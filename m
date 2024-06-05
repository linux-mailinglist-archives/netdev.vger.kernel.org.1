Return-Path: <netdev+bounces-101014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2288FCFC5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040E51F276AD
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EC1940AD;
	Wed,  5 Jun 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn3lmgjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76023194089
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594415; cv=none; b=RfqWqAOXSykHN9VYt40oXlThNwnoblsCZNQxnDyL0IxCpeJaVam86YX5pk2u5kjteW8GxUEjjdThNp0aiOyNn7mTj+oOHa6OdFBwTNOZdCookXmsnmmJGqL8GTRpj2xzGNOfuD1/TwC5OUo39xqO4FkFJH5PrC+7bji251c9YXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594415; c=relaxed/simple;
	bh=aStf4weoOb19KksXkJpVX+50vWps0BP+lcOYbVnGIJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBF/LgXBQqvG9/4GWfOcdObXYGIxknwSGcGfsx77xuAMslJNuDBtUgc8ARqiwf2O6T9tJ4tZ1kPSbfSnkR6bMWJlAODQBYnFKTNf8Agpibs7hhixQeqPwjD9NyPjawkmJFdlUfOIt2yiGQvlR8JpaKdHnzupHMMMjR+Hk8prrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn3lmgjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5736C32781;
	Wed,  5 Jun 2024 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717594415;
	bh=aStf4weoOb19KksXkJpVX+50vWps0BP+lcOYbVnGIJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fn3lmgjotYuQ4H4yDO7EJhyUqxIOuOyjBjMsP3tdzqrdcc6kWictZfgSaeVow3Pz5
	 rzR0xiBA1yO2kzLvSiQ8egaS9fKMFhtgzOP+VM3Rk/OeR4eNArbzJtXjWEywDgzmuW
	 kcmtXvvIokZWHSc/NjfgGSVrNTUQwZEjYNApUR9o6KaMJoXVRuKELNE/mVI/4JqjaO
	 as5OWxZTES7q3MycWGWqDLXESxhUKwjzOJf/sYtW47lgz3D/7VvnpNkCkMzLD/3qZr
	 q622b+1FAVRAR9Ak6Fo+r8PM6W9C4w0mzjLWN97G0XAQE7bEpwC7LGSUCHPW7p9HYP
	 JJPN98ftfBdDw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v3 1/2] net: dsa: deduplicate code adding / deleting the port address to fdb
Date: Wed,  5 Jun 2024 15:33:28 +0200
Message-ID: <20240605133329.6304-2-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240605133329.6304-1-kabel@kernel.org>
References: <20240605133329.6304-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sequence
  if (dsa_switch_supports_uc_filtering(ds))
    dsa_port_standalone_host_fdb_add(dp, addr, 0);
  if (!ether_addr_equal(addr, conduit->dev_addr))
    dev_uc_add(conduit, addr);
is executed both in dsa_user_open() and dsa_user_set_mac_addr().

Its reverse is executed both in dsa_user_close() and
dsa_user_set_mac_addr().

Refactor these sequences into new functions dsa_user_host_uc_install()
and dsa_user_host_uc_uninstall().

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 net/dsa/user.c | 91 ++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 867c5fe9a4da..efbb34c711cb 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -355,60 +355,82 @@ static int dsa_user_get_iflink(const struct net_device *dev)
 	return READ_ONCE(dsa_user_to_conduit(dev)->ifindex);
 }
 
-static int dsa_user_open(struct net_device *dev)
+static int dsa_user_host_uc_install(struct net_device *dev, const u8 *addr)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int err;
 
-	err = dev_open(conduit, NULL);
-	if (err < 0) {
-		netdev_err(dev, "failed to open conduit %s\n", conduit->name);
-		goto out;
-	}
-
 	if (dsa_switch_supports_uc_filtering(ds)) {
-		err = dsa_port_standalone_host_fdb_add(dp, dev->dev_addr, 0);
+		err = dsa_port_standalone_host_fdb_add(dp, addr, 0);
 		if (err)
 			goto out;
 	}
 
-	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr)) {
-		err = dev_uc_add(conduit, dev->dev_addr);
+	if (!ether_addr_equal(addr, conduit->dev_addr)) {
+		err = dev_uc_add(conduit, addr);
 		if (err < 0)
 			goto del_host_addr;
 	}
 
-	err = dsa_port_enable_rt(dp, dev->phydev);
-	if (err)
-		goto del_unicast;
-
 	return 0;
 
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
-		dev_uc_del(conduit, dev->dev_addr);
 del_host_addr:
 	if (dsa_switch_supports_uc_filtering(ds))
-		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
+		dsa_port_standalone_host_fdb_del(dp, addr, 0);
 out:
 	return err;
 }
 
-static int dsa_user_close(struct net_device *dev)
+static void dsa_user_host_uc_uninstall(struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
-	dsa_port_disable_rt(dp);
-
 	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
 		dev_uc_del(conduit, dev->dev_addr);
 
 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
+}
+
+static int dsa_user_open(struct net_device *dev)
+{
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	int err;
+
+	err = dev_open(conduit, NULL);
+	if (err < 0) {
+		netdev_err(dev, "failed to open conduit %s\n", conduit->name);
+		goto out;
+	}
+
+	err = dsa_user_host_uc_install(dev, dev->dev_addr);
+	if (err)
+		goto out;
+
+	err = dsa_port_enable_rt(dp, dev->phydev);
+	if (err)
+		goto out_del_host_uc;
+
+	return 0;
+
+out_del_host_uc:
+	dsa_user_host_uc_uninstall(dev);
+out:
+	return err;
+}
+
+static int dsa_user_close(struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+
+	dsa_port_disable_rt(dp);
+
+	dsa_user_host_uc_uninstall(dev);
 
 	return 0;
 }
@@ -448,7 +470,6 @@ static void dsa_user_set_rx_mode(struct net_device *dev)
 
 static int dsa_user_set_mac_address(struct net_device *dev, void *a)
 {
-	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct sockaddr *addr = a;
@@ -470,34 +491,16 @@ static int dsa_user_set_mac_address(struct net_device *dev, void *a)
 	if (!(dev->flags & IFF_UP))
 		goto out_change_dev_addr;
 
-	if (dsa_switch_supports_uc_filtering(ds)) {
-		err = dsa_port_standalone_host_fdb_add(dp, addr->sa_data, 0);
-		if (err)
-			return err;
-	}
-
-	if (!ether_addr_equal(addr->sa_data, conduit->dev_addr)) {
-		err = dev_uc_add(conduit, addr->sa_data);
-		if (err < 0)
-			goto del_unicast;
-	}
-
-	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
-		dev_uc_del(conduit, dev->dev_addr);
+	err = dsa_user_host_uc_install(dev, addr->sa_data);
+	if (err)
+		return err;
 
-	if (dsa_switch_supports_uc_filtering(ds))
-		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
+	dsa_user_host_uc_uninstall(dev);
 
 out_change_dev_addr:
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
-
-del_unicast:
-	if (dsa_switch_supports_uc_filtering(ds))
-		dsa_port_standalone_host_fdb_del(dp, addr->sa_data, 0);
-
-	return err;
 }
 
 struct dsa_user_dump_ctx {
-- 
2.43.2


