Return-Path: <netdev+bounces-188616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF698AADF79
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E279A984525
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F9281370;
	Wed,  7 May 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVKVJ5xC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478C280038
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621866; cv=none; b=D6gYaDIkqKq480Znj/vFab5akIEtMtbcXk11xkvRAM4wnNI0GOguv8IKSEfMp4jVgNa+LnvN/9GMyf9jlPtXFc+77gcq5Wrrm8vwBV5NFhzHbUg1lczrMlB6V5wN72vPXHfDYDhWKvik4ET7e4zMmjuQ2RtfIy/hCMOOVed2Nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621866; c=relaxed/simple;
	bh=es5WtintKzim6+TJ9y2jeS+EHUpABz8zi35WxuN50N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNXnmdn2R80bmSpYnWCqYDYq5QTH5RBcS1qdVtW8OdDIXacsmoufHRihGBWBbhuM0V67VicCAHmca1s8ODdSnoSUKDV+hNgRU5qTmt3FppC3jsh3qQ9qrUtvMwHkZ2b20w/df8UPGxeg/q5m/1nBVFvvw+IwEu1VvWoVn1cOHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVKVJ5xC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746621863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JM6eS1aq9/ITzi+UPUfeAHGUGQf2zr8846YAw9k0J2A=;
	b=fVKVJ5xCOUPx6Y1jyr0O4NOEefslt0cPC9aG2d94qS3eLwGxqBRrf1xuRKyG2a3l6dXFwA
	A4UU1zo+iSMRSrlc9QcIGtQHr+zJsa15CDEnQCdToX//XzX5qwsau9a2hI3AoZCgalCbu8
	YZfd0P3vKdKXLSIHzAnXYOZc7gvzkS0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-RJE2i5krM2iXsu84feKl1A-1; Wed,
 07 May 2025 08:44:20 -0400
X-MC-Unique: RJE2i5krM2iXsu84feKl1A-1
X-Mimecast-MFC-AGG-ID: RJE2i5krM2iXsu84feKl1A_1746621858
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017FC1800570;
	Wed,  7 May 2025 12:44:18 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E01319560AD;
	Wed,  7 May 2025 12:44:11 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v7 1/8] dt-bindings: dpll: Add DPLL device and pin
Date: Wed,  7 May 2025 14:43:51 +0200
Message-ID: <20250507124358.48776-2-ivecera@redhat.com>
In-Reply-To: <20250507124358.48776-1-ivecera@redhat.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a common DT schema for DPLL device and its associated pins.
The DPLL (device phase-locked loop) is a device used for precise clock
synchronization in networking and telecom hardware.

The device includes one or more DPLLs (channels) and one or more
physical input/output pins.

Each DPLL channel is used either to provide a pulse-per-clock signal or
to drive an Ethernet equipment clock.

The input and output pins have the following properties:
* label: specifies board label
* connection type: specifies its usage depending on wiring
* list of supported or allowed frequencies: depending on how the pin
  is connected and where)
* embedded sync capability: indicates whether the pin supports this

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v5->v6:
* no change
v4->v5:
* removed compilation output from the description
v3->v4:
* dropped $Ref from dpll-pin reg property
* added maxItems to dpll-pin reg property
* fixed paragraph in dpll-pin desc
* dpll-pin type property renamed to connection-type
v1->v3:
* rewritten description for both device and pin
* dropped num-dplls property
* supported-frequencies property renamed to supported-frequencies-hz
---
 .../devicetree/bindings/dpll/dpll-device.yaml | 76 +++++++++++++++++++
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 45 +++++++++++
 MAINTAINERS                                   |  2 +
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
new file mode 100644
index 000000000000..fb8d7a9a3693
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -0,0 +1,76 @@
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
+description:
+  Digital Phase-Locked Loop (DPLL) device is used for precise clock
+  synchronization in networking and telecom hardware. The device can
+  have one or more channels (DPLLs) and one or more physical input and
+  output pins. Each DPLL channel can either produce pulse-per-clock signal
+  or drive ethernet equipment clock. The type of each channel can be
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
+  dpll-types:
+    description: List of DPLL channel types, one per DPLL instance.
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
+      "^pin@[0-9a-f]+$":
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
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
new file mode 100644
index 000000000000..51db93b77306
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -0,0 +1,45 @@
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
+  The DPLL pin is either a physical input or output pin that is provided
+  by a DPLL( Digital Phase-Locked Loop) device. The pin is identified by
+  its physical order number that is stored in reg property and can have
+  an additional set of properties like supported (allowed) frequencies,
+  label, type and may support embedded sync.
+
+  Note that the pin in this context has nothing to do with pinctrl.
+
+properties:
+  reg:
+    description: Hardware index of the DPLL pin.
+    maxItems: 1
+
+  connection-type:
+    description: Connection type of the pin
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ext, gnss, int, mux, synce]
+
+  esync-control:
+    description: Indicates whether the pin supports embedded sync functionality.
+    type: boolean
+
+  label:
+    description: String exposed as the pin board label
+    $ref: /schemas/types.yaml#/definitions/string
+
+  supported-frequencies-hz:
+    description: List of supported frequencies for this pin, expressed in Hz.
+
+required:
+  - reg
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index a7545b5abef9..1477fbda7378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7195,6 +7195,8 @@ M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
+F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
 F:	drivers/dpll/*
 F:	include/linux/dpll.h
-- 
2.49.0


