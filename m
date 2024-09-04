Return-Path: <netdev+bounces-125218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26C96C52F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0EB24C08
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008CB1E1A3C;
	Wed,  4 Sep 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FbRiGVxp"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B031DC733;
	Wed,  4 Sep 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470312; cv=none; b=lsDSplYfyh/Ybk+Kl4hWFDDD8vT1VrUVenvhxK9LVdqClCGDxMgUKOwOoOVHSpD9n57ZCebFj3qAEwsAVE5kpbIpK2+C3JZ+Mbn74iKjLRKWwMGpWEDZ0xPsDci1IP1lh5gPSdPny28ilHIL6Fgo5ctLpU04aLfHLyU0NpyNrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470312; c=relaxed/simple;
	bh=zex7A6t+LdNkRu5ec+ZmyIysFlbAuizCCvDfw+YVhMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWNqIgSS4Au0pFaUOlSXXEvc9PhY2v67+M7wjglBHwUvOy6Yl4YtT7lGcdFBXxI46ziUF04Qh2jnyubDn6fQiaR1+Bc6PxtS9a10JqRv+7ssFOJ9mgvXaX7kG2R541f0uwnA5XckfvOL4qdnKlA1/vNfyx1qGlD8QaPEFcD7q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FbRiGVxp; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3111A1BF203;
	Wed,  4 Sep 2024 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi/2j6epi1DgRRp0ubkSToTbKTHn7XZyH1dUXV/WNsI=;
	b=FbRiGVxpjPae3eW0/kOH4zJOBcCMHI5RSz4kVAShkxChU4ba+zclaC9ZxrVOYUWR+4Qb0g
	S7l08fY7T/r/6SpdIbPD0JQVIAISlC3BcquEgGW/6u0Pa9kJyn6cnFPSuXw8gSFlmGl8qX
	G6K1wbwFx8bM8wN9G/BbIOVNEVBzjD/2pn+xFfCnyW8fk4Z4q4M5kuMG9bwznlOq9v594C
	FZBG6+qYSN5ISxStT01N39066J+LXYTfqAOYmzm1b7+dt/T15A/ChWL1a3pI7sTy1Q+7Os
	pgN7keaGwN//FhiRixE4RpnF6VgQboLzk1k1KYVs5nBbNyezdkaVDbAEEY4nUA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 4/8] net: ethernet: fs_enet: only protect the .restart() call in .adjust_link
Date: Wed,  4 Sep 2024 19:18:17 +0200
Message-ID: <20240904171822.64652-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When .adjust_link() gets called, it runs in thread context, with the
phydev->lock held. We only need to protect the fep->fecp/fccp/sccp
register that are accessed within the .restart() function from
concurrent access from the interrupts.

These registers are being protected by the fep->lock spinlock, so we can
move the spinlock protection around the .restart() call instead of the
entire adjust_link() call. By doing so, we can simplify further the
.adjust_link() callback and avoid the intermediate helper.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/freescale/fs_enet/fs_enet-main.c  | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index caca81b3ccb6..b320e55dcb81 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -607,10 +607,11 @@ static void fs_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 /* generic link-change handler - should be sufficient for most cases */
-static void generic_adjust_link(struct  net_device *dev)
+static void fs_adjust_link(struct  net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
+	unsigned long flags;
 	int new_state = 0;
 
 	if (phydev->link) {
@@ -630,8 +631,11 @@ static void generic_adjust_link(struct  net_device *dev)
 			fep->oldlink = 1;
 		}
 
-		if (new_state)
+		if (new_state) {
+			spin_lock_irqsave(&fep->lock, flags);
 			fep->ops->restart(dev);
+			spin_unlock_irqrestore(&fep->lock, flags);
+		}
 	} else if (fep->oldlink) {
 		new_state = 1;
 		fep->oldlink = 0;
@@ -643,16 +647,6 @@ static void generic_adjust_link(struct  net_device *dev)
 		phy_print_status(phydev);
 }
 
-static void fs_adjust_link(struct net_device *dev)
-{
-	struct fs_enet_private *fep = netdev_priv(dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(&fep->lock, flags);
-	generic_adjust_link(dev);
-	spin_unlock_irqrestore(&fep->lock, flags);
-}
-
 static int fs_init_phy(struct net_device *dev)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-- 
2.46.0


