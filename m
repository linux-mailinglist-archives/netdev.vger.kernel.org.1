Return-Path: <netdev+bounces-237513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C9DC4CB3E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA944211A8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA02F39C5;
	Tue, 11 Nov 2025 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+RBLRxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FB2F3C25
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853538; cv=none; b=k88D+6HDWe8rQd10oxnVWA8XJ/p5uH93AAxR6m72JCsAshcFBCU4SPO2/TfW1orOQPecWbQQZmbPeoEuV+fhWSXtKpEUw8ha2ZSPxuUeo9frXpawW4tWoRWxNKpZOG9kt8aM6RfQsWQYTY0PkrHT9MOIO5H66qpTuAy3K4y/eYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853538; c=relaxed/simple;
	bh=eJRHp56hrMkdCKTBTCEU4mpxqYEPJXqMrrVL+DL96/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fk/QVXYK6B0HLHQ3r5p1Z1u08upjiQQaYnIPyHKltWef43jyyFBBHWsb4EoPzILS8u2tR1Imo/4KpxnLYaa3sJoOhbF4r8h+5PYF/a00N3KkMamO7H9DhpriQY+WIBRTWj2BOUw620udzmwXM1MWgcxebmBeIBVuRFVB/5GdJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+RBLRxq; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88236279bd9so105668506d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853536; x=1763458336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEiuhMIbNwVmAeQC80Oyj3LxiEFSKYwZdl6zZ2uMuaM=;
        b=X+RBLRxqxN+lBqvDXckR1SDBtqZ1n7wy8sETnM3go6esPAMz17oWgjsDym1FTjGgAX
         fUPYU75v2WtD4Nr81YCR3M29dvhn3TmMIoA1FV1Yw5C8gJWKFRPg/kPfFJp8jR2iN8k2
         unnupz749i3wKmA6HeThkGXdiNiBte2Flm1F1fAWNZ4SkZIox5/6PBIfcFGdoLAXg2bR
         D4P2pcpuf6LIk8g7XhkSDPNPNZ4mjmQDHfVbFUxXM2PZsL3E6sFGAJP6kz2Q5JWiwUzm
         n05AWl9myE5aGea+71g071nWD6UIHuj9Q/nbivPaFBAqkmKkrUT8X78SgXFmei8t08Qi
         Mdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853536; x=1763458336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEiuhMIbNwVmAeQC80Oyj3LxiEFSKYwZdl6zZ2uMuaM=;
        b=cRiOzkKKNcooK9Xd+J9CNNRplZqxdwG8cfYzTYdGUYzAZP8Nps0huJza26C4LUYcCT
         Ea04dJ02DpVw8l8rfuq1/+jwyQGxTYiRy4z0rU6IqHcszzP0s29TgJOCZCVnI2yUFvAe
         yxAlUjWxUE7HOe1pro7N4nz/ZLCeOxx9n9B82lDGGh7TFpkm/inchBzq+zVzh4yN1NNs
         TndJNGI7EJabS3Yv5dy6EDFDZ6kNEGaTBaIYxKReVm5mDB8dGdsx2BsCFsBEd8IRjG1a
         cvlN4wI6ZnMUpajEGNv7Nvxxi/GnGrLDvGc5GIGsumSvbq+4WTEhQCx37ULu16rxN37+
         2jKw==
X-Forwarded-Encrypted: i=1; AJvYcCVQscgLLzHnkdkLTFpJ2z+qG9EKy7/JSXOggr7njjW5NMfWiKMVt+krTmiD145c9+cbZrSv26s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqqnEXHa5F2+WgdxTPld9H9L0FzHgBS8Kfu5DKl2YOZZ/+Xtm
	SzFQsNu9LglcXXEdi4k9TOyux2C3psMF//XxuIQxPqsgf7PlnlrzWN13QEClbBVoxhWkITAv2T8
	W6ckArIvYbpNAmQ==
X-Google-Smtp-Source: AGHT+IE4+F54RmclMx3TOynLCkSUP8eekVhkY3P4QnMc631G9c1e3CcwiJ813wWKS0hG4kE4w/80M+hki0af+g==
X-Received: from qvbqw17.prod.google.com ([2002:a05:6214:5c91:b0:882:390f:756b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:cc4:b0:880:57b3:cd0e with SMTP id 6a1803df08f44-8823871da99mr158979346d6.32.1762853535479;
 Tue, 11 Nov 2025 01:32:15 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:56 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/14] net_sched: add Qdisc_read_mostly and
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
2.52.0.rc1.455.g30608eb744-goog


