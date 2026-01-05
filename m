Return-Path: <netdev+bounces-246884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F8CF21F1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC333011AA0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7832C11D1;
	Mon,  5 Jan 2026 07:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFD278E63;
	Mon,  5 Jan 2026 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596950; cv=none; b=eXOA8Au1i0KzTmZyNpg5jubLLu5JAkamc/ukMo06HEWo6hD34X0uRaJghoJ00ItGyiFm/XJ4BoDKE5bk2yySpp4/QymwNDCTx4q9C99+jHj52cy8fQTVQtgvl8VMlpWU834PGaFJY0jClwJZPdxuRXBB0dwAvKE3O6aQojefPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596950; c=relaxed/simple;
	bh=63sVwmCH/6GQ2E59FppAMc1NRGFlUBtTRRXIYDSIAA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TmRL+UF70tGB0Q2A30F4Nb/DMkZ1YocTFoxkK6rZ2oylEe5jDpxrFmn5pmKQywYworIIUd+4SV2WrEf4afn0dDyUzA4owrSAPTEjRZ2zEPOtH6gWVjvEMbNkGnLu+Siu8rvp/ag4uNVG8mJLZoej11uhLz3CsgzVw/7fux386F8=
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
Date: Mon, 5 Jan 2026 15:08:50 +0800
Subject: [PATCH 04/15] net: ftgmac100: Use devm_alloc_etherdev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-4-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1349;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=leJVgbrD0sM0+ZukF10sL2Nm8AnYmSFmz94rAlmrd8k=;
 b=b0l2jMEabc9Ws6DxQ4tJV5tPalpJBWgaqGEFKWCEM71KRlRpAErGogK7iadUso62eTIpGUFPk
 UV0GJyUUQVnDvk2a8lh56WbdlyEGO/lCOblpa6pmQj1a0SjHmy6SPe+
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_alloc_etherdev() to simplify cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f07167cabf39..75c7ab43e7e9 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1877,10 +1877,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		return irq;
 
 	/* setup net_device */
-	netdev = alloc_etherdev(sizeof(*priv));
+	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
 	if (!netdev) {
-		err = -ENOMEM;
-		goto err_alloc_etherdev;
+		return -ENOMEM;
 	}
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
@@ -2080,8 +2079,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 err_ioremap:
 	release_resource(priv->res);
 err_req_mem:
-	free_netdev(netdev);
-err_alloc_etherdev:
 	return err;
 }
 
@@ -2112,7 +2109,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	release_resource(priv->res);
 
 	netif_napi_del(&priv->napi);
-	free_netdev(netdev);
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {

-- 
2.34.1


