Return-Path: <netdev+bounces-47616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5D7EAAB3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60E01C2082D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F0BE68;
	Tue, 14 Nov 2023 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="nB1LieuL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C68F7D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:03:17 +0000 (UTC)
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4513D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:03:14 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 750FA44090A;
	Tue, 14 Nov 2023 09:02:11 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699945331;
	bh=pDUyZ7qyTkuDQx3MnVr5D+z3RJKa9f2SWWz6OYHST70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB1LieuLSKKEMQL3JTpMXrsh5EpDbk3kRBViTT8QdL0nbh/PhsfpusrUGLx+AsRez
	 Qdy/5e+spaUrad6fRMjNX45JinnoNYGi32W1RmbT6EHcD0Bm8dXNhd4hK20cTruV1+
	 v9MK57HY2B5UFw5PJhJypaDQGu8a2AV4VWfYg+sya9CFpGTt2DfimlCmIaBSe7Jq7g
	 2az8JUqMdjcPupS3ClyeCSMVDmDe6xaixPDAy/COH0dmDDnEs23PeqscameWp0pcER
	 ODD3Q2MFYNoxQUuP5SsiodrbCubp0meGwmGGvmai0KdnQQpaGvMKiTWpDiw+eMp3MZ
	 ehlizd9/1rSfg==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next v2 2/2] net: stmmac: reduce dma ring display code duplication
Date: Tue, 14 Nov 2023 09:03:10 +0200
Message-ID: <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
References: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
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
v2: Fix extended descriptor case, and properly test both cases
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 39336fe5e89d..cf818a2bc9d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6182,26 +6182,19 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	int i;
 	struct dma_extended_desc *ep = (struct dma_extended_desc *)head;
 	struct dma_desc *p = (struct dma_desc *)head;
+	unsigned long desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);
 	dma_addr_t dma_addr;
 
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


