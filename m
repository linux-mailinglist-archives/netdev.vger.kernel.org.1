Return-Path: <netdev+bounces-240691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181DC77EC1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE55734E106
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342133C1A5;
	Fri, 21 Nov 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaH4eCKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AE2FE052
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713990; cv=none; b=HhDtf/I3IXnF1yY1U1iaJePQXG5HKCkBiy6uig98SSiIPxzkdJBBRvajJrWFpmoL7IyeIif3jwvcptj+bkcW+/Hccc1evf8JeqhiyZ1uqhqV+0kHtdmEpBmkDqWSjvVq1kCgGNi5a3BsoVaG9mLfF+LeU89HrNV70M/1d7ZL1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713990; c=relaxed/simple;
	bh=7XPTbaAzMmMmz7uSABK2z5xEnabJs4Tije87g94MFrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dsqFb+yQv85Sq4Pk/uBtcbfkpmZLKjZWGk+r4VBaDG2Im86OQvJekefoWROb1aTrGj3BjAbtMd4H4tDxmPzmLh8Wh4Ck+rXe+fyQyYRmwoBeyIKj38ZhpHnY8TzjvYEK0m6kirxby0EH4Av6kNzbeO2ds1r2HJwI2yPCNLYdF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaH4eCKC; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ee25cd2da3so34838731cf.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713988; x=1764318788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeZjDiOqG8PJ7jYXiTIrvmwer7LaY9rLgTLqai5H7/M=;
        b=uaH4eCKCtKe7KlURLyjsZiWsTR2Lo2z3hRwEI+wynush48e60ZJr6v+HINIOcVX356
         HsNzAWJgiZjnVeuVTQw1N0UeOUlhGCwWU/DjqWr6ep48rDa291LRpbubUvD1BKMuGXPM
         KIT20F4ytnAHI+XHPE0L2Jnw6947OaTHYSTAdy6vDgZH6rtuYsblEMdf/JOOQBlmQLBG
         Z3cnDoqtc3nf8oZbjGsRhatlD9SdEN6wyUAE0oZUrHeLh5sDtnLW39qRJsSSc0NBsI+i
         yaAtPCDPbZya3w/heqv6e2g0c6HZ1QlmKhriLyvA1WecS2TeSeBPoDDeTuHfNEQpDngN
         ISJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713988; x=1764318788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeZjDiOqG8PJ7jYXiTIrvmwer7LaY9rLgTLqai5H7/M=;
        b=J8nShfsGAag/VhPWs+RuBx0wszQ8kjuPg6evmFNjn2hRuVcumDPJxuJSTBbFbwXOpR
         DIXbWqZZ6RdUqCsPAhFFTPHXFGy9met89LIWWskkab9vochgTiOW0JMRcdfMfj3EI3GZ
         f3RoWvlnDIpQ012T5ilkGQaQa9PGrQ6XbeTOwja8Jqs3qLWcGnCgbCmWGL91eAPaubPP
         0zhVBZEmYn88gkfJiUmC0A0TwxhW5bzInemxmAeuGMf79KOzCpN0QqU+EbC2pjxKYU3o
         D4UyoIyvajYJqICTV6fn1bJZ1f6iRrX06VRwMX1Jkj+/7zRbYT3xZpk8JV38Nb5cfuvl
         gWww==
X-Forwarded-Encrypted: i=1; AJvYcCU3r+3LwidAQl5GkKFSkIaH7M9qCLI7BQf9c23de2jWF84jDNTdMZ1bLWTif+ekEFRyN5zIOyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9erHKaWVg1bbvpsOt4M+dZgpAerpiO4yQiTrdij7E6n6O+/g
	vlX9HPZh2YowhhR8+IgJoqejwJr8ALdgRI9QwSCMKJF0I5wlKoDt3QSUzNtwi0zdyBJ7hSzGoqq
	P/aMtmX/YLCOetQ==
X-Google-Smtp-Source: AGHT+IGmpoHxRIJEJeHJHAg0aE0BxGaSPQdAbCIPVUNS86TV6XZg3knZ5UsJeWBFTFyyRqklmSeZw3dfPwBOjA==
X-Received: from qtcc22.prod.google.com ([2002:ac8:5a96:0:b0:4ee:18e8:ac9e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a8e:0:b0:4ee:22d6:1d01 with SMTP id d75a77b69052e-4ee588444edmr19252301cf.33.1763713987845;
 Fri, 21 Nov 2025 00:33:07 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:49 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/14] net_sched: add Qdisc_read_mostly and
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

Note that there is an additional hole because @qstats now spans over a third cache line.

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
index cdf7a58ebcf5ef2b5f8b76eb6fbe92d5f0e07899..79501499dafba56271b9ebd97a8f379ffdc83cac 100644
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
2.52.0.460.gd25c4c69ec-goog


