Return-Path: <netdev+bounces-17836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8A7532B4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C31C2158E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149BD6FD3;
	Fri, 14 Jul 2023 07:12:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3883746C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:12:20 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30A30D0;
	Fri, 14 Jul 2023 00:12:11 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLUPrF029957;
	Fri, 14 Jul 2023 00:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=KtQ2DusuHWM+v6Ohvrsv+L0wkXSMe1qiUkwM+fmfqi4=;
 b=HlJDo6S6xTolGgVfhrvcviOS5ZBOiBEDqbKPwYMv8XphbRMXaQ4/LLkng7C1mr4P0fFZ
 Dy8AG9f69fGjJA0N7iK31Q3E5mu3GcBQTN/3wsI7PFX43gSCpRgjyFhdRirz4qQPLbsY
 Fb0I9a61S1eHJdUthvelr9AtIiCwo+NnFBYO62HorlF158fo+KteUeyA3RrCGjMqec6N
 gEO6PikdECh94ElJr1ZNv/n+65j86eGXgtpuELHS7aBHGnfhF5Zs4tCzQJbcIuFxx1p/
 OVlN2azXGw3bUjeB+Abf6ZMMVnlg+fbyuzBnm1C6g4WD1TP4X/4o6YtlOe5ZdzUUuG4Q 8A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptx9sws-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 14 Jul 2023 00:12:05 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 00:12:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 00:12:02 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 978E33F7064;
	Fri, 14 Jul 2023 00:11:59 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 3/3] octeontx2-af: Fix hash configuration for both source and destination IPv6
Date: Fri, 14 Jul 2023 12:41:41 +0530
Message-ID: <20230714071141.2428144-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714071141.2428144-1-sumang@marvell.com>
References: <20230714071141.2428144-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uLBX0LUQdTF32zJdNs5Mtv5NcmRJlE0Y
X-Proofpoint-ORIG-GUID: uLBX0LUQdTF32zJdNs5Mtv5NcmRJlE0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of today, hash reduction was supported only for source IPv6 address
and that calculation also was not correct. This patch fixes that and adds
supports for both source and destination IPv6 address.

Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 76553e0c216f..e7b71f2f3ad3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -100,20 +100,20 @@ u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
 	return field_hash;
 }
 
-static u64 npc_update_use_hash(int lt, int ld)
+static u64 npc_update_use_hash(struct rvu *rvu, int blkaddr,
+			       u8 intf, int lid, int lt, int ld)
 {
-	u64 cfg = 0;
-
-	switch (lt) {
-	case NPC_LT_LC_IP6:
-		/* Update use_hash(bit-20) and bytesm1 (bit-16:19)
-		 * in KEX_LD_CFG
-		 */
-		cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03,
-					  ld ? 0x8 : 0x18,
-					  0x1, 0x0, 0x10);
-		break;
-	}
+	u8 hdr, key;
+	u64 cfg;
+
+	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_LIDX_LTX_LDX_CFG(intf, lid, lt, ld));
+	hdr = FIELD_GET(NPC_HDR_OFFSET, cfg);
+	key = FIELD_GET(NPC_KEY_OFFSET, cfg);
+
+	/* Update use_hash(bit-20) to 'true' and
+	 * bytesm1(bit-16:19) to '0x3' in KEX_LD_CFG
+	 */
+	cfg = KEX_LD_CFG_USE_HASH(0x1, 0x03, hdr, 0x1, 0x0, key);
 
 	return cfg;
 }
@@ -132,12 +132,12 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++) {
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr, intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -149,6 +149,7 @@ static void npc_program_mkex_hash_rx(struct rvu *rvu, int blkaddr,
 							     mkex_hash->hash_mask[intf][ld][1]);
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
+					hash_cnt++;
 				}
 			}
 		}
@@ -169,12 +170,12 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 		for (lt = 0; lt < NPC_MAX_LT; lt++) {
 			for (ld = 0; ld < NPC_MAX_LD; ld++)
 				if (mkex_hash->lid_lt_ld_hash_en[intf][lid][lt][ld]) {
-					u64 cfg = npc_update_use_hash(lt, ld);
+					u64 cfg;
 
-					hash_cnt++;
 					if (hash_cnt == NPC_MAX_HASH)
 						return;
 
+					cfg = npc_update_use_hash(rvu, blkaddr, intf, lid, lt, ld);
 					/* Set updated KEX configuration */
 					SET_KEX_LD(intf, lid, lt, ld, cfg);
 					/* Set HASH configuration */
@@ -187,8 +188,6 @@ static void npc_program_mkex_hash_tx(struct rvu *rvu, int blkaddr,
 					SET_KEX_LD_HASH_CTRL(intf, ld,
 							     mkex_hash->hash_ctrl[intf][ld]);
 					hash_cnt++;
-					if (hash_cnt == NPC_MAX_HASH)
-						return;
 				}
 		}
 	}
-- 
2.25.1


