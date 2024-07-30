Return-Path: <netdev+bounces-114067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA115940DB9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27ABB2740E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D119DF54;
	Tue, 30 Jul 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="orQ7+MQW"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A219D896
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331749; cv=none; b=ay2nS95nZ0UVZrjKm6w2KzKXzfAwMiGYu7O0vz733Qn4lJZCirKO5+FVZo7CIa2/GT62+eCf5a5GAhdlziVxHcaoQxrW8hRflTudf9r+QEBCiRgA3lbPJX6OwXw9I3Yap7krOkbd8/zfl7rnig4/vaWVuh5V/7m9pSpCZZiQ/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331749; c=relaxed/simple;
	bh=iSPJO2ZSJMAqU3yk86fZYJjlI4gEd4wPw4+t5Kg0fbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=mmiE/Ry6W5TB6LjnpvFrfMvP5ILw+FXyPHPotNUz5j59fFJ2DTeWigwHEW6J5gz2HCWpPVk+qVCUVK1wUWodzLoqIfhsCCOO/1PVgBROZCOvZG1S4E6myx1W3InVNWWGBUfdhk2PVW1hugMKmLwPlW2pF9xzSY+GMOm21mhWtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=orQ7+MQW; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240730092904epoutp04cf9818286bed012596ac4091e6958e03~m85ix0pQ01016410164epoutp04B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240730092904epoutp04cf9818286bed012596ac4091e6958e03~m85ix0pQ01016410164epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722331744;
	bh=DRxvsa7nrynwDm71AFc9UprL3LlcSNBmbFvZdgcxW0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orQ7+MQWRy1x+7fM5UJ2Di2w6XLXtYWlYgdZyCiqqJ3jOujmUX3bfp4Z8hiGQSl3z
	 +oR1Hn3iJ/gXcGMrRYjS/dvykzuEtRHWpwjrSqVNFaKSbXK9FYxBk0kNUDj+6Bfam+
	 qoryJxiLS8ZkNyj0Jn6sofli9BOh3xbAlWNNJCso=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240730092903epcas5p1878b0f01ab72383918d3c7d59b6c420f~m85iEfTml2351123511epcas5p1O;
	Tue, 30 Jul 2024 09:29:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WY90G0q2hz4x9Pt; Tue, 30 Jul
	2024 09:29:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.12.09642.D52B8A66; Tue, 30 Jul 2024 18:29:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240730092855epcas5p49902519f31bddcfe7da8f4b96a7d0527~m85aYgAZP1264212642epcas5p4g;
	Tue, 30 Jul 2024 09:28:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730092855epsmtrp27ade7a5949cfe1a7db06963710282c32~m85aWXy5T2643026430epsmtrp2I;
	Tue, 30 Jul 2024 09:28:55 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-f4-66a8b25d11ea
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.9F.07567.752B8A66; Tue, 30 Jul 2024 18:28:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730092851epsmtip2295dfcd28ca23fdbdcae121fd099ae09~m85WwTq2o2103621036epsmtip2A;
	Tue, 30 Jul 2024 09:28:51 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	andrew@lunn.ch, alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
	swathi.ks@samsung.com, rcsekar@samsung.com, ssiddha@tesla.com,
	jayati.sahu@samsung.com, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v4 1/4] dt-bindings: net: Add FSD EQoS device tree bindings
