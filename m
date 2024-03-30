Return-Path: <netdev+bounces-83521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D4892C87
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CAE1C2150A
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493181D526;
	Sat, 30 Mar 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="paPcYYd1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E628821
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823557; cv=none; b=NXXcuXp7jrISB4E8z/PcRDxMGlZBjEl0E31g2sk+g0fquwPhAF5hEWrUVkZ4ZWs+T8jr3BjhmsX2IwFcgym6Tsm7rIYqZX9XSzSDo2IJOWyV6oMYwO/PuOsQv4365+wO6XMMpLHg7BzRObWTL+V6vlQuQhSyRLGCat/+rcjgwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823557; c=relaxed/simple;
	bh=Wv5Au3GN6EVOwYEscSwkEYCzUl3gsdXhrVkJvQGNGts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYTWtTY0oWgcpwU2bT2c+o/0qTLAFp2aq6nf0WxMOjrLJiM4pksKOLNjxLM0l+KBSLAD6brIpinKtGlJ1DE2rSvEeNMp56RGDVdt3lKnD7QJXNZYZJGmNg/Icy3ERTE976q+8AnO0LK9/Tmzt7dzbmqvs3VeKyD9gi28SdJSLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=paPcYYd1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jG9hkeqPqADNNiDfJeyzLij7rhDH+uXL633QTYLkMWQ=; b=pa
	PcYYd14E+TCZJ2VCtTceZVxzED7xg6h+nItXPuNe5RNusdIgcKMTryylQ5SwY1wgPkSMXQhAjrmOj
	b4D6EmBEEsgl/z30j1qmeTCWJM2gh7F18104HJ9oRnEuzvNE/KAOOS9H2stKdwg3hM/L5SSOGMiCQ
	KoL7AEB2HLAb6uU=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVE-00Bjfq-Su; Sat, 30 Mar 2024 19:32:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Mar 2024 13:31:58 -0500
Subject: [PATCH net-next v2 1/7] dsa: move call to driver port_setup after
 creation of netdev.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-1-fc5beb9febc5@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
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
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq1890jBRdxdtn1/UzCZY1RiUuJ3ksgar0os
 Ld43sIG5w6JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatQAKCRDmvw3LpmlM
 hEHUD/4qSlTOcdGZHC9Fr331n3fji3CR6ima1Rzr0b2O+/EsJkZ48atshpC0BkFJJURLFRVNDnC
 CxGaCYRP0T6z5iz53izR9FZRR1D5UaKRu/P7ow1XSjXAsd6f7lq1DCDTG4L+jCspOdv8EKtTlMQ
 xcV3Zj6wg9lj5VBYt4J+DHaRDPrrO419mLCij2B+jzIwhnqHCLcHw1DYN5uW/eodjFjn/e1ExK6
 D0vpWNXqq8jPoezgZaTDJyX1GmcMvIIcd1rkPyGC8aMOGveDHYm5NpcDlIwqsUdjLNDQ/31xnQd
 MyXxRAdCukxQVbOPO+mmaxscv1KIF9MkaX4yG+ofXmKCIcXIMHS+HEXvsh0Y3zBLE+xE8s2kfbj
 m+CkoRNsAe9/v4o79lDm8IZVDGnFfmxT+eR9TSz8Dx5+o2NGGhJhRq2xhDG13HKRXBlbDcNC1Ww
 fMsqB3qw0frdgbLMNG8Cu87g+RdAO0XGRdB+x758BMHfOHTlWs/A6NQoIEdkX1m56zaHkvcnXpv
 xP6eY3GEa5jM5j/lLQx4HF3zt5Y2oglehrHEbiNxt9aMfXBJmm8p9rHMx6jAT+gk2iBdM68RCcK
 e2QU2AzltxOgPyGau1rh8vU83kNAdxTL6sWGvV3xtxMRXXFDpW3Jkkv/IqVJwI8WGqiHUI6pcmq
 XjYX2IlAXn4AEnQ==
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


