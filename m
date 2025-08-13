Return-Path: <netdev+bounces-213217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A83B24235
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B91E1AA8722
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588C2D640E;
	Wed, 13 Aug 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ksRGKxV4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a8zIdsmk"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACB2D47EB;
	Wed, 13 Aug 2025 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068917; cv=none; b=sqdSC/wEA0DvsAapRotFXcSBuefz7a2HHV1n9rIcG+gmGuPOZdipm0rRVr6uyUQsT2AXf4+W0dxoGWctB/O3BjQmtIOzGdTglefCxNgHOEhbNV9dgMjs9+9RciVzhPDrq3fHn8vEnRlfaG6IY7l2t/UgZGNCgb9hzRtJ67C7abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068917; c=relaxed/simple;
	bh=MTsg4gj7tEU3/ZjE1CjAMMa8tT/BbVHx3EW0XZfNlCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQba3v9hV5pCmGmRvg1THwWIEjfHvclCDOfWR7qBty255J7RgIatACs6mEhrbPu/XMXb8Bl2U4Rif1/8w7YKMJG7hr7O2oTr6AOCM55N+4EgCP733gTdGUGcNFa1a8Rdbkqdbnjz3OLc4koEY48Dzcj4J0fSSPNQGD+eYYiwhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ksRGKxV4; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=a8zIdsmk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c1zx76Xzlz9t9l;
	Wed, 13 Aug 2025 09:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwJjGeRDVMBB7l8CoE3oI8yFMY7zoU3Tnurl33iINv4=;
	b=ksRGKxV4KqaXKjWYVdp4jsRMjlzis7wlefL1XlckTHKASbzKL1EPJnwkjbjCApd2r8OER/
	a+8RiBT+IOGH5fvnx/uHFAFWSduGDYYTNXPEhXClAwX0WJjbzdnhOvs4hHuEqAvSBg8jxi
	wjqH1MLMwNb4FiCv04o4X9uGQBlrTsRO67IBFu+PfpwcIjAQDHvaMG41fIvgCGiy2ScapF
	wFKZWH19kUTer8okhtQcYVZjZhlOxw4fl+RmViAcU/10W5Q+OFa/L4nFrxBIv8hMgGJXak
	mcYbSi5c5t/4MsHprZyfOP470ovNjfvuTSSgZNxNhVQpIUbaFudlKCA/mgCA2Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=a8zIdsmk;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwJjGeRDVMBB7l8CoE3oI8yFMY7zoU3Tnurl33iINv4=;
	b=a8zIdsmkB5BsXVHb40TZiVHlgoWsDUtaw55vHcmhGKNJhLCz9j29CPwNeOZmnhkot1ZZ+V
	toLOSvX56TtZ9s2IELhrLoXJTR/wgrRrlfU160boyf3GskVPFj1gD79WHc3B5T49HGILZJ
	NvptUKFG6s7JZqXQTnX+MksUbOg+EY12rVqS9rjX0Gb7gv1W22uwMJxr5tbQzgh9iISHKt
	kcHSWV8Hs6yivt8M6JZGf5mzC2q8Es67zAyOvD1b02GETNt/6y49BuouT6a840GJRD4hn9
	jyvbzhAiTae0EByOhTTQy54MsWCAJF98/bfRj2NC8OzbmOi6zcUYH6LmneV19g==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v18 1/7] dt-bindings: net: Add MTIP L2 switch description
Date: Wed, 13 Aug 2025 09:07:49 +0200
Message-Id: <20250813070755.1523898-2-lukasz.majewski@mailbox.org>
In-Reply-To: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4e3a331e784bc8cb493
X-MBO-RS-META: dwx8bruxypjtdmbbg9e4biobfhruwf31
X-Rspamd-Queue-Id: 4c1zx76Xzlz9t9l

This patch provides description of the MTIP L2 switch available in some
NXP's SOCs - e.g. imx287.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
Changes for v2:
- Rename the file to match exactly the compatible
  (nxp,imx287-mtip-switch)

