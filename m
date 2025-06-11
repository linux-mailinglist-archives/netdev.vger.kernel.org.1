Return-Path: <netdev+bounces-196625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDDAD5971
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354243A74F6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254672BEC23;
	Wed, 11 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwqzYKsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012202BE7DB
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653998; cv=none; b=ONq5qbGPs7QZj/TA+HUfSsqQJWb11+JVhXmx7YkbU6AdJMo+UD986H1jkFCnvAfhuXeNS+rvpDxOlGUVdTG2MiXsjfhMZG0F9AgBX+BWGIgldyJ7WIfXILBe5z++iFMAel3DuLDYejum1BwHGbJ3zx1dMni5iBrYnxKLvIWNYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653998; c=relaxed/simple;
	bh=Rc7VhP1nQTXrf6x06iR4UAJks1WQWUusuCmoqGV1CO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qneLlxSoUFZJ2xlGcvpk+fUQdadndIzbYH1z5Iyt/FA1rtj8KhyEZRcrvmP/+FjghJp/29z/sotFmsq2hFWvkvcJZhJv9J8uCV+hz6DxlV1NulirtlQ6Bhy4+twRKhfO5q03LisIrSCoVJAtkQm82UnZZUMiUJds9gptq8/96fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwqzYKsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F824C4CEE3;
	Wed, 11 Jun 2025 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653997;
	bh=Rc7VhP1nQTXrf6x06iR4UAJks1WQWUusuCmoqGV1CO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwqzYKsVV7ciTllhQjt764auEyzTjFe84rdZzj+uanlUYw7nkfNMzxFYf95yREBBt
	 hF7OrrJVCaGCWKymmWr7o+hhPCzgzTdI9uVPfrftF1b0z7nLlAGjDB0MQD5cAN3+97
	 rrTROqB0i/9NT5lkXSJ+NZLKbZq2VIYa4sLa2QT66QzTELxk8TBQw4+aFexWrTtFQv
	 ++kpo96qhKVST6O5OM5qybKoJZK5KY+oibOBRRlT3CobP4RhPNSsOejvNznib99FVr
	 7yVvibnwRWk/KkA+0xE30kQvksf2dlMlh5PPgskWickVtAYTyuEBb8bRX/hXoTAPng
	 kuorMTVRs8HpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 7/9] net: drv: vmxnet3: migrate to new RXFH callbacks
Date: Wed, 11 Jun 2025 07:59:47 -0700
Message-ID: <20250611145949.2674086-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new rxfh_fields callbacks, instead of de-muxing
the rxnfc calls. This driver does not support flow filtering so
the set_rxnfc callback is completely removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ronak.doshi@broadcom.com
CC: bcm-kernel-feedback-list@broadcom.com
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 74 +++++++++------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 471f91c4204a..cc4d7573839d 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -833,11 +833,19 @@ vmxnet3_set_ringparam(struct net_device *netdev,
 }
 
 static int
-vmxnet3_get_rss_hash_opts(struct vmxnet3_adapter *adapter,
-			  struct ethtool_rxnfc *info)
+vmxnet3_get_rss_hash_opts(struct net_device *netdev,
+			  struct ethtool_rxfh_fields *info)
 {
+	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	enum Vmxnet3_RSSField rss_fields;
 
+	if (!VMXNET3_VERSION_GE_4(adapter))
+		return -EOPNOTSUPP;
+#ifdef VMXNET3_RSS
+	if (!adapter->rss)
+		return -EOPNOTSUPP;
+#endif
+
 	if (netif_running(adapter->netdev)) {
 		unsigned long flags;
 
@@ -900,10 +908,20 @@ vmxnet3_get_rss_hash_opts(struct vmxnet3_adapter *adapter,
 
 static int
 vmxnet3_set_rss_hash_opt(struct net_device *netdev,
-			 struct vmxnet3_adapter *adapter,
-			 struct ethtool_rxnfc *nfc)
+			 const struct ethtool_rxfh_fields *nfc,
+			 struct netlink_ext_ack *extack)
 {
-	enum Vmxnet3_RSSField rss_fields = adapter->rss_fields;
+	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
+	enum Vmxnet3_RSSField rss_fields;
+
+	if (!VMXNET3_VERSION_GE_4(adapter))
+		return -EOPNOTSUPP;
+#ifdef VMXNET3_RSS
+	if (!adapter->rss)
+		return -EOPNOTSUPP;
+#endif
+
+	rss_fields = adapter->rss_fields;
 
 	/* RSS does not support anything other than hashing
 	 * to queues on src and dst IPs and ports
@@ -1074,19 +1092,6 @@ vmxnet3_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
 	case ETHTOOL_GRXRINGS:
 		info->data = adapter->num_rx_queues;
 		break;
-	case ETHTOOL_GRXFH:
-		if (!VMXNET3_VERSION_GE_4(adapter)) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-#ifdef VMXNET3_RSS
-		if (!adapter->rss) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-#endif
-		err = vmxnet3_get_rss_hash_opts(adapter, info);
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1095,36 +1100,6 @@ vmxnet3_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
 	return err;
 }
 
-static int
-vmxnet3_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info)
-{
-	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
-	int err = 0;
-
-	if (!VMXNET3_VERSION_GE_4(adapter)) {
-		err = -EOPNOTSUPP;
-		goto done;
-	}
-#ifdef VMXNET3_RSS
-	if (!adapter->rss) {
-		err = -EOPNOTSUPP;
-		goto done;
-	}
-#endif
-
-	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		err = vmxnet3_set_rss_hash_opt(netdev, adapter, info);
-		break;
-	default:
-		err = -EOPNOTSUPP;
-		break;
-	}
-
-done:
-	return err;
-}
-
 #ifdef VMXNET3_RSS
 static u32
 vmxnet3_get_rss_indir_size(struct net_device *netdev)
@@ -1361,12 +1336,13 @@ static const struct ethtool_ops vmxnet3_ethtool_ops = {
 	.get_ringparam     = vmxnet3_get_ringparam,
 	.set_ringparam     = vmxnet3_set_ringparam,
 	.get_rxnfc         = vmxnet3_get_rxnfc,
-	.set_rxnfc         = vmxnet3_set_rxnfc,
 #ifdef VMXNET3_RSS
 	.get_rxfh_indir_size = vmxnet3_get_rss_indir_size,
 	.get_rxfh          = vmxnet3_get_rss,
 	.set_rxfh          = vmxnet3_set_rss,
 #endif
+	.get_rxfh_fields   = vmxnet3_get_rss_hash_opts,
+	.set_rxfh_fields   = vmxnet3_set_rss_hash_opt,
 	.get_link_ksettings = vmxnet3_get_link_ksettings,
 	.get_channels      = vmxnet3_get_channels,
 };
-- 
2.49.0


