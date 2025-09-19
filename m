Return-Path: <netdev+bounces-224757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71FB89587
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63897BAA1A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16630BB9A;
	Fri, 19 Sep 2025 12:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836C303A31;
	Fri, 19 Sep 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283527; cv=none; b=OH2tlEAUZgzE/QlAWvCFXB+YxYawU1Vkv1tjvf3g44W687MbeOxgAJrTehJrEIEHEvOSbKaO4TDXLwjZ0bJrNx0Z0K1jK4XxXM1WmV+pNdMQ4XRzSUKACc4vDEJdETPFZxKDEng0Kz3m5JtrkJEKOUF09oIcv4nJnTfCwSeBnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283527; c=relaxed/simple;
	bh=ovOgPAA5C+GaIni2KNtKo1RtUiRe1rqB2DEy1M7lRuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IdjKtbY7F/s1xt5TD6bC3mfFXpINyH4kMJSLMVlEqEatx2hOlz3P2MJ0AtRLzqiGN8WNmcRlb+ODz45DyB41zhR7PRGp3RBfmcsqk2lYPPAnJhIEvq5SlOslG7pPwE9iNZB9fR4aeg9SmmHO3gvBHYHgmom1LAc3KebiCSIpJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowADXeBLSRs1oR9y_Aw--.22941S2;
	Fri, 19 Sep 2025 20:04:37 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 19 Sep 2025 20:04:33 +0800
Subject: [PATCH net-next] net: spacemit: Make stats_lock softirq-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-k1-ethernet-fix-lock-v1-1-c8b700aa4954@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIANBGzWgC/y2NyQ6DIBRFf8W8dUkEhIK/0rhgeFZixRZoY2L89
 9JheXLusEPGFDBD3+yQ8BVyWGMFemrATSZekQRfGVjLRKupJjMlWCZMEQsZw0Zuq5uJ01oqarQ
 xwkOt3hNW9529wCcZcSsw/EzCx7P+lL+2JiNx67KE0jecirFj3GLrKVo8s9ar0XejkRa9VEJJS
 7nnHQzH8QaKUMOZvAAAAA==
X-Change-ID: 20250919-k1-ethernet-fix-lock-c99681a9aa5d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <uwu@dram.page>, Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowADXeBLSRs1oR9y_Aw--.22941S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1DKF18Cr4rGw18JryUGFg_yoW7Zw1Dp3
	yj9a93AFW8Xa10qF4DGrWqv34UAw4Sgry7ZFn7A3yxC3ZIyryfua48KrW2vr1jvFW5urZI
	g3yUAryDCayDt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

While most of the statistics functions (emac_get_stats64() and such) are
called with softirqs enabled, emac_stats_timer() is, as its name
suggests, also called from a timer, i.e. called in softirq context.

All of these take stats_lock. Therefore, make stats_lock softirq-safe by
changing spin_lock() into spin_lock_bh() for the functions that get
statistics.

Also, instead of directly calling emac_stats_timer() in emac_up() and
emac_resume(), set the timer to trigger instead, so that
emac_stats_timer() is only called from the timer. It will keep using
spin_lock().

This fixes a lockdep warning, and potential deadlock when stats_timer is
triggered in the middle of getting statistics.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/a52c0cf5-0444-41aa-b061-a0a1d72b02fe@samsung.com/
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Thanks a lot for catching this, Marek!
---
 drivers/net/ethernet/spacemit/k1_emac.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 928fea02198c3754f63a7b33fc25c5dd8c2b59f9..e1c5faff3b71c7d4ceba2ea194d9c888f0e71b70 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -135,7 +135,7 @@ struct emac_priv {
 	bool flow_control_autoneg;
 	u8 flow_control;
 
-	/* Hold while touching hardware statistics */
+	/* Softirq-safe, hold while touching hardware statistics */
 	spinlock_t stats_lock;
 };
 
