Return-Path: <netdev+bounces-210058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB04AB11FCB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6683B9B0B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594DA23A9BE;
	Fri, 25 Jul 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzID8VZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02401DED63
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452461; cv=none; b=P743LKO6d6j0juXYLsoXbRl4KkX1tZv4XlzxejkAaGhzF9mX+HDhc6XZLWXFEvDEOFYf81aqV37rSiiTx1R/lCi0JAUZnu4f3lkLh7YCATC8NZCJOviCrnQymWLCoqDzfFrY975c35w/iTyv+UYe9mQO+xMW8bJ5hCFPuVq6xBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452461; c=relaxed/simple;
	bh=Gb2apZkmGIp8PSuKqTJydnTRQIP64r7iiPQbsHJE7KA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQc0KoyH7AkQSDl3H5AbicVP0VPNDySOZHP4wWfoS9lymQGEs0t7CZddxO/7lbgVBXdCNgp0kK0pEsgFO2I2zrIAvNXx5HIl2zon+QzI0vFyTualZgNTRC2ewbo1J5/hP81xxv+RPL/DmQJhtgAvFtiJd8qWWB8ZUipiElxMdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzID8VZb; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab758aaaf3so82461451cf.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753452457; x=1754057257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBtCUcGMczkfi4ipnIj6s20R+9sfuEskgKfPDELyCmI=;
        b=EzID8VZbrJcCmodCbPWRD2IhaQasXTnvk50QgDsQdfZbai0klLm6Grl/bqEY85uoxL
         UANpSrdP4d/UQuihsU5aukl5qT8lq8tU5IT5pUGROv4s68q6u8s5vZAHB1eEmWyeceTI
         tA4dfDKykizUC4vzABARAWe6049Xvn9zZc5KNKhxu6wV/GWAC96eEaAMKGqYBhl0BJBX
         QfdNujSwBPYjIYXbWxXwSSHJB+bwJkPCHkoc/PsKVlprOy0Oa/nzv21iepbfMgDvmzyD
         JuXRYxrFqTQCCsX2bxWv4tNzZ+jENW8tfgGGBwEx3tEYaaFvBJamUqO9XQhKvIaRA2DW
         Q01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452457; x=1754057257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBtCUcGMczkfi4ipnIj6s20R+9sfuEskgKfPDELyCmI=;
        b=LJBUfWwAbGVnBnX1Q2Cbqsfl6HOp80RShLDzZMAa/HMfe3jH4xIpQsDsRZhigUXVnd
         j7qjR2KygbPdd6IdsHt4kGkRqWg+lVqZexZ/m/xhj0OFlypBHZlVZFBTNHsOS5s7+4/b
         rXF0kXrF4b+S8WkuzSx/zXxJrixtuqa42jW008qi5WiFbHsFLnOPrPVHDEKw9r4InvJO
         PbceNJStboJDWJp573taepO7v44dB35AQnsDZm9MCqYA+ECFtQnXzc4v70d1y3GAGT7t
         U0uoR98k4hoTlb4dGIRNDoZm9OhquDMAah7GkXkQUdOK/rZkTxNFbHgB+DFrNcS9tEdE
         6qIg==
X-Forwarded-Encrypted: i=1; AJvYcCWNwERkzIxIPBDZ2MBA6M5nOy+VDtbH6wnimrKKyCRiCXKwzo4cyMRpNCaJIq5lyx3O/X+I7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXS5BAZU0T9/F5b6b8q6kG60q6ebnB2g6/vfx0VTxW+VCmbv7
	kO4kQ3iKhBApiigGCpkhbkgI1OdL36yA8pzD5S/BUsmRd0+5czx1dOaK0i9Q5wrQN2YaIFlbA+t
	WtFjx4B6wFVrtUg==
