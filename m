Return-Path: <netdev+bounces-237132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06542C45B47
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58A93346A07
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C49302163;
	Mon, 10 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtFo8T6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C18301707
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767933; cv=none; b=pdLO3f0bBYV0j1V7K4+IrzamkinJdvTjHiPkh+9hcMjbkMsF9oy8Lv18swZn5YYZusCG5f//ADepGCrjLBU4nlPLx7fn0r5l8EzzAy3hXke/rILTwiMv6O5tXoS84QZTw03MY7rftejZapIPhv9NwkBU4cbAFLsxWRuUK3NiuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767933; c=relaxed/simple;
	bh=x9hRh6kPk4xWqMIsox6uD0qevHjHm0NztzPuL5PW31o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yv/fP6VzM4pqXSIIs/haS8y2y8sv+FlN3abQiHs4BKOepGLXxWXsVZMrMndB+XKAHghQA3xj2yo49iWVJYWVwSpXhQRQb77qYZzhzRHtFYiRtsvEpDe8Ew8HSMpgs1LBQ0owW6FdYmu0oQJeO3//PWDh+8r8CECQkG8qocdpCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtFo8T6c; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b22c87f005so933222585a.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767930; x=1763372730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEXmGD+VTLhhuF4Skfg/6qkUPU9a2pgt8hIteRNKH/s=;
        b=BtFo8T6cOKe5MbzlJRgKQsMtirpb8yn7wTzaqCBzZVboCG9/NxxOn5U5DGTGjVnK4V
         pb/hktEs5UwVoMDPgjd7ldd8U7JI8mRU9fBEvZEKlEpE0Co48g1OugTtGB0rGQgW6OFl
         cyOOgsHVluUiTvUskrDyyzzvXLFD45sSzfc5rOgNVTiwE+a9aMEwfgwx45VeGIxrZudm
         a4k5HwZ9anDyohkYMfDcII/1uXda6UlaJNymkcIYU+8OjjIPp9rjeeLWTkYBfzvO2O67
         BlE7M6/uFSv8EF5H6DRee38nPNXlDS3AcQ4Pw5alUn69SKn/OYTeI5Y3fGVNhSgEgP5C
         BLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767930; x=1763372730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEXmGD+VTLhhuF4Skfg/6qkUPU9a2pgt8hIteRNKH/s=;
        b=FLzZMlKYvwipyhNySAhPc6RB/SzIC9IsoS+4aXwTTKh/byGushZGAlNlgYCjdosGQx
         UC24xBlcBuySoKItynAMNmTxxWej0gbR0++X7GOUnnjBnc5wj1BtVSUzkw0WfOWvWLf8
         xs+O2Ubn7OsFl2edBmNZ6bmc6nF8ixyz6E5ewNsI4B3uCFHBUQ38yMmOGI4vwOAa+DvR
         gL98JR8ETfedWD7utrK60fYFVH5gkhgGwicnsnrH95C3sLeSN9JU82HAkJHOhA7efT5u
         L8mHAJDR3beK0h2nhJmE6tD8WcCTiMmiTNBnJtt0m1I7CcmCnjIIPdqsavRgNCAfd62k
         znWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI20XiSaJMVD4KVq5+ygd2ex9mIu8o9apS85vGXBbLoWlEP+iomlU7Mw2V3r1gX98i2JDBk0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzavecgKsstkeCsH+31VRPZxdo36Wm8fZ7H+gxu1cNaehIVaQhQ
	0KzM+LuyzfrH19k/bG32xeQlUzj7uA1POBdIngJw+kk+CWJL8zMkNtRQOENHsFhjOphPmA1EcsV
	4vqtY0lQ306DjnQ==
