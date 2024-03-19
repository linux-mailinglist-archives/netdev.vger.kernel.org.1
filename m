Return-Path: <netdev+bounces-80529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE78387FAC1
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EFD282909
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D4A7CF30;
	Tue, 19 Mar 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX22+hmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC7CF07
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840712; cv=none; b=iQCRaJUOB8UJC3mgxNMgIwU7vAgVmc2GBL8Vj7QbEQeUrGGgrEqlU2EdlVCipoqShRqiDHcphxBVMsEeUqfS+hGVLGKnlGUFUdfGpR7bfNyXYNX0Uqp99r3KsnZKi5bMRqSzpWXN6xswycrdmKW+oULAgnIJUYBtGkx8o1jCq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840712; c=relaxed/simple;
	bh=o35t/04LWDC93+XbKVJyrV9DTCIG9cG4uP9jHW9xk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3cz6kPxSho28rwKV5166mfxzdk1zlzLC/pT9wure00aQ72TDetcW7dXiKY/hbV4KitM5aW07PgemxIK9JFvQeL6A1dd27S2YKZ3apAdTflxRIgBn22s1wd137GGbJu4fc3YcjbDs1u3Uiq3ysS+qGN3PhN7m38uQrx6A/Jk8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX22+hmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A8C433C7;
	Tue, 19 Mar 2024 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710840712;
	bh=o35t/04LWDC93+XbKVJyrV9DTCIG9cG4uP9jHW9xk0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kX22+hmM5hDYkZrvQ0Ns2Elerj75aAXXf3WV1/t3CNZ+Ox89RC5RQJ4hT27bVrB3b
	 +DsrLWO3EjMa8UuAGVc0FT/f4qDgN/PmIolgZaubbKZYB0CwyOjXINyax917JiQbzn
	 J7EBqXhIkzUyXqDc6jRdqjAUncmesrPFxyD/5rZHWKoCIusA2HoIMkcAby9Yxkrbxs
	 kcmtqPF5Qx7CvLM7UvTOEhTP+Kscu8Kj4+eAmwfiT78t6v2In0v8N84blZ+76UP+Wf
	 OoE2bVvOe4GVRfnykPRSISns6phT6uX17+S8rGdu/tFlSl5xa4TkT96QWpT1ERHzpx
	 D41j5IDAOQoVg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
Date: Tue, 19 Mar 2024 10:31:38 +0100
Message-ID: <20240319093140.499123-4-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319093140.499123-1-atenart@kernel.org>
References: <20240319093140.499123-1-atenart@kernel.org>
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


