Return-Path: <netdev+bounces-166039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BAA3409E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD13188EB8E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2D2222B9;
	Thu, 13 Feb 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p6w3rGcX"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B7242930
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454206; cv=none; b=OfeCwC/RAFCFXP4iPn2p8vpoZTpD0ODAOSF0N7+pUxI1Srh9OEpfR4GZu79fHILnGj9J2/pUdb+cbhlb3FtOKp4qbMKO/gBT2YZoGtDIT28wScAW0QKBJWvD0d+TwrVR3o3mKs7i9+wht45l8SlHBGs2TBDzzQ1f6QDv8vNHMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454206; c=relaxed/simple;
	bh=LYw2k0jiOHJJsAwNO1BuFn7IJWnmREm2b6VSx7ysIvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=skz+y9iKqkG+LjwyE0CrMxSvdqolN/RUDf+2oqzBICreHyj3CnMBWf+FLgXtpooKysjQ967umdOpw/KQz6seHTLCXDifOzKfQpVafsmLGaO0gufp0+xmZ2Ue47Yascbfg+bfpwlwYFRZds6kIeMnYz8D/sUin9Kb8dMCLpgK/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p6w3rGcX; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250213134321epoutp01b3852a1cb908afc4efbf8d56fa3cb97d~jyGFOWOxv0243702437epoutp01E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:43:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250213134321epoutp01b3852a1cb908afc4efbf8d56fa3cb97d~jyGFOWOxv0243702437epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739454201;
	bh=Euk7TqUpX6X4QNy8TA412LZdsq6ZeUoYJJPn/UUbcuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6w3rGcXC2NoUFWUMcl+V0FB/wNczlqo395WYcu/GeLvq3zM6vzfRSuRCS8gph650
	 buRZBFR/BChwDXezv/4esEt9XvecF20xpX0OXa/HY+SM5mlqdYr40Myur0unrtMUHD
	 TDhsFFtySZbpSxR117uC5xGtivhZJlYMzFq6p5qs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250213134320epcas5p42903fd90823d48d3e25d118b0e35c732~jyGEuwaz51976419764epcas5p4I;
	Thu, 13 Feb 2025 13:43:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtxGG75Y2z4x9Ps; Thu, 13 Feb
	2025 13:43:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.25.19956.6F6FDA76; Thu, 13 Feb 2025 22:43:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250213132740epcas5p3d9446fbb5ba0e0b5eed596453b690568~jx4Y0-VuS2034120341epcas5p3m;
	Thu, 13 Feb 2025 13:27:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250213132740epsmtrp2e80b999a8f20d53f427a74ebda70223d~jx4Y0P1Db2782827828epsmtrp2k;
	Thu, 13 Feb 2025 13:27:40 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-87-67adf6f6eb7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.11.23488.C43FDA76; Thu, 13 Feb 2025 22:27:40 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213132738epsmtip1b2e32ec1a26d078f7d831a390a11af66~jx4WsUlQl0863808638epsmtip1A;
	Thu, 13 Feb 2025 13:27:37 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 2/2] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date: Thu, 13 Feb 2025 18:53:28 +0530
