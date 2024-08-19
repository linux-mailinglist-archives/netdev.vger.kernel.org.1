Return-Path: <netdev+bounces-119701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA8956ABA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A005C1F225B5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144A16B38B;
	Mon, 19 Aug 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HYu/ztXR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84413DBA0;
	Mon, 19 Aug 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070260; cv=none; b=Mlvxra2pBog8K7wiLndDgxdJfXPOiBbdo+nwRrVhDt9ytUbJ3jgT5P3w9a7U4UAXKjJND7+FIAQt+1zY6a7rileWYD5c3Y8KnW2lL7iFj/di7Ai9I+eoMcM3/h7xJ+2JtxVAarheaWnd3fPkNRGc2A7qbBzZKB7EuqkyV+c8Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070260; c=relaxed/simple;
	bh=865qNQsXKeXyQpqbYLqTf/FyQ26bYdPdF0mwQJOBbhs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GuqSSZTt4nvMDPvkJm/fAgKhcJTJrAif+ndyOIibOpFm+O80q49aACQWeol4nEZ2lkGZNHX6T+5nV8KMPXCYKQRHBycsjf1/A1mKRVJxbuKgt0YXCA/Swt37nnQydssyuVGoX3exfVxuRMSjOL8VXKYp7+HLOJVgRGJmyTIYRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HYu/ztXR reason="signature verification failed"; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J9QxAg004262;
	Mon, 19 Aug 2024 05:23:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=kh+d42vFcvI4AKZ94GXODsg
	tyaSSq+ZFR7aI2ux/4ys=; b=HYu/ztXRQZrUiVvxGVF3MCPJd0+z8759hjSrmVX
	b7Vq1kPue/jgboiTwkla1Rx+aDkmLkSd0zUW4U0ht4b9zIn6zBcZIuN077mOiutE
	yI3IcxYbO6hC1VJOH1VoMF7DcTiD4W6+NBp2Ad/A/aSjDoty6oayuueEZJmK5LTY
	xCZRpm2mbnOLj0Liy3GZBZYpfUCoqWIfn3pS2PdH5wTJspMAm5xl42Zz59mv++P5
	AImVmspEvgjpimOolTB6DMA3ZhExmew6bd6gp6cYQXy+9A/kO1AkmbWy4kQkvINp
	qOkQ9YUwGq9kdeONq/x4CbWZ6VllB/3jWV+hQE9pR/q++Fw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4143e80fxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:23:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 Aug 2024 05:23:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 05:23:55 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 1AB673F70A9;
	Mon, 19 Aug 2024 05:23:50 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, b@mx0a-0016f401.pphosted.com
Subject: [net-next,v6 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Mon, 19 Aug 2024 17:53:40 +0530
Message-ID: <20240819122348.490445-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bE6kLMNCOz_h_fUMqNCyHqBZ4KzJVSpw
X-Proofpoint-GUID: bE6kLMNCOz_h_fUMqNCyHqBZ4KzJVSpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01

This patch series adds outbound inline ipsec support on Marvell
cn10k series of platform. One crypto hardware logical function
(cpt-lf) per netdev is required for inline ipsec outbound
functionality. Software prepare and submit crypto hardware
(CPT) instruction for outbound inline ipsec crypto mode offload.
The CPT instruction have details for encryption and authentication
Crypto hardware encrypt, authenticate and provide the ESP packet
to network hardware logic to transmit ipsec packet.

First patch makes dma memory writable for in-place encryption,
Second patch moves code to common file, Third patch disable
backpressure on crypto (CPT) and network (NIX) hardware.
Patch four onwards enables inline outbound ipsec.

v4->v5:
 - Fixed un-initialized warning and pointer check
   (comment from Kalesh Anakkur Purayil)

v3->v4:
 - Few error messages in datapath removed and some moved
   under netif_msg_tx_err().
 - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
   Thanks "Leon Romanovsky" for pointing out
 - Fixed codespell error as per comment from Simon Horman
 - Added some other cleanup comment from Kalesh Anakkur Purayil

v2->v3:
 - Fix smatch and sparse erros (Comment from Simon Horman)
 - Fix build error with W=1 (Comment from Simon Horman)
   https://patchwork.kernel.org/project/netdevbpf/patch/20240513105446.297451-6-bbhushan2@marvell.com/
 - Some other minor cleanup as per comment
   https://www.spinics.net/lists/netdev/msg997197.html

v1->v2:
 - Fix compilation error to build driver a module
 - Use dma_wmb() instead of architecture specific barrier
 - Fix couple of other compilation warnings

Bharat Bhushan (8):
  octeontx2-pf: map skb data as device writeable
  octeontx2-pf: Move skb fragment map/unmap to common code
  octeontx2-af: Disable backpressure between CPT and NIX
  cn10k-ipsec: Init hardware for outbound ipsec crypto offload
  cn10k-ipsec: Add SA add/del support for outb ipsec crypto offload
  cn10k-ipsec: Process outbound ipsec crypto offload
  cn10k-ipsec: Allow ipsec crypto offload for skb with SA
  cn10k-ipsec: Enable outbound ipsec crypto offload

 MAINTAINERS                                   |    1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |    4 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   68 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |    1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1095 +++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  266 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |   99 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 13 files changed, 1605 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


