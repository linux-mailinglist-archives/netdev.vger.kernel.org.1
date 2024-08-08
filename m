Return-Path: <netdev+bounces-117032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04294C6C3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 00:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045CEB2117F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59F15D5A6;
	Thu,  8 Aug 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRtnXEKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4815820F;
	Thu,  8 Aug 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154919; cv=none; b=rIOD4YoQgCBtiinLnIqktKiguXgn+ri9hi/6lJoraDFyz+Rc8POGR6BqSxyGVMM/Ui8qr7yeRvxu8k9DgLWIVGNmaarwc+LlSschafndRk2MYEDESkC2UcjOuwpUymkptHmxR9N9XwtDK7Yh7qN6bE6LuoFrc3TzPT26c9R0uCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154919; c=relaxed/simple;
	bh=G7qcN4kRQFmbzj3pnQMjeYxmwTQfRLd1aXGvHZWLkOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cHug5wYKGtST0m25lOg6I93FanU5pHkE9D3evHklsy/jGHomFgcYOLAbA4de22uVt4bdIsG56X9/5h1UqWYaW9v+C2u5n6FpkG6UYH8W74yKl+TzgMaYflbz03CsfoI68qnZaI/9dWniMlACMB5Rk1Vyp2mkKw8KNT3f2Qb8/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRtnXEKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDDFC32782;
	Thu,  8 Aug 2024 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154918;
	bh=G7qcN4kRQFmbzj3pnQMjeYxmwTQfRLd1aXGvHZWLkOA=;
	h=Date:From:To:Cc:Subject:From;
	b=IRtnXEKJsZqjFPCHC/8osdYGhWIWrJR2RdS/a8cvSQvsV3dr/aMi41TZQp73bitrr
	 nFwZJKSWTlZY5RuTnzi2KGG2e8MMOJjUFhx2HX+kqj0ey1y+0PJidwS56AlqJR2WPt
	 kRV5GO8aqUrFMwscCXBNUv0HqSUY/WNe2QiOgcETwTMXS+7hd8FpE7yBSZH33zLSdZ
	 +lt0WTB+zbzToMgV7nGnIe3z/p4OP0LnU+/NhYHKRJ2RS25ZGP1T+Kwp9ut9tWCpmf
	 MlxzgRxrzSd+ZR5dv25pQVb9Rkyj3BTHbq81NjndkTo33L3OO2hm+VeCRynKOtRYZN
	 Ei739ILUCgNxw==
Date: Thu, 8 Aug 2024 16:08:35 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] nfp: Use static_assert() to check struct sizes
Message-ID: <ZrVB43Hen0H5WQFP@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit d88cabfd9abc ("nfp: Avoid -Wflex-array-member-not-at-end
warnings") introduced tagged `struct nfp_dump_tl_hdr`. We want
to ensure that when new members need to be added to the flexible
structure, they are always included within this tagged struct.

So, we use `static_assert()` to ensure that the memory layout for
both the flexible structure and the tagged struct is the same after
any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
index 2dd37557185e..7276e44a21d0 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
@@ -41,6 +41,8 @@ struct nfp_dump_tl {
 	);
 	char data[];
 };
+static_assert(offsetof(struct nfp_dump_tl, data) == sizeof(struct nfp_dump_tl_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 /* NFP CPP parameters */
 struct nfp_dumpspec_cpp_isl_id {
-- 
2.34.1


