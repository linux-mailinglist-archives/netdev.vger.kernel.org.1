Return-Path: <netdev+bounces-249403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17084D18041
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9225E3020267
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333B3904CF;
	Tue, 13 Jan 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fdnLbZ9I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAC38FF02;
	Tue, 13 Jan 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299478; cv=none; b=p+RABvbO/z3Cp/O7LDBR9KPdA/nsIByENjhxeBmqTTCdNmDcELX40Mg+jd/+8Yqv/gEB/uG+apNM+OQ4Wnma6C0t2E6AW0xAJn3s8LA4Sg636Ednz2x11Xb8cYaPYUyFa6d7Ata9k0RawYyiA2a+BsN8dyUJGpZLrrEhcQSj9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299478; c=relaxed/simple;
	bh=rBH5LZn6EEZ3aNnM3aKa6wO3oG0lh7eDQQ17f0ChjeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzXNtve/cjPdKMAjbBbOIGgpo9qWJgcWMtgrVNqanLkfMOJuL5S3YO+VE/U1PtnzTg6WQuUYKJbMx+PEOmDp/AIxWJuznfPCb8FyJqvgcCShajhQ3ETGxPpeIuI7i36xksbJuF5wL8TfkljKPks7NaAKYDwJZ0w/3LhZosoOWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fdnLbZ9I; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q9rl449708;
	Tue, 13 Jan 2026 02:17:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	dB8TDEHZmEnI2Mluzkf9GakYHLT9A34CmXmfba0OZ8=; b=fdnLbZ9IKoZyuauST
	SgWBDmGyfOYhzzskB2jLmWmAb+rWs6oU1DW4CEArhk29dmaaLOn7jrHp/C7AnVRP
	JYD51pS4JATYR1itfsQ1ncUUIeyE7QF+xtjLLg/rm74kWCwTUBDlOUeUdPJ3+6sz
	141+8hvb9glDC2qPP6Tgnp/9Gr2MW8MJkth4MoFfzAxFfQ4FJO0rVHPRACKC6Ky7
	YJiq5tCcHnL3XxWqNWmvX53nlK9q1knmfjJ89iJyCSAbBD7AwW2KODWqMnNpieZR
	gJ8b3VZTn5KchPzngD20OurraM38qB3eudI+oKc8QltpIWpQvV4mx7zjeAidXEv9
	2r3tA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bngnq8dne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:17:47 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:18:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:18:02 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 510483F7096;
	Tue, 13 Jan 2026 02:17:44 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v4 13/13] octeontx2-af: npc: Use common structures
Date: Tue, 13 Jan 2026 15:46:58 +0530
Message-ID: <20260113101658.4144610-14-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113101658.4144610-1-rkannoth@marvell.com>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DLeCIiNb c=1 sm=1 tr=0 ts=69661bcb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=bNx57pydN-Y4TXDtlhsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Wd22ZhJM_VyT6ai6ahJXHgFU0cCT5QoJ
X-Proofpoint-ORIG-GUID: Wd22ZhJM_VyT6ai6ahJXHgFU0cCT5QoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NyBTYWx0ZWRfX1sXjjAxV45gR
 YncaaazeSxi6RMz/AVfqiS2V9gaXTrGYeBSd5rzPc9SLUUy3k9v6iHAF+N/Odti1rxUJc51pELr
 WuSQkBUHRwi+QvpjP/PR3uXfR+pg4k1akM0fZA9A209m5ibIOTRmg91TkFzQ0E35wdNMi6tmzEm
 OjONbZjjUBCZsdKIP0jL+wO+n68/uF5+ljEFRvHso57uYVaolf8+g0F7k5I83qUw7ss/g80BBkN
 f6pmD3t18cRqN9umWneqoMLADUrzAWnj/o1+fRWpEjTZR0vwKdRaA9/53lilR7/IXn3x9c4sTKj
 fr5lGIJK2J7YjwSesHClwdaQtFqI4ADrcPDRj5jh7IpjeQ8Iea1/Hw16HwNCiCDgDQbJa/Fp21u
 4pOAKuf1an0mvisJGI3nP1d2LF4sdQbL4O8ktimHmrd82vyF21ZzCdTs6L+LxzpeBEUmISiQDqr
 oHRH63j7u2ffJuncyfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

