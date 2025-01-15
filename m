Return-Path: <netdev+bounces-158379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F0A1181F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3EC3A8791
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863E22F3B0;
	Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqs5rJ/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B322DC5D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913221; cv=none; b=Rlv+KHYL/0LF6AN0efvnOwUCM2q6Gm7FYRH2lpjGvnib5dz0ki7sJAsmN7OdWB8ibwRcxrhJaCaZvFqc676Lcbu8d/uI7qYwp/KlIayVo2F48WuyF8r7VinF+FvF+DWvlAeHdkCLYxD0A83xeH6XsFf1uE5OVMRdfN0WDsNf3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913221; c=relaxed/simple;
	bh=XZMCyfzUH5kA6wnjtBdIQuynGd66w3NqmqTblX+cAHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrDPyuh064Xv8jci+ZvcBDDjm6/3STDWBWonkkr16uiZo5pYJhHzdh6mInaouHGUm3Wj3bwoZ2yMfClCTXh7sOgGNbz1cdwLhleaj7P64PHBLppk48dxqWDSdiyhuSAqjZkLQCdU8Tdzane3nirJtiINXIzqaySYGjL8bdVkFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqs5rJ/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7449C4CEE2;
	Wed, 15 Jan 2025 03:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913221;
	bh=XZMCyfzUH5kA6wnjtBdIQuynGd66w3NqmqTblX+cAHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mqs5rJ/yfVYd2lkgVhD54Dzk3bQDjwBk//EgdSbWfpkjLZM5FJ0PDBkJHulPC1qfi
	 hE0yd25wOJ3puOpSfHwV+okWwSKWQhr75z6AfbxC82vhj6pqNEnH6TtaMrZ3QHjG5L
	 QjTTsbcWNcMk7LSdvsTh7DA+xfdjA1G8NzZTV7U99WRxsLvwFsPMlkDacMo281j/ug
	 L/VKWCKYK1NY6+xYk/wnrpv/0ExOOrHMez4AHJHRFtok3xMW9XmJWnmqcETArRdopz
	 7ThIbqbm5/ru8VQJowiKyBYOswU+xjJCQACQURMaCFrh9C4bqsYeffmpSnrIjJSuLB
	 8QptyevquH/gg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	leitao@debian.org
Subject: [PATCH net-next v2 08/11] net: protect threaded status of NAPI with netdev_lock()
Date: Tue, 14 Jan 2025 19:53:16 -0800
Message-ID: <20250115035319.559603-9-kuba@kernel.org>
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

Now that NAPI instances can't come and go without holding
netdev->lock we can trivially switch from rtnl_lock() to
netdev_lock() for setting netdev->threaded via sysfs.

Note that since we do not lock netdev_lock around sysfs
calls in the core we don't have to "trylock" like we do
with rtnl_lock.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - update the comment on dev_isalive()
v1: https://lore.kernel.org/20250114035118.110297-9-kuba@kernel.org

CC: leitao@debian.org
---
 include/linux/netdevice.h | 13 +++++++++++--
 net/core/dev.c            |  2 ++
 net/core/net-sysfs.c      | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4ab33fbadd9f..bf3da95c9350 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -384,7 +384,7 @@ struct napi_struct {
 	int			rx_count; /* length of rx_list */
 	unsigned int		napi_id; /* protected by netdev_lock */
 	struct hrtimer		timer;
-	struct task_struct	*thread;
+	struct task_struct	*thread; /* protected by netdev_lock */
 	unsigned long		gro_flush_timeout;
 	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
@@ -2451,11 +2451,13 @@ struct net_device {
 	 * Drivers are free to use it for other protection.
 	 *
 	 * Protects:
-	 *	@napi_list, @net_shaper_hierarchy, @reg_state
+	 *	@napi_list, @net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
 	 *
+	 * Also protects some fields in struct napi_struct.
+	 *
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
@@ -2697,6 +2699,13 @@ static inline void netdev_assert_locked(struct net_device *dev)
 	lockdep_assert_held(&dev->lock);
 }
 
+static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
+{
+	if (dev->reg_state == NETREG_REGISTERED ||
+	    dev->reg_state == NETREG_UNREGISTERING)
+		netdev_assert_locked(dev);
+}
+
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
diff --git a/net/core/dev.c b/net/core/dev.c
index 9734c3f5b862..d90bb100285d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6784,6 +6784,8 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 	struct napi_struct *napi;
 	int err = 0;
 
+	netdev_assert_locked_or_invisible(dev);
+
 	if (dev->threaded == threaded)
 		return 0;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2d9afc6e2161..9365a7185a1d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -36,7 +36,7 @@ static const char fmt_uint[] = "%u\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
-/* Caller holds RTNL or RCU */
+/* Caller holds RTNL, netdev->lock or RCU */
 static inline int dev_isalive(const struct net_device *dev)
 {
 	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
@@ -108,6 +108,36 @@ static ssize_t netdev_store(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
+/* Same as netdev_store() but takes netdev_lock() instead of rtnl_lock() */
+static ssize_t
+netdev_lock_store(struct device *dev, struct device_attribute *attr,
+		  const char *buf, size_t len,
+		  int (*set)(struct net_device *, unsigned long))
+{
+	struct net_device *netdev = to_net_dev(dev);
+	struct net *net = dev_net(netdev);
+	unsigned long new;
+	int ret;
+
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
+
+	netdev_lock(netdev);
+
+	if (dev_isalive(netdev)) {
+		ret = (*set)(netdev, new);
+		if (ret == 0)
+			ret = len;
+	}
+	netdev_unlock(netdev);
+
+	return ret;
+}
+
 NETDEVICE_SHOW_RO(dev_id, fmt_hex);
 NETDEVICE_SHOW_RO(dev_port, fmt_dec);
 NETDEVICE_SHOW_RO(addr_assign_type, fmt_dec);
@@ -638,7 +668,7 @@ static ssize_t threaded_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
-	return netdev_store(dev, attr, buf, len, modify_napi_threaded);
+	return netdev_lock_store(dev, attr, buf, len, modify_napi_threaded);
 }
 static DEVICE_ATTR_RW(threaded);
 
-- 
2.48.0


