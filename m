Return-Path: <netdev+bounces-169557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D0A4495B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7A4189A5B8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CAD20C47C;
	Tue, 25 Feb 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="tg3vqDng"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45221DDC1A
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506395; cv=none; b=V/OafHT3R9TpLSRp4hLiYoaNCrHcT9YWc6gwmC2TuhCK+6B9pN77nZDGvyM7p/9QkNs9mmJLhsqAxQ3zSnNwD+KzWAEZ+sWTkPnNth3sF52ci5BoYVepEbO3upqi2PcoeRAUxu5+4xkFiBh+JHLUaxy0EC55yIcSuEL+K1rpD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506395; c=relaxed/simple;
	bh=BTo1Uo/janfGowoRh9wLWNFctFGQEatfEr3rs2w8pQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pps4XmyFWZHDjGVk90q0PjNEVbTStqmNVLa9Dyq71hF8hkiPVLeQy6UfK1UzWFbDLw6C6CcaZ2rtTf0yEWmaLg08rafKwa9JjCee8fsky8/ozCLXSlfvs/pUf8icNlPhoQCweyvKOJqH3URxyP/5NHPcACpzc2ZDVLTRyTB16Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=tg3vqDng; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 666652061C40;
	Tue, 25 Feb 2025 18:51:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 666652061C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1740505907;
	bh=hEQ4CIWNsVWBXd/pRVC7xRzrQ2ZWkht2NBhWtqlQz3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tg3vqDngftmoK0yd84iXqLQ75jToubkMkZsy1aKDCS3qbQ67eaOfJ7fz662aEQZoj
	 A1Kwx+kHIOgYNQvtArPgAFroqUd1zhcM5vEv98Hu5IYrrWQM2TedYV/DXt3oF+MdTN
	 URGcfUt4F0gBNHPb+2B8eHuFBmt0p+JR83IsCWofr70+a3BR7vB+L5G+iFJmQobWds
	 9ReKBeaRGTn48EZTIf+7dWhBUqShvNPEf2d7f2ZtKkGjaP9KP/w6CBL0ORlKkJqepJ
	 1ogtdK6xAKjfsDZwCEpA/IB59lM24wahXQKEihyBbQBb1kjSEnnItWZTk/+kiHjV4b
	 1qNZmbMYPsYPA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	David Lebrun <dlebrun@google.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3 1/2] net: ipv6: fix dst ref loop on input in seg6 lwt
Date: Tue, 25 Feb 2025 18:51:38 +0100
Message-Id: <20250225175139.25239-2-justin.iurman@uliege.be>
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

Prevent a dst ref loop on input in seg6_iptunnel.

Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
Cc: David Lebrun <dlebrun@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/seg6_iptunnel.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 33833b2064c0..51583461ae29 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -472,10 +472,18 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
+
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
@@ -490,7 +498,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-- 
2.34.1


