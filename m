Return-Path: <netdev+bounces-164507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC5A2E044
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E484164805
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B768D1E2613;
	Sun,  9 Feb 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="QgVz8BVc"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EB1E0B73
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130294; cv=none; b=h8BXfXh7lv3f+707vgfmGlB+VeGjwx23KkYfinXlvS26k6WM88LW1cSn20BkhaOgTV/gOO5b9+Vh46tFhjPBLGgxBWViim0pHeJTOJRJGxbDdNH8Ir8S9vuRWWKPRBEm90MRvS66k2kNtDMDCmvueJn9eXfYht+pQJwQ58gRAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130294; c=relaxed/simple;
	bh=nkcqBUFSpYOC8+1KW/7plIBhdHc1vBKyJSHKWDkHXHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKW2wgbcMuvmKcg0jeKeTI50elXU7Ow64gR52huYMfrBQUf8X3YgFthDVxigYnFnwQCmkO/8mZA2IT6o5fUWObdzIHXAnTAVlccR5CkIwP0m43KKW9UF4OEkbzo1E/mXRzMhA5Bfm7IQY6t755K0d8/ENuhB/fzxHc+/BYoI8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=QgVz8BVc; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (lfbn-ncy-1-721-166.w86-216.abo.wanadoo.fr [86.216.56.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 3C1F1200E2B5;
	Sun,  9 Feb 2025 20:39:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 3C1F1200E2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739129975;
	bh=/XYTpL152c1a9qxMGc25FVY8Y43KP5x6gdKY70nEbRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgVz8BVcDZbPaK9ma0CCba3U+vewRqHo1fiE7Gmlm88FI3Xq6Q8koC9OiUGjAFYjA
	 E2lcXJjdo6Ew8iAVnvlgR3ITp7OhWQO45jcu5QcEtdRTTj1rFw4WwRzUyIOgfRjorA
	 lRX3VVwRH/GCAVP6E3KLNyoKp5w07U4FQQHpOzrrMre7TtJ13CSD4QyRTwhErpAnnx
	 GrUzLgryNMfni2eElNU6HHUvnSDahPsyLouDJkC3nnmPu2cU0DGJ9Rpror2OpDDeK0
	 OXE10C3Mgz00/yOWjbNRwEwyQ062X5/1CWBp8Sbt+fg6tNI73duMaCItDnOCM8XGRx
	 /nJSK1y9otAWA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <aahringo@redhat.com>,
	David Lebrun <dlebrun@google.com>
Subject: [PATCH net 1/3] net: ipv6: fix dst ref loops on input in lwtunnels
Date: Sun,  9 Feb 2025 20:38:38 +0100
Message-Id: <20250209193840.20509-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209193840.20509-1-justin.iurman@uliege.be>
References: <20250209193840.20509-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to 92191dd10730 ("net: ipv6: fix dst ref loops in rpl,
seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
if the packet destination did not change, we may end up recording a
reference to the lwtunnel in its own cache, and the lwtunnel state will
never be freed).

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Aring <aahringo@redhat.com>
Cc: David Lebrun <dlebrun@google.com>
---
 net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
 net/ipv6/seg6_iptunnel.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 0ac4283acdf2..c26bf284459f 100644
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
+	/* Get the address of lwtstate now, because "orig_dst" may not be there
+	 * anymore after a call to skb_dst_drop(). Note that ip6_route_input()
+	 * also calls skb_dst_drop(). Below, we compare the address of lwtstate
+	 * to detect loops.
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
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 33833b2064c0..6045e850b4bf 100644
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
+	/* Get the address of lwtstate now, because "orig_dst" may not be there
+	 * anymore after a call to skb_dst_drop(). Note that ip6_route_input()
+	 * also calls skb_dst_drop(). Below, we compare the address of lwtstate
+	 * to detect loops.
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


