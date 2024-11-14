Return-Path: <netdev+bounces-145078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CDB9C94F5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757DDB222DC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9671ADFE0;
	Thu, 14 Nov 2024 22:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D7199FD0
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621764; cv=none; b=kyHILQYHE4Bmp5/Y6V2W+Mf2iLNq1SfyIcWGKDMzoSTon6A2IVlg6Vh9CYL1MtFOvEshzrR3kzeN6S+z0rPTRH97bUhfyR6BMzmfu2r+LiXCJ9AfAZdCXnxDBV1MqYDyVsNfR0B2bJAOyVKp5Aa0HOb4vsGSKEIeQCJKfscJoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621764; c=relaxed/simple;
	bh=4RSm0R6BAqCcuKmkv3WQWfZG4eAGg3rtYxtL/2pw4+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMcuD0+yeoYDfFIiwcm7JLT9iz+JS0C89ZmaLFq5OSKgS4kRZl9YSscO7g1kq/HlrI7OphA3tj7tk+DoCQXpVaT/Uj9bY0CxqiQ0CN05N6Hdjz5Fx5JZz+lB5nmNs2gODyzk3r+7Q85aVTGjdqEG9tEzGC3KJHF46V+w9VlB4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 412505A0623; Thu, 14 Nov 2024 22:54:14 +0100 (CET)
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Mike Manning <mmanning@vyatta.att-mail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Ed Santiago <santiago@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>
Subject: [PATCH RFC net 1/2] datagram: Rehash sockets only if local address changed for their family
Date: Thu, 14 Nov 2024 22:54:13 +0100
Message-ID: <20241114215414.3357873-2-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114215414.3357873-1-sbrivio@redhat.com>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
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


