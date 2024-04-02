Return-Path: <netdev+bounces-83964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FD8951EC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03440B257CF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7988657A7;
	Tue,  2 Apr 2024 11:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDD679FE;
	Tue,  2 Apr 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057681; cv=none; b=LPFtUn7Xn6UQySzwKWLf/WKCCzFkBqMqbatd/BlWvAspUR1MNGqRvB18qS5AVUCEbO+JrXJ0nyiMlkcplc2BRmgeQMvze7G6yCXeqx1Zl63XOZMn5ZQG3T7yiB2U/zneM8scp2ILoUd2uBqmtTR5kfsfM2atxHBdnqAPsSVI6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057681; c=relaxed/simple;
	bh=NZjcNFaXHrCCSnJfeK2385qZKdr9n9dZYuteBPidjWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zt9HBtYxB+Xf+1xHYdsSl5wec40l79cbbaXIHfNcMVZ3zW4oWR6fKo5CjXd+hv3LQ8czwFQF7OFEhYuQPexZm8sOeytw361kTKM2vQPVeOpYJwLfo9REIPP9bNIS5RZZ/nE7DyVfrbF8WL0LdRq0qgb0b+GeFdvq6C01K/N3uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V85Lr6vHbz29kj0;
	Tue,  2 Apr 2024 19:31:48 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id CECE01A0172;
	Tue,  2 Apr 2024 19:34:33 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 19:34:33 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<wangweiyang2@huawei.com>
Subject: [PATCH -next] net: usb: asix: Add check for usbnet_get_endpoints
Date: Tue, 2 Apr 2024 11:30:48 +0000
Message-ID: <20240402113048.873130-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)

Add check for usbnet_get_endpoints() and return the error if it fails
in order to transfer the error.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/net/usb/asix_devices.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index f7cff58fe044..11417ed86d9e 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
 	int i;
 	unsigned long gpio_bits = dev->driver_info->data;
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* Toggle the GPIOs in a manufacturer/model specific way */
 	for (i = 2; i >= 0; i--) {
@@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto mdio_err;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -858,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 		if (ret < 0) {
 			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
 				   ret);
-			return ret;
+			goto mdio_err;
 		}
 	}
 
@@ -871,7 +875,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	ret = asix_read_phy_addr(dev, true);
 	if (ret < 0)
-		return ret;
+		goto mdio_err;
 
 	priv->phy_addr = ret;
 	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);
@@ -880,7 +884,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 			    &priv->chipcode, 0);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to read STATMNGSTS_REG: %d\n", ret);
-		return ret;
+		goto mdio_err;
 	}
 
 	priv->chipcode &= AX_CHIPCODE_MASK;
@@ -895,7 +899,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = priv->reset(dev, 0);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
-		return ret;
+		goto mdio_err;
 	}
 
 	/* Asix framing packs multiple eth frames into a 2K usb bulk transfer */
@@ -1258,7 +1262,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 	int ret;
 	u8 buf[ETH_ALEN] = {0};
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-- 
2.25.1


