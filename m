Return-Path: <netdev+bounces-82005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DC88C0D8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2DA1C25CB2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD780C06;
	Tue, 26 Mar 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUczJQ3K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335B6CDB6
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452858; cv=none; b=AlRXEKZ7T+sZyR4l5eK3DPVmxPYG+Fnhtxd22hdh0V9lGfGrPMu7b43cwcSXFKgVtLJQBAnd1IOLFy9wcyIf4Qj7BxBWzEZLTYvZ+eKadNHXvAtY6neumgvvA2YgNwejFsShXtBXN+66N8Ea2bcWJTGm3dwJTlzhvnQgg5JsyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452858; c=relaxed/simple;
	bh=lNZ3GsF+2FDIGqDK/pc65J09dJNN1ybvqZZZwXWhNVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7E8xEpTR2YjbaphcCMmIah6FcR1YZlf2hXk0Ut1sKq4fcAJcvGpJayI3q8j2NjTNUbKj1lOTgleQGGfSdHap6ffR330Ry437zO+O11yIwGJ7WB/+Sg1dICDutKJ3gRekgwI2m8yK6sUDWkhFZmzZ1+Z+K7t0SGE8sMZKcJXEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUczJQ3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A89C43601;
	Tue, 26 Mar 2024 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452858;
	bh=lNZ3GsF+2FDIGqDK/pc65J09dJNN1ybvqZZZwXWhNVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUczJQ3KZQAH8g5O3nUq/MuoItBMo81KOxqK7O+7oVJO2aArqbkFTTtge0SIJdry0
	 60Ka34ypjGGO8IlqofrWsuckRoKUgnoCjAhlwn/0auygqQLL5x0/EXhht2Q+340eGF
	 jl1j/h8tu2rI1D6vSU0H2K8de2Ac0lssUsuWCWXBt3s25vi6T15vBgvXegCAPXRw5t
	 AeniVmV91tStojlc5TdiFTrwvXITy3lCnILkPScBXqnBku5a28KKXuBAitbvjsHUC/
	 ZjCd2m3iILSGtknNSMLJT72eHESoJmpXznLhkcBX+wXCOdRtunkLeurpxxtmkvVxDb
	 rQhO/XXtJVhig==
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
Subject: [PATCH net v4 4/5] udp: prevent local UDP tunnel packets from being GROed
Date: Tue, 26 Mar 2024 12:34:01 +0100
Message-ID: <20240326113403.397786-5-atenart@kernel.org>
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


