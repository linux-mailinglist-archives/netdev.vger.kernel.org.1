Return-Path: <netdev+bounces-153011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E29F693D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A9916737A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE91E9B1D;
	Wed, 18 Dec 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JiHGebCe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3C1DFE0C;
	Wed, 18 Dec 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534007; cv=none; b=Paf3/M4HOFI13kzPHUZ6YNAqm+Wt/VDZ3YWWogSY30RgvyCBNSqT8cCK3rtJnOQHif5T/KqCm1piV5wLfTqlDBEcpAFxOTg2ANvvSGjBfGMxChNieX+8dUewKwbN1PMDBVA3RaBsDQT6CFW5pqZDognXZapG4gZxXr/oySOMcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534007; c=relaxed/simple;
	bh=M/D5vEBOZDS6p+IheTX/8N4CtLxkVVz36RNg7LPOcRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t18IGFVLtZFP5D75eHRoMtFUx2l+LdPaXCfAibqkh0GW+R7zOZAtp4M/srmdF7dlMnF+HDuLnfwyzsC+KGErhuSXq7LHNeYVE2NLZ5qKH4IKJ4z8ZfpRQImVMXmaGpwB1S60JqkKs7Ww6hgtvZwCNjWEAIfvl1W8PyUdNYEXJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JiHGebCe; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIDSqSA016315;
	Wed, 18 Dec 2024 06:59:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=774lI8SrHiA2qv2xIw3T1Hs
	DuE1VRCDr8ZdvWPwcz74=; b=JiHGebCezFedykaDKuooMdgy6a1zof4jrlpcwqk
	ln9WfZpeWakBQDIdN7lYa/o60dgZVxNaflYywmAiuTf6f9MT52j8/8kmdsNDUPuY
	yWdCzu0bv/Gp2vBsduyEJVzOo7dqOLtVYZG6m6sTTmRMTtE6e+shFY6+X6EHMRjh
	4rEWqkTrWZ2g/sqeG9tVtkjmIFlgRDjqAXLQgqPqN3OXAJde+M6Wv8C4rXHduD2u
	f4jvl2QY5KYJ6/SkE3Lp+DdrI1LhC1E2cNz+moPfpEyClpCVu07meNzkIfyzuxVl
	lNUbqOogzHMz9ksTgu6WLIl9Upb4AHEnEKkFvzAUXPzmP/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kyaf05x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 06:59:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 06:59:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 06:59:50 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 328133F7053;
	Wed, 18 Dec 2024 06:59:45 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v6 0/6] CN20K silicon with mbox support
Date: Wed, 18 Dec 2024 20:29:32 +0530
Message-ID: <20241218145938.3301279-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: O3yBbCAtl_UslQ7rAw_zJK8pE8jKNyiQ
X-Proofpoint-ORIG-GUID: O3yBbCAtl_UslQ7rAw_zJK8pE8jKNyiQ
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
v6 changes:
	Addressed review comments given by Jakub Kicinski
	1. Fixed minor line alignment issue to fit in 80 char.
	2. Jakub also suggested to convert macros from patch1 into helper APIs.
	   Since this will result in lot of changes (at >100 places across
	   multiple drivers), will submit that patch as a separate cleanup
	   patch.

v5 changes:
	No changes, re-posting.

v4 changes:
	Addressed minor conflits suggested by Jakub Kicinski
        1. This V4 version of patch set is just a rebase of V3 on top of
	net-next to address some minor conflicts.

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

 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |  34 ++
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 418 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  81 ++++
 .../marvell/octeontx2/af/cn20k/struct.h       |  40 ++
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.c  | 129 +++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  13 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 195 +++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  53 ++-
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  18 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |   2 +-
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 252 +++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  17 +
 .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 152 +++++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  49 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 +-
 23 files changed, 1393 insertions(+), 164 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

-- 
2.25.1


