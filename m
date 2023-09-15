Return-Path: <netdev+bounces-34148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B17A256C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17201C20A67
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714315EA2;
	Fri, 15 Sep 2023 18:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4454125A1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC75C433C7;
	Fri, 15 Sep 2023 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694801815;
	bh=QQqUp4XKgQyXwHPRMB+70AKUDzS82qjfk8gBWWVgGI4=;
	h=Date:From:To:Cc:Subject:From;
	b=Yq79jB3G8IBEwWWnWZobdn6Dv325x+kOyUwQrhwpzktHSyJ6HHrnRXQHYvmOYWOPh
	 gT0e2oKdogaJYnAlSYqFv5zYbSKiPsiSftkYHjSjGR+pjxGaNk7hZKn56zH3bOCSFx
	 JSEh05iC5fyiG4U1VIs7g7UMiazvSKY+Vyf4Ax2XMU5/IZPk03/phNT7y+qEvMjTmH
	 yT8AEElu4D1porsU9LKGu82QC3nQEL/EYaqMnvQPmRoqBhWKP/293HMA/nYqQqRnaV
	 Lq6hPhMYaIGNt04csavSvpsgSl505s4DlcNVdiVeR1n7j6s2fIwFuOB9CpyRMFpWKI
	 XtKv0BUO7E/xQ==
Date: Fri, 15 Sep 2023 12:17:49 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <ZQSfze9HgfLDkFPV@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
protection that struct_size() adds against potential integer overflows
is defeated. Fix this by hardening call to struct_size() with size_add().

Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5704b5f57cd0..83b09dcfafc4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -190,7 +190,7 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
 		       priv->rx_cfg.num_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
-					     tx_stats_num + rx_stats_num);
+					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
 		dma_alloc_coherent(&priv->pdev->dev, priv->stats_report_len,
 				   &priv->stats_report_bus, GFP_KERNEL);
-- 
2.34.1


