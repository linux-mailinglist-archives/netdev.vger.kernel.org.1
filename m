Return-Path: <netdev+bounces-48271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806947EDE4D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3DC1F22CBC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142B14F92;
	Thu, 16 Nov 2023 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aM8RrIJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628D719F;
	Thu, 16 Nov 2023 02:16:24 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9B19E007460;
	Thu, 16 Nov 2023 02:16:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=J0jU/IaWaWx/uf9fJRPUL71R8i/gID+fDxQ120Q+JOA=;
 b=aM8RrIJ5Nr0lnHFvCsq4HOMrTDEc+G5BqH1KL92W9t5MauY95JSvxXPrUY8sgOCZEHsZ
 Vqx5CjgwpHqTWx3sRGX2Z/hueeROmYRlbURLdwCreFmB60YJZxR+KCgCWtJzKttjrPVO
 oHjZzm2ivToajBI78gODscFlFOAtzeqTp0F+Be9zISs4STghQuVbthqavh52ucYwAq3K
 hfC0NL8NU91qg8dWpU4S/ePohfWVfVwYoam6w5Hs6XO0eK+UuNiBj+iEQ86UfBFrfg8D
 FGn87xXqAYD4hP+JIiSk9kh7hiH+7IABR9CIl29Nkr93WWPIWm9QH4Hcdk6tfIFUTHle 7w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uc5vmu5jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 02:16:11 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 02:16:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 16 Nov 2023 02:16:09 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 3F9DD3F706D;
	Thu, 16 Nov 2023 02:16:05 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 0/2] ocetontx2: Multicast/mirror offload changes
Date: Thu, 16 Nov 2023 15:45:59 +0530
Message-ID: <20231116101601.3188711-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _f7f1V7ieNT_nrVHIOz5w2qUxLtnjw57
X-Proofpoint-GUID: _f7f1V7ieNT_nrVHIOz5w2qUxLtnjw57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02

This patchset includes changes to support TC multicast/mirror offload.

Patch #1: Adds changes to support new mailbox to offload multicast/mirror
offload

Patch #2: Adds TC related changes which uses the newly added mailboxes to
offload multicast/mirror rules.

Suman Ghosh (2):
  octeontx2-af: Add new mbox to support multicast/mirror offload
  octeontx2-pf: TC flower offload support for mirror

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  64 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 686 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  66 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 110 ++-
 7 files changed, 947 insertions(+), 38 deletions(-)

-- 
2.25.1


