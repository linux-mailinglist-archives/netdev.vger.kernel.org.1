Return-Path: <netdev+bounces-160721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BEA1AEFA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA43A9269
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0081D8E06;
	Fri, 24 Jan 2025 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umy/4F2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5EE1D8DEA
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688735; cv=none; b=jJREcILveZKi88lTRkTm2eBn/aPEsSBXD7wD+V0STLZ9L9xtKMg92GURbNTvaISEr3Jlx1HDNcG7LbE6LHHNyzGheohStBtJ6LgRCDW/OGqM+lJPyNzN1YxzybLM0kqZBbPyQqA0arofVMYObHwl3AOtyxDj0bHJvP86+cszbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688735; c=relaxed/simple;
	bh=X0/mxlb/Jfxgz6R8FzdBgypuJHZPfih9S1I0n8lgdkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyL5lNt885qdiQKd1zTME66r37whwj2V8N8HeclAbdPzHxrTOTe/CB12wpXthwjtOPWtJyWgXxYdTp+KSLk0xpDNVCDWjE9QrEWDuIplGtE+KWgSx9v+4VuOvvfXk3p4MYHHNHq8pkG2K7o93scD7XC9PPHPRzL2x44IwOTvhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umy/4F2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A952EC4CEE4;
	Fri, 24 Jan 2025 03:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688735;
	bh=X0/mxlb/Jfxgz6R8FzdBgypuJHZPfih9S1I0n8lgdkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Umy/4F2BQ1nUCWPXrmOzFXlWR7kiWBaVQ5L+gs8GqSKxF2AyClIC9iLo2EO1CQjW+
	 x4mVz5JxRrVnByM0SfKt9I49F7kvjguhQHCpJq2cW+1QLA2Vue6iOjKXrcqcdP/kVu
	 WKOYU3jAXRfK68DYuWannEceh7Wpatakg0WBb/T7tfnB7Q7QtdWmnMh8XwppoAeIEk
	 gNCYdu3CH25/x9WLtHH07aK3LLSoAcnWzqGKe10Ky8XNqWfC6FMAt+U7OB5+p6DAAn
	 wrz7jvLzD28Q8mwHejAFNZbF/7M9j5VM2xEQa+EgfSXwxCeYi8e3QsEpwtzwu4drOf
	 e8e1HNVJoZDqw==
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
Subject: [PATCH net v3 6/7] eth: via-rhine: fix calling napi_enable() in atomic context
Date: Thu, 23 Jan 2025 19:18:40 -0800
Message-ID: <20250124031841.1179756-7-kuba@kernel.org>
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

napi_enable() may sleep now, take netdev_lock() before rp->lock.
napi_enable() is hidden inside init_registers().

Note that this patch orders netdev_lock after rp->task_lock,
to avoid having to take the netdev_lock() around disable path.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


