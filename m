Return-Path: <netdev+bounces-248833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF7D0F75E
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48B28301E80B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3B34D4C2;
	Sun, 11 Jan 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qBj1tC+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2434D3AD
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149616; cv=none; b=MQdSYaeBXukkw7cg9t6VBhT20pRqBDDpjW3qsmz7D2aCYauo8G+Vdjr2Z4q2fFL4AekHS3ME4GJJPQhPELtw4FyZIAAj8j22/HBSA9z5CqBXinR2U8x98XozZhLA8Ihc1cUDD1JxiOE5bO/5CWC+LGKfu6+C73r9pj6nic179PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149616; c=relaxed/simple;
	bh=Dr5HQMn6/WT9nf5jbiqNs+RZHGM1XWBwBk58zgT4Gno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZtNTs6j9Aan1PeF4amNrJtNMmteYm6UOjblrIs7TyKetm1ZNtoJd7MB4OYbRPT+slti8P7Iy0KxDaM2QWGWChnCfwA9yMRJvMw0EMuQADhklXntJsWiKkAjFdb+g2e4x1/NiNC3P1LoZ5QWl0sLRI7Hs5ucdjV8mTc/Iq9iT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qBj1tC+u; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c2f74ffd81so588532585a.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149613; x=1768754413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2wzHDcr5BQPsKGaow7JGDJwoqgrDh0fz584Olx3ZA4=;
        b=qBj1tC+u0rRZ4B1lyOpfQMQXwEs4zDDp2aFuqWe/GWO86iNlq5fPO6NL/UEIpbXjj6
         U2vfRMe5DRBxFEDQAIjrRKA+CEkq84Qot9mv2fcitMU6ZT4wbsRtOOQfGY7xDFJYk3mF
         iMt0LCMiAJlmXKhC51gYBvxYTC+gZ11bmsN/N+n4kCniWw5g1OOTgoP7fE6teUHiMMPi
         lKmQA6A1ZuhMup/lB8pvx211JeGcIxy+ESJIHFBMLJaIBX0zVXSE+RnjRGCiXFbkK0nB
         IiwfPf9zyQh/Q776hJMSeTF4FNNKcxZ4JrOafn5/kDJ2WQuSSUYDAMuasXMNgR5KFcDS
         hqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149613; x=1768754413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2wzHDcr5BQPsKGaow7JGDJwoqgrDh0fz584Olx3ZA4=;
        b=F37RgcarzAlVNHxnvBbWm8tfeudDBfhwDVkmycyN5GEeCHL1tRpa76sR7dnpS1CLjc
         V7pQLjtz+HJ6kDi/9GtSp/voTkQjRZCw4XoY5kS/1Bof9t8siYEN+uh8XszQU1Etvmuf
         PmcEHZW4heac88S5FFaJSTY6zZ6519XHlqqvy0vviNPCnreeFySmMhlkr6y6kDaUi1+A
         Tn4FBD0C0SJ40+Ly857b/XMJhOgHg4NtYsSd8G8iSFbHqkBkDrQXKO+4gB5huuNYUs9Q
         28EOztEyU6B/rK9jRZbrSm3ieDvS2Y9RWzOCyMSSRV74BNAkzImKWGmajUGNiwP4eSyT
         R9mg==
X-Gm-Message-State: AOJu0YxZYIa3lCxlcgJFQmMJryd32cPqCdZuRI3c8bUFxz+b7bY+NEsq
	6X9dy1h72x9yTO5rTVn+1QguUfEtfjyf8y0uPihPH2laSKjPd3D32isMCs0QCYzbHg==
X-Gm-Gg: AY/fxX7AQcIB+xAjAlJIZQX3hd2TbtMxLxSgVAhg52Sl++TVrQnTmqywxgFGTbpwAUe
	a6nH6XaPKXwcNAfKUPdW5YYbfJ58CNneMYJ5AF2tpXNgZnUPPh9vXAcum4XiONOkHUOVkDqRIM2
	XU6P7vnWYDuXtAQpnxJyGm9s44jm18o8bSQrgumqcS62P11UB0a6s73bYnJ+1XKFH+B0SRrJ8JV
	QPwFP3AA+EoCT1kyVc2HOwvIS6h9F8In/fHpe4diS5aAIMbNUo3q3/KT0mPmxjjW6DOGXhIx5/5
	QAn0P5KN8KkXOBbAalMQOzJwnO4I/vX+GDhUBh3eDwJhF2A/bG8NPqGnBQ8dn13W/CWK/y+yBe5
	OVEZU6EVYXiXkCgRASvzrLBi7A5EKI5he/QMwIT0DhMnh2OVy7LGtCr0mgbxR0twthFL/YLxgPB
	AAA7laaRiisDE=
X-Google-Smtp-Source: AGHT+IFtW4LB1CJummYrSFhilsiCXLNUDLPFAzkNxMWGSyNK/PRwT5kYS2BE7I2qKUYIqPvbX6Q8gw==
X-Received: by 2002:a05:620a:c53:b0:8c2:9ff4:a8bd with SMTP id af79cd13be357-8c389367480mr2138178985a.15.1768149613545;
        Sun, 11 Jan 2026 08:40:13 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:12 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH net 5/6] net/sched: fix packet loop on netem when duplicate is on
Date: Sun, 11 Jan 2026 11:39:46 -0500
Message-Id: <20260111163947.811248-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
References: <20260111163947.811248-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated by William [1]:

"netem_enqueue's duplication prevention logic breaks when a netem
resides in a qdisc tree with other netems - this can lead to a
soft lockup and OOM loop in netem_dequeue, as seen in [2].
Ensure that a duplicating netem cannot exist in a tree with other
netems."

In this patch, we use the first approach suggested in [1] (the skb
ttl field) to detect and stop a possible netem duplicate infinite loop.

[1] https://lore.kernel.org/netdev/20250708164141.875402-1-will@willsroot.io/
[2] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Closes: https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index a9ea40c13527..4a65fb841a98 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && !skb->ttl &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -539,11 +540,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		skb2->ttl++; /* prevent duplicating a dup... */
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
-- 
2.34.1


