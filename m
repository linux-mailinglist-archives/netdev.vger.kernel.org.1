Return-Path: <netdev+bounces-203575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B96AF6769
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B2E522DDF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBD1F4629;
	Thu,  3 Jul 2025 01:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6F1D5175;
	Thu,  3 Jul 2025 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507471; cv=none; b=Uq4sH2xzn+PtrxdH4l1FYqvq8l92qnL+QZoQF47iYDoCTccNWMqrpxV6B7KsisBzD5Ghov2vWDFUCnsc3rq/6+TUlzblXmA7nnkm9CZ79qt8JV7xY9b1f5DtPjASbXse+vKGz4olvaIdkrClM5yhrUnTDN3VIvfwfjWDWN92oU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507471; c=relaxed/simple;
	bh=Vn+aA7uPhGzMdjU385zXjKNP1FA9dT5ECEnJIeOVM08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQQCfcBM2zg62Pk1WJ1wbqYqzaSVPnHFBFGxxW+i/Ko39cELwWzjOZ0//H2+dhXfHB0YMzgo2lofglwOJYWd7FCOAnX1FrM/ldSOim8RmMuF3tKoKdOuPkXu4ZvhcWbkyt7EMunEIhQT6OLMkCg9Q5If+FvSo1xjaPyy3lBhJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507378t1fabd4f1
X-QQ-Originating-IP: 0ZGAHRp1K9Aluz8ij7tIazDn5ZoBGaxkXRJ8PGc30Uw=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4960571315379612490
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
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
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 05/15] net: rnpgbe: Add download firmware for n210 chip
Date: Thu,  3 Jul 2025 09:48:49 +0800
Message-Id: <20250703014859.210110-6-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzcdIqQ5dcY0nOgHeeTq3Z/+8MxVweIyQlCXr4X0KGGNlrY3N1yyt1UR
	oP3aaLBcHnmRhL+CxLqvAhp5SeeOs5bdL6jroclxRrlewGw0Ffev4ggHhTGvErHIPsduEtd
	ng8SreziFsmywh0KZ4OivfcEGzQUSJ4ofjldIk0ZBHJRR2f9f/dCKjaTeeo3YsNTvVVpW5T
	TWz7W5evYjaiaXP3gi/gZu8VCVeAFt6vPZY07KRLvbpOwnBTTTqVXBNH1VPRblxQ6FCB+oK
	Cd1EuLEISGXrpDqPYTxZuNNeW8dpPXoof+iIeWGzvxZVg/eMcd3hTb5Jadq/G/ljJWeIAyI
	3ol9SIT8wT3jYdO87fi4zLHRfSfnm4BkfHgcMU6Hwa5liKS57FQAZXiuaoSe7l2wV46g+p+
	2Rwg7OnMwmp/WSshPIGWPhgHktn1YQ2H8j6dOH1JOFh4g0+VEyjtLNoKIlVQ2SSMK581rj7
	QVwfyGgvxWL8KHNFoaC0BwTOmxFksG4KRswkNePPva5GSFto3BAzn+dnEHahkdlr2Xh6yPh
	sRzkT0TyVBe7s158d0af5H7Lv6TzgKncSfJ/O77sFN4dxln/G/47r9obdL25IwtGK/ogAFF
	lp3BgUGmPr8zvEFyJo+jB3rREwaUGTTpQw89ealhNrm3l7tHoF4VAr0FR/zGHMQIa8PQkfy
	xDhB+tBzaUwRFE3c4xf0QwwfFktjJn1MZeQBSeUXb+hu6wPERq2F8g0E2Ou1mSa1VLwsTb0
	/VyYqzYErDht9Ys0yj/Yb4x8cDp3n09akSQ79vKjU+51Fdzyqu69sM8fjspovmaggnRP5C+
	920zLX5CYXBZa790pF5Ymb0v8qAOrsvugKUaUWWn8A1YmP11gvRIfri5UFAom7XmygqY43h
	4B0r2VO99wxS9LYPzK0ebTf8eCik8CXL0BABpevz93ugq08zUVwE5Abdky9wrmzJLoLk44z
	qAQqyJwClNKGnK9QlL75+wECSqiDInkXSl1KmoP3f6jgi+P+C6RB75BjQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Initialize download fw function for n210 series.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   3 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  94 ++++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    | 236 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |  30 +++
 5 files changed, 364 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h

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
index fd1610318c75..4e07d39d55ba 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -21,6 +21,7 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_n500 = 0,
 	rnpgbe_hw_n210,
 	rnpgbe_hw_n210L,
