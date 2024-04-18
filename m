Return-Path: <netdev+bounces-89031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF48A941B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A47E1F22802
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C976413;
	Thu, 18 Apr 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDETwkoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149E7D3E5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425595; cv=none; b=VNkEeXUJREeoVivEI3LoQgEj73XWSWTubqTWcxs2qFMWnocIawm18n3iuHOVcmg5CNwklc3jktnguBEORKV4G1wu9dVVIYVOnRfQtTTYCdSUmlg7ICvQlakGoCUMsE66OglQw3m8hXXJVqmKEoxjspbSqiVMxniICp6OKb5k4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425595; c=relaxed/simple;
	bh=UihTBynof5ByLo8nWwjGOmB5TjVe1WZ5vmelRO+R5AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uq/y0vpQDkvEQeuvcMlW6EdYhf4hxtWJPymtdjGXUKVTtIPDl3O99N5n3OB0h9Xzv2H38oWaD7CTHJSpElH4el3ps4Ul+JejgcbOdKXVbcMlTJCm8cgVO3VEb3T6uQvYNNHALKSGidkqRGoRrcsgxOIxVZV8aWbS/0Mfu5Nr8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDETwkoJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de463fb34c9so1134331276.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425593; x=1714030393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Znp+vQdYzVYcETVz3Us8OPerpcvuVBrznxNI9AWwpzs=;
        b=uDETwkoJCXyWc2guV3bYm9zuzPpQf+51WvgovrtI5/31mLdspbU/jdPIUuyPj3NkT+
         85AV76GQnKY9aeKjR/RgNnv9axP6qebVTgwOz8pbZfdwfWDbzlnk5+1sazQ8YK1jxEpG
         j+coICyiCtLcxD8RUkY9BMYTCRMTpLecJLBEGGC2A2Z2F4+UhtFbcgrikNClLxwjgYLc
         ZtwRO6r5uL4UhzGe/8uxcvxQomIrv+TXJyDXUqdDW6omD3jYdK4WLMvYELj0XL2NpqPN
         5Ag1REQIbLkVf8JhfmLz4LUKq9juA1TmReiQ3jgAwAuTWDCcxrWDcOMVjFmYDsVWGETC
         VmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425593; x=1714030393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Znp+vQdYzVYcETVz3Us8OPerpcvuVBrznxNI9AWwpzs=;
        b=BAxOYPyc6LhSJCZ9H3Dm1v4lvRo5n9qeNuRQW1eCOzYwXP3tTeoMEZuGL+WOGj9zON
         2ZIj5lvm6b9Q85pnIPG4k+izHBYFMpzxVI00oLKXhZS757UpIFURHb5/iluPd5cjJxPX
         H+dMlRWV23MHI9kSDFonq3AchiwhP8r5xNpXQ7638KGuzKmIFTcj/VI+FK90hYgcAof0
         IKErPgNQe2jox3nE+ijgWASejGiy1q49Wkq2NAK2CMtZ1c68vDuQqBGri2RI78sRS5t4
         iXoSXc+AAOifGqIRWwgpRDN+BQYfO7T/TwvmDj3CwLXIFJKmCYqNG4UkZ5oT7RFFpKKz
         pbfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxo5qwRarVgzBrtG/YDt7ffIRIpVyAgntPENJ6oVeBouhTfyZ4f20NyhmygMkcQURM5g0ct94+/k7qicUP4fGOf6K7g1j
X-Gm-Message-State: AOJu0Yzu96wMVo2hTrEa94Ygh+MLTyyxQJSeTGMrn+hdX37NQG9gT3nn
	nnNj/oKR85LnZF0sucae+ceTvLcFA3PRikzl7jJDKDfNthTG3gzJTp0gQ1AUOzw2uiS5Y6TML7X
	Lf8g8J4fyxw==
X-Google-Smtp-Source: AGHT+IE8Hie13hSVq0XWDGdiW0SI6fH903dqPHpHeTAYIDwA2H+Nn9Zo3at3R4HRHYL85tUuCRxL1KsK3epIzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1141:b0:dcc:8be2:7cb0 with SMTP
 id p1-20020a056902114100b00dcc8be27cb0mr175009ybu.0.1713425593327; Thu, 18
 Apr 2024 00:33:13 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:48 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/14] net_sched: sch_skbprio: implement lockless skbprio_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, skbprio_dump() can use READ_ONCE()
annotation, paired with WRITE_ONCE() one in skbprio_change().

Also add a READ_ONCE(sch->limit) in skbprio_enqueue().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_skbprio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index b4dd626c309c36725e6030a338d21d1fabcb6704..20ff7386b74bd89c00b50a8f0def91b6c5cce7f4 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -79,7 +79,9 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	prio = min(skb->priority, max_priority);
 
 	qdisc = &q->qdiscs[prio];
-	if (sch->q.qlen < sch->limit) {
+
+	/* sch->limit can change under us from skbprio_change() */
+	if (sch->q.qlen < READ_ONCE(sch->limit)) {
 		__skb_queue_tail(qdisc, skb);
 		qdisc_qstats_backlog_inc(sch, skb);
 		q->qstats[prio].backlog += qdisc_pkt_len(skb);
@@ -172,7 +174,7 @@ static int skbprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (opt->nla_len != nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
 
-	sch->limit = ctl->limit;
+	WRITE_ONCE(sch->limit, ctl->limit);
 	return 0;
 }
 
@@ -200,7 +202,7 @@ static int skbprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct tc_skbprio_qopt opt;
 
-	opt.limit = sch->limit;
+	opt.limit = READ_ONCE(sch->limit);
 
 	if (nla_put(skb, TCA_OPTIONS, sizeof(opt), &opt))
 		return -1;
-- 
2.44.0.683.g7961c838ac-goog


