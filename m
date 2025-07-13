Return-Path: <netdev+bounces-206441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887DB031C9
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC6817BCD8
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BBC27A139;
	Sun, 13 Jul 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AoQQKoej"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88516277CB3
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420736; cv=none; b=E48oS92q8SayyRV47Ufj3cUfMXVH3oKiTg8wz0EtqIwrzZmuDIQzfSrTuQFHbETGLI700SYCzsjhDVEHsK63nrmeT4KxMH9WWNGimPT8/0B66zCB8WOerA19HPgaiNR0Ng339EnpZkM+Vdwo9xT2/i/m8PAqAyJ4oW/dJoJPWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420736; c=relaxed/simple;
	bh=H5/0qhNfRtIQcPtpcRQ5QirUHLaPsai5PTwqOwbiZz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reKDQL1lBzUag5MnNnKunV9JlBJIGQKIIePGpF3cjLGTq+1G6AYoQP5ZN+Tzb+47MMs2uBb9/du6peDjf2E7rtBemHzyPW6ZLWkIbLv5a2l5jB77EaM6iHKg2QzMlYrXZ/OnJuUnRWIRO9DxgWdcnXiDe7xmUME1IWvyPcqysEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AoQQKoej; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DFW4xK004283;
	Sun, 13 Jul 2025 08:32:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Vh4x0pPGp67ljpFx8eyJ0n6O+
	Ac9ibnppD7wBlRK8as=; b=AoQQKoejTRm1HM/fjWWqmX77tmvhUA6i1DNgOOJoA
	OnrGtKyTB2a1X5+Ne5R0w2sCOs0HnFHn40N9yNehYYTFcp/ZeT4i6V2hsC6YnQXf
	WFWOd0ZAqiLZlIYgWtKY2ag52ttD7PYSp5OSdBa42g6BCayQ7zsNxY7C/pb7G9Rx
	Inj4inYL3s7pCRD/5CxdewT9a6eO7eq6bmLQcQOBoEi4e2ehuD8mCumxaSbo2YDT
	kpU4pZjzSJk8AX8kpF0uG/rG9bNqAbGtWg3j1wsCBLg7WzObdZVwUBER3q4lfHtK
	/WyytVCyTDRs627E67XegvdEJLKaVicWKgUinnwfl6VUw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47vbyd86j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:32:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:32:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:32:05 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 823645B6941;
	Sun, 13 Jul 2025 08:32:01 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 10/11] octeontx2-af: Display new bandwidth profiles too in debugfs
Date: Sun, 13 Jul 2025 21:01:08 +0530
Message-ID: <1752420669-2908-11-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfX63cuDCHdFWg/ 5Q5gsP3cDxOCjyQig8vtFC6hMUmZfwjOu3zGGb8qbZsRk5gKlwenwtSFQihAPWXMaQjFmMMK4Eb Bd6bfj88/OB9zUX+4jOVa3udphO0hWZKG+Z2IudNTFbtnHfKECImQ5SPopdWwDoOu1eOlzdqh4c
 fdsVKybUSlwyu+0gZJi/v02QgvBvPv49Jg5iqSpyQjUWKCGnwja4X9fZCR/zg/m4dEsXGxopqPM NuAAoK3uGhifzsCQAsErcDuScBJUvtM7sx6fUkbyjt8R70u51sdFaOHP+wGE0ZLZ+bFHVI3wUFY 3oaehW/g9pHxfLCWE6hlf65zqblAM7GkLFJ+436ZEfw5lF5BXIFAB02K1MVnnYajSUwCWwEy6hF
 GvQ7BOuKuwrjkoHkMUKmzROSDT+UZxhQ0/eC9ZncLqQGJvo8KG/IbfalYWVjN6gmqR1mlnxo
X-Proofpoint-GUID: 3TSXe82s-pnC6tMQOTxEnZMY3tm5QreC
X-Proofpoint-ORIG-GUID: 3TSXe82s-pnC6tMQOTxEnZMY3tm5QreC
X-Authority-Analysis: v=2.4 cv=C+TpyRP+ c=1 sm=1 tr=0 ts=6873d177 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=RZIP-wGVsQArKk7uDzMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

Consider the new profiles of cn20k too while displaying
bandwidth profile contexts in debugfs.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 7243592f0e43..ed502ca0c927 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2056,7 +2056,9 @@ static void print_nix_cn10k_rq_ctx(struct seq_file *m,
 	seq_printf(m, "W1: ipsecd_drop_ena \t\t%d\nW1: chi_ena \t\t\t%d\n\n",
 		   rq_ctx->ipsecd_drop_ena, rq_ctx->chi_ena);
 
-	seq_printf(m, "W2: band_prof_id \t\t%d\n", rq_ctx->band_prof_id);
+	seq_printf(m, "W2: band_prof_id \t\t%d\n",
+		   (u16)rq_ctx->band_prof_id_h << 10 | rq_ctx->band_prof_id);
+
 	seq_printf(m, "W2: policer_ena \t\t%d\n", rq_ctx->policer_ena);
 	seq_printf(m, "W2: spb_sizem1 \t\t\t%d\n", rq_ctx->spb_sizem1);
 	seq_printf(m, "W2: wqe_skip \t\t\t%d\nW2: sqb_ena \t\t\t%d\n",
@@ -2574,7 +2576,10 @@ static void print_band_prof_ctx(struct seq_file *m,
 		(prof->rc_action == 1) ? "DROP" : "RED";
 	seq_printf(m, "W1: rc_action\t\t%s\n", str);
 	seq_printf(m, "W1: meter_algo\t\t%d\n", prof->meter_algo);
-	seq_printf(m, "W1: band_prof_id\t%d\n", prof->band_prof_id);
+
+	seq_printf(m, "W1: band_prof_id\t%d\n",
+		   (u16)prof->band_prof_id_h << 7 | prof->band_prof_id);
+
 	seq_printf(m, "W1: hl_en\t\t%d\n", prof->hl_en);
 
 	seq_printf(m, "W2: ts\t\t\t%lld\n", (u64)prof->ts);
-- 
2.34.1


