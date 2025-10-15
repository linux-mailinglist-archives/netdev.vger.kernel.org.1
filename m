Return-Path: <netdev+bounces-229528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DEBDD94C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCCA3E6D4F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F054307AEC;
	Wed, 15 Oct 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRQGh9o5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53832DA743;
	Wed, 15 Oct 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518904; cv=none; b=hOq2YHC8ZK/xi95k/py2LOJJ3FN5x/laU9xcAKN/FzxRMUvxEztOFvqvMyW8MGE+uFg3OMBUMC+XqfLWET00XGKvaYhEl6y063KoAw79BLeU3gYtdjgt/vSNpRVFVMmwMEAGinbQ8j0LYsAK88ycnqGD7rA0XmG3+aYihTDjDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518904; c=relaxed/simple;
	bh=w4rWAc3iXD8cDZPN/ldhEQotUugo1otzTsmf3kWNhPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCMUusNDdyv89EoEI+1+tQCjUA+WmJ+AXHbTaPLNHOpWddapJIm1zeC5y+6Ft1IXxCjaAPU89rFAl9ZWezjH2ip9WAZ4nbxW1ndMp2oH4GASGpRBwYqBPf6VrLSoackKfg75DSAEfOuQNDd6mWEyhWy0Sybb1TGo1GB/b+Bg1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nRQGh9o5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uKqd007179;
	Wed, 15 Oct 2025 09:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=YFIMYHPwq6ijwBbbSTE72g22zqrjc
	DkXohixte73Eiw=; b=nRQGh9o5hmT4FsueYWrv79B1FoB5+amlueG9YmNyblfqR
	BICpbIhH52L+ADyPZth5VpfakMJki3d9NiVHJK91oy3RsjGZjYr0L6bQJXR84kjb
	x6aJ07HDObAH4XMy7fVi3SI4HdvejIXyCBDcBsB9cg1fwNJfNyI2skBiYhRuHaqD
	/nPp0SMPyp8/qTgV/4LbHEd0xWta4F3kdCdbyswGbGZiCCcbXfLZxwC2LAwdlw3S
	NPfWl/W4fqnHd4D9iUoZJ8uKThNzvdj0q4L1EfF8OnRdKFGVLLQAtGuWBzh2qptd
	kXc5/wrmL4jo78qI7DiUPjPRbQ0/l/pdXD205T1yg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeusx5rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:01:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F7o9Dx037869;
	Wed, 15 Oct 2025 09:01:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpg3q20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:01:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59F91Vhk035640;
	Wed, 15 Oct 2025 09:01:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpg3pyg-1;
	Wed, 15 Oct 2025 09:01:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Nithya Mani <nmani@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH v2] Octeontx2-af: Fix pci_alloc_irq_vectors() return value check
Date: Wed, 15 Oct 2025 02:01:17 -0700
Message-ID: <20251015090117.1557870-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150068
X-Proofpoint-ORIG-GUID: fkaYExNKup0ScYqTK8bxt0dSFisfWCxg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX4T7SS0z0j1fu
 q8OeN/J6XsLPlmhmDZ8Fkek6flkaFcBBVCHWYb0lAgW+GEx/8agM8meyC4z5Ma4xtjnDDv5SLe5
 MiWy3wKdM0LxbkJ47Y9CNNbJ95oj4BP6U2YCQ20F1Ah+etqHTC/WDUjHCDpLCdlo6/M7oddZToc
 t+46QP7jIbqPbwUzCFwvOMhmJZc0VePX/qfsOGz7EaV13xLooZcyDtBHFGm0YUrLkASMLZv5UHw
 mHgRMo0kUkCrmO+FlB78H2CZ5BMgPAUNXwcCH8b/cOkPRkOBI9AovSTxkM7xCqp3ZLfbStBip+e
 SZ8SPxjrFqbLGuugAfqUnZLbbMpMgzQZ0hivUT+el8RHJ32x7v4QpuhWQbKtwwJ3re9ZyHl0/aS
 AWtnbJ3673PWg+l+Nx8m2lh+Y3/fn+HY5SQkXYJQtf5F9q8wLFc=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68ef62ec b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=4n8vcYqJx_LAIKf_xDMA:9 cc=ntf awl=host:12091
X-Proofpoint-GUID: fkaYExNKup0ScYqTK8bxt0dSFisfWCxg

In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
be negative and that check is sufficient.

	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
        if (err < 0 || err != nvec) {
        	...
	}

When pci_alloc_irq_vectors() fail to allocate nvec number of vectors,
-ENOSPC is returned, so it would be safe to remove the check that
compares err with nvec.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.

v1->v2: Improve the commit message
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index d374a4454836..f4d5a3c05fa4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1993,7 +1993,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	nvec = pci_msix_vec_count(cgx->pdev);
 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
-	if (err < 0 || err != nvec) {
+	if (err < 0) {
 		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
 			nvec, err);
 		goto err_release_regions;
-- 
2.39.3


