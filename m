Return-Path: <netdev+bounces-36422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E07AFAB3
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A8C872814B2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 06:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E546156F5;
	Wed, 27 Sep 2023 06:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76429A8
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:06:24 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C092B3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 23:06:21 -0700 (PDT)
X-QQ-mid: bizesmtp62t1695794627tlrky33z
Received: from wxdbg.localdomain.com ( [115.200.229.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 14:03:46 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3hk0mdICKk9QomLHZ3bdRyGpFQSLbx8UbVIqu5oF3uZ/qiyBM1Jf
	0GynGF47Ubyc3KzV2Vf6yHta3HwosTfBn5uTKwovbkG9YHJ8Jj5k8eaNwTK0xOhERjmzaCZ
	ZR68odEoIG+Y/Zt8e1YxMR/+ZBJsH1kR6vx/2VZIjfvwVk8c9eiBVIzX7yie3G8cz7djPvz
	ceGqmto851ucV8LEIG64v1jdiVBCBHXKLT9QHGyJLBneg1U8Lb9KaFTH3Ks6mfPgO3cijbF
	Xn3SVrJkfJNQ52dyl5GMX7mDa4O9jdX8wTCdHhnqmrPvZfaTdl4XCNEe7ynej9xqIeNOTvy
	afTJtzTrOpflquACN75LbRlOt7gP4jVkgfAztxOH1uszgd7zgJ6JSOjfWwRWsy/eXOItmWZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15862063992106408741
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RESEND PATCH net-next v2 2/3] net: txgbe: add ethtool stats support
Date: Wed, 27 Sep 2023 14:14:56 +0800
Message-Id: <20230927061457.993277-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230927061457.993277-1-jiawenwu@trustnetic.com>
References: <20230927061457.993277-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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


