Return-Path: <netdev+bounces-95994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7418C3F55
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC785286687
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E514B076;
	Mon, 13 May 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gxBbHHgn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FE14AD20;
	Mon, 13 May 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597703; cv=none; b=BOLQc4Omj3tUf0grltVpbw2WOixzJiuuxo7jEW3LCBnAxYmR+niI4vgF9pewdCWVPHGf9w+N/+aoiei3MLfGIz6iIh/ye9Vb3fH88PoOxtk9rRPI/0HyZLYqtXy1tkuEK5A1V/sS7Ky/n0GiUXBDsfM7zKHQauEtho3VF0BufkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597703; c=relaxed/simple;
	bh=thF6Bu5lw1Ni0wdDW9EmH4G66io0lf8Sw13DvPTDHQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSO6SiAS7QUZXEHCkBv3OIY+atDrzHkq9rj9g8FSgZA+UyBTPv6HF5XcNpkGTzVJkjWNXFF7puIGKduW05aJG/4yxhRtacdANxQvx5hRirMamqhex39y9VqOC73MWZ9Jk8rcLuOiZeeP/Yfspc7l87E5AzGYT7cfUnmtBLSbtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gxBbHHgn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8XAGs002218;
	Mon, 13 May 2024 03:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=4o7cOJEs
	m/Xm8K85sznSwQR6JzlXO9Jcd/0B/N7K1U0=; b=gxBbHHgnCuNLsdQOKhe0FY8f
	WXfkQJrAx3YwJAsYHVFmS1/uPcF6+7xC+5qDoj2R9LKrrent8kvm8xf/FATFtcJJ
	TYnzKVPXyimwewd78tPqQFCTjt8DrsbQOvdpBU3dQ7cNWqAFSrISeU7knctTd1ge
	ZjjDaQFcgqj1bUFmmWjkwleYRKjIDdL2B220w6G0MnbBIqqGlbuRjBhlddHUj5xJ
	v8rB6yHforbSgMcsh8NX1AKHk6CCcz8kYkQEKtcu+iz+GFXfuoqEUqJXti1OnYdX
	CLLirSE8S/PTu+wNIl7U/jg2JR8Bgm9cOCEoV9iRRJoMvkiCBWkKcMLl0T+5Lw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jbyak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:54:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 May 2024 03:54:54 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 13 May 2024 03:54:49 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [net-next,v2 0/8] cn10k-ipsec: Add outbound inline ipsec support
Date: Mon, 13 May 2024 16:24:38 +0530
Message-ID: <20240513105446.297451-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Fx744JlOJKgOhr9IgXjE3mavcTqdpa5a
X-Proofpoint-ORIG-GUID: Fx744JlOJKgOhr9IgXjE3mavcTqdpa5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02

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
 .../marvell/octeontx2/nic/otx2_common.c       |   80 ++
 .../marvell/octeontx2/nic/otx2_common.h       |   25 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   19 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         |   65 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |    3 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   10 +-
 12 files changed, 1563 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

-- 
2.34.1


