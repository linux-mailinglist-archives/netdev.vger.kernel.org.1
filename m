Return-Path: <netdev+bounces-82004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E606788C0D5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B231C3BDA5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E387E586;
	Tue, 26 Mar 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSGOu0b6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45237641C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452855; cv=none; b=CTEmh59Bk2nKi0KlHTHQyUa7ARTZtIncGfObL5kweMBTSQbPn+LBEpIWPnfgnv4XSlmaLDD72o+rSCbOwrnfVVKpoPuNQKoKIQORem7v+p1u2mGGZIFB2uyopxBWcif63BxamtkutaSse6nRQMNQ4dpVzijXJaiXh4w065NJc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452855; c=relaxed/simple;
	bh=olpSxbuDYHiKY9yUfuosPYFrh40NPdrcXw4pz6WYTX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmaQZ7Hzg0amkBZ78E97KTdq9cfLPxhRuof9Qjuiklqe56BSOlbheRZciUjHQ+2Lw9Afeb2craMSr6SBFpSc2mnVzckJVkONjwq4JFtmdFl6zwWdGorIwjfYAlLxCCsxcq8oToyWyC/5GhlPBbTQ9Zo1IiB3/dRFc7oNxCEScTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSGOu0b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D71C433F1;
	Tue, 26 Mar 2024 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452855;
	bh=olpSxbuDYHiKY9yUfuosPYFrh40NPdrcXw4pz6WYTX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSGOu0b6EoH+HEbOwLoVD0BKZxH8jISjzlDoY4hQJKLIZZ+tizgsBfGMWTtQPDhfA
	 dr/7xJqqjDfo+Qfp7qXp+KPBPFd6TSAgMJ/NRl5O6baDayl6hUaeQbmkgIlR46+Fp+
	 fJ/8PIjcRyQmyZDPCVH/kg655JUG1uXKYbyX5Ybk0FAbh2sK0tZbUB7L6ygTZVkKYz
	 NGQFVC3iwQ5W+hBtacR2iQ2DJR/Vcr0/NVjnd0bOiOiGoawEDx4JyBeOgQhbvZeEML
	 t6MmpnpKCXr3V9lLnb+AIr6MYyRrPk5L09K0IkXw8+neq+D3ExzHNiveOPlHeTbJx0
	 Q4WbpjvRojEtQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v4 3/5] udp: do not transition UDP GRO fraglist partial checksums to unnecessary
Date: Tue, 26 Mar 2024 12:34:00 +0100
Message-ID: <20240326113403.397786-4-atenart@kernel.org>
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

UDP GRO validates checksums and in udp4/6_gro_complete fraglist packets
are converted to CHECKSUM_UNNECESSARY to avoid later checks. However
this is an issue for CHECKSUM_PARTIAL packets as they can be looped in
an egress path and then their partial checksums are not fixed.

Different issues can be observed, from invalid checksum on packets to
traces like:

  gen01: hw csum failure
  skb len=3008 headroom=160 headlen=1376 tailroom=0
  mac=(106,14) net=(120,40) trans=160
  shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
  csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
  hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
  ...

Fix this by only converting CHECKSUM_NONE packets to
CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary. All
other checksum types are kept as-is, including CHECKSUM_COMPLETE as
fraglist packets being segmented back would have their skb->csum valid.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/udp_offload.c | 8 +-------
 net/ipv6/udp_offload.c | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3bb69464930b..548476d78237 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -722,13 +722,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 312bcaeea96f..bbd347de00b4 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -174,13 +174,7 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
+		__skb_incr_checksum_unnecessary(skb);
 
 		return 0;
 	}
-- 
2.44.0


