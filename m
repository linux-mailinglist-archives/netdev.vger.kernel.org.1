Return-Path: <netdev+bounces-88192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C98A63C9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC502842C8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537A3C08A;
	Tue, 16 Apr 2024 06:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C3C47B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249176; cv=none; b=fnkKJvJxFqxmnT494rLQfFAyXF324Y/6YBFu2IhFMhfjsnfy917rtdbNjb1if6h1hr/o0OZeU4+ji0QXYXKiLtaoWqZleZ4dT88mbQdZ3/bAAw1wusJrGdWs+fRNJZ7kNhB/OBabmkve6c6QZ8RZ7F9vPXGN4onzvVcI9PWLLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249176; c=relaxed/simple;
	bh=RtDbcB3T6m5txUI3o5zIcLhepWvDcWLRA7i0gtrHFIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8qNpeuGdfiHOAMyVTiyJn+T70nDIi4bPGKeqLLxu7cinHk3FGJck7R+KInunwO+E2HKJuS07cZKWDcSW8mIEbybX/VRIf8EipGDnc6UyaPqr8V+HghZxnqjKtjaqR+GjA6/thMIcKpMEtOFqsy0IhpRRVIdVyVB8j7IyZfk2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1713249024t513y8j7
X-QQ-Originating-IP: YZFoSH9SVRKmEZuUcZzA+Rs3eZ3enCvBP0+6cEUIOOQ=
Received: from lap-jiawenwu.trustnetic.com ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 14:30:22 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: YaLN/l1zgncoql3tWHXgwYKM1W3JEmEzeWXiU1FAlom5rNwf5ftk4HZWnMriA
	XzbADm7jMfPoJ/63KihfmYBTrg+eoIeMuBRQ/iSqQzpfszhkmjQc8xuHN+cghjAuNCxUQYx
	Y+PjEiQ1m5dL1OClh+kVFDxo4rmzTNGWrdzDzLZlb4cQ/xRWzr7ek7ztYOi7ks+9U32coS8
	jXNIoFNkjZ9HhD8RtfcZAySw6WT2tto2j+d2isqAFEDFuJliMgqZTAiNnyrw6jFpU0VvLeK
	tqN/jyDrg1L72DYHKG0C1GGZOrorbCUSuC+b/nm32bVIIN4t0S4XSdBGZsRka9Xuk9ypmxE
	hvo715J4DwE4XUyE8Qn95rgkKhQyN4vpIMf8mgL4u2qWu8uWC/tTgnmcB69NYNvFXZkHO4F
	hOskqiTjAZg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18092454218291556876
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 5/5] net: txgbe: fix to control VLAN strip
Date: Tue, 16 Apr 2024 14:29:52 +0800
Message-Id: <20240416062952.14196-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240416062952.14196-1-jiawenwu@trustnetic.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When VLAN tag strip is changed to enable or disable, the hardware requires
the Rx ring to be in a disabled state, otherwise the feature cannot be
changed.

Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index af0c548e52b0..2a6b35036fce 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -421,13 +421,69 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void txgbe_reinit_locked(struct wx *wx)
+{
+	u8 timeout = 50;
+
+	netif_trans_update(wx->netdev);
+
+	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
+		timeout--;
+		if (!timeout) {
+			wx_err(wx, "wait device reset timeout\n");
+			goto clear_reset;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	txgbe_down(wx);
+	txgbe_up(wx);
+
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+static void txgbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		txgbe_reinit_locked(wx);
+	else
+		txgbe_reset(wx);
+}
+
+static int txgbe_set_features(struct net_device *netdev, netdev_features_t features)
+{
+	netdev_features_t changed = netdev->features ^ features;
+	struct wx *wx = netdev_priv(netdev);
+
+	if (features & NETIF_F_RXHASH) {
+		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
+		      WX_RDB_RA_CTL_RSS_EN);
+		wx->rss_enabled = true;
+	} else {
+		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
+		wx->rss_enabled = false;
+	}
+
+	netdev->features = features;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
+		txgbe_do_reset(netdev);
+	else if (changed & NETIF_F_HW_VLAN_CTAG_FILTER)
+		wx_set_rx_mode(netdev);
+
+	return 0;
+}
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
 	.ndo_change_mtu         = wx_change_mtu,
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
-	.ndo_set_features       = wx_set_features,
+	.ndo_set_features       = txgbe_set_features,
 	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
-- 
2.27.0


