Return-Path: <netdev+bounces-104438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A290C82C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44F72899B5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86A201246;
	Tue, 18 Jun 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NeZpzrUc"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B820013D;
	Tue, 18 Jun 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703550; cv=none; b=HcFHFCjZVd9DU4hgGBqVqLiuP3b/tmAgdvl52U6ZEopPH+LjbOTS1z1omhB+M2DUgbI6EOvSDlUUJG2low2YnqpSuy6Tk2OfZVmGIOEEhJDmXpUw1j783oQWRBUVZ29WMgYszUcfxuQcFh3z7V6QoThjABTSUdVTitnzHFgPzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703550; c=relaxed/simple;
	bh=HdX7p9Q7zec/XXxzPzYU6Kdf+r0KRsoYjUrW1Gn7LpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfrA18zdS5zpPa+RQDPSVR5slVgAastofVU5xELNpG8hQ68xC4wbdHoyw7j5A2dAu90lEgrkDEmd4Rz3elZP+gFYUt+YDvdhMh9BaMbBL3KpTnapTQKKMtzpzXllS+dUiF698QunacpAI1kWjLIKbLBSVwK08J4jyw2GuKjoB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NeZpzrUc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6hfVY011275;
	Tue, 18 Jun 2024 11:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	w65QGBULGaCNhn/1VSBB1a/kt6/SrVicqQc8LXdTK3k=; b=NeZpzrUcL/QrYbdy
	iflO2+gLzMTAuw7sT2IC8mRDb48LOStKUofD5K4SWiOQSZsA8kQRmoGnRL4H0WBJ
	bXQi+xMKvdcXRnl0M5e3jq4Y0yOPlzbZ1jdbJbPNk/QLfeNVZjhAVqu55r4T6YXM
	WHdbjdtpiCj5p2gnQr0y4Ub/W176HQaseu/2JUlQTZA+VfocxvJHAX4gzy9jvnYc
	Kf5r2AMVjQcGfBRd5JRaI9R1hbSquYQMXHAhSKcwdBf7pzwbcDev+axt1WDvtni3
	5utFKNTzV2WbHGlFN85IKS9JGVLHB57+smuUUOfVf4kHUDHwWB/oZFNQ2gOy64b5
	WRlpeg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035jeea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:37:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C145740044;
	Tue, 18 Jun 2024 11:36:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F0EE2138E2;
	Tue, 18 Jun 2024 11:35:40 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 11:35:37 +0200
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
Subject: [PATCH 2/3] arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Tue, 18 Jun 2024 11:35:26 +0200
Message-ID: <20240618093527.318239-3-christophe.roullier@foss.st.com>
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


