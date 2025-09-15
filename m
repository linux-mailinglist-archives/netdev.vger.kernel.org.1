Return-Path: <netdev+bounces-222945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D11B572C5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAF67AC95C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647D92ECE8A;
	Mon, 15 Sep 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTi177P/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7072ECD28;
	Mon, 15 Sep 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924538; cv=none; b=V+yo7UQB3TZmGmsjM3lGbajnRvp5c3FNB0eDgJa6c6n0O0OgE8lljBkrmmQ7j4q6pBgS48erV/ENIJdTQzq/ddmjex8cb1bOBhhZPCFszvHMKWv4YFXPZjoaK9ceRxgdCRZgF2U1uUqqUWtpFVGXISeZQIhm0Sg8O9ovhlwcuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924538; c=relaxed/simple;
	bh=mo4HPuFIxILu1fSJb80bB4lgwGqWuG93OPcqvnD64Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iU1m2PPsQGbhIZq/49VD0enQoO88hU33PuGwjd8zTuc/BZEvv1qSLGqomG2rYNVcNTTEVp53gNAJCCgXtN94udyLWQ8WDghDHTY9CC+alhniQhI6mG4pXYyUIWHvRY+NKT3X98D1rKH/ZOmFu/rp2UZZOoJdnUz2aGZmiYKiiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTi177P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8F26C4CEFA;
	Mon, 15 Sep 2025 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924536;
	bh=mo4HPuFIxILu1fSJb80bB4lgwGqWuG93OPcqvnD64Pc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JTi177P/uBOLY62ASimFn1X5aACZldEUqQP2h1qOfZVarSFyT83Qs762HpRoUZRsy
	 IAe3Ks9JKMIHq55nWZ9F8Vma/vJEdPHS2fMZ/vz46aMOKnN4TXRv9Tb5HkuPFVmGSQ
	 fpsjQrVP4D4BPR8US21f6BGYmy+cLsvgfKH78pbENfYvTtGpz9P2CbUU4GAnNVKBhn
	 9Ml1rsXJh/fD8I3JCPxP9mvaqU/qgrJujyV3Z445LmIhWjRPJ6zjqVoE29JyDQOU/g
	 BMxsnXsms6AmbJfIuSc3E9BJWfL/+wCBrhwUhVmIf+v/ZZhRKt3FIAw4yqJ0LR/Arj
	 KdpMnPPzOSAAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5ACAC599;
	Mon, 15 Sep 2025 08:22:16 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Mon, 15 Sep 2025 16:22:14 +0800
Subject: [PATCH net-next v2] net: stmmac: est: Drop frames causing HLBS
 error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-hlbs_2-v2-1-27266b2afdd9@altera.com>
X-B4-Tracking: v=1; b=H4sIALXMx2gC/12NywrCMBBFf6XM2pEkOtq68j+kSB9TM1ATSUKpl
 Py7oUuXh3M5d4PIQTjCrdog8CJRvCtgDhUMtnMvRhkLg1GGVKM12rmPT4M0jSPxuT5NykAZfwJ
 Psu6hBzhO6HhN0BZjJSYfvvvDonf/H1s0ahz6CxHXTUP99d7NiUN3HPwb2pzzD68txvunAAAA
