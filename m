Return-Path: <netdev+bounces-183631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12962A9156F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BECF17592C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA5219A8C;
	Thu, 17 Apr 2025 07:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531C1AC882
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875524; cv=none; b=LOcSN/AKfMbJFaKTDzopz7nMjrJ0ohJ7xGjoUPNlnNTalfYD3uK5om5vwBUeLPr66EV2XSmX/qB8meYTEqM9bf3ZYxAuligu00Rr33k/Ovi1MKR6aOvGD1i2YikHCFV2Y8PqDV7C+tHMvRd7qigOyMXLmbYWfLcJZJX6VmDOgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875524; c=relaxed/simple;
	bh=N2pU4lxLznnELwJAQuZJ+ofUI5qfwb3FqbNsy0EfRQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oe8a9WtZUgfox7P7UOqJtVa9WbhM6pr90f1tFBCNO0zxmoDzXu0K0OIz0Vl2MI7gYxcwB+PBZVAX5E4S55MWYM6G1M2VhvaYwdhD5ouTfSD5JWtYzMRuge0HCVfDXAFhuC6f4c3tlQUNR/KafCwYaxZ8IumFUfp5lmZvzfHM1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz7t1744875482t49de3eb3
X-QQ-Originating-IP: IAyjnsusGrq9Fazvc3NVJ67F42pYtTWC/wdji12B2Lg=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Apr 2025 15:38:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13897518688819981051
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
Subject: [PATCH net-next v3 2/2] net: wangxun: restrict feature flags for tunnel packets
Date: Thu, 17 Apr 2025 16:03:28 +0800
Message-Id: <20250417080328.426554-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250417080328.426554-1-jiawenwu@trustnetic.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N+n6UtIkOPCaW05aZpttWrh5PTlXkObNnqtrw8KjWgKUGPmSnOdN2Tfe
	fd813IqBsfWKLFJ8GPZUFLKKniSU9cKEPT6Co9siCTrAAwIRSv6QUBLx4OFJscV8DnQQs5U
	75CN5+tfceaStoyTyo4mke8KrWThGbMMRqVYrqMgbdScMkMP6DOGQ+7CVTTOcuNuJNk1P1L
	d/3cvep1tIpH7BVDEur140FWAIk2mSYwSF7uXxbAQ3yrNMg2B8sMeGCgYKhs0eSoMtnZ+f4
	aMLgcLu+PxurJcUpnOt4aIKvOwAclg9cjSD7erX1dpktIgNxhwPlF2sYlkUeXlQbhsz87ue
	fWZm9ouhm5Yl1S0okTutI5q97ImG7RBh/KKetnXv/1iaUOulqCBakIWt6hS+5gX+gSStSWE
	CIBVh7OsodyZVZC/esFc+JoXoxnyljaxJIN6HVk1rlBrigBnTN6Uvc2tOdw6WUGECzNAZv1
	7MaZ/xTqaphd6nZKO5Kn8KK/TYevMmaWJ8E7881Vc7xcsm0r+15zZQMauCMCQH3pmwnLr/w
	QaE8yXaRpPqysw2iktNcgYO6QRwZhMDMDsDn8+78WQ+FX52oROXEL/fglkAaKgmJbLLVvgW
	YqWptUs3BbC5bxJVEPOSjiehtO8BXp2csKGqr2HxdV1s8bldPZI2svo67YAbn8SLIoD/QKs
	qMMJK2Of8BcsaOBeNpb2JdiQMcKCa+iz/x6336DJ4/67zZL8d0VFh5XeHEzJ0vX4rpCNnfe
	ToKwwd2XJNQPMA0d8fCsaQAuv8kNGmAbnvuJ5QTAkB2+f59hNfSERtHjwBRvXd4fNkV9Nc1
	/woHNNYnrBwm4hS0KGrrrdtSrVzMABSVmh0ZZT/78NC+nYqaem49s6l5mBfGW/3B5bW53u8
	4tUNtcW7oL8XaQ1aI5UHW6tPbhSJzFNHa1UHQKmPAItfdBuNV80k9DmPzOAPd0H1HhAlFnl
	qKJFY9r+Dtz8F8O5bd6of7nW6jNgoiurmMm1wnvOwIiGjGrN1LlBR4K3DOC+d0HpVoLidnb
	3jHfInzQyQbuIcptn2RL+PZlk07VEBY9aZzJxApQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index 95e5262a1e9c..80e6b01c799b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -581,6 +581,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
+	.ndo_features_check     = wx_features_check,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


