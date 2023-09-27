Return-Path: <netdev+bounces-36420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A747AFA9C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C817F1C2074F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DC15493;
	Wed, 27 Sep 2023 06:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F525156C2
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:04:55 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45EB3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 23:04:51 -0700 (PDT)
X-QQ-mid: bizesmtp62t1695794631ti18xmri
Received: from wxdbg.localdomain.com ( [115.200.229.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Sep 2023 14:03:50 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: uW0fSitQVItlZ8NEh8JX8JZW2iUK/c3u6Zx9wjU5Fp2aR41OYHDRvmt77Xoko
	KQ3KW9dqaG+OIwBy0rfrKm0HPls3hbwb69pZ/xdiN2fO+T9X1fvo/ASijCc77dyCoatQ7uW
	hIvTNJSArDMdSx61WXQta/KAkaCaXZJXMcI8fGKU6KBRiUYTRPHOxnx2tdRtZZVrC0W9QPZ
	oyNQPiGyEzKE8i2ycIW5tsFcU5ofl4UZtn3AwH5Z0RmdMrfBCERZkR+FtNhiBD+flgq4AXq
	jB4nnB6KeNJJkM55qrj7OLxUAz5HgjX6327v32kNVBTtp1a5evI+jAduUslONUxJAJCQbLF
	OFyP+kJ+vi8Qgu3E4VdHNQDb/3k8MoNwcG7HJbR/17UIOLsCtDMGIPjml+2vUuJ8XuOsmGp
	EcKN8UKQF3Q=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17019050607144318019
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RESEND PATCH net-next v2 3/3] net: ngbe: add ethtool stats support
Date: Wed, 27 Sep 2023 14:14:57 +0800
Message-Id: <20230927061457.993277-4-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
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


