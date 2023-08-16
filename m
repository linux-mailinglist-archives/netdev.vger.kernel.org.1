Return-Path: <netdev+bounces-28001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93577DDF1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754481C20F45
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D034FBF0;
	Wed, 16 Aug 2023 09:54:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A1D52B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:54:40 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F42110
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:54:27 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQk1C6DpVzFqgT;
	Wed, 16 Aug 2023 17:51:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:54:24 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=
	<rafal@milecki.pl>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
	<opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] net: broadcom: Use helper function IS_ERR_OR_NULL()
Date: Wed, 16 Aug 2023 17:53:56 +0800
Message-ID: <20230816095357.2896080-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use IS_ERR_OR_NULL() instead of open-coding it
to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/broadcom/bgmac.c        | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 10c7c232cc4e..4cd7c6abb548 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	int err;
 
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-	if (!phy_dev || IS_ERR(phy_dev)) {
+	if (IS_ERR_OR_NULL(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 0092e46c46f8..aa9a436fb3ce 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -617,7 +617,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
 		};
 
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (!phydev || IS_ERR(phydev)) {
+		if (IS_ERR_OR_NULL(phydev)) {
 			dev_err(kdev, "failed to register fixed PHY device\n");
 			return -ENODEV;
 		}
-- 
2.34.1


