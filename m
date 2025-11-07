Return-Path: <netdev+bounces-236557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9529C3DF8D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6FED4E99D1
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7128030E;
	Fri,  7 Nov 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="vlt2w2GP"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CA2765C4;
	Fri,  7 Nov 2025 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475122; cv=none; b=gcKO6X1veSVyy44bSnc9WsGr80sjh5Rlx1TxaJskLAM3B6/Z9S0VOlWoDMjXqteMmp/SrzfIYKDYRal5O4l06KX5wg9by7z49mu+gO/2enUwicU6kwbRqM10O+z3FLLoXexIYhSlPb3EgcW/K0xp6r9OfqKnMO9ccxafBGX3ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475122; c=relaxed/simple;
	bh=G8cT8eWsWQj2hmdiyqajEe4gKyi21FTl167Gx6/CWD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtP8d0K7WoOmWFPkjSrcFnlZmw5Q/b3CJN6NVvOsf5wvgFVghxxxgOXAMwAVZExVKi6vUBSSZN3kGeJe+vmvvIM5rbpv5mYE1VPKybp94BFrjjL7swpTcYhu34BngOZsN6hztBcau1aKSS8Rftl+UL5hP+GeIfwbMyyRy/c4ru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=vlt2w2GP; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 48B41C0003EE;
	Thu,  6 Nov 2025 16:25:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 48B41C0003EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1762475113;
	bh=G8cT8eWsWQj2hmdiyqajEe4gKyi21FTl167Gx6/CWD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vlt2w2GPoHg+c1IZvcjNzRnc8SwsBWLKxG3ndUi9nj9pa0VA8bPAtXLppJquvQKDy
	 xPElJeI4kMxAmhai3RqxWhsHxupH7rNrY85eSxGQk6eQJ5WWLz4QKyYPg+RwoSA/oo
	 asvAGKSphHkEviods66ns+404ee3SwewHSfXN+dA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E5D9D180008F4;
	Thu,  6 Nov 2025 16:25:12 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH net-next v3 2/2] net: bcmgenet: Add support for set_pauseparam_panic
Date: Thu,  6 Nov 2025 16:25:10 -0800
Message-Id: <20251107002510.1678369-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
References: <20251107002510.1678369-1-florian.fainelli@broadcom.com>
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
Change-Id: I268ffdaf28e6df30f37e2eaae421c06c727f524a
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
index 38f854b94a79..8eca6a1a8626 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -147,6 +147,16 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
 	mutex_unlock(&phydev->lock);
 }
 
+void bcmgenet_set_pause_panic(struct bcmgenet_priv *priv)
+{
+	u32 reg;
+
+	/* Disable pause frame generation */
+	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+	reg |= CMD_TX_PAUSE_IGNORE;
+	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+}
+
 void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-- 
2.34.1


