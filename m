Return-Path: <netdev+bounces-114226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A116A9418AB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DAA287731
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910E6188012;
	Tue, 30 Jul 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUv6IqzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DD183CCD
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356617; cv=none; b=Mex8tTx2PwcKXdZ5HtcnJAziJ5h5+Ycq8roLr3vb4wIeEoZJeXu9I9YCTDJYy0ecdN3YrtIv6QvuHXBEgx0mztlQYAdi6PkB82bbr+f0BdSzx2L4Ds92CSRSjVjeL3jdi3PttYhglHjeZCYzlrgu9N49tSU5Azd4kuWXCCHNvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356617; c=relaxed/simple;
	bh=TZP5zHn1W5rRyEfZh+ZzX0OSxkuTKzTc+hS7A+H1BEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekmuCcJbqOCOfX+J7X7lCA9Tbbb6BmIUBKrbzq4MHUAFtSAKamhbZpHtvbXCgh8qyYZlmTT71H8sanzaLiGVv+dRTlIw+VmMI9lGCGDe33Z9dwpA8XtavrBxqDVHC06hpGRragUQwXgyznsmKZzBv5RNLKJk4B4iuE5LZqlmAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUv6IqzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DEEC4AF0F;
	Tue, 30 Jul 2024 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356617;
	bh=TZP5zHn1W5rRyEfZh+ZzX0OSxkuTKzTc+hS7A+H1BEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUv6IqzOyTVFvE5JrN5uBxG85igZVfKGO3DYTLuXObnK2lDcK9SY5yQLluXyy3zlA
	 GwmU2sdl0J7wptQb3d6ImRKIKhtZWpcFEYrESONVSh6K6JL0TXFbMqHpYBOWmCeErT
	 tALUS7PpWEEIZJhmGNv+Efm4fyLYaV3I60o7Kej29lf4D/p8WfoAWjLL0s/5KYmmHm
	 BhKuyTUJKn6OY96T91erHZ3Qsm2LSa3NS/dQP4rARCz5qFSdUbqMwHg68bquN+krzz
	 ZshQ3mHmsh9Ud9uOglluKj8FD/Orsfj3MM18/HZWeqFgaHJmz6nTruDP8xTcSI2AMU
	 pn+rEU3RmCYIg==
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
Subject: [PATCH net-next 8/9] net: airoha: Start all qdma NAPIs in airoha_probe()
Date: Tue, 30 Jul 2024 18:22:47 +0200
Message-ID: <72e8dd6ce8a508085bf048125437868183bb53d0.1722356015.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/mediatek/airoha_eth.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 2e21577f9ce2..7a2acb550165 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2124,9 +2124,8 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_qdma_start_napi(struct airoha_eth *eth)
+static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
@@ -2695,7 +2694,9 @@ static int airoha_probe(struct platform_device *pdev)
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


