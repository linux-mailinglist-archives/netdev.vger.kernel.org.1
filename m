Return-Path: <netdev+bounces-237060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B78C44204
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A4E4E221C
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6773002D0;
	Sun,  9 Nov 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG5rJP93"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344DDF59
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704741; cv=none; b=DrVrtaC4Fz5z+06JTy3Z2OPefKZfBOqBw6Awpvtxr7BC0MKEWyE2yfYtO+m8UjmbTwAdtMsjLdEiEBmm/jxk76s49ShGMtXAKnqyVYoL3JCwSXgvz7hi0wbkSWJK5ViDUJ6dtyKTBw1Ie+Vjs5cyf3RWhj7U7x5X2p9CRQU6A9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704741; c=relaxed/simple;
	bh=Tr2DF9KzB1NRAIFLubMG0jG17obtl2srSJCb8gBHsLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HU29xhEeP5UTfmQQGt98jdOd17Lp88IyJa/Il75xcX05LSSQSesFdAEjjnoWBI4qSKFF5d9bjqDAeHicRGDgnWN8Xpmh/CxIg1yWkJQVAuEnBTRPBvl9l1bUr7q7b0RnD13MErNu+MV6UWwNinPPUPieNCCHiUxqIlR42MYB5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG5rJP93; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8823acf4db3so38043206d6.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762704739; x=1763309539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtTxg6rVfWpXfJJZKRhlfjfvqQYRJ1U4XckJOZaQCUs=;
        b=TG5rJP93tBQBgidYOvf3OTCJyFNqoWsWnPJrG0Sh4zFM9+TcHSQpET+0Ieb9dP1Y7S
         X3+yvG+yXzvqG1rBM68qnWCX1YHZPVdug0fkxd/ugyK0iYPXdN/q43bY4Vm4LIRlf5+G
         6FD/Ph1CXgDwlznThT/UmJBUU8S23c+5Vd2WI3qpcoJ77Gi6CyUtlEIuLseGIZwU08HC
         zpprQQzljuUZIyKzaf1GOoLjWrnY3sJt0evpF1NhqnXl0TCUohJJwX76v/389akozJsD
         6rADd5au4C1smNxIqgG0nGElVnpdN1iB979LcVN5p4B82I7mnkCFLWgaQonDzWGTj9y5
         FarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704739; x=1763309539;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtTxg6rVfWpXfJJZKRhlfjfvqQYRJ1U4XckJOZaQCUs=;
        b=C2D3sJ0lftOy7iSytAWH/4NVC2U6MWYbbNEGVbnpkdWrf9GD30WjrWwbgEF3pee5d0
         dFHgK649dFc1CZr+MSeGWY9NWdeRAM1lLk5ERy4s1MeZKnd9usCM+S3RZ8fKImxShu54
         VkJ8dUbpkT0RwbwIadkOQBN91rw+clsOd1AvWddjXVamFJRB7lidDGwyIkTdyH0LRPoP
         AvmlQZ/TGJhlgcNF7DZEzQhoZyOmiNkFPwkEPPqBUIwXayYonFihVZAFHNyVs2DJk7/m
         cFEiizGmCGD5ArNUS2FxFEfOFULZv447oEHcZbkFB4hte/Md331cMkjFM+xoZORhF6A2
         VkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8xWPFhyfVRIlESOtxmRhWln7zBh0+4JcTSFsw9YHRflCfy6N/MEP8UCBHz3my2eFZBhxHa2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK898XroK4UkCKyPUpGg7Feg0HMeFLinjLe8Gtz2erC5c7XR10
	rHU1odjTqmLUZ6m95XSE2bzoLyOwP4FuBDfuo7T/5hvnAHl3NlaGiHKWFwzneGDorNOqccKPEPT
	Rz+NOVSe9jwpEfQ==
X-Google-Smtp-Source: AGHT+IEMOmj++dm93IXR1N6d/AdRHU2bo4QPK8w4tOBFnhQn2yRABQR1W4++8sX5S8+QciGHU4Rb4UdPofyNxg==
X-Received: from qvbdy7.prod.google.com ([2002:ad4:4e87:0:b0:882:37ff:bbe0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:23c8:b0:880:4dd2:1d15 with SMTP id 6a1803df08f44-882386d0bddmr64364896d6.44.1762704738624;
 Sun, 09 Nov 2025 08:12:18 -0800 (PST)
Date: Sun,  9 Nov 2025 16:12:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109161215.2574081-1-edumazet@google.com>
Subject: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
I started seeing many qdisc requeues on IDPF under high TX workload.

$ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle 1:
qdisc mq 1: root
 Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 requeu=
es 3532840114)
 backlog 1056Kb 6675p requeues 3532840114
qdisc mq 1: root
 Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 requeu=
es 3537737653)
 backlog 781164b 4822p requeues 3537737653

