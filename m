Return-Path: <netdev+bounces-208575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D43B0C324
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FCD5417E4
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73412C08D5;
	Mon, 21 Jul 2025 11:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8485C5E;
	Mon, 21 Jul 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097673; cv=none; b=kWiR2Okbr/dtg0+Rz54Z0FM4TozSa6iTF6+jLVl/KBD6lgkhGJSWDex9pn34BUqLeHocA5+b1SXBBnjTY6IyV5aODeygUl3Spabq+8vk2PWsSuTypyRqZKceqk5xtCl7lD0puDFcgc3nTEvwzXN04d7D8xszG10xl4FVaXSWsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097673; c=relaxed/simple;
	bh=QARVXmFDhKHGkAz+aNCzN9wjhcH2VoDGGykDndqLf08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAFfbiOHQGSSlykl0hBXVUJWGrlk9pWmKB+9dmwjfSHihxsY/3lvXDjvr4GdvDBEhE4jeCqnZtwlVu7FUJ2ypgz8Lk71Au8hBeq5wMegXQmP6feLZZEiyfRjIevZsBotsUEm+lAiaTIS77s5G1zpIXM1aGShMalf16POcRVvkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097590t6f230f0a
X-QQ-Originating-IP: bOXwxOcmGXYDuczOHQZkRQUchsl9P/pLlk7DAq06JEU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3178325155967448401
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
Subject: [PATCH v2 05/15] net: rnpgbe: Add download firmware for n210 chip
Date: Mon, 21 Jul 2025 19:32:28 +0800
Message-Id: <20250721113238.18615-6-dong100@mucse.com>
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
X-QQ-XMAILINFO: MYha8DeKTomkDCLz8CmFQCWyDvMtImQ5terAuZ4eaL3zYZ8fTBcB5816
	mEEtTIAdba4qS4Xq+mQmKp6zzpm6SVQHhj0eAr78BmYEHw9tvyxvRLT5z7IOi1aYz93FuyU
	TOHDFWDf8sszU/i3Y5DcmsZwCvdZZoJIt7lZnRKqeLoQcL0RQXgeZTic0rbIOLo/6EM4q4q
	mGquqCa1EiDEqHTSHzjC2EFExj67xXVtKz5VJZZyGSrwdTj/11O5m/+8qmjId8xUAeVi0Yi
	DB7VX7sh1mt3cCfgmyf0hTx4SbIL/gOQkvkBfvIBwTx/zgKUIgtCcqQyuZKFSRqEV+UVZn5
	pkGP5nPiRm4qfX+FcoRQyAeEj/ttm9faTFPU6oc5jGY0YKcxratq19pnZc1EkwJCHGYQK9+
	GmrSke+af2YxsjeqSxFekTSKnQQ37oTZVa6aEor0HxbWUfI0UdI/4TKE+XUDwDwdRQC2Zju
	jxYZ9JMAN1EtvbLZe48hHG+8No8UMT9NGIea9md8kKgtf611Sj53DEklxqOhAnNI3wyuI/V
	cDIZpeLHaWxp8rEWh8q8BWB3CyubpGUAhTZdpe1GzjYIMX6WtwIBif3Ve0pOTui3BilDNra
	p9HoCbLQqXEbxGJ87dkRoVhksvG0nAr+kQJZ4uvvwgcqLICuiRlwcvyIvR15kY5xvFIDUhD
	AaoK9wpjz3yZOhDVUhiUpH8jwTIuE5z8wFQNHgpa8EGP7p69+vOZq7PhqDQ/L5t/cwdw5Bs
	XzFWa+iMgNAVghkGsj+7HyXJ1jyqKBPuo7yUoi5wK1RHMVQG2CQXO19L/vBBxTSJWIvskgB
	kYSS4ByG37o/FfGJWgjpkPK6SK28OjBUi7nDSfes/7ewm18/O1Y6vKlmZ9UQMxKkJofJAaR
	xtTAH4lrnLDwIK1TWJ0u9fnN5lMQP/IZoP60PFFGxgZnrMxsLEQBAfm+L5JoFCBjjyy9b38
	PF+3iZcsnEoHI4ydwQ+2QXsR/xKjYPPd3f4ZIuqxGzMJ7A6tTM3xd/eV/oJQ0KVePt3d+os
	iEpIE6tA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Initialize download fw function for n210 series.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/Kconfig            |   1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  18 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    | 476 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |  30 ++
 6 files changed, 529 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index be0fdf268484..8a0262a70036 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -20,6 +20,7 @@ config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
 	depends on PCI
 	select PAGE_POOL
