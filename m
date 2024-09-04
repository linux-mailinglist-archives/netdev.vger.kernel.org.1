Return-Path: <netdev+bounces-125215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EF96C522
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DE4B23DF4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D73A1E0B69;
	Wed,  4 Sep 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="buReFsYY"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358345EE8D;
	Wed,  4 Sep 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470310; cv=none; b=PaMm//psIGM15zXKF4tx/203xBGw7u223Uj3Zao+8FwnZAwle3XijzEC7HarbF/IB0mzBJH6FBnH5A8rC/XJkYh2Z9MyZDY4VGfX5tCNjetdMyUNYFkLcxCFf6+d6qR25+bxpZUGzktLJyeNi5ztQ2F6p6+iJ9KeEd+V0/oXdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470310; c=relaxed/simple;
	bh=kLZrZSd7nWzg8+ygzMJgOJWXBCdS8EvYZ3SZDBnwit4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5DLI2dIgxLeyGKu4bd3cqDn8K+Ukn+nJoCJ0o+lHDnZMBGicpL/Uo2GDcANqgSpSrnuwLMZMJUrDnTFE44gBGF0BMjCONHklotp6c8gxkjnRpn41htYL69B8b88iqW0UldVfDVtJ/BSZATaOT4ajEIguiVNsoMPNn4MDnr+FNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=buReFsYY; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B74D41BF206;
	Wed,  4 Sep 2024 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itWlvP5P5XgxiQ6iKEXH6a9ldcid6vjBdW4WsWfjArY=;
	b=buReFsYYQE5lqUkBGnRWK0lIoCrccS34ioCzRcaYWEiPvr92+nD5Yp90tR14QbftUfsji2
	/WGOw4FeVMnZmPXwxDCP7YyTItBN1CggaldEXiryAuoCTTupTXITjTS09hFySOsnH9XhNB
	FXK+ZHC4cIlhmyXSZcIz2Pi6/fgc1whNjitP8XIb/Ux8+DqUQTnCy++Hdbj7pNMZ7QkmjZ
	NlliFLC3GK688vmUaGKF68QMEE41guqIuRabYIWVR/NMkC/fuMifZyQZ9X6Sb3+udQ5jks
	icZ3XNCPzHduCTUddUJFoptYffj8aDjO8ikqkKyyfTFhaaE3FIfb0uNvbk5wNw==
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
Subject: [PATCH net-next v3 1/8] net: ethernet: fs_enet: convert to SPDX
Date: Wed,  4 Sep 2024 19:18:14 +0200
Message-ID: <20240904171822.64652-2-maxime.chevallier@bootlin.com>
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

The ENET driver has SPDX tags in the header files, but they were missing
in the C files. Change the licence information to SPDX format.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
2.46.0


