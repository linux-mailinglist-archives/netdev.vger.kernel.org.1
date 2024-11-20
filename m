Return-Path: <netdev+bounces-146468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7A9D38DD
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD562838C4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F381A2846;
	Wed, 20 Nov 2024 10:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DD1A0734;
	Wed, 20 Nov 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100214; cv=none; b=MqEjNUeBbEb3vPHR5PdSafe5sBuF2IsWjVqOtz6zRZLrFezOU21tDmexg+kznQwMQEH2AKiKh+UyOFWTrlJfzMBTAuIxqc9iZ9Kpw+xcQDY/yBtm69WxmrZrZ9Rg99AndJPzPBmTHV+ARxdQeIBPPord3SObxs6kqs/ET7kWSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100214; c=relaxed/simple;
	bh=iRjzYxl1/YHWQu1R4zyczirciBSft4OLVHF0hmQ2Dno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lx+vw3ESTGpNpYdx3N3g57trlzRxViRe0qULn7deq38amFOa+/Nn+V8H7VLSsXgkcg1fcvxFpgkh4WuowbCzCPz97ccvJkXf5c2fjvWpSgMEC/ADNN6p75NFDmUuaNyMCHctL3U+i4A7QyY8cZ69UEmxP4CuAdB9+jbxTEJZsMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppZM_1732100202 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:43 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 08/21] motorcomm:yt6801: Implement the fxgmac_read_mac_addr function
Date: Wed, 20 Nov 2024 18:56:12 +0800
Message-Id: <20241120105625.22508-9-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_read_mac_addr function to read mac address form efuse.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index aa51ecdd7..c3baa06b0 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -796,6 +796,153 @@ static int fxgmac_open(struct net_device *netdev)
 	return ret;
 }
 
+#define EFUSE_FISRT_UPDATE_ADDR				255
+#define EFUSE_SECOND_UPDATE_ADDR			209
+#define EFUSE_MAX_ENTRY					39
+#define EFUSE_PATCH_ADDR_START				0
+#define EFUSE_PATCH_DATA_START				2
+#define EFUSE_PATCH_SIZE				6
+#define EFUSE_REGION_A_B_LENGTH				18
+
+static bool fxgmac_efuse_read_data(struct fxgmac_pdata *pdata, u32 offset,
+				   u8 *value)
+{
+	bool ret = false;
+	u32 wait = 1000;
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, offset);
+	fxgmac_set_bits(&val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
+	fxgmac_set_bits(&val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN,
+			EFUSE_OP_MODE_ROW_READ);
+	wr32_mem(pdata, val, EFUSE_OP_CTRL_0);
+
+	while (wait--) {
+		fsleep(20);
+		val = rd32_mem(pdata, EFUSE_OP_CTRL_1);
+		if (FXGMAC_GET_BITS(val, EFUSE_OP_DONE_POS,
+				    EFUSE_OP_DONE_LEN)) {
+			ret = true;
+			break;
+		}
+	}
+
+	if (!ret) {
+		yt_err(pdata, "Fail to reading efuse Byte%d\n", offset);
+		return ret;
+	}
+
+	if (value)
+		*value = FXGMAC_GET_BITS(val, EFUSE_OP_RD_DATA_POS,
+					 EFUSE_OP_RD_DATA_LEN) & 0xff;
+
+	return ret;
+}
+
+static bool fxgmac_efuse_read_index_patch(struct fxgmac_pdata *pdata, u8 index,
+					  u32 *offset, u32 *value)
+{
+	u8 tmp[EFUSE_PATCH_SIZE - EFUSE_PATCH_DATA_START];
+	u32 addr, i;
+	bool ret;
+
+	if (index >= EFUSE_MAX_ENTRY) {
+		yt_err(pdata, "Reading efuse out of range, index %d\n", index);
+		return false;
+	}
+
+	for (i = EFUSE_PATCH_ADDR_START; i < EFUSE_PATCH_DATA_START; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(pdata, addr,
+					     tmp + i - EFUSE_PATCH_ADDR_START);
+		if (!ret) {
+			yt_err(pdata, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	if (offset) {
+		/* tmp[0] is low 8bit date, tmp[1] is high 8bit date */
+		*offset = tmp[0] | (tmp[1] << 8);
+	}
+
+	for (i = EFUSE_PATCH_DATA_START; i < EFUSE_PATCH_SIZE; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(pdata, addr,
+					     tmp + i - EFUSE_PATCH_DATA_START);
+		if (!ret) {
+			yt_err(pdata, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	if (value) {
+		/* tmp[0] is low 8bit date, tmp[1] is low 8bit date
+		 * ...  tmp[3] is highest 8bit date
+		 */
+		*value = tmp[0] | (tmp[1] << 8) | (tmp[2] << 16) |
+			 (tmp[3] << 24);
+	}
+
+	return ret;
+}
+
+static bool fxgmac_efuse_read_mac_subsys(struct fxgmac_pdata *pdata,
+					 u8 *mac_addr, u32 *subsys, u32 *revid)
+{
+	u32 machr = 0, maclr = 0;
+	u32 offset = 0, val = 0;
+	bool ret = true;
+	u8 index;
+
+	for (index = 0;; index++) {
+		if (!fxgmac_efuse_read_index_patch(pdata, index, &offset, &val))
+			return false;
+
+		if (offset == 0x00)
+			break; /* Reach the blank. */
+
+		if (offset == MACA0LR_FROM_EFUSE)
+			maclr = val;
+
+		if (offset == MACA0HR_FROM_EFUSE)
+			machr = val;
+
+		if (offset == PCI_REVISION_ID && revid)
+			*revid = val;
+
+		if (offset == PCI_SUBSYSTEM_VENDOR_ID && subsys)
+			*subsys = val;
+	}
+
+	if (mac_addr) {
+		mac_addr[5] = (u8)(maclr & 0xFF);
+		mac_addr[4] = (u8)((maclr >> 8) & 0xFF);
+		mac_addr[3] = (u8)((maclr >> 16) & 0xFF);
+		mac_addr[2] = (u8)((maclr >> 24) & 0xFF);
+		mac_addr[1] = (u8)(machr & 0xFF);
+		mac_addr[0] = (u8)((machr >> 8) & 0xFF);
+	}
+
+	return ret;
+}
+
+static int fxgmac_read_mac_addr(struct fxgmac_pdata *pdata)
+{
+	u8 default_addr[ETH_ALEN] = { 0, 0x55, 0x7b, 0xb5, 0x7d, 0xf7 };
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	/* If efuse have mac addr, use it. if not, use static mac address. */
+	ret = fxgmac_efuse_read_mac_subsys(pdata, pdata->mac_addr, NULL, NULL);
+	if (!ret)
+		return -1;
+
+	if (is_zero_ether_addr(pdata->mac_addr))
+		/* Use a static mac address for test */
+		memcpy(pdata->mac_addr, default_addr, netdev->addr_len);
+
+	return 0;
+}
+
 #define FXGMAC_SYSCLOCK 125000000 /* System clock is 125 MHz */
 
 static void fxgmac_default_config(struct fxgmac_pdata *pdata)
-- 
2.34.1


