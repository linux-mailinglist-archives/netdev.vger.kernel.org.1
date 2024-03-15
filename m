Return-Path: <netdev+bounces-80103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E687D008
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5361C21BE5
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D43D56A;
	Fri, 15 Mar 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L01c2KtI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979B3D3B7
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515858; cv=none; b=KSNhszTRq5hJcv6B38zwOEaXfeKH7KxIdIaDTc3QkN0fxFdWuw5cTXScDAtvXa5BS3CVX7vXVuVMu+DBI2KTOvonjiauujvEYTPSy2VYqR8v3Xb0RgLMhb5O3DH6qJPIbppL6Zwnkdu4nbdrZAyTV3I6ZboB604E/3nh9j3JGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515858; c=relaxed/simple;
	bh=go1R2ToTinN4grzju22TbQWhnL0nxFJ1qs1x6RpMpZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlnM41InCi+mh0u8YWlPU01EYAlf1fqHsCnsBvVnc9pn9qVTFtvohVFdcEPikAEZ0A9dne3e6SGj43yO+2fQ/Zh+UKgTUGEDRFYjydHM8Zv+Nyvyvqd2HN+sIjKWn+NLRa/cSG1ibTXRv7mrm7Zf5M69tRQDPPcFvYXMBk9QAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L01c2KtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313DBC433C7;
	Fri, 15 Mar 2024 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515857;
	bh=go1R2ToTinN4grzju22TbQWhnL0nxFJ1qs1x6RpMpZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L01c2KtIz1zf6Ums5BkDsOanMNpNXTuCWcvcFMu3D13yH5or9B7zxEsVYwQxmGWuh
	 uIWDOKqRUgxYL6mN6LYlSHcGxMVH3t7AMe/zLpeZM61tmbyYGrxpdQK0Eq9iSHOTL6
	 TuGU8vNWQkusaaw84USyVUvnQD3UkWBsoa0jmB5mQEvp/iGQx1hxNbhIqiBovGLsm0
	 gb5pEg794U0J7jpz7m2VftYhiJJW+qIhk+epeUL9XUiHZkbOuke1RLNm/DNf5hommC
	 urHDVDxUvMhKVRfdQvcUEhQvhXRhFErEmERCSttjJzrIIsOSDUjD3pj5yJQQyM7RUp
	 vEHl3CI+HMFow==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH net 4/4] udp: prevent local UDP tunnel packets from being GROed
Date: Fri, 15 Mar 2024 16:17:20 +0100
Message-ID: <20240315151722.119628-5-atenart@kernel.org>
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

GRO has a fundamental issue with UDP tunnel packets as it can't detect
those in a foolproof way and GRO could happen before they reach the
tunnel endpoint. Previous commits have fixed issues when UDP tunnel
packets come from a remote host, but if those packets are issued locally
they could run into checksum issues.

If the inner packet has a partial checksum the information will be lost
in the GRO logic, either in udp4/6_gro_complete or in
udp_gro_complete_segment and packets will have an invalid checksum when
leaving the host.

Prevent local UDP tunnel packets from ever being GROed at the outer UDP
level.

Due to skb->encapsulation being wrongly used in some drivers this is
actually only preventing UDP tunnel packets with a partial checksum to
be GROed (see iptunnel_handle_offloads) but those were also the packets
triggering issues so in practice this should be sufficient.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/udp_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3263ebcaa3f4..4ea72bd4f6d7 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -559,6 +559,12 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	 */
 	NAPI_GRO_CB(skb)->is_flist = 0;
 	if (!sk || !udp_sk(sk)->gro_receive) {
+		/* If the packet was locally encapsulated in a UDP tunnel that
+		 * wasn't detected above, do not GRO.
+		 */
+		if (skb->encapsulation)
+			goto out;
+
 		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
 			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
 
-- 
2.44.0


