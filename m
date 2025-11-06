Return-Path: <netdev+bounces-236176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F329C3958B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12E3C350158
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848922DC79A;
	Thu,  6 Nov 2025 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuDRSewi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D552DC771
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413058; cv=none; b=ggI7KSN5d0nTkFpulUa4bXrBFpjDz98p1tLkGQxhjC94aV24cSCco+Xi1QOUwGsArayNIPz4+QTPd9zE9YgOSCfQc5s5F1y9yRrbVc5amslTG0fj58KJcLHoqWTU5gRP+tlgZSxXSFQgMCTawUN6H6pj+YrMlr1qaQ0g62CKWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413058; c=relaxed/simple;
	bh=MB+XLF/5lrlSsNRq80ncZSGCgLukoucv93u0lia3pbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OCnmAtW+d4E//Ko0tlIrdgbQsZaljKVnUkP10ATnsgKgpWBRXb7GBe8YUHrMKgxxnRP9x+kfZ/ZgnFRpvKwOUqDxK3fFED3Bs1Ta2tbp4MrrtXUSlwqKweLE97CicxIDLqs+hpDDn4jk7m1lm8Lo9VdZSJU1N2sTPKvwA6uRTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuDRSewi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso108054a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 23:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413056; x=1763017856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoMYGNsEASRc8E4ktJJFwUwoGxbKsHxWxvqcAB7YOpY=;
        b=VuDRSewi02wPYD63OaicYy3YyV2rYFZ8yzm+a8kqSj3mS0MZNTpZ7B6Xd63+nFVjnX
         wWkJm0XR7Ce0JIDkcRT6WARDveZsHV4jn2vie6ufdw0BopKgVbOgGB98ux3MPf+44zKT
         eSGax1RKekJAfkISMiOVWGzzxBbL33rnCvOAerB41M/Ysieymi0Boa/ORutpLlVqYea8
         1rjsSKBLdtY560BvBQrCN9AM5sPdCA9s3/PLHh4qYYxILWLIsRfXEVsPbGl8gmi77W6q
         A7BggeS7leY519NP8rSZiEh3/RfJuySc2zuNn/6HnVYfAiG3/Nizd4g9GcDMip9/n7RZ
         Z0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413056; x=1763017856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoMYGNsEASRc8E4ktJJFwUwoGxbKsHxWxvqcAB7YOpY=;
        b=xNk2M6P86tDwai/Qx0OVVIAUarsEepji5ft541eVLpJmiuWxBD10AXtKpasutcTYia
         jtdTY1es4h94lIJq6Er34EZUTbYz7DvgrSqWd2whA4lBVDFIxYcBcLtTg0PdbUr2Dd53
         9ZIGj/ZVKhlEZ8gbmM7BhO10Bk9BJjQQ5KEsRVjHVr8R1rIFefTMRMJt6HwgLkj9uRn5
         1tU7BcHtuy70THSkVL1iH8PZD2DwxQnBZXe7fp2TS3++PWyXylBL5EsSRWmjYw9X6Es4
         1woCpoXcp7ga/tkhuGSqgyTYhpvlkcTLp9lZqFmMHOw1xdjE4cpBvDeMi8lMd0BQb8P0
         6NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61MLeHGfyvm2iJ6RR6h+at0oLttgAWkYnAGFy3K2kCtBiZkCrSb7vDTCEl+8pVvH5dFr85ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5StdUsncH2Og2c2MieBNluUpj0wQ++wNuKVZ2LUpxzksQ3cd
	+RiQF8/nOVRoV1NYnEZbEu9BU/7ozljtshCTFzps10imd/1YiPV8lqXxSpXHT8ca1jX3mOteAxM
	CoV30gA==
