Return-Path: <netdev+bounces-306793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BMNfNJoLUmoWLgMAu9opvQ
	(envelope-from <netdev+bounces-306793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C697410AA
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S24g1CXr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306793-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306793-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26AE33038D1C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CE38734E;
	Sat, 11 Jul 2026 09:23:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DF388E4B
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:23:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761781; cv=none; b=IqV7vUIJYX7sdIGlF3SOG7Sw+zLrkKuy4YKowrekwhffWhShxWVzajDodv48tF7XI7Hm4ScnW1a6RuILIL1yaqTx27nukWocPLE51Y299wZZ0+15yTuTvoUWd68X7Xonjxb03GIq3ejdexqa4ltc7wMPKrYdi0m0RILJZ2ZxQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761781; c=relaxed/simple;
	bh=6GIvbMzZ/8+UhVq4yGW71tg8Wjh7suXtJNnD3BDWuuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSdNrr8mYXq90mmRFkS0WTfmvaYlLcoC1kkq/9/lqQIlL2Wt4i7eNlO/IHnON21EVW65qhNWP5BJ9HizKmLOHvl+bdxGb01tOxhlEM2yAAJq7woh3qBc4jMDgmeqqYzFDsENxFZI90p/x45H6QtQAUHBbITc54wEiTE4n1tMFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S24g1CXr; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ba5b151dso233162066b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761779; x=1784366579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PH65A4UuFTzfmoM+usqii1kD4+60b1ufjgSdZD8jziE=;
        b=S24g1CXrKg/o2pt04bYtHVeA5M5y9/tiDMxOPXAWYDZMWxTYiIrU/+deCnmBkb9Wgy
         lJdCF3BMw9FhF/QmPUe3IZ0TwRugYIXA2C0LMLindWdQYitnP7fS7rwoM8tfcE2EqYxT
         XXza1DebuyqGhw4i26p2pBvfvWd3b6Xra5IG+mTs6v/2CVGGtHBb1UWYS6VKEuZEhBLy
         toxn1sHa7QEJUQtkR6bUuLhaYY9Z3Qy+027bptuzbTTP85QTao9DVWLd9gC6IwrKfRSw
         a6aZ4LURv3ivp9HauqblLSy7eScVhieFMhCw29QVY7ig6J3bDhVhjMp9HPBrhobqRbK3
         EB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761779; x=1784366579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PH65A4UuFTzfmoM+usqii1kD4+60b1ufjgSdZD8jziE=;
        b=hHDY4lhWqsgiPd1xencPjEWylf0nxY3mVTwymp3TdPVhI3D7Cz1pwD2CmYMgO1BGlw
         9LV/K3/mtn8nxjwnYH1t3iKr2diShYPjHrHIDJP/v8Lgxy0C+1n5S6EMCslFT86R3JRC
         7pUhzSXOkyYc69/4OHa+o5rWJRfmbynLJtnrHEtyoTh8xtBhjyYdnZrXQ4/Eb5eD0BUj
         d4O6tlQ2csKINEgtgUmdTTeMibDvkJW1evqI8KpzLvLSPJAGAMGm2F1NcCM3GZPgPepu
         eC/Ch8sMz/101z/1OWqZXSlPgxCuJU+0sgsabzfZ9eZRAAJdB65KsOO7g4VVLfW6k4LS
         wimQ==
X-Forwarded-Encrypted: i=1; AHgh+RqEc1RN2Ex/yaNJaGXlUyditbLxVxRLseqcX7MvA17Gi/672nlzAe6YUcASi7Nbl/fmOM0El4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEE7eM/JFxX2of5E6L0KHtR4hQEvJek7BxIuiLW7HT0R3ETfN
	0XWJF3YpovQDEwzMbhDbbRhWyPvDX+CJB9Bty5r7enpDTU3LJ1LXD+an
X-Gm-Gg: AfdE7cmlxDSBTSsYwQrs0NMNm0HbH7PHID1RhQ2UgoR09GaRg3X1wx+6qMqOIum5KYl
	kEjzmik+jSK0eHUQvdySOyyH0UZ5JZ0J0vql1CFodaP870btao4UCT9cLU7UXKHzsqcZ9L2HVIS
	Z9ZbffT01MAb5c5l1PMvJZMgsQxMDPsa1LOo7wiF3fTmnT+VUnZ+bJ4LzPZMDKYT32pwOVfjzyj
	qT43SrRWOGEmAAo5w9OocrHHC6tL1tCnK5W384XRizGn5t3hfr5gZmmXOAG0CIxlCB223ya1U8o
	lmZypufHI+andLlf/O1dl7wNljuqyp+bhHKyDaPxa6yLfrBvtx7aC6fKkpchtXIx4pjMMUwZZbT
	3nUdHlb6l0X0VwrrVkjYihmOxilMq0ANh9xSVbac+OyyGw7jiWtjlcc0/MSkasxevY144Yau+Xf
	hm5FhFjnQTXYjo8sqvF+7cVG9AjE7ys/bP2Rt2lYHVIBIn1BERvy4Aug/5SzM8NbpfG8EoDmEVI
	ZN3pMtwKEAyWVP60uZcWLPxr/j7HUaM98aKynj+6T1jJXw=
X-Received: by 2002:a17:907:e1c3:20b0:c12:34f0:f7c6 with SMTP id a640c23a62f3a-c161f437815mr52997666b.57.1783761778687;
        Sat, 11 Jul 2026 02:22:58 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:57 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 7/9] io_uring/zcrx: don't lock for single producer ptr ring
Date: Sat, 11 Jul 2026 10:22:17 +0100
Message-ID: <b467df7a7e4cdcbeaebb8376f6a8f02fffa76f05.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306793-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65C697410AA

Normally, there is just one io_uring instance using zcrx and all
receiving happens under its lock. In this case we can avoid grabbing the
ptr ring lock on the production side.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 +++++-
 io_uring/zcrx.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 80a26b5798d3..3d5d5c9fd9a5 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -825,6 +825,7 @@ static int zcrx_export(struct io_ring_ctx *ctx, struct io_zcrx_ifq *ifq,
 	if (!mem_is_zero(ce, sizeof(*ce)))
 		return -EINVAL;
 
+	ifq->shared = true;
 	refcount_inc(&ifq->refs);
 	refcount_inc(&ifq->user_refs);
 
@@ -1974,7 +1975,10 @@ static int __zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 
 	if (can_steal && !__ptr_ring_full(&ifq->skb_ring) &&
 	    tcp_read_sock_steal_skb(desc, skb, args->sock->sk)) {
-		ret = ptr_ring_produce(&ifq->skb_ring, skb);
+		if (ifq->shared)
+			ret = ptr_ring_produce(&ifq->skb_ring, skb);
+		else
+			ret = __ptr_ring_produce(&ifq->skb_ring, skb);
 		if (ret) {
 			zcrx_user_ref_frags(ifq, skb, first_frag, i);
 			__kfree_skb(skb);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 7fc12e53c8a1..5ff4dabb0f68 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -71,6 +71,7 @@ struct io_zcrx_ifq {
 	spinlock_t			alloc_lock ____cacheline_aligned_in_smp;
 
 	struct ptr_ring			skb_ring;
+	bool				shared;
 
 	u32				if_rxq;
 	struct device			*dev;
-- 
2.54.0


