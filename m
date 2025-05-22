Return-Path: <netdev+bounces-192627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B78AC08FA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F97B5DFB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC7287505;
	Thu, 22 May 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="edMA7H0G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A89286D65;
	Thu, 22 May 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907285; cv=none; b=kbg18/ywF6YDzKPX+CRjUyfWqUnN08I2L/4VfYjjzgVu01MjJpQjAX0eZUKlFvQfKKPEexPnrEuQdg+eoUg3H4BB1B3nGZY0ZK5iPmAhucN5vSr8AZGNi9b1mPd2FLXYGV07a7PrM4PeDfcoivyLIst0fYrbWSrw9bKmpU0ydMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907285; c=relaxed/simple;
	bh=G9A/bzc76W4/RQ4cu1m8gGGqgrDhVN9o7y4ose9SmmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxdLp+/saeHOqD0MFpOm7SR9fP1ZmWbNd29F55Sx4fsGlTwLVLS0ONnped8eBFCpZ5PjXox+g2Suo228q5TMVV+TbsrILLJM5q5WxApfJjvzfKRf2OwybBtVw6QIGEaycj9XlcfuS2UkXBQW8JYoK4a+gyJ6Mq9XrA7DvE2s7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=edMA7H0G; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9H80q007487;
	Thu, 22 May 2025 02:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=TvoyCFumHT95HRjOX9WJN6h
	LU3in6RU6bCAECQQ4Cb4=; b=edMA7H0Gtn1ad9cnDszkszmQ5JVNV5hm6we/RyB
	FRcQHKoqy4VH8KpSE9Qn9atHfL7QsXiyZNNDLucWm+hkV+3BA23wA0w72x2Itn8z
	FomJ9jcInZLVawG2vM4pzE+Jfw1me70VJgiz6xvKUW0NangR1Nxa8wixnEa6uKea
	9LDVkkmTIeRBwIMNqY1eqvNcjeB2q0U/M6KbNsQknL+OQP0zXxcbBSIRgb30UisZ
	GVlPDJEGB0ouRkQe2ANUFYDy42TxCWtuBrjTsr2m4SGGP0R+F8+Cd7/+H7JURrW6
	NnkqTpTwdzdXujAPo3TWcpuAbsp2nB8ZjIEGze4HdX+jg0A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46t15jr1sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 02:47:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 May 2025 02:47:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 May 2025 02:47:50 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 64FD65B694A;
	Thu, 22 May 2025 02:47:45 -0700 (PDT)
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
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>
Subject: [net Patch v2] octeontx2-pf: QOS: Perform cache sync on send queue teardown
Date: Thu, 22 May 2025 15:17:41 +0530
Message-ID: <20250522094742.1498295-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8SSgxDmwSVKfxR3bSTYvgOrrfv8XvJ8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5OCBTYWx0ZWRfXzNXzM0yDULKr CNyZmokn79kMP+TQyhwI353peadXqT6fIVoAPOQSYOV86fWhfyhy8VFSo7ZsUyrsMb68Ogmq7vw OkRqoy+qUjpj2rVN/2tyEMrIor8gXUUcX2fkirzHY1hXwuQiGF/lXIR6GVZ7AWGMwEzq0aDdRyy
 oKOrXH4dZ/DPKVBbM2Y6mq7ZUtQGLo7rOYHZ07phn6yAEN27jeIx+zRHOLO0x0cZPnIKDS+T53y Vw0ECvOKogO7hUCqAvt+COl0WlfnwQGxwxD3EQbEC7ZcvzOcfdfxUKcGTIfarwdP85PY/VBOsiu Ye0Uwklbc8AfBiL9WNZ/UtWc3otGONmbt4EH3Zn88ubzhW2xWb7E1N8i5V+k+waeCzeiZVDhfkl
 BF3YSO3Grad7n7p2nILVF+mduaVYULv0HxOof+SUDeNWJdSFEsNms8s6/E8NgMpMV1e1+865
X-Authority-Analysis: v=2.4 cv=HOrDFptv c=1 sm=1 tr=0 ts=682ef2c7 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=QY2NK7KhZwvVfJmNNlwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 8SSgxDmwSVKfxR3bSTYvgOrrfv8XvJ8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01

QOS is designed to create a new send queue whenever  a class
is created, ensuring proper shaping and scheduling. However,
when multiple send queues are created and deleted in a loop,
SMMU errors are observed.

This patch addresses the issue by performing an data cache sync
during the teardown of QOS send queues.

Fixes: ab6dddd2a669 ("octeontx2-pf: qos send queues management")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
v2: Push the change to net

 .../ethernet/marvell/octeontx2/nic/qos_sq.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index c5dbae0e513b..58d572ce08ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -256,6 +256,26 @@ int otx2_qos_enable_sq(struct otx2_nic *pfvf, int qidx)
 	return err;
 }
 
+static int otx2_qos_nix_npa_ndc_sync(struct otx2_nic *pfvf)
+{
+	struct ndc_sync_op *req;
+	int rc;
+
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_ndc_sync_op(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->nix_lf_tx_sync = true;
+	req->npa_lf_sync = true;
+	rc = otx2_sync_mbox_msg(&pfvf->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+	return rc;
+}
+
 void otx2_qos_disable_sq(struct otx2_nic *pfvf, int qidx)
 {
 	struct otx2_qset *qset = &pfvf->qset;
@@ -285,6 +305,8 @@ void otx2_qos_disable_sq(struct otx2_nic *pfvf, int qidx)
 
 	otx2_qos_sqb_flush(pfvf, sq_idx);
 	otx2_smq_flush(pfvf, otx2_get_smq_idx(pfvf, sq_idx));
+	/* NIX/NPA NDC sync */
+	otx2_qos_nix_npa_ndc_sync(pfvf);
 	otx2_cleanup_tx_cqes(pfvf, cq);
 
 	mutex_lock(&pfvf->mbox.lock);
-- 
2.34.1


