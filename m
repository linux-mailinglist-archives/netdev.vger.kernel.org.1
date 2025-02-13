Return-Path: <netdev+bounces-166038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049DA34092
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012DD188E3CF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E279242903;
	Thu, 13 Feb 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DcwD4her"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9A227EB5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454201; cv=none; b=qM6mnbpxYkfAIPzi95e+Utv5bXQMlZiTYSbCIp0H2Mm+LkqMI4xYI8g9kIF8e16t2EirgzKgi62Ot6UV80N1aIziwcSugEyUFkftKIezWnzX7sl1RcP3Me4r8FQMNWjDmq1h1kjEZ4nPKR1B6bqZVd8kgaQ7QjG651xrgA5ODdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454201; c=relaxed/simple;
	bh=UKe4+UA31I5tCHy8n/yINgpsLAu5q3mN7fsybj753Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=BJ4w4HFl7HQ7dJwxT0z6004v4X0i9NPK8p5XhwDCqRPmqCzk5Lm5F2utFhfe16upcpUjRnbNAWrPRFi3NQLxq4HppXYGOoDMd6a9Tvk/k1iFtGq8ihD9o6278+kLxiAA30W2EK+wtQRDW67DTq0wA7LLZX9FTBfPMqNMvzf6+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DcwD4her; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250213134317epoutp04c7da9e9554c735a90f22f93bcf06f89e~jyGBObce73252132521epoutp04F
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250213134317epoutp04c7da9e9554c735a90f22f93bcf06f89e~jyGBObce73252132521epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739454197;
	bh=5FL2NYkUMZrJnKt4YtsJYh9Drp/1gJtqNCgkcUVYJ6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcwD4hertPNro4/ElY37yCvnnzqkUvATi1NHlQmvhiMHEri+BVoOxsvAgwnrMAzdL
	 OPkeNcwC3K1a/rrw4Hz2Y7ikd8VBRxOrShNEFK0wnwj9x82xwHn/Ebh5uXw+24R5io
	 VvcL5U7RdrwtpWus23wEDOdIC5QcRBYXLmXGAYTA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250213134315epcas5p1f1f473e53f18fee6b9715a0e4eea94af~jyF-9SOj61560915609epcas5p1B;
	Thu, 13 Feb 2025 13:43:15 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YtxG963GKz4x9Pp; Thu, 13 Feb
	2025 13:43:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.A5.29212.1F6FDA76; Thu, 13 Feb 2025 22:43:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250213132736epcas5p3063b7628bd77ef6609d0b0c97e29b764~jx4VYjREY2034120341epcas5p3k;
	Thu, 13 Feb 2025 13:27:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250213132736epsmtrp2fd1964442522e86b1a4f8b4530a27a17~jx4VXtF422782827828epsmtrp2i;
	Thu, 13 Feb 2025 13:27:36 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-b0-67adf6f150cf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.01.23488.843FDA76; Thu, 13 Feb 2025 22:27:36 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213132734epsmtip1e6158500534793f7d3ebd3779b7b71db~jx4TGD6700661406614epsmtip1J;
	Thu, 13 Feb 2025 13:27:34 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 1/2] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Thu, 13 Feb 2025 18:53:27 +0530