Changes for v3:
- Remove '-' from const:'nxp,imx287-mtip-switch'
- Use '^port@[12]+$' for port patternProperties
- Drop status = "okay";
- Provide proper indentation for 'example' binding (replace 8
  spaces with 4 spaces)
- Remove smsc,disable-energy-detect; property
- Remove interrupt-parent and interrupts properties as not required
- Remove #address-cells and #size-cells from required properties check
- remove description from reg:
- Add $ref: ethernet-switch.yaml#

Changes for v4:
- Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove already
  referenced properties
- Rename file to nxp,imx28-mtip-switch.yaml

Changes for v5:
- Provide proper description for 'ethernet-port' node

Changes for v6:
- Proper usage of
  $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
  when specifying the 'ethernet-ports' property
- Add description and check for interrupt-names property

Changes for v7:
- Change switch interrupt name from 'mtipl2sw' to 'enet_switch'

Changes for v8:
- None

Changes for v9:
- Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- Remove 'label' from required properties
- Move the reference to $ref: ethernet-switch.yaml#/$defs/ethernet-ports
  the proper place (under 'allOf:')

Changes for v13 - v18:
- None
---
 .../bindings/net/nxp,imx28-mtip-switch.yaml   | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
new file mode 100644
index 000000000000..6a07dcd119ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+description:
+  The 2-port switch ethernet subsystem provides ethernet packet (L2)
+  communication and can be configured as an ethernet switch. It provides the
+  reduced media independent interface (RMII), the management data input
+  output (MDIO) for physical layer device (PHY) management.
+
+allOf:
+  - $ref: ethernet-switch.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: nxp,imx28-mtip-switch
+
+  reg:
+    maxItems: 1
+
+  phy-supply:
+    description:
+      Regulator that powers Ethernet PHYs.
+
+  clocks:
+    items:
+      - description: Register accessing clock
+      - description: Bus access clock
+      - description: Output clock for external device - e.g. PHY source clock
+      - description: IEEE1588 timer clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+      - const: enet_out
+      - const: ptp
+
+  interrupts:
+    items:
+      - description: Switch interrupt
+      - description: ENET0 interrupt
+      - description: ENET1 interrupt
+
+  interrupt-names:
+    items:
+      - const: enet_switch
+      - const: enet0
+      - const: enet1
+
+  pinctrl-names: true
+
+  ethernet-ports:
+    type: object
+    additionalProperties: true
+
+    patternProperties:
+      '^ethernet-port@[12]$':
+        type: object
+        additionalProperties: true
+        properties:
+          reg:
+            items:
+              - enum: [1, 2]
+            description: MTIP L2 switch port number
+
+        required:
+          - reg
+          - phy-mode
+          - phy-handle
+
+  mdio:
+    type: object
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Specifies the mdio bus in the switch, used as a container for phy nodes.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - mdio
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include<dt-bindings/interrupt-controller/irq.h>
+    #include<dt-bindings/gpio/gpio.h>
+    switch@800f0000 {
+        compatible = "nxp,imx28-mtip-switch";
+        reg = <0x800f0000 0x20000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+        phy-supply = <&reg_fec_3v3>;
+        interrupts = <100>, <101>, <102>;
+        interrupt-names = "enet_switch", "enet0", "enet1";
+        clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+        clock-names = "ipg", "ahb", "enet_out", "ptp";
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mtip_port1: ethernet-port@1 {
+                reg = <1>;
+                label = "lan0";
+                local-mac-address = [ 00 00 00 00 00 00 ];
+                phy-mode = "rmii";
+                phy-handle = <&ethphy0>;
+            };
+
+            mtip_port2: ethernet-port@2 {
+                reg = <2>;
+                label = "lan1";
+                local-mac-address = [ 00 00 00 00 00 00 ];
+                phy-mode = "rmii";
+                phy-handle = <&ethphy1>;
+            };
+        };
+
+        mdio_sw: mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
+            reset-delay-us = <25000>;
+            reset-post-delay-us = <10000>;
+
+            ethphy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+
+            ethphy1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
-- 
2.39.5


