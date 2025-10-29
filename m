Return-Path: <netdev+bounces-233824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A7C18E59
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD1634F160F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB2320CAC;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIlPSwP9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914E320A0F;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725185; cv=none; b=J6FhX9M803HZxqtp7oovanRr7JTYzgy17uROKEaT2/EEGPXHYgXo+83JreH4yF56yJu1N9AjEXX9std5enbc19UPpTq0hP0LYzVDF2ZpDtJXwr7FC9mfC357r7mLYNmnXJduDeJ5zKu+iGr7lcwbp1tXA1T2SBY9CRcBX5ZlxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725185; c=relaxed/simple;
	bh=EILhiXwSG8mnsP3WGsVKBzN2WcZ7wKbqmXj+1wrNFzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mb1IuplpP8LgCiP/jqtZIxjxFhZISSwOOIdZ4ncu1xInUWcPBL52YwjIpkhHyuFMHcMqT6tgATgZQ2Cfk1AR9nbMOY83npz1YcwX/gpy5Qq41e+n9EpPV8zju1/WpG4z8mgcf3i8qTg2pOlRsbx98X4N10G+p92VgPUjs5TPQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIlPSwP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4E36C116C6;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761725185;
	bh=EILhiXwSG8mnsP3WGsVKBzN2WcZ7wKbqmXj+1wrNFzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HIlPSwP91NTIR8DUNPxOnv/QWitRD5UCo3NK/LPNUYywq319bFSleyjDrASLyZOET
	 EyIg0r/E+LHUX9/Hq+kfNL+Bos3HAlc31jpPtpI8ebdy1KmvlWbpeevQy/Ea0m+MsE
	 CZxtVAHJ/EZkb4P+nKtVgKgkFcVUPxK8S7u3BT4icP5l9DzyGjLdGSKdp93YlfQpxM
	 A7gXBhn4zDD0LE6oqsKQVGXdxN1R/kNNxiO48BnxfFr9jKfR/pla2chJzOGgRZwPjX
	 q2cO7hiXVFPHEOKIR6bAtvg3xGjatE25cb+zcJGNTO3LMtqDlcnP6GoljUjd61a2N9
	 knbmbYWBeMLEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E74CCF9F3;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Wed, 29 Oct 2025 16:06:15 +0800
Subject: [PATCH net-next 3/4] net: stmmac: socfpga: Enable TSO for Agilex5
 platform
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-agilex5_ext-v1-3-1931132d77d6@altera.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725182; l=898;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=p2uWSKKuLwxCOpiNDSbfDTRN7HWTGIFC7QoK3weEpGc=;
 b=zvAEVmt+YCzpgZzoyQtINmkYcMh3/hMOKUNLU/c2tHXcq3h/po36vCnYfNbJL7FRIrYsYIqLa
 yFsbzkbCYp7Bbvx1f8salXZIKI48J2OoZKGS74Dg5MPOSyLxdweez8P
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Agilex5 supports TCP Segmentation Offload(TSO). This commit enables
TSO for Agilex5 socfpga platforms.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c02e6fa715bbea2f703bcdeee9d7a41be51ce91c..37fcf272a46920d1d97a4b651a469767609373b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -474,6 +474,9 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 
 	plat_dat->core_type = DWMAC_CORE_XGMAC;
 
+	/* Enable TSO */
+	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
+
 	/* Enable TBS */
 	switch (plat_dat->tx_queues_to_use) {
 	case 8:

-- 
2.43.7



