Return-Path: <netdev+bounces-192531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF8AC0472
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F1DA21E43
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BC22170F;
	Thu, 22 May 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VXGzZVY7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39222155F
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894569; cv=none; b=qI7HEHzepggK4fWbU10sJI/hwQS7baeyBy33ttWKgN+KWk3n97SnETeTitJN/J6I3NF0GdxFIFw7mT7izb98G1F6r7RehIIAIyCPUoykDekGgs1vYDtzjo9hDHiMcjTw44z+Z2xzkS74td5qOSIq0ZkoJoJI3raMwvsNHsPPJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894569; c=relaxed/simple;
	bh=/XyUgeXXxKU0BkZY7YzR3X4O9ySO8dItg/ybqv8/+qg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aEsGN/KK6VDR3W/WXK9DMTeIZ1kvc7kBAipKOAWq79SzRPBHCm9ofF/C9XWePg2fJnKMSfVyLh5Uf58U5ykvETfOKg6jx4u51cde72cKBTj0hHSHpZEM7zjYW3tCjmGrim+c/mcgo53rtRrvYHgEj+dfgL+GszXd22uMwOPCKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VXGzZVY7; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M5Jgse013402;
	Wed, 21 May 2025 23:15:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=zgD7mD36mu3a468bQxezFrZ/l0/DFW5ffr8Jkxihllo=; b=VXG
	zZVY7QJKSL6TNrft+jflbp1NiwgOpl/KqwyUZTKEwq6orqcQkDvlfcitxmqsdpsM
	v5gnSTiukpD7Yg21PqIpYSow7ddtBXV+oprzN5K8njMiiDfCUjJwb4/6pWx3/iBn
	nfG4wkhBVIXzGQ8E3Ns92JGAZ0gGOiClbQkkXctL9QvDBcjHQvpfXR3X+GezFmGA
	mXA47ZzWYXywWvQ0pwxul0oIbq2OEUuaVaSellFFkX8clF2FPCiy2ijeEZYaSjs6
	KWZfjmOjNbmC7o+bGcLlWaH2cqsFPT27nNjr5s8EGbVIF6c0iwpGbS9R9kq7VQfs
	n0TWYxKp3axRDJtcHFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46swp682se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 23:15:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 23:15:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 23:15:56 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 938563F708A;
	Wed, 21 May 2025 23:15:51 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <sd@queasysnail.net>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 2/2] octeontx2-pf: macsec: Get MACSEC capability flag from AF
Date: Thu, 22 May 2025 11:45:48 +0530
Message-ID: <1747894548-4657-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: t-lcX3PMxNkO0XbewjH514gByAOfaDDb
X-Authority-Analysis: v=2.4 cv=DO+P4zNb c=1 sm=1 tr=0 ts=682ec11d cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=HCoohpATzO-NyKTAk6kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA2MSBTYWx0ZWRfX33G8sRXGxGEF 444o3xcJHH/mFJo5w3hNMZqh2dam49JRqaOIuYTuxHRqDx8KUHOn7KbruOLqWggEHEsJGvn4/Cl zi3nJLZw015IjxOimFmOhBA/Cjk2f8PPAmhjffGuaN4As60b9Fp1+7u/XEDYymOPR+HJZxK202W
 D2Yp3LX8LucQkrbtIR28VgRXkcFRwtNRZAQIc4epfO07OqwnapJPBn67cUnW2eowOp1tQyUbFm0 vhPYL9SOufPpc6BuFzOMpZ5HC7a1w6F9qxw503MZMd8qdRRZJ4DHhKeOZRjfejKRwD6bHEiCJtX LVyS+vPUUTb1c3Rj76fMdGh8pJUtMaPND6DeOhrWkuF/M8HzU9tq5648/nNxjHrovW5iJb8+KCW
 v9pWmze+E3z0TeT0tH+caJcNHyz9GNKRIeiIIVIm3qY5jQl/7WZmcJIneelAr2ijSTOPdGq/
X-Proofpoint-ORIG-GUID: t-lcX3PMxNkO0XbewjH514gByAOfaDDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01

The presence of MACSEC block is currently figured out based
on the running silicon variant. This may not be correct all
the times since the MACSEC block can be fused out. Hence get
the macsec info from AF via mailbox.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index 6a38f91..ca0e6ab1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -632,9 +632,6 @@ static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
 		__set_bit(CN10K_PTP_ONESTEP, &hw->cap_flag);
 		__set_bit(QOS_CIR_PIR_SUPPORT, &hw->cap_flag);
 	}
-
-	if (is_dev_cn10kb(pfvf->pdev))
-		__set_bit(CN10K_HW_MACSEC, &hw->cap_flag);
 }
 
 /* Register read/write APIs */
@@ -1046,6 +1043,7 @@ void otx2_disable_napi(struct otx2_nic *pf);
 irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
 int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
 int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
+int otx2_set_hw_capabilities(struct otx2_nic *pfvf);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index d79b4b3..db7c466 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3144,6 +3144,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_ptp_destroy;
 
+	otx2_set_hw_capabilities(pf);
+
 	err = cn10k_mcs_init(pf);
 	if (err)
 		goto err_del_mcam_entries;
-- 
2.7.4


