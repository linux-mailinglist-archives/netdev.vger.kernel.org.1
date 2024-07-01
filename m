Return-Path: <netdev+bounces-107996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFC91D751
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FD81F21083
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 05:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275F37169;
	Mon,  1 Jul 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IelCGrlc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BE37142
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810783; cv=none; b=pYeqf40Eaos72Xm1c36i91WcLzdUVQrf3rl3p/tYQwZ37tHDhK5kryOp9RPi4YuJa4ANWWjrDH0tRxWIW0P1GbE2N7WYOn9V6yKxd7ipK4oBocjHBpHtZ2f2LEfc+1mGWXrHWKumlCf29yfwSZPd3rrLqeAUX4PRMRic9b++8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810783; c=relaxed/simple;
	bh=0v+iSL2SyFyXRG0dBzboK/N/MB9E7avCrUatww/iEf4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOUYTM++HEHY4/3J+RfiAWoafQGJYIUx7cg7pI47lvVbh4LCGJ9vKfll3y7bPt6fN3/ZnTryE7ePek19LlCns55LLFQ++trwtTWS938WpJZCBHws15AVd3YVRlnTzljYEHREPUN7KIWehuF/Vp5t868szxl+zzVSZijb3/+2cDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IelCGrlc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719810780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y78e29NVl1xQbqd3+lhPG2u5+qw23vHuymEsDJ6wE8I=;
	b=IelCGrlcXQrQGqWB1k7Osg3TGCr0GucO2kqQhiff3GLd9RuRzbpPZfOiweRIBBuDQ2YsiM
	uwemHE0mQYr/bq/qQeD5r2vQGrpAN3KxSmjyNpdPcxz/xM8CDFn/KSTVu/y/uavKEzI0Hp
	pAko5I3UFouIxFENgtsp/TENJquubOo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-9LkqAVKNONSBDqipOPk0vg-1; Mon,
 01 Jul 2024 01:12:57 -0400
X-MC-Unique: 9LkqAVKNONSBDqipOPk0vg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A5041956089;
	Mon,  1 Jul 2024 05:12:56 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C447F1956089;
	Mon,  1 Jul 2024 05:12:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/2] vdpa: support set mac address from vdpa tool
Date: Mon,  1 Jul 2024 13:12:02 +0800
Message-ID: <20240701051239.112447-2-lulu@redhat.com>
In-Reply-To: <20240701051239.112447-1-lulu@redhat.com>
References: <20240701051239.112447-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 drivers/vdpa/vdpa.c       | 73 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  2 ++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 76 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a7612e0783b3..0b70610a4c7f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1149,6 +1149,74 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	return err;
 }
 
+static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct vdpa_dev_set_config set_config = {};
+	struct nlattr **nl_attrs = info->attrs;
+	struct vdpa_mgmt_dev *mdev;
+	const u8 *macaddr;
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
+	mdev = vdev->mdev;
+	classes = vdpa_mgmtdev_get_classes(mdev, NULL);
+	if ((classes & BIT_ULL(VIRTIO_ID_NET)) &&
+	    nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
+			NL_SET_ERR_MSG_FMT_MOD(
+				info->extack,
+				"Missing features 0x%llx for provided attributes",
+				BIT_ULL(VIRTIO_NET_F_MAC));
+			err = -EINVAL;
+			goto mdev_err;
+		}
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+		memcpy(set_config.net.mac, macaddr, ETH_ALEN);
+		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+		if (mdev->ops->dev_set_attr) {
+			err = mdev->ops->dev_set_attr(mdev, vdev, &set_config);
+		} else {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "features 0x%llx not supported",
+					       BIT_ULL(VIRTIO_NET_F_MAC));
+		}
+
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
@@ -1285,6 +1353,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
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
index db15ac07f8a6..e8bb274887ef 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
 		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+			    const struct vdpa_dev_set_config *config);
 };
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 54b649ab0f22..76b3a1fd13f3 100644
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


