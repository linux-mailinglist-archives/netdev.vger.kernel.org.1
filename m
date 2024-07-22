Return-Path: <netdev+bounces-112463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818F4939412
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 21:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7CCB20ED1
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11438DD6;
	Mon, 22 Jul 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WS05OsYy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB914287
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675777; cv=none; b=Xshh1ZbZu15ki5X5WUvCT26XUIHKl0iMek+bZPjJtb01JH+p4MztAnnN9e8vwaUy9cLB8CAUdOjBNyWR9lF50OD8LtjvWiLk0lwfO7Kpt76v+S66W5BBlLe3BjJbHHmSn3YmNfEto/7aVIgyE9sxRTBiC3EDSQdMHqzhm0zdod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675777; c=relaxed/simple;
	bh=yPgiMnhqt31HMeCQSHIny6iV71fk7nKkBHS+bQaVr8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEFbFIY4j+SR3QqPeD7+8BcFqd9iXRk9rDd/otH/kAXJ8noyWjDUG3+xBn8iPbpuechUrdecElQNJxuCD2qSWuGXTAdOuND1VskiTQp1EnFOw1mzBzijjXzQmV0exsBVfie4IY4TYnNoQpN0VPZiQWnZILLJHRBXNe2wWGsDcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WS05OsYy; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721675775; x=1753211775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5XhjdPwNMb/XkgduqS3hivt5F0MEaYRbdq2YDnygYU=;
  b=WS05OsYy6belceHpVzWGkMYmPgxZa8T4FnKN9L4cGp7q+ZrM0IL0YwhX
   ay9PpnkwmZ2UQSi69s52eaJxc+tr/CGfX0QQMvRhevJJp4gn2qtiti9P6
   I4GpoVld2he5SdfKv/OwPC40fuxoB8GuRQPLzoEdsSrVlpSyjo4bX1SXE
   E=;
X-IronPort-AV: E=Sophos;i="6.09,228,1716249600"; 
   d="scan'208";a="108543708"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 19:16:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:29330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.52:2525] with esmtp (Farcaster)
 id 6cbd0530-a040-4281-8c4b-b66e77b20f92; Mon, 22 Jul 2024 19:16:13 +0000 (UTC)
X-Farcaster-Flow-ID: 6cbd0530-a040-4281-8c4b-b66e77b20f92
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 22 Jul 2024 19:16:13 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 22 Jul 2024 19:16:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: James Chapman <jchapman@katalix.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
Date: Mon, 22 Jul 2024 12:15:56 -0700
Message-ID: <20240722191556.36224-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
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

Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
net->gen->ptr[l2tp_net_id] in l2tp_core.c.

Now the leftover wastes one entry of net->gen->ptr[] in each netns.

Let's avoid the unwanted allocation.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/l2tp/l2tp_ppp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..246089b17910 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1406,8 +1406,6 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
  * L2TPv2, we dump only L2TPv2 tunnels and sessions here.
  *****************************************************************************/
 
-static unsigned int pppol2tp_net_id;
-
 #ifdef CONFIG_PROC_FS
 
 struct pppol2tp_seq_data {
@@ -1641,7 +1639,6 @@ static __net_exit void pppol2tp_exit_net(struct net *net)
 static struct pernet_operations pppol2tp_net_ops = {
 	.init = pppol2tp_init_net,
 	.exit = pppol2tp_exit_net,
-	.id   = &pppol2tp_net_id,
 };
 
 /*****************************************************************************
-- 
2.30.2


