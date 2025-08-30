Return-Path: <netdev+bounces-218524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130EB3D021
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C9D17F952
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB925B2F4;
	Sat, 30 Aug 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAGEgEco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED501EDA0E
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756594547; cv=none; b=Fbe2k+1qLb4A4n5ly/fuNNOL2uc9l1WWlJX1fDus3cfRg8BFJoOGyfQ6jpTKo0NoMBZz+kk60stB7dxWztN9scb/KnYYvLo6Gf2CX5j5ja0dOGB7ZCnQnX2KCj1D6K6wQVqpjav1iyhgadd4ZUBymp6e9ht1V6kpwYnUcZXKkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756594547; c=relaxed/simple;
	bh=fOM9Wb83Asj9nd/xyoaWDHEfPGyHm34FIgXXnEsIIMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gP6yQNXjACd2rnuMsn9jFaE40uXPVECmvhYeDNtvbUrIVB4Z9Dc09F5iiMpLeWkiHoJ7dJfPypYTS+pBH0e+MuWPWG28jFPO+27KjW+zzMc3TWaJgPeOjM7MqwrM9DHxkphYFSQK/lKu44inA3qy0YypRvzh1bG0HfJjgAUb44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAGEgEco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C608BC4CEEB;
	Sat, 30 Aug 2025 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756594546;
	bh=fOM9Wb83Asj9nd/xyoaWDHEfPGyHm34FIgXXnEsIIMw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OAGEgEcoEIsh0IJNS4SMeALuct1aTNCN9TAfzf/6VbN+1w0/9N6LRVO4/rDQHfKZO
	 lFCh8dpkIJwvTKb8tHmAkbbypLrrRKlRBiPSnpz50I52p/EhXLaU33wlaLbMdh1BIP
	 2Dbj4LBzgon2Jt0+qLNSTkXroZCMqwlkcGOjvf0t96VNSnu6IrT22NXryks7KH1UHt
	 5AaNU3IYlqVUXiBTc+d3hu+2xFOY0HdvuIXe+QdnOThIAuxsMG9LQKLSjkHVsniuyF
	 FpiYJ67y+o7EyUru3dTFVL7m08ZfHk9HyQquBaDNlazOAidGUDi64ysgCOYKJW6M7/
	 vVLl52lwckyGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF1CA0FFE;
	Sat, 30 Aug 2025 22:55:46 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 30 Aug 2025 15:55:38 -0700
Subject: [PATCH net] net/tcp: Fix socket memory leak in TCP-AO failure
 handling for IPv6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-tcpao_leak-v1-1-e5878c2c3173@openai.com>
X-B4-Tracking: v=1; b=H4sIAGmBs2gC/x3MSwqAIBRG4a3EHSdoD6i2EhFmv3UpLFQiiPaeN
 PwG5zwU4BmBuuwhj4sDHy5B5RmZVbsFgudkKmRRy6aUIppTH+MOvQlbKhjUrZ5QUQpOD8v3P+v
 JIdLwvh8q01JOYQAAAA==
X-Change-ID: 20250830-tcpao_leak-f31ece59abe4
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Francesco Ruggeri <fruggeri@arista.com>
Cc: netdev@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756594546; l=4109;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=bs8zLk+wSSc+das9LF5n3Y0ftafMIM0Nr9MLDmbxX6g=;
 b=qmFN1mCdYzoSk7RZE1YVj0U+s+kndOFpMCbtY9CzgESdjhV8M7uZKqlECkBvdP2+d70EkGfQy
 ekj8kiyRCokCxcAwWurCCjPvCLnqKc7HxIg5hZeVOAk5LJsGlYgCiaR
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

When tcp_ao_copy_all_matching() fails in tcp_v6_syn_recv_sock() it just
exits the function. This ends up causing a memory-leak:

