Return-Path: <netdev+bounces-210059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56AB11FCC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F27B5E9E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF362451C3;
	Fri, 25 Jul 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzU4/1Fo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D61FBEAC
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452462; cv=none; b=FOAhXnogCVGQrOcrlJJ2L3SnnoDOjr8CYwaQSQPPuqVzykAiacbU6JPQywGKYw7OxIxrrg/2DR8NiYRrdhEMGpUJ90FcBwqtQs9wgI9XpbMTsZ9wjaBQXzwCk6Qi2ERtQvOyR5usj4XSjX+fHrVe0iNw5KV5bGNXICUY9XyOd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452462; c=relaxed/simple;
	bh=z+hrFHZpOWAynfmzk6WewpfyoVVg7SMgCppBH9wYKQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i1PkZhGArrBoeOe0bZGtz6XHxQzA2/vR1QmrCLm2TzOZFg1xaHAiSVOYyVS9zBU5sRxF6oJfXUYQ5ceamG2WwNynlXi6NnwxS8J09VWEw7JDF1zPSWCjoPiZ3IXmyHBVfRJJ9yzV5rSvcSZ66/VELbg4BCsHiMy7yiuXmj6vcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzU4/1Fo; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e348600cadso368216885a.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753452459; x=1754057259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKBxT+Ba/3Tx1ek/cI9xtCjQghjDmWgdjwT1kEuQn1s=;
        b=YzU4/1Fo5i2QoI/4ioZ1rydFulZ5hWNseOwu+2bZeHIsMydrl2+Ls3wNfrXmh0z0q7
         SEv+tA+VrLUEZ5qBF1MItzfrqt1h/sgVL/vY1utRUR2svuHEJfEU++L6DO6M+FMP1Izc
         1lw7UpkC5RbOfcAaK3YZSBAG35IF3YScViSNSMgONne2WpXayRetnDKR97mJaNKxIDC6
         1JD4xvcww3SxznfPfUH0tv6/cpDShQz5vGaLKwDHqZcZDUB829gB2c56uobkRSAqbacx
         W89p/SKbar2+8V2DHl4naKllsTSDzut8piAh5cQcBRcs7vO5Y8fk9Ud3NM+PDeah3rCs
         6s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452459; x=1754057259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKBxT+Ba/3Tx1ek/cI9xtCjQghjDmWgdjwT1kEuQn1s=;
        b=M+KIrLSQagLQF9kR5QchaoSIuBAS3gA0u4m3KbB/BGVvnVendUj0ocvMZJgIhpJN8a
         mT+s0HqDXNQwp+RH5XYoLj7wyWa8OMTsv2Cmv0vjc5LqIUKcBJJEN1+QBmt9cwUtoxmH
         GX97LsPruP8MMFE3W3/+bcYN5O5G/lHyp8GEmKIrcw5RmkcM5dmeWv8TyQExuBxW0laE
         zhdLV/lOdOwXeMIQ/jkDW7haKz+jC1NIzZoO2ikZWuteFDPhKNpRqc5kXDlN1oB4zv0a
         z6AvA8N2r+oukEP1K3RRjKCB0177HE+WUsKpzXoCPMUV9gn79ZQUhQDulk1zrPKi1GH3
         cK2A==
X-Forwarded-Encrypted: i=1; AJvYcCUSNVxXUXgJD6M7bPu6h3GBk0SphCet0LdAu/HjPMEHZRXg8X3MSA/w4IC0wteYAQzu7WDiWYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLVhxojsPENor61/zl79qmYiXcLgYiZSa84M25mHQbfhckvVd
	Ne+E5qBT1mUZ1x2y/l0np1c+sHnNe4SefeiBJ5a5P8dsEQvGC7ph1P2YNFUUkjApWx/eSCNaSiU
	36coZpdJJsATnNw==
X-Google-Smtp-Source: AGHT+IF/udZDYGHvNAWsVhZIh0faP8dhSbv50pByYhPnuk3ZHLXWHLB56bhTQwCKiKOay/Ye+bvUKesNG2gMvg==
X-Received: from qkoz32.prod.google.com ([2002:a05:620a:2620:b0:7ca:ebc5:3d42])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2549:b0:7e0:46c3:c0a1 with SMTP id af79cd13be357-7e63bf682d5mr218774185a.26.1753452459301;
 Fri, 25 Jul 2025 07:07:39 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:25 +0000
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725140725.3626540-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725140725.3626540-5-edumazet@google.com>
Subject: [PATCH net 4/4] ipv6: annotate data-races around rt->fib6_nsiblings
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rt->fib6_nsiblings can be read locklessly, add corresponding
READ_ONCE() and WRITE_ONCE() annotations.

