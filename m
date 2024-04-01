Return-Path: <netdev+bounces-83752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626A893B83
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B3C1F221AA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3E3F9CE;
	Mon,  1 Apr 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nb8UZxak"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D413FB31
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978573; cv=none; b=sidcAAp+fxIje4apUW/ugIFOP0/Fnlr2N+Irk4CtP/IQstAz0/opmHCo2QpNMKtv/eg+JjGaU60EiBtxCjtfHvZ6WmAuzGQMFiOMY+aK+VODTJgPUSbiK3KtfA2vyDMPzREojGmqC1o8rPubO/Ldga2yy9avrjnp39xlphH2X+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978573; c=relaxed/simple;
	bh=Wv5Au3GN6EVOwYEscSwkEYCzUl3gsdXhrVkJvQGNGts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkHrv9Asn8Kz5EIM1TMcInv+Tqd3BM2SNZo8dIyx2yFS/HpbU30qSQIjFf0NYjG/rseSKN77gwOouz0BXnV27WXVHngkJteJM9T8s4YbMfT8VLEk/ksYcBTz7sdQEXgrpHhgRZi2C+n3EaiMKa0yyE2LkMBpNUnC0K+ILc2K6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nb8UZxak; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jG9hkeqPqADNNiDfJeyzLij7rhDH+uXL633QTYLkMWQ=; b=Nb
	8UZxake59ybMAmUtWy4QEAnhza3CHerw2mzU6nFLocI6fBErwpZfMUuQh5HCRet8nQRxGalmSBEwm
	cc5Fk/E7i+LgDZVqQCncpkT/O4U87H9sy6nrm7AIpufKi0AWNV5Egwi+y/HLqfDhxyBgKWVWRJTdN
	mmifsEloYZoHYgE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpY-00BrFx-1n; Mon, 01 Apr 2024 15:36:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:46 -0500
Subject: [PATCH net-next v3 1/7] dsa: move call to driver port_setup after
 creation of netdev.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-1-221b3fa55f78@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Wv5Au3GN6EVOwYEscSwkEYCzUl3gsdXhrVkJvQGNGts=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhAO8i3xFEIWgBnzXqyFDje+fuI+n+uAFmvn
 UgI9nFM2NqJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QAAKCRDmvw3LpmlM
 hJteD/94lFZ0ixLpZwz1i6STzRcjw/UQuGiDTf95TGgWryHtDKjBy3qbrjcYG/HDWYLPwBpiwzv
 tm9Ec20ujY2iTu707avm6YLE+wbJbERIRZ3xF9CPy3Jbjh5uVSSL6OPTUP/lWOmQ41COTnfJtRI
 hy1lzo+5zl/gJxL2x+tqDwRiI4duUBsza442W5Wcq5SiIk+sSXJU+nZjTO8yqJPU6Q27Be+XlXR
 l/MpZtHjNV8fsjhJpzB1l0DlQVxqdkDUk+jWjXUbUWwvTvFvj7LtmPDBI92O6EmaRV8tngz557g
 WjFbdMGPYvCrRTtrzpVeIR63l1Iskk1KkP/HWNJi8fwNyyXKBaGvaTy7WHWK/wNjmPFlsjOJRUH
 ue4FFpZB7p4aMOChszWdNa84B+Vnfy6Ef+AMjBRx/q6mCE8uR0DUa1+lV2AvEMoMevmPau2qWg0
 NWcskDLnQ5y4xpz6LsNFikTwLUr3eiRocqz/uUI0lSk/PB5ggpz6rHW2TM/BmsD7KUcjH8b5t6b
 OKTwvSwQpgEEF713ClLzHKOz375Nnda6fPR9ByZr1PHH77Kk+51VnWhPdU2yR++CB6wXfFobxks
 j9a/tFATxhXAgUWA66hDFCjzupXRDVXUHGQAb3RHzins4UB4UDUk11OWZq24FxEY+p1K4HswfCI
 6TMEnU6tFHlhL8w==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The drivers call port_setup() is a good place to add the LEDs of a
port to the netdev representing the port. However, when port_setup()
is called in dsa_port_devlink_setup() the netdev does not exist
yet. That only happens in dsa_user_create() which is latter in
dsa_port_setup().

Move the call to port_setup() out of dsa_port_devlink_setup() and to
the end of dsa_port_setup() where the netdev will exist.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/devlink.c | 17 +----------------
 net/dsa/dsa.c     |  3 +++
 2 files changed, 4 insertions(+), 16 deletions(-)

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
index 09d2f5d4b3dd..6ffee2a7de94 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -520,6 +520,9 @@ static int dsa_port_setup(struct dsa_port *dp)
 		break;
 	}
 
+	if (ds->ops->port_setup)
+		err = ds->ops->port_setup(ds, dp->index);
+
 	if (err && dsa_port_enabled)
 		dsa_port_disable(dp);
 	if (err && dsa_port_link_registered)

-- 
2.43.0


