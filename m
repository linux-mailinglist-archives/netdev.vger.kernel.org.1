Return-Path: <netdev+bounces-251037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECECD3A433
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780A23079687
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C4355819;
	Mon, 19 Jan 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L87gBdmc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910034BA2E;
	Mon, 19 Jan 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817016; cv=none; b=PbPISEvxBFABPpMI2ZBIRnEtd4k1BSM7OlWOuRqBSwdf1NlMoL5xh0Ev+WFKDaukoyG8iJzRydQ5KE87nBIs4KvIK1V4SHfJSkX5udQscPsvhSdgwQ0QO105rKBKiAradND9MW24Yn8gO+2qpnhx6PgIjuNlN+Co164ggrT7kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817016; c=relaxed/simple;
	bh=Yh2sPa5/vhGxXrxveKKyGlWyAO1qvRl91PZumSYriI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmoSC2xY162mBvwY1c6JfoEe5JNtRiOHwwif+keQipQUoiJcvzuF1K19F1DHOenm2N/vakI+lgAie2ZiBiFE6Jhck5fbJKFtAEV2Y7D7tzstk4PnONQgeuAO3lK7/zYcCOyT6IkScxTr2i7rqER5BCxl5AZtEle4d2d3aV75WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L87gBdmc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INVx6D3108907;
	Mon, 19 Jan 2026 02:03:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=W3OwKMDCHMLLcTx+qOCvKLB
	sFd22lChdJ3Pk248tBH0=; b=L87gBdmcTMPM39psvizSCLgv8nfTi8BFUMEbSeK
	DlFWND+XM3LlrfORDsoonFGiN7CHyLI+vQFPyfn+I2n4FO9rw7Ewz5cGTr+IBlyw
	uevW1Ffjh7ZzDyn6nDlwXjpK1CGcmy5ZMxBLfiMQmFRyl/k49QI1MnhZSEork9d9
	utAq8nKcRHipPDn1qGbeknHm96eo53epmdLTtQiZZH8lf3F82P9TBKLW+fM1wEMp
	6LWWsITIyKBAl28Zl9cjdMvtwBdmLuCVDOQeOk9e3OfuexN3gcBgVW+hxji22PbV
	fsum43mVmhRG2w5i9RKcuqOU/6CZlXAlQn+yReUrDsZrnqA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4br8nnb2w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 02:02:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Jan 2026 02:03:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Jan 2026 02:03:14 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 704463F70A3;
	Mon, 19 Jan 2026 02:02:53 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, Suman Ghosh <sumang@marvell.com>,
        Simon
 Horman <horms@kernel.org>,
        "Gerhard Engleder"
	<gerhard@engleder-embedded.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marek Majtyka <alardam@gmail.com>
Subject: [net Patch] Octeontx2-pf: Update xdp features
Date: Mon, 19 Jan 2026 15:32:22 +0530
Message-ID: <20260119100222.2267925-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n5_Pg0paEpCeuUtEgXCyweOsFxVV-3ik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4MiBTYWx0ZWRfX45u33NEqsoSj
 KR343koRm1eYUJwkpljCUdTU25XR5CXtGTpcuMh41VJ1nO93dvYhteTDu9XVke/a3iccQl4FAo6
 NB8h6O9pgYNwNp+Eoo/vk4TeWLCfDazJ0GxLmshS/QWwwBKl8ZvsnT+RwXUKy4oTMbwlewMh9+5
 CzY0B3LuQQqEfcLjJqfPgvVxJCb6PHWCOplCAzIeFN6vzOM0LxEk+/yXSYW0q8QI4hEMTt+ubv5
 ia3Fp4p2kN/+MpIhri3Xgum8zm9ASZTA6nu9dJSpsxUVMhfl20crZ3S7KEOCI26CDJ+gxB9jMYp
 o18RgbTOuiSrQE8ToS4ZBYThXBtPOweGASC4N3kKeMhb57H0sZRYmV5eDBDHu4HmEWtdy8B9i7r
 BVc8luqSTWXEAbiXVJZArV/xNNVrG4jIgT9SeAvsvGKxc56S2PIJ9qxXSKO8AbQEdsry0XUdKir
 Wj0QbcrYfdYjJVLHIOA==
X-Proofpoint-GUID: n5_Pg0paEpCeuUtEgXCyweOsFxVV-3ik
X-Authority-Analysis: v=2.4 cv=FcM6BZ+6 c=1 sm=1 tr=0 ts=696e0153 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=T1dLa4ATUjSZDEheGvQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01

In recent testing, verification of XDP_REDIRECT and zero-copy features
failed because the driver is not setting the corresponding feature flags.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a7feb4c392b3..6b2d8559f0eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3249,7 +3249,9 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	netdev->watchdog_timeo = OTX2_TX_TIMEOUT;
 
 	netdev->netdev_ops = &otx2_netdev_ops;
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
-- 
2.34.1


