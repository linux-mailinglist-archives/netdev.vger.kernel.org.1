Return-Path: <netdev+bounces-201090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C5AE8171
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CFF4A1343
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87614F50F;
	Wed, 25 Jun 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fuLCB97q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB11917D6
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851043; cv=none; b=VdAHFDDUwMX3569ZoaFwu0HsHHuyj/b1oFlGoabJcEGSOvCB8GirHNuyqAvucP0GVHO+szdTUcWGsf+AWakiqzMV464yZwUX2ciVXEj3bKItE0JL0XmFVEijp8aP8Elk97asAIqG5FeTeroFQEyvKXzIiTHeAQPNx2w0t7iHnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851043; c=relaxed/simple;
	bh=/7ABdLkqrcUymp5D3BRRGfgTgOBYsNFQSOvOSk2W+DM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOLiZ9wCDPaZ/Dt1AUh1DFMFk46GSW85EW/fHAcyOn0xRZtSRUQvXlc8TagqibeFhIUff8gZToo0Pxt2YvguDtBSLk6Se4ZNMluH8+yJKj1TkFT2H9Sp7KUotqYND0dE8pvHr+3o34y27cJQ/rN7/I/y9IxnqFtjj+wGlf+Wp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fuLCB97q; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9joc2011110;
	Wed, 25 Jun 2025 04:30:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=D+PS491W9VrqQteOunvRDW4xYMcUtVH0FQpnYFB5LFw=; b=fuL
	CB97qPCnbfkKlU0bc6VtotMgrIZwqXg92TQdlmyP63GDaGDW+/I1GVSw8v0PqFCj
	+ZOByjFoYUtDMSlhN0IvVxDfklVxQphHX7geE8aaDK33xWJ8ReBcw5w9YyWYVclj
	bbDAd4EsfLjvEljlFFOVZfydON3N09kiH0itVk93Cg6E72nq419wM3N2O+7cUbKE
	bp+LuRMUqwURcsXduPWgOqqUeiouH3iSuiH2VMlNjBfHs5aZnCvAuHx/UreBsLrG
	yINk5asr154Wlo5Dyf3nkhodF3LEI6WLGDFgFuP8n98nd+dhHvJgKQ6zVVcv0QTY
	9yF3FmUZ9O+QOZdF+wg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47geryg5t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 04:30:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 04:30:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 04:30:16 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 18AE13F704F;
	Wed, 25 Jun 2025 04:30:12 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, Suman Ghosh <sumang@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Check for DMAC extraction before setting VF DMAC
Date: Wed, 25 Jun 2025 17:00:02 +0530
Message-ID: <1750851002-19418-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 5kZ0FFr5y28ie4DHH23s-M_KiPAuSmqo
X-Authority-Analysis: v=2.4 cv=d9D1yQjE c=1 sm=1 tr=0 ts=685bddc9 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=7o_FJUZ8n211lgTHMv8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5kZ0FFr5y28ie4DHH23s-M_KiPAuSmqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NiBTYWx0ZWRfX+T9S6MvaUAht rqAXmve28HlCLnaEnOQ2gyWQz9RmYJ83o2FxpdTZfQGaR/yktGOsFWk9R8zbUSGEf1TsgNv2vy6 rbp30Dd7qEc/gx7m0KsUvMmNd1wuIgRjOi92CeXcQpdG7da49LKP1BIIsoJnGlw/KBskYPpdTgH
 rM9tWfUVazbwlUGqp4IFNn8f1crrj3sg05h3n90/qX9uSbmklWJMbtq/un9m+2GHxcgME//hDF/ sR6T97YPYV3YMx5sMEyArTlF49hYSSgnveF3vJs07WvxkHJ4dQtxiSI9lTt75hvL8w309thXUUj hQHeSE7p8W7Qrjtv5GZaMNqBMjjnSgBCJFn27kSJb9wz3JZSpk1SqiNjEfUDb+gBlJ7/rPsNy4T
 x9+MNB+UY/trA977/frnMDaU4tD5BMhLZgIkRpaWbyA695K4F2Rmt4HLH/13VOYKQ0GS9s52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-23_07,2025-03-28_01

From: Suman Ghosh <sumang@marvell.com>

Currently while setting a MAC address of a PF's VF (e.g. ip link set
<pf-netdev> vf 0 mac <mac-address>), it simply tries to install a DMAC
based hardware filter. But it is possible that the loaded hardware parser
profile does not support DMAC extraction. Hence check for DMAC extraction
before installing the filter.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 4e2d120..c8c9cf6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2559,6 +2559,8 @@ static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac)
 static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	struct npc_get_field_status_req *req;
+	struct npc_get_field_status_rsp *rsp;
 	struct pci_dev *pdev = pf->pdev;
 	struct otx2_vf_config *config;
 	int ret;
@@ -2572,6 +2574,35 @@ static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 	if (!is_valid_ether_addr(mac))
 		return -EINVAL;
 
+	/* Check if NPC_DMAC feature is set in NPC. If not set then
+	 * return from the function.
+	 */
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
+	if (!req) {
+		mutex_unlock(&pf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->field = NPC_DMAC;
+	ret = otx2_sync_mbox_msg(&pf->mbox);
+	if (ret) {
+		mutex_unlock(&pf->mbox.lock);
+		return ret;
+	}
+
+	rsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
+	       (&pf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pf->mbox.lock);
+		return PTR_ERR(rsp);
+	}
+
+	mutex_unlock(&pf->mbox.lock);
+
+	if (!rsp->enable)
+		return 0;
+
 	config = &pf->vf_configs[vf];
 	ether_addr_copy(config->mac, mac);
 
-- 
2.7.4


