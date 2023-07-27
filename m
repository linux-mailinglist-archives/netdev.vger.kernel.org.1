Return-Path: <netdev+bounces-21728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F4B76478A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87E0281FF8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6766BE55;
	Thu, 27 Jul 2023 07:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AC23D9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDEEC433C8;
	Thu, 27 Jul 2023 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690441374;
	bh=Lo4MjZefFMKLOjN0Q8K8OtcgHfd9HQONZau0vcyqEmg=;
	h=From:To:Cc:Subject:Date:From;
	b=PSsei2VSLpEeVvjxZxu8FQd62dAy++dYdubLALkeQlz/sul1y6q9Exd0mK24wCClR
	 oGvt+W9EtMv60s+/AcyhF/aexlu6g18xZxyINPsDXQTtAZVQuqQUfikQyL7cD7gqDg
	 2Qs4GhRaGaDuwSGIRIv0La/J1ABuSh+eB7GBQvDM/HSqGkX3hNkRtnOQb2gwm3dF14
	 7r9m1LAJLZMOzO7g2YmeTx+pJnC7gvj5+KL0ZyKxZ8lku6nJY6p29jeEDxISCnDJ8p
	 rria8n0aXb4eqO0RykDR7+w+BU9d19kPHkOOeTj/iMU5Mv+eLtnV7sf3PZbEkhgxzf
	 2IZynxL6Ahvdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	daniel@makrotopia.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: enable page_pool support for MT7988 SoC
Date: Thu, 27 Jul 2023 09:02:26 +0200
Message-ID: <fd4e8693980e47385a543e7b002eec0b88bd09df.1690440675.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to recycle pages, enable page_pool allocator for MT7988 SoC.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 30e3935e83f9..d6750a58a71f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1673,7 +1673,7 @@ static void mtk_update_rx_cpu_idx(struct mtk_eth *eth)
 
 static bool mtk_page_pool_enabled(struct mtk_eth *eth)
 {
-	return eth->soc->version == 2;
+	return mtk_is_netsys_v2_or_greater(eth);
 }
 
 static struct page_pool *mtk_create_page_pool(struct mtk_eth *eth,
-- 
2.41.0


