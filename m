Return-Path: <netdev+bounces-50375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489127F57F9
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8588BB2110E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10643C2C3;
	Thu, 23 Nov 2023 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jOd5+j1F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E726B1BF;
	Wed, 22 Nov 2023 22:00:50 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5YoMd023177;
	Wed, 22 Nov 2023 22:00:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=20w8+xsUpn+mENMXqGWsHU036g/l6onOP9fm5MMMsxc=;
 b=jOd5+j1F1j/iWDGRqewtRRMsKlt0IwirH/URmeIkPitRNynsvp689HADhyyvWn+1Mmfs
 NrbvjW03mdRO2G3O8nphKdIXnNCMZlyAngx6jmFiL4xOAeRZbnhPPIACISF1/GI9GfhA
 EaK0NYo/DyMioNw1Z9JCff0xQUSSrhVwRZAzXtaRw62B32my/XKo+6qcJnVKrLrvSJiu
 x2j0ouXUBffnYSgehjKYOjkUI6Zg7tZbKBr1xkyt+6mKN1ffW9hsiWGvmyFZfrLJlCaX
 8/rqgKE+EfFiuPtAbE1kVAPNRsGdK4k2D93KxnT7SsV1viwJCHQh+usuP8f92KyopnjB 7Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn1xkc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 22:00:44 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 22:00:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 22:00:00 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A98293F7067;
	Wed, 22 Nov 2023 21:59:57 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Date: Thu, 23 Nov 2023 11:29:40 +0530
Message-ID: <20231123055941.19430-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123055941.19430-1-gakula@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 435nKjoVN6bfwZ7YZmT-KZhy7wd10U7V
X-Proofpoint-GUID: 435nKjoVN6bfwZ7YZmT-KZhy7wd10U7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02

If mcs resources are attached to PF/VF. These resources need
to be freed on FLR. This patch add mssing mcs flr call on PF FLR.

Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 22c395c7d040..731bb82b577c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2631,6 +2631,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
 	rvu_mac_reset(rvu, pcifunc);
 
+	if (rvu->mcs_blk_cnt)
+		rvu_mcs_flr_handler(rvu, pcifunc);
+
 	mutex_unlock(&rvu->flr_lock);
 }
 
-- 
2.25.1


