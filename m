Return-Path: <netdev+bounces-146831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D09D6220
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98876B213C5
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482911E0DA1;
	Fri, 22 Nov 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ammz8nmM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AD1E0B61;
	Fri, 22 Nov 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292473; cv=none; b=pvR1kPt5QD1mspeTFQF2nsMG1DqrGTNRY0qTqpiYqhst2rDrJm6G8VvAKDsOMQN4kZlT5RKb0zDsI8mMMoD5LiSqkfh/WlBDvU/DT9mhoLVOzDpSdMktBCp6GzoQSRIIyyX2ICS/yv4/uGjzbKoaufKkRjE/GXbPeKkTCPSc1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292473; c=relaxed/simple;
	bh=zlCpofrwiejrtQ+pBy/7ABBJder57azQMUyHYr3sBxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmDaF3gxoSGisM5wYuhMa90z3vj2A5gP9lITboZY52mNj+PVG36V32TVigXb77KbNQB9pRSgs5d6IoVY4zEYKl/0hZYjzNsj65sJFj96BndiZafJh2ay3Mf8BwBM2nAA4uPjzfcSAEGxAl8q4cplD/ZK0S2oQejjl1uJRc4BWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ammz8nmM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCvwde007290;
	Fri, 22 Nov 2024 08:20:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1sXDavttM6oXjBzkey4EID/Lj
	J9Yif910/EdlseeUog=; b=ammz8nmM2xwpfjk4JVkqK5T+VFuY1Lg6MK/DcfCgU
	7EfKfgflx1R+rbHMPtyD84kU4SY81HMOZphL7k3tPefLdJdhcrVl5iYSymsvnpPA
	uBAokvYqto0lG1hcAEsNnb3KQVdoiyHTOApVCqRflAaNLkQD657jlYWK/i1Z7dqj
	nDN1SxcmAeboETVcRjh6NWT0bRVQ4jaK45j74Ky388PoFUFz8W6h3ki6PkS8rtWA
	Wy6OeBcE3GcndT1fzRah5flhpfFBkqzFCWYOn/XW0XDc1lhKTIo5pxPDPqPw+MLS
	C6Sba87NuSljRY4DH4xaIAX+DZClQW8rIiIDsWnAGfWcg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 432tdwgfx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:20:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 22 Nov 2024 08:20:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 22 Nov 2024 08:20:51 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 54DAD3F7080;
	Fri, 22 Nov 2024 08:20:46 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net 2/5] octeontx2-af: RPM: Fix low network performance
Date: Fri, 22 Nov 2024 21:50:32 +0530
Message-ID: <20241122162035.5842-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122162035.5842-1-hkelam@marvell.com>
References: <20241122162035.5842-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IR6g_7cxBxBIK0Eqvr980Ya2ENojciAn
X-Proofpoint-GUID: IR6g_7cxBxBIK0Eqvr980Ya2ENojciAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Low network performance is observed even on RPMs with larger
FIFO lengths.

The cn10kb silicon has three RPM blocks with the following
FIFO sizes:

         --------------------
         | RPM0  |   256KB  |
         | RPM1  |   256KB  |
         | RPM2  |   128KB  |
         --------------------

The current design stores the FIFO length in a common structure for all
RPMs (mac_ops). As a result, the FIFO length of the last RPM is applied
to all RPMs, leading to reduced network performance.

This patch resolved the problem by storing the fifo length in per MAC
structure (cgx).

Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c         | 9 +++++++--
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h         | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h | 5 ++++-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c         | 6 +++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c     | 9 ++++-----
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 27935c54b91b..2f621714c54e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -112,6 +112,11 @@ struct mac_ops *get_mac_ops(void *cgxd)
 	return ((struct cgx *)cgxd)->mac_ops;
 }
 
