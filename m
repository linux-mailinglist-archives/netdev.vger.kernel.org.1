Return-Path: <netdev+bounces-115768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66947947C0F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE1A280EB0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C403BB30;
	Mon,  5 Aug 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BybROuc3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467F38F97;
	Mon,  5 Aug 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865374; cv=none; b=LOwv8UvYFZG3B6zW95MJ1dfWSiVJoqizLVRC9hKB/G+0TAXmwTWj4gwIXIFnYxbaWhb7LAaE8JnVV1cm1pLrIayDkAai3OEmLQRDAdMX8CPt2Wu2148GJvS9oKUjcxxStCHrMSNotribO+7poymjiOjfiyQu5hE095L5chNcdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865374; c=relaxed/simple;
	bh=9ZJEvZ+VcYYZ+TasubzvZy6iH+fngrgv+sfP0TZkYb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p6ct9yM6O6hooD56U61tQur1KOeCdUsqs61vq4NoKulF5b/xiHfV15g2/4keQs9NqCG98fJF03+AaE6tLs9L/Ofwe1yReRHWyRE5QQGMqfxWQMOaOtNxnoYfcjF7r1977jAVIa6BYjaET+SO/z1p/eBoiIgiDDInEWm9IN/N8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BybROuc3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BVBg6021538;
	Mon, 5 Aug 2024 06:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=GQhNe1kfaQmE5XdxYGDbyT/dIdZ1cMG/k2EgK/apYAU=; b=Byb
	ROuc39OR8krVj12hp/bnbNDWrugUo+qveSwetW+waf1/CHcZVsXCmAw4WcWD6e8J
	dGeA2szD+SJILhRxqcWSmpEUf9e1e3wtD3gXq8K0f9Dlup5Njj6g9Dy3abCc7gFV
	eXAuiVdAJfIMNiojuzyyUeam4q7SJ+6Dqa8sTBbrtAwwu29s8lN3cOb+8GYCFX69
	5d5L6uKWAP1wnxCX1fozbwnkSLK8z2CP+r/bRDdsCiYQRjq8JypQ9xz1wuGRVBjS
	mvwb5tVBUVOJJtAGthtDj3fPwO22IykUze0K4s/VD9vICLiFR5uYR2Fw/2QEQ3jh
	YOknsWqkc0HSrY9u+mg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40twxd0cmk-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 5 Aug 2024 06:42:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 06:42:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id D091A5B6E8F;
	Mon,  5 Aug 2024 06:18:16 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v10 00/11] Introduce RVU representors  
Date: Mon, 5 Aug 2024 18:48:04 +0530
Message-ID: <20240805131815.7588-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: iBJxOWyPmCh0uOnoepAmLz7B-Zc249l4
X-Proofpoint-ORIG-GUID: iBJxOWyPmCh0uOnoepAmLz7B-Zc249l4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01

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

v8-v9:
   - Updated the documentation.

v9-v10:
  - Fixed build warning w.r.t documentation.

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

 .../ethernet/marvell/octeontx2.rst            |  85 ++
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
 28 files changed, 1962 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h

-- 
2.25.1


