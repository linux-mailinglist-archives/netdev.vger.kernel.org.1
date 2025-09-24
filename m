Return-Path: <netdev+bounces-225884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06437B98DAF
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F02C16C92C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529892820D7;
	Wed, 24 Sep 2025 08:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71D284669
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702130; cv=none; b=Hdvvn2YDdzf2cBS/illReLxiqoe9SvZWSj1MTFXY9+gGGrT1HUJJwW6r9yER7eyDoeMA7EOyuJnarCFrAZkzEElz7OWk2iijOlhpTc89ypZE1n5jowSS6dnSeCmNEBLtHJJmD23fX1j7o6CAQICxxq8CVSGg7EBnSVgWZP4T7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702130; c=relaxed/simple;
	bh=L5UUEsLHMksXyWvD69JUm67UHcD7qiLJ4bcv0bnG2/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezTZgbJU5mf3akJQ1i9PWqweAC84JCWONPleuAe4G4MrrQxawVOEkG8DahzT5oCCymuHGZoByjFo6hrZm3WR3XgpNBUkJakIgjpoq16yQA3xr8LfOgfbg73AJjtHtIrU/3vMtfVUNrDBiejqadSoRy41i8BMLMyScDIwShhUQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1758702104tf0345847
X-QQ-Originating-IP: tOMHaifYukaA/lKfy+n5vWqYB4TnXq23JWbJtce3xgo=
Received: from localhost.localdomain ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 16:21:42 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15422174651440948574
EX-QQ-RecipientCnt: 5
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next] Wangxun: vf: Implement some ethtool apis for get_xxx
Date: Wed, 24 Sep 2025 16:21:40 +0800
Message-Id: <20250924082140.41612-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MpEJ4rE15GTAnvrb8N0uggqMGoh+jLdoTPgxF2TWq7nJKdFHOVJuivDe
	YiqWFuUymL53Fr8i9558AbFrnzGmox4w93x4qYZ89Iq6BsH4+X2O8EdBYCQtwaO2QNXs4Da
	p9nfAkjoAVYvYjAg6mlTXTp9FcpiaXOsUyVlYCwUDz7uEGnyKrDKIoB5lLshd5f6paItEQy
	uEycnOUb4tjY9ZI8O+XzJZYx4+2HC1JZrmzpUXYcMzajsnFBBlUVHiiDXAUQ6XitgOjMRY0
	z9+jHLZT8XPEnEjLwikHrOz4LePFq5JFcGmmEC2Dm/+cQI8ukFpgnl2ImSZKTEIO/DblhVh
	Qm2u6BHFoD9ezxt/ZFsNyirK0Mw/UnqlOoybG24Mrbmih/METelJyDxHuuUYeYLYekJ9TN6
	eRdy3UTLopso/M+V6xwNIETj/rNgZpNbqKp0LEZ6FD4OTGP9kFebOgi3EbXOOwhJIKsSLbo
	tpO1qsmR2dFx6PcFCcxPtCs6LhDxnZBZrU19X+YoWjOm1GZ/tAaxD5yS8ohoZidRaMmJAUo
	Nmdew8C5FugRglW+9jewzxm3/9tltTYoYE82PnebFzCiuKAd7ME0Dbl78laZB9ESDoYNHI/
	IzYOwYxijp3+pecFAvwyj+Z+TrjKI5Z9g97y0lnakScvoIWtDtZG+MxvHwxrt0EAFHZuVcS
	K8pq9qwf4Ii0PqFiqbnjkVDIAhXOq+mrhJAe8gqGTluHo3VQ4nzoAl1VS2IrNnSzvxFDKYb
	AymeSjUy0duJQPxM73WLr783XqBTK5/lhviSqwWvh8jFoo53warKuCpFGKUbsIRV/PiqPJg
	5y0YvNyN0BPK7kZIxu0v04A3lO5LzyK2KdpmkpLnoays5/XmUXwFhCTxjH+zhw41xokRGPQ
	76LwjH6ACoUlS2S6d1+8qlLNJWcZM+i7s84AqFDR7at0jZ/AMVsopWfIAjDbeKvIibfoH1g
	oBChM6fCmxG5e10g0u7izCgrX2sQlQT1sTcIl6d/rmFINOQRRr96x9ixN1Ebm4sGo36nx39
	BQcrkOx1xjh0fwS0nb/JXMWigHQJwooPVzqYco4AGb9PKiPwIE/ztmhmcaDCXoCuKTqBsMt
	gtyWmBom79HD6poZlHspIDUOjA4YuAMgVOm16f3V9ANkqUWr6bLkAhP8c3GTocB2Eot/L46
	WUD7rND4rewLdnjtVUQfUJbn9A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Implement some ethtool interfaces for obtaining the status of
Wangxun Virtual Function Ethernet.
Just like connection status, version information, queue depth and so on.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 33 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  1 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  4 +++
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  4 +++
 4 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9572b9f28e59..1a9b7bfbd1d2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -546,3 +546,36 @@ void wx_get_ptp_stats(struct net_device *dev,
 	}
 }
 EXPORT_SYMBOL(wx_get_ptp_stats);
+
+static int wx_get_link_ksettings_vf(struct net_device *netdev,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	cmd->base.autoneg = AUTONEG_DISABLE;
+	cmd->base.port = PORT_NONE;
+	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.speed = wx->speed;
+
+	return 0;
+}
+
+static const struct ethtool_ops wx_ethtool_ops_vf = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE,
+	.get_drvinfo		= wx_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ringparam		= wx_get_ringparam,
+	.get_msglevel		= wx_get_msglevel,
+	.get_coalesce		= wx_get_coalesce,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_link_ksettings	= wx_get_link_ksettings_vf,
+};
+
+void wx_set_ethtool_ops_vf(struct net_device *netdev)
+{
+	netdev->ethtool_ops = &wx_ethtool_ops_vf;
+}
+EXPORT_SYMBOL(wx_set_ethtool_ops_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 9e002e699eca..073f1149a578 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -44,4 +44,5 @@ int wx_get_ts_info(struct net_device *dev,
 		   struct kernel_ethtool_ts_info *info);
 void wx_get_ptp_stats(struct net_device *dev,
 		      struct ethtool_ts_stats *ts_stats);
+void wx_set_ethtool_ops_vf(struct net_device *netdev);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index 5f9ddb5e5403..6ef43adcc425 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -14,6 +14,7 @@
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
+#include "../libwx/wx_ethtool.h"
 #include "ngbevf_type.h"
 
 /* ngbevf_pci_tbl - PCI Device ID Table
@@ -186,6 +187,8 @@ static int ngbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	wx->driver_name = KBUILD_MODNAME;
+	wx_set_ethtool_ops_vf(netdev);
 	netdev->netdev_ops = &ngbevf_netdev_ops;
 
 	/* setup the private structure */
@@ -203,6 +206,7 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_sw_init;
 
+	wx_get_fw_version_vf(wx);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 3755bb399f71..72663e3c4205 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -14,6 +14,7 @@
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
+#include "../libwx/wx_ethtool.h"
 #include "txgbevf_type.h"
 
 /* txgbevf_pci_tbl - PCI Device ID Table
@@ -239,6 +240,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	wx->driver_name = KBUILD_MODNAME;
+	wx_set_ethtool_ops_vf(netdev);
 	netdev->netdev_ops = &txgbevf_netdev_ops;
 
 	/* setup the private structure */
@@ -256,6 +259,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_sw_init;
 
+	wx_get_fw_version_vf(wx);
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
-- 
2.30.1


