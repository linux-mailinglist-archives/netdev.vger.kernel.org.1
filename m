Return-Path: <netdev+bounces-55194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A26809C9A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21988B20CA5
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFA6FDD;
	Fri,  8 Dec 2023 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h+Upgxe/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC81722;
	Thu,  7 Dec 2023 22:56:24 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B81CqRG028994;
	Thu, 7 Dec 2023 22:56:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=Asifnag27XDf+5RroF5FKkXLOk8AcvsF3QCMi03ignc=;
 b=h+Upgxe/gLZNgJoIjkg45Pjx/FS4VeHI2x2ss7LrSCa3y+9bL4AHV036pZU+5Rp+L8tU
 WOnKm6lL/9IYdGWB+e7i1XK9SZphepXWcKUkMtrefkVjPHqw7mj7lPrAAAbfEO8JMpRv
 4JzVQffVj8yiOY3+clh77Myd0dmehdC3V32tCBfN+KrBF9DplWWzJKpHkPOD38q1G4p4
 I0T/FtM0RsEn2kO11pb3oIaFVygPABiJczleiuYNr1JYf2Hyx2MZZD1+vdurHnrMlu8W
 8HRDwSvZiGAOEFZOQKd7aQzNNrsCXZMP43gHQ3mDhCKBy+YSX3L8PCTuO695r7GGdPWX kg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddc0hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 22:56:18 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 22:56:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 22:56:15 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 129013F7050;
	Thu,  7 Dec 2023 22:56:11 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net 0/2] octeontx2: Fix issues with promisc/allmulti mode
Date: Fri, 8 Dec 2023 12:26:08 +0530
Message-ID: <20231208065610.16086-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sh1es6nVbeAoL2-Y6Lqb7gGUGeDI_Jkj
X-Proofpoint-GUID: Sh1es6nVbeAoL2-Y6Lqb7gGUGeDI_Jkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02

When interface is configured in promisc/all multi mode, low network
performance observed. This series patches address the same.

Patch1: Change the promisc/all multi mcam entry action to unicast if
there are no trusted vfs associated with PF.

Patch2: Configures RSS flow algorithm in promisc/all multi mcam entries
to address flow distribution issues.


Hariprasad Kelam (2):
  octeontx2-pf: Fix promisc mcam entry action
  octeontx2-af: Update RSS algorithm index

 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 55 +++++++++++++++----
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 25 ++++++++-
 2 files changed, 66 insertions(+), 14 deletions(-)

--
2.17.1

