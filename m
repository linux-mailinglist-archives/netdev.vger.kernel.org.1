Return-Path: <netdev+bounces-138352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8559ACFF6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E2E1F216BD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9781CBE8C;
	Wed, 23 Oct 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e7nsPJ+P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302811CB326;
	Wed, 23 Oct 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700351; cv=none; b=LzTPTT7kGacpfvRdMKVShcR15Iy62A911GMK1iCYk/fBIMVxRoSptsRWYETBV+x3HTgKV+ZyEFJocCKmeLa6Iq0GhTx9Dgg+0lZqZpMDYlq5y8lpGi9CdZSvneSGIQp1zMlj877+x0YhEsT1frAbMyvOchES6vq1tALN74M8ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700351; c=relaxed/simple;
	bh=gzewx5WfmwKoFiDiG1NOQfL+DnzBF92ql5mo94d5PVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2XQZfY0NhIdjInEKKkEQTHwihWczeua41OSF1lpwvQU9satIstktzhU7q0VlGx+Hm7CPYq6n8TZv/EVbFh4cXfenSJFZWWfj0Cp7z8UrfrxHQtbXL7+BCZ0xcoZdWFoIWGjfg4HeED7IB3rpncaHocX63L/RJ9Lymydf0gZNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e7nsPJ+P; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9MnJv027075;
	Wed, 23 Oct 2024 09:19:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7XCaK0H8722+PuN3p7WTaiuhw
	MkNfv+uAAt8PDqbBas=; b=e7nsPJ+PFYzE0BFAC+0i1E1w0U0+D4Fzy2RwIYUV0
	o7AY7Aw19GRCKO5zh3YfCLSb0vjU5M/MosqIyCHXlDWTgiTIqIcB5M+VSbePCfob
	J0lNE/iWiUn8jg8lPJzlOew53fi/c1PZHi+1+TQLJTQxQY4vrfYJKfI8QUucuntZ
	yA24EA3LctSQeOZRwtDMUcD3iNXF/QyZd6FnR+f18V7q+IRk+QRy7KVoD8/IQrXi
	RUYAnUiQ+4vybBZFrKu7SW1T+bnhp7X3DvAK3olsY9N2d3AvBD8DdxQCozf0vVwK
	x7gZ4SS0P2Gjqlnj1zIYQOTOZDFAIwTgYXGfbCtZpG1sQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42exf6gy0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:19:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 23 Oct 2024 09:19:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 09:19:00 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id CFEF23F7084;
	Wed, 23 Oct 2024 09:18:56 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 3/4] octeontx2-pf: Reuse PF max mtu value
Date: Wed, 23 Oct 2024 21:48:42 +0530
Message-ID: <20241023161843.15543-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241023161843.15543-1-gakula@marvell.com>
References: <20241023161843.15543-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oz55sV35CTYilrxVKj745o_EZAxbtxTG
X-Proofpoint-GUID: oz55sV35CTYilrxVKj745o_EZAxbtxTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
index 1185f1bdfa01..15ed1305fbf8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3101,6 +3101,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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


