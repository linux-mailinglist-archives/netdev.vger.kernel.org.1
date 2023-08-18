Return-Path: <netdev+bounces-28726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84151780622
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4192822AF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE314F93;
	Fri, 18 Aug 2023 07:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822A154BD
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:07:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612B30D6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:07:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRtDr2fFlzVkMJ;
	Fri, 18 Aug 2023 15:05:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 15:07:40 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <rafal@milecki.pl>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <opendmb@gmail.com>, <florian.fainelli@broadcom.com>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 3/3] net: lan743x: Return PTR_ERR() for fixed_phy_register()
Date: Fri, 18 Aug 2023 15:07:07 +0800
Message-ID: <20230818070707.3670245-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818070707.3670245-1-ruanjinjie@huawei.com>
References: <20230818070707.3670245-1-ruanjinjie@huawei.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
etc, in addition to -EIO. The Best practice is to return these
error codes with PTR_ERR().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v3:
- Update the commit title and message.
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a36f6369f132..c81cdeb4d4e7 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1515,7 +1515,7 @@ static int lan743x_phy_open(struct lan743x_adapter *adapter)
 							    &fphy_status, NULL);
 				if (IS_ERR(phydev)) {
 					netdev_err(netdev, "No PHY/fixed_PHY found\n");
-					return -EIO;
+					return PTR_ERR(phydev);
 				}
 			} else {
 				goto return_error;
-- 
2.34.1


