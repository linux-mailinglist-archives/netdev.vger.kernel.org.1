Return-Path: <netdev+bounces-83017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856298906C7
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C191C2E964
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBE51327E3;
	Thu, 28 Mar 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugSTvUtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C81DDF5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645405; cv=none; b=iiZe0hhP5L8KVbXirRjfIQKieom+xZE27PIrxX+AgD3mVZRo2NU59JNjOebvhLhzvQZX9ujY17F55iKwXHKTpUu9Rn+Y05YxpKsFccnIgrsunAoejQjKqvI9whl0r8JlYp9AruP9ulC1TjQwtnHlO0etiwuuTtOxRMjPMFXgBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645405; c=relaxed/simple;
	bh=q3Isl5smKGqMI33IT/alUBOXFmQZgBphrYGm25auXXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QozjSNrIdQmXvEAQwQEEi6XTbmJQ5ffCPCDYjWC0SQsCRuYLUdIOinro4T/Y3gfQQXYFyymBEkko/zLrW/CqLt15GRuoNAgP9N7d9pQ/MEHA2z3brtaIj0V5RjmOEayd0nHQlCtCZuI7aFw7/TJm7zxQGbfzunpzXjNoaJUt5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugSTvUtg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so1770976276.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645403; x=1712250203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCHluyXzMsZacgqMrIjjaDOAIpWQewSa765EqrHSqdc=;
        b=ugSTvUtg1JMSmZyo6GI7Wq1ZYS6fyBfXpsQerNYunPoHfOQ12yV8uB53jghH+tv52o
         FutiUDjhGvh/RXQVsoGWvGdxXzwvkN/CFPCVUs6AJJQkG9DzzMYk5XMhfwRWusFsPogT
         469l65Lfle1gwXRmD0rNh+ii2z4o4m3tzQtQ482nc1jLIUenwqXyaviiEEoXQjYLc7+y
         Hl0AvLVYq5I6+zlRAI3dlg5w8ltzMzlFDPN4K3XuO0+qS6NH2Nae15b+3gVIoW9n7qUG
         9uzpn0tWaJi/A3E3/TWaEde/T4n829g/UQQCD1RoRMdsexS4I4/ZSc6oIzMpEM+n/ZOq
         43vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645403; x=1712250203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCHluyXzMsZacgqMrIjjaDOAIpWQewSa765EqrHSqdc=;
        b=pRsaZN8MPHHCg2E1lacaJ8RDGHUj4MGbI6Lp3EwBWh+PAZe9y5teSZOP6jy28fAd0u
         hal1YvCAN0xv7T3k1bfmgTCgh60eHxK50ISOAalHS+aFTDgc2H7r690ZlXse8XQhM83B
         DTpC6nZjeiUWP9Iljo9eICdITzBKZChytpqa+MMHmrMJ0+9PzwFlOLcEfIsAngQ6xca3
         xho+fycH00Uzxudsdho4V9cTMq63I2aWAaafI9xP8IqiRnTGRGEunnOo+tDGYo6XwqLn
         u9QrqY+reRkJQNFSFKA/2IVyNCreIUt6N0/YFdrL7DYJuTpVLnGSvcT4QN35pQLMy3pS
         lDGA==
X-Gm-Message-State: AOJu0Yzh8Y+FKT5WLQ4QB5qiTH7fNqc9GUGikMyGOC9EfMLVD1gcyCnx
	FGVNDt1Ia6N/z7kGCfHMBsQYpK/h1sMRsTPFjP/bJmMbRReDWXp3FiMwQjwclf075k4WuupHCf0
	uiPFaR0YfXw==
X-Google-Smtp-Source: AGHT+IHnj4V0QmcHIMpo4nSvXg1Kt87vodACERO8zjLmA8o2QtYXxQAa8fulNzRk+S7qc3BZl6gZBP50vpnCNA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102e:b0:dd9:4ad1:a1f7 with SMTP
 id x14-20020a056902102e00b00dd94ad1a1f7mr1030646ybt.9.1711645403142; Thu, 28
 Mar 2024 10:03:23 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:07 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] net: rps: change input_queue_tail_incr_save()
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
index 7660243e905b92651a41292e04caf72c5f12f26e..c13f829b8556fda63e76544c332f2c089f0d6ea4 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -35,6 +35,29 @@ struct rps_dev_flow {
 };
 #define RPS_NO_FILTER 0xffff
 
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
 /*
  * The rps_dev_flow_table structure contains a table of flow mappings.
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 4e52745f23412bac6d3ff1b9f4d9f2ce4a2eb666..1fe7c6b10793d45a03461ee581d240d2442f9e17 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4601,7 +4601,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (unlikely(tcpu != next_cpu) &&
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
 		     ((int)(per_cpu(softnet_data, tcpu).input_queue_head -
-		      rflow->last_qtail)) >= 0)) {
+		      READ_ONCE(rflow->last_qtail))) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
 		}
@@ -4656,7 +4656,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 		cpu = READ_ONCE(rflow->cpu);
 		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(per_cpu(softnet_data, cpu).input_queue_head -
-			   rflow->last_qtail) <
+			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
 			expire = false;
 	}
@@ -4791,6 +4791,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	unsigned long flags;
 	unsigned int qlen;
 	int max_backlog;
+	u32 tail;
 
 	reason = SKB_DROP_REASON_DEV_READY;
 	if (!netif_running(skb->dev))
@@ -4815,8 +4816,11 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
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
 
@@ -5894,7 +5898,7 @@ static void flush_backlog(struct work_struct *work)
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
 			dev_kfree_skb_irq(skb);
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 		}
 	}
 	backlog_unlock_irq_enable(sd);
@@ -5903,7 +5907,7 @@ static void flush_backlog(struct work_struct *work)
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
 			kfree_skb(skb);
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 		}
 	}
 	local_bh_enable();
@@ -6031,7 +6035,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
-			input_queue_head_incr(sd);
+			rps_input_queue_head_incr(sd);
 			if (++work >= quota)
 				return work;
 
@@ -11445,11 +11449,11 @@ static int dev_cpu_dead(unsigned int oldcpu)
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


