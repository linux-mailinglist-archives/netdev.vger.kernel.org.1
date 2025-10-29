Return-Path: <netdev+bounces-233823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCCC18EFF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C2F1C88D7F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0A320A3F;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF8kseVC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B68320380;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725185; cv=none; b=PexS3Cl1hH4ToSo3wvt2sxYOMpzoY9pLAUDe/twUKI72cqflgDYOwbHhxHKPjjdN4cI8N5ab6FXiMjPSp8QQh7Dsdlt4Z/ptyMPBaBzoDB9X5rMqQ5whbZ7UiZh8EbtsMfAjfmsSF/+DtYnanZEFZ5hpK3tBwLx6/DPUxeuXkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725185; c=relaxed/simple;
	bh=nWVHnfvQBRA6ZVCql74XqpzDCs6ZKXaKNS1r6cUtQN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gef17QQe91a4lim36cDlpFDMqG9Vmx5JKdmnaAFQXspQF32HLRxcD49hLM6hFAlmGO0a9JgjdlTDHNpwuvUn+Ph2dFAGWvLeChSpVO0IzGFK9MuFXB3eWh63hxjmr35hnQZmkw5SpXhggglVW+AxB1e+Go+8jLqBrkwu5Nu/hwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF8kseVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D52D7C4CEFB;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761725184;
	bh=nWVHnfvQBRA6ZVCql74XqpzDCs6ZKXaKNS1r6cUtQN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BF8kseVCLTniC7aKmiJggehl13MTS9buvUEBi1IODDz8i9x7mkb/2pAUrQ6JWJ5Fp
	 ccyrw+Xi1eYUAzCdNP71AW6juFGzIHkGmTN67J4yqiatF9D3IEUrjsZa0uGZrvBhGu
	 FBfD83EApJvp1ovk2ovM3/0oLc9LfY/ak16lVliSEIfQA8Gllj6/hP0m3q803oQbBr
	 f+zpd1ciAP54xOFMfYOsjpd1LrmPLEOLOSANJZDhhRPI6Dc6/EGWm4Ir42hI34MX3o
	 z0nmOgBE4e83z2CdPtanvXAXWERQLc6D+itE4bJAXyKDdDNcXtlkpE1v7SX4q8/4lg
	 Aw8rCdo7WgNiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDBCCF9F2;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Wed, 29 Oct 2025 16:06:14 +0800
Subject: [PATCH net-next 2/4] net: stmmac: socfpga: Enable TBS support for
 Agilex5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-agilex5_ext-v1-2-1931132d77d6@altera.com>
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
In-Reply-To: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725182; l=1189;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=xSJKSpzgBUj6X7SaRiqPgyeJfwi6PIzrINgCzQeog7s=;
 b=8SDkbxGig66XtJrELUxq38wXz640VIOzsR/gO+kkHJvQzQZVfXdl5J7m1gsIdbdgDYQZiKbl0
 cKATRITmZzNDbB6AewGNQndYuQwl85NB0G5Y9LEWVUbJ0LywdZ8FRxM
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
index 3dae4f3c103802ed1c2cd390634bd5473192d4ee..c02e6fa715bbea2f703bcdeee9d7a41be51ce91c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -473,6 +473,19 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 	socfpga_common_plat_dat(dwmac);
 
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



