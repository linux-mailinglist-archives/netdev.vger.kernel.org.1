Return-Path: <netdev+bounces-115770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD9947C13
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F37B281B9C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938854278;
	Mon,  5 Aug 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ETMiqBlk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841642AA6;
	Mon,  5 Aug 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865376; cv=none; b=WFqr8G+j8JXdalE+QPOoFtF0KXmUOTtwAaOk14Yo4GWEQCxpGrQGx5ewznaO12Ajh4avV2kX/FBw63dppi/VA8zfkUzXs5j8uRzpmG2pFrC2CW0z/fdkwG1hYfWSmFi3Z87VApWeeXhQ187nn3JAWF9dg06zENkps1sQ9mYtJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865376; c=relaxed/simple;
	bh=yL8vbqpGaVdZ/q5htkingKWyLGSn43s+zG39Y7iYPV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVJqqDTMRkuWGAtnosPrqyB8smFP0rf8RcJsd9IuFsu8AhBreBXvQHQQ6A/rTZQrp9PhlICoPUh4YJTBNwFem5XsVgEkI2U4gES7ALIG9JVlYJx1RFUbYEcYBX2vwQ3vOvwkJonfCu+aqynRnEWWo7UkyHkm4ynxSDtr/1mysTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ETMiqBlk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BVVx1021791;
	Mon, 5 Aug 2024 06:42:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=smTo6/e27jptEQSXRKsjOwtTW
	LMEQkV9BJ0+ska/ZQc=; b=ETMiqBlkLEUIk+r7HNjue6XF722anVDlz4kgA95Tc
	QEOwRVsE6/aCQJlb1CSablh//PCGJUPPNkzv0jrWaJBTwKID5+Iie9AD/TLBtiyp
	jHVnQ3mTAf8mEObeSoe7vM/pZ7gcd9aCNmbz3xevQt3S+kZyrXJBWFjKcsXhCRmb
	hsWHK/Lt5sBuJnWxvzQrP7/rktKrFJAE8cdirjWzE2Wm9rEAOA6aYxGVif9SanGM
	7fwa9D4evGN8S89jkTtOvGz9FgoEIYguSZgWvzus9xkFP9t++3LUXx3RRk2utXbP
	3Yi3y1YF+lA3Iz6CY5wzsh7brNxgYUO/Rn8k/ApImyyzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40twxd0cmn-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 5 Aug 2024 06:42:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 06:42:40 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id C0B025B6EB8;
	Mon,  5 Aug 2024 06:18:46 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v10 08/11] octeontx2-pf: Configure VF mtu via representor
Date: Mon, 5 Aug 2024 18:48:12 +0530
Message-ID: <20240805131815.7588-9-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: G6Wmm_BE_jKznjkeMyzO0K-fOyCbEd6u
X-Proofpoint-ORIG-GUID: G6Wmm_BE_jKznjkeMyzO0K-fOyCbEd6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01

Adds support to manage the mtu configuration for VF through representor.
On update of representor mtu a mbox notification is send
to VF to update its mtu.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c    |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c    | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index cdd1f1321318..955ea941a53b 100644
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
index aedcff57d96f..c37cbf440235 100644
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


