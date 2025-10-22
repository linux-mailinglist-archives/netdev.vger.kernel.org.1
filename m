Return-Path: <netdev+bounces-231532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AECBFA151
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FD318C738A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED052EC0BB;
	Wed, 22 Oct 2025 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR43WWyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD92EC563
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111621; cv=none; b=nTaqHzvIXa0hC6Eu/QO9AhmQWMBH+OSl5jYmksZpaQR3BZC3RlUyGSkzbwWHe81BH03crZNveX4viAXXYpknRXvL5obtsyCcL/UlQGLALqKe7lpZcL5CcGaTOwF1PUb52MjDrh0LyuArspt7odl3NQtK4KRAE5hi1ilBLGgYEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111621; c=relaxed/simple;
	bh=K0Vu2XXte8z5Wpl1L/lPwvu+Ot8Hg84Mgs1BV0CQM08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=izMJgRPlVm/Y8Pp2UrHrEnSBnK+PeXTK4D2tSiPmzFozUdE7PGKvvAxkdSIhgOaFf37+gJixtrvynFbRggXhYmLkJv/+6aaNRJpTg9XDZdUz2EQn4k5JLudckzR7BCmYNNdrMtQWtJwh6nbAPIuRkIiNsk2pggKwF1vZo1bK7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR43WWyq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b67c546a6e3so14249971a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111618; x=1761716418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M583yWpsfiw8Xn0uI+4quMq0lPvp0Z7c+ZYs6VEcQUE=;
        b=XR43WWyqpgo6vSkFvbVJQpOzCfgmVbr3Zts6lfw1W3SgBnn7/X9Q4gvCrPoOgUtfiN
         hqyjs3+/gg39qVhRXuCxJQfL9WwnB9MsAcQeVN/Va0r8wvZFlEnEqvDg0kSU5OALxqhH
         fwCkw3IHpcY8Pxjxq6hMfSxLBZRew5vd2/3gLhx90JhUHwBZu1voslGpF9I8Tybsl6sH
         yYNowRnqUKVM9SG1CPBaLKf2offzqXQZbTIQwCuDQ8TW1Gni9tkP/q3vmWz8+rL/NFrp
         CMhkDPRQgJAVZLRpc+tFhPQngj/f9uH6z/NvhxaetcjO3YVTI8vsu4gay+XTJq0fdX8Y
         gzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111618; x=1761716418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M583yWpsfiw8Xn0uI+4quMq0lPvp0Z7c+ZYs6VEcQUE=;
        b=eI3WyorsOOlwkdCgIc3Fvs52ubG0r4Mz93nQ7Z2Hm+zEV8ZgVpZK+OzRgR5C50hZ4F
         TbB742w3M+ME9O6iVpctctq80fRHngPS2CpEgyQ3OxbdFyVy6uXv3i8Xv9C+JhyNSrPW
         gApEZkCiBZbPLLYOCklNf3FcTrRQv2JTfmAB0/Rp7xA57xOtQKtMBuvq03HupBKeFYmW
         POydJQnmBFxYNtQQDhRMoK9bMkhEJH3QfGKdAA7vOaCPUr5B3R4z/H+wkMy7s3jDdKZ7
         fqE3X6D8msxLx5WCGKJ1gY0IZ0uv+O/8D6246WVkWDbBV8GkS47pOhr2Bp67Wo/bWFB+
         z25w==
X-Forwarded-Encrypted: i=1; AJvYcCWDbG/8eRBOkPpfiwFgWBI9bxosnL7tNJYPqHP4flyl6K+7GUhVl0T6a1h/4vVqbtzCyvKD7yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpt27Jr1Gis82JgqxY2ub/Js+3LLygTAddLWhgpIuVfcJN0S5P
	b2+JF4UebWFXgJaRzbG27Y7ASgfC3TVgDvDHGj9pmfMO2lZD1f0Yl/uU2+pueWnJyZuzyHYqBGe
	bKT5F4A==
