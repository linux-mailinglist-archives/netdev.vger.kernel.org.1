Return-Path: <netdev+bounces-257882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEAJN2FCiWmK5QQAu9opvQ
	(envelope-from <netdev+bounces-257882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:11:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3293E10AFBE
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37F930078D8
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351B28B4E2;
	Mon,  9 Feb 2026 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPLt36OS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E4286D4B
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770603102; cv=none; b=RkehMNpldJFQTsgM6NmYyz/zeR4yB3s+2FMDB3wZI1yoSu4EnCh3PB6UF6CFCSHc6sX16fPQdBltZ1NjLi5FITaJF6EspCO0OXcsm0ra5iNkdC6B8A8TlU+ixdcFhqd6xPbS9VrWdpr3eWQSb/2yQmw+cZGPM/AEWTIQUK9BCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770603102; c=relaxed/simple;
	bh=RhQyMiHKFfd0geZtFBCk3DhF6oTFn33DyOrJ7Llaf5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cAFBUstq+zDnbAzY3JAVpsqOSPHOa7xGpS55+NRFZCDcrpq8oN/myHoMdpIDCuQ2kr8Vie79LZZh8ds+oydJi5axbfktU0tua2q881OBmrbrVSZ1LtS9+RBNWJPu0Q7aFj+Yldi+rU9Rsm3f5LenG+YkcJmAq2fkUcaieD4hI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPLt36OS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b86ed375d37so464931866b.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 18:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770603101; x=1771207901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q1cuTHqEYZZgEI2/Zni60c/XQL4LnVPmPr8E69EvnY=;
        b=IPLt36OS7x9b6Fs2ArzPEW+j19MNv0KUlF7o4pb6B++CLEth2cUF5kjJ5Dl4xrKY2s
         jHKTQKGPiaXO7oR5OlwlueYT0jQPc59S68Ax49+zigoGQggoafuWbaBjqEnXAZk5yDUZ
         qkmT0NdnpAA4lV+Jx7wfrWjFxNXN3zxnppgk2lV3TThVXq8Mt+mfLVkr4ukUmUnH7OkY
         NS6lJKn/A+EVPvg+UAWn+TGmgdps4GW1d8miwowA2rHN3mOl4waJBK7gf6lSWtafeyWv
         DJ5alorwuRqWZNVAWgLy9hQqAeI1iYpQFwQDN/BbO7R04JynX0lcIrkpInz3x9MXNRrM
         guXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770603101; x=1771207901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q1cuTHqEYZZgEI2/Zni60c/XQL4LnVPmPr8E69EvnY=;
        b=QXLN3xkxDcMQjyKI34Ie2Re3/PK39rdwjzOZ1BYw9xzTR2X0j4riKFCT98ffxbw6Vo
         tfCHf0E4nkBTF9tMrL0HyLqN7vw6l63RjOFoh2D1gEtFZmG0ToiRwTqwFN8urmwfT1QM
         TPeDNAU0FWto/6ORzOAVGlRg0Q55ChD9fayweWsVAsDBEwWezn7sWPeIcwv61Q249a3Q
         i3v7nHl5RPdQEAlAnm/z2CGqXyipAuqXugR7+Avl11hFC7Iy0KGa/Lam8wIK3fZVEJ1p
         Z12sPVbwNzZkgKENHN4KraF9WPUTBh/nu9HR6puC+HTbsSOZ+BoIrJ9sgJfKvEr+6S/3
         ezlA==
X-Forwarded-Encrypted: i=1; AJvYcCX4v0g8gjBuC0EBKaYULoUDHcXFaqNfXMvELYEkWPtmb1AQhmUygE/9OpBKfItC2Rztm4nWNls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+Vs/7P/i5BbtnwbTKYPqlSYG4ex7y9qetXAhZPc+BRzycr73
	IGaCTSb93nFDgQxTKHYNFpAPk0TLdBVy648qSm/wA0Z53k0IZ/qmS1TL
X-Gm-Gg: AZuq6aJPoayr2DguwQFw02eS2/wVDL/SD7CKXkJS9CTC/qqcvpnA2cAuDc/6IBE2PK0
	PvvsTaK2c71PAXM8Vjfwh8QX0aqKZuiUk7POSrHSNFrdNMLWZGMzAgm9NuzZPADeghCnohSZoar
	OnPjiA1yR+en7R8eAVGotN7lPld6j9uVoz56am5zTc76BofV8qbKIpyia/fkPIrMx2kvQZa5y6w
	nVGd42ZE9gFTMSVtrwPUw3kVDeubjCDZtJAQAjz/zZ6HMrPJHwp+KGtlOOKwgAh20DP3WdUHMF2
	oZBWSvx5fEPf8kbU3xMxrKuOEah72DvSPOBwQqoiWpfeXD/KAnhRHWiVp5L1LqbJi4T6ORYPP5G
	PqTDryYO/KNh3Wgwh6hvRIEW0opI5dFpviuCMERonrpJGs/Uu5XRyCAl1IXKyLX/4kT0=
X-Received: by 2002:a17:907:3d45:b0:b88:7568:26ed with SMTP id a640c23a62f3a-b8edf3ec116mr494051166b.50.1770603100394;
        Sun, 08 Feb 2026 18:11:40 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e21:2705::3e3:36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb3002sm332182766b.39.2026.02.08.18.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:11:39 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] ppp: don't store tx skb in the fastpath
