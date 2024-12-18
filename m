Return-Path: <netdev+bounces-152918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CC9F6552
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B98C168C2C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FF19DF5B;
	Wed, 18 Dec 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CuMY7BMx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51605193079;
	Wed, 18 Dec 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522686; cv=none; b=LkPcdn5Fcw2uf481OKOQZ+PeOCLFd7ZpItVXS/ZKEKq+us9N/5Q7t5EPmhuUaki1yVbEDfuYv8UrR2VTJLIYbkUGgXeSOiZCBrGJR0ZLF/Uk+TEJTWdFcLPc48+WXEABjhDi8mLZ/6Trpm3Xh+lKTewwKRRBKCaTVlRUNf9lRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522686; c=relaxed/simple;
	bh=YeDbIQAkvApLnurElHHDzahSUlkc/SoDdmb5n++dJtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jD3+AyhL1UNYN+w/9njsedNF1xhVWO8oviBMVGwL3d+gU65l8LfZooYsZWQPiT6pFM4p9Cg6bI3hV0gNVkg1FTvPk4xJ7RxZ4x2R69H1vbxMJgQBxSNeyvDmGBJjkUQnKGxvl8QvJvmduzp1ue1hNAqsRzmLnDyM8zrgmbLhG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CuMY7BMx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIAHkrn013132;
	Wed, 18 Dec 2024 03:51:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=CtisIMngXsOl2k/8y5ajLwE
	gVthqTu+5BkMeB3uKsWs=; b=CuMY7BMxdVjoB/kvlpnIet81QiR2wfyZKecidv6
	9g+edsNl+m3eoIAKsfQlbUcXyFfSL6GxN+mVzcech1gWBkl3p/oPetDcNyBYrnxY
	qScSv/mHHzDUQ4YybthaiQimi51FgYhS/q6XXgsyTM2y3VEFPYStnRrWM7agk0g2
	AWjTWyJnyV9Pkx34qj3cMlWBp0H7o8BSIK/8PF004XzPnhn7boONqkCS/28Y2v+R
	wQbC4AiOCUbtKmKUNob93JZ0zqUd75wph4Nt4HdUAx52g9oBCFkLIYjrO2A5bfjU
	o+1HveU4KmDAZl+Ln3lKgblsAubAwWWW7OmloShqGdBFbCg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43kvgvr501-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:51:14 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 03:51:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 03:51:14 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 7B00D3F7072;
	Wed, 18 Dec 2024 03:51:13 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v3 0/4] Fix race conditions in ndo_get_stats64
Date: Wed, 18 Dec 2024 03:51:07 -0800
Message-ID: <20241218115111.2407958-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zDn74tMBf6cIv-YNbEabqCpjOduDt-Vw
X-Proofpoint-ORIG-GUID: zDn74tMBf6cIv-YNbEabqCpjOduDt-Vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix race conditions in ndo_get_stats64 by implementing a state variable
check, and remove unnecessary firmware stats fetch which is currently
unnecessary

Changes:
V3:
  - Added warn log that happened due to rcu_read_lock in commit message

V2: https://lore.kernel.org/all/20241216075842.2394606-1-srasheed@marvell.com/
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-1-srasheed@marvell.com/

Shinas Rasheed (4):
  octeon_ep: fix race conditions in ndo_get_stats64
  octeon_ep: remove firmware stats fetch in ndo_get_stats64
  octeon_ep_vf: fix race conditions in ndo_get_stats64
  octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c   | 11 +----------
 .../net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c |  9 +--------
 2 files changed, 2 insertions(+), 18 deletions(-)

-- 
2.25.1


