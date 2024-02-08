Return-Path: <netdev+bounces-70159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708384DE3D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A84D1F2397E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7B6E2B8;
	Thu,  8 Feb 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orsowU/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37E6D1AE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387916; cv=none; b=OgtaL1p5UOzXqxEAdKTamqn0cQ3IcTsOLxaqkwmm2r2XJqPQx5ph91exdruzN9jczgbGI2q1kGTvx2chr21gZ52jo0/DwSCpZr8wzwXH4QYOaUJVze0MFEXMyEKCw4M0zBLY7qYn/CRgyHeiG10k1H1R8pDJfCGSIL8/XVVJEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387916; c=relaxed/simple;
	bh=ebO6pdQTvVDp5sbdn11vx9wnfJW0PzkwaYUKfnlOvMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AScTl5lmZQbQkrtABGrjE8DouwqDxzWAbr6BuTnBBsTaycv8PsSgzTjwDcrK0Rvoh61ECr9XzHgYKbe869S+jKNq8lifZfExOYn7+uJS9KL6AwvjNlEaJkrK5DlbZwtI6MCqXbyn/wA5L7K6pRBK56cvgBmXPEc2R26ghdChugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orsowU/f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bad01539so2391425276.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 02:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707387913; x=1707992713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PsemiEWHQz0P00/F7dOZm4T8rvQszoCPzw9gOsY8kI=;
        b=orsowU/fUfLN6teRubJY5zIMqc4nWk5c1xDeQGVH5y9EJIgt9sB9r2oI6lWHAoyZFb
         T7h5sZG5gmwP9u7zVY4Q34PJI1hDrBPWWx1WaGcLmWF+ybODhCvWAXZ44SHcFxviDK33
         D3UAYZTPdwVJWJNE908hq1o5OFFPpyOfwMkASf+s073psZsHfTLclqeUJ/FO1753wEko
         ei5LPD3iAoNj49NGqBktqQBkrr5Zj1BqTilIcx6Kj8LIs7aA+iUC0NI6CjBwJqTf/+fe
         /hI/5df81vz1B2AU36TIBM5YKM/OcYd14sJlOYqpo8aRrYWh8YPMHQjEk9mSVwsyiJ4R
         VcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387913; x=1707992713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PsemiEWHQz0P00/F7dOZm4T8rvQszoCPzw9gOsY8kI=;
        b=HqrNuNEMCxpaW7OU/zPJ0TBuUfBSdJJzJ4bRwlmg5mjz5CAF34TwxKfxqZ2+sfo+AD
         E8AnDyL9m3x2der7SY38O7Vvht6lnClpTlHiFnh6oJGFt2XYIvGyOIBcxqwO8cFM6X4H
         uGhmkp25pnnBJRjtVQEWxlce/XJ6HkjIP/io4mBP1Cs+PgH77A9JfL7aViNKRECO6mqq
         vuC3nFEKnps79wVNJ4WXNnywLBtO7y71fKi7In/LPZ2BQHrYvPi/pxXCrc31uRAWBnxR
         2OPJ6pbYNUCg0hY4BeB5DQlf+nkROiGS6HRZ9exUur/Fk3MRcCRbgr7Mzp311dKr6Iu4
         gV2A==
X-Gm-Message-State: AOJu0YzMzQkVOsoMwXskycup5wBiSTSxaKXjspl+V0iQnuiP3Vg1ItdL
	Wn/B1z2nRTCpFy6q6nF1dnRhPiDlGz0nRLBvnQY8EpiGIpzFDOPLRu/u0qBQqXQFUUQRPuyNx+U
	7rIiZpiwsew==
X-Google-Smtp-Source: AGHT+IH2am2/3sYRVoHRCe9kn5IcjiSXOU+kuLh4PRTb0scPZ//4XM/oUC9dVJPff5DNTPnEZlNBWmFr5w0ApQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2005:b0:dc6:a6e3:ca93 with SMTP
 id dh5-20020a056902200500b00dc6a6e3ca93mr267013ybb.10.1707387913364; Thu, 08
 Feb 2024 02:25:13 -0800 (PST)
