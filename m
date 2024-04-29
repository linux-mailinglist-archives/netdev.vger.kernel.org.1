Return-Path: <netdev+bounces-92204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFA8B5F25
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A04E1F20F26
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3585659;
	Mon, 29 Apr 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q82rt5/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43685646
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408593; cv=none; b=Rf8ELFdIJNTcCC/nJdahEgcEetWZnlzFjSsMMkVd4fEO7udjeEBvxLoI99Duw/4/9WyzRM71RZ62GkW/FT/8Z9/qsIj1as/WL9Zvbw4nMWKN/DbLSoELS3DzG4j0zn+EpP1O6BpsEz6Kz7Fyx35HjCPMxtn0QOt7PPGON3+wUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408593; c=relaxed/simple;
	bh=9azVaDYx8Hf2BII3OMntXoB0smdteY8jXBXkGincjrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmQBhjXrdeQWdT4GaBqk1XlEaG8OKyywVaPIiARrXuVGYGRWFtmfSRiJfA4lSCDFCQR2QTzBEozTwPQwcaRgEECiu4ZlNishqM+8ht8OeWo8ityW0fzIlmNJojC9DIBerdETllAS8ynyMWLJJZ8Zw4Jjxx+NdE2K2ntJeZ6xJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q82rt5/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C1C4AF14;
	Mon, 29 Apr 2024 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408593;
	bh=9azVaDYx8Hf2BII3OMntXoB0smdteY8jXBXkGincjrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q82rt5/6fDT8dgtzdWaROZnaOLBgBVPDpbRG1S9lxmD7ryF3xP+Wbht7wcBIHQtZ2
	 zhKomV67KouCj806er/AmOaDDKRX0m7eKxeltkKwEJU+YY7pPq5EVZAdVzbDDkcwMD
	 oH8szbq4Bj4MJDihbe8wWKwFXFNiPXcpNoQA1EREMXvShjhTuAkewKnSNoBRjHWVRu
	 FLhLxlMHB6U4g/YTO5nMWsjGbyc3ILQ54aDKVOlePj+YCGH4LDqRLi/KFRYa7nOfl5
	 dRKPGG7x8PK0EjYMvf0slZ45TR5MkGczox0oUU7jRQJq+xRe+NRCCxsChJoTQq41AL
	 9DqZ+kbSrtmkQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 1/2] net: dsa: Deduplicate code adding / deleting the port address to fdb
Date: Mon, 29 Apr 2024 18:36:26 +0200
Message-ID: <20240429163627.16031-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429163627.16031-1-kabel@kernel.org>
References: <20240429163627.16031-1-kabel@kernel.org>
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


