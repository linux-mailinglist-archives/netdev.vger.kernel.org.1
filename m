Return-Path: <netdev+bounces-280603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tzu4B4iv6WkShgIAu9opvQ
	(envelope-from <netdev+bounces-280603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:35:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F944D4A6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A91CF3006817
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE537F002;
	Thu, 23 Apr 2026 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QP8d+bX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE44359A74
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922501; cv=none; b=mW2kHKj8DczYj+sYlDtEiLwD5pYQoKJhnF6PbbrgBNa+heuzfYYpuYi/eesjwf2kH/pbmRQ32v0kFnHCsMKTO+GtdPKMFsgg1XKvLvBkxjG3D2/rKzckyIe5NOfbjEU2lz4mESUL0Z7Z1jbULgdoYsMVXclcfra+Ft+LUJKzKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922501; c=relaxed/simple;
	bh=xzKPR2UpHkTX3GBEO+5e2FDlI+fn3wp1PHOAWEdQZow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N6BTBifiD1NVpdD3fZidnTsvIGyleVKdYYx1moZM3lbU8q2uhT1Rae1gTkYCwTlVVWAoy7ziwdMv+COU+ODbnqLhQgVeGFkw9AclNy2c+fm7PWmxYunedHIVO5B/lAsJPGlvj6jey34rg8Ifs9Cxs0r2GAZQdn49kCL/qISlDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QP8d+bX2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c795fa31e18so3091327a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776922499; x=1777527299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yt+Sia+cfWjYU339WHib0FV257sCkjZwuqch1IXAiJ4=;
        b=QP8d+bX2p8OeQr5QouPVHKrq8h82PiMWQFHM+VjwNyOnlG4lCSV0Qq4WnDf1pb0N9D
         tJ2b2Bmn1IvqUQdz7rK+Jp76arkFZa2kR+kGtWDaVYuaOTuRGunD7wXV77pQ9MrsN5Fc
         BPEnPN9pz4ZpLngVb5s7xrC7xN7+hC18h41eZ5x+yM8UCpKpyp/YQ5h1ZIct3Sp+Vufc
         lcXYY66EmBWIXmztbeEF6M6lLza7vxQw1A111xEAgRwfi0/KMSw3Hk/HoCBD7wWF+jcj
         klmLelAIdfs+oWCCJmgGa4AWeoaqsmnU3mcFTD9zyuFqy95CYVnd9jb4ETewS9w5WAtH
         /QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776922499; x=1777527299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yt+Sia+cfWjYU339WHib0FV257sCkjZwuqch1IXAiJ4=;
        b=tYjFK8OIBnC7pOlUsdyGroS6DrUuD4qK6eYfKPqEqgWHpGeF1BVncG16wGk80Os8hA
         cZQCQToCDHhMu1W6npq40pmqAUbDDCpefDUlxZAIYvGG+nvEgcIDperWfIDctEM0h9D5
         BP1Jh9D417Jq0iDLm41NPV/exbl8RxzYNybnbchB2wH/UPFaFkS82RvOeKGTMA+j7XlL
         dW7SsGSi4JPFaFFbz+8IVOvlJg3UEM3U2n2Jgl/uVmy52ebWwCZE43r+vrPG3feHz1GW
         cMSe2mdOHWpGcuEpzfNdY3vuHACGeV3iBVgOOTVXUjo4Lpcwu0jV3FvKBvgj/ywjylAu
         PtJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vTTrroVmH9InWFgJpyhLKI4aPP0x6FiICQyA0hCtUYTgUBWj/kR8munOb3vVQfGbNw6bV+lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqmd2noHMRAIsuZdTCseFGo88aEkDTHKyfnb79Wzhve/QNCVR
	kh7kqKelDI0ke9lfFt3/MNKqZbFytuiDFXc8rkqFvWm2ZwNG1SNGzf/hAFfSZm/F4kX+UK1MCcY
	pai604w==
X-Received: from pfgu7.prod.google.com ([2002:a05:6a00:987:b0:831:2832:b2f9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f18:b0:82a:5e9a:922e
 with SMTP id d2e1a72fcca58-82f8c94279emr30095934b3a.42.1776922498934; Wed, 22
 Apr 2026 22:34:58 -0700 (PDT)
Date: Thu, 23 Apr 2026 05:34:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423053456.4097409-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipmr: Free mr_table after RCU grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280603-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A60F944D4A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
does not check if net->ipv4.mrt is NULL.

Since default_device_exit_batch() is called after ->exit_rtnl(),
a device could receive IGMP packets and access net->ipv4.mrt
during/after ipmr_rules_exit_rtnl().

If ipmr_rules_exit_rtnl() had already cleared it and freed the
memory, the access would trigger null-ptr-deref or use-after-free.

Let's fix it by using RCU helper and free mrt after RCU grace
period.

In addition, check_net(net) is added to mroute_clean_tables()
and ipmr_cache_unresolved() to synchronise via mfc_unres_lock.
This prevents ipmr_cache_unresolved() from putting skb into
c->_c.mfc_un.unres.unresolved after mroute_clean_tables()
purges it.

For the same reason, timer_shutdown_sync() is moved after
mroute_clean_tables().

Since rhltable_destroy() holds mutex internally, rcu_work is
used, and it is placed as the first member because rcu_head
must be placed within <4K offset.  mr_table is alraedy 3864
bytes without rcu_work.

Note that IP6MR is not yet converted to ->exit_rtnl(), so this
change is not needed for now but will be.

Fixes: b22b01867406 ("ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h |   3 +
 net/ipv4/ipmr.c             | 108 +++++++++++++++++++-----------------
 net/ipv4/ipmr_base.c        |  16 ++++++
 3 files changed, 77 insertions(+), 50 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index cf3374580f74..5d75cc5b057e 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -226,6 +226,7 @@ struct mr_table_ops {
 
 /**
  * struct mr_table - a multicast routing table
+ * @work: used for table destruction
  * @list: entry within a list of multicast routing tables
  * @net: net where this table belongs
  * @ops: protocol specific operations
@@ -243,6 +244,7 @@ struct mr_table_ops {
  * @mroute_reg_vif_num: PIM-device vif index
  */
 struct mr_table {
+	struct rcu_work		work;
 	struct list_head	list;
 	possible_net_t		net;
 	struct mr_table_ops	ops;
@@ -274,6 +276,7 @@ void vif_device_init(struct vif_device *v,
 		     unsigned short flags,
 		     unsigned short get_iflink_mask);
 
+void mr_table_free(struct mr_table *mrt);
 struct mr_table *
 mr_table_alloc(struct net *net, u32 id,
 	       struct mr_table_ops *ops,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 8a08d09b4c30..2058ca860294 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -151,16 +151,6 @@ static struct mr_table *__ipmr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
-static struct mr_table *ipmr_get_table(struct net *net, u32 id)
-{
-	struct mr_table *mrt;
-
-	rcu_read_lock();
-	mrt = __ipmr_get_table(net, id);
-	rcu_read_unlock();
-	return mrt;
-}
-
 static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
 			   struct mr_table **mrt)
 {
@@ -293,7 +283,7 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 	struct mr_table *mrt, *next;
 
 	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
-		list_del(&mrt->list);
+		list_del_rcu(&mrt->list);
 		ipmr_free_table(mrt, dev_kill_list);
 	}
 }
@@ -315,28 +305,30 @@ bool ipmr_rule_default(const struct fib_rule *rule)
 }
 EXPORT_SYMBOL(ipmr_rule_default);
 #else
-#define ipmr_for_each_table(mrt, net) \
-	for (mrt = net->ipv4.mrt; mrt; mrt = NULL)
-
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
 {
 	if (!mrt)
-		return net->ipv4.mrt;
+		return rcu_dereference(net->ipv4.mrt);
 	return NULL;
 }
 
-static struct mr_table *ipmr_get_table(struct net *net, u32 id)
+static struct mr_table *__ipmr_get_table(struct net *net, u32 id)
 {
-	return net->ipv4.mrt;
+	return rcu_dereference_check(net->ipv4.mrt,
+				     lockdep_rtnl_is_held() ||
+				     !rcu_access_pointer(net->ipv4.mrt));
 }
 
-#define __ipmr_get_table ipmr_get_table
+#define ipmr_for_each_table(mrt, net)				\
+	for (mrt = __ipmr_get_table(net, 0); mrt; mrt = NULL)
 
 static int ipmr_fib_lookup(struct net *net, struct flowi4 *flp4,
 			   struct mr_table **mrt)
 {
-	*mrt = net->ipv4.mrt;
+	*mrt = rcu_dereference(net->ipv4.mrt);
+	if (!*mrt)
+		return -EAGAIN;
 	return 0;
 }
 
@@ -347,7 +339,8 @@ static int __net_init ipmr_rules_init(struct net *net)
 	mrt = ipmr_new_table(net, RT_TABLE_DEFAULT);
 	if (IS_ERR(mrt))
 		return PTR_ERR(mrt);
-	net->ipv4.mrt = mrt;
+
+	rcu_assign_pointer(net->ipv4.mrt, mrt);
 	return 0;
 }
 
@@ -358,9 +351,10 @@ static void __net_exit ipmr_rules_exit(struct net *net)
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
-	ipmr_free_table(net->ipv4.mrt, dev_kill_list);
+	struct mr_table *mrt = rcu_dereference_protected(net->ipv4.mrt, 1);
 
-	net->ipv4.mrt = NULL;
+	RCU_INIT_POINTER(net->ipv4.mrt, NULL);
+	ipmr_free_table(mrt, dev_kill_list);
 }
 
 static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -381,6 +375,17 @@ bool ipmr_rule_default(const struct fib_rule *rule)
 EXPORT_SYMBOL(ipmr_rule_default);
 #endif
 
+static struct mr_table *ipmr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ipmr_get_table(net, id);
+	rcu_read_unlock();
+
+	return mrt;
+}
+
 static inline int ipmr_hash_cmp(struct rhashtable_compare_arg *arg,
 				const void *ptr)
 {
@@ -441,12 +446,11 @@ static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_lis
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
-	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
 			    &ipmr_dev_kill_list);
-	rhltable_destroy(&mrt->mfc_hash);
-	kfree(mrt);
+	timer_shutdown_sync(&mrt->ipmr_expire_timer);
+	mr_table_free(mrt);
 
 	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ipmr_dev_kill_list));
 	list_splice(&ipmr_dev_kill_list, dev_kill_list);
