Return-Path: <netdev+bounces-285186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM4QLGJL/GmZNwAAu9opvQ
	(envelope-from <netdev+bounces-285186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:20:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D44E4AC6
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D771F307374B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E537F8DF;
	Thu,  7 May 2026 08:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85E349AE0;
	Thu,  7 May 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141896; cv=none; b=KU/k5bL17Ei0PTU2I7ixOhYhtsqGt6OIlKkFOLRUhxWxAAl3L81dgW45YX088NFnoDuOzIW9J+3xif3bvUZ5JunYhNOxKhV1pbzIMXqOoUc0wSd5SlwLS6zzZN30dpRi+WDNEQM6PF3RrKsYIS5FsdNGuf7JwOW9I+NlpwSg7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141896; c=relaxed/simple;
	bh=9NUyGwt4knGFbnoSl1joWh5XEcXZXgAuNHRKPbFzOBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IECTvs29AEfOEmG7v7e9+/iTqg9TUD9s84qUKFUb8a2kkUnBeOnlrARGxB9cqb+o/jM5ywipmkeSm97c4SQlGiCu68hzxBuvC6CVSoJovDeaMYENPcMQIVzWPgy9Ej7M6ueV8YkdcUNV3PJl+/+VhqjyVbf+Qmf62aU8SbygP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1778141765t3da93f5a
X-QQ-Originating-IP: Q6BhR/ESnlU1s61Ug8bCQddtymwyG2cgSB8NQw9VVyw=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 16:16:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5789047016288834633
EX-QQ-RecipientCnt: 12
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
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v3 4/4] net: rnpgbe: Add link status handling support
Date: Thu,  7 May 2026 16:15:39 +0800
Message-Id: <20260507081539.171844-5-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507081539.171844-1-dong100@mucse.com>
References: <20260507081539.171844-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OCeVnjjBDJK9BbwAJg9ze1ClhPBsp+XTXCWpKcpma1hby8dQ7kr/q1hq
	8LwVxzuhDlxSc33JNfk7HJjKqb2DLOW51JewWlym7+gBEyadacevZMWg0nVycHKsnDOiZ+4
	tGPdHk8NTD+McGX9nHzp1MDRJEQcMoSuQkwOwEcsUpSwK76uJZ/N5tRRRdy3/s1yieYLbZl
	wlGEb685/vwQh77+veKwy4PaNNaCcSuB122UdHacxv0ZXkLnwiusNtCCBeq2w42q94+yrvc
	nwGha5VnyBLdO3xGi0inrNrte7jyluPBQl2ejBx0pqRundrA2uVRHlSJjWO+PZ7+suewcHa
	dTM75dfYOAXEBEbKvU7u+gfy4mSrsEwHNQim/ascVDceZULn+oEhOKnFZNEV8ctLxc8K/8W
	+FS3EWfhpA/pubzf3nb+JF+DCZq5Er+CBZntPdBfTMYbjFHAPIin/KktNtNEyiARVqBG6M9
	YssZug6lTnG5YwFNmZXUXRE/xAyNi6UKs5r2ETaFaIYAS3PtXm8mDz73F1SiEOnL9wbnKRJ
	a0DmU/2bAoncTbmhpygkxQOg62pRDOyfA4cDBw1yL/uvq8nPvSmI6ubxuzbvU6xFlXA+uoM
	yHKUwtfR4yT2FgPcK9SoUyPXYyN6LbpU/UG83oO5GCtICU5odywX+yvIGOtI8GyzJnyOMmO
	ZaUU2LIPUps6uwfC82Fpf5a2cgX0ylOl6Gzu+o7DL+cpNCF9XGmjpkNtohnE5xZF3jxqopD
	EJKEZn33zUBThfbvHohcJdwCk6+337mhmcogO1PzzWFCsjSStOxj5Otdt/Sutgc4VYjF19Q
	HgkgCRa5RJ8f6dkHPgBfcYwsY3/64J4cnIH8LIQhwzotH1jGvhgI5P9J1sgYCgo8sC1m9Mc
	ARCqzMPa8WcIcunxZgBFBI7M3lEFkid6WlihVERkP6G3z+Z0lp8jp03SydP7z/M+odX6Jke
	D2grlWJZtiQzenfLHZWIuCZY2JXYCLSMP2xOLedrziPkLnClNQqc7bzj9vMBTDyC4AI4BoN
	8xJj0UGMq5lFyUblE0Z9mZTJnqgjKLIPqfQl8zo6i82RPtRREepLCmpnfhoXXxgUWguvF45
	Qvwjz5oTJ7kbeVsAxgGbPdgsZNGHiDKTg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 3B0D44E4AC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285186-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add link status management infrastructure to the rnpgbe driver:
