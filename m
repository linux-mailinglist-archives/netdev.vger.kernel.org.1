Return-Path: <netdev+bounces-115014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB94944E2B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9914828431E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37961A57E8;
	Thu,  1 Aug 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n739wqvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DC1A4885
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522960; cv=none; b=S9yRPGFWXX1nw8ey6aEVwa3Jr1//MzyMwc15YlTCndsvKKjT5BxXlUhiJWomzZxyZ4DoMQXM2H7obpxgWDMQU9X7FBsxyHYawokrO6SznBG56S49FC5bPe88wZMkpCDpXhryBth/XJVKXCyPpwSC6FxJP5UOK5+8ueWG7GwjCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522960; c=relaxed/simple;
	bh=0J7qgF3J/Fu2KCiXu2zERepCTnGXd9JVJxEDHx0sl0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS4NoS6/m5j8PKsakLlPFuUK9xJcLUprSdD0524fvdoK9RedCIUe4C58TrK+X089TLU1VeoujQKnSZy0GC+yRpIeaSNeAXdtaZTwWhxMUE5s7YN9PS8f5vqwdC1Ddf2nce8lw5Scn10HzYGpj1vpgDNFeMGW/mZnpGIvb9aAGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n739wqvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C86C32786;
	Thu,  1 Aug 2024 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522960;
	bh=0J7qgF3J/Fu2KCiXu2zERepCTnGXd9JVJxEDHx0sl0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n739wqvlFLTS8ibT4Add4Tsv0hQH0YvlV5q42u9xjVEafKhwMkDnAGDfocbs7111S
	 qBriEocVjnigEKmsBMDD8jxC61Rs1gaGE/9BCxhJrIqosL7JgjRSRqKhu1nVMACE4+
	 ZE/7Efz7PcxS1b6YBSazFkAmJ2Z8hLTUtzq905K7pNzXkFGyNQIFyEOoGku+m2aXCU
	 r46oNwbUDSngVOUcjk0XMkrAqRgrBhZFGg0tP47ZMeUXgzDaRYTwbBp0zIDRgY4IW5
	 obt+B1M4NXL2ZowqQZHnRB+6QICVI0OrHTV1BseKB1Qj+MVdMoKW6vzf2ZjnAitB/X
	 zc90E3av9w2fQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH v2 net-next 7/8] net: airoha: Start all qdma NAPIs in airoha_probe()
Date: Thu,  1 Aug 2024 16:35:09 +0200
Message-ID: <b51cf69c94d8cbc81e0a0b35587f024d01e6d9c0.1722522582.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722522582.git.lorenzo@kernel.org>
References: <cover.1722522582.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preliminary patch to support multi-QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 5286afbc6f3f..13c72ab6d87a 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2121,9 +2121,8 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_qdma_start_napi(struct airoha_eth *eth)
+static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
@@ -2692,7 +2691,9 @@ static int airoha_probe(struct platform_device *pdev)
 	if (err)
 		goto error;
 
-	airoha_qdma_start_napi(eth);
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_start_napi(&eth->qdma[i]);
+
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
-- 
2.45.2


