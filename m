Return-Path: <netdev+bounces-42351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EB7CE64B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DB8B20BA4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18D41747;
	Wed, 18 Oct 2023 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGXSAj+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75F4123A;
	Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE9C4339A;
	Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697653443;
	bh=wgF2DRUgasKE34DdDKzqsvEchHtBI9vBd4zl65+aas4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGXSAj+hDhRJ2xW5fbYQtHKdrdPH2NJpj+IKM280SZr8gaG3SMx1BW5XnELvZhu3r
	 RRrGvZAU/+j+FnCNqYVgAJJXGm5nUv/Dc2GIaRjSMKtOcTgARHYcXL8IIUMfzy8TS8
	 utjSM40Nm4A2KBnno6frI6VGGgH+4nskbyUUEDEq/DsQ1WhhGKIuuG+eR6UH43ZI0G
	 fwyMLPiDIigXkzMGm2n4nPcL86KxGwWdE4QPWE79yEjNwnu5wJKj6+L7QyaqX2lyoQ
	 OjtlmADwbXa4ZXK7StjClbds33++twH1u9COGidRGDhn2+Q1iQHtUuP0O50z4FfvkA
	 rzURdCZgx/8UQ==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 18 Oct 2023 11:23:53 -0700
Subject: [PATCH net 2/5] tcp: check mptcp-level constraints for backlog
 coalescing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-send-net-20231018-v1-2-17ecb002e41d@kernel.org>
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Christoph Paasch <cpaasch@apple.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol can acquire the subflow-level socket lock and
cause the tcp backlog usage. When inserting new skbs into the
backlog, the stack will try to coalesce them.

Currently, we have no check in place to ensure that such coalescing
will respect the MPTCP-level DSS, and that may cause data stream
corruption, as reported by Christoph.

Address the issue by adding the relevant admission check for coalescing
in tcp_add_backlog().

Note the issue is not easy to reproduce, as the MPTCP protocol tries
hard to avoid acquiring the subflow-level socket lock.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc06..4167e8a48b60 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1869,6 +1869,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;

-- 
2.41.0


