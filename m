Return-Path: <netdev+bounces-48641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFB7EF0BB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B453281182
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A807125C7;
	Fri, 17 Nov 2023 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CSamzhVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED0127;
	Fri, 17 Nov 2023 02:40:39 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH5Yu7S028673;
	Fri, 17 Nov 2023 02:40:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2uIlioN1bFST8jawAO6YLw204IOztiIPTnPD9NbgGbU=;
 b=CSamzhVQH4rrYqXlTY2mWd3f3c/vH1Kn5kG8USM4fROCxNApyThCSrhNR8J4bngx1xTt
 /znyB18IEbwZn425D371wsA2i66Tusac/wWjUcj1otpOAPv2FrpidFNKRUr34epf4CgD
 YuJ7VPh+BhAkg1BtCoZRlgbE2tvCIhbHmxniO+gbhRSBIN9dkwJYzhpYr3osCBql8UXE
 U/qBZmSasubUKCqPcCz5xuajE9Hr+KtT9EloE3YUxOH6yeoq7iKB0CPbojD2bc2/Qb2Z
 TvUSXYHLgs6dfvsi/VB3xEXOHezpJKBnFHkeKRBsyOpjuHzPmKJrX9T4marMhHdRw6T8 iA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3udvh5hsm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 02:40:27 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 17 Nov
 2023 02:40:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 17 Nov 2023 02:40:25 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id D10F33F7086;
	Fri, 17 Nov 2023 02:40:21 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2] octeontx2-pf: Fix memory leak during interface down
Date: Fri, 17 Nov 2023 16:10:18 +0530
Message-ID: <20231117104018.3435212-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PgDUBc2lFmwXsOkEXOWDvtjufiqNpFBx
X-Proofpoint-ORIG-GUID: PgDUBc2lFmwXsOkEXOWDvtjufiqNpFBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_09,2023-11-16_01,2023-05-22_02

During 'ifconfig <netdev> down' one RSS memory was not getting freed.
This patch fixes the same.

Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
v2 changes:
- Updated fixes tag

 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 91b99fd70361..ba95ac913274 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1934,6 +1934,8 @@ int otx2_stop(struct net_device *netdev)
 	/* Clear RSS enable flag */
 	rss = &pf->hw.rss_info;
 	rss->enable = false;
+	if (!netif_is_rxfh_configured(netdev))
+		kfree(rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
 
 	/* Cleanup Queue IRQ */
 	vec = pci_irq_vector(pf->pdev,
-- 
2.25.1


