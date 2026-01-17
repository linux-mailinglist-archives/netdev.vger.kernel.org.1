Return-Path: <netdev+bounces-250713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FAD38FDE
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD11C301E171
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3697A230D35;
	Sat, 17 Jan 2026 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hjDZ7qwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96289475;
	Sat, 17 Jan 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668950; cv=none; b=RoJ5tbh7QaYi1wdF2LvOLTtd805yDxiN8LyZQ4sPgTFTtWIRdPpygmStDKdHDOxWUOTT+i/k9ogb++1wTLAwMNggOFIYjsZFrkaJWqCXRJcGpxy+E+IYUxVnCsyyiaS7tT/QSvg4vY1gzHwdJDS7wI9yy8135EmUc8+vkg8sgmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668950; c=relaxed/simple;
	bh=MTTKuupNYcvteB9PIZxGJihG/TDapUY75Jc97xikZrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9GV3mPXlTBNm6qH6f5rb/gAtmsCyoJ1Tkhh9KZkO8iJbCCCZTWB1PPZJxgEKIEYSYoj9/QHMoGGtubsWqdGB6tBKlRB5xKtj+on6Y6EbQpTAh4CiZOnzBaubDv/2o5sW942SXPrgQbF8ismL9FnqZgHB/JkvzgB4ix7fa5ouGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hjDZ7qwZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HFwqcc1417475;
	Sat, 17 Jan 2026 08:55:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=GIx0eYJ+iPPUH+Sz0npBP2N
	hpiL947MsYUlIV8B11Ps=; b=hjDZ7qwZAdemGjvg2Wr9HpAtwWasC29YfN8GqKm
	WRObSnWrgRWe6vDwXfW3geB4pMuvga2EPfZkoEvwW//qD04ECal+vta/IZQyev5B
	S3RsWJQc8SAcwpzjJYT28YOh2B4sD6HGuoXChRZfuIDu+9BfFwQuU5vukUsOeaMw
	QfISVIQk2ogAfmTJ9FIbBH+dxg3ALrtbpbadlcpxlLHliFUMFeWOiGeeFvP7S8R9
	rayh54jIeVgVEkknmzGN6zG0p/RJKvWeB6+4q1dFoB8oLkkyFbm2iCozWCiSJBwW
	T4XHXLgIWaN6/ndOALYQBb0b38qtasmYrHf0YFd+FyixrxA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4br2yvrsf7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 08:55:27 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 17 Jan 2026 08:55:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 17 Jan 2026 08:55:25 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id D93623F70C5;
	Sat, 17 Jan 2026 08:55:21 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 0/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Sat, 17 Jan 2026 22:25:18 +0530
Message-ID: <20260117165520.2215073-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WckBqkhX c=1 sm=1 tr=0 ts=696bbeff cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yfvZBKtj2kfplXi_T7QA:9
X-Proofpoint-GUID: csAyaA1nVol9AwujKcMbXjtbd9vZr9xh
X-Proofpoint-ORIG-GUID: csAyaA1nVol9AwujKcMbXjtbd9vZr9xh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDE0MSBTYWx0ZWRfXylUgvNIjzemQ
 2s9p6K76REf4MWvLqmRkXavL/r5G8AhVHvZmi8MGjN1gcU8/UlRXCzYB+UIPCTyuo7vGxBPEGYh
 i1OyvbbSUL2FD4mwnapGOI20nT52U1+GNakRbB56rKBS67nm4C/JgI8vTFUuRR4Su397oHZxvE9
 q71z7VqL4Qb5xIbzmlbj0tf5P/i6YXSlgX0RBi+J/tfI9AlNoWkMXvRD7c6/P5Avl+Fcow3rUzj
 v9rJRgnhKkEkLUR1gCV3z/LJgbZPujW+s8zTfMyonLfuvfMei/V9FnvmyJiCZG3hFhv6+1eqCxw
 lni98k1oE1QYfLVJVJw+zwcUCNKa5BJn7mzBuMwHWNgMOjOyasArUh+d7PDN/7ZaY/W8jwKTfID
 NiRZJ3E+BlMuNT/qBFBDyaI1muWlADQ19s64fj1BEVCxIPqNO6gQeia5n2Se6Fsu5EjKOr1gb0J
 +UMx2CP9zea4SXC0PlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_02,2026-01-15_02,2025-10-01_01

Octeontx2/CN10K silicon MAC blocks CGX/RPM supports DMAC filters.
These patches add devlink trap support for this functionality.

Patch 1: Introduces mailbox handlers to retrieve the DMAC filter 
         drop counter.
 
Patch 2: Adds driver callbacks to support devlink traps.

Hariprasad Kelam (2):
  octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter
  Octeontx2-pf: Add support for DMAC_FILTER trap

----
V2* fix warnings reported by kernel test robot

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  11 ++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |   2 +
 .../marvell/octeontx2/af/lmac_common.h        |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   |  18 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  20 +++
 .../marvell/octeontx2/nic/otx2_devlink.c      | 165 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  23 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   7 +
 10 files changed, 254 insertions(+), 2 deletions(-)

-- 
2.34.1


