Return-Path: <netdev+bounces-143195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A29C9C15C8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127FB1F2406F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616191CFEC0;
	Fri,  8 Nov 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gO5wbtnq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF413D278;
	Fri,  8 Nov 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041867; cv=none; b=QpcC6G8n+XS745ua86oaolMgVL7UL+kb4nJKYeJRIB2dhob6gppnV3M4Ycq2SnHdDRL3C/xXqx2JMyJlhuJWynlD3l5pyCgjf9igLT61/L1DSbHrYlyRqMO0iasN9cvPpTfHNxBsuyhtJ78GJXW3fpeHLA2Q6ghR6OnpC4ZlcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041867; c=relaxed/simple;
	bh=Hg22fkQelKa3qpC1mGlStPefCWQKFNdOFVRnTNGoWAc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BatqorkylQ2+WerWEw/alpRAwj9yrPpK5LFNSlKQoKKZVFmupH/Oc9H/IZgDECfpOPsZAEk/ldOUjZoXZQdgYVBoUtNa1SFoTbcn9B9EVgGqaDhqKxPQDbkIUkKNdhbGFuwt0w7ENRNpAbQS2wD67m/x2lt+9XQYqCQuRX/qePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gO5wbtnq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81ghci019269;
	Thu, 7 Nov 2024 20:57:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bNYaP0x+p+WSCHBkbkZxjPH
	OFpJk7SrK7FLkH1p3CV8=; b=gO5wbtnqMsrVn/KJ8RIOsrzW72W9CTes+I7u5G1
	ObMvLNM0+UNP+0Pr3l8WjunsEXNKtSWY1MgJOVDjgt+jLfNjybLWUEVUsqoVl9Ah
	ctgsQi+YYKyRI/2VPkBt9lkPYTlaGatdXsDy/rP7wQFUBCw9f2lkrVnpQBo733uc
	zFqaHzKqokfObzWbPQd0GxFOUMNXY1d5oUr0UeEZSmO6AByZFqnXdkEOv6AwbO99
	hBMiC/pIVy9HlrvwaTnKlJjKSM4R1BXRJUabwFn1JR3Q2pDYnrbhW2OnUR3zUoMw
	70SAjqWfXUCVNtNswh6H3O9hLfV/ESspBe/tpsnM3spdHew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42s97hra0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:32 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:15 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 7036C3F7044;
	Thu,  7 Nov 2024 20:57:11 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Fri, 8 Nov 2024 10:27:00 +0530
Message-ID: <20241108045708.1205994-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9HhpoPWSHAEq19MTPs_36gpFimLLpBc3
X-Proofpoint-GUID: 9HhpoPWSHAEq19MTPs_36gpFimLLpBc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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

v8->v9:
 - Removed mutex lock to use hardware, now using hardware state
 - Previous versions were supporting only 64 SAs and a bitmap was
   used for same. That limitation is removed from this version.
 - Replaced netdev_err with NL_SET_ERR_MSG_MOD in state add flow
   as per comment in previous version 

v7->v8:
 - spell correction in patch 1/8 (s/sdk/skb)

v6->v7:
 - skb data was mapped as device writeable but it was not ensured
   that skb is writeable. This version calls skb_unshare() to make
   skb data writeable (Thanks Jakub Kicinski for pointing out).

v4->v5:
 - Fixed un-initialized warning and pointer check
   (comment from Kalesh Anakkur Purayil)

v3->v4:
 - Few error messages in data-path removed and some moved
   under netif_msg_tx_err().
 - Added check for crypto offload (XFRM_DEV_OFFLOAD_CRYPTO)
   Thanks "Leon Romanovsky" for pointing out
 - Fixed codespell error as per comment from Simon Horman
 - Added some other cleanup comment from Kalesh Anakkur Purayil

v2->v3:
 - Fix smatch and sparse errors (Comment from Simon Horman)
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
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1057 +++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  262 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |  113 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 13 files changed, 1577 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


