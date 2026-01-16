Return-Path: <netdev+bounces-250392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED1D29F78
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4421E30AC968
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074493396E7;
	Fri, 16 Jan 2026 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941F337BAA;
	Fri, 16 Jan 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529422; cv=none; b=Vv5wM0nnza+9AAOb1M2mKlWCMNJyO5GIOjzSWF13a75rfGm+TXMT8mrggxHVYFNsL0Pzs3krB1XGjBNMzgDZUmTTj50jI4guYLNl8keq+SiLGyYlMIfAqbiVMaVQ5uaXpY3F+xRJJbGa1b3H8cT+AsQ3V7QcsLJQ6cz7Jh2RAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529422; c=relaxed/simple;
	bh=yAKMV1n9zuBYT2/kXCPmeCZll/5cbjgYd7Go4UV8TNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MSsSlxge/oOmZi3l5tMro4dCW6KgmO0hdNDC3ll6fedRyS3nzFVFj0ulKLpRiuEhsfkuHQSIhYJaxJLkiSLfTX5iqP7zxdLiC2h9Hg1CtxZrZVfyGy+kt/CkKCrWmUTDP0ViQBtTRhHzfPwH5yrgqNscFS92IfeuArPc7eJ5jBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:17 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:17 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:24 +0800
Subject: [PATCH net-next v2 13/15] net: ftgmac100: Simplify error handling
 for ftgmac100_setup_mdio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-13-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=956;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=rZOhdB2SxA3koqLMc5/XtHD8SIuEU9yPDhMG4DwBZuU=;
 b=7oo6XR4X15z32ht7I5VhcQdGhPk4yU/CoYss35gQHWx9hfx8PipzWc9jq+q5bVmHvEwgn9IGh
 7F7K4PEWU2jBeNMNKfxIxZNaiJX9XI4J9a1/6gDuOHX3jU25XHD6FaV
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

ftgmac100_setup_mdio() cleans up any resources it gets on error. All
resources obtained by the probe function up until this call point use
devm_ methods. So just return the error code rather than use a goto.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1440a4b358e3..93c1ef819abc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2011,7 +2011,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	    priv->mac_id == FTGMAC100_AST2500) {
 		err = ftgmac100_setup_mdio(netdev);
 		if (err)
-			goto err_phy_connect;
+			return err;
 	}
 
 	if (np) {

-- 
2.34.1


