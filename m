Return-Path: <netdev+bounces-114070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505CB940DCA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DAB26322
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A30C19E82C;
	Tue, 30 Jul 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SFXNpOYw"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35B19E815
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331765; cv=none; b=N7Jnvg03f8zy1NDJpueIMTU/rSGl2OHWO3HXLjZynjBqon/wT7CM5EtL3bpWVuLIBzzLVAD/f0Pdpfgub+1kYcDMQxVp38dHoBBa6ERnV6Xz0nOxbaPxlP3bEJYlPU/ayWxivmLaV8hIv2/iBaFRk3Mi5lgZXbIiSrbhVSF3Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331765; c=relaxed/simple;
	bh=/DQN7wlFhNjwCgjwCxxGMwnhQyoM++N1SKCx7cit4/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=YZrpdNIhm4iwsWiol65KEWcuuksn3VKDhcYRItAfwIpCktbUpVLHLPie45Gt/r8cmO7tQ8d+pUbmNz1GuGrr2YRiNNpcz7vlylQj0znzKWkQhiQmDH+BbgmHcWgXauL3lV42y/IaVx/70jp7tm/TTNdj2dSIPukW1cKljp9dx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SFXNpOYw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240730092921epoutp031f78fb2cb2b431873503a760339df95b~m85yHWr8x1577515775epoutp03G
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240730092921epoutp031f78fb2cb2b431873503a760339df95b~m85yHWr8x1577515775epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722331761;
	bh=9b1qcCuUR7o7NGrHlrpGFEmYOKSdxWxtM6MB+MAmgLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFXNpOYwo8BmmmWD2u+g92Px6zNjPdRnVqAX40xMx1NX6/cVIxx0D3cQALfwq2+xB
	 P+gQu8Z+w4zsuJwJGL9eerp0+tmhqtg0oQh8Kf6QaKB5puYcVfg9FyFrOQKvhZJaOb
	 GgjBqyZXrJwRXA76aZGVv9aDsMk9aLqyf2bB1kZw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240730092920epcas5p4447fa999c715be1609600c1e72fa5d20~m85xfTQzh2477224772epcas5p4B;
	Tue, 30 Jul 2024 09:29:20 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WY90Z4pSkz4x9Q1; Tue, 30 Jul
	2024 09:29:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.6E.19863.E62B8A66; Tue, 30 Jul 2024 18:29:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240730092913epcas5p18c3be42421fffe1a229f83ceeca1ace0~m85rcfx2k2928429284epcas5p1I;
	Tue, 30 Jul 2024 09:29:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240730092913epsmtrp1582accd759d37c1ddd9160e1f0635809~m85rbOdrs2361923619epsmtrp1N;
	Tue, 30 Jul 2024 09:29:13 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-11-66a8b26e4aa5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.AF.07567.962B8A66; Tue, 30 Jul 2024 18:29:13 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730092910epsmtip263adb5695f1726963bdef87ff92e4ced~m85n3k4uT2111521115epsmtip26;
	Tue, 30 Jul 2024 09:29:09 +0000 (GMT)
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
Subject: [PATCH v4 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date: Tue, 30 Jul 2024 14:46:48 +0530
Message-Id: <20240730091648.72322-5-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730091648.72322-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHd+5tewsKuQLOI1Fk10k2DIyOAodtTI2LXrNHSPaHhkxqQy+U
	AKX0trrNuOEDp10oA2FDwoCwLbwcj1K6MqHQUovCRmGO51KBdVWh4xE6mbgxpJTpf5/v731+
	5xw+HuDmBfPTZUpGIRNnUjxfjr5nZ3iETFubGnXnSwqtzJwHaKpCz0M2uxlHP3QOYKjc9hUH
	VVoGuMhpvUug8e52DFn6LmPot+p5LrLZmgk0qNdwkdYxwkXTs++jX6+X81CpzYgh9cg9LqpY
	vcpF1qqtaLn/PkDVbQ8ItOZqA2h6sYNAZYMGLrLc+BNHax0GAlVPVXHRg5Zx4s2XaF3dOEY7
	C9oIur3MTtBVWhWtrf+WR7dePk23G9wYvWAc5tEaXT2gTUYB7fy7E6d1XW5AP/niIkG7tSGJ
	/kkZ+6SMWMIoQhlZSrYkXZaWQB08KnpbFBMbJYgQxKM4KlQmzmISqAOHEiPeSc9c3wsV+rE4
	U7VuShSzLLVr/z5FtkrJhEqzWWUCxcglmXKhPJIVZ7EqWVqkjFHuEURF7Y5ZD/woQ3rphpkn
	r91+PH/22VxQEKIGPnxICmH+TCmmBr78ALIDwOULbo5XLAFobRndFMsAtoxUEmrA30i5M/Gc
	194JYJdpAnhFHgZ1JecIT10euQOO1l4jPI4gMheDRXNDuEfgZBcOxzVOjicqkEyCfU478DCH
	fA12VPy0wX7kHqh7OIF5J3wFNjR34x72IffCmjnXRiFIXvKBo983496gA3C5bYjr5UA426sj
	vBwMZwq+3mQRbNAMc7wshfZ/CnlefgN23y7neM6Gkzth0/VdXvPLsKSvcWMGnPSH+Y/ubc7j
	Bw0VT/lVuOoa2Sz5ItRfWdhsRcPeHx/i3rVoAHQ5rNg5EFL2f4sqAOpBMCNns9KYlBi5IELG
	fPLfvaVkZ2nBxusPTzSAhubVSDPA+MAMIB+ngvxEt6+kBvhJxCdOMopskUKVybBmELO+wUI8
	+PmU7PXvI1OKBML4KGFsbKwwPjpWQL3g58q7KAkg08RKJoNh5IziaR7G9wnOxWpLHUGWwVs/
	3wyTHy4sxI6Xroy58PeoOZa31dfsgnGfPbJE78gRFvLykLGmStQ/dv+bg1Tg3Bx3oWml/vHk
	h9VjTWpTgspoPmuLzMAmkx1Dmo7kXHd0Q+/w4trnWxqneN2zZ47FVxRtO3JGj5tE8dd87Jai
	09v/GtJdVcIP9tYtceWs6Y+aLcbvxh3FKdhA/6d19sG8ZjpndH7RNwxvvXXyF8vS8v53W0Pz
	D2eZnNV4z7T9dWfMSMZ5xYmwsrtPircV9EQ62OQLQ/7WU/ik+ZnwQ2clkreY/eakuInG/Meh
	0iNHK3+vCU+Q0TcHd1eeqmG1x1IN+mK1tUTjzpmnOKxULAjHFaz4X76UnUKGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvG7mphVpBpvnGVv8fDmN0eLBvG1s
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xc0DO5ksjpxawmRxb9E7Vovz5zewW1zY1sdq
	senxNVaLh6/CLS7vmsNmMeP8PiaLrmtPWC3m/V3LanFsgZjFt9NvGC0Wbf3CbvH/9VZGi4cf
	9rBbzLqwg9XiyJkXzBb/9+xgt1j0YAGrxZeNN9kdZDy2rLzJ5PG0fyu7x85Zd9k9Fmwq9di0
	qpPNY/OSeo+dOz4zebzfd5XNo2/LKkaPg/sMPZ7+2MvssWX/Z0aPf01z2T0+b5IL4IvisklJ
	zcksSy3St0vgylh85hBbwQqVit5XPA2M/XJdjBwcEgImErdvCXYxcnEICexmlPh18jZzFyMn
	UFxS4lPzVFYIW1hi5b/n7CC2kEAzk8Ten24gNpuAhsT1FdvZQZpFBCYwSaz/tJ8JxGEWuMgs
	0XzqI1iHsECExKsF55hAbBYBVYk9844ygti8AlYSW77fYoLYIC+xesMBsM2cAtYSy9++ZobY
	ZiUxaeElxgmMfAsYGVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHpZbGDsZ78//p
	HWJk4mA8xCjBwawkwht/ZWmaEG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NT
	C1KLYLJMHJxSDUy2h3yzziZzyBgzGfEk+c7bF/8r3nJCesK3kHDm6FUFert+FG+aJljTM2/O
	woY9+SfKT5dFfKha0SC88h23+u4j/g92l/9YnRCtaJZ3SfilC4/S5MTLJtdcl+WbpH1vsN6p
	G/TZXnddtmjNwf1ei5qnR9xbfdLNaceGUqsXNmZla1T2ivIt+b0jJyFmxp4TuxZ2nr9f88ru
	hvDv6qP6gR2CDbf3fffj/B6l+2eW138DHdkQ045NvG2sCtOj9gT+P8t1iO//U0njhoLrjbtU
	b1gfqi+car3r+ZOr85N7Bb3F0hKnFQRIlq++91Dk7GKRuLSu3gfx4Umugtfsll0OFFOUmr9T
	2r24O6CGsWzfKiWW4oxEQy3mouJEAELiedQ6AwAA
X-CMS-MailID: 20240730092913epcas5p18c3be42421fffe1a229f83ceeca1ace0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092913epcas5p18c3be42421fffe1a229f83ceeca1ace0
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092913epcas5p18c3be42421fffe1a229f83ceeca1ace0@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
FSYS0 block and other in PERIC block.

Adds device tree node for Ethernet in PERIC Block and enables the same for
FSD platform.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 27 +++++++++++
 3 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 2c37097c709a..80ca120b3d7f 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -73,6 +73,15 @@
 	};
 };
 
