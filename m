Return-Path: <netdev+bounces-240693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80438C77EBE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 08EAE3211B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8333A706;
	Fri, 21 Nov 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGSMPvxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D72E041D
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713993; cv=none; b=mEwrNnhz0VuX7vICxKF3Rq3mPnTBxez+/Rj6zEctUS5J8MAfJ6McvyRCZDxLTzm3gTZ05niJNdUNRM5pLwgPPX2vK/i0cy52vFuoI+8ZfU6hGPz6fZ0bHJel+DFAaJYB3uXicw/YB2s5GlLggczuGFudJ8TlxNAxRXmHIK4OR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713993; c=relaxed/simple;
	bh=EoxVpu/ORRnnVZ1X3PdYLlVKakhUMG2n2Ff/2U7UIgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebmaSFFO+yQQNFgDFyEUkSF/98M49tYkEZ0UpNjMxL4ctPUnlAj39+2W+qx42zCUbpIH7rZWAxYmke8ZaDwmGmoBHzdKH5fipbdB7fyrKpLGleMF/+A3W7urEHmZbvAphWBS8NBhfaiQta3cQLPJq2k1wDYjC73lYOJtyE5kdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGSMPvxV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b244ef3ed4so519092185a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713990; x=1764318790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lqt1q44zF7W8hNtfP2b6O9ic+Fn7ESI1v1ZIvnwP7w=;
        b=pGSMPvxVf73BrhUJMSrvIBmjZx24rh1iUowQjeBOPHteVJroXmvYruniIpwjnkPr65
         i8Tb1Za6YQuQ0Auooaj8B5AnHP8bT5CzLKzUWIebGuAha+vk5J6pI2+5K2phKEiUywkq
         keYFAkl0/7OlJpKgMefpCF+Br0u2YUWs7jqeclm6yyla0ffuI15MYW5Dn8EG1VrDELjH
         gRCMNefRqzWkSVe6Ir3a58bAXEIwAftvpnrKABb01sxHjjBbFt4SQRi97BqrHz3tpf5O
         tQ4sBs+CKiAVPqrGzq8EFpjCEsGS31ODV7a0ln+I4nPSGU5NI/1ybXjF48gsnLjnycwq
         VgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713990; x=1764318790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lqt1q44zF7W8hNtfP2b6O9ic+Fn7ESI1v1ZIvnwP7w=;
        b=Nd6qoDoLgc05ywZ4RLY+V3F4SqnFYguTgiGhlQ6vVhLYcxdq5QMV+alYt7hDZxPv64
         XnE+vRNbmyjTqBIgXR1/TzAcu+VkWqiodQv+r+dhiJdTfLG0juiq5FIl5ld97SzBxeLM
         N4cUtzxLGUQvO1hqN3x8RtA1am8hpAl/4MCU5lYrw76l2FA6gX2AiO9kOxV9SyHETKMz
         x8ZxkY8bZDJstjfp7bCeO9VBn9fRw76ebfYua7Y5QHcGo798mJuWbo3kH1rAop15NbA8
         NHiiZ6oMeumm0tuSvydROmCiMxyPXQW2veni5/ka64N5Tajr/7dwwjKH6q+QKul+M3Eg
         1JOA==
X-Forwarded-Encrypted: i=1; AJvYcCVrubGBTYO1T6bIz3TKpp1d8AZng4k9sjFTSRKGPoGCpGmm9Ob9IKUmXWDJqB4UwTRNfRNeUzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlUqmhkFn5lNNMAkcv91Ah/10cQIbEyHs9Lv+0I9ZehW6fkSu
	IkFDvFK3k60lzS5flC0Dkc5OGRwMU/ag5T1D6eaknqOb4mqWohaAf1rTdOatpwGdNY7Lih1A/xY
	CpTzjgZQdZvTvgw==
X-Google-Smtp-Source: AGHT+IFpQsuTiAusVNJ+gkFZhFhSmmNC7dUNbFh7d7BiyaI8HJF29wT8XlYPMIZk1kAhyjb6CnsSDEZYRxEM6g==
X-Received: from qtbbz5.prod.google.com ([2002:a05:622a:1e85:b0:4ee:c07:cabd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:393:b0:4ee:1962:dd46 with SMTP id d75a77b69052e-4ee58916841mr20490331cf.79.1763713990311;
 Fri, 21 Nov 2025 00:33:10 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:51 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/14] net_sched: sch_fq: prefetch one skb ahead
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
2.52.0.460.gd25c4c69ec-goog


