Return-Path: <netdev+bounces-46939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE707E73F9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 22:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99461C20A0E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7338F86;
	Thu,  9 Nov 2023 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7A38DF9;
	Thu,  9 Nov 2023 21:52:02 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B46C1FDF;
	Thu,  9 Nov 2023 13:52:02 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1r1CwI-0003Y5-34;
	Thu, 09 Nov 2023 21:51:51 +0000
Date: Thu, 9 Nov 2023 21:51:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 5/8] dt-bindings: net: pcs: add bindings for MediaTek
 USXGMII PCS
Message-ID: <2dff6aff7006573d3232ec2ddd93c1792740d4d3.1699565880.git.daniel@makrotopia.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699565880.git.daniel@makrotopia.org>

MediaTek's USXGMII can be found in the MT7988 SoC. We need to access
it in order to configure and monitor the Ethernet SerDes link in
USXGMII, 10GBase-R and 5GBase-R mode. By including a wrapped
legacy 1000Base-X/2500Base-X/Cisco SGMII LynxI PCS as well, those
interface modes are also available.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/net/pcs/mediatek,usxgmii.yaml    | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
new file mode 100644
index 0000000000000..199cf47859e31
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/mediatek,usxgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek USXGMII PCS
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MediaTek USXGMII PCS provides physical link control and status
+  for USXGMII, 10GBase-R and 5GBase-R links on the SerDes interfaces
+  provided by the PEXTP PHY.
+  In order to also support legacy 2500Base-X, 1000Base-X and Cisco
+  SGMII an existing mediatek,*-sgmiisys LynxI PCS is wrapped to
+  provide those interfaces modes on the same SerDes interfaces shared
+  with the USXGMII PCS.
+
+properties:
+  $nodename:
+    pattern: "^pcs@[0-9a-f]+$"
+
+  compatible:
+    const: mediatek,mt7988-usxgmiisys
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: USXGMII top-level clock
+      - description: SGMII top-level clock
+      - description: SGMII subsystem TX clock
+      - description: SGMII subsystem RX clock
+      - description: XFI PLL clock
+
+  clock-names:
+    items:
+      - const: usxgmii
+      - const: sgmii_sel
+      - const: sgmii_tx
+      - const: sgmii_rx
+      - const: xfi_pll
+
+  phys:
+    items:
+      - description: PEXTP SerDes PHY
+
+  mediatek,sgmiisys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node of the corresponding SGMII LynxI PCS.
+
+  resets:
+    items:
+      - description: XFI reset
+      - description: SGMII reset
+
+  reset-names:
+    items:
+      - const: xfi
+      - const: sgmii
+
+  "#pcs-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - phys
+  - mediatek,sgmiisys
+  - resets
+  - reset-names
+  - "#pcs-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt7988-clk.h>
+    #include <dt-bindings/reset/mediatek,mt7988-resets.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+        usxgmiisys0: pcs@10080000 {
+          compatible = "mediatek,mt7988-usxgmiisys";
+          reg = <0 0x10080000 0 0x1000>;
+          clocks = <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
+                   <&topckgen CLK_TOP_SGM_0_SEL>,
+                   <&sgmiisys0 CLK_SGM0_TX_EN>,
+                   <&sgmiisys0 CLK_SGM0_RX_EN>,
+                   <&xfi_pll CLK_XFIPLL_PLL_EN>;
+          clock-names = "usxgmii", "sgmii_sel", "sgmii_tx", "sgmii_rx", "xfi_pll";
+          resets = <&watchdog MT7988_TOPRGU_XFI0_GRST>,
+                   <&watchdog MT7988_TOPRGU_SGMII0_GRST>;
+          reset-names = "xfi", "sgmii";
+          phys = <&xfi_pextp0>;
+          mediatek,sgmiisys = <&sgmiisys0>;
+          #pcs-cells = <0>;
+        };
+    };
-- 
2.42.1

