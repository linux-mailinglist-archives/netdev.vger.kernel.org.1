Return-Path: <netdev+bounces-172023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95322A4FF30
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D941682FC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EBF24A04C;
	Wed,  5 Mar 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W6kBUqmd"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676E24886E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179455; cv=none; b=WMVp6gppsUF/vK2yP88TJ5hk8InaUoh9qyCyfdQ9RcgsaysnKR+nSXjEyt4+rB8M2k3NdTtJCmPCL99cgATYy5QGFNRVnPPcbHVhwb/GDi+wXDbjRvzkVFzmbL3oyWjgq5oelQi61ULa41q4etHwq3PXdGXaaWWF/6wkrizatQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179455; c=relaxed/simple;
	bh=5M8+uJC2uyidtPtLyF1PLSFVCUkPNquGCVQ5R3aVAyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=eXx86jL19t3lj3XbF//D2hjhVwSdZEgGNafuJe3FJjrtOqrVkqxnbQu0f28yaPRZdGYKFWZiOII7hVkHa6DnIHF5A6Hmg3Q7nyLGpPKMhuC49JhwgkoP+snpHzPZ9QiNBeaUJ8Kryk8E0ZGoNwWwDhf5O+qBYRZnZJxaspQJ0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W6kBUqmd; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250305125725epoutp04a513c64516d80b72212e6bc96956f9dc~p6XsPMUAk1408214082epoutp04e
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250305125725epoutp04a513c64516d80b72212e6bc96956f9dc~p6XsPMUAk1408214082epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741179445;
	bh=+mlxEJSnBQ5SOauVTxxy7LkVjwsmsbn9vtY2XudMo9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6kBUqmdcKfpLQkBjcg2PWKmsU813FX/N4PcOHVIU7uCZOj9ejo+QWuZ1HsIHiwIu
	 eRfvv6sQ6ptmXaFL3MQuwMMexHYo4hI+hNoabG+oXym8g2HbYBWg2pWFWWTxLoGxh+
	 HcLZBdp9STkMz3/i99o5770iXMK3BQkTMq4r4fZI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250305125725epcas5p2560fadf03bc87cfb32132584d439092d~p6XroZ21m1536915369epcas5p2B;
	Wed,  5 Mar 2025 12:57:25 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z7CJ32yZXz4x9Pp; Wed,  5 Mar
	2025 12:57:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.5F.29212.33A48C76; Wed,  5 Mar 2025 21:57:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6~p3Y3k2qj72626326263epcas5p1O;
	Wed,  5 Mar 2025 09:18:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250305091852epsmtrp2b0ada9270ba94a7b26c74f60cdf53a37~p3Y3bb8A00427204272epsmtrp2L;
	Wed,  5 Mar 2025 09:18:52 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-9e-67c84a331b94
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.09.33707.CF618C76; Wed,  5 Mar 2025 18:18:52 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305091849epsmtip2882efafca16a2c30868fa1a74defb38d~p3Y0omLon1567815678epsmtip25;
	Wed,  5 Mar 2025 09:18:49 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree bindings
