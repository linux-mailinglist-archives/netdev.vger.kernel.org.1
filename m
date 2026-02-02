Return-Path: <netdev+bounces-255743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK6CJPJLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727DC9026
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F4C1301938E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43133312816;
	Mon,  2 Feb 2026 06:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA23312805;
	Mon,  2 Feb 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015507; cv=none; b=oJDIecMJVsXozYJJP2A4M4NP5UJu6fIgqgK/I2t26ar5vFd2lbYlaXdEvmWYF7TWbmp4LwMzh5VTPQi3wjyJeglA/q4Kdc+ttEUDPYGgbay7TBUy6VslpCd8p4ZEvtfewgj27/Rs2f+FBpDOe8N3EVo4g8NLdc1UsvaKnJTltpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015507; c=relaxed/simple;
	bh=xYzuPf4JpHkrgbcNDcIhc2AIPUmm1ELC+ia/CAI9TEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ALwMxxPRFV8JQPngE3hgK4PJhYfp3cVlaJgYmjNPOSXz0CivdvCsB+p+ozem3eKGZzrmTy6G/noMaWLSVoDZUMLFlR7cW5FT6UGP7htO7PyUfBThYeehEagEg82isCY5UakPRYSjgGnpcuURhBZA7N0HkVCP5c1bvBk/03xu2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:57:06 +0800
Subject: [PATCH net-next v3 12/15] net: ftgmac100: Remove redundant
 PHY_POLL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-12-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015420; l=1321;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=1fAu1sJrlN8RbP5zBZRB1ty0MJGnS8BU28stOLewZ40=;
 b=4AG56XV68HiduK30y/FQj160NBHCnugr9EGcenSUJgJMPGijXlScVXK/4iCGe3F7l/wv+0BRw
 uB27BeW40+uBo0UBXqAJOSliF0O/vd6QjAWU9uOWtdtmdRNRI4krY+o
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255743-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: 4727DC9026
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

When an MDIO bus is allocated, the irqs for each PHY are set to
polling. Remove the redundant code in the MAC driver which does the
same.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index eac0eddff641..491b684a79fb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1712,7 +1712,7 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	struct platform_device *pdev = to_platform_device(priv->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *mdio_np;
-	int i, err = 0;
+	int err = 0;
 	u32 reg;
 
 	/* initialize mdio bus */
@@ -1740,9 +1740,6 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	priv->mii_bus->read = ftgmac100_mdiobus_read;
 	priv->mii_bus->write = ftgmac100_mdiobus_write;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		priv->mii_bus->irq[i] = PHY_POLL;
-
 	mdio_np = of_get_child_by_name(np, "mdio");
 
 	err = of_mdiobus_register(priv->mii_bus, mdio_np);

-- 
2.34.1


