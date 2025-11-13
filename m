Return-Path: <netdev+bounces-238262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB07C56ACD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFED42109F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2F2C327A;
	Thu, 13 Nov 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BFkpbkaM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642732D63E8;
	Thu, 13 Nov 2025 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026809; cv=none; b=gWwQChTgqxM0Bu5lR6NSW9JrNeVBeMywnhh34hdBf+RqgwNQ5kzpzs1ocGRjx9HuDgIrhGdxeLZJfVN+Kqu63KgTXvpdDbL3BFtQCFeiWZaEZ14s2NQ2704JQ3jUpAo95sCk6C7Mgw0fLcv0uHj3r54FAeND89UOf7/U1rL9PWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026809; c=relaxed/simple;
	bh=PccSFIPRborUgGL8/VaEy8QTABiLNVFPXAHshkFLtc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BsRyWUhZ6SLIpIR8C9pN6VZjdntCyqUY6r6FYzAG+UWfUJDYlHVii9eVtFgoD+VyY0nf1IID6YsA5+yfhKfH+P+V0feMVtfh2CH1hISXQYkBdJumvfIi9gC3wSxyIv/XibZrnlD9nXlkixgmfwZfRLHgR7dZ0dk8s2HcmFQlRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BFkpbkaM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACNSQim4032357;
	Thu, 13 Nov 2025 01:39:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=1TbnnwqrjwLHrKFyBzb646u
	Y0bstDmwiTNtuzxO4hbI=; b=BFkpbkaMv9bc1R9l1G1tvsW6/wlGL3w9Idq/TqI
	NX7CsDy//w2f5IpimP4wYInjK06+QlVYgJH6MJhTWsDatNGItCUhcapDx04o8P7B
	2ydycyFzeZKkRvcnLUr7QhVX6xkIqN/qnRmihn20AEIarT+J4NUIIjsfPlMxJaH3
	ZnJvuQ6SvGi/7qwkuOtZvqcEE0ePf+X9uj7xJOubw6ZJcDlxjxTYaTEkBRXrj0Yc
	Fe+2MaBLIIfEh4bKK1MyLDsDpC0AvwetWmTljJV1/l3X4FR2vIu+Np2wOL1Xm+Wr
	eyBVczAQEJAn+veHz6qO+07B4mAlHVNq09Iy2mpeTvOMVkA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbh62j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 01:39:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 13 Nov 2025 01:39:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 13 Nov 2025 01:39:51 -0800
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id D45FA5B6929;
	Thu, 13 Nov 2025 01:39:35 -0800 (PST)
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
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [net PATCH] octeontx2-af: Skip TM tree print for disabled SQs
Date: Thu, 13 Nov 2025 15:09:00 +0530
Message-ID: <20251113093900.1180282-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bSy0wnbNEdTFBStzaxsZzXAK5bK_0M8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3MCBTYWx0ZWRfX6/eiyOCtlj1h
 JdJ3+3V5B7sezLZdly2OOzEfjP29T5xKxnqIVoBmUXStZ/BbvoGQ+fDm8ECsS5JBWzBi5+0DlKS
 o8FovyJKrBdIJtaGvbQMXhC7LBARvD6myvqbnDbgTay8CLrKxnXX1Zw4ciK9F4yhadQpVaCAQSe
 D0hH4N1qgpWhsT344mGqOPlMV1C8BYS/C3da6AozaV9vmnQaDKxgVb3n/fI5wDS4y7c0+k5TxOH
 rg9ZrGybjOg+lDDJgbYhRd2t54Ccyl7/W41JXtFKR5umyk0LRTr2j6i34pysnOg973VQ+MsbbFN
 r6RnEhaM6x439qx/CyKRIbk6PGOsofhIsm3Q4o146Bl1dTLEoi+mE/SE+CzTOwDluS9hq27UzNq
 soAHSWPakUU4oddX/uQCg7I9lOzfGA==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=6915a75d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=TDmekW24L8jN3pXCac4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bSy0wnbNEdTFBStzaxsZzXAK5bK_0M8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01

Currently, the TM tree is printing all SQ topology including those
which are not enabled, this results in redundant output for SQs
which are not active. This patch adds a check in print_tm_tree()
to skip printing the TM tree hierarchy if the SQ is not enabled.

Fixes: b907194a5d5b ("octeontx2-af: Add debugfs support to dump NIX TM topology")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 8375f18c8e07..7e3be0fb8cf6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -1651,6 +1651,9 @@ static void print_tm_tree(struct seq_file *m,
 	int blkaddr;
 	u64 cfg;
 
+	if (!sq_ctx->ena)
+		return;
+
 	blkaddr = nix_hw->blkaddr;
 	schq = sq_ctx->smq;
 
-- 
2.25.1