Message-Id: <20250213132328.4405-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250213132328.4405-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhu63b2vTDaZONrd4MG8bm8WaveeY
	LOYfOcdqcfPATiaLI6eWMFm8nHWPzWLT42usFg9fhVtc3jWHzWLG+X1MFscWiFks2vqF3eLh
	hz3sFkfOvGC2+L9nB7vFl4032R0EPHbOusvusWlVJ5vH5iX1Hn1bVjF6/Guay+7xeZNcAFtU
	tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0NVKCmWJ
	OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
	9TuPMhZcUq+YMrGTpYHxj0IXIyeHhICJxJWFX9m6GLk4hAR2M0q8WLsIyvnEKPHq5mpWCOcb
	o8S/t0uYYFr+7FnDCJHYyyjx6fJtJgjnC6PEk38vWECq2AQ0JK6v2M4OkhARaGOUOPa0Ecxh
	FrjMKLF02ytmkCphgSiJ/5OPsYHYLAKqErf7d4Lt4BWwlFh17zA7xD55idUbDoDVcwpYSdw6
	f4YVIj6TQ+LufiEI20XifMsdRghbWOLV8S1QvVISn9/tZYOw4yVW911lgbAzJO7+mggVt5c4
	cGUOUJwD6DhNifW79CHCshJTT60DO4dZgE+i9/cTqPd5JXbMg7GVJf6+vgY1UlJi29L3UGs9
	JE5t+swOCZVeRonZff+ZJjDKzUJYsYCRcRWjZGpBcW56arFpgXFeajk83pLzczcxgtOmlvcO
	xkcPPugdYmTiYDzEKMHBrCTCKzFtTboQb0piZVVqUX58UWlOavEhRlNg+E1klhJNzgcm7ryS
	eEMTSwMTMzMzE0tjM0Mlcd7mnS3pQgLpiSWp2ampBalFMH1MHJxSDUzmOw9Hn5Lymugzf25s
	y5WDOsfqK7/tV079uEjjxZOeGMGtLBsPfPn/3tR5dUGE+IppMSr7S356yH7ap3o7Z2ZJ0RE2
	vQg3HvYtv61fcYc7Wp97ypzOufjEzIiI8OOyPh87whlvTNykv4Rn/fIcbl65D5FRzZOO/dmw
	eXGTeXr/opW5nG8bK43/ObPtZfPd7pTUvOHeAuWvhpe2nE/cNfub/qepgc9WzYlNWhigqyCk
	FMBrVxZi730vbL+u5C6RJg2lVvbePsM5V6K/LL6W9HfaUbO4jbqeJU9//poTsn9/T9xHFf1p
	9gE6b6/veVaypP1yDlfe/IkRD+eqx78NfvHB9ES3aMmeua9UVn86UXtOiaU4I9FQi7moOBEA
	FAZDhSQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnK7P57XpBlfu81o8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC2K
	yyYlNSezLLVI3y6BK2P9zqOMBZfUK6ZM7GRpYPyj0MXIySEhYCLxZ88axi5GLg4hgd2MEuu/
	bmOBSEhKfGqeygphC0us/PecHcQWEvjEKDFnvg+IzSagIXF9xXZ2kGYRgT5GiQ3bW1lAHGaB
	m4wS39Y/Zu5i5OAQFoiQmPvRF6SBRUBV4nb/TiYQm1fAUmLVvcPsEAvkJVZvOMAMYnMKWEnc
	On+GFWKZpUTzmcvMExj5FjAyrGKUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECA5qLY0d
	jO++NekfYmTiYDzEKMHBrCTCKzFtTboQb0piZVVqUX58UWlOavEhRmkOFiVx3pWGEelCAumJ
	JanZqakFqUUwWSYOTqkGppgG0Y55K3pfXpw/+WHYAy+eS72L6iKvtzJVb+F8sfVtnBSvY9Ie
	4bidid9eqDz7K+RmMXdF86F1e98tmRdvqMf88MOTzgyeAxZFskvmRPzzWvdCb3+WXXC5IW/U
	24cVv9sv1ec3r+v6vON15DTdEL/kNdWSTJcLlu5/ICh7LqbIT+Xn+5i1Uzck/6nfUnAkRG19
	WMspzy2/p8W52uacnVcz90ii+wK3wIwek/XXbmz+Pt827/KVGKlXIl+uPl3S8nul/P5zO0+8
	qhbU4XVk/X2jlVOivCOmICbfzbvqaVp52LUo1rWPtk7guxEpkrnC3GHa8UsvI3vv/1nwkk37
	kvQuhQkflxx7d7O6u3BK/F0lluKMREMt5qLiRAChqT1d2QIAAA==
X-CMS-MailID: 20250213132740epcas5p3d9446fbb5ba0e0b5eed596453b690568
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213132740epcas5p3d9446fbb5ba0e0b5eed596453b690568
References: <20250213132328.4405-1-swathi.ks@samsung.com>
	<CGME20250213132740epcas5p3d9446fbb5ba0e0b5eed596453b690568@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one in
FSYS0 block and other in PERIC block.
The ethernet interface is connected to a switch which is not managed by
Linux.

Adds device tree node for Ethernet in PERIC Block and enables the same for
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
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 28 +++++++++++
 3 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index cb977d0441a1..382f40322082 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -73,6 +73,15 @@
 	};
 };
 
+&ethernet1 {
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
index c8311cfaeeb0..add456e0ca15 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -979,6 +979,34 @@
 			memory-region = <&mfc_left>;
 		};
 
+		ethernet1: ethernet@14300000 {
+			compatible = "tesla,fsd-ethqos";
+			reg = <0x0 0x14300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
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
+
 		ufs: ufs@15120000 {
 			compatible = "tesla,fsd-ufs";
 			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
-- 
2.17.1


