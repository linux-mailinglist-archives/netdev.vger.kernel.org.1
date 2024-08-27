Return-Path: <netdev+bounces-122342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A9960C11
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5863C2883EF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647361A0AFF;
	Tue, 27 Aug 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BcsTymwb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6821BDA8B;
	Tue, 27 Aug 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765554; cv=none; b=U6cL4r4EvsB+lTJIpiUVVQ+ywwN1D5my7gSuzIjUbpusO3CM8rk5DtUVku7vkP2IHWABkDn6rn6vpIR97YO2sKTBcHBFTiAFdsfLcS5zEfsrK/Lx9YpwRQPiXhLrs9hy5GuRd1PTOwHQnl03xxY7KQA1XhvjfvpyQ75/laI/ClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765554; c=relaxed/simple;
	bh=tuaVSYBrT5XDLd3csl2aL29HQvobJAbpusk4BQCpue0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4kNxdXJDWpQwRA3NbVBBQjV8upvtLvzSHlE0xW6Yf1eIdw7Y3Na3hWugBG1YekNtXjh7IbfMyV2uKBl3LlEltimzFJTmG6xH8c3VqWjXsN2Eltg74SaVvI8hzVVem1/xY4JP9CrBNMWNBcmuMQPVonDB7UIP7ssTGaznu+Mocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BcsTymwb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9SQKB008588;
	Tue, 27 Aug 2024 06:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5wQNYZ45BUqdnRfturDFDkh
	JN2SPydSDS0JqAm4qryE=; b=BcsTymwbf/ctKX/bqd/EyhnnmbjdjoBJYiRrfkO
	NkiawV0gEFVpR41qpegpTi0fqJZkMaB+CHsABRBKSZ0jMEcWbz785/Ueb84ztBTs
	DBIGxPOMj5Zra4ywxL0Af2g3YUHRslrQyjbl56HSkV1INOIDgbSe7GR9JH8uAyA3
	1x3ZeKJj9Tz+2jQvuZ8wjKZb7TQju4lAYMNSvG4V6iHYl76aVCqXxa0lgvm9mG2I
	TNZzOEK+6eVv8T2dDODMfhQvmhsCN00MgrPmlTfUFUBc6LhYA1twk6jd9JzsSr6d
	qXMnq2Leiyu4b8R28cjQngwv4jewX1CvMrbCyR5MoyPlVqg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grr9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:17 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id CA2045C68E4;
	Tue, 27 Aug 2024 06:32:12 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Tue, 27 Aug 2024 19:02:02 +0530
Message-ID: <20240827133210.1418411-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EuqLqxYU-XSE7OaUmWf83xFS-KsSBPMv
X-Proofpoint-GUID: EuqLqxYU-XSE7OaUmWf83xFS-KsSBPMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

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

v6->v7:
 - skb data was mapped as device writeable but it was not ensured
   that skb is writeable. This version calls skb_unshare() to make
   skb data writeable (Thanks Jakub Kicinski for pointing out).

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
 .../marvell/octeontx2/nic/otx2_common.c       |  113 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 13 files changed, 1619 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


