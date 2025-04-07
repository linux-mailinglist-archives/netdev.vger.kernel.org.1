Return-Path: <netdev+bounces-179797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C854A7E871
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CCD17A4F6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9605221F25;
	Mon,  7 Apr 2025 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxO6zkky"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD886221D98
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047156; cv=none; b=eOYpmdT8sHv4MOXIIvC31i6LMw6N1YcVMU5v3t9tQUNSkYlllK4PuKHG0G2mMq/SKZlBc7bkd5sdu0m0uB7ULFikos+wNZ1D1zb93FMjV7MhDYBsTA1bI5ffm/XCkpTBxQoWW1hUiREKw8T0wT1Sr9ST4qCzoH2TOzVV4VOLn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047156; c=relaxed/simple;
	bh=xtGqFPAJUFtpvzp2oSfpCANz6sOWKTPyRiY70KmTtNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL4N3RvQErIrdlrl0coE2Ccilqb8BaLN8FRE4z/0jagc8VlDNfn3HQMzsSQ2BCmiAhpe95DipxBVmhTqtcSOPCucBhoinfjO9su8V2wqHveMj0Uis3rLqOojciXtt+xU1fMAE0Bm3mojaC0UPQ3T0lOKEQeP5juzpIzE3fJGyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxO6zkky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3vlDHc0dtAdMNjfgHWKMugj/8OJ7Tnn4x/ZQC99e8I=;
	b=UxO6zkkypSA0ycIdBBsBZ+RgsTroTAVGUfiKwzusYYNxgra1UicV1mM7CfuAFxfWbWzC+a
	w/edeMIMZaQMJKkZ4++q9KqdtE277WJPmghGWTntDif4ylGnAkgIfRth8VPqIW7EeRjRiz
	27IdAMEpoc47ZXBw07ocaieD3wjcZp8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-Aqsky7_nMC-P6VdwL6SPIA-1; Mon,
 07 Apr 2025 13:32:30 -0400
X-MC-Unique: Aqsky7_nMC-P6VdwL6SPIA-1
X-Mimecast-MFC-AGG-ID: Aqsky7_nMC-P6VdwL6SPIA_1744047148
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9366A19560AD;
	Mon,  7 Apr 2025 17:32:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 682AD1956094;
	Mon,  7 Apr 2025 17:32:22 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 15/28] dt-bindings: dpll: Add device tree bindings for DPLL device and pin
Date: Mon,  7 Apr 2025 19:31:45 +0200
Message-ID: <20250407173149.1010216-6-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This adds DT bindings schema for DPLL (device phase-locked loop)
device and associated pin. The schema follows existing DPLL core API
and should be used to expose information that should be provided
by platform firmware.

The schema for DPLL device describe a DPLL chip that can contain
one or more DPLLs (channels) and platform can specify their types.
For now 'pps' and 'eec' types supported and these values are mapped
to DPLL core's enums.

The DPLL device can have optionally 'input-pins' and 'output-pins'
sub-nodes that contain pin sub-nodes.

These pin sub-nodes follows schema for dpll-pin and can contain
information about the particular pin.

The pin contains the following properties:
* reg - pin HW index (physical pin number of given type)
* label - string that is used as board label by DPLL core
* type - string that indicates pin type (mapped to DPLL core pin type)
* esync-control - boolean that indicates whether embeddded sync control
                  is allowed for this pin
* supported-frequencies - list of 64bit values that represents frequencies
                          that are allowed to be configured for the pin

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../devicetree/bindings/dpll/dpll-device.yaml | 84 +++++++++++++++++++
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 43 ++++++++++
 MAINTAINERS                                   |  2 +
 3 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
new file mode 100644
index 0000000000000..e6c309abb857f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/dpll-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Digital Phase-Locked Loop (DPLL) Device
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description: |
+  Digital Phase-Locked Loop (DPLL) device are used for precise clock
+  synchronization in networking and telecom hardware. The device can
+  have one or more channels (DPLLs) and one or more input and output
+  pins. Each DPLL channel can either produce pulse-per-clock signal
+  or drive ethernet equipment clock. The type of each channel is
+  indicated by dpll-types property.
+
+properties:
+  $nodename:
+    pattern: "^dpll(@.*)?$"
+
+  "#address-cells":
+    const: 0
+
+  "#size-cells":
+    const: 0
+
+  num-dplls:
+    description: Number of DPLL channels in this device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  dpll-types:
+    description: List of DPLL types, one per DPLL instance.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    items:
+      enum: [pps, eec]
+
+  input-pins:
+    type: object
+    description: DPLL input pins
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^pin@[0-9]+$":
+        $ref: /schemas/dpll/dpll-pin.yaml
+        unevaluatedProperties: false
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+  output-pins:
+    type: object
+    description: DPLL output pins
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^pin@[0-9]+$":
+        $ref: /schemas/dpll/dpll-pin.yaml
+        unevaluatedProperties: false
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+dependentRequired:
+  dpll-types: [ num-dplls ]
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
new file mode 100644
index 0000000000000..9aea8ceabb5af
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/dpll-pin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DPLL Pin
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description: |
+  Schema for defining input and output pins of a Digital Phase-Locked Loop (DPLL).
+  Each pin can have a set of supported frequencies, label, type and may support
+  embedded sync.
+
+properties:
+  reg:
+    description: Hardware index of the pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  esync-control:
+    description: Indicates whether the pin supports embedded sync functionality.
+    type: boolean
+
+  label:
+    description: String exposed as the pin board label
+    $ref: /schemas/types.yaml#/definitions/string
+
+  supported-frequencies:
+    description: List of supported frequencies for this pin, expressed in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+
+  type:
+    description: Type of the pin
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ext, gnss, int, mux, synce]
+
+
+required:
+  - reg
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d542440d0b2b..eaf2576a9b746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7194,6 +7194,8 @@ M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
+F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
 F:	drivers/dpll/*
 F:	include/linux/dpll.h
-- 
2.48.1


