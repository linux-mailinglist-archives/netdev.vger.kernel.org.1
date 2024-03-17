Return-Path: <netdev+bounces-80275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7887E078
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48131C215F4
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82FC20B35;
	Sun, 17 Mar 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WRhpvq9Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A511F945
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711951; cv=none; b=d0ANIOsE0NmpnQia5aHIPZKBCY/iYzvxwlZiGZf1bUMIGnfaIeXivrUkjlgwi4gyNRUCNKSsIJ+Ih88r+uzl8+Mn8OldQ3qR2/9DhTxB/GPG0t+Zv5xckz4eybHFa71ixPkJLJuPbK2V+C8QnN7+ULWE5cTsa46o7eKHphwsK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711951; c=relaxed/simple;
	bh=Wv5Au3GN6EVOwYEscSwkEYCzUl3gsdXhrVkJvQGNGts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMvS56GaMX2pIMFHhNFTSbzp8foH0sT+3Ma8PUoCFgIyqlA/Vlc1aSDoJIbyopwmTs+QJMuOhXwIFVE5PM7cKmcMzL6LXYG/SjXp//xtzekSv+9O2QJ/Bv2vbuiQSZwNV3ByELGnI/NgQxaQPCDoSYQml7YiWcITBJf0S4MiAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WRhpvq9Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jG9hkeqPqADNNiDfJeyzLij7rhDH+uXL633QTYLkMWQ=; b=WR
	hpvq9YOGDtEAbvyOcGAmWaEsDQZOaNShq/v1IMeDrxgCMoTIOaTVtZJGWnbob3c4TC3dOy1gVexX1
	Xj+EOwNo6Ict3+YDOvuVPcC349T+XXXkw3R6G2xOFxtQan6a5wRkGG6aMndaIGikb2mbJz8X3NsJe
	YALOxW5C+1z35gc=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyK8-00AYv5-GF; Sun, 17 Mar 2024 22:45:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 17 Mar 2024 16:45:14 -0500
Subject: [PATCH RFC 1/7] dsa: move call to driver port_setup after creation
 of netdev.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-1-80a4e6c6293e@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Wv5Au3GN6EVOwYEscSwkEYCzUl3gsdXhrVkJvQGNGts=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92SAN9kg7BkXHi4UwWjqmi+RzkaRKz7ZpMJJg
 FOEufWeUy6JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkgAAKCRDmvw3LpmlM
 hHChEACfmtL7Ebv1Bi6HxBCyRR7bWhq5e0HRz7RdGp8qbdzog7nhwgK99fV4RnMSxbCiE/7k2MR
 us6Wrvwol/Z/aBspvBlXzndSjidlN9+q5DmhWtpXrzefK1906NaHxREhvLHcUIpjg3bK7Vtgn2R
 Jtxu6zvF7Yy7KeEs/yNQpy9dVISJUh6mk3emZwg99GEOpTZIDWIBrgvQ3Tl/o/UUAUpZQ6g/NIj
 Ss6cKfa74+l8Na5lLSyE9IrhFzGRxP0/XhM6U6bCCUuolLI1VB9Mq1XgZiNFxELXtIGN4i3+/M3
 X7tO8nbenR4GFBE1/NvYul60QdLCI1T8iTYWuRQouhsc6OoMioP3zzpZKJtY2GkLUsAuAX5lgVn
 tsyG1CS4wBLVhmWmpzAiMy0XZhO4vjJH6dQMCltg/Hg9j5a8WcItj9uiu9wdnhtxaiuP4ZZo0Ga
 B3rP7/ooXMJXe9pmyaz6aLHWM/k0KSCdPVqZ7MmJAcP+LfF7iwZ5mX/7jftLM/SD4SAehnz9SLp
 CgGsMiWXVpjBjr9fU3yRysg5g8MCe1QVsu6vTsftjOYO2vaXjH1dwcVetlHK/1gkmUjeHHgeOk4
 eopDvgF2mSV+D7UqMOORmY5mdgsP9wXHdSN6AyJ/8ZsRJiMtbAvUKlyS75NK65WDQItqS9xu6Ze
 ZYAqW0N547p5igg==
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


