Return-Path: <netdev+bounces-87951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866228A5147
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FC01C2220C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B0839E0;
	Mon, 15 Apr 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQFgEl3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CF82D72
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187264; cv=none; b=eDO6j4VqdqB5UnOjsJ2D96mtZ5wQVOiDRUkASvDAQhPdj2opbwRoPz70uNlHxjz4axzKxNfYzkq7wGkEh6hkGk7TXG3aVLhbQQlxAf1+cRaxbA0PYoQkrp+RI93hFa6FRuC3kT54tapy8bot2+gR15dbEFkgyKv3hgpoXQ9tjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187264; c=relaxed/simple;
	bh=je/HGq+WT63hPeXHXiqGA5Bqj2KxfYiW15d84nbQb+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rsQEDCq9XXBpwHc7+JKj6ArkQk6upDKPcRWRvtABb+XYN9XlIHqFYtww6btzdzUpNblLVvn5hqFdhxz1rmknRDC7C6HQGSiu9OVnwIwX/E5b0a120ziMVtEMHhdoYtJWI9LXwMNEwv7ZsG0AcJNbdbXdBWlwPMvuoXD1OmPLibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQFgEl3G; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6180225775bso45263717b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187261; x=1713792061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qqkpTUsvu108xyewMzYbQAX65lAMkHa/u0k7gz7zg4=;
        b=PQFgEl3G4OgBOxdhDJxAh/2X968D54tw/J+r5vy5kUvk/uDHIJp4xjtB3HT0m854Ym
         Y8SLkhaD5aFzykJzDXSn0imssdx4jMa6LyKK+0zcCU3E9R3iAkFchv989Ts99M2KXX6u
         a1ZQDVtlTpicBQROWGZCLOPTSWGIKcV3qUpyQu3Gexlr6x7Xtx4w5f0AdIwz6VYzlqTq
         dmcQ9Pgwetuv43sbunyRHgVBZA/FnZMoeTHrEkwv2Ce5H1zx9GPb+b0NnXJkdZNzZROD
         /1a8Hg5ng+SDc5PPwzd5zXFvCF/8vK5aCAA2ITcV+aAKljtbXLnfrkcw27S6k/IPSGVg
         ZK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187261; x=1713792061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qqkpTUsvu108xyewMzYbQAX65lAMkHa/u0k7gz7zg4=;
        b=vA1va9nOpHhbhx3kMLSt6Pz0Mv/doIVmfi0ligLV7LRKD/Bo8Z7GwaE98zmd1XB7uv
         BJozrnXGcTDyvgIYKhwIDPTHQbKgVquL1b6PfQeENxsON72uswV4PbJeinB4ZtDrFSLU
         GndiMCtwII5YdPbopvDjmp78qLdklBAjnG9HD1mCx9cmDiun1hrAainlB/upBJORlmuQ
         Udf0rP4837IZutrHgMAriv6qIenBkBxJVfWyajkLx4yoOX0SOPAtAEdMi7jWj91J9YKB
         oLVv6vwUW3TyKU7oekLwaVnRJhI7g6Wqs2t0NZrqlb5BHULNkhfG5SPh2j9xYlaD8j2V
         yo8A==
X-Forwarded-Encrypted: i=1; AJvYcCXXIZdtoMKry2frlgvEzbXNVcnQ4VykmNzIH3YycXrxxFLPi+OECLvqszlfB0T5TFMMYUZV7r0lygvI35XBPY1+spKgadG9
X-Gm-Message-State: AOJu0YwohfA9XYxq9SPKwvWC0prSsGSO6yKoLCWSKeVvM+FpKgovGnpP
	2uiHS3cJrULcoRhjQaRYhnx3uuslDxUrT+AHTJCuoPsuDrniVP74W6wGGWogfHrp1PQo3anwRj0
	wo2U19e2UpQ==
X-Google-Smtp-Source: AGHT+IG821hMwVnKrdAfgwP+f6KLnu5+LA85YJsbpq5zSW/D+0e5gnwuhn4V4WrphFZFv0B2bx+8W35ajrQ6Rg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100b:b0:dcd:875:4c40 with SMTP
 id w11-20020a056902100b00b00dcd08754c40mr3248673ybt.10.1713187261710; Mon, 15
 Apr 2024 06:21:01 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:44 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-5-edumazet@google.com>
