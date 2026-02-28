Return-Path: <netdev+bounces-262238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J9jM/Vpo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B01C9720
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A832307AA36
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9A2E7F17;
	Sat, 28 Feb 2026 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4UvqCfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E93D410E
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317093; cv=none; b=XoZFHpmRJDk57M+1qN3oZ+R7u3EMutP64mMc0u/OOOAtp+PcD8icAwpObNr6Fp4KrMGgppiWuqr3fZpQ3vSIf6F6fLjX7v1Uh+vIZbof5aomlmUzWE9AaNjeniOLs0hM1gzB9YR519zt8XUHZ+xv2FTz/vTzEfXIjfkg5j+vbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317093; c=relaxed/simple;
	bh=VRaHckqIqZJ2aTyDyxHZ2DwXdNK+/Ic27P6283h9mxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jKjzM1oQdyxisI7QU47FsxAIl73leyawtCnSaushZFsW+yp8q0+LUTjGLdK4sckjonBQstL4E4EJU7tnOcXNU8v4+gKo6COJwuCPlAI6NnEGT6np+o58kq7618tDpo1D/aszrCB8FmHxaHXOz1O7w0VJhZhF69qt+hy4Z2dzdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4UvqCfd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ad7e454f38so208256135ad.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317092; x=1772921892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ9sJu65P4v3aY44Hq3R5fsxRd8aT57+nJfbfAkh/hs=;
        b=L4UvqCfd17AsAWWcSFZKUr1J6UZYXCS7X3UQ3yNXgo85Ip71BvPUt2VsbT2k+5BEjz
         Mjaa+5vWskNUGk3HuRIn8bgH7CP88UUevTvFSLLSTu2Kw9yhE3ICaUyFFTj5AItn8lPj
         qUcsmYQq8aLuJdIcfynKfv0w7RUSC70TEB6pJhPky6a7v4j3xnFetFg8hlFiBTeHWfPa
         snH0SL4b80TnqlmBIa31vWpgTFqXp8+xzhCJprQPb4ckOT4Tb05fC+cQaP3ZTsO7Scy/
         0v8zpAEI79uE+GR5nwRMtZy+v+jZx/kSoL9HLpoMsDJUYhOzrigryAPnOqNpPLvUzSmc
         9XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317092; x=1772921892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ9sJu65P4v3aY44Hq3R5fsxRd8aT57+nJfbfAkh/hs=;
        b=IxrdZZkJa2x8DI69zx/AySRhrRbA68abru6y9ejuP1C1OpeB+enXj/Q+aWwwMCzLA7
         qnlDnFx3Mw/ooALtooQpg9tyixpyfyJe1drznlHNxn/xb/CfTFRW1QEmXyplfbTLGQVt
         a5eDE/BIKViwZOW9Toekl30tI31ufWR7YURAJ6dmG4KU3bVtwRpK/jUw0PSK3Z961Es+
         rOAhCtPWdUStcKc/w3ZcXuWAaJh6200n7MPVQ5IwX99UOKRvVx3QzRWAuxXymNZQ1heD
         FAXtWwUXlY+hF8hZBU11vKBesxqvQHudOSFpDuyU+tVXYr1iKlnHvsQtS97lx74//atT
         YPgg==
X-Forwarded-Encrypted: i=1; AJvYcCUbI5+7aXvWI2eXzJmiSCBFsF3+1yxgRhVl+G/5ERfmww41/ax47TacSh8ttH4hBV8mRe8m8fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzS4j7C/QPH1u+RXMqq97hCqGTU7ajkx17w4fNt0yKbCspA2+Q
	Q29o2g/vUbaUWnWXVYkde3OOjKQP+ltxFqv6I7w8AJLs21bE97uEPYbllP5Qifz4L1i7KUVzLv1
	2kC7tXw==
