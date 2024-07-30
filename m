Return-Path: <netdev+bounces-114224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED39418A1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778241C20A4F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26F18991E;
	Tue, 30 Jul 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ7FAlHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BD189919
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356610; cv=none; b=D3YLYmiKJ7p7c3oMlcG/H65kdHgSwMNAHpLrIADquue/cA33p8sWKfmtmTyKzwRtc1gPcsGHVrVL7taZrsxHiCJzuGaXjbOSEuSTt1hGPp7dosxE2e701VnqL0Ij1uggpB+px5Kx4LGb8b0EL+Tj/oPiTbx0skI2SbUDKfEOMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356610; c=relaxed/simple;
	bh=3oYoOwjKwwydDncnDQbsW1v26gFUfUI+am7zGLJZOxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhuJseU9pXyJ7qCXMLtcYljOvZuJ43xBW/fhE8pOEvqb+/dffiHsPK+7Y3Eo827bpVx+sh5cCUfI5LJrZJrrst8oFQp0HRjrPLXoGyTkZxLAooBk4OYShL75/ohid9TFgANwNv4T1lpEwX3OJ6Y9a/NFuLwhDWijYLcP5zcgNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ7FAlHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0BEC32782;
	Tue, 30 Jul 2024 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356609;
	bh=3oYoOwjKwwydDncnDQbsW1v26gFUfUI+am7zGLJZOxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQ7FAlHgTmjcWbVbCubGIXQWCw7MECjGH1gdkZztmNDUfPqTsedoZn6LhCwb49UTI
	 2gjHkAd2xvQZGu839DodPcA8kFEI/nNFetWmc6iYKI02Wft0UcVp1Awz8TllyeBp17
	 g+D7xq6SH8C+ApNH08XRWk5zVEYSWYgX3PfbyKAdyz+7sMvefthBEbu0hAP/o+CmEm
	 jvq7jeDqWJ5mZxQNYy6kfewZUhkk9SkkPyMi0hmtoTjyt8+7n3R9xxl6pXFRA5ZOF3
	 0TK9noxmIgk1BcYWV/Wzfqa2nipF2KdXn0e+DYSQ2xBX5AgQp0xoFdcnRvqK335CT2
	 LbfttYrdkIJNg==
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
Subject: [PATCH net-next 6/9] net: airoha: Allow mapping IO region for multiple qdma controllers
Date: Tue, 30 Jul 2024 18:22:45 +0200
Message-ID: <6a56e76fa49b85b633cdb104e42ccf3bd6e7e3f8.1722356015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map MMIO regions of both qdma controllers available on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 46 ++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 18a0c8889073..498c65b4e449 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2025,15 +2025,26 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 }
 
 static int airoha_qdma_init(struct platform_device *pdev,
-			    struct airoha_eth *eth)
+			    struct airoha_eth *eth,
+			    struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = &eth->qdma[0];
-	int err;
+	int err, id = qdma - &eth->qdma[0];
+	const char *res;
 
 	spin_lock_init(&qdma->irq_lock);
 	qdma->eth = eth;
 
-	qdma->irq = platform_get_irq(pdev, 0);
+	res = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d", id);
+	if (!res)
+		return -ENOMEM;
+
+	qdma->regs = devm_platform_ioremap_resource_byname(pdev, res);
+	if (IS_ERR(eth->qdma[id].regs))
+		return dev_err_probe(eth->dev,
+				     PTR_ERR(eth->qdma[id].regs),
+				     "failed to iomap qdma%d regs\n", id);
+
+	qdma->irq = platform_get_irq(pdev, 4 * id);
 	if (qdma->irq < 0)
 		return qdma->irq;
 
@@ -2054,19 +2065,13 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	if (err)
 		return err;
 
-	err = airoha_qdma_hw_init(qdma);
-	if (err)
-		return err;
-
-	set_bit(DEV_STATE_INITIALIZED, &eth->state);
-
-	return 0;
+	return airoha_qdma_hw_init(qdma);
 }
 
 static int airoha_hw_init(struct platform_device *pdev,
 			  struct airoha_eth *eth)
 {
-	int err;
+	int err, i;
 
 	/* disable xsi */
 	reset_control_bulk_assert(ARRAY_SIZE(eth->xsi_rsts), eth->xsi_rsts);
@@ -2080,7 +2085,15 @@ static int airoha_hw_init(struct platform_device *pdev,
 	if (err)
 		return err;
 
-	return airoha_qdma_init(pdev, eth);
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+		err = airoha_qdma_init(pdev, eth, &eth->qdma[i]);
+		if (err)
+			return err;
+	}
+
+	set_bit(DEV_STATE_INITIALIZED, &eth->state);
+
+	return 0;
 }
 
 static void airoha_hw_cleanup(struct airoha_eth *eth)
@@ -2646,13 +2659,6 @@ static int airoha_probe(struct platform_device *pdev)
 		return dev_err_probe(eth->dev, PTR_ERR(eth->fe_regs),
 				     "failed to iomap fe regs\n");
 
-	eth->qdma[0].regs = devm_platform_ioremap_resource_byname(pdev,
-								  "qdma0");
-	if (IS_ERR(eth->qdma[0].regs))
-		return dev_err_probe(eth->dev,
-				     PTR_ERR(eth->qdma[0].regs),
-				     "failed to iomap qdma regs\n");
-
 	eth->rsts[0].id = "fe";
 	eth->rsts[1].id = "pdma";
 	eth->rsts[2].id = "qdma";
-- 
2.45.2


