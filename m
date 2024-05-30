Return-Path: <netdev+bounces-99564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9B8D54BF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C338B23FCB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782EF184131;
	Thu, 30 May 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JGNDl/Iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B6183977
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105622; cv=none; b=OFaHixG0xzoMxr3/BCAMwbms/57LT2tXbN0N6hqorJH+8NWnIgowY496vyYvZuuLtrRAzjABVolbcs7L1yrAFyRVxrAfbt3cazYuLX4J4ySf59PeD8DlnCEdK2PapXUge+R9asOVZMcArzouNWIbNBJNaCcY8/VcXjVSH4LyQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105622; c=relaxed/simple;
	bh=W2h/LnRyHWTHgTveKmP08DBvMQDEDLRwZs6glWTSns0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0G1ymINXi+lhWXbMDduznRoiW9SGi4tmb0T2Cy4vpInqo99AqYhTDHneTnDRlNp8Qq6q0gyM9AJkD+EdV0QrE1bxtXiwKEspGDeGXhMsxkhzQfjCpwFv7+a8q9qh228TNkjrFkxJ/2UpKAE49+MutOOekga6gjVG5T8g2oq0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JGNDl/Iz; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1bc6e5f01so773214b6e.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105619; x=1717710419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iU0kmb1Q8d2eQhrqkYXLZ8UzXfCX7B5qnp9jHajfNfU=;
        b=JGNDl/IzYCqu2Mrrfd9qRTedLOgFLIvopB1c16Vy89CmFUNhrMWZxKhpF5EQ7SHdid
         Wp8VUs5BE5Acep/CtY+740C74H+yvWvZHaWEypm2JTOFIz0pYAeWr8xvc+n5k8+rE8xP
         FvQQ2qi1766/uy3wlobRWq9ehBzwaB2C/ogKkgUbwmdwzEXeruDN5ge/6HXU5cZFutK3
         BsfntBDRMIerX+t4fJiEMa0k15GVUxBwBsKNBTCZcRck9n8fIprf2LaW61iSVGiTn2uq
         EBjriRF14HAKNESp1x4AjUKEWDJNpcmhMPcka8uHX/2eUsmA+OvEo3N/7F1FW1KQhXy7
         KL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105619; x=1717710419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU0kmb1Q8d2eQhrqkYXLZ8UzXfCX7B5qnp9jHajfNfU=;
        b=CIqL6qQX7900eLNHOtZ68TXH2KGS7mJIrwZvJdDhWRRCgvVjo8CPcowqRD8CzwPS1T
         ryMMiLeIq1IaviaP49smg5nHlxAJ0YPxm182J3utPXTLQ1EwL0/W8QNGIkNesVXMFYQ2
         7RwhFZ0Nyz+9KuXeRPSoerqV2HT5XFDaVwRYgVXtufvGvTBi+CJ7OZuMvGxKaxs0NJ6g
         xXrpPCsKndKFlUhq5L8ruy1V31jD+DDDQsAUXrJwVESSvkqLZW2iQWx8t0ZaFRZmZtYb
         75pq3dnV2/D6S7N0Yjmgp+9QQQ0/GjCFyCHytCmizY117MZ+cMOCyfLP10CmyI8TGi1W
         plJQ==
X-Gm-Message-State: AOJu0YwECQjrLjQ8repuVh+LbAEf1p4SRzjViDAEp7VxxbL6jEImCX+K
	3v37SVS2+rnKpvfUkjNFYRglMOQWsOq6xx5cwqV4zBiJn55xcevR0aHXd+ACCXoIUhClofJem/t
	PAXw=
X-Google-Smtp-Source: AGHT+IHgbXLNJseQlQk0+KenNC/IVwEM1DAl54VBPXVciNudX/cszFcDimmnbghb5SinYarxHkVXFQ==
X-Received: by 2002:aca:1119:0:b0:3c9:966e:32ea with SMTP id 5614622812f47-3d1e34786demr29137b6e.2.1717105618801;
        Thu, 30 May 2024 14:46:58 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73e4absm1963286d6.6.2024.05.30.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:46:58 -0700 (PDT)
Date: Thu, 30 May 2024 14:46:56 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC net-next 1/6] net: add kfree_skb_for_sk function
Message-ID: <9be3733eee16bb81a7e8e2e57ebcc008f95cae08.1717105215.git.yan@cloudflare.com>
References: <cover.1717105215.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717105215.git.yan@cloudflare.com>

