Return-Path: <netdev+bounces-106053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F8D914793
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C15E285E5A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43041369BE;
	Mon, 24 Jun 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MSrhT3SD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4B3BBF2;
	Mon, 24 Jun 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225432; cv=none; b=td/EHTbbs8WzqYYNaTylIha8U9UfqcEz7v2bFEkfDhGIpV1Pb19Vq9DMc85SN2+4eLAfZaOuYyxm58Z7AlzMQstC00b0VjlhQjeJfIXqzTr9FjUA9SIpiLCGHYHaZgqA5JBXgdYJUkg4k8reRxzCTf80+vgV7RbZGKlAu7cLYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225432; c=relaxed/simple;
	bh=dWonAnvgXCYpLpYCeBBTIvXq7be3HkLYcFljvNuk9Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0eJfImOXB9e1s5ZwFrqXucbHN1BVtzYCQuZ7pnbJZei1MuJcG7o2RwfNHlsSdWVRaYGRchrHEV3vh0rVoYcx3cahOJYLB7OMERBrJb98lO3VzesZOAO5NjLl6JJMNSqVnLNopWa5DumFyyPxEssYbxpgN+9iEyRr+ONe0UqsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MSrhT3SD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARDOH022070;
	Mon, 24 Jun 2024 03:37:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	bIfCbASG1LP1A6v2Sierwpo8X5f6bT24LBRJqjJvNY=; b=MSrhT3SDsJ0qwUoYT
	zgzchhiWWCs/UZzNbL+5ptXBuBjLCzNP1HH9nPYThq1w9FoqeWsmVdrETEgJfhz9
	vbiPEG4Mh11ngA+19ggQKJM7njV7v4bjwYAfwEBkbe8O7NkYDiI8RsAA3ILUyCKT
	m9exwgX8ELJT+zeO5uo57H/W3v3uYLtf/NaYeXGECJkfZ0rvw+mRrw2MIaL2vHxr
	elFnprSkS5K8rZ5X3EL49PdLtzL5seSSJjJp5rpkYW3/KqKm3w0D1nmWleKBLjoI
	Z+WBnxynrpcJmJHtvFLZdrRAyi0iMjYhgSITPTBeBImcC/69FgRF1Dd2+wSrGh5V
	x8z/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:36:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:36:50 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id CC74B3F7077;
	Mon, 24 Jun 2024 03:36:46 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 1/7] octeontx2-af: Fix klockwork issue in cgx.c
Date: Mon, 24 Jun 2024 16:06:32 +0530
Message-ID: <20240624103638.2087821-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
References: <20240624103638.2087821-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6N1JiL5l4et0rZBrz5VuOJtguHhplLDC
X-Proofpoint-GUID: 6N1JiL5l4et0rZBrz5VuOJtguHhplLDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

Fix minor klockwork issue in CGX. These are not real issues but sanity
checks.

Fixes: 96be2e0da85e ("octeontx2-af: Support for MAC address filters in CGX")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 27935c54b91b..af42a6d23e53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -465,6 +465,13 @@ u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
 	u64 cfg;
 	int id;
 
+	if (!cgx_dev)
+		return 0;
+
+	lmac = lmac_pdata(lmac_id, cgx_dev);
+	if (!lmac)
+		return 0;
+
 	mac_ops = cgx_dev->mac_ops;
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
@@ -1648,7 +1655,7 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
 static int cgx_lmac_init(struct cgx *cgx)
 {
 	struct lmac *lmac;
-	u64 lmac_list;
+	u64 lmac_list = 0;
 	int i, err;
 
 	/* lmac_list specifies which lmacs are enabled
-- 
2.25.1


