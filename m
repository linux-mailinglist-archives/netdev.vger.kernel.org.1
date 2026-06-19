Return-Path: <netdev+bounces-300593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZo/HZHBNGo8gQYAu9opvQ
	(envelope-from <netdev+bounces-300593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:12:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E87796A3C4B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:12:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=cTgwnUAU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300593-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6E130293FF
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530BE3264DA;
	Fri, 19 Jun 2026 04:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0140D599;
	Fri, 19 Jun 2026 04:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842233; cv=none; b=PMsg9oFkPuFxNT6FCceohiUbDb0ZL5uY6LRFFwapXHHrkrkDsMmH9UuWpWo01lJKReiwTrpx3BHbXRuz5OUyRBpGHN+ILkVCVBGToSDb+HDYP0C7AQfLMs8/J9prm9J74qzmOP+xWa66JiYq2hpbXuYi9blCY7JL2KX6YMo0Vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842233; c=relaxed/simple;
	bh=LZty7P2nvh3hz6nomt6R0rdv1kRpZOeVQ0/vBzd1Fnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoRGi4Bro2FYjNbwYWFGDnrrJSRMwhtqXCoMQYQ2atqK5dGuDxUDXfi/YLTuuJHLnYR+kNc/jTQANLQKKpaJUrbkI272tQqs14/vlMpAw1oyXtCvHe8JftBvH9A8Q2teYczNLCirsvjBECkvxVKeUKQfkJpQr99Qgl3pKO2Mr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cTgwnUAU; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2vdE51261877;
	Thu, 18 Jun 2026 21:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=SAgTgvNQJDRn8YhiNhbK7Gy
	OQd2ZasapPI71aNIXMxE=; b=cTgwnUAU2uwHA4q6x9E57iEzWTR/BtO4Mf/9ybD
	fu/6bNKwpE0iDZ74Q9lWoyXxSpP8FTUQ6xn4fgiVFWRvOuQCGWR+V5+Sfc6NQ3g+
	IoiCYBQuTNU4LNx9xnWagTy30lZKYjkO/8QuVkyjcl+1loHZVosCtwnsa+4gDAzT
	metGdkYDFEUjOZc1prNHpTKR7AO3CEnhbuZ7G/5GGF6tEk/9wj32Bf9KvBi7dp/z
	Jp6WXBDb0iZiPEVPXGbbf0XM9AZKgJINpFhnw6HEcIiY3lpHvRu+mSlmX4dBRna8
	ZX+RCyLKIOH5ar0NGQGWHMSBAOpjJTj+gFiu4B0RDtdm2gA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59dcrfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 21:10:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Jun 2026 21:10:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Jun 2026 21:10:20 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AEAA85B693A;
	Thu, 18 Jun 2026 21:10:16 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Hariprasad Kelam <hkelam@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Fri, 19 Jun 2026 09:40:02 +0530
Message-ID: <20260619041002.1773822-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T2vRzRuHu-ZZeQVXJG18JuzK2Pwpk3Fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDAzMyBTYWx0ZWRfX3JLKq9i+dVBM
 RtgdnWZyaetldZ0PlC2fVFNU7NXtCNGoRT8Kcau0OQVOcFX2JHz3EEa5ObKKqrmWGkyv9J2X/ST
 vHlInUPz46c/NyJjBvTZ+12sHdkgJnhQXcaorzzKpS1E4txD9rlNsLaoDPajmnnUOiwlNvcAJPn
 cdKtGjMrtqF+3QNTexBtARVU6Rtzu8fyEWS6bz2a9Himi83OxRjFoTXrsWpeIFSLmkCRyGzyJ3N
 NbwDfmhHnS2VdPxWSoL/UUHTMYy62s84N6sp3gvfWIocA7BA3eAsyhfFcptfAnNbdQH55wtwWxP
 hkDpBdsbl+KMBHrE+LVZc4eyf1KpltQMLOSPPctjusSdDUp4qgkMLLG5EoBT0eTQDu9pjj9Q9o0
 eXL4dgzNP0DFkW8GgK6tWIoiED9XpHnfjFbiBEm7fJmZTFJlor8ysiGKrkZybpPGYq/PNBtvweY
 IB6wDuNyLxG/lVzE0QA==
X-Authority-Analysis: v=2.4 cv=c4Cbhx9l c=1 sm=1 tr=0 ts=6a34c12d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=mwm8SSPRwNU0-m6I1E8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: T2vRzRuHu-ZZeQVXJG18JuzK2Pwpk3Fq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDAzMyBTYWx0ZWRfX/QpVA/tx6dtq
 6/MSVbLBab1BP/mpaCjeqbU3Iw0nued1bAZTxCGjR28NiWGxVr1nsH/21hKlBhGy/xVo+ErdwDT
 BgPo0DaDLa5u/5Jqw+/K2Xfcrd20WPY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300593-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:gakula@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hkelam@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E87796A3C4B

From: Hariprasad Kelam <hkelam@marvell.com>

PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
not reset the LMAC RX PKIND or default TX parse config over the PF setup.

Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.

Fixes: 94d942c5fb97 ("octeontx2-af: Config pkind for CGX mapped PFs")
Cc: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 12 +++++++
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 32 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 13 +++++---
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 2e94d5105016..f5fd6138c352 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -518,6 +518,18 @@ int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind)
 	return 0;
 }
 
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind)
+{
+	struct cgx *cgx = cgxd;
+
+	if (!is_lmac_valid(cgx, lmac_id))
+		return -ENODEV;
+
+	*pkind = cgx_read(cgx, lmac_id, cgx->mac_ops->rxid_map_offset);
+	*pkind = *pkind & 0x3F;
+	return 0;
+}
+
 static u8 cgx_get_lmac_type(void *cgxd, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 92ccf343dfe0..8411a75dd723 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -141,6 +141,7 @@ int cgx_get_cgxid(void *cgxd);
 int cgx_get_lmac_cnt(void *cgxd);
 void *cgx_get_pdata(int cgx_id);
 int cgx_set_pkind(void *cgxd, u8 lmac_id, int pkind);
+int cgx_get_pkind(void *cgxd, u8 lmac_id, int *pkind);
 int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 int cgx_lmac_evh_unregister(void *cgxd, int lmac_id);
 int cgx_get_tx_stats(void *cgxd, int lmac_id, int idx, u64 *tx_stat);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7f3505ae6860..bb671e2150aa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1115,6 +1115,7 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 u8 *intf, u8 *ena);
 int npc_config_cntr_default_entries(struct rvu *rvu, bool enable);
 bool is_cgx_config_permitted(struct rvu *rvu, u16 pcifunc);
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc);
 bool is_mac_feature_supported(struct rvu *rvu, int pf, int feature);
 u32  rvu_cgx_get_fifolen(struct rvu *rvu);
 void *rvu_first_cgx_pdata(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..2be1da3476ac 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1355,3 +1355,35 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
 	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
 		dev_err(rvu->dev, "Failed to reset MAC\n");
 }
