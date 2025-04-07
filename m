Return-Path: <netdev+bounces-179521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49EA7D4EC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B6A3B09E9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA0225408;
	Mon,  7 Apr 2025 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="T/EQHLxD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEC218ADC;
	Mon,  7 Apr 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009454; cv=none; b=U3zcQ3H7O9jj4BCirLR4Wxo46P0CwxsbiDQHyxOpr/i1/aW8uqbw86VVaJkKnhlkejc4zLeuhHAYGyUM2+UniHxY7ukBnLBKmLH5P3o/GyqzXyKkN1IP6gZRsdimQ3iPcnO8FPN2eHUlBySLz/zp9It5kpG/UhFlBM6yqKh/BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009454; c=relaxed/simple;
	bh=63hCsI7D4OsJ+8xqEVbujyRPsdm/RcjkVGWNADKmzJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+icdGjf74ZiBqtPePIB8TnnKrjvB/xLs4ywzKN6eQCkTKdlH6mChT8n/DS46KAVFQf8ERe1kG41JEDtQsLwuz/CSGbspevD5O64o5z3EdWVLWrXraXunHOYVgODIB9Lc6h29mMNDk3JCR9Cg93LdzdiWENbYHs1z7Bsnp6jBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=T/EQHLxD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372oDsE001707;
	Mon, 7 Apr 2025 00:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=i/2qzHRAmu7K3gRU9dmtnPl
	/DCrifDSer7QneKYGT/Q=; b=T/EQHLxDZTHFE988VGOuEZjJPjXdZTOdEACmG9j
	Tr1XAmyFyJt/jL4ME4/GQrXKR7rjUaGVu/wWa+Nr1mUZMNbyjB5RY++15Ltnu19H
	7bovwEuQYC8wy8BSAvNwb19jdi2sa/QuoEfa1wZqq6nmrNT/ZJOOjmtK24GOpIL5
	P60Ey+jPCJVq9R+4naWYMftaf1/qvRED+W6fIoxfD8ooqFT3SQk5+6g1J3dM6c29
	3C1rzBkDjKeB473iMTKlSZSPKWj6kYQ6QDX4eijKjYvqrBYnx7Pc2F5Ocbo/L1Hd
	r+YCCfAeFtBku4fEMe/mhMIR/UdRiHoR3DAjaasaA48rThg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un99shtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 00:04:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 00:03:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Apr 2025 00:03:58 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 089155E689E;
	Mon,  7 Apr 2025 00:03:54 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [net PATCH] octeontx2-pf: qos: fix VF root node parent queue index
Date: Mon, 7 Apr 2025 12:33:41 +0530
Message-ID: <20250407070341.2765426-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f378e0 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=RI5rwOQ5OLZ3BBTcUwgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5dnN9VO_owPMUbQB8nmQR9P-obmrIhhF
X-Proofpoint-ORIG-GUID: 5dnN9VO_owPMUbQB8nmQR9P-obmrIhhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01

The current code configures the Physical Function (PF) root node at TL1
and the Virtual Function (VF) root node at TL2.

This ensure at any given point of time PF traffic gets more priority.

                    PF root node
                      TL1
                     /  \
                    TL2  TL2 VF root node
                    /     \
                   TL3    TL3
                   /       \
                  TL4      TL4
                  /         \
                 SMQ        SMQ

Due to a bug in the current code, the TL2 parent queue index on the
VF interface is not being configured, leading to 'SMQ Flush' errors

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 0f844c14485a..35acc07bd964 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -165,6 +165,11 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL2) {
+		/* configure parent txschq */
+		cfg->reg[num_regs] = NIX_AF_TL2X_PARENT(node->schq);
+		cfg->regval[num_regs] = (u64)hw->tx_link << 16;
+		num_regs++;
+
 		/* configure link cfg */
 		if (level == pfvf->qos.link_cfg_lvl) {
 			cfg->reg[num_regs] = NIX_AF_TL3_TL2X_LINKX_CFG(node->schq, hw->tx_link);
-- 
2.34.1


