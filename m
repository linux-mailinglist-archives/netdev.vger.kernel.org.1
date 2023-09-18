Return-Path: <netdev+bounces-34422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3847A41DD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9672D1C20FBC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B179EB;
	Mon, 18 Sep 2023 07:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8979D0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:10:59 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD02E6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:10:55 -0700 (PDT)
X-QQ-mid: bizesmtp72t1695020988tge07r0s
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Sep 2023 15:09:46 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4NkimdIo3cOZKOgAITMkMQhtq5MY89dTG42uFNz7SsY+NgeC4PX3
	YaFh7e78+9iE93qXnLgqKc2bthtv+Psh4qW/odbs1lSGKvMQZMDBkmQH4G0LI0bfE63GbPM
	h38qqEiYIRVF4+0spdl37+dYCLLOL6hLHpA8Opq+jTS6ybu9dtaksC4oMLUlrVX6Bl08VDv
	pMtgfjuWs7p19CFQFn2QDndWP2gBNjPcxqRaSU6W7Eo6+P8dCHLHy6gcnjfitVns+ehCVIL
	wlXMT+rqTA93iP30PCBWhmDwRLp+po+eWFDWz+/JQzky3zIeH4rjwnKl+u3OtbWYwvfLHLL
	l5B/uSmyBhDzkp8tGWTPzTl10iIOAzO/m9n0xTwaA4W5P8SLGb09jQbH/7uvmD2G08PN+fo
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12056201182732190363
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/3] net: ngbe: add ethtool stats support
Date: Mon, 18 Sep 2023 15:21:08 +0800
Message-Id: <20230918072108.809020-4-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c      | 2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index ec0e869e9aac..1ab6efd993dc 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -49,6 +49,9 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_wol		= ngbe_get_wol,
 	.set_wol		= ngbe_set_wol,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
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


