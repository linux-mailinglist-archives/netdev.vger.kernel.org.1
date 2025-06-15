Return-Path: <netdev+bounces-197896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F51ADA34E
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B205C7A2600
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D2280014;
	Sun, 15 Jun 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W46tjFXU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5D27FD4B
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750018375; cv=none; b=Nhjx3Xs6wgX/vPofKUQ2rITBlz3l4pSaegcfpqdfdDEAhcGPP7KYBe5NqwcZ9OauzBXFKihy0y5OfeYO1jSfzkU2nDcdiqbIZj7bqpPh1pxquCoeE3j9a7744RK1fTkZmXAQDiMTOrWde3MeR6NqoQF5ycNcBiHUZu6L5UI8gjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750018375; c=relaxed/simple;
	bh=lURu+n3h2pYvpFjdMDI1YpZxq6fZG8n3PMjkDW9xgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVQvCgruwamJzzaAAbUGA/Nbl8Ogvvk+s0ceAxbonN5eJH0tR+3PfCBcobPFRv4yOAPQ9nGrQdo6Lm0WxHrNz1WeRbeJ665dPI5a5lWYv3T+I5dBu7O5Xuid9tcOJzs7k4oXK++RLvSlvvVYxF83coR062s1Mj5fuNflz3mVjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W46tjFXU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750018373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMzvfq27DYyR6il3XAVtdyPAzlfwmcDV4p4sg1R5VKY=;
	b=W46tjFXUh5vxqt9I8OuDcwARki0ngFtfxSmRbIH8xAoBRg131xbWYdVjGHN5pFYZYeqmzZ
	pVp/7QSm+miwt57/UD7JO2hRVHSHYcIIDoDwo8a9y0upa5lRTn90P9tkmjBI724qYWMNlG
	Zqf60kdQfhnV0mjeDyjk2xItPLdqMZU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-eGKMqQ8wMzGFrkMyPC_FJw-1; Sun,
 15 Jun 2025 16:12:47 -0400
X-MC-Unique: eGKMqQ8wMzGFrkMyPC_FJw-1
X-Mimecast-MFC-AGG-ID: eGKMqQ8wMzGFrkMyPC_FJw_1750018365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78EE719560AD;
	Sun, 15 Jun 2025 20:12:44 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7081180035E;
	Sun, 15 Jun 2025 20:12:34 +0000 (UTC)
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
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v10 01/14] dt-bindings: dpll: Add DPLL device and pin
Date: Sun, 15 Jun 2025 22:12:10 +0200
Message-ID: <20250615201223.1209235-2-ivecera@redhat.com>
In-Reply-To: <20250615201223.1209235-1-ivecera@redhat.com>
References: <20250615201223.1209235-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
v8:
* no change
---
 .../devicetree/bindings/dpll/dpll-device.yaml | 76 +++++++++++++++++++
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 45 +++++++++++
 MAINTAINERS                                   |  2 +
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
new file mode 100644
index 0000000000000..fb8d7a9a3693f
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
index 0000000000000..51db93b77306f
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
index 507c5ff6f620a..e5b90ac03f39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7324,6 +7324,8 @@ M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
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


