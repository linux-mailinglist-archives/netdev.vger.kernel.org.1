Return-Path: <netdev+bounces-237134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B5C45B56
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2C114E9C97
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37283302158;
	Mon, 10 Nov 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4mqSD7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE630276D
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767936; cv=none; b=FREunfgLjlJRMBHqg479iSN7tvsRmHBHivLAQeUlIXpzdIJlryixUEnOqopC8BZyxYpswz977QxUpjVNhAshXblJkzokTvukhCcVKELrN676Z7WSquHHqCWWedQzLVYiEobuEB0Z6wTIsSInD3N01KGMgNqnEZJR1W7gCdkEo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767936; c=relaxed/simple;
	bh=U+Q6HBkH/EaqnFacmeBoCewhqW5AE4SIxWOsZaRzYRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZbouwzdyRqWUo373FHasJyutbX68yEBSNbWhzxF7XpUPq0QpsY4DquRhf5bYVYrB4uG32VaOMeioPZMT41zsXGSdEQJYSoefbsO4V27VyMEh6VYtu+AG9YtUmcSJSEeQ3Sd8bdelesvYCAioqxKDl5q+ehGX1hFJwCn6Q0jqPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4mqSD7w; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ed74e6c468so37700111cf.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767933; x=1763372733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rxQWPw07IXljR6ASfzKxXbue0kpoNIeXhvJKhiunWs=;
        b=C4mqSD7w6GsPDkoowK5ltkzRlzyySqGUsD7Nqz5IFxBLdz0fqAKXdYMGv0zbX6Y/bI
         yKMtunE7hSFa5Bp//NHCpy1n+G4BhXUu2FEUaPn7kDzWBtfVF3xcvO6e+CEgWNu93RFy
         KAOvLtteWd0k2LbuIr7ngdkefZLL0Cki9yqCZaoTqftnp+gmjKo9jh2LLzIpMYUJLdj2
         XepkK0Dv2s5FKoGJWlsJ6VTVhAoT1JCsDMKXy1Lu2MwWfjLJiiasAM2xGUH48Nlcb+qY
         hzBrPnG+ke/5GFjsix2WSQj0spmRU11/leqpgCtplC7vLkm4pef0Woi1EOwvTnbPyufb
         MQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767933; x=1763372733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rxQWPw07IXljR6ASfzKxXbue0kpoNIeXhvJKhiunWs=;
        b=XnP3hu0lkRPB9YQs6nE62SMKOLyQsdRkwOT6yKyQcp5Woa6Jm9x4Po1IFL6QQC3/4G
         H3x6AR49OaZ9q9WCnMzibpfeGiGIyWdnARQOH2kzCfreyI16zWzlTFuSD/ENEU+uNhXQ
         kGXo0/Vu0liilETH1kedmpnZPS/3HMGktayxNfc7GdaZgtL579YPhEwq2IoO169yRT0T
         FFzg/ye2iuwPN3O/7KXz9Ky0LD9jrCcpTfeMnU4rEkffugi7pbfeXgpIrVB9DcnTopM/
         PCSgKwxlApK4w0Y7CI5zNPo01gDcQmTUtGssEMVsUVkWldPFKX0B27hA35KdaSdLLTdx
         z+MA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ//GyzXUcmekmjKsnd6MlFGC5udL+UkWd3Or8mv8Teh4HMARDfXlXDfNxn/U0QLftR2QOAL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC4POxC8uP2lCUOj/MCpob35oXAYdionh0YDncLKwvASP0/1Q
	6IK+5EFhquy9egbnX5AgiGMRsGNXUvLK63vQVix7c7jM1Mso532ujeDglNG0aLPgGf5E3n2iVjj
	LnxGEQHW4jXQBqw==
X-Google-Smtp-Source: AGHT+IEpAKKw+3phdqFTUURQ/Vub+BNZ7qJyjWD0HHWaDXEPjJLnvqu7fI8OEgFOnEXkbcNbMNrZu37I7IBxtA==
X-Received: from qvlh19.prod.google.com ([2002:a0c:f413:0:b0:880:6bc3:488e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5907:0:b0:4e8:abbc:a7d7 with SMTP id d75a77b69052e-4eda4ff5eacmr84332911cf.84.1762767933531;
 Mon, 10 Nov 2025 01:45:33 -0800 (PST)
Date: Mon, 10 Nov 2025 09:45:03 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-9-edumazet@google.com>
Subject: [PATCH net-next 08/10] net_sched: sch_fq: prefetch one skb ahead in dequeue()
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
2.51.2.1041.gc1ab5b90ca-goog


