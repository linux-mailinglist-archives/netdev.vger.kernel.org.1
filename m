Return-Path: <netdev+bounces-100623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CFE8FB5C9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8782860AF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB661474AD;
	Tue,  4 Jun 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Az4kcxXI"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8531442FD;
	Tue,  4 Jun 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511957; cv=none; b=MaHo2HXCQQNz0BUjBKrdXsXW6tswlsvT+/Fwac2REcjBtlmI3O0NLoz9cOsVAS26gogOQuKHxw5sLcnKEHUPOijPtcA5K6iqdpERM2eUGbNB8+WopTcdHYgn8BRg4nRzslA5QdDuKLYW4phy/ZU0XLwTm2M6zyi/v3eJkvMfhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511957; c=relaxed/simple;
	bh=7VtYYa+5NKjJlPyV4Azd8rtRm77RZ/GnKMAVrzFVyew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kbs5J2ZcWKxxucoRMOaVnEq5R/x6Wf39bx3Sllnslz6S8xHnigSp7ObhvYXH4el5PfOJXTR0FbqXar/NLvBuyGFSq1MWOpPTmCtd1X2V9WoSO/avW9xTn4cUqzztEJyhFBizjg7o85uhLRHTJjTVk9cm4qendupeAcAeWpgcZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Az4kcxXI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454DLTnd013294;
	Tue, 4 Jun 2024 16:38:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eKN5b2VWHRMDBj5Myb6iAparuZeoM5ih/xyaAqhcCLg=; b=Az4kcxXIOEIE9vUq
	diT1hUXTNqgk4ycHCSHENv+gl+7+KtiwbggXYGIe63ngPcKneY4JNR/FfBJg5EzD
	dylXdlRHu7dMfdvkmKrD8vxm90zzattTYqd8jsPinxGPGi4snsgMt0a3Ta9ywYW2
	RMuIUzO+AjQkSq6eGz/paEjubfdMVQ7yHrhgCcHbcKf7dCcYplBS4vP3GPb4YuyP
	ps9qLo8vcKhfn6IxZ3op8vpWG4DCQCzVyKtAHS+dJ5xIQJ2K3MS+utfLpDLS3XdM
	YiuvEHxRQyOUxk51W3ME158WJniZQuqBUcz86lT2SVJvhm5pQy6Z1TXb23EER05Z
	a6ofHQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw30cf73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:38:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6D8C640045;
	Tue,  4 Jun 2024 16:38:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C94E221968;
	Tue,  4 Jun 2024 16:37:42 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:37:42 +0200
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
Subject: [PATCH v4 10/11] ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
Date: Tue, 4 Jun 2024 16:35:01 +0200
Message-ID: <20240604143502.154463-11-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604143502.154463-1-christophe.roullier@foss.st.com>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01

Ethernet1: RMII with crystal
PHY used is SMSC (LAN8742A)

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 567e53ad285fa..16e91b9d812d8 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp135f-dk", "st,stm32mp135";
 
 	aliases {
+		ethernet0 = &ethernet1;
 		serial0 = &uart4;
 		serial1 = &usart1;
 		serial2 = &uart8;
@@ -141,6 +142,28 @@ &cryp {
 	status = "okay";
 };
 
+&ethernet1 {
+	status = "okay";
+	pinctrl-0 = <&eth1_rmii_pins_a>;
+	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	phy-handle = <&phy0_eth1>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0_eth1: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0007.c131";
+			reset-gpios = <&mcp23017 9 GPIO_ACTIVE_LOW>;
+			reg = <0>;
+			wakeup-source;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.25.1


