Return-Path: <netdev+bounces-50006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2FF7F43DD
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CE1B21084
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC37584E2;
	Wed, 22 Nov 2023 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2D7112
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:28:30 -0800 (PST)
X-QQ-mid: bizesmtp82t1700648825tzubzofi
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 18:27:04 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: Q7mBtFKTChS4PdoiI3uUlspdILdWKnF7orrPjWXe7Ztq3XTRcbwGkvSqHYzIi
	Dm4tFF9YpHEde3vHF9fmPoIs4bX19NA01qWO4hpPkGI+bAW/Jn5f1tIvF/6KnEfQhlFBKge
	0ReztYuHet7Y5qFqGjIC/RqdJpFIqwxsTv/IjZ64Bxg2xSxBQ8fpdolKJ91ok5VjsyxAYSP
	tRMqPgfrJLmNLDpp3i1+0UTz96FLYbf0qKkh6wEz4zC0A35qs13zpdGoWd+KYNXy/uavLRp
	uZgMeXTfa0k2/FMApUX38WNS/LtcZpO2OmE6wWpUL7OO9ixec8BdrClwtoS00SZcEQf8f6L
	UWCTpFY57Pfdljm91vIZPHIcGXIZv3RsIEoj114btyK0SmB6aJ3yVVqC5VKZy0Lwhuq3Da7
	EONfLxpCGrIbm7K5p7VNeA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1897568626916506468
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/5] net: wangxun: add coalesce options support
Date: Wed, 22 Nov 2023 18:22:24 +0800
Message-Id: <20231122102226.986265-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231122102226.986265-1-jiawenwu@trustnetic.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Support to show RX/TX coalesce with ethtool -c and set RX/TX
coalesce with ethtool -C.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 101 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   8 ++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   4 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   4 +
 7 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 2a09d1df3b0f..abd2f4c92654 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -8,6 +8,7 @@
 #include "wx_type.h"
 #include "wx_ethtool.h"
 #include "wx_hw.h"
+#include "wx_lib.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -203,3 +204,103 @@ void wx_get_ringparam(struct net_device *netdev,
 	ring->rx_jumbo_pending = 0;
 }
 EXPORT_SYMBOL(wx_get_ringparam);
