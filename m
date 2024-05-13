Return-Path: <netdev+bounces-95856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E28C3B04
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EA81F21141
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D906146589;
	Mon, 13 May 2024 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PJEcIMLk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B71CD3D;
	Mon, 13 May 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579206; cv=none; b=RVn5+jkl3gwxr2nWp5SiKfm/MqTM99W+ezvB3FuDLE4aVOy4m+a6IFA2hH9ljbVN0Kum8ynVK3GX++RSlWGlUbzB8i2cT7ZojmvkSD5uneOz+Gh3H18jUkZB7DNzYVbwKmu2M61L7OvXh4K9PoybmmaJGODoGNvKo/nAXkB8A9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579206; c=relaxed/simple;
	bh=Z7koAMJRKFWVgQw9CWiegV7daXUyqibjfDUyA+dL/WA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n54ELi5RIIhgAoNfqmfg2WoicIva5I4A1JDR1/W3g6V6CJKJa82yYU4vSa80WWbd3Z5HIkoUmkFMYv2P5S6XxTHhu7Hb7Pq/PoQHRqpnO8xEOzHyBvoc21sMwVS+1x56O/e5c14lP4Rt8Xu1eKaKCd2WW5YFwMyNShusyC5zwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PJEcIMLk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CMpj1l017412;
	Sun, 12 May 2024 22:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=gAcSZpoW
	GQiEwCuoxDfljbUf7b94Kn1gqvwBZl0IB5Y=; b=PJEcIMLk+erb7VofLPzu2oPA
	jxhfgFmjj8QpvaLMZbey+5gqvFrLbW2dXnaaTn/QNyrfVbntm9WJAig5/yVIzzWR
	Ew204oG9B2u/7GxbXNNLd4Fbncp0588j6Kd7DosHPvm04idI757h4czqbZvu5ZT1
	Kym8ZtMAfRRtiBN+U/bdRlPMlwTfwLya0b5+L/7Y5kPyzQzQYtwvn4zCDOBIhyO8
	YzXAbRryw5E7/4fmAdaK21qyM5Qgd1AhsVrzSUotGrXt2ns3MXrl888o+p1LtM3M
	L15HDCjM1hCR/Mw1QMVsEFlStH7N26b+SFDeAk6/ZSiC/NwhWudtoGWy0x/ARA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y261jucvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:46:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:46:29 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Sun, 12 May 2024 22:46:26 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Mon, 13 May 2024 11:16:15 +0530
Message-ID: <20240513054623.270366-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: M3eMPaYyu4KZeo5BBVlsHrCWkxNyy4mV
X-Proofpoint-ORIG-GUID: M3eMPaYyu4KZeo5BBVlsHrCWkxNyy4mV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

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
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 1066 +++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  258 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |   80 ++
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 12 files changed, 1561 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


