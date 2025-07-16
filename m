Return-Path: <netdev+bounces-207544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85716B07B62
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A014258690C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CB2F5C2E;
	Wed, 16 Jul 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IbCC/i3a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E52F548C;
	Wed, 16 Jul 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684155; cv=none; b=swI/HS20U1RM9D96xIfxxPc+yfGiWsvi+6Q7oqLY9z6fHz+xvSg3Sm0alM4xppIpAn5aHrLk9aWRx3WUHZd1wh6vRLJKgyX5hhZMOcjA7wdJNJFenfPg7ASbjwEITvTU6C0dAjwC6G6f3O5iweQ0cvULF74+BNwijUFhQP7nA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684155; c=relaxed/simple;
	bh=16x5CQkSNc5jrAHi+halMh2PyF3GYjmp/0AOSAv6nkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szZS8d1yo9OcTz5kFM0f5ZAD1P5vDgsO4InONFocWFG2lYKG9icmba9j96vHggxMd2lo4iB7LKi6dLhwGGT4yNqdAX61VlHjNQGIb+SrA16LoH9l1negc81IIqB7Eup79s4dEzviTviqH+KulT0SdupzjNT8iorTcv8n3A2Bf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IbCC/i3a; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCgjhK014581;
	Wed, 16 Jul 2025 09:42:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	tlxjzZXZXYSImHl1+gOykPVLlagSVohU1snuTNa6jg=; b=IbCC/i3a4SWt+7/sm
	wdkdTE2Dk87kq8yobfaTSrzGyv7vAWvHMR8vYH5a0bvW2pWsqnuyhJilg2cJAN/K
	6x1vJKxGj8ieG05RpO7jkFWeewbA4t8b6tuWgSRajvXPUVa/Cr9/p4V7WYh8zg9Y
	/qYr+/c5bYGtDE1CasmtJ8fE+OyIiz8Xe1+VmlSc/8RccmfbRluY1xvZ76IFBN2M
	5hjjHNL8oGbt/ND1vs9+OhOIb/zUSFnGQH7zMFxuZpMffhKe/iq2rrhr2Ua8XKfn
	N4680fOxcJ4uEquejFRkJ+Vgkiz8AQApLGc1ZsoHEwrdewgpftqE3erlEkTqkKQY
	vOjZw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47x5qd255b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:42:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Jul 2025 09:42:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Jul 2025 09:42:23 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id B258F3F7041;
	Wed, 16 Jul 2025 09:42:19 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 4/4] Octeontx2-af: Debugfs support for firmware data
Date: Wed, 16 Jul 2025 22:11:58 +0530
Message-ID: <20250716164158.1537269-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716164158.1537269-1-hkelam@marvell.com>
References: <20250716164158.1537269-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R7sKFu1wB17ZJZjcrLD91H_RxgVpLVhH
X-Proofpoint-GUID: R7sKFu1wB17ZJZjcrLD91H_RxgVpLVhH
X-Authority-Analysis: v=2.4 cv=ZKXXmW7b c=1 sm=1 tr=0 ts=6877d671 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=hMOJt8txAAAA:8 a=IzogfuMDhfRa5p4SXY4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=VB-UQLohyrnngkzD1eWn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MCBTYWx0ZWRfX1h4u85+K3HWQ ZGOdto0oxo91aJmrt6/fkeDq8EaEm5/B9KUUpJXKVceVquypUsTHx1JcRTMFT3M5bWJRs87N+Y6 c9SEdTRzmCY67Kb+3mKwFoOby+DF6dcwsvlesS/ceLImq7zbHkWZIvgxwQToYFUsg8eGB6V+EE+
 W+//KhaIfgcUrCF90Vk2JiiO4LW9YI3NkpMDA9kmi6NgXjyfVT2uo0+oIE8GMH8fDaOH9zSyCwj jYRypJl7+wx7JgOTHAA8OpIQmYxFYJAQkdTQTnQgfVAWlkdegmb6okoqrxH5QAmS+9dHAPpdWTh Npvju45xOnplYinCKa44gRzksW1Vzwh1Njd9PHlsaGtzxMqAZJqFhjhVjRTSfUlr3wmgJvNciVv
 9VySrPqm/xMGMuSe7iRHYSTWtUxiZ3N6uWnbyuIvwDKi7m0qcgLTm2P/mdls9xDyzUgnGv4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

