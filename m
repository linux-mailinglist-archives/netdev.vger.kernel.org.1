Return-Path: <netdev+bounces-160733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEADA1B034
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179DF3A9D27
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211101D959E;
	Fri, 24 Jan 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPNEeFl1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541F1D88D0
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698875; cv=none; b=VCXDyhGxKM69sT29Q+gxd0LP9TxJUUyHF+5WJPjXgfKJgt2MQvADQnUq+biJI/7bLRP0RjWWlLl7KMV8OF92vZq0hQx1T4wcRfMnqvYlpC9+fYo1Cqw5FkUksLFkgl34UjG978p7gaaBL5Sb7Vb2Xyos5qimnNdUQU1/hzKPcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698875; c=relaxed/simple;
	bh=kKExknpKUSpHOQXmjE6PHW0uDzcJddoE+bLc3C1eGXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEUcYJ+HmqG8WneDSOhdHXnYj6RJnsq5UbFt/WYDPdUMMPbP9SV09vDMgRVLt8OytzjDV82T9g+QitH2Kee6yiym9xGKz69yN6czelhi3v89tRC3aCKWsfbDaXTPh+h9hUSFdnQNg0iCW89LLxrIBW3J9HDkCIDMQCzTrR7ZObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPNEeFl1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so28280645ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698872; x=1738303672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mW9dlWOXLHMk8cSa/H+tTbb9VUo0G58kgm/102TLrE=;
        b=OPNEeFl1o5ua019a/rPqt7k7OxwiCE5znz9QXYQtYT1hNi3dzONXYgH9qlfoWvebUu
         20spgOEXPwX92s4D+6uY47Qa47tMduRlF2X/NQwRIYEbr50tePyrT9U9HhD8sbBRiwx8
         DBMyufoG5e+UHAgopYVUEaFs15VoLOUm40ccoLJiGsyjPmmuE3ai2wxrTVUzvt4iB7HT
         9B+Sx6NhdRLZudtms27PSAPdMEQgIzoclMM2bveR7GTkw/08GAzkqTQJCvooYTS/nUj9
         w25iK4xNwjqnoLOOTwAewhGTjGYFV18sY83noZOWzDDzCpEEiIC0VSydJSdoyNR9eKJK
         AoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698872; x=1738303672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mW9dlWOXLHMk8cSa/H+tTbb9VUo0G58kgm/102TLrE=;
        b=NsHK1p9HBy0JD/+R8/LoBpvyXTcmW1/4LdbK2FUHI4nSm9aEGKCcdnkr/qo5XIMkYD
         rBYqzIfjnhm1Gh8hDvw0zWE9aZ6lwyogKfYL1RI7dvZoyw1ByAgmXmluU+3dwKH0E834
         kLS3WRJKYibAArwUe4LMjnohSGjOBHg/8dsYScHRE5ZNWduyW9a3LSc8gVQdL11AF6FL
         it2cUSrvso4QD91xWxeyg4TNYgVkEfnCC6rkJ9tDVrPlIfH1cr8dGhUqcILNmOegRE+t
         /O1Q+wcmecMKi6qg1d+Xc6DppBSbN+vPH4d2+mei2BQK1sbECc9pVdpfYzOnAUTnC2pd
         ZMDg==
X-Gm-Message-State: AOJu0YwBgA6X6yCgu/WSRd4EzAM6NKdOH7X1FEjgkXzyKAdc7PQ99OHo
	+jjyxQNczLPSrZdnmrK/vJ75QbphRv52V/MlZ0VrLS2BvVc+l2WiugZf8A==
X-Gm-Gg: ASbGncu3KfGHzkX1hDcIWeOUtmEhlCCwZy5qB/FhDZje/LC8x59RBZn6cjCeyHtz91D
	WM8y4oBJ4Zj4X8K9swOaCDik4GUK4kFA6vK3h2dIag06M933TbcDLt8/oAHMr5H9a7lzNH2N/EC
	Bm3rX0VSIrtLLqvdfEJ6seUOOmDg5sM9BfIYxgQO06nqwhAnIOWk51lU5TgoqPy8GH9Ic7M+8Ht
	+8EAY+ffw5ky4IOXr1c7Vg5EUw+Y5pIiVgDCuOqyrvs6cNfShLQbZa40iDy1bVObNz41moBt0NM
	uRzWhMk1lHFIke66AXK14rPEPDiaUL0Z
X-Google-Smtp-Source: AGHT+IETd+i2sYsqqcrnfwxai1cD7wjy+xVzl5Pc++YUpGn12UfM+c5uOF52ArOI2ucNcEYTwITi/Q==
X-Received: by 2002:a17:902:cf0a:b0:216:393b:23e0 with SMTP id d9443c01a7336-21c355b70d7mr472062385ad.36.1737698872338;
        Thu, 23 Jan 2025 22:07:52 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2d85:604b:726:74b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea55dasm8696095ad.101.2025.01.23.22.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:07:51 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net 1/4] pfifo_tail_enqueue: Drop new packet when sch->limit == 0
Date: Thu, 23 Jan 2025 22:07:37 -0800
Message-Id: <20250124060740.356527-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
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


