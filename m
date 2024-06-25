Return-Path: <netdev+bounces-106509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B18916A31
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D8E1F21AA5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289616C6A7;
	Tue, 25 Jun 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PPgjtYU3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7447A64;
	Tue, 25 Jun 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325521; cv=none; b=HuCXVrgFqg9bozDrdNlfhXxgTFIycjtZw16HzqyJEwj4Sas7fxip82xKkbe9Ski7Vczm4fNWwnCf6WZkn9d8HGFVuTZO1MSpG+eMONWHNY6wGjTz/eWab+Mk5lIwDTPs4jU3Cr8CIjxPEAqwp1NKWNa44vskrEwiAznrh5X85P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325521; c=relaxed/simple;
	bh=7Ql6wzXgWyF8NGgbsyHVYC6MbpONUfRdsw2Uj20CiL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JFdTt9qS8IGj97/uZDWlG9SSRf7zQ/8OczeUlkVSrFOqFOfEkRR6NTTGg8ZNKq9qd4A2bSFscroxcdiqP3iScr35c9U7yDUQ8d4lLnjtjim8yvjnj+UrijLw1qta6FQFbfQ9c+8DNzOR2cO242v9guLORUfnRqdtHjc8fXq3nkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PPgjtYU3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8sUD2006261;
	Tue, 25 Jun 2024 07:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=ZQtXd3zR0ULIEP+2DYE8NxObpcJoH0Cc7M/A5JF2bOI=; b=PPg
	jtYU3zYbg8sQiJg17WPT/6ALd69ItAyp2C+2jHtveqQrbTojAbb87D19zfBLMUsb
	Xi4FFT8cExHZp/N+5PzTXMRWm+3iJ12aUi5xeir9od/AoCHrn+SGQudk2jVyzWgH
	NdS3qSc+0Rh71A8gBjSO0dHU4uOrSD/GbuC0hnGPNL++P7FHjHkWiAQm7HlD1zlX
	JkTRa4oxDnGN46p4C+KztJ9HSR22tD5fFrueNIt17m3Oc7C9SswcG5Uk574XGQ0j
	CtrugOGPHRZPpkk7RLBh/wT9k3voljFZ/0VKyReiC+JO2QKZ1bttEiBF60uzEDXH
	fBPcbAz7d2dBhv6UDkg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yytt097sm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:25:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 07:25:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 07:25:07 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 847723F7045;
	Tue, 25 Jun 2024 07:25:04 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v6 00/10] Introduce RVU representors  
Date: Tue, 25 Jun 2024 19:54:53 +0530
Message-ID: <20240625142503.3293-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JRSSdviNOIbVCf9qIl8MxYf9hD7A4QUY
X-Proofpoint-GUID: JRSSdviNOIbVCf9qIl8MxYf9hD7A4QUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01

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
pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
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

v4-v5:
  - Patch 3: Removed devm_* usage in rvu_rep_create()
  - Patch 3: Fixed build warnings.

v5-v6:
  - Addressed review comments provided by "Simon Horman".
  - Added review tag. 

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
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
 28 files changed, 1835 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


