Return-Path: <netdev+bounces-106057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E391479C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC241F232A1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A952136E1C;
	Mon, 24 Jun 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gKlAFkQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C51369A3;
	Mon, 24 Jun 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225440; cv=none; b=jTisXDUJ5QUYOZJW3KFaZeYlBui1L3PsZp4q23fQry4ehr/u+PPMP9reqYw+ZRhK4cRAQ54nqXM/aSdTPFkVjrh76euhQrBFpVNCBamhiemgLHrk76OqJPHANadQiME33NBMq7w3rKNRX1PveRm8LgDRtkbdWtcZlyscYoJyuQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225440; c=relaxed/simple;
	bh=BU7EHfPZqjUzqx9GS36jlxYiQQ5HK2PD1EaGdqFOeCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfN7K2XaPsWgHexiprEwj0Jagryc+gAQkgTN2W7Y4A40dXp+JQqh5E+VNqS2ds4tgxj07fwLU7EMNELaxCdDvU/IXYFHRyQKr8VAQIBaG4nIIRiH8MS0UryUhfOQe0Bnz4C3XHogkP0XsG96AeWesiZLZk+Kb3Y4ucAbUXZF+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gKlAFkQ9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARoRJ022321;
	Mon, 24 Jun 2024 03:37:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	MUJ9tF5v/6qsmLgkWE2hD0Gxixbovk7y/3ORqapGo8=; b=gKlAFkQ9nKhvylbny
	xFZnDeYUqULN0CVzkG4MXsDjH9+JLeBZfF7ZF21bQNvyszDO6cQsbZi5i81XNyCm
	XcvdNuPSU1/bpa/G6CYI2qZaceCWUDfxVz8HS2WPAzqgQy+n6gzp5ImvSK/SvmKP
	ghm6L8d8/MS2rX8KSuFHiD85Kv52rTbpnS7JcJtOk/Vr+SxBVOBsUktf+3LyY+EY
	ms2I1M5NO44Mn2+IyF/wu0q7nBJ+o54QN0BDBKMoLPA2mm5P71te66r0948eUshp
	PEjymmQ8pwNIXggfIQvF0osLMeEb9UlxCm0R74jl8IO31TwwSnpge2ZzhFCpEcxo
	0FByA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:37:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:37:12 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 175243F7077;
	Mon, 24 Jun 2024 03:37:07 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 5/7] octeontx2-af: Fixes klockwork issues in rvu_debugfs.c
Date: Mon, 24 Jun 2024 16:06:36 +0530
Message-ID: <20240624103638.2087821-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
References: <20240624103638.2087821-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SCStz2mjBsbiIpY9sx2aNuPwvswI0P56
X-Proofpoint-GUID: SCStz2mjBsbiIpY9sx2aNuPwvswI0P56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

These are not real issues but sanity checks.

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


