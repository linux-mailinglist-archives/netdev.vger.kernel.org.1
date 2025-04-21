Return-Path: <netdev+bounces-184317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CAA94A9D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE9B7A60FC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431011C3BE0;
	Mon, 21 Apr 2025 02:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4D179BD
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201142; cv=none; b=GwStYJ+B62nZdM27gW7BAXJZv9leMHAJT+Vrp403vygOAABXx8pEx6rQ8wQTQVX1MjY5VW1r0OpcbMgm/a8I95ESBnkqUDwiJuR4T9GWcErTfcDde9a5pl3xlflEHVKUJ/ZxMsMEQ6Wlo6N5/B/7XqXkfsyWvY/T8N9YGEuKWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201142; c=relaxed/simple;
	bh=QkjxdziRcudlBDsG3vGzr/JQirT6P0auIYQ5WJkKQFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqAq9Z5GtoV+rfENv/mn3PUnpSZpRBYsQZB7t1jCjL9Gb1OuQdpwKY7oSv8n+HlUWDmuisxNDCjlVs0dJHv5ub0XOtu9PP9gEY4AIlM6zmpmAYEl1R9Q9MvsSUqPwCXvzN7IWsg9lzgSA11mPVhtbhDwPOnz33XPv66v+kictyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1745201080t7b6f93af
X-QQ-Originating-IP: fdZEMA+yLSktxERZFuRjUaq7o98rqdDXwHd5ARq7qFY=
Received: from wxdbg.localdomain.com ( [36.24.64.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Apr 2025 10:04:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14057136397803681486
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dlemoal@kernel.org,
	jdamato@fastly.com,
	saikrishnag@marvell.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH net-next v4 2/2] net: wangxun: restrict feature flags for tunnel packets
Date: Mon, 21 Apr 2025 10:29:56 +0800
Message-Id: <20250421022956.508018-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250421022956.508018-1-jiawenwu@trustnetic.com>
References: <20250421022956.508018-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MACXe2l6e7j9/LwknU3KQnX6EKK92imky3tchgecs8irR5fpiKjKamT5
	K2bwIOAN4GKneilLSMqNZlfFb91bb59d1uYpTe1El1iT6K9cd/ueGuzQKjhWx497LvnRoQI
	bn8I8af0OfdgPqsrAXv8rkAe1Dk48EAs6XMkUvUdSqAJDUU80zwmnF4XdtlKhqovJecdpKf
	SKSOCwD9TVqQu+FMTw5RYXFPkFJzKstR67LNU6JdUYhtHhy+X71joDIJwP4WTu0jmoL+thj
	MEySu/wXBQW/ecHhK5FTOKD8jy3xSb5YDzRBWg6E+PRrG2ORu3UIyV4YQM7FPyqg2HVRlkD
	IiKIje7KbkrkPJP0cOtt6v3VIRSooUWrzsyNTUwv3Puv7YtQi6jsEghMCIGM7hqh0u215F+
	duyM6+gset5aiZkTGk73NlzBjefDIUIDHjVTkrnk0FuCh0VCMXJfj5q1A71G7PWaW8fQ8wH
	z88v03jMYtaFy7eMdMEVLKeyQeoqD8dXHfyh1uvnBFVa0wJe8KcALaWmyadV+eB/8lU62Fx
	77iK0ejpsgbqlPjIRNTj80/zAt0NVMmam4EddxyhNN4PX64eYzLkIdcjm25SkVaGdYnKrbc
	eR5pfOJYDBycm3TFcf5QqVbv9aiFvZOoemuQPx2rcWIRbt8k74/DW0I3OhrBCg6hgGnavgm
	ESPuw00qQsfid862gwfWrMzxRWsHcojAsMb7QaxWldlwEPXfIilyavtjqzs3wHZMHuKWIyM
	kGoTLI7fv/ot1+lKPdVk55BQjJej37d5N7KID1H2p1deuAfP2fa3BHolfc/mn43GHTvYo1o
	OVMOBFjLtTCynsmjastXoUwh/tACd1FI4GcXlyCJCL9+0WQ8hJAKL0ZwBwtaVrnamlVw4ae
	OdDTuBSGlwICZdAf1gFcc/GKeI72qdiGvFgcLFd/28r8HocZPuIoDCwhPa9y/6NRbpa/chq
	T4nJX+bs5cQcYhPI+jGUBvJkfmNG9t6qa3dwzjS/MQhE1Xtlafi4JsZPzlj60K+RwMa7DGP
	ByLV3iCf8SwyjRsgvzo9oG7B3GRYw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Implement ndo_features_check to restrict Tx checksum offload flags, since
there are some inner layer length and protocols unsupported.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 18422b940dbe..2a808afeb414 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3000,6 +3000,33 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 }
 EXPORT_SYMBOL(wx_fix_features);
 
+#define WX_MAX_TUNNEL_HDR_LEN	80
+netdev_features_t wx_features_check(struct sk_buff *skb,
+				    struct net_device *netdev,
+				    netdev_features_t features)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (!skb->encapsulation)
+		return features;
+
+	if (wx->mac.type == wx_mac_em)
+		return features & ~NETIF_F_CSUM_MASK;
+
+	if (unlikely(skb_inner_mac_header(skb) - skb_transport_header(skb) >
+		     WX_MAX_TUNNEL_HDR_LEN))
+		return features & ~NETIF_F_CSUM_MASK;
+
+	if (skb->inner_protocol_type == ENCAP_TYPE_ETHER &&
+	    skb->inner_protocol != htons(ETH_P_IP) &&
+	    skb->inner_protocol != htons(ETH_P_IPV6) &&
+	    skb->inner_protocol != htons(ETH_P_TEB))
+		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
+
+	return features;
+}
+EXPORT_SYMBOL(wx_features_check);
+
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index fdeb0c315b75..919f49999308 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -33,6 +33,9 @@ void wx_get_stats64(struct net_device *netdev,
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
 netdev_features_t wx_fix_features(struct net_device *netdev,
 				  netdev_features_t features);
+netdev_features_t wx_features_check(struct sk_buff *skb,
+				    struct net_device *netdev,
+				    netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index fd102078f5c9..82e27b9cfc9c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -587,6 +587,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
+	.ndo_features_check     = wx_features_check,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 83017cb0ff3a..fa85069898f5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -579,6 +579,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
+	.ndo_features_check     = wx_features_check,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


