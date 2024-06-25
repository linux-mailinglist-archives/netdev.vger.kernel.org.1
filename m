Return-Path: <netdev+bounces-106604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96B916F54
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56235280D8E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F51448EA;
	Tue, 25 Jun 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ea+DP5Rx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F7A20;
	Tue, 25 Jun 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336859; cv=none; b=SIAjAnjvsG0VAbsQaNuH+gul/HwpvbKBywiinKgPHge2bXZDrRx2ldg+QMAHMTFmkbo/1yX/rglBTBRe4Kx+H+MZQLyS+VslHGqCEG/LQXSr5LC7P29wy1pops2+4FajUN8JlcZAA/HCQfVparQVooj4gzh6dxbME0PbGwhFsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336859; c=relaxed/simple;
	bh=o9J3y+mfv25XHEKa3Zd7JyTNcYT/cuJvyUDuFqHAe3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRkXp6s4OOHjY5D/3ZiMvhsDPpDAFA/ez+q9kXowI3n5sJiudTU4rm1bTwkhOLzTSaChp1z7b8mPc7E3aBINWtKDH+R22DvR3F3tF8hUojn+Zyic2nrjk7oAzV+8Ahn5B5LStlDZ5GhHkszPJGInt8MqD46JLHllXgaqdMmq2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ea+DP5Rx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtONM000939;
	Tue, 25 Jun 2024 10:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=G6tB93ZkO0VPPvJvJqTNtc/
	LBzuzdbxUwskJHzHaQ3c=; b=ea+DP5RxAVViLHpLCY8LOZ9lohm7Dd/M/LHhYQC
	6YZfjvyDtubN2Z5PJ+dZBzRV47BdPffF0zZNrbEjxkf3awldEZ0Lm9NT7rqR0lpA
	PVOzfxEPbL7bOIFdYuXO26FWzIr5gZfe1VgfC/g0N22L7rG7fTEPy02LxAOE1aHT
	YXNAwbzsccll4KUlSF+Gd+WQ1eF9MXNJxbGHZS7UIJWzfINNC3tn3YPuox+G1gmk
	F2oNPT1nIpL0clbZfNIr4QCQRvnOd6HcxNa90R/EsxGsYKAqTVTAj23Qs3lz7SHK
	XEJaCsj0oG0QKV17TXDFcso1WeYgvEP55K+gfNoCCL3wLWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9kfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:33:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:33:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:33:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 54C9C3F7063;
	Tue, 25 Jun 2024 10:33:53 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 0/7] octeontx2-af: Fix klockwork issues in AF driver
Date: Tue, 25 Jun 2024 23:03:42 +0530
Message-ID: <20240625173350.1181194-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gAMQ_931DFA3WaQwaoo6MoN-KPRiI6T0
X-Proofpoint-GUID: gAMQ_931DFA3WaQwaoo6MoN-KPRiI6T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

This patchset fixes minor klockwork issues in multiple files in AF driver

Patch #1: octeontx2-af: Fix klockwork issue in cgx.c

Patch #2: octeontx2-af: Fix klockwork issues in mcs_rvu_if.c

Patch #3: octeontx2-af: Fixes klockwork issues in ptp.c

Patch #4: octeontx2-af: Fixes klockwork issues in rvu_cpt.c

Patch #5: octeontx2-af: Fixes klockwork issues in rvu_debugfs.c

Patch #6: octeontx2-af: Fix klockwork issue in rvu_nix.c

Patch #7: octeontx2-af: Fix klockwork issue in rvu_npc.c

Suman Ghosh (7):
  octeontx2-af: Fix klockwork issue in cgx.c
  octeontx2-af: Fix klockwork issue in mcs_rvu_if.c
  octeontx2-af: Fixes klockwork issues in ptp.c
  octeontx2-af: Fixes klockwork issues in rvu_cpt.c
  octeontx2-af: Fixes klockwork issues in rvu_debugfs.c
  octeontx2-af: Fix klockwork issue in rvu_nix.c
  octeontx2-af: Fix klockwork issue in rvu_npc.c

v2 changes:
  - Updated description for all the patchsets to address comment from Markus
  - Removed variable initialization from cgx.c(patch #1) to avoid fix of different
    klockwork issues

 drivers/net/ethernet/marvell/octeontx2/af/cgx.c       |  7 +++++++
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c    |  6 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c       | 11 ++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c   |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   |  8 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c   |  1 +
 7 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.25.1


