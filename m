Return-Path: <netdev+bounces-217167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD5B37ABE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3CF1B617C3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE9278170;
	Wed, 27 Aug 2025 06:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50B218AB4
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277293; cv=none; b=omrl2JBMZMJqguNw6fYy+LZCZg/pa+5E+F/yHfomhqgd+oGgNHCa8WJfzg4IVRE38wt/PIaW8ENiPubQTGhrgp3PBNfy0k762u2ebd+DrUG2eN+0G2EjkZhgLweDIYPqeUHypCG0NbtPMKRzgUCg88z+l3379XGccOZG1maK8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277293; c=relaxed/simple;
	bh=+NgSGu4iA4f5vCfDkyfNZMeBmwuC3tLiYMiLCAV3A6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmUZbLv+SrDWxP3i58ipV39bX993A4tCKJTZfbnLOUbzq6UA6XUhZW/FMoW/u+d7aOPdxKoRgJm32Mowj/t7zy9UzdCKAs3YuYH5XKUlL9Fk7dEru7UIwK4SOJ4T0qL1dqkCZj2C7euH5FIrIxgkFWdZBadjVDZlfw2fhor7v+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1756277218t4c7554d6
X-QQ-Originating-IP: OSW4fHn6OHaZHguZMHhKER2sQw4dRG7ngLey92lJU2s=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.194.79])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 14:46:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14614664731754484277
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/2] net: wangxun: add RSS reta and rxfh fields support
Date: Wed, 27 Aug 2025 14:46:34 +0800
Message-Id: <20250827064634.18436-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250827064634.18436-1-jiawenwu@trustnetic.com>
References: <20250827064634.18436-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M0YfekmnA1Ql7OKvKfBEYSpHhDRLRyKETAjFvSNr3eV+cRhHuM1kmbyQ
	/OrxPPK8zOrv+lDCTzaKrqvJhQ4qbQbRTuq/NrlmRAFpjriMvXvoyfXZIrKOeORaG+xqm8T
	6Vp3HpFvoJDHL9eKHU68hyey9P+6ge2cJFLNkXoAKobQm1GQZrk1MwzTifvBP069zUUcXk+
	5YUDMmmQS4A6oEWwTPhcAgTNsEAwB0+lzW954E9YVMYkQ1uV6fUG4fnrLV+/Rh3b5IPoYPL
	c7tl6SllKcFW9gR601uDQ20PwapKhUmy7N+6nUpc2og7+GGtr2hOXmpLzdfH/zOYSyDOP15
	F17aP8E00NIAAeH707nXwftS9pRvYOLNbRrSIs8Ow6+Baa3K/pQRc7FnpPlpBmMl0OVKmH/
	+xcQV7/zdeYh6WrIroUKG5OSHXuto/eDiQ3q7f+BtnSFr7LNUisigDWQlsKOGADa2FCr2K/
	Kj78mOWRG9uQ+3WofkMEmbqr3Ju63DjlSOidF0pZCtd1X8srPUxvh+gOxWbw2ff+M3AV4PT
	Xnwj5JAcf7jN8iHeGrgyHVt8FW4VU5Pgst9QFGv+unr7zFXuVYYAXq2WcIJPAWf5o9oYWgP
	7fBPScukdTPFenmO62tqPG7vDE4oWLhFMgE3/Hlnr9BOQ7Na9SAlc7CCR+Vuu+DeIdc/2sI
	YBkvi1gXRrq3x3kFICo5LF2U+jy46eJWDQyWcme/7SViEsGhNtc476AxYDc1SWyTXqPLLww
	q0tuZOIuln8EgvV0BVZ29Uiz7URJl0usN0kei3Q+u3VERbhwHSEWHLmssCEI3cYdcZDh3Gf
	XuEwnNw+AC32IzqRDnPROXckfIEJYCuP3TBAl7NvQcdMZ5iPTm8jp2OYEOyGN18dPWV8UkJ
	vjqeg8rtNqkCoYbmYPY06IdKpdxcnMZxvngr0bQkR9Bi2I1CEWdgoVJeaNWy5Rtp8Uif3rq
	tKQGqshEi/H4RtouGxbw2znwxPJjzpsGoZd1K6WRFkWhNej4LT21HKV69auz36BWSxtTzPz
	Xh4cgtnG5Q9x6tNrU3BuJ57FURi+CJRg8U++6lFcGo4eBzVJRn6fyt+di/iKs=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add ethtool ops for Rx flow hashing, query and set RSS indirection table
and hash key. And support to configure L4 header fields with
TCP/UDP/SCTP for flow hasing.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 152 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   6 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 5 files changed, 182 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9572b9f28e59..a0a46b1b4f9e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -481,6 +481,158 @@ int wx_set_channels(struct net_device *dev,
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
+	int i, reta_size = wx_rss_indir_tbl_entries(wx);
+	u16 rss_m = wx->ring_feature[RING_F_RSS].mask;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		rss_m = wx->ring_feature[RING_F_RSS].indices - 1;
+
+	for (i = 0; i < reta_size; i++)
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
+	u32 reta_entries;
+	int i;
+
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+
+	reta_entries = wx_rss_indir_tbl_entries(wx);
+	/* Fill out the redirection table */
+	if (rxfh->indir) {
+		int max_queues = min_t(int, wx->num_rx_queues,
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
+	{ TCP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_TCP},
+	{ TCP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_TCP},
+	{ UDP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_UDP},
+	{ UDP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_UDP},
+	{ SCTP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_SCTP},
+	{ SCTP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_SCTP},
+};
+
+int wx_get_rxfh_fields(struct net_device *dev,
+		       struct ethtool_rxfh_fields *nfc)
+{
+	struct wx *wx = netdev_priv(dev);
+	int i;
+
+	nfc->data = RXH_IP_SRC | RXH_IP_DST;
+
+	for (i = 0; i < ARRAY_SIZE(rss_flow_table); i++) {
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
+	int i;
+
+	if (!(nfc->data & RXH_IP_SRC) ||
+	    !(nfc->data & RXH_IP_DST))
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(rss_flow_table); i++) {
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
index 9fd0f3a5a48c..7971bc22e869 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1209,6 +1209,12 @@ struct vf_macvlans {
 #define WX_RSS_FIELD_IPV4_UDP      BIT(6)
 #define WX_RSS_FIELD_IPV6_UDP      BIT(7)
 
+struct wx_rss_flow_map {
+	u8 flow_type;
+	u32 data;
+	u32 flag;
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


