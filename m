Return-Path: <netdev+bounces-113819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E015940023
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CA2282187
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BC618D4B3;
	Mon, 29 Jul 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tzXYZIZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176518C324
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287338; cv=none; b=EF94CUpaE1nNoqZof6D6rfzvGvD1JBCOlkEUeSOjHg9wbxg4VSZdYGVEb1AOSBeAtXEG5lQ0Yl85HTY4fH3QwsQM73No4ZlMbBbYeD3aAotuvOD7A65k6l7tAVYG8SFA7paiEXI6QBbd7MaNniayM8ZSayKNh83nSyK2qsi7DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287338; c=relaxed/simple;
	bh=7F31P6GIicRvIK11XQ84XxyG33iiZ67NuFJsBPyEMfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0Pw+OaSI7L/QunM0tTA7aNefGtpWHubA7dVXKHWrX7y4Zw/5Udf5yf6XgAIZcqX9ulziGwVZPvPOhzIBunUnz7j7nOq3R1cMOpBRr94Xg5OB7WV6XA6Z8rPKxn7x05vzOJMBvkcqtDLr6qebfI4j6lPrpDUsEI5jPxYGtM3D7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tzXYZIZV; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287333; x=1753823333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HgUq1NFA5SP76bx4qoabeVYGI26Hb8VWpMw8kagMJtQ=;
  b=tzXYZIZV7gHfjfRADw+LJ76uBa++3LNk68GqlN0P0Vmqf3Od5y3zqWt0
   v+jGzjS8Lv3/kl2vzY43wQovnAZe2Vt1097lAahVSJuNdxwdAKXNX/Y/7
   5KtP3crcy86Pi1MdOCggcos6km77phjFTw5ah/t+1jfiB2/zdOtBashY+
   w=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="745558480"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:08:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:55429]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.194:2525] with esmtp (Farcaster)
 id 9e0ec826-d127-4117-b358-bc70ecd3f49c; Mon, 29 Jul 2024 21:08:45 +0000 (UTC)
X-Farcaster-Flow-ID: 9e0ec826-d127-4117-b358-bc70ecd3f49c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:08:43 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:08:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, James Chapman <jchapman@katalix.com>
Subject: [PATCH v1 net-next 1/6] l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
Date: Mon, 29 Jul 2024 14:07:56 -0700
Message-ID: <20240729210801.16196-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729210801.16196-1-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
net->gen->ptr[l2tp_net_id] in l2tp_core.c.

Now the leftover wastes one entry of net->gen->ptr[] in each netns.

Let's avoid the unwanted allocation.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
CC: James Chapman <jchapman@katalix.com>
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


