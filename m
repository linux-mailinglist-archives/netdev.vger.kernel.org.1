Return-Path: <netdev+bounces-156227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E31A05A3A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564B97A05F8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49041F709F;
	Wed,  8 Jan 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AfFeLjWJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D981DE895
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336608; cv=none; b=Urm8jrBLoTRsCyVDgsmHfcKfW1lAMagQizo/XeTBvaPNspcQf7nncyTTn3YJJ7YSP4fCRCQLxB06+HB4DfhlUUFUtbl2R96bNkx7o0HEGK6bvFa/JKjcHjl1EFo+VUtbORNPtokLw8l9OUECO6I1NWdQdmBqf0cGs560wShi1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336608; c=relaxed/simple;
	bh=iRIpSJW20Gz6NxSPrM0f9aGvhsbr2hjaXK+G3wI/bbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQsjUkckfrrZ0k38rOsaIwjKxp5KK+f+TPuW/Wl3V4xjz+JsdR7T/qPAreXcx/g3cT5rQFZe3UasEffq4DHEnPmRQB7wJCCN1NABwoPGEhEOsQwJART6xQvtev1GZb88osANS37HJIbJ/H2KPNRauPqAQXyZ7NJqZ8aJA2TORL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AfFeLjWJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736336603; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tUihrCBUbs90MR45iVRCgHPNMEBzd7WTUsb3kptxmxw=;
	b=AfFeLjWJEw9VdXqS3mJUGThAOUqNOpNO6CYQBNaqYxYRosIjD1f5v7dehXa+uPMzmAhGsYuEfRmgZvxJAtqR452lM9DYcaBDtWNo7SpS3N+4aLXpwTWm3pJSqtZWEawZ3o48tJe3d452mxuO2WT0URowVh6mA9vpnT/8wH9jZZQ=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WNDxSRx_1736336601 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 19:43:22 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net] udp: Make rehash4 independent in udp_lib_rehash()
Date: Wed,  8 Jan 2025 19:43:21 +0800
Message-Id: <20250108114321.128249-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [0], rehash4 could be missed in udp_lib_rehash() when
udp hash4 changes while hash2 doesn't change. This patch fixes this by
moving rehash4 codes out of rehash2 checking, and then rehash2 and
rehash4 are done separately.

By doing this, we no longer need to call rehash4 explicitly in
udp_lib_hash4(), as the rehash callback in __ip4_datagram_connect takes
it. Thus, now udp_lib_hash4() returns directly if the sk is already
hashed.

Note that uhash4 may fail to work under consecutive connect(<dst
address>) calls because rehash() is not called with every connect(). To
overcome this, connect(<AF_UNSPEC>) needs to be called after the next
connect to a new destination.

[0]
https://lore.kernel.org/all/4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com/

Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 net/ipv4/udp.c | 85 +++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e8953e88efef9..154a1bea071b8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -533,30 +533,6 @@ static struct sock *udp4_lib_lookup4(const struct net *net,
 	return NULL;
 }
 
