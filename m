Return-Path: <netdev+bounces-236556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA655C3DF84
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26818188BF2F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CB2798E8;
	Fri,  7 Nov 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="apWOWkkW"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94002773E6;
	Fri,  7 Nov 2025 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475121; cv=none; b=TSLIEX9VZXGwN07vJvJKPmtGGp2P4uWGjrAdsD6hmdvGWFc4HNj0q4X7uZlnEqD+Bw9Sy45GEx7W+fhhsU1xwU2pwUVnTmSfkGL1cVthnvWoYYWWGM0e89XU3k+zV9IvUU/fCovKCsIM71yDhSwbWYmWk4gmzDrt7AYSY7kdjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475121; c=relaxed/simple;
	bh=LDmqdMJWCSfkaVmbJIiA4PDQ5WGcXKlf4M01bhHn6Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUOpw+FVDr1Tiv8HG2/+FmE/FeI/q4xmIe1T9TGY+p7kpnRJ/1qlXo7UQbp0NbEHzJ2avqdRmoo4KjzUs9nyRAcyww36LyLOgr5vqBzq5jwxuD2G73Tjh06L39UtiEdeXvGgXi4RbHI7NZlh/bzfktRRQQvx++4dj0eJms1ckO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=apWOWkkW; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2107FC000C7B;
	Thu,  6 Nov 2025 16:25:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2107FC000C7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762475113;
	bh=LDmqdMJWCSfkaVmbJIiA4PDQ5WGcXKlf4M01bhHn6Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apWOWkkWrcPUIqaIVDFMQIJh4ZXNbWREJ4s5Dd+Mcx2NdbkgfFA4YRPRnECxGa7b0
	 7TXNFWcP32t9Wrllc8vLd2FS7vFkfq7c/QqHZ7kzrXEncCyhwyQOe19rE+g5Zexftt
	 ZDh8la6Ju+ZOjNRQvpKHrO8KE+/TClhl1OVb7Gt8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B79E01800084D;
	Thu,  6 Nov 2025 16:25:12 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/2] net: ethernet: Allow disabling pause on panic
Date: Thu,  6 Nov 2025 16:25:09 -0800
Message-Id: <20251107002510.1678369-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
References: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Development devices on a lab network might be subject to kernel panics
and if they have pause frame generation enabled, once the kernel panics,
the Ethernet controller stops being serviced. This can create a flood of
pause frames that certain switches are unable to handle resulting a
completle paralysis of the network because they broadcast to other
stations on that same network segment.

To accomodate for such situation introduce a
/sys/class/net/<device>/disable_pause_on_panic knob which will disable
Ethernet pause frame generation upon kernel panic.

Note that device driver wishing to make use of that feature need to
implement ethtool_ops::set_pauseparam_panic to specifically deal with
that atomic context.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/ABI/testing/sysfs-class-net | 16 +++++
 include/linux/ethtool.h                   |  3 +
 include/linux/netdevice.h                 |  1 +
 net/core/net-sysfs.c                      | 39 +++++++++++
 net/ethernet/Makefile                     |  3 +-
 net/ethernet/pause_panic.c                | 79 +++++++++++++++++++++++
 6 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 net/ethernet/pause_panic.c

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..da0e4e862aca 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -352,3 +352,19 @@ Description:
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
 		== ==================================
