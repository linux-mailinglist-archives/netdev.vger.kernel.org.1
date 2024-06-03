Return-Path: <netdev+bounces-100122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B18D7EE0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25811C2172A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729F12B16A;
	Mon,  3 Jun 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="s0xmqufi"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3984DEF;
	Mon,  3 Jun 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407065; cv=none; b=X08tSvYsmcpIrAT6CyeWZgFm4y26Zr9BKn4ud3pQh0FJyzCwFMYy6Uaf2cnkZC4LG76SQ2SWyXu7bvm1iL8DgHEFZ3cAk0TSkevf2sTuzzI2K6kI6ZdiaVUJbLhI3EDoSk9mvtQo6XH+iUfIRLcdHWSHSuTYJuGqIdyxSVFUh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407065; c=relaxed/simple;
	bh=h5mN9hSq8pgjzcyt50z4SAsjS4rmHveIiM9R54ksBvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omeZ6GPP8ycjX+ZpKcHZYzWWqhsfXal6wgQPNr8iL0KXyW7onoTWp1TH1ZC8mSEqFJcsCCixHaiRIzJlLIfuML6zWDjXgHvrTGB4UWk7LdIy9hG4iBfeIOZZnmNiDgKwxCAMWBMxT3IMxXgGp0OO6MaCk5a/QV3wYoQyg+t3Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=s0xmqufi; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45384p8a005103;
	Mon, 3 Jun 2024 11:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1Q35dkt89KWo1ea1imWMRpqWMEk/sfn0A6SfaG1T7t4=; b=s0xmqufitJxZ/a5V
	qPkeWlgd6njrUbAJPh4U3hwk7rVfvc3PdnSog+EAYSIhhEbNbqe2BxETbptGhVoK
	BVvwgDKQ/pOHTU021EzsXEQcLhq1UxfCSoC+6bQZotZzdT87AmGH/24NuYd+VDkQ
	EUGr4nd58LQPyu0iO25OF4TpF+NWJwoOfm4idMkNFm/VgjuOWLUE1lK/mbu6Jx39
	33ClRhe0EG5QlzZKtt+lECE7BR7xbXp4gpOocQZLoh5NenHuGJsasB6mJ6y9jQTu
	RvhMiMQYw4WclKWx2AqjKaFWB5HHk20lcvnv2Lgwdi0tIJnfB01NqTKc+7h1lhuE
	lrSmcg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw306020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 11:30:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E6D540049;
	Mon,  3 Jun 2024 11:30:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 53DB7216614;
	Mon,  3 Jun 2024 11:29:33 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:29:32 +0200
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
Subject: [PATCH v3 09/11] ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
Date: Mon, 3 Jun 2024 11:27:55 +0200
Message-ID: <20240603092757.71902-10-christophe.roullier@foss.st.com>
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

Those pins are used for Ethernet 1 and 2 on STM32MP13F-DK board.
ethernet1: RMII with crystal.
ethernet2: RMII without crystal.
Add analog gpio pin configuration ("sleep") to manage power mode on
stm32mp13.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 71 +++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 32c5d8a1e06ac..7f72c62da0a64 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -13,6 +13,77 @@ pins {
 		};
 	};
 
+	eth1_rmii_pins_a: eth1-rmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, AF11)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 2, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, AF11)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('C', 1, AF10)>; /* ETH_RMII_CRS_DV */
+			bias-disable;
+		};
+
+	};
+
+	eth1_rmii_sleep_pins_a: eth1-rmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RMII_REF_CLK */
+				 <STM32_PINMUX('A', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 2, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('C', 1, ANALOG)>; /* ETH_RMII_CRS_DV */
+		};
+	};
+
+	eth2_rmii_pins_a: eth2-rmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF11)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 11, AF10)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('G', 8, AF13)>, /* ETH_RMII_ETHCK */
+				 <STM32_PINMUX('F', 6, AF11)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('B', 2, AF11)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, AF10)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 4, AF11)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('E', 2, AF10)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('A', 12, AF11)>; /* ETH_RMII_CRS_DV */
+			bias-disable;
+		};
+	};
+
+	eth2_rmii_sleep_pins_a: eth2-rmii-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, ANALOG)>, /* ETH_RMII_TXD0 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* ETH_RMII_TXD1 */
+				 <STM32_PINMUX('G', 8, ANALOG)>, /* ETH_RMII_ETHCK */
+				 <STM32_PINMUX('F', 6, ANALOG)>, /* ETH_RMII_TX_EN */
+				 <STM32_PINMUX('B', 2, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 5, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('F', 4, ANALOG)>, /* ETH_RMII_RXD0 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RMII_RXD1 */
+				 <STM32_PINMUX('A', 12, ANALOG)>; /* ETH_RMII_CRS_DV */
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
-- 
2.25.1


