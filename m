Return-Path: <netdev+bounces-83419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5589235C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016C0285F38
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28120319;
	Fri, 29 Mar 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1S2vUMBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD9320B
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737057; cv=none; b=GmLHnin/z58eRTLvSTWy9FXobOl3HErpDV1V13QIqkCgOB1iFZtQJZmovxvAyJahVA/vJcksVVI4NhwhF4xI0y4kojgCqRjqLlSLpo59Dty64kjCVosimsIAZGZSnFhZaHpOIedkom+Ag8k3p2dXLLeZlRN8tLh/I8AgrUHfoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737057; c=relaxed/simple;
	bh=q9fXlZD4J6SyprbSToxogXpZJfLmJA+jrif1BLLHFwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pvVlig+Z8DnoiS5iAbKKy7UsNO4Ra9Wy5lOPHDtC0UxWNGHI6IwUDN5dsz8O8wsv3mvDK7g+7sizcRimZ/EZaT70BdGQcFzTaWXzsIndYYGN2QtQpwHFHkoDRsgBoaACtBtvpPrrlCda6Zyqc1b5j6Bd6f4M+wjk3nrtWazqwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1S2vUMBb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd073522cso36718707b3.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711737054; x=1712341854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+gP11uoZxESr3DBeQAiaY/Mbz9A5zQu11DjgzkeSGxw=;
        b=1S2vUMBbw9RMylz1LFcmbjNRlmVa86IJ2qRcNjfpGSBrpqcELcJd39e5jgE/Lm7pLf
         19CvMHlYZ8J9LF6vaBJossFy1WiFdvYKlZ5dDiBc7RVIGhw6cS/XDIX9k/NOTk6ROyXZ
         NXPg2y+1Zl+3adb6C5Gcb9LYDLOWap58KsAUxJn+gZ7MW5NBi+yDLpyAKEny4gV2tlaB
         OFfly+IyclE3vKxSN5x9AgyvdbqaRVQrVkyuOb4XKK3FoSkQoiYzjJ5CC3erPuXG+UWw
         u33IwdHJjaMN08e3IroIc4XXnzsCBNhXl0nVoGlFs4+jOWnvuPdza502CsogSSDbD3iM
         Ztdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737054; x=1712341854;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gP11uoZxESr3DBeQAiaY/Mbz9A5zQu11DjgzkeSGxw=;
        b=hu5sY66cXh9/7jDs+bSGXa4o14PncA/li7LVn5H9UuttQvzY0/XbE0FEjTYz54J2fD
         U0Sd4sc8vyhkzqzwNfu/72RflQisTiDLUf2cKL81MyWh+0zpEez6bwIv/fRgaMCK6V+7
         GX9LyiyxidHX4z6x1shnk8us0ua690h/GYyVoGe39708lUTPfqcVQguwrHhuEg11STCt
         ES6OpstujKTcBVBG3UZTDEH0iKVKQ9npTLP0WQ5CevY3RHHxRSa5n7LM7Z8dboDR2g3E
         f/RbGTV58TfvNWwCcj3NOkzEFgxKynWkYNb+9PCvObWj9mW86fWXbeEGLvTK9WMWTfY+
         WirQ==
X-Gm-Message-State: AOJu0Yx21VJ2f7iUnE9hHDcle+3OFa0hdH7k2VpJWd870pXJPW0fKwfT
	/JgK8Modeyqag43D2CXg+6Iu1iHLoJv1jZ6nRRprhp3tIHZovTTrtwGpNgSg8C0beM1SL9gKQ8S
	iH+FLRlaNJg==
X-Google-Smtp-Source: AGHT+IHZDPsIt50Budojh0tsEgFd1V9V2vDjPz+/Rt8aMEQNG4NELpqg78AGjeGkWx2hzn851AFZvUMKo4siNQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:f910:0:b0:611:7166:1a4d with SMTP id
 x16-20020a81f910000000b0061171661a4dmr789183ywm.3.1711737054570; Fri, 29 Mar
 2024 11:30:54 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:30:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329183053.644630-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: remove RTNL protection from inet6_dump_fib()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

No longer hold hold RTNL while calling inet6_dump_fib().

Also change return value for a completed dump,
so that NLMSG_DONE can be appended to current skb,
saving one recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv6/ip6_fib.c | 51 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 5c558dc1c6838681c2848412dced72a41fe764be..284002a2a890526960c1360ebab4378bb8bb43f8 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -623,23 +623,22 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	struct rt6_rtnl_dump_arg arg = {
 		.filter.dump_exceptions = true,
 		.filter.dump_routes = true,
-		.filter.rtnl_held = true,
+		.filter.rtnl_held = false,
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	unsigned int h, s_h;
 	unsigned int e = 0, s_e;
+	struct hlist_head *head;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
-	struct hlist_head *head;
-	int res = 0;
+	unsigned int h, s_h;
+	int err = 0;
 
+	rcu_read_lock();
 	if (cb->strict_check) {
-		int err;
-
 		err = ip_valid_fib_dump_req(net, nlh, &arg.filter, cb);
 		if (err < 0)
-			return err;
+			goto unlock;
 	} else if (nlmsg_len(nlh) >= sizeof(struct rtmsg)) {
 		struct rtmsg *rtm = nlmsg_data(nlh);
 
@@ -660,8 +659,10 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		 * 2. allocate and initialize walker.
 		 */
 		w = kzalloc(sizeof(*w), GFP_ATOMIC);
-		if (!w)
-			return -ENOMEM;
+		if (!w) {
+			err = -ENOMEM;
+			goto unlock;
+		}
 		w->func = fib6_dump_node;
 		cb->args[2] = (long)w;
 	}
@@ -675,46 +676,46 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		tb = fib6_get_table(net, arg.filter.table_id);
 		if (!tb) {
 			if (rtnl_msg_family(cb->nlh) != PF_INET6)
-				goto out;
+				goto unlock;
 
 			NL_SET_ERR_MSG_MOD(cb->extack, "FIB table does not exist");
-			return -ENOENT;
+			err = -ENOENT;
+			goto unlock;
 		}
 
 		if (!cb->args[0]) {
-			res = fib6_dump_table(tb, skb, cb);
-			if (!res)
+			err = fib6_dump_table(tb, skb, cb);
+			if (!err)
 				cb->args[0] = 1;
 		}
-		goto out;
+		goto unlock;
 	}
 
 	s_h = cb->args[0];
 	s_e = cb->args[1];
 
-	rcu_read_lock();
 	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
 		e = 0;
 		head = &net->ipv6.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
 			if (e < s_e)
 				goto next;
-			res = fib6_dump_table(tb, skb, cb);
-			if (res != 0)
-				goto out_unlock;
+			err = fib6_dump_table(tb, skb, cb);
+			if (err != 0)
+				goto out;
 next:
 			e++;
 		}
 	}
-out_unlock:
-	rcu_read_unlock();
+out:
 	cb->args[1] = e;
 	cb->args[0] = h;
-out:
-	res = res < 0 ? res : skb->len;
-	if (res <= 0)
+
+unlock:
+	rcu_read_unlock();
+	if (err <= 0)
 		fib6_dump_end(cb);
-	return res;
+	return err;
 }
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
@@ -2506,7 +2507,7 @@ int __init fib6_init(void)
 		goto out_kmem_cache_create;
 
 	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
-				   inet6_dump_fib, 0);
+				   inet6_dump_fib, RTNL_FLAG_DUMP_UNLOCKED);
 	if (ret)
 		goto out_unregister_subsys;
 
-- 
2.44.0.478.gd926399ef9-goog


