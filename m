Return-Path: <netdev+bounces-307321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AXYHBuiYVWqRqgAAu9opvQ
	(envelope-from <netdev+bounces-307321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD07503F6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:03:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=LIPjXGTg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307321-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 316F7300721F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8F37AA61;
	Tue, 14 Jul 2026 02:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9D377004;
	Tue, 14 Jul 2026 02:03:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994593; cv=none; b=fG4JD0EjjebP6/MwW5C4VeE7ikV0CGQrfx7sM69YN6pNWGlNrHefOs+Dm4XhWsavk2X3MZ47eNk8XukX3DlFeiZLXv8ob7uducO51p+BEuIzn2mAY1Wx+0hETTtJ3xcv62u9qoGXBwieAHQxWH+0qavp8/romKOiPJm/qh9EdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994593; c=relaxed/simple;
	bh=xvEZ1SgUxZP5K28YxSwTKHX5OSfXLgZEDdfPs6gLC8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otaG5Iir3Sk9hvZQn+6uSp+FmRvohkYEac11l0xLGjxtmF/cC+VVSk55aBaC4uRQ/AvlvMqXtoHrzTjNztwjAuQcpeukqfM+guMKZp2vGLIQgIAc/ywKIfcTomboGnvO5tk+RV80+OLrYFgVshNhz1t40ESymzWzhxPGzMhhICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LIPjXGTg; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNmqnw1677576;
	Mon, 13 Jul 2026 19:02:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bFJtg+S3tii5Di//48rypko
	y2nJKQjWpC9AypNb11hI=; b=LIPjXGTg7V47OozZy7GSVYUMlSingms3wTgq45A
	VbpRww77kPWh8JG56S3op+7gVj28WUTRYC0kbDJ8C/jsmp03vtoLzNJPOFZ+VsHx
	XbX3yt0haiD2Q+QCYLlKuc9n2cXDYN2TMfAOlaWCmvoPB3OFq/gptH0Bc/wxGmbb
	DzNWTF3nhuIFQXSMIpGjOAN947cMD2uPoZ3YnaR7WcsYDAERp9RQDs+qzG0xa7Og
	Z/F9gcbbbrhKPg86RLR5Q2MmRPIUhTumrSywDb2ZveIdXttUe03LtoLwdr4Pfu0U
	qFl92V9YDmJXf4KCygCu2CIdmx3FVg1YhLatnKG9/iu7caQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fc6k9mk4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 19:02:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 19:02:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 19:02:51 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2C3935E6866;
	Mon, 13 Jul 2026 19:02:47 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <naveenm@marvell.com>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net] octeontx2: Fix Klocwork issues in AF and PF drivers
Date: Tue, 14 Jul 2026 07:32:41 +0530
Message-ID: <20260714020241.1810407-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ljeKhikW8nxmG7G-fVMF2ZxqNjIK0Lsr
X-Proofpoint-GUID: ljeKhikW8nxmG7G-fVMF2ZxqNjIK0Lsr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxOCBTYWx0ZWRfX3E46+amIcJur
 WQWu95EwCkWH+KttPiYfz7XiChFHuicN6TYBXK3PcP7ZFZLlmqOJiADzDmeLylWjYhm5RFWjusA
 00Im5T/UJNtJkOnc77WQojp38q/x4ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxOCBTYWx0ZWRfX5m757eh7nk3x
 WR+NkAdMu9JMUS1PqzIQTU0pQxP9pjoJTYQjq/6gzqVJ6VkH7eQOzuyfb+Hn7QCB+2SSUXlFc/O
 cUWDdSXG/QJFsnVmDj0kvYsSyWb0fot2dBUG+KgPLEssYSzEasa+VaRBjJ5tepKuCoZxQ66/OK9
 S3ClCKTdkvC7hNsrxIXv0/ddHdOwyXKtld/HXJjkzS4RrfZ69p9vaW57dRM5qyj8O6a6H5v7iYP
 7Chu4kpzEWibErfJoBUHOP0GT3oFlRgcQEd7hOyCVwOPiqR3yVIq7/P9GsyeB2F29g3iZcn1Wu6
 fNC+wkgLrAPtkVDg/A/vndITLWSGKTqyR87TOBAjGLI6m4PIQlytF30Zf0SIO1TR6rbg2jTPDL/
 6dgJPr5Ya+xR74/mSlnqTcOKdoAaFkMb3Xqpb+xBsQEAixvT3BDVE4xZZfajVk4t9dSMaayU4Hq
 5NYaccDMF1Y9UuUy+WQ==
