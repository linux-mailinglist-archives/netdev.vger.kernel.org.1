Return-Path: <netdev+bounces-85459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E789ACCF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B041F21B11
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9644EB44;
	Sat,  6 Apr 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P+cQMZJF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAB4EB43
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434449; cv=none; b=Zo8V7FuIy7Fz7sNyfZHcURZe5KeBoI1MMzMz/wLcSoCRJQsGaERVAWnzbffc2cI7f/T7Ia3nm37OLa5vQYxdJLtWMnyZ6NEpN4yWnw3GPdjQg2B+56F8PtmXDTNmRK8tgIS7vpFWMRAjU7uGhH9VKla5AZg6YdTwOisJQ+z+1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434449; c=relaxed/simple;
	bh=p7dt1sYAFleXe7WJbo7I++W2evAAUObqgPZGrVymRS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAJbgCQND+B3Ed5sv8U8EKR24Vmo4e2ObLqZfKt2vCwZxpasW1sidEbGFcVCiBDZWLH78jRNJ0J5KQ8l8LQiDe6x2FJcgTP3EL2eqx0e1B5mq1haHea/41aManx0y9HUY4QhNiNJFgJA7kZB//5n2fS4hW70ziSUw8yo/AyXb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P+cQMZJF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HzFEEq0e1hj2eRrvH4HUFfwK1pjYzpPU5ffG+djjhUA=; b=P+
	cQMZJFnHw4+Gvw0/fMXkKT2JUpFP1vfSjVcrb0PHTLPJE7cH5L8EGsoyjLrFpycztViDxSZsPdC7C
	NAZUBLi2QASZFs9wDIVQYRjSXkWugcLfyj20FESp0K2Y/HW7aAFBkKvZqnhHYJ09UcjnlVpwCY0hY
	QRp8tjbTDhiGj74=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQP-00COA7-1c; Sat, 06 Apr 2024 22:14:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:30 -0500
Subject: [PATCH net-next v4 3/8] net: dsa: move call to driver port_setup
 after creation of netdev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-3-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4470; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=BGV2AxUQLBPNtICKS0EgkQ3O7rWT8QxXcz7h1ZGAEIs=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEaz/BS5RJTeqRhCZ0GsQ+8sYy9CZ8NUnudeLV
 QRgR9nrLgeJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGs/wAKCRDmvw3LpmlM
 hKANEACkl73pNnvroDWqYtroWDTw/nFp7I3HWhEHhu295RAOs8OkPvhXgNFAkH5uI5h2QgLhWiv
 waADTLNMqgLU6ejQ8kyZT+XGDsRCRecv/HGhZLLjZFk2SmPOoShkhlconxh7vNDP+YM7T7fSnJR
 +LE7g6Jyuqx/1lGiXLmT2jNuoJfhXmzb8tDN7b+vXig4lq6+noRgdwyBlYY11l/ApGNaL2TwhHD
 VkIkqpjaahyVNFyGw2z8YV1/WtitVplt4qpR9VEWdMQKxGG59UaOhI+WCFH1JdkWDcFsilyCch2
 4Uotn5Lt9ywwf34wEx4XmxG+xkXDDU9I25fbf5NhbdTHRQ1ctZnpPYO6PmtXa/SHiIAE+RMHJq1
 8srrS0p8Sb95RXELQPwx5VxmGZrwapiiAhR9YzZOHlamekSl/iNmfOAfRgqtL+h9YFj/cGhTE2c
 NVp6lMe0SVKJG+rSjVVTmskwzo5tUB5nX10pszQ6WyBDsUxbG2D3MhH91Jn3mOQwuYxdszrgEce
 fSchPNpte+yUV5iyWzEZbZK4iSfrIKzfROfKNGlD6J30BJR3XEtZ61twKIGJpqpEhNqyFXjZnXS
 PZ6L6Dzj0s5X4MlzDhC7rqL4ioTTyb8IZzZ3CZCiMmcAKosvmojGDmZF8GWUOZALi2Yulz0tIlB
 ti/OOXIgFzpdyFg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The driver-facing method port_setup() is a good place to add the LEDs of
