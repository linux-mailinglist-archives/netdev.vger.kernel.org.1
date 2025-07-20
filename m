Return-Path: <netdev+bounces-208446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48393B0B701
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A3D189A25B
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A22225417;
	Sun, 20 Jul 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UoGaOjAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6418224B10;
	Sun, 20 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029435; cv=none; b=eYD27ejKSw0hvbywE7S0m6QN0V6SmX74OtG2OidJcUDv3jQ8s0qb4eEzvxY9NvrsRF9mEqPcgkzKQBLPcFdhPC4tTZar62UiXvXU8RGmugWg2e+o88EOot/7ShzrYQdLSYY1IZGPgVgVkGsTFpTRuzAdAV1k9YewvaIPxD9r4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029435; c=relaxed/simple;
	bh=3O4Fwlhz8F4JjXJ7fCBXpshu8iMQZ25ENjPKuI8n8Nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pke9vQFVo1u++WwQzok7NzlOOYlBagbmpWduKyfWgAPRI7h2D1KuVxmav74O92lldbuzdy/HgoWrcQEmRY8axspdqEolFY4L3Lcd+i+nA6/PwpSj83swNbktxaa3l0mL7SCQyV9sCYICV0wbEN8AfQHN5lcA2MpTSp0F+iq5IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UoGaOjAQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGWUsh017741;
	Sun, 20 Jul 2025 09:37:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	hLm0FpB6xUX7EtQLxPHb4wkAHivgPGR1ZeIG2NHiQc=; b=UoGaOjAQdLc14FfF/
	YmduMp8pvWxgaO9ZkmoumXV40sljJw8oumP43fEC7dIeIo391qC/6S4EC0ve2+0V
	U0K69A6cCphWdcFCsuyhu2X2y9mon7wtck7+GDPIUBtYLiCbnne9lLl1hn2etgrD
	olsdbiLQIAO1Nk81LtKZHNYBWTUj4Xo/wlG+WF/EE7YVYZFYS77KZ51NMYnjba1k
	pf735nEzxNNXv9ZuLN8HafkQLFuQxW3vpsQKrsd8c/Gb5TuDzNXr+MwGJ/valolo
	7lbZ3R3L5h3r+tOBRvMNZuUtVDEXiFZZoclLmOmMUlsy0Aj5jksP1iEa1j2b1O23
	Co/pg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4808qq1tk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 09:37:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Jul 2025 09:37:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Jul 2025 09:37:04 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id A93393F7057;
	Sun, 20 Jul 2025 09:36:59 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 4/4] Octeontx2-af: Debugfs support for firmware data
Date: Sun, 20 Jul 2025 22:06:38 +0530
Message-ID: <20250720163638.1560323-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250720163638.1560323-1-hkelam@marvell.com>
References: <20250720163638.1560323-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE2MCBTYWx0ZWRfX0+LW7gKpC3M6 kqSOwTZyEcMQP/1EAaec0iz/tOHIXKTuZ3D8hc/wwfJpRaaXbwnv2FoxwlHBYDb389Upw5fW1ni m1UH82JiOagybjIWZ10w1PYxGv+4uKckUx20asytkhShx6FMNBGa12/qyBTR3pot3Io7yjUDlD1
 /e1L6EhzFLo8wZ9GMdJWSadVBunMsen2Zuq5pY/z/jccVMWRWlxBdBhEgqgcqziY3FeiuaPGpw6 QMVFlpdD1de37roRNsQKxrvfR5YE7LXvIKuTn9jnjXyJHbLHH+Gt9ecvxc+/nrCT5ZNi0Kfs3rQ bKTqRkOSD3dvshaZn8TyLpsEDkaDz3U9OkbCrMNHioxN0v07dsmVCx0+SunjwexycxOx6pHGxN/
 8epxJd6SSm9QmgfDnSIcDGZIfehkhREH9npDG5pwtSK2gj877ZN3qQPKsWy9aIDf3V450Kb1
X-Proofpoint-GUID: d1iY6S-8PNSHb3HaIx8lKroL09iTNE3W
X-Proofpoint-ORIG-GUID: d1iY6S-8PNSHb3HaIx8lKroL09iTNE3W
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=687d1b31 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=hMOJt8txAAAA:8 a=IzogfuMDhfRa5p4SXY4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=VB-UQLohyrnngkzD1eWn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

