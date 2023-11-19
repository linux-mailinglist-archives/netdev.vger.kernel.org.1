Return-Path: <netdev+bounces-48988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DD7F0482
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 06:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4791F223A5
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38E53AB;
	Sun, 19 Nov 2023 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="t9P4UHRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30006194
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 21:39:50 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id ED6424406E6;
	Sun, 19 Nov 2023 07:38:37 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1700372318;
	bh=7P/qg/l6tAP5wTERCi5wYf6/fTbWy3N6umDGe50Fmao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9P4UHRVCnjjSyS056mP0U/2Peuix8vljagx8I9kKTFkM+AYQSon6Ggxphwq+Tl8n
	 tYMs2UUGquWKkEGZOLqHnDO+i3eHvc6eFnfX8MVmclrgTQlx6F3M8znlmVHbUAcVf8
	 K3wl3YeI6KhsWoc/Vbw3suhQRpnnFbe1ug5YWXzX57CG4G6ZRvD23yzG8vt3Mahgqw
	 0uxJyBsMnDdb77LnK2vBhsM82AIEvvWZUqRg0YIoQ+W17i3WU7DW1jexDBTonGVUxB
	 QDmFgb6WkmDSunFEAcOqLiTe5OkhhQqggY6E3opMMxnX5wPJGNL8BYH3pOJVxxSaf7
	 tY//nJi3qkc7Q==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next v3 2/2] net: stmmac: reduce dma ring display code duplication
Date: Sun, 19 Nov 2023 07:39:41 +0200
Message-ID: <a2a5c5ce9338bdea60ec71d7eeb00fe757281557.1700372381.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <444f3b1dd409fdb14ed2a1ae7679a86b110dadcd.1700372381.git.baruch@tkos.co.il>
References: <444f3b1dd409fdb14ed2a1ae7679a86b110dadcd.1700372381.git.baruch@tkos.co.il>
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
v3:
  Reorder variable declaration in reverse xmas (Paolo)

  Move desc_size initialization to function body (Serge, Paolo)

v2: Fix extended descriptor case, and properly test both cases
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8ab99c65ac59..97598c1497ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6180,29 +6180,23 @@ static struct dentry *stmmac_fs_dir;
 static void sysfs_display_ring(void *head, int size, int extend_desc,
 			       struct seq_file *seq, dma_addr_t dma_phy_addr)
 {
-	int i;
 	struct dma_extended_desc *ep = (struct dma_extended_desc *)head;
 	struct dma_desc *p = (struct dma_desc *)head;
+	unsigned int desc_size;
 	dma_addr_t dma_addr;
+	int i;
 
+	desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);
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
+		dma_addr = dma_phy_addr + i * desc_size;
+		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
+				i, &dma_addr,
+				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
+				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
+		if (extend_desc)
+			p = &(++ep)->basic;
+		else
 			p++;
-		}
 	}
 }
 
-- 
2.42.0


