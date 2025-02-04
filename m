Return-Path: <netdev+bounces-162337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD16A2692C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DEA1886675
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BD78F40;
	Tue,  4 Feb 2025 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxPOVAZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5325A62E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630746; cv=none; b=IOsfVyJMk1hLohA1c41+cNjA57zQbNZ0tzHC0mWEOSx8BbaSudcBvx6uC3VUcOqov8Cw4FLrC8Xxcdj2Jgw/GTDzxcMc3skcA8FE9XYsIsSzEserKW1fEmcwY33MDYWFzjS/n0tuUhldZYcoO/1oXFQfyueNwK4amwC/4SjNN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630746; c=relaxed/simple;
	bh=anoltY1dt2zdHmqFufXxFhRD8xWvdz3bpxvr6vuDGaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+eLJy3HTLIJRAhJPj+KCbqINrMGe6rn1qP5fGYqZS2hKs8V1Iej+G9TeUwFKPxh5pkrSMT/aY7xeBEY3vZpPEx8xA7LJcOJdqzGyoyZiTDjUnvDTUSb0MllKfgTT2804Gz32yosVEg56n56SVmfK7e1a6UZ5hF5jnV4SQ1mE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxPOVAZf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efded08c79so6639808a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630744; x=1739235544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2x4uGypj2tYHXP5qRBhHFx0rQU2vkozD96rA0y9ykI=;
        b=UxPOVAZfFUuCKMFWWF357oVBFCqY9vNnToWGWKcfqjp/CGV7v2/dIO/KV6gtcUJnvl
         FultdujS2zOI+C+fItJdjR3Kou/vr3njInXo8In9VHG0kHebaH4TlRsv/zhlTZjHJpsB
         /x6xxChScPJsyDDYKr6nBGBxxlz9lPihvu99LRaiaIsR56nvQWqzGh2K0CPYMKpkHWmA
         zxenBk5gRHrg9Ig0fvD1IRD0ru6/e1DVJM9HAI5VJm4OqpKeJVg54IsafjD+PCXOSZyX
         D33q0aD1pTLTGQj3TCRj7AaYBwGqnjcEv2gdSW34RbZrLUu3NxHS7VBNyB+a3/9CXaTT
         TT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630744; x=1739235544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2x4uGypj2tYHXP5qRBhHFx0rQU2vkozD96rA0y9ykI=;
        b=ve42qm1XQWUkC6MNVDSjDQQf1nRJGIFLzdd17VOQ7P74Y/BI2EGUjMzBpqUZ+IUvDD
         ZJY5x1vzs7eZaja7GMjCEn5Sk/tyTEChgXb92ilAdPskrViWxYJfdXHK1bSvEy8fnejo
         7UZo4nML0VJ+kAHCfUih3Dqcdxo0cTA09Zj2G8jJU/NwApuFpGoYjnL3HX8Y6bukPUTN
         j9gqs0bOwXHYo24MYrsDrrgUDWoVxNhULSe3Rt7ieucLDXOwS6byWCwoR8F9jc0rcsxq
         5RywRl3kOc20csRzC8zVWe7iNu6721nOiMt3nJBqgR7aPFfYTtmKR8CyYTbaw8ENLwpg
         wXlg==
X-Gm-Message-State: AOJu0YxKIeTQKiU+EKWsj9P9acwm4YuPqxbuGQQzZSB9KEaxqkLVvR4k
	Jzfk7EF3HANX8xmRo08J5DjAZ6hKaPy33a/+lpJlXQQzk2qfOyNkFshbGQ==
X-Gm-Gg: ASbGncvgRsl9jSELlLySpYweRnjBWvf4hG9QLYqvHGhXK/C+BsMRjrrDXB0FwkrlePt
	Trr29vhBOTic1Xz2Pd4kmyKGvlPwouQIKyNOya35Dh5dU5I3udEFMuF6o9JMICkie4+jfxqyTYC
	89dcBdUjgqwSK9aJFclqpOZ46JP+7NhhZj25S5tFEhnNw8A8C0Ii8ousovqpZTMlyfvmyuLIDX8
	xGBE82dTUtk+CaqLyy8KoOXy6cgU5m8M5ORhLXKwZ9XT+vmI1UArTI04wKntYQ5dbG7v9eYrZGG
	TzZiCMAT/zmi6UU/p2KUrASlnVcZRhnleoZX7+t39wHW
X-Google-Smtp-Source: AGHT+IG/4XUs9Hr3JIgSaxOFu0jTWkd13hxm9uciAa8Z9c0lafJm/+vxAN1MNd6asRkS/r5YDo01jw==
X-Received: by 2002:a05:6a00:3a0f:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-72fd0c623ccmr32823860b3a.17.1738630743972;
        Mon, 03 Feb 2025 16:59:03 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:90d2:24fd:b5ba:920d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427b95sm9207069b3a.49.2025.02.03.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:59:03 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	mincho@theori.io,
	quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v3 1/4] pfifo_tail_enqueue: Drop new packet when sch->limit == 0
Date: Mon,  3 Feb 2025 16:58:38 -0800
Message-Id: <20250204005841.223511-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quang Le <quanglex97@gmail.com>

Expected behaviour:
In case we reach scheduler's limit, pfifo_tail_enqueue() will drop a
packet in scheduler's queue and decrease scheduler's qlen by one.
Then, pfifo_tail_enqueue() enqueue new packet and increase
scheduler's qlen by one. Finally, pfifo_tail_enqueue() return
`NET_XMIT_CN` status code.

Weird behaviour:
In case we set `sch->limit == 0` and trigger pfifo_tail_enqueue() on a
scheduler that has no packet, the 'drop a packet' step will do nothing.
This means the scheduler's qlen still has value equal 0.
Then, we continue to enqueue new packet and increase scheduler's qlen by
one. In summary, we can leverage pfifo_tail_enqueue() to increase qlen by
one and return `NET_XMIT_CN` status code.

The problem is:
Let's say we have two qdiscs: Qdisc_A and Qdisc_B.
 - Qdisc_A's type must have '->graft()' function to create parent/child relationship.
   Let's say Qdisc_A's type is `hfsc`. Enqueue packet to this qdisc will trigger `hfsc_enqueue`.
 - Qdisc_B's type is pfifo_head_drop. Enqueue packet to this qdisc will trigger `pfifo_tail_enqueue`.
 - Qdisc_B is configured to have `sch->limit == 0`.
 - Qdisc_A is configured to route the enqueued's packet to Qdisc_B.

Enqueue packet through Qdisc_A will lead to:
 - hfsc_enqueue(Qdisc_A) -> pfifo_tail_enqueue(Qdisc_B)
 - Qdisc_B->q.qlen += 1
 - pfifo_tail_enqueue() return `NET_XMIT_CN`
 - hfsc_enqueue() check for `NET_XMIT_SUCCESS` and see `NET_XMIT_CN` => hfsc_enqueue() don't increase qlen of Qdisc_A.

The whole process lead to a situation where Qdisc_A->q.qlen == 0 and Qdisc_B->q.qlen == 1.
Replace 'hfsc' with other type (for example: 'drr') still lead to the same problem.
This violate the design where parent's qlen should equal to the sum of its childrens'qlen.

Bug impact: This issue can be used for user->kernel privilege escalation when it is reachable.

Fixes: f70f90672a2c ("sched: add head drop fifo queue")
Reported-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/sched/sch_fifo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index b50b2c2cc09b..e6bfd39ff339 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -40,6 +40,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	unsigned int prev_backlog;
 
+	if (unlikely(READ_ONCE(sch->limit) == 0))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
-- 
2.34.1


