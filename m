Return-Path: <netdev+bounces-89025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBE8A9415
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAD8283CC9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8C7BB07;
	Thu, 18 Apr 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIAQ2Bbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D167BB15
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425586; cv=none; b=qo/Igevb0+KpL7VYq71mFR9X+AArosW838AjP+1Axl5+kokhfhxuR4wutX5XfiiGXlqLn+txlcLGOlWZMq9lH6afWGmrDr4QcqEuGq2gDRGwsZnhXKEs/Q6K+qj8q/WXHTTgehULlbuJHGI0ztRUd4MAnU7doLFiBigQIlBMsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425586; c=relaxed/simple;
	bh=FOH0bg2dj6T984pv4vB3lHHu3oghm8AmO3cizV67C4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2PmkDuigwu4L2YmH7MA6Lvp8tI2A0x2Ygjm/QySIlZ9CXtA16AVmZaXpK1hwlNNbLRyfXoeH/grxXlTm/Ap6TKB1XdmjFACt6kUwTwpz46Rn0lCkj/owZZEsNeOc/njIzTjtmJMKWwmW4OwcmgZvp1hDo9FIaVEViw/oRLt0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIAQ2Bbh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fe93b5cfso8197477b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425584; x=1714030384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mgoe9sPgEPC/OjJ+22EBFraLcJf05jCazYFAHI/DlQ=;
        b=dIAQ2Bbhog2EtSnV5THRDPVKfQdWfdSHA8ISJvRMePr0W/XLuVUhY/7QTxT1B92lYv
         uauLgkIFp/Yao5wCV4SJL2wf1C4Ev8qqhLOwv4JshSpgzm5nn1UJNY3EL26GOxC729Kg
         5moAIXARZw7BkejLzVQNhI4NZr8ppirtv+ZmF/PsPFr6qnhkrFJqSm+OHhoSnGJijHeK
         RF4OniMJZDbMO/o7UzIgN2JgG7NhnBX1ZgREfn+YKvxRC4pLHJGEKHvOfSnWZxaz666F
         HSPFQkRDOx3NhooMZVdPAVJXtt98jMwHzO4S0t+vDtm9loyZG108YLP37DB+lObphVNW
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425584; x=1714030384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mgoe9sPgEPC/OjJ+22EBFraLcJf05jCazYFAHI/DlQ=;
        b=ctiTrozkeYS+PAn9oz5U6GPSw94MuIRK0ZTJl5OmONAdD7wAuPl41IyurntxNraivh
         4zgIYz8sQwBbSBFy02KqLaGUhyg1pSeUTvHXE1ThV/kdsXD9aK4WS7jsY1AsQqlCl5DR
         Ldpq33t/m1u0pKSwJfiOzrTLzIx+VuDYqqGOwA8oACE5C61eK5cj+oWy8f9ghdnJ93en
         /zf6GFBTAkcwE0P8qBVbKyM/Hwn1IeV4tlurRK2Rojko8zo3fluneos5X2i9IukR2A5D
         xgbp4iKcIYRkBymdbyLYeV8RxHgZ7dyvioHdT7Sp2963gEi3uySjdFyQwM5G6478tLPd
         IEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoJ+BIz4nUmDBO1jFO7K5VOdOx9tayi1nyUQKcTWAA4GL36X184bMdbOhODyfOrf1+Wxk1XMl0pIxCrOkzoo1YRWlLiroV
X-Gm-Message-State: AOJu0YxgGFj/S9O0mdhpdT8dc0EQNifAV7MVIOnTePLOe8pGkG19deCM
	pvDkpHInrJxCFszLfRNMCbor5URmAFAD80xr7kbrorB+sKv/NA4unEg1b4waAwGiHpWR14+fjOr
	GuImAq2mY+Q==
X-Google-Smtp-Source: AGHT+IGTvstfTjtXZlgZ+fjC6VOgu60knvwQkZRMcKSXXEaeCjTHAQE4GyYZQ1WCOtZaoJdpWfGFku3wkIaRfg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2988:b0:de4:7037:69a2 with SMTP
 id ew8-20020a056902298800b00de4703769a2mr10067ybb.5.1713425583961; Thu, 18
 Apr 2024 00:33:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:42 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/14] net_sched: sch_fifo: implement lockless __fifo_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, __fifo_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in __fifo_init().

Also add missing READ_ONCE(sh->limit) in bfifo_enqueue(),
pfifo_enqueue() and pfifo_tail_enqueue().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fifo.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 450f5c67ac4956e21b544dfd81f886714171eced..b50b2c2cc09bc6ee5b23d9d5d3abea4423ff75b9 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -19,7 +19,8 @@
 static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
-	if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit))
+	if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
+		   READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
 	return qdisc_drop(skb, sch, to_free);
@@ -28,7 +29,7 @@ static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static int pfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
-	if (likely(sch->q.qlen < sch->limit))
+	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
 	return qdisc_drop(skb, sch, to_free);
@@ -39,7 +40,7 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	unsigned int prev_backlog;
 
-	if (likely(sch->q.qlen < sch->limit))
+	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
 	prev_backlog = sch->qstats.backlog;
@@ -105,14 +106,14 @@ static int __fifo_init(struct Qdisc *sch, struct nlattr *opt,
 		if (is_bfifo)
 			limit *= psched_mtu(qdisc_dev(sch));
 
-		sch->limit = limit;
+		WRITE_ONCE(sch->limit, limit);
 	} else {
 		struct tc_fifo_qopt *ctl = nla_data(opt);
 
 		if (nla_len(opt) < sizeof(*ctl))
 			return -EINVAL;
 
-		sch->limit = ctl->limit;
+		WRITE_ONCE(sch->limit, ctl->limit);
 	}
 
 	if (is_bfifo)
@@ -154,7 +155,7 @@ static void fifo_destroy(struct Qdisc *sch)
 
 static int __fifo_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
-	struct tc_fifo_qopt opt = { .limit = sch->limit };
+	struct tc_fifo_qopt opt = { .limit = READ_ONCE(sch->limit) };
 
 	if (nla_put(skb, TCA_OPTIONS, sizeof(opt), &opt))
 		goto nla_put_failure;
-- 
2.44.0.683.g7961c838ac-goog


