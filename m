Return-Path: <netdev+bounces-13706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7A73CAC0
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB65281C2A
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD74431;
	Sat, 24 Jun 2023 12:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987A7F9
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 12:18:14 +0000 (UTC)
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 05:18:13 PDT
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA502112;
	Sat, 24 Jun 2023 05:18:13 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
	by unicorn.mansr.com (Postfix) with ESMTPS id A640A15360;
	Sat, 24 Jun 2023 13:12:48 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id 99CBA219FD1; Sat, 24 Jun 2023 13:12:48 +0100 (BST)
From: Mans Rullgard <mans@mansr.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Date: Sat, 24 Jun 2023 13:10:59 +0100
Message-ID: <20230624121211.19711-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeroen Hofstee <jhofstee@victronenergy.com>

Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
id to common file") did not only move the code for an am3517, it also
added the slave parameter, resulting in an invalid (all zero) mac address
being returned for an am3517, since it only has a single emac and the slave
parameter is pointing to the second. So simply always read the first and
valid mac-address.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/net/ethernet/ti/cpsw-common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw-common.c b/drivers/net/ethernet/ti/cpsw-common.c
index bfa81bbfce3f..465dc15f059d 100644
--- a/drivers/net/ethernet/ti/cpsw-common.c
+++ b/drivers/net/ethernet/ti/cpsw-common.c
@@ -74,8 +74,12 @@ int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr)
 	if (of_machine_is_compatible("ti,am33xx"))
 		return cpsw_am33xx_cm_get_macid(dev, 0x630, slave, mac_addr);
 
+	/*
+	 * There is only one emac / mac address on an am3517 so ignore the
+	 * slave = 1 and always get the macid from slave 0.
+	 */
 	if (of_device_is_compatible(dev->of_node, "ti,am3517-emac"))
-		return davinci_emac_3517_get_macid(dev, 0x110, slave, mac_addr);
+		return davinci_emac_3517_get_macid(dev, 0x110, 0, mac_addr);
 
 	if (of_device_is_compatible(dev->of_node, "ti,dm816-emac"))
 		return cpsw_am33xx_cm_get_macid(dev, 0x30, slave, mac_addr);
-- 
2.41.0


