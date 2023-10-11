Return-Path: <netdev+bounces-39914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFD7C4E32
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630A6282286
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B31A71C;
	Wed, 11 Oct 2023 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05821A718
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:08:01 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A6A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:07:57 -0700 (PDT)
X-QQ-mid: bizesmtp86t1697015212tikaivuh
Received: from wxdbg.localdomain.com ( [115.200.230.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 17:06:51 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: xQoAiglG4R7q5T/uVaj50fiOO244KcKbboi8HopzFkgdklEp0Hz2TZ2pqlPr+
	eW5AQOSDDWcPy5viwJbdefHJw+VaAIYdLTr15FcoYnhFdtNGS2IRfEt5K6Th7ZM5aBI3fTT
	lRr3iJ+j84aWboDe7Wf37cPRgzxw6Ivthe4pRXuOOS/FOvKI7QKh8glRnCh3+4+0hMo5EBq
	WKSMlhNLEEkWQ8VlKqyimk4G29PgIIEwajTP1zPdkSO7xdaEb/9C0JkgPZ/au+ruF9U8A9g
	DmT4lNeEQDZBJu8y6P5twUoOHPDSCG8iKnlXrXhrI+mBAXOXPSVgz0yxfzFYzb9Tu1BN3G/
	15/vw6uii7Zc3i9GsTpRxn/pO1FnZxQK4+fhlPhgWdV/hKdLNYJ6ib7hN6jROF+CnZOTT5K
	7BV5M8kZFVk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5144983377111574632
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 2/3] net: txgbe: add ethtool stats support
Date: Wed, 11 Oct 2023 17:19:05 +0800
Message-Id: <20231011091906.70486-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231011091906.70486-1-jiawenwu@trustnetic.com>
References: <20231011091906.70486-1-jiawenwu@trustnetic.com>
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
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c | 5 +++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      | 2 ++
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 859da112586a..3f336a088e43 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -39,6 +39,11 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= txgbe_get_link_ksettings,
 	.set_link_ksettings	= txgbe_set_link_ksettings,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
+	.get_eth_mac_stats	= wx_get_mac_stats,
+	.get_pause_stats	= wx_get_pause_stats,
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


