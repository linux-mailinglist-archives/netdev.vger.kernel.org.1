Return-Path: <netdev+bounces-160444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED8A19BE7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F070F3AC320
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A62B9A9;
	Thu, 23 Jan 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4u7l3q/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD92628D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593127; cv=none; b=YddSOpYwCFHHVzMUtZcsqLx2DRK9vuNNHuZJ8k9sLqUSosnvwYFhvtzUoLz0+m0hlD9l42pWKoRvZvG+OIrbtFHs+pPAJlEdQVWz9lL9rcOznuTioxisAgxPuezk0zKnskIQxLjuesWnB/p3Y1c+MBfj0zwHUfNZFtNVk9qo+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593127; c=relaxed/simple;
	bh=ILkgwHnIje0sb8fDH0UNH2FBGkDS5gzCzG73EyXT1b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxdG8Iifne0WcpCvvkWtesov1HXazoA/py4BVLZQg/cM7H4iNmyTlnHztMYubKoHypeZl0KAVN6JYalYmP5c5TRPOdxyACDvwIygPopEeK5qLIxmG02jJx9xTDEcVn0LSLxo/jgEWowDdTnfQo+ViNKNgQQQFSMXpKx4zks5Vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4u7l3q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1769C4CEE3;
	Thu, 23 Jan 2025 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593127;
	bh=ILkgwHnIje0sb8fDH0UNH2FBGkDS5gzCzG73EyXT1b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4u7l3q/olY0qIBKxCWtvzTk5P9iBVCaY9EK4IbAyqhLmTsgaWaiiRDGM6GYdJ0e4
	 445eTKCvYuCuQa7lDmYD22Rn8XpHB3EHDMXMaL1K10jLtwVjtcpFJEZQONWDyVxo5Y
	 bvCqsRt1iIbk72ysWVItjmDHDFcrIzlsFewBU0QM0dV66c3V7nVuGo5SE/qWsLDWw/
	 s3cVPpYWt29900cakVMcKNOsWk5/KHBZTpkkSiY9Dj2FZQqW3SzRJcE8IzXvzutEU6
	 olOEOrJy63/YFaIRZkvJJ1Y6tyJ9HBOECy1B+3DpwSzN89v78/fhGLs5HmlRH94PSV
	 do0VcEhJJs7Lw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	kevinbrace@bracecomputerlab.com,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com
Subject: [PATCH net v2 6/7] eth: via-rhine: fix calling napi_enable() in atomic context
Date: Wed, 22 Jan 2025 16:45:19 -0800
Message-ID: <20250123004520.806855-7-kuba@kernel.org>
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

napi_enable() may sleep now, take netdev_lock() before rp->lock.
napi_enable() is hidden inside init_registers().

Note that this patch orders netdev_lock after rp->task_lock,
to avoid having to take the netdev_lock() around disable path.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - actually switch to napi_enable_locked()
v1: https://lore.kernel.org/20250121221519.392014-7-kuba@kernel.org

CC: kevinbrace@bracecomputerlab.com
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
---
 drivers/net/ethernet/via/via-rhine.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 894911f3d560..e56ebbdd428d 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -1568,7 +1568,7 @@ static void init_registers(struct net_device *dev)
 	if (rp->quirks & rqMgmt)
 		rhine_init_cam_filter(dev);
 
-	napi_enable(&rp->napi);
+	napi_enable_locked(&rp->napi);
 
 	iowrite16(RHINE_EVENT & 0xffff, ioaddr + IntrEnable);
 
@@ -1696,7 +1696,10 @@ static int rhine_open(struct net_device *dev)
 	rhine_power_init(dev);
 	rhine_chip_reset(dev);
 	rhine_task_enable(rp);
+
+	netdev_lock(dev);
 	init_registers(dev);
+	netdev_unlock(dev);
 
 	netif_dbg(rp, ifup, dev, "%s() Done - status %04x MII status: %04x\n",
 		  __func__, ioread16(ioaddr + ChipCmd),
@@ -1727,6 +1730,8 @@ static void rhine_reset_task(struct work_struct *work)
 
 	napi_disable(&rp->napi);
 	netif_tx_disable(dev);
+
+	netdev_lock(dev);
 	spin_lock_bh(&rp->lock);
 
 	/* clear all descriptors */
@@ -1740,6 +1745,7 @@ static void rhine_reset_task(struct work_struct *work)
 	init_registers(dev);
 
 	spin_unlock_bh(&rp->lock);
+	netdev_unlock(dev);
 
 	netif_trans_update(dev); /* prevent tx timeout */
 	dev->stats.tx_errors++;
@@ -2541,9 +2547,12 @@ static int rhine_resume(struct device *device)
 	alloc_tbufs(dev);
 	rhine_reset_rbufs(rp);
 	rhine_task_enable(rp);
+
+	netdev_lock(dev);
 	spin_lock_bh(&rp->lock);
 	init_registers(dev);
 	spin_unlock_bh(&rp->lock);
+	netdev_unlock(dev);
 
 	netif_device_attach(dev);
 
-- 
2.48.1


