Return-Path: <netdev+bounces-238709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913CC5E07E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3531D4266E2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468532693F;
	Fri, 14 Nov 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="VvTWjdu/"
X-Original-To: netdev@vger.kernel.org
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B23324B37;
	Fri, 14 Nov 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134640; cv=none; b=GAWgBHU1t5EEfD6JjVeSXYdWuJ76ZLT44lJjDnyRzKLQW5Hc6oKEj2hviX2jWa0kw1vYLZN4poAcKFCt8s9IIXM5dJkGPH/K+0Hjm05aUavwSLx5o+BUxJGJvLP6hbAYgK0FxYJRUwwVi/pg2r0K8B0kpibrHGJpe0XMFEA4JrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134640; c=relaxed/simple;
	bh=cQ7eMejPaewNvutj2v8yiSjRQ6v7SnuGpQRvXwOm5xo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kn5bs/4DqXnHz7ugFNOMfal/ugRPoODuQR2I/cZBuWzrlI1xnIaV6aruul5CzIq3UXdghzWtMx/1+hRxlxBXOLNGwnXEBtr94Hd0DyHhTomE8FcqliZXH91atX6QUuBq2/YSmI4ummVdKXen6Zzsi01RWfCBx5F7VJpXPAJCOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=VvTWjdu/; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1763134635;
	bh=GGOj8LlQdVsREg5vvYEETdm1mSAlF0ngl/ZOJBGxSJs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=VvTWjdu/ISRuIB5RTiEqVOs9EObXaQMUjfUZ+rUocxBbF9IkSJf9REnaFueTUCgpv
	 iHleMoal6VAIn7xPHpxh4ivgeOOqmd16w9ZzQ+K5w16jYVjcSMXtNJ8LpmmaBWS7P9
	 UMUAZqHt8LvvHgoNCVIFkyVOSJkgiAkdTUmoYoK4r28sj7HDejdZMXipH0eN0bikGr
	 VlCUhAeLssrDJvSm4zsnDPrjBfz5LI2OYr/G4ZeBuMy4hRnzHP2ld0Y8DdMy743WSF
	 W20OcmTIlMJRRmGqLzl4xkwjzkLmGN93owEcSmHLSwwQlaVun4dcK9E/yOPh9dFams
	 +iDa5qDpTIW6g==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 12BD55A17B1;
	Fri, 14 Nov 2025 18:37:15 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 0863A5A1A93;
	Fri, 14 Nov 2025 18:37:13 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 14 Nov
 2025 18:36:16 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Byungho An <bh74.an@samsung.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Siva Reddy <siva.kallam@samsung.com>, Girish K S
	<ks.giri@samsung.com>, Vipul Pandya <vipul.pandya@samsung.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] net: samsung: sxgbe: handle clk_prepare_enable() failures in sxgbe_open()
Date: Fri, 14 Nov 2025 18:36:14 +0300
Message-ID: <20251114153616.3278623-1-Pavel.Zhigulin@kaspersky.com>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/14/2025 15:25:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 198109 [Nov 14 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:5.0.1,7.1.1;zhigulin-p.avp.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/14/2025 15:28:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/14/2025 2:08:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/14 12:42:00 #27925085
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

sxgbe_open() didn't check result of clk_prepare_enable() call.

Add missing check

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 75bad561b352..6b8e54391d7f 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1063,7 +1063,12 @@ static int sxgbe_open(struct net_device *dev)
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
 	int ret, queue_num;

-	clk_prepare_enable(priv->sxgbe_clk);
+	ret = clk_prepare_enable(priv->sxgbe_clk);
+	if (ret < 0) {
+		netdev_err(dev, "%s: Cannot enable clock (error: %d)\n",
+			   __func__, ret);
+		goto clk_error;
+	}

 	sxgbe_check_ether_addr(priv);

@@ -1195,6 +1200,7 @@ static int sxgbe_open(struct net_device *dev)
 phy_error:
 	clk_disable_unprepare(priv->sxgbe_clk);

+clk_error:
 	return ret;
 }

--
2.43.0


