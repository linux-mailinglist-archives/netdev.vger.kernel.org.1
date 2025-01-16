Return-Path: <netdev+bounces-158809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD24A13589
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13A5167680
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9B1C3C07;
	Thu, 16 Jan 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CuZcY0Th"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DF197A8B;
	Thu, 16 Jan 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016719; cv=none; b=cjGGRxgyFhpIOGeltDQfAonU9aIfmnxy95Iq1t1/BJdMHMXID0GJcsSfBxGM3LFcJa21yMzBCsHHVUs3yqTFN8Ioi/kqI/8X/KL8tCxJUoWBRRSPMFQe1MxmtXQ5plpHElRkAyxeuKDxMpIRP6bojJCeRYZ4Aj9oMIx1nZr6bY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016719; c=relaxed/simple;
	bh=0q/HYAP3e5EnVUTMppt9+JnCAqiC8LWX5GrDDdP/B4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3ZBQ6LWIu1UgY3tQU1tcyAx8KMCWQiv4j669zTsTkUlnRQ4cCGaPy7tjXeAj3exrw95IQicWW90KZXZLGf1EVGpmu8aWid22P+DjjqGss/xZJMARhSf+2hM7TQBOTwyn/G6RM2QDoRJ2zscOxi37EdxnKyWcsGob+ER4gxaGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CuZcY0Th; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G7tO9b015879;
	Thu, 16 Jan 2025 00:38:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=uTYlALs9p3KuoF/8yerpky3
	HaFvncDaqJsuIMquOIAs=; b=CuZcY0ThQ8RmNqAOP/wtaBd4lxyEt8DyLBh87pe
	FOermTiOmPkRVJtdFEG4DZx/k/kWrrXi8uLxxFyxzPI0wuh3WNg3WJ66WyKK6ZBD
	DiACd5g9kd1IRPWXI1acGzpJ+7PGP8tO5xbdqiqY2p34GzfIpGjOPVZRABWSGyNf
	8wKUhdeNS6WKpXntyB+fuc0pG3ENBDLlj4zHxRP4yuUVHhu+/MiLz73qvAis5n1h
	QEKEYH/7v7EQNDjx7q8UWUnSnwodvEcThnUSdzQu77laLztiiyrMlnfdsVclKFOS
	aZAwU4WXeryR3UIfX+ymHlLOQvPtoggnoNoZushDC21Xz2g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 446x58g31b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 00:38:28 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 00:38:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 00:38:27 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 6BBB73F7048;
	Thu, 16 Jan 2025 00:38:27 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v8 0/4] Fix race conditions in ndo_get_stats64
Date: Thu, 16 Jan 2025 00:38:21 -0800
Message-ID: <20250116083825.2581885-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Oo4Gf1_wMEusMPnOFESRZNVzXJFf_wx0
X-Proofpoint-GUID: Oo4Gf1_wMEusMPnOFESRZNVzXJFf_wx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01

Fix race conditions in ndo_get_stats64 by storing tx/rx stats
locally and not availing per queue resources which could be torn
down during interface stop. Also remove stats fetch from
firmware which is currently unnecessary

Changes:
V8:
  - Reordered patches

V7: https://lore.kernel.org/all/20250114125124.2570660-1-srasheed@marvell.com/
  - Updated octep_get_stats64() to be reentrant

V6: https://lore.kernel.org/all/20250110122730.2551863-1-srasheed@marvell.com/
  - Corrected patch 2/4 which was not applying properly

V5: https://lore.kernel.org/all/20250109103221.2544467-1-srasheed@marvell.com/
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
  octeon_ep: remove firmware stats fetch in ndo_get_stats64
  octeon_ep: update tx/rx stats locally for persistence
  octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64
  octeon_ep_vf: update tx/rx stats locally for persistence

 .../marvell/octeon_ep/octep_ethtool.c         | 41 ++++++++-----------
 .../ethernet/marvell/octeon_ep/octep_main.c   | 29 ++++---------
 .../ethernet/marvell/octeon_ep/octep_main.h   | 11 +++++
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 12 +++---
 .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 ++--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 29 +++++--------
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 25 ++++-------
 .../marvell/octeon_ep_vf/octep_vf_main.h      | 11 +++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 10 +++--
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  7 ++--
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  2 +-
 14 files changed, 92 insertions(+), 102 deletions(-)

-- 
2.25.1


