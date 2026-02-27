Return-Path: <netdev+bounces-261710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JiTKiASoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066C1B2530
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF9A53077CC6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231033343D;
	Fri, 27 Feb 2026 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4N59fSLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB355333421
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163572; cv=none; b=c7r3auIGt/ESHhF/lDaXmszUpmUhdfYxiGhH1IonIvkHsZH0Dd91LW133IWqIHaeexsXQt4Ka/mFdCXJdFCH6Ve74MYiQJC+JqlPdz4+eFlPpd1av/093ahbGQA3thXku+10zI/2cytEf0qyete/NjS9QlesXk3l813jwiVJmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163572; c=relaxed/simple;
	bh=sUITKlX+10cxH1fbitWzrhb91VnNSJeWmS+FzTjoWAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6VfzhjbNadL/jYXKmH4PhtJ5SDjfXr6PcAG592AtBMYODjiy+/0hRzH8UhhGVUQ4j8ENpDdXjm/pKQVyKfH0bmm2KWBIBWCFlhj+D63T82PEy/O4jGYU6VQFt7c1nKEjR270Enq2Hc9X2HKfSHCF/Ym5R3yFexQlSwHUh4xi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4N59fSLT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3595485abbbso937898a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163571; x=1772768371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1KPSv1Ftq0eYCEN75QjvuHLk2UMpjWbbQMHZ0QmVBo=;
        b=4N59fSLT2LTXwfJgY8IycTseaTklqSexOMWo2X7Zv3zBhitVS2696APyIpKh6a8w0k
         6Wz0pG/uBCbY6cW2XALPOjgfS0ZMqIsggv2qgcdbjMri3WIYxKF7fVz3LpRXsjbcsV2X
         c8DC6HsBOifC0VuqUK8IrbrjObedetkxmBN/PpXI0i8l6GIxmBQnFLcOHPQBZIDUbhDF
         8Oe7TFUlfvl1zNqL4GDwVi9aQv8lyOIdSyUPdgZBEPMWhS6+GR1jZJO5XiIkOQDjBAw3
         ub1I4YPawqFMgWO2U7cMh6ENXGulaScxl2MmhsrZBIkvdg4kXdw3HIMSJrSKNlLKcXOb
         nRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163571; x=1772768371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1KPSv1Ftq0eYCEN75QjvuHLk2UMpjWbbQMHZ0QmVBo=;
        b=Cof80Z3Y2fXoDV+dLLtrnor2LfF4wVODc0JOgeN8YvTja/8w4D1LhRhDiAiG3yVOEq
         RmXPacwP/a2IF7IuHqIA+umnKPa0AJHDJWtsctZ2Lbv+6AEy84I60gobfE+KxZNV4LTZ
         uhQXV1UgM9oauLxSmFM9eroX226kOKFx2irGXCaaZ+zLroUcRdRy/C1Aj8kPqc4/ho/N
         zwbeM42rZy+Ahp6JxsvUh7cC+5dQQqe8D7NSOwg0Ty8kJSNwMle5HkEgCCIeydQAMRj4
         Us3ciWkgDZ31sjx7nY8MVUL8BUPJ66WBiMiybvyJi1Xh8RaIoWaTRRz49MR0sCjqWgy4
         VbQg==
X-Forwarded-Encrypted: i=1; AJvYcCXG/AYGpN+4weONohjxViv6MXYYlKxoMMrDC94XYso3dMztog4OJAm/YmnnxBKxVQKlxPLC23w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLO2EpIe811c4ksq/COhVsggn/M3i5O7O+9mldcF2lEon2m6Kq
	IV4hb9g1E6Zsi5uXdkef11e4J0aoO+GIeMPNW6UhXRQRv6LCP77plrIa7jPCEgWpD+x7lSeXTPV
	9wmYfhg==
