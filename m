Return-Path: <netdev+bounces-40693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEAD7C8586
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B1B20A63
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360414A8C;
	Fri, 13 Oct 2023 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44D14A84
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:19:44 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 901A3BD;
	Fri, 13 Oct 2023 05:19:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,222,1694703600"; 
   d="scan'208";a="179182869"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 13 Oct 2023 21:19:41 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D4CF3400264B;
	Fri, 13 Oct 2023 21:19:41 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net-next v2 1/2] rswitch: Use unsigned int for array index
Date: Fri, 13 Oct 2023 21:19:35 +0900
Message-Id: <20231013121936.364678-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013121936.364678-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231013121936.364678-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The array index should not be negative, so modify the condition of
rswitch_for_each_enabled_port_continue_reverse() macro, and then
use unsigned int instead.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 8 +++++---
 drivers/net/ethernet/renesas/rswitch.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 112e605f104a..7640144db79b 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1405,7 +1405,8 @@ static void rswitch_ether_port_deinit_one(struct rswitch_device *rdev)
 
 static int rswitch_ether_port_init_all(struct rswitch_private *priv)
 {
-	int i, err;
+	unsigned int i;
+	int err;
 
 	rswitch_for_each_enabled_port(priv, i) {
 		err = rswitch_ether_port_init_one(priv->rdev[i]);
@@ -1786,7 +1787,8 @@ static void rswitch_device_free(struct rswitch_private *priv, int index)
 
 static int rswitch_init(struct rswitch_private *priv)
 {
-	int i, err;
+	unsigned int i;
+	int err;
 
 	for (i = 0; i < RSWITCH_NUM_PORTS; i++)
 		rswitch_etha_init(priv, i);
@@ -1959,7 +1961,7 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 
 static void rswitch_deinit(struct rswitch_private *priv)
 {
-	int i;
+	unsigned int i;
 
 	rswitch_gwca_hw_deinit(priv);
 	rcar_gen4_ptp_unregister(priv->ptp_priv);
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 04f49a7a5843..27c9d3872c0e 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -20,7 +20,7 @@
 		else
 
 #define rswitch_for_each_enabled_port_continue_reverse(priv, i)	\
-	for (i--; i >= 0; i--)					\
+	for (; i-- > 0; )					\
 		if (priv->rdev[i]->disabled)			\
 			continue;				\
 		else
-- 
2.25.1