a port to the netdev representing the port. However, when port_setup()
is called in dsa_port_devlink_setup(), the netdev does not exist
yet. That only happens in dsa_user_create(), which is later in
dsa_port_setup().

Move the call to port_setup() out of dsa_port_devlink_setup() and to
the end of dsa_port_setup() where the netdev will exist. For the other
port types, the call to port_setup() and port_teardown() remains where
it was before (functionally speaking), but now it needs to be open-coded
in their respective setup/teardown logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/devlink.c | 17 +---------------
 net/dsa/dsa.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index 431bf52290a1..9c3dc6319269 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -294,20 +294,12 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	struct dsa_switch_tree *dst = dp->ds->dst;
 	struct devlink_port_attrs attrs = {};
 	struct devlink *dl = dp->ds->devlink;
-	struct dsa_switch *ds = dp->ds;
 	const unsigned char *id;
 	unsigned char len;
-	int err;
 
 	memset(dlp, 0, sizeof(*dlp));
 	devlink_port_init(dl, dlp);
 
-	if (ds->ops->port_setup) {
-		err = ds->ops->port_setup(ds, dp->index);
-		if (err)
-			return err;
-	}
-
 	id = (const unsigned char *)&dst->index;
 	len = sizeof(dst->index);
 
@@ -331,14 +323,7 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	}
 
 	devlink_port_attrs_set(dlp, &attrs);
-	err = devlink_port_register(dl, dlp, dp->index);
-	if (err) {
-		if (ds->ops->port_teardown)
-			ds->ops->port_teardown(ds, dp->index);
-		return err;
-	}
-
-	return 0;
+	return devlink_port_register(dl, dlp, dp->index);
 }
 
 void dsa_port_devlink_teardown(struct dsa_port *dp)
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5d65da9a1971..d8aa869e17ba 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -462,6 +462,15 @@ static void dsa_tree_teardown_cpu_ports(struct dsa_switch_tree *dst)
 
 static int dsa_unused_port_setup(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			return err;
+	}
+
 	dsa_port_disable(dp);
 
 	return 0;
@@ -469,6 +478,10 @@ static int dsa_unused_port_setup(struct dsa_port *dp)
 
 static void dsa_unused_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
 }
 
 static int dsa_shared_port_setup(struct dsa_port *dp)
@@ -490,8 +503,23 @@ static int dsa_shared_port_setup(struct dsa_port *dp)
 			 dp->index);
 	}
 
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			goto unregister_link;
+	}
+
 	err = dsa_port_enable(dp, NULL);
-	if (err && link_registered)
+	if (err)
+		goto port_teardown;
+
+	return 0;
+
+port_teardown:
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
+unregister_link:
+	if (link_registered)
 		dsa_shared_port_link_unregister_of(dp);
 
 	return err;
@@ -499,23 +527,50 @@ static int dsa_shared_port_setup(struct dsa_port *dp)
 
 static void dsa_shared_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
 	dsa_port_disable(dp);
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
 	if (dp->dn)
 		dsa_shared_port_link_unregister_of(dp);
 }
 
 static int dsa_user_port_setup(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+	int err;
+
 	of_get_mac_address(dp->dn, dp->mac);
 
-	return dsa_user_create(dp);
+	err = dsa_user_create(dp);
+	if (err)
+		return err;
+
+	if (ds->ops->port_setup) {
+		err = ds->ops->port_setup(ds, dp->index);
+		if (err)
+			goto user_destroy;
+	}
+
+	return 0;
+
+user_destroy:
+	dsa_user_destroy(dp->user);
+	dp->user = NULL;
+	return err;
 }
 
 static void dsa_user_port_teardown(struct dsa_port *dp)
 {
+	struct dsa_switch *ds = dp->ds;
+
 	if (!dp->user)
 		return;
 
+	if (ds->ops->port_teardown)
+		ds->ops->port_teardown(ds, dp->index);
+
 	dsa_user_destroy(dp->user);
 	dp->user = NULL;
 }

-- 
2.43.0


