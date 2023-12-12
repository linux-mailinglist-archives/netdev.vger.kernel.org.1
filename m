Return-Path: <netdev+bounces-56273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1636180E592
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB9B1C20F1D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3518624;
	Tue, 12 Dec 2023 08:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89983B8
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:11:23 -0800 (PST)
X-QQ-mid: bizesmtp74t1702368596t140jrf7
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:09:54 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: TVZM0Uoyj024TIl5cVZfTRN9rj7l471+4AlZIvBXNDWRdZhJ8IjlyFHwH0nso
	xdfCCgtHO4UmH2IZzlnDb4dXC66zXFsYjtrKct0Gprk+ZrNThSWqWS8I0d3INg+lnVpkV2d
	mUJ5Rz5gS9MZytgVDbJ+P+Mk5zGnmNLGjIyoHsfy3r281ly604dr/n1FoX0o7GXC8aOyoNK
	EZch2/31+zRM9jXdrPbAwq0LWCFotvh7HcIUcJJCTjaf0u827S/PdXysGKVvJqf0V5yzw0P
	RlCxiTNT5p+6vCwsPhQ4wgFduvn/F6ibfq+heCmM35hvVAnZl2eYPVIHu1po7ov59ErRsFS
	2bklVqkQITK5ML7z9Mf0PGtpa3/ghsjPHSZi8sjQ6UfNp7sg4o4RfpnWoa8zbVBf6Y2BqQs
	P9vAOZ3e4iA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1889069302474054002
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 6/8] net: wangxun: add coalesce options support
Date: Tue, 12 Dec 2023 16:04:36 +0800
Message-Id: <20231212080438.1361308-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
References: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
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
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   8 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   4 +
 7 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 77da6111fbce..ccc3f1697a76 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -8,6 +8,7 @@
 #include "wx_type.h"
 #include "wx_ethtool.h"
 #include "wx_hw.h"
+#include "wx_lib.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -247,3 +248,103 @@ void wx_get_ringparam(struct net_device *netdev,
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
+			return -EOPNOTSUPP;
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
index 7651ec4b7dd9..3cd0495a6fbb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -26,4 +26,12 @@ void wx_get_ringparam(struct net_device *netdev,
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
index f721096f4450..890a5c31a5a8 100644
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
index af1381c13d9e..ec909e876720 100644
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
index d3a17e404111..41bd1fb80b93 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -315,6 +315,7 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_IVAR_ALLOC_VAL         0x80 /* Interrupt Allocation valid */
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
+#define WX_20K_ITR                   200
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_EM_MAX_EITR               0x00007FFCU
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 63471b0f0695..2620d30110f6 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -52,7 +52,7 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i, err = 0;
+	int i;
 
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
 		return -EOPNOTSUPP;
@@ -92,10 +92,12 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_configure(wx);
 	ngbe_up(wx);
 
-	return err;
+	return 0;
 }
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= wx_get_link_ksettings,
@@ -112,6 +114,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_pauseparam		= wx_set_pauseparam,
 	.get_ringparam		= wx_get_ringparam,
 	.set_ringparam		= ngbe_set_ringparam,
+	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 6730a72cf2c9..02cff6ef24df 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -62,6 +62,8 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 }
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
@@ -76,6 +78,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_pauseparam		= wx_set_pauseparam,
 	.get_ringparam		= wx_get_ringparam,
 	.set_ringparam		= txgbe_set_ringparam,
+	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


