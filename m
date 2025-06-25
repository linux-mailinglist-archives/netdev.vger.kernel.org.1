Return-Path: <netdev+bounces-201002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037DEAE7CD8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB975A7E20
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0102BCF41;
	Wed, 25 Jun 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dcyh2iGg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAC29E105;
	Wed, 25 Jun 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843302; cv=none; b=aSm0KiqnE1/ncJjO+V46MaWBo07K+Xp2j551wn5qP7f1ltUJFrgRaenex+LClAy8VvTQrzwfOmRFnujHmSUB/oahVEP/FxnaQ05XDphhFEGQae1OeM9qK8dMjf/oCVyNiDwx1Fe/yKyAKlH50QharhP3MFS14AS0DPnCBuyQmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843302; c=relaxed/simple;
	bh=1eBJRtZ6WEXnQxGGRpWyACEc/9N8wWoGfYZGFj7UjJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8vwd11rR1JAZs93pJg/3PmfPy1p3xNlfIZhyV15m4Ta3UVy6x9Yg4o3cqjGfHKv1vceuy+G4hAGNM6B/CJ5fn5EOc5ioJO0lhf9HyesCqxNisJgLLjNKzlnpGRopcNcK+AZK+VRhe/u16lBIXJNLy9+Yr/y2gmiNBgtb6tTNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dcyh2iGg; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2KYae011900;
	Wed, 25 Jun 2025 02:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	zT8mbsaEKffUI1+9mstC701GJMsiUT93j/2VOt7n7A=; b=Dcyh2iGgt7nXNuaQR
	6XFX5rYAIEiRvUjELSZ1JpVpC0TJ66MXMZCycCUSoVj/S4yf4pqCr6Q04gHMgGuz
	o1tRZaZOYI0BLkCmNLjV6iavYpkfrLHKF9vH2j7oa+Ypf8eGL5qytlfyD8xzo0Y4
	wX9idUGPEXOZX/eOCY41SD+1DTx26B9ag8tuNMIisWrARm7Um4RcKhWGjcJ4gGp6
	G+ig9dqWgaHg+gDwaoxf2TtSSW7zBin8hKhJIxxwopxhAVlDoW0/5i4g1wyv+nkm
	vgGq530Z9hMQL/QQcNCuV4ovvPHI67rzzWaVnEFWMgMjIRKveysUEzcsPWT0I+Wp
	PUFKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g8870qmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:21:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 02:21:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 02:21:28 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 0B1B63F705E;
	Wed, 25 Jun 2025 02:21:16 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 1/3] Octeontx-pf: Update SGMII mode mapping
Date: Wed, 25 Jun 2025 14:51:05 +0530
Message-ID: <20250625092107.9746-2-hkelam@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OSBTYWx0ZWRfX4vFFUsws+BMa LZlnC0hWZmsq6+DiiNE3A95ESH5Bps4FQQng74ZN8SCKLSpFNvqjUlqLduPCPaDhuS21+A2zaax R0flaf3nFwezGBPDbabVvHezMt3HHjg30Z1gFNX1sX+AmdcCXuYrY/X218jFOlftrqxbTIQ88IU
 5QK8WMeb7DP+8EYZ5AOl9DbsNpimPhhFGLdYPGb+qC5EpDzaW9L3oaCgIOTB3Mmymh7syL4s7TN QSwIzovPMb7Uf4kCVBhFl+oep2OkEeIKZ5liypqWe5r63JLh3udrhFNTeZkVcmhSeR4yd/dYQCK zfeW0iAdAFYXJWniNMiC440OaDZjwCkNSK9FXNOVEqCWSV/ALGXQjCuqSaqs3sg3uTWwEIHjWL+
 fvwmIn3TgdDmGo1mqpXVUxus7HI5p5fLK0c05hqDJM4M7/xB25envvRLWqkV6sryMLRdLAa8
X-Authority-Analysis: v=2.4 cv=EoTSrTcA c=1 sm=1 tr=0 ts=685bbf99 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=IFoFaaN2sayDEy6T10wA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5Y7uyyMq7W2jdBH2Cn0CSU8u8WdhbeTL
X-Proofpoint-GUID: 5Y7uyyMq7W2jdBH2Cn0CSU8u8WdhbeTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01

Current implementation maps ethtool link modes 10baseT/100baseT/1000baseT
to single firmware mode SGMII. This create a problem for end users who want
to advertise only one speed among them.