- Add link status related data structures (speed, duplex, link state)
- Implement firmware link event handling via mailbox
- Add service task for periodic link status monitoring
- Implement carrier status management (netif_carrier_on/off)
- Add port up/down notification to firmware

This enables the driver to properly track and report link status changes.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  33 ++-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  13 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 163 ++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  23 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 189 +++++++++++++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  38 ++++
 10 files changed, 480 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 9c200b3bdebc..12c0ad6df535 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -16,25 +16,32 @@ enum rnpgbe_boards {
 	board_n210
 };
 
+struct mbx_req_cookie {
+	int timeout;
+	struct completion comp;
+	u8 cmd[56];
+};
+
 struct mucse_mbx_info {
 	u32 timeout_us;
 	u32 delay_us;
 	u16 fw_req;
 	u16 fw_ack;
+	struct mbx_req_cookie cookie;
 	/* lock for only one use mbx */
 	struct mutex lock;
 	/* fw <--> pf mbx */
+	bool irq_en;
 	u32 fwpf_shm_base;
 	u32 pf2fw_mbx_ctrl;
 	u32 fwpf_mbx_mask;
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
@@ -43,8 +50,11 @@ struct mucse_hw {
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
@@ -189,6 +199,10 @@ struct mucse_q_vector {
 #define M_DEFAULT_RXD     512
 #define M_DEFAULT_TX_WORK 256
 
+enum mucse_state_t {
+	__MUCSE_DOWN,
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -196,6 +210,7 @@ struct mucse {
 #define M_FLAG_MSI_EN              BIT(0)
 #define M_FLAG_MSIX_SINGLE_EN      BIT(1)
 #define M_FLAG_MSIX_EN             BIT(2)
+#define M_FLAG_NEED_LINK_UPDATE    BIT(3)
 	u32 flags;
 	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
 		____cacheline_aligned_in_smp;
@@ -209,6 +224,9 @@ struct mucse {
 	int rx_ring_item_count;
 	int num_rx_queues;
 	char mbx_name[32];
+	unsigned long state;
+	struct delayed_work serv_task;
+	spinlock_t link_lock; /* spinlock for link update */
 };
 
 int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr);
@@ -217,6 +235,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+void rnpgbe_set_rx(struct mucse_hw *hw, bool enable);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 291e77d573fe..8986bd325306 100644
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
@@ -149,3 +155,28 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
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
+	if (enable)
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
+	else
+		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 03688586b447..4d1a9a386e9d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -17,7 +17,20 @@
 
 #define TX_AXI_RW_EN                   0xc
 #define RX_AXI_RW_EN                   0x03
+/* mask all valid info */
+#define M_ST_MASK                      0xff000f11
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
+#define GMAC_RX_ALL                    (BIT(31) | BIT(0))
+#define GMAC_FRAME_FILTER              MUCSE_GMAC_OFF(0x4)
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index e0b8e44ee5d8..f7b553a6eb52 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -557,11 +557,16 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 			clean_complete = false;
 	}
 
+	if (test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+		clean_complete = true;
+
 	if (!clean_complete)
 		return budget;
 
-	if (likely(napi_complete_done(napi, work_done)))
-		rnpgbe_irq_enable_queues(q_vector);
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
+			rnpgbe_irq_enable_queues(q_vector);
+	}
 
 	return work_done;
 }
@@ -575,6 +580,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 int register_mbx_irq(struct mucse *mucse)
 {
 	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_hw *hw = &mucse->hw;
 	int err = 0;
 
 	snprintf(mucse->mbx_name, sizeof(mucse->mbx_name),
@@ -584,6 +590,8 @@ int register_mbx_irq(struct mucse *mucse)
 		err = request_irq(pci_irq_vector(pdev, 0),
 				  rnpgbe_msix_other, 0, mucse->mbx_name,
 				  mucse);
+		if (!err)
+			hw->mbx.irq_en = true;
 	}
 
 	return err;
@@ -596,9 +604,12 @@ int register_mbx_irq(struct mucse *mucse)
 void remove_mbx_irq(struct mucse *mucse)
 {
 	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_hw *hw = &mucse->hw;
 
-	if (mucse->flags & M_FLAG_MSIX_EN)
+	if (mucse->flags & M_FLAG_MSIX_EN) {
 		free_irq(pci_irq_vector(pdev, 0), mucse);
+		hw->mbx.irq_en = false;
+	}
 }
 
 /**
@@ -944,6 +955,7 @@ int rnpgbe_request_irq(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
 	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_hw *hw = &mucse->hw;
 	struct mucse_q_vector *q_vector;
 	int err, i;
 
@@ -971,6 +983,7 @@ int rnpgbe_request_irq(struct mucse *mucse)
 				  mucse);
 		if (err)
 			return err;
+		hw->mbx.irq_en = true;
 	}
 
 	return 0;
@@ -993,6 +1006,7 @@ int rnpgbe_request_irq(struct mucse *mucse)
 void rnpgbe_free_irq(struct mucse *mucse)
 {
 	struct pci_dev *pdev = mucse->pdev;
+	struct mucse_hw *hw = &mucse->hw;
 	struct mucse_q_vector *q_vector;
 
 	if (mucse->flags & M_FLAG_MSIX_EN) {
@@ -1005,6 +1019,7 @@ void rnpgbe_free_irq(struct mucse *mucse)
 		}
 	} else {
 		free_irq(pci_irq_vector(pdev, 0), mucse);
+		hw->mbx.irq_en = false;
 	}
 }
 
@@ -1186,7 +1201,26 @@ static void rnpgbe_clean_all_rx_rings(struct mucse *mucse)
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
 	netif_tx_disable(netdev);
 	rnpgbe_napi_disable_all(mucse);
@@ -1202,6 +1236,8 @@ void rnpgbe_down(struct mucse *mucse)
 void rnpgbe_up_complete(struct mucse *mucse)
 {
 	struct net_device *netdev = mucse->netdev;
+	struct mucse_hw *hw = &mucse->hw;
+	int err;
 
 	rnpgbe_configure_msix(mucse);
 	rnpgbe_napi_enable_all(mucse);
@@ -1209,6 +1245,22 @@ void rnpgbe_up_complete(struct mucse *mucse)
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
@@ -1822,3 +1874,108 @@ void rnpgbe_configure_rx(struct mucse *mucse)
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
+	if (!test_bit(__MUCSE_DOWN, &mucse->state))
+		queue_delayed_work(system_wq, &mucse->serv_task,
+				   msecs_to_jiffies(500));
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
index beab4b2a1ea3..fece85f12123 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -87,4 +87,5 @@ void rnpgbe_get_stats64(struct net_device *netdev,
 void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
 int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
 void rnpgbe_free_all_rx_resources(struct mucse *mucse);
+void rnpgbe_service_task(struct work_struct *work);
 #endif
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index fb73120c11a9..b5e06224b2f0 100644
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
index de5e29230b3c..3891e94dbdca 100644
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
@@ -402,5 +422,8 @@ void mucse_init_mbx_params_pf(struct mucse_hw *hw)
 	mbx->delay_us = 100;
 	mbx->timeout_us = 4 * USEC_PER_SEC;
 	mutex_init(&mbx->lock);
+	init_completion(&mbx->cookie.comp);
+	mbx->cookie.timeout = 5 * HZ;
+	mbx->irq_en = false;
 	mucse_mbx_reset(hw);
 }
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
index 05684d716792..21ec16a5fdaf 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/bitfield.h>
+#include <linux/ethtool.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx.h"
@@ -23,6 +24,7 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
 				       struct mbx_fw_cmd_req *req,
 				       struct mbx_fw_cmd_reply *reply)
 {
+	struct mbx_req_cookie *cookie = &hw->mbx.cookie;
 	int len = le16_to_cpu(req->datalen);
 	int retry_cnt = 3;
 	int err;
@@ -32,10 +34,21 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
 	if (err)
 		goto out;
 	do {
-		err = mucse_poll_and_read_mbx(hw, (u32 *)reply,
-					      sizeof(*reply));
-		if (err)
-			goto out;
+		if (hw->mbx.irq_en) {
+			err = wait_for_completion_timeout(&cookie->comp,
+							  cookie->timeout);
+			if (err) {
+				memcpy((u8 *)reply, cookie->cmd,
+				       sizeof(*reply));
+				reinit_completion(&cookie->comp);
+				err = 0;
+			}
+		} else {
+			err = mucse_poll_and_read_mbx(hw, (u32 *)reply,
+						      sizeof(*reply));
+			if (err)
+				goto out;
+		}
 		/* mucse_write_and_wait_ack_mbx return 0 means fw has
 		 * received request, wait for the expect opcode
 		 * reply with 'retry_cnt' times.
@@ -190,10 +203,178 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 	return 0;
 }
 
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
+		.datalen = cpu_to_le16(sizeof(req.report_status) +
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
+		value |= FIELD_PREP(GENMASK_U32(25, 24),
+				    status & GENMASK(1, 0));
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
+		} else {
+			hw->speed = 0;
+			hw->duplex = 0;
+		}
+		/* update regs to notify link info is received */
+		mucse_update_link_status_reg(hw, req);
+		mucse->flags |= M_FLAG_NEED_LINK_UPDATE;
+		spin_unlock_irqrestore(&mucse->link_lock, flags);
+	}
+}
+
+static void mucse_mbx_fw_reply_handler(struct mucse_hw *hw,
+				       struct mbx_fw_cmd_reply *reply)
+{
+	struct mbx_req_cookie *cookie = &hw->mbx.cookie;
+
+	memcpy(cookie->cmd, (u8 *)reply, sizeof(*reply));
+	complete(&cookie->comp);
+}
+
 /**
  * mucse_fw_irq_handler - Try to handle a req from hw
  * @hw: pointer to the HW structure
  **/
 void mucse_fw_irq_handler(struct mucse_hw *hw)
 {
+	struct mbx_fw_cmd_reply reply = {};
+
+	/* try to check and read fw req */
+	if (mucse_check_and_read_mbx(hw, (u32 *)&reply, sizeof(reply)))
+		return;
+
+	if (le16_to_cpu(reply.flags) & FLAGS_REPLY)
+		mucse_mbx_fw_reply_handler(hw, &reply);
+	else
+		mucse_mbx_fw_req_handler(hw, (struct mbx_fw_cmd_req *)&reply);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index aa26c729588c..044d8dfd2c2b 100644
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
@@ -55,10 +68,27 @@ struct mbx_fw_cmd_req {
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
+#define FLAGS_ERR         BIT(2)
 	__le16 flags;
 	__le16 opcode;
 	__le16 error_code;
@@ -80,10 +110,18 @@ struct mbx_fw_cmd_reply {
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
 void mucse_fw_irq_handler(struct mucse_hw *hw);
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


