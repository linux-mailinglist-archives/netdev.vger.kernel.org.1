Return-Path: <netdev+bounces-152500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA259F44F6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC507A5BF9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E788193427;
	Tue, 17 Dec 2024 07:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880621CCEF8;
	Tue, 17 Dec 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419936; cv=none; b=CzO6Kj6DEkK5BIPidAiJhPSg+b3HDNTvhI4MnyFaWR6R+leepBEdZqmTth59kiCW2MOTYYpbBhl3HdrR0CHvztIYr/Q1kIaOW9OtSzFsINmQT8U7kEF0Q9EFrp9G07iQ12uGIiLiOpV3uXxy0R1enERZAzGzSOVJj1AEZupufCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419936; c=relaxed/simple;
	bh=lokrh+F8Mq2f6b4W5F04MSkANEZSRlaI1XoNml2glps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTSlwbM1blwFJ7jNqJS/r96tCCblbkmxPnvqwVZvacZQYIA0A9h6RCW0n5oe8kSYvMgesBjWgF72S6BEkYjHZviC2DyqKc16z9y3S3ZQk44JIGCGKMNxauaVg64C3EB9FPqCePNE+rdgao7nDpRprbwkYvGyTUdIqlY7ZjbOQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YC7TJ3Yymz9sPd;
	Tue, 17 Dec 2024 08:18:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9heJLcNBRVn1; Tue, 17 Dec 2024 08:18:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YC7TJ2RvPz9rvV;
	Tue, 17 Dec 2024 08:18:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 430AB8B768;
	Tue, 17 Dec 2024 08:18:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id VkVf93-PuJTf; Tue, 17 Dec 2024 08:18:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AE048B763;
	Tue, 17 Dec 2024 08:18:43 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Subject: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
Date: Tue, 17 Dec 2024 08:18:25 +0100
Message-ID: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734419906; l=9863; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=lokrh+F8Mq2f6b4W5F04MSkANEZSRlaI1XoNml2glps=; b=IIG86a2OFTbc21UBp7Gf+FubzYJdlK4q6ELOem9ljtmVcg6PX8mEbWJauzwYf8f7SonaOTwYB ujsL6wjpX6VCHqg7EQ9J6MSfO1k8t6kt+F4FWoppSa+8y3527c8YFra
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The following problem is encountered on kernel built with
CONFIG_PREEMPT. An snmp daemon running with normal priority is
regularly calling ioctl(SIOCGMIIPHY). Another process running with
SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.

After some random time, the snmp daemon gets preempted while holding
the RTNL mutex then the high priority process is busy looping into
carrier_show which bails out early due to a non-successfull
rtnl_trylock() which implies restart_syscall(). Because the snmp
daemon has a lower priority, it never gets the chances to release
the RTNL mutex and the high-priority task continues to loop forever.

Replace the trylock by lock_interruptible. This will increase the
priority of the task holding the lock so that it can release it and
allow the reader of /sys/class/net/eth0/carrier to actually perform
its read.

The problem can be reproduced with the following two simple apps:

The one below runs with normal SCHED_OTHER priority:

	int main(int argc, char **argv)
	{
		int sk = socket(AF_INET, SOCK_DGRAM, 0);
		char buf[32];
		struct ifreq ifr = {.ifr_name = "eth0"};

		for (;;)
			ioctl(sk, SIOCGMIIPHY, &ifr);

		exit(0);
	}

And the following one is started with chrt -f 80 so it runs with
SCHED_FIFO policy:

	int main(int argc, char **argv)
	{
		int fd = open("/sys/class/net/eth0/carrier", O_RDONLY);
		char buf[32];

		for (;;) {
			read(fd, buf, sizeof(buf));
			lseek(fd, 0, SEEK_SET);
			usleep(5000);
		}

		exit(0);
	}

When running alone, that high priority task takes approx 6% CPU time.

When running together with the first one above, the high priority task
reaches almost 100% of CPU time.

With this fix applied, the high priority task remains at 6% CPU time
while the other one takes the remaining CPU time available.

Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/rtnetlink.h |  1 +
 net/core/net-sysfs.c      | 70 +++++++++++++++++++--------------------
 net/core/rtnetlink.c      |  6 ++++
 3 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 14b88f551920..f060eecbc382 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -43,6 +43,7 @@ extern void rtnl_lock(void);
 extern void rtnl_unlock(void);
 extern int rtnl_trylock(void);
 extern int rtnl_is_locked(void);
