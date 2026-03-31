Return-Path: <netdev+bounces-273539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL+FJEKUy2nMJAYAu9opvQ
	(envelope-from <netdev+bounces-273539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:30:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F25367197
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C243304E0EB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DA3ED120;
	Tue, 31 Mar 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJQl+r41"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0973E8C78
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949269; cv=none; b=agLqH2+i92l5r4I8Jfj7hzeYdDul3O22YYy+UZh2D/E9gDMWRs8PxDU0SRRSXz9U1iGOtUkGg3YooxeTBuxuQrTzDD8YNAwLsaS/V0TbUZ/5pK33N5vUgki0yU9CBoE5II1X9mokhjNea/XTO5Gk/KCP4Kvp6gjFr6baCuh5thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949269; c=relaxed/simple;
	bh=7ryj1S4X2UNkS4dtJjHcABhvH+mK31teUt5CMJKXupI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eo8d7s2F0sDZftESNTxP+lE/8/uH2OtgMEynuRtONNhwe548o+gDfP+x++tn2OvrnFR+ZHyQpqKAefbfiwgxOxrPaeHveNSVnFYr81XQpOuu+wvq8e2SYXb3O4HYM//+Cx/usVg+bEH7g39lqe/73FAd20ue++FhFzkoHWWvI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJQl+r41; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so2129285a91.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774949267; x=1775554067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnLpnn+8fDWXGZM4wcrNm+iqlJyJ+5W6t82IY0Jdz+0=;
        b=iJQl+r41tQCZ1I2RzPDeDPvTvTxOECTBmIaAfQ37GoaJPuW9WBiatsqvgWsphL/7vt
         R4VhMjINPPBLd1LCP5wYATMck7Vk1Wx2baWoyFYZmpFn8puVlcPye8d5ClMh4vDS5TuD
         zYckIf+bznw92lJj6uFwMm6Am2Za/4Neh0E0Q/ifvo/Lgjee29u8UjLcJk7cW/YclfsY
         JZ5OHcRCyoTF60OSA31mGRxjVWYX6c9PdAAiGktdN6UjsCLUfA7o2fIbuwypxoA8g/t5
         gPOvHWjinfLclzzinV5CT9x40pnoIbEyPFOLo0Brcws5kjhVzSPYqRt90KSfcgB0IQFA
         1gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949267; x=1775554067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnLpnn+8fDWXGZM4wcrNm+iqlJyJ+5W6t82IY0Jdz+0=;
        b=hsu1gzaqVBfnvZPbPYoc4Q6sbgTzgV5Kyz4rNQYMSHfpKSch7707LezX5DUSgTNbpi
         6E1xhZD5S95belep4MrpYFJ/oyeglb87NsjptOuBXtpgSkMLusJjF9PTFVnFeJ11voPZ
         AmH73Q3vxChB+Y9ZrybVL5OE8maPAYbWSl2DW9E4lBqkyBeu9oHvuu09hONRoIGFboBP
         +HvJx7SsgQoaYug2y/dy4rosmafqMWFI+CAlpBLQcROpEK4KPv/tWv30cZtBlrJ2Yg3P
         OxIONrJsMnSWTWzahRinbqKdPC5c29YINPC6y4PrmLuzg4wtJEykb+QQBkEQ2flGrgzA
         vxaA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0J4KG647BE9agjJQsN5W1XqFZJd0xPAPEnxnI5FIAKmd+EkgdIUBiIxMduVf/FIv7rg7Zok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FK/Fk2bvPghDzKW6PhSv2bmjG0DLI3AeFPfUqDfThdtyt1BW
	3HHWtrB0vkRk8z3aTy5sTe7ZXu3qtkE/pVqx4FstxhS+EmMf7TqoIitx
X-Gm-Gg: ATEYQzyWateweyW8gXX3mzpwijzpWQCdBkoSU/ozLDZaImkQEwM2mhmEKBbTeJd2HVX
	4rgzwQOAZbyakrAYGXwhdZ+hNx3oCf2i11bf9uVe3rt/1csJbfTHKRGTZhBaMz5SobFSd+iQxQ5
	nnNIIpJ1VVGAhWM9wkLVzaIszwU1S2coX+6CA/7twDkteYEdIJQ2sXdHc7yKSki+mPbpZX/JEKm
	RjcjS8Egfc20BUaFcWPAKp/W1L6Go8lMfxUrJl4966Ir74Ei3VO45qIB39DQHCNK40CoG2SMN4L
	2Euj6nzZocnpAGxSFUHhFmwPLKi8ADiPD9fAap2JUF772kX9RS864iTla+6svEIr8jPtfVaIMXS
	VvLuzDsIQ90uJpU/g5N9e3g2gPq3j80VJQ//gKw5pM+3r0v4aiIN+VJ/U9R0qER6EbpAo4x4aQ7
	2MpB9HTPkqr563GB0+DnPhgr3jshxpQj/vKrczOOVNzDe+CA==
X-Received: by 2002:a17:90b:1b4f:b0:359:8df1:8553 with SMTP id 98e67ed59e1d1-35db8eed6e0mr2263738a91.9.1774949267368;
        Tue, 31 Mar 2026 02:27:47 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe959358sm947663a91.13.2026.03.31.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:27:46 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] xfrm: delay dev_put in xfrm_input to after transport reinject
