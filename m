Return-Path: <netdev+bounces-158108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38470A1077D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C23A1E1D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB23236EC3;
	Tue, 14 Jan 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VqCz16pu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21853236A6E;
	Tue, 14 Jan 2025 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860336; cv=none; b=dVQ3HbytEPquI0UQ+WVGZBUXeIPah36uaiw/laBpPZFtHtLAnRu6lt4FiVgJXgl2U5v47pBp5Hf2eHetg4ml9ri9mXxtY4qLrihrQOqFrJCPgnBt8YIGbvSD/tF7SaKJYuCAcENCcJn1DHt2DDC7rQqOcd8jIRFszx1hHNARgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860336; c=relaxed/simple;
	bh=cbmjE2PSEunAuNySolt8zxZt/sZG95k82p7mRlm1UVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVUFYMGW/99/dqIIVCLooe/KDZJ6LvbkK2EL9eJ0UEFkYWCmmFLP9ENtQyAx8FCrCRveg0RMNAjmsinQ/WPEu17pvYC6zkXksNOE7r+T0ucr9YXU360A7GBww+DoZsjJNaJzy0CGixnba+/q7gN3iVNYMSvGsXyu4phfDZ4q+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VqCz16pu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EBYbSw004153;
	Tue, 14 Jan 2025 04:51:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=GzEFN4a2DP60p1mr2wqi6vo
	QOKd0TnEgYmCpVVxoUIU=; b=VqCz16puq+8TnHiWy61y9wjNnr0H9PTx9/tMEak
	jMuALCQFP7wX3ODHOJWNmn8OX721cREy9TiPNx/GzAHlaWqI9oVme931gkhSvP0n
	HZbKiJlgvYw9tpwNRazBPAfG/AsuvK1dP1WD3YQCqwPwkyG8H8VpzRfNGGl3bQEd
	Z8i9CF5FcHXW6Uqt54+AdMw4rNtIliEmYlpMbayqcwy0K+ZsAu5AiIJtMXAq2RKQ
	ZBO/YFWyYxX2gPfjMdeWg2FzuJiDskQu5/JdBZww/e1BeV3cgqkVPvd0HTOykVjG
	UO57jq3Edq5nxEMqRxVStcLEsnxmgmUJccgPmCRkPrc+4Zg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 445q60r3ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 04:51:27 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 Jan 2025 04:51:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 04:51:26 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 058415B6927;
	Tue, 14 Jan 2025 04:51:26 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v7 0/4] Fix race conditions in ndo_get_stats64
Date: Tue, 14 Jan 2025 04:51:20 -0800
Message-ID: <20250114125124.2570660-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XA4fCpNaMCkcb3zmMdBrGJBJ_h4yrfgo
X-Proofpoint-ORIG-GUID: XA4fCpNaMCkcb3zmMdBrGJBJ_h4yrfgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix race conditions in ndo_get_stats64 by storing tx/rx stats
locally and not availing per queue resources which could be torn
down during interface stop. Also remove stats fetch from
firmware which is currently unnecessary

Changes:
V7:
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
  octeon_ep: update tx/rx stats locally for persistence
  octeon_ep: remove firmware stats fetch in ndo_get_stats64
  octeon_ep_vf: update tx/rx stats locally for persistence
  octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64

 .../marvell/octeon_ep/octep_ethtool.c         | 41 ++++++++-----------
 .../ethernet/marvell/octeon_ep/octep_main.c   | 30 ++++----------
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
 14 files changed, 93 insertions(+), 102 deletions(-)

-- 
2.25.1


