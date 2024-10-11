Return-Path: <netdev+bounces-134707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB199AE7B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A3B282C13
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D621D1E63;
	Fri, 11 Oct 2024 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aZj8mcb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C471D173C
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684420; cv=none; b=DwxuwjpDu+D1ozxTBSnoe4SbhIvOjoJNa+hg3bfVoWzxPjqfZGXt9mN6YJUpOBugOKMF6hrXCSffL2xlxUteg6VTscwzPRNOHIyPxag7AZObDc8kqgOwB0cXNioxe9swrrttQfblOsmxSwBPLjxsB1RiQI+LJlue0GoNsui0NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684420; c=relaxed/simple;
	bh=/mOF0t1eci5tzVeuEWhrq1JFeIqzAiXXYTrcUIyZnUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCeUpLeCx6SHbsxI/pG1Vs2QYEjxjNZFMMx7sACUdjBTurqiqZpiaFgK+EQHsIpUbT2YmoX5WFxrge1eFTFOIxUNDYWX7z8270yRiru4ocbe5LmOVwrHHma52hKEfKyufRDu6HLIE3m0+FSP4FMn/HP3ec3IQPiciijepaTmCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aZj8mcb4; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684419; x=1760220419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OU/MJ7P4Zx9DtoYHts8liyzgmL+K2464aO0joFc4+Yk=;
  b=aZj8mcb4rc4HzWvzBzC6HNLxNVrav282S8e03z0IL6gszY2N3D70r+/6
   Lw2v1dQWsOHS0NHJSbkvJtgGXkpIbHYGFvgX0U8Jypchkpbj+Rr+siOZW
   KjmKO9EZQ9Ma6PZbkU9mTma9SM6dMSb9t5L560x99IarOjWnZcOojmavv
   E=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="430843799"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:06:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:35015]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 40bfcaf4-1476-48ac-b05d-cd6862e1547d; Fri, 11 Oct 2024 22:06:55 +0000 (UTC)
X-Farcaster-Flow-ID: 40bfcaf4-1476-48ac-b05d-cd6862e1547d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:06:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:06:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/11] neighbour: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:42 -0700
Message-ID: <20241011220550.46040-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..f6137ee80965 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3886,17 +3886,18 @@ EXPORT_SYMBOL(neigh_sysctl_unregister);
 
 #endif	/* CONFIG_SYSCTL */
 
+static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+	{NULL, PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info, 0},
+	{NULL, PF_UNSPEC, RTM_SETNEIGHTBL, neightbl_set, NULL, 0},
+};
+
 static int __init neigh_init(void)
 {
-	rtnl_register(PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
-		      RTNL_FLAG_DUMP_UNLOCKED);
-
-	rtnl_register(PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info,
-		      0);
-	rtnl_register(PF_UNSPEC, RTM_SETNEIGHTBL, neightbl_set, NULL, 0);
-
+	rtnl_register_many(neigh_rtnl_msg_handlers);
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)


