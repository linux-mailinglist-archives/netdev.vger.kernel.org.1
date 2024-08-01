Return-Path: <netdev+bounces-115012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC684944E29
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E830B2299D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE81A57DF;
	Thu,  1 Aug 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF14U4gb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13D1A57C4
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522953; cv=none; b=elQ8B6pGg6GB0Bf+C09GGHIPYCWSBRhtsDJkcRY8KxOVs0bKbH4BmHaGtEdh6wbL5x+wFStAScQNUDInYuVw5plZi76jNUFebZFqDMfxW2UzejJ99x0iXOJZbMQXO/9/T2ROJYUwSVHtFIfRQxLvak004Pc9S2Sxvqu6TiznEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522953; c=relaxed/simple;
	bh=rDhzdFmdvFdeMEnYvLJnOXfciv2PMkb7NwTEj8CXv/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtI4nFEL98iAvzJ+H0pGpMiwOtFoL8Fw36ncF7oZMa7aq5dAo3Fuan57YdHLtFPN7zrMJnZ+5l69sNDMsiI+IdsoShf8FzyPWde1OYyIfpgrcdtXAMM2r0QglbarDGltXpTYLTdF8dAUzEGqiWL6GhDgNqMTea4fxeNz3NKegcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF14U4gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA5DC32786;
	Thu,  1 Aug 2024 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522953;
	bh=rDhzdFmdvFdeMEnYvLJnOXfciv2PMkb7NwTEj8CXv/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF14U4gbjxkLHWKmytt9o9zvJoSxAgGZoe/M0gkMdLS/pwLEbCASqdyv5Chp+pGXS
	 V3ptkU85UOrbfaUt9fMEve8YO7+GmjXlh4lm1qW1GaPUDqK3gcm26OLbS+54KGHQyJ
	 Hx0AIuGkMBt119Zz/BERUNVcABMNqkbgYYmmYfnuAHgZIoxtK84QCAUHtdOdOGyoUJ
	 Si7v9EGYfyssjQetskA5h1H4ug23MX6lzeThuvKNvxYo7OymKa4EArLcRvVZJvfaX0
	 S4ZJuFG6HQZiwMZTe1XBNfDXM2K2XNWZVwcu7bCvO+xMuSIXc2Mv+75Y6h4wMg79p/
	 YQzAtdDgexz8A==
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
Subject: [PATCH v2 net-next 5/8] net: airoha: Use qdma pointer as private structure in airoha_irq_handler routine
Date: Thu,  1 Aug 2024 16:35:07 +0200
Message-ID: <1e40c3cb973881c0eb3c3c247c78550da62054ab.1722522582.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/mediatek/airoha_eth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 54515c8a8b03..2ded99434a17 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1973,8 +1973,7 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 
 static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
-	struct airoha_eth *eth = dev_instance;
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_qdma *qdma = dev_instance;
 	u32 intr[ARRAY_SIZE(qdma->irqmask)];
 	int i;
 
@@ -1984,7 +1983,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
-	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
+	if (!test_bit(DEV_STATE_INITIALIZED, &qdma->eth->state))
 		return IRQ_NONE;
 
 	if (intr[1] & RX_DONE_INT_MASK) {
@@ -2037,7 +2036,7 @@ static int airoha_qdma_init(struct platform_device *pdev,
 		return qdma->irq;
 
 	err = devm_request_irq(eth->dev, qdma->irq, airoha_irq_handler,
-			       IRQF_SHARED, KBUILD_MODNAME, eth);
+			       IRQF_SHARED, KBUILD_MODNAME, qdma);
 	if (err)
 		return err;
 
-- 
2.45.2


