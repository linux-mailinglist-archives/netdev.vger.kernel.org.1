Return-Path: <netdev+bounces-160441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0BA19BE4
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E7F168342
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFE17C91;
	Thu, 23 Jan 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stIHhyFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7617557
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593125; cv=none; b=dEgL1FTHLx0htygXaIIBogSqM0Dk6MBCx8wZf0TcBNad0863rNCqBXOSJpm6SbAw+drjMN3WTTq+Q/KnUh3zogs9jAOWbYp/BOuiALw32T5kChOZinIEX4PNO1O3ur2cVfh0wwwK4uCFdMYIhaCsu0vn+QHjSrTbCv6TR5i7TOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593125; c=relaxed/simple;
	bh=9llfD0hgxq2fab2Xb2H0n8QF3I1jm2JLhmKQ9hxWW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux6LZYEBtzCHXhKQPJ6no2Xe64HqDEPKsxSW+C+IIEhGAUbEdGcwn9ePLeCuEaF0ynRvsI3MvoYxWPf4pvfKX//nhcJGe4U9spI7tmVqWoAf3p+ArbvwXvA4ShHtKCugGHVuTHDev1lrgMpQFEDeKyvTIR3GqF69jEskxEBGxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stIHhyFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDDC4CEE6;
	Thu, 23 Jan 2025 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593125;
	bh=9llfD0hgxq2fab2Xb2H0n8QF3I1jm2JLhmKQ9hxWW5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stIHhyFlmgTcRFbm7BIpiq3KjAz7eZA3f6NBgEXwZGZBC9w01HDDtjfKjND6eyt0M
	 qwMzOI/BlaNT5uC6n9ONKlseu0/oC8R60lf+Xjl4EPrevfmI5cIMjb/mI/Bkr0W5Jl
	 CCYWclgFuLaTq6GRYDLv35tzcDCxtllvUAiRdhfgfdeL6TJdQsewjSiCLNndXZFMR1
	 2X7upvFTN2dUmx+Vx77LNm8dakmxAKjHI+/S4+nErjfeo22z4OfCgUT7oWUbzksJf4
	 qPJOXmrfJV3oIfrAToJob9r376EA0DV95a9zoBIc/n/eiLAwqtB7EqrPY1YvcsuVoR
	 Oa1XiMs5R/k8w==
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
Subject: [PATCH net v2 3/7] eth: forcedeth: fix calling napi_enable() in atomic context
Date: Wed, 22 Jan 2025 16:45:16 -0800
Message-ID: <20250123004520.806855-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123004520.806855-1-kuba@kernel.org>
References: <20250123004520.806855-1-kuba@kernel.org>
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


