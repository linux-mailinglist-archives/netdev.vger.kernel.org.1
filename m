Return-Path: <netdev+bounces-81241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA918886B7A
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A626F2864D1
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D23F9F5;
	Fri, 22 Mar 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZQK5mXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB23F9E4
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107996; cv=none; b=kM4NDWnDPN10r1+q/AVbu7NJ9boNOvmYVVTgHDjjLwmjmNnkTk6Iwn/xC5G3KBL5fIYj/RSiYRc8Ms11K74mTUrmr6i2r27kloQano6UTJK4MfhEKHBWCWMA34jFhmHETWqqE+8lEBYydfuWcGB23MQV4dPJyfAOPSO1mcq3fUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107996; c=relaxed/simple;
	bh=MpxNCWYDdPoEhBAvl91XieIM9R6eDIeYvHrj2xd0Y3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxE1Vbd5Gczv2rPY3UGjj5xKwOCClJyyj4DrasmWYgufph0AnuqJT/vB71noMGPW43hXUO4e55h/XNTi1E8D7uVAd79EIRUCvYMES6vXN8LEzCwiUqTrQ2FTjyRUDQaSOg0sL0zgMT2+rPczgZDPLKgwLbk2V67InMHVEKNeupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZQK5mXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6B7C433F1;
	Fri, 22 Mar 2024 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107996;
	bh=MpxNCWYDdPoEhBAvl91XieIM9R6eDIeYvHrj2xd0Y3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZQK5mXo3asX4/+7FOLoj/HwqP7PZpiNk31/q05xWjJouG1IgMMQDf3P3FwjBB189
	 dqNKxtH406RKW+OQ/FQdOzE0kkfk9kUjrHkWJFTLHIKynyH8zyb/6BK3CkwKGPISm9
	 uafH/F73qujY/OalxVnuh+fj26Wau2y4DNqwiJ0/+8Lye763TZJT1vsIyVissO1Nl7
	 2N+VdixdeJbwLQgLdTdrH67+QNuyB78BPM+xeBAhY1HtlvmgiKZFPzWJ3jZCSPN61q
	 sIfQDesShMddqoGrufY00plaKxN7mhhrjENvplu3bKugbQWItuC4kyWxy3wgW/0hyI
	 E9+ndMLZdwUqQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3 3/4] udp: do not transition UDP GRO fraglist partial checksums to unnecessary
Date: Fri, 22 Mar 2024 12:46:22 +0100
Message-ID: <20240322114624.160306-4-atenart@kernel.org>
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
CHECKSUM_UNNECESSARY by reusing __skb_incr_checksum_unnecessary.

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


