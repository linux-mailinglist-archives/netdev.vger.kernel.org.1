Return-Path: <netdev+bounces-132687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D9992C5B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6721F23BE4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A31D2F70;
	Mon,  7 Oct 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MUeH+siT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7851D2785
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305262; cv=none; b=EBIdSRywjQqgigu3rBX3tKp2ff71jYTynuYa9N+cR+gY9hYpmZYwX82HJcVPy5ITManIvOzDKKq+24HQpaYi3GQ2wMxcfyjPaQZVhRONVv2PBViII3XPa+JF8kjHrq3YXgfQudzqxYjCYtlrZvvotI72SK+ymQpwLxpWOR9+g3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305262; c=relaxed/simple;
	bh=oYxEIsaP3WL2MRzRxLlA5XF+Ejl3KsZ2c6rDs+Dkq0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koLFsl4jQ9XnbnOoXeFZenxvdJEER4oenToyep5MZXI26O/gnF706h0Hnsf134J1R0h+Nc+9aKBP50HIdEQO1ShJMU0SsYXN7djV8qjDa181bxkn7r4TnAB5QKvT/zLZrO4ABHOiagNpf7apj1rTHghy+DtzhFLW/8rjH8g+epQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MUeH+siT; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728305261; x=1759841261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JUpVPW4P+4HVDp3hOfSUT6RRPyzbBGDILckMJXGmhPY=;
  b=MUeH+siT83ST4xivVnataOEqpgRIk4KrWSac1CJpYwqKMRKnI0ZXKr1M
   T2tfQGUrx/du+ajVfN1P/MO/AZqyaQBpINB/gKdFk88PAaJljY8l2gRL/
   +8zyueKTYeJConzNtUosYO5nBB8rL0WWl4/VP0NoXy9gIxr1bmyDWWa5y
   c=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="136165856"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 12:47:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:30501]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id f701fa0d-651a-460b-8276-10b243331aa5; Mon, 7 Oct 2024 12:47:38 +0000 (UTC)
X-Farcaster-Flow-ID: f701fa0d-651a-460b-8276-10b243331aa5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 12:47:38 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 12:47:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <courmisch@gmail.com>, "Florian
 Westphal" <fw@strlen.de>
Subject: [PATCH v3 net 6/6] phonet: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 05:44:59 -0700
Message-ID: <20241007124459.5727-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007124459.5727-1-kuniyu@amazon.com>
References: <20241007124459.5727-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl
message handlers"), once the first rtnl_register_module() allocated
rtnl_msg_handlers[PF_PHONET], the following calls never failed.

However, after the commit, rtnl_register_module() could fail to allocate
rtnl_msg_handlers[PF_PHONET][msgtype] and requires error handling for
each call.

Let's use rtnl_register_many() to handle the errors easily.

Fixes: addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message handlers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Rémi Denis-Courmont <courmisch@gmail.com>
---
Cc: Florian Westphal <fw@strlen.de>
---
 net/phonet/pn_netlink.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 7008d402499d..894e5c72d6bf 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -285,23 +285,17 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static const struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_module = {
+	{THIS_MODULE, PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
+	{THIS_MODULE, PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_GETROUTE, NULL, route_dumpit,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 int __init phonet_netlink_register(void)
 {
-	int err = rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWADDR,
-				       addr_doit, NULL, 0);
-	if (err)
-		return err;
-
-	/* Further rtnl_register_module() cannot fail */
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELADDR,
-			     addr_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR,
-			     NULL, getaddr_dumpit, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
-			     NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED);
-	return 0;
+	return rtnl_register_many(phonet_rtnl_msg_handlers);
 }
-- 
2.30.2


