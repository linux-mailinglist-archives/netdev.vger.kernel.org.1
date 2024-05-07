Return-Path: <netdev+bounces-94190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAE8BE976
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306311F26256
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA43168AFD;
	Tue,  7 May 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GfkjhV2r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD269200D2;
	Tue,  7 May 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099978; cv=none; b=TdbDFQxy/uEFoN8qn8lBJFvWzK4bpMV5xComXmdMm/KKDpb6OEjDtVXYG/wfveBVpL5n6/u/VwYSjFKrPcKwmMTZXvxy3c5zJyXTkAqrE99Vs18NqZ8JGyjhEBNH+iRURF9dnuED+c3lvAmVEYqLBMcrAdA4zSc/BIwf0TBT/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099978; c=relaxed/simple;
	bh=/Vsx8L9+h8WYI+47bqCnjHt9w2HlfVsCqN6Z5HaYFdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lgkn27BkO1raJZZuyjHlHPDfNievSVbox4rZppodRUEM2Tu80HSr48oRWhdX8r4F0eIKDuNq96tYETSpiUVEiIfLdJaEjzB+fYnzOyDfkmvLtCTv+QFkXnBWWQF8v82gT905jJDV9YJ4te4bG1fZPX1m3M//LuyOByUEa/wv2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GfkjhV2r; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447ERhms031423;
	Tue, 7 May 2024 09:39:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=Yw9FpnLdSLu1VkFV4EzbZnDPKKhGzYWYJOYOurYqPVo=; b=Gfk
	jhV2rPtY4RBjZPbuEISRacBSYFohtjpuKX2Ok3DOCITnU8pLT/2l4fL+U5mRUFKN
	HKn5LwRnHpLitAe1yk4100nYJlwuL4CWker9+OGH0w3SA+ilaj7PT6s7WDc/ZClG
	REz2HQVGWdTWJI9qckrGqlisHtbcOf85OE3oeMUAZ2XSQDbqPxSczn7ms8R6S1b0
	Z3GXbRReGACRIBEgRj+XXfeKcEdbyORg1o4q25VJWcx65pMvs90wyQTC6yHBu7ic
	6Tm3lnsfkXmVlLVEanzG9/2jV3A9aWaG17H9C3gXc5PLjbjJr196R+xZld27oZNI
	1D3KOA05bl9mA1HVq8Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhgjewn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 09:39:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 09:39:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 09:39:25 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 866F53F7041;
	Tue,  7 May 2024 09:39:22 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 00/10] Introduce RVU representors  
Date: Tue, 7 May 2024 22:09:11 +0530
Message-ID: <20240507163921.29683-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CfY8cJdk9lzzcUC9eXH6_szckXM3Mtzj
X-Proofpoint-GUID: CfY8cJdk9lzzcUC9eXH6_szckXM3Mtzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02

This series adds representor support for each rvu devices.
When switchdev mode is enabled, representor netdev is registered
for each rvu device. In implementation of representor model, 
one NIX HW LF with multiple SQ and RQ is reserved, where each
RQ and SQ of the LF are mapped to a representor. A loopback channel
is reserved to support packet path between representors and VFs.
CN10K silicon supports 2 types of MACs, RPM and SDP. This
patch set adds representor support for both RPM and SDP MAC
interfaces.

- Patch 1: Refactors and exports the shared service functions.
- Patch 2: Implements basic representor driver.
- Patch 3: Add devlink support to create representor netdevs that
  can be used to manage VFs.
- Patch 4: Implements basec netdev_ndo_ops.
- Patch 5: Installs tcam rules to route packets between representor and
	   VFs.
- Patch 6: Enables fetching VF stats via representor interface
- Patch 7: Adds support to sync link state between representors and VFs .
- Patch 8: Enables configuring VF MTU via representor netdevs.
- Patch 9: Add representors for sdp MAC.
- Patch 10: Add devlink port support.

Command to create VF representor
#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
VF representors are created for each VF when switch mode is set switchdev on representor PCI device
# devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 
# ip link show
25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff

#devlink dev
pci/0002:01:00.0
pci/0002:02:00.0
pci/0002:03:00.0
pci/0002:04:00.0
pci/0002:05:00.0
pci/0002:06:00.0
pci/0002:07:00.0

~# devlink port
pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcivf controller 0 pfnum 1 vfnum 0 external false splittable false
pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false

-----------
v1-v2:
 -Fixed build warnings.
 -Address review comments provided by "Kalesh Anakkur Purayil".

v2-v3:
 - Used extack for error messages.
 - As suggested reworked commit messages.
 - Fixed sparse warning.

v3-v4: 
 - Patch 2 & 3: Fixed coccinelle reported warnings.
 - Patch 10: Added devlink port support.

Geetha sowjanya (10):
  octeontx2-pf: Refactoring RVU driver
  octeontx2-pf: RVU representor driver
  octeontx2-pf: Create representor netdev
  octeontx2-pf: Add basic net_device_ops
  octeontx2-af: Add packet path between representor and VF
  octeontx2-pf: Get VF stats via representor
  octeontx2-pf: Add support to sync link state between representor and
    VFs
  octeontx2-pf: Configure VF mtu via representor
  octeontx2-pf: Add representors for sdp MAC
  octeontx2-pf: Add devlink port support

 .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 669 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
 26 files changed, 1784 insertions(+), 225 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