+
+What:		/sys/class/net/<iface>/disable_pause_on_panic
+Date:		Nov 2025
+KernelVersion:	6.20
+Contact:	netdev@vger.kernel.org
+Description:
+		Boolean value to control whether to disable pause frame
+		generation on panic. This is helpful in environments where
+		the link partner may incorrect respond to pause frames (e.g.:
+		improperly configured Ethernet switches)
+
+		Possible values:
+		== =====================================================
+		0  do not disable pause frame generation on kernel panic
+		1  disable pause frame generation on kernel panic
+		== =====================================================
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c2d8b4ec62eb..e014d0f2a5ac 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -956,6 +956,8 @@ struct kernel_ethtool_ts_info {
  * @get_pauseparam: Report pause parameters
  * @set_pauseparam: Set pause parameters.  Returns a negative error code
  *	or zero.
+ * @set_pauseparam_panic: Set pause parameters while in a panic context. This
+ *	call is not allowed to sleep. Returns a negative error code or zero.
  * @self_test: Run specified self-tests
  * @get_strings: Return a set of strings that describe the requested objects
  * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
@@ -1170,6 +1172,7 @@ struct ethtool_ops {
 				  struct ethtool_pauseparam*);
 	int	(*set_pauseparam)(struct net_device *,
 				  struct ethtool_pauseparam*);
+	void	(*set_pauseparam_panic)(struct net_device *);
 	void	(*self_test)(struct net_device *, struct ethtool_test *, u64 *);
 	void	(*get_strings)(struct net_device *, u32 stringset, u8 *);
 	int	(*set_phys_id)(struct net_device *, enum ethtool_phys_id_state);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e808071dbb7d..2d4b07693745 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2441,6 +2441,7 @@ struct net_device {
 	bool			proto_down;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
+	bool			disable_pause_on_panic;
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca878525ad7c..a752163ded8c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -770,6 +770,44 @@ static ssize_t threaded_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(threaded);
 
+static ssize_t disable_pause_on_panic_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct net_device *ndev = to_net_dev(dev);
+	ssize_t ret = -EINVAL;
+
+	rcu_read_lock();
+	if (dev_isalive(ndev))
+		ret = sysfs_emit(buf, fmt_dec, READ_ONCE(ndev->disable_pause_on_panic));
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int modify_disable_pause_on_panic(struct net_device *dev, unsigned long val)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!ops || !ops->set_pauseparam_panic)
+		return -EOPNOTSUPP;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	WRITE_ONCE(dev->disable_pause_on_panic, val);
+
+	return 0;
+}
+
+static ssize_t disable_pause_on_panic_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	return netdev_store(dev, attr, buf, len, modify_disable_pause_on_panic);
+}
+static DEVICE_ATTR_RW(disable_pause_on_panic);
+
 static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_netdev_group.attr,
 	&dev_attr_type.attr,
@@ -800,6 +838,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
 	&dev_attr_threaded.attr,
+	&dev_attr_disable_pause_on_panic.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(net_class);
diff --git a/net/ethernet/Makefile b/net/ethernet/Makefile
index e03eff94e0db..9b1f3ff8695a 100644
--- a/net/ethernet/Makefile
+++ b/net/ethernet/Makefile
@@ -3,4 +3,5 @@
 # Makefile for the Linux Ethernet layer.
 #
 
-obj-y					+= eth.o
+obj-y					+= eth.o \
+					   pause_panic.o
diff --git a/net/ethernet/pause_panic.c b/net/ethernet/pause_panic.c
new file mode 100644
index 000000000000..2a4960c5f261
--- /dev/null
+++ b/net/ethernet/pause_panic.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ethernet pause disable on panic handler
+ *
+ * This module provides per-device control via sysfs to disable Ethernet flow
+ * control (pause frames) on individual Ethernet devices when the kernel panics.
+ * Each device can be configured via /sys/class/net/<device>/disable_pause_on_panic.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/panic_notifier.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/notifier.h>
+#include <linux/if_ether.h>
+#include <net/net_namespace.h>
+
+/*
+ * Disable pause/flow control on a single Ethernet device.
+ */
+static void disable_pause_on_device(struct net_device *dev)
+{
+	const struct ethtool_ops *ops;
+
+	/* Only proceed if this device has the flag enabled */
+	if (!READ_ONCE(dev->disable_pause_on_panic))
+		return;
+
+	ops = dev->ethtool_ops;
+	if (!ops || !ops->set_pauseparam_panic)
+		return;
+
+	/*
+	 * In panic context, we're in atomic context and cannot sleep.
+	 */
+	ops->set_pauseparam_panic(dev);
+}
+
+/*
+ * Panic notifier to disable pause frames on all Ethernet devices.
+ * Called in atomic context during kernel panic.
+ */
+static int eth_pause_panic_handler(struct notifier_block *this,
+					unsigned long event, void *ptr)
+{
+	struct net_device *dev;
+
+	/*
+	 * Iterate over all network devices in the init namespace.
+	 * In panic context, we cannot acquire locks that might sleep,
+	 * so we use RCU iteration.
+	 * Each device will check its own disable_pause_on_panic flag.
+	 */
+	for_each_netdev(&init_net, dev) {
+		/* Reference count might not be available in panic */
+		if (!dev)
+			continue;
+
+		disable_pause_on_device(dev);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block eth_pause_panic_notifier = {
+	.notifier_call = eth_pause_panic_handler,
+	.priority = INT_MAX, /* Run as late as possible */
+};
+
+static int __init eth_pause_panic_init(void)
+{
+	/* Register panic notifier */
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &eth_pause_panic_notifier);
+
+	return 0;
+}
+device_initcall(eth_pause_panic_init);
-- 
2.34.1


