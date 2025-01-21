Return-Path: <netdev+bounces-160138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92EA187A4
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4FB7A4490
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A461F8F12;
	Tue, 21 Jan 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STlP86Va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E41F8AE6
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497728; cv=none; b=t6MIXI6LeWkZFizVAsBm/5Gml38XilDu+5RPoMrAA4gnaR7QWQCl6hChfhtdMFx6iUaDPNCi/vhM9YgUWv+AGudgvrNEHtB919EpxT7eCK7h054LDnF+sLGemHPve7DB12Wxktrj5ODUy0IhU7VESj3NuBCh80Eh7Nh2zetUvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497728; c=relaxed/simple;
	bh=ly48lvo3sYvZaryFsr2Fi2QggGvgJaMQ9IVTFyjh6b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXrRv+xjIp+ALZ7tfTbAcNZcm4anE0E5e8hgPKJb6nmH73x8qhebGPKaG5O+6D17qiGxRBxvPiQrrFbOv0SFaUvF1GO2QpoeErykhN4mTNpB+allvlBYQ9oRD+++HoeIh9prqUxbPxJYuuzyF0qCVEgWLf7ZYmvCdHgx1qaBJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STlP86Va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A980C4CEE9;
	Tue, 21 Jan 2025 22:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497728;
	bh=ly48lvo3sYvZaryFsr2Fi2QggGvgJaMQ9IVTFyjh6b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STlP86VabetVTCDh/1KRkJieIyKoncN+1vJPLstWVMNQ1qeaOdE99R4gNdMAwVltB
	 iCbZty4DF1hP1Dxi7PtOWznm1VOqQxLo2jrUwUOlH2fJTBxH88BBFGzAmdHgwwAqtz
	 jaXaCtj4goQKS1w1NB6bYWOnThVr9MMeE3vL3FFaq/Uz9JeKQaPYcfw8GgBzpTzgN3
	 /TGbwR8o1MAcyJ+bgJ8Z43Nvp3hpj1LC6u2TkJOxElzFKnkMBTfl90BT1l6LCmhVgL
	 UxtUa/5p9CTm+Sr6r5Ff/Xe2n8E0UiHHzBZDDvfTk0wJFuIqthWrnazn584Y95zW1O
	 KQHwo0+kNvBMw==
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
Subject: [PATCH net-next 6/7] eth: via-rhine: fix calling napi_enable() in atomic context
Date: Tue, 21 Jan 2025 14:15:18 -0800
Message-ID: <20250121221519.392014-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121221519.392014-1-kuba@kernel.org>
References: <20250121221519.392014-1-kuba@kernel.org>
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
CC: kevinbrace@bracecomputerlab.com
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
---
 drivers/net/ethernet/via/via-rhine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 894911f3d560..f27157561082 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
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


