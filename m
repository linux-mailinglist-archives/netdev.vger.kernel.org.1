Return-Path: <netdev+bounces-258023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE5HJISiimleMgAAu9opvQ
	(envelope-from <netdev+bounces-258023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:14:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35933116B48
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94524302F72C
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C22EA72A;
	Tue, 10 Feb 2026 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmZizgMb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DB2DC334
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693205; cv=none; b=RC6k6TmNHEBoXXWSpOUMmy/9CypXaunsoXPOtxULA3hK2hWTeWns4YmB1AAhIpbn4Q6IX5WekKbJJDa+ryNnRl09VKCUktLiJ/1gVQusI6GakDrk6BrsnpVKWkRyNqrnfY7e8afr8q/j3kIawkiiy9CYqNJeFJnjYegzEByN4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693205; c=relaxed/simple;
	bh=4/nMmnI8zKAYeeLlG0XTvxB44Mg+06NdKDy3SZy19bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7yYhIvy6ke21WTScFOGPojuOh1/7sgekAA69a0JQDbjnlWQeYGO14bbmFN7WIO9+DmdRJTcG/E8LMMwRm5y2FRhZj+PGB2PyR/rmXhcfqQszBKP7Z+MbP/KBCUcJynJfu9UiMqX0VqAFjjMlfSDB25Z/CufjuWOwq00w9EnAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmZizgMb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b884d5c787bso602701866b.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 19:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770693202; x=1771298002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yOqvn4iic2Welqp2RwCBkSo3ZxAKMu23cfko1WEdD8=;
        b=HmZizgMbMOJaniZ/4+cIz0hEnuyudHyyiRX6qTvADKcTwgffKT+CetFsaO8zwNoUJS
         8nF6d1JDnzTjmLu8f80w9zZVIcnGLOS94Lnynn9tVLIuzmHCPe1CpB6Z8rzXMxuMBP5J
         /wlAs3eMQ/RKCcXWxRt6kDkaSb8GtlQbBOAchuTcnQKcUEPKj9kDOr1pGBD+13u/GCuo
         qijOKcTVPqt28BAkI6/U5qIZrjsXXb2uKwD4p3r3LYEsSsTPVM3GimGVoJ6AXJJMq+Ej
         /OygUcGOZDCMgCkgQpQw5G5l2GcRTkzOFBpQsYh7Ng++ijvODJQ5JCQnBU9x/oVaXZzM
         wmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770693202; x=1771298002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yOqvn4iic2Welqp2RwCBkSo3ZxAKMu23cfko1WEdD8=;
        b=etW9sRLgx22VzDIF0yIFl7568oLD2Y80ZcogiR8RRMTLug9UhjVT7UQ6R67GJyYsnW
         cc5kigiauKPxKuuiDIkcL9oKClE5Syv0AlkVN5SOX3V44Zqwz4YqSDNxD0UZqGf5VGE5
         dZm/o9C77k1UZj67I1G3YT936voUXB0vEcJ0eh2NxmeT59hxysGh3eWJiqGIJKCX30Yp
         V7ba/kW8896OSsAn1BYrVgWWWviW/5nTADXh1AoQjeWDVemmRkgp9gJiv/Q/O6qrbxxv
         plEy1OG5cifa+ggTXhMtzoHo6WnLiVyiMbwXPySXTIV3wASWlHNeKz5P32hLpE100EiF
         AdjA==
X-Forwarded-Encrypted: i=1; AJvYcCUFeD+g0A9YMUA7PsAYltSb7gcuD2VcvvY3AlG1/MIdLCCxRljLPYSPuWgCM766SVH54aJk29k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYQPVxH+trdg03NQaAzDWl+pSM5kuc+uBejWj1DTtl8fpSjXr
	Y3qEvgkt0oxenYa2fkW4WQBNXzAmKCMoK1xejKGcloEOh4diRDhF27k+
X-Gm-Gg: AZuq6aI8Mc84cEqORTRAKa4IKV2mIkMvTmARS8gesM8QhZOeEf07CvCrwajDk/MxlIv
	CbYQqXR5fFWHgcbOLDf1/I+IAalwSjfEvIkFnc5ugD68BULSSYTFZEQnAB6uCuSZixtdEAXbzG1
	UvEmNF3tkynd8Ap3V21XxrdYQmO84XgJgDbaSIj2n8WaBjL/VM6G1LQA5wEJQ5IZCgTKIepFzw3
	ZJW8b8uFPcLDcUqvj3YpjNAteFA+sViQJmRij0CA5JlI0Q22d/3anA5f+q/XJoabVgMLxKj8N8Y
	u7/iRegYAXYMvCXXG1xxOq4/v5fhg0CHqH1JB5O9Ptit6EuCQ/0HhIfAiwD/JPGBXHEn7j8UJEI
	s6t3vGujs7IKp7VWnsRQWrwZ0ODuZcqBSdPKMT7ZHGAqatJ7jVgW0LQTvNVSY1bkY2USjPKsWM1
	Xplg==
X-Received: by 2002:a17:906:f58d:b0:b87:1ffc:bf9b with SMTP id a640c23a62f3a-b8edf173b0amr809418766b.3.1770693201789;
        Mon, 09 Feb 2026 19:13:21 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e22:26fa::3e2:d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7e6577sm451058566b.30.2026.02.09.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:13:20 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RFC PATCH net-next v2] ppp: don't store tx skb in the fastpath
