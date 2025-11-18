Return-Path: <netdev+bounces-239424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94166C681E5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 970F22A187
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADBA306D49;
	Tue, 18 Nov 2025 08:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED1301718
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453144; cv=none; b=SuSLIVPR9xDi6BwjrCTs5x8yBYFOu1spEbmcH/jO8JMTBof/1iT5KWj2u/hnBOJLaHv641ahSuHCqdlZaiNBVKh4ziwUmlDL+sNFE5CleGG2MbNfYI6VvuD2ZticdB8/E0nMWf6/jiyClvOKqM71KvjdRMV7+KER5qPoaPAJj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453144; c=relaxed/simple;
	bh=JAd5OnyD+v5LZTQJ21SI02WQQ7Fox3HW3mj8jlDsMEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHkh5qCmAJn9xCysFdTqa5GA+hUg6f0R/f2oMgrAt6T2hI3QYZfiotpHuT955jEsNbhPlvbr+1seex55MwMC1DzLrEX5huCsCQga4/ehOnzFgYgAixwImjMJYBQ54a4eogYc+vmS6sIanTukLxT5CYiHgQ6AOlfSqhbQpJHf+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1763453008t78fd6d2c
X-QQ-Originating-IP: puOYpVNrGQL7gb5pTDdx2ZOEONbdHKoMtzdkIkqB6LM=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.152.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 16:03:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6216807809175546591
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 5/5] net: txgbe: support getting module EEPROM by page
Date: Tue, 18 Nov 2025 16:02:59 +0800
Message-Id: <20251118080259.24676-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251118080259.24676-1-jiawenwu@trustnetic.com>
References: <20251118080259.24676-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OCG/O0Z17aKrCh8yLLXQP9h47LZ2Xq50qyLsnTC0KpxN8YSjEzW/w3By
	g3aDcdfNWiHBJEKFZTOf2Yv8G9CskJUsOw2W8eUP9iMi+k9HfNLi8O9IEj6+leDmcMetWrU
	JKMVTLixOeCe4QilKr/T70a7JLzIU5aMPUIM7o1NdVpXe4M3KNymiMfJRYzXvoVgYXUSCjN
	jQ4EggIjRbYMhyu57BvtdnTYwoD3rZiBManUYID3ewbjuLX+dbCpLiaTzEheaTgrqhYFeYp
	wAcQKQ6O/XW5hPmv5GKQJ3od2IMCiSM/EonIsIJeCFN/KsboaJYBsfOMqDKFKbAeV4dpOQU
	2WE2pdc/ZIdE+QJwvE4wbaPMwG4E+ZdEf/feXuOX+0nyP8m9PCSOz2+Ta/kGxVuobXnCnYI
	ONw39cN4C9UxuwhL7cb4kwmJnWqUNBwjBZJHGC5/Z6OR270aPkSdspYnO7VsPNdd24WkmEl
	qU152rVyODaTxNY/2GpVPT9SNzBhTLH/fv9ddfbZSSeaNvlHwNZK3cPKy4Z3j32cIt8gzh5
	xcpKEe0gUXXxsU4H+FEvUvfsiKmiNHQwyTbjS6qHeWHoP3eEWQEjmqmp2stVIylf5ne073R
	5trD+68SZvvuzFZrkkainZQlFttIty0EbiV5ayv1CWhOKzPEcER3QrdXZ0HEmWCsDhFjSi+
	c2FfRa0ZOXWFV9BaxGIk263z8SqzdA2REapSjeihKnKyHFrtbHJKET12fyKOa9cwrHqfDB3
	0RQW1/nqBA7FAjti2st0+fqmkHk2G7jvq2SGMbPPI/sXdnXXsRYLOLD//w3gk2mqr8M0lEI
	EL4CCC2s3AlltIHL/p6MilYPVWxa1lQx2oMfTZlv90RhGBOYEmsTna86+b+iudxk+PV6WuL
	28reb+2WX4EFJHdd/aZxkpZAXgoAfGaLxQ9lRs5mHaUpr45wOIs0va3k4G7LxRPQLL4qlr+
	I3uS6d2oR7zkrZjoruE4s11NsVXwkMz0nGRDKjCBrBjEu6XWrfeUzJWcOFzTEBmtXMERT58
	b+yzSfAG8NAS0KPh0I/EKeYN9CEojbI681NW6CbOzpxMu1sD+diuDrNKA41As4/ngadyOQB
	5aAFBuPIZy/7/vrY03ywEs=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Getting module EEPROM has been supported in TXGBE SP devices, since SFP
driver has already implemented it.

Now add support to read module EEPROM for AML devices. Towards this, add
a new firmware mailbox command to get the page data.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 33 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  3 ++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 30 +++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 11 +++++++
 4 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 3b6ea456fbf7..62d7f47d4f8d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -73,6 +73,39 @@ int txgbe_test_hostif(struct wx *wx)
 					WX_HI_COMMAND_TIMEOUT, true);
 }
 
+int txgbe_read_eeprom_hostif(struct wx *wx,
+			     struct txgbe_hic_i2c_read *buffer,
+			     u32 length, u8 *data)
+{
+	u32 dword_len, offset, value, i;
+	int err;
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
+	/* buffer length offset to read return data */
+	offset = sizeof(struct txgbe_hic_i2c_read) >> 2;
+	dword_len = round_up(length, 4) >> 2;
+
+	for (i = 0; i < dword_len; i++) {
+		value = rd32a(wx, WX_FW2SW_MBOX, i + offset);
+		le32_to_cpus(&value);
+
+		memcpy(data, &value, 4);
+		data += 4;
+	}
+
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
index f553ec5f8238..f3cb00109529 100644
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
+	buffer.length = cpu_to_be32(page_data->length);
+	buffer.offset = cpu_to_be32(page_data->offset);
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
index e72edb9ef084..82433e9cb0e3 100644
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
+	__be32 offset;
+	__be32 length;
+	u8 page;
+	u8 bank;
+	u8 i2c_address;
+	u8 resv;
+};
+
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
 		.name = _NAME,			\
-- 
2.48.1