Date: Thu,  8 Feb 2024 10:25:08 +0000
In-Reply-To: <20240208102508.262907-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208102508.262907-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208102508.262907-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net/sched: act_api: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tc_action_net_exit() is called for each act module,
and grabs rtnl each time, making netns dismantles slow.

exit_batch_rtnl() is called while RTNL is already held,
saving one rtnl_lock()/rtnl_unlock() pair.

Rename tc_action_net_exit() to tc_action_net_exit_batch_rtnl()
and change all callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h      | 3 ++-
 net/sched/act_api.c        | 7 +++----
 net/sched/act_bpf.c        | 7 ++++---
 net/sched/act_connmark.c   | 7 ++++---
 net/sched/act_csum.c       | 7 ++++---
 net/sched/act_ct.c         | 7 ++++---
 net/sched/act_ctinfo.c     | 7 ++++---
 net/sched/act_gact.c       | 7 ++++---
 net/sched/act_gate.c       | 7 ++++---
 net/sched/act_ife.c        | 7 ++++---
 net/sched/act_mirred.c     | 7 ++++---
 net/sched/act_mpls.c       | 7 ++++---
 net/sched/act_nat.c        | 7 ++++---
 net/sched/act_pedit.c      | 7 ++++---
 net/sched/act_police.c     | 7 ++++---
 net/sched/act_sample.c     | 7 ++++---
 net/sched/act_simple.c     | 7 ++++---
 net/sched/act_skbedit.c    | 7 ++++---
 net/sched/act_skbmod.c     | 7 ++++---
 net/sched/act_tunnel_key.c | 7 ++++---
 net/sched/act_vlan.c       | 7 ++++---
 21 files changed, 81 insertions(+), 62 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 8ec97644edf86d5d95960b74b9b57908ca19a198..2aa0060f51a6d7b0cbe0063792548469d41496e2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -149,7 +149,8 @@ struct tc_action_net {
 int tc_action_net_init(struct net *net, struct tc_action_net *tn,
 		       const struct tc_action_ops *ops);
 
-void tc_action_net_exit(struct list_head *net_list, unsigned int id);
+void tc_action_net_exit_batch_rtnl(struct list_head *net_list,
+				   unsigned int id);
 
 int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 		       struct netlink_callback *cb, int type,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9492eae0ebe5844419e1631122871d19b443bc4e..642ff499fa03cffe9873a987ee09ceb76707f2aa 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -921,20 +921,19 @@ static void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
 	idr_destroy(&idrinfo->action_idr);
 }
 
-void tc_action_net_exit(struct list_head *net_list, unsigned int id)
+void tc_action_net_exit_batch_rtnl(struct list_head *net_list, unsigned int id)
 {
 	struct net *net;
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct tc_action_net *tn = net_generic(net, id);
 
 		tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
 		kfree(tn->idrinfo);
 	}
-	rtnl_unlock();
 }
-EXPORT_SYMBOL(tc_action_net_exit);
+EXPORT_SYMBOL(tc_action_net_exit_batch_rtnl);
 
 static LIST_HEAD(act_base);
 static DEFINE_RWLOCK(act_mod_lock);
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc042f1e6f960fb5159153cc67fb27..cad8696ee505f6389cf5af56ea419650b1692d35 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -410,14 +410,15 @@ static __net_init int bpf_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_bpf_ops);
 }
 
-static void __net_exit bpf_exit_net(struct list_head *net_list)
+static void __net_exit bpf_exit_batch_rtnl(struct list_head *net_list,
+					   struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_bpf_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_bpf_ops.net_id);
 }
 
 static struct pernet_operations bpf_net_ops = {
 	.init = bpf_init_net,
-	.exit_batch = bpf_exit_net,
+	.exit_batch_rtnl = bpf_exit_batch_rtnl,
 	.id   = &act_bpf_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 0fce631e7c91113e5559d12ddc4d0ebeef1237e4..110618266ddbd727fa0d207071288d7a101776d5 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -251,14 +251,15 @@ static __net_init int connmark_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_connmark_ops);
 }
 
