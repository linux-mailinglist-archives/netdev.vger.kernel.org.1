Return-Path: <netdev+bounces-267206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAejCKAfs2l/SQAAu9opvQ
	(envelope-from <netdev+bounces-267206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:18:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACA278C34
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26133037933
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40F2C08D0;
	Thu, 12 Mar 2026 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4Mbx37f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E692ECE9B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346716; cv=none; b=aBzVenVhHDTMMHTHS+oSKNKzrT3TizLfy2Rrn4EyXFz0+FClDr/z0OIQP+VnpuTFbi8g9Upl6uDdvD87E4hBj3eEldDt7yHSxE2Syu/vXV1kSxIqeR+fe6qURN8ZQB2gqMhSMPZF22fyWDZ6mOTxO9PpzgNJLbaM8zx442UalgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346716; c=relaxed/simple;
	bh=RsT11W0j6W94v0kjE9D1Xt4lh4+PNRDqUJc15waJdDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aycSNNu6Ug1vHeFzINSEM8quV4KmtSb8NIieLiZek5sXcS4G1wESRKYvVfdzjYmyXlsp9NwoUs3plfYEfakVKDMbcjongvCWwEVja8UnEBGQj5/3bz3vvJXVMZZSMn+W5dpsPQckoaiAMTLf89haMMeDnKW5HjknKynj17Cx6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4Mbx37f; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-799001d77fcso42562567b3.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773346714; x=1773951514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BukdnU4WiGvwao+BMDyxsvD0AHtixjucMsvCFx24MM=;
        b=a4Mbx37fwmwSYd36XVxuF8raJVlu57S1Efn3IN3MhBv6ReySfxtcLWZiXtlKvXUBwu
         9IuZCqox0XeePOeezIXNGce3j3Bd9Gvixu5HpVkOWaVEhDJjOv863IalzaSN8nxHtUDD
         2JCfqbcKTjQuLrGiZiezHIddOUx4Rj0PB/2eoI2LPwZLjpwImG1jiiTZ1c35uJnwToHY
         Mu91j7niptGxJ4Mgt8iem371nyh6f44uYwIdMYunyo20IGZ28lcs+/l+UpD/OrPtkAg7
         rW9FAFAhbS9+ujw0Dd2IugBAoEeJTKGfvJxAc4RHAC/oRbdqz/7AQH1upDcMzMKsa55t
         1JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346714; x=1773951514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BukdnU4WiGvwao+BMDyxsvD0AHtixjucMsvCFx24MM=;
        b=mPQeVLa2epEnxtuOuV1nHpaCCDz4FteDFyFz4884ki6GAN8durmA/fKsvx9/QeKZSt
         EpVo/J0EVNnCGmfeTCb8iXWWyyxLKfjqsk634L3eFheByxXXgGrpjxO5JW3HcKpWdbkE
         2Dzjn/anmCFgKvyJXTUQtNUdyYJWNt0miVrrD1FtHNLf64OH+oh83uGuFYbvZZyAGuUa
         02khBHQy3GUN85Y2QANxAzkOc8nSu0XFcLfn9aeeIeE8b9hTyzfp52CsBlYHeNY8QYHp
         cE8GxNcJVxvT83We6p/DbMNGJzVS6MDyZMNOGYHRU5RceiTnm5g+feoFNwBNcMjkKQSk
         iVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxOSqO4wH90YbE4k8y4tmwi/OIJuNfg50/3cfDvawlEYIwi9oBlK2wLA1inWo8C49bZEwERk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIfJaZmyFMJ2dFaVmGhYP36AXS7HxASZYGBkLUunY2RODyVmC
	7m3UIYO5HzcHy+9azUekPjqUxIL9J8GREAjweRncboX5AEBTrC27R27NGXuN+kvxoZUTEgqxGmO
	o3aAw+hVzQ0toag==
X-Received: from ywvv11.prod.google.com ([2002:a05:690c:a60b:b0:798:19f0:2885])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c50e:b0:798:1f8:3152 with SMTP id 00721157ae682-79a1c085de0mr10723887b3.13.1773346713893;
 Thu, 12 Mar 2026 13:18:33 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:18:24 +0000
In-Reply-To: <20260312201824.203093-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312201824.203093-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260312201824.203093-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net: plumb drop reasons to __dev_queue_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267206-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66ACA278C34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add drop reasons to __dev_queue_xmit():

- SKB_DROP_REASON_DEV_READY : device is not UP.

- SKB_DROP_REASON_RECURSION_LIMIT : recursion limit on virtual device is hit.

Also add an unlikely() for the SKB_DROP_REASON_DEV_READY case,
and reduce indentation level.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 83 ++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f48dc299e4b270f2fedba11e669d4940e73f0d4d..200d44883fc130dcc80afa1ddccce68bf3ff592c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4745,9 +4745,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq = NULL;
-	struct Qdisc *q;
-	int rc = -ENOMEM;
+	enum skb_drop_reason reason;
+	int cpu, rc = -ENOMEM;
 	bool again = false;
+	struct Qdisc *q;
 
 	skb_reset_mac_header(skb);
 	skb_assert_len(skb);
@@ -4816,59 +4817,61 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	 * Check this and shot the lock. It is not prone from deadlocks.
 	 *Either shot noqueue qdisc, it is even simpler 8)
 	 */
