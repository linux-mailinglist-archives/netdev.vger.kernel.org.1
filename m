Return-Path: <netdev+bounces-165305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC498A31870
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4341681D8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E01268FD4;
	Tue, 11 Feb 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="H5ZZ8lEI"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264E1E47AE
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312201; cv=none; b=bWEs6c9S1AOBBUhCSfIcElmW23ViHOyeK612ocsFUyInFIMuC7AR6dZSaYrylTYxCdxf9QUovz5ULo3vk9XalBSwt+IAXB+Nhuk+yRxSVX7/aOQaQLz7wRCm2chRRUH5eAGEpkEQQOWzhx5G0rT8pA2fhX5YFp0n8Z+0KvJkosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312201; c=relaxed/simple;
	bh=9JHJaIdsXAdDxWQtmKJRn9kL61j/0LuF/kezCwF1byU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJmoRIxzxVvLcVmYZ0vESAssC4eOqHNWuGfpCbmtLBTTu67Qff3Ubg6gdhkToBRRhyIeQ3oGrT447m1Gi8CpWe9LMm90m27Vph5GEB+ubw5D5a6r4z4hG7NbsYEA+vHNWtN8mLnfTfKcv4ZTzLoDpeGDdIrF088DJwnzjeV1Bvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=H5ZZ8lEI; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [10.29.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 04114200DB96;
	Tue, 11 Feb 2025 23:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 04114200DB96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739312191;
	bh=8kLBLlSSPt2RoH3VnD8FbHRK4BZNw7glNyWgi3zOQ7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5ZZ8lEIzL7jUaOt9hlMjNAXo3tY6gCWbofUG5jP/2hwoNrvbMRaw40kkrvDsK8hs
	 e32mBjFlcKaYdTMtRIBnNFowcbq/P03XcaHVmjeXXYhhTErj2ILFcYnm3zTA2LGkJU
	 mW8W24DUuCVXAUe2wMzroAfJM4I8JnwJ8YXz6j/YjKncZgQ807CdxtSwfJeBUaoYM6
	 rNS4zDGets5HaH+TQ3Ikdpqd1BByTPDT4ovxPBlUT4951RMrrUZgj5t0YJvc4LMAmg
	 bCz7EVFuE5zN1ikdp2kd1MOwn0x0Gmn5L7SzaJzaFs3kLIjbYwVPY/6Mm22hVgUSX6
	 1B8AvaG7EMklg==
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
	David Lebrun <dlebrun@google.com>
Subject: [PATCH net v2 1/3] net: ipv6: fix dst ref loops on input in rpl and seg6 lwtunnels
Date: Tue, 11 Feb 2025 23:16:22 +0100
Message-Id: <20250211221624.18435-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211221624.18435-1-justin.iurman@uliege.be>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to commit 92191dd10730 ("net: ipv6: fix dst ref loops in
rpl, seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
if the packet destination did not change, we may end up recording a
reference to the lwtunnel in its own cache, and the lwtunnel state will
never be freed).

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Aring <alex.aring@gmail.com>
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


