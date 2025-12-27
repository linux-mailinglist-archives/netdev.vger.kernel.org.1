Return-Path: <netdev+bounces-246153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D3CE0199
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA988302EF67
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67960328616;
	Sat, 27 Dec 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktO+Gf7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690032860F
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864513; cv=none; b=cSxH1YqUz6VB4hbiPvqpqhtP5nYVN7j9Xd72RRy21G5RGhgHQxUULEYIu4brqm4UHZkuWq5ErSg3nXDCa6krEknIdExqqRCfQQXxtzzUPkTjCW0GIjakvZAZ2fYEAAXH2mgpZpyQYzKEkFrkKLa/m/itCzmkhOkiHPO1SoJ+kUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864513; c=relaxed/simple;
	bh=az3G8kHBrPDaiycV6yUEz4jHDJYjAipGII7/OcbRyD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuvlgtkSHnYvmEOLV+oEHkJOe+sAgQZnHnyjH4bVZeXQfjTFyf7Dh3iP0dCFzlBQ14YlAEFSlHCpJiRF5qrROSSF6BprLlsM7POnUaol20FNADFKdYGYYRaadibL75F1KmgHSiH58EvZ0UdHncNiKYJg5zCy3QwSEBq/HqFr3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktO+Gf7L; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae24015dc0so7894996eec.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864510; x=1767469310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpt7S1Hn4AYSa9kqAcQ6h6MHEtvfiyAtxHeb5RmVBIA=;
        b=ktO+Gf7LC0AfSlqlRNXGjll/RTL+lt6BI9FyekvLigxE2+KT+XK7SSMmsGKmitYtMH
         FPHlsZvIfd4fwitl+1wY4QmglfmS0ziHeoAoeDlddcKHIk1+lrqATQMSK0SYIIFtH2bb
         KFOdk7Sz5hW8WIyv789o7od/F3c1vOqWBu7W7wY1gb8JQuc3wWiJr7+oijq3GZPXIdcV
         TLc2vtC6C0aNoIszEkfcCx8cGr6BQg1tb2xQY4FW8ybbFkz6/hNtmL/bJgRwS921+H97
         gVieaRCVD1OFMaOI7EbTX4xRW8Np3BGML9xSFuEFEeejX/jVqruNzahrXMlNivatWZX8
         LNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864510; x=1767469310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpt7S1Hn4AYSa9kqAcQ6h6MHEtvfiyAtxHeb5RmVBIA=;
        b=m9nKFkuq6hlifAhybK6p3R6Rb4pCF7zfWdwUxCHGu8cD9N3cUWuYdU7bHEqKI8BRCu
         EznvvOu6k5IRKCVHFaDMn9jx2lAPPjEbcMQ5R78ds76p827qp4uXmBUMQ/fOMSYkov/O
         EXJbR5wNoWLRQXTVbp8xDIOP85vZX98yt1UD1dFu7+oYTlCtgqgzcjOAdYYyi5zsL/s8
         u5O/FVi9/JUr1qvPBH9T7rGn6Hxr1VHeboRZpeGNaWnXtClwcJ6bPrS3v6dfeizLSTIb
         Tyhev9JXEG9YxxgdoaurRG4mfJGBNlGWUTm0yStEUqXRr6BRbJiwI+DbvhLT9H9j/v7w
         JomA==
X-Gm-Message-State: AOJu0Yy9H/3Ggu0kUGOHbAkCoLGgGHobeN77vwA80Wxpuz8tkqUX3NgN
	hXtqHHUMzzFh/Okaw4Rq+RAk5UmS99HSgJmxnYbIYG4cqh0vzIdft1dLiOsWzg==
X-Gm-Gg: AY/fxX7FV7PW/qDvFmgR87E05gEMgqxjDYuZRswX+dDlt6RJ19+RXOqFrmTyNGbIbTP
	7PkBeb+p+T7rSA5HxSi0oneh+/8ITpqPL0/aZefVMJvGaDsIlD3qc0j/2RILIQ8VuKWhV01tLX+
	mBMNuSCmeiwWFUdGLXOXjFB/KyGKtYqxWno1R4KVITHSqV27IknR4uBon6ionpPKmRcLrh4MNMO
	VFfYFJG7gGHCpWPOQQsL1JVQSnz6mQupmKB7EkL2O0tm2bCTF+9Lng2LJZ/m/UX/TENUCiOv+J/
	NjBUjoRH+V/PHaP5zrPSFQt64pRMKeRABMPDHxW/K77z5g5fWRvQYlChtqQM4hdYW+H1iYkZlIn
	gAW8eo7BN9CLm9ha2ObAOkCx6+jmoNxlFXJmO12ht3djmzUKwkgYShaFogHFmFgnYLTafJzmG/J
	Br7oK6t+HFhQgsAKau
