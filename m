Return-Path: <netdev+bounces-158381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D1A11820
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2CD3A76CB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772E22F82C;
	Wed, 15 Jan 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTXbVQ6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099422F822
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913222; cv=none; b=hmvjbgz+w6A5HYwcvRLaZTp/B/9MP10wVoJylx9Trpz2aNGMQ8CODV2ZE216z7TtPYOtI2QT8fW7R9wQFrj2pbiOFrQjqpxE9nqKI14X5euMxqiE/NnZkQ47H9Qaz3crG6hYFPmbECEPy4VWOunYZCwJcysOB6sQtEoAU76tCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913222; c=relaxed/simple;
	bh=vTnzmHtGahe7bsE6KbOJEQ3kZZy4qG4BsKrcxqQVetc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtXZYbJoBtX+Wk0gMa24XHb21uFb0dLxsMWv+hgZO3kRJ3NxYMD8XeWAAUzeBIRUlvFc8+QydHxoqPsnGZj0xL1cLW+67cMFqcUrR27EtSZYRuGjHYDqc0rrsRBeBnYM7UuWRUMivw3G3NOs3/2SbQxsJ/jIDEN/VDprKuzR64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTXbVQ6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E222CC4CEDF;
	Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913222;
	bh=vTnzmHtGahe7bsE6KbOJEQ3kZZy4qG4BsKrcxqQVetc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTXbVQ6Z2b+YvNCfJAe/lnCKjc/0MEZ6ySH9Nq7iSM77eJRcM2SEJcYxued8nKbHL
	 3Q/GBqy7d7m2J+9WgxQ1x6xWT8FGxvI1ucLlWM4MEVXdesfTzLCTifhWTln78qwXit
	 Q12l8MQp0+JNEU61KIH7hOnb43+ZSPhH55ReXlWsxhnhvQkN73PaizCInHIW1hJrr/
	 NPRPgpDHhN8miq6EnRysHLArJgZsq1JJUFQMqnU0FVb8DvPeeVUoFrRR/bcc2C4Hlu
	 DdPX4RAbaKe0Ez12IVZRtdOHozJ/6jM8X6eOr9KySzf02s9KjvfgLAXfe3fE3PJcVA
	 ALiQufa5Lo6GA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 10/11] net: protect NAPI config fields with netdev_lock()
Date: Tue, 14 Jan 2025 19:53:18 -0800
Message-ID: <20250115035319.559603-11-kuba@kernel.org>
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

Protect the following members of netdev and napi by netdev_lock:
 - defer_hard_irqs,
 - gro_flush_timeout,
 - irq_suspend_timeout.

The first two are written via sysfs (which this patch switches
to new lock), and netdev genl which holds both netdev and rtnl locks.

irq_suspend_timeout is only written by netdev genl.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 7 ++++---
 net/core/net-sysfs.c      | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 390fb70667bf..6f1e5725aca9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -384,11 +384,11 @@ struct napi_struct {
 	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id; /* protected by netdev_lock */
 	struct hrtimer		timer;
-	struct task_struct	*thread; /* protected by netdev_lock */
+	/* all fields past this point are write-protected by netdev_lock */
+	struct task_struct	*thread;
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
-	/* all fields past this point are write-protected by netdev_lock */
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
@@ -2452,7 +2452,8 @@ struct net_device {
 	 * Drivers are free to use it for other protection.
 	 *
 	 * Protects:
-	 *	@napi_list, @net_shaper_hierarchy, @reg_state, @threaded
+	 *	@gro_flush_timeout, @napi_defer_hard_irqs, @napi_list,
+	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 9365a7185a1d..07cb99b114bd 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -450,7 +450,7 @@ static ssize_t gro_flush_timeout_store(struct device *dev,
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	return netdev_store(dev, attr, buf, len, change_gro_flush_timeout);
+	return netdev_lock_store(dev, attr, buf, len, change_gro_flush_timeout);
 }
 NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
@@ -470,7 +470,8 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	return netdev_store(dev, attr, buf, len, change_napi_defer_hard_irqs);
+	return netdev_lock_store(dev, attr, buf, len,
+				 change_napi_defer_hard_irqs);
 }
 NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_uint);
 
-- 
2.48.0


