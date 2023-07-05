Return-Path: <netdev+bounces-15463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4EA747BDD
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 05:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38131C2094C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD395A4D;
	Wed,  5 Jul 2023 03:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7EA3D
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 03:38:39 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8E1A2;
	Tue,  4 Jul 2023 20:38:37 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364Lu0cD004348;
	Tue, 4 Jul 2023 20:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=wB0DSkHbuSEPjLODB+OEbokuQbKF1FQqCpHYFSRULkQ=;
 b=gTTOJ2uosPRNJ2+X1BKLQWUREXXelWReX8YZAHESHeJ2wlsVqAzea7cmA9PO9tOH0/nV
 8fgx2soEUIdVETzJeacU6EDdCpXkIB4njIwPJsc2OjSoA+5zhY7357pKz/voywKPlPC7
 kcwXATzS19/gv5amNfBylOjVFL0+yyVeuVO2kJ1xDa2cHOzSWpCyNbOkFr/p5b0DNOxb
 7crDqNfQeTPwXnM2EbtnrMSyvMcUWnKgoKek1LQvF/wXJukBch2NU8LSTtgQfGuwfntF
 yuwVbWv/rTYFvBO6a7sX6LMSCgtd8gJAMpfTVYkBd39ZaREokjr6KxiBNzbdvSaAsLa6 Tg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rjknj98h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 04 Jul 2023 20:38:24 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 4 Jul
 2023 20:38:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 4 Jul 2023 20:38:22 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3D9A93F7057;
	Tue,  4 Jul 2023 20:38:19 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sbhatta@marvell.com>,
        <gakula@marvell.com>, <schalla@marvell.com>, <hkelam@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: Promisc enable/disable through mbox
Date: Wed, 5 Jul 2023 09:08:13 +0530
Message-ID: <20230705033813.2744357-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nf0j3nLTex24kgZEEv-YCnqWm3cbiScO
X-Proofpoint-ORIG-GUID: nf0j3nLTex24kgZEEv-YCnqWm3cbiScO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In Legacy silicon, promisc mode is only modified
through CGX mbox messages. In CN10KB silicon, it modified
from CGX mbox and NIX. This breaks legacy application
behaviour. Fix this by removing call from NIX.

Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 11 ++---------
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 0d745ae1cc9a..04b0e885f9d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4069,21 +4069,14 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 	}
 
 	/* install/uninstall promisc entry */
-	if (promisc) {
+	if (promisc)
 		rvu_npc_install_promisc_entry(rvu, pcifunc, nixlf,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
-
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_enable(rvu, pcifunc);
-	} else {
+	else
 		if (!nix_rx_multicast)
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_disable(rvu, pcifunc);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 9f11c1e40737..7ee7bc256bde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1164,8 +1164,10 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
+	bool promisc;
 
 	table = rvu->hw->table;
+	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1177,13 +1179,16 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	/* If all rules are deleted, disable cam */
+	if (promisc)
+		goto done;
+
+	/* If all rules are deleted and not already in promisc mode; disable cam */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added, enable cam */
+	/* If rule got added and not already in promisc mode; enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1462,6 +1467,11 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	*promisc = false;
 	mutex_unlock(&table->lock);
 
+	/* Enable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, true);
+
+	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
@@ -1503,6 +1513,11 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	*promisc = true;
 	mutex_unlock(&table->lock);
 
+	/*  disable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);
+
+	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
-- 
2.25.1


