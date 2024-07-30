Return-Path: <netdev+bounces-114069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EB940DA9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420952864B3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7B19E7F4;
	Tue, 30 Jul 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KeBd+9iy"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB519E7E5
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331759; cv=none; b=hnJ+KnFWKRzn+o6apKzkZfGsT2VmNS6sd6uiSw+7QT5llGDC1QFS4/CvEMlEEHaI5CVZ+Fr2dpkJhk2qvK+5VBEg4MCvUcuf1AJ47XfwTcZuBAFCcL4GzRj4flyapel7pOX6eLYmRePqztSG01MK95nHPqQ0v6QtE4K2SYFOIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331759; c=relaxed/simple;
	bh=XJlfX/Cxbl7wGYmVSBOCnAU/0gd78zln6g8xLfY19VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=fxVEQgwG0YKETMeQRJQOWlx3MJwtqYIIJSilRNCb+dXwdCFTWdFoYmy6Kcwy090jBUFic+5b8O9l+/MQI93JrxWonq91rWa1IyVXK5IiIX0Fe61/izOvymk36fksPXg3T0IKVInEilMHrnl4tkVb/GQUABASvNZ8MPm0lJJb9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KeBd+9iy; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240730092915epoutp0312b21a08224b15a031f5300503499a9d~m85snpAfH1577715777epoutp03E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240730092915epoutp0312b21a08224b15a031f5300503499a9d~m85snpAfH1577715777epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722331755;
	bh=x0Y1A7InRF8vrl8GqcbCO2WSkPOfVgrttHPpaop2MQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeBd+9iydQFUm9GNlfH46a6cTYhmdN8V8D/8KIhvnq3mRQoX3LqSdokMasUpNlzar
	 y9VeKDzUWncRwc1OjioubYW0c7N9smJ+YvuyYvDXYp1Xa1jkgjLMqteojXTJWeUFHf
	 W7J0NV8Uab8O7vmLKjPnFaYc49ruiZp1xeEAh+DA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240730092914epcas5p1845e9c9930e6c9699489db235b5fb0ac~m85r_36ru2390023900epcas5p1S;
	Tue, 30 Jul 2024 09:29:14 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WY90S5vSfz4x9Q5; Tue, 30 Jul
	2024 09:29:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.6E.19863.862B8A66; Tue, 30 Jul 2024 18:29:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06~m85l0inV32395223952epcas5p1O;
	Tue, 30 Jul 2024 09:29:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240730092907epsmtrp1db888233e42037ae1ea78c458750ad04~m85lx-rqu2339923399epsmtrp1z;
	Tue, 30 Jul 2024 09:29:07 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-ff-66a8b268129c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.8D.19367.362B8A66; Tue, 30 Jul 2024 18:29:07 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730092904epsmtip2deaca156e95ad97a1d73906a62481768~m85iPufd-2110921109epsmtip2i;
	Tue, 30 Jul 2024 09:29:03 +0000 (GMT)
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
Subject: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Tue, 30 Jul 2024 14:46:47 +0530
Message-Id: <20240730091648.72322-4-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730091648.72322-1-swathi.ks@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTZxTPvbftLS41l8fwg6CDmjlhAu0s7ANlY5Po3SuSmGyOZdY7em2B
	0nZ9MJGYVXwwUIuwsPGSNQxmebmuFCyuIDAULUIhQx7JcMhopnQOeUR8IWtpcf/9zu/8fuec
	nPN9bMxvkRXMTpOpaaWMknJZ6xitv4WHR0pMhkO8B50R8PG97xA4WdXKgvaJbgw2tg+gsNJ+
	ggF/6BlgQse1KRyOd7ahsMdWg8Lb1f8yod1uxOFgq44JTX+NMOGdmU/g75crWbDU3oHCgpFp
	JqxabmLCa/pA+LDvHwRWtyzicMXZgsA7D6w4LB+0MGHPzbsYXLFacFg9qWfCxV/G8cQQ0lw3
	jpKOwhacbCufwEm9SUOa6vNZZHPN12SbZQElZztusUiduR4huzr4pONRO0aarywg5PPc8zi5
	YNqUvD4lY6eEpkS0MpSWpcpFaTJxAveDfcJdwphYHj+SHwff5IbKqEw6gZv0YXLk7jSpay/c
	0CxKqnFRyZRKxY1+a6dSrlHToRK5Sp3ApRUiqUKgiFJRmSqNTBwlo9XxfB7vjRiX8GCGpPHZ
	BK74M+zw1aJ6VIt8E1KA+LABIQBztb14AbKO7UdYEVAy9oTlCeYRsHSuCH0RHC+awNcs7a2l
	iCfRhoDmP257LSdR8FOtluVWsYitYNRwabVwAKFFQfH9IcwdYMQVDIzrHAy3yp9IAUM3Rl0J
	NptBvAoa7L5umkPEg0bTEsvT7hXQYOzE3NiH2AEu3Heu1gFEhQ84PWZgekRJoKE012vwBzO9
	Zu+sweBe4SkvFoIG3S2GB0vAxJMir/5t0DlcyXDPgBHh4OfL0R56IyixXUTdGCPWg7NPp1EP
	zwGWqjW8GSw7R7wlg0Br7ay3FQm0U8+9K9Ih4PubF5jnkE3l/7fQI0g9EkwrVJliOjVGwY+U
	0V+9OFyqPNOErD7/iGQL0mBcjupGUDbSjQA2xg3gCIdrD/lxRFT2EVopFyo1UlrVjcS4FliE
	Bb+cKnf9H5layBfE8QSxsbGCuO2xfO4GjvPkeZEfIabUdAZNK2jlmg9l+wRr0ff6Q8FFzd6P
	LX/HbzeT07PGiIUB03J4juis79EvEnblYYPa1/woFbpt5nr7Ef2eM4np/fM5N2hVuj26r8pG
	0wW+nIChh5Yte1o2kIHNzMLcY3DkVKC6wtZ0/cB8Ulme6p3skP33piOVn1JTialVlKP4UphO
	3Bg21mX+MSfOdte6jfvs4GRW3lxIU64UDA6XGIq3CiYn9TUr++yff1bXNOqsW2QHDZfuP71s
	ff24IXvxsazJMJodWGsVvXts6Qz/JQZDvOWw9tcDMeqZHR+VvR9fY+yTbOxiXx19lFXhDMrP
	4MydmOUiX85XpNuOln3r/7Q3P9CRyNsL+1M2DxmZEVyGSkLxIzClivoPKHhC9ocEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRWUwTURSGuTOdzpTYOhaqV0TQEqOSsAUebqoCiSaODxrFB6Ek0goDgmVJ
	hyISgwZQlIcqGglBQCh1oYJgpbSoQC1gAqjFBZAYhIooirhQxCUCWohv3zl//vM9HAoX63le
	VHJaJqtOU6qkfHdec4fUNyDeeCMx2PEpBP36UALQaGUzH9mHbTiqa32CoXJ7AQ9d6XxCoPGH
	b0g0ZG3BUGePHkOvdZ8JZLc3kqivWUsg49gAgRwfD6Dnd8v5qNTehqGigbcEqpyrJ9DDqpVo
	tvcTQDrTDIkWJk0AOb7eJ1FZn4VAnY8mcLRw30Ii3WgVgWZuD5GR3kxT7RDGjJ8zkUxL2TDJ
	VBk1jNFwls/c0Z9gWixOjPnS1s9ntE0GwDxoC2HGf7biTFO7EzDzeRUk4zT67BXJ3bcmsKrk
	LFYdFK5wP1z3Z5jMGFmf3VVswE6CM95FQEBBOgy2NpeCIuBOiWkzgG8qxvClYDWczr9ELLEH
	rJ1/T7pYTOdjcG5hl4v59CY4eMNMusqe9HkMNky3Y64Bp5/iML/n22LDg46G3aPz/y5RFI/e
	AG/aV7jWQloG64w/+EsCX3iz0booFtBb4PWpSXxJJoMXqp+B80BUBdwMQMJmcKlJqfEZIYGc
	MpXTpCUFxqenGsHiI/2jLOBaw1ygDWAUsAFI4VJPYdyLq4liYYLyWA6rTo9Ta1QsZwNrKJ50
	ldBPdTZBTCcpM9kjLJvBqv+nGCXwOoldu3jadiG2IDdLEhTnsTxU4bh4iJfz1C94/WjfuUm9
	f4wkLMCtjgh9J4rO21kiKBa2HS1p2DfxzRZcn+xje1zaoT+4W6SbWW4O0/iZ4u3HZcz3sInY
	9vqyCMn+nJqAP9uRNdK6S/vSqaC0/lwPf4/br4nMW/uSuqd6Mfk9lbw0clIRrJrqjlKbY2UH
	U3wtjdmXv4jLvSocXcrcdTEjCkXX9qGCPeHW/nSWjt30qjpiULJZMAvumqrVW7NfG0diahif
	ZSnOU8eja3PNEduKCwtjpmVaD51m0NtL+1XeEPEbanaHd5YXThXukNeAjQuVtzhubYWIizIk
	ylqW8aQ87rAyxB9Xc8q/GodSHTcDAAA=
X-CMS-MailID: 20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The FSD SoC contains two instances of Synopsys DWC QoS Ethernet IP, one
in FSYS0 block and other in PERIC block.

Adds device tree node for Ethernet in FSYS0 Block and enables the same for
FSD platform.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  9 ++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 56 ++++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 20 ++++++++
 3 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 8d7794642900..2c37097c709a 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -64,6 +64,15 @@
 	};
 };
 
+&ethernet_0 {
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
index 690b4ed9c29b..cc67930ebf78 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -1007,6 +1007,26 @@
 			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
 			clock-names = "ref_clk";
 		};
+
+		ethernet_0: ethernet@15300000 {
+			compatible = "tesla,fsd-ethqos";
+			reg = <0x0 0x15300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
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


