Return-Path: <netdev+bounces-51140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17277F94EA
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C161C203B0
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620BDDDF;
	Sun, 26 Nov 2023 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R1hN1biC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78766E8;
	Sun, 26 Nov 2023 10:43:35 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQI071x015842;
	Sun, 26 Nov 2023 10:43:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=DXR67G+DNsPl46onjVIn1GegKlkStUK7HA+SwiW69+g=;
 b=R1hN1biCIW1RZXJKuxaDj5LIF88hbW7f8SIE2QLuJURqymiujHI1NAyxwsQKUNmc0w7W
 ZZ1KIuP9/eudWsI8e9Yk209xsC8QeXKyMPFC9d1NX1H5vH2TjctljabuafMWf0WJQK3w
 yWpMcFqkUvNUh1vgrKwD8BTv5LaAcbIYq9o8c+XKdLA18X7uh2eEkG8RpKmVOhla5lLF
 jQwe6yIO64IVd5JhtGx1BI52aA2TegSp6cACNDcV9Qgq5VZdvgMeRnRitWqZwvQGzKYd
 TqaNZXKGBZdfCviRHHzEBvx67WxGOL/+/Co6hEZl5i+i0e62T0cylPhXuKc12hUitJrp Vw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ukf5x2htd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 10:43:27 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Nov
 2023 10:43:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 26 Nov 2023 10:43:25 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id C49923F7094;
	Sun, 26 Nov 2023 10:43:20 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <horms@kernel.org>, <wojciech.drewek@intel.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v4 0/2] octeontx2: Multicast/mirror offload changes
Date: Mon, 27 Nov 2023 00:13:13 +0530
Message-ID: <20231126184315.3752243-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JbumbgDXSYcevFB354Rmu-BJ2chrRy2o
X-Proofpoint-ORIG-GUID: JbumbgDXSYcevFB354Rmu-BJ2chrRy2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_18,2023-11-22_01,2023-05-22_02

This patchset includes changes to support TC multicast/mirror offload.

Patch #1: Adds changes to support new mailbox to offload multicast/mirror
offload.

Patch #2: Adds TC related changes which uses the newly added mailboxes to
offload multicast/mirror rules.

Suman Ghosh (2):
  octeontx2-af: Add new mbox to support multicast/mirror offload
  octeontx2-pf: TC flower offload support for mirror

v4 changes:
- Updated pacth#1 based on comments from Paolo. The major change is to
  simplify mutex_lock/unlock logic in function
  rvu_mbox_handler_nix_mcast_grp_update(),
  rvu_mbox_handler_nix_mcast_grp_destroy() and
  rvu_nix_mcast_flr_free_entries().
  Added one extra variable in the mailbox to indicate if the
  update/delete request is from AF or not. If AF is requesting for
  update/delete then the caller is taking the lock.

v3 changes:
- Updated patch#1 based on comments from Wojciech and Simon.
  The comments were mostly based on some missed mutex_unlock and
  code reorganization.

v2 changes:
- Updated small nits based on review comments from Wojciech Drewek
  in file drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  72 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 701 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  73 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 ++-
 7 files changed, 977 insertions(+), 41 deletions(-)

-- 
2.25.1


