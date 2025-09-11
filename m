Return-Path: <netdev+bounces-222168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F10B535A5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1DFA06A7F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78934573F;
	Thu, 11 Sep 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEdTl97P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091B3376B3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601256; cv=none; b=lMgWrKX/94MtXjzd7VKvhHY37y3QZJ1iLCnAUjPrEdLw4xQyD8YAaz2/D9VvXO7pYzwfyBM6qORDOe2ZediZ8D70P9ibpGE7WEXOBwzUs0qm6qiQkj1pqCwXrKKdttwfTm9ogt5IsCiRQ8F4VA19AWF4oTE4RmpA/N6fqvOlLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601256; c=relaxed/simple;
	bh=LF9mjpsJE320nJa7ljvOUbLgrwPxvDyg6GUm3LLtrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xml0N08G3SNkDNWOu/xSorN7YarJ16J9WtVLb1LCBDYkrlmg0TNpCXZgXyKrRkvJObo+iC8dp6Nl0bJUUhp9irAqg7LVPMALqNyrb3Yl2onuLDB/QLLBT+LVweVwc5CfgYBgAyGNkSDIimSsRHcXGLNCuz8FuZ92wWX5ggTX9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEdTl97P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757601253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HwNowAS09RWNRuCOS+CaBRWoQtMYUs2xhxpuv/fB2s=;
	b=BEdTl97PDBByWLT3JiPVGune/EJd+ZmbEremhHsrEpwqNPHd89NOhtzlgMo7xwZeVYjuyS
	66rbjnwWqypaGtts4XcuBiEq5ObFrVzWxj96/5yWg68FR/DF3EZxnkYQGqMPK7ZDzzLCpO
	ajIZ8xf41UuLDoc/7dXOy6YYsBVQBfE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-hC8V3QT8NjOrS0eIjaO0kw-1; Thu,
 11 Sep 2025 10:34:06 -0400
X-MC-Unique: hC8V3QT8NjOrS0eIjaO0kw-1
X-Mimecast-MFC-AGG-ID: hC8V3QT8NjOrS0eIjaO0kw_1757601241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BA8E1800372;
	Thu, 11 Sep 2025 14:34:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34A0A1800576;
	Thu, 11 Sep 2025 14:33:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-usb@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?Hubert=20Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Subject: [PATCH net] Revert "net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups"
Date: Thu, 11 Sep 2025 16:33:31 +0200
Message-ID: <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This reverts commit 5537a4679403 ("net: usb: asix: ax88772: drop
phylink use in PM to avoid MDIO runtime PM wakeups"), it breaks
operation of asix ethernet usb dongle after system suspend-resume
cycle.

Link: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com/
Fixes: 5537a4679403 ("net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Since we have the net PR waiting for this one, I'll apply it very soon
unless someone screams very loudly in just a few mins :)
---
 drivers/net/usb/asix_devices.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 1e8f7089f5e8..792ddda1ad49 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -607,8 +607,15 @@ static const struct net_device_ops ax88772_netdev_ops = {
 
 static void ax88772_suspend(struct usbnet *dev)
 {
+	struct asix_common_private *priv = dev->driver_priv;
 	u16 medium;
 
+	if (netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_suspend(priv->phylink, false);
+		rtnl_unlock();
+	}
+
 	/* Stop MAC operation */
 	medium = asix_read_medium_status(dev, 1);
 	medium &= ~AX_MEDIUM_RE;
@@ -637,6 +644,12 @@ static void ax88772_resume(struct usbnet *dev)
 	for (i = 0; i < 3; i++)
 		if (!priv->reset(dev, 1))
 			break;
+
+	if (netif_running(dev->net)) {
+		rtnl_lock();
+		phylink_resume(priv->phylink);
+		rtnl_unlock();
+	}
 }
 
 static int asix_resume(struct usb_interface *intf)
-- 
2.51.0


