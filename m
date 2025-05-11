Return-Path: <netdev+bounces-189526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B964AB2876
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F254D3B6BFD
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25122DF84;
	Sun, 11 May 2025 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jwLWJYfi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470622D7AC
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969794; cv=none; b=qw6QhgC3uQCxC18vNBTXAcRQD91WwOHEHiyZK+cOwgdtDQ4oLxFwhMk5qbMhuas818BlDRRonRLLCIkObnP68z6FclLPuV+UJc0S6AKZ+V+LYib7pcAx3t+3bAh5ZfrjTl4WOAvaC0CQHZemh2GT0ALfZpYmsHt277wcRQXY38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969794; c=relaxed/simple;
	bh=fiUYcK0gnjTGfY55XF0VUy7vvwlCOhNOb5sJZnt3xqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MR17lnbOManqagX1J6S7rtNJWdLZaHCLIUF6nUgPVJDxLLB3XAXBE1FEBHVn2jb03RzKvu12nVLCvIQCLlYgQzhk0v653eoIoeFrnEw0e/ckCm0BGdHQjlHOjature6UKtDN7mdW5J+4AmWWt6QLwnuT5MjbFTnJkq2ZwTwTPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jwLWJYfi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BBo437028223;
	Sun, 11 May 2025 06:23:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cK3QE0AVTDzNaLDgdkB1WJWmL
	fjcfVUZJOnMnC1TA30=; b=jwLWJYfi8pGmu9HvIgTs74iyrDuiqH6OM1nSrB70d
	MsWiavRoxxZTOEleN3w7J2WxViK19x9qdjIoQV/F+Y+dZ5/ZXJd+3gWmvXkwFBIs
	Xp55wEvflJXdAozZyc2oT/bC5fvhk4lcF/Lbic5P7rOEe6Nnkxfr+0835DzvggSP
	bDm3Q4l1I1S6vyFfPDLpeCPjSLxUYbJ9Xo8OXcYPQ50mwC28svyC50Z7+QSXPUlT
	z2T8WGqpCFZR9T2pvB52Pc19pcoGkCxqiNac8/pWXd1UKkzL6v4zI+BgjTLvnDw0
	Onu+FgmXTOVd+dinIKWC2TevIO/7HiRWUJlNHqhyplD7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ju2b82uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 06:23:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 May 2025 06:23:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 11 May 2025 06:23:04 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id C1A533F7087;
	Sun, 11 May 2025 06:22:59 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 PATCH 2/2] octeontx2-pf: macsec: Get MACSEC capability flag from AF
Date: Sun, 11 May 2025 18:52:47 +0530
Message-ID: <1746969767-13129-3-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cfewLWTO3wQPq-TKOx1T2UJze4ndQGJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDEzNyBTYWx0ZWRfX1+3uuRTxFG+I wTw47n/TNAtgv4ZhENcFxMIrhsY0jBn1OQpyjDTlyEa2mai6mmHj0VfXt+tFo+oxw7EYfZ+Huuw gdOtDZsByDJCj+0wATNkHyrJtX2gFnwOvdBzDOr4z4SEgeT20MpT0ArYEU4RjByY+XlJBIhE1o1
 0NLusJFs769TSXNOTpHdgPPhO69+gYDWeI/yCPSD/xKV8oxO5++JPFUiRgp3dwsU/NvcerKuldc PzGVkyy5vwUXEFKZdgxLVzTlPKO1KR4OSNKrc3GHgIkgbHyvvjmYhv+pNoBrzlZIKbKTYeUj12P XseV1Z1/eRcWnKaj+0j9a1VKauYDOVzZcNjAY/TrJgouSD3S9NXaKssPq19YqXnJ6jFm9sSx7SX
 ZcaEVVsiof/VPH5qIizDINY6aziIz5Ln0AmHmBET0qzKqwaTXe1+prm/SpNjgjNaS9ZkhFf1
X-Authority-Analysis: v=2.4 cv=DY0XqutW c=1 sm=1 tr=0 ts=6820a4b9 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=HCoohpATzO-NyKTAk6kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: cfewLWTO3wQPq-TKOx1T2UJze4ndQGJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_05,2025-05-09_01,2025-02-21_01

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