Date: Tue, 10 Feb 2026 11:13:13 +0800
Message-ID: <20260210031313.29708-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258023-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35933116B48
X-Rspamd-Action: no action

Currently, ppp->xmit_pending is used in ppp_send_frame() to pass a skb
to ppp_push(), and holds the skb when a PPP channel cannot immediately
transmit it. This state is redundant because the transmit queue
(ppp->file.xq) can already handle the backlog. Furthermore, during
normal operation, an skb is queued in file.xq only to be immediately
dequeued, causing unnecessary overhead.

Refactor the transmit path to avoid stashing the skb when possible:
- Remove ppp->xmit_pending.
- Rename ppp_send_frame() to ppp_prepare_tx_skb(), and don't call
  ppp_push() in it. It returns NULL if the skb is consumed
  (dropped/queue) or a new skb to be passed to ppp_push().
- Update ppp_push() to accept the skb. It returns 1 if the skb is
  consumed, or 0 if the channel is busy.
- Optimize __ppp_xmit_process():
  - Fastpath: If the queue is empty, attempt to send the skb directly
    via ppp_push(). If busy, queue it.
  - Slowpath: If the queue is not empty, process the backlog in
    file.xq. Split dequeuing loop into a separate function
    ppp_xmit_flush() so ppp_channel_push() uses that directly instead of
    passing a NULL skb to __ppp_xmit_process().

This simplifies the states and reduces locking in the fastpath.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
PPPoE encap forwarding performance on a RISC-V SBC increased from
 86kpps to 91kpps. 

v2: fix ppp_prepare_tx_skb() UAF.
 - https://lore.kernel.org/netdev/20260209021134.21194-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 107 +++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f8814d7be6f1..b8a41f571aa3 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -134,7 +134,6 @@ struct ppp {
 	int		debug;		/* debug flags 70 */
 	struct slcompress *vj;		/* state for VJ header compression */
 	enum NPmode	npmode[NUM_NP];	/* what to do with each net proto 78 */
-	struct sk_buff	*xmit_pending;	/* a packet ready to go out 88 */
 	struct compressor *xcomp;	/* transmit packet compressor 8c */
 	void		*xc_state;	/* its internal state 90 */
 	struct compressor *rcomp;	/* receive decompressor 94 */
@@ -264,8 +263,8 @@ struct ppp_net {
 static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 			struct file *file, unsigned int cmd, unsigned long arg);
 static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb);
-static void ppp_send_frame(struct ppp *ppp, struct sk_buff *skb);
-static void ppp_push(struct ppp *ppp);
+static struct sk_buff *ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff *skb);
+static int ppp_push(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_channel_push(struct channel *pch);
 static void ppp_receive_frame(struct ppp *ppp, struct sk_buff *skb,
 			      struct channel *pch);
@@ -1651,26 +1650,45 @@ static void ppp_setup(struct net_device *dev)
  */
 
 /* Called to do any work queued up on the transmit side that can now be done */
+static void ppp_xmit_flush(struct ppp *ppp)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&ppp->file.xq))) {
+		if (unlikely(!ppp_push(ppp, skb))) {
+			skb_queue_head(&ppp->file.xq, skb);
+			return;
+		}
+	}
+	/* If there's no work left to do, tell the core net code that we can
+	 * accept some more.
+	 */
+	netif_wake_queue(ppp->dev);
+}
+
 static void __ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
 	ppp_xmit_lock(ppp);
-	if (!ppp->closing) {
-		ppp_push(ppp);
-
-		if (skb)
+	if (unlikely(ppp->closing)) {
+		kfree_skb(skb);
+		goto out;
+	}
+	skb = ppp_prepare_tx_skb(ppp, skb);
+	if (unlikely(!skb))
+		goto out;
+	/* Fastpath: No backlog, just send the new skb. */
+	if (likely(skb_queue_empty(&ppp->file.xq))) {
+		if (unlikely(!ppp_push(ppp, skb))) {
 			skb_queue_tail(&ppp->file.xq, skb);
-		while (!ppp->xmit_pending &&
-		       (skb = skb_dequeue(&ppp->file.xq)))
-			ppp_send_frame(ppp, skb);
-		/* If there's no work left to do, tell the core net
-		   code that we can accept some more. */
-		if (!ppp->xmit_pending && !skb_peek(&ppp->file.xq))
-			netif_wake_queue(ppp->dev);
-		else
 			netif_stop_queue(ppp->dev);
-	} else {
-		kfree_skb(skb);
+		}
+		goto out;
 	}
+
+	/* Slowpath: Enqueue the new skb and process backlog */
+	skb_queue_tail(&ppp->file.xq, skb);
+	ppp_xmit_flush(ppp);
+out:
 	ppp_xmit_unlock(ppp);
 }
 
