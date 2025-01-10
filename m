Return-Path: <netdev+bounces-157146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D51A09063
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F7C16B9D8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98D20DD75;
	Fri, 10 Jan 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GuhuUuPX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE820CCFF;
	Fri, 10 Jan 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512073; cv=none; b=K0d7jB8uHAldbVZpvV5LvnJs64jz282tQjoGbBdpqlkeODfLrHsb15T2bRDYEygFo05yeVqfEGWxqaexzkSO2S0Wj/9WYBbMxgjYwANzILVKlCfUOK62Yfoz/hXbZhqu8xmObztqBSnilyQxZwqqPYQhoVaMXgJxdcGaomhErp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512073; c=relaxed/simple;
	bh=5ouiv/oBgKXw6puK3OGYyblvoqZTfA68bEBgcuiBsIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HBLfFagK+DXUI9PHMlixUXUuZnuL7YAmD4sMBhT1JABab1OLHGOI+UonVeb0A09wnADgQ+lPMMQ9PKvsIVvayJbPolAkmkvwMPcxAgDHZaNzClVRL1V9L7V62P7IGseRq2Q/ALeeOBw+1Vq8PPjogLRkW4oEnIOSRz8qiShlOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GuhuUuPX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AA1mG4021216;
	Fri, 10 Jan 2025 04:27:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/AOiVcSHSvPlrdUPPxzZS6p
	3drfm5rAD7idZit5VroE=; b=GuhuUuPX8Tf2JyngDofn65WkFmov01SzRGHNhS8
	BegGUVl0RWLmER0R4hl4dh22kIupyTuMHFS5f+M+SD9i0+Of8CdxSGxSN40PN05E
	PWm2tIplwam+iuzbDOfV5/4pXrgCZj3CYXQxHC/2elNo7sK/mD5HFIctpfmTi2oZ
	XvlJ4gmcac91w/N+sc+PA6lDuqIAi2TW3XWc/q9qoNjuDrEW+ACLKJXuyisBHh02
	XWG18/zPO9jYvJjeiAUAT2D2erUkpIWplDDF2jbSEx/wUp3AYPcSuqRM2NFlzdiA
	rzcdKtGC+Vcdw5Ko/y1WE3ppkDWDyzLXAiCohDyd/4PcFsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4431ehg6wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:27:33 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 04:27:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 04:27:33 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 927DC3F7079;
	Fri, 10 Jan 2025 04:27:32 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v6 0/4] Fix race conditions in ndo_get_stats64
Date: Fri, 10 Jan 2025 04:27:26 -0800
Message-ID: <20250110122730.2551863-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VCHhBhCVk_1-fkcM0RJGUEjhVOevvlfB
X-Proofpoint-ORIG-GUID: VCHhBhCVk_1-fkcM0RJGUEjhVOevvlfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Fix race conditions in ndo_get_stats64 by storing tx/rx stats
locally and not availing per queue resources which could be torn
down during interface stop. Also remove stats fetch from
firmware which is currently unnecessary

Changes:
V6:
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


