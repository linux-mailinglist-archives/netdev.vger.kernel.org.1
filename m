Return-Path: <netdev+bounces-172819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C1A5636D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63121895CDA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF11FFC70;
	Fri,  7 Mar 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fqI9QfDV"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CE207A11
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339060; cv=none; b=SIPN3QXT0Dgr/KF2npErmZBo1/+c3NrYGpyqI4/hyd8s8xoeHIyQTetJ/L+KKIsxhksdWELb66lTjO5KQ+I7vkQTiJHhsk/5ouwZ+iZHfkWqgXcFTu+r75seGI4K9el3yb/z93YOx+74b0qsIwFhiBluzADmJipekN0W5d3DVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339060; c=relaxed/simple;
	bh=xsdLHXSw3mdQ7eea7plNyi0z/9AFEsVX5RtC1AnHU6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=sxsZhQsuDKn0Au8MGnU3L/wgGmoQf9GiB6huPaht773+azNK+c7KebAqPWS+NQlM8gvGVpXkeF3L/3CXBP2WJBm5uNGyhtjUvz5mAFBBWlZVbc2isHfcjapORVGgqdfeu2ZxvDlpBBwVYEAVJeEyT4xd87S/WAZtb0pYy0UHO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fqI9QfDV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250307091730epoutp04a673c8a4c094e9c85076ad59e7750d0b~qeqP7gTsm2880928809epoutp04R
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250307091730epoutp04a673c8a4c094e9c85076ad59e7750d0b~qeqP7gTsm2880928809epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741339050;
	bh=S357BBwJWVMXtJUDbTDbqvLbzmfGEzzrnbOin0HIOq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqI9QfDVu/VShadPXWCZUsWGlntRT+LJ6PaZYzFH9bfGsf8Mhw0tCH2a1qXv/V2zR
	 Z8asz9GlCue7HrkREl/UoK3wJZO09S/AhM6xBWWC6pQ/o8oGmfisBoajiAHOJ3n4y7
	 3PODFSohpEZ9MjQIWI6fArcYmtqwl3TE5T6G+ZLs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250307091729epcas5p1903509984bb3dd167128e8a64594e982~qeqPTeAhR2319823198epcas5p1F;
	Fri,  7 Mar 2025 09:17:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z8LKM3ym9z4x9QF; Fri,  7 Mar
	2025 09:17:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.EF.19933.6A9BAC76; Fri,  7 Mar 2025 18:17:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250307045520epcas5p489488a0876bdea0495577d23a8b73cc7~qbFV8dWbC0309903099epcas5p4Z;
	Fri,  7 Mar 2025 04:55:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250307045520epsmtrp20418b80c64f1b0931aed2b2e8245dd57~qbFV7WQMl1515815158epsmtrp2q;
	Fri,  7 Mar 2025 04:55:20 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-74-67cab9a69457
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.D5.33707.83C7AC76; Fri,  7 Mar 2025 13:55:20 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250307045517epsmtip17a8b0a99121fdff7c6ddb3f6b5a3d0a9~qbFTwBNd71085010850epsmtip1B;
	Fri,  7 Mar 2025 04:55:17 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, linux-fsd@tesla.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, alim.akhtar@samsung.com
