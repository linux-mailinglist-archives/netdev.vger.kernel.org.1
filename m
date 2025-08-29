Return-Path: <netdev+bounces-218186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D5B3B6F8
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B645A1791BA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E942FE04B;
	Fri, 29 Aug 2025 09:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CD6F53E
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459166; cv=none; b=aNtHHDinsPCtxSB6VhEKSmyo/0Mz0hJozBKNMwgZx9c6SOQj9CJ/kG8bBE0V6Tm4fusoIIGwU2hHQwGPbziYKjZqUD+XH19cOcFk2d2ic/sKt6TWjzXGAc27/NUn8sgehQ6yMyc0uaLJ5gFoZYwSqd0TlnoeCMwk2FsgXrK7rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459166; c=relaxed/simple;
	bh=mOplHQWMf6MfdErdrYxWdfAdPBqxWAIjUsr30j2YK/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRyDebKuHFgPuAeNcoCMF2DTnBp5pcmWH927y4goM/7EyngKldddIoFdtsI2n5wPeceWYMhxg/IjzZrXI66JiXbM04ZB6fIZbx++a5yC4MJBRURS4i/b94pDXfRGCfmvIs0Ye+g7eVXXDmP809lGiks6c/VZy8Hx+2djn2jnDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz2t1756459092tf3eb6cba
X-QQ-Originating-IP: 4dk+0XskdaXJHfyiDU6eSP+Af5V0ZVRwalm7w0vMYEs=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.194.79])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:18:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12276783638290658564
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
Subject: [PATCH net-next v2 2/2] net: wangxun: add RSS reta and rxfh fields support
Date: Fri, 29 Aug 2025 17:17:52 +0800
Message-Id: <20250829091752.24436-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250829091752.24436-1-jiawenwu@trustnetic.com>
References: <20250829091752.24436-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MyhNtuNETreemH8z/BJ/Db3oW40xVIy5iJ9Wdq0/b4c5GImjLClE2e9n
	oDePzSpixkXrJUxeGvtgUnImFsUvDC05CKDXf8mkCWVVlG8NLjYj1jRkT67Hfr/XWawgwiN
	RaAhyy7lK32e/wwEI/g5nafi6YyykPqG49JUsZDHpraD6WT6N+EYX5ghvkcwcB1FLFW3GR3
	M/LoOOBY86s87V8Ni3/OOumO+PN/SYCVpvVgqAo1sc4wTGzqEBmr10YEaYo3P3G23EKpNLo
	gz3Qne7+tl2xFYoXJb9IeHRT0V8Ub38DkjK+ZDwJiaSDTP1jJCLLufzOv3H1I3avLDob/QE
	gmyxzDyXPQ8eDREQlHTWveJaO1IPVQqf761pwS6Fvi8HnPHu8VzjIsFZkMZoGOmE1pfcvsn
	Op/N3xLtS2pZemPpSIGcKUD/iBKIYLgrw6Tc9Q38eHLBbScNsTYrZlPt0UU2FgFulpnsQre
	50YPP5Stjj2a6NR6WzGxlnWudXVIcZOCwmBPEwJzwsZtLKXoCnTa3C6LZaZcxjyABObT0NQ
	06/+PbKKFJe3dJ2DJZAXYFTeH9Fs30i3neOWR/29CYcYfFi91EyrZOtjS9U9v/5pWlhGdjs
	9bhvlJxRB2qeS+vqbzucOFEU4QCJieyYR3fc+cJUKanTkzJdDtMqMvuLCtt2lvWEweN6rOO
	EluqaTCNGnWo2oUki2wt7hR183XqRMtZv4Yl9FdgBXjjOpFtsd7jao0dnT6+P6aKwmZhkEt
	XvZKzGBpyOLxOm4x1CDmc0hpY9bWXXm7muWdnD0zke25ueFd6PneA4G9viYDOaRo+BflkvK
	hwfKDhKRJvCd49+I4DShRoUZ0e3PPZA4zQqsFLVKK4ETi7A2qoAu0hVH/ATzzIt9Xm4XmiI
	hcTx4r6sn+z7gEs0YR/zR+qfdxfQOe7GyPfizK2h0uOW6SaXO1q/26ar67ffyKdjd60yCn0
	euHFp+794rQnzlLzrlSqZ6KO1yhZIaoJIwe7WBsI48pw0310MqjVHKjt+OUAZUs0YoASje8
	BDWe+bUeKr0AXhRnjEB/6UINMbH75NtKw8nuZpsw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Add ethtool ops for Rx flow hashing, query and set RSS indirection table
and hash key. And support to configure L4 header fields with
TCP/UDP/SCTP for flow hasing.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 149 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   6 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 5 files changed, 179 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9572b9f28e59..a49c71d17504 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -481,6 +481,155 @@ int wx_set_channels(struct net_device *dev,
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
+		u32 max_queues = min_t(u32, wx->num_rx_queues,
+				       WX_RSS_INDIR_TBL_MAX);
+
+		/*Allow at least 2 queues w/ SR-IOV.*/
+		if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+		    max_queues < 2)
+			max_queues = 2;
+
+		/* Verify user input. */
+		for (i = 0; i < reta_entries; i++)
+			if (rxfh->indir[i] >= max_queues)
+				return -EINVAL;
+
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


