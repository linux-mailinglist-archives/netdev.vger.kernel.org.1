Return-Path: <netdev+bounces-208578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6372B0C334
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524461AA28D2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5202D3754;
	Mon, 21 Jul 2025 11:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CE2D29B5;
	Mon, 21 Jul 2025 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097685; cv=none; b=rwtlGehEKiT1H2qyOFERc1QtAg6ipvFKLP8tHM37h5TRIhlSneMle6UVJliY/RUaMFDyiUWsOkotwR0iq+Rw3kQKK/YGOsgBRvXBQ89dpHSONZGZPOwIl7M3FIUh9cIj3TQUs1EtD1cLsuY51Hmf5/UvbYRAyG2OLB6bPLGolvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097685; c=relaxed/simple;
	bh=9k8/HCCq3MQpVaHDwu3CP1V7EMK0zK5PNQmNTzeIYgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxC0Qh5W6hMibwfGfV5oRPfsxMBufpRe96i97yQiFF0WTDUcnSh3Nc8AsKdM2VU7tszjpNrh9Biqbp7sGXeT0SldSPDcuIjnCF6qaiU0YjGm2YArIJ+iRvWSnys9io/zeWB4aLFA1Qc99nf8SyEk3UEv2cr1tkofz0F8O9LjNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097594tfdda31d7
