Return-Path: <netdev+bounces-274862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L5DJiEtz2k3tgYAu9opvQ
	(envelope-from <netdev+bounces-274862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F382390893
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC73E303932A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB1351C05;
	Fri,  3 Apr 2026 02:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21034346FA6;
	Fri,  3 Apr 2026 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185173; cv=none; b=pZUzEZzghalX53E/UgPIDczo/nRWlaO/uaXmxGpaG3AzcBahvtuHalz+McUAwQ21j0Hy9OH7Luazz3d2DNQiEHsTAwwAoQzIedPj7KZi9cKV9M50iCp6evZN0k6bckhmzUS3bH3Ykh40qljv3YvEr6MA+aUx0sym2146HYi1jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185173; c=relaxed/simple;
	bh=xgiAAlr7wmR8SxTb1lw1IEnA4huC1cSGYwFrLf2oBWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2TtelaKcxtMyIuKu1DIJERlwnJXtt0eJS8Hye7k6zZGGCg8Lbcfyuk6Gh6qWmNI0v9ayaDyVPDkcfTPXCQio/0LbaqF+0FPmRS30oPlhFn77v9lQ5O/rzEy1L9d9BDeWXXvzAjFhUA+irLkHNRQodblhz72DxtlFoJIdK9QZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1775185098ta59ebdbf
X-QQ-Originating-IP: TrN5nvzSr1oDy7mgYO3Cn2A2Wdbr2hKJd0LXTdSZGRM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Apr 2026 10:58:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4108894342483881346
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v2 4/4] net: rnpgbe: Add link status handling support
Date: Fri,  3 Apr 2026 10:57:13 +0800
Message-Id: <20260403025713.527841-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260403025713.527841-1-dong100@mucse.com>
References: <20260403025713.527841-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N3L+rZAeYOerPbt7p5S5IjxUfrPXkwuA8e7iJZ/m/6FLzLK82NlbYSfY
	uxlOSAtKobLJoAziLtITZxUZqpm11XN8m3JTCEGVSEqerr9NswhPvYQot38KbU9XlA6iirj
	zM2340OUN0DU+Nv90TW2mMzFbHuRuUQph4Ws+es4+WmrRmcicZQ/+zzs5dZrELPMMZk0KiY
	kgpJu0sAjKTcUMta3hnyqTIEJUriKY9+sTHzEEfQC12tisaT49eOOPs1jInCeJeG3cTPDwF
	usSxYzLIuNHueYiJxh8EF+y8NE17zZCV/FWC3ZjtQPT8ywhFYHinpq6h8EvRJndehB5bdKc
	J0EMv1nmhKad3h4nRDPjN7o8Xj+72Fu5Bj3m2sD+ul3/u5ETg3p8zrWKBa56zKOxhWSVEdM
	51j83/RBiouvjIVdgU20SgCtSia4Cb3Agjn4G2oRELMjvFcHtWl2o4nW9tqm2EOs603izBk
	tK0bVaQLkeJ8m/nRMsityVGWAm7jno2g4tbsrfg/oC2sqWiJ9vPAgZNnjGvYDxivl7vYkxu
	5i4afUECRiwjUhaw/LeS3GwlXkmY3LGf1kzz6u6yobrsfFXcEbed0I/KDTeSe1gpAVUFoFW
	j90Ez6dIbE8hkjImKTuqdBktfn6z5VJs4NBqCNnwfVANckmxfXHB/a8nBpUjAU++Li0f01M
	PD/cZzfwkcpauiSvZsVXdIDleV7phMyQRVsKi0sV6n+3wYWlOJ5KrpGgfYtBl4EadBEqZv4
	DrOyjhj/sLG5DPU2qRO8vn+rM58U+tyKdTnGyqjEHx8PkcS2xcTsK075VTG1x/X9ZhR2LbR
	GsDVUzJqnPzFzmg1r3xCLzwMzHLl4sWpRLk9D84hIQnMK0RSIH/dYrSONi18LxmbpaDSeHJ
	J0HviIRpVbCk9c+1WXiJ9H+WYP78fM1PQpTD8wWZ298S3wp76wJW65+A106HKIpQnmNiBr8
	EsIzb85z57spbOghAJ6+Py3EeiXOOiDkHCXn3BYcbsNB51DFv47Bbh9UnF4kBkiwiQbSl6R
	rJrMlA1eM5q0Llw2f7evcF/oiCThazC5p+T7r9Q3HCNheXEoxOemkahBMVKSk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F382390893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add link status management infrastructure to the rnpgbe driver:
