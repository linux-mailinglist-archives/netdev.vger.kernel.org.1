Return-Path: <netdev+bounces-83362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02868920B0
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663AF28410D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9D4597B;
	Fri, 29 Mar 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB9MEdVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BE3BB55
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726955; cv=none; b=m7qWdtm54cpo27kT1CgBNIYfuXQVFfLAv1kWvdX06AAVYdZWE2Pv42olANLx7UWcfsaZFJvGrFcWlJ9uIKX7a65tQSXay3zozfe0dWYBOtLo/m91443Psm3E/Nj3gnj05WnKrYoHsufvc+qLYr8Kt6mx5wXK8sK4zpa/fTu791Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726955; c=relaxed/simple;
	bh=49NfDQcjQcBykvTuhA4xf8SLni3I9f0ooXUsLaE12ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/BN6OZvT8plgSvpqi1MogVXRegy+1MRBg3LkHWZTUsEHeMBUeMiru3rDRU3WMqoQ/EdCDsT61pNVbF7iW4wYgpDMY4tm4jk9X4iHlAffAwy1Ec+ywHbaFtqLm6W9GyyMvVBzJ+MdPchdMPSMU6dCdP/XVWhkKhu2h9sjxz+tEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nB9MEdVV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso3154828276.2
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726953; x=1712331753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MaqyQyrTnGAJTp/NlfiIi6i7imHnUe1aPUmKIFthC8=;
        b=nB9MEdVVbbcjy0pENeZsPl4SnI0Z6JCJ541F9j9rjsffWfXw4uALD+hneYFle+Ww5R
         KP8WyUuHypv2p/MrQCNuxrJ2IBQjwMChLZ6sRf4H1uX1HaS6m35ldMlEDer+C9qpAHKW
         rX0+BHywCFvLNY8ncSk7m2MlvLsehhS8WHymXIRGms89JIi2Qy0EBC2x0tl90bnoMGF/
         sg3DWZHBJaFZyAdt/6bblnmu3oMCFoW2OiRBu1v2DsrcIYC83WhMjOyOf4tpYSleLghZ
         8z7z9Fv+NCVERqKkBPFaUdol5nt1H8jmvAHdHwD74W4C/8C5s8+ile40id8kRMyoo4Ns
         rRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726953; x=1712331753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MaqyQyrTnGAJTp/NlfiIi6i7imHnUe1aPUmKIFthC8=;
        b=MFDc05Vp1H4mz/qGWyuN5EsZnBK5oZuEiPOY1DAOOJSXZ0tzBPgZRLg571ehvvYwnP
         mSNm6iSByWEh/U1CCFXsCF0drE8NArfZ/+HEFPkI57yc1MCuUEr7KovhwofpR+PrBgoF
         YGg2qyKuWg1yXME+9un6hV0cyVYvVO/K/tl7osRPYBqyg5svX4550NOp+WtFCOlfmZnN
         rvJyIorm0fUkb1V1uvwWDKUQnhh4nBaIM6/Qr+EAe+TItDqZcvu1PYh/pjxSfKPJj9k5
         zevR0rdH+pfxK0OcUQwnbey6Dps0sGa69+mxRu4gQYgmYsoSZBlU2UObIp/HIIpWJJ8r
         8Wlw==
X-Gm-Message-State: AOJu0YzE6ZYNe8BaTLFPMjuNjJ2x9LI940AK+V7FawkabLwrxwdAZE4h
	jlBg/l8JQ//IpLh9Szo7WTRmV1EdfrNp9sql53zWFi6rhxWaWWIf609FaSlG5iumIgYvmGW7NaN
	dcj4qoJ+0tQ==
X-Google-Smtp-Source: AGHT+IHjfLd3cRPZ46/iquC6wR6a1FhsZ/fwOTdYycEMGGC70NvC8Im2Z2IBvK+rOTFtFqAcknIFE6nalpuYpA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b09:b0:dc6:c94e:fb85 with SMTP
 id eh9-20020a0569021b0900b00dc6c94efb85mr163968ybb.2.1711726953123; Fri, 29
 Mar 2024 08:42:33 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:21 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/8] net: make softnet_data.dropped an atomic_t
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
index 4ad7836365e68f700b26dba2c50515a8c18329cf..02c98f115243202c409ee00c16e08fb0cf4d9ab9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4800,17 +4800,22 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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
@@ -4826,11 +4831,11 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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


