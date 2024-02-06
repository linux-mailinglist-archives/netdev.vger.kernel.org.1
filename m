Return-Path: <netdev+bounces-69531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0E84B963
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC428F702
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F5F135A5D;
	Tue,  6 Feb 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="dn05NAVj"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623E134744
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232869; cv=none; b=lXJd0yVBos1qCsxHOHy4dvPSLsM71xI3Q6LbKkQ2c5Iih2EZOn+YXBxZFaAih2sK+fbpAHQnZcvjdpDA+mGuyMZFV8PqqcgSaaz7JgK+B7IMal0u+T63cfvTvY7Qjj/b8BwLe7PkjAUmeKcHMhvempDCdeGHTPurtSmaZY6eoBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232869; c=relaxed/simple;
	bh=Uo+hzVvYiTSM3TfC3L5ycdXoYui57fZKBJq1cLhea5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LD72TGAMJOvSXJ1e5XOps0QWmpE4GYV1iz1Kexf/hDMVmFDWwnmQrFiHcWEyyuuyTxX+xua6vYTTzoQztoJcv3fNZItzungrX2jmLc+0TnFpOrRFsnkxXeVrRWbPt2ScIg0AFMMjZNvCwHYAW2a4AIg+2V2d+m7eJhkR7R4MrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=dn05NAVj; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202402061520553e5259e6484a7aa781
        for <netdev@vger.kernel.org>;
        Tue, 06 Feb 2024 16:20:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aO9HXYqOshN4TxCHyIoXrsxFdzEISczVko5LuJ38+O4=;
 b=dn05NAVjXK31qK8Z6fAuMvdEI8pz/ekx1yY5Yrf4V8yEvZ5bWmt9TPmCtJWbAh9RMjd1Si
 U0zkonrvbnsLE6br30E2AgnaMauqxFkNzIouAJBOtYCARZcOkZEdLQsH1XtCtJ4Y1OuM8iX6
 s15SHCz31r29Enh68Gf9NcLzVf2Jk=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	vigneshr@ti.com,
	jan.kiszka@siemens.com,
	dan.carpenter@linaro.org,
	robh@kernel.org,
	grygorii.strashko@ti.com,
	horms@kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls in emac_ndo_stop()
Date: Tue,  6 Feb 2024 15:20:51 +0000
Message-ID: <20240206152052.98217-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Remove the duplicate calls to prueth_emac_stop() and
prueth_cleanup_tx_chns() in emac_ndo_stop().

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 411898a4f38c..cf7b73f8f450 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1489,9 +1489,6 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* Destroying the queued work in ndo_stop() */
 	cancel_delayed_work_sync(&emac->stats_work);
 
-	/* stop PRUs */
-	prueth_emac_stop(emac);
-
 	if (prueth->emacs_initialized == 1)
 		icss_iep_exit(emac->iep);
 
@@ -1502,7 +1499,6 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
-	prueth_cleanup_tx_chns(emac);
 
 	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
 	prueth_cleanup_tx_chns(emac);
-- 
2.43.0


