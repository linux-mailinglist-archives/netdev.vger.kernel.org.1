Return-Path: <netdev+bounces-168006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30EBA3D21B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95A4177537
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCDF1E7C3F;
	Thu, 20 Feb 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BFVUQKSI"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A41E5B8A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036139; cv=none; b=AU8hiehDOGhdgO0jhQDkxPTqFGkaeH4+8ajIg/PXQIlaBNoSu1tSjhl3PzYkIrEYGqP3RhE8ysHsfpgofdu27H4nwEHXUwYP/UkG/Inxm2SjP7J+gzRwCX5GQZbYDDXyWSfcpyy2RdKeh7+OivJ9NOSFE8AIfPHiZYhoZk1yn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036139; c=relaxed/simple;
	bh=ch6rHFHfkRTpzSc/lOFuRlra4+BwhQFrBZ30QsKoCzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=XU1Ei1Tin4v6nLC2glR/ycjGAuRAz31MU0bfCNR+hGU0ISTkYXKFkOAUsKJeov5WxBOCgcgQcZxCmSJJvdV97FaxraqxXjuyVKsptS0wM1Gbx4flIcCWoASD4bSGBiO1YxSCbh8U7Prgc80tERa8tdGxOOfPidONTvJWRG1AzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BFVUQKSI; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250220072214epoutp037fac26e707e4f0bc344be73e9956b297~l2aUeG2w_0461504615epoutp03K
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250220072214epoutp037fac26e707e4f0bc344be73e9956b297~l2aUeG2w_0461504615epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740036134;
	bh=NDxLuYmF05FU++0vIbq2D7wtQMSdUARZhuxQGdAg9/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFVUQKSI7NLZ2Z7q96w+7Iso+dSwGiafImXsx920x7MAqdI0WfiR8v5Kf6HWBOIkO
	 YUaYYzm9eCGKK0n8tKAvAAD4Cq/KkqKZKpYwlyv1MRbrkUpg+w+E6NxC4AAm6Z8yNr
	 PX5wT8T8riL24vyGzhEsa3UnUd6G2WfkCIvZIEoM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250220072213epcas5p1801c65533e8237f61dc5f1a4e0198f2e~l2aTfg9hb0253802538epcas5p1w;
	Thu, 20 Feb 2025 07:22:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yz4TH22b9z4x9QR; Thu, 20 Feb
	2025 07:22:11 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.F5.19933.328D6B76; Thu, 20 Feb 2025 16:22:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220044128epcas5p1484d81bea4377bef4cbe7bc7b9f03713~l0N81UUBl0786707867epcas5p1_;
	Thu, 20 Feb 2025 04:41:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220044128epsmtrp11da3333b89498b036f6f2d110188918a~l0N8zZ5Y_1731817318epsmtrp1C;
	Thu, 20 Feb 2025 04:41:28 +0000 (GMT)
