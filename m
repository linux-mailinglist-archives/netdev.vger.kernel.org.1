Return-Path: <netdev+bounces-249393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAED17F6F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5283E305E865
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9938BF80;
	Tue, 13 Jan 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="di9YvbyN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791A38170B;
	Tue, 13 Jan 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299450; cv=none; b=HJ9qjBVlPfWnsqHHcCvWPSZtGz0kjW3AWECZwuuXRfiHg7CJ7UKemVXuiJSvHOX7FNrC6t+FGpWZLCsxAIZUL7/GMr6FzDwvdx58iCIAD7olokvrptPy2gb1UqlH2EDufbzKx8OZpFr9QWtEA/R+ezYBQQKmIqjQx8ODY9zn8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299450; c=relaxed/simple;
	bh=4sbAnetNcKKsaiRbuKbCCNnSetASzWIvEGCmRNGP9RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVbYKSFg5mNhPc6nyNrZwbdhoHz9v326qBsnWa37s7x7nRZdYTSAcfbl6aWeObz17NDnyqUY9bo9eXbNQLVWybINIfizi+YM9ktWYWo2JicwlS7jkwAaZ5xlHz7OoIcfGE5bavyA+k7vtWPVvTCsz3WlE2rOCjTLNMKBBsWkXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=di9YvbyN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7Q5qG2460532;
	Tue, 13 Jan 2026 02:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	7S2dnsPJMLRwo1ygTAH1tGmnTBIWPLpRHPaGoDYtOc=; b=di9YvbyN5nOWX1Hr4
	MoMjds14Rjbbceh3C/l0xgB9cAmXx77WvLqaKcbiX6BRolPoGj0Olu3mtgPraMdm
	HYqQgk1/v5cQd1I8FEENzHqWr8/0iEE7YjC2vK6V+nrP6Tp1TLga+JqjdazvAYYk
	wKYKhKXqQscHSg26c4A93d/ixfT6X4FGUG695FOy9WiHH7EG/hI83TQ0sBkMtSy1
	NqdUA4W5NKEUOAfBcwDrySBF7lSxGr1NUw00YOO9sqdmuvLhdOUVA4DGTogR2jw6
	kIz2u5NGuk9IE38xbfAy5Mr8d0bVoovG3U6x5tFDykddSjRjCQRWRGJOzwUOCx/n
	2+G3g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bmvfkbcw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:17:15 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 13 Jan 2026 02:17:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 13 Jan 2026 02:17:14 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2AD683F7096;
	Tue, 13 Jan 2026 02:17:10 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next v4 03/13] octeontx2-af: npc: cn20k: Add default profile
Date: Tue, 13 Jan 2026 15:46:48 +0530
Message-ID: <20260113101658.4144610-4-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4NyBTYWx0ZWRfXxU4GHCPziq7S
 b1oKdUJJX3j3AL4zkkYfns4eprTn6M+NvN0vrVo0VwFH+CyrM+LRRBPf29lA597SUt4JmQsz5Kh
 vxKxeeXeoiTO8dWUZKVNbMfnG8mUYGbiGEZXKfMspMdOTmJrLpLMLBwMCaybiaBipNNTaVFvPf0
 qI2NTPz9C+TKsOuMw06EUpdrMihlhBAtTZ9u/eyCpdK52kwF/h+7GfJBG9VfIdYK9h9FzNfaGtc
 6EF9cgzaY5ng3sv8kXpQcPEp3xHfE/nw0OTjCYNRLbuDP3RFiTLUSgsrURhuMf5ANuVMmWvSZk8
 0Uxu0po8HwUcb21Kkvn62Pi99CwepjiEKOKHS+jHpI+AIPXBy0eQkJUa0OST6w/OIfGkfXkAZzq
 BRWDyNJtZYeHBi7++RgE51OXvjxso7GuuTECZbzQcdzoifoJ0T7/B5VbW1JYpU71We8iY4rIPea
 qB1GdriDICjQP6DiOJA==
