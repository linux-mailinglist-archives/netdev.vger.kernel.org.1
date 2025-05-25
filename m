Return-Path: <netdev+bounces-193250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F1BAC33B6
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B8D1897712
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B941E7C05;
	Sun, 25 May 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wy2HljHu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3531A08BC;
	Sun, 25 May 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748167169; cv=none; b=aai92heszYhBTSbapuraYUwz+F1OYuLGPFbqLsJUxVi90mkhagps+RZHg3NOFtWB1UUMDINkE+MrXUVAkk2nHt2y3MCp9ohNIDQp8ZqssqMHliTABKEhbG7lDAJ27VZzRBGixkbEL9ytMZTIA9lYTk5RRmY2R/wNzMJoP7o5Dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748167169; c=relaxed/simple;
	bh=V3tmG3dLO9mr0GAHG2bi03/J92CNc+D6dI01p6IGmts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4Uac0TQk9i9CTiI9oIh4B0pjrxxqKpcvleDuxV5bTO5jSMit2juBSS/g0Ujy2L1JKdxC1LRIzTFNhyiKqsKFqC//+J9bOh3nL6/7NirrhO6JUs+rStfwgdWADVplIWh7FJ73bGFSdC7kHDFTUhZOmT5iGEO9lmY9saAB9lSCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wy2HljHu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54P9tc31010346;
	Sun, 25 May 2025 02:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OplobE/ksS9d99f5uK5mcir
	jzOQv08vitVJNOGxuBYI=; b=Wy2HljHum51U4MFHuIQjbNACxoE4cco9gSA6uhh
	TZEht2PwhEe4xkPtbbZIrf12PiWqm8+o3xAQAfk0Jj9pKXTRyiXhrfb/bWfmrqHG
	dDpEFsMfn0CMhTR2V6AyLUoqV4X5FxkSx9OUPWcPA5l2qCaVUUJZa+wD/FXmIs3l
	+zzXupf3M4ZtXG7acxJ9kHyCkRzMOPc0aQfkuzP/Ab79d1EcfJaN7bosOL6Y45qA
	r2Y9gDod+SxsMsH0M7AHsjmONfJiFkw/fjgR5fg+VvTgCpw0ZDHaPm6j50WLMicJ
	7ZyHVJMAUBbeRnh1S1nkAVZNmiVEkhobkyKepq7GvBdFEqg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46udmjh474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 May 2025 02:59:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 25 May 2025 02:59:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 25 May 2025 02:59:03 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 57C5F3F709D;
	Sun, 25 May 2025 02:58:58 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Simon Horman <horms@kernel.org>
Subject: [net] Octeontx2-af: Skip overlap check for SPI field
Date: Sun, 25 May 2025 15:28:54 +0530
Message-ID: <20250525095854.1612196-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T8qMT+KQ c=1 sm=1 tr=0 ts=6832e9e8 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=KLocVHQyFJvDF4PZL-8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDA5MSBTYWx0ZWRfX0CJoPIkmuRIV hNlU0zv13z5O1039yS1WdaTppLez8iGVzIVW3VvD00hoPej49+XCotDkuVq79IeFtmGxwsHM8iq 3n3fdlHD2rSISYvCL2AoEnPxvrKxjXjtR4Sn4tvBX7VHe50pzccuEZbi5j7AvLtqZc87avFKx/T
 MtMzOMD7u6uG8Y4VLf0n/2avSS1TvKcbPMLKL9mFCVoVMSMh5SiWzsYAX+HMb7gXXyjfs+tGH0v t8oW4qFpB7ZlfZFwWG23VnbCMWexhiKIg/E3GMhP4mOcZY/fFUqYQOlFL+beiOS0CHyQhFKLOOE dIfdPi8QfOvZSao2hMPcUuHveYZHovMHTrHCJb7TdmvJFWfXFN5/slyt1+q0PacNn2wmS+jt8aE
 Ap7C4nQMKRv0nnnZJ17pgBrexCQDTWzVas1QXw6z9gE9DH+Ib3bW/QVzqqWF1aWfhbYhjvYX
X-Proofpoint-GUID: VzaG_KmzZslV0bbW84rBl6ycUkRTlecf
X-Proofpoint-ORIG-GUID: VzaG_KmzZslV0bbW84rBl6ycUkRTlecf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_04,2025-05-22_01,2025-03-28_01

Currently, the AF driver scans the mkex profile to identify all
supported features. This process also involves checking for any
fields that might overlap with each other.

For example, NPC_TCP_SPORT field offset within the key should
not overlap with NPC_DMAC/NPC_SIP_IPV4 or any other field.

However, there are situations where some overlap is unavoidable.
For instance, when extracting the SPI field, the same key offset might
be used by both the AH and ESP layers. This patch addresses this
specific scenario by skipping the overlap check and instead, adds
a warning message to the user.

Fixes: 12aa0a3b93f3 ("octeontx2-af: Harden rule validation.")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 1b765045aa63..163cbce8575f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -606,8 +606,10 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
+	if (npc_check_overlap(rvu, blkaddr, NPC_IPSEC_SPI, 0, intf))
+		dev_warn(rvu->dev, "Overlap detected the field NPC_IPSEC_SPI\n");
 	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
-	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
+	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
 
-- 
2.34.1


