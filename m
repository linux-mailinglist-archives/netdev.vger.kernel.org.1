Return-Path: <netdev+bounces-39626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF437C02D2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98148281B6E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73338DDF;
	Tue, 10 Oct 2023 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdgoqcT9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB732FE22
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D26C433C9;
	Tue, 10 Oct 2023 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696959416;
	bh=ut0fzzErI+LfTl+C/2QItyy1/8GN3DFsFNX195CgFXs=;
	h=From:To:Cc:Subject:Date:From;
	b=mdgoqcT9dXpenJpXp3Sgj/eaK6glheTGk0YCVnZpFFGbMZ9Y6EXU4R0uYqqUmbmGB
	 c6ZRyrMjVTR3bn5/2cgfP1+moiXbifLDOYYMDYt7E8CtMVnzv1oTX9c7/GzU9On2mb
	 fJjeFUVxfdsmdUppN3DsXqnnXXxg3WcX5J9GSyNy3MieXPjTrxnIlDU9Y8ixeyEqqF
	 12t7I+SwJ44rAbo7BfhotuUliHHXrXPYltTvMovXJFnWGAXwQ867tUTutfWgF+Hljx
	 pnYkpxL/gvFVn4ttjaKGnEwWjJNtmv3lciU+x3TNdYwzgpmYskoz5z3aZBvLGbyEAP
	 Bm8R2FnBgSBAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	clm@fb.com,
	osandov@osandov.com
Subject: [PATCH net] net: tcp: fix crashes trying to free half-baked MTU probes
Date: Tue, 10 Oct 2023 10:36:51 -0700
Message-ID: <20231010173651.3990234-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_stream_alloc_skb() initializes the skb to use tcp_tsorted_anchor
which is a union with the destructor. We need to clean that
TCP-iness up before freeing.

Fixes: 736013292e3c ("tcp: let tcp_mtu_probe() build headless packets")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Thanks to Chris Mason for debug help and Omar Sandoval for
amazing drgn skills and analysis which make all bugs look
obvious :)
---
CC: dsahern@kernel.org
CC: clm@fb.com
CC: osandov@osandov.com
---
 net/ipv4/tcp_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f207712eece1..d5961a82a9e8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2449,6 +2449,7 @@ static int tcp_mtu_probe(struct sock *sk)
 
 	/* build the payload, and be prepared to abort if this fails. */
 	if (tcp_clone_payload(sk, nskb, probe_size)) {
+		tcp_skb_tsorted_anchor_cleanup(nskb);
 		consume_skb(nskb);
 		return -1;
 	}
-- 
2.41.0


