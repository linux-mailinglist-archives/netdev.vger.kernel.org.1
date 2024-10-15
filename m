Return-Path: <netdev+bounces-135426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53699DDE9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69684B21BB8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA200185936;
	Tue, 15 Oct 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="C0oaSeM5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B72AD00;
	Tue, 15 Oct 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972245; cv=none; b=QojSfI9rujb4Ij9E0bkLE1NRM7kazFbxnDrJhIRqffOzdu0fcQ5MY3BDUNgjNfhsVeQ3dSZWgBzwUfHNiw8PNg+IPQDzh3nABHqO+0/sxqvBaw5hkp2TbIGtTL8vftD4KWm9b3jhcwBTO/w1kCRT/+X5CqGV6azasjdH5ezH9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972245; c=relaxed/simple;
	bh=sJCB1sVCo7h+hJMurWNTUZO2lGF33iaTwyvPQ5lU9mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4ejZDdv5j3VUgfAio8EK1YqiMoimhTTIjedhsPtZ4ruV8+ESc0iwQkdElpIUBWr9egoBYkMjWwIAWfcJhQNyuYhP4WIy/BEzh0zQ0N7MO0N6ayXkPD98MVuEpedIA1Ey4giMn7tsviEZkSYS4SZCqEbNjLgLPQTX1t/Mid9xjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=C0oaSeM5; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 90F52100003;
	Tue, 15 Oct 2024 09:03:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1728972226; bh=AE7fY2zWoa1DLTMmoszQOugsxyMv9/IkDR2L061DiNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=C0oaSeM5mPiN+46UCQZk7dbaqo1gEdfFHwRMcvzXoLhPD+crtzrX81+iWjBf7oXyi
	 nkT49A47KnqlIQ+rqtzpwmfopSdQWulVGIQepXHslNmSMGrBKa1wOOiTxJtgTCEHic
	 jqubEFPhHw/F/g9BOf/Up+z7is3Mqf5JwLkW4DZy1sseHbyEX57wYMbV+qBhIn41H3
	 Ec8GDi71ScsOvbj8enHmj8xB8h+z9K1EUOiw1IdjrHNz6P9f4FVT6odNNyZrP2sCYl
	 HD9q3ETx8PbZLf6EXtoPa8nfxj9vxpRU1f+iKXQ5L7xiU2VIR8n0D4GOQAVjp6cuo5
	 wdDIBlEMOntLw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 15 Oct 2024 09:02:39 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 09:01:44 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Simon Horman <horms@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson
	<sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net 1/2] fsl/fman: Save device references taken in mac_probe()
Date: Tue, 15 Oct 2024 09:01:21 +0300
Message-ID: <20241015060122.25709-2-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241015060122.25709-1-amishin@t-argos.ru>
References: <20241015060122.25709-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188432 [Oct 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/15 05:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/15 02:26:00 #26754966
X-KSMG-AntiVirus-Status: Clean, skipped

In mac_probe() there are calls to of_find_device_by_node() which takes
references to of_dev->dev. These references are not saved and not released
later on error path in mac_probe() and in mac_remove().

Add new fields into mac_device structure to save references taken for
future use in mac_probe() and mac_remove().

This is a preparation for further reference leaks fix.

Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/freescale/fman/mac.c | 6 ++++--
 drivers/net/ethernet/freescale/fman/mac.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9767586b4eb3..9b863db0bf08 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -197,6 +197,7 @@ static int mac_probe(struct platform_device *_of_dev)
 		err = -EINVAL;
 		goto _return_of_node_put;
 	}
+	mac_dev->fman_dev = &of_dev->dev;
 
 	/* Get the FMan cell-index */
 	err = of_property_read_u32(dev_node, "cell-index", &val);
@@ -208,7 +209,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	/* cell-index 0 => FMan id 1 */
 	fman_id = (u8)(val + 1);
 
-	priv->fman = fman_bind(&of_dev->dev);
+	priv->fman = fman_bind(mac_dev->fman_dev);
 	if (!priv->fman) {
 		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
 		err = -ENODEV;
@@ -284,8 +285,9 @@ static int mac_probe(struct platform_device *_of_dev)
 			err = -EINVAL;
 			goto _return_of_node_put;
 		}
+		mac_dev->fman_port_devs[i] = &of_dev->dev;
 
-		mac_dev->port[i] = fman_port_bind(&of_dev->dev);
+		mac_dev->port[i] = fman_port_bind(mac_dev->fman_port_devs[i]);
 		if (!mac_dev->port[i]) {
 			dev_err(dev, "dev_get_drvdata(%pOF) failed\n",
 				dev_node);
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index fe747915cc73..8b5b43d50f8e 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -19,12 +19,13 @@
 struct fman_mac;
 struct mac_priv_s;
 
+#define PORT_NUM 2
 struct mac_device {
 	void __iomem		*vaddr;
 	struct device		*dev;
 	struct resource		*res;
 	u8			 addr[ETH_ALEN];
-	struct fman_port	*port[2];
+	struct fman_port	*port[PORT_NUM];
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	phy_interface_t		phy_if;
@@ -52,6 +53,9 @@ struct mac_device {
 
 	struct fman_mac		*fman_mac;
 	struct mac_priv_s	*priv;
+
+	struct device		*fman_dev;
+	struct device		*fman_port_devs[PORT_NUM];
 };
 
 static inline struct mac_device
-- 
2.30.2