MAC address, Link modes (supported and advertised) and eeprom data
for the Netdev interface are read from the shared firmware data.
This patch adds debugfs support for the same.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        | 148 ++++++++++++++++++
 2 files changed, 154 insertions(+), 1 deletion(-)

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
index 0c20642f81b9..900bd1ae240d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -867,6 +867,65 @@ static int rvu_dbg_rvu_pf_cgx_map_display(struct seq_file *filp, void *unused)
 
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
+	seq_printf(s, "\t\texternal clockrate \t :%x\n", fwdata->ptp_ext_clk_rate);
+	seq_printf(s, "\t\texternal timestamp \t :%x\n", fwdata->ptp_ext_tstamp);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\n\t\tSDP CHANNEL INFORMATION\n");
+	seq_puts(s, "\t\t=======================\n");
+	seq_printf(s, "\t\tValid \t\t\t :%x\n", fwdata->channel_data.valid);
+	seq_printf(s, "\t\tNode ID \t\t :%x\n", fwdata->channel_data.info.node_id);
+	seq_printf(s, "\t\tNumner of VFs  \t\t :%x\n", fwdata->channel_data.info.max_vfs);
+	seq_printf(s, "\t\tNumber of PF-Rings \t :%x\n", fwdata->channel_data.info.num_pf_rings);
+	seq_printf(s, "\t\tPF SRN \t\t\t :%x\n", fwdata->channel_data.info.pf_srn);
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
@@ -2923,6 +2982,89 @@ static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
 
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
+	seq_printf(s, "\t\t Link modes \t\t :%llx\n", fwdata->supported_link_modes);
+	seq_printf(s, "\t\t Autoneg \t\t :%llx\n", fwdata->supported_an);
+	seq_printf(s, "\t\t FEC \t\t\t :%llx\n", fwdata->supported_fec);
+	seq_puts(s, "\n");
+
+	seq_puts(s, "\t\tADVERTISED LINK INFORMATION\t\t\n");
+	seq_puts(s, "\t\t==========================\n");
+	seq_printf(s, "\t\t Link modes \t\t :%llx\n", (u64)fwdata->advertised_link_modes);
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
+	seq_printf(s, "\t\t Link modes own \t :%llx\n", (u64)fwdata->advertised_link_modes_own);
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
+	seq_printf(s, "\t\t Mod type configurable \t\t :%x\n", phy->misc.can_change_mod_type);
+	seq_printf(s, "\t\t Mod type \t\t\t :%x\n", phy->misc.mod_type);
+	seq_printf(s, "\t\t Support FEC \t\t\t :%x\n", phy->misc.has_fec_stats);
+	seq_printf(s, "\t\t RSFEC corrected words \t\t :%x\n", phy->fec_stats.rsfec_corr_cws);
+	seq_printf(s, "\t\t RSFEC uncorrected words \t :%x\n", phy->fec_stats.rsfec_uncorr_cws);
+	seq_printf(s, "\t\t BRFEC corrected words \t\t :%x\n", phy->fec_stats.brfec_corr_blks);
+	seq_printf(s, "\t\t BRFEC uncorrected words \t :%x\n", phy->fec_stats.brfec_uncorr_blks);
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
@@ -2962,6 +3104,9 @@ static void rvu_dbg_cgx_init(struct rvu *rvu)
 			debugfs_create_file_aux_num("mac_filter", 0600,
 					    rvu->rvu_dbg.lmac, cgx, lmac_id,
 					    &rvu_dbg_cgx_dmac_flt_fops);
+			debugfs_create_file("fwdata", 0600,
+					    rvu->rvu_dbg.lmac, cgx,
+					    &rvu_dbg_cgx_fwdata_fops);
 		}
 	}
 }
@@ -3808,6 +3953,9 @@ void rvu_dbg_init(struct rvu *rvu)
 		debugfs_create_file("lmtst_map_table", 0444, rvu->rvu_dbg.root,
 				    rvu, &rvu_dbg_lmtst_map_table_fops);
 
+	debugfs_create_file("rvu_fwdata", 0444, rvu->rvu_dbg.root, rvu,
+			    &rvu_dbg_rvu_fwdata_fops);
+
 	if (!cgx_get_cgxcnt_max())
 		goto create;
 
-- 
2.34.1