CN20K and legacy silicon differ in the size of key words used
in NPC MCAM. However, SoC-specific structures are not required
for low-level functions. Remove the SoC-specific structures
and rename the macros to improve readability.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 11 ++++---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 16 ++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 31 ++++++++-----------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 6f35ff94202e..ac9e95cc3755 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -3986,10 +3986,10 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 				     struct npc_get_num_kws_req *req,
 				     struct npc_get_num_kws_rsp *rsp)
 {
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
+	u64 kw[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
 	struct rvu_npc_mcam_rule dummy = { 0 };
-	struct cn20k_mcam_entry cn20k_entry = { 0 };
 	struct mcam_entry_mdata mdata = { };
-	struct mcam_entry entry = { 0 };
 	struct npc_install_flow_req *fl;
 	int i, cnt = 0, blkaddr;
 
@@ -4006,7 +4006,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 		return NPC_MCAM_INVALID_REQ;
 	}
 
-	npc_populate_mcam_mdata(rvu, &mdata, &cn20k_entry, &entry);
+	mdata.kw = kw;
+	mdata.kw_mask = kw_mask;
 
 	npc_update_flow(rvu, &mdata, fl->features, &fl->packet,
 			&fl->mask, &dummy, fl->intf, blkaddr);
@@ -4014,8 +4015,8 @@ int rvu_mbox_handler_npc_get_num_kws(struct rvu *rvu,
 	/* Find the most significant word valid. Traverse from
 	 * MSB to LSB, check if cam0 or cam1 is set
 	 */
-	for (i = NPC_CN20K_MAX_KWS_IN_KEY - 1; i >= 0; i--) {
-		if (cn20k_entry.kw[i] || cn20k_entry.kw_mask[i]) {
+	for (i = NPC_KWS_IN_KEY_SZ_MAX - 1; i >= 0; i--) {
+		if (kw[i] || kw_mask[i]) {
 			cnt = i + 1;
 			break;
 		}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2d9f6cb4820f..dc42c81c0942 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1593,18 +1593,22 @@ struct mcam_entry_mdata {
 	u8 max_kw;
 };
 
+enum npc_kws_in_key_sz {
+	NPC_KWS_IN_KEY_SZ_7 = 7,
+	NPC_KWS_IN_KEY_SZ_8 = 8,
+	NPC_KWS_IN_KEY_SZ_MAX,
+};
+
 struct mcam_entry {
-#define NPC_MAX_KWS_IN_KEY	7 /* Number of keywords in max keywidth */
-	u64	kw[NPC_MAX_KWS_IN_KEY];
-	u64	kw_mask[NPC_MAX_KWS_IN_KEY];
+	u64	kw[NPC_KWS_IN_KEY_SZ_7];
+	u64	kw_mask[NPC_KWS_IN_KEY_SZ_7];
 	u64	action;
 	u64	vtag_action;
 };
 
 struct cn20k_mcam_entry {
-#define NPC_CN20K_MAX_KWS_IN_KEY	8
-	u64	kw[NPC_CN20K_MAX_KWS_IN_KEY];
-	u64	kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64	kw[NPC_KWS_IN_KEY_SZ_8];
+	u64	kw_mask[NPC_KWS_IN_KEY_SZ_8];
 	u64	action;
 	u64	vtag_action;
 	u64	action2;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index f811d6b5c545..a466181cf908 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -197,7 +197,7 @@ struct npc_key_field {
 	/* Masks where all set bits indicate position
 	 * of a field in the key
 	 */
-	u64 kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX];
 	/* Number of words in the key a field spans. If a field is
 	 * of 16 bytes and key offset is 4 then the field will use
 	 * 4 bytes in KW0, 8 bytes in KW1 and 4 bytes in KW2 and
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c5e466c7e514..cb33c213ba47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -227,7 +227,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 		input = &mcam->tx_key_fields[type];
 	}
 
-	kws = NPC_MAX_KWS_IN_KEY;
+	kws = NPC_KWS_IN_KEY_SZ_7;
 
 	if (is_cn20k(rvu->pdev))
 		goto skip_cn10k_config;
@@ -289,7 +289,7 @@ static bool npc_check_overlap(struct rvu *rvu, int blkaddr,
 			 * field bits
 			 */
 			if (npc_check_overlap_fields(dummy, input,
-						     NPC_CN20K_MAX_KWS_IN_KEY))
+						     NPC_KWS_IN_KEY_SZ_8))
 				return true;
 		}
 	}
@@ -460,9 +460,9 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	u8 start_lid;
 
 	if (is_cn20k(rvu->pdev))
-		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_8;
 	else
-		max_kw = NPC_MAX_KWS_IN_KEY;
+		max_kw = NPC_KWS_IN_KEY_SZ_7;
 
 	key_fields = mcam->rx_key_fields;
 	features = &mcam->rx_features;
@@ -906,12 +906,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 		      struct mcam_entry_mdata *mdata, u64 val_lo,
 		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf)
 {
-	struct cn20k_mcam_entry cn20k_dummy = { {0} };
+	u64 kw_mask[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
+	u64 kw[NPC_KWS_IN_KEY_SZ_MAX] = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct mcam_entry dummy = { {0} };
-	u64 *kw, *kw_mask, *val, *mask;
 	struct npc_key_field *field;
 	u64 kw1, kw2, kw3;
+	u64 *val, *mask;
 	int i, max_kw;
 	u8 shift;
 
@@ -922,15 +922,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
 	if (!field->nr_kws)
 		return;
 
-	if (is_cn20k(rvu->pdev)) {
-		max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
-		kw = cn20k_dummy.kw;
-		kw_mask = cn20k_dummy.kw_mask;
-	} else {
-		max_kw = NPC_MAX_KWS_IN_KEY;
-		kw = dummy.kw;
-		kw_mask = dummy.kw_mask;
-	}
+	if (is_cn20k(rvu->pdev))
+		max_kw = NPC_KWS_IN_KEY_SZ_8;
+	else
+		max_kw = NPC_KWS_IN_KEY_SZ_7;
 
 	for (i = 0; i < max_kw; i++) {
 		if (!field->kw_mask[i])
@@ -1315,14 +1310,14 @@ npc_populate_mcam_mdata(struct rvu *rvu,
 		mdata->kw_mask = cn20k_entry->kw_mask;
 		mdata->action = &cn20k_entry->action;
 		mdata->vtag_action = &cn20k_entry->vtag_action;
-		mdata->max_kw = NPC_CN20K_MAX_KWS_IN_KEY;
+		mdata->max_kw = NPC_KWS_IN_KEY_SZ_8;
 		return;
 	}
 	mdata->kw = entry->kw;
 	mdata->kw_mask = entry->kw_mask;
 	mdata->action = &entry->action;
 	mdata->vtag_action = &entry->vtag_action;
-	mdata->max_kw = NPC_MAX_KWS_IN_KEY;
+	mdata->max_kw = NPC_KWS_IN_KEY_SZ_7;
 }
 
 static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-- 
2.43.0


