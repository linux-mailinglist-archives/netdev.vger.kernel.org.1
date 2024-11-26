Return-Path: <netdev+bounces-147396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450A9D9669
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D77A168060
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA019340B;
	Tue, 26 Nov 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Td63hUcm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553885270;
	Tue, 26 Nov 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621506; cv=none; b=SUQ1aDED9yXnWNIRqU7c0cusUpVT0Y8orKkXfyW3qnucEWfz9+xxl5QGen7EPxbp8blMNqaEP27gZzgELw0CBDlYPDNwOEwVJBr5msYA4I8kkCz35ou6nd6X+TRpFxwsEh5HKPh6K6Zypq6q3j4YHttT5kk/MTDHULS19RHOOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621506; c=relaxed/simple;
	bh=BDL0kx7PzHXzvQnsN1T2DC10rEHN3JVEUyJwA12CFJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uu69Gj295gwKGvmVO9GkhtxEsLpFkbb0THMqR/K5k985hAkmrxEEkj/7UXHApnHNdBh6WxnmXupw2nedUUzabvLJvIP+Z517Gdy1Td+dfUlyZ0MKSnwratgHUQYKga6z1d4830AA0UwtBKnPFhHIRq824Q4QB8JIiYIeAP/YPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Td63hUcm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ7stkI003545;
	Tue, 26 Nov 2024 03:44:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=hCDBHPfCP5eXMKguBWJMBfOBMRHU8HYJ61gZpyQBtEQ=; b=Td6
	3hUcmNZfGRK3u0zXdTKM8UJk6VBkHa4Pov4iixxsi0GLvgR5mw03XJy5Lm5iyOhe
	mpHf+p4itjWKZtMsJsBGmqBATORM1sH7oKLTSusyLNEYxgjL7mk58TyE6kzqdnzE
	UY4ZAt2prbNVB8r+F8HCDYBWlSCDz/z5kqqfBueXhu+LVcRqioy6ibzDyMdPWJ7Y
	S1OWLtWQ6WDvnhLZ/8juwN8Ib73eoIkN1/+Yxhst8q4HyrWAu+oyH0kk1lRRs4P7
	qYPR/S2WgC3v5019cq5J34hKfe+acbx4y6IS7gPutWMuhNrKrdMC8rqCKOUZSkCy
	Q+7lSnvcvdpcKIOqmdQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 435abwgexw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 03:44:42 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 26 Nov 2024 03:44:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 26 Nov 2024 03:44:36 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8C1793F704B;
	Tue, 26 Nov 2024 03:44:32 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <horms@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix SDP MAC link credits configuration
Date: Tue, 26 Nov 2024 17:14:31 +0530
Message-ID: <20241126114431.3639-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LuXhU4yYERAO3E79v2Ad1K_eX2Nmfmsd
X-Proofpoint-GUID: LuXhU4yYERAO3E79v2Ad1K_eX2Nmfmsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Current driver allows only packet size < 512B as SDP_LINK_CREDIT
register is set to default value. 
This patch fixes this issue by configure the register with 
maximum HW supported value to allow packet size > 512B.

Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/common.h  | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 5d84386ed22d..406c59100a35 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -159,6 +159,7 @@ enum nix_scheduler {
 #define	SDP_HW_MIN_FRS			16
 #define CN10K_LMAC_LINK_MAX_FRS		16380 /* 16k - FCS */
 #define CN10K_LBK_LINK_MAX_FRS		65535 /* 64k */
+#define SDP_LINK_CREDIT			0x320202
 
 /* NIX RX action operation*/
 #define NIX_RX_ACTIONOP_DROP		(0x0ull)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 5d5a01dbbca1..a5d1e2bddd58 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4672,6 +4672,9 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 	rvu_get_lbk_link_max_frs(rvu, &lbk_max_frs);
 	rvu_get_lmac_link_max_frs(rvu, &lmac_max_frs);
 
+	/* Set SDP link credit */
+	rvu_write64(rvu, blkaddr, NIX_AF_SDP_LINK_CREDIT, SDP_LINK_CREDIT);
+
 	/* Set default min/max packet lengths allowed on NIX Rx links.
 	 *
 	 * With HW reset minlen value of 60byte, HW will treat ARP pkts
-- 
2.25.1


