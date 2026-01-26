Return-Path: <netdev+bounces-253334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAv8F9sId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:25:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE9D847E6
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6120A3029A54
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDD285050;
	Mon, 26 Jan 2026 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IpIivPb4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C912773C1;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408591; cv=none; b=rzLUc7JKn9kEciuVBRFn8S1d27ls68V5ya/Ql47WsvoUuiaw5x7jvKDGPxPqQZEFqYfO/KRe1hKDB8z5ekr68vGotLs7cLKWGJSTTmIesrKksjdZQNRU3b3/WFxOi8OhmedLnudkk9d6skthVDgisCIfEKcDeo7liCJmj/ZC3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408591; c=relaxed/simple;
	bh=Mg1ohjtVy0wioBq9J8DDL/kQgTQMLbePoKZMznb3ElQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQ0ccJgd9FIpZRaT1rA/UymPysvT5QTu2CdrdIDo2J2aPZCc3yWdX3dcHAme8Js0NayZgvr0pYLEbaUe7aI5X3p8ILz6g9UjRGeEbJDcRa/WMEljvDKxe+pm/DZwXQ+FTVcyF6/0U5BaKxyFEcOSSH0mo3m37SGydpsjK5zmmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IpIivPb4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VS
	nGBy+d8W8IhLP50kfwgE0XsPTw3nxi+EJ1fNMCNjM=; b=IpIivPb4XJnmBie5VB
	aI6SAQKhn3iDcOcrEdd1X1+Sz1N1sbSEzJ8P5ozt3rWn0ibsyktfcZkLGw9RzLgR
	yFmEV8HkvFAO6kzTCNqQT4B46ETDQ73y5kJ68mCorIOudWjEydY6t8DedRMxb/D/
	qclnB9vL+z8w3OzXMEhJZejFc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S6;
	Mon, 26 Jan 2026 14:22:12 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v8 4/8] net: wwan: core: split port unregister and stop
Date: Mon, 26 Jan 2026 14:21:54 +0800
Message-Id: <20260126062158.308598-5-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48CFy3Cr1kJr15WFWxZwb_yoW5Jr15pa
	1qqF93KFWkJr43Ww43XF4xXFWruF4xGw1Sy34xW34Skrn5tryFvrWkuF1qvrWrJF97WFy5
	ZrW5tFWUCa45Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGQ6NUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6BU-o2l3CBXu7AAA3g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: CFE9D847E6
X-Rspamd-Action: no action

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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/wwan_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 76f1d759d255..1d9f43ef9b71 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -475,6 +475,18 @@ static int wwan_port_register_wwan(struct wwan_port *port)
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
@@ -535,18 +547,19 @@ void wwan_remove_port(struct wwan_port *port)
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


