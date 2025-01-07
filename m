Return-Path: <netdev+bounces-155921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D39A0459F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88781887B01
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EFA1F7095;
	Tue,  7 Jan 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl/QT6J9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB11F669F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266138; cv=none; b=l9thIms1T/y56Dv43U2lA5G6PJTINtzOxxfNgjkXkH8r7Kj6enxbRXZkND+9rNGV9S1UJniRl6E1OcGizd4OwMoyqwZOVD9ceRCaC6HzkhzKapOC99/R3p5uKzSjGbim7e0HdQuJJyYmH2oQEbHlWc19jcrPsCo+parRjhUgPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266138; c=relaxed/simple;
	bh=xSE20IJULl4nZv2UAXzm3oPk9+3mH4GrwM0Z7ESJbGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZBJruzgDQScaP6qA4oCqa5ducxSr0c8VV5jqLPbNVpcYqrUSTbGDNWouIC+SlDpvJAe+JITq9EEdfUHLtGiFf3E4oUjGXZj0d86kkjzjjZQT1AiEKbtgaiqYXihd7BcjRh/MEt/XKoGIxcejZ4dZ+LhSpmxg08el31z8yvsQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl/QT6J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D5C4CEE2;
	Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266137;
	bh=xSE20IJULl4nZv2UAXzm3oPk9+3mH4GrwM0Z7ESJbGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yl/QT6J9+j6dVJ8zGLkWyqnZfext283Hr6IzlaVuY35TrMYRAT4qq/tizD+rsqElE
	 5JdDd6lmBN4sc6hNOxsjZFIA+mmgTu9Qp2f+V7d9Gex/jBSaw/L5LmFEeDqg2F2w0M
	 O379W/sU9LwgGN0b6pG6slFrgmmSP/yAS1gdiUL7F14juz234h2H4d4S0j1F1Nbu2l
	 NCvu9crK6tGFQpffLT9y/chUAffN38mz4Cj0tguIfLnaFDMg+Rrci/dpJNBo7DFPvU
	 4mbWYwBUA6e1CBky6mBe4H7Cmgfi7uNQ9cdLZhVL4fK8FEsmF+ACZZ5kyoqbyrA6ym
	 woIJHWbQ1zMdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 7/8] netdevsim: add debugfs-triggered queue reset
Date: Tue,  7 Jan 2025 08:08:45 -0800
Message-ID: <20250107160846.2223263-8-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support triggering queue reset via debugfs for an upcoming test.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - change mode to 0200
 - reorder removal to be inverse of add
 - fix the spaces vs tabs
---
 drivers/net/netdevsim/netdev.c    | 55 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index cfb079a34532..d013b6498539 100644
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
@@ -722,6 +725,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
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
+		return -EFAULT;
+	buf[count] = '\0';
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
@@ -934,6 +985,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 
 	ns->pp_dfs = debugfs_create_file("pp_hold", 0600, nsim_dev_port->ddir,
 					 ns, &nsim_pp_hold_fops);
+	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
+					 nsim_dev_port->ddir, ns,
+					 &nsim_qreset_fops);
 
 	return ns;
 
@@ -947,6 +1001,7 @@ void nsim_destroy(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
 
+	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
 	rtnl_lock();
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


