Return-Path: <netdev+bounces-196532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730A0AD531D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F07B1E0795
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49025BF15;
	Wed, 11 Jun 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E1sqL85o"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFF25BF0F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639748; cv=none; b=UWerGotJltXoX13pRO6GXS+3wbPGLsivVIUXiX4lMCc1B9fxHNe3984Pxy/1Xu244nhzuWqwAV/zLC9IOuapFdyC5rLfmQf4GtRULPe8jnOuvzvpacSJdS2s/MoF12LBLZXoUOWQ0RH+ht+ibWeY7es5+RkK1S7IW02c12y1Sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639748; c=relaxed/simple;
	bh=9rynKM3mPNIwedipk4tRrJ2GKg88+7GjCvAGhePAOO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oaspw6Hhr3KXriOZKNB/pdJQpCcJByiwwvLI6Po4RuC/dU2prKBAAMUvBcHx2Q9zDwvYSDyaYvqga09Id0YGJeMzCAOBDC9/3E8IutC28cIuh4PR7zFZg1dgQu7nO6uvh/nDS2b+3Y5cZlsR45gWA5fr7cW1qaU6tBAaS3Le0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E1sqL85o; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8Wn0K025175;
	Wed, 11 Jun 2025 04:02:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=U2gZBZWrnfdRnSfMn142SCZqeEx1hYN8YSYcfqf3avY=; b=E1s
	qL85oB1/qh+9ZHCfLd4N2ShslDIHSUCm3z7rVYTVwjLgY0kU12pFcIShHhmzwjiR
	OszYdNN2wSphXBF39rzG9wa+5jg4b83LpOsLW3A3TmKeq4AnH+NPrwRQb+5X93xs
	LGPg4cvj+tx2nf8f9pNVTG9keEIaCarZST9wiPeWeF1CQ0uofHGpf34qRS/u3CNS
	Qegtq7v68mAC33VOoSH6tPzbKpah2bMVvquen3sK8RrIKzC/Tw8wyQV2VDqYT46H
	RyRK2KUweO9xN6+kauI6kPkKGTvq/AQ4drtOV2qQg7uQyeigQ5sfslfgM7bNyOEI
	HnsT/10NmsTNZp5sqPQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4769bn49hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:02:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 04:02:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 04:02:03 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 29FFA3F706A;
	Wed, 11 Jun 2025 04:01:58 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <saikrishnag@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v11 0/6] CN20K silicon with mbox support
Date: Wed, 11 Jun 2025 16:31:50 +0530
Message-ID: <1749639716-13868-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NCBTYWx0ZWRfX8JxwHRHqEpL9 rQ2inLUjEbS9ftxJssJzns3vZ3rIq8Fp8Y4jU54CryqgJIt/idAQmckgO7Y4+5+JmqW0y9AqCb9 Nr8NqXfqHwBA8BjuMOBQth/EKnfs6lmOJA48HC8qQ/lbTgDFBMpPHHcEre9ZSWWE8C47TVywtoS
 w1v9zjxRJRZMXchCxX0W2xjPcQpwoWKC0yA9Cd9x4y7t8FS4F6whhwHNqK43ox2SclH/8MoLvA8 Cbu/vsuYcnDcTPCCIvtYlipaqKRKw/2CGEp/G/6sX94NjTYoEObbXvwyZqLjpIxJP2Cb3tLtOwB YVq9FDGqVCJa7+i4JUefRb4YYNP5n+lti4xD+u7n8ngPb7XHs0pzmK4R3tEUHoVBY/qb/zqb3m1
 l1YLp1JAZ9E5+ctOasqKKeRSQI6Y8o2x8JSmrHNIznuDMxXNSjI/dl/FQC7G/s/NWT8uTwtl
X-Proofpoint-ORIG-GUID: YqSfZIxuGSItNyrSTtVFDXbeJhQNI8rS
X-Proofpoint-GUID: YqSfZIxuGSItNyrSTtVFDXbeJhQNI8rS
X-Authority-Analysis: v=2.4 cv=ZuDtK87G c=1 sm=1 tr=0 ts=6849622c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=I60V7ryXsXke0IewSq0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01

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

v11 changes:
	Fixed comments from Paolo Abeni -
	Fixed memory leak of rvu->ng_rvu struct
	Removed unnecessary forward declaration of struct rvu
	Removed code which fixes sparse warnings from this patch set and
	submitted as separate patches
	Changed vf_trig_val type from int to u64

	Removed changes which fix warings of -Wenum-enum-conversion as
	suggested by Simon Horman

v10 changes:
	Fixed compilation issue reported by kernel test robot.

v9 changes:
	Addressed review comments given by Jakub Kicinski
	 1. Removed macro indirections and converted PF func mask, shift macros
	 usage into helper APIs and used the same in different modules.

v8 changes:
	No changes, re-posting, as the previous patchset got deferred.

v7 changes:
	Addressed review comments given by Jakub Kicinski
	1. Fixed few clang warnings of enum conversion related to the patchset.

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

 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |   5 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c |  13 +-
 .../crypto/marvell/octeontx2/otx2_cptpf_ucode.c    |   4 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c |   6 +-
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |   2 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/api.h  |  32 ++
 .../marvell/octeontx2/af/cn20k/mbox_init.c         | 424 +++++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cn20k/reg.h  |  81 ++++
 .../ethernet/marvell/octeontx2/af/cn20k/struct.h   |  40 ++
 drivers/net/ethernet/marvell/octeontx2/af/common.h |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   | 106 +++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   8 +
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |   6 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    | 222 +++++++----
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  81 +++-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  68 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  22 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  54 +--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   8 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  16 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_rep.c    |  13 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_sdp.c    |  10 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_switch.c |   8 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |   2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |  18 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |   1 +
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.h   |   2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c | 252 ++++++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h |  17 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  35 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 166 ++++++--
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |  49 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  44 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |   7 +-
 include/linux/soc/marvell/silicons.h               |  25 ++
 41 files changed, 1570 insertions(+), 302 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
 create mode 100644 include/linux/soc/marvell/silicons.h

-- 
2.7.4


