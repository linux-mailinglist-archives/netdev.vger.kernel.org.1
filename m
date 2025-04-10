Return-Path: <netdev+bounces-181114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE0A83B1E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D99E2F70
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15520D4E1;
	Thu, 10 Apr 2025 07:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A820C490
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269604; cv=none; b=CjUjmVBW0Avd/Y8tKy/MNU514Ah0tqE0kcGCAECIraZJL/WIPCt0yMskqw77aIIceyokbKaYEeXQs7fxXnFCwO5plG25fZ/9fGSDDQcOZ8VNTZKYlG2YWJMTkEx/adK7JWRVVtWKdOTIRIrNTzAmBj6ckYCkP4/GFdfNmBJ2QZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269604; c=relaxed/simple;
	bh=St7/BpFDPhZxrzxDDMFK+2EdbsTAi16LvLLVprbQ8ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/ZJQqChJg0l6GQvziN5yJwWjmFi7XNAq21yoOBWe7SvA9EhV68I+U2Iomxhp9D1Pufbp7w2+40XJr9wAZcxyEDDGaeCfGeEIK7kSzN/St8z1jG0h91Z1zf7N2rR2OdqH+8TybVX4TLG4aWAo4AVSLCdz1+UNoF2DVShwvaaql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp25t1744269563tcab450c
X-QQ-Originating-IP: vmTzg8RGk1gnd5v/wmI5VliyzIzyFRbHWZwzGjTVj0A=
Received: from wxdbg.localdomain.com ( [220.184.249.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 15:19:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12800924943129427438
EX-QQ-RecipientCnt: 16
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/2] net: wangxun: restrict feature flags for tunnel packets
Date: Thu, 10 Apr 2025 15:44:56 +0800
Message-Id: <20250410074456.321847-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250410074456.321847-1-jiawenwu@trustnetic.com>
References: <20250410074456.321847-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MMKL56urm3zQCu8/kULort6YEOykZa6CbEY/5xWn8qw8xnS2cx7tvVtv
	jV2kTac2CF9F3HFjKUGS7H/P6XneIeUnkkEbmhskVbK97L8GHWYo5YnjSLGR2kUNELW8fJJ
	pRbppAEIsx5xrQK5WO8a7eKn4I+hm+O4usr6TBqyZHSGJ2nRT/QZ3tOFQ+GZsvo2UMkpN1j
	l7ZvwaLRGDlKORFDRZbZxZkDY+1Z684uNmGsoTXrtXy6DpoNAUbDg4BN02VF7yu5zIrOe6D
	gaWyWtw5rE3ZufVRL+QaPug/YxYWhVpDFAafhjYhVJfNTWSBohVn00CneNNFlxnPsG4SZF+
	dVEtlUlkNIvndAMhjUmivB3+Ww8oVgwXhu0OZb1J2UM/mXClMprvxChMnsxw7/mC8wpg0+h
	fiaG6OV07HdD1/YAlTPGPU8+AnP6fkOYaTmp5OlQxIUPuy8OKozwlh2ite31+RTg2Hln3rn
	w0BRX0nUX+6FJ/tbsI1o6oziahwQ3jq+9ZnI+E2q1lE3CrSQjqvTkU8BiSKMeFYoosUWeHz
	zb+2wEFSTV3oFlYoRmEdw/A6ixWSoywNCsLVMT+ME44eXzAoejxs2w1U+OrA3RPtSAI9rbT
	oKJDsRrbW8DjplX8ZxI+VMlWqKX5sPdNO9bOuMYkSNzt2RtPEc2y1Od7FpLMG6OozH+vgRZ
	dFIFHjcV5SLgzjGBD+FUHRCiZx9W7FsTltQS1/pfvSoXqsbVViA+wzyaRnfqip51smja6ja
	QGEcm3NcwsD4s5x+Jq/ulV9ZHgS3RODBwj35xWmf+nTF6+H0MHrKe2rcG8Y2uD/r0l5dBpS
	FLuG/D1sFJGp/juyfDD7I3nrr1C63QQZuCeowK2QHvo5LieLcK7Ry0h5R1zse6gztIkvmI4
	SHciInsGZdDRPPhAlevCfi9HYC/oCDkSK7ws0U/SeKHGG7PL94mD6qjh+d5n1vu82B8qYKA
	+MstOKbY4NY2e6NwYju/YPLCwVpE0AlCqBL9lgvltrsFlGR0RVLie1mxpvB9zdMrNip9FCO
	CTXNZA3A==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implement ndo_features_check to restrict Tx checksum offload flags, since
there are some inner layer length and protocols unsupported.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 59d904f23764..a1f9d2287fdc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2998,6 +2998,33 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
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
index c984745504b4..0c5d0914e830 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -656,6 +656,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
+	.ndo_features_check     = wx_features_check,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


