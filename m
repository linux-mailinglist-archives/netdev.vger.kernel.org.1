Return-Path: <netdev+bounces-192530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33975AC046E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861491BC053E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B222155F;
	Thu, 22 May 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c+wYg/gp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80738221545
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894549; cv=none; b=OW6A3wyujO/ulOZaJLTJ78rPGBtLnUmF60uRpQq9AHDT+tLlVSBtKP2fa+sgQ/dQtblVVxZwJGtNeH6Yzvgv3tZfOpX9wepmPsonHkFvsEMgvWxlXq7XESSG+AHXgXjRoEOWhAWVEyi8JNEWS9F4Be0i1+k2625ToN7ZvTVe0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894549; c=relaxed/simple;
	bh=nBprkQnJCQsAtjx/FLsHeUut2kcdvVeJAprKQtLse9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKwUXjUBWVvGiqJnCUmO4C8WBnHiBS0Wk1T5UNxHImweWYzGRVfSb58vXG5n2pP9IDpyovlI0wJbUWfS5HdI8ASl2yRMI0g+05IYQD3YbpVbWso6AWxPcN9o/ZhFFoBBCQ2jqJuYOhPQdZ/DwJCt85fz/Dpyux3b07rY/EFlrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c+wYg/gp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M0H9KI018805;
	Wed, 21 May 2025 23:15:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=mi7j4HbsA+AazSMimdU4tt/EIMOMZGWHhEV0/eIFIH4=; b=c+w
	Yg/gpJ9FwHUXFuItvOScEGqc+6HS7sIRkyCeBHNBgT5ImEc3w901gREFqLA8bZyk
	pmyo6QqT3/B8pKA3n34IxTM3cxs2wBSKEuEZcgFGaAU8zNwx7m525ZqN47+hVnYt
	54WfkRgsHOjGqFa56Hz86C7tG3TghAKVhLNHfxXdVucTgcDHL6jmve8Saau+gFzt
	5C+uuePotiT8BCPcigid2N1LaJmKtKzl8B4hjCUnS+qScx2x3JSvSHGmP+SHmCaq
	Q/FZ2olCBaBxgrKiBKAeOvMyU1tl6+xMrjD1NwVT8SpVH/HltAfJi9vHh6sqKJqS
	hzDYg/AA5ifVdCg+pyg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46sqap8qvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 23:15:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 May 2025 23:15:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 May 2025 23:15:36 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B859E3F708A;
	Wed, 21 May 2025 23:15:31 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <sd@queasysnail.net>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 1/2] octeontx2-af: Add MACSEC capability flag
Date: Thu, 22 May 2025 11:45:28 +0530
Message-ID: <1747894528-4611-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: KMCmEHJTVyCML9SEGodKvVGE2bn4TJMq
X-Authority-Analysis: v=2.4 cv=HfgUTjE8 c=1 sm=1 tr=0 ts=682ec109 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=P7ETNM-qh4qR_gsSVD8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KMCmEHJTVyCML9SEGodKvVGE2bn4TJMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA2MSBTYWx0ZWRfX5mv6Z5Da/C94 puD8NcFQYeoMhUtH8VvakvF/imILVH35e6+enDz86Qikx2fis4RpIAAFnY/VAjr5oCrZInyjika 8avmgCc3bmxhHs9a0HFoFcTUdXxH6Y9iB9IJPn03R67obSMvTn4V89b+VH6X3dFZc6qQvwoPFiv
 lqECMJyg75I8/ffKC27+DZn7jPo2HKjR2p6f+xMXPr47U+UdUa1bvOfxkzHEdTKbLp1i1283w2K 9WyrFab//QGg69WTMTaXJbLGMJgOWWikEMR4MqXqLVRIZNzH5eNzICRcd1okQ1EM4+laSjonkjC kyxfQavakm5UIsgjg4le9x5TZ7xq+PURxtb2OxW5d232LxNfeMPxiOTdXlFrf9YNTipN/UeBhau
 ct8qJ+Sz5YiW67p2urnOGV6wGQSttxUiPrCnnH1F8fnYuJnFkqia7R9dq0MJvnTXkdkXW5x5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01

MACSEC block may be fused out on some silicons hence modify
get_hw_cap mailbox message to set a capability flag in its
response message based on MACSEC block availability.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 005ca8a..a213b26 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -524,6 +524,8 @@ struct get_hw_cap_rsp {
 	u8 nix_fixed_txschq_mapping; /* Schq mapping fixed or flexible */
 	u8 nix_shaping;		     /* Is shaping and coloring supported */
 	u8 npc_hash_extract;	/* Is hash extract supported */
+#define HW_CAP_MACSEC		BIT_ULL(1)
+	u64 hw_caps;
 };
 
 /* CGX mbox message formats */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 511eb5b..afad819 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2031,6 +2031,9 @@ int rvu_mbox_handler_get_hw_cap(struct rvu *rvu, struct msg_req *req,
 	rsp->nix_shaping = hw->cap.nix_shaping;
 	rsp->npc_hash_extract = hw->cap.npc_hash_extract;
 
+	if (rvu->mcs_blk_cnt)
+		rsp->hw_caps = HW_CAP_MACSEC;
+
 	return 0;
 }
 
-- 
2.7.4


