Return-Path: <netdev+bounces-113177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D893D0D2
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D8B22050
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EC179955;
	Fri, 26 Jul 2024 10:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73B17623E
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988233; cv=none; b=kMNdP1QGzg86wkRSIdnQpDmPmENq6WkmSg/4lEVq9FC3SMkAnBSbmHF2FKPuWgNvuBl86iEpyJBWhBUtGjBE0BAzppJNjJHEQAPDheLEr2XK4So/Lunb7V2dqBdbZrMzcfh1hKr0C29NXbbEi1OJqxMhRfNFQcLQFnQR9gCzdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988233; c=relaxed/simple;
	bh=NrSi7W58Zl3GtwT4ouV3P5T+IOF7mIF+e/rGL7gFjk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV7VyicwjcMDcC26HVLecJg5gU3r9rHgSvocFB5LgQDyEiGI/wKlcCubix8/7Zs0tVBQBW5697kcERy3WkeNEJVAfkeTWjrK0eHEhfEMYuozD8KWpmtJUBcQAPKSKNbk1kIzEaLnfyPvg5P0GaQDOuusVpqcicQEea9nUZk4Lg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1721988218thokokn2
X-QQ-Originating-IP: mYI4iGImCpBYP5/7w5me1KdWim+uuTh2doBppatINrU=
Received: from localhost.localdomain ( [122.231.252.211])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:03:37 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7546676071251062894
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RFC PATCH net-next v5 08/10] net: libwx: add eswitch switch api for devlink ops
Date: Fri, 26 Jul 2024 18:02:59 +0800
Message-ID: <0F90835A90AD58A2+20240726100301.21416-9-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240726100301.21416-1-mengyuanlou@net-swift.com>
References: <20240726100301.21416-1-mengyuanlou@net-swift.com>
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
2.43.2


