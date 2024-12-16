Return-Path: <netdev+bounces-152111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5319F2B60
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DAF1685F2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE75203D48;
	Mon, 16 Dec 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZuEBZk1j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF70202F7E;
	Mon, 16 Dec 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335957; cv=none; b=dkXeqvcjM87GQ/qWY+IikCTgqG20xZ8gzgbkLa4C34RatXuCwTLdvj8pkqa1Usv1V25pnL4E00/5BXyup6L5k3yG1SA9ynFsj/qgfvx3AMOPYW3SXL6ukHaHYO1FYN/qWp/+PknOvEkG0njHF0AigNy2okieDEvOH4O5NUzyF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335957; c=relaxed/simple;
	bh=pFEcSClKvkGj7FkvYjSlcEpeSnnU85ooA6Ex4oYkS40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ji+wv4SYr2f7+ZDu+mYCDq3MsN7OQiyVhFfgHDfaOzttrW7/xuMRbL6/vhReR7PcKcS2Bvn91y8xAwV/ZZhV85K9KmCuzbcatQje+d5L79i+C4qW0Xw/I67SiE/IO0S+xFznbiEXRDDjaNfAXmpXrEPsdYmkMsJiZSqm8EcEeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZuEBZk1j; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7D0BR019859;
	Sun, 15 Dec 2024 23:58:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=jaEZNOc1ShPcIIWp365ZxO0
	k1RA2M//O3E2TA71sIxI=; b=ZuEBZk1j4vekZCL59gBdDlkHfhj8IrSBCJ1fAqz
	t56I6QGwNfkY6ho7zqd1pX/wG4qxhnOIHNH3rMYF1h9QLIQGYBM7ZLybla9GrRSd
	yMopAdsaNeYEqETJVCAPW4DnjTYWm/zeq5MZLrO/UPIpV/0vOhsqtyDy1A2CFTit
	WCmZHoZd1k+0zpq8r9BV7YBgVKFLouyFeI845nyUjwzURboZXBzuwr7bcNRHTzSP
	mF6a3hZpqQbGaSTv0H+d7818CwdvmJwJxFQFefVLnn3v0oQmqtBb1CWswNMtlgnl
	C1Rp/DqLe3prcvHa2+WFbkyFQx8o1zz9p2dBHtXgDBi8uyw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43hadjrgtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 23:58:45 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 23:58:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 23:58:44 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id D794C3F7091;
	Sun, 15 Dec 2024 23:58:43 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net v2 0/4] Fix race conditions in ndo_get_stats64
Date: Sun, 15 Dec 2024 23:58:38 -0800
Message-ID: <20241216075842.2394606-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yK1O-Ev0N3XruFaFrOIm_6jbYO2M2Xko
X-Proofpoint-ORIG-GUID: yK1O-Ev0N3XruFaFrOIm_6jbYO2M2Xko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Fix race conditions in ndo_get_stats64 by implementing a state variable
check, and remove unnecessary firmware stats fetch which is currently
unnecessary

Changes:
V2:
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


