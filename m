Return-Path: <netdev+bounces-106607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B3916F5A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECC11C234D1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCE6176AD8;
	Tue, 25 Jun 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HSEX14X0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26D176225;
	Tue, 25 Jun 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336873; cv=none; b=qJw3SmG8HTU0zGlg1GrGS9hl/D3MNqLjDSpqC55034dDrY1fSr6iPba/gTnzeszqlE2yil7nc8PJg6WV4wwUWMEfmRhDplmQv9yl/LT1j203Um66h1MwKz3aAC5HCBO3w/Hh4Qx76aZPaogDSlKx+RlNRhvLybt6lk8HSoX5hbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336873; c=relaxed/simple;
	bh=Vyv0SWOwJ6qrJ8qPCzeftxln8S3HT97YjuWhON2Runs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge5QYfJtPyEIbnFRTBdptQYRt90CHKlJRQVIIL3XgBDttcjCYdvEWaJOZ0tXriVPrAVRsRVC1nlc3C0Zp4F2ZzVNmVe4f+zRgC8X6v3CK/n3OwvS0xou45QwdTpoQjaUH9tIDmNShCW7YZ4abBWr47TuIeDjqQjMrXRd1PpH3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HSEX14X0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHUbPv006245;
	Tue, 25 Jun 2024 10:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	YCVLA030JdTa4Etwmskuq3bLahLN/g/i7womYaVbAU=; b=HSEX14X0jQg2Hy3E3
	NZs7GEPie1VtRpEDUbKu1QZvxHmM531udrHYN5iSKHZJNsD40M3o63f73XkzM/Ad
	l+kH5do1AVYuffG5CkWO0/WtTmQXIawDbnUxjU8o6YvxiyClSXFxBHGj2wVPcSqA
	liDbNoJbb7fdWZlhpQ/jGLAAuGyoc/RtiGw+YNcQqDfWpWf3XzF0EhWiJN0FcZoz
	DW1QeFiAPOyVa+d6Tfyzvx7ZpD0b6s2Um6uoCeIUeDNbUVSCtX+Mq+qW99w28KYJ
	Hwn2W+ncPomF08eOumtLTxUXb6XiHymdbE+vKFQDwQiak/1604wiKVW1yIRwGiLy
	oZ0NQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt0a2wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:25 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 20BAB3F7063;
	Tue, 25 Jun 2024 10:34:20 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 4/7] octeontx2-af: Fixes klockwork issues in rvu_cpt.c
Date: Tue, 25 Jun 2024 23:03:47 +0530
Message-ID: <20240625173350.1181194-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y4L1rctydehXCFjhzpcM4eOkIQIvenzj
X-Proofpoint-GUID: Y4L1rctydehXCFjhzpcM4eOkIQIvenzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

Added initialization of a local variable to avoid junk values if it is
used before set.

Fixes: 4826090719d4 ("octeontx2-af: Enable CPT HW interrupts")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..a1a919fcda47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -43,7 +43,7 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	u64 reg, val;
-	int i, eng;
+	int i, eng = 0;
 	u8 grp;
 
 	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
-- 
2.25.1


