Return-Path: <netdev+bounces-141755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB69BC2ED
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFD1281193
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA262AF16;
	Tue,  5 Nov 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N8QiHRix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA502943F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772463; cv=none; b=lLpucpUfVlbKyiXeY82GilKoZivNoIpqbbZ1tTP/QBS9s+XGOPTNBbUYxOGwCmRbR3tCd3RfYn8FCRH3tcv7WACuGa3bTiuwDk0ZO3VJVt3joYlUV4VmCHSGtAF+vMKSlsZopWWbp53oSWoTRNT+K/D02Ao6hgY+8i6PA//tiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772463; c=relaxed/simple;
	bh=/RedJCVcHs4d3RdQ5yHV6gpuf9JgBC5BQM0iTW/kgAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9ioGFHDBlwZjrtub987yXKWpxkvownsPbG1/Ppn0JPYkkPPV4Rlghe8dVvLrFnymwuw7ZVCWWzfTOffr8rZcdqDorT7b3Rr3kZzCsv1m49GycfxAzmGCFGb2xC6miv7kah5day1DFA8WQOGuQjWokjOruoO5UlSSLfL8JLZ+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N8QiHRix; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772463; x=1762308463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tniIc+EZcjD0KJfjlgSHi6mjao3wbPTBeEMgd++R3E=;
  b=N8QiHRixftIe+uTEPKWOGdqt+0wagkESkk6YEbcUoAdRYkVk+cPz9szb
   uX0x+V9htDKGEsqofm+gWfLDzlEPk2pWMXgRtGIOurHRNnf/CBdHozrwg
   VkcRM8gskdJ2nKradvbQKspW49FfFKhjHEOu/xhwLbDcJiIEFu1a57Pid
   I=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="349407299"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:07:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:20568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id 6b62c84b-4b6d-4060-bb91-039edbb33d25; Tue, 5 Nov 2024 02:07:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6b62c84b-4b6d-4060-bb91-039edbb33d25
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:07:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:07:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 7/8] rtnetlink: Convert RTM_NEWLINK to per-netns RTNL.
Date: Mon, 4 Nov 2024 18:05:13 -0800
Message-ID: <20241105020514.41963-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105020514.41963-1-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now, we are ready to convert rtnl_newlink() to per-netns RTNL;
rtnl_link_ops is protected by SRCU and netns is prefetched in
rtnl_newlink().

Let's register rtnl_newlink() with RTNL_FLAG_DOIT_PERNET and
push RTNL down as rtnl_nets_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 48bd9e062550..0df0cba0a700 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -312,6 +312,26 @@ void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net)
 }
 EXPORT_SYMBOL(rtnl_nets_add);
 
+static void rtnl_nets_lock(struct rtnl_nets *rtnl_nets)
+{
+	int i;
+
+	rtnl_lock();
+
+	for (i = 0; i < rtnl_nets->len; i++)
+		__rtnl_net_lock(rtnl_nets->net[i]);
+}
+
+static void rtnl_nets_unlock(struct rtnl_nets *rtnl_nets)
+{
+	int i;
+
+	for (i = 0; i < rtnl_nets->len; i++)
+		__rtnl_net_unlock(rtnl_nets->net[i]);
+
+	rtnl_unlock();
+}
+
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
 
 static inline int rtm_msgindex(int msgtype)
@@ -3991,7 +4011,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	rtnl_nets_lock(&rtnl_nets);
 	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
+	rtnl_nets_unlock(&rtnl_nets);
 
 put_net:
 	rtnl_nets_destroy(&rtnl_nets);
@@ -6995,7 +7017,8 @@ static struct pernet_operations rtnetlink_net_ops = {
 };
 
 static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
-	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
+	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
 	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
-- 
2.39.5 (Apple Git-154)


