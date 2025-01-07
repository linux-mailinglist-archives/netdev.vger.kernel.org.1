Return-Path: <netdev+bounces-155791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D6A03CCA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191611615CE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B11E8850;
	Tue,  7 Jan 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bSc+qsAH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19C1E570E;
	Tue,  7 Jan 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246807; cv=none; b=oXB+rQEcECM2oGOS1CG4h3uSyL1DVGrN/PtshA68QZaRrt3nP0+1yqgtOoflNvHehlAa1hZSjCf55ALHjtkOuCYCljyywo3NBfApviCnbWuhbfppCN7RxgjFmRYqH3jkgAucAuli+qveE2fRU8/N966vqiUnqQIo5dqR0l7gYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246807; c=relaxed/simple;
	bh=oYo3OMfGLSjW+z3gCfkEItno6xIGDypH3M8q8l4sJCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uLIPqRhMwFMmkAOAFoOK2y1RD1tRMbQvPHio6DcxAYUqPqamOQjJPY/tRH1bar/yIAOTzvdm0zdFR1HpEUlMNKTIUkbaxvheEp6IabmKxZU79ZGk0im6iYypDDz4TijfSy2H4UOlRtKnYSvefIVbaqBr99gw8UBUF89AVNb5Bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bSc+qsAH; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507AHDDB005838;
	Tue, 7 Jan 2025 02:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=MFxDAcukKuGFRaIz+kugDx/
	4oKw/WWP1PY0Xo/pecy8=; b=bSc+qsAHFUQxBUXydL9D/Fp30W+mZ5aNuxW2vSt
	oBBOf/e/NVQJH4XBzBnJBkSZSsquKTzq45isZIelZIpXZEWGTzzH2hca6IlHnZjs
	ieRI47/YzbMipWd17EvtM0ZvxPDiqzl5qmGcEaEADnzgHM6eOL17gP1/AiUUiTo7
	oN0B18r7Eo62ekPtYMZLguEnseObpDl+GP6KiOrOK8yjp2UrpvuthjHsXoNIeNrB
	EW8a6+tYy97uuQsibTa1eWP1UaDbLYzagAVt677LfuxWDUxY4N89GJ46U6RDnGHg
	HBkzjdzYpcEUS6oyIANoCV8gkrS0NwququhixFd3MsENd9g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4412cj81jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:46:37 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 Jan 2025 02:46:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 02:46:36 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id AB2003F70A2;
	Tue,  7 Jan 2025 02:46:32 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 0/6] Add af_xdp support for cn10k
Date: Tue, 7 Jan 2025 16:16:22 +0530
Message-ID: <20250107104628.2035267-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lfijTR_kMxHyGzsPJKs93P64xpjpodMS
X-Proofpoint-GUID: lfijTR_kMxHyGzsPJKs93P64xpjpodMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patchset includes changes to support AF_XDP for cn10k chipsets. Both
non-zero copy and zero copy will be supported after these changes. Also,
the RSS will be reconfigured once a particular receive queue is
added/removed to/from AF_XDP support.

Patch #1: octeontx2-pf: Add AF_XDP non-zero copy support

Patch #2: octeontx2-pf: AF_XDP zero copy receive support

Patch #3: octeontx2-pf: Reconfigure RSS table after enabling AF_XDP
zerocopy on rx queue

Patch #4: octeontx2-pf: Don't unmap page pool buffer used by XDP

Patch #5: octeontx2-pf: Prepare for AF_XDP transmit

Patch #6: octeontx2-pf: AF_XDP zero copy transmit support

Geetha sowjanya (1):
  octeontx2-pf: Don't unmap page pool buffer used by XDP

Hariprasad Kelam (2):
  Octeontx2-pf: Prepare for AF_XDP
  octeontx2-pf: AF_XDP zero copy transmit support

Suman Ghosh (3):
  octeontx2-pf: Add AF_XDP non-zero copy support
  octeontx2-pf: AF_XDP zero copy receive support
  octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on
    rx queue

 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 128 +++++++---
 .../marvell/octeontx2/nic/otx2_common.h       |  22 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  25 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 161 ++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   4 +
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 225 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  24 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 12 files changed, 541 insertions(+), 72 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

-- 
2.25.1


