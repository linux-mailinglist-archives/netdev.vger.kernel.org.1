Return-Path: <netdev+bounces-228061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42646BC04C9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F84E1714
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AD31E7C23;
	Tue,  7 Oct 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyjVX0Xx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57D273FD;
	Tue,  7 Oct 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759817337; cv=none; b=HqcoRDFze1O8iajtmPazMuZY/XdBAQuB7ashFdLO++IxQYPcWrk8vZBBmqWCKf2FDM6KUdodjt9LmOnU687uJ9ocjsELyQ9M4hId1yrtkvpCJfKQcrK8I310CRWogbrYKzKlwOeKo//u0ABCYQI7SjhonQa7o+TiXd25a2uSh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759817337; c=relaxed/simple;
	bh=vaMq5ngZH7t7l69by25TsKwNJKrKVl7+BNZxPUHPjj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ihRRVkWnjRMzjHDVd7HpY09qOTsqQV/lk7aV2oR/+Lss9YdVF0b4iu/3VcM7BOHNEOMo+dDNIyw4eNNc+znvwRttE3fXsAT2hMD/iHXZULc2YjNcOG4ZxXq02TbG5ZV6DqspReFXC02m0k2FVSm95GyAHXpmGYiYFGk+D79FnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyjVX0Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC33C4CEF1;
	Tue,  7 Oct 2025 06:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759817336;
	bh=vaMq5ngZH7t7l69by25TsKwNJKrKVl7+BNZxPUHPjj0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZyjVX0XxlE/mSqnqQrohIPMQpWmxz2ziDjpM8TQomjM7WfRAb2qVCLiZ3lIDqbSF7
	 /iADAORwxFvxuPQhkBsZcNOFalFFa5LBCt9aZzJgHHJeWvDJLy1fEgTB1TnlQrJ/MO
	 YWEVT4f5i/Vv9bArzcXIOuZs0brrMFhcWy1IwuVcagsZWqLzwTTIagKHdDdFVOnfDL
	 5CLcMpS/ilCs+rzBWYCqM2PAwr3sTKnIRqZpVLHjZ8iopQZn2wdT7Qiqsw2zh2x2DL
	 4IzXXEPZn75Mn9dyGQqxMVQVWLZXbdYwMmUHd5CRo8f4skHbw9HbWnke3J/W6XyOzE
	 yo2fi10p7HI0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8256CCA470;
	Tue,  7 Oct 2025 06:08:56 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 07 Oct 2025 07:08:36 +0100
Subject: [PATCH] net/ip6_tunnel: Prevent perpetual tunnel growth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com>
X-B4-Tracking: v=1; b=H4sIAGOu5GgC/x3MQQrCMBBA0auUWRtMo1brVURk0oxmoE3KTCxC6
 d2NLt/i/xWUhEnh2qwgtLByThXtroEhYnqR4VANzrpTa+3Z8Nw9yjslGk0kDJLzZDz23QUd9sc
 DQi1noSd//tfbvdqjkvGCaYi/V8my4Bh0P6EWEti2L7hx7O2HAAAA
X-Change-ID: 20251007-ip6_tunnel-headroom-ba968a2a943a
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Tom Herbert <tom@herbertland.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Florian Westphal <fw@strlen.de>, Francesco Ruggeri <fruggeri05@gmail.com>, 
 Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759817335; l=3578;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=B0Jlh8RDVwjqLnA0Qj6JzNQbbltz7rJFTIJJo5dDy3w=;
 b=rATwaMJDQEhKExQr2WdFI9D4UGwHdjuQADmB7GCXlGA1fSZX7scBr+wKxxp+SBVqnWDWMGayV
 dmxe/bVYeiOCEJnrZZl4VmXElsVxhZhTZ6YoSRm8u92KskISZQZFRHN
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

From: Dmitry Safonov <dima@arista.com>

Similarly to ipv4 tunnel, ipv6 version updates dev->needed_headroom, too.
While ipv4 tunnel headroom adjustment growth was limited in
commit 5ae1e9922bbd ("net: ip_tunnel: prevent perpetual headroom growth"),
ipv6 tunnel yet increases the headroom without any ceiling.

Reflect ipv4 tunnel headroom adjustment limit on ipv6 version.

Credits to Francesco Ruggeri, who was originally debugging this issue
and wrote local Arista-specific patch and a reproducer.

Fixes: 8eb30be0352d ("ipv6: Create ip6_tnl_xmit")
Cc: Florian Westphal <fw@strlen.de>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/ip_tunnels.h | 15 +++++++++++++++
 net/ipv4/ip_tunnel.c     | 14 --------------
 net/ipv6/ip6_tunnel.c    |  3 +--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 4314a97702eae094f2defc65d914390864c21006..d88532c0fbcd30110e41907722fcaf31ce2e4fda 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -611,6 +611,21 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	static const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 int iptunnel_handle_offloads(struct sk_buff *skb, int gso_type_mask);
 
 static inline int iptunnel_pull_offloads(struct sk_buff *skb)
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index aaeb5d16f0c9a46d90564dc2b6d7fd0a5b33d037..158a30ae7c5f2f1fa39eea7c3d64e36fb5f7551a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -568,20 +568,6 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
-{
-	/* we must cap headroom to some upperlimit, else pskb_expand_head
-	 * will overflow header offsets in skb_headers_offset_update().
-	 */
-	static const unsigned int max_allowed = 512;
-
-	if (headroom > max_allowed)
-		headroom = max_allowed;
-
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-}
-
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 3262e81223dfc859a06b55087d5dac20f43e6c11..6405072050e0ef7521ca1fdddc4a0252e2159d2a 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1257,8 +1257,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
+	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	err = ip6_tnl_encap(skb, t, &proto, fl6);
 	if (err)

---
base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78
change-id: 20251007-ip6_tunnel-headroom-ba968a2a943a

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



