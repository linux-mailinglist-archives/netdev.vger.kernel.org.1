Return-Path: <netdev+bounces-47417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF757EA247
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C14280E2A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFF2110E;
	Mon, 13 Nov 2023 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="H/wQHR+1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86822EE0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:44:50 +0000 (UTC)
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0210F4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:44:49 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 6DFDA440DAA;
	Mon, 13 Nov 2023 19:43:46 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699897426;
	bh=MW871yMW+SlH+sDGpXeIRnmhp7FvyDE/Bs/X6DKNx4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/wQHR+1hDaQQLWslaOJmc7rhh4UQOEsvSBm6xncV4LkcJE0taaHd48dcIyyK8K6Y
	 cljzk9Wak7yG1M94/DgBQ9uzl0a1MLoh65KunPBCAoE2zE7i5dmFLxdtGiZ6dAXDm7
	 4d+i1F/6GBY/RFG59UKGfWmusxmH77P+fJv4dC+wU9XTkkzaQWV9qZftga54bfGlgn
	 EIjVtuQnJSeN8iEZ5t2HDELjuAanD4avHyxrg14fvJWHl70+xAjlV5H45TRwPm0j7M
	 oNMtRKpCh1BVzej4Zv6aWoDLuacog7nPtV+4Crn3ezXrwhvn+Ls/hPHPoM6skxcYRi
	 kAFeqnj8qcW9A==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next 2/2] net: stmmac: reduce dma ring display code duplication
Date: Mon, 13 Nov 2023 19:44:43 +0200
Message-ID: <fe95e2443cc06bc73a2d3b9851ceb98dfd608551.1699897483.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699897483.git.baruch@tkos.co.il>
References: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699897483.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to show extended descriptor is identical to normal one.
Consolidate the code to remove duplication.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 39336fe5e89d..f39e2bde325f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6184,24 +6184,16 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	struct dma_desc *p = (struct dma_desc *)head;
 	dma_addr_t dma_addr;
 
+	if (extend_desc)
+		p = &ep->basic;
+
 	for (i = 0; i < size; i++) {
-		if (extend_desc) {
-			dma_addr = dma_phy_addr + i * sizeof(*ep);
-			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
-				   i, &dma_addr,
-				   le32_to_cpu(ep->basic.des0),
-				   le32_to_cpu(ep->basic.des1),
-				   le32_to_cpu(ep->basic.des2),
-				   le32_to_cpu(ep->basic.des3));
-			ep++;
-		} else {
-			dma_addr = dma_phy_addr + i * sizeof(*p);
-			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
-				   i, &dma_addr,
-				   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
-				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
-			p++;
-		}
+		dma_addr = dma_phy_addr + i * sizeof(*p);
+		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
+				i, &dma_addr,
+				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
+				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
+		p++;
 	}
 }
 
-- 
2.42.0


