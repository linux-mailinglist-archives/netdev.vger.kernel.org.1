Return-Path: <netdev+bounces-219936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8055B43C25
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E423B3AE6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F402FDC3E;
	Thu,  4 Sep 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ1MdWt3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7142FD7C3
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990435; cv=none; b=a6TCBI1tPhkW/M+WdOjSNuhBG92w0IC+yGx+9z74pEMZfF448IYDo0pOeUkqTFF/8H/RcsA/Ewk+RZycYC41X5VXRQAUin0HZwauzekkDYCLA3ex4HPOI5XYxwsDIhwqFKjsZrcP1vmDyQK1jAC3edY22jaS50S8CVefkoraf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990435; c=relaxed/simple;
	bh=0LsGdocjPbXEK7OOjVuYP4rv5m07zGCcQ7LkvU686zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLp00jM2u9BBMWZHrEdLKqyfrCVo8UDy6bFrUaGsdmj02089g9s3sZ0GE0/Hy7RA6RRdMflrNvYmpBe1lAjubBEA2/n+smCuw0QDMnLojJfgTMXXwnFHwk6cUz2io6SVEYTdOfrZp9y7Il9UFniYVzveH3K3N65Qo/hx3n27esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ1MdWt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0B2C4CEF0;
	Thu,  4 Sep 2025 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756990435;
	bh=0LsGdocjPbXEK7OOjVuYP4rv5m07zGCcQ7LkvU686zU=;
	h=From:To:Cc:Subject:Date:From;
	b=nQ1MdWt3WUO2EIZUEPhI1YbAsEAnYVkYlaZpEWJJhWcTrnRkU7nOvzL4Dnfj3tXXO
	 NZsYPMfvMGUuniUXt8+lIyg3v7SObsVyJWZ2U/anhqn00yKtyAdLgby4Z9TF+dr8a+
	 K+G4z/bc54jkEtE1zllMgAOAHQmniNISNcxD1kmIULL2mqG3f8kAlWaMy5fWp+G1j0
	 XH8lI7LMm+31KzsdlqiLvGAuYFz1SGJLoCBSyozYgW+ci89CHfNPLJ1BwAQ3/eCoQv
	 cZZSqZnkMa/2NRmZmud50qWAgCZeN2NHIxsZodNxQkSR2JY0GtZTaQak2uAxAplr8x
	 d1sCeRdEjUWdA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	sbrivio@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH net] tunnels: reset the GSO metadata before reusing the skb
Date: Thu,  4 Sep 2025 14:53:50 +0200
Message-ID: <20250904125351.159740-1-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a GSO skb is sent through a Geneve tunnel and if Geneve options are
added, the split GSO skb might not fit in the MTU anymore and an ICMP
frag needed packet can be generated. In such case the ICMP packet might
go through the segmentation logic (and dropped) later if it reaches a
path were the GSO status is checked and segmentation is required.

This is especially true when an OvS bridge is used with a Geneve tunnel
attached to it. The following set of actions could lead to the ICMP
packet being wrongfully segmented:

1. An skb is constructed by the TCP layer (e.g. gso_type SKB_GSO_TCPV4,
   segs >= 2).

2. The skb hits the OvS bridge where Geneve options are added by an OvS
   action before being sent through the tunnel.

3. When the skb is xmited in the tunnel, the split skb does not fit
   anymore in the MTU and iptunnel_pmtud_build_icmp is called to
   generate an ICMP fragmentation needed packet. This is done by reusing
   the original (GSO!) skb. The GSO metadata is not cleared.

4. The ICMP packet being sent back hits the OvS bridge again and because
   skb_is_gso returns true, it goes through queue_gso_packets...

5. ...where __skb_gso_segment is called. The skb is then dropped.

6. Note that in the above example on re-transmission the skb won't be a
   GSO one as it would be segmented (len > MSS) and the ICMP packet
   should go through.

Fix this by resetting the GSO information before reusing an skb in
iptunnel_pmtud_build_icmp and iptunnel_pmtud_build_icmpv6.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Reported-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index cc9915543637..2e61ac137128 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -206,6 +206,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
@@ -300,6 +303,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
-- 
2.51.0


