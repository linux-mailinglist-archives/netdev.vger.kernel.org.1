Return-Path: <netdev+bounces-250386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF34D29EF8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 937C9303E684
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6F33892D;
	Fri, 16 Jan 2026 02:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B91A9B58;
	Fri, 16 Jan 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529393; cv=none; b=HCBqcqBaSH1y1fpc+0FwJqtCu2nsO9DwkRSTgNzc60tSScXtP7mJROsG/MjXlDTYmTVCzg9uejlXbMuotEtLXura/5iCSqx3Q47EnFbp4OsPEzsyuvZ7jxZv8zmh+54Nwmg6pB8gWo+WuArWcysEs4Ckoi0K5o+LijPFUvdXzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529393; c=relaxed/simple;
	bh=xH6fYjFLYrj9T4Zssm8L2SOBS9UFZxiecwVla7SSNlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LLRM7D4Ez31SEODKWPOWIHnl5/I5tcJKDjvYZDq4NzMxe+PSsFGwXm4rmckCSqQauXl6spvFLB990g7Pi2jj/72BTMGgol7FvWgGdO8CTsOlWJhK2dC8je9wMfSlLl968ZA/K2axVzo34cssr0u0TQtygNyHdD/uIma65Qry3WY=
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
Date: Fri, 16 Jan 2026 10:09:18 +0800
Subject: [PATCH net-next v2 07/15] net: ftgmac100: Simplify error handling
 for ftgmac100_initial_mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-7-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=1005;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Imv9CaCbsjW/yCYSl/UPIG/NQCG6R8NUnI71OzZI5CA=;
 b=aHWAWOh6nvZMpy8QlQFLIf2upSDN4Vy8kFQw/NlLpKcYEV52Csi48IEO8EhniOxg5GBYKLQ+R
 VZxf1/7RdvXDqy64qCNsVbRv+oxoHAXgm3dbEu/LJsSU6UxkIXqqhC1
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

ftgmac100_initial_mac() does not allocate any resources. All resources
by the probe function up until this call point use devm_ methods. So
just return the error code rather than use a goto.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index ffd86655bcc8..3bccf34cc8a4 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1912,7 +1912,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	/* MAC address from chip or random one */
 	err = ftgmac100_initial_mac(priv);
 	if (err)
-		goto err_phy_connect;
+		return err;
 
 	if (priv->mac_id == FTGMAC100_AST2400 ||
 	    priv->mac_id == FTGMAC100_AST2500 ||

-- 
2.34.1


