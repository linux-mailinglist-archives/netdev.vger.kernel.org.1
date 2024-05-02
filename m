Return-Path: <netdev+bounces-93021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D18B9ADD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D5EB234A7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48F7E796;
	Thu,  2 May 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbA4Nz5K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C591CD39
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652968; cv=none; b=JyGLS5eDHXyROYLeK6Y1RlEC8RizkIiqxH+r9rVXBewWMW/W83DNoYyIXs5FyPK1sInJVfGrdonxoA5hEJXnlVEWoAaRMLNxH3aIVogEvDK/Oa81gVZC29o5dZdK36HOG4bRLdXJ58pFnDCsqcphx7Pn47gFe0hBNnE72U1RYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652968; c=relaxed/simple;
	bh=9azVaDYx8Hf2BII3OMntXoB0smdteY8jXBXkGincjrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcnqbvhwPK4V7R8LiG79RqvA7q0Ae8R5CGarwRfZBxEm86jkYW2ShAHuyOABXMHYfTxfI7ffBf+11CXxXB8PKAQts6u54M/YZ0Pxv/YxWmMWuxm+c23NeURusQKFRSi8G4MaqBkoYLFny+mbPAV547g+b0Gy0k+SpasCJsdKJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbA4Nz5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FABC4AF18;
	Thu,  2 May 2024 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652968;
	bh=9azVaDYx8Hf2BII3OMntXoB0smdteY8jXBXkGincjrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbA4Nz5Kxsa3FVBXg1eyurCEBn74SIrfWK2nmbwt7n6JWA9ZLq5MggrUx7HviU66q
	 gyG3x27Jvrft9b7oJzhxiDdyq/LAqJsJDPjTtJgtwu/SvGT77W/8B0MmyOWnl/VSwr
	 fr9zeD9HOfeURFdLJGmY5p94f+ry7UtZwrzDzwIptTDeqy9sUfZjy9xUL95Ccel5Ql
	 4dABs4gedsLsr4cISNdMfSAV6GnHA/tk8SipVfhj7pG9KGgDXtE5O1h+/8iL1fLdzl
	 rniiQOW/0jZ9yV/pfGqJfmF4ws+MLXmYvuWJn4omEf6mnjwuoJQ9Eu1feKs+I0kn5j
	 JOuR3v+LoqsZg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v2 1/2] net: dsa: deduplicate code adding / deleting the port address to fdb
Date: Thu,  2 May 2024 14:29:21 +0200
Message-ID: <20240502122922.28139-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240502122922.28139-1-kabel@kernel.org>
References: <20240502122922.28139-1-kabel@kernel.org>
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
index c94b868855aa..b1d8d1827f91 100644
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


