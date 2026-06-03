Return-Path: <netdev+bounces-294587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QH8tB+3NH2p6qAAAu9opvQ
	(envelope-from <netdev+bounces-294587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D6634CAE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Nyt5/rBy";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294587-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294587-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDC16302C74E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFA3955CD;
	Wed,  3 Jun 2026 06:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83353909A4
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:47:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469226; cv=none; b=eB68Ro+1dKwesRfo2/S5tbtEEDLHciDRRoeuF0n16dmP/HrriBkrXnT+eOhTn4NYEQ2v1hn11ovV7EKEwEQGSXEBsUoh664zkJ8KCY777k1Rc03ZfnoUbJEjDBudL3iohgMZtxhoBtJrzJB7i5tUgWLTgsZe6zhPDKRpyy+bLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469226; c=relaxed/simple;
	bh=tC6Yze76YDvtLH3JyplB3GFDFXrkujnJEcmeOmKt+0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2OL0J0Jd73wLNEHzcQJBNXP6WZH6viCVd02Sz9Xgs9EY1ncx0vyTP9dqDtsNi0ZEwLPdA5Ixu0MgQPGwYjuto3M7UAsbY1LTqrkkphFN6wTWFKZVcLvPBeKlSyLAuYjy3e4sNAg2yxdPR6abhVJHDU796mVZ2NvTa73mn3+bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyt5/rBy; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49068493267so71619045e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469222; x=1781074022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmq/X2AoAxUvVMRqn8t7pLR/zzqYFJcqvtSDW8+YznA=;
        b=Nyt5/rByfyvw9DRacT/pUJLEJ6S03wnVglgD/gh1/6EeD3wgt7a+3GyUd1d6xA2txL
         KS2QdSXMi9J0M2zH3BHETQqSGtYuAD7VI20XJv8GfgA0yTBjvdtgYOV3Gxc1SaJln9H2
         8ZkiOOprorcHTleBOto0E4JLx84y7uC9nQg9pPxOwuADf4dhWi/EANuFiZe0fH9eovmw
         5EWj/8f3Tomi766s3gYVvmaEmGJeb9AJdeNHCA+rodbuWgMlAZx6bG1x30W5FbTsIphn
         W3ciEHe52fab7Gjmxj0wKT0O1FQPNyWaNNTFzyui+5gPVW2madT05SzFKORkfEZ/6o1d
         CXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469222; x=1781074022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmq/X2AoAxUvVMRqn8t7pLR/zzqYFJcqvtSDW8+YznA=;
        b=UzwI2XJzdl8F+qS0CPZX+a7Z6R1RBm2hn648HWcKYpZ6za4uVul2hIwmgGI5gKV8nY
         sD/ORGxpwQ/fe9xvYI+RUFlbgZJ3fEPGrGGn68WrsnqWHs32CUnfPUUn+AKh6af7t4iB
         pPsp50WrhJzDvDvCeNGGqGMLVyuILralC0/8P8+E7k6oTtNUAov6rYMhngkaS8a5zUjB
         ySdrVRoeNrZbMr1BF85AKNWCxtx4B4HUndyB+lINj7SHA14HUg4tMsB09sdJqtFQYStn
         5HOwdVWKm8bYK6LXvuNHV+sr8jYWJ5xbdXPSx341P826U5+3BIG7DSzMnvfoUJ8f5Rg5
         547Q==
X-Gm-Message-State: AOJu0YzwSO1dverwnFC0KFx/o0/pJd7NZg1nwmOiljt0p+9cbKB/rmOF
	U4dIIbUwfJ2rtNTZCVp8PQWLzdVlFgiEpzWShyc8kdLrxPCta5hjoUaggd7N5o9P
X-Gm-Gg: Acq92OHCvncewnHcT56AnaDk5DDFhTA6ZhG+9ttme52VdkJQUlqSvEDe1DxVU+g8lbi
	qLyyfEwVGuqmNQHxLVJa0vPHfJ2eh6+8bqdekvyt+P6kyL5dGeu0LxqiBffq0+BLHTSge/znLES
	O0mRPD2g1BCgDqkTeFwzYF4wKx3+NkLKRJuKFL8A1qYF5BYtgCK8p328z2iWrjbLDivqJNo/fA+
	X7SH5RNUQl+kiVekNhyC25TF+vS2MjpfdXoZbMFzFT0sI3MilIPdpHZpA/DoJOU9PlAhW1/LgoH
	kqd4nxYwb4o7HdEjYOV8PtLzMSLpbvs/6mtbqE6ToAE1q0JFVDd5bRry037N8enqwDrTx4Zf+c6
	evIhHMArsbzuLNTpLxa/x0cAKdlVp3ozqv2XYEdV1fC9ZUCktz6+5DrW57OAwDLRPa8ifCo4lbH
	kocb1r2/dEwwvNuvCUhrw9ES68f9KFYWJn5qTSoAQDyO181RPV6bkgo8STYeesx/Yg7QtMrzieu
	aN5MJwPXYQPqpuswupKob7V+AVUxHPKDuL0VoY=
X-Received: by 2002:a05:600c:8b21:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-490b5e83933mr30148775e9.2.1780469222047;
        Tue, 02 Jun 2026 23:47:02 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d64e8sm20889215e9.0.2026.06.02.23.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:47:01 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: sd@queasysnail.net,
	steffen.klassert@secunet.com,
	pabeni@redhat.com,
	edumazet@google.com,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v4] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
