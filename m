Return-Path: <netdev+bounces-135427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDACE99DDEB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E1283698
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC59184101;
	Tue, 15 Oct 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Hetd/m7r"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41913BACC;
	Tue, 15 Oct 2024 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972277; cv=none; b=SkekvXBj0cWyjfvn8o8QPiqbPZbYxdSXNSD+XuD1l9PtmGsWcByMC9DCSVahEVwjjgXQ/Qpa0lV+45IhdEKwc5kk/HZIoOK3++pyN7MYYcBMc8IlhB7a74Frw81gLLpHL+6o9VfPjW8EV0p8XdDWkViVc30jRn7//t6KvTu2gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972277; c=relaxed/simple;
	bh=CpJN/sHxA4ytrD4pz28Sh+cNOl6nZphEhktzDoqU8lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jv6mJR73+iWM8ZuS3w0q5AQeS1ezHC0VYuclQEopMJS7OFAXC5KuYfqXg3BQaMLgXLxRPR4rdBbHHJb5DyEK88YFPpJsOL9OvkgsYOhOOlwPO0YE9rG7RlCuxXvCKd/KRVf0TB1Fglh3oYgu4TUEZIkpBAqhn60DV5YnE0WxWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Hetd/m7r; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 730AD100004;
	Tue, 15 Oct 2024 09:04:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1728972256; bh=go8ir/eHJu44HTUZ3QuhOEIVc9aIDc/2fwuzuUwZc0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Hetd/m7rvKE9W+tpWErf9Kx+ilRb+WCkgh3BQmeaImMK367GP81OB3qffRub6Gam3
	 4uSzJhTRteObpwDj6w1PQnmpn67fKUl0QA3i4KH353hJd5zUag2hKCJXgU19WaTRJV
	 2n2ImYqkn/Rsduo2FheJMzHW3gRoPtKBm+U5yK0xqpZijfn7umQ/uZxBQIsZNF/ws1
	 WYGmYlGTqLQbBNOiA5t1b70QgKdQyreA2d0myp+pIeG6bUvP/TvHIBUMLBG6mgZkM9
	 nRf72GXreqWfWNPKjwCohQWS+votG69wqz/fQNed+Pz8AtxX5JwLvLkwI3LbbyNLpQ
	 +0OTB7WpAVKBQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 15 Oct 2024 09:03:09 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 09:01:45 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Simon Horman <horms@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson
	<sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net 2/2] fsl/fman: Fix refcount handling of fman-related devices
Date: Tue, 15 Oct 2024 09:01:22 +0300
Message-ID: <20241015060122.25709-3-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/15 05:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/15 02:26:00 #26754966
X-KSMG-AntiVirus-Status: Clean, skipped

In mac_probe() there are multiple calls to of_find_device_by_node(),
fman_bind() and fman_port_bind() which takes references to of_dev->dev.
Not all references taken by these calls are released later on error path
in mac_probe() and in mac_remove() which lead to reference leaks.

Add references release.

