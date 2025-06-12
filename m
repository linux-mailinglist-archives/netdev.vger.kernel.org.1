Return-Path: <netdev+bounces-196993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACDAD73CE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558813B4D0F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C11246327;
	Thu, 12 Jun 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BYYBoRRh"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A024678E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738479; cv=none; b=eMTkRlhFgkm5hBdy41AkvuFcxbJiyrrf57AdTJGZoGLPLkPAAOsqj2wpRfswNXvBDRxfuxsFEosU97exghuPZzV6uDsL8FQvVNI3EF1EQg+ArZYNcx5osO2W6Q8D7CyzT+HTnzyjJtcqji8UKqLt9etvp6X8H4iVRo306XKjeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738479; c=relaxed/simple;
	bh=lR4rRyT8kEmeAFgFbTyrlgyEKk+f9LUnBbC9banrJsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQJ4rh/CbGQ576EgjDTPy1PGzSI4ZQzJ+PsS7ZERbkZ/HP8rvqMAgCUbqB83oevC8u5Q5Nycq/l62qr1AjqDwKgxE4FTnb0DPvd9hjpxj/tuPTmGGTD7h28WHZX03QZ4K+V0D3xBNUSAFwFZsBynuVC4M7jXPpqGHctaw+qmRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BYYBoRRh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749738464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TPwDoP+jbnUa8bxVZg836/xmpXU4SXa+id2ZO0eScw4=;
	b=BYYBoRRhyn3yzwB6sJ3KgEfbbn9MSqYPlWwxFGIib6wKVgDgzAHWo/gcqDmus3hZ9U68IK
	kKwuzq3dOAz4MwpWzI7VoAYYmfB/9ZlRZoij3Of4DPisYZBoWPRwwx+qpDN4XBduR/A4B8
	CG1PQPRwy10HjYZ2v+NgwfIKMNMDRbU=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH RESEND net-next v2] net: sysfs: Implement is_visible for phys_(port_id, port_name, switch_id)
Date: Thu, 12 Jun 2025 14:27:07 +0000
Message-ID: <20250612142707.4644-1-yajun.deng@linux.dev>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: Remove worthless comments.
v1: https://lore.kernel.org/all/20250515130205.3274-1-yajun.deng@linux.dev/
---
 include/linux/netdevice.h |  2 +-
 net/core/net-sysfs.c      | 59 +++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index adb14db25798..9cbc4e54b7e4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2388,7 +2388,7 @@ struct net_device {
 	struct dm_hw_stat_delta __rcu *dm_private;
 #endif
 	struct device		dev;
-	const struct attribute_group *sysfs_groups[4];
+	const struct attribute_group *sysfs_groups[5];
 	const struct attribute_group *sysfs_rx_queue_group;
 
 	const struct rtnl_link_ops *rtnl_link_ops;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1ace0cd01adc..c9b969386399 100644
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
@@ -668,13 +662,6 @@ static ssize_t phys_port_name_show(struct device *dev,
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
@@ -696,14 +683,6 @@ static ssize_t phys_switch_id_show(struct device *dev,
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
@@ -718,6 +697,40 @@ static ssize_t phys_switch_id_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(phys_switch_id);
 
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
+		if (!netdev->netdev_ops->ndo_get_phys_port_id)
+			return 0;
+	} else if (attr == &dev_attr_phys_port_name.attr) {
+		if (!netdev->netdev_ops->ndo_get_phys_port_name &&
+		    !netdev->devlink_port)
+			return 0;
+	} else if (attr == &dev_attr_phys_switch_id.attr) {
+		if (!netdev->netdev_ops->ndo_get_port_parent_id &&
+		    !netdev->devlink_port)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static const struct attribute_group netdev_phys_group = {
+	.attrs = netdev_phys_attrs,
+	.is_visible = netdev_phys_is_visible,
+};
+
 static ssize_t threaded_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -783,9 +796,6 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_tx_queue_len.attr,
 	&dev_attr_gro_flush_timeout.attr,
 	&dev_attr_napi_defer_hard_irqs.attr,
-	&dev_attr_phys_port_id.attr,
-	&dev_attr_phys_port_name.attr,
-	&dev_attr_phys_switch_id.attr,
 	&dev_attr_proto_down.attr,
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
@@ -2328,6 +2338,7 @@ int netdev_register_kobject(struct net_device *ndev)
 		groups++;
 
 	*groups++ = &netstat_group;
+	*groups++ = &netdev_phys_group;
 
 	if (wireless_group_needed(ndev))
 		*groups++ = &wireless_group;
-- 
2.25.1