MAC address, Link modes (supported and advertised) and eeprom data
for the Netdev interface are read from the shared firmware data.
This patch adds debugfs support for the same.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
V2 *
    fix max line length warnings and typo

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        | 162 ++++++++++++++++++
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 0bc0dc79868b..933073cd2280 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -664,7 +664,12 @@ struct cgx_lmac_fwdata_s {
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1021
+	u32 lmac_type;
+	u32 portm_idx;
+	u64 mgmt_port:1;
+	u64 advertised_an:1;
+	u64 port;
+#define LMAC_FWDATA_RESERVED_MEM 1018
 	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 0c20642f81b9..8375f18c8e07 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -867,6 +867,71 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 
 RVU_DEBUG_SEQ_FOPS(rvu_pf_cgx_map, rvu_pf_cgx_map_display, NULL);
 
+static int rvu_dbg_rvu_fwdata_display(struct seq_file *s, void *unused)
+{
+	struct rvu *rvu = s->private;
+	struct rvu_fwdata *fwdata;
+	u8 mac[ETH_ALEN];
+	int count = 0, i;
+
+	if (!rvu->fwdata)
+		return -EAGAIN;
+
+	fwdata = rvu->fwdata;
+	seq_puts(s, "\nRVU Firmware Data:\n");
+	seq_puts(s, "\n\t\tPTP INFORMATION\n");
+	seq_puts(s, "\t\t===============\n");
+	seq_printf(s, "\t\texternal clockrate \t :%x\n",
+		   fwdata->ptp_ext_clk_rate);
+	seq_printf(s, "\t\texternal timestamp \t :%x\n",
+		   fwdata->ptp_ext_tstamp);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\n\t\tSDP CHANNEL INFORMATION\n");
+	seq_puts(s, "\t\t=======================\n");
+	seq_printf(s, "\t\tValid \t\t\t :%x\n", fwdata->channel_data.valid);
+	seq_printf(s, "\t\tNode ID \t\t :%x\n",
+		   fwdata->channel_data.info.node_id);
+	seq_printf(s, "\t\tNumber of VFs  \t\t :%x\n",
+		   fwdata->channel_data.info.max_vfs);
+	seq_printf(s, "\t\tNumber of PF-Rings \t :%x\n",
+		   fwdata->channel_data.info.num_pf_rings);
+	seq_printf(s, "\t\tPF SRN \t\t\t :%x\n",
+		   fwdata->channel_data.info.pf_srn);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\n\t\tPF-INDEX  MACADDRESS\n");
+	seq_puts(s, "\t\t====================\n");
+	for (i = 0; i < PF_MACNUM_MAX; i++) {
+		u64_to_ether_addr(fwdata->pf_macs[i], mac);
+		if (!is_zero_ether_addr(mac)) {
+			seq_printf(s, "\t\t  %d       %pM\n", i, mac);
+			count++;
+		}
+	}
+
+	if (!count)
+		seq_puts(s, "\t\tNo valid address found\n");
+
+	seq_puts(s, "\n\t\tVF-INDEX  MACADDRESS\n");
+	seq_puts(s, "\t\t====================\n");
+	count = 0;
+	for (i = 0; i < VF_MACNUM_MAX; i++) {
+		u64_to_ether_addr(fwdata->vf_macs[i], mac);
+		if (!is_zero_ether_addr(mac)) {
+			seq_printf(s, "\t\t  %d       %pM\n", i, mac);
+			count++;
+		}
+	}
+
+	if (!count)
+		seq_puts(s, "\t\tNo valid address found\n");
+
+	return 0;
+}
+
+RVU_DEBUG_SEQ_FOPS(rvu_fwdata, rvu_fwdata_display, NULL);
+
 static bool rvu_dbg_is_valid_lf(struct rvu *rvu, int blkaddr, int lf,
 				u16 *pcifunc)
 {
@@ -2923,6 +2988,97 @@ static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
 
 RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, NULL);
 
+static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
+{
+	struct cgx_lmac_fwdata_s *fwdata;
+	void *cgxd = s->private;
+	struct phy_s *phy;
+	struct rvu *rvu;
+	int cgx_id, i;
+
+	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
+					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
+	if (!rvu)
+		return -ENODEV;
+
+	if (!rvu->fwdata)
+		return -EAGAIN;
+
+	cgx_id = cgx_get_cgxid(cgxd);
+
+	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
+		fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
+	else
+		fwdata =  &rvu->fwdata->cgx_fw_data[cgx_id][lmac_id];
+
+	seq_puts(s, "\nFIRMWARE SHARED:\n");
+	seq_puts(s, "\t\tSUPPORTED LINK INFORMATION\t\t\n");
+	seq_puts(s, "\t\t==========================\n");
+	seq_printf(s, "\t\t Link modes \t\t :%llx\n",
+		   fwdata->supported_link_modes);
+	seq_printf(s, "\t\t Autoneg \t\t :%llx\n", fwdata->supported_an);
+	seq_printf(s, "\t\t FEC \t\t\t :%llx\n", fwdata->supported_fec);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\t\tADVERTISED LINK INFORMATION\t\t\n");
+	seq_puts(s, "\t\t==========================\n");
+	seq_printf(s, "\t\t Link modes \t\t :%llx\n",
+		   (u64)fwdata->advertised_link_modes);
+	seq_printf(s, "\t\t Autoneg \t\t :%x\n", fwdata->advertised_an);
+	seq_printf(s, "\t\t FEC \t\t\t :%llx\n", fwdata->advertised_fec);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\t\tLMAC CONFIG\t\t\n");
+	seq_puts(s, "\t\t============\n");
+	seq_printf(s, "\t\t rw_valid  \t\t :%x\n",  fwdata->rw_valid);
+	seq_printf(s, "\t\t lmac_type \t\t :%x\n", fwdata->lmac_type);
+	seq_printf(s, "\t\t portm_idx \t\t :%x\n", fwdata->portm_idx);
+	seq_printf(s, "\t\t mgmt_port \t\t :%x\n", fwdata->mgmt_port);
+	seq_printf(s, "\t\t Link modes own \t :%llx\n",
+		   (u64)fwdata->advertised_link_modes_own);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\n\t\tEEPROM DATA\n");
+	seq_puts(s, "\t\t===========\n");
+	seq_printf(s, "\t\t sff_id \t\t :%x\n", fwdata->sfp_eeprom.sff_id);
+	seq_puts(s, "\t\t data \t\t\t :\n");
+	seq_puts(s, "\t\t");
+	for (i = 0; i < SFP_EEPROM_SIZE; i++) {
+		seq_printf(s, "%x", fwdata->sfp_eeprom.buf[i]);
+		if ((i + 1) % 16 == 0) {
+			seq_puts(s, "\n");
+			seq_puts(s, "\t\t");
+		}
+	}
+	seq_puts(s, "\n");
+
+	phy = &fwdata->phy;
+	seq_puts(s, "\n\t\tPHY INFORMATION\n");
+	seq_puts(s, "\t\t===============\n");
+	seq_printf(s, "\t\t Mod type configurable \t\t :%x\n",
+		   phy->misc.can_change_mod_type);
+	seq_printf(s, "\t\t Mod type \t\t\t :%x\n", phy->misc.mod_type);
+	seq_printf(s, "\t\t Support FEC \t\t\t :%x\n", phy->misc.has_fec_stats);
+	seq_printf(s, "\t\t RSFEC corrected words \t\t :%x\n",
+		   phy->fec_stats.rsfec_corr_cws);
+	seq_printf(s, "\t\t RSFEC uncorrected words \t :%x\n",
+		   phy->fec_stats.rsfec_uncorr_cws);
+	seq_printf(s, "\t\t BRFEC corrected words \t\t :%x\n",
+		   phy->fec_stats.brfec_corr_blks);
+	seq_printf(s, "\t\t BRFEC uncorrected words \t :%x\n",
+		   phy->fec_stats.brfec_uncorr_blks);
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int rvu_dbg_cgx_fwdata_display(struct seq_file *s, void *unused)
+{
+	return cgx_print_fwdata(s, rvu_dbg_derive_lmacid(s));
+}
+
+RVU_DEBUG_SEQ_FOPS(cgx_fwdata, cgx_fwdata_display, NULL);
+
 static void rvu_dbg_cgx_init(struct rvu *rvu)
 {
 	struct mac_ops *mac_ops;
@@ -2962,6 +3118,9 @@ static void rvu_dbg_cgx_init(struct rvu *rvu)
 			debugfs_create_file_aux_num("mac_filter", 0600,
 					    rvu->rvu_dbg.lmac, cgx, lmac_id,
 					    &rvu_dbg_cgx_dmac_flt_fops);
+			debugfs_create_file("fwdata", 0600,
+					    rvu->rvu_dbg.lmac, cgx,
+					    &rvu_dbg_cgx_fwdata_fops);
 		}
 	}
 }
@@ -3808,6 +3967,9 @@ void rvu_dbg_init(struct rvu *rvu)
 		debugfs_create_file("lmtst_map_table", 0444, rvu->rvu_dbg.root,
 				    rvu, &rvu_dbg_lmtst_map_table_fops);
 
+	debugfs_create_file("rvu_fwdata", 0444, rvu->rvu_dbg.root, rvu,
+			    &rvu_dbg_rvu_fwdata_fops);
+
 	if (!cgx_get_cgxcnt_max())
 		goto create;
 
-- 
2.34.1


