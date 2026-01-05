Return-Path: <netdev+bounces-246890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFC7CF2218
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF423011013
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF442DA75C;
	Mon,  5 Jan 2026 07:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C2274FE9;
	Mon,  5 Jan 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596963; cv=none; b=dcnvsVFAohV8zV+gX2ANstNTXMx+qy/XgzASQ+d8pMHwxcKZPHu9N2H9PTGOMR1WlvmJlC/H86uHDE+qULDoQgJM4fZm228RP/loth+StyQ9Y8Yuk8qAHK/wmWW1eHfXfpgBdqkeAVwIU+ZKw1uYIOuVOWoDNfnTj9FSP4YnJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596963; c=relaxed/simple;
	bh=QtDQeZvDeVc4olfYKBioia/GNDEozJ5YslmVcoE1wUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NJuAMcrHs1p8VvTG60x5R766q06x89leCPYhzY/8df0q6mTYDHcuTVWyeG1tJsmNvtPeJrz0CdvBsCU+OXLaPNRC9t0NBWxSRr5J6b8P8OkxzAIHVPA0VrkJIToTBIh98UPpWf/E6kES3V8LkNb8FYQcuWV2NfIbnCcVHh/6JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:52 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:52 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:56 +0800
Subject: [PATCH 10/15] net: ftgmac100: Simplify legacy MDIO setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-10-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1050;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=sTOR8ejCb9ahGiji0rY+7pEcpOADWbGOQwYfcP4m9uE=;
 b=WlVoaSp1563j6acdnnF6I+ZXqoxzDPsmIqYbBsMwZ0pYqsefnO1GDq+By+FPERLwahlkqcY73
 SdwErVW03W2Cubp+mfenJNKvCkBIr7nTVEl4o0nzCaJJ9E8cfuWhNkN
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

There are old device trees which place the PHY nodes directly in the
MAC nodes, rather than within an MDIO container node.

The probe logic indicates that the use of NCSI and the legacy
placement of PHYs is mutually exclusive. Hence priv->use_ncsi cannot
be true, so there is no reason to set it false.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 327e29064793..cc01cf616229 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1995,8 +1995,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * child node. Automatically scan the MDIO bus for available
 		 * PHYs.
 		 */
-		priv->use_ncsi = false;
-
 		err = ftgmac100_mii_probe(netdev);
 		if (err) {
 			dev_err(priv->dev, "MII probe failed!\n");

-- 
2.34.1


