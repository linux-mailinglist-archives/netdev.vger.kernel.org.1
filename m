Return-Path: <netdev+bounces-72298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29585778E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8294AB227EB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770D1CABC;
	Fri, 16 Feb 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hv0xZuRa"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094541CAB1
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071585; cv=none; b=qYHFuwl5fbXVYNZgh0tpAr3lURorHgnWtFZN5TUZm8RsLwf78WK2vXJ6b7Nfvtt5tuEkS9fCgu72Bo9QK3vah6RjnVGuMwy07F0ME0AKSaMTUU08OuzxLbRBXkxeTpE3Sy8XSR3AD2BI8x7D9396k/L1ypgVAntVopNWa/J7OM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071585; c=relaxed/simple;
	bh=f4fZ5be1Y9cmAUXB4IKAdi5dIt05EQK2EdJ/D3bu1QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nls2aTklvWCSP2lT4HUg+eSRUB+df6X+isOS5WBHaD3/UfyNqFBFIXjB6dU1SRi/NTt8qYMcEQX9U0gCD8HwKOJKNjttORwkP35lOyXTdZ6wWr5LD9pZncry8DBXzKDYuPyBHB/Qsdpn2B8IAsg8GEi2P3Y7yQ0H19esr0NO3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hv0xZuRa; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id D1D7B2048D; Fri, 16 Feb 2024 16:19:34 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071574;
	bh=yRPIeMH1Dei5wt5RWgupwXk6ImvO/CvBiMDlpJpJPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hv0xZuRa8NwZNhzlTo9CQxRd0CcdhMWhOk/3qUjfE//bsj9IYDfEVanorwenZz/iw
	 YRygnxxAKwx8/nYXNlMp/sXuYOKeTdAGMp7xvufHv5XT2iJ77+ab6cQ1Y6ddciyLeY
	 SlFxPFQ9A1wtLfLldh0y2sM5eSZpNeHKXOEWEtZzJ6zrEXDbmLsfRbXWUrQI7cg/aj
	 u8sPslGHs5x/QafS0oLSBLx3KN8dx5DzrsXb1+XwLuqQEGKFzfw4WdKHcLo0PFs25z
	 XyJk55MHN12j85oM+nHE65jFKO7R5koJ/FJBmFCw3JpGeKwAngHsE+miNdniEyi+im
	 mJGoRD7JbHReA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 09/11] net: mctp: copy skb ext data when fragmenting
Date: Fri, 16 Feb 2024 16:19:19 +0800
Message-Id: <be7c1076bda7dc6041718d907a8ae49cfd64983c.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're fragmenting on local output, the original packet may contain
ext data for the MCTP flows. We'll want this in the resulting fragment
skbs too.

So, do a skb_ext_copy() in the fragmentation path, and implement the
MCTP-specific parts of an ext copy operation.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Reported-by: Jian Zhang <zhangjian.3032@bytedance.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/core/skbuff.c | 8 ++++++++
 net/mctp/route.c  | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..71dee435d549 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6736,6 +6736,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 		for (i = 0; i < sp->len; i++)
 			xfrm_state_hold(sp->xvec[i]);
 	}
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (old_active & (1 << SKB_EXT_MCTP)) {
+		struct mctp_flow *flow = skb_ext_get_ptr(old, SKB_EXT_MCTP);
+
+		if (flow->key)
+			refcount_inc(&flow->key->refs);
+	}
 #endif
 	__skb_ext_put(old);
 	return new;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index edfde04a1652..f31ecb5e8aa6 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -905,6 +905,9 @@ static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
 		/* copy message payload */
 		skb_copy_bits(skb, pos, skb_transport_header(skb2), size);
 
+		/* we need to copy the extensions, for MCTP flow data */
+		skb_ext_copy(skb2, skb);
+
 		/* do route */
 		rc = rt->output(rt, skb2);
 		if (rc)
-- 
2.39.2


