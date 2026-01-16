Return-Path: <netdev+bounces-250389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BCD29F26
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D76393090055
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C8337B9D;
	Fri, 16 Jan 2026 02:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F4338922;
	Fri, 16 Jan 2026 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529417; cv=none; b=HU+9ZoFt4I21MtV0chzA4+3TXyV+/5SyPk4MwENpQeqw2a0NwMr0TCHptkJQbO8Mmm22hCk5a8tmjNhF9nP7f5YCz4gg45CVftSzrT9qgTY/MUOdp4Hq1pgrRgQLdn3pSC1DknTQtx2XlD71GRc4bYHS3WSJFK3ZqoQI7clai6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529417; c=relaxed/simple;
	bh=cdP3hA++LbZWf4x/fXJUvF/jEOobiwzq8EDUx1tuY20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oxnSSMRWsrSo4zxjHUsAhOberitZC/uqWEZ0GZT/qc+ED1PQZb5qri/QqniOLhVR9PZL487Dre3KMc8JecU0bFmLIRJTRyfzuCo3eWVZSe3rPvUIx2nOBmlFfqhXidCMbDQ41yKoG/dY4uPr84wi9SyyoPrbabsEk9xtxkNVVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:16 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:16 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:21 +0800
Subject: [PATCH net-next v2 10/15] net: ftgmac100: Simplify legacy MDIO
 setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-10-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=1096;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=+AJyqE8pVKNsFnqolYpB1UqP9hmjiyBl6KYwvtG6CfU=;
 b=tOdvyra7sfmydiGOrFSY1CEpAuNsfc1isOENm0w7elxAjQ3nCZuYB9gmur1g1OQ2GDC62x5r5
 t3Zvj7oOV33BxVrnWQFgBZzw5JOAFbjXIYXplNW1rX3o1JRtCZ/PWB8
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

There are old device trees which place the PHY nodes directly in the
MAC nodes, rather than within an MDIO container node.

The probe logic indicates that the use of NCSI and the legacy
placement of PHYs is mutually exclusive. Hence priv->use_ncsi cannot
be true, so there is no reason to set it false.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 931fdf3d07d1..f5e69abb1fcf 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1994,8 +1994,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


