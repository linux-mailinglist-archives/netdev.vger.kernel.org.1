Return-Path: <netdev+bounces-169924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBBA467A1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BE43A184C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1982248BA;
	Wed, 26 Feb 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiL9z13G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1321CA1B
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590036; cv=none; b=OOWxIQJ/Dq8uNBomuas9An6d7xS/JCZeihn4p4QC5fullBqpsbioJ8CG9q6DZun9DfoYv/aCMLiWagymIytw9tBvhCOiQ0qCrMZhV89rAe5in2D/nbwp3u6/CGCrCYc2qiVBD4JQZnK2UtoX+6YiwCF9MpQV4XVqqlrFjBoJS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590036; c=relaxed/simple;
	bh=xeFuvmiK6yJyfBkZp/pDcBfAXa39Zzm+f1oT0x6JpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6FLlCYoxTn1aKq7OQz9pocl7FO0gv/APC5FhKM07FEpstkuB/EbJsCp4OAHDHQ6Zr7cbkgn7M2NC+KMZsAtAamThKfaapicldot2l8W+m4IvT2Z1A2q5xdASAEYSm7NpYN/y9Ohk/xugMrPO+TY7bl4KBKBMXlnlEqrFLzK7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiL9z13G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383EFC4CEE9;
	Wed, 26 Feb 2025 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740590035;
	bh=xeFuvmiK6yJyfBkZp/pDcBfAXa39Zzm+f1oT0x6JpPE=;
	h=From:To:Cc:Subject:Date:From;
	b=iiL9z13G01PfsB92Wd7SY5U2YxwCCqdxtg3NpbkEaXM2b9Tsfs/maHZX3QbhOh5H0
	 P8Xc/M2paKIAz/kIrND6SBS7lRtogcgI6Pkqh7psBJ7KRBVyEwRNn4i90mR/OCo6qh
	 kA/uPBEfS/91EiCdhF9Np0eXnCMxgNOMKQe4niyzNUAiq0NXudeBxboPPMVALk3s89
	 uXECX8Dq4aLhICp0EVo5zCGiGoFUKO1dPSvJTaV6dXYZmgL3yjtyiueha9V2mWNRkW
	 4GRQOird31Ff+n5tJ3l7yqFuiJphPgeurVerWgsJjjZPfS1h/PG1jiX1mapW5CFSaX
	 7o8vBrv7zbxnQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	pshelar@ovn.org
Subject: [PATCH net] net: gso: fix ownership in __udp_gso_segment
Date: Wed, 26 Feb 2025 18:13:42 +0100
Message-ID: <20250226171352.258045-1-atenart@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __udp_gso_segment the skb destructor is removed before segmenting the
skb but the socket reference is kept as-is. This is an issue if the
original skb is later orphaned as we can hit the following bug:

  kernel BUG at ./include/linux/skbuff.h:3312!  (skb_orphan)
  RIP: 0010:ip_rcv_core+0x8b2/0xca0
  Call Trace:
   ip_rcv+0xab/0x6e0
   __netif_receive_skb_one_core+0x168/0x1b0
   process_backlog+0x384/0x1100
   __napi_poll.constprop.0+0xa1/0x370
   net_rx_action+0x925/0xe50

The above can happen following a sequence of events when using
OpenVSwitch, when an OVS_ACTION_ATTR_USERSPACE action precedes an
OVS_ACTION_ATTR_OUTPUT action:

1. OVS_ACTION_ATTR_USERSPACE is handled (in do_execute_actions): the skb
   goes through queue_gso_packets and then __udp_gso_segment, where its
   destructor is removed.
2. The segments' data are copied and sent to userspace.
3. OVS_ACTION_ATTR_OUTPUT is handled (in do_execute_actions) and the
   same original skb is sent to its path.
4. If it later hits skb_orphan, we hit the bug.

Fix this by also removing the reference to the socket in
__udp_gso_segment.

Fixes: ad405857b174 ("udp: better wmem accounting on gso")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/udp_offload.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326..ecfca59f31f1 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -321,13 +321,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
-- 
2.48.1