+u32 cgx_get_fifo_len(void *cgxd)
+{
+	return ((struct cgx *)cgxd)->fifo_len;
+}
+
 void cgx_write(struct cgx *cgx, u64 lmac, u64 offset, u64 val)
 {
 	writeq(val, cgx->reg_base + (lmac << cgx->mac_ops->lmac_offset) +
@@ -501,7 +506,7 @@ static u32 cgx_get_lmac_fifo_len(void *cgxd, int lmac_id)
 	u8 num_lmacs;
 	u32 fifo_len;
 
-	fifo_len = cgx->mac_ops->fifo_len;
+	fifo_len = cgx->fifo_len;
 	num_lmacs = cgx->mac_ops->get_nr_lmacs(cgx);
 
 	switch (num_lmacs) {
@@ -1764,7 +1769,7 @@ static void cgx_populate_features(struct cgx *cgx)
 	u64 cfg;
 
 	cfg = cgx_read(cgx, 0, CGX_CONST);
-	cgx->mac_ops->fifo_len = FIELD_GET(CGX_CONST_RXFIFO_SIZE, cfg);
+	cgx->fifo_len = FIELD_GET(CGX_CONST_RXFIFO_SIZE, cfg);
 	cgx->max_lmac_per_mac = FIELD_GET(CGX_CONST_MAX_LMACS, cfg);
 
 	if (is_dev_rpm(cgx))
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index dc9ace30554a..f9cd4b58f0c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -185,4 +185,5 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
 int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
+u32 cgx_get_fifo_len(void *cgxd);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 9ffc6790c513..c43ff68ef140 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -72,7 +72,6 @@ struct mac_ops {
 	u8			irq_offset;
 	u8			int_ena_bit;
 	u8			lmac_fwi;
-	u32			fifo_len;
 	bool			non_contiguous_serdes_lane;
 	/* RPM & CGX differs in number of Receive/transmit stats */
 	u8			rx_stats_cnt;
@@ -142,6 +141,10 @@ struct cgx {
 	u8			lmac_count;
 	/* number of LMACs per MAC could be 4 or 8 */
 	u8			max_lmac_per_mac;
+	/* length of fifo varies depending on the number
+	 * of LMACS
+	 */
+	u32			fifo_len;
 #define MAX_LMAC_COUNT		8
 	struct lmac             *lmac_idmap[MAX_LMAC_COUNT];
 	struct			work_struct cgx_cmd_work;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 9e8c5e4389f8..22dd50a3fcd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -480,7 +480,7 @@ u32 rpm_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	u8 num_lmacs;
 	u32 fifo_len;
 
-	fifo_len = rpm->mac_ops->fifo_len;
+	fifo_len = rpm->fifo_len;
 	num_lmacs = rpm->mac_ops->get_nr_lmacs(rpm);
 
 	switch (num_lmacs) {
@@ -533,9 +533,9 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	 */
 	max_lmac = (rpm_read(rpm, 0, CGX_CONST) >> 24) & 0xFF;
 	if (max_lmac > 4)
-		fifo_len = rpm->mac_ops->fifo_len / 2;
+		fifo_len = rpm->fifo_len / 2;
 	else
-		fifo_len = rpm->mac_ops->fifo_len;
+		fifo_len = rpm->fifo_len;
 
 	if (lmac_id < 4) {
 		num_lmacs = hweight8(lmac_info & 0xF);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 266ecbc1b97a..4dcd7bfcad4e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -923,13 +923,12 @@ int rvu_mbox_handler_cgx_features_get(struct rvu *rvu,
 
 u32 rvu_cgx_get_fifolen(struct rvu *rvu)
 {
-	struct mac_ops *mac_ops;
-	u32 fifo_len;
+	void *cgxd = rvu_first_cgx_pdata(rvu);
 
-	mac_ops = get_mac_ops(rvu_first_cgx_pdata(rvu));
-	fifo_len = mac_ops ? mac_ops->fifo_len : 0;
+	if (!cgxd)
+		return 0;
 
-	return fifo_len;
+	return cgx_get_fifo_len(cgxd);
 }
 
 u32 rvu_cgx_get_lmac_fifolen(struct rvu *rvu, int cgx, int lmac)
-- 
2.34.1


