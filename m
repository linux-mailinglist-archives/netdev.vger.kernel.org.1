Return-Path: <netdev+bounces-191396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B6ABB625
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C75F189639A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CB266B59;
	Mon, 19 May 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k18YC5ty"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE5F4E2;
	Mon, 19 May 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639651; cv=none; b=R/ezFuNyB+svdsK/MDkw5p4MkJkmSakCfaLjlbMbWH7rZoV6wgFuvIHaQjNsNEBsHTs3giVntK+qmALWYLV9OycJzl6quyGsb+FmBBVmwCsvId+IWM0uOUyELfedpjlBQFMbT/iR0M9QN66kIU2JW9Delh46PPhSNxsTEaYK/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639651; c=relaxed/simple;
	bh=BOnEr9Rl2fHLZ5/jEW+mTH4Vq9hJYeh90JsFlGFCPaU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aH7uzoo3nBg1UhbjblpFjSuckXaOkkYrzrvK8/27PhG/ydtFAHtUJS9/p0+RuvR8t+yMKUBahFtsDQFKK8tvhvKcGbKNVE9bwfPT8+nZfSsqnLVckN8kxDXBTUHsogz+7gFyq/KgvklbH8xehhU9cS/P1wVYjlTlb7iyuXUhfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k18YC5ty; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J1HIkR017553;
	Mon, 19 May 2025 00:27:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Xk63N9eSkVMHuKTHBf+krYV
	UirUlULcHk8wZOb2zrvA=; b=k18YC5ty1+iDXs33TviiCJRO68N2dZUdd7eM4N2
	tCVf9wts/Pzmsv1HhwfTGPKXxRtuWN+OM54/ys1Y+C9rj/uTMjBEfQQQmWOGa4Fu
	v+DF1PYbWUjAyplT8RdN5YfQaOAIdl6fgPBYZobKy3VaQW8WYAbcjdRozUFK1W0R
	aI+isx2rv3aJ+WFKbKFvzFEwfcxSpqw7JjGH5yqRLvxBLX3ISqoJlyqXfyB6KJKc
	U91p2RLProYSNTv/HMOBnOcYgtIHmLUJYZ/QbXMPbPk/DBmzfPaHK7r88snl22hz
	r6LlD/1DUR7G0MXwUsiJMjkDbTmDjvmvjQd0WaJX0stjyRA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46qb799dcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 00:27:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 00:27:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 00:27:07 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id E61733F7080;
	Mon, 19 May 2025 00:27:02 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <bbhushan2@marvell.com>,
        <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf
Date: Mon, 19 May 2025 12:56:58 +0530
Message-ID: <20250519072658.2960851-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zoK2cDfe-H6ph1Q6rJKPlnM7g0oJt5lY
X-Proofpoint-ORIG-GUID: zoK2cDfe-H6ph1Q6rJKPlnM7g0oJt5lY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA2OSBTYWx0ZWRfX+sJsjopTO48u BBPeqcJX/WXcChDXaAOHir4NVHnociEVRGF5YUG8cW/83q79y0tBwK6BmW1fuCttPdFMts+/U+k +G8T4HqhjrzKs4pATZGuEN96LYbwCdfx7T5JkVQ7b6T7kXc0vtjPSOHGTT5JIUODhl0w7wl1MhF
 xlVtpuRoKOkFLQBZ2KeaA6SMN0o52ico08YKmEr3mahEwxf22KycSYODaAKsOJ/YoFX0PD/KYzX 8g1dXhFIMtwIM5+jiH63/tgskkO6H4chQLanwi7s4yseVIkACr5aU36HXVOOKuFdu8ZzvIskEuP gJeJIAtxn85qHgj0p2K2cXdVEXGs4gR+oxFed2ANAPu9CDaajoTRzwU/K+q+Zray0vsC1y0v1GN
 MgDhSFucxE0vmndfFW9Mxw8gIS+swG0tf6wXfykHkad19zjtvR1mW6ZkEQ4p22PoWINCAEa8
X-Authority-Analysis: v=2.4 cv=YvQPR5YX c=1 sm=1 tr=0 ts=682add4c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Z0Ml1a-pTqFXQDG8VyoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01

Priority flow control is not supported for LBK and SDP vf. This patch
adds support to not add dcbnl_ops for LBK and SDP vf.

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 7ef3ba477d49..9b28be4c4a5d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -729,9 +729,12 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 #ifdef CONFIG_DCB
-	err = otx2_dcbnl_set_ops(netdev);
-	if (err)
-		goto err_free_zc_bmap;
+	/* Priority flow control is not supported for LBK and SDP vf(s) */
+	if (!(is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev))) {
+		err = otx2_dcbnl_set_ops(netdev);
+		if (err)
+			goto err_free_zc_bmap;
+	}
 #endif
 	otx2_qos_init(vf, qos_txqs);
 
-- 
2.25.1


