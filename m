Return-Path: <netdev+bounces-146790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C59D5DB3
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9614D283F49
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399E1DE2B2;
	Fri, 22 Nov 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8G2HjGX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A81DE89E
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273378; cv=none; b=m2LtGUCQUOnxc9hsZiSuKHpQ7JYRiZB6x+zuTqmgjV4uA5GpC4ozERawwuzOCxQfZ1x9FmVTDrGVzSHK65fLA7AwB12+eYQko80tNIDHiDEnDGJxs9mAP2nzI7V1fYTWesSti5s6ujnzkua/nHxzk/8bNwPnRA0sAp7JI+31EzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273378; c=relaxed/simple;
	bh=q21V6gxjY+V7Bt1e1B5IARj+JvCSlzaKJGtphO/6VVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xvd3teLjr4ZyzeKr+yEE/E1a39B7pNj8wHQR/cihvxQ2oKmyVWPAtWMhaxiTweUjg6AQSLD7FnNvTd+sgk0fvWTNT+DprYjPQkxQfcbigyah7IhNwrDQstawYeS0zjIBcgSnOgclWGgLf6k5yptYMvv23vWFebr2uwSXzeGVMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8G2HjGX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIYb19GgEyMrL+OCiRrGI8zst9KbjSl6iyCxG1meKT0=;
	b=e8G2HjGX2+l5XUQJ0LB4hKnX+f8DKsFAYwvDIUanbcvuum29E9ePqPHqRVKpVBx1VunRXq
	COGjR/mQ9nVewXXs4ergzcoIHcbwZPVWuvhMFdlEr5w/bOWJ5QfejvgB1iv0bI1OodQdQ3
	SxzdVwxZ/lWylChLa4XkPB8NmITJBaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-hCvm8VQhOBm8wPLCk7TakQ-1; Fri,
 22 Nov 2024 06:02:50 -0500
X-MC-Unique: hCvm8VQhOBm8wPLCk7TakQ-1
X-Mimecast-MFC-AGG-ID: hCvm8VQhOBm8wPLCk7TakQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D28861955F68;
	Fri, 22 Nov 2024 11:02:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C661C19560A3;
	Fri, 22 Nov 2024 11:02:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: [PATCH net 3/3] ipmr: fix tables suspicious RCU usage
Date: Fri, 22 Nov 2024 12:02:16 +0100
Message-ID: <1c14b37b3c8803a4ebda59447561dec78cc87b5d.1732270911.git.pabeni@redhat.com>
In-Reply-To: <cover.1732270911.git.pabeni@redhat.com>
References: <cover.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Similar to the previous patch, plumb the RCU lock inside
the ipmr_get_table(), provided a lockless variant and apply
the latter in the few spots were the lock is already held.

Fixes: 709b46e8d90b ("net: Add compat ioctl support for the ipv4 multicast ioctl SIOCGETSGCNT")
Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/ipmr.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c6ad01dc8310..7fa31a604723 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -137,7 +137,7 @@ static struct mr_table *ipmr_mr_table_iter(struct net *net,
 	return ret;
 }
 
-static struct mr_table *ipmr_get_table(struct net *net, u32 id)
+static struct mr_table *__ipmr_get_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
@@ -148,6 +148,16 @@ static struct mr_table *ipmr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
+static struct mr_table *ipmr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ipmr_get_table(net, id);
+	rcu_read_unlock();
+	return mrt;
+}
+
 static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
 			   struct mr_table **mrt)
 {
@@ -189,7 +199,7 @@ static int ipmr_rule_action(struct fib_rule *rule, struct flowi *flp,
 
 	arg->table = fib_rule_get_table(rule, arg);
 
-	mrt = ipmr_get_table(rule->fr_net, arg->table);
+	mrt = __ipmr_get_table(rule->fr_net, arg->table);
 	if (!mrt)
 		return -EAGAIN;
 	res->mrt = mrt;
@@ -315,6 +325,8 @@ static struct mr_table *ipmr_get_table(struct net *net, u32 id)
 	return net->ipv4.mrt;
 }
 
+#define __ipmr_get_table ipmr_get_table
+
 static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
 			   struct mr_table **mrt)
 {
@@ -408,7 +420,7 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 	if (id != RT_TABLE_DEFAULT && id >= 1000000000)
 		return ERR_PTR(-EINVAL);
 
-	mrt = ipmr_get_table(net, id);
+	mrt = __ipmr_get_table(net, id);
 	if (mrt)
 		return mrt;
 
@@ -1383,7 +1395,7 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		goto out_unlock;
 	}
 
-	mrt = ipmr_get_table(net, raw_sk(sk)->ipmr_table ? : RT_TABLE_DEFAULT);
+	mrt = __ipmr_get_table(net, raw_sk(sk)->ipmr_table ? : RT_TABLE_DEFAULT);
 	if (!mrt) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2271,11 +2283,13 @@ int ipmr_get_route(struct net *net, struct sk_buff *skb,
 	struct mr_table *mrt;
 	int err;
 
-	mrt = ipmr_get_table(net, RT_TABLE_DEFAULT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ipmr_get_table(net, RT_TABLE_DEFAULT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
-	rcu_read_lock();
 	cache = ipmr_cache_find(mrt, saddr, daddr);
 	if (!cache && skb->dev) {
 		int vif = ipmr_find_vif(mrt, skb->dev);
@@ -2559,7 +2573,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	grp = nla_get_in_addr_default(tb[RTA_DST], 0);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
-	mrt = ipmr_get_table(net, tableid ? tableid : RT_TABLE_DEFAULT);
+	mrt = __ipmr_get_table(net, tableid ? tableid : RT_TABLE_DEFAULT);
 	if (!mrt) {
 		err = -ENOENT;
 		goto errout_free;
@@ -2613,7 +2627,7 @@ static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.table_id) {
 		struct mr_table *mrt;
 
-		mrt = ipmr_get_table(sock_net(skb->sk), filter.table_id);
+		mrt = __ipmr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
 			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IPMR)
 				return skb->len;
@@ -2721,7 +2735,7 @@ static int rtm_to_ipmr_mfcc(struct net *net, struct nlmsghdr *nlh,
 			break;
 		}
 	}
-	mrt = ipmr_get_table(net, tblid);
+	mrt = __ipmr_get_table(net, tblid);
 	if (!mrt) {
 		ret = -ENOENT;
 		goto out;
@@ -2929,13 +2943,15 @@ static void *ipmr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
-	mrt = ipmr_get_table(net, RT_TABLE_DEFAULT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ipmr_get_table(net, RT_TABLE_DEFAULT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return ERR_PTR(-ENOENT);
+	}
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
-- 
2.45.2


