Return-Path: <netdev+bounces-189506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5EAB26AE
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 06:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC72189CE30
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CF18BBBB;
	Sun, 11 May 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jF8A+QXN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9A17555
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746938451; cv=none; b=iApEtqGDs+CRAnyt3gnYN9ktuU2u20obwqY7AfOasD+MkyUGZ6qFqDV3vCGL/l2C4tu9iOrl0nhXk1RctQ5ESghx/A+FC1oA32awIslijaSgMr4Nd4PT7Qh2piDA957IawJBId3kkN4iV36FbZiTt2r3QLkU0OWt1H49UxA2KHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746938451; c=relaxed/simple;
	bh=fiUYcK0gnjTGfY55XF0VUy7vvwlCOhNOb5sJZnt3xqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgIYlhTRlcK8/EnJubpbYmP8KeVKXwuVhcSQhxS7NkySiOApmN4Olfx6ejzAgyBKzdVpN0TloEehsTc2xNR5UfuJd9scNvNIjPFJPknXmcUuEQNL8NkJOd/p5nMQRUAIo/7Rrx92NfvMqwcmvMklVFzBKwHNXaBVEjVH6o5AlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jF8A+QXN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54B4QEDr012305;
	Sat, 10 May 2025 21:40:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cK3QE0AVTDzNaLDgdkB1WJWmL
	fjcfVUZJOnMnC1TA30=; b=jF8A+QXN773m9queJPZkVRYUomo+85Yupk1HFwg3F
	JQhBgLE/jfN5m1XEJo9y5ahL7TqNVu4YrpSSQ2Bgz67GYUupdVhj9kl8zVaDxUUe
	mfQJM0OWbCC1C6W4hkTZo0IItqKpLB3jK6DDQZ8ck7OuMLycoqmbQndKPCeY9Rkm
	R/2Pt0on8DtgxAsgBvVGof5IyCser4h/p0etr0mQ7L25gBRwwYi48L3TlL4nppcz
	uoPaBnj4Ks9fNDSxQY1DcaYFedTj7CSBhUsvOzoGe71WYrkmKTizQwNrd2IOq0Or
	bwdip2WcESjZiQUBvCUTahqcyqNdN/AoHfYpO5tBJqN6g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46j6aj8ufu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 May 2025 21:40:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 21:40:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 21:40:34 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id E326A3F704A;
	Sat, 10 May 2025 21:40:29 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH 2/2] octeontx2-pf: macsec: Get MACSEC capability flag from AF
Date: Sun, 11 May 2025 10:10:03 +0530
Message-ID: <1746938403-6667-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
References: <1746938403-6667-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ALcjjCp/ c=1 sm=1 tr=0 ts=68202a43 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=HCoohpATzO-NyKTAk6kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KJ7SGv4oQ9ms09jQZEJyvNZBEjba9KD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDA0NCBTYWx0ZWRfX2BoB6aPJzoak tZPXKHRPyd6W1M3B/WCLAgojOBNrmLTlQPT7XzFNaTTaL/0uKCPjffdoqFRi4S7g8xtAgWqKLvE w8M8XS/tBoJmmMdFVO4CxzOmUVl9iIE7y/yJZsDNrbmUVm1xOCxu2GOIkIAAqcBgIHrT8VRMwNi
 orSdJDHV2qHIpXgygkxKsN9WxePjsHDt/wrCb8jOoN13W9s3gXEYhsUzSzNTkoJS1sTJxFQRBKm H+Xc9Jk9mc8zqNBPFegx1SQ3lkwNv4upP2zIryhQqgeNcbNani3fFeCzKKqaMlJu57/QHs0L2V2 ORu2Zs23bHEuvVh8pbKwck5YsXCBIKFCrqug+B8rJhtEqIivnqE5gZZkmGYzzZCkQJ1/p6HSrLv
 wiS+IH4BNSrubybNFL/yZ6KB677pKse/2alXoirOevna/BD9t/8a2C9EZh8yQPSHF/pYnpi1
X-Proofpoint-GUID: KJ7SGv4oQ9ms09jQZEJyvNZBEjba9KD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_01,2025-05-09_01,2025-02-21_01

The presence of MACSEC block is currently figured out based
on the running silicon variant. This may not be correct all
the times since the MACSEC block can be fused out. Hence get
the macsec info from AF via mailbox.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 37 ++++++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  2 ++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 84cd029..6f57258 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -2055,6 +2055,43 @@ int otx2_handle_ntuple_tc_features(struct net_device *netdev, netdev_features_t
 }
 EXPORT_SYMBOL(otx2_handle_ntuple_tc_features);
 
+int otx2_set_hw_capabilities(struct otx2_nic *pfvf)
+{
+	struct mbox *mbox = &pfvf->mbox;
+	struct otx2_hw *hw = &pfvf->hw;
+	struct get_hw_cap_rsp *rsp;
+	struct msg_req *req;
+	int ret = -ENOMEM;
+
+	mutex_lock(&mbox->lock);
+
+	req = otx2_mbox_alloc_msg_get_hw_cap(mbox);
+	if (!req)
+		goto fail;
+
+	ret = otx2_sync_mbox_msg(mbox);
+	if (ret)
+		goto fail;
+
+	rsp = (struct get_hw_cap_rsp *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
+							 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	if (rsp->hw_caps & HW_CAP_MACSEC)
+		__set_bit(CN10K_HW_MACSEC, &hw->cap_flag);
+
+	mutex_unlock(&mbox->lock);
+
+	return 0;
+fail:
+	dev_err(pfvf->dev, "Cannot get MACSEC capability from AF\n");
+	mutex_unlock(&mbox->lock);
+	return ret;
+}
+
 #define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
 int __weak								\
 otx2_mbox_up_handler_ ## _fn_name(struct otx2_nic *pfvf,		\
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 7e3ddb0..7d0e39d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -631,9 +631,6 @@ static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
 		__set_bit(CN10K_PTP_ONESTEP, &hw->cap_flag);
 		__set_bit(QOS_CIR_PIR_SUPPORT, &hw->cap_flag);
 	}
-
-	if (is_dev_cn10kb(pfvf->pdev))
-		__set_bit(CN10K_HW_MACSEC, &hw->cap_flag);
 }
 
 /* Register read/write APIs */
@@ -1043,6 +1040,7 @@ void otx2_disable_napi(struct otx2_nic *pf);
 irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
 int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
 int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
+int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 0aee8e3..a8ad4a2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3126,6 +3126,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_ptp_destroy;
 
+	otx2_set_hw_capabilities(pf);
+
 	err = cn10k_mcs_init(pf);
 	if (err)
 		goto err_del_mcam_entries;
-- 
2.7.4


