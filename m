Return-Path: <netdev+bounces-238369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E73DAC57D2B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E1345FF6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30114242D87;
	Thu, 13 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="K260DBP9"
X-Original-To: netdev@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27D23AE62;
	Thu, 13 Nov 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042272; cv=none; b=RSyk4IDJhxf2rLJRte44XzBQYvJ23tgoTvHG3aH90g9KXBo8IE7XBYfg4WVYqTtg5AvTJmL5zZu7DCTM/HHDEIdUKzEI5Tl5NN1aBSkEaw4BtIdCAX79jn3MrVyA8TsOkuAMz4P8hRpMP5dKgw8m4CF6H3XYNuEav2pwCamNQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042272; c=relaxed/simple;
	bh=TD/yy2xrXMvZ/UI+lPd7eXy664hMoisCsg3sr+ZuWmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UcxJaUy6Fci9/ygaDr+b/n4i+BrNCCigHnQmNNxvaCWIZNnQR5QObbLf0iPJc8TLwBqJGvMRDe1Si+PufFvH4VaOpxzDFsmnlsqlwdQne5Mryb9UTZ+cPrD5dKUCIY9QP0pJZEuPZB2zftTCBrsDYoJgEmjKse+nM8s+pxPpexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=K260DBP9; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1763042267;
	bh=C7sSsi1ZYZ1fTZwjIwsbLN3ukM79LfIrJOyPDTNA8ns=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=K260DBP99V+SBe1nd3wlqkVxXDoCqsHfqZkFR38at7MnC8NOcuRQz9oSQ6Fp2nzKZ
	 sjBZKjS/6svh4UnDZbjtT6NK6JG4DxmLNtk3wZCWVLma5FgT9ryDWb8+RVBs6tGF5G
	 S13wBOyPU00Ouo5hD+NTrHH4g0bfpsF3+RIo45ZOGhJoxY1GV5viEg42o3Azhh8ZvU
	 AN41ZEtmo2bsGFsAi/Wmi97w9cTGbV+CMCs8nQTVSOAx8YL6BqILZVKPuVdhDpuC0f
	 5T9hvnnvnup0LYKvogN/kkJotcqM+n7ibITVw4+fUDxWXz/EpNUknZ6nMOpwCEzujI
	 BGAuiahHria7w==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 1E2AC3E1D86;
	Thu, 13 Nov 2025 16:57:47 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 4A8E03E2663;
	Thu, 13 Nov 2025 16:57:46 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 13 Nov
 2025 16:57:45 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] net: dsa: hellcreek: fix missing error handling in LED registration
Date: Thu, 13 Nov 2025 16:57:44 +0300
Message-ID: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/13/2025 13:38:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 198054 [Nov 13 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/13/2025 13:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/13/2025 11:57:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/13 09:15:00 #27919685
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The LED setup routine registered both led_sync_good
and led_is_gm devices without checking the return
values of led_classdev_register(). If either registration
failed, the function continued silently, leaving the
driver in a partially-initialized state and leaking
a registered LED classdev.

Add proper error handling

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7d9ee2e8ff15 ("net: dsa: hellcreek: Add PTP status LEDs")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/net/dsa/hirschmann/hellcreek_ptp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek_ptp.c b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
index bfe21f9f7dcd..cb23bea9c21b 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_ptp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
@@ -376,8 +376,18 @@ static int hellcreek_led_setup(struct hellcreek *hellcreek)
 		hellcreek_set_brightness(hellcreek, STATUS_OUT_IS_GM, 1);

 	/* Register both leds */
-	led_classdev_register(hellcreek->dev, &hellcreek->led_sync_good);
-	led_classdev_register(hellcreek->dev, &hellcreek->led_is_gm);
+	ret = led_classdev_register(hellcreek->dev, &hellcreek->led_sync_good);
+	if (ret) {
+		dev_err(hellcreek->dev, "Failed to register sync_good LED\n");
+		goto out;
+	}
+
+	ret = led_classdev_register(hellcreek->dev, &hellcreek->led_is_gm);
+	if (ret) {
+		dev_err(hellcreek->dev, "Failed to register is_gm LED\n");
+		led_classdev_unregister(&hellcreek->led_sync_good);
+		goto out;
+	}

 	ret = 0;

--
2.43.0


