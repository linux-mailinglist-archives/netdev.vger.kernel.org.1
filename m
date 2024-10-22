Return-Path: <netdev+bounces-137989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C629AB633
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5487BB23807
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B691C9EDE;
	Tue, 22 Oct 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f6nLgZ7s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962919DF9E;
	Tue, 22 Oct 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623282; cv=none; b=oja3t4kriBtMyEKyxoK6jP2xxyMHJdU36bSZR/aduLlYOtQNwYkpXPg6UCdHSI5BlLUZ4FBJ2Fov7diH5N75phzSxPHoRAzBVUNJflOInpu4WSYUM87PFQzDh8V69xxehVQEes+uxowKX33wd1C2zl1ljoENckRkNL0IcwfDGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623282; c=relaxed/simple;
	bh=X0JFf0OoFpP/6TpzZM2f+rDXKVrTpoRkxCNc0WWKP1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ri58PbIK8Vxs4lm2ZFehKFO3+rF6H2tYvxyWCLZ2JFUXCnkFj9juqRErlUSm4g2Ehzif9LrfpkaSQLXsBBUq3QEQM8Qn/8PLY0sFfU1QJeOQOl6m5XvVJjN4Bi8+PR2APG6kvYt/E9x4KdoYcoIQdthOpHPR2/4cjRkHDpO+C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f6nLgZ7s; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MBQKdd007903;
	Tue, 22 Oct 2024 11:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=h/lbEB65YgsaKP04LsjTsqG
	5K7YyvL4+cYwDHOFtq6U=; b=f6nLgZ7sMZed/oI//hvSOyPfvJOTkLgg1VDomLx
	52nvfqDxNXeztMnlA69uFqenrFqcVfG9NFqmHeCjRY/5Ssotob5IxyN92cLjmyQL
	YV+uHMWExgM6ajrvzVSD4NVEr5BhyKBLXxVQN0MkMCXYvo9WT0hQeaXq0N6dUZqM
	Ku9M0jpNk5rK4QdgEnJrwoepHQ+pZoooT7a1im8gEUAD9YsJDfFz041G9bW5eV6Z
	YP+wvRkQUUWwyAYiAKpLIhkbYBjG93Ckh6dMVeetuIMzLDksHF9TbYRa92JUrktV
	s1GStmcAwX7Itk1R7K8Rno9B+o9WwvZz0Mcnqhyu/F8KyZA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42eb66s55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:54:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Oct 2024 11:54:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Oct 2024 11:54:18 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 2324B3F7075;
	Tue, 22 Oct 2024 11:54:13 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v2 0/6] CN20K silicon with mbox support
Date: Wed, 23 Oct 2024 00:24:04 +0530
Message-ID: <20241022185410.4036100-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cv3DaQLFYFjwc33j-vvkYZe4KAOn8Vv6
X-Proofpoint-ORIG-GUID: cv3DaQLFYFjwc33j-vvkYZe4KAOn8Vv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
v2 changes:
	Addressed review comments given by Kalesh Anakkur Purayil
        1. Optimized code in parts of patches, removed redundant code
        2. Fixed sparse warning
        3. Removed debug log, and code cleanup.

 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |  34 ++
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 418 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  81 ++++
 .../marvell/octeontx2/af/cn20k/struct.h       |  40 ++
 .../net/ethernet/marvell/octeontx2/af/mbox.c  | 129 +++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  13 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 185 +++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  52 ++-
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  18 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 252 +++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  17 +
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 145 ++++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  49 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 +-
 19 files changed, 1377 insertions(+), 147 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

-- 
2.25.1


