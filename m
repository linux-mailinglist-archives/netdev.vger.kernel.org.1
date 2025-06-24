Return-Path: <netdev+bounces-200557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7EAE6185
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A173BB151
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842227E7D2;
	Tue, 24 Jun 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="zlVTveOa"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C026AAB2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758867; cv=none; b=ulawAxRVxlpDbtjyMi/tcc2IfMwSSQe4Ba1nIygUyCsZgZFw8F4MjX3+UxnG8i26KVPGQOkThEpA9d/P3jnVGJ9bGUSU2k4gWAr7f7cCJWFMzagtIGXR8+d4Di0xIVs/A/EE5QPD/+dWsEYr7SYNyqFkVKMYhCqmWuO8UzDK/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758867; c=relaxed/simple;
	bh=tlJRnEEZgM8wikV+kuti8475GoBki3tuqWhJS+hQBU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zw+gbnIn1P7KwNy2wWrWvttzBGxTxlBStz9uXr9uDkkza++/0JPLbKFl44+yTsP8WvM76wodLF8aV87HLTzad4j2tg3sq621qNZlM4YRF6I5cdGCWYye56QLTJJlV7/8XCVbRR3PpR4DTvt83t4cvcLlav1ujG0a14dbd3j4WPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=zlVTveOa; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M9-00AXaU-1A; Tue, 24 Jun 2025 11:54:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=xj6kXLXwTDoVKtPP/s0jXoxPWGgGCda8M6HRmlI59d8=; b=zlVTveOa6g2e6AbnZ/Bi3KaXsP
	31umJe3UG6IY9nTSiU6FIQnAFizcFmuiatruUP09TIBfNobcQOOgv5+nuQk5mknw/6z4sOnYIg+hI
	xWc8k8dt0XIsRndfnA5oOo6JWQVGPXPMmNA7D4mx8G1ihHvmp3oabaxrT8X3qnqiNkFo0h9htCk1j
	Naq+hiIGxC5Wm5Mgj0rIzbGFoz+sXGVsAIncKdl2myq3ZGvuiEHkMGtfLrOq+9hZJTTkjUtA1ajkI
	vOmzxQtlJBuIPGvaySLEWspIG79pedG3Uj+BDAdi8te6yjFxaUsRhAHDma/sVU3FmoG1Rhs/sGUKS
	1JaufY8g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M8-0005ut-N6; Tue, 24 Jun 2025 11:54:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Lm-00FYQf-O5; Tue, 24 Jun 2025 11:53:58 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:53 +0200
Subject: [PATCH net-next 6/7] net: splice: Drop nr_pages_max initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-6-cf641a676d04@rbox.co>
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

splice_pipe_desc::nr_pages_max was initialized unnecessary in commit
41c73a0d44c9 ("net: speedup skb_splice_bits()"). spd_fill_page() compares
spd->nr_pages against a constant MAX_SKB_FRAGS, which makes setting
nr_pages_max redundant.

Remove the assignment. No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Probably the same thing in net/smc/smc_rx.c:smc_rx_splice()?
---
 net/core/skbuff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c381a097aa6e087d1b5934f2d193a896a255bf83..b4f7843430a3f8f84aed387bf41ae761d97687ad 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3188,7 +3188,6 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 	struct splice_pipe_desc spd = {
 		.pages = pages,
 		.partial = partial,
-		.nr_pages_max = MAX_SKB_FRAGS,
 		.ops = &nosteal_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};

-- 
2.49.0


