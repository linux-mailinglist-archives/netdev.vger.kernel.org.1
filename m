Return-Path: <netdev+bounces-190831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717DAB9076
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96663AA173
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0128D8E6;
	Thu, 15 May 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dds4VrK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352C4B1E44;
	Thu, 15 May 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339273; cv=none; b=EZHcCEJc1OFXUfDySbEf+VdKn5IBS6l5tpGlEKJ1SdVWKA8AU1yeSdeNZ5ELNCjY7dpkBA6fwgW20MTuvfpKXUbQNXnZACEy4gpxyOJlnP7x0ChhqM+K5WhWZovaMrKs0gkZN6qb1LMwPPhBxR+AlSKei/R5fDQ9OlDRv1bc7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339273; c=relaxed/simple;
	bh=mEnN50jIc7T5c496yU2di1R2bgcNRb3JCrN1K7AdEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdba5zupxo60xwGOlU0tCDOhz3zJbZjODRC5Xy2YHh7fFA2s6aJDJ12qSpxFquQohMOh9P6t0ZhxPAwVS8LIdcwbCZ7ogcw7Ch1B0oPf0LI5FDQZzknZlilJfuAaXmcTW3y3/XTIaV0XoE5OQn3+/HsYw4HKFNv7pKgIH+7TyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dds4VrK0; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id FekBuCN6oIqMPFekQugnx3; Thu, 15 May 2025 22:00:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747339207;
	bh=Xe3Yf/RkJy0bBAFw+fy2FrPiDrFjW5kHmVMstQPOdyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dds4VrK0VNtd1KEL5NbJssDaA6ZgoOZRe2hYjPJQrQXEDy2zIxlDbH6HyHsa60st+
	 mnmReU3IaRk75AWJv89Dh4h1sqmhxMc9wU+PWs2Q/6+T5QuAib0PK8iN/72pwQxGtp
	 6Q4g3X4fBHo/+Vbut0qwVfH8we040E9XMCkQxUy0c9vgd/mQJbXVSCvt38dDUvP7SM
	 jeq9fWUAevNfhMZe9kg1Ed72kNlwapp2rVG/h2UvmmbYiIZY57DR6JD8+Zvyqa8fzm
	 OA/m2jrnNJAJD6lxmulxHIISVebP7wF/BLvGLBsDgres6dGXybDY4LyX8zVaI79X6H
	 V7kUGcjoFu3Sw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 May 2025 22:00:07 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 4/4] net: airoha: Use dev_err_probe()
Date: Thu, 15 May 2025 21:59:38 +0200
Message-ID: <bb64aa1ea0205329c377ad32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe() to slightly simplify the code.
It is less verbose, more informational and makes error logging more
consistent in the probe.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v3:
  - None

Changes in v2:
  - New patch
v2: https://lore.kernel.org/all/1b67aa9ea0245325c3779d32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr/

Compile tested only.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2335aa59b06f..7404ee894467 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2896,10 +2896,9 @@ static int airoha_probe(struct platform_device *pdev)
 	eth->dev = &pdev->dev;
 
 	err = dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
-	if (err) {
-		dev_err(eth->dev, "failed configuring DMA mask\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed configuring DMA mask\n");
 
 	eth->fe_regs = devm_platform_ioremap_resource_byname(pdev, "fe");
 	if (IS_ERR(eth->fe_regs))
@@ -2912,10 +2911,9 @@ static int airoha_probe(struct platform_device *pdev)
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
 						    ARRAY_SIZE(eth->rsts),
 						    eth->rsts);
-	if (err) {
-		dev_err(eth->dev, "failed to get bulk reset lines\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed to get bulk reset lines\n");
 
 	eth->xsi_rsts[0].id = "xsi-mac";
 	eth->xsi_rsts[1].id = "hsi0-mac";
@@ -2925,10 +2923,9 @@ static int airoha_probe(struct platform_device *pdev)
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
 						    ARRAY_SIZE(eth->xsi_rsts),
 						    eth->xsi_rsts);
-	if (err) {
-		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed to get bulk xsi reset lines\n");
 
 	eth->napi_dev = alloc_netdev_dummy(0);
 	if (!eth->napi_dev)
-- 
2.49.0