+
+/* Do not allow CGX-mapped VFs to overwrite PKIND when special parse kinds
+ * (HiGig, EDSA, etc.) are in use on the shared LMAC.
+ */
+bool rvu_cgx_is_pkind_config_permitted(struct rvu *rvu, u16 pcifunc)
+{
+	int pf, err, rxpkind;
+	u8 cgx_id, lmac_id;
+	void *cgxd;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+
+	if (!(pcifunc & RVU_PFVF_FUNC_MASK))
+		return true;
+
+	if (!is_pf_cgxmapped(rvu, pf))
+		return true;
+
+	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	cgxd = rvu_cgx_pdata(cgx_id, rvu);
+	err = cgx_get_pkind(cgxd, lmac_id, &rxpkind);
+	if (err)
+		return false;
+
+	switch (rxpkind) {
+	case NPC_RX_HIGIG_PKIND:
+	case NPC_RX_EDSA_PKIND:
+		return false;
+	default:
+		return true;
+	}
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d8989395e875..8c5cadd4465d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -363,8 +363,11 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		pfvf->tx_chan_cnt = 1;
 		rsp->tx_link = cgx_id * hw->lmac_per_cgx + lmac_id;
 
-		cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id, pkind);
-		rvu_npc_set_pkind(rvu, pkind, pfvf);
+		if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
+			cgx_set_pkind(rvu_cgx_pdata(cgx_id, rvu), lmac_id,
+				      pkind);
+			rvu_npc_set_pkind(rvu, pkind, pfvf);
+		}
 		break;
 	case NIX_INTF_TYPE_LBK:
 		vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
@@ -1680,8 +1683,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RX_CFG(nixlf), req->rx_cfg);
 
 	/* Configure pkind for TX parse config */
-	cfg = NPC_TX_DEF_PKIND;
-	rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+	if (rvu_cgx_is_pkind_config_permitted(rvu, pcifunc)) {
+		cfg = NPC_TX_DEF_PKIND;
+		rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
+	}
 
 	if (is_rep_dev(rvu, pcifunc)) {
 		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
-- 
2.43.0