-/* In hash4, rehash can happen in connect(), where hash4_cnt keeps unchanged. */
-static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
-			u16 newhash4)
-{
-	struct udp_hslot *hslot4, *nhslot4;
-
-	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
-	nhslot4 = udp_hashslot4(udptable, newhash4);
-	udp_sk(sk)->udp_lrpa_hash = newhash4;
-
-	if (hslot4 != nhslot4) {
-		spin_lock_bh(&hslot4->lock);
-		hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
-		hslot4->count--;
-		spin_unlock_bh(&hslot4->lock);
-
-		spin_lock_bh(&nhslot4->lock);
-		hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
-					 &nhslot4->nulls_head);
-		nhslot4->count++;
-		spin_unlock_bh(&nhslot4->lock);
-	}
-}
-
 static void udp_unhash4(struct udp_table *udptable, struct sock *sk)
 {
 	struct udp_hslot *hslot2, *hslot4;
@@ -582,15 +558,13 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
 	struct net *net = sock_net(sk);
 	struct udp_table *udptable;
 
-	/* Connected udp socket can re-connect to another remote address,
-	 * so rehash4 is needed.
+	/* Connected udp socket can re-connect to another remote address, which
+	 * will be handled by rehash. Thus no need to redo hash4 here.
 	 */
-	udptable = net->ipv4.udp_table;
-	if (udp_hashed4(sk)) {
-		udp_rehash4(udptable, sk, hash);
+	if (udp_hashed4(sk))
 		return;
-	}
 
+	udptable = net->ipv4.udp_table;
 	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
 	hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 	hslot4 = udp_hashslot4(udptable, hash);
@@ -2170,17 +2144,17 @@ EXPORT_SYMBOL(udp_lib_unhash);
 void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 {
 	if (sk_hashed(sk)) {
+		struct udp_hslot *hslot, *hslot2, *nhslot2, *hslot4, *nhslot4;
 		struct udp_table *udptable = udp_get_table_prot(sk);
-		struct udp_hslot *hslot, *hslot2, *nhslot2;
 
+		hslot = udp_hashslot(udptable, sock_net(sk),
+				     udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 		nhslot2 = udp_hashslot2(udptable, newhash);
 		udp_sk(sk)->udp_portaddr_hash = newhash;
 
 		if (hslot2 != nhslot2 ||
 		    rcu_access_pointer(sk->sk_reuseport_cb)) {
-			hslot = udp_hashslot(udptable, sock_net(sk),
-					     udp_sk(sk)->udp_port_hash);
 			/* we must lock primary chain too */
 			spin_lock_bh(&hslot->lock);
 			if (rcu_access_pointer(sk->sk_reuseport_cb))
@@ -2199,18 +2173,43 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 				spin_unlock(&nhslot2->lock);
 			}
 
-			if (udp_hashed4(sk)) {
-				udp_rehash4(udptable, sk, newhash4);
+			spin_unlock_bh(&hslot->lock);
+		}
 
-				if (hslot2 != nhslot2) {
-					spin_lock(&hslot2->lock);
-					udp_hash4_dec(hslot2);
-					spin_unlock(&hslot2->lock);
+		/* Now process hash4 if necessary:
+		 * (1) update hslot4;
+		 * (2) update hslot2->hash4_cnt.
+		 * Note that hslot2/hslot4 should be checked separately, as
+		 * either of them may change with the other unchanged.
+		 */
+		if (udp_hashed4(sk)) {
+			hslot4 = udp_hashslot4(udptable,
+					       udp_sk(sk)->udp_lrpa_hash);
+			nhslot4 = udp_hashslot4(udptable, newhash4);
+			udp_sk(sk)->udp_lrpa_hash = newhash4;
 
-					spin_lock(&nhslot2->lock);
-					udp_hash4_inc(nhslot2);
-					spin_unlock(&nhslot2->lock);
-				}
+			spin_lock_bh(&hslot->lock);
+			if (hslot4 != nhslot4) {
+				spin_lock(&hslot4->lock);
+				hlist_nulls_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
+				hslot4->count--;
+				spin_unlock(&hslot4->lock);
+
+				spin_lock(&nhslot4->lock);
+				hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
+							 &nhslot4->nulls_head);
+				nhslot4->count++;
+				spin_unlock(&nhslot4->lock);
+			}
+
+			if (hslot2 != nhslot2) {
+				spin_lock(&hslot2->lock);
+				udp_hash4_dec(hslot2);
+				spin_unlock(&hslot2->lock);
+
+				spin_lock(&nhslot2->lock);
+				udp_hash4_inc(nhslot2);
+				spin_unlock(&nhslot2->lock);
 			}
 			spin_unlock_bh(&hslot->lock);
 		}
-- 
2.32.0.3.g01195cf9f


