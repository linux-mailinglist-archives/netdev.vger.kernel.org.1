Return-Path: <netdev+bounces-249390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A921DD17EE0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B70F3004E1C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731038A717;
	Tue, 13 Jan 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K4MDR3hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116AF38A2BA;
	Tue, 13 Jan 2026 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299435; cv=none; b=anG689AUzHpPM7Ak6uqqN6+lFy9EykYvrDElAv6nLIHmkcXYAiOrF0b/y2XT4OjOWuhasWUwxOgx23Tqeyh+LUtbJUNr/kea33F2J23l0dM5qMgD0i/EjGE7hvKykUjhWPq534RUv79Ou1MYG4dwIfUGCoSKXh0jm4qPX6OaLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299435; c=relaxed/simple;
	bh=PpAQXt2wEvyyiLTvgfKYo0mM3nCDJxdRejcJ9KLIhgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LuasxH0fQ1ZctDOiqcHMt4Xr3MiOO9uSrT6C5wI8srVodK5iN0OwTviVS4ca/8kGqTQuMb2su6PJSJYCGiQ/DUpa51m8DKPQFQeMjG7JebkBByiXstKvTKSANt2PWhcdawWBSfRFXVXJdr5iTrPTXF3lriSz5UIaMCwVLt4xrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K4MDR3hZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q96Z3356474;
	Tue, 13 Jan 2026 02:17:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mOtXrB1/cgmka49wQZLgXAb
	sbO5r+07AEK/N8Ib2UPs=; b=K4MDR3hZnxkZcOVC0npf1wmrQS6QV/bcmxvOf6m
	u3Hcoh+oID3/hbp6rqdmMeCb7gV0saC/6Sd+uFl1pIGCZSmNYAmrAP1vrGmYBQZE
	zOfiZSFzlTjFTAMZyeeBVKEtWAM7VXkVvZ1fLyHbtYDvpXrtlt0COHH9HjbyrhtM
	yfN2gHX9l7PanbkcN1NSoMu3QH7m+JJe0Xfv+NkTjJ6QB0wn4YFSPGfOkosqq7q+
	mL+NzlqfuXE3emeD6QIX/b08C/69Vjt8Rmz5D+XnM+1x2tTdmUuUoEHPq22yNhxW
	JQqW5BZXj5+uyKbIDPTSIB9C2Dzv6nvmaNhs+fjUXHLp+VQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bnd2g8t3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:17:04 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:17:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:17:19 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1D6903F709D;
	Tue, 13 Jan 2026 02:17:00 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v4 00/13] NPC HW block support for cn20k
Date: Tue, 13 Jan 2026 15:46:45 +0530
Message-ID: <20260113101658.4144610-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3gLzfAOAir6OtR0KvXLP09bt4vFN54Py
X-Authority-Analysis: v=2.4 cv=OvlCCi/t c=1 sm=1 tr=0 ts=69661ba0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=A1wDlwXRn1NGPBHeO_kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3gLzfAOAir6OtR0KvXLP09bt4vFN54Py
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NyBTYWx0ZWRfXylisiUFdMIRy
 YrdUhYixigcxxS+73FXmECVxRLnK6g5fNOqV3CBR1skjI2ryZeNqJFLdwWVOquMT0EIKBAQa4r+
 y6MEhN6/x/LWBVORk9gIYuy816wMx0plwHGJkaQOjHAmDFpZWDcIg5QQgUaEjQjjaDi+IBV50ln
 L+u1uduMT++5/9QzbrYIMLalESFLzFqCJPu5H5AFtlt4qDolLx5YmAFcH3BZKekMEjPiPnn8Eav
 m0DJ92Po89NLz9jAIit9y2buH+fkLWk4jzeY4MuWRbKV1bAGjd3pxTwfWSP6u8sqhUTXq6aWKIq
 wEsGvjRiqs6fjcbjKVkxFlQ6JCFCdiyrX7EIl4CxGNhrFg8qmh2gignfmMTqdIzn85T3RfD1Gx7
 YOUQi3xQx4hylRAktyizBDLq1PnTP0c1CpO+WGyuKScGJE9xbHismz0w7GlfgBLxzSPjjCKBic5
 wmTHSt6HrU0kLq271cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

This patchset adds comprehensive support for the CN20K NPC
architecture. CN20K introduces significant changes in MCAM layout,
parser design, KPM/KPU mapping, index management, virtual index handling,
and dynamic rule installation. The patches update the AF, PF/VF, and
common layers to correctly support these new capabilities while
preserving compatibility with previous silicon variants.

