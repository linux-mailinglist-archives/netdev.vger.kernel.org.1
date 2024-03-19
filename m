Return-Path: <netdev+bounces-80528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82287FAC0
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F771F21D59
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A877D416;
	Tue, 19 Mar 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT215DZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B17CF07
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840710; cv=none; b=bWhWPjSvbPGiPSGkUhk04KKEYOZSIckrbEokJZpUpDVsyebvKMfGVQBGBYHjfuNiCkWi/RwKh/Mou1mazZSbAKXAK5NfSaEn16mnCwiZZI4oaN2Lq5cgwu/+oH86Ierk+5gJan9QRZik5zCY/bQ3v2xlKHd4w9NZ4zQD+n+hOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840710; c=relaxed/simple;
	bh=GQuzUSMgJFKGY+VSFwAV8bBLm4VyTtVUj9T4/0i49fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eq8O2kXAfYA3XBTudHT+oPyUo8opxi2NUhqgrdkgAT3aRiOPm1aVS8aDzzRVbBhWYWcOSc5uced2KexAuCCKwXGQrLZpkPCMH+HLoNbWEFro8x1eeAMzmYACsYZ2R1vKhhpyBxL0+VVu5gRrDMHyynd2Y6ZcMge1pTcp66oljM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT215DZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A704C433F1;
	Tue, 19 Mar 2024 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710840709;
	bh=GQuzUSMgJFKGY+VSFwAV8bBLm4VyTtVUj9T4/0i49fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kT215DZ+ibTbgX26wmy4UfARDKGFDetYOpZ2ozFOvkF8kV3yO973VwLo4kPpMVwcD
	 0nIk5iF9l40mlkVR52QAhvZX3gxPbS+E0jvRipcrU0ct3qooAfkpKjxImW1vpCt+Ae
	 pGq5mia5Z4mUClpYFuWk1FDtVwnewcrOMhcpNjpPeS3AvzYAki4zE2f4jjTePlIS93
	 FxvzvjIBG/zdSRJ5EyJZkuDP+2BqV4GEOUKC50QwBuPZS5ExRctjEboKS1mkqnLmtJ
	 AewKuVyB/fnu81A3u6UM3z0AaWDasS+8Ux4cNfp7m8pjb6Dn6R9IL/AdoNFkEegEWZ
	 lucKMmOoBbggA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2 2/4] gro: fix ownership transfer
Date: Tue, 19 Mar 2024 10:31:37 +0100
Message-ID: <20240319093140.499123-3-atenart@kernel.org>
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

If packets are GROed with fraglist they might be segmented later on and
continue their journey in the stack. In skb_segment_list those skbs can
be reused as-is. This is an issue as their destructor was removed in
skb_gro_receive_list but not the reference to their socket, and then
they can't be orphaned. Fix this by also removing the reference to the
socket.

For example this could be observed,

  kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
  RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
  Call Trace:
   ipv6_list_rcv+0x250/0x3f0
   __netif_receive_skb_list_core+0x49d/0x8f0
   netif_receive_skb_list_internal+0x634/0xd40
   napi_complete_done+0x1d2/0x7d0
   gro_cell_poll+0x118/0x1f0

A similar construction is found in skb_gro_receive, apply the same
change there.

Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock reference")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Since v1:
  - Reworded beginning of the commit msg.

 net/core/gro.c         | 3 ++-
 net/ipv4/udp_offload.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index ee30d4f0c038..83f35d99a682 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -192,8 +192,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	delta_truesize = skb->truesize;
 	if (offset > headlen) {
 		unsigned int eat = offset - headlen;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index e9719afe91cf..3bb69464930b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -449,8 +449,9 @@ static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	NAPI_GRO_CB(p)->count++;
 	p->data_len += skb->len;
 
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
-- 
2.44.0


