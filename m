Return-Path: <netdev+bounces-102183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149AE901C4E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215E1F226B5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7A558B9;
	Mon, 10 Jun 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UIXy9Bv1"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E303CF5E;
	Mon, 10 Jun 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006721; cv=none; b=kEcmzYwM3OA86t0A+q0xDZ/Ta8fjv/M7MZN814e2Q/fvGwb9fmuDjwlWZZkZnrWagElyRUlYzCV8VgJCPi1oWJpTr7XmfzU05AIXSTD8GAnzp7lqmj+RsEQ+BRSKCzsKez9ZU/Bp5c0mV11hWU3gf/cVo9FePigOb1XPCyToACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006721; c=relaxed/simple;
	bh=CAZsEHdU0NPzww91Qu6WUIeqxgOXgiU+/ZYcHGvkRbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8XkI9QA5EKpBRRyeyj2pA6vm0q/3muNwollHEmTcfAIp13fy/NmNZp6UxC3F5O0fpstUu19dBIPcAWaOuPBJ5W4ex29s4osSsoE93Sr0okiTy3cY8H9S3wBMay/Ixhm6HojRHdj8KsJTCrXKJ6NwC+7rIPBG6a3nddyXHkGikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UIXy9Bv1; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A7uVe6014413;
	Mon, 10 Jun 2024 10:04:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Ptf8HKu5dQW1v+fxAxHKdjS3fgIMjFEHFw+2sP3c/zI=; b=UIXy9Bv1D9gGbswb
	F5VdqOKGD615TlsWAS0OM6WxUyynfaJmVc0dkEH5VfgPH7l/rjtO636kIX23D7gz
	sx74fTnygMGIlljHiVQk3wRbTb1Vu8jQrA7k9jx94V7JfPxiw+gbCRWS3Oaphxz0
	Ks26OrqkFgdkU5JJZ/EdKfw1gFIH9jngIMxSfprb+z7L85KYnn+y0FDXjHHlNiwM
	V7XE7L58HxQ2KilO8OmhocJHIyFnLtOE3fOk7CBJmMLSX+xf46HB5qhVrKFg6QeO
	bI+oN1+/AKfPoldxox5Q3pk9fuiF44IGhr3OMPHhUAlevWz0olTaOxHFNs8xlNHa
	8zrC8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yme6d5kp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:04:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1B54140048;
	Mon, 10 Jun 2024 10:04:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2267211970;
	Mon, 10 Jun 2024 10:03:33 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 10:03:33 +0200
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
Subject: [PATCH 3/3] ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
Date: Mon, 10 Jun 2024 10:03:09 +0200
Message-ID: <20240610080309.290444-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610080309.290444-1-christophe.roullier@foss.st.com>
References: <20240610080309.290444-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

Ethernet1: RMII with crystal
Ethernet2: RMII with no cristal, need "phy-supply" property to work,
today this property was managed by Ethernet glue, but should be present
and managed in PHY node. So I will push second Ethernet in next step.

PHYs used are SMSC (LAN8742A)

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 567e53ad285fa..cf65d09e89156 100644
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
+			reg = <0>;
+			reset-gpios = <&mcp23017 9 GPIO_ACTIVE_LOW>;
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


