Return-Path: <netdev+bounces-191778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43256ABD343
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AF84A71B8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DD2673B5;
	Tue, 20 May 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G9824tmF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7872263F44;
	Tue, 20 May 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733006; cv=none; b=fZCjc9ap78jlaab72KpbKJ/lLj0bJ0w+VA2iTm6dskEUqPIf2zF07UVkUBzaNLrufbbWIjz/aY/cPsbxgb75waf169J1sLtcKOvhvdAffUkeMdDMweodXq7Ujhgu9/SnF8w4ih6g+6H2fBun3PqWs66YLQuGL6qLL24QfNVKiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733006; c=relaxed/simple;
	bh=f6uMN/qfgFSUel7hrqq9RGFK8nG0PVaWF4Jy5LR6W4o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZT+DvbOt2PxcU/ai7DO5JlwNQDEAjEI1klhmYzIE/CiZER9RgXWhTMrB48BI6rDNPZMS5nPtF+yitH22LU0KBCjB0AHU31ddjIYElKoOjDrqyucLkqVTFNR2o0jqOVtfIEq4JF8LvmwFuoH3Gnk2XsKK0FUUBGQdE2UlZ+EUih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G9824tmF; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JHr1GM001904;
	Tue, 20 May 2025 02:23:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=MXCKhHkSP7si1f7Y5i5VsCh
	4Ng2sFD41PgdisHGznVE=; b=G9824tmFdPal5EJ89rSbJSHy7QQJb1dM9uN/ODC
	sjcIjm16bCahjosMmYzj3tEIdoDh1EcfQn+1eq+BmgMTtFf+78xaBBbVGst19DjA
	mMqKyTRfHMV+AehpEF3Sp0LEWDgNi/ZOSk9Cqiro+jZtm9NlrShVGxEOjqI/viQC
	JDbDHPVcCfcd0am+JGzMy6oIE7mL1ZgmFJVma5C8J1iKMw2U7VcweNUv+x6r4zA7
	9wmkyZ79hjN7mnryHsmxGh89VV/k56rYwypuMvD9U537uXMd0+shKPkfBlyf8owy
	5nvUrZP+Mhp1OoFzUYebUWHkOr7rK62Y+yE/vyHG82j1njA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fcgq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 02:23:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 02:23:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 02:23:00 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 2EC0F3F7061;
	Tue, 20 May 2025 02:22:55 -0700 (PDT)
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
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [net-next] octeontx2-pf: QOS: Perform cache sync on send queue teardown
Date: Tue, 20 May 2025 14:52:48 +0530
Message-ID: <20250520092248.1102707-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682c49f5 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=QY2NK7KhZwvVfJmNNlwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: R1i0RygRbEliO-PJRScBckPEThoCfpn0
X-Proofpoint-ORIG-GUID: R1i0RygRbEliO-PJRScBckPEThoCfpn0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3NiBTYWx0ZWRfX7QMj2kpUSwTk L1yfvBbF9eKdCrM9iEXvV7YCB40vXq/Ha9mVhE1fj7rirMGRLE+86cPcnKoIUoeB0r2rgPOrTG7 OBhCCi2Ig8d4hJ8YjjfgQHOryzemT21MSuOfBkk0xSaGUOx9qyzkhLqAa9YhyrYWlkHYxPU9Hb1
 nbKfFrIxSB+jRG/9HgdaPfKMVcA9u9GmnRsLxUm6UZJi29WyUClTVCV7ywoaQNgnOttXOtmNIl5 XVeT0DrbouKJP+CXiqxXwv846jOBU+8sllNslYoKC4MmlrHRlP7AAlKlfCdOEciWqewYHM/G0eC UOrIFOtQKobS5VCy2BKXK1aH+MexCTcDfJ9Nsun2+92VJCgRMc7ok7AEQa2cvCJ1hhMJ34DffT3
 54IWn37T/KGBjfYc1Tr1Jrt1emfxUr+H3DcktuWHbvnVtZ7F38G5XzXkmLXMv0EZ2xvWYww2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01

QOS is designed to create a new send queue whenever  a class
is created, ensuring proper shaping and scheduling. However,
when multiple send queues are created and deleted in a loop,
SMMU errors are observed.

This patch addresses the issue by performing an data cache sync
during the teardown of QOS send queues.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
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


