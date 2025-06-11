Return-Path: <netdev+bounces-196527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49404AD5285
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125953A4167
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD600283FD9;
	Wed, 11 Jun 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D04ob6H5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91336283FC5;
	Wed, 11 Jun 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638671; cv=none; b=BsYZP6Y9aIbZ2ek4ODWruAfHzH3iT0D+wgzuJJE7/nl5gDQITSAeJ3W9JIxDBA1MmGAMAsjUP2OjSEUP8BQ8U63bx7rLKWLJRlEvnWUN9HblutVg+zQ1sXS69L0Iy98nncSIQgDs5TAS9/mTx/XVM7x0Hmp9AaMYL8tUXeM2NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638671; c=relaxed/simple;
	bh=V6OgO8Xaa9feBzickPcgYFExBJC7VO849/3jpU4fO1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knT25O5w4Dm2nd5zjQFMxVEWcUD0FazaXWDylxVN2kAblw2dAmNuCNjuVI+76kT+nbazR1WASBTf5JLEjEx2SxCOdQ36pfE0Qwfmg+038NhxXcLdJjUPiEHugXaV/IfR2Nkn4HbK2PALz3rXT1pnhTwjPGglawPw7kErAPyM5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D04ob6H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A41AC4CEEE;
	Wed, 11 Jun 2025 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638671;
	bh=V6OgO8Xaa9feBzickPcgYFExBJC7VO849/3jpU4fO1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D04ob6H5kXD+EeJ7WAWyLmjqzK+u1wtrr/kqMyj2fzv0bpHp22CYh+gB8Xo7yVh8+
	 2jPMUxBjZE0FzP/LmJbfJkcIkv5pXpcK858k34eCnWB3Z7NNB+j9T4wBtqdidbb7Ff
	 +qBZZ312RpVxhflVMTYC02H3rLNfS/7Ru4YgHOo1oLHCtP7c1wvE4sQ+1U22g+B0q3
	 zXhRTm1foGMPX32KN6NL/sbeDtxV9eGEcWMuvkjhABUCB3WauYiWqAgWRLihCTWHo2
	 YFXHaq0mwMH2v9DYHFvF/W6YMvo+sfP67EKg4/lPYWNgQXsdz0TAYvsSxHiy6VZzmP
	 FaSfRW1CDOZjg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH] net: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:43 +0200
Message-ID: <20250611104348.192092-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org

---
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Cc: Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/net/dsa/microchip/ksz_common.c | 3 +--
 drivers/net/dsa/microchip/ksz_ptp.c    | 4 ++--
 drivers/net/dsa/mv88e6xxx/global2.c    | 6 ++----
 drivers/net/dsa/qca/ar9331.c           | 4 ++--
 drivers/net/usb/lan78xx.c              | 6 ++----
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7c142c17b3f6..6e1daf0018bc 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2786,8 +2786,7 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	kirq->dev = dev;
 	kirq->masked = ~0;
 
-	kirq->domain = irq_domain_create_simple(of_fwnode_handle(dev->dev->of_node),
-						kirq->nirqs, 0,
+	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev), kirq->nirqs, 0,
 						&ksz_irq_domain_ops, kirq);
 	if (!kirq->domain)
 		return -ENOMEM;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 8ab664e85f13..35fc21b1ee48 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1130,8 +1130,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 	init_completion(&port->tstamp_msg_comp);
 
-	ptpirq->domain = irq_domain_create_linear(of_fwnode_handle(dev->dev->of_node),
-						  ptpirq->nirqs, &ksz_ptp_irq_domain_ops, ptpirq);
+	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
+						  &ksz_ptp_irq_domain_ops, ptpirq);
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index aaf97c1e3167..30a6ffa7817b 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1154,10 +1154,8 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	chip->g2_irq.domain = irq_domain_create_simple(of_fwnode_handle(chip->dev->of_node),
-						       16, 0,
-						       &mv88e6xxx_g2_irq_domain_ops,
-						       chip);
+	chip->g2_irq.domain = irq_domain_create_simple(dev_fwnode(chip->dev), 16, 0,
+						       &mv88e6xxx_g2_irq_domain_ops, chip);
 	if (!chip->g2_irq.domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index 79a29676ca6f..0526aa96146e 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -821,8 +821,8 @@ static int ar9331_sw_irq_init(struct ar9331_sw_priv *priv)
 		return ret;
 	}
 
-	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(np), 1,
-						   &ar9331_sw_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(dev_fwnode(dev), 1, &ar9331_sw_irqdomain_ops,
+						   priv);
 	if (!priv->irqdomain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -EINVAL;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f53e255116ea..391a497bbd20 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2448,10 +2448,8 @@ static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqchip = &lan78xx_irqchip;
 	dev->domain_data.irq_handler = handle_simple_irq;
 
-	irqdomain = irq_domain_create_simple(of_fwnode_handle(dev->udev->dev.parent->of_node),
-					     MAX_INT_EP, 0,
-					     &chip_domain_ops,
-					     &dev->domain_data);
+	irqdomain = irq_domain_create_simple(dev_fwnode(dev->udev->dev.parent), MAX_INT_EP, 0,
+					     &chip_domain_ops, &dev->domain_data);
 	if (irqdomain) {
 		/* create mapping for PHY interrupt */
 		irqmap = irq_create_mapping(irqdomain, INT_EP_PHY);
-- 
2.49.0


