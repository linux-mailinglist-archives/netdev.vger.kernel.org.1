Return-Path: <netdev+bounces-122701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A49623F6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016A81C212C2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B616BE06;
	Wed, 28 Aug 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Np/rB1hR"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F082167DB8;
	Wed, 28 Aug 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838675; cv=none; b=U9z56X4NnHjkpIV9zH3p/CHNEOzRJym1hpTwXG0sH6cphP/EE4p1GyYGm/xZ83iX09+VED09g8vejWVTLW2GwM1Ip4H930taej3kI8JH+Mw9LHy1+5KL1nW4ZCQ/Si5PmhCnHJscHxLpl53Gf6Tno4aYCpvHfWaUBX+hn9C2wDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838675; c=relaxed/simple;
	bh=7f7JaOIlOH1iSomitE/j6mpEL/ydcPQUth2PnpFZGAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ0cBB3OuKuVxjLXatAsjRJazp6+gPtrlnAE1asgNzT0rOJoa1TDqwC1Dh8gCuWazaeuqwd2kkJWga1wFWci9pRAMOEtfC6QbKQTB08TpB6+/7lASnDCaAWuWAaqxESvarLes/ZtfPzuCcTB/FTuwbke4lV5m4L49kZKL6Xbn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Np/rB1hR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E78A81C000A;
	Wed, 28 Aug 2024 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724838671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOqxHOunZthc42y0BkXMB3O7jdtqqFooDociJletkPA=;
	b=Np/rB1hRLIMhEltBoJZCPFzIpIC655en36TGn0Y80SOoPNYAGvBVCsZMel8EaB6icKoZ4K
	IVqy6JAXDDzfulksg/dO6N7lro1FLXwZCPRcilIUEULHwwXMk/H3Rs63AceLmLMKkDUwSs
	DL0ZTzCPNxOOlIImBjDNOxPp9ZiYoe0JFm+B01OWIhcTZ7VYk3FbdfVcshp2di1yn1rUAM
	40bOxRWLZpZDgclrXBZYDbJFyhJIHBM+KHk4ZQ/7yZTH/KLEoaq/QTZ0LECYl9tXeLOXVc
	QFs3ttkmUc4IlIFHGCVoB/mkOcNmBB/kM8VOqQOfdkmWR86yH1KHdswBd/KJWA==
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
Subject: [PATCH net-next 4/6] net: ethernet: fs_enet: drop unused phy_info and mii_if_info
Date: Wed, 28 Aug 2024 11:51:00 +0200
Message-ID: <20240828095103.132625-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

There's no user of the struct phy_info, the 'phy' field and the
mii_if_info in the fs_enet driver, probably dating back when phylib
wasn't as widely used.  Drop these from the driver code.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index abe4dc97e52a..781f506c933c 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -92,14 +92,6 @@ struct fs_ops {
 	void (*tx_restart)(struct net_device *dev);
 };
 
-struct phy_info {
-	unsigned int id;
-	const char *name;
-	void (*startup) (struct net_device * dev);
-	void (*shutdown) (struct net_device * dev);
-	void (*ack_int) (struct net_device * dev);
-};
-
 /* The FEC stores dest/src/type, data, and checksum for receive packets.
  */
 #define MAX_MTU 1508		/* Allow fullsized pppoe packets over VLAN */
@@ -153,10 +145,7 @@ struct fs_enet_private {
 	cbd_t __iomem *cur_rx;
 	cbd_t __iomem *cur_tx;
 	int tx_free;
-	const struct phy_info *phy;
 	u32 msg_enable;
-	struct mii_if_info mii_if;
-	unsigned int last_mii_status;
 	int interrupt;
 
 	int oldduplex, oldspeed, oldlink;	/* current settings */
-- 
2.45.2


