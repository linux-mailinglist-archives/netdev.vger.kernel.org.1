Return-Path: <netdev+bounces-160139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CADA187A5
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C0016A9C3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BE1F91C1;
	Tue, 21 Jan 2025 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww7bQa/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1161F8F1C
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497729; cv=none; b=EREkN9xHU2eC/VbtPAvvr3pPy7pvsL/Jhp5doCkMZZ8BJnjRlL3bGCBpZfKYWgtr4q09I0UUmjX9KydNZkYUJi78RuXEkUDQkb3I3X6/keT+YHJL3EsvxocpNhX+svDTv8qZrq37dZgEcKtTF+IEa7kyrs2Hv/NKr9lG/UPXuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497729; c=relaxed/simple;
	bh=UEWVpCm59rWBJZDc20PiAdgsV5omP3b/7jDCZudyFX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOFYCjfe1nMyNczs1pW9//rrrz5XS3sb/t1AMtzxTikb0A8jogQxRsFg7FkD7s8otmK7j3qmQhnVprlOeL8nWuGLevJTSzi8aKc1kIKRmBBaI2W/w9RdD/NBzp0CT0ZFcpFiIJfOsTqJxpCJzPK0RWRqcMMe1gIqXYDUQ6aVA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww7bQa/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88903C4CEDF;
	Tue, 21 Jan 2025 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497728;
	bh=UEWVpCm59rWBJZDc20PiAdgsV5omP3b/7jDCZudyFX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww7bQa/1Slm5IbAaB/jjhy9JZO2y2wezfGyVjPGMInS8KMktGSdE4Ij++V5yFhDZV
	 h7DQOyWE4yhX49RREuDRdiq9K4kcafTdb310FR/0WbRu/LaRdKVhJ9R8ujy/zmoN+o
	 TQnhG5a+bY3gqSj4jbL8Vo51GtF4r41WThqYisQKnHbtn7/78sNbajSJsbwKtk2DlH
	 /evzrsAGfwj/1V2fxP75KvPKYEJEksqGMYnFqz6JZatvbZ9wgnq8Hg+CbN7L5XED14
	 QqTKvZ4WMbkA6wWaTKfX+Dy2zVY+Zhs0nC4ft/lleVCtvRh5qWXL5UkedO7gCZX71+
	 qMJVpVx/6RH9g==
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
Subject: [PATCH net-next 5/7] eth: niu: fix calling napi_enable() in atomic context
Date: Tue, 21 Jan 2025 14:15:17 -0800
Message-ID: <20250121221519.392014-6-kuba@kernel.org>
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

napi_enable() may sleep now, take netdev_lock() before np->lock.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
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


