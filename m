Return-Path: <netdev+bounces-251425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A058BD3C4BB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 565B8584CEC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDCE3A0E94;
	Tue, 20 Jan 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JZpPUjzU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893A38757B;
	Tue, 20 Jan 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903450; cv=none; b=l+IPbHgkBea4SQyRokOqGWv9zV8Hj5XIN+vpdjxh0Jo60nKJcPkh/4I2VGxepUyW4T+nQW9Q6HRuqq3Jcy4rM/Neo4gyP6swTsRsJM5FMtp1RFAgpCksP66jHtKJyuQvW+lEvcD95oeg0n2U/cl2bj3dS/xvCgxGh7dVCjhWU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903450; c=relaxed/simple;
	bh=z/37CXg1o6Ft0V6Mv74mTqvuXKrLrGbjqFwBVKZFS1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7X79bBVj8cZDVh4SeaHiof3PDbcUIcIV/Hjgrkb182+c0LwpBBhr9AGG3lvtkEnCDZd6SPGwP3juyg24ev7Ww2inCOqnKG9yyUEOnw0ZsUe1kXQj4v8SFGDkM5t1M9M6XRgWPaAISf3/z+wzyVH9XzEkMAxsJdnlY51JuXPsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JZpPUjzU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JLfcpT3381160;
	Tue, 20 Jan 2026 02:03:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=V9OAIu1OdhMMLbHw35ac7EX
	37rbaryIwMt1OTCtVaI4=; b=JZpPUjzUg871JMMDQDjT60x3q1B+kHLgm36AP09
	uWYL2TgLjDTwljVbP014AllnTvFERCpJyQoD8rQNxJbIuAw8MdLC9aG8lzAo3HIf
	kiBdjZX0UYS14NDQULehXFQhoM/UdG4Zr9Ec1toE3NSO81va+moJlg4sRmNKRB9R
	ebggyWnkF9ikW9BIYH4OmNHAT164gmFKlidNTOvxwmZ8allMui1pJuE4gDs1bEc5
	8wjWkOGbxpyljyWZzJ9e4JFkrEmmVkEE6anjoJXDARM4BW3GtoVRc8yAPf2CdML5
	xKWHk79vKQT0aavQxtmdfyVZtPbgzUHHXwuYX0+1KmWdNyw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bsg20ajy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 02:03:47 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 02:04:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 02:04:10 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 4FBA35B6936;
	Tue, 20 Jan 2026 02:03:42 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV3 0/2] Octeontx2-pf: Add support for DMAC_FILTER trap
Date: Tue, 20 Jan 2026 15:33:39 +0530
Message-ID: <20260120100341.2479814-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y-cgJGV-J2mAQ9aJNPoosw90g8Xi2hQG
X-Authority-Analysis: v=2.4 cv=XPY9iAhE c=1 sm=1 tr=0 ts=696f5303 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yfvZBKtj2kfplXi_T7QA:9
X-Proofpoint-GUID: y-cgJGV-J2mAQ9aJNPoosw90g8Xi2hQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4MyBTYWx0ZWRfX7FkO04GmXhN/
 OHi9akWiOEwFC+ZSEbdDYM8ggMCCYZpRB8g+QUA9bCeeq61quoKQyC7d1Bf3vHJkXJOYczGQ8y1
 v0iCML1d85uEhGOy07xe37TEdzhtzXzoTUdItYJAus10XY/WrQmNFbfy5ERsPV5be2Vy7JHKjB4
 vqjvUq33iflJuXjVaLbQ+IU5f1fu1gDw9mienAFsVOh0d2LqDD7xlD+kDNXK+p9fTmSGB3+2Oko
 WW2t152HVoEsxUh8CuHIxPL9PheYnzEzVmYZU9BB5W9BF5wh87GTM4Pwi0kllCpDo4cu5MWz/9C
 weRe2qK5LofLn+G4Fil5gE6GSha85UYsz5mcWdT1GuUWQpjIonWHI+R9N+LUTIf7fawt7wpHuY/
 YNZWW4JRXgwhYLHy6qe6uprMg1xUkdbg+BvEQigG3B2PPTghTM80L+oTQQoe1JNdRebY6xZqWUS
 sKH/WpQ6uFakxI8Z/4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01

Octeontx2/CN10K silicon MAC blocks CGX/RPM supports DMAC filters.
These patches add devlink trap support for this functionality.

Patch 1: Introduces mailbox handlers to retrieve the DMAC filter 
         drop counter.
 
Patch 2: Adds driver callbacks to support devlink traps.

Hariprasad Kelam (2):
  octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter
  Octeontx2-pf: Add support for DMAC_FILTER trap

----
V3 * Address review comments suggested by Claude Code

V2 * fix warnings reported by kernel test robot

 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  11 ++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |   2 +
 .../marvell/octeontx2/af/lmac_common.h        |   1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rpm.c   |  18 +-
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  23 +++
 .../marvell/octeontx2/nic/otx2_devlink.c      | 167 ++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_devlink.h      |  23 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   5 +
 10 files changed, 257 insertions(+), 2 deletions(-)

-- 
2.34.1


