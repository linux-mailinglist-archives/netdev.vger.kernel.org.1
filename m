Return-Path: <netdev+bounces-109420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7762B9286A0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CA283716
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751614D2B7;
	Fri,  5 Jul 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hqHyXTfG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD214BFA3;
	Fri,  5 Jul 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174651; cv=none; b=MKpjHnrTDphMrCgeb8bUrMr69zJNhxic+0gGGXROMayuHG1PY20xN+GyYecQ6rjNSW1nAszFmGKFPUOGv9JTMNH/aOS0YwwP0Rhv5q5Ze4j6EeYK4+0eyQOE44a9ItwfK40QKHYeLdacdU+obVjw7oHixk+PL3q6X2MkI7YgOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174651; c=relaxed/simple;
	bh=yL8vbqpGaVdZ/q5htkingKWyLGSn43s+zG39Y7iYPV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJYm9COz8Vbp40LLM2g36Lyzi0JUadvQlFuNs8wXMKxGj4X1dMB47IITzdQb02OACmDAqNfZVr2tnQe/NC1Z0Oe+jRLh7xfJIxUAiULtMZgoEp2T78cizjSzN+wrMTGZU1e7O9obRTg1Q20yf6lAZ+JXIZV+yVDvOzUgG30cVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hqHyXTfG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4659PDmF029505;
	Fri, 5 Jul 2024 03:17:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=smTo6/e27jptEQSXRKsjOwtTW
	LMEQkV9BJ0+ska/ZQc=; b=hqHyXTfGqIOpYuDhLZ80zCY8xEv3wauNvmtA2xUqt
	AanrM3/hnVUUuUcTMhZ0SjpgSuX2toMnDnRNSgxy+jL+FR4EzYqveC6VVZY1fEJu
	awK9cja/Hcy84R/9xMYK5oiL6L2AAB06Y130/4ATx/7UqpycNcmVTi+GmjMtyIx7
	Zetd77aSSKfj4uXwlQy0qbUqbF7nzMID3GQzMkT3xIufJEeHYsVMmcatX1qxo68s
	snDm3bxpeYotZ7u7quQJb45SpkGVqnT591sDayTxW+UpedjAuXhlWtFWctqQjCvn
	v/ZiU75hVCshmS4zuMl0og00khB5R8OEJD9jtH66FOvxw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 406e6c04vu-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 03:17:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Jul 2024 03:16:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 5 Jul 2024 03:16:51 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id CEFE63F7040;
	Fri,  5 Jul 2024 03:16:47 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v8 08/11] octeontx2-pf: Configure VF mtu via representor
Date: Fri, 5 Jul 2024 15:46:15 +0530
Message-ID: <20240705101618.18415-9-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240705101618.18415-1-gakula@marvell.com>
References: <20240705101618.18415-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 7FRWFL0wCkd45fUxVln9qxs2D_P9ocdY
X-Proofpoint-ORIG-GUID: 7FRWFL0wCkd45fUxVln9qxs2D_P9ocdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_06,2024-07-03_01,2024-05-17_01

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