This patch addresses the issue by mapping each ethtool link mode
to a corresponding firmware mode also updates new modes supported
by firmware.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   |  8 ++---
 .../ethernet/marvell/octeontx2/af/cgx_fw_if.h | 26 ++++++++++++++-
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 32 +++++++++----------
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 971993586fb4..ac30b6dcb5e5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1200,16 +1200,16 @@ static void otx2_map_ethtool_link_modes(u64 bitmask,
 {
 	switch (bitmask) {
 	case ETHTOOL_LINK_MODE_10baseT_Half_BIT:
-		set_mod_args(args, 10, 1, 1, BIT_ULL(CGX_MODE_SGMII));
+		set_mod_args(args, 10, 1, 1, BIT_ULL(CGX_MODE_SGMII_10M_BIT));
 		break;
 	case  ETHTOOL_LINK_MODE_10baseT_Full_BIT:
-		set_mod_args(args, 10, 0, 1, BIT_ULL(CGX_MODE_SGMII));
+		set_mod_args(args, 10, 0, 1, BIT_ULL(CGX_MODE_SGMII_10M_BIT));
 		break;
 	case  ETHTOOL_LINK_MODE_100baseT_Half_BIT:
-		set_mod_args(args, 100, 1, 1, BIT_ULL(CGX_MODE_SGMII));
+		set_mod_args(args, 100, 1, 1, BIT_ULL(CGX_MODE_SGMII_100M_BIT));
 		break;
 	case  ETHTOOL_LINK_MODE_100baseT_Full_BIT:
-		set_mod_args(args, 100, 0, 1, BIT_ULL(CGX_MODE_SGMII));
+		set_mod_args(args, 100, 0, 1, BIT_ULL(CGX_MODE_SGMII_100M_BIT));
 		break;
 	case  ETHTOOL_LINK_MODE_1000baseT_Half_BIT:
 		set_mod_args(args, 1000, 1, 1, BIT_ULL(CGX_MODE_SGMII));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
index d4a27c882a5b..da21a6f847cf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
@@ -95,7 +95,31 @@ enum CGX_MODE_ {
 	CGX_MODE_100G_C2M,
 	CGX_MODE_100G_CR4,
 	CGX_MODE_100G_KR4,
-	CGX_MODE_MAX /* = 29 */
+	CGX_MODE_LAUI_2_C2C_BIT,
+	CGX_MODE_LAUI_2_C2M_BIT,
+	CGX_MODE_50GBASE_CR2_C_BIT,
+	CGX_MODE_50GBASE_KR2_C_BIT,     /* = 30 */
+	CGX_MODE_100GAUI_2_C2C_BIT,
+	CGX_MODE_100GAUI_2_C2M_BIT,
+	CGX_MODE_100GBASE_CR2_BIT,
+	CGX_MODE_100GBASE_KR2_BIT,
+	CGX_MODE_SFI_1G_BIT,
+	CGX_MODE_25GBASE_CR_C_BIT,
+	CGX_MODE_25GBASE_KR_C_BIT,
+	CGX_MODE_SGMII_10M_BIT,
+	CGX_MODE_SGMII_100M_BIT,        /* = 39 */
+	CGX_MODE_2500_BASEX_BIT = 42, /* Mode group 1 */
+	CGX_MODE_5000_BASEX_BIT,
+	CGX_MODE_O_USGMII_BIT,
+	CGX_MODE_Q_USGMII_BIT,
+	CGX_MODE_2_5G_USXGMII_BIT,
+	CGX_MODE_5G_USXGMII_BIT,
+	CGX_MODE_10G_SXGMII_BIT,
+	CGX_MODE_10G_DXGMII_BIT,
+	CGX_MODE_10G_QXGMII_BIT,
+	CGX_MODE_TP_BIT,
+	CGX_MODE_FIBER_BIT,
+	CGX_MODE_MAX /* = 53 */
 };
 /* REQUEST ID types. Input to firmware */
 enum cgx_cmd_id {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9b7f847b9c22..ae1cdd51b9fb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -15,6 +15,7 @@
 
 #include "otx2_common.h"
 #include "otx2_ptp.h"
+#include <cgx_fw_if.h>
 
 #define DRV_NAME	"rvu-nicpf"
 #define DRV_VF_NAME	"rvu-nicvf"
@@ -1126,17 +1127,9 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
 				    *link_ksettings)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(otx2_link_modes) = { 0, };
-	const int otx2_sgmii_features[6] = {
-		ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-		ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-		ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-		ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
-		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-	};
 	/* CGX link modes to Ethtool link mode mapping */
-	const int cgx_link_mode[27] = {
-		0, /* SGMII  Mode */
+	const int cgx_link_mode[CGX_MODE_MAX] = {
+		0, /* SGMII  1000baseT */
 		ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
 		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
 		ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
@@ -1166,14 +1159,19 @@ static void otx2_get_link_mode_info(u64 link_mode_bmap,
 	};
 	u8 bit;
 
-	for_each_set_bit(bit, (unsigned long *)&link_mode_bmap, 27) {
-		/* SGMII mode is set */
-		if (bit == 0)
-			linkmode_set_bit_array(otx2_sgmii_features,
-					       ARRAY_SIZE(otx2_sgmii_features),
-					       otx2_link_modes);
-		else
+	for_each_set_bit(bit, (unsigned long *)&link_mode_bmap, ARRAY_SIZE(cgx_link_mode)) {
+		if (bit == CGX_MODE_SGMII_10M_BIT) {
+			linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, otx2_link_modes);
+			linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, otx2_link_modes);
+		} else if (bit == CGX_MODE_SGMII_100M_BIT) {
+			linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, otx2_link_modes);
+			linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, otx2_link_modes);
+		} else if (bit == CGX_MODE_SGMII) {
+			linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, otx2_link_modes);
+			linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, otx2_link_modes);
+		} else {
 			linkmode_set_bit(cgx_link_mode[bit], otx2_link_modes);
+		}
 	}
 
 	if (req_mode == OTX2_MODE_ADVERTISED)
-- 
2.34.1


