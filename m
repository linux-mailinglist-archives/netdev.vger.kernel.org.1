Return-Path: <netdev+bounces-190122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC42AB53FE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8757B3B5813
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BFE28CF7E;
	Tue, 13 May 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e8WaV1hs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8C23C4E9
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136434; cv=none; b=cZocbCFflQeee1ivVa+ForDQfCQ7zuXaeI7vvjIL0gj4zln3vOYCSV7qjU6cNPVCK970wjdIX+PhDmOdsPvlQXBfl/y0RDSRaM1pU1gbubNiwttL55lGmySQartKpVjW07ZLYNdoqlMst4TY5ThoDYKOULcbLxbSY0BLm+b3v1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136434; c=relaxed/simple;
	bh=85ZMNmMFj0w56osbSnquVGpzG5Mfz9ALiHrYYgE4Ih4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EakvWfrWztym6pTW92qdoJ/8aXoeNk9e5NpfmWc9RDL6joL18dSnlRVgSmNPZaIfk6J9lqgE/liZdMi2YbkFky5XJdAC0Ar7bUS794ZHSFGqjh98t632susCGV7gjM8RjfVRva0kB3Yt4r6JOsHZc5VBIEjiF5x7vRB56AP0KFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e8WaV1hs; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CNgc4L026927;
	Tue, 13 May 2025 04:40:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=iOMZA7HTf68tMx7jgyYFl9l9NW1mHsVAY58pxVCPGTM=; b=e8W
	aV1hsdB8io/gMgjuMUxz6IoYR8ihXs4JH9fcYfZ8WIz1dzKTepCiRinS1WabzWzM
	uXhB6g1q/c1WwKdNjatZAZByP6nMIRWFMnJIvTMNOUmCV5qF2TOVkQrsnHlnsBci
	25+WStIuhVQIGwxRpw9WpyTyTSzoDvMVbxZSKApL75kGur9EKMSYmjjbSZh+nbV9
	8WO4x1rTD1Nr0rTkUwcLTS2aYmBKAopvPh6paeZWNe/qPh9cEiWfGZUwjLhK7odX
	BtEclhvZ6aspBXUq+f1Rl1PMN4U7pFgmVpJ6ivmFqznnpZf/OKYA6Gd9t8yhoYo2
	kynHRP0vMHt6sY4UFWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ktw195mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 04:40:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 May 2025 04:40:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 May 2025 04:40:20 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 61DF63F709E;
	Tue, 13 May 2025 04:40:16 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next v2 0/4] octeontx2: Improve mailbox tracing
Date: Tue, 13 May 2025 17:10:04 +0530
Message-ID: <1747136408-30685-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: LT_7HPvEshYepE36DoUwg3DtERXaxUYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExMSBTYWx0ZWRfX3jzgJZkGpKCn DvoajjEcoCSsicaTKIuJtR/gsUPjGQnYmNDO/bEPbabi5YKC96ENQNzVOfpORrZCR3XRkavQfuz QEgI5g5rnrpcuDELcfcGf5xpXtGq6Nv8G+/irOgQ0KuF4lHwwmhFFj7xc/RODrAhgrb6uaIBPxU
 IXe3IxenbG0WnbyXn2ABv8iN1sQd2PuyKBsV3uchB5uxjdMsqh+77l0zhzPoHOjUCnkJbF+08LI m4Nf7hgubXs+KfvlfiXsrPOQYNdSFfhDFYT99hfFmbRh8znSNcig0w5ExB5P7Cv6zXJtS2xbuyw YqKzXRMUcUdoba+YvzYDcWtn8km7FE9TbUnVQhouL9cxzxyxZp9FGDMgM4TqaSFEtFtvnVWmfT8
 n2vR/tOuKFk7KVj50Jm2YDruCmgv2TzhqNu8Wrr07os0QPRCaJhlriSZrShrXx0BoP0PuOOA
X-Proofpoint-ORIG-GUID: LT_7HPvEshYepE36DoUwg3DtERXaxUYe
X-Authority-Analysis: v=2.4 cv=WsErMcfv c=1 sm=1 tr=0 ts=68232fa6 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=7MsJCCbhr72MGiVMC_UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01

Octeontx2 VF,PF and AF devices communicate using hardware
shared mailbox region where VFs can only to talk to its PFs
and PFs can only talk to AF. AF does the entire resource management
for all PFs and VFs. The shared mbox region is used for synchronous
requests (requests from PF to AF or VF to PF) and async notifications
(notifications from AF to PFs or PF to VFs). Sending a request to AF
from VF involves various stages like
1. VF allocates message in shared region
2. Triggers interrupt to PF
3. PF upon receiving interrupt from VF will copy the message
   from VF<->PF region to PF<->AF region
4. Triggers interrupt to AF
5. AF processes it and writes response in PF<->AF region
6. Triggers interrupt to PF
7. PF copies responses from PF<->AF region to VF<->PF region
8. Triggers interrupt to Vf
9. VF reads response in VF<->PF region

Due to various stages involved, Tracepoints are used in mailbox code for
debugging. Existing tracepoints need some improvements so that maximum
information can be inferred from trace logs during an issue.
This patchset tries to enhance existing tracepoints and also adds
a couple of tracepoints.

Changes for v2:
 Fixed compilation errors of __assign_str()
 Dropped one incorrect patch which was sent by mistake

Thanks,
Sundeep

Subbaraya Sundeep (4):
  octeontx2-af: convert dev_dbg to tracepoint in mbox
  octeontx2-af: Display names for CPT and UP messages
  octeontx2: Add pcifunc also to mailbox tracepoints
  octeontx2: Add new tracepoint otx2_msg_status

 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   | 17 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.c  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  | 62 +++++++++++++++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  4 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 21 +++++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  2 +-
 8 files changed, 91 insertions(+), 20 deletions(-)

-- 
2.7.4