This is caused by try_bulk_dequeue_skb() being only limited by BQL budget.

perf record -C120-239 -e qdisc:qdisc_dequeue sleep 1 ; perf script
...
 netperf 75332 [146]  2711.138269: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1292 =
skbaddr=3D0xff378005a1e9f200
 netperf 75332 [146]  2711.138953: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1213 =
skbaddr=3D0xff378004d607a500
 netperf 75330 [144]  2711.139631: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1233 =
skbaddr=3D0xff3780046be20100
 netperf 75333 [147]  2711.140356: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1093 =
skbaddr=3D0xff37800514845b00
 netperf 75337 [151]  2711.141037: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1353 =
skbaddr=3D0xff37800460753300
 netperf 75337 [151]  2711.141877: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1367 =
skbaddr=3D0xff378004e72c7b00
 netperf 75330 [144]  2711.142643: qdisc:qdisc_dequeue: dequeue ifindex=3D5=
 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1202 =
skbaddr=3D0xff3780045bd60000
...

This is bad because :

1) Large batches hold one victim cpu for a very long time.

2) Driver often hit their own TX ring limit (all slots are used).

3) We call dev_requeue_skb()

4) Requeues are using a FIFO (q->gso_skb), breaking qdisc ability to
   implement FQ or priority scheduling.

5) dequeue_skb() gets packets from q->gso_skb one skb at a time
   with no xmit_more support. This is causing many spinlock games
   between the qdisc and the device driver.

Requeues were supposed to be very rare, lets keep them this way.

Limit batch sizes to /proc/sys/net/core/dev_weight (default 64) as
__qdisc_run() was designed to use.

Fixes: 5772e9a3463b ("qdisc: bulk dequeue support for qdiscs with TCQ_F_ONE=
TXQUEUE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/sched/sch_generic.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d9a98d02a55fc361a223f3201e37b6a2b698bb5e..852e603c17551ee719bf1c56184=
8d5ef0699ab5d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -180,9 +180,10 @@ static inline void dev_requeue_skb(struct sk_buff *skb=
, struct Qdisc *q)
 static void try_bulk_dequeue_skb(struct Qdisc *q,
 				 struct sk_buff *skb,
 				 const struct netdev_queue *txq,
-				 int *packets)
+				 int *packets, int budget)
 {
 	int bytelimit =3D qdisc_avail_bulklimit(txq) - skb->len;
+	int cnt =3D 0;
=20
 	while (bytelimit > 0) {
 		struct sk_buff *nskb =3D q->dequeue(q);
@@ -193,8 +194,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		bytelimit -=3D nskb->len; /* covers GSO len */
 		skb->next =3D nskb;
 		skb =3D nskb;
-		(*packets)++; /* GSO counts as one pkt */
+		if (++cnt >=3D budget)
+			break;
 	}
+	(*packets) +=3D cnt;
 	skb_mark_not_on_list(skb);
 }
=20
@@ -228,7 +231,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
  * A requeued skb (via q->gso_skb) can also be a SKB list.
  */
 static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
-				   int *packets)
+				   int *packets, int budget)
 {
 	const struct netdev_queue *txq =3D q->dev_queue;
 	struct sk_buff *skb =3D NULL;
@@ -295,7 +298,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, boo=
l *validate,
 	if (skb) {
 bulk:
 		if (qdisc_may_bulk(q))
-			try_bulk_dequeue_skb(q, skb, txq, packets);
+			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
 			try_bulk_dequeue_skb_slow(q, skb, packets);
 	}
@@ -387,7 +390,7 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc =
*q,
  *				>0 - queue is not empty.
  *
  */
-static inline bool qdisc_restart(struct Qdisc *q, int *packets)
+static inline bool qdisc_restart(struct Qdisc *q, int *packets, int budget=
)
 {
 	spinlock_t *root_lock =3D NULL;
 	struct netdev_queue *txq;
@@ -396,7 +399,7 @@ static inline bool qdisc_restart(struct Qdisc *q, int *=
packets)
 	bool validate;
=20
 	/* Dequeue packet */
-	skb =3D dequeue_skb(q, &validate, packets);
+	skb =3D dequeue_skb(q, &validate, packets, budget);
 	if (unlikely(!skb))
 		return false;
=20
@@ -414,7 +417,7 @@ void __qdisc_run(struct Qdisc *q)
 	int quota =3D READ_ONCE(net_hotdata.dev_tx_weight);
 	int packets;
=20
-	while (qdisc_restart(q, &packets)) {
+	while (qdisc_restart(q, &packets, quota)) {
 		quota -=3D packets;
 		if (quota <=3D 0) {
 			if (q->flags & TCQ_F_NOLOCK)
--=20
2.51.2.1041.gc1ab5b90ca-goog