X-Proofpoint-GUID: _2ov5kuN6mZaJRSly3I2_cER_ZhqiwGU
X-Proofpoint-ORIG-GUID: _2ov5kuN6mZaJRSly3I2_cER_ZhqiwGU
X-Authority-Analysis: v=2.4 cv=AZe83nXG c=1 sm=1 tr=0 ts=69661bab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=NGP3fZmBk5oLfH1lOsUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Default mkex profile for cn20k silicon. This commit
changes attribute of objects to may_be_unused to
avoid compiler warning

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 176 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  18 ++
 .../marvell/octeontx2/af/npc_profile.h        |  72 +++----
 3 files changed, 229 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 8b9424bfcdcf..0717fd66e8a1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -7,9 +7,13 @@
 #include <linux/xarray.h>
 #include <linux/bitfield.h>
 
+#include "rvu.h"
+#include "npc.h"
+#include "npc_profile.h"
+#include "rvu_npc_hash.h"
+#include "rvu_npc.h"
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
-#include "rvu_npc.h"
 
 static struct npc_priv_t npc_priv = {
 	.num_banks = MAX_NUM_BANKS,
@@ -21,6 +25,176 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
 	[NPC_MCAM_KEY_X4] = "X4",
 };
 
+#define KEX_EXTR_CFG(bytesm1, hdr_ofs, ena, key_ofs)		\
+		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
+		     ((key_ofs) & 0x3F))
+
+static struct npc_mcam_kex_extr npc_mkex_extr_default = {
+	.mkex_sign = MKEX_SIGN,
+	.name = "default",
+	.kpu_version = NPC_KPU_PROFILE_VER,
+	.keyx_cfg = {
+		/* nibble: LA..LE (ltype only) + Error code + Channel */
+		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) |
+			NPC_PARSE_NIBBLE_INTF_RX |
+				 NPC_PARSE_NIBBLE_ERRCODE,
+
+		/* nibble: LA..LE (ltype only) */
+		[NIX_INTF_TX] = ((u64)NPC_MCAM_KEY_X2 << 32) |
+			NPC_PARSE_NIBBLE_INTF_TX,
+	},
+	.intf_extr_lid = {
+	/* Default RX MCAM KEX profile */
+	[NIX_INTF_RX] = { NPC_LID_LA, NPC_LID_LA, NPC_LID_LB, NPC_LID_LB,
+			  NPC_LID_LC, NPC_LID_LC, NPC_LID_LD },
+	[NIX_INTF_TX] = { NPC_LID_LA, NPC_LID_LA, NPC_LID_LB, NPC_LID_LB,
+			  NPC_LID_LC, NPC_LID_LD },
+	},
+	.intf_extr_lt = {
+	/* Default RX MCAM KEX profile */
+	[NIX_INTF_RX] = {
+		[0] = {
+			/* Layer A: Ethernet: */
+			[NPC_LT_LA_ETHER] =
+				/* DMAC: 6 bytes, KW1[63:15] */
+				KEX_EXTR_CFG(0x05, 0x0, 0x1,
+					     NPC_KEXOF_DMAC + 1),
+			[NPC_LT_LA_CPT_HDR] =
+				/* DMAC: 6 bytes, KW1[63:15] */
+				KEX_EXTR_CFG(0x05, 0x0, 0x1,
+					     NPC_KEXOF_DMAC + 1),
+		},
+		[1] = {
+			/* Layer A: Ethernet: */
+			[NPC_LT_LA_ETHER] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0xc, 0x1, 0x6),
+			[NPC_LT_LA_CPT_HDR] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0xc, 0x1, 0x6),
+		},
+		[2] = {
+			/* Layer B: Single VLAN (CTAG) */
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN: 2 bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x8),
+			/* Layer B: Stacked VLAN (STAG|QinQ) */
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x8),
+			[NPC_LT_LB_FDSA] =
+				/* SWITCH PORT: 1 byte, KW1[7:0] */
+				KEX_EXTR_CFG(0x0, 0x1, 0x1, 0x8),
+		},
+		[3] = {
+			[NPC_LT_LB_CTAG] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x6),
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x8, 0x1, 0x6),
+			[NPC_LT_LB_FDSA] =
+				/* Ethertype: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x6),
+		},
+		[4] = {
+			/* Layer C: IPv4 */
+			[NPC_LT_LC_IP] =
+				/* SIP+DIP: 8 bytes, KW3[7:0], KW2[63:8] */
+				KEX_EXTR_CFG(0x07, 0xc, 0x1, 0x11),
+			/* Layer C: IPv6 */
+			[NPC_LT_LC_IP6] =
+				/* Everything up to SADDR: 8 bytes, KW3[7:0],
+				 * KW2[63:8]
+				 */
+				KEX_EXTR_CFG(0x07, 0x0, 0x1, 0x11),
+		},
+		[5] = {
+			[NPC_LT_LC_IP] =
+				/* TOS: 1 byte, KW2[7:0] */
+				KEX_EXTR_CFG(0x0, 0x1, 0x1, 0x10),
+		},
+		[6] = {
+			/* Layer D:UDP */
+			[NPC_LT_LD_UDP] =
+				/* SPORT+DPORT: 4 bytes, KW3[39:8] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x19),
+			/* Layer D:TCP */
+			[NPC_LT_LD_TCP] =
+				/* SPORT+DPORT: 4 bytes, KW3[39:8] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x19),
+		},
+	},
+	/* Default TX MCAM KEX profile */
+	[NIX_INTF_TX] = {
+		[0] = {
+			/* Layer A: NIX_INST_HDR_S + Ethernet */
+			/* NIX appends 8 bytes of NIX_INST_HDR_S at the
+			 * start of each TX packet supplied to NPC.
+			 */
+			[NPC_LT_LA_IH_NIX_ETHER] =
+				/* PF_FUNC: 2B , KW0 [47:32] */
+				KEX_EXTR_CFG(0x01, 0x0, 0x1, 0x4),
+			/* Layer A: HiGig2: */
+			[NPC_LT_LA_IH_NIX_HIGIG2_ETHER] =
+				/* PF_FUNC: 2B , KW0 [47:32] */
+				KEX_EXTR_CFG(0x01, 0x0, 0x1, 0x4),
+		},
+		[1] = {
+			[NPC_LT_LA_IH_NIX_ETHER] =
+				/* SQ_ID 3 bytes, KW1[63:16] */
+				KEX_EXTR_CFG(0x02, 0x02, 0x1, 0xa),
+			[NPC_LT_LA_IH_NIX_HIGIG2_ETHER] =
+				/* VID: 2 bytes, KW1[31:16] */
+				KEX_EXTR_CFG(0x01, 0x10, 0x1, 0xa),
+		},
+		[2] = {
+			/* Layer B: Single VLAN (CTAG) */
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN[2..3] KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x6),
+			/* Layer B: Stacked VLAN (STAG|QinQ) */
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 bytes, KW0[63:48] */
+				KEX_EXTR_CFG(0x01, 0x2, 0x1, 0x6),
+		},
+		[3] = {
+			[NPC_LT_LB_CTAG] =
+				/* CTAG VLAN[2..3] KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x4, 0x1, 0x8),
+			[NPC_LT_LB_STAG_QINQ] =
+				/* Outer VLAN: 2 Bytes, KW1[15:0] */
+				KEX_EXTR_CFG(0x01, 0x8, 0x1, 0x8),
+		},
+		[4] = {
+			/* Layer C: IPv4 */
+			[NPC_LT_LC_IP] =
+				/* SIP+DIP: 8 bytes, KW2[63:0] */
+				KEX_EXTR_CFG(0x07, 0xc, 0x1, 0x10),
+			/* Layer C: IPv6 */
+			[NPC_LT_LC_IP6] =
+				/* Everything up to SADDR: 8 bytes, KW2[63:0] */
+				KEX_EXTR_CFG(0x07, 0x0, 0x1, 0x10),
+		},
+		[5] = {
+			/* Layer D:UDP */
+			[NPC_LT_LD_UDP] =
+				/* SPORT+DPORT: 4 bytes, KW3[31:0] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x18),
+			/* Layer D:TCP */
+			[NPC_LT_LD_TCP] =
+				/* SPORT+DPORT: 4 bytes, KW3[31:0] */
+				KEX_EXTR_CFG(0x3, 0x0, 0x1, 0x18),
+		},
+	},
+	},
+};
+
+struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void)
+{
+	return &npc_mkex_extr_default;
+}
+
 static void npc_config_kpmcam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpm, int entry)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
