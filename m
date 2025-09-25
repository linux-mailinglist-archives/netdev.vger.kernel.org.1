Return-Path: <netdev+bounces-226401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7EB9FE4B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652042A7A16
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760222D3A75;
	Thu, 25 Sep 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZXV4PyE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6828640C;
	Thu, 25 Sep 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809188; cv=none; b=DU/1tQZRrVc+YhmpKF7+JPT7rHonIDbbHQMUCfbeNceX0V9Dk71chvxB56VELUp+Xr3x8MxmDva/53vEOT+ql/f4buvMqV9h6K6aLbDIgpC3rhStO4nmKxqEdmgQSnBzvN42aMCCDHDmo2BvaGC9CtV2c6VN7hGclPof+ghBLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809188; c=relaxed/simple;
	bh=HV1fJPRFrPlcadQzhmD0w45w8XUYKAzZp4nL/8OX/sU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx7RTUaYDeIktto1/F/5EjYI8h2iDbAJDxkPlUb05DW0XFMadhcw/rqs+Lf6dBTRlSl2Cs0w3tyaZfbOn2q7KQgAV0/LQ1DWpdhWNa0fKEvUhECGXz6LaeJ7qzYe3owErpTiakvLHlNow0k0rVThTr5u1ukOf3H34z0N9PwJo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZXV4PyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAC92C116D0;
	Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758809187;
	bh=HV1fJPRFrPlcadQzhmD0w45w8XUYKAzZp4nL/8OX/sU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AZXV4PyEfHJIAOnyxSkujQNWdCnF1+t0zf438VaaaJxiOkVeZAQ2bhk4zWXwks32S
	 xCtuq4ZUx7iRijmMNrn9R9iuIxGkClsa4QpFc3rq7wjqsNURc4HuTOvi8iuG/bfDrc
	 xz4LqWlW0QNWGnlEoJR2/kVqQH0UMEzYKacUQGEUA50J1vNIETIZb6Pddfxb2E8lam
	 K/H79239LrutrQYv+yFXTmha4wK7+NmaX2iT1RmWsoi6+C8I3YkzOr0k40e6B1+joa
	 US5G3dPMN5hAb19htIfLNuuZAPQjNMEKkNsboWDcjo4KDEbOe942rVcZ0Kk+nacgtu
	 XvRuD6GGq2acw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD778CAC5B7;
	Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Thu, 25 Sep 2025 22:06:14 +0800
Subject: [PATCH net-next v3 2/2] net: stmmac: tc: Add HLBS drop count to
 taprio stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-hlbs_2-v3-2-3b39472776c2@altera.com>
References: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
In-Reply-To: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809186; l=1901;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=yQq3VlBwoMaeIk8RqufK4UtuoZY2MJJUDQlkLWwWmPU=;
 b=hMdALF2Fprn4xVt2wKIRH3p+R12E3UBo6KtGBycM/0VaCD43UCQOfL6aRH7GT37DTEzaquy94
 rybizx/a9NfB7Wi/Vz9npKmXRfGA6OTViRZojhai+kF+f2vKAwnzA0S
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Add the count of the frames dropped by Head-Of-Line Blocking due to
Scheduling(HLBS) error to taprio window drop count stats.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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

-- 
2.35.3



