Return-Path: <netdev+bounces-122698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729649623F0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C312CB21058
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7297166F31;
	Wed, 28 Aug 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JEl7GRvj"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727311547F2;
	Wed, 28 Aug 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838672; cv=none; b=D6/7dU5mglCOyxLzQ4FoJbocE4RSY3QvYWMg86+nrlFF7YoqSLaQJKRpyOK5fp48ciW4YA7tdjfUVn45PeDQ7/vVDH5AE3Ycc+7Bo/2LdCTVrL0egIU4r8smxGFT72c9jqa0lnMC9XxpBGzme1g83hykc8765smi8SSroHl0XXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838672; c=relaxed/simple;
	bh=myRSXmQDYO54myIfWdViq8cLlDYdqFTEuY1MLlUPvjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs1eKw5q2rHALaaO77AndZoW2lJkBngDCo66mimAneupVxWdeQLspI3tw0ghIe1tHQY7bPF2WyNPhJtZpSB4jDoyYlOKd8ZfM8WIgko0AkqxKhZCTx+7njA7kgzKBHscNA+CkYdmAWdva2GHq7Da2dQU9wxDPU9BD/pBVfHi5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JEl7GRvj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED1BA1C000C;
	Wed, 28 Aug 2024 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724838668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0hzvG0hZsY1WlPlvceV3QEtbLRs4+O1bK+FGJ2ZLwI=;
	b=JEl7GRvjUa6PAT9bOWi3WscuC5JkXQnnLHtPr8TQdtIO0tYY3ZAU0Q4B63Uws4vCGZVgq5
	4LsnJjPGv+dZFrchzehXUHV9/H4O9qdEEBXpDtKf92HC5s+COTlIJrXLu9/bDEPweIahh0
	dBZ2jSFOtjGlbbSi/+5JObsohrcSvW8jA4WZy5xrBy9sHyVcUWHMRYiv2TQm/2CmI4715p
	F2tw7aZVJqtGCwb8ItRCH8CwDevUCq3OlXHB9Sl62x1f/8YF1GZumHejxmEI6cb0jUrYk/
	gt2RMs1nBsBlg6Makm5F+LZ5X0Qn5cdXjcT7Z28yGy0r2JVLA8xp2AjXJPa+Iw==
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
Subject: [PATCH net-next 1/6] net: ethernet: fs_enet: convert to SPDX
Date: Wed, 28 Aug 2024 11:50:57 +0200
Message-ID: <20240828095103.132625-2-maxime.chevallier@bootlin.com>
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

The ENET driver has SPDX tags in the header files, but they were missing
in the C files. Change the licence information to SPDX format.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 5 +----
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c      | 5 +----
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c      | 5 +----
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c      | 5 +----
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c  | 5 +----
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c      | 5 +----
 6 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index cf392faa6105..5bfdd43ffdeb 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
  *
@@ -9,10 +10,6 @@
  *
  * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
  * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index e2ffac9eb2ad..add062928d99 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * FCC driver for Motorola MPC82xx (PQ2).
  *
@@ -6,10 +7,6 @@
  *
  * 2005 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index cdc89d83cf07..f75acb3b358f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Freescale Ethernet controllers
  *
@@ -6,10 +7,6 @@
  *
  * 2005 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 9e89ac2b6ce3..29ba0048396b 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Ethernet on Serial Communications Controller (SCC) driver for Motorola MPC8xx and MPC82xx.
  *
@@ -6,10 +7,6 @@
  *
  * 2005 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index f965a2329055..2e210a003558 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
  *
@@ -6,10 +7,6 @@
  *
  * 2005 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
index 7bb69727952a..93d91e8ad0de 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
  *
@@ -6,10 +7,6 @@
  *
  * 2005 (c) MontaVista Software, Inc.
  * Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/module.h>
-- 
2.45.2


