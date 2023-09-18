Return-Path: <netdev+bounces-34420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1267A41D9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743BD1C21032
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C918D749B;
	Mon, 18 Sep 2023 07:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80C3C2C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:10:50 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E911C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:10:45 -0700 (PDT)
X-QQ-mid: bizesmtp72t1695020984tzv55dms
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Sep 2023 15:09:43 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: xQoAiglG4R5W4O0z6r1xvcnlkg2I0KPVgJ7Vxva0ognG374z/pJHViOuLQHav
	Ycji1pkGsp1x8ZnuL8b8qkeLgT20iHnQtV40KfOVg6zYu+BTnf7Beb+Uju7jLQJPC28szJE
	AtpHLdhM1XI8L38jgVwwpBKwXXr2Jm4PNd2Ph+h1eCBmkYJvyE7itYAe/ib73JI1mJmkEjL
	wZAm9TdTJqw7qUV8gwwZ4RbQk3Pu8Wc97yuIthkSXR8/rNbxP+02aaAh9xT0HHz/neZLFrC
	cgaRxHqfBEWgverKMduXfvzOtCAmTt8Fa2mheXO6BTFarjOJe7zbcKfInBo6eZeECIZjC1F
	oT5MayuL+MPUHWXQyt7X0ES901MjaOHPIMc4umsRTJ6qfTLBLOucdBOvNNY8WyzV14Y3+3N
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12935686042037011435
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/3] net: txgbe: add ethtool stats support
Date: Mon, 18 Sep 2023 15:21:07 +0800
Message-Id: <20230918072108.809020-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918072108.809020-1-jiawenwu@trustnetic.com>
References: <20230918072108.809020-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c | 3 +++
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      | 2 ++
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 859da112586a..764d23daa112 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -39,6 +39,9 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= txgbe_get_link_ksettings,
 	.set_link_ksettings	= txgbe_set_link_ksettings,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 372745250270..474d55524e82 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -306,6 +306,8 @@ int txgbe_reset_hw(struct wx *wx)
 
 	txgbe_reset_misc(wx);
 
+	wx_clear_hw_cntrs(wx);
+
 	/* Store the permanent mac address */
 	wx_get_mac_addr(wx, wx->mac.perm_addr);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 5c3aed516ac2..394f699c51da 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -286,6 +286,8 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* Disable the Tx DMA engine */
 	wr32m(wx, WX_TDM_CTL, WX_TDM_CTL_TE, 0);
+
+	wx_update_stats(wx);
 }
 
 static void txgbe_down(struct wx *wx)
-- 
2.27.0


