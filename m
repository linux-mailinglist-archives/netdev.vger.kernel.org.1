Return-Path: <netdev+bounces-156640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1926A0733F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49A11619EA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789A215172;
	Thu,  9 Jan 2025 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FXEV9OPW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951313D246;
	Thu,  9 Jan 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418763; cv=none; b=VIkCg3quSMAlr1hfFP7nv9jpGek4VHz5XjnCw2klKQpty1TAXSzq32rmNj9apHPkdDS0gr6FMdxfflTWaJ4zZmxW1FvVUz3OEDSQT0bo6kfH27Pr8ceNw4so5WLDmH2i8sZNzOB/RnMTjxNepoSO3Q2mosBqWa182cYvgWUpNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418763; c=relaxed/simple;
	bh=QexIktawkhPu8rBWtKFU2L96SB55c+m5Md+Vp/iUspo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvbX6EqBN0luica7FIqLbgNZqHQgOfjTIMgYGRGD3qKHJfB37NOdxw14TfRyCvq2eDRF3S5QryhOdPGA+EN7PaEXRTwh6jjNvao4F+n6c7zCpAS4VFGua6IRes0zooi/N/KcbJLVv2cP0DuLhqNQ/UTBZsH5hDa/acArtN7WQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FXEV9OPW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5099M2dd030938;
	Thu, 9 Jan 2025 02:32:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=yVzu0XARXBEJDDLJte/X9/A
	PaS+T7dBffDHO/b7j9zA=; b=FXEV9OPW8XQbyCAi4w5vlZA7Nhmt4NTLoLAv+ls
	O9v1VSdZBKqy1Gk9y0CIg0xMu5qJYwcQH36AjKtJhHNwtO1DSsgIFQuRd0UrgdmU
	Y6RFy192zUF8IU3aB8lyHtu5gyJvqHZRNF11rwX+LGjJXVq/aBNZFlqiN+iz1I+F
	Qbaqqai9sOZUmyxp4qk3951rWW6i66OVJ9UFrCDlTyubtMo1RSAGvmRfp/CpXoET
	eiB++9lxC0FtYXX9WtWxxBZURNXgsag6FXZvsz29FYyCUPPFYCyDgDuV4Uz+yhXr
	8tnWzwHoezi7rpcQnDKQvAOeE5h1Z/SKsxZij/1CXQSv32g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 442brv04qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 02:32:23 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 02:32:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 02:32:23 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id D4C133F7072;
	Thu,  9 Jan 2025 02:32:22 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v5 0/4] Fix race conditions in ndo_get_stats64
Date: Thu, 9 Jan 2025 02:32:16 -0800
Message-ID: <20250109103221.2544467-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mSywR-MVPvW-8oa62AtyXVYMU-9siTIl
X-Proofpoint-GUID: mSywR-MVPvW-8oa62AtyXVYMU-9siTIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix race conditions in ndo_get_stats64 by storing tx/rx stats
locally and not availing per queue resources which could be torn
down during interface stop. Also remove stats fetch from
firmware which is currently unnecessary

Changes:
V5:
  - Store tx/rx stats locally and avail use stats in ndo_get_stats64()
    instead of availing per queue resources there.

V4: https://lore.kernel.org/all/20250102112246.2494230-1-srasheed@marvell.com/
  - Check if netdev is running, as decision for accessing resources
    rather than availing lock implementations, in ndo_get_stats64()

V3: https://lore.kernel.org/all/20241218115111.2407958-1-srasheed@marvell.com/
  - Added warn log that happened due to rcu_read_lock in commit message

V2: https://lore.kernel.org/all/20241216075842.2394606-1-srasheed@marvell.com/
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-1-srasheed@marvell.com/

Shinas Rasheed (4):
  octeon_ep: update tx/rx stats locally for persistence
  octeon_ep: remove firmware stats fetch in ndo_get_stats64
  octeon_ep_vf: update tx/rx stats locally for persistence
  octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64

 .../marvell/octeon_ep/octep_ethtool.c         | 41 +++++++----------
 .../ethernet/marvell/octeon_ep/octep_main.c   | 45 +++++++------------
 .../ethernet/marvell/octeon_ep/octep_main.h   | 11 +++++
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 12 ++---
 .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 +--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 29 +++++-------
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 42 +++++++----------
 .../marvell/octeon_ep_vf/octep_vf_main.h      | 11 +++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 10 +++--
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  7 +--
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  2 +-
 14 files changed, 108 insertions(+), 119 deletions(-)

-- 
2.25.1


