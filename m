Return-Path: <netdev+bounces-80100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33D87D005
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E23C1C20A83
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE503D55F;
	Fri, 15 Mar 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiLuFzwt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93133D55D
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515848; cv=none; b=HEhIxumjN5OJ4nFUT7731RsIgRTRYwng5f79iz10TAhBqVXfChn/xW8EotXB35l+3iVCtK8zeQ+rYOM/pv8fa6M2rmX+lqu3wi+a6eloIFx0lUW7SpZcs5XeJ46Jv6o6DCizzDsh1jFjv6bNMnlFXQRLbMQtyKubpOvFIkSCDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515848; c=relaxed/simple;
	bh=1HvF5NrOy50WvjvddMyHqrGPbDlUD72YxOTjbA5cHpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td/fIFoUr8SMV8GGpUkCj0IXh0tykZHv8kOOIq4i4oyT4waubpY7DSTTK2Rx/1z6B9h7/n9LEoCgcjx0LRYK1t/G+EREQqkOyN5QUTXGKGmTNSZGjY1/fkt3K1gqVPJ9YpmoLz9SIY5z690GiDlkgKgenWAWk5Vw8rqiNPnhmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiLuFzwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D532C433C7;
	Fri, 15 Mar 2024 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515848;
	bh=1HvF5NrOy50WvjvddMyHqrGPbDlUD72YxOTjbA5cHpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiLuFzwtyzCLYF+9tMMlXYX2rMBQsmVMYitdj8umUP8Z5RB63eqtWVQ0IZeNCAPOF
	 9/glA/gHcFPfbhVmO2YeXTFQHfzG2gOo9HVeAJe9EQ85q1cEMz6tmRR6ayb9iCi9ib
	 /CzmDqArgns7/FMNmDMbXAmd31Y+LP/MGgJrW7GyJU/WsPKMmTkeIQi3Ze54KpfuKF
	 WK8cwWmH2FWu3ZJhtf9gI9IKo1Gc7G+pF3BD5CxLgqFeybE7e8mBX5Pxt9ncQBSiaK
	 n7lj3SXJg9y3xd4DBavws/2FiRlNvhahusG7/E+Nn111eCLSRwPBwWW8Y3s7oCjlNz
	 ZoBGP51n34aHQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
Date: Fri, 15 Mar 2024 16:17:17 +0100
Message-ID: <20240315151722.119628-2-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315151722.119628-1-atenart@kernel.org>
References: <20240315151722.119628-1-atenart@kernel.org>
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
lacking the SKB_GSO_UDP_TUNNEL/_CUSM bits and landing in a tunnel must
be segmented.

[1] kernel BUG at net/core/skbuff.c:4408!
    RIP: 0010:skb_segment+0xd2a/0xf70
    __udp_gso_segment+0xaa/0x560

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 include/linux/udp.h    | 14 ++++++++++++++
 net/ipv4/udp_offload.c |  6 ++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b..51558d6527f0 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -150,6 +150,9 @@ static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
 	}
 }
 
+DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
+DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+
 static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 {
 	if (!skb_is_gso(skb))
@@ -163,6 +166,17 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
 		return true;
 
+	/* GSO packets lacking the SKB_GSO_UDP_TUNNEL/_CUSM bits might still
+	 * land in a tunnel as the socket check in udp_gro_receive cannot be
+	 * foolproof.
+	 */
+	if ((static_branch_unlikely(&udp_encap_needed_key) ||
+	     static_branch_unlikely(&udpv6_encap_needed_key)) &&
+	    READ_ONCE(udp_sk(sk)->encap_rcv) &&
+	    !(skb_shinfo(skb)->gso_type &
+	      (SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM)))
+		return true;
+
 	return false;
 }
 
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
-- 
2.44.0


