Return-Path: <netdev+bounces-19306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3AA75A3BC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EA61C20909
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC063E;
	Thu, 20 Jul 2023 01:04:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3E631
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D3C433CB;
	Thu, 20 Jul 2023 01:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815056;
	bh=2Tq+nHxHgb+BUUbKct3AAwrNQQmWr/xFOhLUEd7t4o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfHLyuUV4QULh0oiUscPlxa20IOYVK67I4PuS69vasYPxOtrpXvj/Vw2V89YkEjho
	 tQ9glJ3vYanj+piTZhU/SGN00/DbHaQHseLyYSqP74V9t69bvtG+NGMM7ARUboKuLD
	 U3jesPOzqG2gGtw52maPB0oLqB1kqJTdhYk1Nql7SbdkXh3cziW9UfrRv550qwuzMm
	 iUmKs48/j6eHX+ld8EmAXG1lJ/CQcO816FqT3niX4WiZg0xLw0ZShi2AsKWNNpyEoR
	 /KkG14D+aSM/gYP3j0qnSDRHA7RCQzbNK7/AXesrpkNCOaNvHN2ySEK5JN9nIt5Yoz
	 ZXbvM4H34IOPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com
Subject: [PATCH net-next 2/4] eth: stmmac: let page recycling happen with skbs
Date: Wed, 19 Jul 2023 18:04:07 -0700
Message-ID: <20230720010409.1967072-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010409.1967072-1-kuba@kernel.org>
References: <20230720010409.1967072-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac removes pages from the page pool after attaching them
to skbs. Use page recycling instead.

skb heads are always copied, and pages are always from page
pool in this driver. We could as well mark all allocated skbs
for recycling.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: peppe.cavallaro@st.com
CC: alexandre.torgue@foss.st.com
CC: joabreu@synopsys.com
CC: mcoquelin.stm32@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efe85b086abe..40b17f94d21b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5416,7 +5416,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					priv->dma_conf.dma_buf_sz);
 
 			/* Data payload appended into SKB */
-			page_pool_release_page(rx_q->page_pool, buf->page);
+			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		}
 
@@ -5428,7 +5428,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					priv->dma_conf.dma_buf_sz);
 
 			/* Data payload appended into SKB */
-			page_pool_release_page(rx_q->page_pool, buf->sec_page);
+			skb_mark_for_recycle(skb);
 			buf->sec_page = NULL;
 		}
 
-- 
2.41.0