X-Received: from plsp11.prod.google.com ([2002:a17:902:bd0b:b0:2a8:a03b:32c7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e752:b0:2a0:9755:2e97
 with SMTP id d9443c01a7336-2ae2e3f048dmr92278755ad.15.1772317091679; Sat, 28
 Feb 2026 14:18:11 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:23 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262238-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B4B01C9720
X-Rspamd-Action: no action

ipmr_rtm_getroute() calls __ipmr_get_table(), ipmr_cache_find(),
and ipmr_fill_mroute().

The table is not removed until netns dismantle, and net->ipv4.mr_tables
is managed with RCU list API, so __ipmr_get_table() is safe under RCU.

struct mfc_cache is freed by mr_cache_put() after RCU grace period,
so we can use ipmr_cache_find() under RCU.  rcu_read_lock() around
it was just to avoid lockdep splat for rhl_for_each_entry_rcu().

ipmr_fill_mroute() calls mr_fill_mroute(), which properly uses RCU.

Let's drop RTNL for ipmr_rtm_getroute() and use RCU instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c      | 34 ++++++++++++++++++----------------
 net/ipv4/ipmr_base.c |  4 ++--
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9f2dd726affb..cb1a5e3a6296 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2680,9 +2680,9 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(in_skb->sk);
 	struct nlattr *tb[RTA_MAX + 1];
-	struct sk_buff *skb = NULL;
 	struct mfc_cache *cache;
 	struct mr_table *mrt;
+	struct sk_buff *skb;
 	__be32 src, grp;
 	u32 tableid;
 	int err;
@@ -2695,39 +2695,40 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	grp = nla_get_in_addr_default(tb[RTA_DST], 0);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
+	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
+	if (!skb) {
+		err = -ENOBUFS;
+		goto errout;
+	}
+
+	rcu_read_lock();
+
 	mrt = __ipmr_get_table(net, tableid ? tableid : RT_TABLE_DEFAULT);
 	if (!mrt) {
 		err = -ENOENT;
-		goto errout_free;
+		goto errout_unlock;
 	}
 
-	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ipmr_cache_find(mrt, src, grp);
-	rcu_read_unlock();
 	if (!cache) {
 		err = -ENOENT;
-		goto errout_free;
-	}
-
-	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
-	if (!skb) {
-		err = -ENOBUFS;
-		goto errout_free;
+		goto errout_unlock;
 	}
 
 	err = ipmr_fill_mroute(mrt, skb, NETLINK_CB(in_skb).portid,
 			       nlh->nlmsg_seq, cache,
 			       RTM_NEWROUTE, 0);
 	if (err < 0)
-		goto errout_free;
+		goto errout_unlock;
 
-	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
+	rcu_read_unlock();
 
+	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 errout:
 	return err;
 
-errout_free:
+errout_unlock:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	goto errout;
 }
@@ -3297,7 +3298,8 @@ static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_DELROUTE,
 	 .doit = ipmr_rtm_route},
 	{.protocol = RTNL_FAMILY_IPMR, .msgtype = RTM_GETROUTE,
-	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute},
+	 .doit = ipmr_rtm_getroute, .dumpit = ipmr_rtm_dumproute,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 int __init ip_mr_init(void)
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 2d62526406ca..b0fd9ffa01a2 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -223,7 +223,7 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 
 	rcu_read_lock();
 	vif_dev = rcu_dereference(mrt->vif_table[c->mfc_parent].dev);
-	if (vif_dev && nla_put_u32(skb, RTA_IIF, vif_dev->ifindex) < 0) {
+	if (vif_dev && nla_put_u32(skb, RTA_IIF, READ_ONCE(vif_dev->ifindex)) < 0) {
 		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
@@ -252,7 +252,7 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 
 			nhp->rtnh_flags = 0;
 			nhp->rtnh_hops = c->mfc_un.res.ttls[ct];
-			nhp->rtnh_ifindex = vif_dev->ifindex;
+			nhp->rtnh_ifindex = READ_ONCE(vif_dev->ifindex);
 			nhp->rtnh_len = sizeof(*nhp);
 		}
 	}
-- 
2.53.0.473.g4a7958ca14-goog