@@ -1757,12 +1775,11 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 }
 
 /*
- * Compress and send a frame.
- * The caller should have locked the xmit path,
- * and xmit_pending should be 0.
+ * Compress and prepare to send a frame.
+ * The caller should have locked the xmit path.
  */
-static void
-ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
+static struct sk_buff *
+ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff *skb)
 {
 	int proto = PPP_PROTO(skb);
 	struct sk_buff *new_skb;
@@ -1784,7 +1801,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 					      "PPP: outbound frame "
 					      "not passed\n");
 			kfree_skb(skb);
-			return;
+			return NULL;
 		}
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter &&
@@ -1869,42 +1886,38 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 			goto drop;
 		skb_queue_tail(&ppp->file.rq, skb);
 		wake_up_interruptible(&ppp->file.rwait);
-		return;
+		return NULL;
 	}
 
-	ppp->xmit_pending = skb;
-	ppp_push(ppp);
-	return;
+	return skb;
 
  drop:
 	kfree_skb(skb);
 	++ppp->dev->stats.tx_errors;
+	return NULL;
 }
 
 /*
- * Try to send the frame in xmit_pending.
+ * Try to send the frame.
  * The caller should have the xmit path locked.
+ * Returns 1 if the skb was consumed, 0 if not.
  */
-static void
-ppp_push(struct ppp *ppp)
+static int
+ppp_push(struct ppp *ppp, struct sk_buff *skb)
 {
 	struct list_head *list;
 	struct channel *pch;
-	struct sk_buff *skb = ppp->xmit_pending;
-
-	if (!skb)
-		return;
 
 	list = &ppp->channels;
 	if (list_empty(list)) {
 		/* nowhere to send the packet, just drop it */
-		ppp->xmit_pending = NULL;
 		kfree_skb(skb);
-		return;
+		return 1;
 	}
 
 	if ((ppp->flags & SC_MULTILINK) == 0) {
 		struct ppp_channel *chan;
+		int ret;
 		/* not doing multilink: send it down the first channel */
 		list = list->next;
 		pch = list_entry(list, struct channel, clist);
@@ -1916,27 +1929,26 @@ ppp_push(struct ppp *ppp)
 			 * skb but linearization failed
 			 */
 			kfree_skb(skb);
-			ppp->xmit_pending = NULL;
+			ret = 1;
 			goto out;
 		}
 
-		if (chan->ops->start_xmit(chan, skb))
-			ppp->xmit_pending = NULL;
+		ret = chan->ops->start_xmit(chan, skb);
 
 out:
 		spin_unlock(&pch->downl);
-		return;
+		return ret;
 	}
 
 #ifdef CONFIG_PPP_MULTILINK
 	/* Multilink: fragment the packet over as many links
 	   as can take the packet at the moment. */
 	if (!ppp_mp_explode(ppp, skb))
-		return;
+		return 0;
 #endif /* CONFIG_PPP_MULTILINK */
 
-	ppp->xmit_pending = NULL;
 	kfree_skb(skb);
+	return 1;
 }
 
 #ifdef CONFIG_PPP_MULTILINK
@@ -2005,7 +2017,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 	 * performance if we have a lot of channels.
 	 */
 	if (nfree == 0 || nfree < navail / 2)
-		return 0; /* can't take now, leave it in xmit_pending */
+		return 0; /* can't take now, leave it in transmit queue */
 
 	/* Do protocol field compression */
 	if (skb_linearize(skb))
@@ -2199,8 +2211,12 @@ static void __ppp_channel_push(struct channel *pch, struct ppp *ppp)
 	spin_unlock(&pch->downl);
 	/* see if there is anything from the attached unit to be sent */
 	if (skb_queue_empty(&pch->file.xq)) {
-		if (ppp)
-			__ppp_xmit_process(ppp, NULL);
+		if (ppp) {
+			ppp_xmit_lock(ppp);
+			if (!ppp->closing)
+				ppp_xmit_flush(ppp);
+			ppp_xmit_unlock(ppp);
+		}
 	}
 }
 
@@ -3460,7 +3476,6 @@ static void ppp_destroy_interface(struct ppp *ppp)
 	}
 #endif /* CONFIG_PPP_FILTER */
 
-	kfree_skb(ppp->xmit_pending);
 	free_percpu(ppp->xmit_recursion);
 
 	free_netdev(ppp->dev);
-- 
2.43.0


