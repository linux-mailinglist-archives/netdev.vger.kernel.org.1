Return-Path: <netdev+bounces-261138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AEIAc2yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:41:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E01A02C6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AEB83009CEA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39D378831;
	Thu, 26 Feb 2026 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq35HUfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FA37AA8B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073425; cv=none; b=DynBX3sXYa44SXlqloAeAkc2YHbPqLdSUht5eXPZ4DMpp0CgOyayE2WWQ+gFDRBbZp2BDeCrvtHxn24AycZSEASxtoSkZ5NBZR88pT339L6V/EuVmSz1R8MScrC+avZkWNF/4TjQlpnImoKs2KQdGq3ugnzn+8ucL0U4nmOag6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073425; c=relaxed/simple;
	bh=2gOMzdBf7KwrzGwFwx0DUmJ6TzvabBjzX8G1zjEwCgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eBcaQHi0/JN2XZbHhNA0q2dtz/N5HLBkpqI2g05uDGpCgeR2VdUciOD0WvI6kVVGiLefGVCIHmre74TH1hDxJluabP9GKHEz3XrPYBDz/7rRMzlcbukZnti4cxRz3tLYMhLx7YG6Sn3hOk02wSgb92mRUi4iMpBJSFo5HkjoEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq35HUfy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e79b4ca6so194082a91.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073423; x=1772678223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFmnhVWG5zQBiQMe/tiM5Crxo9AGgjngscemWybZynU=;
        b=kq35HUfyID3OYfYWXhuhWA7xWkZIRwRRZT2G+aGGFoGFIG788tFUIVBd8SwtLQ4Bvz
         fWlnhiCEoJC1DFVwzko+/Wai2lP/TElkKBEabdoQhUuMnpHZmJQE9CP+/YHZRCHy4Qoy
         etmXQpmFAQ2l0icmWWWavjNOD4yjnJpSYAL13UsZQmyC7EkQEsM1NDqYqRjN1tIuGcxJ
         q6HVPB5pNICuayG/WvDh9sl9iGPGHgqVVOb0ThDNwvaWBxa5SyW9dGnbYNvmzzVC+YhR
         GkAn2AFNY2Misq75x4tE2pWbT2FJeDnFq34tu2c3KWMLOst7yjCevnoxTwZ8lZ6kU+KS
         rHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073423; x=1772678223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFmnhVWG5zQBiQMe/tiM5Crxo9AGgjngscemWybZynU=;
        b=IFtIkoKzQCxhgxQbhxwUFywebVJzFS2HdE+w32O38a73hRND4nIHac3i1fGUohroBR
         2745H5Zw0ts1/MLPLbfpBzqQeiDqAoU9+2ql4rbvf3TY4+6x2M60KSuiMD833AMxn3ON
         +rUVK9bDZedG2Di8ne5NsXIrx310nI44goC9xzpHHZHbGvGSUUY/19U2pFYBVKRfNpq4
         sn/drC/Tac3EEddixUMe+OaMzF0Fi2M+NYm8Jesp/MTb4UbrGHxf5Lgg6OORZoXfV30V
         Sz9gpwE3DjuYjo5d+SDtn8Y6yeRQSlkQb2kpFXuozwraL13frvP+Ea1lKW79XKssG1bm
         jzgA==
X-Forwarded-Encrypted: i=1; AJvYcCWmXwsB9AxIgrycO+TzyiPkC4DT+yKAaBSdoETcD/WYowPrYMquQ2i7Pg+RhWogKL93bXacNQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDiXgqA3v9aJ+CA79Wox/pVW9Q4JMeaixBaLTc+d+OwjDyjCf
	qhZMT4iepKrvTFa+XuPxE+oDQcxGOkYi0KfzXDQS71Z9f8lOVn3jls5BE2nm2POESiny3igZ0+Q
	PWbtPuA==
X-Received: from pjpy7.prod.google.com ([2002:a17:90a:a407:b0:356:1fb9:8d52])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48d1:b0:354:7cc3:f3d9
 with SMTP id 98e67ed59e1d1-35928bd9689mr1872164a91.25.1772073422911; Wed, 25
 Feb 2026 18:37:02 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:26 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-15-kuniyu@google.com>
Subject: [PATCH v1 net-next 14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
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
	TAGGED_FROM(0.00)[bounces-261138-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D3E01A02C6
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
index bcb3f920e8c3..0dd7d088de50 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1327,6 +1327,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 	/* Wipe the cache */
 	if (flags & (MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC)) {
+		mutex_lock(&net->ipv4.mfc_mutex);
+
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC_STATIC)) ||
 			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC)))
@@ -1339,6 +1341,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 			mroute_netlink_event(mrt, cache, RTM_DELROUTE);
 			mr_cache_put(c);
 		}
+
+		mutex_unlock(&net->ipv4.mfc_mutex);
 	}
 
 	if (flags & MRT_FLUSH_MFC) {
@@ -1496,12 +1500,17 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
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
@@ -2911,21 +2920,26 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3267,6 +3281,8 @@ static int __net_init ipmr_net_init(struct net *net)
 	LIST_HEAD(dev_kill_list);
 	int err;
 
+	mutex_init(&net->ipv4.mfc_mutex);
+
 	err = ipmr_notifier_init(net);
 	if (err)
 		goto ipmr_notifier_fail;
-- 
2.53.0.414.gf7e9f6c205-goog