Date: Mon,  9 Feb 2026 10:11:33 +0800
Message-ID: <20260209021134.21194-1-dqfext@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257882-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3293E10AFBE
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
  ppp_push() in it. It returns 1 if the skb is consumed
  (dropped/handled) or 0 if it can be passed to ppp_push().
- Update ppp_push() to accept the skb. It returns 1 if the skb is
  consumed, or 0 if the channel is busy.
- Optimize __ppp_xmit_process():
  - Fastpath: If the queue is empty, attempt to send the skb directly
    via ppp_push(). If busy, queue it.
  - Slowpath: If the queue is not empty, or fastpath failed, process
    the backlog in file.xq. Split dequeueing loop into a separate
    function ppp_xmit_flush() so ppp_channel_push() uses that directly
    instead of passing a NULL skb to __ppp_xmit_process().

This simplifies the states and reduces locking in the fastpath.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
- Sent as RFC, since net-next is closed.

 drivers/net/ppp/ppp_generic.c | 107 +++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f8814d7be6f1..0f7bc3ab4a49 100644
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
+static int ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff *skb);
+static int ppp_push(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_channel_push(struct channel *pch);
 static void ppp_receive_frame(struct ppp *ppp, struct sk_buff *skb,
 			      struct channel *pch);
@@ -1651,26 +1650,44 @@ static void ppp_setup(struct net_device *dev)
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
+	if (unlikely(ppp_prepare_tx_skb(ppp, skb)))
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
 
@@ -1757,12 +1774,12 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 }
 
 /*
- * Compress and send a frame.
- * The caller should have locked the xmit path,
- * and xmit_pending should be 0.
+ * Compress and prepare to send a frame.
+ * The caller should have locked the xmit path.
+ * Returns 1 if the skb was consumed, 0 if it can be passed to ppp_push().
  */
-static void
-ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
+static int
+ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff *skb)
 {
 	int proto = PPP_PROTO(skb);
 	struct sk_buff *new_skb;
@@ -1784,7 +1801,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 					      "PPP: outbound frame "
 					      "not passed\n");
 			kfree_skb(skb);
-			return;
+			return 1;
 		}
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter &&
@@ -1869,42 +1886,38 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 			goto drop;
 		skb_queue_tail(&ppp->file.rq, skb);
 		wake_up_interruptible(&ppp->file.rwait);
-		return;
+		return 1;
 	}
 
-	ppp->xmit_pending = skb;
-	ppp_push(ppp);
-	return;
+	return 0;
 
  drop:
 	kfree_skb(skb);
 	++ppp->dev->stats.tx_errors;
+	return 1;
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


