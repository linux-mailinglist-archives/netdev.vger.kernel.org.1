Return-Path: <netdev+bounces-144206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3209C60E2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6D1F21CAA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD45217F31;
	Tue, 12 Nov 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aCGTWi6U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07E217F27;
	Tue, 12 Nov 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437848; cv=none; b=cdyew3oeKVHwwmPkKUO1bcJ9pauBhdIw2H0iAKHyYgeLRHEjAV/HEHT/b1r76z6rqoai3gDVg7VfP3A/RFA8/dj3b4eN0nApshfMxUgwcBgB2siNSevvrOYEr26YVTbduxcpONmgS2TH6tUnK0UgAMC/otuozmClXfvGGfNmKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437848; c=relaxed/simple;
	bh=PL6M+hMDi1rzqXCk2vT356vV01rAWmK34Z+z0GixyvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBX3/ztOlp5NTaik8IIF6atDjwm65cov19UC1CvAqjvWuvgieQeRVc6e+romZ5v+k0nYHk90ieYqJBxuk03i9cJp5LqB/G3f5vqny7mlXlIynTEkrvwNs+kXmCg15lwbJtRo862wXZr6hn32Amay7SY/NnjSEoPBtdgAqLScQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aCGTWi6U; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACI4FSr003711;
	Tue, 12 Nov 2024 10:57:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Xp9qf19XALaV19BbEfrSdjU
	hUbakXd5kKiz4cL6nAQI=; b=aCGTWi6UMVbWlDDPC6340NKsxDkbkemNf7plqI/
	PLokVnPwsT8SAxbVy138HP/qonJCOk1Fn7+bpfeDpp4q84K1ndBWYtxFVgAIEM++
	Jsn6vXocnQfqeTTufQGwV+avmo1wzNOPj9ig7LUHeW3FKZQXMXfqSHrYzAzxAi+Y
	AZEN9/JJ/5G0UgQxYlNia8FAtwa5pOg1MeLn26rziXxOAPgGtwOXZtJIVqWvR1BS
	KuRyo4yRNPUBhX2+N/qawaoTJgpZMwnsaPmopNYdifq9sgejM13GiPDrhgflPbZC
	owoHJRekLcLSB1PUTT8iJhVD2UbGJF6NJc/vdhfGJveSK1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42v9xdreue-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 10:57:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 10:57:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 10:57:03 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 681043F7045;
	Tue, 12 Nov 2024 10:56:59 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v3 0/6] CN20K silicon with mbox support 
Date: Wed, 13 Nov 2024 00:23:20 +0530
Message-ID: <20241112185326.819546-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bysDiIEebIf-EIq9me3jD8tpZM6wQKP0
X-Proofpoint-ORIG-GUID: bysDiIEebIf-EIq9me3jD8tpZM6wQKP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

CN20K is the next generation silicon in the Octeon series with various
improvements and new features.

Along with other changes the mailbox communication mechanism between RVU
(Resource virtualization Unit) SRIOV PFs/VFs with Admin function (AF) has
also gone through some changes.

Some of those changes are
- Separate IRQs for mbox request and response/ack.
- Configurable mbox size, default being 64KB.
- Ability for VFs to communicate with RVU AF instead of going through
  parent SRIOV PF.

Due to more memory requirement due to configurable mbox size, mbox memory
will now have to be allocated by
- AF (PF0) for communicating with other PFs and all VFs in the system.
- PF for communicating with it's child VFs.

On previous silicons mbox memory was reserved and configured by firmware.

This patch series add basic mbox support for AF (PF0) <=> PFs and
PF <=> VFs. AF <=> VFs communication and variable mbox size support will
come in later.

Patch #1 Supported co-existance of bit encoding PFs and VFs in 16-bit
         hardware pcifunc format between CN20K silicon and older octeon
         series. Also exported PF,VF masks and shifts present in mailbox
         module to all other modules.

Patch #2 Added basic mbox operation APIs and structures to support both
         CN20K and previous version of silicons.

Patch #3 This patch adds support for basic mbox infrastructure
         implementation for CN20K silicon in AF perspective. There are
         few updates w.r.t MBOX ACK interrupt and offsets in CN20k.
         
Patch #4 Added mbox implementation between NIC PF and AF for CN20K.

Patch #5 Added mbox communication support between AF and AF's VFs.

Patch #6 This patch adds support for MBOX communication between NIC PF and
         its VFs.

Sai Krishna (5):
  octeontx2-af: CN20k basic mbox operations and structures
  octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
  octeontx2-pf: CN20K mbox REQ/ACK implementation for NIC PF
  octeontx2-af: CN20K mbox implementation for AF's VF
  octeontx2-pf: CN20K mbox implementation between PF-VF

Subbaraya Sundeep (1):
  octeontx2: Set appropriate PF, VF masks and shifts based on silicon

---
v3 changes:
	Addressed review comments given by Jakub Kicinski, Simon Horman
        1. Fixed sparse errors, warnings.
        2. Fixed a comment mistake, inline with kernel-doc format.
        3. Removed un-necessary type casting to honor Networking code format.

v2 changes:
	Addressed review comments given by Kalesh Anakkur Purayil
        1. Optimized code in parts of patches, removed redundant code
        2. Fixed sparse warning
        3. Removed debug log.

 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |  34 ++
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 418 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  81 ++++
 .../marvell/octeontx2/af/cn20k/struct.h       |  40 ++
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.c  | 129 +++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  13 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 195 +++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  52 ++-
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  18 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 252 +++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  17 +
 .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 152 +++++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  49 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 +-
 21 files changed, 1391 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

-- 
2.25.1