Fixes: 66f5d6ce53e6 ("ipv6: replace rwlock with rcu and spinlock in fib6_table")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_fib.c | 20 +++++++++++++-------
 net/ipv6/route.c   |  5 +++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index af7db69d9eac97033fde46c5ee57e0cfb53a36db..4d68bd853dbae92a48a15eeee091bfdde3b5c77d 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -445,15 +445,17 @@ struct fib6_dump_arg {
 static int fib6_rt_dump(struct fib6_info *rt, struct fib6_dump_arg *arg)
 {
 	enum fib_event_type fib_event = FIB_EVENT_ENTRY_REPLACE;
+	unsigned int nsiblings;
 	int err;
 
 	if (!rt || rt == arg->net->ipv6.fib6_null_entry)
 		return 0;
 
-	if (rt->fib6_nsiblings)
+	nsiblings = READ_ONCE(rt->fib6_nsiblings);
+	if (nsiblings)
 		err = call_fib6_multipath_entry_notifier(arg->nb, fib_event,
 							 rt,
-							 rt->fib6_nsiblings,
+							 nsiblings,
 							 arg->extack);
 	else
 		err = call_fib6_entry_notifier(arg->nb, fib_event, rt,
@@ -1138,7 +1140,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 
 			if (rt6_duplicate_nexthop(iter, rt)) {
 				if (rt->fib6_nsiblings)
-					rt->fib6_nsiblings = 0;
+					WRITE_ONCE(rt->fib6_nsiblings, 0);
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES)) {
@@ -1167,7 +1169,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 			 */
 			if (rt_can_ecmp &&
 			    rt6_qualify_for_ecmp(iter))
-				rt->fib6_nsiblings++;
+				WRITE_ONCE(rt->fib6_nsiblings,
+					   rt->fib6_nsiblings + 1);
 		}
 
 		if (iter->fib6_metric > rt->fib6_metric)
@@ -1217,7 +1220,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 		fib6_nsiblings = 0;
 		list_for_each_entry_safe(sibling, temp_sibling,
 					 &rt->fib6_siblings, fib6_siblings) {
-			sibling->fib6_nsiblings++;
+			WRITE_ONCE(sibling->fib6_nsiblings,
+				   sibling->fib6_nsiblings + 1);
 			BUG_ON(sibling->fib6_nsiblings != rt->fib6_nsiblings);
 			fib6_nsiblings++;
 		}
@@ -1264,7 +1268,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				list_for_each_entry_safe(sibling, next_sibling,
 							 &rt->fib6_siblings,
 							 fib6_siblings)
-					sibling->fib6_nsiblings--;
+					WRITE_ONCE(sibling->fib6_nsiblings,
+						   sibling->fib6_nsiblings - 1);
 				WRITE_ONCE(rt->fib6_nsiblings, 0);
 				list_del_rcu(&rt->fib6_siblings);
 				rcu_read_lock();
@@ -2014,7 +2019,8 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			notify_del = true;
 		list_for_each_entry_safe(sibling, next_sibling,
 					 &rt->fib6_siblings, fib6_siblings)
-			sibling->fib6_nsiblings--;
+			WRITE_ONCE(sibling->fib6_nsiblings,
+				   sibling->fib6_nsiblings - 1);
 		WRITE_ONCE(rt->fib6_nsiblings, 0);
 		list_del_rcu(&rt->fib6_siblings);
 		rt6_multipath_rebalance(next_sibling);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 04f2b860ca6156776e0cedd18d96877effd287a4..aaedc08607c01c409276032b3ac213bb1876c726 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5346,7 +5346,8 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
 	 */
 	rcu_read_lock();
 
-	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
+	if ((nlflags & NLM_F_APPEND) && rt_last &&
+	    READ_ONCE(rt_last->fib6_nsiblings)) {
 		rt = list_first_or_null_rcu(&rt_last->fib6_siblings,
 					    struct fib6_info,
 					    fib6_siblings);
@@ -5856,7 +5857,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 		if (dst->lwtstate &&
 		    lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 			goto nla_put_failure;
-	} else if (rt->fib6_nsiblings) {
+	} else if (READ_ONCE(rt->fib6_nsiblings)) {
 		struct fib6_info *sibling;
 		struct nlattr *mp;
 
-- 
2.50.1.470.g6ba607880d-goog


