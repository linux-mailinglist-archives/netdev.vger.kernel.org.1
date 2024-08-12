Return-Path: <netdev+bounces-117674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CBF94EBBF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983BB1C20627
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40E170A0F;
	Mon, 12 Aug 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty08APGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD461586C0
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461857; cv=none; b=pHg2cwmvObyQXehiqjEejJ+Yv66ik/BII/BjbdnV8efDTC/myppPQlygZsbFRfGGhC/6BEiLQQwWWRfWODsfk56C2CgFL53/U5fFaoPQkBlcO1i/lj5+KrkWg1MnsNqo/yLRfEQ3VIx9jBqAbSNixZmAfyLnKW6IvhPCLPh9pc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461857; c=relaxed/simple;
	bh=VffN4sf34Vkt2YYSGbq35Oce3OI0WUPKSOdexCIkIPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IIHLd82dVS6U/QgL5X7eom2TVm0r0HJkPsDUrT9p2Qr6+0F9SEGKr/EiHjyemVQ5vYKLszG8y9qGwDNer8SlYURBkfpPMJGVzSPb/CN7NmWU0wXUUiOoQUtK8jXcQydk95m3XlqOWVK13PWceoEgGeahdqSPui+qLURXzglisec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty08APGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45997C32782;
	Mon, 12 Aug 2024 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723461857;
	bh=VffN4sf34Vkt2YYSGbq35Oce3OI0WUPKSOdexCIkIPc=;
	h=From:Date:Subject:To:Cc:From;
	b=ty08APGianSZJwSzDIyIFFMVDgrL+Ao/iUB5rtol4XBymPFfs1+HFWNpzoTg8iAWb
	 PpT5Ye2WXPaKQTCe13rXaZVPxmw3yT7xQfX3DYEpfzc6cAHNsrhgbqcsKA4FGgmVUC
	 4pL2aFRmyFIrJkHrImcaQ0cYz4YVPKORyOV6KETQX+ntkKvoG2jgRunbVqBKy4BaeU
	 qI0ma/gCna0CA0hF9wlwKvRjbnNmT/mHtpEYIpXTjAji0SLMtzz7QoJjfCT04ykZyD
	 k9FRQUghi0rwpw6pNUF1oggSpN2Txn/LVwg7MEqQiETzB1MzNCxlVV1xDrZyvxB+Yk
	 oQ8Rla9wbHzwQ==
From: Simon Horman <horms@kernel.org>
Date: Mon, 12 Aug 2024 12:24:13 +0100
Subject: [PATCH net-next] net: mvneta: Use __be16 for l3_proto parameter of
 mvneta_txq_desc_csum()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-mvneta-be16-v1-1-e1ea12234230@kernel.org>
X-B4-Tracking: v=1; b=H4sIANzwuWYC/x2MywqAIBAAfyX23EJqL/qV6GC11h7aQkMC6d+Tj
 gMzkyCQZwowFAk8RQ58SgZVFrDsVjZCXjODrnRd9UrjEYVuizOpFhvVWdfXrdPGQC4uT46f/zZ
 C1lDouWF63w+nxvmfZwAAAA==
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

The value passed as the l3_proto argument of mvneta_txq_desc_csum()
is __be16. And mvneta_txq_desc_csum uses this parameter as a __be16
value. So use __be16 as the type for the parameter, rather than
type with host byte order.

Flagged by Sparse as:

 .../mvneta.c:1796:25: warning: restricted __be16 degrades to integer
 .../mvneta.c:1979:45: warning: incorrect type in argument 2 (different base types)
 .../mvneta.c:1979:45:    expected int l3_proto
 .../mvneta.c:1979:45:    got restricted __be16 [usertype] l3_proto

No functional change intended.
Flagged by Sparse.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 41894834fb53..d72b2d5f96db 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1781,7 +1781,7 @@ static int mvneta_txq_sent_desc_proc(struct mvneta_port *pp,
 }
 
 /* Set TXQ descriptors fields relevant for CSUM calculation */
-static u32 mvneta_txq_desc_csum(int l3_offs, int l3_proto,
+static u32 mvneta_txq_desc_csum(int l3_offs, __be16 l3_proto,
 				int ip_hdr_len, int l4_proto)
 {
 	u32 command;