+
+int wx_get_coalesce(struct net_device *netdev,
+		    struct ethtool_coalesce *ec,
+		    struct kernel_ethtool_coalesce *kernel_coal,
+		    struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	ec->tx_max_coalesced_frames_irq = wx->tx_work_limit;
+	/* only valid if in constant ITR mode */
+	if (wx->rx_itr_setting <= 1)
+		ec->rx_coalesce_usecs = wx->rx_itr_setting;
+	else
+		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
+
+	/* if in mixed tx/rx queues per vector mode, report only rx settings */
+	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
+		return 0;
+
+	/* only valid if in constant ITR mode */
+	if (wx->tx_itr_setting <= 1)
+		ec->tx_coalesce_usecs = wx->tx_itr_setting;
+	else
+		ec->tx_coalesce_usecs = wx->tx_itr_setting >> 2;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_coalesce);
+
+int wx_set_coalesce(struct net_device *netdev,
+		    struct ethtool_coalesce *ec,
+		    struct kernel_ethtool_coalesce *kernel_coal,
+		    struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u16 tx_itr_param, rx_itr_param;
+	struct wx_q_vector *q_vector;
+	u16 max_eitr;
+	int i;
+
+	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count) {
+		/* reject Tx specific changes in case of mixed RxTx vectors */
+		if (ec->tx_coalesce_usecs)
+			return -EINVAL;
+	}
+
+	if (ec->tx_max_coalesced_frames_irq)
+		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
+
+	if (wx->mac.type == wx_mac_sp)
+		max_eitr = WX_SP_MAX_EITR;
+	else
+		max_eitr = WX_EM_MAX_EITR;
+
+	if ((ec->rx_coalesce_usecs > (max_eitr >> 2)) ||
+	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
+		return -EINVAL;
+
+	if (ec->rx_coalesce_usecs > 1)
+		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
+	else
+		wx->rx_itr_setting = ec->rx_coalesce_usecs;
+
+	if (wx->rx_itr_setting == 1)
+		rx_itr_param = WX_20K_ITR;
+	else
+		rx_itr_param = wx->rx_itr_setting;
+
+	if (ec->tx_coalesce_usecs > 1)
+		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
+	else
+		wx->tx_itr_setting = ec->tx_coalesce_usecs;
+
+	if (wx->tx_itr_setting == 1) {
+		if (wx->mac.type == wx_mac_sp)
+			tx_itr_param = WX_12K_ITR;
+		else
+			tx_itr_param = WX_20K_ITR;
+	} else {
+		tx_itr_param = wx->tx_itr_setting;
+	}
+
+	/* mixed Rx/Tx */
+	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
+		wx->tx_itr_setting = wx->rx_itr_setting;
+
+	for (i = 0; i < wx->num_q_vectors; i++) {
+		q_vector = wx->q_vector[i];
+		if (q_vector->tx.count && !q_vector->rx.count)
+			/* tx only */
+			q_vector->itr = tx_itr_param;
+		else
+			/* rx only or mixed */
+			q_vector->itr = rx_itr_param;
+		wx_write_eitr(q_vector);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_coalesce);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 77545d0eec56..3a80f8e63719 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -17,4 +17,12 @@ void wx_get_ringparam(struct net_device *netdev,
 		      struct ethtool_ringparam *ring,
 		      struct kernel_ethtool_ringparam *kernel_ring,
 		      struct netlink_ext_ack *extack);
+int wx_get_coalesce(struct net_device *netdev,
+		    struct ethtool_coalesce *ec,
+		    struct kernel_ethtool_coalesce *kernel_coal,
+		    struct netlink_ext_ack *extack);
+int wx_set_coalesce(struct net_device *netdev,
+		    struct ethtool_coalesce *ec,
+		    struct kernel_ethtool_coalesce *kernel_coal,
+		    struct netlink_ext_ack *extack);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6645aff415f8..9eb9ab8fe581 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2150,7 +2150,7 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
  * when it needs to update EITR registers at runtime.  Hardware
  * specific quirks/differences are taken care of here.
  */
-static void wx_write_eitr(struct wx_q_vector *q_vector)
+void wx_write_eitr(struct wx_q_vector *q_vector)
 {
 	struct wx *wx = q_vector->wx;
 	int v_idx = q_vector->v_idx;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index b4bf11684a1d..159d2e34ced9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -21,6 +21,7 @@ void wx_free_irq(struct wx *wx);
 int wx_setup_isb_resources(struct wx *wx);
 void wx_free_isb_resources(struct wx *wx);
 u32 wx_misc_isb(struct wx *wx, enum wx_isb_idx idx);
+void wx_write_eitr(struct wx_q_vector *q_vector);
 void wx_configure_vectors(struct wx *wx);
 void wx_clean_all_rx_rings(struct wx *wx);
 void wx_clean_all_tx_rings(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index bdb2c3d33197..8c795f908d1e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -314,6 +314,7 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_IVAR_ALLOC_VAL         0x80 /* Interrupt Allocation valid */
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
+#define WX_20K_ITR                   200
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_EM_MAX_EITR               0x00007FFCU
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 42bd82b03488..712e0308c397 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -118,6 +118,8 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 }
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
@@ -134,6 +136,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_pauseparam		= ngbe_set_pauseparam,
 	.get_ringparam		= wx_get_ringparam,
 	.set_ringparam		= ngbe_set_ringparam,
+	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index abbccef81557..fe055b006a4e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -93,6 +93,8 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 }
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= txgbe_nway_reset,
 	.get_link		= ethtool_op_get_link,
@@ -107,6 +109,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_pauseparam		= txgbe_set_pauseparam,
 	.get_ringparam		= wx_get_ringparam,
 	.set_ringparam		= txgbe_set_ringparam,
+	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


