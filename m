Return-Path: <netdev+bounces-172821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC2A563A7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6093B3A59B2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D5201010;
	Fri,  7 Mar 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SVXi5s96"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD41FDE2E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339334; cv=none; b=lbaXdy+MLXbshc2OI/41GKfVjxDBVvh57Ci+n/i/JXi/Xr82Xz3sDE1+u0nBAkeFgzHVKrjXd1A+RpSTxCq0bAW324Uy4BaVg7KkVzZhCBKoNK7a79p1yQiNfsgiIrkA7wyGFyEDNgQErrY+bQkPH/j/CCF4XvxD59i9znaskcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339334; c=relaxed/simple;
	bh=yNxOhXYIvNFmAhFJZ/JNNjx0UtL+SQYo7g+8bzyz/7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=phMoMwMlbq7HruMW6DiEv5oU2LQqvDzxjTrHnuVNyzFXc+QDfS6CrSHRFWq0JSxIrztHxmeWe2YfVKtGQZR0jLaIaOq33VBp5WVyQvZ/DoSDW6pJ1MLRSzsSDvaaOdCIhkQsnk+9nu0SGYkLhmsY8OswrvC2PZy3Sjryl3Fy4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SVXi5s96; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250307092210epoutp0174d806b1276de08ac53d161057a4abbb~qeuU282Zq0333003330epoutp01b
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250307092210epoutp0174d806b1276de08ac53d161057a4abbb~qeuU282Zq0333003330epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741339330;
	bh=oc7YHSjsxtVonlvoGk2xIqyBO7/KdbIfRxzx7Tv596M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVXi5s96pzun31fhXZuRUZlpWrvhPhyP1XSFcG3ypgD2IKjCzN5Zog+SZ9JFDOJSD
	 vX0+Ax5J/R9IewH+a6driVCzNPboBzzExVAVVvbC22lFG87Flb6sFkkxxC2ir5ACQP
	 2C2iO6IwXklvHeu6QbKU4o2FBtn3gKfRVlsR2wiM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250307092209epcas5p4b17984afa515636d2f1cab81c4c66706~qeuUBnDJk0294602946epcas5p4x;
	Fri,  7 Mar 2025 09:22:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z8LQm0f4pz4x9Q8; Fri,  7 Mar
	2025 09:22:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.B0.19933.FBABAC76; Fri,  7 Mar 2025 18:22:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250307045524epcas5p3f4ef3398f70f8286ddd9903a4e1d68f4~qbFZ4U9cz2885928859epcas5p3s;
	Fri,  7 Mar 2025 04:55:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250307045524epsmtrp271a8640a0655ee2f0981cdd6e9fe965e~qbFZ3Lrii1515815158epsmtrp2t;
	Fri,  7 Mar 2025 04:55:24 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-ec-67cababfc24e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.9C.23488.C3C7AC76; Fri,  7 Mar 2025 13:55:24 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250307045522epsmtip124914e600f7411a4d5d0d92eca178c8c~qbFXpYlwQ1085010850epsmtip1C;
	Fri,  7 Mar 2025 04:55:22 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v8 2/2] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Date: Fri,  7 Mar 2025 10:19:04 +0530
