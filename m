Return-Path: <netdev+bounces-134714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41499AE84
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6771CB232EB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891E1D1F7F;
	Fri, 11 Oct 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dQZELpVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CC1D1F44
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684559; cv=none; b=J8ZAFd82BRQl2KFdODsHqh5ygw+h5z8u3KVizSqueMhINSuzJtnExE0qrcrq/5NrOQdzaY9tpHjbz/DjTNr1kMThxHUAaQljBkQCL4857yExNcA+IG/V0+6+kjiB3v1I7bWCZ86Ih0uxagkPeQGNub81xSEVWDryHZyxX9o7Z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684559; c=relaxed/simple;
	bh=AakWStbGg9Gq2r6p+9e4DM+/+1xCaPAUAsSwJmO54f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA/n5xnlQRS9dKjDXs+PtUMwD6tq7cuFHo5CMHTnuSMOIPb30AG8dtkztW2UpcQ+WKmmEJe/4B6KQqYxHHqgBqH2zlDbcxAqq8ZIHKodWIsOX2JaKEOyUydDKlj0H3WGjRCRIEn/0KJwQgxlcg5lrVhpaE/1Pnc4i5pKdQH29qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dQZELpVR; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684558; x=1760220558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KRn5QrX42HicQ1ybwE8gQsg6PxuOkGqkBd5sS0aIu0o=;
  b=dQZELpVRfWOweetnTPpVVvKhMp2NctxblL72Fs68e6NgUoOc4Tj6VyjU
   /gO5UckS2TRz3TAAs7t7gpcMYEGs2VQ2vHfyfycZZjoif8Fvf6BOlrqwb
   6FPJIj67go55KO8k+KD/McMFSrSIKOGWXLY6aeZZ9P/VYJM36QMjlP4iX
   4=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="434489545"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:09:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:51936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 1762e977-9390-4364-a34b-b4ad660966c8; Fri, 11 Oct 2024 22:09:15 +0000 (UTC)
X-Farcaster-Flow-ID: 1762e977-9390-4364-a34b-b4ad660966c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:09:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:09:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Oliver Hartkopp
	<socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 net-next 10/11] can: gw: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:49 -0700
Message-ID: <20241011220550.46040-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register_module() in favour of rtnl_register_many().

rtnl_register_many() will unwind the previous successful registrations
on failure and simplify module error handling.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/gw.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..34d6b8c37b92 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1265,6 +1265,12 @@ static struct pernet_operations cangw_pernet_ops = {
 	.exit_batch = cangw_pernet_exit_batch,
 };
 
+static const struct rtnl_msg_handler cgw_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_CAN, RTM_NEWROUTE, cgw_create_job, NULL, 0},
+	{THIS_MODULE, PF_CAN, RTM_DELROUTE, cgw_remove_job, NULL, 0},
+	{THIS_MODULE, PF_CAN, RTM_GETROUTE, NULL, cgw_dump_jobs, 0},
+};
+
 static __init int cgw_module_init(void)
 {
 	int ret;
@@ -1290,27 +1296,13 @@ static __init int cgw_module_init(void)
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


