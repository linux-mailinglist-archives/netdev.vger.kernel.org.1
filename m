Return-Path: <netdev+bounces-229159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B737BD8B1B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D7E44FC3C7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E822F5A2D;
	Tue, 14 Oct 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWAwIThU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0C2ED14B;
	Tue, 14 Oct 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436901; cv=none; b=emILXdxZCZlAkeCBUIt2QBSbaBI32IHlzIHohrU14V5SeJwoifOImqgrtdkxz22LEg7svteTzGSsaHIRmIFAYGgsjZN4qlpc5KXQJGuDkamy0yMUqdN4BdWDCQ9hnsDPmabtac8fjZI5Q8i+1o1SHvvw6csVDUEYshLUj3x356k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436901; c=relaxed/simple;
	bh=6LQ/ooMvB3nFZedw7u8xDGqdZaVegtvDkC95WP1B+ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiVGDbyQq/xN7onMMV/95ka+Hmxifr+I1ZraTdCSy/NrNB1bmIB70Ax47nJv5ZUqp0GhJ2fFzH68Pl1zeiBkFHzg85Myk2NgDhP8w5K9tLoRguq3m+oAlgYmIjkqGuxhURei3FJJTFr02ErDWN0dmmRqv1cqJPxWvePFFO9/UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iWAwIThU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9uv0c000747;
	Tue, 14 Oct 2025 10:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=GkKuRpOJeMZpPf82BkZWPHvEYk7HG
	F/kROPkkBed3Gg=; b=iWAwIThUoaIw4tPwkQitKiyLVgzBO8KMhnXoulxdev6ii
	vjjlh9ITdcY0PSjV68c8abdkBf6n6vvGNrLumUKgkFn2bmZahKLtMvDHo+qzvmRF
	eJoZCjmw0rovEL8LkQADjLeRE7uN5dUckw5w9bHHJuaF1FcRe4y5uAF2qDPnXu8D
	oR+4TicyAm7yyBDBoPyv2P+9jsEDroLss0lXzbc5d/duSuuXmdWKxFxN1X0brtma
	UFwHG38B4eDRdKTidEYYRxOVBk5p3PcEPRMkrQ3Tvhjr4xm5fquhtOK9DJ15VOwA
	JqBwKpaVt2BEJfUN0Gl/W6z6g2/udcKIA5niR61wA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bv19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:14:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8Y9GV026328;
	Tue, 14 Oct 2025 10:14:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8g58x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:14:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59EAEksW009763;
	Tue, 14 Oct 2025 10:14:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdp8g582-1;
	Tue, 14 Oct 2025 10:14:46 +0000
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
Subject: [PATCH] Octeontx2-af: Fix pci_alloc_irq_vectors() return value check
Date: Tue, 14 Oct 2025 03:14:42 -0700
Message-ID: <20251014101442.1111734-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140080
X-Proofpoint-GUID: ZC8XgT9HBmCZoGtFHrc0voSLENPeFmeU
X-Proofpoint-ORIG-GUID: ZC8XgT9HBmCZoGtFHrc0voSLENPeFmeU
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ee2298 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=4n8vcYqJx_LAIKf_xDMA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXwE80qADYcDOZ
 NmVf4deN1GvFmTmtvIPZfcf34gUdpXGlM4XcPoMk4oS//kaaoieWm2aEAfQqEt8OUzjawINaTXp
 klZmWx6KI7uy+Iqcl7y4qn4Oq/xGCSEaSfo5NsTIiYsqNaapZLyVMX5trqzyslhCMtD33hlDbwT
 jbNqN1BXBaEKhqrFRvLKDfEh3cj40R8KBiIHev8T01TcRkGmPJZuBsbO8lI3OaB4JoToe8B0rxl
 QoeJ9hFoXmRPZh6Kw3Lwg7lkNHwnzz5Jb207k9TFarg7Dm2hicNEeKGvJDdgV6ulOGWjXcNiC8Z
 OgC+7NdlPC21YbC/oVyDtc4KdRWNuEhsZy1SnI6zPkhIgTjlYvmcAupWPsxPPeoLzSe0qV8Fa0g
 sNqDz9Zbc1j/Pr4zQr2RFS9eDxmdDU1Zmlq93HNyu0kmwalD7Js=

In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
be negative and that check is sufficient.

	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
        if (err < 0 || err != nvec) {
        	...
	}

Remove the check which compares err with nvec.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Only compile tested.
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


