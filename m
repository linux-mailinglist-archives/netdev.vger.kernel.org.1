Return-Path: <netdev+bounces-81242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0C886B7B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A9286493
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFED3FB0A;
	Fri, 22 Mar 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRQg4/9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4C3EA83
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107999; cv=none; b=YKuCMUXNpmlL3CE/wwcUdPaJ+vqKJtQcPfGmgKbeqUDS0ZaeXqHZnZhhPr99pTC2KGKcY/TWvtoEVmy9hSrmNzYZsPg95b9GYxrZMpq6I/gfIo5fOjaz0B1mb9Sfw0S0TFfAqxASsHpJVa6lr71kVPQBGHXwjib3UesWVNQyKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107999; c=relaxed/simple;
	bh=lNZ3GsF+2FDIGqDK/pc65J09dJNN1ybvqZZZwXWhNVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn3/mwLYo96xZ/kzOkk8kHYCytSfRWDzrvRJ6cVB6DFpvNQ1by2JCX/wgHZ3XEYvmBzt3PLrkbhuq+CYnDME7Iby/WnUjsOEGhTNkkgdFAFUPRhOB7FhDFtsqdd2mCJvpSGjWe7EU8BK/hvJmHpL7+NYxrsfyHCfXhuwRd96J6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRQg4/9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1929C433F1;
	Fri, 22 Mar 2024 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107999;
	bh=lNZ3GsF+2FDIGqDK/pc65J09dJNN1ybvqZZZwXWhNVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRQg4/9Z7ELjfF+iw/+w0dnGSUh6pJXiPqoreaOK9gttvaRQDQ0gAnUxMupKMjEo+
	 eJU+xRcCYFgpicIfORSxAYW2GWv8XvCHR8Cd27ppHnQ8cP80MfXumel/+w0fSsHC2c
	 /Cf0XM+gDkZJgGbQOj2FdE5xZ2CHCdMAcvVXCgYPeaNxHXRYChK2qj/j0icueL8SM8
	 d9DHw0GMr/nT7j5g3q40Fzrx3dcXagfUGOCQSfYsngjYMzym5aEr2P2TTukrQ8mVRY
	 SQ1Q+omtgk0CEuPKwI+yeWjFrScIqyIvKayQWFaLLWcvVBypuFKNsIJEpc9zyl2+UE
	 doA3LNPWZskRA==
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
Subject: [PATCH net v3 4/4] udp: prevent local UDP tunnel packets from being GROed
Date: Fri, 22 Mar 2024 12:46:23 +0100
Message-ID: <20240322114624.160306-5-atenart@kernel.org>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 548476d78237..3498dd1d0694 100644
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


