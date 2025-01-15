Return-Path: <netdev+bounces-158373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FABA11818
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879F73A7446
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F3322E3FF;
	Wed, 15 Jan 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRy8UV3z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A322E3F4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913218; cv=none; b=Y5rbqMG5QL0HgTP6RhpuDcc0/f6AmCcC3YUP3BZcNS6ar6ppUmkdZ4egyfnDIJzufpuTOb5WeOrZ7hEPUreJO2hRTb4wwALpgaRONWzdh/MMoqhn92zC0atODTDd/akTV11f0qtMjUTfMKzqV8pns0y5N/OJPrF21xWGfj6RKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913218; c=relaxed/simple;
	bh=9JEyl5sdkje6p3P7Kzrigfid34QwP8UKD23Ziugmw+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uos6hf9MWOxpD+gTy2pSMwcvR4cNWa5wfwZrwzN+8+YKOMOzP9ewuqad1CC/+//+GAFlcOKp5V8ozcrLgzlRk279aWRp+KfN5Q4NTIYuC9ecFP+n7kGbJk54Q9bu2qg324dVH6VKMJLKgedWJyhXoFHsIJqGJ4cxIWMRjOH31ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRy8UV3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D884EC4CEE2;
	Wed, 15 Jan 2025 03:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913218;
	bh=9JEyl5sdkje6p3P7Kzrigfid34QwP8UKD23Ziugmw+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRy8UV3z05haUCU97iJrfkf4zuCXmtZw43P7TL2AcmGzqgrfJlVxTk35n+FXdFbjd
	 HO5MZ6qVqTj5IpKAe0WvcG5z9qqaDEBZ46wPrYqRQjZLJMrHqu11jfutzrQ3arJsXI
	 a9VWr+G2qNJQEJvXGav8L3mbZhHI3h1FwggV4HxXAEegh4B/WkuIbCWDd0GSCzj+hw
	 zC01M6ECX6Hb7oUG+rgfAOlbVeJXcnAOvDepu11se106j3FIFU5l/96ePH/r7z3CZx
	 mxFTDb2FQoFldms6gFu6iBfAxraepvUXh8pMhUlnZkagWMTBWltmqOHSB0F87feLrU
	 XTQzl0v/70XHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 02/11] net: make netdev_lock() protect netdev->reg_state
Date: Tue, 14 Jan 2025 19:53:10 -0800
Message-ID: <20250115035319.559603-3-kuba@kernel.org>
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

Protect writes to netdev->reg_state with netdev_lock().
From now on holding netdev_lock() is sufficient to prevent
the net_device from getting unregistered, so code which
wants to hold just a single netdev around no longer needs
to hold rtnl_lock.

We do not protect the NETREG_UNREGISTERED -> NETREG_RELEASED
transition. We'd need to move mutex_destroy(netdev->lock)
to .release, but the real reason is that trying to stop
the unregistration process mid-way would be unsafe / crazy.
Taking references on such devices is not safe, either.
So the intended semantics are to lock REGISTERED devices.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - reorder with next patch
v1: https://lore.kernel.org/20250114035118.110297-4-kuba@kernel.org
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 891c5bdb894c..30963c5d409b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2448,7 +2448,7 @@ struct net_device {
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
 	 * Drivers are free to use it for other protection.
 	 *
-	 * Protects: @net_shaper_hierarchy.
+	 * Protects: @reg_state, @net_shaper_hierarchy.
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index fda4e1039bf0..6603c08768f6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10668,7 +10668,9 @@ int register_netdevice(struct net_device *dev)
 
 	ret = netdev_register_kobject(dev);
 
+	netdev_lock(dev);
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
+	netdev_unlock(dev);
 
 	if (ret)
 		goto err_uninit_notify;
@@ -10942,7 +10944,9 @@ void netdev_run_todo(void)
 			continue;
 		}
 
+		netdev_lock(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
+		netdev_unlock(dev);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11548,7 +11552,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
 		unlist_netdevice(dev);
+		netdev_lock(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
+		netdev_unlock(dev);
 	}
 	flush_all_backlogs();
 
-- 
2.48.0


