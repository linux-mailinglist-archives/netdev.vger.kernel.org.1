Return-Path: <netdev+bounces-82307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98D88D299
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F92E73BB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888313D8B2;
	Tue, 26 Mar 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qTdx9nXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F713D8AA
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494208; cv=none; b=sZbK3k3+Hs6HOKp/OYdLXahOR/3c2StQ3y2C6QVvTbtyhn06t/bFm5LBR0hotxP/kVOCdr7fVQhq0DxKY2LBt3DgAOh2g5k2B6AYhonCyeumXzHu+3hDeRCD7iFCsR4nzI5shF7If3u7PXpIkhTPEKj2sPdNSIu/sqscIxGN8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494208; c=relaxed/simple;
	bh=qqP+VO9v+q87Uvqjkf19GSXHf4GmEUarKFKmhUE99+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q15uc5fgS/R4QROWg/9GBO3K1LyYXnZjM2DUIapsUKv5OR1QmhAwv49LVsbT6MaVuP7JJk14dN0kLePKHZvYJ2iOy+mfWZKM5Op+r2mbj4Irpn/cNP6KvlCtdWTYd+CpQDNzpGK1M8NYj4GINWQmPfmVGg3EW+mOMk2gMP5U2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qTdx9nXc; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3ca3c3bbaso1687468b6e.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711494205; x=1712099005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ELcCtWI9dleO2se6oYTKhZyKF5RN417FYqDmXsdIk=;
        b=qTdx9nXcPAleJ/9zYoKm7u9hEC0YIKpw+4BU2AnJ4zkcdxEBt/I0uD6atcLVGfl1IC
         egue+ATNgzkSao7JPfeO+HGGy355r7o0TFGlNha3s2viskMA/WGrCmcducVm4C+YGaGu
         DX3USk4CQJXvVpLuWhi2Svv66KUG4vHw5+REjbyWk9wKcL3fiJU+92/Rs9g1lpIAC8iG
         XTpINY4Vv4DvWCqAEKaZl+vDvlpY0so1eLzpD8qYw0lA8QuQfxZ+dYsHpivIbftUZ4SH
         kD4O66eC628CtSFYr+cipmPU9wNCTavMQ++0HQhsoyTCRitIM0Zlvcfo9K6HCyjncX3x
         y+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494205; x=1712099005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0ELcCtWI9dleO2se6oYTKhZyKF5RN417FYqDmXsdIk=;
        b=egSunmW+42RSEB0prccp7NAxq0SoaD0PUNcs+0+GOCsVKGzlXAQ2d639JVKlTTR02z
         yjG2auRjsNRbYIxIVf92gmpwKcKZi6x22GoLwLaKdwZlzw4InapRt8G2+iS//2XvF5um
         +vl+De6G6k4BtusHrWYC8czJpHoSDRDskIUy77yzrIqXouOl9TEpXWOJdpQNFcJwuNn5
         7t+ZMhSTLM4k1l3HdID9jrRLLDxJ9a1CLKACpaOtxVyN+qK1h60QiM4GWvaM0p5HJycm
         n0KWpI5V4EgGzJY1AF0b+NEP5yujplCb8YDyGkqTNMsUFJgowAsrkxRp91soYg70OCEI
         X1HA==
X-Forwarded-Encrypted: i=1; AJvYcCW//cfqfwlUtaqGxf77jJShqoXjfjmwO5CEQ0bWt5LRo5ABSjPqMd4d4dh55fdtoQfSRtKzHhjxXBVgUh3xQ3BhyK2P3gPQ
X-Gm-Message-State: AOJu0YxMUH/OkjyzEP0DU5sT/DISlaDDGz5bclhaFjyQNy5VTAS7haU4
	ZEcH6G4ut3XBnRDgbKePQipS3SA/OkyPYRPCgBloQPdZSXQ5qdnsrI4Q/d9HzA==
X-Google-Smtp-Source: AGHT+IE9iQBbXpFtvs6WovKZDfTZUp3xtSfK1gLaMSWLmLOk56ZpW+iJO2C+Kveua+ZyIiAyr7YVyg==
X-Received: by 2002:a05:6808:2f0a:b0:3c3:bf5a:a903 with SMTP id gu10-20020a0568082f0a00b003c3bf5aa903mr15784765oib.10.1711494205249;
        Tue, 26 Mar 2024 16:03:25 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id gs11-20020a056214226b00b00696944e3ce6sm1982742qvb.74.2024.03.26.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 16:03:24 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	renmingshuai@huawei.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
