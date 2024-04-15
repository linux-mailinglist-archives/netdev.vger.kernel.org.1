Return-Path: <netdev+bounces-87955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880938A514C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0792856FC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DB84A36;
	Mon, 15 Apr 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OocEPncW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8183A0A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187269; cv=none; b=Qwg6bauiuZOabchnTH7uJJ0mfpugew6IkR8J8ERxb4se+as3W4MjEqGFJ20g+j5XyGwOnNLDRfXX4x8chv1N8w3zwebgT/BuENz7Zi1+u8VCEHHjv1coaAr++vozz7yyZR8AxWklm+9pAkxen4faQqeAYpsc8zOr7bZrbLJFNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187269; c=relaxed/simple;
	bh=FOH0bg2dj6T984pv4vB3lHHu3oghm8AmO3cizV67C4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGfNRuQ0zvsHj5o8loEdaTdPEofjLiAuXp6CeWu8WAOgXtFmSy4aPY/1UBX68XAQtWFNr4z21Z5XeScXv2if07JOIN7GcDqLjvpYndR6ZfmMsVL8j5BbTzgK8Qu/kzAat/+J933T5IdLbxMQ66ihoRjRMyeGh5TLBTMv0sJUalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OocEPncW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61892d91207so37853797b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187267; x=1713792067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mgoe9sPgEPC/OjJ+22EBFraLcJf05jCazYFAHI/DlQ=;
        b=OocEPncWaCI//v5zPQSotHwc2Y1paTnmIbNnO9lNRWzVc1bYQudeifiFb+uEDNp2li
         t+KZMOdEuvSPhXGEiQk9kBuJLCq9y2m8/ctZD5/OIc5j3x08L/HrS0HNXOJ1gx8BV355
         E1T8syCJ2RRNxoRdTMYuZphcxUjh/R6Ll5nY2jQARPBT7vLPrHCOzMA+cpnwrMpx04tH
         w66ApMMjoX6fkbx9UBvKHLECjDnAUjBpBXEUDofixe1yigU+vqvcVz/+XpMQuqM/g+CI
         RYpL7fpfiunky6kIldo2/LUNYxO5OwDeUTsNle1w8cOR+ZLafNjfj+CqBriwL96m//Bu
         pCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187267; x=1713792067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mgoe9sPgEPC/OjJ+22EBFraLcJf05jCazYFAHI/DlQ=;
        b=r5hB+DJbF6MN4Stw8sCex41tyWXLdECDeWOCWmBk9s486I18rU9MXd2Qp8ZAAaaOl/
         mvKZcyBx3DmeairIVRJ/kSPv6otqf/KW1pRGKinHSlwIfb1Q4KXlnWdYP9EpTUcKsnve
         zQ5/C3wmgVJFXukiQ9bbhjHccFzmGXKrxVFOIP5TUOTcKiJ1jmV2Z2uBcKwDpVkFXazm
         FVKjLisGIrD4phDiGw1PU7I7+dG7lbxvh9HIlrA9UwZo+Vox0O242qnq7eNabAle+gpb
         19RcRwegJlAOIoeZoQkqPLkmCpro6jpA/uwLeTcRdi6/AkGUYxvGynKj/iNSjSI0HCdw
         oGnw==
X-Forwarded-Encrypted: i=1; AJvYcCX23Fhu07yZ36JHc6eNBnpEhpU5aoMfklXtu9+ibTjHaZHSyAJhqad+ppJDn0hKKpNBV881TiZs0a4oDcri96ETrinBhyGr
X-Gm-Message-State: AOJu0YwYuuD3sbP8PLEoBA3Pp3Kzwba+TXHyVscH5aWCGisyj6uUba27
	3rCdakyZbufD52YPCoJhVYbTk0r4LXBxXh0IvvAZnF4iHLQWk/jkyzjR+nn5vIAoDkZzfqMwKse
	JFJ1fMt/BOw==
X-Google-Smtp-Source: AGHT+IH2Xjl+5INpqY0J4mc3TnCIponu0WyJk+DNZXvLgUF+0FBlJp7EMxHL6trfR5nz4on1BcoBoAx2/CqebQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:690b:b0:61a:d0d7:85af with SMTP
 id if11-20020a05690c690b00b0061ad0d785afmr711983ywb.4.1713187267595; Mon, 15
 Apr 2024 06:21:07 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:48 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-9-edumazet@google.com>
Subject: [PATCH net-next 08/14] net_sched: sch_fifo: implement lockless __fifo_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
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


