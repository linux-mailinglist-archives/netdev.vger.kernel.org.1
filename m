Return-Path: <netdev+bounces-104871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F302590EBD6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838BF1F25655
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96614C5B5;
	Wed, 19 Jun 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DSv2tlDU"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49C14D43E;
	Wed, 19 Jun 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802053; cv=none; b=OvHEQKJ8YPSInrJjyT4VkCFMC73L/DHblVrFrfITBViywCLXi3Rh5mDCHSwrIQrcih0wZ7LKY7lHhfvWMGnNM1fNSBM63BLNOkhweXq/ZglZIdhTUDK4X3QdnQUxQ9wg+nwnj3ZNTHAER12j6ayMdpnHnrSWkAcm0t3yx5BQGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802053; c=relaxed/simple;
	bh=HdX7p9Q7zec/XXxzPzYU6Kdf+r0KRsoYjUrW1Gn7LpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaZrwBWsoemBAWOrRQITw0TDLB2TbzmKyFD+VbUuUGLVVq2SMxfmb1YQrkuTQSb0e1oM0pnp61A53jRsYjYMpne5deKEduNl7yKxTpC4M8O8yCnRPyoZ6IWHLfXcT2qKPA5a3fA2jO1Co5dK5Xm4CjopyCWV4lcg27Gfnq07biY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DSv2tlDU; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JCdFrt028618;
	Wed, 19 Jun 2024 14:59:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	w65QGBULGaCNhn/1VSBB1a/kt6/SrVicqQc8LXdTK3k=; b=DSv2tlDU+i2A93aK
	VfFThKIVeFgzDlsmZHe5kD5Bqq86d1Ok8KuhNW9ZgWFa/knsba7MQvt736s0lyYk
	9oxFe4/g0otkTkZj1y6Qw+KDwWB+o/fS7q4gEd0SMAayfU3r0RKBX6PxfshV4DSj
	5vZBs8fGFg9mtjARQq/6Ej+FNMXjPYFXIlxaoHKKDZIm45g1lfKeMibKAM0koKcR
	iwYbZ1dHlOJYnP34YV152qgZP2ilxYrejcdeX7CUAw5DAIEjNH5en5EMcDYnziVE
	ncPD/fr6qLGwN70L5PrILSW9Jjo9yjxTWqRpAscDqyCsIkZw00YAslGAhL70VqAR
	ojEI5Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuja1b9jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:59:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 35EFF40044;
	Wed, 19 Jun 2024 14:59:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CAEA4218629;
	Wed, 19 Jun 2024 14:58:29 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 14:58:29 +0200
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
Subject: [PATCH v2 2/3] arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Wed, 19 Jun 2024 14:58:14 +0200
Message-ID: <20240619125815.358207-3-christophe.roullier@foss.st.com>
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

Add pinctrl entry related to ETH2 in stm32mp25-pinctrl.dtsi
ethernet2: RGMII with crystal.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 7a82896dcbf6..9b2512ad197f 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -6,6 +6,65 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	eth2_rgmii_pins_a: eth2-rgmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 7, AF10)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 8, AF10)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 9, AF10)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('C', 10, AF10)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('C', 4, AF10)>; /* ETH_RGMII_TX_CTL */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('F', 7, AF10)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('C', 6, AF10)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('C', 5, AF10)>; /* ETH_MDIO */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins4 {
+			pinmux = <STM32_PINMUX('G', 0, AF10)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 12, AF10)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('F', 9, AF10)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('C', 11, AF10)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('C', 3, AF10)>; /* ETH_RGMII_RX_CTL */
+			bias-disable;
+		};
+		pins5 {
+			pinmux = <STM32_PINMUX('F', 6, AF10)>; /* ETH_RGMII_RX_CLK */
+			bias-disable;
+		};
+	};
+
+	eth2_rgmii_sleep_pins_a: eth2-rgmii-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 7, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 8, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 9, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('C', 10, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('F', 8, ANALOG)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('F', 7, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('C', 6, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('G', 0, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 12, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('F', 9, ANALOG)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('C', 11, ANALOG)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('C', 3, ANALOG)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('F', 6, ANALOG)>; /* ETH_RGMII_RX_CLK */
+		};
+	};
+
 	i2c2_pins_a: i2c2-0 {
 		pins {
 			pinmux = <STM32_PINMUX('B', 5, AF9)>, /* I2C2_SCL */
-- 
2.25.1


