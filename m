Return-Path: <netdev+bounces-24676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFA771036
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706522822D0
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCFC14D;
	Sat,  5 Aug 2023 14:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABF1FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 14:45:51 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFD4224;
	Sat,  5 Aug 2023 07:45:50 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qSIXH-0000Ou-2v;
	Sat, 05 Aug 2023 14:45:44 +0000
Date: Sat, 5 Aug 2023 15:45:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
Message-ID: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Different MT7530 variants require different PHY drivers.
Use 'imply' instead of 'select' to relax the dependency on the PHY
driver, and choose the appropriate driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3ed5391bb18d6..f8c1d73b251d0 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -37,7 +37,6 @@ config NET_DSA_LANTIQ_GSWIP
 config NET_DSA_MT7530
 	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"
 	select NET_DSA_TAG_MTK
-	select MEDIATEK_GE_PHY
 	imply NET_DSA_MT7530_MDIO
 	imply NET_DSA_MT7530_MMIO
 	help
@@ -49,6 +48,7 @@ config NET_DSA_MT7530
 config NET_DSA_MT7530_MDIO
 	tristate "MediaTek MT7530 MDIO interface driver"
 	depends on NET_DSA_MT7530
+	imply MEDIATEK_GE_PHY
 	select PCS_MTK_LYNXI
 	help
 	  This enables support for the MediaTek MT7530 and MT7531 switch
@@ -60,6 +60,7 @@ config NET_DSA_MT7530_MMIO
 	tristate "MediaTek MT7530 MMIO interface driver"
 	depends on NET_DSA_MT7530
 	depends on HAS_IOMEM
+	imply MEDIATEK_GE_SOC_PHY
 	help
 	  This enables support for the built-in Ethernet switch found
 	  in the MediaTek MT7988 SoC.
-- 
2.41.0