Message-Id: <20250213132328.4405-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250213132328.4405-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmlu7Hb2vTDXrnaFs8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC0q
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GolhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	4ZMvmArWq1SsWzeVrYFxjVwXIyeHhICJxO+5c1i7GLk4hAT2MEq87DvACOF8YpR4uuI+M4Tz
	jVFiy+LJjDAtfbO/sEAk9jJKdD+8BeV8YZR4/m41WBWbgIbE9RXb2UESIgJtjBLHnjaCOcwC
	lxkllm57xQxSJSwQJbF14xKg9RwcLAKqEks/yYCEeQUsJZrv3WGBWCcvsXrDAbByTgEriVvn
	z4BdKyEwkUPi5LzZzBBFLhLTlr1ggrCFJV4d38IOYUtJfH63lw3CjpdY3XcVamiGxN1fE6Hi
	9hIHrsxhAbmBWUBTYv0ufYiwrMTUU+vARjIL8En0/n4CNZ5XYsc8GFtZ4u/ra1AjJSW2LX0P
	tdZDYsaaHnZIqPQySqy82sc2gVFuFsKKBYyMqxilUguKc9NTk00LDHXzUsvhEZecn7uJEZw4
	tQJ2MK7e8FfvECMTB+MhRgkOZiURXolpa9KFeFMSK6tSi/Lji0pzUosPMZoCA3Ais5Rocj4w
	deeVxBuaWBqYmJmZmVgamxkqifM272xJFxJITyxJzU5NLUgtgulj4uCUamBK2XZ8yvT3S0zL
	Ol7LVaTsYDp828eh7+vxmmWsJje25zz6tr0ot/N+/sajJrXKFSwrNAx1Zjx2eG7aHn06+OHi
	yoxNVokp/kuLnpZv8GcxUs7k6bxgmHepXlj4rcL5R/ve6ssZWgRP2/RHmPfeSyPXuMsJPf3l
	m0P7hWaWtzELPxUoFTVf2+EdKhM4caeXefnnsC3rMhaevH/GQvj8liqhHV65XzXPHYpdIXip
	LOpb7JRI++PSx83znpYW/Nab+jH2bsQc7pB7uw+1t/A9VZ1ldnC/oDr/Af8LbXue3p9w5oX/
	m0w/u9TJtgZfNsre2r5Z85q41j2W68Uf1NKefT2t/+Ce3yzl6oXTxP8b7NioxFKckWioxVxU
	nAgA6y3/8yUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnK7H57XpBjO2ylo8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC2K
	yyYlNSezLLVI3y6BK+PwyRdMBetVKtatm8rWwLhGrouRk0NCwESib/YXli5GLg4hgd2MEitu
	nWGGSEhKfGqeygphC0us/PecHaLoE6PEnGcv2EESbAIaEtdXbAdLiAj0MUps2N4KNopZ4Caj
	xLf1j8FGCQtESBzc/oypi5GDg0VAVWLpJxmQMK+ApUTzvTssEBvkJVZvOABWzilgJXHr/Bmw
	zUIgNWcuM09g5FvAyLCKUTK1oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4rLU0djC++9ak
	f4iRiYPxEKMEB7OSCK/EtDXpQrwpiZVVqUX58UWlOanFhxilOViUxHlXGkakCwmkJ5akZqem
	FqQWwWSZODilGpiSF63g7ZG7mr7hS7rpnnWme2RWyj489P8jAwvr1TuTNbw2Ju87EZNwidVz
	IoNVzWxt6TmbF0f76El4GTYFMP77ziHquSfkxf2bfcLFH4ylA1YcbI2qDF6csfmfX7rCtAuH
	dsYUC16e+fSi77GH3YEBq3633zl7QeaslNiZ9rNevpWeETMmRL+uKLR+e8p03fLI0zK5sXed
	dA/9n/huu0T/ypqg+hX1sT+2f298f3Lfs3nsdzhcr64KfFb0a2G63bv7jQWPMh6zXzlqyzaX
	65FHG9eur0vPbtVfGHCET9/T9n3exnc71rRZOsZtnh7J7u2yacr0r2E+31TEWWayHpgxZY/A
	bJ7Pb0suZ3EcKt7hqcRSnJFoqMVcVJwIACFHcAjaAgAA
X-CMS-MailID: 20250213132736epcas5p3063b7628bd77ef6609d0b0c97e29b764
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213132736epcas5p3063b7628bd77ef6609d0b0c97e29b764
References: <20250213132328.4405-1-swathi.ks@samsung.com>
	<CGME20250213132736epcas5p3063b7628bd77ef6609d0b0c97e29b764@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one
in FSYS0 block and other in PERIC block.
The ethernet interface is managed by a switch which is not managed by
Linux.

Adds device tree node for Ethernet in FSYS0 Block and enables the same for
FSD platform.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
This patch depends on the dt-binding patch
https://lore.kernel.org/netdev/20250213044624.37334-2-swathi.ks@samsung.com/

And the driver patch
https://lore.kernel.org/netdev/20250213044624.37334-3-swathi.ks@samsung.com/

 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 21 ++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 8d7794642900..cb977d0441a1 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -64,6 +64,15 @@
 	};
 };
 
+&ethernet0 {
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
index 3f898cf4874c..cb437483ff6e 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -64,6 +64,62 @@
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	eth0_tx_clk: eth0-tx-clk-pins {
+		samsung,pins = "gpf0-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_tx_data: eth0-tx-data-pins {
+		samsung,pins = "gpf0-1", "gpf0-2", "gpf0-3", "gpf0-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_tx_ctrl: eth0-tx-ctrl-pins {
+		samsung,pins = "gpf0-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_phy_intr: eth0-phy-intr-pins {
+		samsung,pins = "gpf0-6";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	eth0_rx_clk: eth0-rx-clk-pins {
+		samsung,pins = "gpf1-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_rx_data: eth0-rx-data-pins {
+		samsung,pins = "gpf1-1", "gpf1-2", "gpf1-3", "gpf1-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_rx_ctrl: eth0-rx-ctrl-pins {
+		samsung,pins = "gpf1-5";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV6>;
+	};
+
+	eth0_mdio: eth0-mdio-pins {
+		samsung,pins = "gpf1-6", "gpf1-7";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_peric {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 690b4ed9c29b..c8311cfaeeb0 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1007,6 +1007,27 @@
 			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
 			clock-names = "ref_clk";
 		};
+
+		ethernet0: ethernet@15300000 {
+			compatible = "tesla,fsd-ethqos";
+			reg = <0x0 0x15300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_CLK_PTP_REF_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_ACLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_HCLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_RGMII_CLK_I>,
+				 <&clock_fsys0 FSYS0_EQOS_TOP0_IPCLKPORT_CLK_RX_I>;
+			clock-names = "ptp_ref", "master_bus", "slave_bus", "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&eth0_tx_clk>, <&eth0_tx_data>, <&eth0_tx_ctrl>,
+				    <&eth0_phy_intr>, <&eth0_rx_clk>, <&eth0_rx_data>,
+				    <&eth0_rx_ctrl>, <&eth0_mdio>;
+			local-mac-address = [00 00 00 00 00 00];
+			iommus = <&smmu_fsys0 0x0 0x1>;
+			phy-mode = "rgmii-id";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1


