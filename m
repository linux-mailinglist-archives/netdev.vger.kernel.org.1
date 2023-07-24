Return-Path: <netdev+bounces-20548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FC4760107
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C36281398
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19F10979;
	Mon, 24 Jul 2023 21:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E6DDC8;
	Mon, 24 Jul 2023 21:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8777C433C7;
	Mon, 24 Jul 2023 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690233536;
	bh=N4OuHYLYh0XTbs0p57g4iiEmvIO8lb9r0X7HGPxsqFc=;
	h=From:To:Cc:Subject:Date:From;
	b=U3oJkQB3A0WbwrAOyw5CPf94OoZqbYk0mzmN+A42nLJLREQ1i3NoARsoF64EWOEuq
	 ehsrl7m0ICSj8a+12OmMq8RhyoL6tgc8xahROFAu+U5dEgzKica5ms2qBhTXYErOoq
	 EHTgz+ie961FIQNgXbMP4nRByL2eRbWWlZ/8tJ/Q8dPyT3tfDSMTBZLq1exCi8U15R
	 jlUwzNZr36SYyNItvKyVLUyCuaEXQ8Sf5khlqYGZRS1KEAvlssFifRPK2ulT5iMwyy
	 jWGNybvepS1bf5MRqVYjjvKN4y/XoRCQtsdggbhk7SmlGZVUt9kR2TkUQYmsI1Fiz7
	 yLP/h56I8yinw==
Received: (nullmailer pid 805390 invoked by uid 1000);
	Mon, 24 Jul 2023 21:18:54 -0000
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2] can: Explicitly include correct DT includes, part 2
Date: Mon, 24 Jul 2023 15:18:40 -0600
Message-Id: <20230724211841.805053-1-robh@kernel.org>
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
I had the CAN changes in a separate patch, but inadvertently put these
in the 'net' patch.

v2:
 - Split out can, dsa, wireless, phy/pcs to separate patches
---
 drivers/net/can/bxcan.c                    | 1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c      | 1 -
 drivers/net/can/m_can/m_can.c              | 1 -
 drivers/net/can/m_can/m_can.h              | 1 -
 drivers/net/can/rcar/rcar_canfd.c          | 1 -
 drivers/net/can/sja1000/sja1000_platform.c | 1 -
 drivers/net/can/sun4i_can.c                | 1 -
 drivers/net/can/ti_hecc.c                  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index 39de7164bc4e..49cf9682b925 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -23,7 +23,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 1d6642c94f2f..72307297d75e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <linux/can/dev.h>
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c5af92bcc9c9..4e76cd9c02b0 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..267d06ce6ade 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e4d748913439..b82842718735 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -34,7 +34,6 @@
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 4e59952c66d4..33f0e46ab1c2 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "sja1000.h"
 
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..b493a3d8ea9a 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -59,7 +59,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 54284661992e..a8243acde92d 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/can/dev.h>
-- 
2.40.1


