Return-Path: <netdev+bounces-189663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EBAB31EA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA41189AD4E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25F25A2BE;
	Mon, 12 May 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G446zpuL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B125A2AB
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039356; cv=none; b=XXMK384hkJl6TyHzXzNynWzqrVpB2wxJNugRjvWQrEg/4sNu+lZjB44K/Pk5Y3ksj9JhVChqlfAlIkamX7eGobTRoUTJ943W5YSSjKX3iEOEVC7X5sSrs01SYsTvk0mrIZCATMlVKhMk6OZvrPK+RiC5Mjpj7l4Gev6UiQfX0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039356; c=relaxed/simple;
	bh=qG7Av4QQTtIan/AaNdNZAIPEV0X0jAdxaGfElMPjV3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l7PiThJ6wlRFndbRsc8Gh7a1raFwLZWQ6XdDQgXy4MME8PW7Wtj7AnlvW9p5H891GJO7Iu/77dLjosGOLwxrO0q0xvc45F77SBBpsV+liwFVcDQNQMs2/H9TAdIasnq3He5CWRE6W8JqMQNp0ACJD2FtuuCQTVbYWxAaAYFOjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G446zpuL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0TOQn017627;
	Mon, 12 May 2025 01:42:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=UfdJ4Wve0PlPILoQT4gaN6B+5tBT9a3UbMWMSjPVcyQ=; b=G44
	6zpuLxAQGuoMNCg385G5Ax8cy1qpeDspeXVz/S/NXkK2Ji1XoNstQjBciFb8jShA
	6/ks1borDPuK69/nd13D6yQiLLCvsX+pwFqMf/hC7bPZZNi8dKVH+Nu96ZRFyeYl
	V18p9Ax1GFvMgqkXTnlo7YnvavSBcwZBZxvivwI7Y6JCW7BkIwqqv5+dPWbyu3DH
	X6z6mSdqn3Hu+R08mr//Ha+vqXI/bQeJighRMjftNYag7Rd9gkWT/MCsszJb2+vc
	/Is+M2OzuvvEF+xJQ2gGmYWM+hVwzMWXlDHGr1BRB1T7h1jqSwgyARSZxo72qZOZ
	Vso7kBoWzlbGe2gtf3g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5trrnrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 01:42:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 01:42:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 01:42:08 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 8571D3F7097;
	Mon, 12 May 2025 01:42:02 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 0/4] octeontx2: Improve mailbox tracing
Date: Mon, 12 May 2025 14:11:50 +0530
Message-ID: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=6821b465 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=rHoA_-v4lEPsYuQfVaMA:9
X-Proofpoint-GUID: VqMY6BrABRcJFIgtyjhm5cpHxrQq0yKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5MSBTYWx0ZWRfX50/hhugqS5KA yGPDCrMfsDgpP4rMdNk7Ciy838aXYn+1KHWqHNtCpYhtKhWTTD3QHULBPtoolkVM0Z6iVAMF71F SzHkWevZY2DAQ3bXta8eWYptbfAQBqnJF/7EXg5RSCIEHT86iUO8Rca9j+oKrFuJncjlHssC7J6
 HkPlHqz26PYaBRyi/THtvO2dySEIAzeDpOpnskx85PvNtlL8eGetlUCQV/UZm5vdZA2JjlQK3tj wOTK3BD9EpT3dWvJh7XmSCwCjKJzUTDpwr9Q6PGKzbIfbaOEyN4kN3unNyc0sKI0A3/To9r0FCg 4hXZbZjw7/jebhJ/7w31PPl8bGbXbpjI/zcttR75EfjQsApoc5aeZMZ/MJy9frhNDHromecEMQX
 Woe4ocSvHYoZNYVjQg6nUFv7sBftkUokIr0CdCFn0eKJHWE6ANQa3W0mMQZslD0zIZhEcV+E
X-Proofpoint-ORIG-GUID: VqMY6BrABRcJFIgtyjhm5cpHxrQq0yKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01

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


