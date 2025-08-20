Return-Path: <netdev+bounces-215152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63BB2D438
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5E622CBB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588E188906;
	Wed, 20 Aug 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kATAWw3H"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CB256D;
	Wed, 20 Aug 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672410; cv=none; b=jXijLIwTQw+NtQL6c9qO34zMHL7aNeS0TthAS7lNTKcD1I0RPqDGIUvCDMK6ht+43vOt2h4zz01LjA5EjAZ39zeAAC51c3YgDz3gX3zzWMlkTZm4ZQdwR2a3Z2c+PkWQTsZXCAAjTg7gRSAWdC5EtlJyybra0R7zDnVplS6MXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672410; c=relaxed/simple;
	bh=ldNndaQoO/UHByOrYRw96gyaFlCZhoYjJ+xlgbyY9tk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AIXcmL0toSbtSZ7DNPGGVmjMioIRxEunBl/JszfA8WpHm9vHTPDDxzfP1S9SF2JBByvnzV3rJNZ1jkQ7Bo1g88t+yaujTo1IGcVf04YjBa06bQmqF8yF9sB9OxpBy4aOtgp1ZFFi/9S1WPIGl4rXf5Vs73A4xtNb4hOReOikrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kATAWw3H; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oBoM012409;
	Tue, 19 Aug 2025 23:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mgvPjbKHPHmqG3f6LOUqpIF
	jvu1YeBJXr3u8s7i319M=; b=kATAWw3HyB+bJ5cs3f+c0VPwJ1SMHcZWsfInWVp
	Z6+PxT/hwA7cwyKD4rtBMD4+g3p86fAEqG43BVWG9N7aO/fDhzJ2J5cBBLQhGwUJ
	PIAfAGTeL+d1+bcunAMti1KVMuAC7YWlrA7/Eo9cZ83U0Gqt4JVKGwRXAsupSIk9
	bsQPRvu2+rQkGV6US7S5lcJ6KVscUftWSnotJ4HDCx3eFFCqaHSpLgNKe8V2Kguf
	WvHvVRYoDF410Bl11HEDvSND4QrINrW6+5J7OYvTYFrV9YcQt36WmIqIWyyZS+m8
	Ao5dK8EfnOwsWB7hyBGzrqepUiT1cBc2wX67Izsdc/ArZKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48n51urgbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 23:46:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 Aug 2025 23:46:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 Aug 2025 23:46:42 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 1DE183F70B5;
	Tue, 19 Aug 2025 23:46:33 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net-next Patch] Octeontx2-af: Broadcast XON on all channels
Date: Wed, 20 Aug 2025 12:16:25 +0530
Message-ID: <20250820064625.1464361-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aIF4cOFPENb5x4stqJ4qKuTj_Bu-EPtX
X-Proofpoint-GUID: aIF4cOFPENb5x4stqJ4qKuTj_Bu-EPtX
X-Authority-Analysis: v=2.4 cv=I9E8hNgg c=1 sm=1 tr=0 ts=68a56f4f cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=Zm5e-TsFn6k_I1Zn3SQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA1NyBTYWx0ZWRfX5xFSkjaHru68 v9UdCAn5UB2zn66qoUbsImFwYVB2SrsQXPfwWudzQsdznhOL7hFuBBEAikjsYNQRpdOVqRWj+XO 8QZZ9Etffv5+Fax3QCl0eS/0GVCEIcgOuiXn7/VIgEW9hdYeNiHUKv9qifvu/XP5zVp03q0R+AI
 8D4Gy4yH73wmBCf7GQL8odJyqwa2K8gqcZoXlibzbpeUqEX6EZCRK3fphvm00yU86QmgTaDQIWI UWE0w1gtXHO6Rguqtc2GA24aifLnCMI9z/FhO5oAs9nj188vEGTC+rquudzjlP98Br7AonSm2Mf C9B2qrUgxQ7fR/9zi885f4uosHHSHPa8r9+4grTtpDU7+ekCFBfRynxoHQ0cwL2v+9XoCvikS4o
 Um6GLql0EjKGqVGBQe2YNiVqDvZykq34Sn68+TpXpG+3l+46KZiNq2lqtYnootPrmAY84WJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-14_01,2025-03-28_01

The NIX block receives traffic from multiple channels, including:

MAC block (RPM)
Loopback module (LBK)
CPT block

                     RPM
                      |
                -----------------
       LBK   --|     NIX         |
                -----------------
                     |
                    CPT

Due to a hardware errata,  CN10k and earlier Octeon silicon series,
the hardware may incorrectly assert XOFF on certain channels during
reset. As a workaround, a write operation to the NIX_AF_RX_CHANX_CFG
register can be performed to broadcast XON signals on the affected
channels

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c  |  3 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c  | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index c6bb3aaa8e0d..2d78e08f985f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1164,6 +1164,9 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	rvu_program_channels(rvu);
 	cgx_start_linkup(rvu);
 
+	rvu_block_bcast_xon(rvu, BLKADDR_NIX0);
+	rvu_block_bcast_xon(rvu, BLKADDR_NIX1);
+
 	err = rvu_mcs_init(rvu);
 	if (err) {
 		dev_err(rvu->dev, "%s: Failed to initialize mcs\n", __func__);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7ee1fdeb5295..1692033b46b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1017,6 +1017,7 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			    int blkaddr, int nixlf);
+void rvu_block_bcast_xon(struct rvu *rvu, int blkaddr);
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
 int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 60db1f616cc8..828316211b24 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6616,3 +6616,19 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 
 	return ret;
 }
+
+/* On CN10k and older series of silicons, hardware may incorrectly
+ * assert XOFF on certain channels. Issue a write on NIX_AF_RX_CHANX_CFG
+ * to broadcacst XON on the same.
+ */
+void rvu_block_bcast_xon(struct rvu *rvu, int blkaddr)
+{
+	struct rvu_block *block = &rvu->hw->block[blkaddr];
+	u64 cfg;
+
+	if (!block->implemented || is_cn20k(rvu->pdev))
+		return;
+
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0));
+	rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(0), cfg);
+}
-- 
2.34.1


