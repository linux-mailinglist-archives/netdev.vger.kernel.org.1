Return-Path: <netdev+bounces-235234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F87C2DF0B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAF418971F6
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974623191D3;
	Mon,  3 Nov 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jDkzyxCM"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8282BD5A2;
	Mon,  3 Nov 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199214; cv=none; b=ZyKfKpNA99E6fyA6AAF7WSIyQxYKTV7eVZHWrIic9bSTJT8pPR+g8kGNpLrn1T4wr0LEbyFx5KK5t7+FgQ23QvgwSJGzETMhLvKGQm6ISCeeKLRelEnOcngV88QKPJb8aq4TjZO4iZqAmk7IHIplxPy6PRnHlFFy1whZGutxs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199214; c=relaxed/simple;
	bh=VnQXms8ECBnra6d2GFhjZ7Vb8yzmQJDGv2peaU4vPJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH976OmFwBFEdO1l+WAT054GBEh5OYNZJXfqZpr3Q6Drtt1Jq+8hDvuvzRqsvXGQ0WRcmDlGr+R3nAmas4XO1HNMMA+hJvPudtsyxzG46bDESc5CMixnh+UR5expqrnLI5TDwP4c+seTqVlFG8NyjDS3z8ZkxBKg54xPqIZrWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=jDkzyxCM; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B24F4C00281B;
	Mon,  3 Nov 2025 11:46:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B24F4C00281B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762199205;
	bh=VnQXms8ECBnra6d2GFhjZ7Vb8yzmQJDGv2peaU4vPJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDkzyxCMNiPFKkvzWwJp0MnzLSuBJoNtn9lz5JJOeWwUuVm5GuH/6sgcuNszffk3j
	 GDOmAnK5Fqp+g3A6t+NIQmLIQr2f5E/YFb4j0JUeyN/N2tAtT/9+LCPPaRemCh0Egv
	 S9Hp08ulI6Wl1otXOl3neMERuOhZ6BPRWYJkhEUI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 864C44002F45;
	Mon,  3 Nov 2025 14:46:44 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
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
Subject: [PATCH net-next 1/2] net: ethernet: Allow disabling pause on panic
Date: Mon,  3 Nov 2025 11:46:30 -0800
Message-Id: <20251103194631.3393020-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
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
completle paralysis of the network.

To accomodate for such situation introduce a
/sys/class/net/<device>/disable_pause_on_panic knob which will disable
Ethernet pause frame generation upon kernel panic.

Note that device driver wishing to make use of that feature need to be
mindful of the fact that ethtool_ops::set_pauseparam may now be called
from atomic context.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/ABI/testing/sysfs-class-net | 16 ++++
 include/linux/netdevice.h                 |  1 +
 net/core/net-sysfs.c                      | 34 ++++++++
 net/ethernet/Makefile                     |  3 +-
 net/ethernet/pause_panic.c                | 95 +++++++++++++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 net/ethernet/pause_panic.c

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..f762ce439203 100644
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
+		== ==================================
+		0  threaded mode disabled for this dev
+		1  threaded mode enabled for this dev
+		== ==================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9c1e5042c5e7..7af0944aada2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2439,6 +2439,7 @@ struct net_device {
 	bool			proto_down;
 	bool			irq_affinity_auto;
 	bool			rx_cpu_rmap_auto;
+	bool			disable_pause_on_panic;
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca878525ad7c..c01dc3e200d8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -770,6 +770,39 @@ static ssize_t threaded_store(struct device *dev,
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
@@ -800,6 +833,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
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
index 000000000000..ed859b443b00
--- /dev/null
+++ b/net/ethernet/pause_panic.c
@@ -0,0 +1,95 @@
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
+ * This is called from panic context, so we cannot sleep.
+ * We try to call set_pauseparam, but if it would require sleeping,
+ * we skip the device rather than risk deadlock.
+ */
+static void disable_pause_on_device(struct net_device *dev)
+{
+	struct ethtool_pauseparam pause = { };
+	const struct ethtool_ops *ops;
+
+	/* Only proceed if this device has the flag enabled */
+	if (!READ_ONCE(dev->disable_pause_on_panic))
+		return;
+
+	ops = dev->ethtool_ops;
+	if (!ops || !ops->set_pauseparam)
+		return;
+
+	/* Prepare pause parameters to disable flow control */
+	pause.autoneg = 0;
+	pause.rx_pause = 0;
+	pause.tx_pause = 0;
+
+	/*
+	 * In panic context, we're in atomic context and cannot sleep.
+	 * We try to call set_pauseparam directly. If it would sleep,
+	 * that's a driver bug, but we proceed anyway since we're panicking.
+	 * The driver's set_pauseparam implementation should ideally handle
+	 * atomic context, but if it doesn't, we can't do much about it
+	 * during a panic.
+	 */
+	ops->set_pauseparam(dev, &pause);
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
+	rcu_read_lock();
+	for_each_netdev_rcu(&init_net, dev) {
+		/* Reference count might not be available in panic */
+		if (!dev)
+			continue;
+
+		disable_pause_on_device(dev);
+	}
+	rcu_read_unlock();
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


