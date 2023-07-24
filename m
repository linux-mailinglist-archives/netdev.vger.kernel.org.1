Return-Path: <netdev+bounces-20550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAB6760110
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FF1281396
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7CC1119B;
	Mon, 24 Jul 2023 21:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16411193
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B491C433C7;
	Mon, 24 Jul 2023 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690233553;
	bh=Kj3XfjZcezJ9YNhnOjElUCHift7/ySxvviPokSxuUfw=;
	h=From:To:Cc:Subject:Date:From;
	b=N20CdsGLjqTiQ1aVBymIuJeFt3sAkR8Xs1S7Xrei7URkWIFKMPxKhvZ7JzBAY/tZ6
	 qeTGRI23GVQlJFw1i/SX6IMCz6HlvbNT4Q9ktfo82y4YZRKyIZm7Iz5GBX2naAD0La
	 qhqGFY8QH33p0o4SGOfIRjTR5tUrDGDLgjopTQ44GGbgm+Nb8P/GSwNyCwKtR1YAi+
	 lrDqOHcF6gCnWmjZR66gSRQlh3rrdfLvOzOqozasSXt7W3z6DbqQa8H4kqld8Vcmjy
	 1EAvGj1phm/OfwT+nNWqHbtxEHMUq5UvGv9dZecMisg1azwXg1WCKoqPgkmDGHaCeu
	 BXxlaySrNaymg==
Received: (nullmailer pid 805831 invoked by uid 1000);
	Mon, 24 Jul 2023 21:19:11 -0000
From: Rob Herring <robh@kernel.org>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] net: phy/pcs: Explicitly include correct DT includes
Date: Mon, 24 Jul 2023 15:19:05 -0600
Message-Id: <20230724211905.805665-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Split out can, dsa, wireless, phy/pcs to separate patches
---
 drivers/net/pcs/pcs-rzn1-miic.c   | 1 +
 drivers/net/phy/marvell-88x2222.c | 1 -
 drivers/net/phy/mediatek-ge-soc.c | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 323bec5e57f8..e5d642c67a2c 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -12,6 +12,7 @@
 #include <linux/of_platform.h>
 #include <linux/pcs-rzn1-miic.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <dt-bindings/net/pcs-rzn1-miic.h>
 
diff --git a/drivers/net/phy/marvell-88x2222.c b/drivers/net/phy/marvell-88x2222.c
index f83cae64585d..e3aa30dad2e6 100644
--- a/drivers/net/phy/marvell-88x2222.c
+++ b/drivers/net/phy/marvell-88x2222.c
@@ -14,7 +14,6 @@
 #include <linux/mdio.h>
 #include <linux/marvell_phy.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/sfp.h>
 #include <linux/netdevice.h>
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 95369171a7ba..da512fab0eb0 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -2,8 +2,6 @@
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/phy.h>
 
-- 
2.40.1


