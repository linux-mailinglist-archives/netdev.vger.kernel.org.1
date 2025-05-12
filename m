Return-Path: <netdev+bounces-189745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F04AB378E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A50188C61C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448C293475;
	Mon, 12 May 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iby2sXa3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8781AB52D
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053787; cv=none; b=HF12wdoLiffqdoyT0H9qvgZQc3UdGQMYk3duOwQPWF1+JSUacckSJfrj80czcXtY0Nxi+28hSvT+/YF/mhgvi67gPdanKc5lsuPGVzzWmLPhJ6973BN5Wf/CQj1beOh/aqHlJ+O9OfE6+agVi9ECh5cfx7+LzK8Z382SIpQlr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053787; c=relaxed/simple;
	bh=4WtdmWYLJPkqu8LdJVGQUc3wGr0SFGTfYFuRc+CRpA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dcl3gYsslfNcQ71IRK4SpmAcZNc76EJu7wuSTZRJtzqPuUD9LgloxNustYwOblgNrpk9I73NNtFYQW+xdDkXnRPeIdroLrrbEdxvQxnuJV3cSLJ5vxPDnXxpBrH+dy5wh27mlbkfZ1jpaAg2K0dWuT7tiL4KFHawxslEwBFbF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iby2sXa3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0ntGG017196;
	Mon, 12 May 2025 05:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=9WnEX1IQbIQjxiXqn+EjMg39IcE3fzEzs48See2Jh7w=; b=iby
	2sXa36eAVyu+LW26q0iZHMu8ZyVeNKcVYdVmTUNUpJR+nQ5uY5/57j5FiGFdr5YD
	b5wcYf8jBAm5IZu+jvoVCOEe2HSvyHsUeJhkVhq9G4RMo/lYvPlJ6aIdl8NQpQ9T
	pMyTP3uxbvVhD9BXePgmprd4D/Z6o3ZjrE/nxFjqFiCTo6tRc3+8DTrRG0pOA85+
	XmlRAJbYRVrXb2gxXTlJL29XdA+8/2lfHZlBF1TEmNdwlRxEiBfvZrrfRPnSrq4Z
	Y6ZUF74D+3beTsi1ot+7FxVl22ZA7t3afPOt+0zrpxb8ak2LTRXO4KZ30rEjqzo7
	2StOnvBeB7vm2HFn5SA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5r6h2b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:42:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 05:42:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 05:42:53 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 1FDFB3F7095;
	Mon, 12 May 2025 05:42:47 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
        <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net v2] octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy
Date: Mon, 12 May 2025 18:12:36 +0530
Message-ID: <1747053756-4529-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6821eccd cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=B7Znt_Yslpsvivp7DLsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: np5peV6Ei1DUGyUbyXGzvdJ9_87cZkqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEzMiBTYWx0ZWRfX54Z49neIXx/2 R4HTPoCtcJTRpBF39vWaXEWXxNtLtsF88MGhYvecjQM3ddbHgOo3dRexXf/dduO/3cXWikBznIY US7Iaxngn+8D+LL+2kdWg6smE/Cw2kuO4wEN6XiHX3vNzwT8Ow4dFyqXzJlZKyr/9Qm3GLCGzz4
 biwMipDlqlT42Cl4G9KLpQS5DSoVjNt5JZYjZqUoHzXfUTn8GiR99Tf3R4QEaThfG63d/lN4qj8 9YX9aQtc9WHbvelMLY4pBKZ5tc0JsdGkuYcvFi/WKd9x+zEqr5V5utMYVqgm0w0z3x+JSZYK25C wo6jbIbkjIXF+ebiawLxvtbU/rkUB2FasNd9umXlMGUgSuyeItMJeyHcNUUaXL/ynt+t9MVelOR
 wUdlRcVjwTz7/CQUwxpWbxrBnFWEL6aI/nZnsJkvV1Dw+eUO6GXBpWeWprR3RpM0FXyOf7om
X-Proofpoint-ORIG-GUID: np5peV6Ei1DUGyUbyXGzvdJ9_87cZkqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01

MASCEC hardware block has a field called maximum transmit size for
TX secy. Max packet size going out of MCS block has be programmed
taking into account full packet size which has L2 header,SecTag
and ICV. MACSEC offload driver is configuring max transmit size as
macsec interface MTU which is incorrect. Say with 1500 MTU of real
device, macsec interface created on top of real device will have MTU of
1468(1500 - (SecTag + ICV)). This is causing packets from macsec
interface of size greater than or equal to 1468 are not getting
transmitted out because driver programmed max transmit size as 1468
instead of 1514(1500 + ETH_HDR_LEN).

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v2 changes:
 Modified commit description and added subject prefix as net.

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index f3b9daf..4c7e0f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -531,7 +531,8 @@ static int cn10k_mcs_write_tx_secy(struct otx2_nic *pfvf,
 	if (sw_tx_sc->encrypt)
 		sectag_tci |= (MCS_TCI_E | MCS_TCI_C);
 
-	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU, secy->netdev->mtu);
+	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU,
+			    pfvf->netdev->mtu + OTX2_ETH_HLEN);
 	/* Write SecTag excluding AN bits(1..0) */
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_TCI, sectag_tci >> 2);
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_OFFSET, tag_offset);
-- 
2.7.4


