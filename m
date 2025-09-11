Return-Path: <netdev+bounces-222021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E32B52BEB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7A9179868
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DE2E543E;
	Thu, 11 Sep 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxB+5Eau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515D2E2852;
	Thu, 11 Sep 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579898; cv=none; b=RIQQI3MvZkL7xOh4WfaPPVcwNlFNozsud19ZPawwo7WtYm0aFlSAjdWzHWg5gqQZf8hZc5kRZ548OX9fbarUkhBbXU2Jt+tiQtwjSZn7RR+I+snVKh4hDpwD/b8RO8eYR/TYNb2YycAJoVcFtDwA0ULpgWDhBLSaFD1NlGqjmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579898; c=relaxed/simple;
	bh=3Ta+U8bDmn+TLd+5gSYW6szMLbfTk9DlYnED0UXkvx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m3PLrCSCeFd1QVxiceobsAabDI5LGG/KAVZ9GshKomaLtH3IjvFn/55aP0gHIN12tsnFqK/xeHRyZBRmvaYNd4EQyz6ZtHdBkzOJTOquCVT8hGEnH5lKuJXXQSah6CCDJDAG2Qi4fJE/6XXaoDDw4YcljI1Re/7s5XDd0/MJaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxB+5Eau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78EDEC4CEF7;
	Thu, 11 Sep 2025 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579898;
	bh=3Ta+U8bDmn+TLd+5gSYW6szMLbfTk9DlYnED0UXkvx8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HxB+5EauNEn0j+nE4dMAuReoUaw83Uxlh6GEV/G3pDSy8ueRVuWt32zgJ+3Hzykwm
	 sQDCUjkQ6mxmbINjejWClrBrDVh/uskw1GwFSd7Lwd0AKJqPGSmkbxZoEU3oKMtqgI
	 NI2aLkgJzZ5zT1mxS7d6omOjF4km0EiKJovYBoOvfcnwWXBIqaq/lAL11wu1/fm9Iy
	 jxgVoHsUHvh4eAhKsMcXlpKhAUFyCZz34r7PP9m3/pZUcZdRDT0WEhwWmCm+StS6+k
	 a8VisZ5k/kzbNPN1mDKgCCPYQx3EtrpY2jHDed4bzvvpVGOxEptCM3jXq0F5x2Y/yb
	 lvhiq6cp94B0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A1CA1016;
	Thu, 11 Sep 2025 08:38:18 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Thu, 11 Sep 2025 16:38:16 +0800
Subject: [PATCH net-next] net: stmmac: est: Drop frames causing HLBS error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-hlbs_2-v1-1-cb655e8995b7@altera.com>
X-B4-Tracking: v=1; b=H4sIAHeKwmgC/x3MQQqAIBBA0avErBPUEqqrRETlmANhoRKCePek5
 YPPzxDQEwaYmgweXwp0uwrRNnDYzZ3ISFeD5FLxUQhmrz2skimjtcJ+6AyXUOPHo6H0j2ZwGJn
 DFGEp5QMVeEEKYgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757579897; l=4389;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=rzzc5ust1FUYLSTdUDlYDXeMTa9SqQgjaI1YarHG5WM=;
 b=ZMgyKAlpBN4cQqypdUTAVHzpXbtiOTB7N1s66ZtuclJIHZ6WivlbvTwuXWfz4CPtQUFdlXgez
 rlqVE8DCNOPDuKsQXxAs6WkTpax/SeJICQ6fbDQB53RbMNDHpToKHeL
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
 drivers/net/ethernet/stmicro/stmmac/common.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 7 ++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 7 +++++--
 4 files changed, 13 insertions(+), 3 deletions(-)

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
index ac6f2e3a3fcd2f9ae21913845282ff015cd2f7ec..385431a3336b731547df49621098586b741cae85 100644
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
 
@@ -109,6 +109,11 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 
 		x->mtl_est_hlbs++;
 
+		for (i = 0; i < txqcnt; i++) {
+			if (value & BIT(i))
+				x->mtl_est_txq_hlbs[i]++;
+		}
+
 		/* Clear Interrupt */
 		writel(value, est_addr + EST_SCH_ERR);
 
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
base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
change-id: 20250911-hlbs_2-5fdd5e483f02

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



