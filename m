Return-Path: <netdev+bounces-18126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A53755103
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931961C2096B
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 19:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0B8F74;
	Sun, 16 Jul 2023 19:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12F8F55
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:31:23 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE71FC0;
	Sun, 16 Jul 2023 12:31:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GGhmo8023743;
	Sun, 16 Jul 2023 12:31:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=KTpU9bjR5oshdOg6vAIukO5MjvQup3SkGkQVv+cyixQ=;
 b=HUeZNyFwQSy7fcMMUczCmlEXJMEJdXTQIPFmsmKyPD3LbBvE9dUlBnAGZ4+BuF+oRDKm
 piHbX9uIOeHrs5TxgiXacOGt33tghrGiN7aA5Nj+9aPX/jH07H5AbCMVPCjudkjWV8pu
 42TxIUGp3xnpst0ucp3DsowZTCScJTDciCh74c47iIAdLnz6EmT1Nk12RlTizlnqUN0K
 qdnRvAIJ0s1XbWmHXLTMlhLdVQt1oGHZV0uX5urkwZJBNGvNPTJMq3LdXUNS7w0TUuFE
 CPxnGebLOm9QkIAc0JaJAf8wlp2YIzK6/3rwf/nnELZX8siocTZ3OylXgQ0YPdAVvhUD AA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rus6dawqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 16 Jul 2023 12:31:02 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jul
 2023 12:31:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 16 Jul 2023 12:31:01 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 22EC75E6869;
	Sun, 16 Jul 2023 12:30:57 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V3 1/2] octeontx2-af: Fix hash extraction mbox message
Date: Mon, 17 Jul 2023 01:00:48 +0530
Message-ID: <20230716193049.2499410-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230716193049.2499410-1-sumang@marvell.com>
References: <20230716193049.2499410-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: odW8JEUmd0bpun3LcxJGVYY3_LzVSBK7
X-Proofpoint-ORIG-GUID: odW8JEUmd0bpun3LcxJGVYY3_LzVSBK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_06,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of today, hash extraction mbox message response supports only the
secret key which is not a complete solution. This patch fixes that and
adds support to extract both hash mask and hash control along with the
secret key. These are needed to use hash reduction of 128 bit IPv6
address to 32 bit. Hash mask decides on the bits from the 128 bit IPv6
address which should be used for 32 bit hash calculation. After
generating the 32 bit hash, hash control decides how many bits from the
32 bit hash can be taken into consideration.

Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++---
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 27 ++++++++++---------
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  9 ++++---
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eba307eee2b2..5a5c23a02261 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -246,9 +246,9 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011, npc_read_base_steer_rule,            \
 M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,                     \
 				   npc_mcam_get_stats_req,              \
 				   npc_mcam_get_stats_rsp)              \
-M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,                     \
-				   npc_get_field_hash_info_req,              \
-				   npc_get_field_hash_info_rsp)              \
+M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,             \
+				   npc_get_field_hash_info_req,         \
+				   npc_get_field_hash_info_rsp)         \
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 6fe67f3a7f6f..a3bc53d22dc0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -96,7 +96,7 @@ u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
 	field_hash = rvu_npc_toeplitz_hash(data_padded, hash_key, 128, 159);
 
 	field_hash &= FIELD_GET(GENMASK(63, 32), rsp.hash_ctrl[intf][hash_idx]);
-	field_hash += FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
+	field_hash |= FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
 	return field_hash;
 }
 
@@ -253,7 +253,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
 	}
 
 	req.intf = intf;
-	rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp);
+	if (rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp))
+		return;
 
 	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
 		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
@@ -319,9 +320,9 @@ int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
 					     struct npc_get_field_hash_info_req *req,
 					     struct npc_get_field_hash_info_rsp *rsp)
 {
+	int hash_idx, hash_mask_idx, blkaddr;
 	u64 *secret_key = rsp->secret_key;
 	u8 intf = req->intf;
-	int i, j, blkaddr;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
 	if (blkaddr < 0) {
@@ -333,18 +334,18 @@ int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
 	secret_key[1] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY1(intf));
 	secret_key[2] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY2(intf));
 
-	for (i = 0; i < NPC_MAX_HASH; i++) {
-		for (j = 0; j < NPC_MAX_HASH_MASK; j++) {
-			rsp->hash_mask[NIX_INTF_RX][i][j] =
-				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, i, j);
-			rsp->hash_mask[NIX_INTF_TX][i][j] =
-				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, i, j);
+	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++)
+		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH_MASK; hash_mask_idx++) {
+			rsp->hash_mask[NIX_INTF_RX][hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, hash_idx, hash_mask_idx);
+			rsp->hash_mask[NIX_INTF_TX][hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, hash_idx, hash_mask_idx);
 		}
-	}
 
-	for (i = 0; i < NPC_MAX_INTF; i++)
-		for (j = 0; j < NPC_MAX_HASH; j++)
-			rsp->hash_ctrl[i][j] = GET_KEX_LD_HASH_CTRL(i, j);
+	for (hash_idx = 0; hash_idx < NPC_MAX_INTF; hash_idx++)
+		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH; hash_mask_idx++)
+			rsp->hash_ctrl[hash_idx][hash_mask_idx] =
+				GET_KEX_LD_HASH_CTRL(hash_idx, hash_mask_idx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
index a1c3d987b804..eb9cb311b934 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
@@ -12,9 +12,6 @@
 #define RVU_NPC_HASH_SECRET_KEY1 0xa9d5af4c9fbc87b4
 #define RVU_NPC_HASH_SECRET_KEY2 0x5954c9e7
 
-#define NPC_MAX_HASH 2
-#define NPC_MAX_HASH_MASK 2
-
 #define KEX_LD_CFG_USE_HASH(use_hash, bytesm1, hdr_ofs, ena, flags_ena, key_ofs) \
 			    ((use_hash) << 20 | ((bytesm1) << 16) | ((hdr_ofs) << 8) | \
 			     ((ena) << 7) | ((flags_ena) << 6) | ((key_ofs) & 0x3F))
@@ -41,6 +38,12 @@
 	rvu_write64(rvu, blkaddr,	\
 		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
 
+#define GET_KEX_LD_HASH_CTRL(intf, ld)  \
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
+
+#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
+	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx))
+
 struct npc_mcam_kex_hash {
 	/* NPC_AF_INTF(0..1)_LID(0..7)_LT(0..15)_LD(0..1)_CFG */
 	bool lid_lt_ld_hash_en[NPC_MAX_INTF][NPC_MAX_LID][NPC_MAX_LT][NPC_MAX_LD];
-- 
2.25.1


