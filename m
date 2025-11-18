Return-Path: <netdev+bounces-239385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A34C679A5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 84F6129C3E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9A2D640A;
	Tue, 18 Nov 2025 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XNPABXOQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65C2BD5B4;
	Tue, 18 Nov 2025 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763444609; cv=none; b=I6gHj2eab5qYwdmHpzQamyTR1s88PCEMU8vIgTGkf2QY1MXTVHPcxE8eTivzz9zIvh3WYG7ttHF8DiCnKBW6laDDGu4I1s4Ld4055UC2OedwNDmUJghbMG+icd7wZs3kFmfCjlLpiP7Z/uEwTPvQgqsYoWFHkPzDjJFj5rA7X70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763444609; c=relaxed/simple;
	bh=gIavelo5vm1snqJlIZMMnz3SvaQtBBy3AuuY6f7eANc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgWyjb5OxvJX7IwZ170KDTlavlu38iVMftAxJ7KP+H2DL+GlLfXsmXxGh2ClrC9OsvUXGoHAHUe+f0jKZlZIngCLGFHMgPYEQtyjUhzCA6qicpKATT/TJ3pw/LdgqYoWHLpED4Hf00q3oCsCtbB9CJ4pxE3ycMg1t/sTrnHi/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XNPABXOQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHNS02a4159140;
	Mon, 17 Nov 2025 21:42:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=TdnGE+ISE6hJTJvQtA+FsQc
	gGsuBOsi8qKi8AxWIp5Y=; b=XNPABXOQKjOytdqtjQQXmXtyquvWq7VP7PJAG9T
	jvNfcs/ozaxcMlN7ueuNJ3nEGacNKMwKtsXoaa0hfTi3TyKNSLClxlZov0kae6Ug
	KPp+uU3gfmExCIm1f7+CIjekCWxud2LmQ/uQzqi3f0sRS2p7TCXMak2geYa/4AY3
	6JuiVKH3OVQBfU9bva8GU2MEJhAr+Ga3IlOzJJaxp9Qw840M5z2Q62gHNGHEF0ar
	CB5fOi6atblKcAjC8i9Xp/68IjrSQlGoM/h9TzavaP1dUXm+VrnSsZI1YGhaB9oE
	siD0BYuKENuDTRkypnFskryj1wDU//Ije8++EnoQobj2ETg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4agddc0r6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 21:42:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 17 Nov 2025 21:43:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 17 Nov 2025 21:43:08 -0800
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 1480E3F70C8;
	Mon, 17 Nov 2025 21:42:40 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [net-next PATCH] octeontx2-af: Skip TM tree print for disabled SQs
Date: Tue, 18 Nov 2025 11:12:34 +0530
Message-ID: <20251118054235.1599714-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA0MiBTYWx0ZWRfX8taIM19y7voy
 bT18C4VjbyTUw+UK1gtkFJuthbwiFiqne5D490dCrp9hBvqdjyjdIPOCiFWbNcxkjFTfUTW4XCp
 6iO+SbRaPiHHVQkkB55R27xuEqHk1054HgTENPb6OlPomUhBbzntHLEGdep4xaQ6OL+kHIj0zbY
 u4JAXm5RqPSvH6GLPyp9Wj/52O3zMOd7r7lbvZdOf4xFdxTdkgIJByqPAY7HnqJV/gBCOzLDiwP
 5Tdu7qoCnd6wCVGyvL708AXMKOzdye8fl8CAENVoy9JCwVoUN+GZROfMtAVRiJjy+wQNKtbJMOy
 LfdPYZdiHDVTBAvbJTy/qKYv1gDYHr2kduG/KEtnYdbzVds7ghv6Pi983YBIMSq++J9Ipo7jFVe
 wva+gJ8qRQbIPLsaXJCrhQ4h7WQjOg==
X-Authority-Analysis: v=2.4 cv=WNVyn3sR c=1 sm=1 tr=0 ts=691c0761 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=VXwXFphZWUwt223JmCYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8d2AIAhUmDjQjBY93P-jE5Xy13fNkm-O
X-Proofpoint-ORIG-GUID: 8d2AIAhUmDjQjBY93P-jE5Xy13fNkm-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01

Currently, the TM tree is printing all SQ topology including those
which are not enabled, this results in redundant output for SQs
which are not active. This patch adds a check in print_tm_tree()
to skip printing the TM tree hierarchy if the SQ is not enabled.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 7370812ece2a..15d3cb0b9da6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1663,6 +1663,9 @@ static void print_tm_tree(struct seq_file *m,
 	int blkaddr;
 	u64 cfg;
 
+	if (!sq_ctx->ena)
+		return;
+
 	blkaddr = nix_hw->blkaddr;
 	schq = sq_ctx->smq;
 
-- 
2.25.1


