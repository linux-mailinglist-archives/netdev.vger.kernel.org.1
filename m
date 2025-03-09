Return-Path: <netdev+bounces-173234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67BA58161
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 08:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F727A2784
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A914B092;
	Sun,  9 Mar 2025 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kHtuooKT"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B217C77;
	Sun,  9 Mar 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741506455; cv=none; b=pTzahQLnug0fBcgRZTk549Z28MjMYw//o+YPhZvt3eLsu+a+Z1HbWmAfUhgPQvfkh+Whg7ZoShTZ96cl/Jph1rv+JkWmjejyBiZkn0k35GcUPeAAEumnuAzrlm3BCc2vGmdry8blz+WzKIcpJlGRUlcMwafgsR8nxvLuk1gRWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741506455; c=relaxed/simple;
	bh=qtXCXe+nNyfcyRAulZDFi2Udoq+tbMD7n9+7CwQJoXc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=To7D+9BbLrppEyB5HVeAXrdhEZt2BwC2pjG6wqkCbzUcihaEzQ0sPUIRA4ab1oxcieTa+ykd24lGGE3b5mrbYms8OzGZNG2YlBKu4zMpdUvFBkrXrVzpqF+FEMpOymMKa0JCLs/MzYFnaLWLCGiONv/L7rhLlwV1yE9Tp7HPtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kHtuooKT; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741506439; bh=UuctHCw54Sbs+GMXZiA+9NBNhsVaLpJkYq7/z98yanc=;
	h=From:To:Cc:Subject:Date;
	b=kHtuooKT48tsok0BZV5wfYaQo4lrCy2wxYYfyBLLZMdE25Oo64UsKKI9M/J/sbOEu
	 ceEmh14M0VjEUWUK7J/5KLgHX8gdhvyhDSqH7BdJCus1esA/z2BYetd3Xe2l5lQOL3
	 P5cRaZ0gUsJaonoTy5QnPRI+Vmz3Yp9+ahCW0zw0=
Received: from localhost.localdomain ([59.66.26.122])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id BD13AEE0; Sun, 09 Mar 2025 15:47:17 +0800
X-QQ-mid: xmsmtpt1741506437ty97nhdku
Message-ID: <tencent_0A154BBE38E000228C01BE742CB73681FE09@qq.com>
X-QQ-XMAILINFO: NouDQD3dZCwaaL7UEsvYJy45KdtSWtllmld6g/xFR5bnFZB3OHNNpL+AnFsFCn
	 5eL0r4MmUInGwGPq3ytPdImyqTee9RnvxXs9dFvi25efOaLjpFRkGY52nhV4jPLTTYhFH0Fg/CFX
	 JpWCn6Ozzz6XcHh4pJikoOry/g0jBv0idm2Kr/9cUx19Dmf42iQqRBeRv6f1XUkRha3a8Jcv+Hc6
	 JLWq0x/PKiqcyH8bJVLvAhuN/Bh4+eloxqYwDcgl8UE8Xs+HnaDQ7UM8/tBuid/mIapt9Ux7bkSF
	 eIp7n52PPc2e2c7XdlxkdRIm2PAVOee51QumLlTPBkJOmEIIaQdAd4oQIZPIo/l0uDOf0WgpBsEf
	 NjqDNGQV/YhJGBeNiPXL66hO79e9NeuNVmQ2XUB7ewrGMJFwFsqP+kwllDnH2o7hTxs2FEEw7Smy
	 Nux/fG9SwgsjM973B7j6ENwr4AdfcG2VaTuVLTpHsg3uRCpTWv7LAJJJEE3gggwy1gKY1V3d9+nF
	 FoEHheeE/KDYhz8FTjOB4AN5yQcEtMhmeZpc5ao3sxa009cnU17P9WhiF2OgWMKcFqK/pqUBnUTV
	 XgMKMXt3AOUpwam9GweJu1yY9IV/E85fJFWSUZ+B4M2EGAAHbrurK0RDQWif0qmsCDY7B78Lc9FX
	 mm4AI/YhvFMgo0aVPa97YKKTwDWIFl5Uwi4cBBdi3fp08tn7nECpeLOw6dnRDN0XIMAuB00qbuDB
	 CY92jN+Sli58OQqwLWA2IYebsTbz3TYYZEjAQsIf+Nt/DtHvJ3o89+6xI7Sx9M58U738SHF5OOEi
	 EZrmc+CuYiOzvZAxha4LLRNgeAZk6lNUqD8lLSA50gk5wv5+QfT8RTN5ZmHcNtexEjVFaTzmFiYc
	 fGZS1a3cQNG48fpUAE3AwDKfSUDKO5alV40jy9vugy3dhJ9rk/bt0DVOGeJ1U6CM7wH/peGI3rja
	 BxkRe8qtPthhmIM2X6rSqi618vJhPtemStqChy5pgt4OQr+SF9xeUN28tvjtUO5ys9hXF+e/c=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH 1/2] net: enc28j60: support getting irq number from gpio phandle in the device tree
