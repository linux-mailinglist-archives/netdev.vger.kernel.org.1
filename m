Return-Path: <netdev+bounces-237831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F7C50AA3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677A33B5198
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDF2D5A14;
	Wed, 12 Nov 2025 06:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCF15D1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927260; cv=none; b=GKPnN0unJoGLnQ3Eh5rU34pzPMLMxTlMHskXn7aSSwAjmg0oxgaXZ58DAQkpYMe8RfBh8o7hBb9PXT4eXph3qcpZKMX4J25ElG7nubxFyD6NjUmXBWz9MOxFS+JISaD3nxZrc3402Ju99YVTnjGs71E2j3NzPBUmSHQTCwMdIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927260; c=relaxed/simple;
	bh=GxJUactct2dIKP0grOK2LnNcokr5mn86Q7N5+YCYco0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaDfdvxs532uuOjuTjVNvXElNa9WBgMAL2x7nDfBIcgGzubpbrw9Q/QVAvchNbKKVMDxojn1HJekboQEHc2XpGE9cNZBId/zuOktqXfoCU1TOshjdi3VfBKUP9BoZCXieOgb+y7VxE2/bAp57x/6J5ReAMmS4MXtuvFwg5LAzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1762927142t6a933574
X-QQ-Originating-IP: 8LnMsNR/hAokFugCTvoCg6WUANtdn8Brke8nm9DeLBM=
Received: from lap-jiawenwu.trustnetic.com ( [115.200.224.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Nov 2025 13:59:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2237260100047043363
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by page
Date: Wed, 12 Nov 2025 13:58:41 +0800
Message-Id: <20251112055841.22984-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251112055841.22984-1-jiawenwu@trustnetic.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MYcyYH/A/+tC0q64et/8mKSmjDewIRDAL5uQz8/tw2PyaeMNCDAhTTc5
	Y0K/AmRtPkFzmUm3cQiU5nhPjU4hj+S6crk+YIcjjf1pFOKLKC2Cm7ZUfRjGoHFNUJRU18y
	wGuvHo/Z/02AhRB8E9X4w00EnOmPOfxTtZfzFLA25Zn/uoEqH01hNy2S2RDxruRRnGoxEL/
	pPuzHuKLAE36rxEXzYhKXE4lkloxHmCHudYHor+1e1G4XudqWyNMWcEV9OKEtLMXU/yBD8c
	MlB3QGVBoK2vUZNDudHq4/cmD64zcYmuQPf7ZQibIaJUKqV9ULUQqNmN33fow5KYVA8MObc
	5KcyJ/Pkfz28+gLf642qHthVfzm69d6I9bu7cKRuZNR9HRScJyHhqdIM5qsQpTuk55KuzXc
	4yvt2AofPhXCv3lxPGRp9nVVka72jj8qzaIpGCSUTHAfFI+LtjSpmb1owXV4MF8r+f84DXU
	edfo3AgcC79gNc3puAshyalvtI9W3jxICEYkOmbHPwn6UPAjphrJ5IL99T6zhFy4yh4MGbV
	9yvdCaNUc2OpZjdI9uwY9S4PDjJHSMAe//Iu15ISakD9Nc8ZX7/9z0ozVbfiUSDmWPgimG0
	jOtxGY/VXJ0g32VztlX8nnTMeZL60M4/vp6CBI5PP3p+EaCMnhCb3R0ERy/NNKVKNR1CQtp
	KjxGgIIlHK+zTPUdyIe815I83EHw/OEmAFFhxjT1K7OwrzoQnYxiqvwnHCZijV018SBVIPV
	kydx4RLIC+z6YwWaCI6sqEd84SYJEpL8JPPVLD+OABeisbUCOTIMuvTIcdUYuEC2gHufSYY
	B/+ZWKPDAcBv2It0rggMj5m79c4IUSEgzaCuna4M+rZIOIDSXKUUo4OxJqv9H/+7FHR68tS
	sFQtFbhKfeEj4+P+R8BfUUPHqbb6vzqKpRULgfJEw7mWRoJbhqX2dewyUvMbKkxd4S6LHXr
	zMMBngvycdy+yc2LWiXfBa13cOcRPWyz9yvKuc1XbP+oAcHcXnkbPUBs2m8WzIDydvgA3wD
	kDG8cMaXFIsEi5e391XvkscmC78RDIrkAAcSRawo8RfAgThsFnrY/LWTf+LLBG27WQjbMaH
	ufKf1cqlsoXPriQiueFZTs=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Getting module EEPROM has been supported in TXGBE SP devices, since SFP
driver has already implemented it.

Now add support to read module EEPROM for AML devices. Towards this, add
a new firmware mailbox command to get the page data.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 37 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  3 ++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 30 +++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 11 ++++++
 4 files changed, 81 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 3b6ea456fbf7..12900abfa91a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -73,6 +73,43 @@ int txgbe_test_hostif(struct wx *wx)
 					WX_HI_COMMAND_TIMEOUT, true);
 }
 
