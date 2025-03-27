Return-Path: <netdev+bounces-177903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC08A72C27
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D81C1691E0
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876F20C022;
	Thu, 27 Mar 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UcyhD6X5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FB20C00C;
	Thu, 27 Mar 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743066907; cv=none; b=PQ3q9qfpYVhC4VmsOOwhwCut2TXpVF1QrmuGcuIUW9AMELcYT2UFmKB0/aRD6HOT1gpGxuUS4aK5/XhyfUViOCIvOyc37SAkvCtmV1sZK4KfxAnTLhopDIZQzd53fwR5wBsYRLQ8RDeqZ7i09QrnRX8S9FczFT+xiravSiC0Gn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743066907; c=relaxed/simple;
	bh=Cw6ejRTqbNTRy1dOrLVVDEgZ0Ll7ZxSxIn2I5fiFSAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2IH7ICwbgk6dWmCG+/3ABWadMhsP/HHmM8wNM7IHOdQc6Ne3/ZMWkelSeNHyy5bkUZBztcfyT/+pVegAyZojUMTQZ8I6ZQhM48di70RPIWTv2GplB/tgYSWba0pVUZstC0THjI+ABkUK4WvJPLa7eVTCwORDHg9oO1c74MVOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UcyhD6X5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R75vwR014009;
	Thu, 27 Mar 2025 02:14:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=qfACdZ3eEfdUgRMgQABnRXr5APgDUxRBai15XeOp4Gw=; b=Ucy
	hD6X5n1NGelsCwcp5nff3o+veRXZqYYqFCf3c1R1XaABtwQZOvJeZ5UqGUGOMlzr
	MeJXpxTjmdhui0HJPtOwmkw+7BQVX0eMNuug1At7TmXxpjby6SBUwIJYy8KRTYuj
	giLw7oAGI+eOAl+zwn/OFqj5sr2WhCJBKk8uq3SUK7U+z4Xkd5ELggXWI32NAea/
	Luhs15MB0RMh9TDst7XxlvpqkFumxJluXDmluXtmD7bERx6loyJvodF0Wmf2YqcH
	Xogma/rKkbDRJHtM4XoQC35oGkxwl+illjhUp1Jp5pn169gQxwDB+lSvS1nuSh07
	tk5zy4axqJCpbhwelXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mqr3hf38-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:14:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 02:14:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 02:14:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 701EF3F7063;
	Thu, 27 Mar 2025 02:14:42 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <tduszynski@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix mbox INTR handler when num VFs > 64
Date: Thu, 27 Mar 2025 14:44:41 +0530
Message-ID: <20250327091441.1284-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GORetHUyo1tBLtBLUj8WTAd9j0PlFgeR
X-Authority-Analysis: v=2.4 cv=Yeq95xRf c=1 sm=1 tr=0 ts=67e5170a cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=M9fZB8FS68YcmyB56HsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: GORetHUyo1tBLtBLUj8WTAd9j0PlFgeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01

When number of RVU VFs > 64, the vfs value passed to "rvu_queue_work" 
function is incorrect. Due to which mbox workqueue entries for
VFs 0 to 63 never gets added to workqueue.

Fixes: 9bdc47a6e328 ("octeontx2-af: Mbox communication support btw AF and it's VFs")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1..6575c422635b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2634,7 +2634,7 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 		rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INTX(1), intr);
 
 		rvu_queue_work(&rvu->afvf_wq_info, 64, vfs, intr);
-		vfs -= 64;
+		vfs = 64;
 	}
 
 	intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(0));
-- 
2.25.1


