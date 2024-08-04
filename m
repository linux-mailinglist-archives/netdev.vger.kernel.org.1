Return-Path: <netdev+bounces-115538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B4946EC2
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E45E1F21ED2
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06F25779;
	Sun,  4 Aug 2024 12:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FE3987B
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775771; cv=none; b=KfDbrbmqayDRqRWTvjbZweaSdICEu5Kbfw6kDjodWmyS/Bnl9QcCUZa9FX1UFvs4tHXp9Vf5WVv8YSmqoLNlNc8hbXRltXus/1nmx5pMYXMXkV0jlKeoHtZTc3i3P12stJoKrekJEiNPa0K/wAil/VTzAnud7FK7hYNNOfgkevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775771; c=relaxed/simple;
	bh=b+1uHv0SG+OnTMytTFsR1luKNtRgSPLhOtTOsDj6+KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy6l39lS0tqGO9MV4pzNR89cpOb/UvbnwGJmaC6X2xaHkSMZwRShfYs/XF/DTuIZYGrN+lRG5OusLHPf5Adm9KKc8ttRvuucQ192yiEcRfT5XnBoGh+InN8uxnX7VwA/MdHXDsMhk47v31OZq6nMq5Pz6Wr9aVU72UjEPH3M1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775755t422fazw
X-QQ-Originating-IP: dPWBiFTqWZjtl0bYA9JOe3fP62ZyuFM6Kpw1rgLijjg=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:49:13 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17940692144791991624
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for devlink ops
Date: Sun,  4 Aug 2024 20:48:39 +0800
Message-ID: <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804124841.71177-1-mengyuanlou@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |  3 +-
 .../net/ethernet/wangxun/libwx/wx_devlink.c   |  3 ++
 .../net/ethernet/wangxun/libwx/wx_eswitch.c   | 53 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_eswitch.h   | 13 +++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_eswitch.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 643a5e947ba9..a7065ad924d1 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o wx_devlink.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o wx_devlink.o \
+	      wx_eswitch.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_devlink.c b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
index b39da37c0842..f37362af1449 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
@@ -6,9 +6,12 @@
 
 #include "wx_type.h"
 #include "wx_sriov.h"
+#include "wx_eswitch.h"
 #include "wx_devlink.h"
 
 static const struct devlink_ops wx_pf_devlink_ops = {
+	.eswitch_mode_get = wx_eswitch_mode_get,
+	.eswitch_mode_set = wx_eswitch_mode_set,
 };
 
 static void wx_devlink_free(void *devlink_ptr)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
new file mode 100644
index 000000000000..a426a352bf96
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019-2021, Intel Corporation. */
+
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_eswitch.h"
+#include "wx_devlink.h"
+
+int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
+			struct netlink_ext_ack *extack)
+{
+	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
+	struct wx *wx = dl_priv->priv_wx;
+
+	if (wx->eswitch_mode == mode)
+		return 0;
+
+	if (wx->num_vfs) {
+		dev_info(&(wx)->pdev->dev,
+			 "Change eswitch mode is allowed if there is no VFs.");
+		return -EOPNOTSUPP;
+	}
+
+	switch (mode) {
+	case DEVLINK_ESWITCH_MODE_LEGACY:
+		dev_info(&(wx)->pdev->dev,
+			 "PF%d changed eswitch mode to legacy",
+			 wx->bus.func);
+		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
+		break;
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+		dev_info(&(wx)->pdev->dev,
+			 "Do not support switchdev in eswitch mode.");
+		NL_SET_ERR_MSG_MOD(extack, "Do not support switchdev mode.");
+		return -EINVAL;
+	default:
+		NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
+		return -EINVAL;
+	}
+
+	wx->eswitch_mode = mode;
+	return 0;
+}
+
+int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
+	struct wx *wx = dl_priv->priv_wx;
+
+	*mode = wx->eswitch_mode;
+	return 0;
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.h b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.h
new file mode 100644
index 000000000000..0323931e7df1
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019-2021, Intel Corporation. */
+
+#ifndef _WX_ESWITCH_H_
+#define _WX_ESWITCH_H_
+
+#include <net/devlink.h>
+
+int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode);
+int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
+			struct netlink_ext_ack *extack);
+
+#endif /* _WX_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index a8722f69cebb..a3e103e0c365 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1141,6 +1141,7 @@ struct wx {
 	/* devlink port data */
 	struct devlink_port devlink_port;
 	struct wx_dl_priv *dl_priv;
+	u16 eswitch_mode;		/* current mode of eswitch */
 
 	struct wx_bus_info bus;
 	struct wx_mbx_info mbx;
-- 
2.45.2


