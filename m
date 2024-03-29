Return-Path: <netdev+bounces-83364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB98920B2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90EB1F22046
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103814F8A0;
	Fri, 29 Mar 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLINtWdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA81E491
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726958; cv=none; b=WocxkSHFDrJ2/PJLYSDAPW1kgZAnjEyXNi2uXJFlHYysx6v4MRclCs3C0wHBqRXBAOKkhC+c0x2eHqsKFAbWh3SxYmT/ZP42f4kLJAampS7Gir9A5OXaeinVWq0AU/lkusyAzdT5p04ENM/6Hy35Tb/J6Y/F9mknOAyX8R3NES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726958; c=relaxed/simple;
	bh=4DWTyyt6+BzClySBH46Kl3XhnA2GwwDCvNYLsMyp53I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zjy9R4sROxJOet8RTWheIt8F2uK8QabqJjqNFm1vLcfj1+R92RYoFwxv9eD/KI8qzGfEJKdC6fj5kxBbgqVSmpF6/Gw/Tytz2rbB14MLJ4dizTbzascf3SxrSD44tvjf25H+r2U1HnSiVjX4QKrdlIEQ22tJRCb2VPJiHIyLNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLINtWdt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so3010024276.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726956; x=1712331756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4m8dG+cGHACwpf060OQmHT6LiXTZOTDb4U/m0fLPXTY=;
        b=eLINtWdtx4KaVKPszmtF4uoqJxQ/mEdmt0pv4gFJTCSUzDseg0xXtcNIrvrp2PvOLA
         Bkz7Ay+pSggmRLTpyYlTZUasVcmclNEiD7KrDCoUx/qmep/JUks+xn4GtrYJ9nKEIBI2
         Ke+HBuKNJbsGmhlpTxLUC4wod5ZNYre6htiWJSRULP+jePV8o30dUH0vddCP1fWVptt8
         /IGLosaZQl1tG8m2mmwMVMbrOhkIkzIxxeeFu6MQLTHjjbH3AfGlN33zRgQmZE0rboZT
         5ftQ98GrKZIp7TJmKjsnKk+f3p+uOfpTQCQ8zvzWSDny48cnyjrGe84InxVlSNp4j09D
         bKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726956; x=1712331756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m8dG+cGHACwpf060OQmHT6LiXTZOTDb4U/m0fLPXTY=;
        b=tBaKlAko8NKpZNF+0O8u3xnpoZZWM2ip/kid1kVmG1ZvAR1yAoTAYM/P9VRN0+ROxF
         rbq9bVAMpo6s6+va3IDg2DqKlFAI66c3hG02otlgGGAFzI0FkbO3W1dq7XmVor0amCcH
         ehq3CZ48vR2xQG4LLiY22MpjTJIl5NNXdIeNuSFMCpdzysvGJXKSePCe4Sirmt9dszWJ
         E+Ot4XG2GbXdP85SStvJUBojsQIKgLS7Lj8JCLBKOZy5f7fwUtV10DltP0RDiZ5H36Od
         QoLvwCB8td+Hh/5VBb996opcSb2pRbKf3WMN/JH+vko6sTg8RplNStR7rxQW4wsrwvwG
         2dpw==
X-Gm-Message-State: AOJu0YyZCMMc7ylTlSlMyOOvjI/UI+hld/m9M56IVEn6Okcn/MNWAE6H
	KFfCs+4Q9kWCCWyYCTf158UZBmgpwPRSwne+UN/sDzK7qvUxHanu80U9AASsfhvkE5t3dICHxPO
	Zi5RTReoiuQ==
X-Google-Smtp-Source: AGHT+IFGijK8Z2IE14RgDanAXGPGs2NB31ZYcfErnq2zkEJ0H4XCfRiDRrgyXSx3h1z7QFkX+Y3h35O8i0Fspw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2502:b0:dcc:79ab:e522 with SMTP
 id dt2-20020a056902250200b00dcc79abe522mr192060ybb.11.1711726956278; Fri, 29
 Mar 2024 08:42:36 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:23 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/8] net: rps: change input_queue_tail_incr_save()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

input_queue_tail_incr_save() is incrementing the sd queue_tail
and save it in the flow last_qtail.

Two issues here :