Subject: [PATCH net-next 04/14] net_sched: sch_choke: implement lockless choke_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, choke_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in choke_change().

Also use READ_ONCE(q->limit) in choke_enqueue() as the value
could change from choke_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/red.h     | 10 +++++-----
 net/sched/sch_choke.c | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/net/red.h b/include/net/red.h
index 425364de0df7913cdd6361a0eb8d18b418372787..7daf7cf6130aeccf3d81a77600f4445759f174b7 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -233,10 +233,10 @@ static inline void red_set_parms(struct red_parms *p,
 	int delta = qth_max - qth_min;
 	u32 max_p_delta;
 
-	p->qth_min	= qth_min << Wlog;
-	p->qth_max	= qth_max << Wlog;
-	p->Wlog		= Wlog;
-	p->Plog		= Plog;
+	WRITE_ONCE(p->qth_min, qth_min << Wlog);
+	WRITE_ONCE(p->qth_max, qth_max << Wlog);
+	WRITE_ONCE(p->Wlog, Wlog);
+	WRITE_ONCE(p->Plog, Plog);
 	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
@@ -244,7 +244,7 @@ static inline void red_set_parms(struct red_parms *p,
 		max_P = red_maxp(Plog);
 		max_P *= delta; /* max_P = (qth_max - qth_min)/2^Plog */
 	}
-	p->max_P = max_P;
+	WRITE_ONCE(p->max_P, max_P);
 	max_p_delta = max_P / delta;
 	max_p_delta = max(max_p_delta, 1U);
 	p->max_P_reciprocal  = reciprocal_value(max_p_delta);
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index ea108030c6b410418f0b58ba7ea51e1b524d4df9..51e68c9661727e64862392a76880bed5fa0c27a2 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -264,7 +264,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	/* Admit new packet */
-	if (sch->q.qlen < q->limit) {
+	if (sch->q.qlen < READ_ONCE(q->limit)) {
 		q->tab[q->tail] = skb;
 		q->tail = (q->tail + 1) & q->tab_mask;
 		++sch->q.qlen;
@@ -405,8 +405,8 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 	} else
 		sch_tree_lock(sch);
 
-	q->flags = ctl->flags;
-	q->limit = ctl->limit;
+	WRITE_ONCE(q->flags, ctl->flags);
+	WRITE_ONCE(q->limit, ctl->limit);
 
 	red_set_parms(&q->parms, ctl->qth_min, ctl->qth_max, ctl->Wlog,
 		      ctl->Plog, ctl->Scell_log,
@@ -431,15 +431,16 @@ static int choke_init(struct Qdisc *sch, struct nlattr *opt,
 static int choke_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct choke_sched_data *q = qdisc_priv(sch);
+	u8 Wlog = READ_ONCE(q->parms.Wlog);
 	struct nlattr *opts = NULL;
 	struct tc_red_qopt opt = {
-		.limit		= q->limit,
-		.flags		= q->flags,
-		.qth_min	= q->parms.qth_min >> q->parms.Wlog,
-		.qth_max	= q->parms.qth_max >> q->parms.Wlog,
-		.Wlog		= q->parms.Wlog,
-		.Plog		= q->parms.Plog,
-		.Scell_log	= q->parms.Scell_log,
+		.limit		= READ_ONCE(q->limit),
+		.flags		= READ_ONCE(q->flags),
+		.qth_min	= READ_ONCE(q->parms.qth_min) >> Wlog,
+		.qth_max	= READ_ONCE(q->parms.qth_max) >> Wlog,
+		.Wlog		= Wlog,
+		.Plog		= READ_ONCE(q->parms.Plog),
+		.Scell_log	= READ_ONCE(q->parms.Scell_log),
 	};
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -447,7 +448,7 @@ static int choke_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_put_failure;
 
 	if (nla_put(skb, TCA_CHOKE_PARMS, sizeof(opt), &opt) ||
-	    nla_put_u32(skb, TCA_CHOKE_MAX_P, q->parms.max_P))
+	    nla_put_u32(skb, TCA_CHOKE_MAX_P, READ_ONCE(q->parms.max_P)))
 		goto nla_put_failure;
 	return nla_nest_end(skb, opts);
 
-- 
2.44.0.683.g7961c838ac-goog