X-Change-ID: 20250911-hlbs_2-5fdd5e483f02
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757924535; l=4857;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=hFASYJ89I2m+eMFKEU8Vw8nda9ry4NXxOx/oENtYScc=;
 b=JZPA6bBDBbmw1kmGvVEjSVf2f5+gWw40697/4dlWcC1R3xyZcnqCR2GZQqK2kNwiiDUisLXIO
 v/YYi0W9bpmAn6u75g6queSx6QKhCUO9XrUq7Jh19vBgWWamXQIgAm/
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Drop those frames causing HLBS error to avoid HLBS interrupt
flooding and netdev watchdog timeouts due to blocked packets.
Also add HLBS frame drops to taprio stats.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v2:
- Removed unnecessary parantheses
- Link to v1: https://lore.kernel.org/r/20250911-hlbs_2-v1-1-cb655e8995b7@altera.com
---
 drivers/net/ethernet/stmicro/stmmac/common.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 9 ++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 7 +++++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index eaa1f2e1c5a53b297b014a8218bf8f3db5beb4de..8f34c9ad457f07553206841223fd38e55208d5ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -228,6 +228,7 @@ struct stmmac_extra_stats {
 	unsigned long mtl_est_btrlm;
 	unsigned long max_sdu_txq_drop[MTL_MAX_TX_QUEUES];
 	unsigned long mtl_est_txq_hlbf[MTL_MAX_TX_QUEUES];
+	unsigned long mtl_est_txq_hlbs[MTL_MAX_TX_QUEUES];
 	/* per queue statistics */
 	struct stmmac_txq_stats txq_stats[MTL_MAX_TX_QUEUES];
 	struct stmmac_rxq_stats rxq_stats[MTL_MAX_RX_QUEUES];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index ac6f2e3a3fcd2f9ae21913845282ff015cd2f7ec..4b513d27a9889046e8b5e404adfd917f469c3f05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -63,7 +63,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 			 EST_GMAC5_PTOV_SHIFT;
 	}
 	if (cfg->enable)
-		ctrl |= EST_EEST | EST_SSWL;
+		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
 
@@ -109,6 +109,10 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 
 		x->mtl_est_hlbs++;
 
+		for (i = 0; i < txqcnt; i++)
+			if (value & BIT(i))
+				x->mtl_est_txq_hlbs[i]++;
+
 		/* Clear Interrupt */
 		writel(value, est_addr + EST_SCH_ERR);
 
@@ -131,10 +135,9 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 
 		x->mtl_est_hlbf++;
 
-		for (i = 0; i < txqcnt; i++) {
+		for (i = 0; i < txqcnt; i++)
 			if (feqn & BIT(i))
 				x->mtl_est_txq_hlbf[i]++;
-		}
 
 		/* Clear Interrupt */
 		writel(feqn, est_addr + EST_FRM_SZ_ERR);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index d247fa383a6e44a5a8371dd491eab5b1c99cd1f2..f70221c9c84afe6bce62782c7847a8005e469dd7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -16,6 +16,7 @@
 #define EST_XGMAC_PTOV_MUL		9
 #define EST_SSWL			BIT(1)
 #define EST_EEST			BIT(0)
+#define EST_DFBS			BIT(5)
 
 #define EST_STATUS			0x00000008
 #define EST_GMAC5_BTRL			GENMASK(11, 8)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 694d6ee1438197bd4434af6e9b78f022e94ff98f..97e89a604abd7a01bb8e904c38f10716e0a911c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1080,6 +1080,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 			priv->xstats.max_sdu_txq_drop[i] = 0;
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
+			priv->xstats.mtl_est_txq_hlbs[i] = 0;
 		}
 		mutex_unlock(&priv->est_lock);
 	}
@@ -1097,7 +1098,8 @@ static void tc_taprio_stats(struct stmmac_priv *priv,
 
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
 		window_drops += priv->xstats.max_sdu_txq_drop[i] +
-				priv->xstats.mtl_est_txq_hlbf[i];
+				priv->xstats.mtl_est_txq_hlbf[i] +
+				priv->xstats.mtl_est_txq_hlbs[i];
 	qopt->stats.window_drops = window_drops;
 
 	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
@@ -1111,7 +1113,8 @@ static void tc_taprio_queue_stats(struct stmmac_priv *priv,
 	int queue = qopt->queue_stats.queue;
 
 	q_stats->stats.window_drops = priv->xstats.max_sdu_txq_drop[queue] +
-				      priv->xstats.mtl_est_txq_hlbf[queue];
+				      priv->xstats.mtl_est_txq_hlbf[queue] +
+				      priv->xstats.mtl_est_txq_hlbs[queue];
 
 	/* Transmission overrun doesn't happen for stmmac, hence always 0 */
 	q_stats->stats.tx_overruns = 0;

---
base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
change-id: 20250911-hlbs_2-5fdd5e483f02

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