index fa675f71cb7e..635c9294dbcc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
@@ -130,6 +130,23 @@ struct npc_kpm_action0 {
 #endif
 };
 
+struct npc_mcam_kex_extr {
+	/* MKEX Profle Header */
+	u64 mkex_sign; /* "mcam-kex-profile" (8 bytes/ASCII characters) */
+	u8 name[MKEX_NAME_LEN];   /* MKEX Profile name */
+	u64 cpu_model;   /* Format as profiled by CPU hardware */
+	u64 kpu_version; /* KPU firmware/profile version */
+	u64 reserved; /* Reserved for extension */
+
+	/* MKEX Profle Data */
+	u64 keyx_cfg[NPC_MAX_INTF]; /* NPC_AF_INTF(0..1)_KEX_CFG */
+#define NPC_MAX_EXTRACTOR	24
+	/* MKEX Extractor data */
+	u64 intf_extr_lid[NPC_MAX_INTF][NPC_MAX_EXTRACTOR];
+	/* KEX configuration per extractor */
+	u64 intf_extr_lt[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
+} __packed;
+
 struct rvu;
 
 struct npc_priv_t *npc_priv_get(void);
@@ -146,5 +163,6 @@ int npc_cn20k_idx_free(struct rvu *rvu, u16 *mcam_idx, int count);
 int npc_cn20k_search_order_set(struct rvu *rvu, int (*arr)[2], int cnt);
 const int *npc_cn20k_search_order_get(bool *restricted_order);
 void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr);