+	rnpgbe_hw_unknow,
 };
 
 struct mucse_dma_info {
@@ -199,6 +200,8 @@ struct mucse {
 	struct mucse_hw hw;
 	/* board number */
 	u16 bd_number;
+	u32 flags2;
+#define M_FLAG2_NO_NET_REG ((u32)(1 << 0))
 
 	char name[60];
 };
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index b701b42b7c42..a7b8eb53cd69 100644
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
 static const char rnpgbe_driver_string[] =
@@ -42,6 +44,56 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_check_fw_from_flash - Check chip-id and bin-id
+ * @hw: hardware structure
+ * @data: data from bin files
+ *
+ * rnpgbe_check_fw_from_flash tries to match chip-id and bin-id
+ *
+ *
+ * Returns 0 on mactch, negative on failure
+ **/
+static int rnpgbe_check_fw_from_flash(struct mucse_hw *hw, const u8 *data)
+{
+	u32 device_id;
+	int ret = 0;
+	u32 chip_data;
+	enum rnpgbe_hw_type hw_type = rnpgbe_hw_unknow;
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
+	/* we should get hw_type from sfc-flash */
+	chip_data = ioread32(hw->hw_addr + CHIP_OFFSET);
+	if (chip_data == 0x11111111)
+		hw_type = rnpgbe_hw_n210;
+	else if (chip_data == 0x0)
+		hw_type = rnpgbe_hw_n210L;
+
+	switch (hw_type) {
+	case rnpgbe_hw_n210:
+		if (device_id != 0x8208)
+			ret = -1;
+		break;
+	case rnpgbe_hw_n210L:
+		if (device_id != 0x820a)
+			ret = -1;
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
+
 /**
  * init_firmware_for_n210 - download firmware
  * @hw: hardware structure
@@ -53,7 +105,46 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int init_firmware_for_n210(struct mucse_hw *hw)
 {
-	return 0;
+	char *filename = "n210_driver_update.bin";
+	const struct firmware *fw;
+	struct pci_dev *pdev = hw->pdev;
+	int rc = 0;
+	int err = 0;
+	struct mucse *mucse = (struct mucse *)hw->back;
+
+	rc = request_firmware(&fw, filename, &pdev->dev);
+
+	if (rc != 0) {
+		dev_err(&pdev->dev, "requesting firmware file failed\n");
+		return rc;
+	}
+
+	if (rnpgbe_check_fw_from_flash(hw, fw->data)) {
+		dev_info(&pdev->dev, "firmware type error\n");
+		release_firmware(fw);
+		return -EIO;
+	}
+	/* first protect off */
+	mucse_sfc_write_protect(hw);
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
+	dev_info(&pdev->dev, "init firmware successfully.");
+	dev_info(&pdev->dev, "Please reboot.");
+
+out:
+	release_firmware(fw);
+	mucse->flags2 |= M_FLAG2_NO_NET_REG;
+
+	return err;
 }
 
 /**
@@ -97,6 +188,7 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	hw = &mucse->hw;
 	hw->back = mucse;
 	hw->hw_type = ii->hw_type;
+	hw->pdev = pdev;
 
 	switch (hw->hw_type) {
 	case rnpgbe_hw_n500:
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
new file mode 100644
index 000000000000..8e0919f5d47e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+
+#include "rnpgbe_sfc.h"
+#include "rnpgbe.h"
+
+static inline void mucse_sfc_command(u8 __iomem *hw_addr, u32 cmd)
+{
+	iowrite32(cmd, (hw_addr + 0x8));
+	iowrite32(1, (hw_addr + 0x0));
+	while (ioread32(hw_addr) != 0)
+		;
+}
+
+static inline void mucse_sfc_flash_write_disable(u8 __iomem *hw_addr)
+{
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(WR_DATA_CYCLE(0), (hw_addr + 0x14));
+
+	mucse_sfc_command(hw_addr, CMD_WRITE_DISABLE);
+}
+
+static int32_t mucse_sfc_flash_wait_idle(u8 __iomem *hw_addr)
+{
+	int time = 0;
+	int ret = HAL_OK;
+
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(RD_DATA_CYCLE(8), (hw_addr + 0x14));
+
+	while (1) {
+		mucse_sfc_command(hw_addr, CMD_READ_STATUS);
+		if ((ioread32(hw_addr + 0x4) & 0x1) == 0)
+			break;
+		time++;
+		if (time > 1000)
+			ret = HAL_FAIL;
+	}
+	return ret;
+}
+
+static inline void mucse_sfc_flash_write_enable(u8 __iomem *hw_addr)
+{
+	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
+	iowrite32(0x1f, (hw_addr + 0x18));
+	iowrite32(0x100000, (hw_addr + 0x14));
+
+	mucse_sfc_command(hw_addr, CMD_WRITE_ENABLE);
+}
+
+static int mucse_sfc_flash_erase_sector(u8 __iomem *hw_addr,
+					u32 address)
+{
+	int ret = HAL_OK;
+
+	if (address >= RSP_FLASH_HIGH_16M_OFFSET)
+		return HAL_EINVAL;
+
+	if (address % 4096)
+		return HAL_EINVAL;
+
+	mucse_sfc_flash_write_enable(hw_addr);
+
+	iowrite32((CMD_CYCLE(8) | ADDR_CYCLE(24)), (hw_addr + 0x10));
+	iowrite32((RD_DATA_CYCLE(0) | WR_DATA_CYCLE(0)), (hw_addr + 0x14));
+	iowrite32(SFCADDR(address), (hw_addr + 0xc));
+	mucse_sfc_command(hw_addr, CMD_SECTOR_ERASE);
+	if (mucse_sfc_flash_wait_idle(hw_addr)) {
+		ret = HAL_FAIL;
+		goto failed;
+	}
+	mucse_sfc_flash_write_disable(hw_addr);
+
+failed:
+	return ret;
+}
+
+void mucse_sfc_write_protect(struct mucse_hw *hw)
+{
+	mucse_sfc_flash_write_enable(hw->hw_addr);
+
+	iowrite32(CMD_CYCLE(8), (hw->hw_addr + 0x10));
+	iowrite32(WR_DATA_CYCLE(8), (hw->hw_addr + 0x14));
+	iowrite32(0, (hw->hw_addr + 0x04));
+	mucse_sfc_command(hw->hw_addr, CMD_WRITE_STATUS);
+}
+
+/**
+ * mucse_sfc_flash_erase - Erase flash
+ * @hw: Hw structure
+ * @size: Data length
+ *
+ * mucse_sfc_flash_erase tries to erase sfc_flash
+ *
+ * Returns HAL_OK on success, negative on failure
+ **/
+int mucse_sfc_flash_erase(struct mucse_hw *hw, u32 size)
+{
+	u32 addr = SFC_MEM_BASE;
+	u32 i = 0;
+	u32 page_size = 0x1000;
+
+	size = ((size + (page_size - 1)) / page_size) * page_size;
+
+	addr = addr - SFC_MEM_BASE;
+
+	if (size == 0)
+		return HAL_EINVAL;
+
+	if ((addr + size) > RSP_FLASH_HIGH_16M_OFFSET)
+		return HAL_EINVAL;
+
+	if (addr % page_size)
+		return HAL_EINVAL;
+
+	if (size % page_size)
+		return HAL_EINVAL;
+	/* skip some info */
+	for (i = 0; i < size; i += page_size) {
+		if (i >= 0x1f000 && i < 0x20000)
+			continue;
+
+		mucse_sfc_flash_erase_sector(hw->hw_addr, (addr + i));
+	}
+
+	return HAL_OK;
+}
+
+/**
+ * mucse_download_firmware - Download data to chip
+ * @hw: Hw structure
+ * @data: Data to use
+ * @file_size: Data length
+ *
+ * mucse_download_firmware tries to download data to white-chip
+ * by hw_addr regs.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+int mucse_download_firmware(struct mucse_hw *hw, const u8 *data,
+			    int file_size)
+{
+	struct device *dev = &hw->pdev->dev;
+	loff_t old_pos = 0;
+	loff_t pos = 0;
+	loff_t end_pos = file_size;
+	u32 rd_len = 0x1000;
+	int get_len = 0;
+	u32 iter = 0;
+	int err = 0;
+	u32 fw_off = 0;
+	u32 old_data = 0;
+	u32 new_data = 0;
+	char *buf = kzalloc(0x1000, GFP_KERNEL);
+
+	dev_info(dev, "initializing firmware, which will take some time.");
+	/* capy bin to bar */
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
+	dev_info(dev, "Checking for firmware. Wait a moment, please.");
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
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h
new file mode 100644
index 000000000000..9c381bcda960
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
+#define HAL_OK (0)
+#define HAL_FAIL (-1)
+#define HAL_EINVAL (-3) /* Invalid argument */
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
+void mucse_sfc_write_protect(struct mucse_hw *hw);
+int mucse_sfc_flash_erase(struct mucse_hw *hw, u32 size);
+int mucse_download_firmware(struct mucse_hw *hw, const u8 *data,
+			    int file_size);
+#endif /* _RNPGBE_SFC_H */
-- 
2.25.1


