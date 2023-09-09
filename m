Return-Path: <netdev+bounces-32716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67683799A6F
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DEE28181F
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CB2748E;
	Sat,  9 Sep 2023 18:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCA7460
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 18:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF6EC433C8;
	Sat,  9 Sep 2023 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694284932;
	bh=wuo16JyQlSC0fGLdygM/5u4cxoAXrQ599fZaJ7+y50A=;
	h=From:To:Cc:Subject:Date:From;
	b=fncTc7arkwQbaSC8SpkcrBeRVWsLc6Wq6q59+P7xXQVh8HhAFwVsHQswTEAx/j/ua
	 qLHn90LZWKq2XAEsDKm4YPxAORis14tchAhwWa4E1oWMxIKsfJJpMRzg3bW9GBDjnC
	 1x+fTkOyzADCzKqodNP6LnJ9zzlQJ7bmVkETH9F5uTGwTFAMxpW9Ezbe4DXggVIrCH
	 KNiJKudeuv2Ykr5sbZ9GH1xgmeAyKND5FqpfQDSLeBBX29Cn6Gssi+/fQH2obNl+VW
	 XdmzqQ+ClJ04LEBASt4faRa88r7p67g2EYXQMNVmCv2iljX5NQtI8U+92q7gpsEGWo
	 BakrHWB7yP1Ag==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix pse_port configuration for MT7988
Date: Sat,  9 Sep 2023 20:41:56 +0200
Message-ID: <717829d0b5aab2fa757e4de79a6328dd7a5b0a3b.1694284783.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7988 SoC support 3 NICs. Fix pse_port configuration in
mtk_flow_set_output_device routine if the traffic is offloaded to eth2.
Rely on mtk_pse_port definitions.

Fixes: 88efedf517e6 ("net: ethernet: mtk_eth_soc: enable nft hw flowtable_offload for MT7988 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index a70a5417c173..a4efbeb16208 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -214,9 +214,11 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 	dsa_port = mtk_flow_get_dsa_port(&dev);
 
 	if (dev == eth->netdev[0])
-		pse_port = 1;
+		pse_port = PSE_GDM1_PORT;
 	else if (dev == eth->netdev[1])
-		pse_port = 2;
+		pse_port = PSE_GDM2_PORT;
+	else if (dev == eth->netdev[2])
+		pse_port = PSE_GDM3_PORT;
 	else
 		return -EOPNOTSUPP;
 
-- 
2.41.0


