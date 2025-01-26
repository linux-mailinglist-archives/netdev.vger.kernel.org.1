Return-Path: <netdev+bounces-160947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA6A1C647
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226A03A723F
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E619D09C;
	Sun, 26 Jan 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXCYV3Q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5C17CA1B
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864800; cv=none; b=Unqp2lSosbRn/d0pov/QXsULQa5qUcLQxu9BeSCvsMjmG1BpyAUaikvzM6GlyE0mHTsdy0JEVdg0FKwsPRADbmks0234wzZ+xdGBsslBaMRY1K7tBaSR5IajyRBI3VctmVzaG190bCquDCe4n9865tG9gw9H2iE7VueyW2AT3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864800; c=relaxed/simple;
	bh=kKExknpKUSpHOQXmjE6PHW0uDzcJddoE+bLc3C1eGXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGLDXh0S0yihXZpjhRVv7o0OEMPh82Br0Axkc4GVSEB/T3zO/Fug8H/1OpXxjDllgGiNTo9WD23U0nTbRdDADCMGwRarwrKm7dnXiOnIM+OQUht8Rf+LPP881qbvM8TCrMiqhWMl0ZVwlA+2wErpRQBimVkwU/di8lfEwTXt1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXCYV3Q+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso58172055ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 20:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737864798; x=1738469598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mW9dlWOXLHMk8cSa/H+tTbb9VUo0G58kgm/102TLrE=;
        b=SXCYV3Q+huzrSrV/MVJotssu9GgenKNto2vPD0M+ibdnG+64ilMqbeU+3ZNW0tuzg9
         0jOXBXw3EB78toSxfd+FX/94W/KTWHDJbIfRIuy+2RyOo1aBSe1LGW26Rf+gQT+bF48H
         xduF8psoggGM7pVTgO1bgDgV2VSrs/cLGy59jzGcrmMjq0JLGb0GY6D5J39ovIAvw0FI
         eEmBudxL0RGQlpLmAlUic/D7pUYL3Hx1JKJY09zaETRhG5O1kQomDlf0r8FNb/EmygEq
         ChZRlGLUQ2bEdwoGwbroFU6bd6HAmT5y2qZWMyH0fRRersa6+WLkpi7a0nRH6PngZfmA
         bNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864798; x=1738469598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mW9dlWOXLHMk8cSa/H+tTbb9VUo0G58kgm/102TLrE=;
        b=QlS5cz601V/3Gtcq/3RAmfgO/icd215hdS7p7MLFuMahkJC/2vPpvfTqvWMYakKxxH
         o0xGa4qiPL2FaE5P3alTI2GdLbNWO7b5vVPdZe8TZ42DG1i9U7C9zdDGvKMHj54co2wv
         TQEFPvCAKyljFwFhZjPMWro36aWCDsLH0e9vUkHak4RRopQagInWuD8nRM3bhNKVixw/
         2oig2G8oe/h1StsqgW5gUHxnBSiLpIZGBP3tZamBNA4fOm3uvP3REEZx80xMJTu0ZZSW
         SBxIxCgyW12hmkmpmPvxmrZR8UMNjEmvaDT1Wd9+LYSKdRJikicnNgePs/IYfYvRRgN9
         XdFw==
X-Gm-Message-State: AOJu0Yy5pb+L2ELqhUzhoe2XwfpqbBFe7NGkkxkrkIw5I23RXUT1x21+
	ssiBNZcmo4HkepVBLJVL+lLeRsMvuMKwWOkhSkVUGjcsMleYqtLWPOBTHA==
X-Gm-Gg: ASbGnct83VTMEoV/N0xoXEmozKQEqLLVifQqVlgz5Z0zF40jHNrnxrGxyiTuUcmiSF5
	WiB2s9VlSZ0tPzub+B46Kz/u6FcFS7iSZTEwmCXP5Askwtkyv0JlAl6mNwcGh20loBs039yoCX4
	T8jmLEtSwr1LyCMTd/1LWJg/g9B5oyHT+JpIOSfdfSAfsSo/ocEji4/NJBiTEYpp73iLJu0uRny
	GS+o+YxbvJ7f0r3To8t6ep4uDGnwSQxcdKVfQE18CYquFNMnnqMiDH4rJCjxOSFb8aXLc5alGo+
	9J4eQtPISV4BjDolLHkYmux/iM51obhKKw==
X-Google-Smtp-Source: AGHT+IFyMYTGikvhDCuCfaQO06HQZMGtABZtJvnEVU2nHJevXCP4m8z84+V069qDlHcTXJTgUDn+0Q==
X-Received: by 2002:a05:6a21:6d8a:b0:1ea:f941:8da0 with SMTP id adf61e73a8af0-1eb214e52damr51417094637.24.1737864798282;
        Sat, 25 Jan 2025 20:13:18 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fd40sm4514213b3a.3.2025.01.25.20.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 20:13:17 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v2 1/4] pfifo_tail_enqueue: Drop new packet when sch->limit == 0
Date: Sat, 25 Jan 2025 20:12:21 -0800
Message-Id: <20250126041224.366350-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
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


