Return-Path: <netdev+bounces-132268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23799124F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADEC1C22658
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1571B4F12;
	Fri,  4 Oct 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cBZCMeCq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77D149C4D
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080799; cv=none; b=iwpagh4MTdab7mWMEmSX9WXreXdcC9jf5bCtJvAZgjHXkDPoPqbEOH+fNyoCX6/glbwWBVEuVn0fLW5wj6Z61C/jDYZwTNWN/MAR6vPPfuUjeuGSvJt4p6ELNZXFQlEM5ahYb6fjwalI1iiwlWctG7aDX+C/8aa7WnhlTT/oLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080799; c=relaxed/simple;
	bh=S2VSOcRVvN3Gsk3/7VdUikD+19l3pRtPYIe3LuVBEp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6IAFQqeBQefHDZnYCka3PYGyZKAnIqnTVPE6/pNbk2E4PtP7ns36LYttjzrrI2GR2mzPkYqdigDt62j80yV1Rg5VvqnHTRyp7F+oLaE5Q2Jd26LHpaVxt2F1MfAKpnuxSv1s5kFQAoRHZExAjIIE2hNpE6ZBbCYgBUunBPN4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cBZCMeCq; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080798; x=1759616798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpJoU38GA8ydQeCYt6xIyPJwSL12KRVtmYq4lB8dal0=;
  b=cBZCMeCqDLt+V++EKxDuB/n94fBA09p8UKu/SaYNcI0uTFrFcP5G8dIz
   HV5IMwHGP4Q6Al1OK0a11cEWi3sn/873Tw22kDA6Qs5rHy4eQHzq+JRHP
   VBNHeJgJ/jfsDDdNK1jPs+31bB/Ontd96as7e70BBr+MwMwW6QLJGQ9rY
   k=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="30767192"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:26:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:44002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id b10eee2e-a0ab-4e48-955b-2508dbeadecd; Fri, 4 Oct 2024 22:26:35 +0000 (UTC)
X-Farcaster-Flow-ID: b10eee2e-a0ab-4e48-955b-2508dbeadecd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:26:35 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:26:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <courmisch@gmail.com>, "Florian
 Westphal" <fw@strlen.de>
Subject: [PATCH v2 net 6/6] phonet: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 15:23:58 -0700
Message-ID: <20241004222358.79129-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004222358.79129-1-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl
message handlers"), once the first rtnl_register_module() allocated
rtnl_msg_handlers[PF_PHONET], the following calls never failed.

However, after the commit, rtnl_register_module() could fail to allocate
rtnl_msg_handlers[PF_PHONET][msgtype] and requires error handling for
each call.

Let's use rtnl_register_module_many() to handle the errors easily.

Fixes: addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message handlers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Rémi Denis-Courmont <courmisch@gmail.com>
---
Cc: Florian Westphal <fw@strlen.de>
---
 net/phonet/pn_netlink.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 7008d402499d..d39e6983926b 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -285,23 +285,16 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_module = {
+	{PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
+	{PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
+	{PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
+	{PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
+	{PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
+	{PF_PHONET, RTM_GETROUTE, NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED},
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
+	return rtnl_register_module_many(phonet_rtnl_msg_handlers);
 }
-- 
2.30.2