Fixes: 3933961682a3 ("fsl/fman: Add FMan MAC driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
Compile tested only.

 drivers/net/ethernet/freescale/fman/mac.c | 62 +++++++++++++++++------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9b863db0bf08..11da139082e1 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -204,7 +204,7 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (err) {
 		dev_err(dev, "failed to read cell-index for %pOF\n", dev_node);
 		err = -EINVAL;
-		goto _return_of_node_put;
+		goto _return_dev_put;
 	}
 	/* cell-index 0 => FMan id 1 */
 	fman_id = (u8)(val + 1);
@@ -213,40 +213,51 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (!priv->fman) {
 		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
 		err = -ENODEV;
-		goto _return_of_node_put;
+		goto _return_dev_put;
 	}
 
+	/* Two references have been taken in of_find_device_by_node()
+	 * and fman_bind(). Release one of them here. The second one
+	 * will be released in mac_remove().
+	 */
+	put_device(mac_dev->fman_dev);
 	of_node_put(dev_node);
+	dev_node = NULL;
 
 	/* Get the address of the memory mapped registers */
 	mac_dev->res = platform_get_mem_or_io(_of_dev, 0);
 	if (!mac_dev->res) {
 		dev_err(dev, "could not get registers\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 
 	err = devm_request_resource(dev, fman_get_mem_region(priv->fman),
 				    mac_dev->res);
 	if (err) {
 		dev_err_probe(dev, err, "could not request resource\n");
-		return err;
+		goto _return_dev_put;
 	}
 
 	mac_dev->vaddr = devm_ioremap(dev, mac_dev->res->start,
 				      resource_size(mac_dev->res));
 	if (!mac_dev->vaddr) {
 		dev_err(dev, "devm_ioremap() failed\n");
-		return -EIO;
+		err = -EIO;
+		goto _return_dev_put;
 	}
 
-	if (!of_device_is_available(mac_node))
-		return -ENODEV;
+	if (!of_device_is_available(mac_node)) {
+		err = -ENODEV;
+		goto _return_dev_put;
+	}
 
 	/* Get the cell-index */
 	err = of_property_read_u32(mac_node, "cell-index", &val);
 	if (err) {
 		dev_err(dev, "failed to read cell-index for %pOF\n", mac_node);
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 	priv->cell_index = (u8)val;
 
@@ -260,22 +271,26 @@ static int mac_probe(struct platform_device *_of_dev)
 	if (unlikely(nph < 0)) {
 		dev_err(dev, "of_count_phandle_with_args(%pOF, fsl,fman-ports) failed\n",
 			mac_node);
-		return nph;
+		err = nph;
+		goto _return_dev_put;
 	}
 
 	if (nph != ARRAY_SIZE(mac_dev->port)) {
 		dev_err(dev, "Not supported number of fman-ports handles of mac node %pOF from device tree\n",
 			mac_node);
-		return -EINVAL;
+		err = -EINVAL;
+		goto _return_dev_put;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(mac_dev->port); i++) {
+	/* PORT_NUM determines the size of the port array */
+	for (i = 0; i < PORT_NUM; i++) {
 		/* Find the port node */
 		dev_node = of_parse_phandle(mac_node, "fsl,fman-ports", i);
 		if (!dev_node) {
 			dev_err(dev, "of_parse_phandle(%pOF, fsl,fman-ports) failed\n",
 				mac_node);
-			return -EINVAL;
+			err = -EINVAL;
+			goto _return_dev_arr_put;
 		}
 
 		of_dev = of_find_device_by_node(dev_node);
@@ -283,7 +298,7 @@ static int mac_probe(struct platform_device *_of_dev)
 			dev_err(dev, "of_find_device_by_node(%pOF) failed\n",
 				dev_node);
 			err = -EINVAL;
-			goto _return_of_node_put;
+			goto _return_dev_arr_put;
 		}
 		mac_dev->fman_port_devs[i] = &of_dev->dev;
 
@@ -292,9 +307,15 @@ static int mac_probe(struct platform_device *_of_dev)
 			dev_err(dev, "dev_get_drvdata(%pOF) failed\n",
 				dev_node);
 			err = -EINVAL;
-			goto _return_of_node_put;
+			goto _return_dev_arr_put;
 		}
+		/* Two references have been taken in of_find_device_by_node()
+		 * and fman_port_bind(). Release one of them here. The second
+		 * one will be released in mac_remove().
+		 */
+		put_device(mac_dev->fman_port_devs[i]);
 		of_node_put(dev_node);
+		dev_node = NULL;
 	}
 
 	/* Get the PHY connection type */
@@ -314,7 +335,7 @@ static int mac_probe(struct platform_device *_of_dev)
 
 	err = init(mac_dev, mac_node, &params);
 	if (err < 0)
-		return err;
+		goto _return_dev_arr_put;
 
 	if (!is_zero_ether_addr(mac_dev->addr))
 		dev_info(dev, "FMan MAC address: %pM\n", mac_dev->addr);
@@ -329,6 +350,12 @@ static int mac_probe(struct platform_device *_of_dev)
 
 	return err;
 
+_return_dev_arr_put:
+	/* mac_dev is kzalloc'ed */
+	for (i = 0; i < PORT_NUM; i++)
+		put_device(mac_dev->fman_port_devs[i]);
+_return_dev_put:
+	put_device(mac_dev->fman_dev);
 _return_of_node_put:
 	of_node_put(dev_node);
 	return err;
@@ -337,6 +364,11 @@ static int mac_probe(struct platform_device *_of_dev)
 static void mac_remove(struct platform_device *pdev)
 {
 	struct mac_device *mac_dev = platform_get_drvdata(pdev);
+	int		   i;
+
+	for (i = 0; i < PORT_NUM; i++)
+		put_device(mac_dev->fman_port_devs[i]);
+	put_device(mac_dev->fman_dev);
 
 	platform_device_unregister(mac_dev->priv->eth_dev);
 }
-- 
2.30.2


