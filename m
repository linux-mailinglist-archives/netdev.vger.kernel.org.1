Return-Path: <netdev+bounces-168076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD0A3D44C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860D117915C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3561EE02A;
	Thu, 20 Feb 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ISWJ+jGq"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B71EE00D
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042814; cv=none; b=tuMIN/VWWh2nvl5lwwgl304Lf5EkZ/KQSpC86K0Y/mCY1T8j+SYeIGGKV7FTCWIF8fwST4tLvJgDua7XPbiWGndGCBFClbaRoEMtW58HcTYAuyHrcxiaUEs6cb8FQasdkSojhwa7NxuW85BfmJWoJLeQIz/PH+i6jx6QqehPP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042814; c=relaxed/simple;
	bh=xsdLHXSw3mdQ7eea7plNyi0z/9AFEsVX5RtC1AnHU6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=S200tbDlLvMHpPQxK9vM9/MOpv09O31pXiTt/WrYLxceG6P8Y3V+XVXHDpEjKa+AmkRbI6tmsBktG3bFoI1L5VCq4MMEw8cukEOOHSySZD1JC7+CA42y6cMsJujoovBxyNYMQy9bKEThxrTds3w6lm5A3LQf/P+5OViiRWE8cT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ISWJ+jGq; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250220091330epoutp04d3138973dd91c783fc03fecf0369a0a5~l37eKSmvh1734017340epoutp04k
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:13:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250220091330epoutp04d3138973dd91c783fc03fecf0369a0a5~l37eKSmvh1734017340epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740042810;
	bh=S357BBwJWVMXtJUDbTDbqvLbzmfGEzzrnbOin0HIOq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISWJ+jGqph4UbWt7Dq3XKpJa7O+BeBYu7HGICb9ONGZeHSswwk64iNfgF5dLM9bwM
	 pGv9JvV59jtjFfauXU60ZjznXbRv9y7dcuDK94NYue6U0UtflsBvt+UAt+9VJ2WJfB
	 u8r5hSxO7FbN0X/PIEdd8z3f4hNX4AOPOjMbPpNo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250220091329epcas5p3cb87aba204387db1f99f3c74e8650c3a~l37du3C_V2116321163epcas5p3w;
	Thu, 20 Feb 2025 09:13:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yz6xh0dQjz4x9QB; Thu, 20 Feb
	2025 09:13:28 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.9F.19933.732F6B76; Thu, 20 Feb 2025 18:13:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53~l2pmVGhdr3017430174epcas5p4J;
	Thu, 20 Feb 2025 07:39:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220073944epsmtrp2897d904f4e9cb2c09cca0c67f46a70e4~l2pmT618j1308313083epsmtrp2J;
	Thu, 20 Feb 2025 07:39:44 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-fe-67b6f2371a88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.65.33707.04CD6B76; Thu, 20 Feb 2025 16:39:44 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220073941epsmtip267bc747019e436c85163dec09917fd26~l2pkKVDFj3266832668epsmtip2t;
	Thu, 20 Feb 2025 07:39:41 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v7 1/2] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Thu, 20 Feb 2025 13:05:26 +0530
