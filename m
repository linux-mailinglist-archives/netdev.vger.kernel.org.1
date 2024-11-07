Return-Path: <netdev+bounces-142900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F29C0AD9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3077E1F21C84
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E3216A0D;
	Thu,  7 Nov 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ibYNXVZL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6B216446;
	Thu,  7 Nov 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995735; cv=none; b=N7DcNRin88zfasK9QBrpoJm3Twc6hU/qQb2Xqqyh71DxYI5qgy11lnz7oYxTJoO4nU8Gjlh7D/pNbqd2PG77fmcI0qWC9EojIOGFiHpi+yJ+lyXu4832WBQ0JyqL8Y768rLTh8LTEG9gLbJ+HPeNdUMaZqphBAQJEvC/SvYkOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995735; c=relaxed/simple;
	bh=GgBNvDQxhI9svGOL//zga8sNakTU41V7WT8sEMXTIkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SxJXSwe2DvI1e+NRxF7+04UciwpA8yY3GreX9GLG5/2DTAnuLxYmQ7ywd4oy2kAOP3I9yUiYXJpaFfPb8l3hYg+gFXTskohgUgD917a8AlE/ydL9OtDtqvfc4S9WCJEvlwVH1IxuqyoQOeMqm4OTfgQTTGn0fSgNWhL704my6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ibYNXVZL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75b3c4006194;
	Thu, 7 Nov 2024 08:08:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=UvyRVSXObbm5utzbvKKEWqHMxQ1/8bZbiTbp+dRLQMs=; b=ibY
	NXVZL+Sv8gTT8wNBWZU32uMVGf58wGovd4qwcRnmgSxU/Kj4VB9itO+PFqfSh/rd
	CiTRvw68wOYGe5eizRuCtJt+Meodugo4Nj6v+LzlSHuVCz0mCQ8akpP2WzmbRICm
	d2HjqwOr+9QM5tLWGEq73SaTbCvAMhEry1vgsWR1pRB0MxTH7L+pI20FciTvNzqN
	N1bF66Yw/dSLIWDcIgRGprzb8a4Mnb9uK7Crk5LMTSXzUoiTVvSYNqyA8i74xp7U
	SGh23vMUMAlF/uAbuJP3QumWm7bK6oNAVGnOUqp+C7WhsY+FscxZbxdHgrfGhixD
	+GEXHD+3/cHFDOITDFg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rqj8s77f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:08:45 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:08:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:08:44 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id DD9D73F708C;
	Thu,  7 Nov 2024 08:08:40 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 00/12] Introduce RVU representors  
Date: Thu, 7 Nov 2024 21:38:27 +0530
Message-ID: <20241107160839.23707-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Qb4KmYtSxh1bo02FtMY5H_eKRYOXB2Ue
X-Proofpoint-ORIG-GUID: Qb4KmYtSxh1bo02FtMY5H_eKRYOXB2Ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This series adds representor support for each rvu devices.
When switchdev mode is enabled, representor netdev is registered
for each rvu device. In implementation of representor model, 
one NIX HW LF with multiple SQ and RQ is reserved, where each
RQ and SQ of the LF are mapped to a representor. A loopback channel
is reserved to support packet path between representors and VFs.
CN10K silicon supports 2 types of MACs, RPM and SDP. This
patch set adds representor support for both RPM and SDP MAC
interfaces.

- Patch 1: Implements basic representor driver.
- Patch 2: Add devlink support to create representor netdevs that
  can be used to manage VFs.
- Patch 3: Implements basec netdev_ndo_ops.
- Patch 4: Installs tcam rules to route packets between representor and
	   VFs.
- Patch 5: Enables fetching VF stats via representor interface
- Patch 6: Adds support to sync link state between representors and VFs .
- Patch 7: Enables configuring VF MTU via representor netdevs.
- Patch 8: Adds representors for sdp MAC.
- Patch 9: Adds devlink port support.
- Patch 10: Implements offload stats.
- Patch 11: Implements tc offload support.
- patch 12: Adds documentation for rvu port representor.


#devlink dev
pci/0002:1c:00.0

Command to create PF/VF representor
#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev

# ip link show
	Rpf1vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether f6:43:83:ee:26:21 brd ff:ff:ff:ff:ff:ff
	Rpf1vf1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 12:b2:54:0e:24:54 brd ff:ff:ff:ff:ff:ff
	Rpf1vf2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c4:4c:32:62 brd ff:ff:ff:ff:ff:ff
	Rpf1vf3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether ca:cb:68:0e:e2:6e brd ff:ff:ff:ff:ff:ff
	Rpf2vf0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000 link/ether 06:cc:ad:b4:f0:93 brd ff:ff:ff:ff:ff:ff


~# devlink port
	pci/0002:1c:00.0/0: type eth netdev Rpf1vf0 flavour physical port 0 splittable false
	pci/0002:1c:00.0/1: type eth netdev Rpf1vf1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
	pci/0002:1c:00.0/2: type eth netdev Rpf1vf2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
	pci/0002:1c:00.0/3: type eth netdev Rpf1vf3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false

-----------
v11:v1:
  - Submitted refactoring changes as a separate patch set.
	https://lore.kernel.org/netdev/20241023161843.15543-1-gakula@marvell.com/T/
  - Moved documentation to a separate patch.
  - patch 9: Added code changes to forward updated mac address to VF.
  - Implemented TC offload support.

v10-v11:
  - As suggested by "Jiri Pirko" adjusted the documentation.
  - Added more commit description to patch1. 

v9-v10:
  - Fixed build warning w.r.t documentation.

v8-v9:
   - Updated the documentation.

v7-v8:
   - Implemented offload stats ndo.
   - Added documentation.

v6-v7:
  - Rebased on top net-next branch.

v5-v6:
  - Addressed review comments provided by "Simon Horman".
  - Added review tag. 

v4-v5:
  - Patch 3: Removed devm_* usage in rvu_rep_create()
  - Patch 3: Fixed build warnings.

v3-v4: 
 - Patch 2 & 3: Fixed coccinelle reported warnings.
 - Patch 10: Added devlink port support.

v2-v3:
 - Used extack for error messages.
 - As suggested reworked commit messages.
 - Fixed sparse warning.

v1-v2:
 -Fixed build warnings.
 -Address review comments provided by "Kalesh Anakkur Purayil".


Geetha sowjanya (12):
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
  octeontx2-pf: Implement offload stats ndo for representors
  octeontx2-pf: Add TC offload support
  Documentation: octeontx2: Add Documentation for RVU repsentors

 .../ethernet/marvell/octeontx2.rst            | 102 +++
 .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/common.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  75 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   3 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  49 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  14 +-
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 468 ++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  54 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  75 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 +
 .../marvell/octeontx2/nic/otx2_flows.c        |   5 -
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  77 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  25 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |  29 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  14 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 864 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  54 ++
 28 files changed, 1953 insertions(+), 131 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