X-Google-Smtp-Source: AGHT+IEwRHn38aTU+ZLathGsQrm4P4BR5+oqH8sCUu3EOiGysBbPZPqPOMYiVGB2FDMrYdsdcmlfdG6zp5P/CA==
X-Received: from qtbfg9.prod.google.com ([2002:a05:622a:5809:b0:4ab:7d7e:a849])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:574b:0:b0:4ab:b187:17ec with SMTP id d75a77b69052e-4ae8ef8c95dmr25235141cf.14.1753452456292;
 Fri, 25 Jul 2025 07:07:36 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:23 +0000
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725140725.3626540-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725140725.3626540-3-edumazet@google.com>
Subject: [PATCH net 2/4] ipv6: prevent infinite loop in rt6_nlmsg_size()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While testing prior patch, I was able to trigger
an infinite loop in rt6_nlmsg_size() in the following place:

list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
			fib6_siblings) {
	rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
}

This is because fib6_del_route() and fib6_add_rt2node()
uses list_del_rcu(), which can confuse rcu readers,
because they might no longer see the head of the list.

Restart the loop if f6i->fib6_nsiblings is zero.

Fixes: d9ccb18f83ea ("ipv6: Fix soft lockups in fib6_select_path under high next hop churn")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_fib.c |  4 ++--
 net/ipv6/route.c   | 34 ++++++++++++++++++----------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 93578b2ec35fb55ca1f56c3e558661989568639e..af7db69d9eac97033fde46c5ee57e0cfb53a36db 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1265,7 +1265,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 							 &rt->fib6_siblings,
 							 fib6_siblings)
 					sibling->fib6_nsiblings--;
-				rt->fib6_nsiblings = 0;
+				WRITE_ONCE(rt->fib6_nsiblings, 0);
 				list_del_rcu(&rt->fib6_siblings);
 				rcu_read_lock();
 				rt6_multipath_rebalance(next_sibling);
@@ -2015,7 +2015,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 		list_for_each_entry_safe(sibling, next_sibling,
 					 &rt->fib6_siblings, fib6_siblings)
 			sibling->fib6_nsiblings--;
-		rt->fib6_nsiblings = 0;
+		WRITE_ONCE(rt->fib6_nsiblings, 0);
 		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9f92129efa05087d435575aa84c81b30430db249..6d4e147ae46bc245ccd195e5fb0e254f34ec65a4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5670,32 +5670,34 @@ static int rt6_nh_nlmsg_size(struct fib6_nh *nh, void *arg)
 
 static size_t rt6_nlmsg_size(struct fib6_info *f6i)
 {
+	struct fib6_info *sibling;
+	struct fib6_nh *nh;
 	int nexthop_len;
 
 	if (f6i->nh) {
 		nexthop_len = nla_total_size(4); /* RTA_NH_ID */
 		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
 					 &nexthop_len);
-	} else {
-		struct fib6_nh *nh = f6i->fib6_nh;
-		struct fib6_info *sibling;
-
-		nexthop_len = 0;
-		if (f6i->fib6_nsiblings) {
-			rt6_nh_nlmsg_size(nh, &nexthop_len);
-
-			rcu_read_lock();
+		goto common;
+	}
 
-			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
-						fib6_siblings) {
-				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
-			}
+	rcu_read_lock();
+retry:
+	nh = f6i->fib6_nh;
+	nexthop_len = 0;
+	if (READ_ONCE(f6i->fib6_nsiblings)) {
+		rt6_nh_nlmsg_size(nh, &nexthop_len);
 
-			rcu_read_unlock();
+		list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
+					fib6_siblings) {
+			rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
+			if (!READ_ONCE(f6i->fib6_nsiblings))
+				goto retry;
 		}
-		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
 	}
-
+	rcu_read_unlock();
+	nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
+common:
 	return NLMSG_ALIGN(sizeof(struct rtmsg))
 	       + nla_total_size(16) /* RTA_SRC */
 	       + nla_total_size(16) /* RTA_DST */
-- 
2.50.1.470.g6ba607880d-goog


