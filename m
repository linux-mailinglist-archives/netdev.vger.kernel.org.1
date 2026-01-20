Return-Path: <netdev+bounces-251426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 697EED3C4D7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7740158522E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5893DA7DC;
	Tue, 20 Jan 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TAOf34lU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF463DA7C4;
	Tue, 20 Jan 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903454; cv=none; b=TGIH6MnZLp0uW+WOZC25oKBQXDZ1JIlcU5wpLT1YyelpDjTuFo7VQ3sW6dNabvw1pMEI2sNSBu4LB3cZivu4/MnU30JW2P/+w9SjqbT6BFuampZiK3FupG2m1Gz5yK3miQuQjgRy78VN4qT8p4lVhz3Nafn+TXA6Aiy0LVjusDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903454; c=relaxed/simple;
	bh=LfJ+I1qRSncZgqon7oAHSHA9jvookJNV5i5/HDLTMec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE4QOWOUB18mwaP0Y6cT9fkP5WdBABcOW8J6y2Y2XqV5/RmZz41ABs2zAyiscHixpyjTKkDYFPybJXOkiT/SABmzKPQFh23ObQDVILp8gdlg4gTg9Qn3yfjfrqryD0KtqLWUREgjdkWR6jT5cchwYZExKwXqui8SOvw9xJ1xgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TAOf34lU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K9ZxIh830539;
	Tue, 20 Jan 2026 02:03:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	BoTVtailKuum9ZJztSMHNcLnoylSDIQl7LWZBGzTwY=; b=TAOf34lUbX2GYxqfO
	rJpL+gxCTQUU7Hu6YFeVxTjv4loJ07TPY7ac9xIHJuY0XBOxAAIXM1Hqtmw2tg9F
	mEA+Xcvg/j5RokcYqf0s34O8EG7r0XIdulVa3AfTLSwM8A+CVipwC48H/Ni4Ytp/
	c15cYng2RATFLrVDPeYeGfOo6M7q6mVwQwgKpE7zWn6o39P58fBnnbXmgFcfFjzd
	CSDtzvdxtGiduu0BshltzhliosRj/jWsI/mu2jlXgsxO6D2XAaIpsf3jgIW0W3mf
	Qbqfq1WhTLw8R3C0pOmrcNbgxNruyAUiG0OGNiSpoeAjmFAL4Yp5Lls791XcRoJy
	J5BBw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bt77dg1k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 02:03:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 02:04:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 02:04:05 -0800
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id B4D005B6936;
	Tue, 20 Jan 2026 02:03:46 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV3 1/2] octeontx2-af: Mailbox handlers to fetch DMAC filter drop counter
Date: Tue, 20 Jan 2026 15:33:40 +0530
Message-ID: <20260120100341.2479814-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120100341.2479814-1-hkelam@marvell.com>
References: <20260120100341.2479814-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s4TREVVUYBJht7TSGzQIoXuvtFFafRWh
X-Authority-Analysis: v=2.4 cv=MZRhep/f c=1 sm=1 tr=0 ts=696f5307 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=yp_SqDG9be_aWQAmv5EA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4MyBTYWx0ZWRfX84aOC5Un4GJU
 MpsMMhvGvwDJKNMcSG/K58OE1zvPNrnqiA/75p4+qCa+sVAPku+iOOFow0i8xnjpv9GQ0ZmzW5X
 FkPAiPv5NN8wQyFo8X1WszI1Xbrtpw/c7zVRwMYSrl9hZrnzqmEt8NV0DlwYyKz4ml2fWS868MI
 4YGOY1qO5Cdpzuae53An+az4ZA3PICljRcPhoerJMf+RZzWz8ywRzSuwQeLORXIuyPTuxLMPr6d
 ODxWtFKlG3UWJ1xwVGdtGBUgeKSAbepHucNKmy7LQTXV6YAHJV8R2/Ks53HdSPSmpxsOCuA7v4F
 SOwx1lKaGGzYOaYtcazt1fYE2JEH4ciBAEqlBONMeDehuLCW128tmWso5VJ41sXv16N5is6zv0o
 pimK8LVma+gG2KmdEziGHMElutvqSFL8NWzlSdCfnPyENuNS60p/29a8blWhhCGFssNb/rZLNUt
 859TJLymOfPrcm7b5cQ==
