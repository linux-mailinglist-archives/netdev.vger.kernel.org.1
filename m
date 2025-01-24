Return-Path: <netdev+bounces-160720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6617A1AEF8
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE7916C13B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B61D89EC;
	Fri, 24 Jan 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/V8DA3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78791D88D1
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688734; cv=none; b=kijsmyIikdERCEE/8aM900ShQZ0++9Hj0fX6QGbjXObGQEnpCz7CYRoJ/6258qudurTV5kgxf+BQevwQiLQrNeTiBm7rRylCpjt47+kvhtQlQw5GLvbe8+IfsDJuYlCgfRmSYCQCGyBgakoXRnRDswQ5BZGxuvot+1wbs0IobwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688734; c=relaxed/simple;
	bh=hQf1J3ItQ4oRcRphtOkACcoJOJ4gLAc4gVVhH4Yo11o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/e9P2ADGWQJIos0muuQ2jAZoZ1ELPazVbSBFdAKmkSqfRfel24pjXA/tQQcr35mGpzkBd7sa0EsmxCFRR7wl4RoNIhkHYAfaPOr9RrnAc/mBI9yy4OE1AyTD99cQ59V+z4Iy9AkoYghMgun8fN+nyf7IGdYUCMGmU1R7FnxxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/V8DA3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325B8C4CEE2;
	Fri, 24 Jan 2025 03:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688734;
	bh=hQf1J3ItQ4oRcRphtOkACcoJOJ4gLAc4gVVhH4Yo11o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/V8DA3NTrdqcIMD2LIBEyS46fjhXEVKedN5SBo6tLsMBiLI32gm8EDRDo6lmG++w
	 uaxcJqznGpbgvwJQsRbtcqMu1x4NCJzaciln9GJN0nB647acFtH3riZOiqT2i9qoJT
	 mCiTO+KcMqiAHz4Ozrm3Ihi2U/gQBqkyhhmK4R9AoHq//3YEQ+QFzDEqVuoAxsfL23
	 4dZbEWhPH5S8jCOfcN+vJpYi6flwN0tjPakcTQafbJ72wqpWW1/gv/t6MYgGgs3OZ9
	 da0s8MvSd+bevfrTnApH+HUoMy3lPaexMKV+OgQ2wK5tw8Lc3la5JZlHaAjYcn17HD
	 mlqXsLS+A4+UA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	willy@infradead.org,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com
Subject: [PATCH net v3 5/7] eth: niu: fix calling napi_enable() in atomic context
Date: Thu, 23 Jan 2025 19:18:39 -0800
Message-ID: <20250124031841.1179756-6-kuba@kernel.org>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: willy@infradead.org
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
---
 drivers/net/ethernet/sun/niu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index d7459866d24c..72177fea1cfb 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6086,7 +6086,7 @@ static void niu_enable_napi(struct niu *np)
 	int i;
 
 	for (i = 0; i < np->num_ldg; i++)
-		napi_enable(&np->ldg[i].napi);
+		napi_enable_locked(&np->ldg[i].napi);
 }
 
 static void niu_disable_napi(struct niu *np)
@@ -6116,7 +6116,9 @@ static int niu_open(struct net_device *dev)
 	if (err)
 		goto out_free_channels;
 
+	netdev_lock(dev);
 	niu_enable_napi(np);
+	netdev_unlock(dev);
 
 	spin_lock_irq(&np->lock);
 
@@ -6521,6 +6523,7 @@ static void niu_reset_task(struct work_struct *work)
 
 	niu_reset_buffers(np);
 
+	netdev_lock(np->dev);
 	spin_lock_irqsave(&np->lock, flags);
 
 	err = niu_init_hw(np);
@@ -6531,6 +6534,7 @@ static void niu_reset_task(struct work_struct *work)
 	}
 
 	spin_unlock_irqrestore(&np->lock, flags);
+	netdev_unlock(np->dev);
 }
 
 static void niu_tx_timeout(struct net_device *dev, unsigned int txqueue)
@@ -6761,7 +6765,9 @@ static int niu_change_mtu(struct net_device *dev, int new_mtu)
 
 	niu_free_channels(np);
 
+	netdev_lock(dev);
 	niu_enable_napi(np);
+	netdev_unlock(dev);
 
 	err = niu_alloc_channels(np);
 	if (err)
@@ -9937,6 +9943,7 @@ static int __maybe_unused niu_resume(struct device *dev_d)
 
 	spin_lock_irqsave(&np->lock, flags);
 
+	netdev_lock(dev);
 	err = niu_init_hw(np);
 	if (!err) {
 		np->timer.expires = jiffies + HZ;
@@ -9945,6 +9952,7 @@ static int __maybe_unused niu_resume(struct device *dev_d)
 	}
 
 	spin_unlock_irqrestore(&np->lock, flags);
+	netdev_unlock(dev);
 
 	return err;
 }
-- 
2.48.1


