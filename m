Return-Path: <netdev+bounces-255751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IATOOqFMgGlQ6AIAu9opvQ
	(envelope-from <netdev+bounces-255751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:05:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8DC9089
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060643032774
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A9830F932;
	Mon,  2 Feb 2026 07:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5730E83C;
	Mon,  2 Feb 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015737; cv=none; b=FJEeAxNRegogh+fBdNKr1zIjCk6pSJ9/xPhVvdN/oTkisqqlYF+VdE1yL6NXWfRnE87zsWm7mSak/J2yS+zh018Ql3/j08e4kBzkCZzYhBbAwZmMjfvJJkqIqVrRI6L/14LB2oVu+qweLW7Nc4uvWGdqREGqAy2K8Ti+nyHgsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015737; c=relaxed/simple;
	bh=1bEa2Jv/bTv7bHrcPfXv9ul57tdtU4FVmXDJgJry74s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oUhkCGv6hWNeNpDbKGsgRTURDXZkMhrGDRFN4SLY/1h42jTKi96puPyWdRLPd4U97yZLZwUeDT0Uf1mnGuKj6AsUwAjZkqQpLgPNP70qcpHflIMIgpeQkIO0E4ODvlNWCz67+U8gjTY1x1GvkRT8clCav+kKBuSIKoIrcHagM08=
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
Date: Mon, 2 Feb 2026 14:56:57 +0800
Subject: [PATCH net-next v3 03/15] net: ftgmac100: Replace all
 of_device_is_compatible()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-3-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015419; l=3130;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=+aILZO8pus/3meVrNzurjk9uWwwKRISZWHJRBZ3qWxI=;
 b=cQaHfFCn2Tu+xjHPO213qIuDLrIRTvVe7zRWDuQxUsdMNFinCvKWMHbdz70zAs+KA8CoE7ZAM
 JvpuA2zf5sSDs/sd9BvOAD15vvHXqpwsAVYEI5AdoBq20w4SaCHCEiD
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255751-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CA8DC9089
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

Now that the priv structure includes the MAC ID, make use of it
instead of the more expensive of_device_is_compatible().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 104eb7b1f5bb..f07167cabf39 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1720,8 +1720,8 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	if (!priv->mii_bus)
 		return -EIO;
 
-	if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-	    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500) {
 		/* The AST2600 has a separate MDIO controller */
 
 		/* For the AST2400 and AST2500 this driver only supports the
@@ -1926,9 +1926,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+	if (priv->mac_id == FTGMAC100_AST2400 ||
+	    priv->mac_id == FTGMAC100_AST2500 ||
+	    priv->mac_id == FTGMAC100_AST2600) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1973,8 +1973,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		 * available PHYs and register them.
 		 */
 		if (of_get_property(np, "phy-handle", NULL) &&
-		    (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		     of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
+		    (priv->mac_id == FTGMAC100_AST2400 ||
+		     priv->mac_id == FTGMAC100_AST2500)) {
 			err = ftgmac100_setup_mdio(netdev);
 			if (err)
 				goto err_setup_mdio;
@@ -2026,7 +2026,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (priv->mac_id == FTGMAC100_AST2600)
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2044,11 +2044,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	/* AST2400  doesn't have working HW checksum generation */
-	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
+	if (priv->mac_id == FTGMAC100_AST2400)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	/* AST2600 tx checksum with NCSI is broken */
-	if (priv->use_ncsi && of_device_is_compatible(np, "aspeed,ast2600-mac"))
+	if (priv->use_ncsi && priv->mac_id == FTGMAC100_AST2600)
 		netdev->hw_features &= ~NETIF_F_HW_CSUM;
 
 	if (np && of_get_property(np, "no-hw-checksum", NULL))

-- 
2.34.1


