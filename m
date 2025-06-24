Return-Path: <netdev+bounces-200563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D4AE619E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6A67B4CB2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EB285CAC;
	Tue, 24 Jun 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="WhPFZlcP"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945128F533;
	Tue, 24 Jun 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758881; cv=none; b=ohlDVcoNa+bzOja/kKIJ9A2lp0M0/gPXn5EDa40sYErGclFk4QqTxppYtPjkaboC5ia3QnUUbcKmioRTMv27b/jxcxcyA2W/uVyhvEwGzvr+qe5ig6ZeLWQ7VQ4U79HgJQlf7UERHhZY/wlD/vVGwuT4o/kzC9NIXpjW+2V5FYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758881; c=relaxed/simple;
	bh=Rt3SdjfeRFOWaAIBveiyEHR2/z5Og0yrqZBGpP6Y7Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yf3gO/nTJzrF18yrPkw7UQ5X9nFmIqYerUFKL13lpc4sEN9we7JJ4hNNMeUdnyF29cAJibIh/GRK8ZYThyygoneSgAA2niW0H8AaPxJ/jFbkzOS5QTvQY2jtqKuiw+8lnUmVqMQrIXzhlIeUu5/wsng+UXMxR22yGnfEMWxCDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=WhPFZlcP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MD-00AXbP-Mt; Tue, 24 Jun 2025 11:54:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=yh+wgCONewBgg0HYVBK74vPz+B6SDKm5RD1XJlT5iN0=; b=WhPFZlcP2GPjpQ6zQQYQObfXy7
	dZu8YNKBVdyS++rUUjLZ4rU9bmfVTM/8LWpWSL2ZrGmNmASaGkD1zyCaS7BIBMMjvdtjYjFEemB8g
	iAMadzx45U/ufo7HBDBOiFJxRBkKfTqKOdTWj74lwe6/HUqJ1DRnXuRG11be99uNN32DvbPkr2hfz
	dOQFPloQw1gGTV/+LExNyKC4nhiN42wXGs1F6wcS2Vr5oOFGbuI+jZ+0YkjpFGANewkXhVVUI731y
	ojWmvvMHOx/XNUP5JQu8uBmpAHASchsCgdT/S1/ABcmMmenFPyR5cFf9K4srnyow0hRIUhL6PG0oH
	6k8WXRRw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MD-0002ZW-CH; Tue, 24 Jun 2025 11:54:25 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Lj-00FYQf-B5; Tue, 24 Jun 2025 11:53:55 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:48 +0200
Subject: [PATCH net-next 1/7] net: splice: Drop unused @pipe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-1-cf641a676d04@rbox.co>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
In-Reply-To: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since commit 41c73a0d44c9 ("net: speedup skb_splice_bits()"),
__splice_segment() and spd_fill_page() do not use the @pipe argument. Drop
it.

While adapting the callers, move one line to enforce reverse xmas tree
order.

No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c6a9c53a7c16634cce82a1cd1bbd3..ae0f1aae3c91d914020c64e0703732b9c6cd8511 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3060,10 +3060,8 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 /*
  * Fill page/offset/length into spd, if it can hold more pages.
  */
-static bool spd_fill_page(struct splice_pipe_desc *spd,
-			  struct pipe_inode_info *pipe, struct page *page,
-			  unsigned int *len, unsigned int offset,
-			  bool linear,
+static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
+			  unsigned int *len, unsigned int offset, bool linear,
 			  struct sock *sk)
 {
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
@@ -3091,8 +3089,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 			     unsigned int plen, unsigned int *off,
 			     unsigned int *len,
 			     struct splice_pipe_desc *spd, bool linear,
-			     struct sock *sk,
-			     struct pipe_inode_info *pipe)
+			     struct sock *sk)
 {
 	if (!*len)
 		return true;
@@ -3111,8 +3108,7 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 	do {
 		unsigned int flen = min(*len, plen);
 
-		if (spd_fill_page(spd, pipe, page, &flen, poff,
-				  linear, sk))
+		if (spd_fill_page(spd, page, &flen, poff, linear, sk))
 			return true;
 		poff += flen;
 		plen -= flen;
@@ -3130,8 +3126,8 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			      unsigned int *offset, unsigned int *len,
 			      struct splice_pipe_desc *spd, struct sock *sk)
 {
-	int seg;
 	struct sk_buff *iter;
+	int seg;
 
 	/* map the linear part :
 	 * If skb->head_frag is set, this 'linear' part is backed by a
@@ -3143,7 +3139,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 			     skb_headlen(skb),
 			     offset, len, spd,
 			     skb_head_is_locked(skb),
-			     sk, pipe))
+			     sk))
 		return true;
 
 	/*
@@ -3160,7 +3156,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
 
 		if (__splice_segment(skb_frag_page(f),
 				     skb_frag_off(f), skb_frag_size(f),
-				     offset, len, spd, false, sk, pipe))
+				     offset, len, spd, false, sk))
 			return true;
 	}
 

-- 
2.49.0


