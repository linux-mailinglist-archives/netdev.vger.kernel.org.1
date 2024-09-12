Return-Path: <netdev+bounces-127693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC279761B8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71330B21DA2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A0190073;
	Thu, 12 Sep 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wk0vuikn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B318E379;
	Thu, 12 Sep 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123250; cv=none; b=PJsyrxr2/E+8TF07qFufs1WKwEQgJ/XK4f6QGCQC8WJSsxRY+Mj5NRQSsNA1kDlveOq4wfLd/Nhx+1YOMt0XGbAU7Wrht4eQrTukvI5/9QoZT+QqyAtuZG8/vTklkuW+V5qq1aTjzEUnuSTExQHOFrDFY+FT8mNK7u1Go4Uir8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123250; c=relaxed/simple;
	bh=/25XrHf2Ey0nLVjS4rQYYFy0vcK2WZDh9ovvLGYLIO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdjxoomaugtT2JPMIcG9+w+lYhXtAu4QBXiM97Ighk6dKrGdYwyaeSJSKi46aPXPjyYops3upoFT6X3rDoA4w92r0rRa05z43jaWZdvbxABZkjy+Hc2GEIHnsvNZewFazajXbs3Crl8tnyOyT+Mg6w4YlhIpvwuRPrvgdy91fgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wk0vuikn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4P8YP001926;
	Wed, 11 Sep 2024 23:40:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YqJCPTHuo4x0NraPsIKvJezVh
	WJPk1vZerVfRMqJxQY=; b=Wk0vuiknx/VO3MpPUICZpL0F6NiJ46Cl6V6VYHevK
	WuZncZOtTBU9sss3JSMeE0jzEOuygAxlSKTKPwKPJEfGPyf6SjbREhJOkrUvd9YJ
	ONB6TKuXnZxOdPoV6vNs746ldy4g6Uov2nX6kCBTaRGf/W56lzU2CIFE9rgtCea8
	FJ5tz+Qzu0Tf3Nzj3PIIbqOkdrV5lkkHPJRNDaBXjehZRlb1QHaZ0+4QAwNxZiWu
	xV0kkrTt7JSTxbN5XlxNAKx8xTb/urA/QIZjXPsRHq6yu3yMbNSZVZpc9cuN3v0w
	BHs9EFmGDtdiKGzsGCs1U4tll+QuQNPpJrARjNFoZmJfw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8prd2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 23:40:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 23:40:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 23:40:33 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id E06655E6864;
	Wed, 11 Sep 2024 23:40:29 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 3/4] octeontx2-pf: Reuse PF max mtu value
Date: Thu, 12 Sep 2024 12:10:16 +0530
Message-ID: <20240912064017.4429-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240912064017.4429-1-gakula@marvell.com>
References: <20240912064017.4429-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nOhxREnUY8SUNaJQgC_GurX0gk0-SjxS
X-Proofpoint-GUID: nOhxREnUY8SUNaJQgC_GurX0gk0-SjxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Reuse the maximum support HW MTU value that is fetch during probe.
Instead of fetching through mbox each time mtu is changed as the
value is fixed for interface.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c     | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c     | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..34e76cfd941b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -227,7 +227,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 	u16 maxlen;
 	int err;
 
-	maxlen = otx2_get_max_mtu(pfvf) + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
+	maxlen = pfvf->hw.max_mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
 
 	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_nix_set_hw_frs(&pfvf->mbox);
@@ -236,7 +236,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 		return -ENOMEM;
 	}
 
-	req->maxlen = pfvf->netdev->mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
+	req->maxlen = mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
 
 	/* Use max receive length supported by hardware for loopback devices */
 	if (is_otx2_lbkvf(pfvf->pdev))
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index df548aeffecf..b36b87dae2cb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -228,6 +228,7 @@ struct otx2_hw {
 	u16			txschq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16			matchall_ipolicer;
 	u32			dwrr_mtu;
+	u32			max_mtu;
 	u8			smq_link_type;
 
 	/* HW settings, coalescing etc */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b7082a154c34..962583277f7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3104,6 +3104,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
+	hw->max_mtu = netdev->max_mtu;
 
 	/* reset CGX/RPM MAC stats */
 	otx2_reset_mac_stats(pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 99fcc5661674..79a8acac6283 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -671,6 +671,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(vf);
+	hw->max_mtu = netdev->max_mtu;
 
 	/* To distinguish, for LBK VFs set netdev name explicitly */
 	if (is_otx2_lbkvf(vf->pdev)) {
-- 
2.25.1


