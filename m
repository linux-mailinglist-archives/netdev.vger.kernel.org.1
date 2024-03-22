Return-Path: <netdev+bounces-81239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA4886B78
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9828642F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A43F9FD;
	Fri, 22 Mar 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcJZfumD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15E224FA
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107990; cv=none; b=rK6odwQ9Vrrt4QSdrSutEynwQfFyucAB8hhy5etoAM1dtTM8Fc+e6MeP/PdCV3VP106MJw4/KTWpVJqtkTi3MVoCS6zoD+yPL0SZ/jJ52VBdftZ0hFOhylcho5dd0hsp9ERCrISvEl9pwwycsj5sij0M9z9TkL+bnxnye1+DvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107990; c=relaxed/simple;
	bh=x4YH3OhXZnwtL2VG55Qju0hX04ZVvudFCYZzBZkH1gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiSkmP4SZ7iOm+X7AfCMBAKwFTKqmmm44COmq5SM2qzr+prVa7SwP1ptN/TX8qalyUKmeGw4CTxkIbvAohLP0ttt+8taEpmJYSjzlgs8StXLa1rB/L8XqekAKvDNRF1qvIN92k0xHw9X52AOmyXlKf6MxlF8Zar6tCnrmA6pBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcJZfumD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2DBC433C7;
	Fri, 22 Mar 2024 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107990;
	bh=x4YH3OhXZnwtL2VG55Qju0hX04ZVvudFCYZzBZkH1gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcJZfumDaW+UlZD8LWeQhxFuW+q+92QXXcxUVFe8adMJs0vxnhnlsWM+2P4be4FU+
	 TbuGGVPmjSZvIChUMfaKawLQZs0D5sF1F3FIwpijgry14rf99FsNEuItg14sG/pGRL
	 0Z6FV1F1vKcIPhQwEo0wmyyDYqjSvHRI8ku/UiMxk/HFvhXu0ShGNzyNUmtfzW/X/i
	 OeVqAaWf9C8lZ0ZHbNiJDlaFfsiSKcuQ99FpqYo83lKM/0ePoUhlHBJ8urZez+81GF
	 4Qqjw5m02/Wpavebq3NWki3TFxHyVpn1ukQ4DGF6Uif6Ad9edOu5oMG7Q+6klS6fgQ
	 EJJcsHoYijQnw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v3 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
Date: Fri, 22 Mar 2024 12:46:20 +0100
Message-ID: <20240322114624.160306-2-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322114624.160306-1-atenart@kernel.org>
References: <20240322114624.160306-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rx-udp-gro-forwarding is enabled UDP packets might be GROed when
being forwarded. If such packets might land in a tunnel this can cause
various issues and udp_gro_receive makes sure this isn't the case by
looking for a matching socket. This is performed in
udp4/6_gro_lookup_skb but only in the current netns. This is an issue
with tunneled packets when the endpoint is in another netns. In such
cases the packets will be GROed at the UDP level, which leads to various
issues later on. The same thing can happen with rx-gro-list.

We saw this with geneve packets being GROed at the UDP level. In such
case gso_size is set; later the packet goes through the geneve rx path,
the geneve header is pulled, the offset are adjusted and frag_list skbs
are not adjusted with regard to geneve. When those skbs hit
skb_fragment, it will misbehave. Different outcomes are possible
depending on what the GROed skbs look like; from corrupted packets to
kernel crashes.

One example is a BUG_ON[1] triggered in skb_segment while processing the
frag_list. Because gso_size is wrong (geneve header was pulled)
skb_segment thinks there is "geneve header size" of data in frag_list,
although it's in fact the next packet. The BUG_ON itself has nothing to
do with the issue. This is only one of the potential issues.

Looking up for a matching socket in udp_gro_receive is fragile: the
lookup could be extended to all netns (not speaking about performances)
but nothing prevents those packets from being modified in between and we
could still not find a matching socket. It's OK to keep the current
logic there as it should cover most cases but we also need to make sure
we handle tunnel packets being GROed too early.

This is done by extending the checks in udp_unexpected_gso: GSO packets
lacking the SKB_GSO_UDP_TUNNEL/_CSUM bits and landing in a tunnel must
be segmented.

[1] kernel BUG at net/core/skbuff.c:4408!
    RIP: 0010:skb_segment+0xd2a/0xf70
    __udp_gso_segment+0xaa/0x560

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/udp.h    | 28 ++++++++++++++++++++++++++++
 net/ipv4/udp.c         |  7 +++++++
 net/ipv4/udp_offload.c |  6 ++++--
 net/ipv6/udp.c         |  2 +-
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b..17539d089666 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -150,6 +150,24 @@ static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
+#if IS_ENABLED(CONFIG_IPV6)
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+#endif
+
+static inline bool udp_encap_needed(void)
+{
+	if (static_branch_unlikely(&udp_encap_needed_key))
+		return true;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (static_branch_unlikely(&udpv6_encap_needed_key))
+		return true;
+#endif
+
+	return false;
+}
+
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
 	if (!skb_is_gso(skb))
@@ -163,6 +181,16 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
 		return true;
 
+	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CSUM bits might still
+	 * land in a tunnel as the socket check in udp_gro_receive cannot be
+	 * foolproof.
+	 */
+	if (udp_encap_needed() &&
+	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
+	    !(skb_shinfo(skb)->gso_type &
+	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
+		return true;
+
 	return false;
 }
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f..c02bf011d4a6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -582,6 +582,13 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 }
 
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
+EXPORT_SYMBOL(udp_encap_needed_key);
+
+#if IS_ENABLED(CONFIG_IPV6)
+DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+EXPORT_SYMBOL(udpv6_encap_needed_key);
+#endif
+
 void udp_encap_enable(void)
 {
 	static_branch_inc(&udp_encap_needed_key);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b9880743765c..e9719afe91cf 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -551,8 +551,10 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	unsigned int off = skb_gro_offset(skb);
 	int flush = 1;
 
-	/* we can do L4 aggregation only if the packet can't land in a tunnel
-	 * otherwise we could corrupt the inner stream
+	/* We can do L4 aggregation only if the packet can't land in a tunnel
+	 * otherwise we could corrupt the inner stream. Detecting such packets
+	 * cannot be foolproof and the aggregation might still happen in some
+	 * cases. Such packets should be caught in udp_unexpected_gso later.
 	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
 	if (!sk || !udp_sk(sk)->gro_receive) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7c1e6469d091..8b1dd7f51249 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -447,7 +447,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	goto try_again;
 }
 
-DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
 void udpv6_encap_enable(void)
 {
 	static_branch_inc(&udpv6_encap_needed_key);
-- 
2.44.0