+extern int rtnl_lock_interruptible(void);
 extern int rtnl_lock_killable(void);
 extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 2d9afc6e2161..0f97ea78c4da 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -95,8 +95,8 @@ static ssize_t netdev_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		goto err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (dev_isalive(netdev)) {
 		ret = (*set)(netdev, new);
@@ -190,7 +190,7 @@ static ssize_t carrier_store(struct device *dev, struct device_attribute *attr,
 	struct net_device *netdev = to_net_dev(dev);
 
 	/* The check is also done in change_carrier; this helps returning early
-	 * without hitting the trylock/restart in netdev_store.
+	 * without hitting the lock/restart in netdev_store.
 	 */
 	if (!netdev->netdev_ops->ndo_change_carrier)
 		return -EOPNOTSUPP;
@@ -204,8 +204,8 @@ static ssize_t carrier_show(struct device *dev,
 	struct net_device *netdev = to_net_dev(dev);
 	int ret = -EINVAL;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (netif_running(netdev)) {
 		/* Synchronize carrier state with link watch,
@@ -228,13 +228,13 @@ static ssize_t speed_show(struct device *dev,
 	int ret = -EINVAL;
 
 	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the lock/restart below.
 	 */
 	if (!netdev->ethtool_ops->get_link_ksettings)
 		return ret;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
@@ -254,13 +254,13 @@ static ssize_t duplex_show(struct device *dev,
 	int ret = -EINVAL;
 
 	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the lock/restart below.
 	 */
 	if (!netdev->ethtool_ops->get_link_ksettings)
 		return ret;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
@@ -459,8 +459,8 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 	if (len >  0 && buf[len - 1] == '\n')
 		--count;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (dev_isalive(netdev)) {
 		ret = dev_set_alias(netdev, buf, count);
@@ -523,13 +523,13 @@ static ssize_t phys_port_id_show(struct device *dev,
 	ssize_t ret = -EINVAL;
 
 	/* The check is also done in dev_get_phys_port_id; this helps returning
-	 * early without hitting the trylock/restart below.
+	 * early without hitting the lock/restart below.
 	 */
 	if (!netdev->netdev_ops->ndo_get_phys_port_id)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (dev_isalive(netdev)) {
 		struct netdev_phys_item_id ppid;
@@ -551,14 +551,14 @@ static ssize_t phys_port_name_show(struct device *dev,
 	ssize_t ret = -EINVAL;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the trylock/restart below.
+	 * returning early without hitting the lock/restart below.
 	 */
 	if (!netdev->netdev_ops->ndo_get_phys_port_name &&
 	    !netdev->devlink_port)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (dev_isalive(netdev)) {
 		char name[IFNAMSIZ];
@@ -580,15 +580,15 @@ static ssize_t phys_switch_id_show(struct device *dev,
 	ssize_t ret = -EINVAL;
 
 	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the trylock/restart below. This works
+	 * returning early without hitting the lock/restart below. This works
 	 * because recurse is false when calling dev_get_port_parent_id.
 	 */
 	if (!netdev->netdev_ops->ndo_get_port_parent_id &&
 	    !netdev->devlink_port)
 		return -EOPNOTSUPP;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	if (dev_isalive(netdev)) {
 		struct netdev_phys_item_id ppid = { };
@@ -1282,8 +1282,8 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	index = get_netdev_queue_index(queue);
 
@@ -1327,7 +1327,7 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 		return -EPERM;
 
 	/* The check is also done later; this helps returning early without
-	 * hitting the trylock/restart below.
+	 * hitting the lock/restart below.
 	 */
 	if (!dev->netdev_ops->ndo_set_tx_maxrate)
 		return -EOPNOTSUPP;
@@ -1336,8 +1336,8 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 	if (err < 0)
 		return err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	err = -EOPNOTSUPP;
 	if (dev->netdev_ops->ndo_set_tx_maxrate)
@@ -1593,8 +1593,8 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	/* If queue belongs to subordinate dev use its map */
 	dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
@@ -1640,9 +1640,9 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	if (rtnl_lock_interruptible()) {
 		free_cpumask_var(mask);
-		return restart_syscall();
+		return -ERESTARTSYS;
 	}
 
 	err = netif_set_xps_queue(dev, mask, index);
@@ -1664,8 +1664,8 @@ static ssize_t xps_rxqs_show(struct netdev_queue *queue, char *buf)
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	if (rtnl_lock_interruptible())
+		return -ERESTARTSYS;
 
 	tc = netdev_txq_to_tc(dev, index);
 	rtnl_unlock();
@@ -1699,9 +1699,9 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	if (rtnl_lock_interruptible()) {
 		bitmap_free(mask);
-		return restart_syscall();
+		return -ERESTARTSYS;
 	}
 
 	cpus_read_lock();
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ebcfc2debf1a..a52ffc3c8ab8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -80,6 +80,12 @@ void rtnl_lock(void)
 }
 EXPORT_SYMBOL(rtnl_lock);
 
+int rtnl_lock_interruptible(void)
+{
+	return mutex_lock_interruptible(&rtnl_mutex);
+}
+EXPORT_SYMBOL(rtnl_lock_interruptible);
+
 int rtnl_lock_killable(void)
 {
 	return mutex_lock_killable(&rtnl_mutex);
-- 
2.47.0


