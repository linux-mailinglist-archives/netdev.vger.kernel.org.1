Return-Path: <netdev+bounces-222016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45920B52B82
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38B9562682
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8E2DF153;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQxyzVZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47322DECCC;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579009; cv=none; b=ObivgLmsEJafgSit2CvWmhTBA7mX1iT/BXwn+9pGN4UsMfegOQjhvs2C1gPK2zRCUHj0QBKbIAKAFp4vrDMgW3t4viJWm4MwtEQ1AOU45HRkwSrKmuuYa3ssnyVNCcQTLA1AawBXBO+qT9n3tBYq6gH0AODgWpSoSgyDatzYeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579009; c=relaxed/simple;
	bh=/v0yrpBEJQ0D28G9+YyT6cosJyEdCGkLKC3aD1BtsjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwCG/hUxmKbX/p58/E7Om3nsufC5DRtKUJ+yJFZXRmfukGaRs3LfkJz9QFzOBUH4LqDjL5S7fuRgBa5swVxOLDYnc6x0omJhvA5BGpGHrKubAyVWZKy/wHwZcWjecnsyZTtVy9SvunT3vqaz2T/g+W6mWFsBp/mrPoJ/WYCwPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQxyzVZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67236C4CEF7;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579009;
	bh=/v0yrpBEJQ0D28G9+YyT6cosJyEdCGkLKC3aD1BtsjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CQxyzVZfqH+P8zdM82GRHXbD8rE+lYTjiUXu+VMzpsklXBR9fuIyHyWn95aOHeij+
	 KRbHJHTH1k7NCMiEZ0DPX6Oy84HwmVwMu+cvW5iGVfZz3l7vuW/EK/sift3aM/85FS
	 nQ8m3gzMIZ1e29VOW8+pIln+g9i03WkXc+d+z0wRvrMgRz/VC7RloIXEYvmQI9gmGs
	 /1EZuYKLIdxqaNNj3hGFk3tJqo6+/nsxiI7JZJ87zRdNlE4AZnCWTKRK97n1nFszT3
	 VQhv+/NRP4yPq1vH9CtgsHsaONBPTjPjEDU5Zjk9XVs+qwBAWqe9cW5yD2qIBmM0nc
	 lKsJ5rUKSOZow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54666CAC587;
	Thu, 11 Sep 2025 08:23:29 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Thu, 11 Sep 2025 16:22:59 +0800
Subject: [PATCH net 1/2] net: stmmac: est: Fix GCL bounds checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
References: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
In-Reply-To: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757579008; l=1329;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=08KV5iTtWBP58r0AMyc5QP0+5U8/3Bb20vU2hpRSVqk=;
 b=RKVL8L4shTtsE0yMWktLB7UBTuTa5UWJgk5bAXN9GwEGjDkZuaPg7txbFStG1fwxJBY0LIErS
 eYMjClFcT76BBd+UOuHoOQAlvwTtkpfhVFDcJ60tcbGH5COJq7AZ5kT
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@intel.com>

Fix the bounds checks for the hw supported maximum GCL entry
count and gate interval time.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 694d6ee1438197bd4434af6e9b78f022e94ff98f..89d094abb6be5c993c81901e3f79a6b03f310511 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -981,7 +981,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
 
-	if (qopt->num_entries >= dep)
+	if (qopt->num_entries > dep)
 		return -EINVAL;
 	if (!qopt->cycle_time)
 		return -ERANGE;
@@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid, 0))
+		if (delta_ns >= BIT(wid))
 			return -ERANGE;
 		if (gates > GENMASK(31 - wid, 0))
 			return -ERANGE;

-- 
2.25.1



