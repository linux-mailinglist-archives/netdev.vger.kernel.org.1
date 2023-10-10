Return-Path: <netdev+bounces-39632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0247C0325
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC411C20911
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFB225BF;
	Tue, 10 Oct 2023 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM+XBNgZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD4225B6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93883C433C7;
	Tue, 10 Oct 2023 18:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696961126;
	bh=wJRIjhOfy7nEd+btMkTXq9qwE2P1o6E+/n4leHnp4/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VM+XBNgZGArlEQnwrUTaqUIHYfAh7BvQvRyTHh4pH3qoP7R4r8aqWSji0UNbAc4rn
	 y00qEbAWaBsQ7XCTFGGcw10+mp3DuymN4PrjmydQ/lrDIs+8l89DSftUxeP7cvjsa6
	 kcn18dLlqva4z5B5ALFKHBhvlc6XhliU8MN+L/9P+mXAOsYWEq9Hh4TbnjnePsLt89
	 pmnuKRetPii/mIJij0QSJaZc4oEJNpxU5tf4p+Nlp528QqVcW2dcccqhcMmBGNSN5u
	 w8wNKXp+U4/t5t+EZ4m1cHjMkzf7jcvBd7kjE4Tke1cmhNVE+1rf/KuKDwlqoNw+HH
	 DtLmg4yWlYqUg==
Date: Tue, 10 Oct 2023 20:05:22 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH v2] net: dsa: bcm_sf2: Fix possible memory leak in
 bcm_sf2_mdio_register()
Message-ID: <20231010180522.GB1003866@kernel.org>
References: <20231009083906.1212900-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009083906.1212900-1-ruanjinjie@huawei.com>

On Mon, Oct 09, 2023 at 04:39:06PM +0800, Jinjie Ruan wrote:
> In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
> to increment reference count for priv->master_mii_bus->dev if
> of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
> fails, it will call get_device() twice without decrement reference count
> for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
> fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
> reference count has not decremented to zero, the dev related resource will
> not be freed.
> 
> So remove the get_device() in bcm_sf2_mdio_register(), and call
> put_device() if mdiobus_alloc() or mdiobus_register() fails and in
> bcm_sf2_mdio_unregister() to solve the issue.
> 
> Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hi Jinjie Ruan,

I agree with your analysis here, but I wonder if it would be nicer
to move bcm_sf2_mdio_register() to a more idiomatic way of unwinding
from errors.

Something like this (compile tested only!)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0b62bd78ac50..037ce118ee00 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -617,8 +617,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
 	priv->master_mii_bus = of_mdio_find_bus(dn);
 	if (!priv->master_mii_bus) {
-		of_node_put(dn);
-		return -EPROBE_DEFER;
+		err = -EPROBE_DEFER;
+		goto err_of_node_put;
 	}
 
 	get_device(&priv->master_mii_bus->dev);
@@ -626,8 +626,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
-		of_node_put(dn);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_put_master_mii_bus_device;
 	}
 
 	priv->slave_mii_bus->priv = priv;
@@ -684,12 +684,18 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
 
 	return err;
+
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_device:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
+	return err;
 }
 
 static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)

