Return-Path: <netdev+bounces-83015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E78906C5
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE5A28F87E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0E1311A0;
	Thu, 28 Mar 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOxJmiUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F8131BA3
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645399; cv=none; b=IemnSaljglBFV0uCEJA+1gDbI7NJIy2eP5mI02i+jNkvZ+xUzhGgtYRk1RjTss9FwyixDA5Wr4Gz2+FfwFocby9jdXeTUS6YwMBtDQoxcpkrjmhh5sDibtsDSzz6C10BSaoJwfqCtcUd+8H7r4OYkVJBPxnYMukL0dxF/4Rsdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645399; c=relaxed/simple;
	bh=dN/v+E0kL8WG56Mv6N2bzCQJg+7TLsKE8PqoMrU1wOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FH6IIeja1+p3J+csPgpBrYvUXm2K3IJUEycGvWbhYMHmf2vkZYGIsF5DUU2nE7uhaedcsBvtKmegy1mACoBia/OIi7JNGQB8gsxFhQIbLnGessjglfGhFJFprZmp5K4Obj1BWFkGi/5mTKYiBqyXaNf9+fRtZDzpeFrhJEeR/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOxJmiUC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a54004e9fso21966967b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645397; x=1712250197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg1OdI5e7r+RvUDxZBQUJCmu93WtBEz8eFjqLMQtw/s=;
        b=gOxJmiUCuBO2hh0GC93Hi7fGru8z+Qm57jdyKKq9NCu3C1A4jiSQ8k6er3kx0hTqID
         fCA4ZpgGTL/N1jp+ixsGEas5gB8O37x75A4tb5NDAI6WdiY1vyOn1e6OHzbA8tm04To1
         wloloD+uUrNqc4BCBSdrU0P5iDPFP6HNBGnWIy26jCSgblxLqQyzKfIayK1e+R2Syrpc
         Gwtr/QhvnvUZQfPgfsF0+bORDVMIRw+mwPld3QHf/LaNHMOHs8GclyAYtWC5ZIojilVv
         P5Tu61keRyGSkzw5+GjMxojLhbB2rNujFpQGop3yvQ7h7gS77PSilK5x9u3+6NbjgqcJ
         6WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645397; x=1712250197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg1OdI5e7r+RvUDxZBQUJCmu93WtBEz8eFjqLMQtw/s=;
        b=HGkbhhj2ke7cGuxLBBuJ+jutL6Lavlhx9A3CSJCX0pwBC2YFm6+Bg10k0nXefu8pZi
         qQYzKJuZEUvZEtNA6oMgfWOL1wL8eCCXszPmUEvYn+GQCh5v0XdJEwjuqe5915LSpnFs
         EU433QGQ7KnL4GPNkUrGSfPGKpQ1ScukNLhtWniTlaXMwk/lUqaqBACoRWzcvtL4O3CK
         Fe0lCp8aG8ZYm3vmwn/GKl8Edy7NmXf1XtZUCovfoJUxBQ4PGTQI5gW93px3EtrbGG7j
         /OW0Kt+K3jib62W20TDy+Gv6tX+JZ528W3LgTshazKF8tChS5/gYt6FcZaU9zYWq6H8b
         mM2A==
X-Gm-Message-State: AOJu0Yz9bwovV75iCkqeLY8xdDhPsD9vxv6dOgw3u+jAxtiP/+6XbcoA
	z/me2cdSjxS+BYQ5J0+Z32PDBf4VlWGcofoAlqsA5eZeQxoFNzWbkYbbqY4txu2p3kTtekjOjX8
	Jh35EL6X0ag==
X-Google-Smtp-Source: AGHT+IF2+6girXyoZaFPLNw3BWl6MtVk49zlLOSIu82lkK8jgxX7qHHaqDCEGz0PHoNvFGso/t8yAx3w8HMrCg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:6dd0:0:b0:611:34aa:ea6e with SMTP id
 i199-20020a816dd0000000b0061134aaea6emr4392ywc.1.1711645397135; Thu, 28 Mar
 2024 10:03:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:05 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] net: make softnet_data.dropped an atomic_t
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If under extreme cpu backlog pressure enqueue_to_backlog() has
to drop a packet, it could do this without dirtying a cache line
and potentially slowing down the target cpu.

Move sd->dropped into a separate cache line, and make it atomic.

In non pressure mode, this field is not touched, no need to consume
valuable space in a hot cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  3 ++-
 net/core/dev.c            | 13 +++++++++----
 net/core/net-procfs.c     |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 70775021cc269e0983f538619115237b0067d408..1c31cd2691d32064613836141fbdeeebc831b21f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3236,10 +3236,11 @@ struct softnet_data {
 	unsigned int		input_queue_tail;
 #endif
 	unsigned int		received_rps;
-	unsigned int		dropped;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
 
+	atomic_t		dropped ____cacheline_aligned_in_smp;
+
 	/* Another possibly contended cache line */
 	spinlock_t		defer_lock ____cacheline_aligned_in_smp;
 	int			defer_count;
diff --git a/net/core/dev.c b/net/core/dev.c
index af7a34b0a7d6683c6ffb21dd3388ed678473d95e..be2392ba56bc57bed456e2748b332d4971c83a4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4790,17 +4790,22 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	struct softnet_data *sd;
 	unsigned long flags;
 	unsigned int qlen;
+	int max_backlog;
 
 	reason = SKB_DROP_REASON_DEV_READY;
 	if (!netif_running(skb->dev))
 		goto bad_dev;
 
+	reason = SKB_DROP_REASON_CPU_BACKLOG;
 	sd = &per_cpu(softnet_data, cpu);
 
+	qlen = skb_queue_len_lockless(&sd->input_pkt_queue);
+	max_backlog = READ_ONCE(net_hotdata.max_backlog);
+	if (unlikely(qlen > max_backlog))
+		goto cpu_backlog_drop;
 	backlog_lock_irq_save(sd, &flags);
 	qlen = skb_queue_len(&sd->input_pkt_queue);
-	if (qlen <= READ_ONCE(net_hotdata.max_backlog) &&
-	    !skb_flow_limit(skb, qlen)) {
+	if (qlen <= max_backlog && !skb_flow_limit(skb, qlen)) {
 		if (qlen) {
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
@@ -4816,11 +4821,11 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 			napi_schedule_rps(sd);
 		goto enqueue;
 	}
-	reason = SKB_DROP_REASON_CPU_BACKLOG;
 
-	sd->dropped++;
 	backlog_unlock_irq_restore(sd, &flags);
 
+cpu_backlog_drop:
+	atomic_inc(&sd->dropped);
 bad_dev:
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index a97eceb84e61ec347ad132ff0f22c8ce82f12e90..fa6d3969734a6ec154c3444d1b25ee93edfc5588 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -144,7 +144,8 @@ static int softnet_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq,
 		   "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x "
 		   "%08x %08x\n",
-		   sd->processed, sd->dropped, sd->time_squeeze, 0,
+		   sd->processed, atomic_read(&sd->dropped),
+		   sd->time_squeeze, 0,
 		   0, 0, 0, 0, /* was fastroute */
 		   0,	/* was cpu_collision */
 		   sd->received_rps, flow_limit_count,
-- 
2.44.0.478.gd926399ef9-goog


