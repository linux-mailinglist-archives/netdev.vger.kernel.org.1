Return-Path: <netdev+bounces-234716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCEC26558
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F3A188A073
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307330596F;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXcS3Dd6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC642F6182;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931636; cv=none; b=C7qr4gcwvHcTzx/mHDBlLYLx/9kkgu9FBBpBASlkic968LZJZxAvgHBy/VJhm4fAyb93J5dj9ht+SwZcRpmqedfIZG80dof193Aj0WG0j2964vMxfmNC+6U9besDfFJrr5CyfX74m3XvNh9kcaWCxU8qTYt6vKRQOO1ym7mayp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931636; c=relaxed/simple;
	bh=GYem28TIcz0PWGQwlrg2H0OZ4/ZTAm/l/zRLYIjV6ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qg2TjuMhyH1gVFktZr47o5TQOMAa17t739r1pxX8IEagmsdgKzKKDZFFpIwIXuV9/dZieVTSZS6r5drQEO23+ry1iqSGpg1EDenZIMVoUaH6jGzI+2vggS4vNqP935o7wmm8oNN1kPbLV7NUoAeNqqdFKE1Y+w4jaIHamDPnRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXcS3Dd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 118FFC4CEF1;
	Fri, 31 Oct 2025 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761931636;
	bh=GYem28TIcz0PWGQwlrg2H0OZ4/ZTAm/l/zRLYIjV6ZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CXcS3Dd6m4Hq4K2iZHXFSqje7Mp80IrdEFkrTAQmJtn2Kh4QaPCvzJPzaXlH7wR2J
	 aSlkEj2GQTgRmQ7UjWqIJ39bdlGQZNbEWEmopNN3ewWkRYdkqIRup71wS07eoOIUb4
	 xBBVN9v7Ltku8GiNXGUKeRhCtaZJvWPcLCYAIm4VssjopEiLyvPgYtEPabfhZL52+n
	 YrJ8d5Houvi9qT1CNyerui8Rb/kHgp9rkdLGe3IVcE/OXJ47L7+tskAIoyiysouyRd
	 DfhJVGNhcpUm+Ka5xS6OirqVc912fNSHp1hlYrXuqHJWNjwpoHsecYfyZsVoUk9r8s
	 oomv4DGDsCHtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377ECCF9F8;
	Fri, 31 Oct 2025 17:27:15 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Sat, 01 Nov 2025 01:27:08 +0800
Subject: [PATCH net-next v2 2/4] net: stmmac: socfpga: Enable TBS support
 for Agilex5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-agilex5_ext-v2-2-a6b51b4dca4d@altera.com>
References: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
In-Reply-To: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761931634; l=1214;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=Rehj3W/2337ILzEH6ON7+yaibhBp9L+MAU32vI9ki2k=;
 b=7dqHPuanqJE3mi6rIM7SP88BAecpYWdfi2p7QVL22kjPa9vppTpBken6O7JMOAiCZ33oy/ClL
 snYeN9ZAW/bCTmWX6ZQb9332UdAyyEZAuBZHgHjPjf8hM5qniPffkub
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Agilex5 supports Time-Based Scheduling(TBS) for Tx queue 6 and Tx
queue 7. This commit enables TBS support for these queues.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5666b01723643984f21b996e7653a36f4dc22e30..4f256f0ae05c15d28e4836d676e2f2c052540184 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -457,6 +457,19 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
 
 	plat_dat->core_type = DWMAC_CORE_XGMAC;
+
+	/* Enable TBS */
+	switch (plat_dat->tx_queues_to_use) {
+	case 8:
+		plat_dat->tx_queues_cfg[7].tbs_en = true;
+		fallthrough;
+	case 7:
+		plat_dat->tx_queues_cfg[6].tbs_en = true;
+		break;
+	default:
+		/* Tx Queues 0 - 5 doesn't support TBS on Agilex5 */
+		break;
+	}
 }
 
 static int socfpga_dwmac_probe(struct platform_device *pdev)

-- 
2.43.7



