Return-Path: <netdev+bounces-277584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKeTBmFp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960123DCD3A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249F93065F28
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5623AEF32;
	Fri, 10 Apr 2026 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzuRI1Oq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A773A7844
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855867; cv=none; b=GYI6VoSG8puO/yu8KtPhl7ir6bfW0EmNfCM5dxzEqVjrI0KowSo9Bw2aYLOAz9jB79zx/9DIAx50ojtLZYo8GqjK9ukg3oKlVxuBM0dQW12SYYXfpPwxR4UNJSBo/56ODRcnFaRSqfrIcs/mdMHJgywzvS5ndMMQ4AUl2izpMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855867; c=relaxed/simple;
	bh=gk38U09WELWZR4HFgy1B876yJ3UfXDbh5i+UntveDQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCDbnemqh6KdU6EHwp0ylByBZ7KWrq6DeEojiRHEuNKAnUVr1qL5nfS4CDXV9g1/RNXnuGV/EwWgHQWjld0kV2f7b+tI+pBxR9TK0L69S1TRGYBBpCOtoCzOccxekyaJU9U7TQB5OaybIKgJ99AeqA0v6ogCrfWFrNCvvpOoAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzuRI1Oq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c646e980bso1509579b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855866; x=1776460666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWv7c1HMNelJEJ20TdBXvirmsx0g/Itx1DloguKRdSs=;
        b=UzuRI1Oqz2VaAO6QSAtQBPWmuvvmAEnrBxMphCcBK7houw0MFMzHjXuDsMNrYz/mvf
         V/K6Xeaeihr52bXik2rleIz9vvZYMWhxKwSEGLcUeuR6936wlZcar1CGYqQIukQHWQu3
         7IUMddF5MhW2VEcrRfI+UOYy3H2XS9n7d9gW+rKx8qRYcY+On2fTLw9lQfZ3BvFQbN7g
         jLNyNR+IEfvaMWMLsHEPuldjO3YEYxfjH1+9fPdNnN9iOPSemoCS3hPW1iHrIhOSCSxE
         5wNh5VUBdFXSj7/7QeahsIuHmmh7hQC+V3OO0nEBi+/m1oIxRKNteDo2ttu8l496g5Vj
         zong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855866; x=1776460666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWv7c1HMNelJEJ20TdBXvirmsx0g/Itx1DloguKRdSs=;
        b=BUAaZxSVFytnK2Je/3fr+MPD3qJ1Syk8PTupCz/ucJs4t0zZcmdzPcwQHNA6C+8nsh
         RMDwuM8uti4cz61miz67l664p/dXAQblI/Q3WNm2Mn0HoWhlzSMiXOvMbWmTc9eCOsRK
         gsHA6AtMrGz+GDNEo7m6cwkZ71TAjyL1radKUzkMm6M9sRiY58mGIIcWU+XbXD2u9t0T
         Xo+pLb8psZvPXFBpPMEtH+O039j28yO6GuMiuqOJBPrniNbqN7OfZL0mmeHm2SFf6xQJ
         5+Vj4Lp9qn9IeLTdCJNScoNTbx0wdw5Jmk9cI/Hh98d5TNCjdT4+24Zv+jFTQREnmz3G
         RoKA==
X-Forwarded-Encrypted: i=1; AJvYcCVHs7WmAZcBlLjgnOV3WBs5ExNJHMd8TcjVU6UgQltXKMR+HMy12ADlYvq1h7TGfr8irfPgpug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1kCAXsbie8q0+nnH/9I9yiNVvgoVRMIPj3xB0335VxI7uGwB
	bngiReNGl9edA0tfiqyyr4VNkM9c9oypeSTdGJTAYAOWgfRYAUqCwA90/fpW1KmgaWY300M3jML
	ns2WCwg==
X-Received: from pfbdo17.prod.google.com ([2002:a05:6a00:4a11:b0:82c:6863:427a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:170c:b0:82c:ddbb:7db3
 with SMTP id d2e1a72fcca58-82f0c21d396mr4954734b3a.25.1775855865553; Fri, 10
 Apr 2026 14:17:45 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:04 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/15] ipmr: Free mr_table after RCU grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277584-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 960123DCD3A
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

Note that rcu_head must be placed within <4K offset and mr_table
is already 3864 bytes without rcu_head.

Fixes: b22b01867406 ("ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h |  2 ++
 net/ipv4/ipmr.c             | 51 ++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index cf3374580f74..db3f98cae4c9 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -226,6 +226,7 @@ struct mr_table_ops {
 
 /**
  * struct mr_table - a multicast routing table
+ * @rcu: used for table destruction
  * @list: entry within a list of multicast routing tables
  * @net: net where this table belongs
  * @ops: protocol specific operations
@@ -243,6 +244,7 @@ struct mr_table_ops {
  * @mroute_reg_vif_num: PIM-device vif index
  */
 struct mr_table {
+	struct rcu_head		rcu;
 	struct list_head	list;
 	possible_net_t		net;
 	struct mr_table_ops	ops;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index fa168513295d..3bf63f8ea606 100644
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
@@ -446,7 +451,7 @@ static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_lis
 			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
 			    &ipmr_dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
-	kfree(mrt);
+	kfree_rcu(mrt, rcu);
 
 	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ipmr_dev_kill_list));
 	list_splice(&ipmr_dev_kill_list, dev_kill_list);
-- 
2.53.0.1213.gd9a14994de-goog


