Return-Path: <netdev+bounces-108057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D691DB18
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427C528472A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8712C550;
	Mon,  1 Jul 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WkfjFTtr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AF85947;
	Mon,  1 Jul 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824900; cv=none; b=NiprIKOigjLQ4F+NNqRg1tu/4ISV2lbl0JJWpiwQPZUhOcdLYPkNAD1VgxdUUl1jDhZ3R9vvsw09qOZ06qvDfgZ6EbGDHWJnpNPlF5nRcqvKUeVA2Sfb9mJVqWDUpbD00RFXB0cLWmZWLskCsDYE+QLzEwlMir+csD/n2ITwwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824900; c=relaxed/simple;
	bh=LoqLEfyO3ewNCizqJBK5ur7qnh+nxRU7jMjJchBYhg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7txHtU6rM00u148HiEigxbEN6qHEZ0E4EMlTMGDDSrfI5WjoO6Ew+HhxiN2qcoQg6IuAuEd2qyFrJKZNMdSMDVSSm5c0Ggikix4qOPwunWQhYgOdKcWudd1hRKz4Kgx/ytUKIT+W/wlYIEEphKtll53x0IPRRRkgUoBexMsnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WkfjFTtr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4618vSRn022237;
	Mon, 1 Jul 2024 02:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	Ox5bs9bk/snzCJoSa2fpz4qb3GdaK3gs5hsTeKUB74=; b=WkfjFTtrRn7V7xUdD
	dT9TaaFURuJjrVuTuwI2JFZ+bteA16VE4fpHIeZKQW8p5F54DvuevVnI6zwMbi+8
	URxw1jheMf3ZcVcCuaBl+unoHmKisH4pW9wwtiVHsTV34fTcQzPoWC/HXPCHBaJJ
	G7n99tf5UgvGuwXluoEKH6HQavaVsCYr+blmwYmEyxFKPeuAUodT+lYkB1bVlR89
	x4Pwz2RCp20NlCjIbwzWG3vssg2sMlZba4Vm3Uy57/QGbTljCj6yCgxl0z1WfMAg
	6KQ+guE3l1yRXHXJ9CX2nPZsKvB1G6fs+ZnFFcvN4t8sV96szTxY8KoTVzhtn7r3
	9sIfQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 403sdcg1p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:08:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:08:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:08:13 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 363B63F7044;
	Mon,  1 Jul 2024 02:08:08 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>, Satheesh Paul <psatheesh@marvell.com>
Subject: [PATCH net,5/6] octeontx2-af: fix issue with IPv4 match for RSS
Date: Mon, 1 Jul 2024 14:37:45 +0530
Message-ID: <20240701090746.2171565-6-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701090746.2171565-1-schalla@marvell.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SiqYG2SB2TzLbhX70U1UcgXoBOhCcKyn
X-Proofpoint-ORIG-GUID: SiqYG2SB2TzLbhX70U1UcgXoBOhCcKyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

From: Satheesh Paul <psatheesh@marvell.com>

While performing RSS based on IPv4, packets with
IPv4 options are not being considered. Adding changes
to match both plain IPv4 and IPv4 with option header.

Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS")
Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bf5c9cc3df87..da090d8b9046 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3933,7 +3933,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 			field->hdr_offset = 9; /* offset */
 			field->bytesm1 = 0; /* 1 byte */
 			field->ltype_match = NPC_LT_LC_IP;
-			field->ltype_mask = 0xF;
+			field->ltype_mask = 0xE;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV4:
 		case NIX_FLOW_KEY_TYPE_INNR_IPV4:
@@ -3961,7 +3961,10 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 				}
 			}
 
-			field->ltype_mask = 0xF; /* Match only IPv4 */
+			/* Match only IPv4; both NPC_LT_LC_IP and
+			 * NPC_LT_LC_IP_OPT
+			 */
+			field->ltype_mask = 0xE;
 			keyoff_marker = false;
 			break;
 		case NIX_FLOW_KEY_TYPE_IPV6:
-- 
2.25.1


