Return-Path: <netdev+bounces-184014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D8A92F48
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE967B1455
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C171C3314;
	Fri, 18 Apr 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gyjdsdM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329E20B22
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939764; cv=none; b=AiueVodMICt64zBrRltAzg0BHXFsM+xLE1yay3M/mayaJMM7J60aS7xc4kJiJ/beKPwJPY6DSNOvzK7UeQChjIEZH+RV5/UM7yuiXgM5f915rMYtmYfCrTmevJV4n4WXBrHHCPthu/bIDbz/ILVnpJsyEX7OOkkDPGYoOFj+4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939764; c=relaxed/simple;
	bh=46ZbV5hCQ2C3IQYcWlvj4z24RTUHZkuomsZBugnkowI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewCrPaO+rZKO9wnhbQrDc1tfE+q4hy2AZyuBCtvTRGu+vb4c9rRHDPcA49xk+NnQ+MZrFSL+lNBVfSfs2EF5fnyh4dY+2axQeHhTGUSSqAZYLPiEd5MLy7/rWcg8ay80promowWPE6ILCom1LXEJ9CK5zsooFCrFom2Kw2tWDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gyjdsdM4; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939764; x=1776475764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ap3bdavBH5SWCF1QTTQU941R2VkrZc8cGxeKtefcVAs=;
  b=gyjdsdM4KBEEoF63r7g+/J9os+I6CtVtHx2rTJhW6k7JmEAjwVtGFvqN
   FSkVnEhx/bAHmiXk7j0FkEkc5ff9vH9J6BjEXJsMotdXF7uaxR+SOT8gA
   jh3wbU9piQErCmHWGsTLppvBd9NXjk9YeYz5QeYlcfo04/2oPo3w6nZAi
   c=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512512129"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:29:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:36693]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.110:2525] with esmtp (Farcaster)
 id 81d20da3-a95a-41e1-b47c-ddcc533658ed; Fri, 18 Apr 2025 01:29:16 +0000 (UTC)
X-Farcaster-Flow-ID: 81d20da3-a95a-41e1-b47c-ddcc533658ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:29:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:29:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] neighbour: Move neigh_find_table() to neigh_get().
Date: Thu, 17 Apr 2025 18:26:56 -0700
Message-ID: <20250418012727.57033-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418012727.57033-1-kuniyu@amazon.com>
References: <20250418012727.57033-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

neigh_valid_get_req() calls neigh_find_table() to fetch neigh_tables[].

neigh_find_table() uses rcu_dereference_rtnl(), but RTNL actually does
not protect it at all; neigh_table_clear() can be called without RTNL
and only waits for RCU readers by synchronize_rcu().

Fortunately, there is no bug because IPv4 is built-in, IPv6 cannot be
unloaded, and DECNET was removed.

To fetch neigh_tables[] by rcu_dereference() later, let's move
neigh_find_table() from neigh_valid_get_req() to neigh_get().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1abce19040bf..b1d90696ca0c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2847,10 +2847,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 }
 
 static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
-					 struct neigh_table **tbl, void **dst,
+					 struct nlattr **tb,
 					 struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
 	int err, i;
 
@@ -2885,13 +2884,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;
 
-	*tbl = neigh_find_table(ndm->ndm_family);
-	if (!*tbl) {
-		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		err = -EAFNOSUPPORT;
-		goto err;
-	}
-
 	for (i = 0; i <= NDA_MAX; ++i) {
 		switch (i) {
 		case NDA_DST:
@@ -2900,13 +2892,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 				err = -EINVAL;
 				goto err;
 			}
-
-			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
-				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				err = -EINVAL;
-				goto err;
-			}
-			*dst = nla_data(tb[i]);
 			break;
 		default:
 			if (!tb[i])
@@ -2947,16 +2932,17 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(in_skb->sk);
 	u32 pid = NETLINK_CB(in_skb).portid;
+	struct nlattr *tb[NDA_MAX + 1];
 	struct net_device *dev = NULL;
-	struct neigh_table *tbl = NULL;
 	u32 seq = nlh->nlmsg_seq;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct sk_buff *skb;
 	struct ndmsg *ndm;
-	void *dst = NULL;
+	void *dst;
 	int err;
 
-	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	ndm = neigh_valid_get_req(nlh, tb, extack);
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
@@ -2967,6 +2953,21 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	tbl = neigh_find_table(ndm->ndm_family);
+	if (!tbl) {
+		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
+		err = -EAFNOSUPPORT;
+		goto err;
+	}
+
+	if (nla_len(tb[NDA_DST]) != (int)tbl->key_len) {
+		NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
+		err = -EINVAL;
+		goto err;
+	}
+
+	dst = nla_data(tb[NDA_DST]);
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
-- 
2.49.0


