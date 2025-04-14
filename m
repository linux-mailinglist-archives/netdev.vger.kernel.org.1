Return-Path: <netdev+bounces-182073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF917A87AE9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEE83A19E6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5225F796;
	Mon, 14 Apr 2025 08:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB125DAFD
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620352; cv=none; b=U+eRgWVKzdwRrcgmLAsim/jOGjK/RveMCETImS57RP/Uyo5r205hsFXqy3Zt4XejHzqwoVO/DBLuaOZJ6VNov5w8hoWJmjpIWseoxiB40IN+06rBpZ513lUlginVT+gvoj25/SaGVcnOUPCA5fhlE23UW/hm+wfG94X0igtlGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620352; c=relaxed/simple;
	bh=p/TA1OYYyLmyYh+1BOWJD/YmsnVrwWqX560OexUaeEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+CaYD7hfngINulR3lsPiUzhCXoLk7vI6mfDtk71tpgLh/IovLLq0IoyI/9yOq385pcCKbN/Q/wH2d59hAgyMvlZw1EQQR9JdsqxrMhzkKKqSq8Sdo2ARGQhY3lmoMum29DXfJPHps8epeQrK/87T6pPRlhBVgnlTmL1+k4keoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: izesmtp25t1744620295t9a3c904f
X-QQ-Originating-IP: LdnE4VcaLj5frFG2u8YoEYETo8Umxu7hE75sG+KW/z4=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 16:44:54 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13594933487445962241
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
Subject: [PATCH net-next v2 2/2] net: wangxun: restrict feature flags for tunnel packets
Date: Mon, 14 Apr 2025 17:10:22 +0800
Message-Id: <20250414091022.383328-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250414091022.383328-1-jiawenwu@trustnetic.com>
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmIUUz9KGMMdrMMMYqkpWXJiH7aRwW3+R2HXQAkdA9lQq1cb6wWPJb9f
	hfTCriRVbQgFjmWHkQYIYb2tgIUiX0QxCPZnu36P8ydVqIEiQzOsHxz/QBjQRH8r9BqjshD
	qw1PPj8bSGuTByjQb6omm3/+TZbmBFtg0ZakKrYJNPpe0aPeg0SDGuoFgfuq3nbngV6KDht
	GXa8q6uyn7lPlcMsvuYyG8Gev9y+fwLAjUbfiqSF8FbJVGpvGEc2Rc3SfZMX6ntcbIydQA6
	PjiwB+hfGwKLncRuxHm8r7PSPc0NObJCuIyHUZ7JlZBv6nSisP/LUQQvzHMKALhddFlYXhv
	pCM5TjH9wKTN90mkOqsydJUk0u0u0Gduv1ag3II18ypP/eect5pbDozhLEqBgUMoWPq+mjk
	oD4lKwp7xvMkD2MzIOglQ5WBPIe8ugHoZenOoGYjABym9VJvgFuRXPhVO9n69TOkICBCKpQ
	1EzPS4hLuxQ9MXDuPwwuCK+fvKEB0iRdr6azKhQ0K7InhTPD/yk8NKAaexkQq4Vv651Z1Oe
	q/PcVEMNsY8UpmFkDaQcczl1ypJeNiU2pDa6MHSwrEnDXqm3JDsBDP4+KXFDrli0Ozgv+o9
	EyEAWqAlo7e1O/KuOf6r/C91/7AsPJcAUzeKOt1Qm98KF4Vvb+rMyaiX3L8Y1GLdgwkTN2q
	Rm2MUZcz9DTJB+H31uRz0USmWRfdLvmjp8bu2GlvEPhUjsR3Q4WsIvi1SZTsnSVfJWU1d46
	AbjienBt9O1jWPs9QD5WLxlvtCvHoOMa9qUcAuzHzhJJ9hCK8BkB6dBZKLhnCqK0OhjJH0U
	MNEM6qcBNGPLPVrziIk9SjIbIZj4POG4gX2QqogKUEq/ed4nRWl3dUGqmFXecDqnHt+pB1N
	ZxIyTucmHWO0WSSJ8c/YeMQqS6nk8+hUBNW2afHVCj9dkdy7pJapC+OSddSnjxt47EWagsd
	1xCyvrN3FzRHBWNYOefMysKKf1xmcaooJ035WkCPDU36p5S57D95eMjtWrnAW5UaavUJZUu
	yzF0mAzL3OYw/QcV2ir9JoKrElAV9NGNLecbGL0A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
index c3b0f15099db..259062b8f990 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -629,6 +629,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
 	.ndo_fix_features       = wx_fix_features,
+	.ndo_features_check     = wx_features_check,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


