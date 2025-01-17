Return-Path: <netdev+bounces-159205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483BA14C52
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779B03A0FF1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57661F9AB0;
	Fri, 17 Jan 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N+uGComK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2ED1F91EC;
	Fri, 17 Jan 2025 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107228; cv=none; b=SJ1M9p4/60Bp2Wq9F1gDHOBoqULl8REbPMqMuIoyf1vAyxaDGmpbYru/EOlQ6B/KtNdRyTwUU5ZC7fbJ9mJU++woR9S+u6gAcC2O+hPdmfFQvDJg4fc6MKfPrwyTeNi5AA0a3roqVfPxXVXcSjkeKuJ49Lwr1BWnZaWsAFw6jkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107228; c=relaxed/simple;
	bh=GH9OvVqFAsJM7AjEFkyuqa1vzmlSJyLPoIg4BTbg8oU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/TciKdVCYTkWpGMYRmPuh6djjw848h+JqYH1MVNwqx1khNhXNbSlh+WSyhGlyPy7hNsiaEyjv/9fFi/QOmq8EtzlL6BtLX5QUILb+6JzAHXvC+Ceb0QXm74cPBcPRjA/rIMD3sAf7KqQPzFZF+rIIh31xDRkEECs6jpn2umo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N+uGComK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H8QvNd009879;
	Fri, 17 Jan 2025 01:46:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OkHB5tbZFaK+v6ulOY6W/WG
	3VQL6Lfb+DhxhI+RQ6PQ=; b=N+uGComKOBgtNP7RQInbZpWg720NXLDYxwl3+VL
	48exnSlg0SH2w6Jk7KmNQ1utHazxb38pe5wp6IZNw4qyWF+axc9NKZqom5ruiOWo
	2xKsc8llLLbnm1U4bsO+kR3GikodfMcD5GT5xUuvJV274RhgYU9IolAx3TId5f3a
	38jVm82DakW+fEJGq1Tr01UTbHUcfGXFOf6eCOR1LgGojFFUv7VV6wHZCa63iJgo
	bOzAh63T7zXF/UCYB9EvB+mJskyLVMrNGwgEHPgAxNAey53XbrCYtmhvp3a4vDSS
	JGM4cNDg/qh1lvMQlV7K08zUrguSo3z9i5yxyNRI0MlhOcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 447kps84bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 01:46:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 Jan 2025 01:46:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 01:46:55 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 6CC113F707A;
	Fri, 17 Jan 2025 01:46:55 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v9 0/4] Fix race conditions in ndo_get_stats64
Date: Fri, 17 Jan 2025 01:46:49 -0800
Message-ID: <20250117094653.2588578-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ABowkOjck54ce8HMFOel9GHk1psZG-7K
X-Proofpoint-GUID: ABowkOjck54ce8HMFOel9GHk1psZG-7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01

Fix race conditions in ndo_get_stats64 by storing tx/rx stats
locally and not availing per queue resources which could be torn
down during interface stop. Also remove stats fetch from
firmware which is currently unnecessary

Changes:
V9:
  - Iterate over OCTEP_MAX_QUEUES or OCTEP_VF_MAX_QUEUES in the
    respective ndo_get_stats64() function, rather than just the active
    queues.
  - Update commit messages of 1/4 and 3/4 to reflect reordering.

V8: https://lore.kernel.org/all/20250116083825.2581885-1-srasheed@marvell.com/
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
 .../ethernet/marvell/octeon_ep/octep_main.h   |  6 +++
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 11 ++---
 .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 ++--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 29 +++++--------
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 25 ++++-------
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  6 +++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  9 ++--
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  7 ++--
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  2 +-
 14 files changed, 80 insertions(+), 102 deletions(-)

-- 
2.25.1


