Return-Path: <netdev+bounces-39912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8A7C4E30
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EBD1C20BD8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AC1A71C;
	Wed, 11 Oct 2023 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC209323D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:07:55 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227C99C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:07:52 -0700 (PDT)
X-QQ-mid: bizesmtp86t1697015215t7lnh2z3
Received: from wxdbg.localdomain.com ( [115.200.230.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 17:06:54 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: xQoAiglG4R7q5T/uVaj50ZkAYUxOihIqjsq3nAsIONqRB5j4udifx8Siw2XUS
	90R/c2skgKZu9V+72kXwDmDyMFtH09Mr3dSna1EtN+elgSLUVcjbo8jtlq/z1dzYFwD5p3q
	0YggEqiYCHENaFJIMPC/zReTtcvrHgLXGw3RUYh8QiEFil251TF01dn6oV5uWuN8ii26iq5
	ePAis2FnWnjR1c9SbaOYDS8kZ3Z2bfVjYQt585gjYn7qh352zaIs9QUeA6GEeFoV/WCLY3g
	daScaoOMd2x2G7gfAIgCMRxWLbB+jSrbTzsCIXPUtqf2ro+/J4/owipllR3le6U+ZyItbdp
	E/ikWa4oZu/xVfxfIEylGYPRXIVMrotpqK21FyAEe+LRUmEO1mX8d+Pe8OWq89nyHNoxHsB
	n8QvXLtBFPI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15441367497343982946
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 3/3] net: ngbe: add ethtool stats support
Date: Wed, 11 Oct 2023 17:19:06 +0800
Message-Id: <20231011091906.70486-4-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 5 +++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c      | 2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index ec0e869e9aac..afbdf6919071 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -49,6 +49,11 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_wol		= ngbe_get_wol,
 	.set_wol		= ngbe_set_wol,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
+	.get_eth_mac_stats	= wx_get_mac_stats,
+	.get_pause_stats	= wx_get_pause_stats,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
index 6562a2de9527..6459bc1d7c22 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c
@@ -85,6 +85,8 @@ int ngbe_reset_hw(struct wx *wx)
 	}
 	ngbe_reset_misc(wx);
 
+	wx_clear_hw_cntrs(wx);
+
 	/* Store the permanent mac address */
 	wx_get_mac_addr(wx, wx->mac.perm_addr);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2b431db6085a..652e6576e36a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -332,6 +332,8 @@ static void ngbe_disable_device(struct wx *wx)
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
+
+	wx_update_stats(wx);
 }
 
 static void ngbe_down(struct wx *wx)
-- 
2.27.0