X-Proofpoint-GUID: s4TREVVUYBJht7TSGzQIoXuvtFFafRWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01

Both CGX/RPM mac blocks support DMAC filters. This patch
adds mbox support to read the counter.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V3 * Return early on non CGX mapped interfaces by adding 
     "is_pf_cgxmapped"  check

V2 * no changes

 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 11 +++++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  2 ++
 .../marvell/octeontx2/af/lmac_common.h        |  1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 ++++++
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 18 ++++++++++++++-
 .../net/ethernet/marvell/octeontx2/af/rpm.h   |  2 ++
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 23 +++++++++++++++++++
 7 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 42044cd810b1..f29e6069acc1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -740,6 +740,16 @@ u64 cgx_features_get(void *cgxd)
 	return ((struct cgx *)cgxd)->hw_features;
 }
 
+u64 cgx_get_dmacflt_dropped_pktcnt(void *cgxd, int lmac_id)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return 0;
+
+	return cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT4);
+}
+
 int cgx_stats_reset(void *cgxd, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
@@ -1924,6 +1934,7 @@ static struct mac_ops	cgx_mac_ops    = {
 	.pfc_config =                   cgx_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        cgx_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			cgx_lmac_reset,
+	.get_dmacflt_dropped_pktcnt      =      cgx_get_dmacflt_dropped_pktcnt,
 	.mac_stats_reset       =	cgx_stats_reset,
 	.mac_x2p_reset                   =      cgx_x2p_reset,
 	.mac_enadis_rx			 =      cgx_enadis_rx,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 92ccf343dfe0..4c5ffd0aebdc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -39,6 +39,7 @@
 #define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_STAT0		0x070
+#define CGXX_CMRX_RX_STAT4		0x090
 #define CGXX_CMRX_RX_LOGL_XON		0x100
 #define CGXX_CMRX_RX_LMACS		0x128
 #define CGXX_CMRX_RX_DMAC_CTL0		(0x1F8 + mac_ops->csr_offset)
@@ -186,5 +187,6 @@ int cgx_lmac_get_pfc_frm_cfg(void *cgxd, int lmac_id, u8 *tx_pause,
 int verify_lmac_fc_cfg(void *cgxd, int lmac_id, u8 tx_pause, u8 rx_pause,
 		       int pfvf_idx);
 int cgx_lmac_reset(void *cgxd, int lmac_id, u8 pf_req_flr);
+u64 cgx_get_dmacflt_dropped_pktcnt(void *cgx, int lmac_id);
 u32 cgx_get_fifo_len(void *cgxd);
 #endif /* CGX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
index 6180e68e1765..82446f6c27a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h
@@ -134,6 +134,7 @@ struct mac_ops {
 	int			(*mac_stats_reset)(void *cgxd, int lmac_id);
 	void                    (*mac_x2p_reset)(void *cgxd, bool enable);
 	int			(*mac_enadis_rx)(void *cgxd, int lmac_id, bool enable);
+	u64			(*get_dmacflt_dropped_pktcnt)(void *cgxd, int lmac_id);
 };
 
 struct cgx {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a3e273126e4e..2b653a572eba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -197,6 +197,8 @@ M(CGX_MAC_ADDR_UPDATE,	0x21E, cgx_mac_addr_update, cgx_mac_addr_update_req, \
 						    cgx_mac_addr_update_rsp) \
 M(CGX_PRIO_FLOW_CTRL_CFG, 0x21F, cgx_prio_flow_ctrl_cfg, cgx_pfc_cfg,  \
 				 cgx_pfc_rsp)                               \
+M(CGX_DMAC_FILTER_DROP_CNT, 0x220, cgx_get_dmacflt_dropped_pktcnt, msg_req,  \
+				 cgx_dmac_filter_drop_cnt)                      \
 /* NPA mbox IDs (range 0x400 - 0x5FF) */				\
 M(NPA_LF_ALLOC,		0x400, npa_lf_alloc,				\
 				npa_lf_alloc_req, npa_lf_alloc_rsp)	\
@@ -718,6 +720,11 @@ struct cgx_mac_addr_update_rsp {
 	u32 index;
 };
 
+struct cgx_dmac_filter_drop_cnt {
+	struct mbox_msghdr hdr;
+	u64 count;
+};
+
 #define RVU_LMAC_FEAT_FC		BIT_ULL(0) /* pause frames */
 #define	RVU_LMAC_FEAT_HIGIG2		BIT_ULL(1)
 			/* flow control from physical link higig2 messages */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 2e9945446199..7e0e0c5c11a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -37,7 +37,8 @@ static struct mac_ops		rpm_mac_ops   = {
 	.mac_tx_enable =		rpm_lmac_tx_enable,
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
-	.mac_reset   =			rpm_lmac_reset,
+	.mac_reset			 =	  rpm_lmac_reset,
+	.get_dmacflt_dropped_pktcnt      =        rpm_get_dmacflt_dropped_pktcnt,
 	.mac_stats_reset		 =	  rpm_stats_reset,
 	.mac_x2p_reset                   =        rpm_x2p_reset,
 	.mac_enadis_rx			 =        rpm_enadis_rx,
@@ -73,6 +74,7 @@ static struct mac_ops		rpm2_mac_ops   = {
 	.pfc_config =                   rpm_lmac_pfc_config,
 	.mac_get_pfc_frm_cfg   =        rpm_lmac_get_pfc_frm_cfg,
 	.mac_reset   =			rpm_lmac_reset,
+	.get_dmacflt_dropped_pktcnt =   rpm_get_dmacflt_dropped_pktcnt,
 	.mac_stats_reset	    =	rpm_stats_reset,
 	.mac_x2p_reset              =   rpm_x2p_reset,
 	.mac_enadis_rx		    =   rpm_enadis_rx,
@@ -449,6 +451,20 @@ int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat)
 	return 0;
 }
 
+u64 rpm_get_dmacflt_dropped_pktcnt(void *rpmd, int lmac_id)
+{
+	rpm_t *rpm = rpmd;
+	u64 dmac_flt_stat;
+
+	if (!is_lmac_valid(rpm, lmac_id))
+		return 0;
+
+	dmac_flt_stat = is_dev_rpm2(rpm) ? RPM2_CMRX_RX_STAT2 :
+			RPMX_CMRX_RX_STAT2;
+
+	return rpm_read(rpm, lmac_id, dmac_flt_stat);
+}
+
 int rpm_stats_reset(void *rpmd, int lmac_id)
 {
 	rpm_t *rpm = rpmd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index b8d3972e096a..443481010aba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -60,6 +60,7 @@
 #define RPMX_MTI_STAT_RX_STAT_PAGES_COUNTERX 0x12000
 #define RPMX_MTI_STAT_TX_STAT_PAGES_COUNTERX 0x13000
 #define RPMX_MTI_STAT_DATA_HI_CDC            0x10038
+#define RPMX_CMRX_RX_STAT2		     0x4010
 
 #define RPM_LMAC_FWI			0xa
 #define RPM_TX_EN			BIT_ULL(0)
@@ -129,6 +130,7 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
 			      u8 rx_pause);
 int rpm_get_tx_stats(void *rpmd, int lmac_id, int idx, u64 *tx_stat);
 int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat);
+u64 rpm_get_dmacflt_dropped_pktcnt(void *rpmd, int lmac_id);
 void rpm_lmac_ptp_config(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_rx_tx_enable(void *rpmd, int lmac_id, bool enable);
 int rpm_lmac_tx_enable(void *rpmd, int lmac_id, bool enable);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 3abd750a4bd7..ee7de8bbeadc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1352,3 +1352,26 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
 	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
 		dev_err(rvu->dev, "Failed to reset MAC\n");
 }
+
+int rvu_mbox_handler_cgx_get_dmacflt_dropped_pktcnt(struct rvu *rvu,
+						    struct msg_req *req,
+						    struct cgx_dmac_filter_drop_cnt *rsp)
+{
+	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
+	struct mac_ops *mac_ops;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return 0;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	mac_ops = get_mac_ops(cgxd);
+
+	if (!mac_ops->get_dmacflt_dropped_pktcnt)
+		return 0;
+
+	rsp->count =  mac_ops->get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
+	return 0;
+}
-- 
2.34.1


