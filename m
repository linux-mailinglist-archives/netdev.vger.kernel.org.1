Return-Path: <netdev+bounces-197863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC4ADA150
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 10:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48C9188FAD6
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AC2641E3;
	Sun, 15 Jun 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIGHNTHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C42641E2
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749976644; cv=none; b=NtNcWVmgZAyBZgxuuolY4sUT4ENMtkLgsiuB0ryltuQkSLeMxwAkSah75f8J45nczXuVH7Hi0wP9vdcpl+qrdH+9qjdQMluQILQyoY7FzUa6AMKWwipdXbHQCdVOAMLVPtIftmOg9ymxW/QW9sLKSNcUFMSOYEuwCuYzaVuGi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749976644; c=relaxed/simple;
	bh=elF098D0OS/wcuBbtA4frD9WsTW9bNNyp+TTzihxrvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEjz5f/u8s97gB9wDRPD7uDOFA3HSaL/OHaNKi2YFIaZbgJO6hthl4d+5pvfvjwsxWKXWeJApk3jVnsn1k5nFL5aVZ1UQ82vy3YTe+Viwb9JQ0VCsWfjVBI+Mycbkp6YbdRVN8cl4CbN+ddST5U53+OBXMrRYWQTyrcdVw/lGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIGHNTHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CDDC4CEE3;
	Sun, 15 Jun 2025 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749976643;
	bh=elF098D0OS/wcuBbtA4frD9WsTW9bNNyp+TTzihxrvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aIGHNTHa64cn/6DQZsXe1A13+teT+YB5TmgjvQJ7ckj+cP1VrVZ4Lw1DH+Kvu2N7r
	 quuDndtYPwl/VI80MikDQPflkH0xBgK+zmi4ArO05Va9kdcSsEN5t1/UPKJu8xgGa3
	 edHNOocu2c2HUJ+7o2nPA/grsqgoHccHS5liaNROcBMgON94DCDFppsK3iJnc1EWoV
	 jawroQ0OYWpzzUTM3IpX5jmdxvyaRsp4UCqA2vKn3hh+JqR9OLL60f7HUe4RItw4RP
	 TV3ZbcmBwCeC1NOuq5VOSAX+huuOmx5kBIJqd7UcPTBdy13F/WREriIOxy3nEP1mWd
	 PlPfCeaqqCD7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Jun 2025 10:36:19 +0200
Subject: [PATCH net-next 2/2] net: airoha: Differentiate hwfd buffer size
 for QDMA0 and QDMA1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-airoha-hw-num-desc-v1-2-8f88daa4abd7@kernel.org>
References: <20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org>
In-Reply-To: <20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In oreder to reduce the required hwfd buffers queue size for QDMA1,
differentiate hwfd buffer size for QDMA0 and QDMA1 and use 2KB for QDMA0
and 1KB for QDMA1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 1b7fd7ee0cbf3e1f7717110c70e9c5183fdd93d4..bf8eec1c96ebf642150befaa9c12ca02e82a29bb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1068,14 +1068,15 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	int size, index, num_desc = HW_DSCP_NUM;
 	struct airoha_eth *eth = qdma->eth;
 	int id = qdma - &eth->qdma[0];
+	u32 status, buf_size;
 	dma_addr_t dma_addr;
 	const char *name;
-	u32 status;
 
 	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
 	if (!name)
 		return -ENOMEM;
 
+	buf_size = id ? AIROHA_MAX_PACKET_SIZE / 2 : AIROHA_MAX_PACKET_SIZE;
 	index = of_property_match_string(eth->dev->of_node,
 					 "memory-region-names", name);
 	if (index >= 0) {
@@ -1096,9 +1097,9 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		/* Compute the number of hw descriptors according to the
 		 * reserved memory size and the payload buffer size
 		 */
-		num_desc = rmem->size / AIROHA_MAX_PACKET_SIZE;
+		num_desc = rmem->size / buf_size;
 	} else {
-		size = AIROHA_MAX_PACKET_SIZE * num_desc;
+		size = buf_size * num_desc;
 		if (!dmam_alloc_coherent(eth->dev, size, &dma_addr,
 					 GFP_KERNEL))
 			return -ENOMEM;
@@ -1111,9 +1112,10 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
+	/* QDMA0: 2KB. QDMA1: 1KB */
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
-			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
+			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, !!id));
 	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
 	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,

-- 
2.49.0


