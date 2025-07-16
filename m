Return-Path: <netdev+bounces-207541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1AB07B5D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D7750816A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763F2F5C37;
	Wed, 16 Jul 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Cs6lTfij"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FC2F5C2B;
	Wed, 16 Jul 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684146; cv=none; b=AnbY3ogt3i1vIPf5R5lAA/y+4/sY4JkZL1/v+Tg/p026yOxmc62iJji2u5VB4zT7yMNufI28TzKmnrJ26WHUkf59kg/sp3L66dqP6kt0Bky5oaZVnUaub4U8MptsKMhJRLtRkiTj+1xsKbu0wgN3Ffn+mjDP6ofClnl4K9Bxpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684146; c=relaxed/simple;
	bh=vhEGNNzpDQEQqKY3zGGN6tcWuYYk2ZO8h61wlzhfIC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAcAa3x0WbovVQhmmDSrrnOKJ1GAjV4NIWdilKAUCETJCM9X9YIAVCuAv1I3t+9DGTj8Hs+cjK+url8N8KEF3Yfbxk+2GD3XH2/vzmlOJ9f7u1/utQhWC6SG5zi/wF83cb/dEqKCRa1vHKA/sLvdm8nyMCOPD/9pDo/j5SiaDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Cs6lTfij; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCgjhA014581;
	Wed, 16 Jul 2025 09:42:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	wnE5pPPJqzmFeZ98yOC4f81RmaAbFfWo37Qw+L1dxU=; b=Cs6lTfijqb8JasuHs
	PrVZlgcrmBum3FrK7hT09L8XJYoMXpQ426qj5NjoSKVDcnrqnwyfmC8aL5ffdMlH
	6iM0i/k1nchCqE6JIS4O1kI8Kys/vPjtopIXzWAbOqKKXbFOO4NKHrMRUvhui1S9
	tSW1d9EQLXu/b2SZP/vjSWL4eiBJVqPhQWPCdnv32nz1jJmB46xtz+92GZz8evw2
	iwdUwruaP/hs4a/xUXi8RBwm/ro5VRYnT+IVMnN4uNZex5icCk0048lAXpmdDCAh
	I1492NhI/0XDyaYUuMLpPVqgJc8NRMaktiVbMe5nmzdAoYMueLpbY8Z1gOk4aHre
	bl+Hw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47x5qd253m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:42:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Jul 2025 09:42:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Jul 2025 09:42:13 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id E4E2E3F7062;
	Wed, 16 Jul 2025 09:42:09 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 2/4] Octeontx2-af: Disable stale DMAC filters
Date: Wed, 16 Jul 2025 22:11:56 +0530
Message-ID: <20250716164158.1537269-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716164158.1537269-1-hkelam@marvell.com>
References: <20250716164158.1537269-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QN96zJX_R3jYqEsDtCLt6ZxOcuru0sqd
X-Proofpoint-GUID: QN96zJX_R3jYqEsDtCLt6ZxOcuru0sqd
X-Authority-Analysis: v=2.4 cv=ZKXXmW7b c=1 sm=1 tr=0 ts=6877d667 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=m_soVfamJn4hQp2eihYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MCBTYWx0ZWRfX81F/HG83pum/ fpW+SSayjDGrybrLsi4F1cePiKOgjwnttzQHq6pMPgprBsBYHgFZSjAMy5spovOliNXf/my9wAz 1gP3zQi+98iPnNHe2qQtmNmMcvK+0cI81+XdQthP6K8anRaJNhernqD/V4N+lQQ/DK/BTLsKNYE
 GbkHdPXnpVf90r5Xz3ThN8oL9ZVcoKGJRLAU4uzFm3E/NqIinR9HY1rlfuJflkh01SOHkO+eLCl zzqHEpY2rcgrAVSUQQwv8v0o18CItHYOB5ufAKNffpUGq/uofZwLA+NWtcMavx72yAC3rnkvoLY i9BXFhJ2xxxbwrdZzxop++8kh9xCR6cnQbZYCZIL3KYu2QAZKnORBcJrBdwb5YdJYrAHGLQveMY
 vXPPTiIfKRuKILPDd7GbYMrBn4v+b8F/Uxx7NsjgFSC9y95n4Yyn+5HfI57e7y19STVW7vmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

During driver initialization disable stale DMAC filters
in CGX/RPM set by firmware.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 846ee2b9edf1..cd6c5229d0ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1704,9 +1704,11 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
 
 static int cgx_lmac_init(struct cgx *cgx)
 {
+	u8 max_dmac_filters;
 	struct lmac *lmac;
 	u64 lmac_list;
 	int i, err;
+	int filter;
 
 	/* lmac_list specifies which lmacs are enabled
 	 * when bit n is set to 1, LMAC[n] is enabled
@@ -1745,6 +1747,8 @@ static int cgx_lmac_init(struct cgx *cgx)
 				cgx->mac_ops->dmac_filter_count /
 				cgx->lmac_count;
 
+		max_dmac_filters = lmac->mac_to_index_bmap.max;
+
 		err = rvu_alloc_bitmap(&lmac->mac_to_index_bmap);
 		if (err)
 			goto err_name_free;
@@ -1774,6 +1778,15 @@ static int cgx_lmac_init(struct cgx *cgx)
 		set_bit(lmac->lmac_id, &cgx->lmac_bmap);
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, true);
 		lmac->lmac_type = cgx->mac_ops->get_lmac_type(cgx, lmac->lmac_id);
+
+		/* Disable stale DMAC filters for sane state */
+		for (filter = 0; filter < max_dmac_filters; filter++)
+			cgx_lmac_addr_del(cgx->cgx_id, lmac->lmac_id, filter);
+
+		/* As cgx_lmac_addr_del does not clear entry for index 0
+		 * so it needs to be done explicitly
+		 */
+		cgx_lmac_addr_reset(cgx->cgx_id, lmac->lmac_id);
 	}
 
 	/* Start X2P reset on given MAC block */
-- 
2.34.1