-static void __net_exit connmark_exit_net(struct list_head *net_list)
+static void __net_exit connmark_exit_batch_rtnl(struct list_head *net_list,
+						struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_connmark_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_connmark_ops.net_id);
 }
 
 static struct pernet_operations connmark_net_ops = {
 	.init = connmark_init_net,
-	.exit_batch = connmark_exit_net,
+	.exit_batch_rtnl = connmark_exit_batch_rtnl,
 	.id   = &act_connmark_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5cc8e407e7911c6c9f252d58b458728174913317..d2c2824317d5249ac86ddfa66e6f9d83afbded4c 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -718,14 +718,15 @@ static __net_init int csum_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_csum_ops);
 }
 
-static void __net_exit csum_exit_net(struct list_head *net_list)
+static void __net_exit csum_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_csum_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_csum_ops.net_id);
 }
 
 static struct pernet_operations csum_net_ops = {
 	.init = csum_init_net,
-	.exit_batch = csum_exit_net,
+	.exit_batch_rtnl = csum_exit_batch_rtnl,
 	.id   = &act_csum_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index baac083fd8f1096eb717a5ae6cd744ae15d6d17d..b3351e9a6ba541e3aefba70346aedd8b5a7de3a7 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1609,14 +1609,15 @@ static __net_init int ct_init_net(struct net *net)
 	return tc_action_net_init(net, &tn->tn, &act_ct_ops);
 }
 
-static void __net_exit ct_exit_net(struct list_head *net_list)
+static void __net_exit ct_exit_batch_rtnl(struct list_head *net_list,
+					  struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_ct_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_ct_ops.net_id);
 }
 
 static struct pernet_operations ct_net_ops = {
 	.init = ct_init_net,
-	.exit_batch = ct_exit_net,
+	.exit_batch_rtnl = ct_exit_batch_rtnl,
 	.id   = &act_ct_ops.net_id,
 	.size = sizeof(struct tc_ct_action_net),
 };
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5dd41a012110e04d4e7b199367a84fa1905156b3..5ee8b9ce32893782f99a75a1138e289fa8979e26 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -372,14 +372,15 @@ static __net_init int ctinfo_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_ctinfo_ops);
 }
 
-static void __net_exit ctinfo_exit_net(struct list_head *net_list)
+static void __net_exit ctinfo_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_ctinfo_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_ctinfo_ops.net_id);
 }
 
 static struct pernet_operations ctinfo_net_ops = {
 	.init		= ctinfo_init_net,
-	.exit_batch	= ctinfo_exit_net,
+	.exit_batch_rtnl = ctinfo_exit_batch_rtnl,
 	.id		= &act_ctinfo_ops.net_id,
 	.size		= sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e949280eb800d9558cf101ced8f0d9742926c5f7..ada08c61b6d4dfcc521de6c31c848dbd386607f7 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -305,14 +305,15 @@ static __net_init int gact_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_gact_ops);
 }
 
-static void __net_exit gact_exit_net(struct list_head *net_list)
+static void __net_exit gact_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_gact_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_gact_ops.net_id);
 }
 
 static struct pernet_operations gact_net_ops = {
 	.init = gact_init_net,
-	.exit_batch = gact_exit_net,
+	.exit_batch_rtnl = gact_exit_batch_rtnl,
 	.id   = &act_gact_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 1dd74125398a0f41751fab72397f006b2c63d1db..65946e3450262aaf515d23d9fcf1e40f85f4bbc9 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -654,14 +654,15 @@ static __net_init int gate_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_gate_ops);
 }
 
-static void __net_exit gate_exit_net(struct list_head *net_list)
+static void __net_exit gate_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_gate_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_gate_ops.net_id);
 }
 
 static struct pernet_operations gate_net_ops = {
 	.init = gate_init_net,
-	.exit_batch = gate_exit_net,
+	.exit_batch_rtnl = gate_exit_batch_rtnl,
 	.id   = &act_gate_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 107c6d83dc5c4b586b534bacd7b185bcf891812a..ad11ef0aade95358a2463f7bd7d786c5981dbf37 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -898,14 +898,15 @@ static __net_init int ife_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_ife_ops);
 }
 
