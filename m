Return-Path: <netdev+bounces-239969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF2C6E9EA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50AFA4FC1EE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBBB3612D3;
	Wed, 19 Nov 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lXswAYIq"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31835FF69;
	Wed, 19 Nov 2025 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556269; cv=none; b=B1wWcxg+fs1V8QLRFYGvaboNBiTv1UnBAurXUHVbI4y6IR7dvULZ0lumF0zJutiLcto2s3BND1qDiwROihZpUNB8p1QshqmhvUxH41B0d+f2zg72pBJBd9YVH7bDZRB4uRwhVqz3iY3o7AbQeVqM+11ixL26JZTGbzHwc+82rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556269; c=relaxed/simple;
	bh=Rnru5ouamGLdHTyWUlFahVoXs373OdFK7aMwp2vqL8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv/RWZC9WS4o2+Tf0rRHJCHefyxqp7cwFp+hlXHa3mzlu1VSNa7bkswUTesIrzmGU/MtvWFvANUbQE2YO6tKl6cZIHHtKMy8QcJ2VmzVvY2jBF7vwaVBzDkUCuz2QxISAt+A1fcGY4TYwhHBMljQVsztIkgS5/RcaTy3MTUSvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lXswAYIq; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f4H1DyMnqMWXqfDqjmax/RukEGIiAKVw3Nhx0Pp/47o=;
	b=lXswAYIqGP91adavjcMz/EDM1U2IgrVsicsR9DuyEy7ZIIVJXWMMasznqrJCF9Zwfg2kD6NZI
	nI++14Me3jjtmYi3tEkeZV6SjzwqRG0pCrGcNyf0Be2cUSuvweXOEd4HcV6GMmDG6wBs00G9p75
	r4WGt+KT5LwamaMggl2pdGQ=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dBLjM36Mgz1cyQ2;
	Wed, 19 Nov 2025 20:42:31 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 977D118001B;
	Wed, 19 Nov 2025 20:44:15 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 20:44:14 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v07 8/9] hinic3: Add netdev notifier interfaces
Date: Wed, 19 Nov 2025 20:43:41 +0800
Message-ID: <ff986bcacacf77b6d86a241139eedee9fce4145c.1763555878.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1763555878.git.zhuyikai1@h-partners.com>
References: <cover.1763555878.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add netdev notifier interfaces.
As we stipulate that netdevices with a vlan depth greater than 1
should disable the offload feature, Layer 1 vlan netdevices use
notifier to modify vlan_features.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 89 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  1 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 1308653819ef..463609585f46 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -32,6 +32,61 @@
 #define HINIC3_RX_PENDING_LIMIT_LOW   2
 #define HINIC3_RX_PENDING_LIMIT_HIGH  8
 
+#define HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT  1
+#define HINIC3_VLAN_CLEAR_OFFLOAD \
+	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+	 NETIF_F_SCTP_CRC | NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
+/* used for netdev notifier register/unregister */
+static DEFINE_MUTEX(hinic3_netdev_notifiers_mutex);
+static int hinic3_netdev_notifiers_ref_cnt;
+
+static u16 hinic3_get_vlan_depth(struct net_device *netdev)
+{
+	u16 vlan_depth = 0;
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+	while (is_vlan_dev(netdev)) {
+		netdev = vlan_dev_priv(netdev)->real_dev;
+		vlan_depth++;
+	}
+#endif
+	return vlan_depth;
+}
+
+static int hinic3_netdev_event(struct notifier_block *notifier,
+			       unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct hinic3_nic_dev *nic_dev = netdev_priv(ndev);
+	u16 vlan_depth;
+
+	if (!is_vlan_dev(ndev))
+		return NOTIFY_DONE;
+
+	netdev_hold(ndev, &nic_dev->tracker, GFP_ATOMIC);
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		vlan_depth = hinic3_get_vlan_depth(ndev);
+		if (vlan_depth == HINIC3_MAX_VLAN_DEPTH_OFFLOAD_SUPPORT)
+			ndev->vlan_features &= (~HINIC3_VLAN_CLEAR_OFFLOAD);
+
+		break;
+
+	default:
+		break;
+	}
+
+	netdev_put(ndev, &nic_dev->tracker);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hinic3_netdev_notifier = {
+	.notifier_call = hinic3_netdev_event,
+};
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -309,6 +364,36 @@ static int hinic3_set_default_hw_feature(struct net_device *netdev)
 	return 0;
 }
 
+static void hinic3_register_notifier(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	hinic3_netdev_notifiers_ref_cnt++;
+	if (hinic3_netdev_notifiers_ref_cnt == 1) {
+		err = register_netdevice_notifier(&hinic3_netdev_notifier);
+		if (err) {
+			dev_dbg(nic_dev->hwdev->dev,
+				"Register netdevice notifier failed, err: %d\n",
+				err);
+			hinic3_netdev_notifiers_ref_cnt--;
+		}
+	}
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
+static void hinic3_unregister_notifier(void)
+{
+	mutex_lock(&hinic3_netdev_notifiers_mutex);
+	if (hinic3_netdev_notifiers_ref_cnt == 1)
+		unregister_netdevice_notifier(&hinic3_netdev_notifier);
+
+	if (hinic3_netdev_notifiers_ref_cnt)
+		hinic3_netdev_notifiers_ref_cnt--;
+	mutex_unlock(&hinic3_netdev_notifiers_mutex);
+}
+
 static void hinic3_link_status_change(struct net_device *netdev,
 				      bool link_status_up)
 {
@@ -412,6 +497,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_uninit_sw;
 
+	hinic3_register_notifier(netdev);
+
 	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
 	netif_carrier_off(netdev);
 
@@ -422,6 +509,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_uninit_nic_feature:
+	hinic3_unregister_notifier();
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
 
@@ -452,6 +540,7 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
+	hinic3_unregister_notifier();
 
 	disable_delayed_work_sync(&nic_dev->periodic_work);
 	cancel_work_sync(&nic_dev->rx_mode_work);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9bd46541b3e3..899f60588d25 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -97,6 +97,7 @@ struct hinic3_intr_coal_info {
 struct hinic3_nic_dev {
 	struct pci_dev                  *pdev;
 	struct net_device               *netdev;
+	netdevice_tracker               tracker;
 	struct hinic3_hwdev             *hwdev;
 	struct hinic3_nic_io            *nic_io;
 
-- 
2.43.0


