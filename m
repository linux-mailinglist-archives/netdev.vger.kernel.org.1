Return-Path: <netdev+bounces-106609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF8916F5E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074831F22297
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F701459F8;
	Tue, 25 Jun 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EASIKClw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69ED1448EA;
	Tue, 25 Jun 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336881; cv=none; b=VLRHn1v15pR0KfD0p5IliBp8uFfcxepq4vPg7op4BiL1vTGIquryLENoMxqX/yWckIIJp4VTUuCMC+GG0Gu1WeiEfXsDwT8SW9iMNuNNC6B8nxN46qU0ZjkjFF1adc7MfWMwQ/S/B/WLFGZbOhIpPfu9grAB1U1JBfEKkoU5bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336881; c=relaxed/simple;
	bh=mYswLskD2f54xsA+uigeWVHnVsphdKMidBwt5fV88iE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGPigTCliyOZ9O6J+AHMcZ9GAHS2UeQsUMZ5hLT5Y+2locIDiuiiAMa2vxGBQNmc1B9VL7p2dIg4RRLr2bm3wsle/C45NJCSD2u5VxuE+BUTOOt1KZzGgzRSCKcM9djtvwU4YY7ny/vEOR/AIQ1vK6tqtpIzVA2rPo1KGYUQeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EASIKClw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtIf9000832;
	Tue, 25 Jun 2024 10:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	e0t3Fua8wPFIE995yUJ9ZMXzL8cJoYXVeTjct8zcQc=; b=EASIKClwTSbHSPYp/
	0GTGzMO+uwnxQLn4L1OXbGYG31COxg++kbo8ZcW2xjn9JbFuIrRc5kRQozh32kLb
	4bPawvCaaI9KkECx4pgH4kc1JcGpDQjV1/H+GV+hhQOi4KLoDLwx8j5X4WYEby4l
	9JKwMRctecw5j/c1Ny4qpLV+qmogk/00tKt06NgZc/mS2fDzBxmKo45B38j7eOpX
	eEJg9WI+KfrVR5UDUfeVLAznL+jnFOlTZ4956rbxoSK7IhINtcmEvm/xDkbGhGiS
	YTvtV5t5I5sQMfgjdzPewK0ah3yA8ZVwFlHpumfTSU+JFv2nMGRzTAC8uIbhGHgT
	KKTuQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9kjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 30E7B3F7063;
	Tue, 25 Jun 2024 10:34:27 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 5/7] octeontx2-af: Fixes klockwork issues in rvu_debugfs.c
Date: Tue, 25 Jun 2024 23:03:48 +0530
Message-ID: <20240625173350.1181194-7-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nWepujQj1fbK2-dvBfYR7qQm0nC5hsnW
X-Proofpoint-GUID: nWepujQj1fbK2-dvBfYR7qQm0nC5hsnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

As part of this fix, fixed sized char array is converted to dynamic sized
array to avoid splitting of some debug information.

Fixes: d06c2aba5163 ("octeontx2-af: cn10k: mcs: Add debugfs support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 881d704644fb..292eead7be46 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -518,13 +518,17 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
 
 static void rvu_dbg_mcs_init(struct rvu *rvu)
 {
+	char *dname = NULL;
 	struct mcs *mcs;
-	char dname[10];
 	int i;
 
 	if (!rvu->mcs_blk_cnt)
 		return;
 
+	dname = kmalloc_array(rvu->mcs_blk_cnt, sizeof(char), GFP_KERNEL);
+	if (!dname)
+		return;
+
 	rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
 
 	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
@@ -568,6 +572,8 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 		debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
 				    &rvu_dbg_mcs_tx_port_stats_fops);
 	}
+
+	kfree(dname);
 }
 
 #define LMT_MAPTBL_ENTRY_SIZE 16
-- 
2.25.1