-static void __net_exit ife_exit_net(struct list_head *net_list)
+static void __net_exit ife_exit_batch_rtnl(struct list_head *net_list,
+					   struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_ife_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_ife_ops.net_id);
 }
 
 static struct pernet_operations ife_net_ops = {
 	.init = ife_init_net,
-	.exit_batch = ife_exit_net,
+	.exit_batch_rtnl = ife_exit_batch_rtnl,
 	.id   = &act_ife_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d900c238c9a84d75201b6edf01ba198..97429da4491f15aa78064785b28eb2eed0b2c3f1 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -652,14 +652,15 @@ static __net_init int mirred_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_mirred_ops);
 }
 
-static void __net_exit mirred_exit_net(struct list_head *net_list)
+static void __net_exit mirred_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *batch_rtnl)
 {
-	tc_action_net_exit(net_list, act_mirred_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_mirred_ops.net_id);
 }
 
 static struct pernet_operations mirred_net_ops = {
 	.init = mirred_init_net,
-	.exit_batch = mirred_exit_net,
+	.exit_batch_rtnl = mirred_exit_batch_rtnl,
 	.id   = &act_mirred_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 44a37a71ae9236cc1967239d6db8aba74d77355c..347d439f87f3f8d9586081a90106b3efebb3eeed 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -461,14 +461,15 @@ static __net_init int mpls_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_mpls_ops);
 }
 
-static void __net_exit mpls_exit_net(struct list_head *net_list)
+static void __net_exit mpls_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_mpls_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_mpls_ops.net_id);
 }
 
 static struct pernet_operations mpls_net_ops = {
 	.init = mpls_init_net,
-	.exit_batch = mpls_exit_net,
+	.exit_batch_rtnl = mpls_exit_batch_rtnl,
 	.id   = &act_mpls_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index d541f553805face5a0d444659c17e0b720aeb843..af43b962d66838af715172cdb7f304b3e37e6aef 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -333,14 +333,15 @@ static __net_init int nat_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_nat_ops);
 }
 
-static void __net_exit nat_exit_net(struct list_head *net_list)
+static void __net_exit nat_exit_batch_rtnl(struct list_head *net_list,
+					   struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_nat_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_nat_ops.net_id);
 }
 
 static struct pernet_operations nat_net_ops = {
 	.init = nat_init_net,
-	.exit_batch = nat_exit_net,
+	.exit_batch_rtnl = nat_exit_batch_rtnl,
 	.id   = &act_nat_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index df5a02d5f919c3e8b26308f5128ee35f63e5401a..9509760d4663b8b18e2e9431cdde3043263e6a6e 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -629,14 +629,15 @@ static __net_init int pedit_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_pedit_ops);
 }
 
-static void __net_exit pedit_exit_net(struct list_head *net_list)
+static void __net_exit pedit_exit_batch_rtnl(struct list_head *net_list,
+					     struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_pedit_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_pedit_ops.net_id);
 }
 
 static struct pernet_operations pedit_net_ops = {
 	.init = pedit_init_net,
-	.exit_batch = pedit_exit_net,
+	.exit_batch_rtnl = pedit_exit_batch_rtnl,
 	.id   = &act_pedit_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 8555125ed34d83eaadd36391da869bd46f2372fe..00ed38e2632131ee00bb751f2db17078417078da 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -511,14 +511,15 @@ static __net_init int police_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_police_ops);
 }
 
-static void __net_exit police_exit_net(struct list_head *net_list)
+static void __net_exit police_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_police_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_police_ops.net_id);
 }
 
 static struct pernet_operations police_net_ops = {
 	.init = police_init_net,
-	.exit_batch = police_exit_net,
+	.exit_batch_rtnl = police_exit_batch_rtnl,
 	.id   = &act_police_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index a69b53d54039eda131bea4d4022ce1b86506c275..7da5cd7701d31014abdcae7450c97215b2947d40 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -325,14 +325,15 @@ static __net_init int sample_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_sample_ops);
 }
 
