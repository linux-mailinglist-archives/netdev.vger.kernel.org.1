Return-Path: <netdev+bounces-202650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31078AEE7B2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1497C3A8649
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BC22E3B0E;
	Mon, 30 Jun 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXJA7JVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344B28EA63
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312601; cv=none; b=AisFbYTI6/+Zfg2XIO0nMNtVy5D8oLZpxzDZClB/fLXXcdTi9ulWO0yUc0N8j2qlkHi6GfOxFKDcaxKJg42CyIReUMU0mvaSTl7Y220wG6PojZ/DARhza+0ta/EHX+MaO8lUuPKCMbmqz71nMxhv7gK4MLTSPEdwYhZYxguRWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312601; c=relaxed/simple;
	bh=D9jqQaGbvVKBUijTmZ6CXZvkT1Skld/+JDsPAOQe4rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJlF+vmu3W4cpwTta++RFO9F62xqNUNtMATUQcXKiKMQJp6R0X4J6UxpdH4pt+xRDc3rKguV5W8JSvzzMKQjiYtzXVevakYrxnCdi9ZNBQF7zzv1RhQg+H8Rn854S5vYnBKhzfrgVTz4WqccTrpgLcjIdU5TESdlntWcEftMfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXJA7JVk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e302191a3so48552037b3.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751312598; x=1751917398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laaBDXIT6luJUV05biWXU7/Zt7eiNpztDEtTLptVCqY=;
        b=dXJA7JVklPD1FrbMitKOA+HV+gtdvq+WJnZ3T4gtlG0WhxKzxS9ylwQ4yKuyKEK1CC
         7Wv9NZg9Oob0o0kbncVkf5GvSetsa5Zu8AC8dZxIoV57BHwphoEUtO4AhSSfk4Oni6qQ
         kkcJ4cZuyu9ITack/KdUp0kCOGvzn/8HqWlzewhh4MzO/w8SA0mZtIXntATC7Q7G7W/z
         pEimjcg+Nv5nrWId8laZIfU87Rcsz1wMLeUvNvku2KlB6WdWmMgNQLAQvKaegjhP+sdY
         vzga25gNk50C4L3TC96NeGNaHgENk2eVvsk89uPACmcMEjjd7FULlVPi3dXJSu1vngqM
         Oaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312598; x=1751917398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laaBDXIT6luJUV05biWXU7/Zt7eiNpztDEtTLptVCqY=;
        b=FhcEuWwXpUBZds5soUbJwigSKfugl/7OUClLpn2jRox69z3XpdCMUqrPbFJFHAxVOt
         iSN1syjmxMtQPWmAfXI4ZCL13UhF0ydcfECQhFvBsuz5BA2S01EJuCfEsumvn2/UpQIM
         c/DhTC9L2z0Bfi7sN1kBOQjJHKgI8T6KgiATyawzm8uxEYgkwg+SUCw85Xvu6tvh8yw4
         PXIEvrsyCcPN29uzJwxjUaH763pjxqXGUl+Dh0qg3Dlz3QrekCLBP4Jlny+n2CuYJiGN
         kqiaYDJx6vY7DhuSKiiV0U+gNJ3ZebS4ZQWrNrZYgO3vc3CuhICnKLrSUOO2MfN4am9d
         RYHg==
X-Gm-Message-State: AOJu0YxHPumiSUj9JFzqqnmDyOeyN9xHn9ef1aX6KQq8vK5f5ZK+Mwni
	gc7HYZm8CGvJMYzUIxhtQu92TMCpdhQHvHvT/Q2+dDJkLpj/Z0f9Z64XPiMVTQ==
X-Gm-Gg: ASbGncs7Aub9fwJ2yqmpJM6JCjI9DZtGKUU06N3nx2XTdEYLMofM7ds9BklihEcwc0D
	K/h3388htD7f7XH8urFw0SJ9xD7DB2J3wEqgvQR+0zjELjXx8QiSpDqpyq/VRBeSAM/IQWyFzTd
	6v9r1gUBZFNEbOxsbzWq0stoOYDczpVZnsnyRS4UrulTDzry7SOF+FzOAPZekLVmnnDfF2QtfJK
	wjXs7umLrFD7Jh7/Cw07FdTe5U3yQx10Jr/MYlwSQ0b/m001KPOG3S/xGltQgypL1vXNMdJvtjt
	+JWJTj8ykBF9/RG4HpRAWwXJE4jHTlww6BPvRd8aon8wm2Zlgim8Bu76a2RwBg1kgzO4hTBvKEO
	AuqrBAdiwSMeqlh7iyPWX0YANfphoz4krTV14zqrTh3m0PAZ8Tkrh15sGS/8Fog==
X-Google-Smtp-Source: AGHT+IGx5IFkVxGaO50oYB/ZEEc/KIxFtDxRIG/Euv3KUcmgEv6n+IcawH2OkHHV5YuxW1xpTfceXQ==
X-Received: by 2002:a05:690c:6c0b:b0:70e:7638:a3a9 with SMTP id 00721157ae682-7151719250dmr223009377b3.18.1751312598106;
        Mon, 30 Jun 2025 12:43:18 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb2661sm16884177b3.85.2025.06.30.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:43:17 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/2] net: preserve MSG_ZEROCOPY with forwarding
Date: Mon, 30 Jun 2025 15:42:11 -0400
Message-ID: <20250630194312.1571410-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
References: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

MSG_ZEROCOPY data must be copied before data is queued to local
sockets, to avoid indefinite timeout until memory release.

This test is performed by skb_orphan_frags_rx, which is called when
looping an egress skb to packet sockets, error queue or ingress path.

To preserve zerocopy for skbs that are looped to ingress but are then
forwarded to an egress device rather than delivered locally, defer
this last check until an skb enters the local IP receive path.

This is analogous to existing behavior of skb_clear_delivery_time.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c       | 2 --
 net/ipv4/ip_input.c  | 6 ++++++
 net/ipv6/ip6_input.c | 7 +++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7ee808eb068e..96d33dead604 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5937,8 +5937,6 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (pt_prev) {
-		if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
-			goto drop;
 		*ppt_prev = pt_prev;
 	} else {
 drop:
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 30a5e9460d00..f8696e67def4 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -226,6 +226,12 @@ void ip_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int protocol)
 
 static int ip_local_deliver_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC))) {
+		__IP_INC_STATS(net, IPSTATS_MIB_INDISCARDS);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return 0;
+	}
+
 	skb_clear_delivery_time(skb);
 	__skb_pull(skb, skb_network_header_len(skb));
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 39da6a7ce5f1..0f7fddc89658 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -476,6 +476,13 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 
 static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC))) {
+		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+				IPSTATS_MIB_INDISCARDS);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
+		return 0;
+	}
+
 	skb_clear_delivery_time(skb);
 	ip6_protocol_deliver_rcu(net, skb, 0, false);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


