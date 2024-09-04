Return-Path: <netdev+bounces-125216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159196C528
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549B61C25339
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CC1E1A11;
	Wed,  4 Sep 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZCZNZu2"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20745473E;
	Wed,  4 Sep 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470312; cv=none; b=EDkf0/7a9P6H1iOAC/HG91sH8uBuDAc0gGJGtyFSSrkOaYbmc5wHWqGuataVahONTD8tasDwcrYWTkCGtjxh4SVnYjCLHVlKYo4BvUg0GGQ0bbikPfQbt5DIpspxBu/bYrpUzrANr6xSA8D+Jb5iVTP30uBXA5UiM+5y6ZtJIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470312; c=relaxed/simple;
	bh=3RD4MudhqHb/xy20IqyAMWl0beEws1NkQiGFQMLWdCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDA2MHzfmyMofhAEaINY/vXYn9qr1bMfKRvcYD8PdDMma96un+WLPMW7yMrihBQLR7UjWOHo3s1bnF7sLmCumm0W83bhIFrSfQlwLM6z+oPePJzvKc8AAJz51BeFGcuF/4tYizaOAhfFiBaXMKvpN1KAgHQ1HashBFj3rmKHABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZCZNZu2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D34D1BF209;
	Wed,  4 Sep 2024 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FV/qcbVRZQEWQv+cuiJ0FHX/wU1qKcBWUAGNrbhmHk=;
	b=QZCZNZu2MmQ5+C3IulMS1p8b1ROgFz1XQIY+DtlAhl3mEMB+RZI9LBBoID6o+GIHb8momT
	ozzTfI4m0W9BGsEjt1c+9jcfTXGI+p9dmJPfh9/hh8MnesO3mN/mffUwHV6D5dVVAfBZN1
	jM19DwnCxJvlMxR7u8dBPeoqIh7Tk9KUuzbTnL1NnbANkRCXB2ReeuOwLk5K0p+ALA6PNj
	qQrb7qfUdBFAV3Cwkt6bdCNs4MHdH7kDaWjiPfmkMUlMv1EjzURHfR2eYGvA7uBAcQuEJ6
	lXh5I1N6dNXmkHZ4e70kO0ZsUbkSgXs44pNu7TXCa6pXhX3ZCHGLAIeYT34V/Q==
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
Subject: [PATCH net-next v3 3/8] net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
Date: Wed,  4 Sep 2024 19:18:16 +0200
Message-ID: <20240904171822.64652-4-maxime.chevallier@bootlin.com>
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

There's no in-tree user for the fs_ops .adjust_link() function, so we
can always use the generic one in fe_enet-main.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 7 +------
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h      | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2b48a2a5e32d..caca81b3ccb6 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&fep->lock, flags);
-
-	if (fep->ops->adjust_link)
-		fep->ops->adjust_link(dev);
-	else
-		generic_adjust_link(dev);
-
+	generic_adjust_link(dev);
 	spin_unlock_irqrestore(&fep->lock, flags);
 }
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index 21c07ac05225..abe4dc97e52a 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -77,7 +77,6 @@ struct fs_ops {
 	void (*free_bd)(struct net_device *dev);
 	void (*cleanup_data)(struct net_device *dev);
 	void (*set_multicast_list)(struct net_device *dev);
-	void (*adjust_link)(struct net_device *dev);
 	void (*restart)(struct net_device *dev);
 	void (*stop)(struct net_device *dev);
 	void (*napi_clear_event)(struct net_device *dev);
-- 
2.46.0


