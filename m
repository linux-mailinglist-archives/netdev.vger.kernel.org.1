Return-Path: <netdev+bounces-168883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEFA41459
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 04:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875C716B3DA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87B19E97C;
	Mon, 24 Feb 2025 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="B7WggNNN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19212F37;
	Mon, 24 Feb 2025 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740369393; cv=none; b=Zwd1O9CSnZ8CxXD3Y2/pIxbN3Wqb9Gu6svxJxW/ijHwYAACx5N2usJxC36ga7+ddX8gI9lc5iK613xbv43RCo+K8tTZpvCbjoxDQmXSca08OgkfEf0Gm4sUrI4xmOvhSkl/qyp5k6+alzWI45h8KElntSNm2nLqzMh1RW3wxEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740369393; c=relaxed/simple;
	bh=ZrrQ99Vyl/imGW9oIU17Kg2bfSqIyf0dcSZrlT3KtyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B9QJEUkKUDA322xVAciXARkMwbZr3BRy1MSiMLddlxtPSjiuDMXQrzC6nWXNB+2xmW/EGwuCPSQ+0rCJn3GtZIMtC3IOjkWh8kKp/EuWnG/IH3l36a7RP+XaMJuCcb6A/zXEDUd6FcuEZB8GYP8pdsaxSvxIUi3OmmDp4v+fzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=B7WggNNN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O0xAie024648;
	Sun, 23 Feb 2025 19:56:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=P2suAZguiIOX2XVuwMAyT/U
	jhnCDHVAZBb35/FSP19Q=; b=B7WggNNNIMyVxfyZ40MnueiTBHm19bfxiDxgOwS
	F+Pu2MWmu2hJkBGFR2592kyFaDeNO1GwMfwaIrfNNlfxVgEUStZxGYLAc3fM9R/K
	ZPcttQRNCVWBjRFEbaVCmhjrBMJHxjv4yI4SjiiIiCCSBeOfJGnARMHWSYPzht3S
	nyDuSfhu/Gkb4LHC2Y9HGAwpJo02nQ9fX2GqGKkpGFYOFoDIwh3uGMuoW1bEbZD6
	3CE0DdEI81RImDAPeQ8idLXGgUZcr9S6EtgiXNBc/M4HwT8QS51fd+amimwHgU2k
	d6lmWu03lXSzunYG+G+vay/Bb6oGlIJOu89hTSTRi/KNgQw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbs32u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 19:56:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 23 Feb 2025 19:56:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 23 Feb 2025 19:56:08 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 95F483F7068;
	Sun, 23 Feb 2025 19:56:04 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net-next] Octeontx2-af: RPM: Register driver with PCI subsys IDs
Date: Mon, 24 Feb 2025 09:26:03 +0530
Message-ID: <20250224035603.1220913-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ipWuP4qWKcLSoxhqpJ5jbPR9PMcTDRPZ
X-Proofpoint-ORIG-GUID: ipWuP4qWKcLSoxhqpJ5jbPR9PMcTDRPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_01,2025-02-20_02,2024-11-22_01

Although the PCI device ID and Vendor ID for the RPM (MAC) block
have remained the same across Octeon CN10K and the next-generation
CN20K silicon, Hardware architecture has changed (NIX mapped RPMs
and RFOE Mapped RPMs).

Add PCI Subsystem IDs to the device table to ensure that this driver
can be probed from NIX mapped RPM devices only.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 14 ++++++++++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 8216f843a7cd..0b27a695008b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -66,8 +66,18 @@ static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool en);
 /* Supported devices */
 static const struct pci_device_id cgx_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN10K_A) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF10K_A) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10K_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF10K_B) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN10K_B) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CN20KA) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_RPM,
+	  PCI_ANY_ID, PCI_SUBSYS_DEVID_CNF20KA) },
 	{ 0, }  /* end of table */
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a383b5ef5b2d..60f085b00a8c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -30,6 +30,8 @@
 #define PCI_SUBSYS_DEVID_CNF10K_A	       0xBA00
 #define PCI_SUBSYS_DEVID_CNF10K_B              0xBC00
 #define PCI_SUBSYS_DEVID_CN10K_B               0xBD00
+#define PCI_SUBSYS_DEVID_CN20KA                0xC220
+#define PCI_SUBSYS_DEVID_CNF20KA               0xC320
 
 /* PCI BAR nos */
 #define	PCI_AF_REG_BAR_NUM			0
-- 
2.43.0


