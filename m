Return-Path: <netdev+bounces-257444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEK9JMtdhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:19:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F440F9A13
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD443038F28
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D2A33A6F7;
	Fri,  6 Feb 2026 03:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B330D3B;
	Fri,  6 Feb 2026 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347874; cv=none; b=UFlYJTQPaYWCp09pW8PPc0uiAqOXOl679V10vcuIcrgu1CMERNRMFdPWJkDlCJ1a54Q+iV9OJNy7xlXi/kenqzB9pGxjHUM8QnaGYa4xmwvwMcRn9A1xV9bvdDg2zkRRgyM5X/bOzqzHNYOr9cx6vYt24HbWDquM4YLqHANvgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347874; c=relaxed/simple;
	bh=Xm43c+KKic+049Qk5F38DZFCb5ouFHXJhHFJPYfLQ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=l97fdVex4c9pdJirA+CGViY/lwv6fuzOc7oBuw7UlwMywRR/HS8NMkDO0e6+R96Mu4vo1fWdaFe/rXDvsWfrECZ4uJAlWxVUXKJ8jOidvE6njKYO7rPws+y2zZ3B7vj0S5GwPtQ5o0Hd6C/PlnnJc6tBi92c+ZIeD8UWqGStUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Feb
 2026 11:17:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Feb 2026 11:17:46 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 6 Feb 2026 11:17:50 +0800
Subject: [PATCH net-next v5 10/15] net: ftgmac100: Simplify legacy MDIO
 setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260206-ftgmac-cleanup-v5-10-ad28a9067ea7@aspeedtech.com>
References: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
In-Reply-To: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770347864; l=1096;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=GTkRyDcl3ULtGmvephJdZgK7CRofqaRfmOgtTmD+CE4=;
 b=8NPrYO4IW6skyuBdvLBKg5s83NXq0BNrT8EUcmxwurvSSxiXecjvfZgFs4ItVdCIDnGIl5ty/
 xFk2xmVYTnFCQ8uDQ6NQ4CSL/JWP3PDw/OF+Eph6mwV75y+pxkTBCju
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257444-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F440F9A13
X-Rspamd-Action: no action

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
index c33726e7bff6..ee886ed03587 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2010,8 +2010,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


