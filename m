Return-Path: <netdev+bounces-53823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC606804BC4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B051C20DE3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43539876;
	Tue,  5 Dec 2023 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hgwAJeVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DBA1B2;
	Tue,  5 Dec 2023 00:05:04 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56OghX010788;
	Tue, 5 Dec 2023 00:04:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=cpu74fKMW0DTq/GMU//ItdeUtHkkNpXJJ0gkywxMXBU=;
 b=hgwAJeVJYYD55lDLTDXM2RnWwvoqbsLPyVZkm2ij/Ht+7cQxLVPi1YrJActKzSduCukS
 jFtn08jYImKA7aOJssZoGd1flIh8jDippE6uD6o9xTq14TY/w8byC77aHwXMJz5/niJi
 tcwQt4YrflWj7mUs29Kp4E+VCwKhzIHhacYs3E5PjjLsvleAHLf9oePofrBtNasB1/Vj
 uoLSMPgBg98wCTCgA/MCC2X16hT3zbBRPvnTaiaeSfh6Zynr7qJ+ZycMhIcoANt6mOG2
 NfOwtEXa9GiNR6OZbRvUhX/Cs08Ld1G/xT9A0rqChkynGbLJn1YIn6zvW0sp6PWJ7AA7 Xw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrrq4w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 00:04:59 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 00:04:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 00:04:56 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id EFF7B3F70A6;
	Tue,  5 Dec 2023 00:04:52 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>
Subject: [net v4 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Date: Tue, 5 Dec 2023 13:34:33 +0530
Message-ID: <20231205080434.27604-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231205080434.27604-1-gakula@marvell.com>
References: <20231205080434.27604-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: RN41f7qEnVFQRrIZGXm0tsISjsoeHmuq
X-Proofpoint-ORIG-GUID: RN41f7qEnVFQRrIZGXm0tsISjsoeHmuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02

If mcs resources are attached to PF/VF. These resources need
to be freed on FLR. This patch add missing mcs flr call on PF FLR.

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


