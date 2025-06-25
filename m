Return-Path: <netdev+bounces-201003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFFAE7CDA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7281917E82F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880672DA752;
	Wed, 25 Jun 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BZB4HzBg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0429E105;
	Wed, 25 Jun 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843309; cv=none; b=Z1tcxPTh6G9U3/6lcJTNJKkoP9lRX0HOm0Rk7vG+ClWis9nYjrxIXya84IQiX+5KEO9gMGcoGjOk3cUOgUDvY4F5frxgk6Sk2irBBxNpnVvZXtNOtR30W1hOJflKb4V6G3SNfWZMB+rmacJG+VEyDbqcNyFnQ9tnIY4PPrJApvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843309; c=relaxed/simple;
	bh=m9u5exFHZZ3hGmqte6aN34DVQaAtS4N0mLZOuwkhrwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9bRHc0/kp84+iaBi+hDHr3hE4+w14MzAKNf0PpsBbmaJMJmbPnvkb3+laMmF959WLj0+PgCgzhsrqMT3f94QHK2Ef+hBojv94e7nYnPrSz6oIBAKs1UfTwep7c+qF+NaZo8YpLaRZErw1PHVFrPsfzA3ELogG5ZSCDkrb5p3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BZB4HzBg; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONSkTT032685;
	Wed, 25 Jun 2025 02:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	XimmrYhnZJpFf1DH0XHfCJxwAgLzgfaVMnWVv0iLog=; b=BZB4HzBgXSjFejpjY
	/HPKR+tOAF4jano7oYcp/4QXHdQIZ+Qy5PGrMTqE/DK367/je2CIU5GRJUzJbPIe
	kBPyNo6OU+KrmLNUHr3m3WwXOUfHZLZVC2uQlCYhQHizVPbBg8RQjyLXD5Bm4M5r
	Z63f5dinv+UBMpdMSHrRTp4/Ha2Q98FutllINj4KeDX6s9+M19uURAWnfZhSql6H
	3MyZ8hco3BRHQUfYVhXZsudsucEOqmH2K2aps/bRL+cXiWWNWKxeUysvfOtWtpP4
	eQ6XzAVInSPWIH9dLM8uZs2MCPKRk7F9n00PrP8EIu+uUr1xS6iKVCnIjlAbwTEY
	78JlQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g5qss29w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:21:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 02:21:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 02:21:37 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 45F3A3F704F;
	Wed, 25 Jun 2025 02:21:29 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 2/3] Octeontx2-af: Introduce mode group index
Date: Wed, 25 Jun 2025 14:51:06 +0530
Message-ID: <20250625092107.9746-3-hkelam@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OSBTYWx0ZWRfX/e/c5+PAB1ST cV4yuwNwybIV6O0Yz1HMLwBwJuJ5sX9ewjeSb02E4gBpsasy6M6AAfWrk7pyXQ5fuhCQyrGcJVZ Oq+JIGFhJ01lNvA6x00DLBQ66keQ9SQ5hPqcArj4hGmT0UMwvqnpIheq0CbIAw6hGu9dq++aSG9
 tX756aSZF8cKIzdzedb4IgTFni4+Jkh5g130VsT7loPEWvDjBuaWT2edmmWECMbM0Ios779T9Vc sM/Mac5YzeGUwVCk05DHPQDen2IvhrUAnwHAkHPxSbKGq/CpgeJXkWA1KPl0YJU4jjwYuvx+Wk8 gNEAoU1ncnyHsHz+xiZIdX2oeFBKj/1J4Zp/x7h0WRrAGFrdvCl/BE1e9m5uYxZC/Fu7fyjDy0G
 DI0ZK7PM6188DWmZwfbZBa6NYRhKSsWxGs8LrlAgEBZJLp8KeLDS9fez+XOFI8zPMiro63fI
X-Authority-Analysis: v=2.4 cv=AaqxH2XG c=1 sm=1 tr=0 ts=685bbfa2 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=F26pDgV8Ds4sHcX3m9QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: L-TMfFbfPvg1wK_W2pid8UtzK7LQdoeW
X-Proofpoint-ORIG-GUID: L-TMfFbfPvg1wK_W2pid8UtzK7LQdoeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01