@@ -1239,7 +1239,7 @@ static void emac_get_stats64(struct net_device *dev,
 	/* This is the only software counter */
 	storage->tx_dropped = emac_get_stat_tx_drops(priv);
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
@@ -1261,7 +1261,7 @@ static void emac_get_stats64(struct net_device *dev,
 	storage->rx_missed_errors = rx_stats->stats.rx_drp_fifo_full_pkts;
 	storage->rx_missed_errors += rx_stats->stats.rx_truncate_fifo_full_pkts;
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void emac_get_rmon_stats(struct net_device *dev,
@@ -1275,7 +1275,7 @@ static void emac_get_rmon_stats(struct net_device *dev,
 
 	*ranges = emac_rmon_hist_ranges;
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
@@ -1294,7 +1294,7 @@ static void emac_get_rmon_stats(struct net_device *dev,
 	rmon_stats->hist[5] = rx_stats->stats.rx_1024_1518_pkts;
 	rmon_stats->hist[6] = rx_stats->stats.rx_1519_plus_pkts;
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void emac_get_eth_mac_stats(struct net_device *dev,
@@ -1307,7 +1307,7 @@ static void emac_get_eth_mac_stats(struct net_device *dev,
 	tx_stats = &priv->tx_stats;
 	rx_stats = &priv->rx_stats;
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
@@ -1325,7 +1325,7 @@ static void emac_get_eth_mac_stats(struct net_device *dev,
 	mac_stats->FramesAbortedDueToXSColls =
 		tx_stats->stats.tx_excessclsn_pkts;
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static void emac_get_pause_stats(struct net_device *dev,
@@ -1338,14 +1338,14 @@ static void emac_get_pause_stats(struct net_device *dev,
 	tx_stats = &priv->tx_stats;
 	rx_stats = &priv->rx_stats;
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
 	pause_stats->tx_pause_frames = tx_stats->stats.tx_pause_pkts;
 	pause_stats->rx_pause_frames = rx_stats->stats.rx_pause_pkts;
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 /* Other statistics that are not derivable from standard statistics */
@@ -1393,14 +1393,14 @@ static void emac_get_ethtool_stats(struct net_device *dev,
 	u64 *rx_stats = (u64 *)&priv->rx_stats;
 	int i;
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
 	for (i = 0; i < ARRAY_SIZE(emac_ethtool_rx_stats); i++)
 		data[i] = rx_stats[emac_ethtool_rx_stats[i].offset];
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 }
 
 static int emac_ethtool_get_regs_len(struct net_device *dev)
@@ -1769,7 +1769,7 @@ static int emac_up(struct emac_priv *priv)
 
 	netif_start_queue(ndev);
 
-	emac_stats_timer(&priv->stats_timer);
+	mod_timer(&priv->stats_timer, jiffies);
 
 	return 0;
 
@@ -1807,14 +1807,14 @@ static int emac_down(struct emac_priv *priv)
 
 	/* Update and save current stats, see emac_stats_update() for usage */
 
-	spin_lock(&priv->stats_lock);
+	spin_lock_bh(&priv->stats_lock);
 
 	emac_stats_update(priv);
 
 	priv->tx_stats_off = priv->tx_stats;
 	priv->rx_stats_off = priv->rx_stats;
 
-	spin_unlock(&priv->stats_lock);
+	spin_unlock_bh(&priv->stats_lock);
 
 	pm_runtime_put_sync(&pdev->dev);
 	return 0;
@@ -2111,7 +2111,7 @@ static int emac_resume(struct device *dev)
 
 	netif_device_attach(ndev);
 
-	emac_stats_timer(&priv->stats_timer);
+	mod_timer(&priv->stats_timer, jiffies);
 
 	return 0;
 }

---
base-commit: 315f423be0d1ebe720d8fd4fa6bed68586b13d34
change-id: 20250919-k1-ethernet-fix-lock-c99681a9aa5d

Best regards,
-- 
Vivian "dramforever" Wang


