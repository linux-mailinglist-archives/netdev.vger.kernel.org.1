Return-Path: <netdev+bounces-109411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83A928688
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22790287503
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA98146A62;
	Fri,  5 Jul 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eabBc4vP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AB60DFA;
	Fri,  5 Jul 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174603; cv=none; b=d8axdkC1K9FOoj5E9RfCAmEAopFhd78F0xA5VT73u8mP3o4YeTFwGhCATueEjbIYuheuX+l5kqKAhEwpRX4+jElYWGifzDvF8NtzWXgvLo8T6KKTbJSoV/IdfVccjov+m6lOWPwou1yes28pVrEp0MzEgcyZcA1noZCO92SbNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174603; c=relaxed/simple;
	bh=a8pc6RPIckJJzfw5SCPK/ykqp10iT32nOfzGe98E+58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdKji0y/X4aClhpzxsGxScnBRLdQJfyk62f8pxq+OplmXTLcRNtuZHAcC2PT3GFWoTzll+0UwCSCxMhoqGUN/asS723HzGmE6hueFIszt0kF+yfQqElJQgSQQ4CLedt1zkFbCarhlNp+mbmHMxugN7xcZA6GxlEbeiK2pxUb03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eabBc4vP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464NkFad002580;
	Fri, 5 Jul 2024 03:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=YVt4wui1NixG3hklYR8bQNRuLZEjk6EJlvXtqrxU/zM=; b=eab
	Bc4vPPOoN9HGal/4NGgKtQXxY9qeSX7LFMMSTOQqQfk6l6Xu0BNefzzrkmvJU6sK
	u2/uexWy0/fxwpeXckpkOQOlr11V6aaKyIJVNVQV4vf83tCUiOI9xhXfR+PRkhxW
	GqB2r2cXmhPXzrdpVfl5ncgvjSJ65iAb90Vjokzii5bmWSgzeg2O9uJMDCm49bi3
	ZAaKkn2yGX3hjfkoMFXb11J1gAE87PQR8MXG1frOmXtKvYwLl47aNIPBoxzqO+Lp
	LtcoO1kKVZouWaxgIJ/zfgj9xK5tcODuFCqAvvcWrdQ6DzopmqrTzHP/y1nvcslj
	DMNLPjGhy2xe1otqgZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 405s2ebe3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 03:16:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Jul 2024 03:16:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 5 Jul 2024 03:16:22 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 948AC3F7040;
	Fri,  5 Jul 2024 03:16:19 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v8 00/11] Introduce RVU representors  
Date: Fri, 5 Jul 2024 15:46:07 +0530
Message-ID: <20240705101618.18415-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sX2hA3LlFUd_ACGqQkuqLsaZltZ7oPdF
X-Proofpoint-GUID: sX2hA3LlFUd_ACGqQkuqLsaZltZ7oPdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_06,2024-07-03_01,2024-05-17_01

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
- Patch 11: Implement offload stats ndo


Command to create PF/VF representor
#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
VF representors are created for each VF when switch mode is set switchdev on representor PCI device

#devlink dev
pci/0002:01:00.0
pci/0002:02:00.0
pci/0002:1c:00.0

#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev

# ip link show
	eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:58:2d:b6:97:51 brd ff:ff:ff:ff:ff:ff
	r0p1v0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff:ff:ff:ff:ff
	r1p1v1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd ff:ff:ff:ff:ff:ff
	r2p1v2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff:ff:ff:ff:ff
	r3p1v3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:ff:ff:ff


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

v6-v7:
  - Rebased on top net-next branch.

v7-v8:
   - Implmented offload stats ndo.
   - Added documentation.

Geetha sowjanya (11):
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
  octeontx2-pf: Implement offload stats ndo for representors

 .../ethernet/marvell/octeontx2.rst            |  55 ++
 .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 +++++++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  26 +
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  58 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  84 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
 .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 725 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
 28 files changed, 1932 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