Kernel and firmware communicates via scratch register which is
64 bit in size.

[MODE_ID   PORT    AUTONEG  DUPLEX  SPEED   CMD_ID   OWNERSHIP ]
 63-22     21-14     13      12      11-8    7-2       1-0

The existing MODE_ID bitmap can only support up to 42 modes.
To resolve the issue, the unused port field is modified as below
            uint64_t reserved2:6;
            uint64_t mode_group_idx:2;

'mode_group_idx' categorize the mode ID range to accommodate more modes.

	To specify mode ID range of 0 - 41, this field will be 0.

    	To specify mode ID range of 42 - 83, this field will be 1.

mode ID will be still mentioned as 1 << (0 - 41).  But the mode_group_idx
decides the actual mode range

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 17 +++++++++++++++--
 .../ethernet/marvell/octeontx2/af/cgx_fw_if.h   |  7 ++++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h    |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index ac30b6dcb5e5..5c2435f39308 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1182,6 +1182,9 @@ static int cgx_link_usertable_index_map(int speed)
 static void set_mod_args(struct cgx_set_link_mode_args *args,
 			 u32 speed, u8 duplex, u8 autoneg, u64 mode)
 {
+	int mode_baseidx;
+	u8 cgx_mode;
+
 	/* Fill default values incase of user did not pass
 	 * valid parameters
 	 */
@@ -1191,8 +1194,18 @@ static void set_mod_args(struct cgx_set_link_mode_args *args,
 		args->speed = speed;
 	if (args->an == AUTONEG_UNKNOWN)
 		args->an = autoneg;
+
+	/* Derive mode_base_idx and mode fields based
+	 * on cgx_mode value
+	 */
+	cgx_mode = find_first_bit((unsigned long *)&mode,
+				  CGX_MODE_MAX);
 	args->mode = mode;
-	args->ports = 0;
+	mode_baseidx = cgx_mode - 41;
+	if (mode_baseidx > 0) {
+		args->mode_baseidx = 1;
+		args->mode = BIT_ULL(mode_baseidx);
+	}
 }
 
 static void otx2_map_ethtool_link_modes(u64 bitmask,
@@ -1499,7 +1512,7 @@ int cgx_set_link_mode(void *cgxd, struct cgx_set_link_mode_args args,
 			cgx_link_usertable_index_map(args.speed), req);
 	req = FIELD_SET(CMDMODECHANGE_DUPLEX, args.duplex, req);
 	req = FIELD_SET(CMDMODECHANGE_AN, args.an, req);
-	req = FIELD_SET(CMDMODECHANGE_PORT, args.ports, req);
+	req = FIELD_SET(CMDMODECHANGE_MODE_BASEIDX, args.mode_baseidx, req);
 	req = FIELD_SET(CMDMODECHANGE_FLAGS, args.mode, req);
 
 	return cgx_fwi_cmd_generic(req, &resp, cgx, lmac_id);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
index da21a6f847cf..39352d451cc3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
@@ -282,7 +282,12 @@ struct cgx_lnk_sts {
 #define CMDMODECHANGE_SPEED		GENMASK_ULL(11, 8)
 #define CMDMODECHANGE_DUPLEX		GENMASK_ULL(12, 12)
 #define CMDMODECHANGE_AN		GENMASK_ULL(13, 13)
-#define CMDMODECHANGE_PORT		GENMASK_ULL(21, 14)
+/* this field categorize the mode ID(FLAGS) range to accommodate
+ * more modes.
+ * To specify mode ID range of 0 - 41, this field will be 0.
+ * To specify mode ID range of 42 - 83, this field will be 1.
+ */
+#define CMDMODECHANGE_MODE_BASEIDX	GENMASK_ULL(21, 20)
 #define CMDMODECHANGE_FLAGS		GENMASK_ULL(63, 22)
 
 /* LINK_BRING_UP command timeout */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index b3562d658d45..2fc6b0ba7494 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -675,7 +675,7 @@ struct cgx_set_link_mode_args {
 	u32 speed;
 	u8 duplex;
 	u8 an;
-	u8 ports;
+	u8 mode_baseidx;
 	u64 mode;
 };
 
-- 
2.34.1


