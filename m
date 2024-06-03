Return-Path: <netdev+bounces-100128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B498D7EF6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5633F1C211D1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963082D64;
	Mon,  3 Jun 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8WI10r5H"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDA811F8;
	Mon,  3 Jun 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407151; cv=none; b=SmkkhTAhxFOONqLO9/V4IIJ9EaYFmuMHPNthQcn/zA7hqPsceoNQZBbg74G8ie9YqXvUP7F4shKNxbZUftubDkIl4wj1ur60RjuKyGolbk0xGX4OMVOonc77yMeJVxBhmLJ8lowA8mTTcawNxkVUVlLLUuFyaNbh5lT9zbOgKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407151; c=relaxed/simple;
	bh=FNWOXSBY3itK9FOIIAK3yj6bfYlo6/Igm0OR42BMEk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MK5nFRKEnH+lwKF26kED6cA2t3oBrBwrSSjKzPQOT/biAxlIcZWI5Rsojsf5Z/aQteisEIBiyYUhD/uJuAXN/OJyz7lX1iE2f1qrHwKgl3g9RLZWes/JO/bXTHAuYFc8NHY8ubFeLzWHisaAFVfEDjgsA/hMJxENbeZ4/adbB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8WI10r5H; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45384HRH024936;
	Mon, 3 Jun 2024 11:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	su42IsDZlpnTDQYbDGMLNCOVNAXyU95Bml9CimB2Hdo=; b=8WI10r5HCY9lSaSH
	m62Rcz4QC2D5OoMT5Qko6RG+ch/KOEz2Wyrl2gSQNW5kntZf5H+sjXQDWm2WD5TP
	oplHgoT+RO0WjRyGnYL5GpBwoZGH5hOEN/gRnCnozw1vuOh3b6My4fY1ps22Vwj1
	NCPgZKojdWuQCmxItzSpztLPqGKfITzVKo43aXWC4OoSgQHE3k9l9uDbP+RoVBMB
	NGE3LUqrZ40O8r1pZtKRytV5Me+OSqQjNS6vTop/SXHObnCmAvWUyqVhoV3LoxLG
	+oZljU/bYWeBWp+zXszy+WWL99QwxP2gzmouvdqPNuHlR13dyWVAIUVuf5SDHnRZ
	le6+LQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw9164sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 11:32:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 616FB40046;
	Mon,  3 Jun 2024 11:31:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C6A1214D3A;
	Mon,  3 Jun 2024 11:30:43 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:30:43 +0200
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
Subject: [PATCH v3 10/11] ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
Date: Mon, 3 Jun 2024 11:27:56 +0200
Message-ID: <20240603092757.71902-11-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240603092757.71902-1-christophe.roullier@foss.st.com>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_06,2024-05-30_01,2024-05-17_01

Ethernet1: RMII with crystal
PHY used is SMSC (LAN8742A)

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 567e53ad285fa..cebe9b91eced9 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp135f-dk", "st,stm32mp135";
 
 	aliases {
+		ethernet0 = &ethernet1;
 		serial0 = &uart4;
 		serial1 = &usart1;
 		serial2 = &uart8;
@@ -141,6 +142,29 @@ &cryp {
 	status = "okay";
 };
 
+&ethernet1 {
+	status = "okay";
+	pinctrl-0 = <&eth1_rmii_pins_a>;
+	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	max-speed = <100>;
+	phy-handle = <&phy0_eth1>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0_eth1: ethernet-phy@0 {
+			compatible = "ethernet-phy-id0007.c131";
+			reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;
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