Date: Sun,  9 Mar 2025 15:47:08 +0800
X-OQ-MSGID: <20250309074709.127504-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows the kernel to automatically requests the pin, configures
it as an input, and converts it to an IRQ number, according to a GPIO
phandle specified in device tree. This simplifies the process by
eliminating the need to manually define pinctrl and interrupt nodes.
Additionally, it is necessary for platforms that do not support pin
configuration and properties via the device tree.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 25 ++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537e4..b3613e45c900 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -24,6 +24,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/of_gpio.h>
 
 #include "enc28j60_hw.h"
 
@@ -1526,6 +1527,7 @@ static int enc28j60_probe(struct spi_device *spi)
 	struct net_device *dev;
 	struct enc28j60_net *priv;
 	int ret = 0;
+	unsigned long irq_flags = IRQF_ONESHOT;
 
 	if (netif_msg_drv(&debug))
 		dev_info(&spi->dev, "Ethernet driver %s loaded\n", DRV_VERSION);
@@ -1558,20 +1560,33 @@ static int enc28j60_probe(struct spi_device *spi)
 		eth_hw_addr_random(dev);
 	enc28j60_set_hw_macaddr(dev);
 
+	if (spi->irq > 0) {
+		dev->irq = spi->irq;
+	} else {
+		/* Try loading device tree property irq-gpios */
+		struct gpio_desc *irq_gpio_desc = devm_fwnode_gpiod_get_index(&spi->dev,
+				of_fwnode_handle(spi->dev.of_node), "irq", 0, GPIOD_IN, NULL);
+		if (IS_ERR(irq_gpio_desc)) {
+			dev_err(&spi->dev, "unable to get a valid irq gpio\n");
+			goto error_irq;
+		}
+		dev->irq = gpiod_to_irq(irq_gpio_desc);
+		irq_flags |= IRQF_TRIGGER_FALLING;
+	}
+
 	/* Board setup must set the relevant edge trigger type;
 	 * level triggers won't currently work.
 	 */
-	ret = request_threaded_irq(spi->irq, NULL, enc28j60_irq, IRQF_ONESHOT,
+	ret = request_threaded_irq(dev->irq, NULL, enc28j60_irq, irq_flags,
 				   DRV_NAME, priv);
 	if (ret < 0) {
 		if (netif_msg_probe(priv))
 			dev_err(&spi->dev, "request irq %d failed (ret = %d)\n",
-				spi->irq, ret);
+				dev->irq, ret);
 		goto error_irq;
 	}
 
 	dev->if_port = IF_PORT_10BASET;
-	dev->irq = spi->irq;
 	dev->netdev_ops = &enc28j60_netdev_ops;
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->ethtool_ops = &enc28j60_ethtool_ops;
@@ -1589,7 +1604,7 @@ static int enc28j60_probe(struct spi_device *spi)
 	return 0;
 
 error_register:
-	free_irq(spi->irq, priv);
+	free_irq(dev->irq, priv);
 error_irq:
 	free_netdev(dev);
 error_alloc:
@@ -1601,7 +1616,7 @@ static void enc28j60_remove(struct spi_device *spi)
 	struct enc28j60_net *priv = spi_get_drvdata(spi);
 
 	unregister_netdev(priv->netdev);
-	free_irq(spi->irq, priv);
+	free_irq(priv->netdev->irq, priv);
 	free_netdev(priv->netdev);
 }
 
-- 
2.43.0