+int txgbe_read_eeprom_hostif(struct wx *wx,
+			     struct txgbe_hic_i2c_read *buffer,
+			     u32 length, u8 *data)
+{
+	u32 buf_size = sizeof(struct txgbe_hic_i2c_read) - sizeof(u8);
+	u32 total_len = buf_size + length;
+	u32 dword_len, value, i;
+	u8 local_data[256];
+	int err;
+
+	if (total_len > sizeof(local_data))
+		return -EINVAL;
+
+	buffer->hdr.cmd = FW_READ_EEPROM_CMD;
+	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
+			      sizeof(struct wx_hic_hdr);
+	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+
+	err = wx_host_interface_command(wx, (u32 *)buffer,
+					sizeof(struct txgbe_hic_i2c_read),
+					WX_HI_COMMAND_TIMEOUT, false);
+	if (err != 0)
+		return err;
+
+	dword_len = (total_len + 3) / 4;
+
+	for (i = 0; i < dword_len; i++) {
+		value = rd32a(wx, WX_FW2SW_MBOX, i);
+		le32_to_cpus(&value);
+
+		memcpy(&local_data[i * 4], &value, 4);
+	}
+
+	memcpy(data, &local_data[buf_size], length);
+	return 0;
+}
+
 static int txgbe_identify_module_hostif(struct wx *wx,
 					struct txgbe_hic_get_module_info *buffer)
 {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
index 7c8fa48e68d3..4f6df0ee860b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -7,6 +7,9 @@
 void txgbe_gpio_init_aml(struct wx *wx);
 irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
 int txgbe_test_hostif(struct wx *wx);
+int txgbe_read_eeprom_hostif(struct wx *wx,
+			     struct txgbe_hic_i2c_read *buffer,
+			     u32 length, u8 *data);
 int txgbe_set_phy_link(struct wx *wx);
 int txgbe_identify_module(struct wx *wx);
 void txgbe_setup_link(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index f553ec5f8238..1f60121fe73c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -10,6 +10,7 @@
 #include "../libwx/wx_lib.h"
 #include "txgbe_type.h"
 #include "txgbe_fdir.h"
+#include "txgbe_aml.h"
 #include "txgbe_ethtool.h"
 
 int txgbe_get_link_ksettings(struct net_device *netdev,
@@ -534,6 +535,34 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static int
+txgbe_get_module_eeprom_by_page(struct net_device *netdev,
+				const struct ethtool_module_eeprom *page_data,
+				struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct txgbe_hic_i2c_read buffer;
+	int err;
+
+	if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
+		return -EOPNOTSUPP;
+
+	buffer.length = (__force u32)cpu_to_be32(page_data->length);
+	buffer.offset = (__force u32)cpu_to_be32(page_data->offset);
+	buffer.page = page_data->page;
+	buffer.bank = page_data->bank;
+	buffer.i2c_address = page_data->i2c_address;
+
+	err = txgbe_read_eeprom_hostif(wx, &buffer, page_data->length,
+				       page_data->data);
+	if (err) {
+		wx_err(wx, "Failed to read module EEPROM\n");
+		return err;
+	}
+
+	return page_data->length;
+}
+
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -568,6 +597,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_msglevel		= wx_set_msglevel,
 	.get_ts_info		= wx_get_ts_info,
 	.get_ts_stats		= wx_get_ptp_stats,
+	.get_module_eeprom_by_page	= txgbe_get_module_eeprom_by_page,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index e72edb9ef084..3d1bec39d74c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -353,6 +353,7 @@ void txgbe_do_reset(struct net_device *netdev);
 #define FW_PHY_GET_LINK_CMD             0xC0
 #define FW_PHY_SET_LINK_CMD             0xC1
 #define FW_GET_MODULE_INFO_CMD          0xC5
+#define FW_READ_EEPROM_CMD              0xC6
 
 struct txgbe_sff_id {
 	u8 identifier;		/* A0H 0x00 */
@@ -394,6 +395,16 @@ struct txgbe_hic_ephy_getlink {
 	u8 resv[6];
 };
 
+struct txgbe_hic_i2c_read {
+	struct wx_hic_hdr hdr;
+	u32 offset;
+	u32 length;
+	u8 page;
+	u8 bank;
+	u8 i2c_address;
+	u8 data;
+};
+
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
 		.name = _NAME,			\
-- 
2.48.1


