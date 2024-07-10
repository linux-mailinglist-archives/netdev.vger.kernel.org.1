Return-Path: <netdev+bounces-110514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A621A92CC49
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379391F211E9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D386AE3;
	Wed, 10 Jul 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iavt2zUh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA928563E;
	Wed, 10 Jul 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598026; cv=none; b=JofqR9QJeSUFd/lfVuz9oFmRGQStXMPWmDfConPy+mB7SDfMOLkcgvVVht3Yb3R6GnqsNhoAUt5GbWv8j8QWXa68HZqzxIofz4jUSsP0HiiMsd23dq7eWUMzB4yAlNNjfrhJY+9ajfL3TyWzUts8bTawlWdKN977p4WIaCGvWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598026; c=relaxed/simple;
	bh=2tNka/XCqF1S0Kd3D2qMLaGepB8cZWlWto0t3iWI0fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmTWEF6DfB2BP8RcyvNP0THtCZasSyndsU2lP+UkHBtjH5Oimp0e79v+U22/VYSaH3VVM2i1/kflwPNEqXrivmLljonq7Yu2QyPO6hlXUrcq3cItPeLBj+IYiPAwpFIVhP5fx3y6TKE2Us0eZliWGryZQ/KQfFVDhLFBUkd8kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iavt2zUh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MPZGY021946;
	Wed, 10 Jul 2024 00:53:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
	OQPGU4QRB4TebF7CqTQwipvo1iFyJ4qNEXfA5XULdQ=; b=iavt2zUhuECBNMoBv
	EjOZiOoc5FwIC8MiShqhxZCjIy7pebms++6YPgP+lvAHyQfkZdyeV1xZK9DOYqYG
	/oHtiDu2W53SffdET3gnPWO170u36JoeYts7ICl4dH1I8ydhXuDnm59Ul6ur8tUD
	9Dp8Mug9wo18qbYX6sKUcVtuDs/jWM+QIFsissv7++hN9dCZtUEBPw2GOzkrvUV3
	FKTUVXYkB1frxr3vfFVGsHCxWQ1SqenEdqpe8kz/dIhGT3p2OJVJAFU4DeCVPvY+
	PTjziNYr8RPI3HH9UY99pPz6Suop33TJACvnReWVkki3bvG4ApC4HqRXoTVH8RtC
	GbtVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p7r-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:53:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 6B6A23F7053;
	Wed, 10 Jul 2024 00:51:51 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>, Satheesh Paul <psatheesh@marvell.com>
Subject: [PATCH net,v2,5/5] octeontx2-af: fix issue with IPv4 match for RSS
Date: Wed, 10 Jul 2024 13:21:27 +0530
Message-ID: <20240710075127.2274582-6-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710075127.2274582-1-schalla@marvell.com>
References: <20240710075127.2274582-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PP3nT04FHlwXzp4lWtaSAOmLMA3tpGX8
X-Proofpoint-GUID: PP3nT04FHlwXzp4lWtaSAOmLMA3tpGX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

From: Satheesh Paul <psatheesh@marvell.com>

While performing RSS based on IPv4, packets with
IPv4 options are not being considered. Adding changes
to match both plain IPv4 and IPv4 with option header.

Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS")
Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 19fe3ed5c0ee..3dc828cf6c5a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3866,6 +3866,8 @@ static int get_flowkey_alg_idx(struct nix_hw *nix_hw, u32 flow_cfg)
 
 /* Mask to match ipv6(NPC_LT_LC_IP6) and ipv6 ext(NPC_LT_LC_IP6_EXT) */
 #define NPC_LT_LC_IP6_MATCH_MSK ((~(NPC_LT_LC_IP6 ^ NPC_LT_LC_IP6_EXT)) & 0xf)
+/* Mask to match both ipv4(NPC_LT_LC_IP) and ipv4 ext(NPC_LT_LC_IP_OPT) */
+#define NPC_LT_LC_IP_MATCH_MSK  ((~(NPC_LT_LC_IP ^ NPC_LT_LC_IP_OPT)) & 0xf)
 
 static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 {
@@ -3936,7 +3938,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 			field->hdr_offset = 9; /* offset */
 			field->bytesm1 = 0; /* 1 byte */
 			field->ltype_match = NPC_LT_LC_IP;
-			field->ltype_mask = 0xF;
+			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV4:
 		case NIX_FLOW_KEY_TYPE_INNR_IPV4:
@@ -3963,8 +3965,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 3; /* DIP, 4 bytes */
 				}
 			}
-
-			field->ltype_mask = 0xF; /* Match only IPv4 */
+			field->ltype_mask = NPC_LT_LC_IP_MATCH_MSK;
 			keyoff_marker = false;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV6:
-- 
2.25.1