X-Authority-Analysis: v=2.4 cv=ULLt2ify c=1 sm=1 tr=0 ts=6a5598d0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=H34Y70v85j6Wi5UwV7gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307321-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,redhat.com,gmail.com,marvell.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:sumang@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00CD07503F6

From: Suman Ghosh <sumang@marvell.com>

Fix null dereference, uninitialized variable, and error-path resource
leak findings reported by Klocwork across the OcteonTX2 AF and PF code.

Fixes: 818ed8933bd1 ("octeontx2-af: Re-enable MAC TX in otx2_stop processing")
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c      | 12 +++++++++---
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c   |  8 +++++---
 drivers/net/ethernet/marvell/octeontx2/af/npc.h      |  6 +++---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c      | 11 ++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c  |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c  |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c  |  8 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c  |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c  |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +++
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c     |  1 +
 12 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2e94d5105016..70c8ef5f0be0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -491,12 +491,19 @@ int cgx_lmac_addr_max_entries_get(u8 cgx_id, u8 lmac_id)
 u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
-	struct lmac *lmac = lmac_pdata(lmac_id, cgx_dev);
 	struct mac_ops *mac_ops;
+	struct lmac *lmac;
 	int index;
 	u64 cfg;
 	int id;
 
+	if (!cgx_dev)
+		return 0;
+
+	lmac = lmac_pdata(lmac_id, cgx_dev);
+	if (!lmac)
+		return 0;
+
 	mac_ops = cgx_dev->mac_ops;
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
@@ -1709,10 +1716,10 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
 static int cgx_lmac_init(struct cgx *cgx)
 {
 	u8 max_dmac_filters;
+	u64 lmac_list = 0;
 	struct lmac *lmac;
 	int err, filter;
 	unsigned int i;
-	u64 lmac_list;
 
 	/* lmac_list specifies which lmacs are enabled
 	 * when bit n is set to 1, LMAC[n] is enabled
@@ -2021,7 +2028,6 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	list_add(&cgx->cgx_list, &cgx_list);
 
-
 	cgx_populate_features(cgx);
 
 	mutex_init(&cgx->lock);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index d98b49f47970..cc19d16e660f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -632,8 +632,8 @@ int rvu_mbox_handler_mcs_free_resources(struct rvu *rvu,
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
+	int rc = -EINVAL;
 	struct mcs *mcs;
-	int rc = 0;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -682,8 +682,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
+	int rsrc_id = -EINVAL, i;
 	struct mcs *mcs;
-	int rsrc_id, i;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -744,6 +744,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 			rsp->rsrc_cnt++;
 		}
 		break;
+	default:
+		goto exit;
 	}
 
 	rsp->rsrc_type = req->rsrc_type;
@@ -856,7 +858,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
 static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
 {
 	struct mcs *mcs = mcs_get_pdata(0);
-	unsigned long lmac_bmap;
+	unsigned long lmac_bmap = 0;
 	int cgx, lmac, port;
 
 	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index eaed172f1606..402cd56b835e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -522,7 +522,7 @@ struct npc_coalesced_kpu_prfl {
 	u8 name[NPC_NAME_LEN]; /* KPU Profile name */
 	u64 version; /* KPU firmware/profile version */
 	u8 num_prfl; /* No of NPC profiles. */
-	u16 prfl_sz[];
+	u16 prfl_sz[0];
 };
 
 struct npc_mcam_kex {
@@ -549,7 +549,7 @@ struct npc_kpu_fwdata {
 	 * struct npc_kpu_profile_cam[entries];
 	 * struct npc_kpu_profile_action[entries];
 	 */
-	u8	data[];
+	u8	data[0];
 } __packed;
 
 struct npc_lt_def {
@@ -639,7 +639,7 @@ struct npc_kpu_profile_fwdata {
 	 *  Custom KPU CAM and ACTION configuration entries.
 	 * struct npc_kpu_fwdata kpu[kpus];
 	 */
-	u8	data[];
+	u8	data[0];
 } __packed;
 
 struct rvu_npc_mcam_rule {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 58e62e955554..6ccaa9de998c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -517,6 +517,7 @@ static int ptp_pps_on(struct ptp *ptp, int on, u64 period)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
+	void __iomem * const *base;
 	struct ptp *ptp;
 	int err;
 
@@ -536,7 +537,15 @@ static int ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	ptp->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	base = pcim_iomap_table(pdev);
+	if (!base)
+		goto error_free;
+
+	ptp->reg_base = base[PCI_PTP_BAR_NO];
+	if (!ptp->reg_base) {
+		err = -ENODEV;
+		goto error_free;
+	}
 
 	pci_set_drvdata(pdev, ptp);
 	if (!first_ptp_block)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..3b1f1dbfc27e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -507,7 +507,7 @@ int rvu_cgx_tx_enable(struct rvu *rvu, u16 pcifunc, bool enable)
 	void *cgxd;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return LMAC_AF_ERR_PERM_DENIED;
+		return 0;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f404117bf6c8..fbe41537ea9a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -83,8 +83,8 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 	struct rvu_block *block = ptr;
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
+	int i, eng = 0;
 	u64 reg, val;
-	int i, eng;
 	u8 grp;
 
 	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..230794abbb4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -496,13 +496,17 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
 
 static void rvu_dbg_mcs_init(struct rvu *rvu)
 {
+	char *dname = NULL;
 	struct mcs *mcs;
-	char dname[10];
 	int i;
 
 	if (!rvu->mcs_blk_cnt)
 		return;
 
+	dname = kmalloc_array(rvu->mcs_blk_cnt, sizeof(char), GFP_KERNEL);
+	if (!dname)
+		return;
+
 	rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
 
 	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
@@ -546,6 +550,8 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 		debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
 				    &rvu_dbg_mcs_tx_port_stats_fops);
 	}
+
+	kfree(dname);
 }
 
 #define LMT_MAPTBL_ENTRY_SIZE 16
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 6a0ce2665031..c1333c4d45ec 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5540,7 +5540,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
 				 int blkaddr)
 {
 	u8 cpt_idx, cpt_blkaddr;
-	u64 val;
+	u64 val = 0;
 
 	cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
 	if (req->enable) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c7bc0b3a29b9..6b3ad91bb903 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -2210,8 +2210,8 @@ static int npc_load_kpu_profile_from_fw(struct rvu *rvu)
 				rvu->kpu_prfl_addr = NULL;
 			} else {
 				kfree(rvu->kpu_fwdata);
+				rvu->kpu_fwdata = NULL;
 			}
-			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 5dd0591fed99..99d78fc5a2c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -272,6 +272,7 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 	if (allocated) {
 		pfvf->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
 		pfvf->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
+		pfvf->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
 	}
 
 	if (allocated != count)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 2e33b33ec993..33577a90fc1e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -489,6 +489,9 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 	return;
 
 inval_msg:
+	if (!msg)
+		return;
+
 	otx2_reply_invalid_msg(mbox, vf_idx, 0, msg->id);
 	otx2_mbox_msg_send(mbox, vf_idx);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 69c0911e28e9..02e593017556 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -533,6 +533,7 @@ otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 	err = otx2_qos_add_child_node(parent, node);
 	if (err) {
 		mutex_unlock(&pfvf->qos.qos_lock);
+		kfree(node);
 		return ERR_PTR(err);
 	}
 	mutex_unlock(&pfvf->qos.qos_lock);
-- 
2.43.0