X-Received: from pjbnb14.prod.google.com ([2002:a17:90b:35ce:b0:359:135b:b2e7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d05:b0:359:427:3df7
 with SMTP id 98e67ed59e1d1-35965c498a9mr1406373a91.15.1772163570907; Thu, 26
 Feb 2026 19:39:30 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:37 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-15-kuniyu@google.com>
Subject: [PATCH v2 net-next 14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261710-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3066C1B2530
X-Rspamd-Action: no action

We will no longer hold RTNL for ipmr_rtm_route() to modify the
MFC hash table.

Only __dev_get_by_index() in rtm_to_ipmr_mfcc() is the RTNL
dependant, otherwise, we just need protection for mrt->mfc_hash
and mrt->mfc_cache_list.

Let's add a new mutex for ipmr_mfc_add(), ipmr_mfc_delete(),
and mroute_clean_tables() (setsockopt(MRT_FLUSH or MRT_DONE)).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/ipmr.c          | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 94dca64fec41..4c249aeaf7f1 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -281,6 +281,7 @@ struct netns_ipv4 {
 #endif
 	struct fib_notifier_ops	*ipmr_notifier_ops;
 	atomic_t		ipmr_seq;
+	struct mutex		mfc_mutex;
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 77684acc8ad4..9afaa5a3761f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1329,6 +1329,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 	/* Wipe the cache */
 	if (flags & (MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC)) {
+		mutex_lock(&net->ipv4.mfc_mutex);
+
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC_STATIC)) ||
 			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC)))
@@ -1341,6 +1343,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 			mroute_netlink_event(mrt, cache, RTM_DELROUTE);
 			mr_cache_put(c);
 		}
+
+		mutex_unlock(&net->ipv4.mfc_mutex);
 	}
 
 	if (flags & MRT_FLUSH_MFC) {
@@ -1498,12 +1502,17 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		}
 		if (parent == 0)
 			parent = mfc.mfcc_parent;
+
+		mutex_lock(&net->ipv4.mfc_mutex);
+
 		if (optname == MRT_DEL_MFC || optname == MRT_DEL_MFC_PROXY)
 			ret = ipmr_mfc_delete(mrt, &mfc, parent);
 		else
 			ret = ipmr_mfc_add(net, mrt, &mfc,
 					   sk == rtnl_dereference(mrt->mroute_sk),
 					   parent);
+
+		mutex_unlock(&net->ipv4.mfc_mutex);
 		break;
 	case MRT_FLUSH: {
 		LIST_HEAD(dev_kill_list);
@@ -2913,21 +2922,26 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
-	int ret, mrtsock, parent;
-	struct mr_table *tbl;
+	int ret, mrtsock = 0, parent;
+	struct mr_table *tbl = NULL;
 	struct mfcctl mfcc;
 
-	mrtsock = 0;
-	tbl = NULL;
 	ret = rtm_to_ipmr_mfcc(net, nlh, &mfcc, &mrtsock, &tbl, extack);
 	if (ret < 0)
 		return ret;
 
 	parent = ret ? mfcc.mfcc_parent : -1;
+
+	mutex_lock(&net->ipv4.mfc_mutex);
+
 	if (nlh->nlmsg_type == RTM_NEWROUTE)
-		return ipmr_mfc_add(net, tbl, &mfcc, mrtsock, parent);
+		ret = ipmr_mfc_add(net, tbl, &mfcc, mrtsock, parent);
 	else
-		return ipmr_mfc_delete(tbl, &mfcc, parent);
+		ret = ipmr_mfc_delete(tbl, &mfcc, parent);
+
+	mutex_unlock(&net->ipv4.mfc_mutex);
+
+	return ret;
 }
 
 static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
@@ -3269,6 +3283,8 @@ static int __net_init ipmr_net_init(struct net *net)
 	LIST_HEAD(dev_kill_list);
 	int err;
 
+	mutex_init(&net->ipv4.mfc_mutex);
+
 	err = ipmr_notifier_init(net);
 	if (err)
 		goto ipmr_notifier_fail;
-- 
2.53.0.473.g4a7958ca14-goog


