Return-Path: <netdev+bounces-110513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937B92CC48
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196B21F21FC9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB984DEB;
	Wed, 10 Jul 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KSXItV93"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E084FDF;
	Wed, 10 Jul 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598026; cv=none; b=qEF9c6YW8/xUam9Byc5J2qzdt8QNApGgK1ed0xb4aUo3BbP/QtSeRXPdP7ocV5tbsAOGFCop7VT1yfAo4qBK/3SZPoDxO02i70G7Mm4HkdLuu8Lh7HMg6PIKAqFMwjGotqwvajc4pqYE4rKeUfuIMu2ukqa7x6iKT2SlV5Cg8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598026; c=relaxed/simple;
	bh=tHLm/CprBaxtO6ChlniHmP+14Mp3ng7MvaO5a0kIMyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0uv5GR5w+T+dkv9p22BdHatazAJrmTsRvgzgTYn/c+WYnZZecELKS4n9m7bGGYznZ1TaGf2df/zz65f+ZRrq/kroo/XWNH13LzmISPf15TNvLjzUDrBWEdsd5TUV70O3+lRumsquDCzQ7sB69UDEopoJAvMjK0pM8liXZUAe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KSXItV93; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MPZGX021946;
	Wed, 10 Jul 2024 00:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	g+jAFLncsOkoJiPCqGY59zRTAbGvg4vbCN6QizNtpo=; b=KSXItV93lZOIhdfom
	rZ0XnJAwIE6b7s7duBALkoQpqiv3ETjJPT0FuoXmljRXjKeQ0DnG+PSSB1ruVfB+
	YZ5R9kGNObgrN+KEJKIIX8QmPjW9HOUlOWgevO41zOC3tJ0LNFOvtfSDNtxLnIEZ
	imt9iLsYS9zDWKhfs3EwDdRiO2mWLjwHvYhatAG0bi8w2TevUCahJTa/4IxL/UPp
	mKG9+Kp3+H5Hmmss0HK+5oH7gpGBWSHRl+Wlbfy7p5DPbdIiUmONibSUO4aupK0d
	p4Q7dUReqbdpP2DqDzPLtWFFPIrX3pfj1R4uLHr9xdAMurhcsr9Elers+mQcGwO3
	1l+Aw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p7r-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:53:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:51 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id B39083F7089;
	Wed, 10 Jul 2024 00:51:46 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH net,v2,4/5] octeontx2-af: fix issue with IPv6 ext match for RSS
Date: Wed, 10 Jul 2024 13:21:26 +0530
Message-ID: <20240710075127.2274582-5-schalla@marvell.com>
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
X-Proofpoint-ORIG-GUID: IG5EmdVX6nxQAwVYpDK3nnWFNFriNZzW
X-Proofpoint-GUID: IG5EmdVX6nxQAwVYpDK3nnWFNFriNZzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

From: Kiran Kumar K <kirankumark@marvell.com>

While performing RSS based on IPv6, extension ltype
is not being considered. This will be problem for
fragmented packets or packets with extension header.
Adding changes to match IPv6 ext header along with IPv6
ltype.

Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS")
Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..19fe3ed5c0ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3864,6 +3864,9 @@ static int get_flowkey_alg_idx(struct nix_hw *nix_hw, u32 flow_cfg)
 	return -ERANGE;
 }
 
+/* Mask to match ipv6(NPC_LT_LC_IP6) and ipv6 ext(NPC_LT_LC_IP6_EXT) */
+#define NPC_LT_LC_IP6_MATCH_MSK ((~(NPC_LT_LC_IP6 ^ NPC_LT_LC_IP6_EXT)) & 0xf)
+
 static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 {
 	int idx, nr_field, key_off, field_marker, keyoff_marker;
@@ -3990,7 +3993,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 15; /* DIP,16 bytes */
 				}
 			}
-			field->ltype_mask = 0xF; /* Match only IPv6 */
+			field->ltype_mask = NPC_LT_LC_IP6_MATCH_MSK;
 			break;
 		case NIX_FLOW_KEY_TYPE_TCP:
 		case NIX_FLOW_KEY_TYPE_UDP:
-- 
2.25.1


