Return-Path: <netdev+bounces-81240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F91886B79
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073731C21A96
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3E3FB1E;
	Fri, 22 Mar 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP9Wq7e7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3D3F9D5
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107994; cv=none; b=AZ8L/dbDBEfhs+yFT3Ub7XyvMx+PUcaSDMzyaRNfYLt70SqQgLGxUlPTwsfgYAot+uJYuCbD69XQsyLX6slyw3i7nWZnKAjpgyMvVfQkhc2AFx8FuGQqWJ2u3GJW+AqnD4uA0XI7Bmqo5CI7TO5UwM1uy6+YcnYTwTBruPg1f6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107994; c=relaxed/simple;
	bh=9AGZg+Pbqwe5RkEz1eQH+VUG1GXVEpPCjOgQ8W1uVY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bViErqxZwWSX+p889XKkdexLj52DNXZY+CAb+WTP9MmhKPTDIv37S4L9da5WV83qMwGQOJF4IJMBeafrQbIrSgzb7NbSZjKqfjtAEN8O9VCSKh32wkIO0MMDtmjNNa8jtwa3LLY2Y9aUlCw43TdEiIlh0W4CNqB8wDO/c08lsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP9Wq7e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C6C433F1;
	Fri, 22 Mar 2024 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107993;
	bh=9AGZg+Pbqwe5RkEz1eQH+VUG1GXVEpPCjOgQ8W1uVY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qP9Wq7e7GlrDVg9hWQ8pcJITvd/9rTkDXgozhRv9fLRHr0gheIRAD6omJ2C6TulQa
	 L7vx/8N79cAKrFXKDbTi7sMBSIQchaBOjYJzBM1ds6DodEqBtXB6UoLgcTZo2IRpjJ
	 MpfuQz40qBfUwn/+HSK48b804EpDQ0CmVZde/+UFmQBq3m87TVxCKzfGYeSNOSnlio
	 a4s4LXg6ikb+080mrELxTWqMpTSNCse50Y6XD6aF10u9nqgs1aENbeTwzAfZp0ftbS
	 oDZjAA8ltjlvo/lBEoaMTWdxOUb1JJm3WLJwXzrUPJY08BqT3EuixKFPcs+PDQhTKI
	 0kTBGM128Q6LQ==
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
Subject: [PATCH net v3 2/4] gro: fix ownership transfer
Date: Fri, 22 Mar 2024 12:46:21 +0100
Message-ID: <20240322114624.160306-3-atenart@kernel.org>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
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


