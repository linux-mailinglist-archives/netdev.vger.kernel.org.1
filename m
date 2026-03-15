Return-Path: <netdev+bounces-267924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILCzF0PWtmkDJgEAu9opvQ
	(envelope-from <netdev+bounces-267924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:54:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960AC291480
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539553023371
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175F36E462;
	Sun, 15 Mar 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bj8t6OVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D39368941
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590080; cv=none; b=ll40FracsuT2DoXYtbsALNeYqLIWPOfOC7Hs1i8yosodrra4+taFtNrkP78Eux3YCY4McP0jJhoYRhkSqB3VCUy9+S5lEwPrJs32fSx4wPHQmF38G/VW+VSScXPTkir5eP4wOSlLC4prjBpMctJ7t+oydQAQ8skf46aZuQRzHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590080; c=relaxed/simple;
	bh=S5jvZCEQqQf4z9JLruedsXvdC+qRBkkS5+tcKM54mXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IHmQzteJUMEHvRPHLV7gpMu4AjL5M7nqww5ZRfNLA1GSoaPi4/GKMvxvSTgMX/6r6vy6/LV0zivnnSCHWTMW3eEv2fA+7Bnt9vrZK/ydEBBCfM3SXDkpRJ/aM6UoaifV4p4pDY0P7zD75W3Kj2ZAk7BiNx1cvOTV5rK/e0yJbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bj8t6OVX; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899fbf92bdbso50113896d6.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773590077; x=1774194877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P02NgkOon5+R73dtOQYvmE0YQTuOQwhyaum++5yhdVY=;
        b=bj8t6OVXiR4yGMQGSBHZwMkH+LiiKAJM/09eYoG1+TIKIknNWIktXRIbL46kytKQLx
         FknkbI7sxEn/ojFNvbS3XyAczbSKYDSLCoRgTLUDx4SAEQbjgyY8bYw25gIPvWNoabhZ
         ECjjsiq3E8b3+GPaLIqSUXKLk7HEPMVd8V9FsjZ0FKlVYmIcVWyTdcZhYQUz4/UgKPNP
         fYMC+cptfOa3ktm9OMtsQk5/YJ95mHXCdwwraVrIhUcfafuDehdWIq7j0jLv+ZJP2CJE
         H7Am/sy3ijV2M1yhIyLcW/OG6iacGHLdznZ6iSBqNjnzlfk/syuS6IbCxnAERClNJwZH
         ITWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590077; x=1774194877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P02NgkOon5+R73dtOQYvmE0YQTuOQwhyaum++5yhdVY=;
        b=HUvQ7dqwS0WwrNsLNeUW8nzVSw++KXrFqTCX0jTCGo9a2sGo4KCfTpcNfZJF6U8uMY
         Dgx1iGeFo/ErWoQZ6+bwjD2F/HR5zOF6/QoHFGU+1Nxnl1WnogYtLeKrDF1YzSJitM8e
         dspx+NIErSYdpg6Ek8r0aaQxSNmJtJcuyTyjQelSA1BjyfmAwVTsArx8otDc1d1TFIHT
         YV6J8ANl0cJJ7ijYocVBEL842banmiaok+zTWfF78u+Ctlbl9yezy6YmH0m1sryY3KwB
         JQdd6paBwkwlcBCS5D3JeICgTwdj6UxWzS1PT8pVJYuKtsnzg2CKerXAfw2NFw3b5z9L
         vtPA==
X-Gm-Message-State: AOJu0Yw4Z3Nzs1QU3D/qxUjl7R1VITbqGUsNtH7hQ1ER0FmDD4EyCnCo
	6zbw2FpMTVzw+6M3oFeEJlTerfuF7qH3OS+zOWOV5BcIhxR2bkUNRcwuuKmgnaMgzmTTI3DX9sQ
	u0Sc=
X-Gm-Gg: ATEYQzw/TU86LDbAv51G5TCh9ibuCdLq68GRIMAyqvScowZ+yhMJDdk8FgwavjeJXNj
	/uAyfg9zW1ClJon+5+JQIZMCOozcC2rQjENwrMOVu1ABaZFRzys+iP4DtaD1fSaoP3CsOymrfQu
	USDoa0n1ps+oShn9SSYuTDQKoqBBJxFDlj6ESXxjKe45epblx/xZpvKskmryktterdC2ufV3jdI
	73zO3IKpv7N46rjvn65svswPF7kvJfjn48tXw3RXj3OCCUtu+Ze3XdP8Tjb/78gzMToi9Rt3xb9
	vDel1Apv0l0OJhBwMFrbbCrPY+HT50VmtYTnLhAQCqojrDevk/FREeExybvNRqXOC0rL8TcRQdZ
	+IpgmV6jRXvW+p3KP386hMNJtoBfWNJlwwXB6CxorThI4kheh7EKGKJ6vkA0hqWJ2iv+b5w6KvY
	XRwDbEEJg/98gKk+WNKYMywPo=
X-Received: by 2002:a05:6214:40d:b0:89a:c09:aa8b with SMTP id 6a1803df08f44-89a81ec266emr168638176d6.39.1773590077413;
        Sun, 15 Mar 2026 08:54:37 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfc409sm103662326d6.35.2026.03.15.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:54:36 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	keenanat2000@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: teql: Fix double-free in teql_master_xmit
Date: Sun, 15 Mar 2026 11:54:22 -0400
Message-Id: <20260315155422.147256-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267924-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 960AC291480
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Whenever a TEQL devices has a lockless Qdisc as root, qdisc_reset should
be called using the seq_lock to avoid racing with the datapath. Failure
to do so may cause crashes like the following:

[  238.028993][  T318] BUG: KASAN: double-free in skb_release_data (net/core/skbuff.c:1139)
[  238.029328][  T318] Free of addr ffff88810c67ec00 by task poc_teql_uaf_ke/318
[  238.029749][  T318]
[  238.029900][  T318] CPU: 3 UID: 0 PID: 318 Comm: poc_teql_ke Not tainted 7.0.0-rc3-00149-ge5b31d988a41 #704 PREEMPT(full)
[  238.029906][  T318] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  238.029910][  T318] Call Trace:
[  238.029913][  T318]  <TASK>
[  238.029916][  T318]  dump_stack_lvl (lib/dump_stack.c:122)
[  238.029928][  T318]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
[  238.029940][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
[  238.029944][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
...
[  238.029957][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
[  238.029969][  T318]  kasan_report_invalid_free (mm/kasan/report.c:221 mm/kasan/report.c:563)
[  238.029979][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
[  238.029989][  T318]  check_slab_allocation (mm/kasan/common.c:231)
[  238.029995][  T318]  kmem_cache_free (mm/slub.c:2637 (discriminator 1) mm/slub.c:6168 (discriminator 1) mm/slub.c:6298 (discriminator 1))
[  238.030004][  T318]  skb_release_data (net/core/skbuff.c:1139)
...
[  238.030025][  T318]  sk_skb_reason_drop (net/core/skbuff.c:1256)
[  238.030032][  T318]  pfifo_fast_reset (./include/linux/ptr_ring.h:171 ./include/linux/ptr_ring.h:309 ./include/linux/skb_array.h:98 net/sched/sch_generic.c:827)
[  238.030039][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
...
[  238.030054][  T318]  qdisc_reset (net/sched/sch_generic.c:1034)
[  238.030062][  T318]  teql_destroy (./include/linux/spinlock.h:395 net/sched/sch_teql.c:157)
[  238.030071][  T318]  __qdisc_destroy (./include/net/pkt_sched.h:328 net/sched/sch_generic.c:1077)
[  238.030077][  T318]  qdisc_graft (net/sched/sch_api.c:1062 net/sched/sch_api.c:1053 net/sched/sch_api.c:1159)
[  238.030089][  T318]  ? __pfx_qdisc_graft (net/sched/sch_api.c:1091)
[  238.030095][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[  238.030102][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[  238.030106][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
[  238.030114][  T318]  tc_get_qdisc (net/sched/sch_api.c:1529 net/sched/sch_api.c:1556)
...
[  238.072958][  T318] Allocated by task 303 on cpu 5 at 238.026275s:
[  238.073392][  T318]  kasan_save_stack (mm/kasan/common.c:58)
[  238.073884][  T318]  kasan_save_track (mm/kasan/common.c:64 (discriminator 5) mm/kasan/common.c:79 (discriminator 5))
[  238.074230][  T318]  __kasan_slab_alloc (mm/kasan/common.c:369)
[  238.074578][  T318]  kmem_cache_alloc_node_noprof (./include/linux/kasan.h:253 mm/slub.c:4542 mm/slub.c:4869 mm/slub.c:4921)
[  238.076091][  T318]  kmalloc_reserve (net/core/skbuff.c:616 (discriminator 107))
[  238.076450][  T318]  __alloc_skb (net/core/skbuff.c:713)
[  238.076834][  T318]  alloc_skb_with_frags (./include/linux/skbuff.h:1383 net/core/skbuff.c:6763)
[  238.077178][  T318]  sock_alloc_send_pskb (net/core/sock.c:2997)
[  238.077520][  T318]  packet_sendmsg (net/packet/af_packet.c:2926 net/packet/af_packet.c:3019 net/packet/af_packet.c:3108)
[  238.081469][  T318]
[  238.081870][  T318] Freed by task 299 on cpu 1 at 238.028496s:
[  238.082761][  T318]  kasan_save_stack (mm/kasan/common.c:58)
[  238.083481][  T318]  kasan_save_track (mm/kasan/common.c:64 (discriminator 5) mm/kasan/common.c:79 (discriminator 5))
[  238.085348][  T318]  kasan_save_free_info (mm/kasan/generic.c:587 (discriminator 1))
[  238.085900][  T318]  __kasan_slab_free (mm/kasan/common.c:287)
[  238.086439][  T318]  kmem_cache_free (mm/slub.c:6168 (discriminator 3) mm/slub.c:6298 (discriminator 3))
[  238.087007][  T318]  skb_release_data (net/core/skbuff.c:1139)
[  238.087491][  T318]  consume_skb (net/core/skbuff.c:1451)
[  238.087757][  T318]  teql_master_xmit (net/sched/sch_teql.c:358)
[  238.088116][  T318]  dev_hard_start_xmit (./include/linux/netdevice.h:5324 ./include/linux/netdevice.h:5333 net/core/dev.c:3871 net/core/dev.c:3887)
[  238.088468][  T318]  sch_direct_xmit (net/sched/sch_generic.c:347)
[  238.088820][  T318]  __qdisc_run (net/sched/sch_generic.c:420 (discriminator 1))
[  238.089166][  T318]  __dev_queue_xmit (./include/net/sch_generic.h:229 ./include/net/pkt_sched.h:121 ./include/net/pkt_sched.h:117 net/core/dev.c:4196 net/core/dev.c:4802)

Workflow to reproduce:
1. Initialize a TEQL topology (dummy0 and ifb0 as slaves, teql0 up).
2. Start multiple sender workers continuously transmitting packets
   through teql0 to drive teql_master_xmit().
3. In parallel, repeatedly delete and re-add the root qdisc on
   dummy0 and ifb0 via RTNETLINK, forcing frequent teardown and reset activity
   (teql_destroy() / qdisc_reset()).
4. After running both workloads concurrently for several iterations,
   KASAN reports slab-use-after-free or double-free in the skb free path.

Fix this by moving dev_reset_queue to sch_generic.h and calling it, instead
of qdisc_reset, in teql_destroy since it handles both the lock and lockless
cases correctly for root qdiscs.

Fixes: 96009c7d500e ("sched: replace __QDISC_STATE_RUNNING bit with a spin lock")
Reported-by: Xianrui Dong <keenanat2000@gmail.com>
Tested-by: Xianrui Dong <keenanat2000@gmail.com>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h | 28 ++++++++++++++++++++++++++++
 net/sched/sch_generic.c   | 27 ---------------------------
 net/sched/sch_teql.c      |  7 ++-----
 3 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d5d55cb21686..cafb266a0b80 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -716,6 +716,34 @@ void qdisc_destroy(struct Qdisc *qdisc);
 void qdisc_put(struct Qdisc *qdisc);
 void qdisc_put_unlocked(struct Qdisc *qdisc);
 void qdisc_tree_reduce_backlog(struct Qdisc *qdisc, int n, int len);
+
+static inline void dev_reset_queue(struct net_device *dev,
+				   struct netdev_queue *dev_queue,
+				   void *_unused)
+{
+	struct Qdisc *qdisc;
+	bool nolock;
+
+	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
+	if (!qdisc)
+		return;
+
+	nolock = qdisc->flags & TCQ_F_NOLOCK;
+
+	if (nolock)
+		spin_lock_bh(&qdisc->seqlock);
+	spin_lock_bh(qdisc_lock(qdisc));
+
+	qdisc_reset(qdisc);
+
+	spin_unlock_bh(qdisc_lock(qdisc));
+	if (nolock) {
+		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
+		spin_unlock_bh(&qdisc->seqlock);
+	}
+}
+
 #ifdef CONFIG_NET_SCHED
 int qdisc_offload_dump_helper(struct Qdisc *q, enum tc_setup_type type,
 			      void *type_data);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 98ffe64de51f..9e726c3bd86b 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1288,33 +1288,6 @@ static void dev_deactivate_queue(struct net_device *dev,
 	}
 }
 
-static void dev_reset_queue(struct net_device *dev,
-			    struct netdev_queue *dev_queue,
-			    void *_unused)
-{
-	struct Qdisc *qdisc;
-	bool nolock;
-
-	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
-	if (!qdisc)
-		return;
-
-	nolock = qdisc->flags & TCQ_F_NOLOCK;
-
-	if (nolock)
-		spin_lock_bh(&qdisc->seqlock);
-	spin_lock_bh(qdisc_lock(qdisc));
-
-	qdisc_reset(qdisc);
-
-	spin_unlock_bh(qdisc_lock(qdisc));
-	if (nolock) {
-		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
-		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
-		spin_unlock_bh(&qdisc->seqlock);
-	}
-}
-
 static bool some_qdisc_is_busy(struct net_device *dev)
 {
 	unsigned int i;
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 783300d8b019..ec4039a201a2 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -146,15 +146,12 @@ teql_destroy(struct Qdisc *sch)
 					master->slaves = NEXT_SLAVE(q);
 					if (q == master->slaves) {
 						struct netdev_queue *txq;
-						spinlock_t *root_lock;
 
 						txq = netdev_get_tx_queue(master->dev, 0);
 						master->slaves = NULL;
 
-						root_lock = qdisc_root_sleeping_lock(rtnl_dereference(txq->qdisc));
-						spin_lock_bh(root_lock);
-						qdisc_reset(rtnl_dereference(txq->qdisc));
-						spin_unlock_bh(root_lock);
+						dev_reset_queue(master->dev,
+								txq, NULL);
 					}
 				}
 				skb_queue_purge(&dat->q);
-- 
2.34.1


