Return-Path: <netdev+bounces-219876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B06B43881
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0157E1C81EF0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6E2FB60E;
	Thu,  4 Sep 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="cgnFjqSC"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FC2FB994;
	Thu,  4 Sep 2025 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981105; cv=none; b=dut2WPRZYFfaly1YZlOftteVYfbjLPAIWrmh1upU04lqqTPuEXlqgjkS8jlL0vOVmMgGvW37LHSY6auyxiAyCBczm2WKcAloysMLC54dHzKxMhYxx2x5UFVIF5ystMgHsyNukoFefM+rDHKYDKdjLu7Lvsnq48oX0LxAEm+UGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981105; c=relaxed/simple;
	bh=4FqIKFWXjElqdCi+JWqPb8A2YEsabxbdRB2GRSTlteE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw5fldqmDnwIWn/sc+mmp2ofeMkpAH1O51TrxdyNg+kDTke8Ai4VxwL1YBFTlGIzM8DYxasCAOjH11OVqTYNBVSMWoNDeDZKRAR3tWomWe7HjDCOemnWDUkcnIZyA/3kSt4NWy85gzDugZ5O9lW8xVyASp2t96gkNT8XOA5FZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=cgnFjqSC; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sljHiUjGUPXOmAnRjHsjOGpp/FinyGB7YDTB1iURIU4=; b=cgnFjqSCTeoEEXpKRspd7NQj+w
	BYaGtQbF7piasZl/I9p8xq3blMxx2iiUyagPudUgeLWK56KyJa74+BpTSHtWBNdl9EEHwqUDst5+7
	nDahpwD247lv4NC27NvTW7Sp8onybG2VsggTGodLkxc2ajxfPnTPbHEuRuO+CpEP3MCdCGbcTcOpY
	OI4m9BvtGhcvbqh+jSdjd3E7cT55hG5lMYW6W0xOT4eT5ZHkjO+DdccDi1U3HxHAIn55dJ4J/dJB5
	JaZGWTDlpHJdb6vOArewo7smRqyiRc2Rn6tcfoNSGSka3D6OJek6zt6xdNu9OjfC/JIMiuA5vCDva
	nT04VrKg==;
Received: from [122.175.9.182] (port=31570 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uu72k-0000000CN2u-1bFa;
	Thu, 04 Sep 2025 06:18:14 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	m-malladi@ti.com,
	s.hauer@pengutronix.de,
	afd@ti.com,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	johan@kernel.org,
	alok.a.tiwari@oracle.com,
	m-karicheri2@ti.com,
	s-anna@ti.com,
	glaroque@baylibre.com,
	saikrishnag@marvell.com,
	kory.maincent@bootlin.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	bastien.curutchet@bootlin.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v15 1/5] dt-bindings: net: ti: Adds DUAL-EMAC mode support on PRU-ICSS2 for AM57xx, AM43xx and AM33xx SOCs
Date: Thu,  4 Sep 2025 15:45:38 +0530
Message-ID: <20250904101729.693330-2-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904101729.693330-1-parvathi@couthit.com>
References: <20250904101729.693330-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Documentation update for the newly added "pruss2_eth" device tree
node and its dependencies along with compatibility for PRU-ICSS
Industrial Ethernet Peripheral (IEP), PRU-ICSS Enhanced Capture
(eCAP) peripheral and using YAML binding document for AM57xx SoCs.

Co-developed-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/ti,icss-iep.yaml  |  10 +-
 .../bindings/net/ti,icssm-prueth.yaml         | 233 ++++++++++++++++++
 .../bindings/net/ti,pruss-ecap.yaml           |  32 +++
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |   9 +
 4 files changed, 281 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
index e36e3a622904..ea2659d90a52 100644
--- a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -8,6 +8,8 @@ title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
 
 maintainers:
   - Md Danish Anwar <danishanwar@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
 
 properties:
   compatible:
@@ -17,9 +19,11 @@ properties:
               - ti,am642-icss-iep
               - ti,j721e-icss-iep
           - const: ti,am654-icss-iep
