Return-Path: <netdev+bounces-115013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C430944E2A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597F1285295
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D90C1A57C2;
	Thu,  1 Aug 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJS0GN16"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493DF1A4885
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522957; cv=none; b=Kr+EW4h0TMaS08Mp5Ilt4pqgb3nyd2zn49R2XBGkOUTo4Z5c8LuB0Ks0cEyiKoHCxxaz06dYEZxKqPa9TWw2u7QYdXFpE3Fyir3DX6+uzRYv2Hhi6jcryBfHFPqgCVgFr1p8vM3LTjhFsCvv7BOwC42urfKqXls832Ryk0RvYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522957; c=relaxed/simple;
	bh=CN29bD43mYmBHoqM5Pv7Tk1t9vxbTlHM72y91y3xufk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrgbPbQy8Ngg7bqdD2esEZMe8/5//kV9v+EBBXlyenyEDD5KfQvuJqTZmHRKEr54ogeuRU2/sdY1NI1Xk7XMNhITahuebl8wh0E9pK7wE3WxlYCyHgkCiFqZGW8K5JywAb0SuISIeXTsq3sFhR11Ysp+nZ1Ce0mTfcfGFsTQtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJS0GN16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C394AC32786;
	Thu,  1 Aug 2024 14:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522957;
	bh=CN29bD43mYmBHoqM5Pv7Tk1t9vxbTlHM72y91y3xufk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJS0GN16p3x9sif7f83wTuO9Tm0UXflK0wFPoDFyIUgvcNrTm3/l0EuTFShLdhID1
	 C4EEOIhdCFNaU/p7rWKMUfiY+KCmAZU9gqq5VZuQdC7R/mPITWC32XR4e017iZl2AL
	 XD9yPqAb7+wdOraxJ146Esro4IP67FvIm5iD6/PhYHoweqYroLaW1iFH4qbGY5pM+6
	 eKarGLxyvvs4P+hth+ZYOxqUyKZIvkyzhn054IGTEomT4CQlLehArsMLKgIUyxWGL8
	 ubfnHpeBHYL99bqNqgCPsAnNC1mizC7hpCbnh6Za17R9dVxBFey8i0hfI0Q61PBig5
	 DAx+DndCpejhQ==
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
Subject: [PATCH v2 net-next 6/8] net: airoha: Allow mapping IO region for multiple qdma controllers
Date: Thu,  1 Aug 2024 16:35:08 +0200
Message-ID: <a734ae608da14b67ae749b375d880dbbc70868ea.1722522582.git.lorenzo@kernel.org>
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

Map MMIO regions of both qdma controllers available on EN7581 SoC.
Run airoha_hw_cleanup routine for both QDMA controllers available on
EN7581 SoC removing airoha_eth module or in airoha_probe error path.
This is a preliminary patch to support multi-QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 56 ++++++++++++----------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 2ded99434a17..5286afbc6f3f 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2023,15 +2023,25 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
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
+	if (IS_ERR(qdma->regs))
+		return dev_err_probe(eth->dev, PTR_ERR(qdma->regs),
+				     "failed to iomap qdma%d regs\n", id);
+
+	qdma->irq = platform_get_irq(pdev, 4 * id);
 	if (qdma->irq < 0)
 		return qdma->irq;
 
@@ -2052,19 +2062,13 @@ static int airoha_qdma_init(struct platform_device *pdev,
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
@@ -2078,12 +2082,19 @@ static int airoha_hw_init(struct platform_device *pdev,
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
 
-static void airoha_hw_cleanup(struct airoha_eth *eth)
+static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2644,13 +2655,6 @@ static int airoha_probe(struct platform_device *pdev)
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
@@ -2706,7 +2710,9 @@ static int airoha_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	airoha_hw_cleanup(eth);
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_hw_cleanup(&eth->qdma[i]);
+
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
@@ -2724,7 +2730,9 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	airoha_hw_cleanup(eth);
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_hw_cleanup(&eth->qdma[i]);
+
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
-- 
2.45.2


