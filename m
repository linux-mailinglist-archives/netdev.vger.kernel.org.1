Return-Path: <netdev+bounces-156918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05479A08487
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFB27A172B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A52BAE3;
	Fri, 10 Jan 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jzUAcunZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68E539A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471614; cv=none; b=GebJKhYmggClIKLnMj7Y8Y1P1YT5/MyZIaxNUNxGlIE17+S/3refrKnc8kauO1dzlG8txltdl179awAbuOL1Z7skrpN1P+GnLuAehO8XChCIYIp2VUezKFFwbXZgz/FyxRZ060dYOTO5ubprd2GrJivw3jPTMzZkkT1+I7dQYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471614; c=relaxed/simple;
	bh=3n8BIEV6YLVQVFej9cmRiGS+KBv85jn4iE+4DqRHZLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qodhK0o9bIq694/MkbsmdpnA0EyvKQlaRF0gaoLDntigXbQuSA+mJzpKFNRNfBzzQZNiTqGYymUf7RtPtFDZIIpHgNbtGh5cCdU19YXhoUI3KXvSUGfay0QuunUVqjN7JslEj+5imLyvAeSvWmCHlYmifVlqC2CKYnxBovSQ7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jzUAcunZ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736471607; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fA2WckPk3d9uIQ9L4JwB+512HSZMvzRpDG6dgVhZ7Fs=;
	b=jzUAcunZOMVPP61X4E7XDOknQIs6Dl4b/ABoaJQR6DmIgmCpr9jqxBo+4VaofC2vLA9xQZ0qr2ehGevmVxCwRVRp0PkAuT/mf45Qzja0yyeXaqDWGBfOt3TNRnLca5NeELfsJ3sR6y2+fMwJL7nalKcHfJr0mlrF37rfp3teazQ=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WNItn8M_1736471290 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 09:08:10 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cambda@linux.alibaba.com
Subject: [PATCHv2 net] udp: Make rehash4 independent in udp_lib_rehash()
Date: Fri, 10 Jan 2025 09:08:10 +0800
Message-Id: <20250110010810.107145-1-lulie@linux.alibaba.com>
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
changelogs:
v1 -> v2:
- fix some build errors with CONFIG_BASE_SMALL

v1:
https://lore.kernel.org/r/20250108114321.128249-1-lulie@linux.alibaba.com
---
 net/ipv4/udp.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e8953e88efef9..86d2826185150 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -533,7 +533,7 @@ static struct sock *udp4_lib_lookup4(const struct net *net,
 	return NULL;
 }
 
-/* In hash4, rehash can happen in connect(), where hash4_cnt keeps unchanged. */
+/* udp_rehash4() only checks hslot4, and hash4_cnt is not processed. */
 static void udp_rehash4(struct udp_table *udptable, struct sock *sk,
 			u16 newhash4)
 {
@@ -582,15 +582,13 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
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
@@ -2173,14 +2171,14 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 		struct udp_table *udptable = udp_get_table_prot(sk);
 		struct udp_hslot *hslot, *hslot2, *nhslot2;
 
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
@@ -2199,19 +2197,29 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 				spin_unlock(&nhslot2->lock);
 			}
 
-			if (udp_hashed4(sk)) {
-				udp_rehash4(udptable, sk, newhash4);
+			spin_unlock_bh(&hslot->lock);
+		}
+
+		/* Now process hash4 if necessary:
+		 * (1) update hslot4;
+		 * (2) update hslot2->hash4_cnt.
+		 * Note that hslot2/hslot4 should be checked separately, as
+		 * either of them may change with the other unchanged.
+		 */
+		if (udp_hashed4(sk)) {
+			spin_lock_bh(&hslot->lock);
 
-				if (hslot2 != nhslot2) {
-					spin_lock(&hslot2->lock);
-					udp_hash4_dec(hslot2);
-					spin_unlock(&hslot2->lock);
+			udp_rehash4(udptable, sk, newhash4);
+			if (hslot2 != nhslot2) {
+				spin_lock(&hslot2->lock);
+				udp_hash4_dec(hslot2);
+				spin_unlock(&hslot2->lock);
 
-					spin_lock(&nhslot2->lock);
-					udp_hash4_inc(nhslot2);
-					spin_unlock(&nhslot2->lock);
-				}
+				spin_lock(&nhslot2->lock);
+				udp_hash4_inc(nhslot2);
+				spin_unlock(&nhslot2->lock);
 			}
+
 			spin_unlock_bh(&hslot->lock);
 		}
 	}
-- 
2.32.0.3.g01195cf9f


