Return-Path: <netdev+bounces-149154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E69E47AF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ACC1880583
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44319DF98;
	Wed,  4 Dec 2024 22:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830392391AF
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350688; cv=none; b=YHNhUFC3viQIYmr0l+W7FHkfNBvdB5LULeOpWwn41G0r3VbxV3aroCVLVDXD7KogUcFt4MPB6jfOvOJmIZ+fwYSUCs0EHDfKw8cyhhKNTEfR+WzveKIxm7dT14S+WEqTWxdLd71/pH1pvUxPKt4fj+tyLlRqR5M87C7H3npNd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350688; c=relaxed/simple;
	bh=yn5DqhiG3Ge+L5dDqmDdpHasLiCtCkuWSl7fJ6ixU78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9inCJgLV9xG9wxEi81aPh0bOCDfiqxJqZXX2R+fXcIp1rLDKx2PCsNvsMCzrZr0F0iXItFO9i+RAleBFpZg1Cwk8vWKujHqfw+Mu92cMMCFHuL3D2aIbqx4U3QfebS2qIMsyDRzQtGrKjMMub35iKm/W+tZ9eAVxEbNDY6KT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 252635A061D; Wed, 04 Dec 2024 23:12:54 +0100 (CET)
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mike Manning <mvrmanning@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Holzinger <pholzing@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Subject: [PATCH net-next 1/2] datagram: Rehash sockets only if local address changed for their family
Date: Wed,  4 Dec 2024 23:12:53 +0100
Message-ID: <20241204221254.3537932-2-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221254.3537932-1-sbrivio@redhat.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It makes no sense to rehash an IPv4 socket when we change
sk_v6_rcv_saddr, or to rehash an IPv6 socket as inet_rcv_saddr is set:
the secondary hash (including the local address) won't change, because
ipv4_portaddr_hash() and ipv6_portaddr_hash() only take the address
matching the socket family.

Currently, dual-stack AF_INET6 sockets (without IPV6_V6ONLY) are
redundantly rehashed if connect() is issued on them with an IPv4
address: __ip6_datagram_connect() calls __ip4_datagram_connect().
This case can be reproduced with:

  socat UDP6-LISTEN:1337,null-eof STDOUT & { sleep 1; : | socat STDIN UDP4:0:1337,shut-null; }

and, in general, the assumptions __ip4_datagram_connect() <-> AF_INET
__ip6_datagram_connect() <-> AF_INET6 don't necessarily hold.

This is a mere optimisation at the moment, but, in the next patch,
we'll change the rehash operation into an operation that also sets the
receive address, and we want this new operation to be called only with
addresses corresponding to the socket family, for simplicity.

v1:
  - explain in which case sk_family isn't AF_INET, in
    __ip4_datagram_connect() (Willem de Bruijn)
  - rebase onto net-next

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 net/ipv4/datagram.c | 2 +-
 net/ipv6/datagram.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cc6d0bd7b0a9..d52333e921f3 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 		inet->inet_saddr = fl4->saddr;	/* Update source address */
 	if (!inet->inet_rcv_saddr) {
 		inet->inet_rcv_saddr = fl4->saddr;
-		if (sk->sk_prot->rehash)
+		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
 			sk->sk_prot->rehash(sk);
 	}
 	inet->inet_daddr = fl4->daddr;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..5c28a11128c7 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -211,7 +211,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 		    ipv6_mapped_addr_any(&sk->sk_v6_rcv_saddr)) {
 			ipv6_addr_set_v4mapped(inet->inet_rcv_saddr,
 					       &sk->sk_v6_rcv_saddr);
-			if (sk->sk_prot->rehash)
+			if (sk->sk_prot->rehash && sk->sk_family == AF_INET6)
 				sk->sk_prot->rehash(sk);
 		}
 
-- 
2.40.1


