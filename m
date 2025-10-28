Return-Path: <netdev+bounces-233413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB00C12C76
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB831AA6C4E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A6286415;
	Tue, 28 Oct 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSGD9leP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032827F4E7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622723; cv=none; b=dtyChgvCQU8+xvjnP+tY900drow3BITbsv1gFIVKnQrlYTmF04FGIpUCdunt6xuUCvOncrDniOLEtJ7ny0UbPXFYp6lLgtXWSvkesKjv5imfAMOC4heXMvQi+NU0kYiKOqZ7e/Mkm4LI29nq4wtL0wSgTuZjq/GfZkPIrPX1kCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622723; c=relaxed/simple;
	bh=A5Tsl3o0q29dUV4Y+m2zcB0jcC7JCobXQdpT7Gq8lYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVOJmGCAOPmTxZQ2mgxsuT/hcgu8PVNbGCXEXo0hnBNWz2RvHE7tnupHYjSHHZAilDYbt17bVmN8R7jAsUOlNqwTdPb3bQI1t/ByE8f5S3mH9v9bTSNb+PRj/0uJdFMKvzyIe8Fo7MLpVCStLcoVr6I/aVhCqsll4BloKIHoiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSGD9leP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-286a252bfbfso127501725ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622721; x=1762227521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy05N4ii4sfjunuTDRXX3tezP8/inX8KonW1zgUmoOI=;
        b=FSGD9lePxpIfTnpY/GUNy2KSanwX4Iqea3LDCs6jHlsPUcmNm1VQFKRdt1uwf62+6k
         QChc/zFYFPGWZGHIe8X4NxlhAvsf5q18uzhEVm0wE3tKcwykBtUGMtIHeW/Wf/eAB+Zq
         tC+vyxXIsSBrgjQ1UEG2KKUwOyCeFHVeE8iCaTHREsL1z86o4efp1mRMY4qbcydASknm
         38uVgBzGvj7/hGnVGxNrMn7/d2pIylw19J+yU7UArnf4hCtKpxVThmcEKzvJ38s6GQk8
         BAMB4u1Bh8gTWfaOMgZQSnAX6bHCVcwNNJQIWTMZoKSytoXUlOMKIn/yM3DiQVbIc6IT
         di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622722; x=1762227522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy05N4ii4sfjunuTDRXX3tezP8/inX8KonW1zgUmoOI=;
        b=enPuJ2dfVPsVolua4KILscN6DP0ypIm6ECxxUitv58Kl5NzoP8oupj+Dn6sgURQjPA
         q1L0z27Pa6jJRacO+OSwRdc4v2HPYD8k2Scwov3OxXNMZPw6004n2y81OU3ST8J0lhU3
         qvAIxXMr5DGumbMis2IcJn0WdJ07ptDqRHlYuLiAxe9hr6eePeSnj93cP6iSHYZnWg6w
         P725xni6IOkg1ReYA4QG6sYiLkiK4mBhQiQRyNV37ssjhJUt4Yox7h6W01z1qAM2g9J7
         HGnFS/ghUGWzsXXoMhnnldMT1v4xeqaDq8xVSZKN/ol364bPAwB5sbCODZW+MmZi3pHV
         VIkA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSV3GORAVKPui5TQf+uIiaBSkwbP9GbyzvJqPkj9GckRDvFEChP6iSSjaVq+KwijI4crew6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrdUjIv1uqh0CBQTTnQVv7QTSMD4Vv6olyZ1cYNPgpS6///zx
	tAA6Q0DTuXyj3EQNmIT7KUyVizI+5VkhBJr/239DieBGiHQRMPF7AkHHxHPCfEpnAE1T91Rr3s+
	H6ZTUwQ==
X-Google-Smtp-Source: AGHT+IH6WLpn7qIxVvB+YYaWUjU/2qLMN87kuEzZNeQpUfJ9RxH6dDaj5zWXxE2uMeeKmWC5XuLqK6S99u4=
X-Received: from plcj18.prod.google.com ([2002:a17:902:f252:b0:290:a6e2:2006])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:182:b0:267:b0e4:314e
 with SMTP id d9443c01a7336-294cb39f710mr21359995ad.23.1761622721650; Mon, 27
 Oct 2025 20:38:41 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:05 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/13] mpls: Convert mpls_dump_routes() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_dump_routes() sets fib_dump_filter.rtnl_held to true and
calls __dev_get_by_index() in mpls_valid_fib_dump_req().

This is the only RTNL dependant in mpls_dump_routes().

Also, synchronize_rcu() in resize_platform_label_table()
guarantees that net->mpls.platform_label is alive under RCU.

Let's convert mpls_dump_routes() to RCU and use dev_get_by_index_rcu().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 35ae3dbd7bdc..f6cf38673742 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2153,7 +2153,7 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 
 		if (i == RTA_OIF) {
 			ifindex = nla_get_u32(tb[i]);
-			filter->dev = __dev_get_by_index(net, ifindex);
+			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			filter->filter_set = 1;
@@ -2191,20 +2191,19 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	struct mpls_route __rcu **platform_label;
 	struct fib_dump_filter filter = {
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	unsigned int flags = NLM_F_MULTI;
 	size_t platform_labels;
 	unsigned int index;
+	int err;
 
-	ASSERT_RTNL();
+	rcu_read_lock();
 
 	if (cb->strict_check) {
-		int err;
-
 		err = mpls_valid_fib_dump_req(net, nlh, &filter, cb);
 		if (err < 0)
-			return err;
+			goto err;
 
 		/* for MPLS, there is only 1 table with fixed type and flags.
 		 * If either are set in the filter then return nothing.
@@ -2212,14 +2211,14 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((filter.table_id && filter.table_id != RT_TABLE_MAIN) ||
 		    (filter.rt_type && filter.rt_type != RTN_UNICAST) ||
 		     filter.flags)
-			return skb->len;
+			goto unlock;
 	}
 
 	index = cb->args[0];
 	if (index < MPLS_LABEL_FIRST_UNRESERVED)
 		index = MPLS_LABEL_FIRST_UNRESERVED;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
+	platform_label = rcu_dereference(net->mpls.platform_label);
 	platform_labels = net->mpls.platform_labels;
 
 	if (filter.filter_set)
@@ -2228,7 +2227,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	for (; index < platform_labels; index++) {
 		struct mpls_route *rt;
 
-		rt = rtnl_dereference(platform_label[index]);
+		rt = rcu_dereference(platform_label[index]);
 		if (!rt)
 			continue;
 
@@ -2243,7 +2242,13 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	cb->args[0] = index;
 
+unlock:
+	rcu_read_unlock();
 	return skb->len;
+
+err:
+	rcu_read_unlock();
+	return err;
 }
 
 static inline size_t lfib_nlmsg_size(struct mpls_route *rt)
@@ -2768,6 +2773,8 @@ static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_modu
 	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
 	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
 	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes,
+	 RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
 	 RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.51.1.838.g19442a804e-goog