X-AuditID: b6c32a4a-4525924000004ddd-c7-67b6d82383ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.ED.18949.772B6B76; Thu, 20 Feb 2025 13:41:27 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250220044125epsmtip1949c161445c32f32479d66b515f674be~l0N6BapKq1690116901epsmtip1E;
	Thu, 20 Feb 2025 04:41:24 +0000 (GMT)
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
Subject: [PATCH v7 1/2] dt-bindings: net: Add FSD EQoS device tree bindings
Date: Thu, 20 Feb 2025 10:07:11 +0530
Message-Id: <20250220043712.31966-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220043712.31966-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+5te1u0yx0qHokoXjK0bpQWgR0cTI2G3ShjJBKzObNa4aZg
	S9v0wdCxwBxx0CiPCW6wgmTRgTBe5VVewniNDYZzQAcKDmaJw5GA0uFkdK6lZfvv8z3n+/t9
	c37nHC7u2cfx5iYqdYxGKVVQHA9WU49gT4DfeJNM1FmzAT2buwpQ2bSZjb7pGMaQ8XYGC13r
	HWaj2f7fCDTR1YKhuaL7HPRTUzYbmR5Y2Gik1chBBouVjUrsVWzUX+qFlgfnAfqq0UagmcV2
	AvUO/Y6jn3PyMPS83UwgW90EcXALPWK5g9MNNycwejankaBbiqYIutSkp00VWRy6/noa3WJe
	wuiFW2McOruhAtDf3hLTS6YdMRtPysMTGGk8o/FllHGq+ESlLII6dlxyWBISKhIHiMPQa5Sv
	UprERFBHomICIhMVjrNSvslShd6xFCPVaqnAN8I1Kr2O8U1QaXURFKOOV6iD1UKtNEmrV8qE
	Ska3XywSBYU4jKflCeUP7YTaujvl+s0CTjqY324APC4kg2F6nZFtAB5cT7INwMnOIcwlngB4
	Y6qO4xLLAD4csrHXSyxP6gnXRgeAl+ueu0tsADbaxwini0Pugb+UN6+5NpMrAC5+Nog7BU6W
	YXBwetQhuNxN5DFoyTztRBb5MszvkziRT+6Hd3JecoXthJW1XbiTeeTrsLx9BTi7QHKcCx89
	vQ9cpiNwfsCOuXgTfPRdA+FibziXc9HNEliZPcZycQKcWsnjuPgA7Bo1spy5OCmANa2BrmUf
	WPBD9VpLnHwRXv7b6m7Ph+aSdfaD9j8s7pbbYNONBXcUDXs+XnIPKBvAqgsNeC7YUfR/RCkA
	FWAbo9YmyRhtiDpIyXzw363FqZJMYO097z1qBjPTi8JugHFBN4BcnNrMv5jWIPPkx0vPnWc0
	KolGr2C03SDEMb483HtLnMrxIZQ6iTg4TBQcGhoaHLYvVExt5X/SkiHzJGVSHSNnGDWjWa/D
	uDzvdKxtV7HQM/oF8dkf8389tfNM1rJxZChXzJZsGOy5svD9dOHd3Fp7722QUZBiEZQ+eGa1
	ZYpGmSzfir6ujTwDdunoAPP4074DGbze99svn8tjG0uKsyp5b04m3yvMEhhTU036KKFX/3jg
	P2KDqiP+4IW7i29ttUV3xvpMCw6rFoc/ugr6Ti0nt8ZGxX0pX/2rsOreSZ0ANRdQSzVf57/7
	ns1LMf6nfNX/DJirrjKUz8a94r9cu92n3v98UXVkat1AiOzQrmiz3BrVdqmW7//5Y6z4nREg
	Ov70LOos25f3YXZGUPghXYq1IvLEF6+e6BZOXhPMEG/HeqXlK3azrvhlrjLNHhRLmyAV78U1
	Wum/vuuuilgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSnG75pm3pBk9PW1r8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFww972C2OnHnBbHGpfyKTxf89O9gtvmy8ye4g6nH52kVm
	jy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYvKTeY+eOz0we7/ddZfPo27KK0ePgPkOPz5vk
	AniiuGxSUnMyy1KL9O0SuDJWPP/LXvBEvWLJyqlsDYxvZLoYOTkkBEwkrn3azA5iCwnsZpRo
	vegJEZeU+NQ8lRXCFpZY+e85UA0XUM0nRokTZx6BJdgENCSur9gOlhAR6GCS2DP1JDOIwyyw
	kUni2CWQsRwcwgLeEtc6EkBMFgFViSlH40FMXgEriYv9ghDz5SVWbzjADGJzClhLrNjzixGk
	RAioZHaD6wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjR0trB+OeVR/0
	DjEycTAeYpTgYFYS4W2r35IuxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTU
	gtQimCwTB6dUA5P60pXFn+tSV/fOO9izUYXzvm/+HqOG70m8U1xnRvSJXn8//VH1g9tf6o7O
	ioqZnyh/b+509hPRa8ub3m49Weey7vAqgdq9YXo5np82LhLXz3YXaS7oqLugG6G8Li7S6pVa
	3KzelJ8N3H/ezCtlSK9nkS+/tL14/+anUZeMZQvCu/w7pj9e68H+7spk/tBpQh1ThReWf/qh
	xX/wL2PzevOKOfPr5GWsOt8lOysdESljiLHbtVnpoIzhxetJp++Xqvg7ujzOPpCrnfv/uXNi
	jpDYo4cJe9JbFzZY7cm4a56/UsPY0aI0+v6BQzq73peH8F7nEm96yDj9XMo0noMbmM/Wc/y+
	ulOQRfWiEee5vUosxRmJhlrMRcWJAEarWWAMAwAA
X-CMS-MailID: 20250220044128epcas5p1484d81bea4377bef4cbe7bc7b9f03713
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220044128epcas5p1484d81bea4377bef4cbe7bc7b9f03713
References: <20250220043712.31966-1-swathi.ks@samsung.com>
	<CGME20250220044128epcas5p1484d81bea4377bef4cbe7bc7b9f03713@epcas5p1.samsung.com>
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
 .../bindings/net/tesla,fsd-ethqos.yaml        | 115 ++++++++++++++++++
 2 files changed, 118 insertions(+), 2 deletions(-)
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
index 000000000000..538432158436
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
@@ -0,0 +1,115 @@
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