Message-Id: <20250307044904.59077-3-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250307044904.59077-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXffArlPpBn+FLR7M28ZmsWbvOSaL
	+UfOsVrcPLCTyeLIqSVMFi9n3WOz2PT4GqvFw1fhFpd3zWGzmHF+H5PFsQViFou2fmG3ePhh
	D7vFkTMvmC3+79nBbvFl4012BwGPnbPusntsWtXJ5rF5Sb1H35ZVjB7/muaye3zeJBfAFpVt
	k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tJJCWWJO
	KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Nt
	+wH2grnqFad/bmNqYDyq0MXIySEhYCJxd8tN9i5GLg4hgd2MEpMnnGGGcD4xSrxaMIERwvnG
	KHFt4n82mJZTn84zgdhCAnsZJc6ti4co+sIo0bHjNjNIgk1AQ+L6iu1gc0UE2hgljj1tBHOY
	BeYySaw6uA1slLBAlMT1/idgNouAqsSWVWvBbF4BK4ll+/ayQqyTl1i94QDYVE4Ba4lz++6C
	DZIQ6OWQ+PSqnQWiyEWieVsbI4QtLPHq+BZ2CFtK4vO7vVB3x0us7rsKVZ8hcffXRKi4vcSB
	K3OA4hxA12lKrN+lDxGWlZh6ah3Ym8wCfBK9v58wQcR5JXbMg7GVJf6+vgY1UlJi29L37CBj
	JAQ8JO4ezISESh+jxNSOVawTGOVmIWxYwMi4ilEytaA4Nz212LTAKC+1HB5tyfm5mxjBKVPL
	awfjwwcf9A4xMnEwHmKU4GBWEuFV234qXYg3JbGyKrUoP76oNCe1+BCjKTD8JjJLiSbnA5N2
	Xkm8oYmlgYmZmZmJpbGZoZI4b/POlnQhgfTEktTs1NSC1CKYPiYOTqkGpo3tNRm+MsUHlpfo
	nW2Kztnnv68+XzOpXK1W5pcmz+tlS3+8FOsRyVlq0JUfVBEWvnmy8gdd3vCP98MNA9ycfz+P
	l3CM2eul57U65GBASl/Dt6ltH0Xku4z2rzcyu1T7Y+Wr7Uc+JHxdlzgrcPb6LSU8+nJc9yQE
	LYs/rU12Ep5/LfVr9v/7z2e69TdwLgv229fvcXNnsUWkVWt4wcx/bj/b5q/k2+MpL3D7Zfze
	a1vfKm34Ga0kP7en7GfTxVTPhqfBc5gLz1V8sBLSWem+gE15y9efriytOwqn5ud1v7t9ekV7
	5sJqX//NTZPUw64t1P2RUnteTmlHRv3nOsGbjjoHPP1/tS1X72WL/+SoxFKckWioxVxUnAgA
	AgCv4iIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnK5Nzal0g7nnxS0ezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/ZwW7xZeNNdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBbF
	ZZOSmpNZllqkb5fAlbG2/QB7wVz1itM/tzE1MB5V6GLk5JAQMJE49ek8E4gtJLCbUeLodgGI
	uKTEp+aprBC2sMTKf8/ZIWo+MUpM2qYMYrMJaEhcX7EdKM7FISLQxyixYXsrC4jDLLCcSWLB
	gQZGkCphgQiJc2f6mUFsFgFViS2r1rKB2LwCVhLL9u2F2iAvsXrDAbAaTgFriXP77kJts5KY
	PX0u+wRGvgWMDKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYKDWktjB+O7b036hxiZ
	OBgPMUpwMCuJ8ApuPpkuxJuSWFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoR
	TJaJg1OqgUn6442lcyqvp1U5iy+9GdWzPGx/evPuPSsXf6jSmKp7MP/iidePp31T2sAUuydS
	5FrPtx+/452Vr9ddc/xXHHe9/nqXqOBk7dz8pPfHQqNCpHT7f7r9DhSZzfb/xsQ1bV949GRD
	lGX+q82tl/1W9eLlrNs95ziELGZ+bFGymePIq2ytUco232PiM5+2vfMavAs7ngrqJR2svftQ
	agpH+6TjLft9db7Lp3RkSk7P0fw6wyRUcKLvNJ/m1SvdHs+aMyk08YNaQv+H5ohdsbZOe/7X
	Z9z8caD6GcfTT6v/7H4/YclHFu/1wfpTgrkqJph18q25OLNiae3mS0GdHo6mp3Z2352u1Tm5
	cB0nw70dvm+UWIozEg21mIuKEwEy5iyx2QIAAA==
X-CMS-MailID: 20250307045524epcas5p3f4ef3398f70f8286ddd9903a4e1d68f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250307045524epcas5p3f4ef3398f70f8286ddd9903a4e1d68f4
References: <20250307044904.59077-1-swathi.ks@samsung.com>
	<CGME20250307045524epcas5p3f4ef3398f70f8286ddd9903a4e1d68f4@epcas5p3.samsung.com>
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
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 30 ++++++++++++
 3 files changed, 96 insertions(+)

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
index 01850fbf761f..0fb1b508be52 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -979,6 +979,36 @@
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
+			assigned-clocks = <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+					  <&clock_peric PERIC_EQOS_PHYRXCLK>;
+			assigned-clock-parents = <&clock_peric PERIC_EQOS_PHYRXCLK>;
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


