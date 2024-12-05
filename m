Return-Path: <netdev+bounces-149493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415F9E5C7F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773B18836F3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CF21D5AC;
	Thu,  5 Dec 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR3cI7pn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B343F4E2
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418346; cv=none; b=cFB0IS6AOCIpiOMgiMv6cg4r2kTiAa+1m4HuhiexqhqUOUtVVXsL2Ci6jiiYtVPB2EbNEyKUqmDjEHm61BUqPCv2+gd5YffiVA6LqE3deFM4I5Pl8eq2zSZXGGodhs9bbwie/xywfe2R1i3tH9hj0cJJEvsQkxEU0hVX+oBho9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418346; c=relaxed/simple;
	bh=oEOpcOk6JQn+TqC+Y0qyhALWC7OnfGq/On5S3tsDbsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HBYxMguXyVK4N/dagli6C5byCgh5TjKz0m2738+00uTlH4SVvijevos0kEvfTBN2F9Oq2En1WJhNAhaA6FZj/+ImchhwGyg48wr2FKhqXyqsc2rQmkMiAItlqws2iEAYmTOCWyYRecZdtqv1EPjL7t1x0d20lVSxjzk8lL6Odz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR3cI7pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61033C4CED1;
	Thu,  5 Dec 2024 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418346;
	bh=oEOpcOk6JQn+TqC+Y0qyhALWC7OnfGq/On5S3tsDbsM=;
	h=From:Date:Subject:To:Cc:From;
	b=GR3cI7pnY5AfYgJ4hzaR4nys9Y6sldfYWHYzbYFWxl7O7PsDb5iShLz9JQ4kMpu1Y
	 /cqUrVMaCwfSdwTQo7FTWUGD/kuIXVcNK/GCCyxj9ngps887BGn0N2LoDciwY7SHd2
	 Kaedv+1UEW47eH75rUCNTtaVgFH0mvdoubVmxsOyDarPlfDsjzvbbWoN2gzfkvTXSW
	 BgQSwnOaBzGNQ/WqedO4g4OtUm2g6X8Z4NfE5zX5tMlsOag5bWJfJfhedNh/XXB6wN
	 7/VY6o6kxXdIm+O4IlEbwmgpFySn772UXz8kN5tCu0cjKk3LJKw2JitX/wW5UTdRyL
	 Pgd7EnK7bk38w==
From: Simon Horman <horms@kernel.org>
Date: Thu, 05 Dec 2024 17:05:23 +0000
Subject: [PATCH RFC net] net: hibmcge: Release irq resources on error and
 device tear-down
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-hibmcge-free-irq-v1-1-f5103d8d9858@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFLdUWcC/x2MQQ5AMBBFr9LMWhNt0MRW4gC2YoEOZqGYikjE3
 U0s33/574GITBihVA8wXhRpCwImUTAufZhRkxcGm9rM2DTXCw3rKPPEKI4P7Zx3hXG9L9CA3Hb
 Gie4/2UJTVyrgCd37fgvkudhrAAAA
To: Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This patch addresses two problems related to leaked resources allocated
by hbg_irq_init().

1. On error release allocated resources
2. Otherwise, release the allocated irq vector on device tear-down
   by setting-up a devres to do so.

Found by inspection.
Compile tested only.

Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c | 57 +++++++++++++++++-------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 25dd25f096fe..35fedd7e0a33 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -83,45 +83,72 @@ static irqreturn_t hbg_irq_handle(int irq_num, void *p)
 static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx",
 						     "err", "mdio" };
 
+static void hbg_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
 int hbg_irq_init(struct hbg_priv *priv)
 {
 	struct hbg_vector *vectors = &priv->vectors;
 	struct device *dev = &priv->pdev->dev;
-	int ret, id;
+	int ret, id[HBG_VECTOR_NUM - 1];
 	u32 i;
 
 	/* used pcim_enable_device(),  so the vectors become device managed */
 	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
 				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to allocate vectors\n");
+	if (ret < 0) {
+		dev_err(dev, "failed to allocate vectors\n");
+		return ret;
+	}
 
-	if (ret != HBG_VECTOR_NUM)
-		return dev_err_probe(dev, -EINVAL,
-				     "requested %u MSI, but allocated %d MSI\n",
-				     HBG_VECTOR_NUM, ret);
+	if (ret != HBG_VECTOR_NUM) {
+		dev_err(dev, "requested %u MSI, but allocated %d MSI\n",
+			HBG_VECTOR_NUM, ret);
+		ret = -EINVAL;
+		goto err_free_irq_vectors;
+	}
 
 	/* mdio irq not requested, so the number of requested interrupts
 	 * is HBG_VECTOR_NUM - 1.
 	 */
 	for (i = 0; i < HBG_VECTOR_NUM - 1; i++) {
-		id = pci_irq_vector(priv->pdev, i);
-		if (id < 0)
-			return dev_err_probe(dev, id, "failed to get irq id\n");
+		id[i] = pci_irq_vector(priv->pdev, i);
+		if (id[i] < 0) {
+			dev_err(dev, "failed to get irq id\n");
+			ret = id[i];
+			goto err_free_irqs;
+		}
 
 		snprintf(vectors->name[i], sizeof(vectors->name[i]), "%s-%s-%s",
 			 dev_driver_string(dev), pci_name(priv->pdev),
 			 irq_names_map[i]);
 
-		ret = devm_request_irq(dev, id, hbg_irq_handle, 0,
+		ret = devm_request_irq(dev, id[i], hbg_irq_handle, 0,
 				       vectors->name[i], priv);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to request irq: %s\n",
-					     irq_names_map[i]);
+		if (ret) {
+			dev_err(dev, "failed to request irq: %s\n",
+				irq_names_map[i]);
+			goto err_free_irqs;
+		}
+	}
+
+	ret = devm_add_action_or_reset(dev, hbg_free_irq_vectors, priv->pdev);
+	if (ret) {
+		dev_err(dev, "Failed adding devres to free irq vectors\n");
+		goto err_free_irqs;
 	}
 
 	vectors->info_array = hbg_irqs;
 	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
 	return 0;
+
+err_free_irqs:
+	while (i-- > 0)
+		devm_free_irq(dev, id[i], priv);
+err_free_irq_vectors:
+	pci_free_irq_vectors(priv->pdev);
+
+	return ret;
 }


