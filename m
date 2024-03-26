Return-Path: <netdev+bounces-82002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2388C0CF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F15B246EA
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800E6BFB8;
	Tue, 26 Mar 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSmF2G9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136146BFB3
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452850; cv=none; b=IA5IU0UWl23gAlVlKdMcjL9oJmpVUatM/wzcy4g05iBSdNNTMQggL+e8hXNeT+rZlnp5tEUglq1RsJ6gs0Lsc2BnlyGxo3Pw0wEBA3yejLCEElHc/ZKiO9a4JDXK9a8Ht91HqEK7nHIm0vGNWp3ipc1i6XpY/MkE2HhsFouUv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452850; c=relaxed/simple;
	bh=x4YH3OhXZnwtL2VG55Qju0hX04ZVvudFCYZzBZkH1gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF8Cztfn5GFucGYa8zxCzQdEE336WIM3LpNpWbS4Byr2aaYciTNW7ktVHvZZaUP8fsK67nXG+OZ0xsNwFWaR5WO14b8O0mpYf0WGPHc5yzRKHmTGvJhCXmaREeAab2MZAc0z8g9znS388oD4U861d8PUIyf5uLkkaDuKHboDjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSmF2G9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430F3C433C7;
	Tue, 26 Mar 2024 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452849;
	bh=x4YH3OhXZnwtL2VG55Qju0hX04ZVvudFCYZzBZkH1gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSmF2G9BiP3gm9s5gd5uarc6RKYeVhUflhmouk90mL2o9zW9QOSjlsDrSK1+P99W+
	 oqTf5xZVZfAlbWyucLUM6gDfMLnPXSczI3ajettxxt1q52Fy43I2aR45MrrG8ye46u
	 h32L8gF5dnRzT7lrbV6e123HkvT7Czi3G+0HO9GXV+2be+yGt4gN4KUDpeabpDtyzC
	 tHSrCOfke7mA5ljrBhi/igKSEUielV7SYMeVF6koTVZepsmZ2NTqlXUDkRxtwvi1Mx
	 RTMWjT/6U/dkTDGhdt1rnLbgfgu/KgYYe/MCPLmFOhc45yOK5HTzL5iZm9NjxXFIs9
	 I8ztLxE82dWzg==
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
Subject: [PATCH net v4 1/5] udp: do not accept non-tunnel GSO skbs landing in a tunnel
Date: Tue, 26 Mar 2024 12:33:58 +0100
Message-ID: <20240326113403.397786-2-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326113403.397786-1-atenart@kernel.org>
References: <20240326113403.397786-1-atenart@kernel.org>
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