Cc: jayati.sahu@samsung.com, swathi.ks@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: [PATCH v8 1/2] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Fri,  7 Mar 2025 10:19:03 +0530
Message-Id: <20250307044904.59077-2-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250307044904.59077-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmuu6ynafSDdomqVg8mLeNzWLN3nNM
	FvOPnGO1uHlgJ5PFkVNLmCxezrrHZrHp8TVWi4evwi0u75rDZjHj/D4mi2MLxCwWbf3CbvHw
	wx52iyNnXjBb/N+zg93iy8ab7A4CHjtn3WX32LSqk81j85J6j74tqxg9/jXNZff4vEkugC0q
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GolhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	/NermAtOK1VM/f+AvYHxgUwXIyeHhICJxKFpi5hBbCGB3YwS7R2KXYxcQPYnRomfH74wwTk3
	Hjxkgeno/vuCFSKxk1Hiy7ZnbBDOF0aJ7sn32EGq2AQ0JK6v2M4OkhARaGOUOPa0EcxhFpjL
	JLHq4DagFg4OYYEoiVmnWEEaWARUJSY+6wI7hFfASuL3o4eMEOvkJVZvOAAW5xSwlji37y7Y
	HAmBTg6Jh90Ql0sIuEjcu36BHcIWlnh1fAuULSXx+d1eNgg7XmJ131WoHzIk7v6aCBW3lzhw
	ZQ4LyD3MApoS63fpQ4RlJaaeWscEYjML8En0/n7CBBHnldgxD8ZWlvj7+hrUSEmJbUvfQ631
	kNj6+DQzJFT6gEH0ZDH7BEa5WQgrFjAyrmKUTC0ozk1PLTYtMMpLLYdHW3J+7iZGcNLU8trB
	+PDBB71DjEwcjIcYJTiYlUR41bafShfiTUmsrEotyo8vKs1JLT7EaAoMwInMUqLJ+cC0nVcS
	b2hiaWBiZmZmYmlsZqgkztu8syVdSCA9sSQ1OzW1ILUIpo+Jg1OqgalbrdxfSUnf82fJzVmK
	Lb+kFKd/iC9YeZLzdopC0SqfVSZbNsYyZDiZcK+zDs52PHph2qdufhl7lU+rOibopLJrebWm
	OBr/SS1SLLrfUf1q+vuiObuOqveeXm0t/ovF99TnINXVTh3VrjNWCS0TE9qx66i+6Ic3570e
	z1X+dsrzZfYungPf1591KsxMrxDsXu8/PbsgoY95wtUyzSMNH/L9nl+7fqd85lO7dbKLa/gl
	M109ZW7O7t297o2B5AzHz09kmIRFrF4fMVz/M7ooMa1x2tUE2clOH6z21jBk9At/vfAlbV1d
	+5oZXoYTcnV3y51LX/JZNtv9jMkS9s0lLeznLz/7I20et/vTmcx7GkosxRmJhlrMRcWJADfJ
	qKkjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnK5Fzal0g2OHeSwezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/ZwW7xZeNNdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBbF
	ZZOSmpNZllqkb5fAlTH/9SrmgtNKFVP/P2BvYHwg08XIySEhYCLR/fcFaxcjF4eQwHZGiQed
	k9ghEpISn5qnskLYwhIr/z1nhyj6xCgxd+cfRpAEm4CGxPUV28ESIgJ9jBIbtreygDjMAsuZ
	JBYcaACrEhaIkLiz8g7YKBYBVYmJz7qYQWxeASuJ348eMkKskJdYveEAWJxTwFri3L67YGcI
	AdXMnj6XfQIj3wJGhlWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwQGtFbSDcdn6v3qHGJk4
	GA8xSnAwK4nwCm4+mS7Em5JYWZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgm
	y8TBKdXApLjgiov1ovrJ3quz1j31s53x7FjEFf1d3ooTV6Yx60w6pHM/O3Ly/KmmPtE9zy+c
	iD/2T7k2hieSMW572q4PH4sZRAWuGSuYbdycuEhpSktUS/S/8nXvjBgMj/926855qrDc2+jY
	PiuOe74LdygL3dS4vV5RcUHxFq8yCQ+mLRfOHF/adnV2e1NOotHqdvWcS03PRVMkrs++MpdD
	9Zpn5aale19ol3/8IPI55kaVLNf9oxtbFP/2TZgfY5VVKsRv4Nw+2yjAeqF4Vax8u0jsi70x
	KuwJTRKH4w980Ewodz4pe9K6JzqK++DqTPHMnyyGHblZ156K28ccKRRklO6cUyxTEjZH4Cfv
	Esaiqm4lluKMREMt5qLiRADJfjUY1wIAAA==
X-CMS-MailID: 20250307045520epcas5p489488a0876bdea0495577d23a8b73cc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250307045520epcas5p489488a0876bdea0495577d23a8b73cc7
References: <20250307044904.59077-1-swathi.ks@samsung.com>
	<CGME20250307045520epcas5p489488a0876bdea0495577d23a8b73cc7@epcas5p4.samsung.com>
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