- no lock protects the write on last_qtail, we should use appropriate
  annotations.

- We can perform this write after releasing the per-cpu backlog lock,
  to decrease this lock hold duration (move away the cache line miss)

Also move input_queue_head_incr() and rps helpers to include/net/rps.h,
while adding rps_ prefix to better reflect their role.

v2: Fixed a build issue (Jakub and kernel build bots)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 15 ---------------
 include/net/rps.h         | 23 +++++++++++++++++++++++
 net/core/dev.c            | 20 ++++++++++++--------
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1c31cd2691d32064613836141fbdeeebc831b21f..14f19cc2616452d7e6afbbaa52f8ad3e61a419e9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3249,21 +3249,6 @@ struct softnet_data {
 	call_single_data_t	defer_csd;
 };
 
-static inline void input_queue_head_incr(struct softnet_data *sd)
-{
-#ifdef CONFIG_RPS
-	sd->input_queue_head++;
-#endif
-}
-
-static inline void input_queue_tail_incr_save(struct softnet_data *sd,
-					      unsigned int *qtail)
-{
-#ifdef CONFIG_RPS
-	*qtail = ++sd->input_queue_tail;
-#endif
-}
-
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 
 static inline int dev_recursion_level(void)
diff --git a/include/net/rps.h b/include/net/rps.h
index 7660243e905b92651a41292e04caf72c5f12f26e..10ca25731c1ef766715fe7ee415ad0b71ec643a8 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -122,4 +122,27 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 #endif
 }
 
+static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
+{
+#ifdef CONFIG_RPS
+	return ++sd->input_queue_tail;
+#else
+	return 0;
+#endif
+}
+
+static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
+{
+#ifdef CONFIG_RPS
+	WRITE_ONCE(*dest, tail);
+#endif
+}
+
+static inline void rps_input_queue_head_incr(struct softnet_data *sd)
+{
+#ifdef CONFIG_RPS
+	sd->input_queue_head++;
+#endif
+}
+
 #endif /* _NET_RPS_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 0a8ccb0451c30a39f8f8b45d26b7e5548b8bfba4..79073bbc9a644049cacf8433310f4641745049e9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4611,7 +4611,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (unlikely(tcpu != next_cpu) &&
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
 		     ((int)(per_cpu(softnet_data, tcpu).input_queue_head -
-		      rflow->last_qtail)) >= 0)) {
+		      READ_ONCE(rflow->last_qtail))) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
 		}
@@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 		cpu = READ_ONCE(rflow->cpu);
 		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(per_cpu(softnet_data, cpu).input_queue_head -
-			   rflow->last_qtail) <
+			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
 			expire = false;
 	}
@@ -4801,6 +4801,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	unsigned long flags;
 	unsigned int qlen;
 	int max_backlog;
+	u32 tail;
 
 	reason = SKB_DROP_REASON_DEV_READY;
 	if (!netif_running(skb->dev))
@@ -4825,8 +4826,11 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 				napi_schedule_rps(sd);
 		}
 		__skb_queue_tail(&sd->input_pkt_queue, skb);
-		input_queue_tail_incr_save(sd, qtail);
+		tail = rps_input_queue_tail_incr(sd);
 		backlog_unlock_irq_restore(sd, &flags);
+
+		/* save the tail outside of the critical section */
+		rps_input_queue_tail_save(qtail, tail);
 		return NET_RX_SUCCESS;
 	}
 
@@ -5904,7 +5908,7 @@ static void flush_backlog(struct work_struct *work)
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
 			dev_kfree_skb_irq(skb);
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 		}
 	}
 	backlog_unlock_irq_enable(sd);
@@ -5913,7 +5917,7 @@ static void flush_backlog(struct work_struct *work)
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
 			kfree_skb(skb);
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 		}
 	}
 	local_bh_enable();
@@ -6041,7 +6045,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 			if (++work >= quota)
 				return work;
 
@@ -11455,11 +11459,11 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb = __skb_dequeue(&oldsd->process_queue))) {
 		netif_rx(skb);
-		input_queue_head_incr(oldsd);
+		rps_input_queue_head_incr(oldsd);
 	}
 	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx(skb);
-		input_queue_head_incr(oldsd);
+		rps_input_queue_head_incr(oldsd);
 	}
 
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