X-QQ-Originating-IP: Vt/tiO7TvsfG2aaZyYNcDWVQ16RkHy59UJCH1drGIpQ=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6926418822098371029
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 06/15] net: rnpgbe: Add some functions for hw->ops
Date: Mon, 21 Jul 2025 19:32:29 +0800
Message-Id: <20250721113238.18615-7-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MxFwHSywoLiFF95UQJ+D2tKOKS7iGHEW1iO5G1X7yzFWmUcvdt7llyN+
	MdFQNQ3ZJhAuVBtOMLA/MNVFiQpmbdBYadtkc/a0sxurgNR0BwJdt7Nr0rXIm5hE0t6SDo+
	qgbcINGnRNdd06IezovewlERg2TSVoaTjfDpsZAvCGHaPK5zBKiwrXHKP9mo8R3rTHwVvGS
	pcH17Dn9xYP+WD+tM1Cuk9Yn10os75mh+L3ojY1+NUwjaibIC5E8hiV00lRffbW/dJOE4+B
	wtO7j+u8R2l7wCwnetZ6GWZGIXcR15gCT/sOyH7/GQspnLGIxk6auP1k8b5eRZCQ1YflmJD
	ysyFvlxfITpkC6cAPsvN9lYtTNUBfPr3cV20CYurM3DChp72YmK+XH/T+B4VOug15z+HVC9
	pcrNOug9cIWfE+gb+2cARbFiFBslEUilao2f/vFC8GxyUNDOiR/HDIZMQ6pCquSRGxTR93h
	+BTCNkZWvT1bBcUZoxxXBm5mZTXIN5v9nKBOS/ZkpQhosVGMvoSBixZACSUaraav+xZmlK5
	Blm74s5z5Uily0I9efiEla/R526T+oSmQKqKLg6ERt28ZJ5VwZssuXJ1rF6RNtVQM86ypp+
	uDfBHNtByQqMkfV6OXD7VPF8Zgw91+Wj7h4TVumaxWS2tDwxM5sIeNc/l9SHwdHWiPxA3+b
	bRuMaX2xjPJzNNMx1p8phntaLItgSD1UC/oh954jRkR10gIlUFqflNN8NRGu7RfuZKVE2sx
	LI7goJ2b01FZxfV7emSBfXG8IsfGsluH7KhZWIoPrX+WKfuQ2vl4mdE8S1ImaaAmFK/BeUM
	3bsnG4vJJuWkA3MDiFVwVKreDvyP/Lm0fGiZO6tJ2BQF6Dvn2Jmf1qfYOi+JPforqRu9SFS
	j6LQIOhdScLJeTEU4Ns/brDwATPGRIy/rc0tzP/1WV2sq7QZmYNctJwvRmxU5TrqoJhJoX3
	em//2zX3dgdnpoZKzZeNS+m5I16JtdtWX22rSXvfGpbYvRgYFbpCeEjPg2HSjhN049401z0
	2S4FBwge+bzrdZZaNo3juUBR2Ovn5+rihjUdeQ1ayDeowV00hfKXjzy3HLHJs=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize functions (init, reset ...) to control chip.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  35 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 107 ++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  15 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  28 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 255 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  74 +++++
 6 files changed, 513 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index ea28236669e3..527091e6a680 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -144,6 +144,25 @@ struct mucse_mbx_info {
 
 #include "rnpgbe_mbx.h"
 
+struct lldp_status {
+	int enable;
+	int inteval;
+};
+
+struct mucse_hw_operations {
+	int (*init_hw)(struct mucse_hw *hw);
+	int (*reset_hw)(struct mucse_hw *hw);
+	void (*start_hw)(struct mucse_hw *hw);
+	/* ops to fw */
+	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
+};
+
+enum {
+	mucse_driver_insmod,
+	mucse_driver_suspuse,
+	mucse_driver_force_control_phy,
+};
+
 struct mucse_hw {
 	void *back;
 	u8 pfvfnum;
@@ -166,6 +185,7 @@ struct mucse_hw {
 	int max_vfs;
 	int max_vfs_noari;
 	enum rnpgbe_hw_type hw_type;
+	struct mucse_hw_operations ops;
 	struct mucse_dma_info dma;
 	struct mucse_eth_info eth;
 	struct mucse_mac_info mac;
@@ -190,7 +210,11 @@ struct mucse_hw {
 #define M_HW_FEATURE_EEE BIT(17)
 #define M_HW_SOFT_MASK_OTHER_IRQ BIT(18)
 	u32 feature_flags;
+	u32 driver_version;
 	u16 usecstocount;
+	int nr_lane;
+	struct lldp_status lldp_status;
+	int link;
 };
 
 struct mucse {
@@ -225,5 +249,16 @@ struct rnpgbe_info {
 
 #define m_rd_reg(reg) readl(reg)
 #define m_wr_reg(reg, val) writel((val), reg)
+#define hw_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
+#define dma_wr32(dma, reg, val) m_wr_reg((dma)->dma_base_addr + (reg), (val))
+#define dma_rd32(dma, reg) m_rd_reg((dma)->dma_base_addr + (reg))
+#define eth_wr32(eth, reg, val) m_wr_reg((eth)->eth_base_addr + (reg), (val))
+#define eth_rd32(eth, reg) m_rd_reg((eth)->eth_base_addr + (reg))
+
+#define mucse_err(mucse, fmt, arg...) \
+	dev_err(&(mucse)->pdev->dev, fmt, ##arg)
+
+#define mucse_dbg(mucse, fmt, arg...) \
+	dev_dbg(&(mucse)->pdev->dev, fmt, ##arg)
 
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index b0e5fda632f3..7a162b844fe4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -7,6 +7,111 @@
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
 #include "rnpgbe_mbx.h"
+#include "rnpgbe_mbx_fw.h"
+
+/**
+ * rnpgbe_init_hw_ops_n500 - Init hardware
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_hw_ops_n500 first do a hw reset, then
+ * tries to start hw
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_init_hw_ops_n500(struct mucse_hw *hw)
+{
+	int status = 0;
+	/* Reset the hardware */
+	status = hw->ops.reset_hw(hw);
+	if (status == 0)
+		hw->ops.start_hw(hw);
+
+	return status;
+}
+
+/**
+ * rnpgbe_reset_hw_ops_n500 - Do a hardware reset
+ * @hw: hw information structure
+ *
+ * rnpgbe_reset_hw_ops_n500 calls fw to do a hardware
+ * reset, and cleans some regs to default.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_reset_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	struct mucse_eth_info *eth = &hw->eth;
+	int err;
+	int i;
+	/* Call hw to stop dma */
+	dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
+	err = mucse_mbx_fw_reset_phy(hw);
+	if (err)
+		return err;
+	eth_wr32(eth, RNPGBE_ETH_ERR_MASK_VECTOR,
+		 RNPGBE_PKT_LEN_ERR | RNPGBE_HDR_LEN_ERR);
+	dma_wr32(dma, RNPGBE_DMA_RX_PROG_FULL_THRESH, 0xa);
+	for (i = 0; i < 12; i++)
+		m_wr_reg(hw->ring_msix_base + RING_VECTOR(i), 0);
+
+	hw->link = 0;
+
+	return 0;
+}
+
+/**
+ * rnpgbe_start_hw_ops_n500 - Setup hw to start
+ * @hw: hw information structure
+ *
+ * rnpgbe_start_hw_ops_n500 initializes default
+ * hw status, ready to start.
+ *
+ **/
+static void rnpgbe_start_hw_ops_n500(struct mucse_hw *hw)
+{
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_dma_info *dma = &hw->dma;
+	u32 value;
+
+	value = dma_rd32(dma, RNPGBE_DMA_DUMY);
+	value |= BIT(0);
+	dma_wr32(dma, RNPGBE_DMA_DUMY, value);
+	dma_wr32(dma, RNPGBE_DMA_CONFIG, DMA_VEB_BYPASS);
+	dma_wr32(dma, RNPGBE_DMA_AXI_EN, (RX_AXI_RW_EN | TX_AXI_RW_EN));
+	eth_wr32(eth, RNPGBE_ETH_BYPASS, 0);
+	eth_wr32(eth, RNPGBE_ETH_DEFAULT_RX_RING, 0);
+}
+
+/**
+ * rnpgbe_driver_status_hw_ops_n500 - Echo driver status to hw
+ * @hw: hw information structure
+ * @enable: true or false status
+ * @mode: status mode
+ **/
+static void rnpgbe_driver_status_hw_ops_n500(struct mucse_hw *hw,
+					     bool enable,
+					     int mode)
+{
+	switch (mode) {
+	case mucse_driver_insmod:
+		mucse_mbx_ifinsmod(hw, enable);
+		break;
+	case mucse_driver_suspuse:
+		mucse_mbx_ifsuspuse(hw, enable);
+		break;
+	case mucse_driver_force_control_phy:
+		mucse_mbx_ifforce_control_mac(hw, enable);
+		break;
+	}
+}
+
+static struct mucse_hw_operations hw_ops_n500 = {
+	.init_hw = &rnpgbe_init_hw_ops_n500,
+	.reset_hw = &rnpgbe_reset_hw_ops_n500,
+	.start_hw = &rnpgbe_start_hw_ops_n500,
+	.driver_status = &rnpgbe_driver_status_hw_ops_n500,
+};
 
 /**
  * rnpgbe_get_invariants_n500 - setup for hw info
@@ -84,7 +189,9 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 			     M_NET_FEATURE_STAG_OFFLOAD;
 	/* start the default ahz, update later */
 	hw->usecstocount = 125;
+	hw->max_vfs_noari = 1;
 	hw->max_vfs = 7;
+	memcpy(&hw->ops, &hw_ops_n500, sizeof(hw->ops));
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index ff7bd9b21550..35e3cb77a38b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -14,8 +14,21 @@
 #define RNPGBE_RING_BASE (0x1000)
 #define RNPGBE_MAC_BASE (0x20000)
 #define RNPGBE_ETH_BASE (0x10000)
-
+/* dma regs */
+#define DMA_VEB_BYPASS BIT(4)
+#define RNPGBE_DMA_CONFIG (0x0004)
 #define RNPGBE_DMA_DUMY (0x000c)
+#define RNPGBE_DMA_AXI_EN (0x0010)
+#define RX_AXI_RW_EN (0x03 << 0)
+#define TX_AXI_RW_EN (0x03 << 2)
+#define RNPGBE_DMA_RX_PROG_FULL_THRESH (0x00a0)
+#define RING_VECTOR(n) (0x04 * (n))
+/* eth regs */
+#define RNPGBE_ETH_BYPASS (0x8000)
+#define RNPGBE_ETH_ERR_MASK_VECTOR (0x8060)
+#define RNPGBE_ETH_DEFAULT_RX_RING (0x806c)
+#define RNPGBE_PKT_LEN_ERR (2)
+#define RNPGBE_HDR_LEN_ERR (1)
 /* chip resourse */
 #define RNPGBE_MAX_QUEUES (8)
 /* multicast control table */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 61dd0d232d99..ba21e3858c0e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -38,6 +38,17 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_sw_init - Init driver private status
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_sw_init(struct mucse *mucse)
+{
+	return 0;
+}
+
 /**
  * rnpgbe_add_adapter - add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -127,8 +138,12 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 	hw->hw_addr = hw_addr;
 	hw->dma.dma_version = dma_version;
+	hw->driver_version = 0x0002040f;
+	hw->nr_lane = 0;
 	ii->get_invariants(hw);
 	hw->mbx.ops.init_params(hw);
+	/* echo fw driver insmod */
+	hw->ops.driver_status(hw, true, mucse_driver_insmod);
 
 	err = mucse_mbx_get_capability(hw);
 	if (err) {
@@ -137,6 +152,16 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 		goto err_free_net;
 	}
 
+	err = rnpgbe_sw_init(mucse);
+	if (err)
+		goto err_free_net;
+
+	err = hw->ops.reset_hw(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Hw reset failed\n");
+		goto err_free_net;
+	}
+
 	return 0;
 
 err_free_net:
@@ -202,11 +227,14 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_rm_adapter(struct mucse *mucse)
 {
+	struct mucse_hw *hw = &mucse->hw;
 	struct net_device *netdev;
 
 	rnpgbe_devlink_unregister(mucse);
 	netdev = mucse->netdev;
+	hw->ops.driver_status(hw, false, mucse_driver_insmod);
 	free_netdev(netdev);
+	mucse->netdev = NULL;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index 1674229fcd43..18f57ef8b1ad 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 
+#include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
 
 /**
@@ -138,3 +139,257 @@ int mucse_mbx_get_capability(struct mucse_hw *hw)
 
 	return err;
 }
+
+/**
+ * mbx_req_cookie - Alloc a cookie structure
+ * @priv_len: private length for this cookie
+ *
+ * @return: cookie structure on success
+ **/
+static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
+{
+	struct mbx_req_cookie *cookie;
+
+	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
+
+	if (cookie) {
+		cookie->timeout_jiffes = 30 * HZ;
+		cookie->magic = COOKIE_MAGIC;
+		cookie->priv_len = priv_len;
+	}
+
+	return cookie;
+}
+
+/**
+ * mucse_mbx_fw_post_req - Posts a mbx req to firmware and wait reply
+ * @hw: Pointer to the HW structure
+ * @req: Pointer to the cmd req structure
+ * @cookie: Pointer to the req cookie
+ *
+ * mucse_mbx_fw_post_req posts a mbx req to firmware and wait for the
+ * reply. cookie->wait will be set in irq handler.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
+				 struct mbx_fw_cmd_req *req,
+				 struct mbx_req_cookie *cookie)
+{
+	int len = le32_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
+	int err = 0;
+
+	cookie->errcode = 0;
+	cookie->done = 0;
+	init_waitqueue_head(&cookie->wait);
+
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	err = mucse_write_mbx(hw, (u32 *)req,
+			      L_WD(len),
+			      MBX_FW);
+	if (err) {
+		mutex_unlock(&hw->mbx.lock);
+		return err;
+	}
+
+	if (cookie->timeout_jiffes != 0) {
+retry:
+		err = wait_event_interruptible_timeout(cookie->wait,
+						       cookie->done == 1,
+						       cookie->timeout_jiffes);
+		if (err == -ERESTARTSYS)
+			goto retry;
+		if (err == 0)
+			err = -ETIME;
+		else
+			err = 0;
+	} else {
+retry_no_timeout:
+		err = wait_event_interruptible(cookie->wait, cookie->done == 1);
+		if (err == -ERESTARTSYS)
+			goto retry_no_timeout;
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+
+	if (cookie->errcode)
+		err = cookie->errcode;
+
+	return err;
+}
+
+/**
+ * rnpgbe_mbx_lldp_get - Get lldp status from hw
+ * @hw: Pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_mbx_lldp_get(struct mucse_hw *hw)
+{
+	struct mbx_req_cookie *cookie = NULL;
+	struct get_lldp_reply *get_lldp;
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int err;
+
+	cookie = mbx_cookie_zalloc(sizeof(*get_lldp));
+	if (!cookie)
+		return -ENOMEM;
+
+	get_lldp = (struct get_lldp_reply *)cookie->priv;
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_get_lldp_req(&req, cookie, hw->nr_lane);
+	if (hw->mbx.irq_enabled) {
+		err = mucse_mbx_fw_post_req(hw, &req, cookie);
+	} else {
+		err = mucse_fw_send_cmd_wait(hw, &req, &reply);
+		get_lldp = &reply.get_lldp;
+	}
+
+	if (err == 0) {
+		hw->lldp_status.enable = le32_to_cpu(get_lldp->value);
+		hw->lldp_status.inteval = le32_to_cpu(get_lldp->inteval);
+	}
+
+	kfree(cookie);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_ifinsmod - Echo driver insmod status to hw
+ * @hw: Pointer to the HW structure
+ * @status: true for insmod, false for rmmod
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int len;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifinsmod(&req, hw->driver_version, status);
+	len = le32_to_cpu(req.datalen) + MBX_REQ_HDR_LEN;
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	if (status) {
+		err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+					       L_WD(len),
+					       MBX_FW);
+	} else {
+		err = hw->mbx.ops.write(hw, (u32 *)&req,
+					L_WD(len),
+					MBX_FW);
+	}
+
+	mutex_unlock(&hw->mbx.lock);
+	return err;
+}
+
+/**
+ * mucse_mbx_ifsuspuse - Echo driver suspuse status to hw
+ * @hw: Pointer to the HW structure
+ * @status: true for suspuse, false for no susupuse
+ *
+ * mucse_mbx_ifsuspuse echo driver susupus status to hw. The
+ * status is used to enter wol status for hw.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifsuspuse(struct mucse_hw *hw, int status)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int len;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifsuspuse(&req, hw->nr_lane, status);
+	len = le32_to_cpu(req.datalen) + MBX_REQ_HDR_LEN;
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+				       L_WD(len),
+				       MBX_FW);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_ifforce_control_mac - Echo force mac control to hw
+ * @hw: Pointer to the HW structure
+ * @status: true for force control, false for not
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status)
+{
+	struct mbx_fw_cmd_reply reply;
+	struct mbx_fw_cmd_req req;
+	int len;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	build_ifforce(&req, hw->nr_lane, status);
+	len = le32_to_cpu(req.datalen) + MBX_REQ_HDR_LEN;
+	err = mutex_lock_interruptible(&hw->mbx.lock);
+	if (err)
+		return err;
+
+	err = hw->mbx.ops.write_posted(hw, (u32 *)&req,
+				       L_WD(len),
+				       MBX_FW);
+	mutex_unlock(&hw->mbx.lock);
+
+	return err;
+}
+
+/**
+ * mucse_mbx_fw_reset_phy - Posts a mbx req to reset hw
+ * @hw: Pointer to the HW structure
+ *
+ * mucse_mbx_fw_reset_phy posts a mbx req to firmware to reset hw.
+ * It uses mucse_fw_send_cmd_wait if no irq, and mucse_mbx_fw_post_req
+ * if other irq is registered.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
+{
+	struct mbx_fw_cmd_req req;
+	struct mbx_fw_cmd_reply reply;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	if (hw->mbx.irq_enabled) {
+		struct mbx_req_cookie *cookie = mbx_cookie_zalloc(0);
+
+		if (!cookie)
+			return -ENOMEM;
+
+		build_reset_phy_req(&req, cookie);
+		ret = mucse_mbx_fw_post_req(hw, &req, cookie);
+		kfree(cookie);
+		return ret;
+
+	} else {
+		build_reset_phy_req(&req, &req);
+		return mucse_fw_send_cmd_wait(hw, &req, &reply);
+	}
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
index a24c5d4e0075..9e07858f2733 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
@@ -563,6 +563,80 @@ static inline void build_phy_abalities_req(struct mbx_fw_cmd_req *req,
 	req->cookie = cookie;
 }
 
+static inline void build_get_lldp_req(struct mbx_fw_cmd_req *req, void *cookie,
+				      int nr_lane)
+{
+#define LLDP_TX_GET (1)
+
+	req->flags = 0;
+	req->opcode = cpu_to_le32(LLDP_TX_CTRL);
+	req->datalen = cpu_to_le32(sizeof(req->lldp_tx));
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->lldp_tx.lane = cpu_to_le32(nr_lane);
+	req->lldp_tx.op = cpu_to_le32(LLDP_TX_GET);
+	req->lldp_tx.enable = 0;
+}
+
+static inline void build_ifinsmod(struct mbx_fw_cmd_req *req,
+				  unsigned int nr_lane,
+				  int status)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(DRIVER_INSMOD);
+	req->datalen = cpu_to_le32(sizeof(req->ifinsmod));
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifinsmod.lane = cpu_to_le32(nr_lane);
+	req->ifinsmod.status = cpu_to_le32(status);
+}
+
+static inline void build_ifsuspuse(struct mbx_fw_cmd_req *req,
+				   unsigned int nr_lane,
+				   int status)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(SYSTEM_SUSPUSE);
+	req->datalen = cpu_to_le32(sizeof(req->ifsuspuse));
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifinsmod.lane = cpu_to_le32(nr_lane);
+	req->ifinsmod.status = cpu_to_le32(status);
+}
+
+static inline void build_ifforce(struct mbx_fw_cmd_req *req,
+				 unsigned int nr_lane,
+				 int status)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(SYSTEM_FORCE);
+	req->datalen = cpu_to_le32(sizeof(req->ifforce));
+	req->cookie = NULL;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->ifforce.lane = cpu_to_le32(nr_lane);
+	req->ifforce.status = cpu_to_le32(status);
+}
+
+static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
+				       void *cookie)
+{
+	req->flags = 0;
+	req->opcode = cpu_to_le32(RESET_PHY);
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
 int mucse_mbx_get_capability(struct mucse_hw *hw);
+int rnpgbe_mbx_lldp_get(struct mucse_hw *hw);
+int mucse_mbx_ifinsmod(struct mucse_hw *hw, int status);
+int mucse_mbx_ifsuspuse(struct mucse_hw *hw, int status);
+int mucse_mbx_ifforce_control_mac(struct mucse_hw *hw, int status);
+int mucse_mbx_fw_reset_phy(struct mucse_hw *hw);
 
 #endif /* _RNPGBE_MBX_FW_H */
-- 
2.25.1


