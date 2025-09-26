Return-Path: <netdev+bounces-226576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E744BA23AD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463031C27D63
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E32261596;
	Fri, 26 Sep 2025 02:40:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E800261573
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854419; cv=none; b=bQXSTLhiZNi4fEH9Zd76AZ9AndPQfmzUkigj+ktWvg/1iSrkk1w475AOZXnKMw19OtG71nlv6D/iV2lEPj1z1pn/8N5nXtrogiLCKy5e42aQv6qDSOUBvzH7icIvmebF08RC8LIvhAvmdQp7OCyLpZQdzludQ53VdQqFLSxPkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854419; c=relaxed/simple;
	bh=JEBYfRazcX9RHTFlpbhVAhu8lOWDGl21MEjLGo8pCE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mG4iEj0icJuAPUhtdTQmKWIr4yZi9X91g7Wg21k4f/3L0C4I4bFIAv4D2RU6Kfq/EXJqWmSprDCZyWkNh2QO2MyFCB4RCfT5dwGEN0egDYnsLWJhfBZnuzLdZwrt5arUopCFI5UP4Ea+v4VY9g+BsxVEMlhuLze2XQExvPhaGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1758854338t83464d2c
X-QQ-Originating-IP: tUFMtr9FzAj7MyS914bEmxGrH2tgbFBWllEfGhrkDZE=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Sep 2025 10:38:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3904069364247036737
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 3/4] net: wangxun: add RSS reta and rxfh fields support
Date: Fri, 26 Sep 2025 10:38:42 +0800
Message-Id: <20250926023843.34340-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250926023843.34340-1-jiawenwu@trustnetic.com>
References: <20250926023843.34340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MMAYpOwztiY83hSOCPoAL847FgjCI818ozneVNF0F7jJDf58U62iteEC
	pw1TKJXDuiXAQgP1N1IF3ARWPg58kST4MFjQ60PziO3UqRRAgefPIYfv6sqIxZjOjOTTeaq
	sDpoQEWtIcBu0jOlcTMmYKM6IxuGDGtEZaBns0ITlE1OiUJee6x1BSnjGG5Hjz+qidOV0ym
	Hme0OQFIFgN/hwxP1DlYia7hY9gaQ/PqnJu2EO4C4avkUvWmutiJESm2vSMoYdfUrY28ftC
	W7/MoF90emUWOjOzlJvSZgBLu+1RfXV8/ZHtQdx2UQ94oMvSwavZLnmeXXRLYFapt3KibyH
	Lk0WJQuVfQ/VDUnpyCXEBit/hgegG+bzaAtjLq7lOiJP2OsBzbAl1BwYjegh3gKunQERYdO
	N+4j4fJEl9vo1UKj6cE4QNjcjuTydtOv9XI/CjKobXztBEhBdMwmWWMvjk6eukwbtAlzwvd
	yDMXljZHLpOo31xUNycKIHILD/D6Ydj0hSIfcbtNH1OS7yd8ZTg1nGzIBhXVQLypPWoKlaG
	e169T6La66BD8jTQYLLNRgg4rdpQKbHYth3HlcemT15tDjMarcVzDLPxppMPUvspeLWFVrt
	NG/NQL0jNSYUG3OKZqeHSZAx6ksWfE7VmucEip6SKY8i6axmmuQzNEEqjrC7CXcK+CNWPLC
	I7/Dn9FtauIc66vn4RV6AbX4+LnCKM8jtMO8q2PMON0w3SYPOtR1IrNlJd8+/IRWF7blAn/
	yTMJ6/ym7HCt8tW1iwQ9KQr3OnUK/q0diaqHNgGbbgb5KuTAXoeA0UkgYkQ2IjMM28hpdPQ
	6bkl8+X+SXO92QEDSdGaxEJe9YggXxZ217/LxXC3SxCJ56myutr/mnJZmxqWkEzi2PaA7Jx
	wCoN1fB6V1gxTBsOVNcNGfM4gq0lJqYCwwNsV6qtpFLksO/vk9uVuiuqizN1CCfC6moVKkO
	94l5iqdmkbIUPBbdatfsyllIyg1Trm7NF8BvqnnNoXYvc7aqhshScpAxPC6mMJ0Z/sLzeej
	h0cHLX2w7DvPHoEm2Ng+JWEeXlhxeUZcFreF+usxrORClVQ+b24ayIGxxTePrlWuMM9sCP7
	RYsEvocmpFXxl1NOLleRQ0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add ethtool ops for Rx flow hashing, query and set RSS indirection table
