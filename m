Return-Path: <netdev+bounces-197578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79DAD93C0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E9B3B4E52
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A11F4722;
	Fri, 13 Jun 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVPjdWJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886332E11B1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835674; cv=none; b=lFVDYMlfCIbKYIZTnIT8PxE7e5iOk7MI3GOpn5Z3RIwheRpa+7sIo79FEESeEs9zFtuIBW7L5WBOVzMr5xyWmhFKkB0n6oFOUzdSwXn0yH+uqZfYjKeUSj/OkZPz+DNfQSV7+YTTkK13OU2tCNfQRHnSDv/tq08gU24UbjblGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835674; c=relaxed/simple;
	bh=PUr9DZ7exrQCYXST42uXT2sRzqpy4JpbqGgorVkLOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmMPc3fDBywxwgsXCfugwyS8U4eum3inJyL3ir/m4s9CzKd6Kxi0pasNvF64KJ4EebKnum30HeQpIFMD/fJxj6Zc0h0fBnpyDEr9Ey1cIygXACiJtG8eav8MDMxjJR1ikCH+RbvXa9Q38yybwTvcTclSgX0SQFQafB955XgyKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVPjdWJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8235C4CEE3;
	Fri, 13 Jun 2025 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835674;
	bh=PUr9DZ7exrQCYXST42uXT2sRzqpy4JpbqGgorVkLOWM=;
	h=From:To:Cc:Subject:Date:From;
	b=IVPjdWJEWM1kmEn1KltOGkQqGTJ+87M6ut9wNGYjVBfT2uCLDbnSi3Lh72axZVFXx
	 JkJ827NMMp1bFSl3GmoMe8rT77dcF0RIAAEQckC1e6VmZGVF+0cbXDUi39vDBoEbzB
	 JaxTh1UJj4QhH85uGbnGMQU2JyWOKgv4vPReA2HRrERsfdslqmB701sVeZoFAJFL7n
	 8gfWkhr3myhxSGJhHDjsGQa6uTbsUAJ7T4FumDOEBK5Mq7q7tDAXJQoyLY7iSEqswm
	 Vzu3HeT/1sjUbitFeNr47Ct5gUH9HWDr9paGgV4+3WmbjmWAeZvneXbP6B1g6gGJnl
	 hk6dtrsUeir7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next] eth: gianfar: migrate to new RXFH callbacks
Date: Fri, 13 Jun 2025 10:27:51 -0700
Message-ID: <20250613172751.3754732-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Uniquely, this driver supports only the SET operation. It does not
support GET at all. The SET callback also always returns 0, even
tho it checks a bunch of conditions, and if my quick reading is
right, expects the user to insert filtering rules for given flow
type first? Long story short it seems too convoluted to easily
add the GET as part of the conversion.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I sent the GET-only drivers yesterday, this is the only SET-only one.

CC: claudiu.manoil@nxp.com
---
 .../net/ethernet/freescale/gianfar_ethtool.c  | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 781d92e703cb..28f53cf2a174 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -781,14 +781,26 @@ static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow,
 	return ret;
 }
 
-static int gfar_set_hash_opts(struct gfar_private *priv,
-			      struct ethtool_rxnfc *cmd)
+static int gfar_set_rxfh_fields(struct net_device *dev,
+				const struct ethtool_rxfh_fields *cmd,
+				struct netlink_ext_ack *extack)
 {
+	struct gfar_private *priv = netdev_priv(dev);
+	int ret;
+
+	if (test_bit(GFAR_RESETTING, &priv->state))
+		return -EBUSY;
+
+	mutex_lock(&priv->rx_queue_access);
+
+	ret = 0;
 	/* write the filer rules here */
 	if (!gfar_ethflow_to_filer_table(priv, cmd->data, cmd->flow_type))
-		return -EINVAL;
+		ret = -EINVAL;
 
-	return 0;
+	mutex_unlock(&priv->rx_queue_access);
+
+	return ret;
 }
 
 static int gfar_check_filer_hardware(struct gfar_private *priv)
@@ -1398,9 +1410,6 @@ static int gfar_set_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	mutex_lock(&priv->rx_queue_access);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = gfar_set_hash_opts(priv, cmd);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		if ((cmd->fs.ring_cookie != RX_CLS_FLOW_DISC &&
 		     cmd->fs.ring_cookie >= priv->num_rx_queues) ||
@@ -1508,6 +1517,7 @@ const struct ethtool_ops gfar_ethtool_ops = {
 #endif
 	.set_rxnfc = gfar_set_nfc,
 	.get_rxnfc = gfar_get_nfc,
+	.set_rxfh_fields = gfar_set_rxfh_fields,
 	.get_ts_info = gfar_get_ts_info,
 	.get_link_ksettings = phy_ethtool_get_link_ksettings,
 	.set_link_ksettings = phy_ethtool_set_link_ksettings,
-- 
2.49.0


