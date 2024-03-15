Return-Path: <netdev+bounces-80102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FF87D007
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77001F2247F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9153D54D;
	Fri, 15 Mar 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay2VLpBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22A3D3B7
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515855; cv=none; b=DqDqb0xjq0J+sIa2QQFjUm2WCexjT5BTwGwmeeEhxXi0dobj74E4mwtYIzIxcwHQvEkqASGoDw1Tk7cirYSIZTQkngy2+V5Ox/hNbnJAd0D4MC1W/9PnGOqpp+jglkuqxpNrMZS9BQWF9DPXTIBnRJO9FNJWx0qiQV8j6QHPaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515855; c=relaxed/simple;
	bh=o35t/04LWDC93+XbKVJyrV9DTCIG9cG4uP9jHW9xk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toSUjJMbvHn2xGWFLgfOonPMqhIPLGYko8LPmGHDCslg+eFKzcSE88mBzRilZNJvRHtMVJcXKYGmb3eEcoRifYCxF8yHplj/qh+1RTByGRfcZpCGzCSWjOS7Nw/m77fAy8j158gpOvbVJdKEkTFEhcCVKwMzclBm7o1Lxcl66I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay2VLpBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D432C433F1;
	Fri, 15 Mar 2024 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515854;
	bh=o35t/04LWDC93+XbKVJyrV9DTCIG9cG4uP9jHW9xk0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ay2VLpBjcz2G5wrriN37ybJWuGmlvY9+zYY0oI+nT+TBWn8Bj85oGQla1h9czK94M
	 Tfgc36B6c3bCcWd3UxKFtlpBnR2QhOi6gLdU/GphT6yey+fTNy42asrXZmSwxUyk2j
	 4HSdV8RXxz3/D3F3KUex3BOcWnobgH/fSfpnRuLu91pcQouH0TK2OTq8TXSXdvEpJo
	 fLSy7vkvN4H3kCfdwyOc18BhnAr8d3kTAZ4As1HlYbQN1kA2YqGqKphrIyXpZIGrni
	 /6rc7a2v+/v/y5Gzj4ZC/3KMh7nWWj5OE5SbR/IZtoMXMDWsahMjHV5hAlPDZ+Sl84
	 Tt9w+3cMJiXNA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH net 3/4] udp: do not transition UDP fraglist to unnecessary checksum
Date: Fri, 15 Mar 2024 16:17:19 +0100
Message-ID: <20240315151722.119628-4-atenart@kernel.org>
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

udp4/6_gro_complete transition fraglist packets to CHECKSUM_UNNECESSARY
and sets their checksum level based on if the packet is recognized to be
a tunneled one. However there is no safe way to detect a packet is a
tunneled one and in case such packet is GROed at the UDP level, setting
a wrong checksum level will lead to later errors. For example if those
packets are forwarded to the Tx path they could produce the following
dump:

  gen01: hw csum failure
  skb len=3008 headroom=160 headlen=1376 tailroom=0
  mac=(106,14) net=(120,40) trans=160
  shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
  csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
  hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
  ...

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/udp_offload.c | 8 --------
 net/ipv6/udp_offload.c | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3bb69464930b..3263ebcaa3f4 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -722,14 +722,6 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
-
 		return 0;
 	}
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 312bcaeea96f..9289384cb7d0 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -174,14 +174,6 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 
-		if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-			if (skb->csum_level < SKB_MAX_CSUM_LEVEL)
-				skb->csum_level++;
-		} else {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = 0;
-		}
-
 		return 0;
 	}
 
-- 
2.44.0