-
-      - const: ti,am654-icss-iep
-
+      - enum:
+          - ti,am654-icss-iep
+          - ti,am5728-icss-iep
+          - ti,am4376-icss-iep
+          - ti,am3356-icss-iep
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
new file mode 100644
index 000000000000..a98ad45ca66f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
@@ -0,0 +1,233 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,icssm-prueth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ICSSM PRUSS Ethernet
+
+maintainers:
+  - Roger Quadros <rogerq@ti.com>
+  - Andrew F. Davis <afd@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
+
+description:
+  Ethernet based on the Programmable Real-Time Unit and Industrial
+  Communication Subsystem.
+
+properties:
+  compatible:
+    enum:
+      - ti,am57-prueth     # for AM57x SoC family
+      - ti,am4376-prueth   # for AM43x SoC family
+      - ti,am3359-prueth   # for AM33x SoC family
+
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to OCMC SRAM node
+
+  ti,mii-rt:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the MII_RT peripheral for ICSS
+
+  ti,iep:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to IEP (Industrial Ethernet Peripheral) for ICSS
+
+  ti,ecap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to Enhanced Capture (eCAP) event for ICSS
+
+  interrupts:
+    items:
+      - description: High priority Rx Interrupt specifier.
+      - description: Low priority Rx Interrupt specifier.
+
+  interrupt-names:
+    items:
+      - const: rx_hp
+      - const: rx_lp
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      ^ethernet-port@[0-1]$:
+        type: object
+        description: ICSSM PRUETH external ports
+        $ref: ethernet-controller.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            items:
+              - enum: [0, 1]
+            description: ICSSM PRUETH port number
+
+          interrupts:
+            maxItems: 3
+
+          interrupt-names:
+            items:
+              - const: rx
+              - const: emac_ptp_tx
+              - const: hsr_ptp_tx
+
+        required:
+          - reg
+
+    anyOf:
+      - required:
+          - ethernet-port@0
+      - required:
+          - ethernet-port@1
+
+required:
+  - compatible
+  - sram
+  - ti,mii-rt
+  - ti,iep
+  - ti,ecap
+  - ethernet-ports
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: /schemas/remoteproc/ti,pru-consumer.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS2 */
+    pruss2_eth: pruss2-eth {
+      compatible = "ti,am57-prueth";
+      ti,prus = <&pru2_0>, <&pru2_1>;
+      sram = <&ocmcram1>;
+      ti,mii-rt = <&pruss2_mii_rt>;
+      ti,iep = <&pruss2_iep>;
+      ti,ecap = <&pruss2_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss2_intc>;
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss2_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss2_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss2_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss2_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx", "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS1 */
+    pruss1_eth: pruss1-eth {
+      compatible = "ti,am4376-prueth";
+      ti,prus = <&pru1_0>, <&pru1_1>;
+      sram = <&ocmcram>;
+      ti,mii-rt = <&pruss1_mii_rt>;
+      ti,iep = <&pruss1_iep>;
+      ti,ecap = <&pruss1_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss1_intc>;
+
+      pinctrl-0 = <&pruss1_eth_default>;
+      pinctrl-names = "default";
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss1_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss1_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss1_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss1_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
+  - |
+    /* Dual-MAC Ethernet application node on PRU-ICSS */
+    pruss_eth: pruss-eth {
+      compatible = "ti,am3359-prueth";
+      ti,prus = <&pru0>, <&pru1>;
+      sram = <&ocmcram>;
+      ti,mii-rt = <&pruss_mii_rt>;
+      ti,iep = <&pruss_iep>;
+      ti,ecap = <&pruss_ecap>;
+      interrupts = <20 2 2>, <21 3 3>;
+      interrupt-names = "rx_hp", "rx_lp";
+      interrupt-parent = <&pruss_intc>;
+
+      pinctrl-0 = <&pruss_eth_default>;
+      pinctrl-names = "default";
+
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pruss_emac0: ethernet-port@0 {
+          reg = <0>;
+          phy-handle = <&pruss_eth0_phy>;
+          phy-mode = "mii";
+          interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+
+        pruss_emac1: ethernet-port@1 {
+          reg = <1>;
+          phy-handle = <&pruss_eth1_phy>;
+          phy-mode = "mii";
+          interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+          interrupt-names = "rx", "emac_ptp_tx",
+                                          "hsr_ptp_tx";
+          /* Filled in by bootloader */
+          local-mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
new file mode 100644
index 000000000000..42f217099b2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,pruss-ecap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PRU-ICSS Enhanced Capture (eCAP) event module
+
+maintainers:
+  - Murali Karicheri <m-karicheri2@ti.com>
+  - Parvathi Pudi <parvathi@couthit.com>
+  - Basharath Hussain Khaja <basharath@couthit.com>
+
+properties:
+  compatible:
+    const: ti,pruss-ecap
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pruss2_ecap: ecap@30000 {
+        compatible = "ti,pruss-ecap";
+        reg = <0x30000 0x60>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 927b3200e29e..b5336bcbfb01 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -251,6 +251,15 @@ patternProperties:
 
     type: object
 
+  ecap@[a-f0-9]+$:
+    description:
+      PRU-ICSS has a Enhanced Capture (eCAP) event module which can generate
+      and capture periodic timer based events which will be used for features
+      like RX Pacing to rise interrupt when the timer event has occurred.
+      Each PRU-ICSS instance has one eCAP module irrespective of SOCs.
+    $ref: /schemas/net/ti,pruss-ecap.yaml#
+    type: object
+
   mii-rt@[a-f0-9]+$:
     description: |
       Real-Time Ethernet to support multiple industrial communication protocols.
-- 
2.43.0


