Return-Path: <netdev+bounces-132090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342129905DE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EF2844EC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC2215F47;
	Fri,  4 Oct 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ2dS/Mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAC210188
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051681; cv=none; b=Ccyb7yxek61ipW0h3+8zyK0RyLGOC24LTYMEWSnR24ge88UxJxOKIPre0aAR18lJLX6y1YTWpFw18wOD779TMXsVDloUdoKWZ5kWnmiX3kosUxs0rbSV1O3uiBZFlN6pG/h68jfDsKRAgd9matWDl+O0TydnQWw4gZFZ6JEeBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051681; c=relaxed/simple;
	bh=LfA1gSgY/oocyM4ckjZyuAird29y8yMw5sve/T8isKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuENtL5jMVcml3H8UbO3w6YQ+K4SDYR6F8PWCrsMDRi5LDLuYv5fSVgA+JcmPDnu+AUawTA8pfEmV5tz11zxHPV8ezWw63UCeFzjy250/QeUoVA+nPJjLHixKRvTZwWRtL4rq+3Anhxtj+G5gby/z27ej+rCOv3FZJEW5W5NFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ2dS/Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B6C4CEC6;
	Fri,  4 Oct 2024 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051678;
	bh=LfA1gSgY/oocyM4ckjZyuAird29y8yMw5sve/T8isKk=;
	h=From:To:Cc:Subject:Date:From;
	b=YJ2dS/Mt7UEa9UeJ35ZIyIu5n9z/lrGD6YRdHV4oVuU+0zn69BT6d6swxaQFkcHHR
	 gVq4RAu2JUlwo1V/DUrlmVXvvERWBJEQ9Htq6CRlolwppoklOqHAdpRoYuRpn7BLwW
	 sSz4hBE+S08Y5JnSBAbthfDeJIuDltUmSMpt6plSQ4N3BcCsIHQtLKlWe8BdnMtHPC
	 Z9y7cN1aRuyQMDXiFgEmi5O6HjhvvHhoQ2FK25QsCWaf7clIPEUglpj71KmcN+lJFx
	 +j4R0SlyLg0jDO7bmzioS2fYtc/3BjH/f2H05O2f5NJHskfSC6jKNvusoI3S3n8Nyg
	 xQk4EiZpBcmBw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	hawk@kernel.org,
	0x1207@gmail.com
Subject: [PATCH net] Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"
Date: Fri,  4 Oct 2024 07:21:15 -0700
Message-ID: <20241004142115.910876-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit b514c47ebf41a6536551ed28a05758036e6eca7c.

The commit describes that we don't have to sync the page when
recycling, and it tries to optimize that case. But we do need
to sync after allocation. Recycling side should be changed to
pass the right sync size instead.

Fixes: b514c47ebf41 ("net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/20241004070846.2502e9ea@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexandre.torgue@foss.st.com
CC: joabreu@synopsys.com
CC: mcoquelin.stm32@gmail.com
CC: hawk@kernel.org
CC: 0x1207@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e2140482270a..d3895d7eecfc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2035,7 +2035,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
 
-	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = dma_conf->dma_rx_size;
 	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
 	pp_params.order = ilog2(num_pages);
-- 
2.46.2