Date: Tue, 30 Jul 2024 14:46:45 +0530
Message-Id: <20240730091648.72322-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730091648.72322-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTf1STVRg+9/u2fRuF5xMFLxwh/NICC9gC5uVXFnrwO5JJ+QeVeNaET0bA
	trMNkfIUgdqBaoAnRBBwB4QURWEC8XMi7EzPJEYh1IIRIFTy21gkEhJjWP897/s+z/Pe9733
	cnGnOY4bN0GqYhRScRLFcWA1dHq/7HNEe/kYf8mC0OLDcwANlzZwkMnSgaNrbd0YKjadYqGL
	+m42GjeMEsjc3oQhvfEShobKZtjIZKohUE+Dmo20D/rZaGQiGvU2F3PQeZMOQ9n9Y2xUulzN
	RgaNC1q4NwVQWb2VQCuT9QCNzLUSqKinkY30XX/gaKW1kUBlwxo2staaiTe20nVXzBg9nlNP
	0E1FFoLWaFNobVUWh7556TO6qXEeo2d1fRxaXVcF6Ns6AT3+uA2n627NA/ppRglBz2s9ojZ8
	kBgqYcRxjMKTkcbK4hKk8WFU5CHRHlGgkC/wEQShXZSnVJzMhFF734ryiUhIWt0L5XlcnJSy
	mooSK5WU3+uhClmKivGUyJSqMIqRxyXJA+S+SnGyMkUa7ytlVMECPv+1wFXih4mSsd5OXL5A
	nbhQbWWlgwGYDbhcSAbA/MxPsgGP60S2AJhVIsgGDqv4TwAzZgoxe7AAoOafGszGsgmWms/h
	9kIbgL8M3AH24DQGM35vw20sDukFf7r8HWErbCbTMXh2+oc1CU7ewqFZPc6ysTaRkbDt71yO
	7SAscgdcPpVmSzuSwXAxs5Cwt3sBXq1pXzPlkSHw2+nJNR9IlvPg2cdGln2IvfCvRzw7fxOc
	uFO3rnWD8zNtHDsWwavqPpYdS6DlSd56fjdsv1+8ZoOT3vBGs5897Q7zjdfXJsbJDfDrpbH1
	6R1hY+kz/CJcnuxft3SFDRWz621p2HnvGmFfihrAypsWIhd4FP3fQgNAFXBl5MrkeEYZKPeX
	Mqn/XVqsLFkL1p7+zshGMDo859sBMC7oAJCLU5sdRfcrjjk5xonTPmYUMpEiJYlRdoDA1fXl
	4W7OsbLVvyNViQQBQfwAoVAYEOQvFFBbHCdPl8Q5kfFiFZPIMHJG8UyHcXlu6Vhtml7CD4zJ
	fCpeWQqL0CvKrc/7bpFSOz7/4gKuv9373PbKB7m8qY0HTOlp58OvJ3U/LOgy4+8Ofl/+VYxv
	6tLE5LLhcM7BI9vxgVmvsJFkncEcGpFzYlv6cEX0k0XXM8URx/XVv+V5ZXlZ6kSdM8X6rWaX
	rJN9vqqVgYJtbmXWftFQi/uYU6XDbnD07pkpOrxH3fm+8HCQtPUdYDT9eGN0V+ynwV1DG3Xf
	/BpR8PbP4SGjDrCGCnF3YRYO1db0TOg8wgujjT04f79wcL9zQfZ7Ph+l+uXHX5l+pdr57sGg
	owf8Hvl/Sb55UWswMlMDGXv2qaZava2al/bJB2NenW9xMJykWEqJWLATVyjF/wICMyOYgwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRWUwTYRSF+Wc6naGhOKmIgwqaJgYFBZsY/UVRxCUTXDBuRCLBCsNebKaA
	IjEg5QGrAm6IUGkhuIAStNJSVLZaN1AKKhBiWKWKgloWCwRBBeLbOff7kvNwCVRQzFlERMbG
	MWysOEbI5XF0z4RLVwdo7oatyVU4w4mv2QB25+u40NRhQOH9qkYEKk1pHKgyNmLQ/KIXh+21
	lQg01hchsLPwBwZNpgc4bNJlYFDzqRWDPd8C4PvHSi7MMVUjUNHah8H8qVIMvlA7QmvDIICF
	2lEc/hnQAthjeYrD3CY9Bo1v+lH456keh4XdagyOPmzHfZbQ5cXtCG3O1OJ0ZW4HTqs18bSm
	5ByXflSUTFfqRxD6Z3ULl84oLwF0XbWINo9XoXR5zQigp1Nv4vSIxmWffSBvUygTE5nAsJ6b
	j/Ei+t4/Q6VW4am80lFOCvhIKYAtQZFrqcnH2agC8AgB+QRQ580p6Bxwoobl17C5PJ8qnv6C
	z0lyhMq8+pozA7jkCqrtbsUscCCzEKpsuAaZKSjZjFLy+iF8xppP7qKqxrK4CkAQHHI5NZWW
	OHPmk17UhPwGPrewlLr3oHZ22ZbcSN35PjCbBf+cywXvQBawVwObEuDESGWScEmISCqKZU56
	yMQSWXxsuEfICYkGzH7TbYUedKqmPQwAIYABUAQqdOAHf7gVJuCHihNPM+yJYDY+hpEZwGKC
	I1zIF+XkhQrIcHEcE80wUob9TxHCdlEKcr6oq6Ghzk+608/nyaEJkXrHwPNvZ5bFZNZ47ffc
	d73pwpiqICs5xG1DfkRucFk1rBlq3jJvW7TPR2hMivK1W+vu3iqx2u3McFV467aXcwligXJr
	wt7w9QfGmfyL6aW9XYGHKwoClg3af0ZTGVNolOcq1xLS3e+yVD65Mr320m7HinTrPOuRX8n+
	b+2GvM+qDiiN7Zaj99mHZN9087h5nVKq5ncdTxpwvCKpa3sZLLpd2fpbY1RGObSoXKIOZusK
	EgYjuvXrPvV3aT+HqQRhPNBjyWFtkNpo30TzsL1Nmb/lmoptePRqguc8cuO7Jci89XQ9mxf0
	xdDPu7dHW7VNyJFFiEVuKCsT/wVMOaR7PAMAAA==