X-Google-Smtp-Source: AGHT+IHTrCJ18QOBx2srVWZpUlbz/BIjqX9+K0elagwGZFVIQZjM2pZTUR9IYI50jjfciq1ovlEzuQ==
X-Received: by 2002:a05:7300:fc19:b0:2ae:5ee6:6746 with SMTP id 5a478bee46e88-2b04cc10220mr17970091eec.18.1766864510184;
        Sat, 27 Dec 2025 11:41:50 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:49 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch net v6 4/8] net_sched: Implement the right netem duplication behavior
Date: Sat, 27 Dec 2025 11:41:31 -0800
Message-Id: <20251227194135.1111972-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the old behavior, duplicated packets were sent back to the root qdisc,
which could create dangerous infinite loops in hierarchical setups -
imagine a scenario where each level of a multi-stage netem hierarchy kept
feeding duplicates back to the top, potentially causing system instability
or resource exhaustion.

The new behavior elegantly solves this by enqueueing duplicates to the same
qdisc that created them, ensuring that packet duplication occurs exactly
once per netem stage in a controlled, predictable manner. This change
enables users to safely construct complex network emulation scenarios using
netem hierarchies (like the 4x multiplication demonstrated in testing)
without worrying about runaway packet generation, while still preserving
the intended duplication effects.

Another advantage of this approach is that it eliminates the enqueue reentrant
behaviour which triggered many vulnerabilities. See the last patch in this
patchset which updates the test cases for such vulnerabilities.

Now users can confidently chain multiple netem qdiscs together to achieve
sophisticated network impairment combinations, knowing that each stage will
apply its effects exactly once to the packet flow, making network testing
scenarios more reliable and results more deterministic.

I tested netem packet duplication in two configurations:
1. Nest netem-to-netem hierarchy using parent/child attachment
2. Single netem using prio qdisc with netem leaf

Setup commands and results:

Single netem hierarchy (prio + netem):
  tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
  tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%

Result: 2x packet multiplication (1→2 packets)
  2 echo requests + 4 echo replies = 6 total packets

Expected behavior: Only one netem stage exists in this hierarchy, so
1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
2 echo replies, which also get duplicated to 4 replies, yielding the
predictable total of 6 packets (2 requests + 4 replies).

Nest netem hierarchy (netem + netem):
  tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
  tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%

Result: 4x packet multiplication (1→2→4 packets)
  4 echo requests + 16 echo replies = 20 total packets

Expected behavior: Root netem duplicates 1 ping to 2 packets, child netem
receives 2 packets and duplicates each to create 4 total packets. Since
ping operates bidirectionally, 4 echo requests generate 4 echo replies,
which also get duplicated through the same hierarchy (4→8→16), resulting
in the predictable total of 20 packets (4 requests + 16 replies).

The new netem duplication behavior does not break the documented
semantics of "creates a copy of the packet before queuing." The man page
description remains true since duplication occurs before the queuing
process, creating both original and duplicate packets that are then
enqueued. The documentation does not specify which qdisc should receive
the duplicates, only that copying happens before queuing. The implementation
choice to enqueue duplicates to the same qdisc (rather than root) is an
internal detail that maintains the documented behavior while preventing
infinite loops in hierarchical configurations.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_netem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index a9ea40c13527..74aae53322ec 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -165,6 +165,7 @@ struct netem_sched_data {
  */
 struct netem_skb_cb {
 	u64	        time_to_send;
+	u8		duplicate : 1;
 };
 
 static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
@@ -461,8 +462,16 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
-		++count;
+	if (q->duplicate) {
+		bool dup = true;
+
+		if (netem_skb_cb(skb)->duplicate) {
+			netem_skb_cb(skb)->duplicate = 0;
+			dup = false;
+		}
+		if (dup && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+			++count;
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
@@ -533,17 +542,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	/*
-	 * If doing duplication then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
+	 * If doing duplication then re-insert at the same qdisc,
+	 * as going back to the root would induce loops.
 	 */
 	if (skb2) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
+		netem_skb_cb(skb2)->duplicate = 1;
+		qdisc_enqueue(skb2, sch, to_free);
 		skb2 = NULL;
 	}
 
-- 
2.34.1