Implement a new kfree_skb_for_sk to replace kfree_skb_reason on a few
local receive path. The function accepts an extra receiving socket
argument, which will be set in skb->cb for kfree_skb/consume_skb
tracepoint consumption. With this extra bit of information, it will be
easier to attribute dropped packets to netns/containers and
sockets/services for performance and error monitoring purpose.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/linux/skbuff.h | 48 ++++++++++++++++++++++++++++++++++++++++--
 net/core/dev.c         | 21 +++++++-----------
 net/core/skbuff.c      | 29 +++++++++++++------------
 3 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..66f5b06798f2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1251,8 +1251,52 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason);
+/*
+ * Some protocol will clear or reuse skb->dev field for other purposes.  For
+ * example, TCP stack would reuse the pointer for out of order packet handling.
+ * This caused some problem for drop monitoring on kfree_skb tracepoint, since
+ * no other fields of an skb provides netns information.  In addition, it is
+ * also complicated to recover receive socket information for dropped packets,
+ * because the socket lookup can be an sk-lookup BPF program.
+ *
+ * This can be addressed by just passing the rx socket to the tracepoint,
+ * because it also has valid netns binding.
+ */
+struct kfree_skb_cb {
+	enum skb_drop_reason reason; /* used only by dev_kfree_skb_irq */
+	struct sock *rx_sk;
+};
+
+#define KFREE_SKB_CB(skb) ((struct kfree_skb_cb *)(skb)->cb)
+
+/* Save cb->rx_sk before calling kfree_skb/consume_skb tracepoint, and restore
+ * after the tracepoint. This is necessary because some skb destructor might
+ * rely on values in skb->cb, e.g. unix_destruct_scm.
+ */
+#define _call_trace_kfree_skb(action, skb, sk, ...)	do {	\
+	if (trace_##action##_skb_enabled()) {			\
+		struct kfree_skb_cb saved;			\
+		saved.rx_sk = KFREE_SKB_CB(skb)->rx_sk;		\
+		KFREE_SKB_CB(skb)->rx_sk = sk;			\
+		trace_##action##_skb((skb), ## __VA_ARGS__);	\
+		KFREE_SKB_CB(skb)->rx_sk = saved.rx_sk;		\
+	}							\
+} while (0)
+
+#define call_trace_kfree_skb(skb, sk, ...) \
+	_call_trace_kfree_skb(kfree, skb, sk, ## __VA_ARGS__)
+
+#define call_trace_consume_skb(skb, sk, ...) \
+	_call_trace_kfree_skb(consume, skb, sk, ## __VA_ARGS__)
+
+void __fix_address kfree_skb_for_sk(struct sk_buff *skb, struct sock *rx_sk,
+				    enum skb_drop_reason reason);
+
+static inline void
+kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+{
+	kfree_skb_for_sk(skb, NULL, reason);
+}
 
 /**
  *	kfree_skb - free an sk_buff with 'NOT_SPECIFIED' reason
diff --git a/net/core/dev.c b/net/core/dev.c
index 85fe8138f3e4..17516f26be92 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3135,15 +3135,6 @@ void __netif_schedule(struct Qdisc *q)
 }
 EXPORT_SYMBOL(__netif_schedule);
 
-struct dev_kfree_skb_cb {
-	enum skb_drop_reason reason;
-};
-
-static struct dev_kfree_skb_cb *get_kfree_skb_cb(const struct sk_buff *skb)
-{
-	return (struct dev_kfree_skb_cb *)skb->cb;
-}
-
 void netif_schedule_queue(struct netdev_queue *txq)
 {
 	rcu_read_lock();
@@ -3182,7 +3173,11 @@ void dev_kfree_skb_irq_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	} else if (likely(!refcount_dec_and_test(&skb->users))) {
 		return;
 	}
-	get_kfree_skb_cb(skb)->reason = reason;
+
+	/* There is no need to save the old cb since we are the only user. */
+	KFREE_SKB_CB(skb)->reason = reason;
+	KFREE_SKB_CB(skb)->rx_sk = NULL;
+
 	local_irq_save(flags);
 	skb->next = __this_cpu_read(softnet_data.completion_queue);
 	__this_cpu_write(softnet_data.completion_queue, skb);
@@ -5229,17 +5224,17 @@ static __latent_entropy void net_tx_action(struct softirq_action *h)
 			clist = clist->next;
 
 			WARN_ON(refcount_read(&skb->users));
-			if (likely(get_kfree_skb_cb(skb)->reason == SKB_CONSUMED))
+			if (likely(KFREE_SKB_CB(skb)->reason == SKB_CONSUMED))
 				trace_consume_skb(skb, net_tx_action);
 			else
 				trace_kfree_skb(skb, net_tx_action,
-						get_kfree_skb_cb(skb)->reason);
+						KFREE_SKB_CB(skb)->reason);
 
 			if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 				__kfree_skb(skb);
 			else
 				__napi_kfree_skb(skb,
-						 get_kfree_skb_cb(skb)->reason);
+						 KFREE_SKB_CB(skb)->reason);
 		}
 	}
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..5ce6996512a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1190,7 +1190,8 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+bool __kfree_skb_reason(struct sk_buff *skb, struct sock *rx_sk,
+			enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
 		return false;
@@ -1201,28 +1202,30 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 				SKB_DROP_REASON_SUBSYS_NUM);
 
 	if (reason == SKB_CONSUMED)