Date: Wed,  3 Jun 2026 08:46:59 +0200
Message-ID: <20260603064659.3867-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294587-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:steffen.klassert@secunet.com,m:pabeni@redhat.com,m:edumazet@google.com,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[queasysnail.net,secunet.com,redhat.com,google.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,queasysnail.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B10D6634CAE

validate_xmit_xfrm() returns NULL both when a packet is dropped and
when it is stolen by async crypto (-EINPROGRESS from ->xmit()).
Callers cannot distinguish the two cases.

f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
changed the semantics of a NULL return from "dropped" to "stolen or
dropped", but __dev_queue_xmit() was not updated.  On virtual/bridge
interfaces (noqueue qdisc) __dev_queue_xmit() initialises rc=-ENOMEM
and jumps to out: when skb is NULL, returning -ENOMEM to the caller
even though the packet will be delivered correctly via xfrm_dev_resume().

Return ERR_PTR(-EINPROGRESS) from validate_xmit_xfrm() for the async
case so callers can tell it apart from a real drop.  Update
__dev_queue_xmit() to handle ERR_PTR(-EINPROGRESS) from
validate_xmit_skb() correctly.  Update validate_xmit_skb_list() to
use IS_ERR_OR_NULL() so that ERR_PTR(-EINPROGRESS) is not mistakenly
added to the transmitted list.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
Changes in v4:
 - Drop bool stolen tracking in validate_xmit_skb_list() and ERR_PTR
   return from that function; use IS_ERR_OR_NULL() in the loop so
   stolen skbs are silently skipped (same as the pre-patch NULL behaviour)
   (Sabrina Dubroca)
 - Drop ERR_PTR(-EINPROGRESS) handling in __dev_direct_xmit(); callers
   cannot reach the -EINPROGRESS path of validate_xmit_xfrm()
   (Sabrina Dubroca)
 - Move validate_xmit_skb() return-value comment above the function
   instead of inline in __dev_queue_xmit() (Sabrina Dubroca)

Changes in v3:
 - Fix validate_xmit_skb_list(): set stolen=true only for -EINPROGRESS,
   not for all IS_ERR() cases (Sabrina Dubroca)
 - Update __dev_direct_xmit() to handle ERR_PTR(-EINPROGRESS) from
   validate_xmit_skb_list() before kfree_skb_list() which would crash
   on an ERR_PTR (Sabrina Dubroca / sashiko)

Changes in v2:
 - Only reset rc to NET_XMIT_SUCCESS when PTR_ERR(skb) == -EINPROGRESS,
   not for any IS_ERR() result (Sabrina Dubroca)
 - Add comment explaining why rc is reset and the async delivery path
 - Fix validate_xmit_skb_list(): track stolen skbs and return
   ERR_PTR(-EINPROGRESS) when all skbs in the list were stolen by
   async crypto, not NULL (Sabrina Dubroca)
---
 net/core/dev.c         | 11 ++++++++---
 net/xfrm/xfrm_device.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0c6c270d9..18e92bef7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4016,6 +4016,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	return NULL;
 }
 
+/* Returns the skb on success, NULL if dropped, or ERR_PTR(-EINPROGRESS)
+ * if stolen by async xfrm crypto (delivered via xfrm_dev_resume()).
+ */
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	netdev_features_t features;
@@ -4078,7 +4081,6 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	struct sk_buff *next, *head = NULL, *tail;
-
 	for (; skb != NULL; skb = next) {
 		next = skb->next;
 		skb_mark_not_on_list(skb);
@@ -4087,7 +4089,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		skb->prev = skb;
 
 		skb = validate_xmit_skb(skb, dev, again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb))
 			continue;
 
 		if (!head)
@@ -4858,8 +4860,11 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			goto recursion_alert;
 
 		skb = validate_xmit_skb(skb, dev, &again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb)) {
+			if (PTR_ERR(skb) == -EINPROGRESS)
+				rc = NET_XMIT_SUCCESS;
 			goto out;
+		}
 
 		HARD_TX_LOCK(dev, txq, cpu);
 
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 550457e4c..bb0c0fafa 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -182,7 +182,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		err = x->type_offload->xmit(x, skb, esp_features);
 		if (err) {
 			if (err == -EINPROGRESS)
-				return NULL;
+				return ERR_PTR(-EINPROGRESS);
 
 			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
 			kfree_skb(skb);
-- 
2.51.0


