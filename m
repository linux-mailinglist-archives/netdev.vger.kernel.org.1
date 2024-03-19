Return-Path: <netdev+bounces-80530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7387FAC2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B72A1C21C07
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B67D06B;
	Tue, 19 Mar 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8wiKyMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13A4594C
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840715; cv=none; b=blUbrLceij7w2w1Aj4n1hmgy0ls1F9CaxUORjNsN19Wp/yf2buWMBpoMv72/gUSqq3VP5Fl22kO5qvqAWh0Zz49yFn0h/skNHRbHLyJAGB2pQMHQuG8juPe++R0cT/+kXfMOiI1CcooxB8xqnwh5N1fRaqEfuWX5glQRQU/mqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840715; c=relaxed/simple;
	bh=4VrvztLs/RejelrR1osyNJscmfSt73/BFJL8lboTMz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ7Tg81SVp3V2g9U2lavmlyoTrmbsTORLBfXd/CYX8ZJ1FqCzoAtmJ0NkscYs6gYuTWKXt7ejByZ1zB5X+4eetypt4Mv8/XPEUpi+dfRR1qGkT8Xz+j8tRkOfySLFJFJCcWDeue4nUmgoFxOnd+Of5pIymawCXexIFDW57yCNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8wiKyMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AECC433F1;
	Tue, 19 Mar 2024 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710840715;
	bh=4VrvztLs/RejelrR1osyNJscmfSt73/BFJL8lboTMz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8wiKyMHHXqqLmqnwsaQIM6sUK3A90m3tDeTJwCFYRSYOBw7BhO4IK9qDLkQycNoU
	 iwdGNw/FVTtdN8aYGYUdY8DjZI4ZfAtdAYCXgbipMr3Lvz9ufHHylq7C7NcvbDOecm
	 qir7Yzjk9SYJV0xPF4pT0jBvlnfm/Jmrk3ehTk3mtunweInm9wGppaVUKV9hsOzhm0
	 Dv23XnfFyj0K7YdJ/s/j3Wt6SaVaX6JCXgKYHViodpvC9iFbViOuDN7almX4z5tkWu
	 AIm+eyqIqo+VodJ36bCH/LHdZDS2Yp6nyC73YCDCHy4PYC7fQRC55T11o3xMhPE419
	 iPAqIqdW1LGoQ==
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
Subject: [PATCH net v2 4/4] udp: prevent local UDP tunnel packets from being GROed
Date: Tue, 19 Mar 2024 10:31:39 +0100
Message-ID: <20240319093140.499123-5-atenart@kernel.org>
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

Since v1:
  - Added Reviewed-by tag.

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


