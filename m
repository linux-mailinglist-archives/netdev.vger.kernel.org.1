Return-Path: <netdev+bounces-212808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDACB22147
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814345603FD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3A2E6105;
	Tue, 12 Aug 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eMxtXVGg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aOLcchdn"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D82E5B06;
	Tue, 12 Aug 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987420; cv=none; b=FiUm7+JCiTU8RA08sByOnwkGhYfcKhGekvaKFZNhPO9I2JuE8aNxMwJ+BEtjv3uokxF7N+2F7/VV75X1Wd4663qyqm71FofJD8xhVQTwTfSYcwvk6NRKUf/ujmJ8XmC8P3nFz56zVisKwVoCy5+ovdbrV2pGaengNmmsBkEeFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987420; c=relaxed/simple;
	bh=P+J5LkwWxBvtGaRSYm0LJFnPsKOAf0BnUiVWYm8YRTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbekXM44Lm5Z1cL0WLSofHbnmCkDVU2F42SmFrZYw61cQl11vLj78ZKgxx7wwncZlsxRne8qbQ2K6hUV1J2Pp0/5NE3hOi3P0uvTcikydW3N2PmcxkJh203e95SFHj01UVfnIRJlKg6xN2J3I+iBDcgAkNupIybvn4dFJp88D+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eMxtXVGg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aOLcchdn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1Pp043Yfz9tyS;
	Tue, 12 Aug 2025 10:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN/0yxQN/1iqkhAXLnIQOB+RSTw+5oQHa4pjTfvku1E=;
	b=eMxtXVGgIDdUWP9nda/TSrdGaYSus1dHGTiMnVQIjy0+MKMlbyoVNTyeQMfprtxSS4JkC1
	wCObD7D6MtaOdD/TCxIEaTpW1roBBdt4X9ir52IOq5fjvXCNcz4qmegfJieAdmpkrA7jWI
	MaxUqduLZ7bL9HTavXbIRgAWL0JotRCM8bERrXpykrr4GJbMyLzXspObE+9b5Ki+SgGQtr
	gNPG5hdKWfw7mQv5zQbSSNvqxd0/VWceEOz1yg2gvPepzT0xhVDwjnpcAZE3QWMeJypJAP
	/cQLR18YB171xpaiF/EW9W24VwsCpmVNwVr3SNOQRYoQLBAiT6UaOgCzBNGB9g==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=aOLcchdn;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QN/0yxQN/1iqkhAXLnIQOB+RSTw+5oQHa4pjTfvku1E=;
	b=aOLcchdnj9nEFDzww2jLZiTK9SPefeMdwVB0xww0+DPDU4QJ23c6+Bh8WIh3ons2Dficgn
	zbPzOesQZDyYzpQzFXYuqoT053u3wceAKTIn9Jbd5gGnlKi54vfH3fYPCVrBSgkiqwLPNW
	iQ/CnS7SKyC+y4U+XPV92ivVhsTB3N51lgdBizKS+vHYhz5uBXpd5XAb6+x4cg3NUSMNsI
	9RCjZEf2seWzOk3MFjJxGSSYb+/TGXWVZWVUk//bui2IabDuoFLh2DQWUgRcw1/vjYfdy8
	eRmrwJ8gq7QBARLLW9GFsdBEeBBcLVxzBrE/aPJFieJ5tnjW2ubA0L7cEWrevA==
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
Subject: [net-next RESEND v17 01/12] dt-bindings: net: Add MTIP L2 switch description
Date: Tue, 12 Aug 2025 10:29:28 +0200
Message-Id: <20250812082939.541733-2-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ru1xtk7owy4rbexgwo1t411xuqkn1mhu
X-MBO-RS-ID: 60a95b0c54416c723c3
X-Rspamd-Queue-Id: 4c1Pp043Yfz9tyS

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

Changes for v13 - v17:
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


