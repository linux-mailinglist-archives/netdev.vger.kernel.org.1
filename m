Return-Path: <netdev+bounces-190722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39FAB8740
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797803A37E7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885627A935;
	Thu, 15 May 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="py6Cgf/U"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A81F4CAA
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314143; cv=none; b=afIsxwP2h9TphRDhOPkOG5HHCUWiN0zuWi47Cao2aTfFgRlSRFktxeASoQl+U2ql7ZCM/7COWtVXOPeXgvr58ZuZwPRIQI6+b1QRel6NfO8Ulkxb48Jep3PUu9HF8DiL3X6E95F6AH5snMPzBrmrbU+iCtV2RCTzV0j1Q4Z0nwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314143; c=relaxed/simple;
	bh=oqOr8wDts3SEJoai/gCfdzOFy2kinuvRB6WW4PqyRXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLwFWrjLX8r5kKn2HnPgfkfk1jeEXGaIQaysKj3+OsvPHHX8lNHBNBDzIC/GRnfZtbdZF9ezDmIHUku7lvpKqHEZ+XSlvwEu+gC8piwvRZnObib/4cN7ivpYPlpQ9uW/eprt49qR496KJmUhajIvsGhOLckygfHciqRHV/a6AaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=py6Cgf/U; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747314139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=upiqr/kbWt+JiyB/hvA2e7f4ANCPn2RZZBZ+9WMLMvI=;
	b=py6Cgf/UjwqmzrWar/Ta1fvKRxp8GCUxQNJ0I8uaaV8HXG3U2B5NoMFuit5l5P7I5WvJ2m
	3D0bac273cYhXLcwR6a1fXoP7zC4ou5UwLp3z18sHlfFitV3tbEpDgJkRhkhlIt11koW+S
	yy6VsN+nyPbPk8Nrzy3PJAiv4KgHDaI=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: sysfs: Implement is_visible for phys_(port_id, port_name, switch_id)
Date: Thu, 15 May 2025 21:02:05 +0800
Message-Id: <20250515130205.3274-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

phys_port_id_show, phys_port_name_show and phys_switch_id_show would
return -EOPNOTSUPP if the netdev didn't implement the corresponding
method.

There is no point in creating these files if they are unsupported.