X-Google-Smtp-Source: AGHT+IFsHpOKoZy7mtv/Htp1etKECoEebF0GIGofclxOqPtE8JiX9h7JCD2b3fi0hxiqOfyztwDkEYuWGRo=
X-Received: from plble11.prod.google.com ([2002:a17:902:fb0b:b0:296:18d:ea1c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec7:b0:295:a1a5:baf7
 with SMTP id d9443c01a7336-2962ad96af4mr75567885ad.37.1762413055950; Wed, 05
 Nov 2025 23:10:55 -0800 (PST)
Date: Thu,  6 Nov 2025 07:10:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106071050.494080-1-kuniyu@google.com>
Subject: [PATCH v1 net] net: sched: sch_qfq: Fix use-after-free in qfq_reset_qdisc().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Paolo Valente <paolo.valente@unimore.it>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free in qfq_reset_qdisc() while
accessing struct qfq_class hashed in qfq_sched.clhash.hash[]. [0]

When qfq_find_agg() returns NULL in qfq_change_class(),
struct qfq_aggregate is allocated.

If it fails, qfq_class is kfree()d at the destroy_class: label.

However, if it happens when qfq_change_class() is called for an
existing class, just freeing it is not sufficient, leaking the old
qfq_aggregate and leaving qfq_class in qfq_sched.clhash.hash[].

Let's call qfq_delete_class() in such a case.

We need to move up qfq_destroy_class() and qfq_delete_class().

[0]:
BUG: KASAN: slab-use-after-free in qfq_reset_qdisc+0xcc/0x208 net/sched/sch_qfq.c:1484
Read of size 8 at addr ffff0000ca2bfe50 by task syz.0.17/6716
CPU: 0 UID: 0 PID: 6716 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 qfq_reset_qdisc+0xcc/0x208 net/sched/sch_qfq.c:1484
 qdisc_reset+0x128/0x598 net/sched/sch_generic.c:1038
 __qdisc_destroy+0x134/0x4bc net/sched/sch_generic.c:1077
 qdisc_put net/sched/sch_generic.c:1109 [inline]
 dev_shutdown+0x35c/0x47c net/sched/sch_generic.c:1497
 unregister_netdevice_many_notify+0xbb8/0x1de0 net/core/dev.c:12242
 unregister_netdevice_many net/core/dev.c:12317 [inline]
 unregister_netdevice_queue+0x2b4/0x300 net/core/dev.c:12161
 unregister_netdevice include/linux/netdevice.h:3389 [inline]
 __tun_detach+0x5d4/0x1304 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x118/0x1f8 drivers/net/tun.c:3436
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Allocated by task 6716:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:573
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3a4/0x65c mm/slub.c:5748
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 qfq_change_class+0x498/0xbe8 net/sched/sch_qfq.c:479
 __tc_ctl_tclass net/sched/sch_api.c:2274 [inline]
 tc_ctl_tclass+0x988/0x10b0 net/sched/sch_api.c:2304
 rtnetlink_rcv_msg+0x624/0x97c net/core/rtnetlink.c:6963
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6981
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2719
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 6716:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:77
 __kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2523 [inline]
 slab_free mm/slub.c:6611 [inline]
 kfree+0x184/0x600 mm/slub.c:6818
 qfq_change_class+0x92c/0xbe8 net/sched/sch_qfq.c:533
 __tc_ctl_tclass net/sched/sch_api.c:2274 [inline]
 tc_ctl_tclass+0x988/0x10b0 net/sched/sch_api.c:2304
 rtnetlink_rcv_msg+0x624/0x97c net/core/rtnetlink.c:6963
 netlink_rcv_skb+0x220/0x3fc net/netlink/af_netlink.c:2552
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6981
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x694/0x8c4 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x648/0x930 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x490/0x7b8 net/socket.c:2630
 ___sys_sendmsg+0x204/0x278 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __arm64_sys_sendmsg+0x184/0x238 net/socket.c:2719
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/690c48f2.050a0220.baf87.0080.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sched/sch_qfq.c | 68 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2255355e51d3..3d1522b1b88a 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -403,6 +403,36 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 	return 0;
 }
 
+static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
+{
+	gen_kill_estimator(&cl->rate_est);
+	qdisc_put(cl->qdisc);
+	kfree(cl);
+}
+
+static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
+			    struct netlink_ext_ack *extack)
+{
+	struct qfq_sched *q = qdisc_priv(sch);
+	struct qfq_class *cl = (struct qfq_class *)arg;
+
+	if (qdisc_class_in_use(&cl->common)) {
+		NL_SET_ERR_MSG_MOD(extack, "QFQ class in use");
+		return -EBUSY;
+	}
+
+	sch_tree_lock(sch);
+
+	qdisc_purge_queue(cl->qdisc);
+	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	qfq_rm_from_agg(q, cl);
+
+	sch_tree_unlock(sch);
+
+	qfq_destroy_class(sch, cl);
+	return 0;
+}
+
 static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			    struct nlattr **tca, unsigned long *arg,
 			    struct netlink_ext_ack *extack)
@@ -511,6 +541,10 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		new_agg = kzalloc(sizeof(*new_agg), GFP_KERNEL);
 		if (new_agg == NULL) {
 			err = -ENOBUFS;
+
+			if (existing)
+				goto delete_class;
+
 			gen_kill_estimator(&cl->rate_est);
 			goto destroy_class;
 		}
@@ -528,40 +562,14 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	*arg = (unsigned long)cl;
 	return 0;
 
-destroy_class:
-	qdisc_put(cl->qdisc);
-	kfree(cl);
+delete_class:
+	qfq_delete_class(sch, (unsigned long)cl, extack);
 	return err;
-}
 
-static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
-{
-	gen_kill_estimator(&cl->rate_est);
+destroy_class:
 	qdisc_put(cl->qdisc);
 	kfree(cl);
-}
-
-static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
-			    struct netlink_ext_ack *extack)
-{
-	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_class *cl = (struct qfq_class *)arg;
-
-	if (qdisc_class_in_use(&cl->common)) {
-		NL_SET_ERR_MSG_MOD(extack, "QFQ class in use");
-		return -EBUSY;
-	}
-
-	sch_tree_lock(sch);
-
-	qdisc_purge_queue(cl->qdisc);
-	qdisc_class_hash_remove(&q->clhash, &cl->common);
-	qfq_rm_from_agg(q, cl);
-
-	sch_tree_unlock(sch);
-
-	qfq_destroy_class(sch, cl);
-	return 0;
+	return err;
 }
 
 static unsigned long qfq_search_class(struct Qdisc *sch, u32 classid)
-- 
2.51.2.1026.g39e6a42477-goog


