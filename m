Return-Path: <netdev+bounces-208566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598BB0C2BF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687E0173EB6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3122BD58E;
	Mon, 21 Jul 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f5nmHjvn"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448129E108;
	Mon, 21 Jul 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096872; cv=none; b=hfc9fzs5E/AdykevIvobucCg7O21p2x6hgWZ2anoePUQJsHXTRhuZ4pFNaoZBtcaJTtbUOWvzSCm75dmHvYt1TrSrKqjBV8W0oWbAUkwaFolF6h6Ghz1WWctn8ZRQ2SKtP2+cUgbqQHg41Pu+jtglPrYicIukgHLzv9A1VMVbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096872; c=relaxed/simple;
	bh=5zlOyseGY2a12mIH0pp7n82/QDRPL8mVnq+tTRpVY5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WA4XJatsGr3ipYt20ntLX6PkeSVlOeTExU5J7pHtdPMIUkJK+PLPExyAlFWenE7tupZKxgx/yURYBIlfJMl7iZeXJ9EkRphMD3ItJhB4tv/errA+NN+lrW0v0g/vjGZ167L++j4ptaVETKgqkL2C3R4aZiC8vIm6gxJ7RQiy0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f5nmHjvn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LB6qGI018077;
	Mon, 21 Jul 2025 13:20:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fPGrfqg8UaxEktjEHfSecm4NyduW08Yu5c4nY2o6pg8=; b=f5nmHjvn4IpzkOBS
	T9BjLS6WLAVsGTndvlbqeiKu7xeh5SADJr8xPJLXgSfi/P2ENunRwsTEZDACrdxD
	ouQqSNZPnjGvjDOFf+u6DBzYv0jNWJof5JbchdAFj4K822olnI8syeC8wnRC2h4Z
	u/C2Cwp0tFPnc6wjYWwhUdvlsLtM9da3Ihrh2NHTA3Wy6LYdZMGM/KJcyD+Os/C5
	V9pWZnJLpC2Mz9D9qnl1/EZzDHpaRZr8OwHjWtP2CsGRgAq1Ek/zw/bJnRV1kaiY
	K+4L7jMeTv2C6BQb2XjpRsq840oxFe0Slp3dCpbHvwOklXQoL/grEClMYXpU+2Er
	afmK9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4802q20mm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 13:20:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D2AAA40052;
	Mon, 21 Jul 2025 13:19:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 119277A16E0;
	Mon, 21 Jul 2025 13:17:49 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 13:17:48 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Mon, 21 Jul 2025 13:14:46 +0200
Subject: [PATCH net-next 4/4] arm: dts: st: activate ETH1 WoL from PHY on
 stm32mp135f-dk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250721-wol-smsc-phy-v1-4-89d262812dba@foss.st.com>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
In-Reply-To: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Simon
 Horman <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        Florian
 Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=731;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=5zlOyseGY2a12mIH0pp7n82/QDRPL8mVnq+tTRpVY5E=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBofiHZMUPjiV5/QfVT9gWzWZYWZtjpH9vw1Lm1Z
 fKGFiG/opGJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCaH4h2QAKCRCq90auhvHD
 KJxPDACVprDiGGi6h62GgbvAIbaolnGJjbtI3aAQUy0LzF8zbEIgUY/GruoXoMtHLOEpIYWosco
 R3udACN4dTSARxGTXGEB09/s/QQ7gsm4JnJ+pT3zGPghDKb4fZrrDkXfBjYQfUoayN8dn0HylCt
 1RsKyLZ8HNqbeqcvQSyCugjKrXUqnsMqXs/t326ToQAGXcdPKl2uy/NeiCijpFaaA/Hgclwjdsk
 9CXiEHYIrLdTZJd2PaBBlOpd3thUXZZAEwmhboqZhJKzn4j3wSLMcCkSnWZXB6JYQhoo3u1XdYb
 z+THksSe77k6vlhS809zwnHywkwT70Zfk4Wouje8pe8bvTFIlPHOafNqXcPSNdfBxQJTolTWk6i
 1QcO2iPovhd8SYHyH475smn4qm8Z9OWsPY1eKaOHsP1d+zDjIDsVoGrvhsch6XX3kHey72ksXzq
 PzHgTqYnPaXdoScj8smDS94Q8EbUpPAHGbJpsmLRb7iKEbpKk7Odx0ALbdu1S38J8IosI=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01

On this board, the ETH1 supports WoL from PHY. Add the "st,phy-wol"
property to support it.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 9764a6bfa5b428c8524a5902c10b7807dda46b3d..d746424b039013759bfbcce5193a701ff775e715 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -193,6 +193,7 @@ &ethernet1 {
 	pinctrl-names = "default", "sleep";
 	phy-mode = "rmii";
 	phy-handle = <&phy0_eth1>;
+	st,phy-wol;
 
 	mdio {
 		#address-cells = <1>;

-- 
2.35.3


