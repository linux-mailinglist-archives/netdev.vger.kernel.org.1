Return-Path: <netdev+bounces-246410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2EBCEB699
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376783172580
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B08311C20;
	Wed, 31 Dec 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kymUDguA"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87A3115AF;
	Wed, 31 Dec 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163953; cv=none; b=LMK1nwO+B/HHpu3wXKu8+HtIOLl+hd+epq/Be3c0dvx0UUywCCsB+cu6I4+UWw3kULRTg176jZWae3hQ2DP8LwOwuP0GvLNXW/9+MHuy958Q3uiUP2l1pVwm7ugMbfcsBTwhOMmcUz1OhY4ODIP2aodfTaPQ2Lzeks0EOYvKzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163953; c=relaxed/simple;
	bh=YY3Vx9PIFhrCTpocaI1ZwHiT4Zc4qeWkF9q4sJfNauM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk0jCAP5kb2C3s6IU2S6WajIdig76RLxmjLd3kLCiSMyTnc5nvwt6cippIQfy1rOEuwSe+qZ7SK57D2sFT2dez0Gkc7ft9s1gOI+DJmRs+C6ZCRJxmBo5AWC+QnMlKOwFvKELHXcemqWQ5CnItgzm1WMHzONHgAh6PEEcpY6HBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kymUDguA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oO
	dtIcMYsSD0TmAAE42OsXPNuxSQgAJE5aR5WCRdbik=; b=kymUDguAvBRVYXkPHR
	UCwEcqO0dBHMJY0pG7njXWwvTmvGdne2EV/C9Ohgd9+sC/81kvIhTZBWXBexcdTw
	3xrIIoqPChEOfLyngbWjzBYAS5QgyWVTXFdOq7lSRWCq0o/EBh2bOHRhFp3ztn5G
	uVyiBODbIYC9gLvjBkMEw1Chw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHpCPmx1Rp9FyCDg--.29927S5;
	Wed, 31 Dec 2025 14:51:35 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v3 3/8] net: wwan: core: split port unregister and stop
Date: Wed, 31 Dec 2025 14:51:04 +0800
Message-Id: <20251231065109.43378-4-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231065109.43378-1-slark_xiao@163.com>
References: <20251231065109.43378-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCPmx1Rp9FyCDg--.29927S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48CFy3Cr1kJr15WFWxZwb_yoW8KF1Dpa
	1qqF9xKFW8Jr43Ww43XF4xXFWruF4xGw1Sy34xW34Skrn5tryFv3ykuF1qyrWrJF97WFyY
	vrW5tFWUCa45Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLAwxUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xeeA2lUx-cJ0wAA36

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Upcoming GNSS (NMEA) port type support requires exporting it via the
GNSS subsystem. On another hand, we still need to do basic WWAN core
work: call the port stop operation, purge queues, release the parent
WWAN device, etc. To reuse as much code as possible, split the port
unregistering function into the deregistration of a regular WWAN port
device, and the common port tearing down code.

In order to keep more code generic, break the device_unregister() call
into device_del() and put_device(), which release the port memory
uniformly.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index edee5ff48f28..c735b9830e6e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -476,6 +476,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
 	return 0;
 }
 
+/* Unregister a regular WWAN port (e.g. AT, MBIM, etc) */
+static void wwan_port_unregister_wwan(struct wwan_port *port)
+{
+	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
+
+	dev_set_drvdata(&port->dev, NULL);
+
+	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
+
+	device_del(&port->dev);
+}
+
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
 				   const struct wwan_port_ops *ops,
@@ -536,18 +548,19 @@ void wwan_remove_port(struct wwan_port *port)
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 
 	mutex_lock(&port->ops_lock);
-	if (port->start_count)
+	if (port->start_count) {
 		port->ops->stop(port);
+		port->start_count = 0;
+	}
 	port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
 	mutex_unlock(&port->ops_lock);
 
 	wake_up_interruptible(&port->waitqueue);
-
 	skb_queue_purge(&port->rxq);
-	dev_set_drvdata(&port->dev, NULL);
 
-	dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port->dev));
-	device_unregister(&port->dev);
+	wwan_port_unregister_wwan(port);
+
+	put_device(&port->dev);
 
 	/* Release related wwan device */
 	wwan_remove_dev(wwandev);
-- 
2.25.1


