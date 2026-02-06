Return-Path: <netdev+bounces-257436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFjfBKNdhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:18:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E9F99FC
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEC403036D4E
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A13330D2A;
	Fri,  6 Feb 2026 03:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F554330331;
	Fri,  6 Feb 2026 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347869; cv=none; b=FhctjcxS9/it+OlGv+UQc2/U9W3pTzDtYCEKuEothyiCNeAVIG2KYcoF2DfgApqJqTNO0NvK0SRt/qBbRJlCu5HbeBmXWGWmW700mPEwMwo1Nmzpw0ej73VmP//gKqwyQTi2CbAgzwiZa3Iq8PQjpxs3foIui1qRx2u/uimRfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347869; c=relaxed/simple;
	bh=TvPvwgbTpwSpyw/7g9BTYt5lpmiQYEi+FH4stMJoeMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hLlA+ltTT5+4zxlUK+JNsZHmSpeHiZRsxDZbj0GMh/8/AUQSHugKqaOv2dJFCEto6iOHHpyPwrO73/ljBFJ+bYbij7aKubdym6JyUzKMezy/VQqjRcHz8DcXjE+2WTCDQ6MkgeYePtiNBAhb5MW44R9rq79Omq9OWffp6j7YoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 6 Feb
 2026 11:17:45 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 6 Feb 2026 11:17:45 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 6 Feb 2026 11:17:42 +0800
Subject: [PATCH net-next v5 02/15] net: ftgmac100: Add match data
 containing MAC ID
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260206-ftgmac-cleanup-v5-2-ad28a9067ea7@aspeedtech.com>
References: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
In-Reply-To: <20260206-ftgmac-cleanup-v5-0-ad28a9067ea7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770347864; l=3993;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=NVi1QwkA7JxwSCPAVjGjUYu41AXXsXEhvfrBSk1vf/A=;
 b=tpk1GakZw49oFnSCjE7N2IehbitaB7Z8oYK3nhioDB6XDrvoJaeO1/5ad0Se7aXQdmVXQz2yb
 lskG3seCWRAAKoGwPiOVlijdEAw+YlTzQRuDlnK154c8d0zQHEflvhU
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
	TAGGED_FROM(0.00)[bounces-257436-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 735E9F99FC
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

The driver supports 4 different versions of the FTGMAC core.  Extend
the compatible matching to include match data, which indicates the
version of the MAC. Default to the initial Faraday device if DT is not
being used. Lookup the match data early in probe to keep error handing
simple.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index bd768a93b9e6..104eb7b1f5bb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -33,6 +33,17 @@
 
 #define DRV_NAME	"ftgmac100"
 
+enum ftgmac100_mac_id {
+	FTGMAC100_FARADAY = 1,
+	FTGMAC100_AST2400,
+	FTGMAC100_AST2500,
+	FTGMAC100_AST2600
+};
+
+struct ftgmac100_match_data {
+	enum ftgmac100_mac_id mac_id;
+};
+
 /* Arbitrary values, I am not sure the HW has limits */
 #define MAX_RX_QUEUE_ENTRIES	1024
 #define MAX_TX_QUEUE_ENTRIES	1024
@@ -66,6 +77,8 @@ struct ftgmac100 {
 	struct resource *res;
 	void __iomem *base;
 
+	enum ftgmac100_mac_id mac_id;
+
 	/* Rx ring */
 	unsigned int rx_q_entries;
 	struct ftgmac100_rxdes *rxdes;
@@ -1835,6 +1848,8 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 
 static int ftgmac100_probe(struct platform_device *pdev)
 {
+	const struct ftgmac100_match_data *match_data;
+	enum ftgmac100_mac_id mac_id;
 	struct resource *res;
 	int irq;
 	struct net_device *netdev;
@@ -1843,6 +1858,16 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int err = 0;
 
+	np = pdev->dev.of_node;
+	if (np) {
+		match_data = of_device_get_match_data(&pdev->dev);
+		if (!match_data)
+			return -EINVAL;
+		mac_id = match_data->mac_id;
+	} else {
+		mac_id = FTGMAC100_FARADAY;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
@@ -1870,6 +1895,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
+	priv->mac_id = mac_id;
 	INIT_WORK(&priv->reset_task, ftgmac100_reset_task);
 
 	/* map io memory */
@@ -1900,7 +1926,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (err)
 		goto err_phy_connect;
 
-	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
@@ -2090,11 +2115,31 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	free_netdev(netdev);
 }
 
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {
+	.mac_id = FTGMAC100_AST2400
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2500 = {
+	.mac_id = FTGMAC100_AST2500
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
+	.mac_id = FTGMAC100_AST2600
+};
+
+static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
+	.mac_id = FTGMAC100_FARADAY
+};
+
 static const struct of_device_id ftgmac100_of_match[] = {
-	{ .compatible = "aspeed,ast2400-mac" },
-	{ .compatible = "aspeed,ast2500-mac" },
-	{ .compatible = "aspeed,ast2600-mac" },
-	{ .compatible = "faraday,ftgmac100" },
+	{ .compatible = "aspeed,ast2400-mac",
+	  .data = &ftgmac100_match_data_ast2400},
+	{ .compatible = "aspeed,ast2500-mac",
+	  .data = &ftgmac100_match_data_ast2500 },
+	{ .compatible = "aspeed,ast2600-mac",
+	  .data = &ftgmac100_match_data_ast2600 },
+	{ .compatible = "faraday,ftgmac100",
+	  .data = &ftgmac100_match_data_faraday },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ftgmac100_of_match);

-- 
2.34.1