+struct npc_mcam_kex_extr *npc_mkex_extr_default_get(void);
 
 #endif /* NPC_CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index 41de72c8607f..561b01fcdbde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -489,7 +489,7 @@ enum NPC_ERRLEV_E {
 		0, 0, 0, 0,			\
 	}
 
-static struct npc_kpu_profile_action ikpu_action_entries[] = {
+static struct npc_kpu_profile_action ikpu_action_entries[] __maybe_unused = {
 	{
 		NPC_ERRLEV_RE, NPC_EC_NOERR,
 		12, 16, 20, 0, 0,
@@ -1068,7 +1068,7 @@ static struct npc_kpu_profile_action ikpu_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu1_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu1_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -1878,7 +1878,7 @@ static struct npc_kpu_profile_cam kpu1_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu2_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu2_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -2823,7 +2823,7 @@ static struct npc_kpu_profile_cam kpu2_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu3_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu3_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -3804,7 +3804,7 @@ static struct npc_kpu_profile_cam kpu3_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu4_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu4_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -4119,7 +4119,7 @@ static struct npc_kpu_profile_cam kpu4_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu5_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -5172,7 +5172,7 @@ static struct npc_kpu_profile_cam kpu5_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu6_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -5901,7 +5901,7 @@ static struct npc_kpu_profile_cam kpu6_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu7_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -6252,7 +6252,7 @@ static struct npc_kpu_profile_cam kpu7_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu8_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7089,7 +7089,7 @@ static struct npc_kpu_profile_cam kpu8_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu9_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu9_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7575,7 +7575,7 @@ static struct npc_kpu_profile_cam kpu9_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu10_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu10_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -7746,7 +7746,7 @@ static struct npc_kpu_profile_cam kpu10_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu11_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu11_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8061,7 +8061,7 @@ static struct npc_kpu_profile_cam kpu11_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu12_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu12_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8322,7 +8322,7 @@ static struct npc_kpu_profile_cam kpu12_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu13_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu13_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8340,7 +8340,7 @@ static struct npc_kpu_profile_cam kpu13_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu14_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu14_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8358,7 +8358,7 @@ static struct npc_kpu_profile_cam kpu14_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu15_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu15_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8565,7 +8565,7 @@ static struct npc_kpu_profile_cam kpu15_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_cam kpu16_cam_entries[] = {
+static struct npc_kpu_profile_cam kpu16_cam_entries[] __maybe_unused = {
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
 	NPC_KPU_NOP_CAM,
@@ -8628,7 +8628,7 @@ static struct npc_kpu_profile_cam kpu16_cam_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu1_action_entries[] = {
+static struct npc_kpu_profile_action kpu1_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -9368,7 +9368,7 @@ static struct npc_kpu_profile_action kpu1_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu2_action_entries[] = {
+static struct npc_kpu_profile_action kpu2_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -10209,7 +10209,7 @@ static struct npc_kpu_profile_action kpu2_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu3_action_entries[] = {
+static struct npc_kpu_profile_action kpu3_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -11082,7 +11082,7 @@ static struct npc_kpu_profile_action kpu3_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu4_action_entries[] = {
+static struct npc_kpu_profile_action kpu4_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -11363,7 +11363,7 @@ static struct npc_kpu_profile_action kpu4_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu5_action_entries[] = {
+static struct npc_kpu_profile_action kpu5_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -12300,7 +12300,7 @@ static struct npc_kpu_profile_action kpu5_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu6_action_entries[] = {
+static struct npc_kpu_profile_action kpu6_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -12949,7 +12949,7 @@ static struct npc_kpu_profile_action kpu6_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu7_action_entries[] = {
+static struct npc_kpu_profile_action kpu7_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -13262,7 +13262,7 @@ static struct npc_kpu_profile_action kpu7_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu8_action_entries[] = {
+static struct npc_kpu_profile_action kpu8_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14007,7 +14007,7 @@ static struct npc_kpu_profile_action kpu8_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu9_action_entries[] = {
+static struct npc_kpu_profile_action kpu9_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14440,7 +14440,7 @@ static struct npc_kpu_profile_action kpu9_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu10_action_entries[] = {
+static struct npc_kpu_profile_action kpu10_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14593,7 +14593,7 @@ static struct npc_kpu_profile_action kpu10_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu11_action_entries[] = {
+static struct npc_kpu_profile_action kpu11_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -14874,7 +14874,7 @@ static struct npc_kpu_profile_action kpu11_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu12_action_entries[] = {
+static struct npc_kpu_profile_action kpu12_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15107,7 +15107,7 @@ static struct npc_kpu_profile_action kpu12_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu13_action_entries[] = {
+static struct npc_kpu_profile_action kpu13_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15124,7 +15124,7 @@ static struct npc_kpu_profile_action kpu13_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu14_action_entries[] = {
+static struct npc_kpu_profile_action kpu14_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15141,7 +15141,7 @@ static struct npc_kpu_profile_action kpu14_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu15_action_entries[] = {
+static struct npc_kpu_profile_action kpu15_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15326,7 +15326,7 @@ static struct npc_kpu_profile_action kpu15_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile_action kpu16_action_entries[] = {
+static struct npc_kpu_profile_action kpu16_action_entries[] __maybe_unused = {
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
 	NPC_KPU_NOP_ACTION,
@@ -15383,7 +15383,7 @@ static struct npc_kpu_profile_action kpu16_action_entries[] = {
 	},
 };
 
-static struct npc_kpu_profile npc_kpu_profiles[] = {
+static struct npc_kpu_profile npc_kpu_profiles[] __maybe_unused = {
 	{
 		ARRAY_SIZE(kpu1_cam_entries),
 		ARRAY_SIZE(kpu1_action_entries),
@@ -15482,7 +15482,7 @@ static struct npc_kpu_profile npc_kpu_profiles[] = {
 	},
 };
 
-static struct npc_lt_def_cfg npc_lt_defaults = {
+static struct npc_lt_def_cfg npc_lt_defaults __maybe_unused = {
 	.rx_ol2 = {
 		.lid = NPC_LID_LA,
 		.ltype_match = NPC_LT_LA_ETHER,
@@ -15604,7 +15604,7 @@ static struct npc_lt_def_cfg npc_lt_defaults = {
 	},
 };
 
-static struct npc_mcam_kex npc_mkex_default = {
+static struct npc_mcam_kex npc_mkex_default __maybe_unused = {
 	.mkex_sign = MKEX_SIGN,
 	.name = "default",
 	.kpu_version = NPC_KPU_PROFILE_VER,
-- 
2.43.0


