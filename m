Return-Path: <netdev+bounces-96843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7418C8012
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B621D1F22B1F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB09441;
	Fri, 17 May 2024 02:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FA8F55;
	Fri, 17 May 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715914282; cv=none; b=XZT2FyRtVCNbEF9fBJTOv6hw38LNlg4Mtgfx+i7IDF28F14/jlztmVtiiE6ELdC2buKl7e79uGHT4GMbbc3s9UytcmgVr1BmWKVPKgQ6LjrbnNTC5kdLOG3uraTQeDYMYuUp7iIeQRgGflCuNM6StRW9rTf1gQ+LcG8nE95YhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715914282; c=relaxed/simple;
	bh=zzzCp1QUm1wKcYmoJU9X68oy67/XfeJKxY6LghtApFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JduQVZFBlQogMTBZwfpd9/hNV4v8RvSOYylOw+YkYKtfjSawjYWJsgjlzNrbcrsmR3fKF0uVpey1mmkAggfXLsEib/5eJunZ+2oPJWSV5zSAjX4xC74Be6mOzRNrwb9BKa9g4Cj7TQWmHwI9HsT2OAjopXQ6vVSB+YEN2lr9MKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAC3v5MIxkZmdCJ_Cw--.63667S2;
	Fri, 17 May 2024 10:50:49 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next v2] net: ethernet: mtk_eth_soc: add missing check for rhashtable_init
Date: Fri, 17 May 2024 10:39:22 +0800
Message-Id: <20240517023922.362327-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3v5MIxkZmdCJ_Cw--.63667S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rZrWftF4UWw17ArWxXrb_yoW8AFWDpr
	4Yya47ZF1rJw4UWa1kAa1xZFW5Ga1xK34DGFyfZw1Sv345Ar47JF1Utay5ZrW0yrWDKFsI
	yr1jv3sxCFZ8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq38
	nUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of rhashtable_init() and return the error
if it fails in order to catch the error.

Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Rewrite the error handling.
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c     | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index cae46290a7ae..f9b8956a8726 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4957,7 +4957,7 @@ static int mtk_probe(struct platform_device *pdev)
 
 			eth->ppe[i] = mtk_ppe_init(eth, eth->base + ppe_addr, i);
 
-			if (!eth->ppe[i]) {
+			if (IS_ERR_OR_NULL(eth->ppe[i])) {
 				err = -ENOMEM;
 				goto err_deinit_ppe;
 			}
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 0acee405a749..4895c6febaf8 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -884,12 +884,15 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
 	struct mtk_ppe *ppe;
 	u32 foe_flow_size;
 	void *foe;
+	int ret;
 
 	ppe = devm_kzalloc(dev, sizeof(*ppe), GFP_KERNEL);
 	if (!ppe)
 		return NULL;
 
-	rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
+	ret = rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
+	if (ret)
+		return ERR_PTR(ret);
 
 	/* need to allocate a separate device, since it PPE DMA access is
 	 * not coherent.
-- 
2.25.1


