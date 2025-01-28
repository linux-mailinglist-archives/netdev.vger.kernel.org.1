Return-Path: <netdev+bounces-161320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC132A20B1D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88208165CA2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EA1A8412;
	Tue, 28 Jan 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jja0TuSt"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5021AAE2E
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070061; cv=none; b=myTZe8JghUGLoffc559lCdLIOzuhXqZ/WL6sVP2dI/1xhd54XgJRrgB0WJUk3G40L+1lvc6p5niV1c+Y94RbYH16BtqFi8PWr3V186wgGF5/ZsPmIhjsHjIVRCjWosbJRdgq9HSh8t+RN1XjLJr1TLzDlSfzlQfdNIrw0uw4olM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070061; c=relaxed/simple;
	bh=IIgx1B6XqatntkUP5CiQGLFH7WXDRsHzusM2xMjkF2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=Zidxd1N3k7FgvewneonHV/YcOpdifXMRV85lCu1JLDMEw0Iif5yU7/qoFezmIUa0AYH87Nq+wkWLFIdEDlUtotkW2Clg/yt36Q35kjbVxuad19P/JolTsIUyx8EuL1es5oV0eKuuQepaumIOhzMtz8ew1PFHyszWyPe48zBDiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jja0TuSt; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250128131415epoutp026b15bacb6760358091a4113e355104b9~e3YHZK17f0586305863epoutp02N
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:14:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250128131415epoutp026b15bacb6760358091a4113e355104b9~e3YHZK17f0586305863epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738070056;
	bh=rI2/d6PAoM90uS1YsEcLDFsDL2jCXAeosUtgg9fK5S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jja0TuStnvlfkmYms9C+DR+BYGghuhZZZ/86tzkXEvTBhFFZnCD4bbt5cYwOG/DJ2
	 z3Ue7ooPTSEeghTrimMQey+8Z9N8pirQ+o0fLSbWkfsjH/WF9tXI3r1YhaYel05Omd
	 K/BzVH2CBo++ZndxfLTU17yZdhLQzHOEzIMQZKLo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250128131414epcas5p34fd12555ab867182d59b8cd441c7a255~e3YGPt0TP1396613966epcas5p3S;
	Tue, 28 Jan 2025 13:14:14 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yj5N450s0z4x9Ps; Tue, 28 Jan
	2025 13:14:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.13.29212.428D8976; Tue, 28 Jan 2025 22:14:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250128102743epcas5p1388a66efc96444adc8f1dbe78d7239b9~e1GtmjMps0919809198epcas5p1p;
	Tue, 28 Jan 2025 10:27:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250128102743epsmtrp1322fa5aca260b1b3b87dd5067c2e57af~e1GtlVizR0854908549epsmtrp1A;
	Tue, 28 Jan 2025 10:27:43 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-92-6798d82492d4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.C1.18729.F11B8976; Tue, 28 Jan 2025 19:27:43 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250128102740epsmtip1f397206547bb7fd8d92a47b4ed27e2c1~e1Gp7N9lk1807218072epsmtip17;
	Tue, 28 Jan 2025 10:27:39 +0000 (GMT)
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
Subject: [PATCH v5 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date: Tue, 28 Jan 2025 15:55:58 +0530
Message-Id: <20250128102558.22459-5-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250128102558.22459-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTVxzm3NveW5iQG0Q4KwxJwQzJwNYBHhCUbEru4iLFPRhmC1S4FIQ+
	bIvgMjJQI4pSRTbSMUDWSRivCR0gyMOua9TgRkEEeQQHAxYtMhwvQcJcaWH77/t+5/d93y+/
	cw4Hd54nuJwUqYpRSEVpPMKB1fzLzjf9fQY1Yv5wLw+tPC0CaKysmUCmUQOOaju6MVRiOstC
	14zdbDR15w8SDelbMWTsuo6hx9q/2MhkqidRT7OajXQTA2w0bo5BfbdKCKQxdWIob2CSjcrW
	6tjoTrkrWrr/DCBt0wKJXk03ATT+vJ1ExT0tbGT89QmOXrW3kEg7Vs5GCw1DZIQH3Vg1hNFT
	l5tIurV4lKTLdem0rvoCQf90/Uu6tWUeo2c7+wla3VgN6J87BfTUcgdON96eB/Q/p0tJel7n
	KXQ6mhqWzIgSGYUXI02QJaZIxeG8Qx/EvRsXFMwX+AtC0B6el1QkYcJ5B94X+kempFn2wvM6
	KUpLt5SEIqWSt2tfmEKWrmK8kmVKVTiPkSemyQPlAUqRRJkuFQdIGVWogM/fHWRpjE9NXiis
	Z8tXfDIvValBNujxzAP2HEgFwm9m7rPzgAPHmWoH0DgyRdrIHIC6a7PARpYANOmr8U2JZnGB
	ZTvoAHDuu5uEjSwAqG2rI9e7CMoXPvrhptXLhcrG4NWZXnyd4NRtHA6ppyx6DmcrdRSuLiet
	C1jUDqivn8HWsSMVCnO65ghb3HZYU6+3RttTe+ET7d/WaEgV2sOKtiJi3QdSB+Dp7Axb/1Zo
	vttI2jAXPr18bgPHwRp1P8uGk+Hoy4IN//1Q/7DEOg5O7YQ3bu2yld+AX3f9aB0Hp5xg/uok
	Zqs7wpayTewN16YHNixfh80VsxtRNBwZa9jYkBrAvsoy9hXgWfx/RDkA1YDLyJUSMZMQJBf4
	S5mM/+4tQSbRAevr9xO2gJr6tQADwDjAACAH57k4ftatETs7JopOfc4oZHGK9DRGaQBBlgUW
	4NxtCTLL95Gq4gSBIfzA4ODgwJC3gwU8N8czrWfFzpRYpGJSGUbOKDZ1GMeem41F+B5q8FPq
	G91KY4Vf1Gwb8qQ0IdyAsFH+ckreW0zZuStJW2LMH37smjs/eybznYPHvbpzv3Vw8JnUT0SF
	r7S9VqC/1/uwoc9JMm2Oaf0z9tMj7uOffDVp973Aoyeh7fyO3Y8rSvm/H4/acuxivndhdPiy
	3Za5B1kebi8GQ91LpqP9umS6yNwTDzzcUowUkRdafPX88DPf8RfRR3KH4/trsyV7zEkjH11w
	fxmPV/oStaZ7NzR1rgaX3sikmpyIOdek/sPei7XmE1VZq1GDzzMdEicWU38T2hsOlq4sXQyL
	zRnfm3/YLkvvwypp397vfmnZdMrpmDFjZv8sa1/RSe3dSo/3Ch/xWMpkkcAPVyhF/wJ+YVaL
	hgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRiA/c7dxcZpSX5WKI0kW2WpkV8XuxF1/kRFUFFhntxhhk7Hpl0J
	zaSc1hQsMy85ZpmbRXOpqZkuswsWmxplJsaszHXXOaWFWU3p3/PyPLzvj5fBpWZiDnM4OVXQ
	JPNJMkpE1D+UBS8NqSlSLte1LkfeT4UAOa/WU8jR34ajm/ftGCp1ZBGovN1OosHH72jUa2vE
	UHvHNQy9NX4nkcNhoVFnvZ5E1vevSDTweQ960VRKoSJHC4ZyXn0g0dXft0j02DAbjT/7CpCx
	zkOjP1/qABoYbqZRcWcDidqfu3D0p7mBRkangUSeml56wzyu1tSLcYN5dTTXWNxPcwZrGmc1
	6yjuzrV0rrFhFON+tLykOH2tGXAPWiK4wZ/3ca62dRRwk5llNDdqDd4h2SdaqxCSDh8RNMvW
	xYkSPAUWUu1dcOy8SQ8yQGdwDvBnILsCFo15iBwgYqTsPQDHrg+DaREE3WcukdM8C5omh+jp
	yA2gZWiA9gmKDYM9VXenRACbj8Hb7lbMN+BsFw7PdIxMVbPYvTDbVTi1lmBDoc3yDfOxmF0N
	T3e4qekTIbDaYsN97M+ugS7jCOFj6b9mILMQ5AOJAfiZQZCg1qqUKm2EOiJZOBqu5VXatGRl
	eHyKygqm3ilf1ADumofD2wDGgDYAGVwWINb1XlRKxQr++AlBk3JQk5YkaNvAXIaQBYoDXRcU
	UlbJpwqJgqAWNP8txvjPycBW5JaMO0XG1Lim6I9ws0TdFBpqPmCbqNRZjpfFH2yhKqotu0Jz
	M/ZV6QtGGy/UrlTOdMYOD5XmRvJMdL996NwjgxB1MisvvSTR7cpezeNnCWpikyn99YOejCXr
	U3T7+/NjtngdXesCL5oqquVh2K8JganIu7HjTWB9j33MGX35VgKrGm8uVxVnVwXNc1jFKTN2
	r7K9cX6NEiRyhSIRPlw4eSfefSi2rroyrH3+57GagpMo0/Ak1uVn92x82h2n8WpmRs6VxPT1
	8dsWS+i3frEjfYfm+0Xp+7rK5ct4eGpx8XtJZvfW7TvfeUsqD2TtxiJTY/S6S1lXugNCQjAZ
	oU3gI+S4Rsv/BYnP6Eo9AwAA
X-CMS-MailID: 20250128102743epcas5p1388a66efc96444adc8f1dbe78d7239b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250128102743epcas5p1388a66efc96444adc8f1dbe78d7239b9
References: <20250128102558.22459-1-swathi.ks@samsung.com>
	<CGME20250128102743epcas5p1388a66efc96444adc8f1dbe78d7239b9@epcas5p1.samsung.com>
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