-		trace_consume_skb(skb, __builtin_return_address(0));
+		call_trace_consume_skb(skb, rx_sk, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason);
+		call_trace_kfree_skb(skb, rx_sk, __builtin_return_address(0), reason);
+
 	return true;
 }
 
 /**
- *	kfree_skb_reason - free an sk_buff with special reason
+ *	kfree_skb_for_sk - free an sk_buff with special reason and receiving socket
  *	@skb: buffer to free
+ *	@rx_sk: the socket to receive the buffer, or NULL if not applicable
  *	@reason: reason why this skb is dropped
  *
  *	Drop a reference to the buffer and free it if the usage count has
- *	hit zero. Meanwhile, pass the drop reason to 'kfree_skb'
+ *	hit zero. Meanwhile, pass the drop reason and rx socket to 'kfree_skb'
  *	tracepoint.
  */
-void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+void __fix_address kfree_skb_for_sk(struct sk_buff *skb, struct sock *rx_sk,
+				    enum skb_drop_reason reason)
 {
-	if (__kfree_skb_reason(skb, reason))
+	if (__kfree_skb_reason(skb, rx_sk, reason))
 		__kfree_skb(skb);
 }
-EXPORT_SYMBOL(kfree_skb_reason);
+EXPORT_SYMBOL(kfree_skb_for_sk);
 
 #define KFREE_SKB_BULK_SIZE	16
 
@@ -1261,7 +1264,7 @@ kfree_skb_list_reason(struct sk_buff *segs, enum skb_drop_reason reason)
 	while (segs) {
 		struct sk_buff *next = segs->next;
 
-		if (__kfree_skb_reason(segs, reason)) {
+		if (__kfree_skb_reason(segs, NULL, reason)) {
 			skb_poison_list(segs);
 			kfree_skb_add_bulk(segs, &sa, reason);
 		}
@@ -1405,7 +1408,7 @@ void consume_skb(struct sk_buff *skb)
 	if (!skb_unref(skb))
 		return;
 
-	trace_consume_skb(skb, __builtin_return_address(0));
+	call_trace_consume_skb(skb, NULL, __builtin_return_address(0));
 	__kfree_skb(skb);
 }
 EXPORT_SYMBOL(consume_skb);
@@ -1420,7 +1423,7 @@ EXPORT_SYMBOL(consume_skb);
  */
 void __consume_stateless_skb(struct sk_buff *skb)
 {
-	trace_consume_skb(skb, __builtin_return_address(0));
+	call_trace_consume_skb(skb, NULL, __builtin_return_address(0));
 	skb_release_data(skb, SKB_CONSUMED);
 	kfree_skbmem(skb);
 }
@@ -1478,7 +1481,7 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 		return;
 
 	/* if reaching here SKB is ready to free */
-	trace_consume_skb(skb, __builtin_return_address(0));
+	call_trace_consume_skb(skb, NULL, __builtin_return_address(0));
 
 	/* if SKB is a clone, don't handle this case */
 	if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
-- 
2.30.2



