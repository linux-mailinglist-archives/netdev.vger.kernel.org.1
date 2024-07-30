Return-Path: <netdev+bounces-114225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69A9418A7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3D91F23DC3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91D189522;
	Tue, 30 Jul 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF7pObya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9B188000
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356613; cv=none; b=te2G6bmfNC8Q0B1ITB3jgPXqG7dhISaRmNLHKJSgLpAebf9Z5Bt/BwGzdzgMg93KSVRhFKO63/XOpztXx+Ln6cRMNY3XSl3K9C9o4dJql9fjfDLmGWDZERVsbXmGrZAt7WftaD6tBzWciaXq4vcbpfjo3B1mLEW1YbB6J0bbF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356613; c=relaxed/simple;
	bh=vQDIJsnOGGgaq4WYfkSJ5Agb4wD4Q3L1HuA+vM95XEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuxRIbWlANNpRYOw+axtxuUBKVo8IRYvX5t68RpNJ9rZY3zwfqm9q0yDYUFgHDBxkRQZusdoF5sKdIWMZoOeSoczkNW0uibZ1zY2ur3/D75AdQ0x+hNxhQFDWUpUACclFR222I5tEzOna7NnOLG16LJaWf4h4xntjud++uAYpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF7pObya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B502C32782;
	Tue, 30 Jul 2024 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356613;
	bh=vQDIJsnOGGgaq4WYfkSJ5Agb4wD4Q3L1HuA+vM95XEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cF7pObyahraRhAF99pcJUmdgGM/1WTC/y0IVLeCUHdFXkb6cHHegi68wCj9YwLl9T
	 BtqXYP5yZ07DvmadE5xwfq7eRuK9ngfAaUx4L0NjM6NlhTqyPZtWEAKLKeSgOeR99K
	 dS1yCJ2D4IbwYQ7gXjn6WJUrI+/Oq/HbB+WR2qG4bga/+Kk9eEpXHLp6W0fTJQbLDM
	 eQpgjjtopQ7Hb7WmpMPTwm19RKdA+/uagIb0DeyBNQqL2QXe7tlHhV3Y59FDfJi2o5
	 Z866MTil2g3srNkPQzRjJQPO2XXbMvtWDY6dOWwFMpGC1xZeuPB6KIRnLwHMQPBi5o
	 04wSJRnoxcFgw==
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
Subject: [PATCH net-next 7/9] net: airoha: Clean-up all qdma controllers running airoha_hw_cleanup()
Date: Tue, 30 Jul 2024 18:22:46 +0200
Message-ID: <fc10753d211fe7782c8173f27cfb7b8586adf583.1722356015.git.lorenzo@kernel.org>
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

Run airoha_hw_cleanup routine for both QDMA controllers available on
EN7581 SoC removing airoha_eth module or in airoha_probe error path.
This is a preliminary patch to support multi-QDMA controllers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 498c65b4e449..2e21577f9ce2 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2096,9 +2096,8 @@ static int airoha_hw_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void airoha_hw_cleanup(struct airoha_eth *eth)
+static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 {
-	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
@@ -2714,7 +2713,9 @@ static int airoha_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	airoha_hw_cleanup(eth);
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_hw_cleanup(&eth->qdma[i]);
+
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
@@ -2732,7 +2733,9 @@ static void airoha_remove(struct platform_device *pdev)
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


