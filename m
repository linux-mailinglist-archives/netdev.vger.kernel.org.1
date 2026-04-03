Return-Path: <netdev+bounces-275248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOtOAE080GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78C398B3A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C75DD3044B7D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03605303CAB;
	Fri,  3 Apr 2026 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSdwMPhb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B125333426
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254548; cv=none; b=g6H/20EYRIaE1ogicujiKuX0ZJ+YOhyS8QM99/Ob8cHY78HRa3MSvsvtOZL44AwQI4FPHqj4R0sFNAW5CUejYoaeBGnVKPBFnVY80Z0O662PvZdGIHNGV6IbHsZyzHSZLLsl369LfgSFXLA3Nk3VCUOHhILv2s4fD+A/JMZs6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254548; c=relaxed/simple;
	bh=9yVrLQtKK+yaEcRxTc+wkj5nY8yqp/9Eywt/Xe8iKgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vikc8o70o8IA/enXEOuS8Dp2ysU7oMKhpEw+a6TK44x6oDbKi3UdZy42gQ9yGUdkbksK1ZaaVmq7aj8lzBBCjDSjbE/14UKSkmJmdT8lzIlD44nB1XEDVPQJ8TPlhBntFVnPP5KxyMKEwyrtgEmKtnNRijPvPrLmewbxX456i7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSdwMPhb; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b4b81c632so42912891cf.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775254546; x=1775859346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qvL/NUINTIX6ZrUZ8Spdes0hjtaxFpUVM8RixIYSfQ=;
        b=FSdwMPhbAr4zx7eC5lVZnJvQ+VNKkdkZNeL+cZIo9IQnOt0gkLhB4SS6uPSj8EeAJz
         9x9XcmPGj7mETsaBHGCnvSdOMAYd9JIoncW7TYFQ1onUo894T//gxJP8h66QvP7RECUR
         9BNk2j7VeBv/aD9KvegBeovJfK90caoWTLAxJY+crZkLF6hwUvo6Pi6sOxd72XayaJV7
         pCevVAda5arAMzSb7Lxdh58rSauTQNJ8PK3fwLsSc6i8gRzdBm1uQK6/VTND3v9nF+0f
         ELfge/0fzQ1L9+aZk7m0w5uX2rGeYS57kCL5RmkEhfv6kwEpAGhCCp1XXmtSLC3pXOEY
         fSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254546; x=1775859346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qvL/NUINTIX6ZrUZ8Spdes0hjtaxFpUVM8RixIYSfQ=;
        b=naT8CvEf0N/Kehw3nXBRE5OcH5ombLb5aFavi0pCHjL6x926Vr7/VgycLJFcSagS3l
         qJ1l8wYHCjvoUziljWEa0J905m7ay8ckqVEkU+YKd971PBxlcSpG2xWXONrl7m4eQqSL
         IgDGP/YRgqbgY7K2uCoJTPXjQCdI0HDVtBiEi31DpyS5ew9wSXbH+v2AjKrrfom0vchn
         z6o1rnaD+Q7EWymGLeAR9IEPHXNzEfPUl2QFD0+3nzjfy4QJFXBQghbMalvBvki4KomH
         6wAz7qaW2UFE1YRiNZloPbiggRpdYQgtaJT6X4NzOguxQjyK95g0Vt5ILzTHhr6Tcqot
         u4iw==
X-Forwarded-Encrypted: i=1; AJvYcCWsFrdvpHuZi3eeRaHhim7B6Agpmp2rUz+1Ud25gpYcdEjoqCBaiq0RW737b36JFfgw3N0apco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkE/qmTrIelXUTEZB3sAX+9VJlFfDW3/FKu7PgUa2h6W4vyjLE
	fmgmokWosU1S8VF57jS0wXkWm2x5PznSgh0z9EHUv+rCMbGfRrgHM8i/1ZdhmNwxIhFZS9KUMvd
	hyvRdCw9YI9QAtw==