X-Google-Smtp-Source: AGHT+IG8tCFbwQ6CqMsPxYYlSz+FIGLEUqyIaQkyQ4wFnkCaot7v42VNyticfuAZiTD7TF57sPcTnOBYK6A=
X-Received: from pjsg6.prod.google.com ([2002:a17:90a:7146:b0:33b:9e06:6b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a4:b0:2f9:48ac:c8ed
 with SMTP id adf61e73a8af0-334a8534251mr24978795637.1.1761111618639; Tue, 21
 Oct 2025 22:40:18 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:46 +0000
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/5] neighbour: Annotate access to neigh_parms fields.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

NEIGH_VAR() is read locklessly in the fast path, and IPv6 ndisc uses
NEIGH_VAR_SET() locklessly.

The next patch will convert neightbl_dump_info() to RCU.

Let's annotate accesses to neigh_param with READ_ONCE() and WRITE_ONCE().

Note that ndisc_ifinfo_sysctl_change() uses &NEIGH_VAR() and we cannot
use '&' with READ_ONCE(), so NEIGH_VAR_PTR() is introduced.

Note also that NEIGH_VAR_INIT() does not need WRITE_ONCE() as it is before
parms is published.  Also, the only user hippi_neigh_setup_dev() is no
longer called since commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS"),
which looks wrong, but probably no one uses HIPPI and RoadRunner.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h | 15 ++++++++++++---
 net/core/neighbour.c    | 17 ++++++-----------
 net/ipv6/ndisc.c        |  8 ++++----
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 4a30bd458c5a9..998ff9eccebb7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -92,15 +92,17 @@ struct neigh_parms {
 static inline void neigh_var_set(struct neigh_parms *p, int index, int val)
 {
 	set_bit(index, p->data_state);
-	p->data[index] = val;
+	WRITE_ONCE(p->data[index], val);
 }
 
-#define NEIGH_VAR(p, attr) ((p)->data[NEIGH_VAR_ ## attr])
+#define __NEIGH_VAR(p, attr) ((p)->data[NEIGH_VAR_ ## attr])
+#define NEIGH_VAR(p, attr) READ_ONCE(__NEIGH_VAR(p, attr))
+#define NEIGH_VAR_PTR(p, attr) (&(__NEIGH_VAR(p, attr)))
 
 /* In ndo_neigh_setup, NEIGH_VAR_INIT should be used.
  * In other cases, NEIGH_VAR_SET should be used.
  */
-#define NEIGH_VAR_INIT(p, attr, val) (NEIGH_VAR(p, attr) = val)
+#define NEIGH_VAR_INIT(p, attr, val) (__NEIGH_VAR(p, attr) = val)
 #define NEIGH_VAR_SET(p, attr, val) neigh_var_set(p, NEIGH_VAR_ ## attr, val)
 
 static inline void neigh_parms_data_state_setall(struct neigh_parms *p)
@@ -378,6 +380,13 @@ struct net *neigh_parms_net(const struct neigh_parms *parms)
 
 unsigned long neigh_rand_reach_time(unsigned long base);
 
+static inline void neigh_set_reach_time(struct neigh_parms *p)
+{
+	unsigned long base = NEIGH_VAR(p, BASE_REACHABLE_TIME);
+
+	WRITE_ONCE(p->reachable_time, neigh_rand_reach_time(base));
+}
+
 void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 		    struct sk_buff *skb);
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl, struct net *net,
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 56ce01db1bcb4..b08a9df31a15b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -995,8 +995,7 @@ static void neigh_periodic_work(struct work_struct *work)
 
 		WRITE_ONCE(tbl->last_rand, jiffies);
 		list_for_each_entry(p, &tbl->parms_list, list)
-			p->reachable_time =
-				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
+			neigh_set_reach_time(p);
 	}
 
 	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
@@ -1749,8 +1748,7 @@ struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 	if (p) {
 		p->tbl		  = tbl;
 		refcount_set(&p->refcnt, 1);
-		p->reachable_time =
-				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
+		neigh_set_reach_time(p);
 		p->qlen = 0;
 		netdev_hold(dev, &p->dev_tracker, GFP_KERNEL);
 		p->dev = dev;
@@ -1810,8 +1808,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	list_add(&tbl->parms.list, &tbl->parms_list);
 	write_pnet(&tbl->parms.net, &init_net);
 	refcount_set(&tbl->parms.refcnt, 1);
-	tbl->parms.reachable_time =
-			  neigh_rand_reach_time(NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME));
+	neigh_set_reach_time(&tbl->parms);
 	tbl->parms.qlen = 0;
 
 	tbl->stats = alloc_percpu(struct neigh_statistics);
@@ -2194,7 +2191,7 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 			NEIGH_VAR(parms, MCAST_PROBES)) ||
 	    nla_put_u32(skb, NDTPA_MCAST_REPROBES,
 			NEIGH_VAR(parms, MCAST_REPROBES)) ||
-	    nla_put_msecs(skb, NDTPA_REACHABLE_TIME, parms->reachable_time,
+	    nla_put_msecs(skb, NDTPA_REACHABLE_TIME, READ_ONCE(parms->reachable_time),
 			  NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_BASE_REACHABLE_TIME,
 			  NEIGH_VAR(parms, BASE_REACHABLE_TIME), NDTPA_PAD) ||
@@ -2475,8 +2472,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 				 * only be effective after the next time neigh_periodic_work
 				 * decides to recompute it (can be multiple minutes)
 				 */
-				p->reachable_time =
-					neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
+				neigh_set_reach_time(p);
 				break;
 			case NDTPA_GC_STALETIME:
 				NEIGH_VAR_SET(p, GC_STALETIME,
@@ -3721,8 +3717,7 @@ static int neigh_proc_base_reachable_time(const struct ctl_table *ctl, int write
 		 * only be effective after the next time neigh_periodic_work
 		 * decides to recompute it
 		 */
-		p->reachable_time =
-			neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
+		neigh_set_reach_time(p);
 	}
 	return ret;
 }
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f427e41e9c49b..59d17b6f06bfd 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1449,7 +1449,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 					      BASE_REACHABLE_TIME, rtime);
 				NEIGH_VAR_SET(in6_dev->nd_parms,
 					      GC_STALETIME, 3 * rtime);
-				in6_dev->nd_parms->reachable_time = neigh_rand_reach_time(rtime);
+				neigh_set_reach_time(in6_dev->nd_parms);
 				in6_dev->tstamp = jiffies;
 				send_ifinfo_notify = true;
 			}
@@ -1948,9 +1948,9 @@ int ndisc_ifinfo_sysctl_change(const struct ctl_table *ctl, int write, void *buf
 		ret = -1;
 
 	if (write && ret == 0 && dev && (idev = in6_dev_get(dev)) != NULL) {
-		if (ctl->data == &NEIGH_VAR(idev->nd_parms, BASE_REACHABLE_TIME))
-			idev->nd_parms->reachable_time =
-					neigh_rand_reach_time(NEIGH_VAR(idev->nd_parms, BASE_REACHABLE_TIME));
+		if (ctl->data == NEIGH_VAR_PTR(idev->nd_parms, BASE_REACHABLE_TIME))
+			neigh_set_reach_time(idev->nd_parms);
+
 		WRITE_ONCE(idev->tstamp, jiffies);
 		inet6_ifinfo_notify(RTM_NEWLINK, idev);
 		in6_dev_put(idev);
-- 
2.51.0.915.g61a8936c21-goog