unreferenced object 0xffff0000281a8200 (size 2496):
  comm "softirq", pid 0, jiffies 4295174684
  hex dump (first 32 bytes):
    7f 00 00 06 7f 00 00 06 00 00 00 00 cb a8 88 13  ................
    0a 00 03 61 00 00 00 00 00 00 00 00 00 00 00 00  ...a............
  backtrace (crc 5ebdbe15):
    kmemleak_alloc+0x44/0xe0
    kmem_cache_alloc_noprof+0x248/0x470
    sk_prot_alloc+0x48/0x120
    sk_clone_lock+0x38/0x3b0
    inet_csk_clone_lock+0x34/0x150
    tcp_create_openreq_child+0x3c/0x4a8
    tcp_v6_syn_recv_sock+0x1c0/0x620
    tcp_check_req+0x588/0x790
    tcp_v6_rcv+0x5d0/0xc18
    ip6_protocol_deliver_rcu+0x2d8/0x4c0
    ip6_input_finish+0x74/0x148
    ip6_input+0x50/0x118
    ip6_sublist_rcv+0x2fc/0x3b0
    ipv6_list_rcv+0x114/0x170
    __netif_receive_skb_list_core+0x16c/0x200
    netif_receive_skb_list_internal+0x1f0/0x2d0

This is because in tcp_v6_syn_recv_sock (and the IPv4 counterpart), when
exiting upon error, inet_csk_prepare_forced_close() and tcp_done() need
to be called. They make sure the newsk will end up being correctly
free'd.

tcp_v4_syn_recv_sock() makes this very clear by having the put_and_exit
label that takes care of things. So, this patch here makes sure
tcp_v4_syn_recv_sock and tcp_v6_syn_recv_sock have similar
error-handling and thus fixes the leak for TCP-AO.

Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/ipv6/tcp_ipv6.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7577e7eb2c97b821826f633a11dd5567dde7b7cb..e885629312a4a7a98df00222b420b646a351868f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1431,17 +1431,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	ireq = inet_rsk(req);
 
 	if (sk_acceptq_is_full(sk))
-		goto out_overflow;
+		goto exit_overflow;
 
 	if (!dst) {
 		dst = inet6_csk_route_req(sk, &fl6, req, IPPROTO_TCP);
 		if (!dst)
-			goto out;
+			goto exit;
 	}
 
 	newsk = tcp_create_openreq_child(sk, req, skb);
 	if (!newsk)
-		goto out_nonewsk;
+		goto exit_nonewsk;
 
 	/*
 	 * No need to charge this sock to the relevant IPv6 refcnt debug socks
@@ -1525,25 +1525,19 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 			const union tcp_md5_addr *addr;
 
 			addr = (union tcp_md5_addr *)&newsk->sk_v6_daddr;
-			if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key)) {
-				inet_csk_prepare_forced_close(newsk);
-				tcp_done(newsk);
-				goto out;
-			}
+			if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key))
+				goto put_and_exit;
 		}
 	}
 #endif
 #ifdef CONFIG_TCP_AO
 	/* Copy over tcp_ao_info if any */
 	if (tcp_ao_copy_all_matching(sk, newsk, req, skb, AF_INET6))
-		goto out; /* OOM */
+		goto put_and_exit; /* OOM */
 #endif
 
-	if (__inet_inherit_port(sk, newsk) < 0) {
-		inet_csk_prepare_forced_close(newsk);
-		tcp_done(newsk);
-		goto out;
-	}
+	if (__inet_inherit_port(sk, newsk) < 0)
+		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
 				       &found_dup_sk);
 	if (*own_req) {
@@ -1570,13 +1564,17 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	return newsk;
 
-out_overflow:
+exit_overflow:
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENOVERFLOWS);
-out_nonewsk:
+exit_nonewsk:
 	dst_release(dst);
-out:
+exit:
 	tcp_listendrop(sk);
 	return NULL;
+put_and_exit:
+	inet_csk_prepare_forced_close(newsk);
+	tcp_done(newsk);
+	goto exit;
 }
 
 INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,

---
base-commit: 788bc43d8330511af433bf282021a8fecb6b9009
change-id: 20250830-tcpao_leak-f31ece59abe4

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



