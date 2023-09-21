Return-Path: <netdev+bounces-35372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8127A9146
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070DE1C208F5
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8F17EF;
	Thu, 21 Sep 2023 03:21:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01111840
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:21:27 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3FEED
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:21:25 -0700 (PDT)
X-QQ-mid: bizesmtp89t1695266336thb1ujms
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Sep 2023 11:18:55 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 2w1wQVt6itRMT2Q0X9XWhCDy7YmAMrM2EE/mktgf6s69T6fYeJKwPBoAxM1hS
	ImUcfHYdhN4rmwIPG3XUz9NwTWUBokWRumIZRwOMfnZN1J4KM1LbZBhcHR9Lsh4c+GS7Jko
	3KnkeYxRBP9J2NXYYg2l8EBEOGJhw3fZ1wl/kLD+vnuid8FcjZXGcD+ptry0hfsrjzgClzl
	Pize85T8J/7ZN1v/yAxgJazrH78YnLAH6xcXKYgSuIe4rLmNLnQ/toLMZFOoE7epI9Srd+R
	cvfULayn3Bykp8HpFuOidLjl2DcXUWv/057a+z3LeTId5uUn1DDm3vlYo+02M8mNFohhLPs
	aEy6Sw5Zz1gxF7hUk6e8Ml0i3r8FsVvXEd/UbHCA92gXCrWVxbd/jr8zV/csb5XrJeScAkg
	kN4hvtlIGU4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14714635642530804064
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/3] net: txgbe: add ethtool stats support
Date: Thu, 21 Sep 2023 11:30:19 +0800
Message-Id: <20230921033020.853040-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230921033020.853040-1-jiawenwu@trustnetic.com>
References: <20230921033020.853040-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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