and hash key. Disable UDP RSS by default, and support to configure L4
header fields with TCP/UDP/SCTP for flow hasing.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 136 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   6 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 6 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9572b9f28e59..fd826857af4a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -481,6 +481,142 @@ int wx_set_channels(struct net_device *dev,
 }
 EXPORT_SYMBOL(wx_set_channels);
 
+u32 wx_rss_indir_size(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return wx_rss_indir_tbl_entries(wx);
+}
+EXPORT_SYMBOL(wx_rss_indir_size);
+
+u32 wx_get_rxfh_key_size(struct net_device *netdev)
+{
+	return WX_RSS_KEY_SIZE;
+}
+EXPORT_SYMBOL(wx_get_rxfh_key_size);
+
+static void wx_get_reta(struct wx *wx, u32 *indir)
+{
+	u32 reta_size = wx_rss_indir_tbl_entries(wx);
+	u16 rss_m = wx->ring_feature[RING_F_RSS].mask;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		rss_m = wx->ring_feature[RING_F_RSS].indices - 1;
+
+	for (u32 i = 0; i < reta_size; i++)
+		indir[i] = wx->rss_indir_tbl[i] & rss_m;
+}
+
+int wx_get_rxfh(struct net_device *netdev,
+		struct ethtool_rxfh_param *rxfh)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	rxfh->hfunc = ETH_RSS_HASH_TOP;
+
+	if (rxfh->indir)
+		wx_get_reta(wx, rxfh->indir);
+
+	if (rxfh->key)
+		memcpy(rxfh->key, wx->rss_key, WX_RSS_KEY_SIZE);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_rxfh);
+
+int wx_set_rxfh(struct net_device *netdev,
+		struct ethtool_rxfh_param *rxfh,
+		struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 reta_entries, i;
+
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+
+	reta_entries = wx_rss_indir_tbl_entries(wx);
+	/* Fill out the redirection table */
+	if (rxfh->indir) {
+		for (i = 0; i < reta_entries; i++)
+			wx->rss_indir_tbl[i] = rxfh->indir[i];
+
+		wx_store_reta(wx);
+	}
+
+	/* Fill out the rss hash key */
+	if (rxfh->key) {
+		memcpy(wx->rss_key, rxfh->key, WX_RSS_KEY_SIZE);
+		wx_store_rsskey(wx);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_rxfh);
+
+static const struct wx_rss_flow_map rss_flow_table[] = {
+	{ TCP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_TCP },
+	{ TCP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_TCP },
+	{ UDP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_UDP },
+	{ UDP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_UDP },
+	{ SCTP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_SCTP },
+	{ SCTP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_SCTP },
+};
+
+int wx_get_rxfh_fields(struct net_device *dev,
+		       struct ethtool_rxfh_fields *nfc)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	nfc->data = RXH_IP_SRC | RXH_IP_DST;
+
+	for (u32 i = 0; i < ARRAY_SIZE(rss_flow_table); i++) {
+		const struct wx_rss_flow_map *entry = &rss_flow_table[i];
+
+		if (entry->flow_type == nfc->flow_type) {
+			if (wx->rss_flags & entry->flag)
+				nfc->data |= entry->data;
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_rxfh_fields);
+
+int wx_set_rxfh_fields(struct net_device *dev,
+		       const struct ethtool_rxfh_fields *nfc,
+		       struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(dev);
+	u8 flags = wx->rss_flags;
+
+	if (!(nfc->data & RXH_IP_SRC) ||
+	    !(nfc->data & RXH_IP_DST))
+		return -EINVAL;
+
+	for (u32 i = 0; i < ARRAY_SIZE(rss_flow_table); i++) {
+		const struct wx_rss_flow_map *entry = &rss_flow_table[i];
+
+		if (entry->flow_type == nfc->flow_type) {
+			if (nfc->data & entry->data)
+				flags |= entry->flag;
+			else
+				flags &= ~entry->flag;
+
+			if (flags != wx->rss_flags) {
+				wx->rss_flags = flags;
+				wx_config_rss_field(wx);
+			}
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(wx_set_rxfh_fields);
+
 u32 wx_get_msglevel(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 9e002e699eca..2ddd4039d5d2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -38,6 +38,18 @@ void wx_get_channels(struct net_device *dev,
 		     struct ethtool_channels *ch);
 int wx_set_channels(struct net_device *dev,
 		    struct ethtool_channels *ch);
+u32 wx_rss_indir_size(struct net_device *netdev);
+u32 wx_get_rxfh_key_size(struct net_device *netdev);
+int wx_get_rxfh(struct net_device *netdev,
+		struct ethtool_rxfh_param *rxfh);
+int wx_set_rxfh(struct net_device *netdev,
+		struct ethtool_rxfh_param *rxfh,
+		struct netlink_ext_ack *extack);
+int wx_get_rxfh_fields(struct net_device *dev,
+		       struct ethtool_rxfh_fields *cmd);
+int wx_set_rxfh_fields(struct net_device *dev,
+		       const struct ethtool_rxfh_fields *nfc,
+		       struct netlink_ext_ack *extack);
 u32 wx_get_msglevel(struct net_device *netdev);
 void wx_set_msglevel(struct net_device *netdev, u32 data);
 int wx_get_ts_info(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 9bffa8984cbe..73d5a2a7c4f6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2449,8 +2449,7 @@ int wx_sw_init(struct wx *wx)
 		return err;
 	}
 	wx->rss_flags = WX_RSS_FIELD_IPV4 | WX_RSS_FIELD_IPV4_TCP |
-			WX_RSS_FIELD_IPV6 | WX_RSS_FIELD_IPV6_TCP |
-			WX_RSS_FIELD_IPV4_UDP | WX_RSS_FIELD_IPV6_UDP;
+			WX_RSS_FIELD_IPV6 | WX_RSS_FIELD_IPV6_TCP;
 
 	wx->mac_table = kcalloc(wx->mac.num_rar_entries,
 				sizeof(struct wx_mac_addr),
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index bb03a9fdc711..d89b9b8a0a2c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1208,6 +1208,12 @@ struct vf_macvlans {
 #define WX_RSS_FIELD_IPV4_UDP      BIT(6)
 #define WX_RSS_FIELD_IPV6_UDP      BIT(7)
 
+struct wx_rss_flow_map {
+	u8 flow_type;
+	u32 data;
+	u8 flag;
+};
+
 enum wx_pf_flags {
 	WX_FLAG_MULTI_64_FUNC,
 	WX_FLAG_SWFW_RING,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 4363bab33496..662f28bdde8a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -137,6 +137,12 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
 	.set_channels		= ngbe_set_channels,
+	.get_rxfh_fields	= wx_get_rxfh_fields,
+	.set_rxfh_fields	= wx_set_rxfh_fields,
+	.get_rxfh_indir_size	= wx_rss_indir_size,
+	.get_rxfh_key_size	= wx_get_rxfh_key_size,
+	.get_rxfh		= wx_get_rxfh,
+	.set_rxfh		= wx_set_rxfh,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
 	.get_ts_info		= wx_get_ts_info,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index b496ec502fed..e285b088c7b2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -560,6 +560,12 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_channels		= txgbe_set_channels,
 	.get_rxnfc		= txgbe_get_rxnfc,
 	.set_rxnfc		= txgbe_set_rxnfc,
+	.get_rxfh_fields	= wx_get_rxfh_fields,
+	.set_rxfh_fields	= wx_set_rxfh_fields,
+	.get_rxfh_indir_size	= wx_rss_indir_size,
+	.get_rxfh_key_size	= wx_get_rxfh_key_size,
+	.get_rxfh		= wx_get_rxfh,
+	.set_rxfh		= wx_set_rxfh,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
 	.get_ts_info		= wx_get_ts_info,
-- 
2.48.1


