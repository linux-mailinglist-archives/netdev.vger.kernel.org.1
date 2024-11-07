Return-Path: <netdev+bounces-142907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61389C0AEA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC5D1F21E21
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309A2178EC;
	Thu,  7 Nov 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N3aultQe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88C21766E;
	Thu,  7 Nov 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995765; cv=none; b=eZOIs2+RHP/oEDZTLXny3b+hjzw+NkqvQUAz1ESFlPmdN3ZHyphEvcwV8/oDq6TUV0BrUYwdhHTUgNf7BYGIqg+4ycs61FvA6qKAiGFdkeYKMlMtOa22xQrHSXZqpTMAGHcNMn33hYVOKqh9X2RjCJCBHCEbGa2eTwvgoBUcClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995765; c=relaxed/simple;
	bh=g6gV4/3GF+Rk0sgJnKOO+Ab6lVrFsCD0G7xIKIBdSbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvhHxniaKd9KNtmiVW6d92xo+jETMDOGeNCZ4IKAOUcZ8TD6BHilIcoKI4976VifamfFGZic/N2Wrl+mihCVBxyQG/OKVfHQbt80P0eqYoLQYkXTcPFtA/YMpEswUx3bRToFC4phZxiKXtYNvZDK5ocZvAbubTvm8oKHUOb9Y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N3aultQe; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75eHB4010991;
	Thu, 7 Nov 2024 08:09:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Cwx1Z/CJ3UdOfB/csDl6r3G4b
	CKQkq2pEKTsPVKLgsQ=; b=N3aultQekrMOlPqMipeoBFiZ/FDywauQrXBArlcOR
	3yU3RaNTI6WdRBuutZ7MFLH+wxtBFNbEiky7f35eMnTn9/hFxQQDgAi4IqpodhEB
	uPKCifkIndamr886jyOdZ3qfv1GkBVCqN8v6yYAZcnHHvjx5i0nXqfWIvOpEMs8v
	Hq9co+PXosXAwf2RvEMdKGTcRXFRRN5NBMT3H2Ko4gbDJEeRR/HpBhiT/T+JIllX
	aWpM+HhsxAkuBQmRigZiEYo4hj7I3mIRAT4PkLIAZMRn78X0vFUhPlqMCARBg+Ft
	3uLO9ovzOooewva2FzrQIS9QpWFP9/12kYNSLfrKq9+mQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rqj8s79y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:13 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:12 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id CC6973F708C;
	Thu,  7 Nov 2024 08:09:08 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 07/12] octeontx2-pf: Configure VF mtu via representor
Date: Thu, 7 Nov 2024 21:38:34 +0530
Message-ID: <20241107160839.23707-8-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
References: <20241107160839.23707-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: BIdadYg_A7ApUcEisaXwWfDOp9tFneFh
X-Proofpoint-ORIG-GUID: BIdadYg_A7ApUcEisaXwWfDOp9tFneFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Adds support to manage the mtu configuration for VF through representor.
On update of representor mtu a mbox notification is send
to VF to update its mtu.

This feature is implemented based on the "Network Function Representors"
kernel documentation.
"
Setting an MTU on the representor should cause that same MTU
to be reported to the representee.
"

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c    |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c    | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ea5183fc8414..0d62f16af68b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -854,6 +854,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
 {
 	struct net_device *netdev = pf->netdev;
 
+	if (info->event == RVU_EVENT_MTU_CHANGE) {
+		netdev->mtu = info->evt_data.mtu;
+		return 0;
+	}
+
 	if (info->event == RVU_EVENT_PORT_STATE) {
 		if (info->evt_data.port_state) {
 			pf->flags |= OTX2_FLAG_PORT_UP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index eec3e0dc7fdf..d4e78015ef71 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -79,6 +79,22 @@ int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info)
 	return 0;
 }
 
+static int rvu_rep_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *priv = rep->mdev;
+	struct rep_event evt = {0};
+
+	netdev_info(dev, "Changing MTU from %d to %d\n",
+		    dev->mtu, new_mtu);
+	dev->mtu = new_mtu;
+
+	evt.evt_data.mtu = new_mtu;
+	evt.pcifunc = rep->pcifunc;
+	rvu_rep_notify_pfvf(priv, RVU_EVENT_MTU_CHANGE, &evt);
+	return 0;
+}
+
 static void rvu_rep_get_stats(struct work_struct *work)
 {
 	struct delayed_work *del_work = to_delayed_work(work);
@@ -226,6 +242,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_stop		= rvu_rep_stop,
 	.ndo_start_xmit		= rvu_rep_xmit,
 	.ndo_get_stats64	= rvu_rep_get_stats64,
+	.ndo_change_mtu		= rvu_rep_change_mtu,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv,
-- 
2.25.1


