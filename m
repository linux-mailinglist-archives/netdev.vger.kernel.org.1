Return-Path: <netdev+bounces-28714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761C780565
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A1728231A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8113FE1;
	Fri, 18 Aug 2023 05:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DB13AD8
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:12:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC432E74
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 22:12:51 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRqfZ6SLdztS07;
	Fri, 18 Aug 2023 13:09:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 13:12:48 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<pgynther@google.com>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v3 1/2] net: bgmac: Fix return value check for fixed_phy_register()
Date: Fri, 18 Aug 2023 13:12:20 +0800
Message-ID: <20230818051221.3634844-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818051221.3634844-1-ruanjinjie@huawei.com>
References: <20230818051221.3634844-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The fixed_phy_register() function returns error pointers and never
returns NULL. Update the checks accordingly.

Fixes: c25b23b8a387 ("bgmac: register fixed PHY for ARM BCM470X / BCM5301X chipsets")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3:
- Split the err code update code into another patch set as suggested.
v2:
- Remove redundant NULL check and fix the return value.
- Update the commit title and message.
- Add the fix tag.
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 10c7c232cc4e..52ee3751187a 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	int err;
 
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-	if (!phy_dev || IS_ERR(phy_dev)) {
+	if (IS_ERR(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
 		return -ENODEV;
 	}
-- 
2.34.1


