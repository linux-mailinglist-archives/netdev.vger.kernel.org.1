Return-Path: <netdev+bounces-150993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C79EC4B5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910F018875D7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F21C1F2F;
	Wed, 11 Dec 2024 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B3u8YTuk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BD2451C0;
	Wed, 11 Dec 2024 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898282; cv=none; b=kM2TcVGwpn0Zo9kSQCtZ1SZ3V4pF8gjmwBtUp+4FK0fQJe29rasvDIfiEXeQERM8e2lCgRiEIyT+ZzMEN7UJAEOZZGqIJHrnQeQ7JKw7DB6FFBe97Z5SWIforyCIgXQtRRYpbqo6hSWn0BPyKmJIVgodh9hJNQKi1ICjOpiTSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898282; c=relaxed/simple;
	bh=nv4XefQTe1dFzpfb4j2X/y6wb4VxbLNIsZWdQa2sWHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7Bo8eLV/PlqqXYRz3QNzCKDes/vrZIxzkcBuUMqgXmSeDpPtMEZJLm1Q/hC28AKRObWAdqodXFAuc8Zz6DyDdflT9VpBCQqULd1I2tLgt5pxALKAKQIwngZnSjYGg42RmCcGcuQWcPpUWOykuZHEWgs70Vi2pm7FcTKihg3eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B3u8YTuk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANtmxa028631;
	Tue, 10 Dec 2024 22:24:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=E/aQuxosOoaXJrhrjZ6OwkL
	ichZ7znZ+m2fdN7g/axQ=; b=B3u8YTukpMjRbTE3AHT/7AKwyLAXGU/thghd6UD
	iXRoYRe6MXXv3rMMvqfkzxwzg/U5H7unvgbb4xUx2lI3L6Id93oaWPob9bboN3BR
	mw476Omwvdeeb/SCXD4cumXT1Sf6c38+HxeaSFfnUyqiI07VJxIwHx9mUBBbG+xk
	AyadAs/jvO+PIHFQmVYbYFwRBgRVMGnuB97IkFoSns1SJXYOZhKADFRs1yaDnzFV
	RGQ78IVpYlk2ctr3RWm2YLNj/+ytouluiB9A9WXP30R1qUh0nFXQD6dPf71YsViz
	HWvAVcoJ8J333uAr3hkPb36arAr+Z+YNxT2VJebCPaWygog==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43eyqh0pu7-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:24:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Dec 2024 22:24:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Dec 2024 22:24:28 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id A37633F7090;
	Tue, 10 Dec 2024 22:24:24 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <bbhushan2@marvell.com>
CC: kernel test robot <lkp@intel.com>
Subject: [net-next PATCH] cn10k-ipsec: Fix compilation error when CONFIG_XFRM_OFFLOAD disabled
Date: Wed, 11 Dec 2024 11:54:19 +0530
Message-ID: <20241211062419.2587111-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J489MHfhrq8fAOGGUuQJieJA4r_pXKhe
X-Proofpoint-ORIG-GUID: J489MHfhrq8fAOGGUuQJieJA4r_pXKhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Define static branch variable "cn10k_ipsec_sa_enabled"
in "otx2_txrx.c". This fixes below compilation error
when CONFIG_XFRM_OFFLOAD is disabled.

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x8): undefined reference to `cn10k_ipsec_sa_enabled'
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x18): undefined reference to `cn10k_ipsec_sa_enabled'
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x28): undefined reference to `cn10k_ipsec_sa_enabled'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412110505.ZKDzGRMv-lkp@intel.com/
Fixes: 6a77a158848a ("cn10k-ipsec: Process outbound ipsec crypto offload")
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 2 --
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index c333e04daad3..09a5b5268205 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -14,8 +14,6 @@
 #include "otx2_struct.h"
 #include "cn10k_ipsec.h"
 
-DEFINE_STATIC_KEY_FALSE(cn10k_ipsec_sa_enabled);
-
 static bool is_dev_support_ipsec_offload(struct pci_dev *pdev)
 {
 	return is_dev_cn10ka_b0(pdev) || is_dev_cn10kb(pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 4e0133d1d892..224cef938927 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -27,6 +27,8 @@
  */
 #define PTP_SYNC_SEC_OFFSET	34
 
+DEFINE_STATIC_KEY_FALSE(cn10k_ipsec_sa_enabled);
+
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
-- 
2.34.1


