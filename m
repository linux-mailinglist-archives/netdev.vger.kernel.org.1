Return-Path: <netdev+bounces-234431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9742C209D7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C31A262E6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843892417E6;
	Thu, 30 Oct 2025 14:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B137A3C2;
	Thu, 30 Oct 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834764; cv=none; b=Z9EVxFInYuCiB+nE6552bUBKFAyF1ltpmULVwQCJxPjan9nrVsIXCZPqBHkwsGcnC1t73ctvYKW53lScV/wc8gUMbqZ+zA9BiGrCK3EcwZSoQ8kDJtA19eqBZXwtn0sf+SxUFnohA7E0NQUAmARkM/pWPkPrAn2fFp/JcE7zHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834764; c=relaxed/simple;
	bh=Vv8+Zc55MjFKW5EjvmWza6mHqxGSrdju6Wu7nRKTDb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hPT61pHCSFUvYC3Ngy1YQR/P0NuzKjuRleDPySmmCFY0i09HGBuq0mEqgEJuitac8bvcY9O26MReHKECIi5WCXYtJ5MF76NwSEJAUi2KUyv0/cRvRiEcfIR2KSFTZcKN/XiX+CUanJGgzG8jb5wPE+kzz2c8nnX/rMxXNdRPPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowAAnlfPfdgNpTQZlAA--.3125S2;
	Thu, 30 Oct 2025 22:32:01 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 30 Oct 2025 22:31:44 +0800
Subject: [PATCH net] net: spacemit: Implement emac_set_pauseparam properly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIANB2A2kC/y2NSw6CMBCGr0Jm7Zi2RKNcxbBoywgTQ6vTQkwId
 3eiLr//uUEhYSrQNRsIrVw4JwV7aCBOPo2EPCiDM+5kTWvwYZHqRJKo4p3f6JeaE43oyfmrC21
 0QwBtP4XU/i7fQMPQ/0Sh16Iv9e8EXwhjnmeuXbOej/aCEi30+/4B8sktx5sAAAA=
X-Change-ID: 20251030-k1-ethernet-fix-autoneg-ae2a92b3c2db
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowAAnlfPfdgNpTQZlAA--.3125S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF47Gw4rArWktF1xWr17Wrg_yoWrXF4DpF
	WUXa4Skr4UXFs3tFsxAF4UAFy3Ga4xtr17uFyfCwsYq3ZxAryxCFyvkay7GFykurW8Xry3
	G3y5AF1xGFWDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

emac_set_pauseparam (the set_pauseparam callback) didn't properly update
phydev->advertising. Fix it by changing it to call phy_set_asym_pause.

Also simplify/reorganize related code around this.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 48 ++++++++++++++-------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index e1c5faff3b71..61d62c0f028e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -133,7 +133,6 @@ struct emac_priv {
 	u32 rx_delay;
 
 	bool flow_control_autoneg;
-	u8 flow_control;
 
 	/* Softirq-safe, hold while touching hardware statistics */
 	spinlock_t stats_lock;
@@ -1039,14 +1038,7 @@ static void emac_set_rx_fc(struct emac_priv *priv, bool enable)
 	emac_wr(priv, MAC_FC_CONTROL, val);
 }
 
-static void emac_set_fc(struct emac_priv *priv, u8 fc)
-{
-	emac_set_tx_fc(priv, fc & FLOW_CTRL_TX);
-	emac_set_rx_fc(priv, fc & FLOW_CTRL_RX);
-	priv->flow_control = fc;
-}
-
-static void emac_set_fc_autoneg(struct emac_priv *priv)
+static void emac_set_fc(struct emac_priv *priv)
 {
 	struct phy_device *phydev = priv->ndev->phydev;
 	u32 local_adv, remote_adv;
@@ -1056,17 +1048,18 @@ static void emac_set_fc_autoneg(struct emac_priv *priv)
 
 	remote_adv = 0;
 
-	if (phydev->pause)
+	/* Force settings in advertising if autoneg disabled */
+
+	if (!priv->flow_control_autoneg || phydev->pause)
 		remote_adv |= LPA_PAUSE_CAP;
 
-	if (phydev->asym_pause)
+	if (!priv->flow_control_autoneg || phydev->asym_pause)
 		remote_adv |= LPA_PAUSE_ASYM;
 
 	fc = mii_resolve_flowctrl_fdx(local_adv, remote_adv);
 
-	priv->flow_control_autoneg = true;
-
-	emac_set_fc(priv, fc);
+	emac_set_tx_fc(priv, fc & FLOW_CTRL_TX);
+	emac_set_rx_fc(priv, fc & FLOW_CTRL_RX);
 }
 
 /*
@@ -1429,31 +1422,28 @@ static void emac_get_pauseparam(struct net_device *dev,
 				struct ethtool_pauseparam *pause)
 {
 	struct emac_priv *priv = netdev_priv(dev);
+	u32 val = emac_rd(priv, MAC_FC_CONTROL);
 
 	pause->autoneg = priv->flow_control_autoneg;
-	pause->tx_pause = !!(priv->flow_control & FLOW_CTRL_TX);
-	pause->rx_pause = !!(priv->flow_control & FLOW_CTRL_RX);
+	pause->tx_pause = !!(val & MREGBIT_FC_GENERATION_ENABLE);
+	pause->rx_pause = !!(val & MREGBIT_FC_DECODE_ENABLE);
 }
 
 static int emac_set_pauseparam(struct net_device *dev,
 			       struct ethtool_pauseparam *pause)
 {
 	struct emac_priv *priv = netdev_priv(dev);
-	u8 fc = 0;
+	struct phy_device *phydev = dev->phydev;
 
-	priv->flow_control_autoneg = pause->autoneg;
+	if (!phydev)
+		return -ENODEV;
 
-	if (pause->autoneg) {
-		emac_set_fc_autoneg(priv);
-	} else {
-		if (pause->tx_pause)
-			fc |= FLOW_CTRL_TX;
+	if (!phy_validate_pause(phydev, pause))
+		return -EINVAL;
 
-		if (pause->rx_pause)
-			fc |= FLOW_CTRL_RX;
+	priv->flow_control_autoneg = pause->autoneg;
 
-		emac_set_fc(priv, fc);
-	}
+	phy_set_asym_pause(dev->phydev, pause->rx_pause, pause->tx_pause);
 
 	return 0;
 }
@@ -1632,7 +1622,7 @@ static void emac_adjust_link(struct net_device *dev)
 
 		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
 
-		emac_set_fc_autoneg(priv);
+		emac_set_fc(priv);
 	}
 
 	phy_print_status(phydev);
@@ -2010,6 +2000,8 @@ static int emac_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	platform_set_drvdata(pdev, priv);
 
+	priv->flow_control_autoneg = true;
+
 	ret = emac_config_dt(pdev, priv);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Configuration failed\n");

---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251030-k1-ethernet-fix-autoneg-ae2a92b3c2db

Best regards,
-- 
Vivian "dramforever" Wang


