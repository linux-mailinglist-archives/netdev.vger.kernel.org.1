Return-Path: <netdev+bounces-168077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DEA3D452
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375CC179DEF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879051EEA5E;
	Thu, 20 Feb 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oZodfa6/"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1751EEA35
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042819; cv=none; b=GfPrMXjZcGCXB7dzogCyHt+xLYyk3oX9+3Unt31srLCqx2ECuSD6WwEae5N/pMVgEiJvAQCqhmsrsAFqgusu/pGVTX143G624C/mTD16nGrMotzlBTVV1b2wVxfJUVwHUv+aOo+D/bGodIIYZN3XZt+Lkn3RTH/Y//fIRr8z784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042819; c=relaxed/simple;
	bh=5ibUdrZykS/rvzLD79d3jUQ535b7mLcp6jwQ/GUUCKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=B9D+vEWsyQdZlgw7uS+20uOod5EPO8xfslby38XU7vUo3rXAFUI3D5+iMZNvrfq+oHZYY1HLmmqaSxUxu/u5s0g3nbKPLcu1/xSNpt6D3wH3qhRyCBzMeD7/yo2sb5HENBuDDo6V5YrGHKSUpQJHXJXO1YPzsvcwD0Y/Fs11rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oZodfa6/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250220091335epoutp018f7521345e6b3f285016086afac12986~l37i3Tg8r0265002650epoutp01R
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250220091335epoutp018f7521345e6b3f285016086afac12986~l37i3Tg8r0265002650epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740042815;
	bh=KtlAFheXTf0FyYerM+ptw8UEXD/JdHDfFRdfuDQNIG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZodfa6/FYXQXQ2ll3M7ZYSFII4sthaBh90G0+WcygL0YNgmUpydlH2kE3gLAa6M8
	 ek0fIjcCtp7vMIIuqUWZvn6jjXrWL2xvpk5J0+WmGIowvivlHYWTqjNyHTppf/krJj
	 zeOz28JQ7X/mWhmVbcBBeXnSH/g0oh6tqjoQtyrs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250220091334epcas5p25de5f2a47e2a158203a39f66252b16af~l37h3EAM41861518615epcas5p2J;
	Thu, 20 Feb 2025 09:13:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yz6xl5dqXz4x9Q3; Thu, 20 Feb
	2025 09:13:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.9F.19933.B32F6B76; Thu, 20 Feb 2025 18:13:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220073948epcas5p1d90c5111fda1ccc4395dbe918066caca~l2pp4ifXc1846718467epcas5p1b;
	Thu, 20 Feb 2025 07:39:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220073948epsmtrp1a4fee4634f8407d3ea5496e38fa5cd16~l2pp3lCzC2536525365epsmtrp1z;
	Thu, 20 Feb 2025 07:39:48 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-05-67b6f23b530f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.DC.23488.34CD6B76; Thu, 20 Feb 2025 16:39:47 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220073945epsmtip2c91087019405c5a6c934b83eed0b4e48~l2pnwvZ953267832678epsmtip2k;
	Thu, 20 Feb 2025 07:39:45 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v7 2/2] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date: Thu, 20 Feb 2025 13:05:27 +0530
