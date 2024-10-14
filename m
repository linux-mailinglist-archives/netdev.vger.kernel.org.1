Return-Path: <netdev+bounces-135312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A591099D81C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76F01C22681
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC21CDFD2;
	Mon, 14 Oct 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j4yX2+RT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3924149C47
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937320; cv=none; b=h9vMM/0GF3WnghQCLYl9BnMrTFEMsIEURgEl3FEeFI2KbAeBQ9WEgVu2EVbPrMKT0q2csyms75kAlRqPFZ5LiiUjaWh7d/4OIfqIcNyudOh3v5/AcRp1vLzAPempiKVN03C4bdFVEV5JbiD94NZsfmJ08CqrqjirTf9am21aDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937320; c=relaxed/simple;
	bh=gpAJNfzBOZ+Op84kxQp9W7WL/Ilixmd/JWAbHi8HPQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6x0nHu2hkTL6zaNtAkwOUfkJuVXCT+6kf8vKX5Woy+xFKQi+y/xfGTPMYGyx4M+WZD/3Vh6poEWVU5+my+/5W/QxV75XjDztqW7rLAi2STYEMOF/6Q5yiFmxKR1W6aKS3gayJh5R+Dd7jWL+K5MWvVtq3RSgeKWJT4y7HNXjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j4yX2+RT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937318; x=1760473318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RILhGzyr/xs2ZbFs/Wg/td011AFjhneT2w0dh4/jpXg=;
  b=j4yX2+RT4QqGJS4tX946upmrDFm77TFPNzOJBYiV0P+0J4PsXONGW2ta
   qMAoaY6nuyg6ms6NVtkm9zvLJwrasJ4JnLGIvy60JDY5d/twNQmgjPWWh
   doKFXi8RRtVvehpd/bewAgLC4sAyZYXqLqDVbd5JnnZRkX+DC6hoHY2Ms
   E=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="440745752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:21:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:46236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id a450b907-6c79-4d2e-a16f-cd48bbd62aed; Mon, 14 Oct 2024 20:21:53 +0000 (UTC)
X-Farcaster-Flow-ID: a450b907-6c79-4d2e-a16f-cd48bbd62aed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:21:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:21:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Oliver Hartkopp
	<socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 net-next 10/11] can: gw: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:27 -0700
Message-ID: <20241014201828.91221-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register_module() in favour of rtnl_register_many().

rtnl_register_many() will unwind the previous successful registrations
on failure and simplify module error handling.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

v2:
  * Add __initconst_or_module
  * Use C99 initialisation
---
 net/can/gw.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..ef93293c1fae 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1265,6 +1265,15 @@ static struct pernet_operations cangw_pernet_ops = {
 	.exit_batch = cangw_pernet_exit_batch,
 };
 
+static const struct rtnl_msg_handler cgw_rtnl_msg_handlers[] __initconst_or_module = {
+	{.owner = THIS_MODULE, .protocol = PF_CAN, .msgtype = RTM_NEWROUTE,
+	 .doit = cgw_create_job},
+	{.owner = THIS_MODULE, .protocol = PF_CAN, .msgtype = RTM_DELROUTE,
+	 .doit = cgw_remove_job},
+	{.owner = THIS_MODULE, .protocol = PF_CAN, .msgtype = RTM_GETROUTE,
+	 .dumpit = cgw_dump_jobs},
+};
+
 static __init int cgw_module_init(void)
 {
 	int ret;
@@ -1290,27 +1299,13 @@ static __init int cgw_module_init(void)
 	if (ret)
 		goto out_register_notifier;
 
-	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_GETROUTE,
-				   NULL, cgw_dump_jobs, 0);
-	if (ret)
-		goto out_rtnl_register1;
-
-	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_NEWROUTE,
-				   cgw_create_job, NULL, 0);
-	if (ret)
-		goto out_rtnl_register2;
-	ret = rtnl_register_module(THIS_MODULE, PF_CAN, RTM_DELROUTE,
-				   cgw_remove_job, NULL, 0);
+	ret = rtnl_register_many(cgw_rtnl_msg_handlers);
 	if (ret)
-		goto out_rtnl_register3;
+		goto out_rtnl_register;
 
 	return 0;
 
-out_rtnl_register3:
-	rtnl_unregister(PF_CAN, RTM_NEWROUTE);
-out_rtnl_register2:
-	rtnl_unregister(PF_CAN, RTM_GETROUTE);
-out_rtnl_register1:
+out_rtnl_register:
 	unregister_netdevice_notifier(&notifier);
 out_register_notifier:
 	kmem_cache_destroy(cgw_cache);
-- 
2.39.5 (Apple Git-154)


