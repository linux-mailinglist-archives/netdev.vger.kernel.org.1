Return-Path: <netdev+bounces-114223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85DA94189E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B532865B8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383A18455D;
	Tue, 30 Jul 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElRH25wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC841078F
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356606; cv=none; b=GyLS0LqgxQ56oUMBJixMv7SRS3joFXpQ/ZBR+pw1wT8PXbhyIfDfxQYYXFo8FBXszMoU+MX7PzErNB6Xs1Ul37u01PKQOuC8Zll8b/nSxXKJ4dO5h2CnmEgdwU67c8UNhEsWYfDeXq+Khf7drhQdn8XradLcaOkUI2pkNA5ywsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356606; c=relaxed/simple;
	bh=goFYc4tszjB+5vMtiKcyp7Goi8HpUFHwYeiuijvPdNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PknNticocZjajlmVdavEUc+z596bytk9k6GVFVOC9icUNJh+LMw/UXmNmgEfWSyh23X6J66Xh3AV7d5F269vkKC22LT8GVfScXAYLHgAGeBHNKz6EIhwTIRavAvCVrDbhm+DIyV4LkJPSOYELFgE15WlR/nqeQTjmgQhxFOcyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElRH25wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D144CC4AF0C;
	Tue, 30 Jul 2024 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356606;
	bh=goFYc4tszjB+5vMtiKcyp7Goi8HpUFHwYeiuijvPdNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElRH25wasGrkx9O/t6c6dZbQZNOhgZw+KQRz4BrhyUiKKA7Ev3MK1lRdz5TqUFYqh
	 mZHNChLUSY7K8zZ7V3CAHwhpqDznzBgimy17V75S8uMPQL6YAuCUzLl8mxi0VyWVqg
	 pZMSCn1E2wYmXn4qi+K1iZUaVHRxqb7XV8LzMWcVowBWwxfJa2YlmzLVh236az6eVc
	 WjPdDnjmFexpw6XQ8p3KQaVBXG6EcCimRefjPDItRAYiOV77pEd3nbhelzeMeSsIco
	 V4r1o+rlAsdNRar4yJ7LhsEMFr1tCv/1A89eu2TEXr8m72OBnrXNeE8jxEeMsHCYQG
	 lFyzVtnNZBH6A==
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
Subject: [PATCH net-next 5/9] net: airoha: Use qdma pointer as private structure in airoha_irq_handler routine
Date: Tue, 30 Jul 2024 18:22:44 +0200
Message-ID: <bc99a70ec713e9fdf7c60a6a685a546aa3073a75.1722356015.git.lorenzo@kernel.org>
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

This is a preliminary patch to support multi-QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 763b8df73552..18a0c8889073 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1975,8 +1975,7 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 
 static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
-	struct airoha_eth *eth = dev_instance;
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_qdma *qdma = dev_instance;
 	u32 intr[ARRAY_SIZE(qdma->irqmask)];
 	int i;
 
@@ -1986,7 +1985,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
-	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
+	if (!test_bit(DEV_STATE_INITIALIZED, &qdma->eth->state))
 		return IRQ_NONE;
 
 	if (intr[1] & RX_DONE_INT_MASK) {
@@ -2039,7 +2038,7 @@ static int airoha_qdma_init(struct platform_device *pdev,
 		return qdma->irq;
 
 	err = devm_request_irq(eth->dev, qdma->irq, airoha_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, eth);
+			       IRQF_SHARED, KBUILD_MODNAME, qdma);
 	if (err)
 		return err;
 
-- 
2.45.2


