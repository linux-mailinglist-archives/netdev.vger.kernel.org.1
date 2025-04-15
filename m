Return-Path: <netdev+bounces-182729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C9A89C72
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A01901CF3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8A82957A2;
	Tue, 15 Apr 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Ez5i8jSU"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E982951B0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716369; cv=none; b=IdVsye8FUvxf3Bhg9VSqW+GlOVDvh6/caDesyvZK1VA3cBbvqY2Z/JRCA7oCto1VtfX7OGFvN+vWbm10RxM419qXQXUsQup/oTOdEpWsWnHkuA8Kd2RYNUpVkLbOlYrB+Q59JCFS6TjQOd0WnT/8p/VPhoyeIImzfDOpLMGQMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716369; c=relaxed/simple;
	bh=W5ogA5CLRFcusUg3wn8A0Zn+ui+y7xJIwGnj+L0TEXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY9Yt3b3gRNbd9OTMepkd3FBCL4dHo1HuOunk0ikbqeyLWjvhdByThcLL03jEMmDPvhvgYXhvu0Tpcm0Zu0srYrA0H/1OkG478ornlMsOUUxzYuWakHB9VaPHg0Y4hGcZpn6R2jU4ju+s8QT/WQ9biTK1UwHrSKo3fxd65LoJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Ez5i8jSU; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id E8221200BFF2;
	Tue, 15 Apr 2025 13:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be E8221200BFF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744716365;
	bh=89U50mWWmX6OjZjjRurP0c1g2qKT2amHzBUeWPdoe8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez5i8jSU33JdtHTMLvvuZNc6/ScHQ5KMOTXGw+n5ZA7XSD0qMRd/GTBMLK5L/iYbA
	 qC+upOCfn4O2RAwlX+TonoHQCrIv1+dyvHwXc4w+btdJEzbpOaSxBY3se8zf8PoHsG
	 c1K7WQokR1q6O5BVsuUbHBILGE0VxyHXQN2u7I2yJ11W3zNFilALmSKrTxeBS7fMXN
	 1OHLQG/EIjbxc9ZKgwl+KHG5nJQun9kLhO3/LW/s/AxKQ7ckCgCB5Cb5JhE6m3kAVz
	 GniuPu1F8b7ns/MzLMwuqvm9kKFPab8fmyu2MLPpJz+sQcr8QFefo9yuzSAG7dWRdN
	 ST214xarHtCzA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 2/2] net: ipv6: ioam6: fix double reallocation
Date: Tue, 15 Apr 2025 13:25:54 +0200
Message-Id: <20250415112554.23823-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415112554.23823-1-justin.iurman@uliege.be>
References: <20250415112554.23823-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the dst_entry is the same post transformation (which is a valid use
case for IOAM), we don't add it to the cache to avoid a reference loop.
Instead, we use a "fake" dst_entry and add it to the cache as a signal.
When we read the cache, we compare it with our "fake" dst_entry and
therefore detect if we're in the special case.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 41 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 57200b9991a1..40df8bdfaacd 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -38,6 +38,7 @@ struct ioam6_lwt_freq {
 };
 
 struct ioam6_lwt {
+	struct dst_entry null_dst;
 	struct dst_cache cache;
 	struct ioam6_lwt_freq freq;
 	atomic_t pkt_cnt;
@@ -177,6 +178,14 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	if (err)
 		goto free_lwt;
 
+	/* This "fake" dst_entry will be stored in a dst_cache, which will call
+	 * dst_hold() and dst_release() on it. We must ensure that dst_destroy()
+	 * will never be called. For that, its initial refcount is 1 and +1 when
+	 * it is stored in the cache. Then, +1/-1 each time we read the cache
+	 * and release it. Long story short, we're fine.
+	 */
+	dst_init(&ilwt->null_dst, NULL, NULL, DST_OBSOLETE_NONE, DST_NOCOUNT);
+
 	atomic_set(&ilwt->pkt_cnt, 0);
 	ilwt->freq.k = freq_k;
 	ilwt->freq.n = freq_n;
@@ -356,6 +365,17 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
 
+	/* This is how we notify that the destination does not change after
+	 * transformation and that we need to use orig_dst instead of the cache
+	 */
+	if (dst == &ilwt->null_dst) {
+		dst_release(dst);
+
+		dst = orig_dst;
+		/* keep refcount balance: dst_release() is called at the end */
+		dst_hold(dst);
+	}
+
 	switch (ilwt->mode) {
 	case IOAM6_IPTUNNEL_MODE_INLINE:
 do_inline:
@@ -408,12 +428,19 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		/* cache only if we don't create a dst reference loop */
-		if (orig_dst->lwtstate != dst->lwtstate) {
-			local_bh_disable();
+		/* If the destination is the same after transformation (which is
+		 * a valid use case for IOAM), then we don't want to add it to
+		 * the cache in order to avoid a reference loop. Instead, we add
+		 * our fake dst_entry to the cache as a way to detect this case.
+		 * Otherwise, we add the resolved destination to the cache.
+		 */
+		local_bh_disable();
+		if (orig_dst->lwtstate == dst->lwtstate)
+			dst_cache_set_ip6(&ilwt->cache,
+					  &ilwt->null_dst, &fl6.saddr);
+		else
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
-			local_bh_enable();
-		}
+		local_bh_enable();
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
@@ -439,6 +466,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 static void ioam6_destroy_state(struct lwtunnel_state *lwt)
 {
+	/* Since the refcount of per-cpu dst_entry caches will never be 0 (see
+	 * why above) when our "fake" dst_entry is used, it is not necessary to
+	 * remove them before calling dst_cache_destroy()
+	 */
 	dst_cache_destroy(&ioam6_lwt_state(lwt)->cache);
 }
 
-- 
2.34.1