- Add link status related data structures (speed, duplex, link state)
- Implement firmware link event handling via mailbox
- Add service task for periodic link status monitoring
- Implement carrier status management (netif_carrier_on/off)
- Add port up/down notification to firmware

This enables the driver to properly track and report link status changes.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  17 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  31 +++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 150 ++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  20 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 166 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  38 ++++
 10 files changed, 437 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 87cb9e9e3f0f..9bd173c7f44f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -30,11 +30,10 @@ struct mucse_mbx_info {
 	u32 fwpf_ctrl_base;
 };
 
-/* Enum for firmware notification modes,
- * more modes (e.g., portup, link_report) will be added in future
- **/
 enum {
 	mucse_fw_powerup,
+	mucse_fw_portup,
+	mucse_fw_link_report_en,
 };
 
 struct mucse_hw {
@@ -43,8 +42,11 @@ struct mucse_hw {
 	struct pci_dev *pdev;
 	struct mucse_mbx_info mbx;
 	int port;
+	int speed;
+	bool link;
 	u16 cycles_per_us;
 	u8 pfvfnum;
+	u8 duplex;
 };
 
 struct rnpgbe_tx_desc {
@@ -191,6 +193,10 @@ struct mucse_stats {
 #define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
+enum mucse_state_t {
+	__MUCSE_DOWN,
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -199,6 +205,7 @@ struct mucse {
 #define M_FLAG_MSI_EN              BIT(0)
 #define M_FLAG_MSIX_SINGLE_EN      BIT(1)
 #define M_FLAG_MSIX_EN             BIT(2)
+#define M_FLAG_NEED_LINK_UPDATE    BIT(3)
 	u32 flags;
 	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
@@ -211,6 +218,9 @@ struct mucse {
 	int num_q_vectors;
 	int rx_ring_item_count;
 	int num_rx_queues;
+	unsigned long state;
+	struct delayed_work serv_task;
+	spinlock_t link_lock; /* spinlock for link update */
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -219,6 +229,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+void rnpgbe_set_rx(struct mucse_hw *hw, bool enable);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 291e77d573fe..902c8a801ba3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -66,11 +66,17 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       int mode)
 {
 	int err;
-	/* Keep switch struct to support more modes in the future */
+
 	switch (mode) {
 	case mucse_fw_powerup:
 		err = mucse_mbx_powerup(hw, enable);
 		break;
+	case mucse_fw_portup:
+		err = mucse_mbx_phyup(hw, enable);
+		break;
+	case mucse_fw_link_report_en:
+		err = mucse_mbx_link_report(hw, enable);
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -149,3 +155,26 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
 	return 0;
 }
+
+/**
+ * rnpgbe_set_rx - Setup rx state
+ * @hw: hw information structure
+ * @enable: set rx on or off
+ *
+ * rnpgbe_set_rx setup rx enable
+ *
+ **/
+void rnpgbe_set_rx(struct mucse_hw *hw, bool enable)
+{
+	u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
+
+	if (enable)
+		value |= GMAC_CONTROL_RE;
+	else
+		value &= ~GMAC_CONTROL_RE;
+
+	mucse_hw_wr32(hw, GMAC_CONTROL, value);
+
+	value = mucse_hw_rd32(hw, GMAC_FRAME_FILTER);
+	mucse_hw_wr32(hw, GMAC_FRAME_FILTER, value | BIT(0));
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 03688586b447..77aef019acbf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -17,7 +17,19 @@
 
 #define TX_AXI_RW_EN                   0xc
 #define RX_AXI_RW_EN                   0x03
+/* mask all valid info */
+#define M_ST_MASK                      0x0f000f11
+/* 31:28 set 0xa to valid it is a driver set info */
+#define M_DEFAULT_ST                   0xa0000000
+/* driver setup this by own info */
+/*bit:   25:24   |  11:8   |     4   | 0       */
+/*fun:   pause   |  speed  |  duplex | up/down */
+#define RNPGBE_LINK_ST                 0x000c
 #define RNPGBE_DMA_AXI_EN              0x0010
 
+#define MUCSE_GMAC_OFF(_n)             (0x20000 + (_n))
+#define GMAC_CONTROL_RE                0x00000004
+#define GMAC_CONTROL                   MUCSE_GMAC_OFF(0)
+#define GMAC_FRAME_FILTER              MUCSE_GMAC_OFF(0x4)
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 7e057e2f948b..5d0c170b8c9e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -9,6 +9,7 @@
 
 #include "rnpgbe_lib.h"
 #include "rnpgbe.h"
+#include "rnpgbe_mbx_fw.h"
 
 /**
  * rnpgbe_msix_other - Other irq handler
@@ -19,6 +20,10 @@
  **/
 static irqreturn_t rnpgbe_msix_other(int irq, void *data)
 {
+	struct mucse *mucse = (struct mucse *)data;
+
+	mucse_fw_irq_handler(&mucse->hw);
+
 	return IRQ_HANDLED;
 }
 
@@ -528,6 +533,9 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 	}
 
+	if (test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+		clean_complete = true;
+
 	if (!clean_complete)
 		return budget;
 
@@ -892,6 +900,7 @@ static irqreturn_t rnpgbe_int_single(int irq, void *data)
 	struct mucse *mucse = (struct mucse *)data;
 	struct mucse_q_vector *q_vector;
 
+	mucse_fw_irq_handler(&mucse->hw);
 	q_vector = mucse->q_vector[0];
 	rnpgbe_irq_disable_queues(q_vector);
 	if (q_vector->rx.ring || q_vector->tx.ring)
@@ -1146,7 +1155,26 @@ static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
 void rnpgbe_down(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	int err;
+
+	set_bit(__MUCSE_DOWN, &mucse->state);
+	cancel_delayed_work_sync(&mucse->serv_task);
+
+	err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send link report to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
+	}
 
+	err = rnpgbe_send_notify(hw, false, mucse_fw_portup);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send port down to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Port is not truly down\n");
+	}
+	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 	rnpgbe_irq_disable(mucse);
 	netif_tx_disable(netdev);
@@ -1162,6 +1190,8 @@ void rnpgbe_down(struct mucse *mucse)
 void rnpgbe_up_complete(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	int err;
 
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
@@ -1169,6 +1199,22 @@ void rnpgbe_up_complete(struct mucse *mucse)
 	netif_tx_start_all_queues(netdev);
 	for (int i = 0; i < mucse->num_rx_queues; i++)
 		mucse_ring_wr32(mucse->rx_ring[i], RNPGBE_RX_START, 1);
+
+	err = rnpgbe_send_notify(hw, true, mucse_fw_portup);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send portup to hw failed %d\n", err);
+		dev_warn(&hw->pdev->dev, "Port is not truly up\n");
+	}
+
+	err = rnpgbe_send_notify(hw, true, mucse_fw_link_report_en);
+	if (err) {
+		dev_warn(&hw->pdev->dev, "Send link report to hw failed %d\n",
+			 err);
+		dev_warn(&hw->pdev->dev, "Fw will not report link event\n");
+	}
+	clear_bit(__MUCSE_DOWN, &mucse->state);
+	queue_delayed_work(system_wq, &mucse->serv_task,
+			   msecs_to_jiffies(500));
 }
 
 /**
@@ -1777,3 +1823,107 @@ void rnpgbe_configure_rx(struct mucse *mucse)
 	dma_axi_ctl |= RX_AXI_RW_EN;
 	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
 }
+
+/**
+ * rnpgbe_watchdog_update_link - Update the link status
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_watchdog_update_link(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	unsigned long flags;
+	bool link;
+	int speed;
+	u8 duplex;
+
+	if (!(mucse->flags & M_FLAG_NEED_LINK_UPDATE))
+		return;
+
+	spin_lock_irqsave(&mucse->link_lock, flags);
+
+	link = hw->link;
+	speed = hw->speed;
+	duplex = hw->duplex;
+
+	mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
+	spin_unlock_irqrestore(&mucse->link_lock, flags);
+
+	if (link) {
+		netdev_info(netdev, "NIC Link is Up %d Mbps, %s Duplex\n",
+			    speed,
+			    duplex ? "Full" : "Half");
+	}
+}
+
+/**
+ * rnpgbe_watchdog_link_is_up - Update netif_carrier status and
+ * print link up message
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_watchdog_link_is_up(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Only continue if link was previously down */
+	if (netif_carrier_ok(netdev))
+		return;
+	rnpgbe_set_rx(hw, true);
+	netif_carrier_on(netdev);
+	netif_tx_wake_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_watchdog_link_is_down - Update netif_carrier status and
+ * print link down message
+ * @mucse: pointer to the private structure
+ **/
+static void rnpgbe_watchdog_link_is_down(struct mucse *mucse)
+{
+	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+
+	/* Only continue if link was up previously */
+	if (!netif_carrier_ok(netdev))
+		return;
+	netdev_info(netdev, "NIC Link is Down\n");
+	rnpgbe_set_rx(hw, false);
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+}
+
+/**
+ * rnpgbe_watchdog_subtask - Check and bring link up
+ * @mucse: pointer to the device private structure
+ **/
+static void rnpgbe_watchdog_subtask(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	/* if interface is down do nothing */
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return;
+
+	rnpgbe_watchdog_update_link(mucse);
+	if (hw->link)
+		rnpgbe_watchdog_link_is_up(mucse);
+	else
+		rnpgbe_watchdog_link_is_down(mucse);
+}
+
+/**
+ * rnpgbe_service_task - Manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+void rnpgbe_service_task(struct work_struct *work)
+{
+	struct mucse *mucse = container_of(work, struct mucse, serv_task.work);
+
+	if (test_bit(__MUCSE_DOWN, &mucse->state))
+		return;
+
+	rnpgbe_watchdog_subtask(mucse);
+
+	queue_delayed_work(system_wq, &mucse->serv_task,
+			   msecs_to_jiffies(500));
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index 29520ad716ca..74b4b0ab0b89 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -86,4 +86,5 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
 int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
 void rnpgbe_free_all_rx_resources(struct mucse *mucse);
+void rnpgbe_service_task(struct work_struct *work);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index f31547a04b3d..4fc6244f247c 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -52,6 +52,7 @@ static int rnpgbe_open(struct net_device *netdev)
 	struct mucse *mucse = netdev_priv(netdev);
 	int err;
 
+	netif_carrier_off(netdev);
 	err = rnpgbe_request_irq(mucse);
 	if (err)
 		return err;
@@ -181,6 +182,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "Init hw err %d\n", err);
 		goto err_free_net;
 	}
+
 	/* Step 1: Send power-up notification to firmware (no response expected)
 	 * This informs firmware to initialize hardware power state, but
 	 * firmware only acknowledges receipt without returning data. Must be
@@ -223,6 +225,9 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_powerdown;
 	}
 
+	INIT_DELAYED_WORK(&mucse->serv_task, rnpgbe_service_task);
+	spin_lock_init(&mucse->link_lock);
+
 	err = rnpgbe_init_interrupt_scheme(mucse);
 	if (err) {
 		dev_err(&pdev->dev, "init interrupt failed %d\n", err);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
index de5e29230b3c..1d4e2ae78154 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -247,6 +247,26 @@ int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
 	return mucse_read_mbx_pf(hw, msg, size);
 }
 
+/**
+ * mucse_check_and_read_mbx - check if there is notification and receive message
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer, negative errno on failure
+ **/
+int mucse_check_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int err;
+
+	err = mucse_check_for_msg_pf(hw);
+	if (err)
+		return err;
+
+	return mucse_read_mbx_pf(hw, msg, size);
+}
+
 /**
  * mucse_mbx_get_fwack - Read fw ack from reg
  * @mbx: pointer to the MBX structure
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
index e6fcc8d1d3ca..cba54a07a7fa 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -17,4 +17,5 @@
 int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
 void mucse_init_mbx_params_pf(struct mucse_hw *hw);
 int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_check_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
 #endif /* _RNPGBE_MBX_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 8c8bd5e8e1db..3eef31f4289a 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/bitfield.h>
+#include <linux/ethtool.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx.h"
@@ -189,3 +190,168 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 
 	return 0;
 }
+
+/**
+ * mucse_mbx_phyup - Echo fw let the phy up
+ * @hw: pointer to the HW structure
+ * @is_phyup: true for up, false for down
+ *
+ * mucse_mbx_phyup echo fw to change phy status
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_phyup(struct mucse_hw *hw, bool is_phyup)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen = cpu_to_le16(sizeof(req.phy_status) +
+				       MUCSE_MBX_REQ_HDR_LEN),
+		.opcode  = cpu_to_le16(SET_PHY_UP),
+		.phy_status = {
+			.port_mask = cpu_to_le32(BIT(hw->port)),
+			.status  = cpu_to_le32(is_phyup ? 1 : 0),
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_link_report - Echo fw report link change event or not
+ * @hw: pointer to the HW structure
+ * @is_report: true for report, false for no
+ *
+ * mucse_mbx_link_eventup echo fw to change event report state
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report)
+{
+	struct mbx_fw_cmd_req req = {
+		.datalen = cpu_to_le16(sizeof(req. report_status) +
+				       MUCSE_MBX_REQ_HDR_LEN),
+		.opcode  = cpu_to_le16(LINK_REPORT_EN),
+		.report_status = {
+			.port_mask = cpu_to_le16(BIT(hw->port)),
+			.status  = cpu_to_le16(is_report ? 1 : 0),
+		},
+	};
+	int len, err;
+
+	len = le16_to_cpu(req.datalen);
+	mutex_lock(&hw->mbx.lock);
+	err = mucse_write_and_wait_ack_mbx(hw, (u32 *)&req, len);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_update_link_status_reg - update driver speed inf to reg
+ * @hw: pointer to the HW structure
+ * @req: pointer to req data
+ *
+ * mucse_update_link_status_reg update reg according to driver info,
+ * fw will send irq if status is differ with reg
+ *
+ **/
+static void mucse_update_link_status_reg(struct mucse_hw *hw,
+					 struct mbx_fw_cmd_req *req)
+{
+	u16 status = le16_to_cpu(req->link_stat.st.status);
+	u32 value;
+
+	value = mucse_hw_rd32(hw, RNPGBE_LINK_ST);
+	value &= ~M_ST_MASK;
+	value |= M_DEFAULT_ST;
+
+	if (le16_to_cpu(req->link_stat.port_status)) {
+		value |= BIT(0);
+		switch (hw->speed) {
+		case 10:
+			value |= (mucse_speed_10 << 8);
+			break;
+		case 100:
+			value |= (mucse_speed_100 << 8);
+			break;
+		case 1000:
+			value |= (mucse_speed_1000 << 8);
+			break;
+		default:
+			/* invalid speed do nothing */
+			break;
+		}
+
+		value |= FIELD_PREP(BIT(4), !!hw->duplex);
+		value |= FIELD_PREP(GENMASK_U32(25, 24), status & GENMASK(1, 0));
+	} else {
+		value &= ~BIT(0);
+	}
+
+	if (status & ST_STATUS_LLDP_STATUS_MASK)
+		value |= BIT(6);
+	else
+		value &= ~BIT(6);
+
+	mucse_hw_wr32(hw, RNPGBE_LINK_ST, value);
+}
+
+/**
+ * mucse_mbx_fw_req_handler - Handle fw req
+ * @hw: pointer to the HW structure
+ * @req: pointer to req data
+ *
+ * rnpgbe_mbx_fw_req_handler handler fw req, such as a link event req.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
+				     struct mbx_fw_cmd_req *req)
+{
+	struct mucse *mucse = container_of(hw, struct mucse, hw);
+	u32 magic = le32_to_cpu(req->link_stat.port_magic);
+	unsigned long flags;
+
+	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
+		spin_lock_irqsave(&mucse->link_lock, flags);
+
+		if (le16_to_cpu(req->link_stat.port_status))
+			hw->link = true;
+		else
+			hw->link = false;
+
+		if (magic == ST_VALID_MAGIC) {
+			hw->speed = le16_to_cpu(req->link_stat.st.speed);
+			hw->duplex = req->link_stat.st.flags & DUPLEX_BIT;
+			/* update regs to notify link info is received from fw */
+			mucse_update_link_status_reg(hw, req);
+		} else {
+			hw->speed = 0;
+			hw->duplex = 0;
+		}
+		mucse->flags |= M_FLAG_NEED_LINK_UPDATE;
+		spin_unlock_irqrestore(&mucse->link_lock, flags);
+	}
+}
+
+/**
+ * mucse_fw_irq_handler - Try to handle a req from hw
+ * @hw: pointer to the HW structure
+ **/
+void mucse_fw_irq_handler(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_req req = {};
+
+	/* try to check and read fw req */
+	if (mucse_check_and_read_mbx(hw, (u32 *)&req, sizeof(req)))
+		return;
+
+	/* handle it if is a req from fw */
+	if (!(le16_to_cpu(req.flags) & FLAGS_REPLY))
+		mucse_mbx_fw_req_handler(hw, &req);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index fb24fc12b613..691ee8f39cac 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -14,6 +14,9 @@ enum MUCSE_FW_CMD {
 	GET_HW_INFO     = 0x0601,
 	GET_MAC_ADDRESS = 0x0602,
 	RESET_HW        = 0x0603,
+	LINK_CHANGE_EVT = 0x0608,
+	LINK_REPORT_EN  = 0x0613,
+	SET_PHY_UP      = 0x0800,
 	POWER_UP        = 0x0803,
 };
 
@@ -36,6 +39,16 @@ struct mucse_hw_info {
 	__le32 ext_info;
 } __packed;
 
+#define ST_STATUS_LLDP_STATUS_MASK        BIT(12)
+
+#define DUPLEX_BIT                        BIT(0)
+struct st_status {
+	u8 phyid;
+	u8 flags;
+	__le16 speed;
+	__le16 status;
+} __packed;
+
 struct mbx_fw_cmd_req {
 	__le16 flags;
 	__le16 opcode;
@@ -55,10 +68,26 @@ struct mbx_fw_cmd_req {
 			__le32 port_mask;
 			__le32 pfvf_num;
 		} get_mac_addr;
+		struct {
+			__le32 port_mask;
+			__le32 status;
+		} phy_status;
+		struct {
+			__le16 status;
+			__le16 port_mask;
+		} report_status;
+		struct {
+			__le16 changed_lanes;
+			__le16 port_status;
+			__le32 port_magic;
+#define ST_VALID_MAGIC 0xa4a6a8a9
+			struct st_status st;
+		} link_stat;
 	};
 } __packed;
 
 struct mbx_fw_cmd_reply {
+#define FLAGS_REPLY       BIT(0)
 	__le16 flags;
 	__le16 opcode;
 	__le16 error_code;
@@ -80,9 +109,18 @@ struct mbx_fw_cmd_reply {
 	};
 } __packed;
 
+enum mucse_speed {
+	mucse_speed_10,
+	mucse_speed_100,
+	mucse_speed_1000,
+};
+
 int mucse_mbx_sync_fw(struct mucse_hw *hw);
 int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup);
 int mucse_mbx_reset_hw(struct mucse_hw *hw);
 int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 			  u8 *mac_addr, int port);
+int mucse_mbx_phyup(struct mucse_hw *hw, bool is_phyup);
+int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report);
+void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