X-Received: from qtqx7.prod.google.com ([2002:ac8:4a07:0:b0:50b:8bf1:9fc0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:738f:b0:50b:47b2:5591 with SMTP id d75a77b69052e-50d62a8d37emr55692711cf.42.1775254546173;
 Fri, 03 Apr 2026 15:15:46 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:15:40 +0000
In-Reply-To: <20260403221540.3297753-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403221540.3297753-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403221540.3297753-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net: pull headers in qdisc_pkt_len_segs_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275248-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C78C398B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most ndo_start_xmit() methods expects headers of gso packets
to be already in skb->head.

net/core/tso.c users are particularly at risk, because tso_build_hdr()
does a memcpy(hdr, skb->data, hdr_len);

qdisc_pkt_len_segs_init() already does a dissection of gso packets.

Use pskb_may_pull() instead of skb_header_pointer() to make
sure drivers do not have to reimplement this.

Some malicious packets could be fed, detect them so that we can
drop them sooner with a new SKB_DROP_REASON_SKB_BAD_GSO drop_reason.

Fixes: e876f208af18 ("net: Add a software TSO helper API")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h |  3 +++
 net/core/dev.c                | 51 +++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index de61dd5dbfd9dc7d91d22d79a510d42fb69eb60a..51855de5d20819bff950e1c5846a6a4f3f8a3b95 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -74,6 +74,7 @@
 	FN(UNHANDLED_PROTO)		\
 	FN(SKB_CSUM)			\
 	FN(SKB_GSO_SEG)			\
+	FN(SKB_BAD_GSO)			\
 	FN(SKB_UCOPY_FAULT)		\
 	FN(DEV_HDR)			\
 	FN(DEV_READY)			\
@@ -392,6 +393,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SKB_CSUM,
 	/** @SKB_DROP_REASON_SKB_GSO_SEG: gso segmentation error */
 	SKB_DROP_REASON_SKB_GSO_SEG,
+	/** @SKB_DROP_REASON_SKB_BAD_GSO: malicious gso packet. */
+	SKB_DROP_REASON_SKB_BAD_GSO,
 	/**
 	 * @SKB_DROP_REASON_SKB_UCOPY_FAULT: failed to copy data from user space,
 	 * e.g., via zerocopy_sg_from_iter() or skb_orphan_frags_rx()
diff --git a/net/core/dev.c b/net/core/dev.c
index 3eb2f50f516564c6a6465c19a6d802c136e0ddde..5a31f9d2128c28d07d2dd5d58baa2374d469ed82 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4101,16 +4101,16 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 }
 EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
-static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
+static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int hdr_len;
+	unsigned int hdr_len, tlen;
 	u16 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 	if (!shinfo->gso_size) {
 		qdisc_skb_cb(skb)->pkt_segs = 1;
-		return;
+		return SKB_NOT_DROPPED_YET;
 	}
 
 	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;
@@ -4118,43 +4118,49 @@ static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	/* To get more precise estimation of bytes sent on wire,
 	 * we add to pkt_len the headers size of all segments
 	 */
-	if (unlikely(!skb_transport_header_was_set(skb)))
-		return;
 
 	/* mac layer + network layer */
-	if (!skb->encapsulation)
+	if (!skb->encapsulation) {
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			return SKB_NOT_DROPPED_YET;
 		hdr_len = skb_transport_offset(skb);
-	else
+	} else {
 		hdr_len = skb_inner_transport_offset(skb);
-
+	}
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;
-		struct tcphdr _tcphdr;
 
-		th = skb_header_pointer(skb, hdr_len,
-					sizeof(_tcphdr), &_tcphdr);
-		if (likely(th))
-			hdr_len += __tcp_hdrlen(th);
-	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
-		struct udphdr _udphdr;
+		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
 
-		if (skb_header_pointer(skb, hdr_len,
-				       sizeof(_udphdr), &_udphdr))
-			hdr_len += sizeof(struct udphdr);
+		th = (const struct tcphdr *)(skb->data + hdr_len);
+		tlen = __tcp_hdrlen(th);
+		if (tlen < sizeof(*th))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
+		hdr_len += tlen;
+		if (!pskb_may_pull(skb, hdr_len))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
+	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
+		if (!pskb_may_pull(skb, hdr_len + sizeof(struct udphdr)))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
+		hdr_len += sizeof(struct udphdr);
 	}
 
+	/* prior pskb_may_pull() might have changed skb->head. */
+	shinfo = skb_shinfo(skb);
 	if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
 		int payload = skb->len - hdr_len;
 
 		/* Malicious packet. */
 		if (payload <= 0)
-			return;
+			return SKB_DROP_REASON_SKB_BAD_GSO;
 		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
 		shinfo->gso_segs = gso_segs;
 		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 	}
 	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static int dev_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *q,
@@ -4771,6 +4777,12 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
 
+	reason = qdisc_pkt_len_segs_init(skb);
+	if (unlikely(reason)) {
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return -EINVAL;
+	}
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
 	 */
@@ -4778,7 +4790,6 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	skb_update_prio(skb);
 
-	qdisc_pkt_len_segs_init(skb);
 	tcx_set_ingress(skb, false);
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
-- 
2.53.0.1213.gd9a14994de-goog


