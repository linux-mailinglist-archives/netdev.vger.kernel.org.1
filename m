Return-Path: <netdev+bounces-157984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D2A0FFC4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA833A37B2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20A237A46;
	Tue, 14 Jan 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIcfVaCV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE1237A42
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826696; cv=none; b=FR05QoMSIExFAqxTU+Ckvwbmai3av+25N1W66K9ldEkf9WLznbcQeB5HGffu1Rx3cYdpHy7EbYfpkTicEoKxKgGP91DSOdSWE39wjg1Ra+KxBiXtofd1WjxjTDO5WeptuEZq9XPk2PHrljMqc2ESNzRE1jD9wnKUFWFh84xNWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826696; c=relaxed/simple;
	bh=/4XrkvlKOJPZxij//0PUUE4HevuFjRXGOD+YZA5nW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSdld032S5X60IA5pzwSvyxUKfC/N+C99LzX5eKqZ4FE4gcr4cURwzKFGOQLzZvS7ffyF+fW6iNzHAMpzHoTlb2Xm7nYg+WgDHLKCs5ySdfuIMD7ZjcFdK9xvaQH4oHLL5kAdryf+70M5ByBXRVLve/KsSRoh7WklrOUBL0zf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIcfVaCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E47C4CEE3;
	Tue, 14 Jan 2025 03:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826696;
	bh=/4XrkvlKOJPZxij//0PUUE4HevuFjRXGOD+YZA5nW9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIcfVaCVjmVH2DY16Vy1jubQ7lLAHXT9K73Lb1PeBGnWgKjdcFjjsfXcd62OesNO4
	 +99fR1bQLGQq78OzAzNBYM9P8MYNwPEhuxt2NsXNmS+MtaPnZxHW+Raxi8rZow3Zmy
	 MRlzCkPigvQbIqnU5kizWPF5o9wnYYZ60qQsfw8IQxHUQGN5HfKqXGTi0iKlAGm1IH
	 iMf57vVZQxT6zfb26nRr4VNZnJOTM9HsRvsmU8kn5L9oY5MmhWlW7KD4rY08fh44qN
	 C0YscvvUlO9hgRgGEOgD7gKuyHSz588C048nv02Bl0gdvIztrJWgz0uuR4SR8BWLrp
	 qzkHQCxc0sqiw==
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
Subject: [PATCH net-next 08/11] net: protect threaded status of NAPI with netdev_lock()
Date: Mon, 13 Jan 2025 19:51:14 -0800
Message-ID: <20250114035118.110297-9-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
---
 include/linux/netdevice.h | 13 +++++++++++--
 net/core/dev.c            |  2 ++
 net/core/net-sysfs.c      | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3108a12e562..75c30404657b 100644
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
@@ -2451,10 +2451,12 @@ struct net_device {
 	 * Drivers are free to use it for other protection.
 	 *
 	 * Protects:
-	 *	@napi_list, @net_shaper_hierarchy, @reg_state
+	 *	@napi_list, @net_shaper_hierarchy, @reg_state, @threaded
 	 * Partially protects (readers hold either @lock or rtnl_lock,
 	 * writers must hold both for registered devices):
 	 *	@up
+	 * Also protects some fields in struct napi_struct.
+	 *
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
@@ -2696,6 +2698,13 @@ static inline void netdev_assert_locked(struct net_device *dev)
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
index 1151baaedf4d..5872f0797cc3 100644
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
index 2d9afc6e2161..5602a3c12e9a 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
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
2.47.1


