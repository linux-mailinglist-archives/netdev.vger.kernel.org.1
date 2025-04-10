Return-Path: <netdev+bounces-181329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1624A847C5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659164E0F16
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD2F1E9B07;
	Thu, 10 Apr 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="c6OMN6b4"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457813AC1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298701; cv=none; b=o5VrDXuUW4RJV3LFzglGL6uNoKkf1o06bR/9OPG1NauqWqZEQcn2RkLff4mjPI8d5PydyshS9+A8dN+zVc5TSvnsfQ0Rda+Ig1yHfwamuHDWWbx+MYiKXpL77xiSj5CNV8mMCdyf2WRCySc5QmFmx7xwfrlFjdavPcrgUSX0jDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298701; c=relaxed/simple;
	bh=xL4lrdKnf7v8YdwMgwhe3cVE9HVZrqtKaYldLbnM0BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alTLmqwBYYMGJhLNq/ouxHB+1CStxztRuW6Db4INMYs3eDI7LuOF08S9XOo4RmUdkhfJ3KbE5SPAtx2a6KDUwP3jcuEQETUNUKORUFX3apNIKKN6dVIMeHl3ejZUWje4EjPbdhsqG1El8E6d+d6rYeisAUcoD8y7fWzA8AKVHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=c6OMN6b4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EBFBC200A8AD;
	Thu, 10 Apr 2025 17:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EBFBC200A8AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744298691;
	bh=nM7xAQgv/18jqNyVkGW27+B26z8lC/AgVfkBuaOm7V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6OMN6b46XwFHDLVhnaSOaTCnal1yvRkMTHa4cyGO+W/gJng8dNhlLmN5Lomaqx9D
	 whkwSn0h3PEWdB9Tj8wGyCIvLQ8aR9Px+WBg7PPwuUb06wZMKR42TDElXa+feDeY0O
	 NdU5BggMdaVjfyLV06jpv6FfszYnQaXBYn2VwJ2gDgqK6/DISqhZX/UDqzLMdmgQhO
	 Jxl8m5W7uYmeBGZaaaO4LNvHmtXRCduYKQ6Zq5KmrpGdKYGmjGyJlnfoAcU6ZVdaIY
	 VI77y5xyDnKDkS3bcb4g/RyUlZLcXrgLsLEciQGM9mUKaKQyxGNuK23wslhC+oPBpK
	 d9mbaJggqeeDQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 2/2] net: ipv6: ioam6: fix double reallocation
Date: Thu, 10 Apr 2025 17:24:32 +0200
Message-Id: <20250410152432.30246-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410152432.30246-1-justin.iurman@uliege.be>
References: <20250410152432.30246-1-justin.iurman@uliege.be>
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
 net/ipv6/ioam6_iptunnel.c | 40 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 57200b9991a1..bbfb7dd7fa61 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -38,6 +38,7 @@ struct ioam6_lwt_freq {
 };
 
 struct ioam6_lwt {
+	struct dst_entry null_dst;
 	struct dst_cache cache;
 	struct ioam6_lwt_freq freq;
 	atomic_t pkt_cnt;
@@ -177,6 +178,16 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	if (err)
 		goto free_lwt;
 
+	/* We set DST_NOCOUNT, even though this "fake" dst_entry will be stored
+	 * in a dst_cache, which will call dst_hold() and dst_release() on it.
+	 * These functions don't check for DST_NOCOUNT and modify the reference
+	 * count anyway. This is not really a problem, as long as we make sure
+	 * that dst_destroy() won't be called (which is the case since the
+	 * initial refcount is 1, then +1 to store it in the cache, and then
+	 * +1/-1 each time we read the cache and release it).
+	 */
+	dst_init(&ilwt->null_dst, NULL, NULL, DST_OBSOLETE_NONE, DST_NOCOUNT);
+
 	atomic_set(&ilwt->pkt_cnt, 0);
 	ilwt->freq.k = freq_k;
 	ilwt->freq.n = freq_n;
@@ -356,6 +367,17 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
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
@@ -408,8 +430,18 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		/* cache only if we don't create a dst reference loop */
-		if (orig_dst->lwtstate != dst->lwtstate) {
+		/* If the destination is the same after transformation (which is
+		 * a valid use case for IOAM), then we don't want to add it to
+		 * the cache in order to avoid a reference loop. Instead, we add
+		 * our fake dst_entry to the cache as a way to detect this case.
+		 * Otherwise, we add the resolved destination to the cache.
+		 */
+		if (orig_dst->lwtstate == dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&ilwt->cache,
+					  &ilwt->null_dst, &fl6.saddr);
+			local_bh_enable();
+		} else {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 			local_bh_enable();
@@ -439,6 +471,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
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