+	select NET_DEVLINK
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
 	  adapters.
diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index fd455cb111a9..db7d3a8140b2 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o \
 	       rnpgbe_chip.o \
 	       rnpgbe_mbx.o \
-	       rnpgbe_mbx_fw.o
+	       rnpgbe_mbx_fw.o \
+	       rnpgbe_sfc.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 4514bc1223c1..ea28236669e3 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/netdevice.h>
+#include <net/devlink.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -195,9 +196,12 @@ struct mucse_hw {
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct devlink *dl;
 	struct mucse_hw hw;
 	/* board number */
 	u16 bd_number;
+	u32 flags2;
+#define M_FLAG2_NO_NET_REG BIT(0)
 
 	char name[60];
 };
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index aeb560145c47..61dd0d232d99 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -7,9 +7,11 @@
 #include <linux/netdevice.h>
 #include <linux/string.h>
 #include <linux/etherdevice.h>
+#include <linux/firmware.h>
 
 #include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
+#include "rnpgbe_sfc.h"
 
 char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -76,6 +78,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	hw = &mucse->hw;
 	hw->back = mucse;
 	hw->hw_type = ii->hw_type;
+	hw->pdev = pdev;
 
 	switch (hw->hw_type) {
 	case rnpgbe_hw_n500:
@@ -94,8 +97,18 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	case rnpgbe_hw_n210:
 	case rnpgbe_hw_n210L:
 		/* check bar0 to load firmware */
-		if (pci_resource_len(pdev, 0) == 0x100000)
-			return -EIO;
+		if (pci_resource_len(pdev, 0) == 0x100000) {
+			hw->hw_addr = ioremap(pci_resource_start(pdev, 0),
+					      pci_resource_len(pdev, 0));
+
+			if (!hw->hw_addr) {
+				dev_err(&pdev->dev, "map bar0 failed!\n");
+				return -EIO;
+			}
+			rnpgbe_devlink_register(mucse);
+			mucse->flags2 |= M_FLAG2_NO_NET_REG;
+			return 0;
+		}
 		/* n210 use bar2 */
 		hw_addr = devm_ioremap(&pdev->dev,
 				       pci_resource_start(pdev, 2),
@@ -191,6 +204,7 @@ static void rnpgbe_rm_adapter(struct mucse *mucse)
 {
 	struct net_device *netdev;
 
+	rnpgbe_devlink_unregister(mucse);
 	netdev = mucse->netdev;
 	free_netdev(netdev);
 }
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
new file mode 100644
index 000000000000..91a637b3ac19
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/iopoll.h>
+#include <net/devlink.h>
+#include <linux/pci.h>
+
+#include "rnpgbe_sfc.h"
+#include "rnpgbe.h"
+
+/**
+ * mucse_sfc_command - Write sfc cmd to hw and wait ok
+ * @hw_addr: bar addr for sfc controller
+ * @cmd: sfc command
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_command(u8 __iomem *hw_addr, u32 cmd)
+{
+	int val;
+
+	iowrite32(cmd, (hw_addr + 0x8));
+	iowrite32(1, (hw_addr + 0x0));
+
+	return read_poll_timeout(ioread32, val, !val,
+				 100, 10000, true,
+				 hw_addr);
+}
+
+/**
+ * mucse_sfc_flash_write_disable - Enable flash cmd protect
+ * @hw_addr: bar addr for sfc controller
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_flash_write_disable(u8 __iomem *hw_addr)
+{
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(WR_DATA_CYCLE(0), (hw_addr + 0x14));
+
+	return mucse_sfc_command(hw_addr, CMD_WRITE_DISABLE);
+}
+
+/**
+ * mucse_sfc_flash_wait_idle - Wait sfc controller idle
+ * @hw_addr: bar addr for sfc controller
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_flash_wait_idle(u8 __iomem *hw_addr)
+{
+	int try_count = 100;
+	int err, val;
+
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(RD_DATA_CYCLE(8), (hw_addr + 0x14));
+
+try:
+	try_count--;
+	err = mucse_sfc_command(hw_addr, CMD_READ_STATUS);
+	if (err && try_count)
+		goto try;
+	err = read_poll_timeout(ioread32, val, !(val & 0x1),
+				100, 1000, true,
+				hw_addr + 0x4);
+	if (err && try_count)
+		goto try;
+
+	return err;
+}
+
+/**
+ * mucse_sfc_flash_write_enable - Disable flash cmd protect
+ * @hw_addr: bar addr for sfc controller
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_flash_write_enable(u8 __iomem *hw_addr)
+{
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(0x1f, (hw_addr + 0x18));
+	iowrite32(0x100000, (hw_addr + 0x14));
+
+	return mucse_sfc_command(hw_addr, CMD_WRITE_ENABLE);
+}
+
+/**
+ * mucse_sfc_flash_erase_sector - Erase flash sector
+ * @hw_addr: bar addr for sfc controller
+ * @address: sector start address
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_flash_erase_sector(u8 __iomem *hw_addr,
+					u32 address)
+{
+	int err;
+
+	if (address >= RSP_FLASH_HIGH_16M_OFFSET)
+		return -EINVAL;
+
+	if (address % 4096)
+		return -EINVAL;
+
+	err = mucse_sfc_flash_write_enable(hw_addr);
+	if (err)
+		return err;
+	iowrite32((CMD_CYCLE(8) | ADDR_CYCLE(24)), (hw_addr + 0x10));
+	iowrite32((RD_DATA_CYCLE(0) | WR_DATA_CYCLE(0)), (hw_addr + 0x14));
+	iowrite32(SFCADDR(address), (hw_addr + 0xc));
+	err = mucse_sfc_command(hw_addr, CMD_SECTOR_ERASE);
+	if (err)
+		return err;
+	err = mucse_sfc_flash_wait_idle(hw_addr);
+	if (err)
+		return err;
+	err = mucse_sfc_flash_write_disable(hw_addr);
+
+	return err;
+}
+
+/**
+ * mucse_sfc_write_protect - set flash write protect off
+ * @hw: Pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_write_protect(struct mucse_hw *hw)
+{
+	int err;
+
+	err = mucse_sfc_flash_write_enable(hw->hw_addr);
+	if (err)
+		return err;
+
+	iowrite32(CMD_CYCLE(8), (hw->hw_addr + 0x10));
+	iowrite32(WR_DATA_CYCLE(8), (hw->hw_addr + 0x14));
+	iowrite32(0, (hw->hw_addr + 0x04));
+	err = mucse_sfc_command(hw->hw_addr, CMD_WRITE_STATUS);
+
+	return err;
+}
+
+/**
+ * mucse_sfc_flash_erase - Erase flash
+ * @hw: Pointer to the HW structure
+ * @size: Data length
+ *
+ * mucse_sfc_flash_erase tries to erase sfc_flash
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_sfc_flash_erase(struct mucse_hw *hw, u32 size)
+{
+	u32 addr = SFC_MEM_BASE;
+	u32 page_size = 0x1000;
+	u32 i = 0;
+	int err;
+
+	size = ((size + (page_size - 1)) / page_size) * page_size;
+	addr = addr - SFC_MEM_BASE;
+
+	if (size == 0)
+		return -EINVAL;
+
+	if ((addr + size) > RSP_FLASH_HIGH_16M_OFFSET)
+		return -EINVAL;
+
+	if (addr % page_size)
+		return -EINVAL;
+
+	if (size % page_size)
+		return -EINVAL;
+	/* skip some info */
+	for (i = 0; i < size; i += page_size) {
+		if (i >= 0x1f000 && i < 0x20000)
+			continue;
+
+		err = mucse_sfc_flash_erase_sector(hw->hw_addr, (addr + i));
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/**
+ * mucse_download_firmware - Download data to chip
+ * @hw: Pointer to the HW structure
+ * @data: Data to use
+ * @file_size: Data length
+ *
+ * mucse_download_firmware tries to download data to white-chip
+ * by hw_addr regs.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_download_firmware(struct mucse_hw *hw, const u8 *data,
+				   int file_size)
+{
+	char *buf = kzalloc(0x1000, GFP_KERNEL);
+	loff_t end_pos = file_size;
+	u32 rd_len = 0x1000;
+	loff_t old_pos = 0;
+	u32 old_data = 0;
+	u32 new_data = 0;
+	int get_len = 0;
+	u32 fw_off = 0;
+	loff_t pos = 0;
+	u32 iter = 0;
+	int err = 0;
+
+	if (!buf)
+		return -ENOMEM;
+	/* copy bin to bar */
+	while (pos < end_pos) {
+		/* we must skip header 4k */
+		if ((pos >= 0x1f000 && pos < 0x20000) || pos == 0) {
+			pos += rd_len;
+			continue;
+		}
+
+		old_pos = pos;
+		if (end_pos - pos < rd_len)
+			get_len = end_pos - pos;
+		else
+			get_len = rd_len;
+
+		memcpy(buf, data + pos, get_len);
+		if ((get_len < rd_len && ((old_pos + get_len) != end_pos)) ||
+		    get_len < 0) {
+			err = -EIO;
+			goto out;
+		}
+
+		for (iter = 0; iter < get_len; iter += 4) {
+			old_data = *((u32 *)(buf + iter));
+			fw_off = (u32)old_pos + iter + 0x1000;
+			iowrite32(old_data, (hw->hw_addr + fw_off));
+		}
+
+		if (pos == old_pos)
+			pos += get_len;
+	}
+	/* write first 4k header */
+	pos = 0;
+	old_pos = pos;
+	get_len = rd_len;
+	memcpy(buf, data + pos, get_len);
+
+	for (iter = 0; iter < get_len; iter += 4) {
+		old_data = *((u32 *)(buf + iter));
+		fw_off = (u32)old_pos + iter + 0x1000;
+		iowrite32(old_data, (hw->hw_addr + fw_off));
+	}
+	/* check */
+	pos = 0x0;
+	while (pos < end_pos) {
+		if (pos >= 0x1f000 && pos < 0x20000) {
+			pos += rd_len;
+			continue;
+		}
+
+		old_pos = pos;
+		if (end_pos - pos < rd_len)
+			get_len = end_pos - pos;
+		else
+			get_len = rd_len;
+
+		memcpy(buf, data + pos, get_len);
+		if ((get_len < rd_len && ((old_pos + get_len) != end_pos)) ||
+		    get_len < 0) {
+			err = -EIO;
+			goto out;
+		}
+
+		for (iter = 0; iter < get_len; iter += 4) {
+			old_data = *((u32 *)(buf + iter));
+			fw_off = (u32)old_pos + iter + 0x1000;
+			new_data = ioread32(hw->hw_addr + fw_off);
+			if (old_data != new_data)
+				err = -EIO;
+		}
+
+		if (pos == old_pos)
+			pos += get_len;
+	}
+out:
+	kfree(buf);
+	return err;
+}
+
+/**
+ * rnpgbe_check_fw_from_flash - Check chip-id and bin-id
+ * @hw: Pointer to the HW structure
+ * @data: data from bin files
+ *
+ * rnpgbe_check_fw_from_flash tries to match chip-id and bin-id
+ *
+ * @return: 0 on mactch, negative on failure
+ **/
+static int rnpgbe_check_fw_from_flash(struct mucse_hw *hw, const u8 *data)
+{
+	enum rnpgbe_hw_type hw_type = rnpgbe_hw_unknow;
+	u32 device_id;
+	u32 chip_data;
+	int ret = 0;
+
+#define RNPGBE_BIN_HEADER (0xa55aa55a)
+	if (*((u32 *)(data)) != RNPGBE_BIN_HEADER)
+		return -EINVAL;
+
+	device_id = *((u16 *)data + 30);
+
+	/* if no device_id no check */
+	if (device_id == 0 || device_id == 0xffff)
+		return 0;
+
+#define CHIP_OFFSET (0x1f014 + 0x1000)
+#define CHIP_N210_FLAG (0x11111111)
+	/* we should get hw_type from sfc-flash */
+	chip_data = ioread32(hw->hw_addr + CHIP_OFFSET);
+	if (chip_data == CHIP_N210_FLAG)
+		hw_type = rnpgbe_hw_n210;
+	else if (chip_data == 0x0)
+		hw_type = rnpgbe_hw_n210L;
+
+	switch (hw_type) {
+	case rnpgbe_hw_n210:
+		if (device_id != 0x8208)
+			ret = -EINVAL;
+		break;
+	case rnpgbe_hw_n210L:
+		if (device_id != 0x820a)
+			ret = -EINVAL;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * init_firmware_for_n210 - download firmware
+ * @hw: Pointer to the HW structure
+ * @fw: pointer to the firmware
+ *
+ * init_firmware_for_n210 try to download firmware
+ * for n210, by bar0(hw->hw_addr).
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int init_firmware_for_n210(struct mucse_hw *hw,
+				  const struct firmware *fw)
+{
+	struct pci_dev *pdev = hw->pdev;
+	int err = 0;
+
+	if (rnpgbe_check_fw_from_flash(hw, fw->data)) {
+		dev_err(&pdev->dev, "firmware type error\n");
+		return -EINVAL;
+	}
+	/* first protect off */
+	err = mucse_sfc_write_protect(hw);
+	if (err) {
+		dev_err(&pdev->dev, "protect off command failed!");
+		goto out;
+	}
+
+	err = mucse_sfc_flash_erase(hw, fw->size);
+	if (err) {
+		dev_err(&pdev->dev, "erase flash failed!");
+		goto out;
+	}
+
+	err = mucse_download_firmware(hw, fw->data, fw->size);
+	if (err) {
+		dev_err(&pdev->dev, "init firmware failed!");
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+/**
+ * rnpgbe_dl_info_get - return card fw info
+ * @dl: devlink structure
+ * @req: devlink info req
+ * @extack: extack info
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_dl_info_get(struct devlink *dl,
+			      struct devlink_info_req *req,
+			      struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = devlink_info_version_running_put(req,
+					       DEVLINK_INFO_VERSION_GENERIC_FW,
+					       "NULL");
+
+	return err;
+}
+
+/**
+ * rnpgbe_dl_flash_update - Update fw to chip flash
+ * @dl: devlink structure
+ * @params: flash update params
+ * @extack: extack info
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_dl_flash_update(struct devlink *dl,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack)
+{
+	struct rnpgbe_devlink *rnpgbe_devlink = devlink_priv(dl);
+	struct mucse *mucse = rnpgbe_devlink->priv;
+	struct mucse_hw *hw = &mucse->hw;
+	int err;
+
+	err = init_firmware_for_n210(hw, params->fw);
+	if (err) {
+		devlink_flash_update_status_notify(dl,
+						   "Flash failed",
+						   NULL, 0, 0);
+	} else {
+		devlink_flash_update_status_notify(dl,
+						   "Flash done",
+						   NULL, 0, 0);
+	}
+	return err;
+}
+
+static const struct devlink_ops rnpgbe_dl_ops = {
+	.info_get       = rnpgbe_dl_info_get,
+	.flash_update   = rnpgbe_dl_flash_update,
+};
+
+/**
+ * rnpgbe_devlink_register - Regist devlink
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_devlink_register(struct mucse *mucse)
+{
+	struct device *dev = &mucse->pdev->dev;
+	struct rnpgbe_devlink *rnpgbe_devlink;
+	struct devlink *dl;
+
+	dl = devlink_alloc(&rnpgbe_dl_ops, sizeof(struct rnpgbe_devlink), dev);
+	if (!dl)
+		return -EIO;
+	mucse->dl = dl;
+	rnpgbe_devlink = devlink_priv(dl);
+	rnpgbe_devlink->priv = mucse;
+
+	devlink_register(dl);
+	return 0;
+}
+
+/**
+ * rnpgbe_devlink_unregister - remove devlink
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_devlink_unregister(struct mucse *mucse)
+{
+	if (!mucse->dl)
+		return;
+	devlink_unregister(mucse->dl);
+	devlink_free(mucse->dl);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h
new file mode 100644
index 000000000000..523a873d65c8
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_SFC_H
+#define _RNPGBE_SFC_H
+
+#include "rnpgbe.h"
+
+/* Return value */
+#define RSP_FLASH_HIGH_16M_OFFSET 0x1000000
+#define SFC_MEM_BASE 0x28000000
+#define CMD_WRITE_DISABLE 0x04000000
+#define CMD_READ_STATUS 0x05000000
+#define CMD_WRITE_STATUS 0x01000000
+#define CMD_WRITE_ENABLE 0x06000000
+#define CMD_SECTOR_ERASE 0x20000000
+#define SFCADDR(a) ((a) << 8)
+#define CMD_CYCLE(c) (((c) & 0xff) << 0)
+#define RD_DATA_CYCLE(c) (((c) & 0xff) << 8)
+#define WR_DATA_CYCLE(c) (((c) & 0xff) << 0)
+#define ADDR_CYCLE(c) (((c) & 0xff) << 16)
+
+struct rnpgbe_devlink {
+	struct mucse *priv;
+};
+
+int rnpgbe_devlink_register(struct mucse *mucse);
+void rnpgbe_devlink_unregister(struct mucse *mucse);
+
+#endif /* _RNPGBE_SFC_H */
-- 
2.25.1


