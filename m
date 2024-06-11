Return-Path: <netdev+bounces-102577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD0903CA2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721951C2340C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2417C200;
	Tue, 11 Jun 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lDNEEh77"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0B1E49E;
	Tue, 11 Jun 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111034; cv=none; b=e8Tk3v1WuMBe9+mVWK8vh6mkAYoJ1mft1NZAqMsXiNRevVR3AwjE6YZmarec4OCZj9c+dS0Kzc379njGNNSWqHBLH3jWSkNFeE3FRnICHKwURivf2mmhKWq2//SHS+/EVEJYNhZx3wBPmKzivR7XMawxhAU3xRRMSpYfJTHR5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111034; c=relaxed/simple;
	bh=M6GEiEWNrY9h8lLkrj6x1tk33dVGL7nb4xJaDcccsl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7Y1FQyeW22VmarX4G9rRxHuPmsD3gnls82UTIy/cVMt2azsTQMXk+5QY5jpcJAXjDWOu/6kjhxTgzQeHMq8Nm8H8no9ghzJe+lIlQoLr+Yl2J6UAh2wLRuxreYvMT4Y1U/+vXFRQHit9KGzM0oI9KsNWzfkeX5xSJlVILt0GhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lDNEEh77; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BC6XS7027887;
	Tue, 11 Jun 2024 15:03:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	eZdlrdbslQQ0mHLAASgpTYKc7mczW84tLQTLSJPBD60=; b=lDNEEh77ZoYs1etg
	YBLhB02RO0AnPAL3gXV+ac2zsRNoWZdom0315mDJNU8dOi3JHlvfxPDQHDX6cmC4
	UrS1AesSDVKaD7JqhS+0IbYOHjrMZ20yTsZVyn9OKoeVdSv2qVju9n+blITRtZZJ
	Wbd28bN4iFsPNxuKL8ZYX+e8LlkkXeVDIqdv2fUVQyUhBm4Gj8JgJ9Aw0OkDrrK+
	8LQ44u1fj7jit4uh2gBfOfBkocFbW0Ubpyyz5Xv22fszqfvidJMmuAbzOYktK8fj
	G5905yavMnwfVoAXYXlAHgZW2dMrfZDsPxCUSR0/F6CfykFW5tHd9E5Zt1DJcTY1
	DdqwfA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp2b04v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:03:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5327F4005D;
	Tue, 11 Jun 2024 15:03:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7EE03214D36;
	Tue, 11 Jun 2024 15:01:59 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 11 Jun
 2024 15:01:58 +0200
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
Subject: [PATCH v2 3/3] ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
Date: Tue, 11 Jun 2024 15:01:10 +0200
Message-ID: <20240611130110.841591-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611130110.841591-1-christophe.roullier@foss.st.com>
References: <20240611130110.841591-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01

Ethernet1: RMII with crystal
Ethernet2: RMII with no crystal, need "phy-supply" property to work,
today this property was managed by Ethernet glue, but should be present
and managed in PHY node. So I will push second Ethernet in next step.

PHYs used are SMSC (LAN8742A)

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>
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


