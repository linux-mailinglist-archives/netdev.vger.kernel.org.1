Return-Path: <netdev+bounces-208443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C53B0B6FA
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F5B3B0601
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485B220F36;
	Sun, 20 Jul 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GJNyy2yk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E701ACED5;
	Sun, 20 Jul 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029430; cv=none; b=lQTWF29xaBvfpBC7B7+P+59aeg0Pgd1zMuNjrfot5bVZZgSosSXcIkNt9uqrE9LKTWyxoN5hT73WQyNrxYtelM1dK5FJ4CQGUL4vUVvqs3ozLVEEN4r7he4sKeBWgwmbmX43m0HzXd6Tnx0cycQYhKIpQttJ8wZ5B7lkwUYpVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029430; c=relaxed/simple;
	bh=QwcgapcpZUc1qrR4pe+IFzqkuuT4KcIZMy/dOgG74f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLuZnxwSGVLqg5ypV1TSJIdEWN3jyENhxR2ukNfuyqkZnW39eHrfF7CsaLOD3z6i/RY91xcijf0AzJsOlhGITavMLqdWKoz95pvtm0XMPtX7eE8g9sWavbskhRyALGqvRlpwjO3AmN8Vkjdsb3LtAci9ftOXMRlWNHq2PO01K4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GJNyy2yk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGDXL1018159;
	Sun, 20 Jul 2025 09:36:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	zaAy0+gitEQzVGTaJnOPKhoFPr+GYriGzuzDEJEajM=; b=GJNyy2ykxhElG899n
	NtMKXzd/VLrcaOysjRxwn3N+D7ZaI08eGoC/kOrzPmSCSeKjITDEbE388txG84Uw
	oWrPul6irbXLA+HTLk0VV9bm0YLuBUpINgLn2PjwQ2/skwGUiQSlLuphM1jW+X9G
	thDudcE++rxKsVYY1gW9ui4+T1T04QeW97XU4lGOL7JduMAPfLKGDASjTotpH5dr
	VaPaAeuK9NvnZTPferyTrenso4rUe+pbWLyPwNxclrP+ry7CtrUiphTSKILbNeF6
	xUxCHY+ftGbNRhkzkK35GyJ9LLe6G0Y54jd3czG4O6yURERJ7Kcx2doEqi/uL1oP
	wLZ+Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 480ymbg8p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 09:36:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Jul 2025 09:36:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Jul 2025 09:36:54 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id BD78C3F7057;
	Sun, 20 Jul 2025 09:36:49 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 2/4] Octeontx2-af: Disable stale DMAC filters
Date: Sun, 20 Jul 2025 22:06:36 +0530
Message-ID: <20250720163638.1560323-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250720163638.1560323-1-hkelam@marvell.com>
References: <20250720163638.1560323-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VtgjA/2n c=1 sm=1 tr=0 ts=687d1b27 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=m_soVfamJn4hQp2eihYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 1F42NXCntmXv3WC6qVj155YeJYx-XDT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE2MCBTYWx0ZWRfX+W8AYTN1AfD0 GmuaX+xWjg/jmfmlQt/ZC68KCzA+wcMY5BR9IZ12Q4FyYBOfHH/ccpIXsgKFi2erhQAQL40Jj1k XWYJfb2mI6Pktp2FJ6iUAJNNoJgXDHQsj4uIZsBfbRJS9bQGQ/h5uaRWeH2a+QyHx30xyNgVbWZ
 /Q6YogE/6bOLILtOu+sWrOXSQUQBHTUM/ARFEGmSQMI0EINpysFyM34aFttypZQRdM2qWXsuHvw oDGhbwbOGpGph5FppCAEBJfKFhjeSTM9untt5e9Pyfx7bQUgJM0nLFwviANDxQUqmjFUVWLtW2X VxCaoru6mey6PMz49v/lx/hAVbZe+DGEbOxhhdCllm1nnV/l9KqLblHBWZl0nkuNGiILnnvg8pe
 ePJhbYp97zeQ6gWcrz99ZSgPYozPcvXU+sffOyNYFr2nEGd8Hn0KTpFSuJr7GZc2ml2DZSFh
X-Proofpoint-GUID: 1F42NXCntmXv3WC6qVj155YeJYx-XDT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

During driver initialization disable stale DMAC filters
in CGX/RPM set by firmware.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


