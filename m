Return-Path: <netdev+bounces-80101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7B87D006
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F232528469E
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB13D0C1;
	Fri, 15 Mar 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Dq6K08"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214963D0B4
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515852; cv=none; b=pgwAnPR4lN96IiYxSQhtxre+5Y47UcUDKazYhOZrxWEtPSMaCtDOJobPeBys6ZouYprbzvsKtH/v+/ziEQIz40w3pf9uNK5YwnPcz84gGyHJZtg5yMpQf2eeyvFyz0Vh5ljN5II7PUhWQwL4Ia7485tMy5o3rpVmiDKFkgi0ziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515852; c=relaxed/simple;
	bh=q99DKJEWeU3UfVxyI6HLu+ddKQEwRVrE8+HEK5Y6MZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+YFvcSJfUcLuhjo7cr9LmMgecAKXZ03hnyorShPIZZ6BsYL5Q07PjG0drBuznRmEh3vHtw9ynYiDth9kSSIRB1nyxZjk44Ww9ZhEiC43pbZHv7JxafljaLv4I/T1TyJPUYiIadZoNA7JE1Q+0kzu4xB3mfv+NpgYMNIodLjyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Dq6K08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E1FC433C7;
	Fri, 15 Mar 2024 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515851;
	bh=q99DKJEWeU3UfVxyI6HLu+ddKQEwRVrE8+HEK5Y6MZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/Dq6K08dvzxtkHSJ/2o+xcrqQZ3MCpleYAX7clpJA9a6r2Fw5UOzJbo0zPhT8KNd
	 sVnbRXQTFLIeDua/xqO0qEls05vYYUOkuUNLbj/EkPJMiD6RUBiUJHirbQ2rJFQV0F
	 +AfcLLMPU528hV0AZ5XyQiE9pMc3kAdkDJ9TjmTl6WRO8EHiglOeRx10Q9L8hs7qza
	 8knUsPujsOxit2hDqJV9EGevO8SAe+KhKb+DEytYUrp0ViKDFgY12u7J+I1X+tlrCL
	 fR5QxsRsl/+NFzIssqybouy3JRTbT7Fq3do2A/gGYEFF9jhozHph9YhZ4JhRh8sJ3y
	 5lGY0dtx0T/Hg==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH net 2/4] gro: fix ownership transfer
Date: Fri, 15 Mar 2024 16:17:18 +0100
Message-ID: <20240315151722.119628-3-atenart@kernel.org>
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

Issue was found while using rx-gro-list. If fragmented packets are GROed
in skb_gro_receive_list, they might be segmented later on and continue
their journey in the stack. In skb_segment_list those skbs can be reused
as-is. This is an issue as their destructor was removed in
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