Message-Id: <20250220073527.22233-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220073527.22233-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlq7Fp23pBjubGC0ezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/ZwW7xZeNNdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBaV
	bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLWSQlli
	TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
	/utVzAWnlSqm/n/A3sD4QKaLkZNDQsBE4uK3n4xdjFwcQgK7GSVamvYxQzifGCWOH93CAud8
	e9DABtOy+HQvK0RiJ6NEc+91sISQwBdGiUnHK0FsNgENiesrtrODFIkItDFKHHvaCOYwC8xl
	klh1cBtYh7BAlMT5liNAozg4WARUJXa+lgIJ8wpYSUy9cpYRYpu8xOoNB5hBbE4Ba4nTi06C
	zZEQ6OWQeP7hENRJLhKLGpdB2cISr45vYYewpSQ+v9sLFY+XWN13lQXCzpC4+2siVNxe4sCV
	OSwgNzALaEqs36UPEZaVmHpqHROIzSzAJ9H7+wkTRJxXYsc8GFtZ4u/ra1AjJSW2LX0PtdZD
	4tn/H0yQEOpjlPj+fQHLBEa5WQgrFjAyrmKUTC0ozk1PLTYtMMpLLYdHW3J+7iZGcNLU8trB
	+PDBB71DjEwcjIcYJTiYlUR42+q3pAvxpiRWVqUW5ccXleakFh9iNAWG30RmKdHkfGDaziuJ
	NzSxNDAxMzMzsTQ2M1QS523e2ZIuJJCeWJKanZpakFoE08fEwSnVwNR+SOGIzZ3EuXdi38zw
	M7L6dMP919I7099+/rxl++LZpZMdf02fJTHJN+Kfa3ZgqXjl6zWnZbZJX/91+/mLXUWl5bP9
	dbO1kxfkftswuyt5b8zOeptDbO8UFkeoi5XeXM3QqJV2bMkNvrmLv2RETF6QsaxwPZeQTeNP
	Jt79DatuuCuH1N+38lF+HhZ7Vy5KmmnWkR0L1ayLNi0oydrCXm70yIQ7c252ivrmxKtSRvOU
	0xMuvKtR/POnN/r/6w2nbNyas3f9Tfp9SbpFiC1x5qPA35PcfrVLvDt8JFLxYdauLxsVdyRu
	ZrOVaQtf8aDWJ9rGJTS1oeyC+f/4Bac3bLTcIrF4yrPZfP7PRWrubd2oxFKckWioxVxUnAgA
	B3KR/SMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvK7DnW3pBq3r2SwezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/ZwW7xZeNNdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBbF
	ZZOSmpNZllqkb5fAlTH/9SrmgtNKFVP/P2BvYHwg08XIySEhYCKx+HQvK4gtJLCdUWLHDDeI
	uKTEp+aprBC2sMTKf8/Zuxi5gGo+MUocuLKNHSTBJqAhcX3FdrCEiEAfo8SG7a0sIA6zwHIm
	iQUHGhhBqoQFIiS2L5vO3MXIwcEioCqx87UUSJhXwEpi6pWzjBAb5CVWbzjADGJzClhLnF50
	kh3iIiuJI6fvsU9g5FvAyLCKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIziYtYJ2MC5b/1fv
	ECMTB+MhRgkOZiUR3rb6LelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1ML
	UotgskwcnFINTCyb+j0seTaVHTx6aWXE1PWXZ0TLPPcq/HJxq5uDbvSn5IXpv1I9Ex8989xv
	Oi1mh19Cl9AkT+Zfl+0F/nMZm0cZcVzx/DU/dEq0lKfeGif3694sc/fkHNHKmVoT/6C+9LrC
	Rc/np3h/+sl4LpI5vyW6xoH31qUJRiwKq86U/GoxnFylcr2m7xTT1fVHAi4pX918+3yZuobF
	Z1+v8nkt3br1tm9K7h8+F7KZ0cDrjuH0ONWv/T4zrcvqjNeZF/SK3S/YYThvnsHbmpUnhWQd
	BS+YSt45v+r61+o3Deuux1lV2Vtw8ma+yTbqvhrz+TX3J9dPXe//Of7535mgs1G51unIg7RT
	jsdVvFyij9pNU2Ipzkg01GIuKk4EABypPmjVAgAA
X-CMS-MailID: 20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53
References: <20250220073527.22233-1-swathi.ks@samsung.com>
	<CGME20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53@epcas5p4.samsung.com>
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
 arch/arm64/boot/dts/tesla/fsd-evb.dts      | 10 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 20 ++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 8d7794642900..321270a07651 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -64,6 +64,16 @@
 	};
 };
 
+&ethernet0 {
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
index 690b4ed9c29b..01850fbf761f 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1007,6 +1007,26 @@
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
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1


