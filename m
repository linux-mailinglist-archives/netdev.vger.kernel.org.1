Return-Path: <netdev+bounces-292882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFh2Ex3OGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A085FB609
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65DCB3107177
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF036EA9F;
	Thu, 28 May 2026 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYoyjxnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CE36C581
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010214; cv=none; b=dKmV/IlxXr68ObLfFsnquiHUNnuuD2kP+2mxQNZB45/h1xaBCATykVb6Sgjo1+t3ZVJtnOoqkWEM2HiY6OfbpzYHQNS9tcQnYT+AztNtpCzZFEWTx25/huqavPU5Ya9ZAwKQWS2JODEHZXMJONwSfnb27rawQwe1L+X/NdAosEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010214; c=relaxed/simple;
	bh=H717zQE6mbYDiJTqD4NN45Lpc7AzByjt5aX5D71uoWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVGGXsac1jUc7zACDbP0moVJ1tJ5D2JvRctXhdCaIJ8YEgpJcWQ6OLxJorbvwZpld/7ExwvewIoU0BEWuipY8HBcXu5Qja+auNxZM6ZP+CLgMyXsQPqidZu4goSN/HMueumGnwape34BxjNEtSIumEPm7y8XIPfueUep35A+ydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYoyjxnz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFA31F00A3D;
	Thu, 28 May 2026 23:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010212;
	bh=/w1oYXhDApORvFmOXrqg+6qK+1/bj6oJJXQkvfk2iS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYoyjxnzXvwbc6rmyaNZO8jllc7vD2hrgkTgE5N25k8LhwDyo8bWHW87VerXX5Aeb
	 VwPyC7Y1zMu75nHkBcg7AmsxasWLzNtO8EZ2X2oUH6GMPBavk+wFn8906IaXS1izA2
	 VDFATrFFsfCXwexX6JnS0KbOPJswCGpxDP2E6nYie+kbtIHDmxAfX/JVjFfLT+I/MZ
	 3I7vSlgM3NJ9PsHe5n13p0ACDAbm56Ao3QtBtUQNI9+qiBfSkRGNM4G2PbSz9HqTUG
	 wsjBeUXQgaludCTWCP0NFaAl/W8nOpvI9Dbmw95U0exKaU8HJk2ikLOfzCdhRjxnhW
	 zmBwmJ0h7ZOLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/14] net: ethtool: make dev->hwprov ops-protected
Date: Thu, 28 May 2026 16:16:28 -0700
Message-ID: <20260528231637.251822-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292882-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9A085FB609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dev->hwprov tracks the active hwtstamp provider for the device.
Make it ops protected (instance lock if the netdev driver opts
into holding instance lock around callbacks, otherwise rtnl_lock).

hwprov is written in
 - drivers/net/phy/phy_device.c
    phydev and ops protection don't currently mix, add a comment
 - net/ethtool/
    as of now holds both rtnl lock and ops lock, this one will
    soon only hold one lock or the other

read in:
 - net/core/dev_ioctl.c
    holds both rtnl lock and ops lock
 - net/core/timestamping.c
    RCU reader

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h           |  3 +++
 include/net/netdev_lock.h           | 11 +++++++++++
 drivers/net/phy/phy_device.c        |  3 +++
 drivers/net/phy/phy_link_topology.c |  4 +++-
 net/core/dev_ioctl.c                |  4 ++--
 net/ethtool/tsconfig.c              | 10 ++++++----
 6 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7309467d7873..2d9a658e9b1a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2584,6 +2584,9 @@ struct net_device {
 	 * Double protects:
 	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
+	 * Ops protects:
+	 *	@hwprov
+	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
 	 *
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index f4c77899fb86..3eca5465a8e6 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -102,6 +102,14 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
 		rtnl_unlock();
 }
 
+/* Matching "ops protected" category from netdevice.h */
+static inline int netdev_ops_is_locked(const struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		return lockdep_is_held(&dev->lock);
+	return lockdep_rtnl_is_held();
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
@@ -138,6 +146,9 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 #define netdev_lock_dereference(p, dev)				\
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->lock))
 
+#define netdev_ops_lock_dereference(p, dev)				\
+	rcu_dereference_protected(p, netdev_ops_is_locked(dev))
+
 int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 		       void *ptr);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..ea53e477465d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1935,6 +1935,9 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
 
+		/* hwprov may technically be protected by ops lock but
+		 * not for devices with a phydev, see phy_link_topo_add_phy()
+		 */
 		hwprov = rtnl_dereference(dev->hwprov);
 		/* Disable timestamp if it is the one selected */
 		if (hwprov && hwprov->phydev == phydev) {
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index aed3b26c1674..4134de7ae313 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -38,7 +38,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
 	 * currently protects the PHY topology. No driver currently mixes
-	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
+	 * the two, flag if someone tries. See also:
+	 *  - ethnl_req_get_phydev()
+	 *  - phy_detach()
 	 */
 	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
 		return -EOPNOTSUPP;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index f3979b276090..a320e264eaaf 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -260,7 +260,7 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 {
 	struct hwtstamp_provider *hwprov;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		cfg->qualifier = hwprov->desc.qualifier;
 		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
@@ -337,7 +337,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	bool phy_ts;
 	int err;
 
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
 		    hwprov->phydev) {
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 664c3fe49b5b..65df05a05ade 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -2,6 +2,7 @@
 
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
+#include <net/netdev_lock.h>
 
 #include "bitset.h"
 #include "common.h"
@@ -57,7 +58,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	data->hwtst_config.flags = cfg.flags;
 
 	data->hwprov_desc.index = -1;
-	hwprov = rtnl_dereference(dev->hwprov);
+	hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 	if (hwprov) {
 		data->hwprov_desc.index = hwprov->desc.index;
 		data->hwprov_desc.qualifier = hwprov->desc.qualifier;
@@ -213,7 +214,7 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 		return -ENOMEM;
 	}
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 	reply_data->base.dev = dev;
 	ret = tsconfig_prepare_data(&req_info->base, &reply_data->base, info);
 	if (ret < 0)
@@ -316,7 +317,7 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 		struct hwtstamp_provider_desc __hwprov_desc = {.index = -1};
 		struct hwtstamp_provider *__hwprov;
 
-		__hwprov = rtnl_dereference(dev->hwprov);
+		__hwprov = netdev_ops_lock_dereference(dev->hwprov, dev);
 		if (__hwprov) {
 			__hwprov_desc.index = __hwprov->desc.index;
 			__hwprov_desc.qualifier = __hwprov->desc.qualifier;
@@ -414,7 +415,8 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 			goto err_free_hwprov;
 
 		/* Change the selected hwtstamp source */
-		__hwprov = rcu_replace_pointer_rtnl(dev->hwprov, hwprov);
+		__hwprov = rcu_replace_pointer(dev->hwprov, hwprov,
+					       netdev_ops_is_locked(dev));
 		if (__hwprov)
 			kfree_rcu(__hwprov, rcu_head);
 	}
-- 
2.54.0


