Return-Path: <netdev+bounces-51192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D737F97CF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CD9B20AEB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DF23CB;
	Mon, 27 Nov 2023 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IB4sEvZU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80076124;
	Sun, 26 Nov 2023 19:05:09 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR0QDe9014892;
	Sun, 26 Nov 2023 19:05:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=s27OucWU3fOscbVAX3ldp1gFzf1mDvkwTDGgwv9Qvbc=;
 b=IB4sEvZU74KHeBCSfus5Sh32l7dl0EI82Oc8GQTiQrtqcXI2WEC+vgBpAs5acK1PmWa1
 57x7Wew0mN98XbpJBVlggM758L5Hlek0eokYECY8X1Z/frnMmh9TBPsFwbnn0fXsaf8M
 +HKfiSFFd+N4cRVCCkbkH3NiWh5N4zDkjja6IAaFazvW8SzL1/1+b9Lp3Zei0cIlRUf7
 AvwsXsZKxBY2ObcAeTzhLkNUB9ake75G8awFp0BB1+Ptfc00N43WAoG3C80Ki/IjspS/
 kA3suAsdIkKOh+eN4XzaoQHD3/xFWNAzf/RHRudk2ETF2Br4X9PbSsFCvunLChiCyjy1 gQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ukf5x3bk4-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 19:05:03 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Nov
 2023 19:04:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 26 Nov 2023 19:04:54 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B78633F7090;
	Sun, 26 Nov 2023 19:04:51 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v2 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Date: Mon, 27 Nov 2023 08:34:34 +0530
Message-ID: <20231127030435.17278-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231127030435.17278-1-gakula@marvell.com>
References: <20231127030435.17278-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: wNHzfbdQuQluqmq4T-0QZmOmOzDkV0GM
X-Proofpoint-ORIG-GUID: wNHzfbdQuQluqmq4T-0QZmOmOzDkV0GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02

If mcs resources are attached to PF/VF. These resources need
to be freed on FLR. This patch add mssing mcs flr call on PF FLR.

Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
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


