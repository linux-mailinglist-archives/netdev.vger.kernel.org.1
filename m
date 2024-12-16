Return-Path: <netdev+bounces-152343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEED9F37CF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071191884220
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DD2066E0;
	Mon, 16 Dec 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psRGZzTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342F2063E1
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371286; cv=none; b=i4gpN4BicSzSAX2t7c2p9E0W6eHuwof/hjhvUa4A0McXOlmPfgVeq3Ta1Z5NABjyUwFuy5FP84CE/CIUZAtviqyhDeNN5AHPJdBq30k3T6YJ+65f3+TrNGY1h7w0Sp/rZLHrlCfbCICbN7WuVFS8toLdz3UyUd2Ekod6xP24EvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371286; c=relaxed/simple;
	bh=YY6i8qBttwJwMGYHa0FJ7uNKRckcwymjOs5Mh2rzAaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RLG3arFL2vVHK7BetheORm7axgruCzyAq2vYFMK4tecOIPrONApFT/4/WJenE9mHkIoKIbMJjyqMExQA0l3UkFer3+j8kwGV9FgMALrasmTmOfaNSWXdJ2qpxCb/jHlq0EnCvdjIfGklHSv0Rz8gOHdqHNa8fgGorluBBzITbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psRGZzTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD1DC4CED0;
	Mon, 16 Dec 2024 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734371286;
	bh=YY6i8qBttwJwMGYHa0FJ7uNKRckcwymjOs5Mh2rzAaI=;
	h=From:Date:Subject:To:Cc:From;
	b=psRGZzTQFpUcDy5NQLC/ikAzjhe3peCZPny1d/+r6ut0Dvkr7Bshm/n4nGTk3/yIK
	 fBQu2KIXXmvpQbHvisNK9VMFMqgtWyrOOhkOUxu3cxUS6/areYexT0DCwt1k+rXZce
	 wsumdQafCFe0A0hIjqOqULnJL0ovbjebpKkglciOyQa7raZXG8GCDn94zUJFsoNOJv
	 bpEt4qX622ulz4X0DOBIQ5HndttcXwg0hfwsRyTTrZArPXmsTReJIHSjCdOmxNm/Nv
	 pEoCkB8Nv+Mkirqk3KMQrUgZLdfD72LztmsY5QHGRCFZIoCQ+zr65x9OoC+0YFpu6p
	 Q2KUurSu4FKhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 16 Dec 2024 18:47:33 +0100
Subject: [PATCH net-next v2] net: airoha: Fix error path in airoha_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-airoha_probe-error-path-fix-v2-1-6b10e04e9a5c@kernel.org>
X-B4-Tracking: v=1; b=H4sIALRnYGcC/42NQQ6CMBAAv0L27Bq6gAme/AchptCVbjS02RKiI
 fzdygs8zhxmNkiswgmuxQbKqyQJcwY6FTB6O0+M4jIDlVQbMg1a0eDtPWoYGFk1KEa7eHzIG5t
 hvAzsSqaSIReictZHvesze0lL0M8xW83P/tddDRp0jtrWELmqrm5P1plf56AT9Pu+fwEMwNMbx
 wAAAA==
X-Change-ID: 20241215-airoha_probe-error-path-fix-5bc6bed0e20e
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Mailer: b4 0.14.2

Do not run napi_disable() if airoha_hw_init() fails since Tx/Rx napi
has not been started yet. In order to fix the issue, introduce
airoha_qdma_stop_napi routine and remove napi_disable in
airoha_hw_cleanup().

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- rename airoha_qdma_disable_napi() in airoha_qdma_stop_napi()
- Link to v1: https://lore.kernel.org/r/20241215-airoha_probe-error-path-fix-v1-1-dd299122d343@kernel.org
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 33 ++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 6c683a12d5aa52dd9d966df123509075a989c0b3..d8bfc21a5b194478e18201ee3beca7494c223e24 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2138,17 +2138,14 @@ static void airoha_hw_cleanup(struct airoha_qdma *qdma)
 		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_disable(&qdma->q_rx[i].napi);
 		netif_napi_del(&qdma->q_rx[i].napi);
 		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
 		if (qdma->q_rx[i].page_pool)
 			page_pool_destroy(qdma->q_rx[i].page_pool);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-		napi_disable(&qdma->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
-	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)
@@ -2173,6 +2170,21 @@ static void airoha_qdma_start_napi(struct airoha_qdma *qdma)
 	}
 }
 
+static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		napi_disable(&qdma->q_tx_irq[i].napi);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
+			continue;
+
+		napi_disable(&qdma->q_rx[i].napi);
+	}
+}
+
 static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
@@ -2738,7 +2750,7 @@ static int airoha_probe(struct platform_device *pdev)
 
 	err = airoha_hw_init(pdev, eth);
 	if (err)
-		goto error;
+		goto error_hw_cleanup;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
@@ -2753,13 +2765,16 @@ static int airoha_probe(struct platform_device *pdev)
 		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
-			goto error;
+			goto error_napi_stop;
 		}
 	}
 
 	return 0;
 
-error:
+error_napi_stop:
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+		airoha_qdma_stop_napi(&eth->qdma[i]);
+error_hw_cleanup:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);
 
@@ -2780,8 +2795,10 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+		airoha_qdma_stop_napi(&eth->qdma[i]);
 		airoha_hw_cleanup(&eth->qdma[i]);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];

---
base-commit: bc6a5efe3dcd9ada8d76eeb69039a11a86add39b
change-id: 20241215-airoha_probe-error-path-fix-5bc6bed0e20e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


