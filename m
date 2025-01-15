Return-Path: <netdev+bounces-158380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04289A1181E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF4B168D4F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738D22F3B6;
	Wed, 15 Jan 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUDye+To"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEB22F3B1
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913221; cv=none; b=Nuv2WUpsBRfiCBxqulKrXyBH7wROdNa3QFl20efCbkExxC+Rr04xuGhGiPLW9wXtBEm0T2xLO0QYw9XpzbIZ8DkU6Fh9HpvC3eoujssQpoQJRySJGQRGnjZZRK78Xekhn917y0rFWpmS48WEVfxCXykj661v+ET8/GrdBw8aRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913221; c=relaxed/simple;
	bh=D9w2XEcMFHLvKicI7xIIwq/in2BDlW4Yhb8NuHCc0B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwZxOVNCExC5tVOIZL6z9WZlVgZZ09I94AWO4HcrFlyuyIVmXZI+eYRsDOOdWHIiSHi19aLxK1mWYnMT6HyOgQogtRcN7Io0bsdqwBf0DsAmcz4ZKWc8ON3tuvHrEJl+sz5RQCiA7dRq7dEib06mPWpidbE6qUJH8WKLFKr0+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUDye+To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69585C4CEE6;
	Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913221;
	bh=D9w2XEcMFHLvKicI7xIIwq/in2BDlW4Yhb8NuHCc0B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUDye+TogU9uhf4JIOEfZQ0E7bWmknJHKSgJguYwgMNyCA0VglrjEu9soxQS6bC1I
	 n3oE0TTlSwBi2ZFCwn6el8UYEinVbYDVPyAytS0wlaR3ughF44byZOldUVD9H4/CMW
	 YJqLNAZJp3TvPyuFH6iyczEmFOsPGNPM6bSOtqP3euYxYz5VcqIVjej2lpF2vJVOPi
	 a/Tz+HzpJOeb9hhtJyYz0iHxAqYqpkZGS0xJAJkQlQppnIsEITllO13qD/sXypzDOo
	 bfRjosfS4AoIK0GdrJhQVqCUntsJYk9oyLFp6kTq3k1DUIfqBF/cHw5T4GlWZdrYmE
	 eWEZpcz+jzYLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/11] net: protect napi->irq with netdev_lock()
Date: Tue, 14 Jan 2025 19:53:17 -0800
Message-ID: <20250115035319.559603-10-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take netdev_lock() in netif_napi_set_irq(). All NAPI "control fields"
are now protected by that lock (most of the other ones are set during
napi add/del). The napi_hash_node is fully protected by the hash
spin lock, but close enough for the kdoc...

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 10 +++++++++-
 net/core/dev.c            |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf3da95c9350..390fb70667bf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -388,6 +388,7 @@ struct napi_struct {
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
+	/* all fields past this point are write-protected by netdev_lock */
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
@@ -2706,11 +2707,18 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 		netdev_assert_locked(dev);
 }
 
-static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+static inline void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
 }
 
+static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
+{
+	netdev_lock(napi->dev);
+	netif_napi_set_irq_locked(napi, irq);
+	netdev_unlock(napi->dev);
+}
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index d90bb100285d..495ceefcdc34 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6956,7 +6956,7 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = false;
-	netif_napi_set_irq(napi, -1);
+	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
 
-- 
2.48.0