Date: Wed,  5 Mar 2025 14:42:45 +0530
Message-Id: <20250305091246.106626-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250305091246.106626-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xbVRzOubftvRC7XHntrBmIt1mUJYV2a/HAgKGiXocxKDFOfNQ7etMi
	0NY+UBkKieAmYVSW4bAhSHSkDMYGHa+Oh7wcC491YzxGJg4HG2PoIKPOgSIWWuZ/3+/7fb/3
	OSTu1y8QkWlaE2fQshm0wJfX3BsWJtl74JJaWvEVhVbmvwXINt3KR2c6LmOo3JnPQ9/3Xeaj
	2xdvEWiyy4GheeuvAnSluZiP7DPjfHTtQrkAFY7P8lHFWh0fXawMQg8HfwfohyYXgX5baidQ
	39BdHI1YSjC03t5KIFfDJBEfyFwbv4ozjacnMea2pYlgHNYpgqm0mxl7zdcC5vypXMbRuowx
	i51jAqa4sQYw3Z0yZtkekvRESnqMhmNVnCGU06bqVGladSydmKx8UamIlMoksij0HB2qZTO5
	WDrhtSTJy2kZ7lnp0Cw2w+ymklijkY6IizHozCYuVKMzmmJpTq/K0Mv14UY202jWqsO1nCla
	JpXuUbiFH6ZrFqeE+rawT1cdgXkgL6QQ+JCQksM12yivEPiSflQ7gFVHh73GAwBnF1rAY6Ot
	3o5vhZy+6sI9DgeADWVLmMdwAViyVE1sqATUs3CiuoXYcARQqwAuHR/cDMEpGwYHp0c3c/lT
	ibDqr1LeBuZRu2BZWSnYwEJqH5xzNgk89Z6CtfVdm3ofKgb+3F242SGkrpNwdbIeeEQJ0Da8
	4G3QH97rbyQ8WASX73d4EylhbfEYz4M1cGq1xMvvh12j5W6edHcXBs9diPDQwbB04Cy2gXFq
	Gzz29yzm4YWwtWILi+Hawrg35Q7YXLXoLcvARyfPCDxrsbinXx8hvgEh1v9LVAJQA0Sc3pip
	5lIVeplEy33y+G6pukw72HzRu5NaQW39WngPwEjQAyCJ0wHChYF+tZ9QxX6WzRl0SoM5gzP2
	AIV7gyW4KDBV5/4SWpNSJo+SyiMjI+VReyNl9Hbhl458tR+lZk1cOsfpOcNWHEb6iPIwgaXo
	SOjKHTU54nwY8szN6WRJThV6RTLcLd6nnI4o6n3ymPTg8xaUfbhBenB+7nOVLujfk2R/9eAe
	3ts54nNf1KUvx7Vo6pqdhyZsN1aWT9zEhD5tKRG5DZK3rN/tz9qVctiyfrcqeCQ1Lzu/Azva
	aRb/SGB/4mND7yVWP/3PjEo4ZKfrjgQFf4ydUBTUx5lzip0Nj1x/RG9PyNJeKnjV7gy4RdiC
	4/vkPZXv+77Tc30m/oUPdrz57k/iNOtLE1O9zXUH+Odz2czkle7X/X0nF+feiJF1Hb9B7FT8
	cuje4LYHsuTEHGW74UpBii3aRXauB4o+ksSdWtp5J+3+QtHAWetqCM0zaljZbtxgZP8Dm/EC
	XloEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSvO4fsRPpBp/uc1r8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFww972C2OnHnBbHGpfyKTxf89O9gtvmy8ye4g6nH52kVm
	jy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYvKTeY+eOz0we7/ddZfPo27KK0ePgPkOPz5vk
	AniiuGxSUnMyy1KL9O0SuDLe3+Ut2K1Z8WunaANjg1wXIyeHhICJxMqLX5i7GLk4hAS2M0os
	XLWfGSIhKfGpeSorhC0ssfLfc3aIok+MEhM/bQFLsAloSFxfsR0sISLQwSSxZ+pJsFHMAhuZ
	JI5d2swOUiUs4C2x9PtUFhCbRUBVYsaMqYwgNq+AtcTz81vZIFbIS6zecABsNaeAjcTRg11A
	9RxA66wlTv5kn8DIt4CRYRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcNxoBe1gXLb+r94h
	RiYOxkOMEhzMSiK8r08dTxfiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQ
	WgSTZeLglGpg6ppSFmCxI18qc0ZU39q7eRXTFiziDLaO2BJZv9LUXCdJSjzPxSzXVzN64+lH
	s9nm7fg+45z0r+WKDD+7dgW2zpdJvvQpeZqw9+Nk+ZuboqqmKz/8cm6D+xEl64S6ZXmt99gm
	//xx4PBe88bv06YET39p3GB+LiWVy+PXp2+NAnO7tuzWsGG+764pOS9lwruzDzWyFv1mZ/CK
	0N4iNJ+bSefbLzNT6enJ2y8+9b3/U+x7y8fOTqYD9yKFDoYceXcvi+HFvPfxDMFrlqwRUnH9
	filDvT02KruqY1JUq/iRM4daijcdP7PDprZuedtOx6uW688mbyo5NXNRmNilJFGeNV48zh2M
	KpNPrrUJa+a0VmIpzkg01GIuKk4EAKcZBXoKAwAA
X-CMS-MailID: 20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6
References: <20250305091246.106626-1-swathi.ks@samsung.com>
	<CGME20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
Ethernet YAML schema to enable the DT validation.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../bindings/net/tesla,fsd-ethqos.yaml        | 118 ++++++++++++++++++
 2 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 91e75eb3f329..c7004eaa8eae 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -102,6 +102,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - tesla,fsd-ethqos
         - thead,th1520-gmac
 
   reg:
@@ -126,7 +127,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     items:
       - description: GMAC main clock
@@ -138,7 +139,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     contains:
       enum:
diff --git a/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
new file mode 100644
index 000000000000..dd7481bb16e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/tesla,fsd-ethqos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FSD Ethernet Quality of Service
+
+maintainers:
+  - Swathi K S <swathi.ks@samsung.com>
+
+description:
+  Tesla ethernet devices based on dwmmac support Gigabit ethernet.
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-ethqos
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
+  clocks:
+    minItems: 5
+    items:
+      - description: PTP clock
+      - description: Master bus clock
+      - description: Slave bus clock
+      - description: MAC TX clock
+      - description: MAC RX clock
+      - description: Master2 bus clock
+      - description: Slave2 bus clock
+      - description: RX MUX clock
+      - description: PHY RX clock
+      - description: PERIC RGMII clock
+
+  clock-names:
+    minItems: 5
+    items:
+      - const: ptp_ref
+      - const: master_bus
+      - const: slave_bus
+      - const: tx
+      - const: rx
+      - const: master2_bus
+      - const: slave2_bus
+      - const: eqos_rxclk_mux
+      - const: eqos_phyrxclk
+      - const: dout_peric_rgmii_clk
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    enum:
+      - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - iommus
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ethernet1: ethernet@14300000 {
+            compatible = "tesla,fsd-ethqos";
+            reg = <0x0 0x14300000 0x0 0x10000>;
+            interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "macirq";
+            clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
+                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
+                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
+                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
+                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
+                     <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
+                     <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
+                     <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+                     <&clock_peric PERIC_EQOS_PHYRXCLK>,
+                     <&clock_peric PERIC_DOUT_RGMII_CLK>;
+            clock-names = "ptp_ref", "master_bus", "slave_bus","tx",
+                          "rx", "master2_bus", "slave2_bus", "eqos_rxclk_mux",
+                          "eqos_phyrxclk","dout_peric_rgmii_clk";
+            assigned-clocks = <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+                              <&clock_peric PERIC_EQOS_PHYRXCLK>;
+            assigned-clock-parents = <&clock_peric PERIC_EQOS_PHYRXCLK>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
+                        <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
+                        <&eth1_rx_ctrl>, <&eth1_mdio>;
+            iommus = <&smmu_peric 0x0 0x1>;
+            phy-mode = "rgmii-id";
+        };
+    };
+
+...
-- 
2.17.1


