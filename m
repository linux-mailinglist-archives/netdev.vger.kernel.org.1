Return-Path: <netdev+bounces-235590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AEBC33238
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A093B5D35
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591492E7161;
	Tue,  4 Nov 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O3RA4WZN"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3202C376B;
	Tue,  4 Nov 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294442; cv=none; b=A3peoPehMrGLUTPh6pS/2YjtGDpKOb6aQqzESrou70NH5S1QZRaNrLtp1z/JkR8Mhckrgd8l2lNP9puvBTtPCTSJBckbxmf291N7xrr0eFtQ1E1gyxSoAASTUKADM/ofFLrXP2SHzopaDdq9baqPhDV67esub6VzyGOQ0KkjrPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294442; c=relaxed/simple;
	bh=nkdxGoHbtBgkqF4hvXzcmYUK6jPG9kz/+bIf/5XKspA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCf/XbUJWVK7Pyz+oOV2gPrMRjL3FzKn/79okb11A/+ZCPxUFFkC0zTZRYXfrM2kfxGcfUiN6sLDmVqPx2WF5iBEPmgfYlegxrWrVCtlE2TX8ep3i3K+eC0R6qCh8pFxxofz6sYtA4lubWSw7/CyblL5AJbAYDWYaA9Y6Z+oKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O3RA4WZN; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 52344C000C7F;
	Tue,  4 Nov 2025 14:13:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 52344C000C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762294434;
	bh=nkdxGoHbtBgkqF4hvXzcmYUK6jPG9kz/+bIf/5XKspA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3RA4WZNn0l/GpokJl4x55zNousas4IhQ6meRiHHjM1QpdXJ1XWBzfJqPb17geWR7
	 ETHLM7tl54RdcFM8yoVUw2YTJHn3AOrgVaF1VVqGlNxn8Eu1zQKyVof90AsNJhGx3V
	 Nh/tOTQ7xiaO5I17tGvucCQAHpHaJ57uFdlMrlb0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 3CB094002F44;
	Tue,  4 Nov 2025 17:13:53 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 2/2] net: bcmgenet: Add support for set_pauseparam_panic
Date: Tue,  4 Nov 2025 14:13:48 -0800
Message-Id: <20251104221348.4163417-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid making sleeping calls that would in not being able to complete the
MMIO writes ignoring pause frame reception and generation at the
Ethernet MAC controller level.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  8 ++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d99ef92feb82..323bf119c2af 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -966,6 +966,13 @@ static int bcmgenet_set_pauseparam(struct net_device *dev,
 	return 0;
 }
 
+static void bcmgenet_set_pauseparam_panic(struct net_device *dev)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+
+	bcmgenet_set_pause_panic(priv);
+}
+
 /* standard ethtool support functions. */
 enum bcmgenet_stat_type {
 	BCMGENET_STAT_RTNL = -1,
@@ -1702,6 +1709,7 @@ static const struct ethtool_ops bcmgenet_ethtool_ops = {
 	.set_rxnfc		= bcmgenet_set_rxnfc,
 	.get_pauseparam		= bcmgenet_get_pauseparam,
 	.set_pauseparam		= bcmgenet_set_pauseparam,
+	.set_pauseparam_panic	= bcmgenet_set_pauseparam_panic,
 };
 
 /* Power down the unimac, based on mode. */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 5ec3979779ec..faf0d2406e9a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -738,6 +738,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init);
 int bcmgenet_mii_probe(struct net_device *dev);
 void bcmgenet_mii_exit(struct net_device *dev);
 void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx);
+void bcmgenet_set_pause_panic(struct bcmgenet_priv *priv);
 void bcmgenet_phy_power_set(struct net_device *dev, bool enable);
 void bcmgenet_mii_setup(struct net_device *dev);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 38f854b94a79..a9a1d06032fa 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -147,6 +147,16 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
 	mutex_unlock(&phydev->lock);
 }
 
+void bcmgenet_set_pause_panic(struct bcmgenet_priv *priv)
+{
+	u32 reg;
+
+	/* Disable pause frame generation and reception */
+	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+	reg |= CMD_RX_PAUSE_IGNORE | CMD_TX_PAUSE_IGNORE;
+	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+}
+
 void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-- 
2.34.1


