Return-Path: <netdev+bounces-108056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5B91DB16
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2729F28422A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2812A14C;
	Mon,  1 Jul 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="erc6pSTO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DC85656;
	Mon,  1 Jul 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824899; cv=none; b=J6eIJFiTKLSY7VEX2/G2e8+HgkT2O/tpOcZw0Uj3NHUGZMsKc1sEcT3ZsPdUPZuKKBZEL6gpIcypiCZrrBLXtcnqfTgKIv+AEfJIhh5OLZ5zECN1b85+pYHnQQzGLMZKptZgvMIWwOVMJjfOOZ1LGmj3DXmINaJ1/NbcZce32so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824899; c=relaxed/simple;
	bh=of45miHqg0zIGr0XeG9+2B9Ss/L/V39dvk7XO47i/aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkrJdszBM2Q3HcIFErkAg3H0o/M0vg66gGpU2aRPzmYDgkwuWHnxsoDLMR8UYg1muqpIDLGQ3P5TXLuTzCUJxX2ofTaHwPYvZvk4+I5Z9/vBjYHxa6hBhqwNFRcV6IKyJbWTNOv/77wDCinQUmixV2jS23lEo2hp5rPbZ9Y3Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=erc6pSTO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4618vXFm022323;
	Mon, 1 Jul 2024 02:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	DL/RyI33NOmI5rhwYexOQYakJ9UWsxRPe4WpaynY+I=; b=erc6pSTOyZOb0myuA
	dhQt2EmjJ7wmyrxz9XnwV65V/nBab3LjEci4x3yFgEUZ2Z0Sg5Hu54XMzTNym6aU
	/Cw2P3TGNv3lg0deos27sjHHGvkgHBvgYpblTu9YDEUgkJcYgd64EJIu/bM+exKr
	WAnvad0dl5TiQLoT73T195zUyn9xurlxStdksMMhjpUY1Prz1PPPpdaJhycdj8rK
	gyk9qlkB1igVdAEyKej/5TZmpMuEyNY7ra6Vk3nAqjglKE7RboOXWWpU+JXq4AEd
	aAhCU3bl+2Nio371HNxfZ7nhm6wnaNz43solU6UqdOJawzkV43V649zDwsP1j1qk
	5Y3PA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 403sdcg1nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:08:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:08:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:08:08 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id DC7B53F7044;
	Mon,  1 Jul 2024 02:08:04 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH net,4/6] octeontx2-af: Fix issue with IPv6 ext match for RSS
Date: Mon, 1 Jul 2024 14:37:44 +0530
Message-ID: <20240701090746.2171565-5-schalla@marvell.com>
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
X-Proofpoint-GUID: OQQ7s3mCRw_n1BUg-qwo9I7BorsnOdb6
X-Proofpoint-ORIG-GUID: OQQ7s3mCRw_n1BUg-qwo9I7BorsnOdb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

From: Kiran Kumar K <kirankumark@marvell.com>

While performing RSS based on IPv6, extension ltype
is not being considered. This will be problem for
fragmented packets or packets with extension header.
Adding changes to match IPv6 ext header along with IPv6
ltype.

Fixes: 41a7aa7b800d ("octeontx2-af: NIX Rx flowkey configuration for RSS")
Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..bf5c9cc3df87 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3990,7 +3990,7 @@ static int set_flowkey_fields(struct nix_rx_flowkey_alg *alg, u32 flow_cfg)
 					field->bytesm1 = 15; /* DIP,16 bytes */
 				}
 			}
-			field->ltype_mask = 0xF; /* Match only IPv6 */
+			field->ltype_mask = 0xE; /* Match IPv6 and IPv6_ext */
 			break;
 		case NIX_FLOW_KEY_TYPE_TCP:
 		case NIX_FLOW_KEY_TYPE_UDP:
-- 
2.25.1


