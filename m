Return-Path: <netdev+bounces-80279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FAF87E07C
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91093281F8B
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1320B20;
	Sun, 17 Mar 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1lGo+jKR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471722086
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711960; cv=none; b=rJjJXfM7z4LNgkeADDsKJet5JEzTUb5TZULVsptseKm8yhkg0dIMcbCN1om2DpuxCw08jmOO69EY5abgMCokKuQR2mmXJfA6H3DLDg85cQUSVwXJ1ONCipX3f7OSIblVcmHZKiraoL5FnXDGjLpo/aqdyheL4whkEt0WygpoN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711960; c=relaxed/simple;
	bh=jN06A6RN74/A9JG07iAr7h9U1L7CPt7cjU7nOZyzbGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6Iw0BvPy5MkukypTTk4nwv5loOP9Ub+oRaoUadJyPEQoQOh5qQ0IB6aUcYMqiANcQdbTGna9SHRnc71MEV50SSvz0uWDk//EVZ7Dy2QV5nPF1vATGddtwm4OfKYOEGH4XyQb0qKXaOOp7CcfPpvQU6fS2j1nFd2hp1muq8MqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1lGo+jKR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jQR7P1Q5Se8GixNYzr/FafPy3P2nvqlYT8DftTiAOhc=; b=1l
	Go+jKR+/HbQl1VWWEYFqjJxQQq+qT+GBKUbkhaH2QnTrbRmaR7/PSI9NxjDonhm/DEiGDg7Z4e3bY
	CR1sO6moXc5KgxIm6QFquzoi7txVT5ORC6yNCQdFXA3bodXQ9fpsZdIZyQ3ycbXMrmOlfMsliGoi/
	CJ8qLQo1mTBmQJM=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyKJ-00AYv5-4w; Sun, 17 Mar 2024 22:45:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 Mar 2024 16:45:18 -0500
Subject: [PATCH RFC 5/7] net: dsa: Add helpers to convert netdev to ds or
 port index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-5-80a4e6c6293e@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
In-Reply-To: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=jN06A6RN74/A9JG07iAr7h9U1L7CPt7cjU7nOZyzbGA=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92SC4gIgap0nTGhzlfww13pEBycNyUBzUh5nk
 vgGrq3Hi7eJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkggAKCRDmvw3LpmlM
 hHkJEACFe6D0ncbsXewwG4aiIyzTwLV01Lji6rzWi4593MqIQo+t/z4M13pZHoqDLsfpZ6dF0Ok
 fHZ+JUVYRUmlFJhqftRyqfFcRnVtJ5fZgP5Pki47v+wcVOecRY4YMaxVLAwoi/e9jG3oDjsriyJ
 FI05kcGayTHQlm2+7cSO6z3vpGR06ncBCQXKa0T23Q6DXLHJ3wMqFlQt6pKZdVFmtWKINvYu2c/
 NEp2CFeFMXkBdYCkFF5lGNCYTXZlzSiirtAgnuzVwLMG6HDUVSMN/NZ7CTtBAb7YLhQUZAPoUax
 r/dfoZSfHRExngGUbB66Iq0+Ve/UibGCnHG0WReB5PNUnVg8muXEHiPmvGvEX4o6CXYQItLpu7v
 ev6db88zveyk2jt9YQz1ReVkPldmgZC+qzl7498b93S+zMWxCJKizvidxSkpVk0lFyH28jTcaMN
 6YV7VU6HGmOFMzXM2uYFpId/5o6PoV9cxCo2SGVRDbi7tA1hOHJIpZuFI75CKBV6k8dk7cfpBne
 mNPNiSLHXtXpWp5tdSkAjy4kCugid2S2hx4hX1EgMIkoZQiWKY4u4uJqt/aa0vEem6j8SW+h04q
 W0DfFtAhAgrYrC5TjySpYJbNLq7GWQ+7Jg3deIERzcGwzq0p9nE2dkSfQLV2FvK1VIjhtq38IHQ
 1TdXl3odQAyFrjg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The LED helpers make use of a struct netdev. Add helpers a DSA driver
can use to convert a netdev to a struct dsa_switch and the port index.

To do this, dsa_user_to_port() has to be made available out side of
net/dev, to convert the inline function in net/dsa/user.h into a
normal function, and export it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h | 17 +++++++++++++++++
 net/dsa/user.c    |  8 ++++++++
 net/dsa/user.h    |  7 -------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..1fbfada6678d 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1359,6 +1359,23 @@ int dsa_register_switch(struct dsa_switch *ds);
 void dsa_switch_shutdown(struct dsa_switch *ds);
 struct dsa_switch *dsa_switch_find(int tree_index, int sw_index);
 void dsa_flush_workqueue(void);
+
+struct dsa_port *dsa_user_to_port(const struct net_device *dev);
+
+static inline struct dsa_switch *dsa_user_to_ds(const struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+
+	return dp->ds;
+}
+
+static inline unsigned int dsa_user_to_index(const struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+
+	return dp->index;
+}
+
 #ifdef CONFIG_PM_SLEEP
 int dsa_switch_suspend(struct dsa_switch *ds);
 int dsa_switch_resume(struct dsa_switch *ds);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 16d395bb1a1f..bbee3f63e2c7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3699,3 +3699,11 @@ void dsa_user_unregister_notifier(void)
 	if (err)
 		pr_err("DSA: failed to unregister user notifier (%d)\n", err);
 }
+
+struct dsa_port *dsa_user_to_port(const struct net_device *dev)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+
+	return p->dp;
+}
+EXPORT_SYMBOL_GPL(dsa_user_to_port);
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 996069130bea..b6bcf027643e 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -51,13 +51,6 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 int dsa_user_manage_vlan_filtering(struct net_device *dev,
 				   bool vlan_filtering);
 
-static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
-{
-	struct dsa_user_priv *p = netdev_priv(dev);
-
-	return p->dp;
-}
-
 static inline struct net_device *
 dsa_user_to_conduit(const struct net_device *dev)
 {

-- 
2.43.0


