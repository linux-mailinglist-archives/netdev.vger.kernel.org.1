Return-Path: <netdev+bounces-204506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F41AFAEF6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FBF1AA29ED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9028B414;
	Mon,  7 Jul 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YKI+zifM"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FD1C5D7D;
	Mon,  7 Jul 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878349; cv=none; b=ZoCiPdpbE42f8BWiuC8apkHXDA6Ywn24COdn3sz92YJtjyRjEcAo1AccYxJFzDef8mJUdfvhxrqr6NyuHqCdLtMoIxEUD3vIZpnRnDdLHUvRAZGP8mH+tuOZyqD2yMAfSQOEfaNKgF554MapOoSzxdnfjJKcuZBdhLBA7zsUsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878349; c=relaxed/simple;
	bh=sAml1Kpx+nxrsSW+ThPJ2nwXbtmHipxPCqPuwa4volo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdoT3EMUhnOQM1TsR3JJGj1p8jrVNK+mf23m9UuuvZCPSliAIkUlnRQ8ricTWZvLMo5BaXQEQeaYDWGAS1L12oavOzPOx7xVow/61kb+H0TgGwAzEbJ8mmg+M93ReRGsMz5OE829774AiGWQJv7vLZp3FPVapxh55r1GW+I9E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YKI+zifM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5678q4He167371;
	Mon, 7 Jul 2025 03:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751878324;
	bh=iY1v5wj7w+DkwXaytdgSJ+fjPXtWnraXdCVCfHtiPKM=;
	h=From:To:CC:Subject:Date;
	b=YKI+zifMPAGz6yZDLGacH33X1LLgBO6dgpLFwc/ew1Fm2vNZ0QMSFEL4C0gS63yuM
	 1EPVpbGZ5ouaZ8zYfibPRjZl6qgUQwsjAFlwvObNVLm8oGsp38KboZQcnG3kM3X934
	 Lt1ZxW++SmtHY73GW8JaSSjbinnsooOVZIumvJIU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5678q3282044492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 03:52:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 03:52:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 03:52:03 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5678q2Vl3765423;
	Mon, 7 Jul 2025 03:52:03 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>, <c-vankar@ti.com>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info
Date: Mon, 7 Jul 2025 14:22:01 +0530
Message-ID: <20250707085201.1898818-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

While transitioning from netdev_alloc_ip_align() to build_skb(), memory
for the "skb_shared_info" member of an "skb" was not allocated. Fix this
by allocating "PAGE_SIZE" as the skb length, accounting for the packet
length, headroom and tailroom, thereby including the required memory space
for skb_shared_info.

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on the commit 'af80679632063' of origin/main branch of
Linux-net repository.

Link to v2: 
https://lore.kernel.org/r/20250626051226.2418638-1-c-vankar@ti.com/

Changes from v2 to v3: 
- Updated skb length with the PAGE_SIZE as suggested by Jakub Kicinski.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f20d1ff192ef..231ca141331f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -856,8 +856,6 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 {
 	struct sk_buff *skb;
 
-	len += AM65_CPSW_HEADROOM;
-
 	skb = build_skb(page_addr, len);
 	if (unlikely(!skb))
 		return NULL;
@@ -1344,7 +1342,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	}
 
 	skb = am65_cpsw_build_skb(page_addr, ndev,
-				  AM65_CPSW_MAX_PACKET_SIZE, headroom);
+				  PAGE_SIZE, headroom);
 	if (unlikely(!skb)) {
 		new_page = page;
 		goto requeue;
-- 
2.34.1


