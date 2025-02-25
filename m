Return-Path: <netdev+bounces-169558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68952A4495D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9B17AA30
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CC20C490;
	Tue, 25 Feb 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="NlVZpcqH"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44021DD889
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506395; cv=none; b=KM7qlfKODRqVaHS5emSzWRBpjkmlHloxf0B/6I/7Y5/FZr9KkA+RLuNZ3wvDrlaulxHFzgrowc4WX0NGQgB2329UTO7jjZU3Z1PkFTFGmqfnpSgWmwtTLUYcvJbY/BKHNcIa9Woo7/yBvhjAF2wQ5gI5sIxtKqcyQ9zGhEBq48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506395; c=relaxed/simple;
	bh=Zigg86Ga/cY2gJYz6PULeGq/p6Qti1VOVhB06Zs+CIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nI/dA6uzEykcbSfdhNPzos5NqfFQl5sizxFnxV6NhQZ7V60xeO8WydUI1x57v5aLKUV82Gr77p/TH+OssABJmr3375g/7wS9TKSw6+lUzo9+pvefV4jXbRr4AmsJFXTNI2bCX2e77bAQv0Kyp/xlqsL7GWR0JxcmuOQPx7MDFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=NlVZpcqH; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 9DD222061C44;
	Tue, 25 Feb 2025 18:51:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 9DD222061C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1740505907;
	bh=ArB5PZuVr7Y5+tENgby8Pet4p9AuHf2FFY4zbpjUVIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlVZpcqHw/hzsOdSy5FsPknhCh450H/JZHiYN/HkSZTkX/9W/GyMHDoUkRfCtP8rZ
	 PZmlox/kQBXVdI2IYORQNE/zdB2/K72dgQQ4GVp1uw2HA7BUsY2l3Sl3YVubRdrKGz
	 37f42aPYmbVqHCnWLmzI9n61zEWN9GDNgfekAudZK6laS739dBWNb8iGQSgu0kos3L
	 0gSzMujbzdgCuDYy0f37jwcdiwRubBI3msq7LLOUDvMUgJSt+DSHH5hQaBA6NyRbqe
	 A/CZ4yLqqvjjHumLmIlwK05kVtMgyjBM/ddRXQ8fWgMWfLX1nCbUsasyQZEvzBymLH
	 n0tniS//qJT1Q==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <alex.aring@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3 2/2] net: ipv6: fix dst ref loop on input in rpl lwt
Date: Tue, 25 Feb 2025 18:51:39 +0100
Message-Id: <20250225175139.25239-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225175139.25239-1-justin.iurman@uliege.be>
References: <20250225175139.25239-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a dst ref loop on input in rpl_iptunnel.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/rpl_iptunnel.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 0ac4283acdf2..7c05ac846646 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -262,10 +262,18 @@ static int rpl_input(struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
+
+	rlwt = rpl_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
@@ -280,7 +288,9 @@ static int rpl_input(struct sk_buff *skb)
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-- 
2.34.1


