Return-Path: <netdev+bounces-103108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986F9064DB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79641F22F6D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9B139CF2;
	Thu, 13 Jun 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gRu2n4lA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3D7E578;
	Thu, 13 Jun 2024 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263257; cv=none; b=HU2RoE4JfED+viwVw5LxK3eMIGZGQ6o7VCyhv1dw6YTNa1AZth2O7fmHX6G8CVCfrdPlo4pJR6CJ0d0DhkbgvETLafTxqJmPllVuho37mqN+j0sSH0v/292weOMEvhIJ6fhFgwjo3/GnW383XqgUdlxcgeoZBAGMAxL/IFYAD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263257; c=relaxed/simple;
	bh=8qAmcuxVdy9UciUM3TV8S7ygDBN0xQsnDFgY4xwrUIY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtZXatTuqeKJzFZhseb/UZLctS7JU+hU9nYpQMLyl86tD5ycGvzvSZgWSpbUNZ2LdXAjuP1bQrti1lSvETIgW5S2zJq4QWkSNn9JLGBwu78Vyj69vfltGhJXlFybOeHjGTwVNdKNeXv39iJF6hydzwPDST0Vf6jXEHSCrqXsiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gRu2n4lA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D0Anoh019119;
	Thu, 13 Jun 2024 00:20:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=QaJk6KB21ZRtn604FUI/GvT
	E3L8EUAqkcLA3cQUhvQI=; b=gRu2n4lAeeT7n45jxTLaqVs4nGEFJ5h6qB8z6qP
	+VJohhoMKZnWKaEcbsABeF0LnruYfvoM4CdxCmOYAfR1da+WxBsw2Y7cA32EGEYA
	pcB5Wpmp+IOFtClXoupgU5tkiTkcqFMO0GXkgCXovMRVUTF+ZBAUTTZtA3KDSlCL
	+K2TolowTYk+gEig12SyB+3gNnepYPAUcHTD7lP5+k0kqOMqsSPykPpWHQVcHmjN
	wq1UQaFjp0PojJmNoxBw47zfc+UqxH39Ug7awzCgq4Y+x9Ailsj17p86LBSWX9UG
	m3fRRtJIshDBbm3sntD3TkP0PTjhaCnoMD0PVYps2LnVo8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8syw4kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 00:20:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Jun 2024 00:20:01 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 13 Jun 2024 00:19:57 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v5 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Thu, 13 Jun 2024 12:49:47 +0530
Message-ID: <20240613071955.2280099-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8xKc_0FLlZxWJUbAKmjd4gETnux2aE5W
X-Proofpoint-ORIG-GUID: 8xKc_0FLlZxWJUbAKmjd4gETnux2aE5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01

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
  cn10k-ipsec: Initialize crypto hardware for outb inline ipsec
  cn10k-ipsec: Add SA add/delete support for outb inline ipsec
  cn10k-ipsec: Process inline ipsec transmit offload
  cn10k-ipsec: Allow inline ipsec offload for skb with SA
  cn10k-ipsec: Enable outbound inline ipsec offload

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |    4 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   74 +-
 .../ethernet/marvell/octeontx2/nic/Makefile   |    1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1068 +++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  258 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |   99 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 12 files changed, 1575 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