-	if (dev->flags & IFF_UP) {
-		int cpu = smp_processor_id(); /* ok because BHs are off */
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		reason = SKB_DROP_REASON_DEV_READY;
+		goto drop;
+	}
 
-		if (!netif_tx_owned(txq, cpu)) {
-			bool is_list = false;
+	cpu = smp_processor_id(); /* ok because BHs are off */
 
-			if (dev_xmit_recursion())
-				goto recursion_alert;
+	if (likely(!netif_tx_owned(txq, cpu))) {
+		bool is_list = false;
 
-			skb = validate_xmit_skb(skb, dev, &again);
-			if (!skb)
-				goto out;
+		if (dev_xmit_recursion())
+			goto recursion_alert;
 
-			HARD_TX_LOCK(dev, txq, cpu);
+		skb = validate_xmit_skb(skb, dev, &again);
+		if (!skb)
+			goto out;
 
-			if (!netif_xmit_stopped(txq)) {
-				is_list = !!skb->next;
+		HARD_TX_LOCK(dev, txq, cpu);
 
-				dev_xmit_recursion_inc();
-				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
-				dev_xmit_recursion_dec();
+		if (!netif_xmit_stopped(txq)) {
+			is_list = !!skb->next;
 
-				/* GSO segments a single SKB into
-				 * a list of frames. TCP expects error
-				 * to mean none of the data was sent.
-				 */
-				if (is_list)
-					rc = NETDEV_TX_OK;
-			}
-			HARD_TX_UNLOCK(dev, txq);
-			if (!skb) /* xmit completed */
-				goto out;
+			dev_xmit_recursion_inc();
+			skb = dev_hard_start_xmit(skb, dev, txq, &rc);
+			dev_xmit_recursion_dec();
 
-			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
-					     dev->name);
-			/* NETDEV_TX_BUSY or queue was stopped */
-			if (!is_list)
-				rc = -ENETDOWN;
-		} else {
-			/* Recursion is detected! It is possible,
-			 * unfortunately
+			/* GSO segments a single SKB into a list of frames.
+			 * TCP expects error to mean none of the data was sent.
 			 */
-recursion_alert:
-			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-					     dev->name);
-			rc = -ENETDOWN;
+			if (is_list)
+				rc = NETDEV_TX_OK;
 		}
+		HARD_TX_UNLOCK(dev, txq);
+		if (!skb) /* xmit completed */
+			goto out;
+
+		net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
+				     dev->name);
+		/* NETDEV_TX_BUSY or queue was stopped */
+		if (!is_list)
+			rc = -ENETDOWN;
+	} else {
+		/* Recursion is detected! It is possible unfortunately. */
+recursion_alert:
+		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+				     dev->name);
+		rc = -ENETDOWN;
 	}
 
+	reason = SKB_DROP_REASON_RECURSION_LIMIT;
+drop:
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
-	kfree_skb_list(skb);
+	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
 	rcu_read_unlock_bh();
-- 
2.53.0.880.g73c4285caa-goog