+&ethernet_1 {
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
 &fin_pll {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index cb437483ff6e..6f4658f57453 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -437,6 +437,62 @@
 		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	eth1_tx_clk: eth1-tx-clk-pins {
+		samsung,pins = "gpf2-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_tx_data: eth1-tx-data-pins {
+		samsung,pins = "gpf2-1", "gpf2-2", "gpf2-3", "gpf2-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_tx_ctrl: eth1-tx-ctrl-pins {
+		samsung,pins = "gpf2-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_phy_intr: eth1-phy-intr-pins {
+		samsung,pins = "gpf2-6";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	eth1_rx_clk: eth1-rx-clk-pins {
+		samsung,pins = "gpf3-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_rx_data: eth1-rx-data-pins {
+		samsung,pins = "gpf3-1", "gpf3-2", "gpf3-3", "gpf3-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_rx_ctrl: eth1-rx-ctrl-pins {
+		samsung,pins = "gpf3-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth1_mdio: eth1-mdio-pins {
+		samsung,pins = "gpf3-6", "gpf3-7";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index cc67930ebf78..670f6a852542 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1027,6 +1027,33 @@
 			phy-mode = "rgmii-id";
 			status = "disabled";
 		};
+
+		ethernet_1: ethernet@14300000 {
+			compatible = "tesla,fsd-ethqos";
+			reg = <0x0 0x14300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
+				 <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
+				 <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
+				 <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
+				 <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+				 <&clock_peric PERIC_EQOS_PHYRXCLK>,
+				 <&clock_peric PERIC_DOUT_RGMII_CLK>;
+			clock-names = "ptp_ref", "master_bus", "slave_bus", "tx", "rx",
+				      "master2_bus", "slave2_bus", "eqos_rxclk_mux",
+				      "eqos_phyrxclk", "dout_peric_rgmii_clk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
+				    <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
+				    <&eth1_rx_ctrl>, <&eth1_mdio>;
+			local-mac-address = [00 00 00 00 00 00];
+			iommus = <&smmu_peric 0x0 0x1>;
+			phy-mode = "rgmii-id";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1


