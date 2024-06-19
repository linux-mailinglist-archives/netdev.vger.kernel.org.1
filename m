Return-Path: <netdev+bounces-104870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1590EBD2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AC51C24AC9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7E41474C3;
	Wed, 19 Jun 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FfTuwSVt"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95380144307;
	Wed, 19 Jun 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802049; cv=none; b=gL8EKhhyqrMx2cdS3sJ5LNwyaOH/dy3enkVBf9WpE3PH0YSzX5l2fYXRNGTjKvAM7vBw0dwSC+F9cm+9fqptZhkzKsdc14+1+kSb/ouj6boxEWNA8Qun7rDaUVhU1ynTzsrMkiLK63bxPBxSqxG3fGQ1SjhMrV2ir//OY9YqR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802049; c=relaxed/simple;
	bh=BKa/BZil4tJV9cfhHF1kyacuzAP7Gz0trqyfaSztpZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxlETUA0Nv5DbCp+BUNI6ihqKEwSh9bUcrrbD2ivwN+OqhjjAopDhBnv9T5Fbp8FkoGZgxrRfvwJioB7//SjPpmu2lx1rb900Z/E6Jyf1mcbxTovo2lXEkxxSLAFq31fe9HTEsFTjt5ax3rjH5uNuc/sgerMkzb2NnURElYcAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FfTuwSVt; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JCUgjH015592;
	Wed, 19 Jun 2024 14:59:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jwyneShirZyRnGXk/ujWIW15qBot5c+IWzpmXBsKWbg=; b=FfTuwSVtxZ3+gPrS
	wl9xODgA+HaNcgLArvaqJwDCcH6SjBG/30PZSjgyBTmIy6uBchukTWhXAmiwy/f7
	wO6jILno+w1UHhH7NpHC3Io6U7yL5CJYCfaQXRiqq5RWl7FviJXbKUYCVBuc9fMj
	+JFQliu0scteEldqlXXQmKTo+2AkNaODZncxg5Go5wuva95h2L4SbIJbHidukbfl
	f1IRqD6Vb/FC6hQqWpvJvYBzPmPTNsQZTkZRfXBZSyCFvyiLzLTF0sIFr23G4s0y
	2XJTJsGZLSHzCg7uMWTVG9UQ58BJIeK9UKGR0rPhSMA4iv69smHeV+UfWTMwc9sk
	IZWQ0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9s39pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:59:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 357EC4002D;
	Wed, 19 Jun 2024 14:59:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DA9121862A;
	Wed, 19 Jun 2024 14:58:31 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 14:58:30 +0200
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
Subject: [PATCH v2 3/3] arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board
Date: Wed, 19 Jun 2024 14:58:15 +0200
Message-ID: <20240619125815.358207-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619125815.358207-1-christophe.roullier@foss.st.com>
References: <20240619125815.358207-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

ETHERNET2 instance is connected to Realtek PHY in RGMII mode
Ethernet is SNSP IP with GMAC5 version.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 27b7360e5dba..058af3a51677 100644
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
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth2_rgmii_pins_a>;
+	pinctrl-1 = <&eth2_rgmii_sleep_pins_a>;
+	max-speed = <1000>;
+	phy-handle = <&phy0_eth2>;
+	phy-mode = "rgmii-id";
+	status = "okay";
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