Date: Tue, 31 Mar 2026 17:27:37 +0800
Message-ID: <20260331092737.1937-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-273539-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E4F25367197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_trans_queue() queues transport-mode packets for async reinject
via xfrm_trans_reinject() workqueue.  After async crypto completes,
xfrm_input_resume() re-enters xfrm_input() with encap_type == -1,
which immediately calls dev_put(skb->dev) before the skb reaches
transport_finish and the reinject queue.  The device can be freed
before the workqueue callback runs, causing a use-after-free when
xfrm_trans_reinject dereferences skb->dev.

Remove the dev_put from the async resumption entry and let the
reference survive through the transport reinject path.  Introduce
async variants of the NF_HOOK okfn callbacks that queue the skb
with dev_held=true and drop the reference on error.  The reinject
worker checks this flag and puts the reference after the callback
completes.

For the synchronous crypto path, the existing dev_hold/dev_put
around x->type->input() is unchanged — the reference is balanced
within the same softirq context before the skb reaches the queue.

If the loop re-enters async crypto (multi-SPI with a second
-EINPROGRESS), drop the extra reference from the earlier async
resume so exactly one reference accompanies the skb.

Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes in v2:
  - Do not add extra dev_hold/dev_put pair (reviewer feedback:
    "expensive operation, we just drop it too early")
  - Reuse existing dev_hold from xfrm_input, delay dev_put to
    reinject completion
  - Add async okfn variants for IPv4/IPv6 transport_finish so
    the reinject queue knows whether a dev ref is held
  - Drop the cb->dev field from v1; use bool dev_held flag instead

