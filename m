Return-Path: <netdev+bounces-100529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C243E8FB01E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D39E1F21EF8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0DA146A97;
	Tue,  4 Jun 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZzaP3Lcm"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DB146A69;
	Tue,  4 Jun 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497620; cv=none; b=u/4xHczaDzIyELJQg5lkK1KUSwY4ZJnhVudKr+o4JNPIfzO6zZqmmnoAw9xK2ypWNjG30YzQemPyXXOcOrbDLIhiEoz0WKv5fa0OYj2bHZ0/n4RwbkSjQ/PG9FslSw41njG8sP08/cbomxKPZb3tHk6thAKmcxXPrMEXg4hRVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497620; c=relaxed/simple;
	bh=7yhAM6xH9kCUFSvDoP+AEJuCocl7K81S23eYIiV8v30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHqbUCc6PJSzrD7GyPtC75kR2HdPK43Ii+pxl26LU6xihs6fIUYNNHHqrMVxzOiYbhToxCYkKeCKrBjFp5lsd0StCn1xSiduPNJitbhbYQhZvhHTStG8WKo+mxxeTuXdUVLTuTwWeUfH4JE/RxpjRuLdhGqJ8anpFfJ4dXgDu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZzaP3Lcm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7C1E1BF206;
	Tue,  4 Jun 2024 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXhuPfMb8JiYCutfiZUlVCVpb7e9NN3nMxofwfDJxZk=;
	b=ZzaP3Lcmxfjr7gJhZb177k5Y113ChXkBQ6BsTHc5/mDKEwA9VsQceBsETOSlwdVU7bTf6G
	fw4+IfFJOuc44mavp3dnWonWdLE3+W9kkDA71ZzQUy+EyoB2VpwKVRcO4eBi+JHxgDFsVN
	s3c2CQswspGboYg1XcnEEHWTszSKK8eKIo2WfUK0KbVVksjLwl8x7uc+mgfHk6jgwYML3N
	7WZN8xx3kJ6C2NPwvSkkUkVAyBwfzsHvV6TF7Hi/e5O97j2zpCebsvF5KHOAU63Fq0M7Tg
	6mc5nSpgi1WAGWXv2yCaVhkF+2RfXypOQtudao7dwsljQrrz6Ufx5trpZsJovQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:39:45 +0200
Subject: [PATCH net-next v14 10/14] net: netdevsim: ptp_mock: Convert to
 netdev_ptp_clock_register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-10-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

The hardware registration clock for net device is now using
netdev_ptp_clock_register to save the net_device pointer within the PTP
clock xarray. netdevsim is registering its ptp through the mock driver.
It is the only driver using the mock driver to register a ptp clock.
Convert the mock driver to the new API.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v8:
- New patch
---
 drivers/net/netdevsim/netdev.c | 19 +++++++++++--------
 drivers/ptp/ptp_mock.c         |  4 ++--
 include/linux/ptp_mock.h       |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c22897bf5509..51ba5e75740e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -662,17 +662,12 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	struct mock_phc *phc;
 	int err;
 
-	phc = mock_phc_create(&ns->nsim_bus_dev->dev);
-	if (IS_ERR(phc))
-		return PTR_ERR(phc);
-
-	ns->phc = phc;
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
-		goto err_phc_destroy;
+		return err;
 
 	rtnl_lock();
 	err = nsim_queue_init(ns);
@@ -690,8 +685,18 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	phc = mock_phc_create(ns->netdev);
+	if (IS_ERR(phc)) {
+		err = PTR_ERR(phc);
+		goto err_register_netdevice;
+	}
+
+	ns->phc = phc;
 	return 0;
 
+err_register_netdevice:
+	unregister_netdevice(ns->netdev);
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
@@ -701,8 +706,6 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 err_utn_destroy:
 	rtnl_unlock();
 	nsim_udp_tunnels_info_destroy(ns->netdev);
-err_phc_destroy:
-	mock_phc_destroy(ns->phc);
 	return err;
 }
 
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index e7b459c846a2..1dcbe7426746 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -115,7 +115,7 @@ int mock_phc_index(struct mock_phc *phc)
 }
 EXPORT_SYMBOL_GPL(mock_phc_index);
 
-struct mock_phc *mock_phc_create(struct device *dev)
+struct mock_phc *mock_phc_create(struct net_device *dev)
 {
 	struct mock_phc *phc;
 	int err;
@@ -147,7 +147,7 @@ struct mock_phc *mock_phc_create(struct device *dev)
 	spin_lock_init(&phc->lock);
 	timecounter_init(&phc->tc, &phc->cc, 0);
 
-	phc->clock = ptp_clock_register(&phc->info, dev);
+	phc->clock = netdev_ptp_clock_register(&phc->info, dev);
 	if (IS_ERR(phc->clock)) {
 		err = PTR_ERR(phc->clock);
 		goto out_free_phc;
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
index 72eb401034d9..e226011071f8 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -13,13 +13,13 @@ struct mock_phc;
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK_MOCK)
 
-struct mock_phc *mock_phc_create(struct device *dev);
+struct mock_phc *mock_phc_create(struct net_device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
 
 #else
 
-static inline struct mock_phc *mock_phc_create(struct device *dev)
+static inline struct mock_phc *mock_phc_create(struct net_device *dev)
 {
 	return NULL;
 }

-- 
2.34.1


