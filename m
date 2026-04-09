Return-Path: <netdev+bounces-276896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JH7OH9q12myNggAu9opvQ
	(envelope-from <netdev+bounces-276896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC4B3C81FD
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F233055DEC
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C538F240;
	Thu,  9 Apr 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvGNdQOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1538550A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724767; cv=none; b=oAD9ktEItN4Q+TDOMWI4s8NffIc8ycUyM5d1OimxCIXcNX9+DTjyuyKLkbOYMq1qPZnYwBwJH3CCfvGd90CAT3b9LzsbglfLDf2eORu3ipB+8RssmkHVORh7hahWYIAxG+23wSQgXB9aKwQtAeaPBlyU/UW4ac+n5QpZdRzuSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724767; c=relaxed/simple;
	bh=SnycINSvMrsTYN7o3VQ9VjfpCIM4CZoHt+uEsda1rkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=obvW8jkWdGLQq05W3Z3wBWNFvipSeDkWAVLdR9WPrOwhg54gLg2dnC825lC4sW09rtWVnLyFXlRqU3tSnB4h7DNuRb0PInpPztGGcnbj1ZCm+ZMmPUBCD6YKQhY8IZ5eML9t7fRfyzMEv21TyVf6UoS2kqgvi9M/VrOQjwDR4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvGNdQOx; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8c192b3fso35486971cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775724764; x=1776329564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=joGTEHnyC2gWFMculzj+p1s7d9jK2bjrOx0CVR84se0=;
        b=vvGNdQOxzb3SRxwFjrLzxREG2jLr/Zfp8yK4l+MxMCK5/uwRzdnwWAt6V4clKJJtsN
         IaSWa2Hv8lX/fREQuYMu1TpPbzcHcEjDd4yZZ8ap/PLiBv111nYzrZzjrmTs3Ir/3nJR
         g4vp4YVFaKnYmEgd8clq2mpVe23X5fWhXxdW8fHNQvArU8ba+UXc1E/7XHVBddNCffFL
         IVc0x8hlSCkCfsHmYqznY1HiefXBn6toOSv+mypAjZWTko4fYfge3AEOd9Zx5njUb996
         vNmtbFNrpTI6gpcLStGV8dMkWO+cBefHAQEBm+EdI+Zaw8niSiFJOpSY5cHMMaM5Ac74
         M8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724764; x=1776329564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joGTEHnyC2gWFMculzj+p1s7d9jK2bjrOx0CVR84se0=;
        b=SOfEPtS9GBwYOp/r26QAPhGHbGeefkyR23C+gicvxNh9f4g/x9sCUwQa6gEljTBpsg
         C9uRhz68Z9i2YAE8egaoPpDDUGNhYglBk3ED1UhgyiyzW8pMYCH5xVdhLyb2H0ZR7SgL
         eFuJklMK76J4MHSUaeu+63BmIwMoQ0LlA/nsAWBOumBb6UnZinSexsvrivz9/c5fIu31
         EVoLah9iQ3bWc4sB//4zMi9pTYKJnlf7JzzpodqTCnBzUEHMLKhvexe+e0T6/Cv5UIP5
         nOprgAMmSEv+Y2Y6w9f6IaV5MqdWWJUXQItzrnRFmW5VB2dQXgeq10sVVpU8u3YdmfGg
         2pVg==
X-Forwarded-Encrypted: i=1; AJvYcCWCRxuXqea19vVVs28osKjHJnMrHxs1B50hBG+EELtiARZ9dwddq8oVxBBR6fFNGE2Rx6gedz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVdYTuLJhSfLm7Uf43avOXh61T3BKQR8igwb4vaKQ3AvhzoLM
	Gp2iB17IRCyL8R2SyZio8HePCmuz8U5WXZe1CijF8lcmjjzgU3CLR9lg+w4CeWag73kuj9cQlBB
	wWdW6ar4lspVeOQ==
X-Received: from qti20.prod.google.com ([2002:a05:622a:8354:b0:509:1e8e:d6c7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a9d1:10b0:509:68c:634d with SMTP id d75a77b69052e-50dc210953emr29382611cf.10.1775724764265;
 Thu, 09 Apr 2026 01:52:44 -0700 (PDT)
Date: Thu,  9 Apr 2026 08:52:37 +0000
In-Reply-To: <20260409085238.1122947-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409085238.1122947-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409085238.1122947-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] ipvlan: ipvlan_handle_mode_l2() refactoring
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FC4B3C81FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reduce indentation level, and add a likely() clause
as we expect to process more unicast packets than multicast ones.

No functional change, this eases the following patch review.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 38 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 0b493a8aa33857d531329e8eaef6b25a5c6f572d..214fd299a5aa6e40579aa2dbcb178b5474b561a4 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -744,34 +744,32 @@ static rx_handler_result_t ipvlan_handle_mode_l3(struct sk_buff **pskb,
 static rx_handler_result_t ipvlan_handle_mode_l2(struct sk_buff **pskb,
 						 struct ipvl_port *port)
 {
-	struct sk_buff *skb = *pskb;
+	struct sk_buff *nskb, *skb = *pskb;
 	struct ethhdr *eth = eth_hdr(skb);
-	rx_handler_result_t ret = RX_HANDLER_PASS;
 
 	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
 		return RX_HANDLER_PASS;
 
-	if (is_multicast_ether_addr(eth->h_dest)) {
-		if (ipvlan_external_frame(skb, port)) {
-			struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+	/* Perform like l3 mode for non-multicast packet */
+	if (likely(!is_multicast_ether_addr(eth->h_dest)))
+		return ipvlan_handle_mode_l3(pskb, port);
 
-			/* External frames are queued for device local
-			 * distribution, but a copy is given to master
-			 * straight away to avoid sending duplicates later
-			 * when work-queue processes this frame. This is
-			 * achieved by returning RX_HANDLER_PASS.
-			 */
-			if (nskb) {
-				ipvlan_skb_crossing_ns(nskb, NULL);
-				ipvlan_multicast_enqueue(port, nskb, false);
-			}
-		}
-	} else {
-		/* Perform like l3 mode for non-multicast packet */
-		ret = ipvlan_handle_mode_l3(pskb, port);
+	/* External frames are queued for device local
+	 * distribution, but a copy is given to master
+	 * straight away to avoid sending duplicates later
+	 * when work-queue processes this frame.
+	 * This is achieved by returning RX_HANDLER_PASS.
+	 */
+	if (!ipvlan_external_frame(skb, port))
+		return RX_HANDLER_PASS;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (nskb) {
+		ipvlan_skb_crossing_ns(nskb, NULL);
+		ipvlan_multicast_enqueue(port, nskb, false);
 	}
 
-	return ret;
+	return RX_HANDLER_PASS;
 }
 
 rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
-- 
2.53.0.1213.gd9a14994de-goog


