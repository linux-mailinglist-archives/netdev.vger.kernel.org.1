Return-Path: <netdev+bounces-112352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD2938717
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 03:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB031F2127C
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E18BE46;
	Mon, 22 Jul 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS9Hd6nW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCA6FDC
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610406; cv=none; b=QJ5c1XPeJwzdoLHKcDdft+r/HjtrWEb03BhKP0MedkfxIMr61lFm37lOykXix0qcaj36+a2TwKvzwCDpd7mwnVLuuWenMqJLmwfpPC3oawCs9d7ZjGmit0RkeH2/+OhBgyWsKswrXvNCTnhPr9bPlnoTW+Tcp2v1b/KOU5FTeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610406; c=relaxed/simple;
	bh=cAQ8+qM16l7GyTaYbjnbEjvXVwilTUhFDaBQgG7U800=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rniRmCkU0ln6NusYUlPGlILJEfautLRGeF+QqUcHn6CGrLeAsjXm2qcpTwdyZVS71YDbOIe031k1U320NV6wDhxCMZ2/GAe5P72SZNRRDfLlsu7Qq3Q05tXCd0cZDDcJEH2/NIua/mlwKCn/VzKjCcgNhwJFsv4OsfNDipIq+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS9Hd6nW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBVhMi8j8tkf4NJc2ePQoKDV+1xaoPFqwO84E+bM5sU=;
	b=QS9Hd6nWRCPie56X1SuPX57tfzO3JSYcJlI6YyVJ3bJnSPRH6zGrKQtxh2UDxkd+0/pNe6
	CDyJzlI9vBCLkXrN2cQ82X7jEmgGLNP07U4s0uw25+o3dgNsm6ksumEMTyX07c0OhanKUP
	YoqmaYs23zbUObZb/cAlG7lRCN2ui3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-mPnOjeBfOsGArst0iHj6Ag-1; Sun,
 21 Jul 2024 21:06:42 -0400
X-MC-Unique: mPnOjeBfOsGArst0iHj6Ag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A47195609E;
	Mon, 22 Jul 2024 01:06:41 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 959DD195605A;
	Mon, 22 Jul 2024 01:06:36 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v4 1/3] vdpa: support set mac address from vdpa tool
Date: Mon, 22 Jul 2024 09:05:18 +0800
Message-ID: <20240722010625.1016854-2-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-1-lulu@redhat.com>
References: <20240722010625.1016854-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add new UAPI to support the mac address from vdpa tool
Function vdpa_nl_cmd_dev_attr_set_doit() will get the
new MAC address from the vdpa tool and then set it to the device.

The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**

Here is example:
root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "82:4d:e9:5d:d7:e6",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55

root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  9 +++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 94 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8d391947eb8d..07d61ee62839 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	return err;
 }
 
+static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
+					struct genl_info *info)
+{
+	struct vdpa_dev_set_config set_config = {};
+	const u8 *macaddr;
+	struct vdpa_mgmt_dev *mdev = vdev->mdev;
+	struct nlattr **nl_attrs = info->attrs;
+	int err = -EINVAL;
+
+	if (!vdev->mdev)
+		return -EINVAL;
+
+	down_write(&vdev->cf_lock);
+	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
+	    nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+
+		if (is_valid_ether_addr(macaddr)) {
+			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
+			if (mdev->ops->dev_set_attr) {
+				err = mdev->ops->dev_set_attr(mdev, vdev,
+							      &set_config);
+			} else {
+				NL_SET_ERR_MSG_FMT_MOD(info->extack,
+						       "device not supported");
+			}
+		} else {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "Invalid MAC address");
+		}
+	}
+	up_write(&vdev->cf_lock);
+	return err;
+}
+static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	const char *name;
+	int err = 0;
+	struct device *dev;
+	struct vdpa_device *vdev;
+	u64 classes;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+
+	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+
+	down_write(&vdpa_dev_lock);
+	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		err = -ENODEV;
+		goto dev_err;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		NL_SET_ERR_MSG_MOD(
+			info->extack,
+			"Fail to find the specified management device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
+	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
+		err = vdpa_dev_net_device_attr_set(vdev, info);
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
+				       name);
+	}
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	up_write(&vdpa_dev_lock);
+	return err;
+}
+
 static int vdpa_dev_config_dump(struct device *dev, void *data)
 {
 	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
@@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_ATTR_SET,
+		.doit = vdpa_nl_cmd_dev_attr_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7977ca03ac7a..3511156c10db 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
  *	     @dev: vdpa device to remove
  *	     Driver need to remove the specified device by calling
  *	     _vdpa_unregister_device().
+  * @dev_set_attr: change a vdpa device's attr after it was create
+ *	     @mdev: parent device to use for device
+ *	     @dev: vdpa device structure
+ *	     @config:Attributes to be set for the device.
+ *	     The driver needs to check the mask of the structure and then set
+ *	     the related information to the vdpa device. The driver must return 0
+ *	     if set successfully.
  */
 struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
 		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+			    const struct vdpa_dev_set_config *config);
 };
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 842bf1201ac4..71edf2c70cc3 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_ATTR_SET,
 };
 
 enum vdpa_attr {
-- 
2.45.0


