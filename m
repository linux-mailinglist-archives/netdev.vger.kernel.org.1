Return-Path: <netdev+bounces-262247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB+gL6dqo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:22:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D721C9772
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B2830EE0E2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497613D5228;
	Sat, 28 Feb 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKzU9cQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2403D5236
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317108; cv=none; b=GaAd0cmVERD+XmAsSSkhApUXiWJlOTUlZPpM6QA6ZItP82f67CWUzcq2pJmRmK9bjDANBYqsGPyTGjgn9IFHbJYbggYYJPCgxUkM++norzqiQiWm4kG8L6WiEZyjmE51+ZP5xqoSE399NfypDC1Px0V2Iri/8p3X8Td70Cbmdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317108; c=relaxed/simple;
	bh=EQjCDgLC0832fj4KA211ChKr/bUQLUPR/OhjsWMaecs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRTIBdWCYgMLggXwXe0O98xQuCMIRpjBJ5hyWp8lrRHtFAib8vqzcphuZPgnfDp3EGLlx8rvJIKf8s1ahAZs9uqFkflEZ/VQ8rJ3ZPK67hU88klce96ctg8PBmNQO8jIyuv7rUstZtbRXXJtG8CBITkvR3YSVED6kbJHB31NjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKzU9cQR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so3169872a91.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317106; x=1772921906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCaQzv7XkQa3JPgrgF66pCPhenhDbydvTqWJ3XkVHAM=;
        b=ZKzU9cQRJ++QVOcTIm4atzsge2HAZHsW/XkO7wkMl/Z+dWxuKyPb+6THoDvkmlbIDX
         LRed2O9qWqDz0i0a4c3c6ftH2zyimHw0F7wAhw2EDbSd26T+04DyWUlH5ICJM25oQFTy
         CKzZ0XcxgJVLtfiasK1Fc0APQJof/5HZSEM2txUBxsK9IrUq29Lyp8N5NgUbZNxlc2K+
         8ifPS1BNL9m2KFlKt/AQ8ixaY/wSzUSaPwfZavkkhPy0IcoCiS3WCYcRGr5G2a7vIeI8
         o5mnwmLLpkd0YWtXk5ykFnQvsT8Tqq1G32JounTwKgKziXQzF2AiwqtBcX3D56FcPgnj
         ZtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317106; x=1772921906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCaQzv7XkQa3JPgrgF66pCPhenhDbydvTqWJ3XkVHAM=;
        b=fKpfELRM1kB53yUwsg3I3SIksKbflQPB5pgu8qnXRb0OSBRb7zYX9NOOIIhHVARvzl
         zsiV9neYhcCPDe8JST3HiftIdswx1JKarifnsrwVFbPcxg/EI0egIc+gCXRX3do0AIiP
         DYWvhRwGKWH7u9AYlJ5EImvy59OpulwPx+OPt8dfuGujsjd2CnPTm7Z6/7VSvr2ahntF
         U6xC3qGh3Yo9PL3bYura1InAblaWAqSRMVWKqRIpPhzUtJILpHY63fYnGKs0PhPJjeR3
         bQyNFo+Lprsos/1HZoSPzVmfuvkFc9IdszhYGxSHeD727upRFz62REymhggXC7c62kLo
         DRUw==
X-Forwarded-Encrypted: i=1; AJvYcCXY2g78MkYko3JosXltZFX673MRBIYjj6A/Bd+a3c+Ilkc2dXiqMc7i2frmys9KPxmKRlhW3ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqQwXU7VJugaBX5UYkuy+dcx3/JCVP/4n8DfahsEA+OieX2lu
	yKGBJuWscAiis2t/WBqaODgfikq+eI0dkqy5SpleXTB6ZNIOsapmm5WnrohAVZTiyWU0CRu3pF2
	bG4SExg==
X-Received: from pjbkk8.prod.google.com ([2002:a17:90b:4a08:b0:354:be64:d426])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5843:b0:354:a57c:65dd
 with SMTP id 98e67ed59e1d1-35965cd0e68mr7282974a91.24.1772317106305; Sat, 28
 Feb 2026 14:18:26 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:32 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262247-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27D721C9772
X-Rspamd-Action: no action

We will no longer hold RTNL for ipmr_rtm_route() to modify the
MFC hash table.

Only __dev_get_by_index() in rtm_to_ipmr_mfcc() is the RTNL
dependant, otherwise, we just need protection for mrt->mfc_hash
and mrt->mfc_cache_list.

Let's add a new mutex for ipmr_mfc_add(), ipmr_mfc_delete(),
and mroute_clean_tables() (setsockopt(MRT_FLUSH or MRT_DONE)).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index 6ec73796d84d..d4983d8a9b2a 100644
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


