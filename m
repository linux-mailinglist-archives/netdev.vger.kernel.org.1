Return-Path: <netdev+bounces-160718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B940AA1AEF7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BED5188C6CE
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53341D7E4B;
	Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BufYno/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA921D7E2F
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688733; cv=none; b=Q7eZ47DeMiiQKN2YsjZ/apeEyUwNY3uJrPwhiPIrv5lI64w2Heia8F8KpmrXpSolgZz8pQoE54dtBXtqYI2ZEbb5UJENMHnGLr/BPkMifiVIoZvTL74/VWNZ//JHRxJ6UhWK7xBVrI7ZW5tB319fk4evH8VWWSo3YjABohZpjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688733; c=relaxed/simple;
	bh=9llfD0hgxq2fab2Xb2H0n8QF3I1jm2JLhmKQ9hxWW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjrf8UhtuyargLZWVfGIbNb2S3USWXqU/Z9nT539mJsJfXb/Ojxucf/BcUbq0saKoHp1LTSuxfCBUt0ia4LxbpsMg0BJigXObEVFiL8lq1MQT5lzRkANHkZysJ/l9sUxZ1U8YrofExL9jM2Gx2P2BTwkieO3aU7rC1rx/mH9g2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BufYno/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32644C4CEE2;
	Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688733;
	bh=9llfD0hgxq2fab2Xb2H0n8QF3I1jm2JLhmKQ9hxWW5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BufYno/+sDrwSpI1ODpKPasL2FeZR2oFNiK+kiYnowmjbgB6HVrjfTwWo5mv0cwqL
	 lYHvGeUCK2J2jhaUsG7eoJ3uuS5BOqbgE2vq4usLqadaEznv2XlBAZi80FxWHpxjAZ
	 hQCwczWKz9RUnRuELFHFVwn5JlTypX+dHKzBt7C1RCEpdLc9EOA7i8U6Wq52qMH+Qb
	 RmijNH1lx3oHK1Wll3aVcjyFKctvuahHa2aAm9pC0sY66RLLP5/NVcqt3qR47VyB0u
	 Cm/91FV51dsgJuGWdo6GTgbdUv1GPg4gETSkJvGVlb3jBf/BZBpCwnmTUxhoRFgh77
	 mUh3IVNnicLZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	rain.1986.08.12@gmail.com,
	kuniyu@amazon.com,
	romieu@fr.zoreil.com
Subject: [PATCH net v3 3/7] eth: forcedeth: fix calling napi_enable() in atomic context
Date: Thu, 23 Jan 2025 19:18:37 -0800
Message-ID: <20250124031841.1179756-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124031841.1179756-1-kuba@kernel.org>
References: <20250124031841.1179756-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_enable() may sleep now, take netdev_lock() before np->lock.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: rain.1986.08.12@gmail.com
CC: kuniyu@amazon.com
CC: romieu@fr.zoreil.com
---
 drivers/net/ethernet/nvidia/forcedeth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index b00df57f2ca3..499e5e39d513 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5562,6 +5562,7 @@ static int nv_open(struct net_device *dev)
 	/* ask for interrupts */
 	nv_enable_hw_interrupts(dev, np->irqmask);
 
+	netdev_lock(dev);
 	spin_lock_irq(&np->lock);
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
 	writel(0, base + NvRegMulticastAddrB);
@@ -5580,7 +5581,7 @@ static int nv_open(struct net_device *dev)
 	ret = nv_update_linkspeed(dev);
 	nv_start_rxtx(dev);
 	netif_start_queue(dev);
-	napi_enable(&np->napi);
+	napi_enable_locked(&np->napi);
 
 	if (ret) {
 		netif_carrier_on(dev);
@@ -5597,6 +5598,7 @@ static int nv_open(struct net_device *dev)
 			round_jiffies(jiffies + STATS_INTERVAL));
 
 	spin_unlock_irq(&np->lock);
+	netdev_unlock(dev);
 
 	/* If the loopback feature was set while the device was down, make sure
 	 * that it's set correctly now.
-- 
2.48.1