Date: Tue, 26 Mar 2024 19:03:19 -0400
Message-Id: <20240326230319.190117-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mirred action is used on a classful egress qdisc and a packet is
mirrored or redirected to self we hit a qdisc lock deadlock.
See trace below.

[..... other info removed for brevity....]
[   82.890906]
[   82.890906] ============================================
[   82.890906] WARNING: possible recursive locking detected
[   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
[   82.890906] --------------------------------------------
[   82.890906] ping/418 is trying to acquire lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] but task is already holding lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] other info that might help us debug this:
[   82.890906]  Possible unsafe locking scenario:
[   82.890906]
[   82.890906]        CPU0
[   82.890906]        ----
[   82.890906]   lock(&sch->q.lock);
[   82.890906]   lock(&sch->q.lock);
[   82.890906]
[   82.890906]  *** DEADLOCK ***
[   82.890906]
[..... other info removed for brevity....]

Example setup (eth0->eth0) to recreate
tc qdisc add dev eth0 root handle 1: htb default 30
tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth0

Another example(eth0->eth1->eth0) to recreate
tc qdisc add dev eth0 root handle 1: htb default 30
tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth1

tc qdisc add dev eth1 root handle 1: htb default 30
tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth0

We fix this by adding a per-cpu, per-qdisc recursion counter which is
incremented the first time a root qdisc is entered and on a second attempt
enter the same root qdisc from the top, the packet is dropped to break the
loop.

Reported-by: renmingshuai@huawei.com
Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmingshuai@huawei.com/
Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action()")
Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loops")
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h |  2 ++
 net/core/dev.c            |  9 +++++++++
 net/sched/sch_api.c       | 12 ++++++++++++
 net/sched/sch_generic.c   |  2 ++
 4 files changed, 25 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index cefe0c4bdae3..f9f99df037ed 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -125,6 +125,8 @@ struct Qdisc {
 	spinlock_t		busylock ____cacheline_aligned_in_smp;
 	spinlock_t		seqlock;
 
+	u16 __percpu            *xmit_recursion;
+
 	struct rcu_head		rcu;
 	netdevice_tracker	dev_tracker;
 	/* private data */
diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db..2b712388c06f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3789,6 +3789,13 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 
+	if (__this_cpu_read(*q->xmit_recursion) > 0) {
+		__qdisc_drop(skb, &to_free);
+		rc = NET_XMIT_DROP;
+		goto free_skb_list;
+	}
+
+	__this_cpu_inc(*q->xmit_recursion);
 	spin_lock(root_lock);
 	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
 		__qdisc_drop(skb, &to_free);
@@ -3825,7 +3832,9 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		}
 	}
 	spin_unlock(root_lock);
+	__this_cpu_dec(*q->xmit_recursion);
 	if (unlikely(to_free))
+free_skb_list:
 		kfree_skb_list_reason(to_free,
 				      tcf_get_drop_reason(to_free));
 	if (unlikely(contended))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65e05b0c98e4..6c3bc1aff89a 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1260,6 +1260,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	struct Qdisc *sch;
 	struct Qdisc_ops *ops;
 	struct qdisc_size_table *stab;
+	int cpu;
 
 	ops = qdisc_lookup_ops(kind);
 #ifdef CONFIG_MODULES
@@ -1376,11 +1377,22 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		}
 	}
 
+	sch->xmit_recursion = alloc_percpu(u16);
+	if (!sch->xmit_recursion) {
+		err = -ENOMEM;
+		goto err_out5;
+	}
+	for_each_possible_cpu(cpu)
+		(*per_cpu_ptr(sch->xmit_recursion, cpu)) = 0;
+
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
 	return sch;
 
+err_out5:
+	if (tca[TCA_RATE])
+		gen_kill_estimator(&sch->rate_est);
 err_out4:
 	/* Even if ops->init() failed, we call ops->destroy()
 	 * like qdisc_create_dflt().
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ff5336493777..afbbd2e885a4 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1070,6 +1070,8 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 	module_put(ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
+	free_percpu(qdisc->xmit_recursion);
+
 	trace_qdisc_destroy(qdisc);
 
 	call_rcu(&qdisc->rcu, qdisc_free_cb);
-- 
2.34.1


