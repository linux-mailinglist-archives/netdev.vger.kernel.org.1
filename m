Return-Path: <netdev+bounces-166145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE1A34BFB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2691886E3F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A910242921;
	Thu, 13 Feb 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wthce/YT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C324169B;
	Thu, 13 Feb 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467909; cv=none; b=pM8Wdic5V6X8i9YlKfOTWUU+e6dW4a89UPQ6kpqiMV5CQ1+JyC6Qbc0qrzgmWXqxQRR6M9LfA8rVQw4/yKeV0eXW7829e2P5O/dSZmtkJ0skaaw5DIdgfVDmsQkzxmze3+puftakwkStpdYMJPXQdwpaetqQ6NRkJ/52sKX3LNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467909; c=relaxed/simple;
	bh=hViWmk89vOoLMLnKK9no0UZbnJA6UFqyx+SjlMdI49w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZJDqkLrhN6Vk1NNgCRGeukgTbeUO2VPF0SsmaaVcJBsps5MuVj9KVi3+UOdYVjupBfHMm7Ij+n6yhs8TkqMjXb/s+nRggRh6b8x1lwBwiq8soXN8WW+JpoBCQU8JGDWdt6m6qfaYY2t3ATcF74g11SZ5nZL0U4Q2t7PxNLkON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wthce/YT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DH3oIG011522;
	Thu, 13 Feb 2025 09:31:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=UCWnjri5y386AVebKSsSLIf
	eeCS4TIG2rSsyU2i/7Ms=; b=Wthce/YTdpv3LZ4WFpyhdn04I4qDys0HfpTjcHY
	RHP/WLS6LuFE3e59gQraOzzuBwGkn9X38bjr/XHY7kPpQD9Gh1uFlp3GJ30qix6f
	MzCGdG6j9t2fs8WQbmx1ZXdB7OzEWxFNh1nh2x6UvrwLFYIG3IDMGNsI2Pw07hzO
	49wn7zoQ7vaQ/x6igQSNkXIcuffGPNEtQvlKB0nJIlMQB7UcuvCdQb8Cv43ElzIZ
	5CBB/PIA0IgivseW+oq5JdDYaRG8yCXkJtSEuz4jCLn6A1mtcZ6qMykEUKt5mIMj
	15G4wmBkXx/IUPxSHJsQWFKT545BBxh/y/Qh5sGEQ2fWNBA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44smtb04b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 09:31:25 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 09:31:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 09:31:22 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 61C9E3F70F7;
	Thu, 13 Feb 2025 09:05:08 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v9 0/6] CN20K silicon with mbox support
Date: Thu, 13 Feb 2025 22:34:58 +0530
Message-ID: <20250213170504.3892412-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0ePm4JEfuACCh3qEDS-2VH2MvawUNC-D
X-Proofpoint-ORIG-GUID: 0ePm4JEfuACCh3qEDS-2VH2MvawUNC-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01

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

 .../marvell/octeontx2/otx2_cpt_common.h       |   5 +-
 .../marvell/octeontx2/otx2_cptpf_mbox.c       |  13 +-
 .../marvell/octeontx2/otx2_cptpf_ucode.c      |   4 +-
 .../marvell/octeontx2/otx2_cptvf_mbox.c       |   6 +-
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |  34 ++
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 421 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  81 ++++
 .../marvell/octeontx2/af/cn20k/struct.h       |  40 ++
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.c  | 106 ++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
 .../marvell/octeontx2/af/mcs_rvu_if.c         |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 226 +++++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  81 +++-
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  68 +--
 .../ethernet/marvell/octeontx2/af/rvu_cn10k.c |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   |   4 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  22 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  54 +--
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |   8 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       |  16 +-
 .../marvell/octeontx2/af/rvu_npc_hash.h       |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  13 +-
 .../ethernet/marvell/octeontx2/af/rvu_sdp.c   |  10 +-
 .../marvell/octeontx2/af/rvu_struct.h         |   6 +-
 .../marvell/octeontx2/af/rvu_switch.c         |   8 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  18 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |   1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |   2 +-
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 252 +++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |  17 +
 .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  35 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 173 +++++--
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  49 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  44 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |   7 +-
 include/linux/soc/marvell/silicons.h          |  25 ++
 42 files changed, 1574 insertions(+), 318 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
 create mode 100644 include/linux/soc/marvell/silicons.h

-- 
2.25.1