-static void __net_exit sample_exit_net(struct list_head *net_list)
+static void __net_exit sample_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_sample_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_sample_ops.net_id);
 }
 
 static struct pernet_operations sample_net_ops = {
 	.init = sample_init_net,
-	.exit_batch = sample_exit_net,
+	.exit_batch_rtnl = sample_exit_batch_rtnl,
 	.id   = &act_sample_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index f3abe05459895661d9600f719379773a55a1c456..e2620722a2f77478b53d1e5423a3a7afb3c2b78a 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -218,14 +218,15 @@ static __net_init int simp_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_simp_ops);
 }
 
-static void __net_exit simp_exit_net(struct list_head *net_list)
+static void __net_exit simp_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_simp_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_simp_ops.net_id);
 }
 
 static struct pernet_operations simp_net_ops = {
 	.init = simp_init_net,
-	.exit_batch = simp_exit_net,
+	.exit_batch_rtnl = simp_exit_batch_rtnl,
 	.id   = &act_simp_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 1f1d9ce3e968a2342a524c068d15912623de058f..ac4784315133c5b670a6bcb33a4f46aa843f090f 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -435,14 +435,15 @@ static __net_init int skbedit_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_skbedit_ops);
 }
 
-static void __net_exit skbedit_exit_net(struct list_head *net_list)
+static void __net_exit skbedit_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_skbedit_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_skbedit_ops.net_id);
 }
 
 static struct pernet_operations skbedit_net_ops = {
 	.init = skbedit_init_net,
-	.exit_batch = skbedit_exit_net,
+	.exit_batch_rtnl = skbedit_exit_batch_rtnl,
 	.id   = &act_skbedit_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 39945b139c4817584fb9803b9e65c89fef68eca0..cf01c94d2453cef229dbdb8ecb029af63ebb2b04 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -296,14 +296,15 @@ static __net_init int skbmod_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_skbmod_ops);
 }
 
-static void __net_exit skbmod_exit_net(struct list_head *net_list)
+static void __net_exit skbmod_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_skbmod_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_skbmod_ops.net_id);
 }
 
 static struct pernet_operations skbmod_net_ops = {
 	.init = skbmod_init_net,
-	.exit_batch = skbmod_exit_net,
+	.exit_batch_rtnl = skbmod_exit_batch_rtnl,
 	.id   = &act_skbmod_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 1536f8b16f1b250eb62ae5530f01cbc6f7ea632a..6d167a0feed1d5f3d29c06781ffc372743d123be 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -851,14 +851,15 @@ static __net_init int tunnel_key_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_tunnel_key_ops);
 }
 
-static void __net_exit tunnel_key_exit_net(struct list_head *net_list)
+static void __net_exit tunnel_key_exit_batch_rtnl(struct list_head *net_list,
+						  struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_tunnel_key_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_tunnel_key_ops.net_id);
 }
 
 static struct pernet_operations tunnel_key_net_ops = {
 	.init = tunnel_key_init_net,
-	.exit_batch = tunnel_key_exit_net,
+	.exit_batch_rtnl = tunnel_key_exit_batch_rtnl,
 	.id   = &act_tunnel_key_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 22f4b1e8ade9f5a5bb5ece4c2fc600f94d8053fd..6b0ab1750f05b3523d5c96abd2ab7820db57d4a0 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -436,14 +436,15 @@ static __net_init int vlan_init_net(struct net *net)
 	return tc_action_net_init(net, tn, &act_vlan_ops);
 }
 
-static void __net_exit vlan_exit_net(struct list_head *net_list)
+static void __net_exit vlan_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
-	tc_action_net_exit(net_list, act_vlan_ops.net_id);
+	tc_action_net_exit_batch_rtnl(net_list, act_vlan_ops.net_id);
 }
 
 static struct pernet_operations vlan_net_ops = {
 	.init = vlan_init_net,
-	.exit_batch = vlan_exit_net,
+	.exit_batch_rtnl = vlan_exit_batch_rtnl,
 	.id   = &act_vlan_ops.net_id,
 	.size = sizeof(struct tc_action_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


