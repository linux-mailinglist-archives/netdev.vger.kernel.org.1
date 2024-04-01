Return-Path: <netdev+bounces-83756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AB893B87
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2C71C213EB
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEED3F9C5;
	Mon,  1 Apr 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3hp1xPFa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB8405E5
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978583; cv=none; b=RXyPhlvfo7+rSiI0As9LyThihfqTBOoSQSXp/yrUz2l0fCmFaKaSZeuhH4FJ9oFFHxWfKMe9tifbXw6CRPF/32w2ksAFgnK66ei04nf5p/HE9XMLOdaYuJt8FoFwB3lVJz4ITdhG2KVKhehEN5dgppYN30g3Do3bGphpqTUT8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978583; c=relaxed/simple;
	bh=jN06A6RN74/A9JG07iAr7h9U1L7CPt7cjU7nOZyzbGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gkKSFjt/2zjPRyP4fwteHgoueS2OVU1lDZhF84PGt246GNv9HdY78v9q1tuynFU0+RV/aiJxukjkdeCACJqk7UIgVzmd/5LjrkX4UAlyU05Cw6zPyjr8Hc2zIOTsHNQhxm+cCR6oXuYZs9Lo6gX8YWJSUbUOiOAGi2JBwJWE8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hp1xPFa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jQR7P1Q5Se8GixNYzr/FafPy3P2nvqlYT8DftTiAOhc=; b=3h
	p1xPFaU1c4TOza0+KDUC8watsZuPK7hM0fC32OJoOd2RSDfv+ZeTs/yBQdcoLgZBa5jeKP6PtC87X
	LPc9k+s+0b7gPgtWQj7HC9tngLcZCdUgI0YSbny55I+6AhHZV/Rc9QgOUckN5QuEsXhLXF7p8phkp
	b0gRkv7PX+cQhq4=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpi-00BrFx-Ml; Mon, 01 Apr 2024 15:36:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:50 -0500
Subject: [PATCH net-next v3 5/7] net: dsa: Add helpers to convert netdev to
 ds or port index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-5-221b3fa55f78@lunn.ch>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhBnnKaJbOApBkClkmls/TXY7PaiauY4t9Fe
 0TM8gsvRq2JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QQAKCRDmvw3LpmlM
 hMmED/4+YWkQ02dThPIkLxgXMULXMwkFnQUD7EsGnDGcffufN7MvmiAw9lD88YyvWu5XHNkpUhA
 3J7tnGfUd8N9l2slKiUQZKhjHjXfoIduFs08yYSgPLnA/BV57U7RS7leK/N8EdvIUS+y4HyDc9T
 IRY0DKuBr3Adh6TlS8jjZ3Jnznd+s2VYX4N5YqREwrYV9TJsl4oIk/TSdVMZhrKjIvJVExZqy2F
 u1TUntNktdQWqgrJtvTxxhmCkLO26mIcne+C0Ut2s/0ucU2yget51WIMMX4csj7Xp/D8JMd9itG
 gwqsF58R0q9lT1yaQkkIfamnlvusGZmDXSc69IwzEb+sJjXuefJUCfMk1/3WO7/W+FTFzMMdDi5
 QJAu190/BB0XDrOhoYWeq9nX20Di2XnAd1AXbmjVdRofaTDYQmrTizhIg3xAQXiSBMD3M+8Qw/R
 UDuscG2V4XuOb5Ke76F4LNT4lZ6Q9B9vH1q2J0FMwshWCtQeAR4y0/sxbnDuU+jtToVq2w6m7w5
 ukSgYdSRaE4rwk5VcFFY7INmHOI4dLNMuCmDs3G0q2iAAXXHnVy8q5YEXo6Nh3tB0EjUPdmluTU
 C+YAPRiULEbcG5HTR0HrwCqx7Vm+F0lBHau6ZSzZHU4ZX+9UwvI6W+NsgX/FSYLry9WLmF22+z0
 MLWJTBDc/YeAvDw==
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


