Return-Path: <netdev+bounces-261137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPRELvixn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4261A0256
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C69D30478B2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D363783CC;
	Thu, 26 Feb 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWeerSCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FB37AA86
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073423; cv=none; b=IQF0C5YhuvsM/aCl8er6Em2aByXqwifhW2LYg9y2froiCA3Lu1q2xrG8r1PUDvi0OBFzWiSQWCrt7GSd3R9zj9Q+D1CVyuizTmDherwGKpt8gFcOPVv9WKzyCawaJV5ICt6ZfBw4JF50mPClKWUPqjDXRutFTAUt9envQEvlt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073423; c=relaxed/simple;
	bh=tocxanHEU2FpK2XxVyoMm5h7aouujJk1bMtjyipOlHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FlZSBI553OJPOczogLomD1KKEgnBdI38DkzvQfIXHEgu4pgP+UzoI/5jF6SGzDwSq3F3uXUT9gYGrC9ufWd51MgnJoCY6jbeDShl5c5pve243Pd9nx/eIJXxxroFgfasSpyrDpzSp2/1E5gz/15FqI9ZHMuhOfi5vX5udtzfRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWeerSCA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3562171b56dso270506a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073421; x=1772678221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFqK36c18xhPeh/60vl5pkALokqM4wIiTUoKQSvhRNk=;
        b=VWeerSCAUtsk5FR5X+tLqU/gjFFdBvwxKmQyxK0vutzUDX2AOwN3gkTD7iLy1SOiI0
         8HUYBu5M8Y2SoqY492k42ZzmmizW7mbcQsdfxR1Xt2eGCrXUjO19MMVumbm1ZA7jPQI8
         6ANSdUs217mi2WFvcj6yYGNNVbrFpWFuaQaO6mDJaVTuQmm4c/qIowxiFQqu9BTtVOn4
         S423DvvBv/4636OP9qOExbzODSKpMsdWqYhjHw3PPo1Cccmrf6Yrb36jFES42xFc8MUC
         HbGL+JNP+vUk3wKnQ9/g1I9btsMf4jZYy24DO9XYhZzDGMAMhEXAnLXlpulAbfEtsBOm
         8pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073421; x=1772678221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFqK36c18xhPeh/60vl5pkALokqM4wIiTUoKQSvhRNk=;
        b=kKdRPVKaqLoLD1cr69KgcJgGaGSOHwl8ob5z898uoczyU0ROJJhjk3VuHVjYX/0x+I
         OrXZK9GXnbhAABbA9dMdhVmqSO0T/sanMvddm+M/T3y95T7IW5p2hFj3x8Ut2cxBhA+R
         kdFL/52y7I7dOtk76OehddoFl/EBkc3Y0tmHJ2sMpNVqO1OFL1Bs3zLfLvgageqhHsnw
         BzOo8FYaaZgKNxnlHR6UP1EX/XMAfjqiQXcacExEZfoiG9fW3WOT4dEo0fww5CEDJ3tw
         wCJm/1d5xm9wTDgeFrx79FCjfLDaEX0u8hWPwzn4uUbktvw0hnf3/9H0a9lBmnI5xybV
         jlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV23XzBchaN/UkeJZBJ+iEiNzHQ7FgUqsppb6j4gAnKX9a9+waPIi8HRn7jNBBL8jqFMon0GK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBOqaxSKCzwjic11KpFEA25W642z/LTsqO85FWlXrO1micq9R
	4z6cEwTBx+Lr/TmXBDHNGxrYWJrGxuwyQHxvWEWoWkSfrgPy8QA6Q05pbI1TCnTLg5qWkQ/jtLx
	4nzxWWA==
