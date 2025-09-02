Return-Path: <netdev+bounces-218983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CDB3F2A7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 05:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA5B484F86
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEC286885;
	Tue,  2 Sep 2025 03:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038A2853E2
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783537; cv=none; b=CJn3wwhLhwUxDozpVpXJQXlp/uLkJ3/bIzNL3gO/qQ9NOfMmCTZ0aBDlmPSla5U8R5ssrf5t+Menpd3HSQOJveNvgPU/YGpDhVJEE3Lu9ikXReIv9gzb/9XFGgjbUcbXjzRGHZoX7lz8KDuADYmM5V0nJAnjiaErva8YcEaNxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783537; c=relaxed/simple;
	bh=vjEZdDpFMV3rH4VU4funv7m4JRXeK5IqYMfy9h7k71Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZFiGOMLE0PDmxplQZpgc+hXnQwsV1wWo1uJ8dHO+IW/k9em+bcmdBPFpwDipqLxRSSZHbJrbea+JxSIGvzbUb9fBiKwEbYzw745aKA3POtUtcMhyhiV6ssky14ZgxiQLIyrg9YisQzHCpp/3lfqxuwYvJcVeZ2EbevIqyu929E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1756783454t8b96391d
X-QQ-Originating-IP: 0Opae5nSjtTUrpgOOEGpCgl6PZEYioJAiwUtRwn5Iwc=
Received: from lap-jiawenwu.trustnetic.com ( [115.227.135.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 11:24:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 627418564836035955
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
Subject: [PATCH net-next v3 2/2] net: wangxun: add RSS reta and rxfh fields support
Date: Tue,  2 Sep 2025 11:23:59 +0800
Message-Id: <20250902032359.9768-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250902032359.9768-1-jiawenwu@trustnetic.com>
References: <20250902032359.9768-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWN2NjqHd6+NDpne9uPy60LP5um4aXvKcTwyWgfWybUvPQSNKkKLUYum
	67A4fC+STTPXBwmnr1op2LrE1y7m9InPvPxfW5iY8JBwx2UaM/vIv0ii7Kbi+vvk0b1MR/G
	anq4tab2fLuyV8+EsusIlQU1sey7/rFa+6DPkzJVuCB+84RrcUd84tFEq8iEvkbq5mn13CT
	5Xz2nimh1uoPOK+1uxebQP0iPWaXPhL4rokzIHj4Rx0ZEr4Dk99oyIYo2KC88nVgAPBFOww
	0Y/MoQfcjFgc177moc+yAYCmAZyvOAJkz41p4M5HqDeJwtz2mNQ+so4YDcZUidUVfCXeWfx
	paLtQq/CCaSilZOoN2y1xd7k9raeX72u/DCJ9sHuxqb8q6NHh2j4pm/mjuwigyzJGLwj8YW
	U/Kl9mzpCfEgCBYZFd2xH8IxM8VH+opNAtVAB6dpYst68fW7l8CP++/v6D57gdmJqMOc2w7
	387sPev0JXztggt80EyxuziH2zPQ8oeEesvvbboZNnYmpSDTGKkcEpBbMcYhmANOafEBfHE
	D+mJWR5eCKQUNkJ9PkwCydBE89JZ9Axw+ffUzs6xX22mQvtq8xIqYdPDxqmk+U50kzOv1vQ
	12GWrHQlXFEdelYILgbEKy9iLVjB2sG+cCTSSURNRQORNFik+aa49isJalLSnND85uBPiVc
	09Qal3tUZ/Q18ld71Z8NdVbFzH9NLbO9h/GFs38KSjvFzXDVvUBohoiWeJSsL7JepXoPf5u
	GELo1hzYLUuQ0qmAz4KygXp6mEPWYtwWdenXCiY1ghredBst94QIC5U4qEhv283IuckUxyZ
	PKa/ptn+shv3wHLciPPcGdri95PKcy2iOCFXYQ/J6uuDkeaGOrVoI6ICivonKtKEfuUpimV
	81T1qr0mZtaj1PN9LaYQsfKjsNeYHvOMXnOgs1KiwoUQg4QUf2p6/Ky2FcQc6rV3kImGgpx
	P8rCp9ciC6J7MQWHJNZ3snw+CCTBQgWDeTADUwof+mGL5ByYNvkyOXbNm2iBHNt5SG0MWPq
	ZMlrc7oblcvYDTMn/jrOybvLGknmLP9V8oIDpo7Q/y9ERe9f0ao437KBI6sbbiQAbVenje7
	VbbsLd5D2Awwc6NFFHkh+A=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add ethtool ops for Rx flow hashing, query and set RSS indirection table
and hash key. And support to configure L4 header fields with
TCP/UDP/SCTP for flow hasing.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 136 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   6 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 5 files changed, 166 insertions(+)

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


