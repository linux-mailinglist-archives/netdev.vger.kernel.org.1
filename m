Return-Path: <netdev+bounces-154707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533B9FF8A8
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6607B1882C9E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603719D086;
	Thu,  2 Jan 2025 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MoSq55us"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEE193419;
	Thu,  2 Jan 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816994; cv=none; b=pfKDnKsiHnCQ+uimeB1HIGPZ8k3iCQmqjxqwlJKOtQKaDMIiOzK1bRyElqVm9/5NX24hkJn4wVhC8oFZmigmrGxsfKqqXVTIwYCTt9vYHrjoweT5vNf7AySjQpstS6Eu9U9P4L8l+MKO+Sz27eogpyjWcqY3isgGwRpklU189Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816994; c=relaxed/simple;
	bh=jGIwB3Lf+IKyPdMX7WIqXG0gElDUUGTtfN4JIacpt1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gkt2X/mOak/9chdjzqo00FGao+lYVBLmpcOWU8Zxux6XRPiGGe9V0fTMUZS/4U+uZLXSH2Rh+b63iHCx+mRIOzGl9Rv9WzAiXjbSEbxVs/2uJUrln4JN6q1voWEBIUm5Bav1whZrj28K2GR/i+HtNXNjR0YdkIbktfDua53unhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MoSq55us; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502A9pQH000996;
	Thu, 2 Jan 2025 03:22:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=298HlXVZl99kA0dPK0t71Hy
	Dessm6KiIxdy1kcUQ5rE=; b=MoSq55usoxMbkmYvytyz81KM5U9Cu+byR/FDebk
	EkDQgYVnI/uQnt5evdtS3WbtO56aY5X6po4f9DEod1+EmvCiUll7IrSPzypC5oXn
	fn8ZVZatFYVESgu6NmQ0CTPHFRiIe/O1RiWvjhUkQJDuNtRqQ/Cfl4BnfBvb5HxU
	UOJMMwqt2MT+J1XgrDyo/kaMd2S17cepX+LrjXnwJSK487XZFKWzrHsjktmN8367
	l+4LXipw18x/L2uNQShDnfq8pWKNMJ0YCu+EcPMEQq19/ZkiYS+8com0ayu3CMPy
	xGxwElDWy9dGZCK5J/1qYieCTmntQ6O3Sq6kAW5QQDTsjwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43wrt702w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 03:22:58 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 Jan 2025 03:22:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 2 Jan 2025 03:22:55 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 654ED3F708C;
	Thu,  2 Jan 2025 03:22:55 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v4 0/4] Fix race conditions in ndo_get_stats64
Date: Thu, 2 Jan 2025 03:22:42 -0800
Message-ID: <20250102112246.2494230-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YGS7-StfUE8_hvX2QhMrnJNwmbNub0wW
X-Proofpoint-ORIG-GUID: YGS7-StfUE8_hvX2QhMrnJNwmbNub0wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Fix race conditions in ndo_get_stats64 by checking if netdev is running
before per queue resources are accessed, and remove stats fetch from
firmware which is currently unnecessary

Changes:
V4:
  - Check if netdev is running, as decision for accessing resources
    rather than availing lock implementations, in ndo_get_stats64()

V3: https://lore.kernel.org/all/20241218115111.2407958-1-srasheed@marvell.com/
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

 .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 ++++----------
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  | 12 ++++--------
 2 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.25.1


