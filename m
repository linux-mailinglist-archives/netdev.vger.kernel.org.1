Return-Path: <netdev+bounces-87961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF68A5154
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030A2284251
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281784FAC;
	Mon, 15 Apr 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ut4Jt07v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BA84E16
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187278; cv=none; b=oudDyu9bUE5kE+LjFq2y59AkYV2A5tuHoaCz7P52bDtpYjPq1L7zQMWsL/AZs2dN00Bm+eajsjEC7Wp5u5hCJv1joxmtIFBhzqRDWU0juYXrdeGWUJoQnB6Lni8ve89lDAmAXPYOw8EU8OaP1t1ia/2y6MD74TPwNGsJwVp4gVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187278; c=relaxed/simple;
	bh=UihTBynof5ByLo8nWwjGOmB5TjVe1WZ5vmelRO+R5AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ovJ7tYoClMteh/e8gKPcgfHStbSKgyDF0JmcrMr2mOoXaJuhD+4CteDgnF9rW+5WysGntNGjdQv7KNNnFz08z5WNs27t+ttMESVX7b3cOtc1u3W6CqrpaGNhB4Pn2Q0pBDdgoUk+qAQRD7bTt2nbsYNb6GbImE7/O3viMUvtLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ut4Jt07v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6183c4a6d18so48984647b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187276; x=1713792076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Znp+vQdYzVYcETVz3Us8OPerpcvuVBrznxNI9AWwpzs=;
        b=ut4Jt07vZU04zpBfku9lVNqs+/grYh7Az12LblHHQLEBmkOQXKBPRKT4fobdNhLJvI
         DOMAEZGaR7dgIzuu/Xdy9udqWurrdFpADQB9yB6Sr9LWTb47XJWgM5Ozib6h/R0Y8Ah/
         mSC8w63RSmTfob3e2B7WLEgVWyM0vfHcD6Xn1RhPEzHDvXfY4oxCo+UbXjQkM2rVuU88
         ag+ZSl1TuGyF7p0Sq7kFCH78ur367bBwLr0cU3fM1LLSd0SKtdU058/3wZXfsz/y7YeH
         LwSo9HK4EYrAUZWUYOHhuaLcnrRE5Ma+jiCljJUfsG81l56AGNl+/iOV638xQtZ7tV9X
         ygug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187276; x=1713792076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Znp+vQdYzVYcETVz3Us8OPerpcvuVBrznxNI9AWwpzs=;
        b=FfdSeHsAiUf5KQrapZtfmFc/Zh8hnFa/kxGUYSZj05vqZnlVmB1p9Z8wU9lMYoB0gY
         fMQu6Am33N3m2JJbLFeN3l3eiECOi9Yl3d7u4cgpDwGSTeyC1/CIOmeiLyNfD4UQCRnN
         2IjOD3Zf7VdPoSbjU/6EWFEDDA46rHli7YhRRJzdm3AupT0SCg+C1P/PgWOEicJfBKsc
         IwB9M1iXMMinTkmUslUVoFDEDD6Y3GmE+e54l9QX/w026F8TKI/G0E8c3VPqZ80IS27B
         UU5fgnzU8g3uLRti+dNNwMjPy2wEj4I19dgegFOhIYWW8JoryV5y8Ow0fwwzF0sLKY0M
         cbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5SuGEb8BhwMqJQf/yj7P61FAFdYB+mbpiKu+MhngyyzH982j87DdgQyHUMcKR1eweXJT2lG39YtmOz5ogrya6H0g26D3g
X-Gm-Message-State: AOJu0YxZvyzyx7v14PczzKCp95rpccku5+6zyiQLCeoXASJEv8pSzj9W
	4G07s0dn47EFzBl2PUAS2sTBVHVpoysbSexUpa54KmqsoPrjq+0RtUwlwk4QCH2SWHe3ipRYUh5
	1Vj1QDAXVVA==
X-Google-Smtp-Source: AGHT+IGWSeEEmDug5+P0RUq8SP/KB5Iio3SLbLzm77PNN1+ENHvqpoQocbx+PXobEhN4yCnwTL4Ifn3udB16hA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d886:0:b0:dd9:2d94:cd8a with SMTP id
 p128-20020a25d886000000b00dd92d94cd8amr736954ybg.9.1713187275828; Mon, 15 Apr
 2024 06:21:15 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:54 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-15-edumazet@google.com>
Subject: [PATCH net-next 14/14] net_sched: sch_skbprio: implement lockless skbprio_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
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