Message-Id: <20250220073527.22233-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220073527.22233-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmuq71p23pBgf3aVo8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC0q
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GolhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	8w1rWAreqVYc3bmetYFxg3wXIyeHhICJxIYrs5m6GLk4hAR2M0o8WvaZBcL5xCixce4bRgjn
	G6PEt9997DAtVzo/sUMk9jJK/Fywjw3C+cIosWj6f0aQKjYBDYnrK7aDVYkItDFKHHvaCOYw
	C8xlklh1cBsbSJWwQJTEhVtPmEBsFgFViUPrvoF18wpYSezp/s8GsU9eYvWGA8wgNqeAtcTp
	RSeh7ujlkPi4w7iLkQPIdpGY01IAERaWeHV8C1SJlMTL/jYoO15idd9VFgg7Q+Lur4lQ4+0l
	DlyZwwIyhllAU2L9Ln2IsKzE1FPrwC5jFuCT6P0NcaWEAK/EjnkwtrLE39fXoEZKSmxb+h5q
	lYfElEUHWCGB0sco8fv1OeYJjHKzEFYsYGRcxSiZWlCcm55abFpglJdaDo+25PzcTYzgpKnl
	tYPx4YMPeocYmTgYDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUktPsRoCgy+icxSosn5wLSd
	VxJvaGJpYGJmZmZiaWxmqCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBaY3WxxzB2YZrhGs3
	aVlY3VnRYSXZE1Rrcbz4R4+24LRQQYt/C4TL3rxo693BumnNMnGb8ubJTtvzL0hecpOYekI5
	wU9138r2BT91ZqV47Y1ds6rg3b6XmnHxm9feLNqj+PhR/geFo/5q93o1dj+Sd7vc/M71zUzx
	5GhXQ5kI0TOP/9Tt+h8ZPKNsecn7xsIrJh+9Zb013nW/NGEx5KlK7+opOXon9NTrDrUM18Xf
	+VLdym0dzTKViuJ/x9TM6nC5sbmhyNB5WVqlsqVttCH/F/FfyW8qHujNPFh05/l285+zJ8W8
	235EfxvDL4abV7csZ50is+bM0+q87TqXPfWq118QnezeEl3UINX+6qSzEktxRqKhFnNRcSIA
	h18gsCMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvK7znW3pBo1dVhYP5m1js1iz9xyT
	xfwj51gtbh7YyWRx5NQSJouXs+6xWWx6fI3V4uGrcIvLu+awWcw4v4/J4tgCMYtFW7+wWzz8
	sIfd4siZF8wW//fsYLf4svEmu4OAx85Zd9k9Nq3qZPPYvKTeo2/LKkaPf01z2T0+b5ILYIvi
	sklJzcksSy3St0vgyni+YQ1LwTvViqM717M2MG6Q72Lk5JAQMJG40vmJvYuRi0NIYDejRP+M
	FlaIhKTEp+apULawxMp/z6GKPjFKXP4ymxEkwSagIXF9xXawhIhAH6PEhu2tLCAOs8ByJokF
	BxrAqoQFIiQ+vLvDAmKzCKhKHFr3DSzOK2Alsaf7PxvECnmJ1RsOMIPYnALWEqcXnWQHsYWA
	ao6cvsc+gZFvASPDKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4MDW0tjB+O5bk/4h
	RiYOxkOMEhzMSiK8bfVb0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzrjSMSBcSSE8sSc1OTS1I
	LYLJMnFwSjUwOUaZ84bLyDheslJdr8x8utHYJGSL0aUZZd6rIr3euv2pZGFXsLCK0XV24xJ4
	tKHpzJdbZw8ed/5b8e2G8rRSw68JC1R939Vb3eC2f3ghvXTh+/i06I6uJSb29XZsM89PXBuc
	9WQu064NP/Lk+i9tPHRPblv9celjccfSNrYsTRbfWstpsrDK6seEmZE92Tku6m8EzpvHlx78
	pNyY9HXOTK0f7Ile5YE7d858KqcgsmDV38Pznu5tsjY2/vW4R6ZVfEfHaa8yBYb58p9fvfjL
	yyKyWm67I/v1gIVSPydN3ui30bz3Qmh2z5OgyN/FgVc22J89aNXuOG03r/MV53cyRg21zGeZ
	Ly75JxL4JUteiaU4I9FQi7moOBEA6ti4N9sCAAA=
X-CMS-MailID: 20250220073948epcas5p1d90c5111fda1ccc4395dbe918066caca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220073948epcas5p1d90c5111fda1ccc4395dbe918066caca
References: <20250220073527.22233-1-swathi.ks@samsung.com>
	<CGME20250220073948epcas5p1d90c5111fda1ccc4395dbe918066caca@epcas5p1.samsung.com>
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
 arch/arm64/boot/dts/tesla/fsd-evb.dts      | 10 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 27 +++++++++++
 3 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 321270a07651..9ff22e1c8723 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -74,6 +74,16 @@
 	};
 };
 
+&ethernet1 {
+	status = "okay";
+
+	phy-mode = "rgmii-id";
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
index 01850fbf761f..f96a69e25156 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -979,6 +979,33 @@
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
+			status = "disabled";
+		};
+
 		ufs: ufs@15120000 {
 			compatible = "tesla,fsd-ufs";
 			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
-- 
2.17.1


