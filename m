Return-Path: <netdev+bounces-183382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DF3A908A4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47580189FB3B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A18209F53;
	Wed, 16 Apr 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEqaRyk9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9B1A23BE
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820526; cv=none; b=r10DQrKbHKkQS6NYPQ6CYra5jwoJj6P4+Mpnbu1ThYlCwCwfKTSZ2/uln/nqRrtlPoDb7YUHtd01RRdG+pZ7OG6kyHMrLlIVCAWJeINDyonmfXbZjLSOcMTXD7YT2E0H5yHu2ExHBavZDW5FC/ypf5Nsv5kjCq0OykBYXFKAVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820526; c=relaxed/simple;
	bh=pvztLf2+f/TeR7vcXBvLoFOJlmGc+oGeCk8DZGt4HUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENURo6Gj/PmD88tEpi0ngjLKpXpQFD80znn1y9CXvuQXdvXzR6bVKrgQuynJYePNsRv5bh7SmtRQDlWLMJ4G5QSqtjHYs9JTk6YI4RxQ0ovYryUdDrARpWfTvaszBBvOJmLufK0G6Xh2zEhspaLNDM0W/tMf4yqbzq6bmt8TBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEqaRyk9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VODoBL80CQHBrJrr7R/ZL/MS/tpTwQM1Yp3DwpdKziM=;
	b=EEqaRyk9YSGVZX7Kv1rnd8yk92TicNo2sJrtiMjalQhd6lrQyXSRM7R0U9UPhCzBlUj4NH
	rAZD1uJY5b0YjatH0fB9WU4lVTS/XtSEmo5TkqNeEq/id5DfzJ9E7UV2hstcN9Tf2u8Alf
	ZafEbk6jHCUcxBFgbLLjbRCnLMY9UL0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-anChNQjwMRS_B3QDKNEIeg-1; Wed,
 16 Apr 2025 12:22:01 -0400
X-MC-Unique: anChNQjwMRS_B3QDKNEIeg-1
X-Mimecast-MFC-AGG-ID: anChNQjwMRS_B3QDKNEIeg_1744820516
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BC951800878;
	Wed, 16 Apr 2025 16:21:56 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F103180045B;
	Wed, 16 Apr 2025 16:21:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 net-next 1/8] dt-bindings: dpll: Add device tree bindings for DPLL device and pin
Date: Wed, 16 Apr 2025 18:21:37 +0200
Message-ID: <20250416162144.670760-2-ivecera@redhat.com>
In-Reply-To: <20250416162144.670760-1-ivecera@redhat.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a common DT schema for DPLL device and associated pin.
The DPLL (device phase-locked loop) is a device used for precise clock
synchronization in networking and telecom hardware.

The device itself is equipped with one or more DPLLs (channels) and
one or more physical input and output pins.

Each DPLL channel is used either to provide pulse-per-clock signal or
to drive ethernet equipment clock.

The input and output pins have a label (specifies board label),
type (specifies its usage depending on wiring), list of supported
or allowed frequencies (depending on how the pin is connected and
where) and can support embedded sync capability.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v3:
* rewritten description for both device and pin
* dropped num-dplls property
* supported-frequencies property renamed to supported-frequencies-hz
---
 .../devicetree/bindings/dpll/dpll-device.yaml | 76 +++++++++++++++++++
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 44 +++++++++++
 MAINTAINERS                                   |  2 +
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
new file mode 100644
index 0000000000000..11a02b74e28b7
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
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
new file mode 100644
index 0000000000000..44af3a4398a5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -0,0 +1,44 @@
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
+  Note that the pin in this context has nothing to do with pinctrl.
+
+properties:
+  reg:
+    description: Hardware index of the DPLL pin.
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
+  supported-frequencies-hz:
+    description: List of supported frequencies for this pin, expressed in Hz.
+
+  type:
+    description: Type of the pin
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ext, gnss, int, mux, synce]
+
+required:
+  - reg
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 1248443035f43..f645ef38d2224 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7187,6 +7187,8 @@ M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
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


