Return-Path: <netdev+bounces-124529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FD969DE8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC21282B42
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162A1D86EE;
	Tue,  3 Sep 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SZ0HkTJh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965A1D0974;
	Tue,  3 Sep 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367274; cv=none; b=je5JEmq1rrWZkB4VGgPbLxBtjy3EHGjCsgrLHoaDkFNB1UxmfbBgXk7RLUOBz72r/riyGOLhkBKKhl/noCA5jpaYta6xoP7xfer5ReNnkopO3JfCpRlBYisizEGFD5xVZsJ0O/ZbENQilKVUHUr000UlyEq4kOk44gtYn98eq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367274; c=relaxed/simple;
	bh=8NJQ61+av5eIoyPOg2e9opxq7Ypltcr9Mj+quRtW50U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj5YTE8Y3Cn35WHuTLCentUq2CqDdDvePheKnqdjL2CTbi6WhEmU6CJi6ASkBHONCLTP/QKKHGVEuXTx7V7p/8ZOIBH2D+Py3eCogmqMyMoz7fithhyQJoaN7hRapb5+J8/Ml4tym8rbw+KRak98ym3HGaBeLYPsa6dw5dVdjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SZ0HkTJh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48396iZ4019306;
	Tue, 3 Sep 2024 05:41:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=svGo0WKor6EHMlc0Mp/BNHON3
	sznQQeTqeLkbA7QXzE=; b=SZ0HkTJhaIOiIvZ6+bLfGHg5dzTiYfSLPTcf9IgAR
	1yZShCElxcM9icCdSy6ElZs1mmcuGxLe7MC5cx9/CCkn2RGIxJQI0YxSp3hnbyEN
	nfyJSHHLQ3GfRLw0U8ISx3vW3r0F+X5xtAmdxXvlHjOW0lTyLRLo/RRbLg16eV+X
	W6nWuR06kKAdlxzIgMJ7K4Hdlssm035ylk0LK+ZTZstPDGa2OpFORzsseIri+5Oi
	I5v7ZidaNaDWnfBtYguQdysdWaLEaavUzthPSfo/a9c7NOq8RhuiBGIp0bcmvemq
	6vFpuNlXRpsjQqVYiKWZnzT4Kqqst58QSp4rCtE6D9XAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41dyhmrkva-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 05:41:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Sep 2024 05:41:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Sep 2024 05:41:05 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 98B0A3F70E4;
	Tue,  3 Sep 2024 05:41:01 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 3/4] octeontx2-pf: Reuse PF max mtu value
Date: Tue, 3 Sep 2024 18:10:47 +0530
Message-ID: <20240903124048.14235-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240903124048.14235-1-gakula@marvell.com>
References: <20240903124048.14235-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OzTyhe7Ja-paMk14ixmFaaj_SvMd7t0p
X-Proofpoint-GUID: OzTyhe7Ja-paMk14ixmFaaj_SvMd7t0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

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
index 68addc975113..5bb6db5a3a73 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3103,6 +3103,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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