MCAM on CN20K differs from older designs: the hardware now contains
two vertical banks of depth 8192, and thirty-two horizontal subbanks of
depth 256. Each subbank can be configured as x2 or x4, enabling
256-bit or 512-bit key storage. Several allocation models are added to
support this layout, including contiguous and non-contiguous allocation
with or without reference ranges and priorities.

Parser and extraction logic are also enhanced. CN20K introduces a new
profile model where up to twenty-four extractors may be configured for
each parsing profile. A new KPM profile scheme is added, grouping
sixteen KPUs into eight KPM profiles, each formed by two KPUs.

Support is added for default index allocation for CN20K-specific
MCAM entry structures, virtual index allocation, improved defragmentation,
and TC rule installation by allowing the AF driver to determine
required x2/x4 rule width during flow install.

Ratheesh Kannoth (7):
  octeontx2-af: npc: cn20k: Index management
  Add CN20K MCAM allocation support. Implements contiguous and
  non-contiguous allocation models with ref, limit, contig,
  priority, and count support.

  octeontx2-af: npc: cn20k: Allocate default MCAM indexes
  Allocate default MCAM entries dynamically in descending index
  order during NIX LF attach, reducing MCAM wastage

  octeontx2-af: npc: cn20k: Prepare for new SoC
  Introduce MCAM metadata structure so low-level functions no
  longer receive SoC-specific structures directly.

  octeontx2-af: npc: cn20k: virtual index support
  Add virtual MCAM index allocation and improve CN20K MCAM
  defragmentation handling. Track virtual indexes and restore
  statistics correctly.

  octeontx2-af: npc: cn20k: Allocate MCAM entry for flow installation
  Extend install_flow mailbox so AF can determine rule width and
  complete allocation and installation in a single exchange.

  octeontx2-af: npc: cn20k: add debugfs support
  Debugfs entries to show mcam layout and default mcam entry allocations
  Legacy debugfs entries are modified to show hardware priority on cn20k
  SoC.

  octeontx-af: npc: Use common structures
  Low level functions should use maximum mcam size array and modify cam0
  and cam1. This is a cleanup patch.

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Add TC rules support
  Add full TC dynamic rule support for CN20K. Handle x2/x4 rule
  widths, dynamic allocation, and shifting restrictions when
  mixed rule sizes exist.

Suman Ghosh (5):
  octeontx2-af: npc: cn20k: KPM profile changes
  Add support for CN20K KPM profiles. Sixteen KPUs are grouped
  into eight KPM configurations to improve resource usage

  octeontx2-af: npc: cn20k: Add default profile
  Update mkex profile for CN20K and mark unused objects with
  may_be_unused to silence compiler warnings.

  ocetontx2-af: npc: cn20k: MKEX profile support
  Add support for the new CN20K parser profile. Introduces the
  extractor-based model with up to twenty-four extractors per
  profile.

  octeontx2-af: npc: cn20k: Use common APIs
  Update common MCAM APIs for CN20K. Add new register handling,
  new access algorithms, and CN20K-specific index management.

  octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon
  Add CN20K-specific MCAM mailbox messages for updated mcam_entry
  layout and avoid breaking backward compatibility.

 MAINTAINERS                                   |    2 +-
 .../ethernet/marvell/octeontx2/af/Makefile    |    2 +-
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  437 ++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |    3 +
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 4368 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  262 +
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   58 +
 .../ethernet/marvell/octeontx2/af/common.h    |    4 -
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  173 +-
 .../net/ethernet/marvell/octeontx2/af/npc.h   |    2 +
 .../marvell/octeontx2/af/npc_profile.h        |   84 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   17 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   18 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |   68 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   81 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |    1 -
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  513 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.h   |   21 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  664 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   14 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       |   21 +-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |    2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    |  265 +
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   13 +
 .../marvell/octeontx2/nic/otx2_common.h       |   35 +
 .../marvell/octeontx2/nic/otx2_flows.c        |  263 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |   77 +-
 27 files changed, 7086 insertions(+), 382 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.h

--
ChangeLog:
v3 -> v4: Address comments from Jakub
	 https://lore.kernel.org/netdev/20260109054828.1822307-12-rkannoth@marvell.com/T/#t
v2 -> v3: Resolved build errors, addressed comments
v1 -> v2: Addressed comments
2.43.0