@@ -1135,12 +1139,19 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 				 struct sk_buff *skb, struct net_device *dev)
 {
+	struct net *net = read_pnet(&mrt->net);
 	const struct iphdr *iph = ip_hdr(skb);
-	struct mfc_cache *c;
+	struct mfc_cache *c = NULL;
 	bool found = false;
 	int err;
 
 	spin_lock_bh(&mfc_unres_lock);
+
+	if (!check_net(net)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	list_for_each_entry(c, &mrt->mfc_unres_queue, _c.list) {
 		if (c->mfc_mcastgrp == iph->daddr &&
 		    c->mfc_origin == iph->saddr) {
@@ -1153,10 +1164,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 		/* Create a new entry if allowable */
 		c = ipmr_cache_alloc_unres();
 		if (!c) {
-			spin_unlock_bh(&mfc_unres_lock);
-
-			kfree_skb(skb);
-			return -ENOBUFS;
+			err = -ENOBUFS;
+			goto err;
 		}
 
 		/* Fill in the new cache entry */
@@ -1166,17 +1175,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 
 		/* Reflect first query at mrouted. */
 		err = ipmr_cache_report(mrt, skb, vifi, IGMPMSG_NOCACHE);
-
-		if (err < 0) {
-			/* If the report failed throw the cache entry
-			   out - Brad Parker
-			 */
-			spin_unlock_bh(&mfc_unres_lock);
-
-			ipmr_cache_free(c);
-			kfree_skb(skb);
-			return err;
-		}
+		if (err < 0)
+			goto err;
 
 		atomic_inc(&mrt->cache_resolve_queue_len);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
@@ -1189,18 +1189,26 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 
 	/* See if we can append the packet */
 	if (c->_c.mfc_un.unres.unresolved.qlen > 3) {
-		kfree_skb(skb);
+		c = NULL;
 		err = -ENOBUFS;
-	} else {
-		if (dev) {
-			skb->dev = dev;
-			skb->skb_iif = dev->ifindex;
-		}
-		skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
-		err = 0;
+		goto err;
+	}
+
+	if (dev) {
+		skb->dev = dev;
+		skb->skb_iif = dev->ifindex;
 	}
 
+	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
+
 	spin_unlock_bh(&mfc_unres_lock);
+	return 0;
+
+err:
+	spin_unlock_bh(&mfc_unres_lock);
+	if (c)
+		ipmr_cache_free(c);
+	kfree_skb(skb);
 	return err;
 }
 
@@ -1346,7 +1354,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 	}
 
 	if (flags & MRT_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+		if (atomic_read(&mrt->cache_resolve_queue_len) != 0 || !check_net(net)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 37a3c144276c..3930d612c3de 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -28,6 +28,20 @@ void vif_device_init(struct vif_device *v,
 		v->link = dev->ifindex;
 }
 
+static void __mr_free_table(struct work_struct *work)
+{
+	struct mr_table *mrt = container_of(to_rcu_work(work),
+					    struct mr_table, work);
+
+	rhltable_destroy(&mrt->mfc_hash);
+	kfree(mrt);
+}
+
+void mr_table_free(struct mr_table *mrt)
+{
+	queue_rcu_work(system_unbound_wq, &mrt->work);
+}
+
 struct mr_table *
 mr_table_alloc(struct net *net, u32 id,
 	       struct mr_table_ops *ops,
@@ -50,6 +64,8 @@ mr_table_alloc(struct net *net, u32 id,
 		kfree(mrt);
 		return ERR_PTR(err);
 	}
+
+	INIT_RCU_WORK(&mrt->work, __mr_free_table);
 	INIT_LIST_HEAD(&mrt->mfc_cache_list);
 	INIT_LIST_HEAD(&mrt->mfc_unres_queue);
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog


