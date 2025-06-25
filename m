Return-Path: <netdev+bounces-201004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80379AE7CEF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DAF1899DEF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03D2DAFB5;
	Wed, 25 Jun 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zxv3b4GG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227729E105;
	Wed, 25 Jun 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843315; cv=none; b=DjFOQEaVTgs8C8t9k2Zd0lK9tjbXRLj9W9fNtwVx05nUad+OHN9M7yKKaKku8us2C6WX2pyNAj4qaYM/ZXKlnAkex0dKZRrrEMsQa/UjgOJO2Mfmnn+UuGqKuziCf1eGyCUA5VEaX4EzTaU8sb0L/KicuIbT4zXiVjHV2RJwzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843315; c=relaxed/simple;
	bh=sL3wTPOBUStDFWraPdGDXIVj/bUgPHAIdhdJFsL/EXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upa7nE/zj/BiZBrRhcG+/GYpSCkaOPapbWjL+XBE+ZupLunOpZt/cIZ6KaiFU40AB4QIDnvovAdqZsUTeguhh3ymqQBmNjOoTdk5tW1G9CQssBU5XtSOXJky8eHJKL3wTa2Fzy/CT6/J0AiQxGO6j1JCfESFAj6lCBlPANDiIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zxv3b4GG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONSlUK032688;
	Wed, 25 Jun 2025 02:21:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	DiTYru47fd3koLpihvY/vsuM7pb7UbeU+UR1676p7U=; b=Zxv3b4GGvvp6uiZsn
	A/w2KcE3UenctR/AbokPTOcxtSlsyApKoiZyzXuSMmUUGRygYUKb46kVUTgbn96p
	GfkW2NeYrM86pQyuSTDTkxJ0gJf41YtYyfyh9pt4j1jmOGhfYI8oWJhFXPGj2r8T
	vN1mOyFlKdFumwFpQXOWRHE+VuHq85U6bJY4DavNpmGZuKwKmRCmaoFukOSrdrEU
	m5vqZ7CRwyem2mttIUgTyuIrv4Txv4LByjFLGe2xPNBK9pxPAMIGAWoboz1/XBRC
	SQaJNOT/fimVoWBM9EKXWCjGXC78A4ZqTgmxh2GOMVQI1IkEDuYg2uFSXDyFlFnr
	/p01Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g5qss2a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:21:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 02:21:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 02:21:42 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 876A03F704F;
	Wed, 25 Jun 2025 02:21:37 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 3/3] Octeontx2-pf: ethtool: support multi advertise mode
Date: Wed, 25 Jun 2025 14:51:07 +0530
Message-ID: <20250625092107.9746-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625092107.9746-1-hkelam@marvell.com>
References: <20250625092107.9746-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OSBTYWx0ZWRfXwH4SYhu4cPY2 cpalfKOrV1g9m4m8UUcnb98owayxlsMNcbhWBEsqv2Yd/ChzMRvVbQ4pPxeR7piSH0zi79NRWFy +U8yiq2em4yNJNcAZkdjRmWdD089lrDriKMBdSIpFLudHora0PuSkk2WrnkU7effZirG9V1ArXH
 ZfsP9JI93TXw1uadh9gHEbq1USrKXgwoF4g5y82OCaUhUAUCvkYqBINBv8w7/NjDt5Q27W9UISW Vf8jvmdc28ZKZTwM9A8ucV9pD6JaQxGyW7r1+8oUL1aSu99KgplJAO9YstRgQ0EkE7S1XjNyFJo /ThrDb0qlYbyf/QJq9OfKeUIaMCaNx58RHR4hU8VpeBJOWIYp8F2YWZy9HMApdwwgvPTLenoGmz
 7ZdztjbkQEbHdkfA4IAazagoA1R4OxMJ2v3ksEzU/ZzFxzkFUVdfDweRsEciDJ2AJN2AHsPz
X-Authority-Analysis: v=2.4 cv=AaqxH2XG c=1 sm=1 tr=0 ts=685bbfa7 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=h0SdlxYgKzDmWoZmwyEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 7bje0VGd0fBTVF9BXzscImfdtS1BHeEn
X-Proofpoint-ORIG-GUID: 7bje0VGd0fBTVF9BXzscImfdtS1BHeEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01

Current implementation considers only first advertise
mode and passes the same to firmware to process.
This patch extends code such that user can advertise
multiple modes on the given interface.

Below are high level changes:

1. Remove unnecessary speed/duplex/autoneg validation as its
   already verified as part of "set_link_ksettings"

2. Since scratch csr framework designed to support single mode at a time,
   use "shared firmware data" for multi mode support.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 32 +++++++++++--------
 .../net/ethernet/marvell/octeontx2/af/cgx.h   |  1 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 ++--
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   |  9 +++++-
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 30 ++++++++---------
 5 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 5c2435f39308..846ee2b9edf1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1185,15 +1185,10 @@ static void set_mod_args(struct cgx_set_link_mode_args *args,
 	int mode_baseidx;
 	u8 cgx_mode;
 
-	/* Fill default values incase of user did not pass
-	 * valid parameters
-	 */
-	if (args->duplex == DUPLEX_UNKNOWN)
-		args->duplex = duplex;
-	if (args->speed == SPEED_UNKNOWN)
-		args->speed = speed;
-	if (args->an == AUTONEG_UNKNOWN)
-		args->an = autoneg;
+	if (args->multimode) {
+		args->mode |= mode;
+		return;
+	}
 
 	/* Derive mode_base_idx and mode fields based
 	 * on cgx_mode value
@@ -1494,18 +1489,29 @@ int cgx_get_fwdata_base(u64 *base)
 }
 
 int cgx_set_link_mode(void *cgxd, struct cgx_set_link_mode_args args,
+		      struct cgx_lmac_fwdata_s *linkmodes,
 		      int cgx_id, int lmac_id)
 {
 	struct cgx *cgx = cgxd;
 	u64 req = 0, resp;
+	u8 bit;
 
 	if (!cgx)
 		return -ENODEV;
 
-	if (args.mode)
-		otx2_map_ethtool_link_modes(args.mode, &args);
-	if (!args.speed && args.duplex && !args.an)
-		return -EINVAL;
+	for_each_set_bit(bit, args.advertising,
+			 __ETHTOOL_LINK_MODE_MASK_NBITS)
+		otx2_map_ethtool_link_modes(bit, &args);
+
+	if (args.multimode) {
+		if (linkmodes->advertised_link_modes_own != CGX_CMD_OWN_NS)
+			return -EBUSY;
+
+		linkmodes->advertised_link_modes = args.mode;
+		/* Update ownership */
+		linkmodes->advertised_link_modes_own = CGX_CMD_OWN_FIRMWARE;
+		args.mode = GENMASK_ULL(41, 0);
+	}
 
 	req = FIELD_SET(CMDREG_ID, CGX_CMD_MODE_CHANGE, req);
 	req = FIELD_SET(CMDMODECHANGE_SPEED,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 1cf12e5c7da8..950231e7ea71 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -171,6 +171,7 @@ int cgx_set_fec(u64 fec, int cgx_id, int lmac_id);
 int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp);
 int cgx_get_phy_fec_stats(void *cgxd, int lmac_id);
 int cgx_set_link_mode(void *cgxd, struct cgx_set_link_mode_args args,
+		      struct cgx_lmac_fwdata_s *linkmodes,
 		      int cgx_id, int lmac_id);
 u64 cgx_features_get(void *cgxd);
 struct mac_ops *get_mac_ops(void *cgxd);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2fc6b0ba7494..0bc0dc79868b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -10,6 +10,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/sizes.h>
+#include <linux/ethtool.h>
 
 #include "rvu_struct.h"
 #include "common.h"
@@ -658,7 +659,8 @@ struct cgx_lmac_fwdata_s {
 	u64 supported_link_modes;
 	/* only applicable if AN is supported */
 	u64 advertised_fec;
-	u64 advertised_link_modes;
+	u64 advertised_link_modes_own:1; /* CGX_CMD_OWN */
+	u64 advertised_link_modes:63;
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
@@ -676,11 +678,12 @@ struct cgx_set_link_mode_args {
 	u8 duplex;
 	u8 an;
 	u8 mode_baseidx;
+	u8 multimode;
 	u64 mode;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
 };
 
 struct cgx_set_link_mode_req {
-#define AUTONEG_UNKNOWN		0xff
 	struct mbox_msghdr hdr;
 	struct cgx_set_link_mode_args args;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index b79db887ab9b..890a1a5df2de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -1223,6 +1223,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 				       struct cgx_set_link_mode_rsp *rsp)
 {
 	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
+	struct cgx_lmac_fwdata_s *linkmodes;
 	u8 cgx_idx, lmac;
 	void *cgxd;
 
@@ -1231,7 +1232,13 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
 	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
-	rsp->status = cgx_set_link_mode(cgxd, req->args, cgx_idx, lmac);
+	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
+		linkmodes = &rvu->fwdata->cgx_fw_data_usx[cgx_idx][lmac];
+	else
+		linkmodes = &rvu->fwdata->cgx_fw_data[cgx_idx][lmac];
+
+	rsp->status = cgx_set_link_mode(cgxd, req->args, linkmodes,
+					cgx_idx, lmac);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index ae1cdd51b9fb..20de517dfb09 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1212,23 +1212,10 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
-static void otx2_get_advertised_mode(const struct ethtool_link_ksettings *cmd,
-				     u64 *mode)
-{
-	u32 bit_pos;
-
-	/* Firmware does not support requesting multiple advertised modes
-	 * return first set bit
-	 */
-	bit_pos = find_first_bit(cmd->link_modes.advertising,
-				 __ETHTOOL_LINK_MODE_MASK_NBITS);
-	if (bit_pos != __ETHTOOL_LINK_MODE_MASK_NBITS)
-		*mode = bit_pos;
-}
-
 static int otx2_set_link_ksettings(struct net_device *netdev,
 				   const struct ethtool_link_ksettings *cmd)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct otx2_nic *pf = netdev_priv(netdev);
 	struct ethtool_link_ksettings cur_ks;
 	struct cgx_set_link_mode_req *req;
@@ -1265,7 +1252,20 @@ static int otx2_set_link_ksettings(struct net_device *netdev,
 	 */
 	req->args.duplex = cmd->base.duplex ^ 0x1;
 	req->args.an = cmd->base.autoneg;
-	otx2_get_advertised_mode(cmd, &req->args.mode);
+	/* Mask unsupported modes and send message to AF */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT, mask);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT, mask);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT, mask);
+
+	linkmode_copy(req->args.advertising,
+		      cmd->link_modes.advertising);
+	linkmode_andnot(req->args.advertising,
+			req->args.advertising, mask);
+
+	/* inform AF that we need parse this differently */
+	if (bitmap_weight(req->args.advertising,
+			  __ETHTOOL_LINK_MODE_MASK_NBITS) >= 2)
+		req->args.multimode = true;
 
 	err = otx2_sync_mbox_msg(&pf->mbox);
 end:
-- 
2.34.1


