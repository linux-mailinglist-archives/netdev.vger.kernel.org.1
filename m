Return-Path: <netdev+bounces-104439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49890C82E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5080E1C22FB8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0320126D;
	Tue, 18 Jun 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4Zp9r0dj"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FA1D2A22;
	Tue, 18 Jun 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703565; cv=none; b=btE+346nkPrPvoNS0CAfczG3+r0ihoe+L+jL3yYC0fv/gfR9FlZWYppMgdmR52q2Bbmb9trD55lCJTTZUmL/tDwWOJlgBoXN5t0NRdWCxn5Hg4rCcYJXfhtYRaHaaq0U55dcYpetbPnDks0G6hEd5zu3pxEVEhIqkANUQm4BMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703565; c=relaxed/simple;
	bh=EvGWuSwaHDErXeyOGE9RBM6lfbCiVYj8yQAmwWnhDsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo3RNNFPjGU1oMKawYcXb33LaimhUo747Xpm6BB4tiT00jYNXLc672foKqNaBHtH67fBsCztfkvTe5fTJHLvrn0v2WJJS+E7HwxS4ePXzbawF3loZsKAh5lqgTxIsdN3KO5Mw19arhh0nBuiU3I+9e1gvyOHz/mD1R9SYnyhBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4Zp9r0dj; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6jGl4022142;
	Tue, 18 Jun 2024 11:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dcvRD59Q/QhzHEfOoMrdSAIGmaRekneKKoCazdo4mts=; b=4Zp9r0djo9UX0AY6
	VQ1WJ63YK8tcSBVJyDNj+c3tHTOnvl8RIPvEDBaU5YHzQQ42SnshEgPcNr+OnuKX
	jY1qx36y/9XJfMK1h40H6SmPOUGrRKrP+pgAbc6ya30DYxeCy7Cd2+BYaZzCJ+KG
	rXbvrDK1tOO6UvoVBmor726v+ullzgpxHk4iLF2QscSBZ4HEBdFaejqYErW7mWaM
	2paXQdzMz7DbNpKB3kxtQQ7DHxx2Y+zxCbuyVDIRhg+O7xLLlkX9qiBdcUoNQWVj
	+rAt63TT+abMmHK6EW+naY814nflm7qtqa9SHoltfLn9M/6dpyWAWzk3LCJU+Vxu
	JJLljg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1uct8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:37:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D29AE40047;
	Tue, 18 Jun 2024 11:36:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C6202138E0;
	Tue, 18 Jun 2024 11:35:39 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 11:35:38 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board
Date: Tue, 18 Jun 2024 11:35:27 +0200
Message-ID: <20240618093527.318239-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618093527.318239-1-christophe.roullier@foss.st.com>
References: <20240618093527.318239-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

ETHERNET2 instance is connected to Realtek PHY in RGMII mode
Ethernet is SNSP IP with GMAC5 version.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 27b7360e5dba..6d8bf1342e23 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -17,6 +17,7 @@ / {
 	compatible = "st,stm32mp257f-ev1", "st,stm32mp257";
 
 	aliases {
+		ethernet0 = &ethernet2;
 		serial0 = &usart2;
 	};
 
@@ -55,6 +56,29 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ethernet2 {
+	status = "okay";
+	pinctrl-0 = <&eth2_rgmii_pins_a>;
+	pinctrl-1 = <&eth2_rgmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rgmii-id";
+	max-speed = <1000>;
+	phy-handle = <&phy0_eth2>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0_eth2: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <1>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+			reset-gpios =  <&gpiog 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
 &i2c2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c2_pins_a>;
-- 
2.25.1


