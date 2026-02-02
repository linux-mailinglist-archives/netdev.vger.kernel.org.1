Return-Path: <netdev+bounces-255736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOuMMgtLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:58:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA21C8F91
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 089EB3004D3A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E95430BB93;
	Mon,  2 Feb 2026 06:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D352BDC1C;
	Mon,  2 Feb 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015494; cv=none; b=OfXnLHiftg/fzMycObC/4eXDjQyXl+1+z2XxshrEL0bw/C6CiW7t9nchFj2cleO5oe3lqzG4HDEBx3FdziQribMj7whWWt1BdHbJwjXyQ69fssFIsj8G/cAo1Iw2ih2J3r2yQSVl0y3eRmw8sSaHcXt8kpEcj/A4GlrjyPwWwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015494; c=relaxed/simple;
	bh=ceYR9uOBjSpJRI2oiBkcEl1sbI98TqqWni7uo64dK5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dRRXWMJARy3DDmSDZ+atb7HrNexU37QLQzeWTntRXd0vYwAmummV1+J8IZtJzgipaMndFZXS4zO3+uSr3gjNKb+LvsN9VZIdUUaA8/VI1FtpHRXKplqUnZsnIXOYdfX594Slk6ZB/pR8CLIXKsTK2K+zRoW3ip+vOiEULHMLn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:56:59 +0800
Subject: [PATCH net-next v3 05/15] net: ftgmac100: Use
 devm_request_memory_region/devm_ioremap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-5-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015419; l=1997;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PabSzzWHuOc4GjJAVT/Ar4WEHvlB1Z2Il9a4L8Pq5xY=;
 b=UealA8MQUvPt394swGWa6cSd3LUKbrLyOXgyMKqfUdg266dFocu3tHSAG/trMwDoIR77Sr7hZ
 Y7BcBVgS66BBC8bOYyBWca/bnSSASuLmOCd+Exq1JfJmUNyDDGWo/xs
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255736-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 5EA21C8F91
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

Make use of devm_ methods to request and remap the device memory to
simplify cleanup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 397ada43c851..ec2e7ec23ddf 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1897,19 +1897,18 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	INIT_WORK(&priv->reset_task, ftgmac100_reset_task);
 
 	/* map io memory */
-	priv->res = request_mem_region(res->start, resource_size(res),
-				       dev_name(&pdev->dev));
+	priv->res = devm_request_mem_region(&pdev->dev,
+					    res->start, resource_size(res),
+					    dev_name(&pdev->dev));
 	if (!priv->res) {
 		dev_err(&pdev->dev, "Could not reserve memory region\n");
-		err = -ENOMEM;
-		goto err_req_mem;
+		return -ENOMEM;
 	}
 
-	priv->base = ioremap(res->start, resource_size(res));
+	priv->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!priv->base) {
 		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
-		err = -EIO;
-		goto err_ioremap;
+		return -EIO;
 	}
 
 	netdev->irq = irq;
@@ -2074,10 +2073,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		ncsi_unregister_dev(priv->ndev);
 	ftgmac100_destroy_mdio(netdev);
 err_setup_mdio:
-	iounmap(priv->base);
-err_ioremap:
-	release_resource(priv->res);
-err_req_mem:
 	return err;
 }
 
@@ -2104,9 +2099,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	ftgmac100_phy_disconnect(netdev);
 	ftgmac100_destroy_mdio(netdev);
 
-	iounmap(priv->base);
-	release_resource(priv->res);
-
 	netif_napi_del(&priv->napi);
 }
 

-- 
2.34.1