X-CMS-MailID: 20240730092855epcas5p49902519f31bddcfe7da8f4b96a7d0527
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092855epcas5p49902519f31bddcfe7da8f4b96a7d0527
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092855epcas5p49902519f31bddcfe7da8f4b96a7d0527@epcas5p4.samsung.com>
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
 .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +-
 .../devicetree/bindings/net/tesla,ethqos.yaml | 91 +++++++++++++++++++
 2 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 3eb65e63fdae..0da11fe98cec 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -98,6 +98,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - tesla,fsd-ethqos
 
   reg:
     minItems: 1
@@ -121,7 +122,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     items:
       - description: GMAC main clock
@@ -133,7 +134,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     contains:
       enum:
diff --git a/Documentation/devicetree/bindings/net/tesla,ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
new file mode 100644
index 000000000000..9246b0395126
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/tesla,ethqos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FSD Ethernet Quality of Service
+
+maintainers:
+  - Swathi K S <swathi.ks@samsung.com>
+
+description:
+  dwmmac based tesla ethernet devices which support Gigabit
+  ethernet.
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-ethqos.yaml
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 5
+    maxItems: 10
+
+  clock-names:
+    minItems: 5
+    maxItems: 10
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    $ref: ethernet-controller.yaml#/properties/phy-connection-type
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
+
+    ethernet_1: ethernet@14300000 {
+              compatible = "tesla,fsd-ethqos";
+              reg = <0x0 0x14300000 0x0 0x10000>;
+              interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+              clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
+                       <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
+                       <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
+                       <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+                       <&clock_peric PERIC_EQOS_PHYRXCLK>,
+                       <&clock_peric PERIC_DOUT_RGMII_CLK>;
+              clock-names = "ptp_ref",
+                            "master_bus",
+                            "slave_bus",
+                            "tx",
+                            "rx",
+                            "master2_bus",
+                            "slave2_bus",
+                            "eqos_rxclk_mux",
+                            "eqos_phyrxclk",
+                            "dout_peric_rgmii_clk";
+              pinctrl-names = "default";
+              pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
+                          <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
+                          <&eth1_rx_ctrl>, <&eth1_mdio>;
+              iommus = <&smmu_peric 0x0 0x1>;
+              phy-mode = "rgmii-id";
+    };
+
+...
-- 
2.17.1


