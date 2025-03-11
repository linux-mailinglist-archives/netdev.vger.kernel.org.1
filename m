Return-Path: <netdev+bounces-173992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4EDA5CDE0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AE31895EDC
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64D263C97;
	Tue, 11 Mar 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GE0Z30h4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75695263C69;
	Tue, 11 Mar 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717628; cv=none; b=SkSVAnyZ4JwQs2NYB0HoFxzTOXNoR+r54aD500nBOfomlZF6VhyPVS4THLobz58i3lefLm6ocKLy4T1jeVtCR7z3GA4ndzRgHTpTzUpbDABOdXE+XCUqBSz7XF55UjIrDiR/Q2kPwqP9yxTV0uLp+zrH+U+vev3sfHUmx+ZWae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717628; c=relaxed/simple;
	bh=sAcPmP5x4MDgX3q+zT45VHsc2Xff81Pj4aR2VDWSe9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V6WO0lgPrpaURFV84CQedovaXi3yG1ftdnDcvkgJEXjt0XttuGel+UbJ674WDt0jhQ682S2FRw62d2+x35paFwHujVFfKTPvUJKVbuDHLLmaG/p1AP+yNR31or3U52BSa+CNRQiiZeSlkLWaBrXTKNSmZNcq+5TgaMHZ5y/gPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GE0Z30h4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEwj83023500;
	Tue, 11 Mar 2025 11:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=L+B7/fcRis6/t8DAVLhAttm
	jqV+WSMG+iLFaF0sDEIM=; b=GE0Z30h4oH/EF3iIiJL7SNfvKry+MH/rZctFiUP
	gHB1eN+Q7ZG9heOvu0ykR9dErblvukToKfoGx3zAFwqJtYpR42RSYcHiBSuHxkc3
	8G0OdKtzp2KGXWyBqgat3sfXLaTHhDeA7GKBHa+GEsivL4IVLEG/HH9ac84lsdg9
	ymttmKjk9/oAnsDHP7zRDrpBNNabxAvz/60R6+v0DzSPQBV+eRxsIEN0wikXfcvI
	KjwyAWCvRyF6bQCS5U/ZVGzd1MheDIWI8vn/MsMbc7loojj+ew1E1H+GIDEcVoNL
	O2eX/P+1vFTXA1CcXHejZikVSVw4kEA85W0abF1lhNXgzKQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45aqdjgg5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:26:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Mar 2025 11:26:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Mar 2025 11:26:40 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 26E843F705D;
	Tue, 11 Mar 2025 11:26:33 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>, <llvm@lists.linux.dev>, <horms@kernel.org>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v3 0/2] octeontx2-af: fix build warnings flagged
Date: Tue, 11 Mar 2025 23:56:29 +0530
Message-ID: <20250311182631.3224812-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=A8WWP7WG c=1 sm=1 tr=0 ts=67d08061 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Vs1iUdzkB0EA:10 a=8sePa-ASlOdttdOSK3gA:9
X-Proofpoint-GUID: gPQOg9BHDoTlbXxBhWcGm2YEq4qe-BpP
X-Proofpoint-ORIG-GUID: gPQOg9BHDoTlbXxBhWcGm2YEq4qe-BpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01

There are couple of build warnings observed on x86_64 flagged by Sparse.
Some are inconsistent usage of __iomem annotations and other Sparse 
warnings are typecasting related. This patch series fixes the same.

Patch #1 This patch corrects the __iomem annotations flagged by Sparse.

Patch #2 This patch fixes rest of compiler warnings flagged by Sparse
         which are related to typecasting to required datatype from
         _iomem.


Sai Krishna (2):
  octeontx2-af: correct __iomem annotations flagged by Sparse
  octeontx2-af: fix compiler warnings flagged by Sparse
---
v3 changes:
	Addressed review comments given by Simon Horman
	1. Fixed compilation warnings reported by kernel test robot.
	2. Addressed build warning fixes into separate patches.

v2 changes:
	Addressed review comments given by Jakub Kicinski
          Corrected Closes tag which was tampered by mail server.

 drivers/net/ethernet/marvell/octeontx2/af/common.h   |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 +++++++-----
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c | 10 +++++-----
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  9 ++++-----
 4 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.25.1