X-Received: from pgbcu9.prod.google.com ([2002:a05:6a02:2189:b0:c64:8fdc:63f7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431f:b0:366:18b3:85c3
 with SMTP id adf61e73a8af0-39545e54317mr18382401637.1.1772073421203; Wed, 25
 Feb 2026 18:37:01 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:25 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-14-kuniyu@google.com>
Subject: [PATCH v1 net-next 13/15] ipmr/ip6mr: Convert net->ipv[46].ipmr_seq
 to atomic_t.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261137-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F4261A0256
X-Rspamd-Action: no action

We will no longer hold RTNL for ipmr_mfc_add() and ipmr_mfc_delete().

MFC entry can be loosely connected with VIF by its index for
mrt->vif_table[] (stored in mfc_parent), but the two tables are
not synchronised.  i.e. Even if VIF 1 is removed, MFC for VIF 1
is not automatically removed.

The only field that the MFC/VIF interfaces share is
net->ipv[46].ipmr_seq, which is protected by RTNL.

Adding a new mutex for both just to protect a single field is overkill.

Let's convert the field to atomic_t.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h | 8 ++++----
 include/net/netns/ipv4.h    | 2 +-
 include/net/netns/ipv6.h    | 2 +-
 net/ipv4/ipmr.c             | 4 ++--
 net/ipv6/ip6mr.c            | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 0075f6e5c3da..0baa6f994da9 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -76,7 +76,7 @@ static inline int mr_call_vif_notifiers(struct net *net,
 					struct vif_device *vif,
 					struct net_device *vif_dev,
 					unsigned short vif_index, u32 tb_id,
-					unsigned int *ipmr_seq)
+					atomic_t *ipmr_seq)
 {
 	struct vif_entry_notifier_info info = {
 		.info = {
@@ -89,7 +89,7 @@ static inline int mr_call_vif_notifiers(struct net *net,
 	};
 
 	ASSERT_RTNL();
-	(*ipmr_seq)++;
+	atomic_inc(ipmr_seq);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
 
@@ -198,7 +198,7 @@ static inline int mr_call_mfc_notifiers(struct net *net,
 					unsigned short family,
 					enum fib_event_type event_type,
 					struct mr_mfc *mfc, u32 tb_id,
-					unsigned int *ipmr_seq)
+					atomic_t *ipmr_seq)
 {
 	struct mfc_entry_notifier_info info = {
 		.info = {
@@ -209,7 +209,7 @@ static inline int mr_call_mfc_notifiers(struct net *net,
 	};
 
 	ASSERT_RTNL();
-	(*ipmr_seq)++;
+	atomic_inc(ipmr_seq);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
 
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 380ff34c0233..94dca64fec41 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -280,7 +280,7 @@ struct netns_ipv4 {
 	struct fib_rules_ops	*mr_rules_ops;
 #endif
 	struct fib_notifier_ops	*ipmr_notifier_ops;
-	unsigned int		ipmr_seq;	/* protected by rtnl_mutex */
+	atomic_t		ipmr_seq;
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308e8f..499e4288170f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -118,7 +118,7 @@ struct netns_ipv6 {
 	struct seg6_pernet_data *seg6_data;
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
-	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		ipmr_seq;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 0dd683932d2b..bcb3f920e8c3 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3224,7 +3224,7 @@ static const struct net_protocol pim_protocol = {
 
 static unsigned int ipmr_seq_read(const struct net *net)
 {
-	return READ_ONCE(net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
+	return atomic_read(&net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
 }
 
 static int ipmr_dump(struct net *net, struct notifier_block *nb,
@@ -3245,7 +3245,7 @@ static int __net_init ipmr_notifier_init(struct net *net)
 {
 	struct fib_notifier_ops *ops;
 
-	net->ipv4.ipmr_seq = 0;
+	atomic_set(&net->ipv4.ipmr_seq, 0);
 
 	ops = fib_notifier_ops_register(&ipmr_notifier_ops_template, net);
 	if (IS_ERR(ops))
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e047a4680ab0..85010ff21c98 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1280,7 +1280,7 @@ static int ip6mr_device_event(struct notifier_block *this,
 
 static unsigned int ip6mr_seq_read(const struct net *net)
 {
-	return READ_ONCE(net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
+	return atomic_read(&net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
 }
 
 static int ip6mr_dump(struct net *net, struct notifier_block *nb,
@@ -1305,7 +1305,7 @@ static int __net_init ip6mr_notifier_init(struct net *net)
 {
 	struct fib_notifier_ops *ops;
 
-	net->ipv6.ipmr_seq = 0;
+	atomic_set(&net->ipv6.ipmr_seq, 0);
 
 	ops = fib_notifier_ops_register(&ip6mr_notifier_ops_template, net);
 	if (IS_ERR(ops))
-- 
2.53.0.414.gf7e9f6c205-goog