X-Google-Smtp-Source: AGHT+IEcCR0ZXNkZrYZ44W8yY9FDpkbNlxBisSv6tE6ecWLkrwkSnVD7gZz/wRVPyf7t4Q4rg/Smg41aG4nG/g==
X-Received: from qva6.prod.google.com ([2002:a05:6214:8006:b0:882:49f1:1e2e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5c88:b0:882:398d:3cf5 with SMTP id 6a1803df08f44-882398d3fafmr86887796d6.52.1762767930521;
 Mon, 10 Nov 2025 01:45:30 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:01 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-7-edumazet@google.com>
Subject: [PATCH net-next 06/10] net_sched: add Qdisc_read_mostly and
 Qdisc_write groups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

It is possible to reorg Qdisc to avoid always dirtying 2 cache lines in
fast path by reducing this to a single dirtied cache line.

In current layout, we change only four/six fields in the first cache line:
 - q.spinlock
 - q.qlen
 - bstats.bytes
 - bstats.packets
 - some Qdisc also change q.next/q.prev

In the second cache line we change in the fast path:
 - running
 - state
 - qstats.backlog

        /* --- cacheline 2 boundary (128 bytes) --- */
        struct sk_buff_head        gso_skb __attribute__((__aligned__(64))); /*  0x80  0x18 */
        struct qdisc_skb_head      q;                    /*  0x98  0x18 */
        struct gnet_stats_basic_sync bstats __attribute__((__aligned__(16))); /*  0xb0  0x10 */

        /* --- cacheline 3 boundary (192 bytes) --- */
        struct gnet_stats_queue    qstats;               /*  0xc0  0x14 */
        bool                       running;              /*  0xd4   0x1 */

        /* XXX 3 bytes hole, try to pack */

        unsigned long              state;                /*  0xd8   0x8 */
        struct Qdisc *             next_sched;           /*  0xe0   0x8 */
        struct sk_buff_head        skb_bad_txq;          /*  0xe8  0x18 */
        /* --- cacheline 4 boundary (256 bytes) --- */

Reorganize things to have a first cache line mostly read,
then a mostly written one.

This gives a ~3% increase of performance under tx stress.

Note that there is an additional hols because @qstats now spans over a third cache line.

	/* --- cacheline 2 boundary (128 bytes) --- */
	__u8                       __cacheline_group_begin__Qdisc_read_mostly[0] __attribute__((__aligned__(64))); /*  0x80     0 */
	struct sk_buff_head        gso_skb;              /*  0x80  0x18 */
	struct Qdisc *             next_sched;           /*  0x98   0x8 */
	struct sk_buff_head        skb_bad_txq;          /*  0xa0  0x18 */
	__u8                       __cacheline_group_end__Qdisc_read_mostly[0]; /*  0xb8     0 */

	/* XXX 8 bytes hole, try to pack */

	/* --- cacheline 3 boundary (192 bytes) --- */
	__u8                       __cacheline_group_begin__Qdisc_write[0] __attribute__((__aligned__(64))); /*  0xc0     0 */
	struct qdisc_skb_head      q;                    /*  0xc0  0x18 */
	unsigned long              state;                /*  0xd8   0x8 */
	struct gnet_stats_basic_sync bstats __attribute__((__aligned__(16))); /*  0xe0  0x10 */
	bool                       running;              /*  0xf0   0x1 */

	/* XXX 3 bytes hole, try to pack */

	struct gnet_stats_queue    qstats;               /*  0xf4  0x14 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	__u8                       __cacheline_group_end__Qdisc_write[0]; /* 0x108     0 */

	/* XXX 56 bytes hole, try to pack */

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index ae037e56088208ad17f664c43689aee895569cab..b76436ec3f4aa412bac1be3371f5c7c6245cc362 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -103,17 +103,24 @@ struct Qdisc {
 	int			pad;
 	refcount_t		refcnt;
 
-	/*
-	 * For performance sake on SMP, we put highly modified fields at the end
-	 */
-	struct sk_buff_head	gso_skb ____cacheline_aligned_in_smp;
-	struct qdisc_skb_head	q;
-	struct gnet_stats_basic_sync bstats;
-	struct gnet_stats_queue	qstats;
-	bool			running; /* must be written under qdisc spinlock */
-	unsigned long		state;
-	struct Qdisc            *next_sched;
-	struct sk_buff_head	skb_bad_txq;
+	/* Cache line potentially dirtied in dequeue() or __netif_reschedule(). */
+	__cacheline_group_begin(Qdisc_read_mostly) ____cacheline_aligned;
+		struct sk_buff_head	gso_skb;
+		struct Qdisc		*next_sched;
+		struct sk_buff_head	skb_bad_txq;
+	__cacheline_group_end(Qdisc_read_mostly);
+
+	/* Fields dirtied in dequeue() fast path. */
+	__cacheline_group_begin(Qdisc_write) ____cacheline_aligned;
+		struct qdisc_skb_head	q;
+		unsigned long		state;
+		struct gnet_stats_basic_sync bstats;
+		bool			running; /* must be written under qdisc spinlock */
+
+		/* Note : we only change qstats.backlog in fast path. */
+		struct gnet_stats_queue	qstats;
+	__cacheline_group_end(Qdisc_write);
+
 
 	atomic_long_t		defer_count ____cacheline_aligned_in_smp;
 	struct llist_head	defer_list;
-- 
2.51.2.1041.gc1ab5b90ca-goog


