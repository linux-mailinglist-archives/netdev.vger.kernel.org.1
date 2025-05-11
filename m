Return-Path: <netdev+bounces-189525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A0AB2873
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 15:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6145C1727C3
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6202256C69;
	Sun, 11 May 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NFBMfSks"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED3BA3F
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969788; cv=none; b=TFKn6Fxv7yGCmDGery4oj6l9LDii5MXVrCUx6AVWzgGuUw18dZg/oCzRstXw3H6W/hWJHgp4xQD0hc9QJvyZ2C6U3xK/y9AArZPld3ynfs2rXOD5Od3GvqzJL11dchiHtsHAJ+9TRnJO7nMdoCJj8qsN06apTvx3qSDW3qVpscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969788; c=relaxed/simple;
	bh=g0/IjMzj5MWgjOwQc/7uEkFwkoE6qUHXa5kut1j/wkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DixePq0i6dyZGjPDVgJ7Y/u9YFTly0diEiHFbDHatt1AfYmBB4oG3e7UmdvD7lZxRgZFDEDI9chDXS1rMiWWX3GKmWEYmoUXGFEOMeFjzGu2HRTVvDs3KnO9ym3uBU3+N4ZgdA3i1maocMVLN9l09KL0s5oqI/OmSuhS1gW0s0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NFBMfSks; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BCPnqA016796;
	Sun, 11 May 2025 06:23:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=JfFOxL2e7UAAEdh45LKgqglVa
	3kZtYMa0KqAmPxjsSY=; b=NFBMfSksDdh2ikzgXlzmjPLRvmND0LJQGVQ1419FN
	dZLm1TlQjbWarIIuTy7ikcGI3n8i+rkym6yi5o79hr2p2OHtiA4ZIneqKAahq9Vk
	vuLtu3kjuJk8WmaTbUD4XZIFiV19PF0LEJQJ7iGiwLX/Zlczdnezf4NF4WFBr2Ha
	gShHLAhsn1fz3/tgsM1rSr10MFbP2vQA+90YH1tdGtjTtoczohdGoAYW0IFXy2Lh
	euFvfH0zLTUDXKjThHIr5+rvG0gzpgHeC4lT+tNF3pfPNmvnd+uS4YvcvL8rNdg4
	8m5TNEVGWnD771AHWKY3Ugcxd8/CARI4h6WyeZpCtPb/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ju2b82u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 06:22:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 May 2025 06:22:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 11 May 2025 06:22:59 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 94C5D3F7087;
	Sun, 11 May 2025 06:22:54 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 PATCH 1/2] octeontx2-af: Add MACSEC capability flag
Date: Sun, 11 May 2025 18:52:46 +0530
Message-ID: <1746969767-13129-2-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
References: <1746969767-13129-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rMtzN1hODHR17fuvJmq5v04iE5XGUVmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTExMDEzNyBTYWx0ZWRfX+WvNAUduyPcb +ZoFMGmsmu1rAZ+TDB/8qys7u+0ZK+8quRYTEVO2ekvLSycQI9DKzinAFfidu7PEiYehSzZhOYg HUOg4ikBrw4e6uyMwTefoTwFzHk+6syD7uKA8YuWK3JxMb/w8bWMnk/MvgLmv9hUpQ9k0IGe1u/
 WFSUfMOrNAYpA8r1iv8brFUqraAvyPDFP8SlBRKFf76R8Ov4o1jsQbvYnZK7BBG7+xmAfn+qlgr M1z2rvmxP6Ztq2QhXhfi8OVItVvLwiZfDAqZVLAfh0MDNe9aXUvLGBThE7saoSXKlpA4FX9IFAa T+4ogync+8CSSUAzdCZssYEl/TA04ilb5LOiOj1gsogUqzjOcNjcweIG+SlW/E3VOBhW52KM6Fp
 2A66cdGfBkbZQtuN7ixoBb9Zc7hFdOsFWMGRIQxj02gPVfvalGv/zHa/w1FtSdIi+JzPJlQr
X-Authority-Analysis: v=2.4 cv=DY0XqutW c=1 sm=1 tr=0 ts=6820a4b4 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=P7ETNM-qh4qR_gsSVD8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rMtzN1hODHR17fuvJmq5v04iE5XGUVmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_05,2025-05-09_01,2025-02-21_01

MACSEC block may be fused out on some silicons hence modify
get_hw_cap mailbox message to set a capability flag in its
response message based on MACSEC block availability.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
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
index 6575c42..6e13ab2 100644
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


