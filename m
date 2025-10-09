Return-Path: <netdev+bounces-228387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A231CBC9AD9
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C32D3E3C20
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0C2EC08A;
	Thu,  9 Oct 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBau8YwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D332EBDC2;
	Thu,  9 Oct 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022149; cv=none; b=BL85v9LSyjq3uChzC0n53N9r8c+VPK+6x1RKVcCTyf6Azu542kwMcf9PIsYs1echgEYghg95D3gBn+JfUVVG39vzdz3+kbbdoGNqsnG+83VlfHNPzElQqbU8mpulznrkZWzyV06nLHC54MIoV/T3ggfnWQV2hV/bzNTEFRciO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022149; c=relaxed/simple;
	bh=JkRJI/zla1OF5Sp6NH/3oLjN4FkNpNy9o9joGPayRkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kahr+4GamuC58ztH4WFkBeD0jKIOfSzf2PsnaudMR5m/XLZTHzRRpG4hWr+xQKH5HAvQ3r7s+psdTIYDdljuTKooU8rnhin6ly2wfJ2V+h0/v82b7dDveWgj/767qPhkPnx9Z7w8m9rdlHR/9vTVWrzmA6t+5/WK9gHiBSYaBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBau8YwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADFA5C4CEE7;
	Thu,  9 Oct 2025 15:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022148;
	bh=JkRJI/zla1OF5Sp6NH/3oLjN4FkNpNy9o9joGPayRkc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CBau8YwA6i9YRs6x9Yz14TRQo0+5rnGvEldECDcsTD8HYQbGMCKw9GMCqbGM8Negu
	 Z1TauATLNFGziVZiWkDiJ2fIoWrO5WiACXrioslKo5URJsLobF6dlZkmO4XK8nFbfd
	 5XBI1zmZaNxdgZ04AzP7/9e/4pLXRTA23VeQ1kJ5Cm+6A6szjTj8jcVA2GNxC+sRsX
	 gRKjll1ZPUMgsYk+XwKAe4b0OdV82cx5Z9mUbe5JYgjiNkTqaPllxqTcn43vD8JN1e
	 FS6imEim597F9VUfiwkoKE7eK//p8k6yYX9sLbs/22OngfBsq76s2WGjs43tap07GW
	 QztFCEKZEU5yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F8CCD183;
	Thu,  9 Oct 2025 15:02:28 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Thu, 09 Oct 2025 16:02:19 +0100
Subject: [PATCH v2] net/ip6_tunnel: Prevent perpetual tunnel growth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-ip6_tunnel-headroom-v2-1-8e4dbd8f7e35@arista.com>
X-B4-Tracking: v=1; b=H4sIAHrO52gC/32OTQ7CIBBGr9KwFi3035X3MI2Z0lFICjRDJZqmd
 5f2AC7fJO99s7KAZDCwa7YywmiC8S6BPGVMaXAv5GZMzGQuK5HnDTdz/VjezuHENcJI3ls+QFe
 3IKErC2DJnAmf5nNU733iAQLygcApvbcWTxGmMVwshAVpN7QJ6fo93ohi9/4vRsEFV0K2TdkWU
 HXyBpQScFbesn7bth9CxeHO2QAAAA==
X-Change-ID: 20251007-ip6_tunnel-headroom-ba968a2a943a
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Tom Herbert <tom@herbertland.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>, Florian Westphal <fw@strlen.de>, 
 Francesco Ruggeri <fruggeri05@gmail.com>, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760022147; l=3753;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=QP0aw6XFbqBaKIxubuBQan+TnP0JhZPSMwD0ZXJHoWo=;
 b=0crxKtxxohvisEkl0rV59JpOcc/F2hdWJB8uSwEG9Z4igHS+nkyOlefV/5yUVqin7dbIzh1x7
 urEgRaoO7PvD1MUrRxcfd3DuhVFsf8qAXrJ8xhFDOG+Qx/UVqgzWV++
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
Changes in v2:
- Drop 'static' for local variable max_allowed (Jakub's nit)
- Link to v1: https://lore.kernel.org/r/20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com
---
 include/net/ip_tunnels.h | 15 +++++++++++++++
 net/ipv4/ip_tunnel.c     | 14 --------------
 net/ipv6/ip6_tunnel.c    |  3 +--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 4314a97702eae094f2defc65d914390864c21006..ecae35512b9b449fa061d96e66eb4533d1816bef 100644
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
+	const unsigned int max_allowed = 512;
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
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20251007-ip6_tunnel-headroom-ba968a2a943a

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



