Return-Path: <netdev+bounces-37232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EE7B4579
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 57124B20AF8
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60044944D;
	Sun,  1 Oct 2023 05:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F411870
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 05:51:11 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5C39D3;
	Sat, 30 Sep 2023 22:51:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.192.195.11])
	by mail-app3 (Coremail) with SMTP id cC_KCgDHz8N_CBlllGwtAQ--.64662S4;
	Sun, 01 Oct 2023 13:50:07 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: stable@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Harry Morris <harrymorris12@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Date: Sun,  1 Oct 2023 13:49:49 +0800
Message-Id: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDHz8N_CBlllGwtAQ--.64662S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4fGFW5ury5Cry5JFW3GFg_yoW8uF4fpa
	1Ska4UJryqvF4jga18Ar48Zr98C3W7KayruF95K392k3ZxuryxKanrAFW3JF4rAFWUCan8
	C3yUJ3y5uFs5AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMPBmUYLyEI2QADsp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

If of_clk_add_provider() fails in ca8210_register_ext_clock(),
it calls clk_unregister() to release priv->clk and returns an
error. However, the caller ca8210_probe() then calls ca8210_remove(),
where priv->clk is freed again in ca8210_unregister_ext_clock(). In
this case, a use-after-free may happen in the second time we call
clk_unregister().

Fix this by removing the first clk_unregister(). Also, priv->clk could
be an error code on failure of clk_register_fixed_rate(). Use
IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: -Remove the first clk_unregister() instead of nulling priv->clk.

v3: -Simplify ca8210_register_ext_clock().
    -Add a ';' after return in ca8210_unregister_ext_clock().
---
 drivers/net/ieee802154/ca8210.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index aebb19f1b3a4..ae44a9133937 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2757,18 +2757,8 @@ static int ca8210_register_ext_clock(struct spi_device *spi)
 		dev_crit(&spi->dev, "Failed to register external clk\n");
 		return PTR_ERR(priv->clk);
 	}
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
-	if (ret) {
-		clk_unregister(priv->clk);
-		dev_crit(
-			&spi->dev,
-			"Failed to register external clock as clock provider\n"
-		);
-	} else {
-		dev_info(&spi->dev, "External clock set as clock provider\n");
-	}
 
-	return ret;
+	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
 }
 
 /**
@@ -2780,8 +2770,8 @@ static void ca8210_unregister_ext_clock(struct spi_device *spi)
 {
 	struct ca8210_priv *priv = spi_get_drvdata(spi);
 
-	if (!priv->clk)
-		return
+	if (IS_ERR_OR_NULL(priv->clk))
+		return;
 
 	of_clk_del_provider(spi->dev.of_node);
 	clk_unregister(priv->clk);
-- 
2.17.1


