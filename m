Return-Path: <netdev+bounces-47419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD67EA254
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1DA1C2084C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC0224C0;
	Mon, 13 Nov 2023 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="h4Svy6gl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D2224EA
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:49:33 +0000 (UTC)
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA410EC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:49:32 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 3F44D4406F7;
	Mon, 13 Nov 2023 19:41:53 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699897313;
	bh=rsN6ONrmXmjveXdLExCyq9Ko3XW2Kuct8gTVNvQv1Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4Svy6glaao3UeOsYqVpyLldJOjSdH3PiiA6BWKQlLbUUZ6QfeHGq9JIVid+XiCAu
	 e0xbf4ANGF7eIVh2Z7mJXMS7iixqqw/aJVe10ujnrZInqs1HiUXiL2FP4B1ucdtBPA
	 24eAAhEV6KYK+GM+ZXF6275IQ9xkgOa2YZg1hNXINedEd47HzKHzZC/sfxM6X775x2
	 imG1rES1nT4oCO+uZ+W6VFRlL/2Uiobgpnf9ZCgCWfZaVeApbruxl4j7uDNWGVfSlQ
	 1PjlVoG8mw32T7Og1DOCdxR1xJAK9V1tln4TTanlc1bDU3DH5zxt3XjnB/TWsD8u1J
	 sID0eyUC7VKTQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net 2/2] net: stmmac: avoid rx queue overrun
Date: Mon, 13 Nov 2023 19:42:50 +0200
Message-ID: <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_rx_size can be set as low as 64. Rx budget might be higher than
that. Make sure to not overrun allocated rx buffers when budget is
larger.

Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
'cur_rx'.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f28838c8cdb3..2afb2bd25977 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5293,6 +5293,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
-- 
2.42.0


