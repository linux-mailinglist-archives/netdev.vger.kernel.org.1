Return-Path: <netdev+bounces-237515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60193C4CAFE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB4189DEE9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9492F5A22;
	Tue, 11 Nov 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X923Fffe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E72F25E8
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853540; cv=none; b=g+krDvNvgC5/otRM9cZWx4ZJpIvA7lZy7M30uc202puYyy3DLVBBe1QXmu5PEblH3GmC92VLaaLpOM/3AWnxQke/byunMnUpukXTDwX1pLue3+J5slKLZk3Tc5q/cNhARIcl95auqxtayJ7Swnv+EFMtIql709SyZB/5tXETHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853540; c=relaxed/simple;
	bh=zMGZl6slSYG+3nSoO8VQj/ubPkJP6O2BW16mOBnNoqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smkt10JVLg1Hl/EJk0ePGBBkN8v1xmZ9J5AM0VyedZgqSa5PzRKy92Xfv9QJkuKloWKNEP1DKNzF5b9mtOOi06Qe3lJY2UfW0RnoaLFSuBJlhkinR0zL7+c8bLw5yf4NuXSVyxzuW1jfJuvihyYdpYU3gL0VxL1S0m2iPZlOdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X923Fffe; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824b00ee8bso23726396d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853538; x=1763458338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNNwN4DGcMRn0/AGOdfFOJKOPLLLq8y3nk+GO++fwDc=;
        b=X923FffeCq34xYB8k7oah1pT8xP/Sap0zh0c9ZWajqr7GdM230LzmT0awO258hju3S
         ZbiyBRvNCvK2IXDeDZdAjHJAX5hNw/wWNTJ3b7JGKIbmJ0XEagF/Q0TZZV2RKPIXHRlK
         9z7rBrBJ66sGwMlEoL+4lQS3yMmoqBnRv0T8UGkxewVN1OaWrq0VFno/mz+puTcrryyi
         GO7yKQBmaezzBcVxlfP6jajecBBOB2WGeYSCggfvRYyRjaK52RaWLAQOJFP5BR1wOda1
         qLgxDthQSQ91ZNnLZ+cdG3rbPHdyWH3+fUWDP+k6eTyAHQB7yzp7pH71wNwqrOYYf4Je
         PyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853538; x=1763458338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNNwN4DGcMRn0/AGOdfFOJKOPLLLq8y3nk+GO++fwDc=;
        b=KjF1QPZvLQsGesy2lVXTjXb5SieZ1iA2Y3Mh6nfO5TlrTRFJPUhNCG0DJs0ohAsbcg
         FqmE0VhWqAawBA31Y/dZ0+skRYEP1Zk2jF9qaPzK63Yla7VLQLSmHbiS8FEmcchgC2e4
         vv+58ZqoEnOt0b2cy9/DefLSfrt2JzLWnWsioXKfa7mtrvreQohOoTeXKpdM2EWeavEG
         Pej9iqsWRXJJKdqF9bgqPPsmV+oWSTRNKo+Ot0bHuDyngtcFA0eovER0YzkjlxX+nUV+
         YMrFkJ/kwQTBZ43ODxJp8jcEN0uI+y8gQjhff9pzKjMtezcHuyScC49tBL2Jjc8kKHXi
         MuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrI4ajPAIgDJL5sO/j9HOhJR+lQcrqFz/sSUG4fGpOIMHaN2Wdw/xS80vqP9zow90s1wi+Pjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEe1So7qaCSs+GiaD9lNG5MIdkkaT2FEP+n5/yBysagRlY2UQ8
	Kgb4FyptH7sqHkjqimeMpC10rXefwVF3glCYGWQAUKjv/qTnzWT+DbrML2gVQlUEm7jzxEz0sgT
	0KbRT3HwisD3DHg==
X-Google-Smtp-Source: AGHT+IF8Ezx6uNXheN1Tw9uCPBcH9VLGoAaZwanxU8b/tTqs6YgPRtRMEqGrq/hmS2BRhCPRtBgXfrsUv5pcXw==
X-Received: from qvb11.prod.google.com ([2002:a05:6214:600b:b0:882:4c5e:138])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1303:b0:880:4b29:d96f with SMTP id 6a1803df08f44-88238678a3fmr149762276d6.39.1762853538482;
 Tue, 11 Nov 2025 01:32:18 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:58 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/14] net_sched: sch_fq: prefetch one skb ahead
 in dequeue()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

prefetch the skb that we are likely to dequeue at the next dequeue().

Also call fq_dequeue_skb() a bit sooner in fq_dequeue().

This reduces the window between read of q.qlen and
changes of fields in the cache line that could be dirtied
by another cpu trying to queue a packet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 0b0ca1aa9251f959e87dd5dc504fbe0f4cbc75eb..6e5f2f4f241546605f8ba37f96275446c8836eee 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -480,7 +480,10 @@ static void fq_erase_head(struct Qdisc *sch, struct fq_flow *flow,
 			  struct sk_buff *skb)
 {
 	if (skb == flow->head) {
-		flow->head = skb->next;
+		struct sk_buff *next = skb->next;
+
+		prefetch(next);
+		flow->head = next;
 	} else {
 		rb_erase(&skb->rbnode, &flow->t_root);
 		skb->dev = qdisc_dev(sch);
@@ -712,6 +715,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			goto begin;
 		}
 		prefetch(&skb->end);
+		fq_dequeue_skb(sch, f, skb);
 		if ((s64)(now - time_next_packet - q->ce_threshold) > 0) {
 			INET_ECN_set_ce(skb);
 			q->stat_ce_mark++;
@@ -719,7 +723,6 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		if (--f->qlen == 0)
 			q->inactive_flows++;
 		q->band_pkt_count[fq_skb_cb(skb)->band]--;
-		fq_dequeue_skb(sch, f, skb);
 	} else {
 		head->first = f->next;
 		/* force a pass through old_flows to prevent starvation */
-- 
2.52.0.rc1.455.g30608eb744-goog


