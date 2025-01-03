Return-Path: <netdev+bounces-155067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52145A00E2C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06957A07E5
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484E1FCFCE;
	Fri,  3 Jan 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6ipKp5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E191FC7DF
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930802; cv=none; b=qYphnkQoSYTaJj1ZsB2ehKAppHOTJYBdBX26cVJECkDROvDAahulqHKPpGc4dbZcS5+f8bOU9AFMd0mD3pRIgi/5AtxEc18uvfkYzV8C9NRkhccE7QnShHb91c5uWjG37CTPe99OsRPxYTk3OW0ddudytvNGZyLXt5EO7g8Sok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930802; c=relaxed/simple;
	bh=WAw6OslHeff7CgXJrV3yhDAtX/gjSDBfWLnZ5jRR0No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv3TJAPRxELLpD8kpUlPDi7K4BTVx7O6Ur3EFE/WCIRI47bSN9z1DjGtYJb7IWuopDzu6MV5pPG1QO2UsqEwRPzd5+rRZFe7LChlokjhrsjG9W8vp35IXiwlz/WzpsILv4DHYU1YOBHM4fv+lHuOqMXIBOo1ydbXrcWouw/joLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6ipKp5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C7C4CEDF;
	Fri,  3 Jan 2025 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930802;
	bh=WAw6OslHeff7CgXJrV3yhDAtX/gjSDBfWLnZ5jRR0No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6ipKp5OuVBXVz/GV8cIaKd0BbRrAUgPgQeGLl8X8goZD8aMFdQ6kbZLzxa4hM2Bn
	 3q1tVvQR8Y8Gt99Wuf9nHw1jeP2qCI4tJmbRAN+v+rqZiMO96JF7tLNsNF31BoYq0x
	 fyZ3ul1IB487yy1OEPSChTrRwzBp8D7e+HXiSSH1BbPnbB/nYQX8cJzl4Bm4sOMpwr
	 P5q2gMLITTe/duRwrAVOrBy/0wkdMsonOEDbVpjDodhXIV+1eOHdfc6kwEdUqL70v0
	 FPadY065pNSj5xVwDuu1gNbwfhQbJ32DgBwXCkkOyB67s/UQMyyCxk5TzmAqJXN7qd
	 FekKWhLsS2PDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/8] netdevsim: add debugfs-triggered queue reset
Date: Fri,  3 Jan 2025 10:59:52 -0800
Message-ID: <20250103185954.1236510-8-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support triggering queue reset via debugfs for an upcoming test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c    | 55 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 86614292314a..65605d2eb943 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -20,6 +20,7 @@
 #include <linux/netdevice.h>
 #include <linux/slab.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/netlink.h>
 #include <net/net_shaper.h>
@@ -29,6 +30,8 @@
 
 #include "netdevsim.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 #define NSIM_RING_SIZE		256
 
 static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
@@ -723,6 +726,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
 	.ndo_queue_stop		= nsim_queue_stop,
 };
 
+static ssize_t
+nsim_qreset_write(struct file *file, const char __user *data,
+		  size_t count, loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	unsigned int queue, mode;
+	char buf[32];
+	ssize_t ret;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, data, count))
+                return -EFAULT;
+        buf[count] = '\0';
+
+	ret = sscanf(buf, "%u %u", &queue, &mode);
+	if (ret != 2)
+		return -EINVAL;
+
+	rtnl_lock();
+	if (!netif_running(ns->netdev)) {
+		ret = -ENETDOWN;
+		goto exit_unlock;
+	}
+
+	if (queue >= ns->netdev->real_num_rx_queues) {
+		ret = -EINVAL;
+		goto exit_unlock;
+	}
+
+	ns->rq_reset_mode = mode;
+	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ns->rq_reset_mode = 0;
+	if (ret)
+		goto exit_unlock;
+
+	ret = count;
+exit_unlock:
+	rtnl_unlock();
+	return ret;
+}
+
+static const struct file_operations nsim_qreset_fops = {
+	.open = simple_open,
+	.write = nsim_qreset_write,
+	.owner = THIS_MODULE,
+};
+
 static ssize_t
 nsim_pp_hold_read(struct file *file, char __user *data,
 		  size_t count, loff_t *ppos)
@@ -935,6 +986,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 
 	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
 					 ns, &nsim_pp_hold_fops);
+	ns->qr_dfs = debugfs_create_file("queue_reset", 0600,
+					 nsim_dev_port->ddir, ns,
+					 &nsim_qreset_fops);
 
 	return ns;
 
@@ -949,6 +1003,7 @@ void nsim_destroy(struct netdevsim *ns)
 	struct netdevsim *peer;
 
 	debugfs_remove(ns->pp_dfs);
+	debugfs_remove(ns->qr_dfs);
 
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 8c50969b1240..a70f62af4c88 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -136,6 +136,7 @@ struct netdevsim {
 
 	struct page *page;
 	struct dentry *pp_dfs;
+	struct dentry *qr_dfs;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
-- 
2.47.1