Link: https://lore.kernel.org/all/20260320073023.21873-1-tpluszz77@gmail.com/
---
 include/net/xfrm.h     |  3 ++-
 net/ipv4/esp4.c        |  3 ++-
 net/ipv4/xfrm4_input.c | 25 ++++++++++++++++++++++++-
 net/ipv6/esp6.c        |  3 ++-
 net/ipv6/xfrm6_input.c | 16 +++++++++++++++-
 net/xfrm/xfrm_input.c  | 35 ++++++++++++++++++++++++++---------
 6 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..1dd8b3b36649 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1779,7 +1779,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 			 int (*finish)(struct net *, struct sock *,
-				       struct sk_buff *));
+				       struct sk_buff *),
+			 bool dev_held);
 int xfrm_trans_queue(struct sk_buff *skb,
 		     int (*finish)(struct net *, struct sock *,
 				   struct sk_buff *));
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcdef65..0114c92b10d4 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -187,7 +187,8 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
-	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb);
+	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb,
+				   false);
 	local_bh_enable();
 
 	/* EINPROGRESS just happens to do the right thing.  It
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index f28cfd88eaf5..9765fdc63ffc 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -46,6 +46,28 @@ static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 }
 
+static int xfrm4_rcv_encap_finish_async(struct net *net, struct sock *sk,
+					struct sk_buff *skb)
+{
+	if (!skb_dst(skb)) {
+		const struct iphdr *iph = ip_hdr(skb);
+
+		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
+					 ip4h_dscp(iph), skb->dev))
+			goto drop;
+	}
+
+	if (xfrm_trans_queue_net(dev_net(skb->dev), skb,
+				 xfrm4_rcv_encap_finish2, true))
+		goto drop;
+
+	return 0;
+drop:
+	dev_put(skb->dev);
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
 int xfrm4_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
@@ -74,7 +96,8 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
 		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-		xfrm4_rcv_encap_finish);
+		async ? xfrm4_rcv_encap_finish_async :
+			xfrm4_rcv_encap_finish);
 	return 0;
 }
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f75313734f8..8a0a44d7d010 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -204,7 +204,8 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
-	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb);
+	err = xfrm_trans_queue_net(xs_net(x), skb, esp_output_tcp_encap_cb,
+				   false);
 	local_bh_enable();
 
 	/* EINPROGRESS just happens to do the right thing.  It
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 9005fc156a20..d4eede5315ac 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -40,6 +40,19 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
 	return 0;
 }
 
+static int xfrm6_transport_finish2_async(struct net *net, struct sock *sk,
+					 struct sk_buff *skb)
+{
+	if (xfrm_trans_queue_net(dev_net(skb->dev), skb, ip6_rcv_finish,
+				 true)) {
+		dev_put(skb->dev);
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	return 0;
+}
+
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
@@ -69,7 +82,8 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-		xfrm6_transport_finish2);
+		async ? xfrm6_transport_finish2_async :
+			xfrm6_transport_finish2);
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index dc1312ed5a09..2d75f984532a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -40,6 +40,7 @@ struct xfrm_trans_cb {
 	} header;
 	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct net *net;
+	bool dev_held;
 };
 
 #define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
@@ -506,7 +507,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
-			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			spin_lock(&x->lock);
 			goto resume;
@@ -659,8 +659,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			dev_hold(skb->dev);
 
 			nexthdr = x->type->input(x, skb);
-			if (nexthdr == -EINPROGRESS)
+			if (nexthdr == -EINPROGRESS) {
+				if (async)
+					dev_put(skb->dev);
 				return 0;
+			}
 
 			dev_put(skb->dev);
 			spin_lock(&x->lock);
@@ -695,9 +698,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
 
 		err = xfrm_inner_mode_input(x, skb);
-		if (err == -EINPROGRESS)
+		if (err == -EINPROGRESS) {
+			if (async)
+				dev_put(skb->dev);
 			return 0;
-		else if (err) {
+		} else if (err) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
 			goto drop;
 		}
@@ -734,6 +739,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		if (async)
+			dev_put(skb->dev);
 		gro_cells_receive(&gro_cells, skb);
 		return 0;
 	} else {
@@ -753,6 +760,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
+			if (async)
+				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
 			return err;
 		}
@@ -763,6 +772,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	if (async)
+		dev_put(skb->dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;
@@ -787,15 +798,20 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct xfrm_trans_cb *cb = XFRM_TRANS_SKB_CB(skb);
+		struct net_device *dev = cb->dev_held ? skb->dev : NULL;
+
+		cb->finish(cb->net, NULL, skb);
+		dev_put(dev);
+	}
 	local_bh_enable();
 }
 
 int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 			 int (*finish)(struct net *, struct sock *,
-				       struct sk_buff *))
+				       struct sk_buff *),
+			 bool dev_held)
 {
 	struct xfrm_trans_tasklet *trans;
 
@@ -808,6 +824,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
 	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->dev_held = dev_held;
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
@@ -820,7 +837,7 @@ int xfrm_trans_queue(struct sk_buff *skb,
 		     int (*finish)(struct net *, struct sock *,
 				   struct sk_buff *))
 {
-	return xfrm_trans_queue_net(dev_net(skb->dev), skb, finish);
+	return xfrm_trans_queue_net(dev_net(skb->dev), skb, finish, false);
 }
 EXPORT_SYMBOL(xfrm_trans_queue);
 
-- 
2.43.0


