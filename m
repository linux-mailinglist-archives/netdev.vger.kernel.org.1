Return-Path: <netdev+bounces-203211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84BAF0C44
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3093B7BD3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4168223DEA;
	Wed,  2 Jul 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAwe4z0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD52236F3
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440357; cv=none; b=kb6UwozK8qwFgSKMh4B3/+aWOc5SHSmJQcYwCa+uzFTJf44WVoq0RbLBahTXiFCjpQ33yj6r6sba7yRa35kv9G7b2K56bcmPtWVP80mAHjxE18J3noym8HGEWU7SSyXzJYZ62uI5oj+3jdwh2FW+CBXhnT5yIrjSWPgv5ZYrj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440357; c=relaxed/simple;
	bh=L8gzyqSyVOMAec0ZT8t+tRHJlDwwhKa+i1P6GdG7vgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h+jVdL7+toRq7EBPyJLgKoNnCJ4UIEHJyqwxKHko/Jcbd1IvA7ftus9/z/ANKH/Tihy/f3TIEyudbflGQutg5cQFVSzlOla3txyAhIaXYHNOSLHvID8TI7ovhx6SHvi+WUQSZ1TzC2xhUk8HzFVMnPdKp0Awi5eWDgcYq03jjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAwe4z0Q; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d413a10b4cso1106463085a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751440354; x=1752045154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dxI8+CD4/R5XYiIR8lsirbp/clezH5qoh5q5NVx22U=;
        b=cAwe4z0QpyB8gwMYgDM5yHhVyGXyyz6yZu2aMXko35fGLHICyt7OtRzERrD/U1r68c
         DZZmbyU9Sb6CAFw3325QNe0TtMezR/88d6w0WpcOZMRASv8pzzaTc0sgGGEJlo4hBuSc
         0swZABy4uxBAmNl6bSy5qMf3H7kObep50doNCqp2SCqDN928JxKEi1ZgO7gW6dL0KVS2
         ZVF8mpGj8lBrO5FlcfU9V+juAtY+tNbuFUIA7cfupTLjbMUpx3Mridd5LVpeJAbUL1ZF
         ZNE6GQ3jHZxrQkJ0bfMdy7ke4CayEg4rjR1r7ZzxhHNxB98BOXAsr1nscXB+r8dVCN3d
         mWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440354; x=1752045154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dxI8+CD4/R5XYiIR8lsirbp/clezH5qoh5q5NVx22U=;
        b=qwlUfah/DzJTBvss9TeV6z1bk0Sf6zKDUiSN5wlhcZs6JyNOdtT1dRhHLwZ++h94/r
         xUric1Ua/eLLm5LrIFjGpyFujMd8UNDa741bJzqJVvNINjtJ3goWGIGE+nBNGeYOKnc2
         CeJrKFuo+l8Ht8mdfB1Z3gv7DUSnw3BVwK9ipeSY8JCYCEtdbV2aleBxcnzyHAzZvtfI
         fJ23zwDntunf/g0LcZgxYxs76E6s3LPj8y+Fkks3gWN46ad/dX4GD9v7Q9QHyzzFfx5/
         2PWlJQP6DTEiJv6oeUrhSVJHpV5P/2DpOwcEuHNeq0r4WaLTIJDPAeWmGfXPoaDwLNMf
         P2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXg8CTbzB5/iA4Z2WexSLljOoJGSQZASOEn9pl7YTpI1VmiCGv1ivwTymvjvodVaWyEQZiGHOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITh+QzH3fd7a1e3JF3xA9A1DNIT1keY68f78KqH5jD3TpOb0o
	Pv46FrvVm6Od+7dAcECrrIPNG2cCM8s6RxIgryQk04Ubkzp2OsLs46TeFnw1vKa2H93ComGLWxt
	kT81bwH0zEmXLFg==
X-Google-Smtp-Source: AGHT+IHl/h5HpQ94wR5tWMLOLZBDqviKVtaqC0Qsnw5QelK+AOF7injqtioDPlYZLVN6Ig4eRvtIhBFsy+E/IQ==
X-Received: from qtbgd25.prod.google.com ([2002:a05:622a:5c19:b0:48a:4c42:bc53])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8018:b0:7c7:b4aa:85bc with SMTP id af79cd13be357-7d5c472ec2bmr222674685a.17.1751440353736;
 Wed, 02 Jul 2025 00:12:33 -0700 (PDT)
Date: Wed,  2 Jul 2025 07:12:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702071230.1892674-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net/sched: acp_api: no longer acquire RTNL in tc_action_net_exit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"

tc_action_net_exit() got an rtnl exclusion in commit
a159d3c4b829 ("net_sched: acquire RTNL in tc_action_net_exit()")

Since then, commit 16af6067392c ("net: sched: implement reference
counted action release") made this RTNL exclusion obsolete for
most cases.

Only tcf_action_offload_del() might still require it.

Move the rtnl locking into tcf_idrinfo_destroy() when
an offload action is found.

Most netns do not have actions, yet deleting them is adding a lot
of pressure on RTNL, which is for many the most contended mutex
in the kernel.

We are moving to a per-netns 'rtnl', so tc_action_net_exit()
will not be able to grab 'rtnl' a single time for a batch of netns.

Before the patch:

perf probe -a rtnl_lock

perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; sleep 1'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.305 MB perf.data (25 samples) ]

After the patch:

perf record -e probe:rtnl_lock -a /bin/bash -c 'unshare -n "/bin/true"; sleep 1'
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.304 MB perf.data (9 samples) ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Buslov <vladbu@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
v2: Added conditional rtnl acquisition in tcf_idrinfo_destroy()
    after Cong feedback about tcf_action_offload_del() safety.
    Added some performance numbers before/after the patch.
v1: https://lore.kernel.org/netdev/20250701133006.812702-1-edumazet@google.com/

 include/net/act_api.h | 2 --
 net/sched/act_api.c   | 9 ++++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 404df8557f6a13420b18d9c52b9710fe86d084aa..04781c92b43d6ab9cc6c81a88d5c6fe8c282c590 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -170,14 +170,12 @@ static inline void tc_action_net_exit(struct list_head *net_list,
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct tc_action_net *tn = net_generic(net, id);
 
 		tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
 		kfree(tn->idrinfo);
 	}
-	rtnl_unlock();
 }
 
 int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 057e20cef3754f33357c4c1e30034f6b9b872d91..9e468e46346710c85c3a85b905d27dfe3972916a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -933,18 +933,25 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
 			 struct tcf_idrinfo *idrinfo)
 {
 	struct idr *idr = &idrinfo->action_idr;
+	bool mutex_taken = false;
 	struct tc_action *p;
-	int ret;
 	unsigned long id = 1;
 	unsigned long tmp;
+	int ret;
 
 	idr_for_each_entry_ul(idr, p, tmp, id) {
+		if (tc_act_in_hw(p) && !mutex_taken) {
+			rtnl_lock();
+			mutex_taken = true;
+		}
 		ret = __tcf_idr_release(p, false, true);
 		if (ret == ACT_P_DELETED)
 			module_put(ops->owner);
 		else if (ret < 0)
 			return;
 	}
+	if (mutex_taken)
+		rtnl_unlock();
 	idr_destroy(&idrinfo->action_idr);
 }
 EXPORT_SYMBOL(tcf_idrinfo_destroy);
-- 
2.50.0.727.gbf7dc18ff4-goog


