Return-Path: <netdev+bounces-52341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E37FE795
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F3EB20D07
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F214CB4C;
	Thu, 30 Nov 2023 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZFFG9NCD"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 431121A6;
	Wed, 29 Nov 2023 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=UfjhIxyGPgUBRRrgHE
	ZRqAC26KRpErr7rMhG9xIdpcU=; b=ZFFG9NCDo5w5m5kc8Nih7jn82lb8VyQ7c1
	/b8/AW+icz0K+aVbmvLFOU0UzoFafKs3cQwOuHJRuSowCYMRSPDtE0cQ4d3AhaDd
	3FOE+UTr31EiBB10Hnmd3BGECauHcIxz4V1tsVWTapYwatC7zpn4CQtOFATqOsJ7
	tTjhORLiI=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wDH13_P_WdlBXH7AQ--.52667S2;
	Thu, 30 Nov 2023 11:13:21 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	pabeni@redhat.com,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [net/ethernet] arc_emac: Add error handling in emac_rockchip_probe
Date: Wed, 29 Nov 2023 19:13:18 -0800
Message-Id: <20231130031318.35850-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDH13_P_WdlBXH7AQ--.52667S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfKw13KF1fuw1UKryUWrg_yoW8Gw43pw
	4DCr9xCw1kWw17Za97GayrAF4Yq3W5KFWjgF9rGa1fua45AFyUXry0qa45ur1UJr42kFya
	kr4UA34fZan8X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieOJ7UUUUU=
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgU4gletj6IPXAAAsJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This patch introduces error handling for the of_match_node call within
the emac_rockchip_probe. Previously, there was no check for the return
value of of_match_node, which could result in improper behavior if the
device tree match was unsuccessful.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 493d6356c8ca..f6f1390b77f6 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -134,6 +134,11 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	}
 
 	match = of_match_node(emac_rockchip_dt_ids, dev->of_node);
+	if (!match) {
+		dev_err(dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	priv->soc_data = match->data;
 
 	priv->emac.clk = devm_clk_get(dev, "hclk");
-- 
2.17.1


