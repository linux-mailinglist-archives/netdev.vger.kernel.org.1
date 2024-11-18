Return-Path: <netdev+bounces-145886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC39D13DA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3327A281D30
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549301A0AF7;
	Mon, 18 Nov 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F6UAFboT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F11E529;
	Mon, 18 Nov 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942109; cv=none; b=VYgCcoe8zx5FYb0NkOMeKSKiphadud4j9DtHACZHo78lZo2DpaieEiABGRyrJGZeYEJfLcdx18zI0W6Gm/X6ht/dwHfgt6FbA9FfUKT+0/gn8BosqQ5K7tpdUhVMNKhRGHheVHu6/kyyO36JZoL1V7TSMAlnD1K3Nk1QpmMFEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942109; c=relaxed/simple;
	bh=91WJIM6DEcG4F2rZBZl+TB5hBYHOlk75jKkoRHxwwaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CpHWRNL2nNBvrmk8+hCsINDW4+AFuRlJphiCxCs1n9B79E5kt5NOXbIx2btIKtUjmw4HeJvun715+o6BqqgHO2HK3uoWheTVTK8rJDzrFyK1WgysHw4/dBSK6Wh8nsGNwdpoH3jz3LHmaxnVXtdN/Jfv26RReeKUrjVcJ4jqrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F6UAFboT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI80kh3024910;
	Mon, 18 Nov 2024 07:01:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=xtjVRiz8c4+V5M0Xq+pl9lo
	C7niIxEjqQUXPvwSwC48=; b=F6UAFboT5MhRWgByZ+HxtkmPENqJzXZ1R5N8VNW
	C5pCHmZPUbsUzOu0PLr6JA2CER1Yb6NHD/7S+AIBn0BnGPX0k/YkjKBApB/qc9Ud
	Q0aP6dqqFEoFhp/5KdMZ25OwqSolrhauHEn27AtRRR09XI9DgmqRO39wc95SRMXP
	62eZvxhZ56kRjS5GhvsJNrtIpqWaePfOr9xVinqwtwzqF3VKkt3oW/evCOBuYM0H
	cllshZvu9Qj+5L4R68rrG/wOGP94b9sRJMggzy9Qcg4Gjc0GQzNxGIlV3UptyXpv
	MpdF99h0h96+anY4SMXw9QjiQ+l5iyYBspDgX+akStLR1uQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4301ps8p9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 07:01:35 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 18 Nov 2024 07:01:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 18 Nov 2024 07:01:33 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 287D53F7041;
	Mon, 18 Nov 2024 07:01:28 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v4 0/6] CN20K silicon with mbox support
Date: Mon, 18 Nov 2024 20:31:18 +0530
Message-ID: <20241118150124.984323-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QS27xwWsa1jz06Klk34PE7Yj18CJDCK6
X-Proofpoint-GUID: QS27xwWsa1jz06Klk34PE7Yj18CJDCK6
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
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 252 +++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  17 +
 .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  36 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 152 +++++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  49 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 +-
 21 files changed, 1392 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

-- 
2.25.1