Put these attributes in netdev_phys_group and implement the is_visible
method. make phys_(port_id, port_name, switch_id) invisible if the netdev
dosen't implement the corresponding method.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/netdevice.h |  2 +-
 net/core/net-sysfs.c      | 78 +++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 32a1e41636a9..efbcc4836498 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2384,7 +2384,7 @@ struct net_device {
 	struct dm_hw_stat_delta __rcu *dm_private;
 #endif
 	struct device		dev;
-	const struct attribute_group *sysfs_groups[4];
+	const struct attribute_group *sysfs_groups[5];
 	const struct attribute_group *sysfs_rx_queue_group;
 
 	const struct rtnl_link_ops *rtnl_link_ops;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1ace0cd01adc..f176b7808abe 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -641,12 +641,6 @@ static ssize_t phys_port_id_show(struct device *dev,
 	struct netdev_phys_item_id ppid;
 	ssize_t ret;
 
-	/* The check is also done in dev_get_phys_port_id; this helps returning
-	 * early without hitting the locking section below.
-	 */
-	if (!netdev->netdev_ops->ndo_get_phys_port_id)
-		return -EOPNOTSUPP;
-
 	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 	if (ret)
 		return ret;
@@ -659,7 +653,8 @@ static ssize_t phys_port_id_show(struct device *dev,
 
 	return ret;
 }
-static DEVICE_ATTR_RO(phys_port_id);
+static struct device_attribute dev_attr_phys_port_id =
+	__ATTR(phys_port_id, 0444, phys_port_id_show, NULL);
 
 static ssize_t phys_port_name_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -668,13 +663,6 @@ static ssize_t phys_port_name_show(struct device *dev,
 	char name[IFNAMSIZ];
 	ssize_t ret;
 
-	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the locking section below.
-	 */
-	if (!netdev->netdev_ops->ndo_get_phys_port_name &&
-	    !netdev->devlink_port)
-		return -EOPNOTSUPP;
-
 	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 	if (ret)
 		return ret;
@@ -687,7 +675,8 @@ static ssize_t phys_port_name_show(struct device *dev,
 
 	return ret;
 }
-static DEVICE_ATTR_RO(phys_port_name);
+static struct device_attribute dev_attr_phys_port_name =
+	__ATTR(phys_port_name, 0444, phys_port_name_show, NULL);
 
 static ssize_t phys_switch_id_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -696,14 +685,6 @@ static ssize_t phys_switch_id_show(struct device *dev,
 	struct netdev_phys_item_id ppid = { };
 	ssize_t ret;
 
-	/* The checks are also done in dev_get_phys_port_name; this helps
-	 * returning early without hitting the locking section below. This works
-	 * because recurse is false when calling dev_get_port_parent_id.
-	 */
-	if (!netdev->netdev_ops->ndo_get_port_parent_id &&
-	    !netdev->devlink_port)
-		return -EOPNOTSUPP;
-
 	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
 	if (ret)
 		return ret;
@@ -716,7 +697,52 @@ static ssize_t phys_switch_id_show(struct device *dev,
 
 	return ret;
 }
-static DEVICE_ATTR_RO(phys_switch_id);
+static struct device_attribute dev_attr_phys_switch_id =
+	__ATTR(phys_switch_id, 0444, phys_switch_id_show, NULL);
+
+static struct attribute *netdev_phys_attrs[] __ro_after_init = {
+	&dev_attr_phys_port_id.attr,
+	&dev_attr_phys_port_name.attr,
+	&dev_attr_phys_switch_id.attr,
+	NULL,
+};
+
+static umode_t netdev_phys_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct net_device *netdev = to_net_dev(dev);
+
+	if (attr == &dev_attr_phys_port_id.attr) {
+		/* The check is also done in dev_get_phys_port_id; this helps returning
+		 * early without hitting the locking section below.
+		 */
+		if (!netdev->netdev_ops->ndo_get_phys_port_id)
+			return 0;
+	} else if (attr == &dev_attr_phys_port_name.attr) {
+		/* The checks are also done in dev_get_phys_port_name; this helps
+		 * returning early without hitting the locking section below.
+		 */
+		if (!netdev->netdev_ops->ndo_get_phys_port_name &&
+		    !netdev->devlink_port)
+			return 0;
+	} else if (attr == &dev_attr_phys_switch_id.attr) {
+		/* The checks are also done in dev_get_phys_port_name; this helps
+		 * returning early without hitting the locking section below. This works
+		 * because recurse is false when calling dev_get_port_parent_id.
+		 */
+		if (!netdev->netdev_ops->ndo_get_port_parent_id &&
+		    !netdev->devlink_port)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute_group netdev_phys_group = {
+	.attrs = netdev_phys_attrs,
+	.is_visible = netdev_phys_is_visible,
+};
 
 static ssize_t threaded_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -783,9 +809,6 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_tx_queue_len.attr,
 	&dev_attr_gro_flush_timeout.attr,
 	&dev_attr_napi_defer_hard_irqs.attr,
-	&dev_attr_phys_port_id.attr,
-	&dev_attr_phys_port_name.attr,
-	&dev_attr_phys_switch_id.attr,
 	&dev_attr_proto_down.attr,
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
@@ -2328,6 +2351,7 @@ int netdev_register_kobject(struct net_device *ndev)
 		groups++;
 
 	*groups++ = &netstat_group;
+	*groups++ = &netdev_phys_group;
 
 	if (wireless_group_needed(ndev))
 		*groups++ = &wireless_group;
-- 
2.25.1


