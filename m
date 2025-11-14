Return-Path: <netdev+bounces-238687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33733C5D9A4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D096F4E2A97
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862A320A3B;
	Fri, 14 Nov 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="S6CjI91v"
X-Original-To: netdev@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB921ADA4;
	Fri, 14 Nov 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130306; cv=none; b=fw8tzxuE+kafMPSLTS7e4fSSs1sqB4nM2WYY5hnzI8km8xkBVUwSCXDybaXQ6FywP9npJ1oHGJMd1JLqjDcJKQfE71HwMbE4IKDJSHY12sp+9bfe3wtfHDXG7lWSpyPkWHjEhfbhK6N4o/jdFiihD9CPE5zs4ejvUY945bKm7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130306; c=relaxed/simple;
	bh=Jf/CdMXbd62d+wZauqYAjVsHb3RCi12OjVkVw76mHBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3NF2Z0FTJd8fgW5/IN4XIG/wIdHPQvC8LAwddfUYzxzyQqEqiXnlbSwqbseG1oME0aE2m0HTaZj6f/T1bnW10C24oVkbN/USPY97S9PTlM0wLjmOT4XOnxeMkh2ltIG45WSjLEKsJKe2WVbz3Mq+5HziNBstBHsNov684DMDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=S6CjI91v; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1763130294;
	bh=TQ9qAP1jynhq56w3FNF76wiXhRdCJQJmkcCu8hs9das=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=S6CjI91vAWRwG3S5c1FA5vp36IzbpPBJzU9drG0r20BybvNfgWjHMgpG8hHE9Fcxv
	 4uxKJ7idstligMMNamNJjVqCdEEhqczWs63qUWahgcmdAmKDkYj2zCX6f4xIZuwmgm
	 7EA10lz9kym3uWgKci4c77UfEyZ3cj9OEpLfI2w+GzajTxkb3txtlHyYpFPMhisdpJ
	 +Pwu/75k2rzYATaJTpRkbi+9XVivKmWeVvZeABPYtmIpvWjnHrZkjEvOMQvNZWWO4z
	 DgyFdyfw0K8QYe4ZHP0lNkJOVcyEQBFwKssQH4YYGGwzcFX8gKV9bySrFG4eD+DZjc
	 G7xeSsHORCZ4A==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id AABC93E5142;
	Fri, 14 Nov 2025 17:24:54 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id A41413E230B;
	Fri, 14 Nov 2025 17:24:51 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 14 Nov
 2025 17:23:52 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Inochi Amaoto
	<inochiama@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, Joe Hattori
	<joe@pf.is.s.u-tokyo.ac.jp>, Rayagond Kokatanur <rayagond@vayavyalabs.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] net: stmmac: add clk_prepare_enable() error handling
Date: Fri, 14 Nov 2025 17:23:50 +0300
Message-ID: <20251114142351.2189106-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/14/2025 14:08:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 198105 [Nov 14 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;zhigulin-p.avp.ru:7.1.1,5.0.1;kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/14/2025 14:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/14/2025 12:07:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/14 13:28:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/14 12:42:00 #27925085
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/14 13:28:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The driver previously ignored the return value of 'clk_prepare_enable()'
for both the CSR clock and the PCLK in 'stmmac_probe_config_dt()' function.

Add 'clk_prepare_enable()' return value checks.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bfab27a146ed ("stmmac: add the experimental PCI support")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
v2: Fix 'ret' value initialization after build bot notification.
v1: https://lore.kernel.org/all/20251113134009.79440-1-Pavel.Zhigulin@kaspersky.com/

 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 27bcaae07a7f..8f9eb9683d2b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -632,7 +632,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 			dev_warn(&pdev->dev, "Cannot get CSR clock\n");
 			plat->stmmac_clk = NULL;
 		}
-		clk_prepare_enable(plat->stmmac_clk);
+		rc = clk_prepare_enable(plat->stmmac_clk);
+		if (rc < 0)
+			dev_warn(&pdev->dev, "Cannot enable CSR clock: %d\n", rc);
 	}

 	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
@@ -640,7 +642,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		ret = plat->pclk;
 		goto error_pclk_get;
 	}
-	clk_prepare_enable(plat->pclk);
+	rc = clk_prepare_enable(plat->pclk);
+	if (rc < 0) {
+		ret = ERR_PTR(rc);
+		dev_err(&pdev->dev, "Cannot enable pclk: %d\n", rc);
+		goto error_pclk_get;
+	}

 	/* Fall-back to main clock in case of no PTP ref is passed */
 	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
--
2.43.0


