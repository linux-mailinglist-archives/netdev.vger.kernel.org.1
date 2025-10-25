Return-Path: <netdev+bounces-232795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C9C08F15
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AE01B23E42
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275122F39A5;
	Sat, 25 Oct 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AoeuFhww"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB323E35E
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388404; cv=none; b=aGEb8y6lhcXcpeclK5rBQeB1+gRn9CC0dTxCR4IodWmN9yB27aw48XjMjbsr8QbFvMcA7H9Ofo4OdJk4CM74HszDnXx/RjrwLhfZ6iutlHwlwawOT1CcsavoSWDJRXiQoNNdS479ymDKUKK2SSQ0p3yDlllOyNgtyAvlHPnRD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388404; c=relaxed/simple;
	bh=R5C1C/GFIBVTbF80hL5yPJzzAUNU91RQXblsoQIXnbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ud7pPU3WfTl3hSHhikxQfjCx5tG2ob8X8Rch35kBNyz4e9oh5km+kSRyQjgm8cGzQxD8QB/vNP71k2/gnSYItmwGr+xIZj7RPQV14c/jMJZ85FZm7dNvlHBLCsK3R9rUq07CDFgRaTFwzV1t2NRdybt1ratM+fIHhOkzimpehZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AoeuFhww; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P80229613482;
	Sat, 25 Oct 2025 03:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=9eDN6c30DO+JrR4XGNLEYvRMFahp3mUdFOIxhzvaN90=; b=Aoe
	uFhww+TWrkcq/6rnVDXM6pvghRclqAhwccJraPObF3mSeo5PZYoS12x43NBg31lu
	KyskwZOnrHABYSDpEw0O9PTzQXH2ydTx17VXiHiJGcp3fvae2tEpSARLu2vUG3Aq
	Mc9BwuKPWhaLnOFwwUPO1D1/+2m9vbrvL9cbhC+bUVs+7WXZuRk+sEfEyKYkgGg4
	hGifXI5zvpo+sA8g9VZOcc6SfxremyECXOaZeu5SJcE7yi33h0ClWPJg4t0uXgnf
	485kpisQUvuPVnxdZaZ3PVcM+EZryihokMETQ/8fcZvci0VtcJICUHRn2AYEwX3V
	doqsi2ua4G9P7L31Shg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a0p2g8gxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:18 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id E4DB65B6921;
	Sat, 25 Oct 2025 03:33:04 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 00/11] Add CN20K NIX and NPA contexts
Date: Sat, 25 Oct 2025 16:02:36 +0530
Message-ID: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX4l4zbwcPE0kq
 qm+zpVhSNwqpSbAY7ZWapHce3B+647nVIW5zaCB6tAAHSB8mZotcd+V70OdlRAHbk+fnivBlEX8
 +RQvYb3F2i70FGcdthqedBfSUbuE5cwXVl+7qzDS9LcgOn1iGTVYMOp7bIoH2fmAh/hE2Vf0Tk0
 oM0yfN1eLtjjBEdWyAalrSroZdqDLpaWK4yWtJHvSUv3G4KPVSkhZBMngTx6XXrcd46BqUNL9O/
 ySnvpbvtu6Vxfo4CzXIkZKqusfS5xBJKTvq7l8GVVwGdfTZxnfKWrIlNsYSjRzZCPsIHbB0o9/m
 pUqMM6lFx50wMbRhvFhkmwxfL3muFOfrx0HRp2OthHSekUQ6YclQLzRd5Wf/ohvhuAh2u4AXBE4
 7BuEqSCNTioU0ydY6Mzt8MYFkUFieg==
X-Proofpoint-ORIG-GUID: V1-k_YsqIsdb-tWPucuxYUBW2H5DILhl
X-Authority-Analysis: v=2.4 cv=Bt6QAIX5 c=1 sm=1 tr=0 ts=68fca766 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=BODy_oOD_763Z0c2EKIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: V1-k_YsqIsdb-tWPucuxYUBW2H5DILhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

The hardware contexts of blocks NIX and NPA in CN20K silicon are
different than that of previous silicons CN10K and CN9XK. This
patchset adds the new contexts of CN20K in AF and PF drivers.
A new mailbox for enqueuing contexts to hardware is added.

Patch 1 simplifies context writing and reading by using max context
size supported by hardware instead of using each context size.
Patch 2 and 3 adds NIX block contexts in AF driver and extends
debugfs to display those new contexts
Patch 4 and 5 adds NPA block contexts in AF driver and extends
debugfs to display those new contexts
Patch 6 omits NDC configuration since CN20K NPA does not use NDC
for caching its contexts
Patch 7 and 8 uses the new NIX and NPA contexts in PF/VF driver.
Patch 9, 10 and 11 are to support more bandwidth profiles present in
CN20K for RX ratelimiting and to display new profiles in debugfs

v4 changes:
 As suggested by Simon
 	Added static_assert to all context structures
	Fixed line wraps
	constrained #ifdef to small helper in patch 7
	Used FIELD_PREP and FIELD_GET in patch 9
 As suggested by Jakub
	Used order instead of page count for pp_params.order
v3 changes:
 Added static_assert as suggested by Michal Swiatkowski
v2 changes:
 Fixed string fortifier warnings by padding structures

Link till v3:
https://lore.kernel.org/all/1752772063-6160-1-git-send-email-sbhatta@marvell.com/

Thanks,
Sundeep

Linu Cherian (4):
  octeontx2-af: Add cn20k NPA block contexts
  octeontx2-af: Extend debugfs support for cn20k NPA
  octeontx2-af: Skip NDC operations for cn20k
  octeontx2-pf: Initialize cn20k specific aura and pool contexts

Subbaraya Sundeep (7):
  octeontx2-af: Simplify context writing and reading to hardware
  octeontx2-af: Add cn20k NIX block contexts
  octeontx2-af: Extend debugfs support for cn20k NIX
  octeontx2-pf: Initialize new NIX SQ context for cn20k
  octeontx2-af: Accommodate more bandwidth profiles for cn20k
  octeontx2-af: Display new bandwidth profiles too in debugfs
  octeontx2-pf: Use new bandwidth profiles in receive queue

 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 218 +++++++++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |  28 ++
 .../ethernet/marvell/octeontx2/af/cn20k/nix.c |  20 ++
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c |  21 ++
 .../marvell/octeontx2/af/cn20k/struct.h       | 340 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  15 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  76 ++--
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  29 +-
 .../marvell/octeontx2/af/rvu_struct.h         |  31 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  10 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 220 +++++++++++-
 .../marvell/octeontx2/nic/otx2_common.c       |  14 +
 .../marvell/octeontx2/nic/otx2_common.h       |  10 +
 16 files changed, 1092 insertions(+), 55 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/nix.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npa.c

-- 
2.48.1


