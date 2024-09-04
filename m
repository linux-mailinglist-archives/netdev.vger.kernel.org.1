Return-Path: <netdev+bounces-125221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB996C53B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A963B22DAB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA31E490D;
	Wed,  4 Sep 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ks76icyj"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6191E1A0C;
	Wed,  4 Sep 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470315; cv=none; b=g6xTFljENEk0QzFE/glSjwk47rWOAaCL/mGyt61fHSy+qnrjiV0ibgGTzBhVI8yKnf4hRnd417JCjyZRCJxy6JDGzm0bEwc/WrjX20gefhVKi+f311yliOe0DuZGhwrnvMTBbGX30h3OQJrBe1q8Hef/1kbu1JPrF48MU1GOY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470315; c=relaxed/simple;
	bh=700LYOARH6vDr2hlt/iPSJDvzdNtL4q07L/FEiekbjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQTgMbw/1E2e1wzovAw5LBeOfDgK5k9Q3LVmSKb6NHLDntZL7E/ekaV83C1mvs3tYRBfeQtRu+iOtk0uya+LUIVhgHaFGIwqJJn2gl6o4dt2AA8jGHy9wCEtQ7i/Ni2T7qCkrzYOoaddSJIMxOJPw7yjzkvgIc7D3AH//FNd7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ks76icyj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF8EF1BF204;
	Wed,  4 Sep 2024 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1v2wNrojZNwAx2VQ+X6lX7XOCpRJVlU3xdY4cZSmMA=;
	b=ks76icyjTpyd6Beh6Lqvvre1JXbuLRbkm5QpB08LMoxxqOFE9PVZksvA3OgIcRNYPRQ1aS
	dFTpKG991urCmud0vUml46D4iYLa/AbX4uoeAiuJK7ttNhTbwpppGACBPvhwCeWuCaFZly
	Jg7gf2gPg6u1b4mHwXvrY/Q8gwGA2riTyjSWQ9jyxmzNahyzTLu7spfKGWaXVowFXAHZxQ
	ZbvG57TnAmpag93JvAcRABqDaEips/6GsUGYOQGHWFQ3T1MUmQ74GDoQOcAQaB04F+L46z
	oJZkGP6wY8Jv0SMyFS0smTl9J8Ta8U9WwleZg8r8bZHp4R5JVdbJddOGfMLf8w==
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
Subject: [PATCH net-next v3 5/8] net: ethernet: fs_enet: drop unused phy_info and mii_if_info
Date: Wed,  4 Sep 2024 19:18:18 +0200
Message-ID: <20240904171822.64652-6-maxime.chevallier@bootlin.com>
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

There's no user of the struct phy_info, the 'phy' field and the
mii_if_info in the fs_enet driver, probably dating back when phylib
wasn't as widely used.  Drop these from the driver code.

As the definition for struct mii_if_info is no longer required, drop the
include for linux/mii.h altogether in the driver.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c    |  1 -
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h     | 12 ------------
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c     |  1 -
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c     |  1 -
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c     |  1 -
 5 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index b320e55dcb81..c96a6b9e1445 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -26,7 +26,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index abe4dc97e52a..ee49749a3202 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -3,7 +3,6 @@
 #define FS_ENET_H
 
 #include <linux/clk.h>
-#include <linux/mii.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
 #include <linux/list.h>
@@ -92,14 +91,6 @@ struct fs_ops {
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
@@ -153,10 +144,7 @@ struct fs_enet_private {
 	cbd_t __iomem *cur_rx;
 	cbd_t __iomem *cur_tx;
 	int tx_free;
-	const struct phy_info *phy;
 	u32 msg_enable;
-	struct mii_if_info mii_if;
-	unsigned int last_mii_status;
 	int interrupt;
 
 	int oldduplex, oldspeed, oldlink;	/* current settings */
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index add062928d99..159a384813b3 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -22,7 +22,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index f75acb3b358f..cf4c49e884ba 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -23,7 +23,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 29ba0048396b..6edc9f66ae83 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -22,7 +22,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
-#include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
 #include <linux/fs.h>
-- 
2.46.0


