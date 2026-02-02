Return-Path: <netdev+bounces-255744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLG6N8dLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:01:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32CC9016
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD8673004C8D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1790314A65;
	Mon,  2 Feb 2026 06:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EC313532;
	Mon,  2 Feb 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015508; cv=none; b=L243Sr/QUK/9LiMVV94Cfr01+vCcDZawuAkRcvrQv1pfJMtb6NperL+x/7BAokJlp1C83uP0T9wqK0sWkcx6eEgM6zvA2voWjPXAhh/3G41yGjS3XFO69clC2DRbO3omtT9XkVNVCfDHtx5hJLGqF4/u/pBDaFqpxT6y088FqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015508; c=relaxed/simple;
	bh=PDYi6UpYkJptqVcGU/3hRklZnU4sEbljA07zhsRbTso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gSDAF03MsFpNOOjR75OTGyMbwWJGyewt79fNfhmdauisyFcX/Yux5c2Ak96ibbrw/R5G2uUuFGEngGff2iVR6xXXz3NCBLHz1/13byOs8tod7EwgKxX0DOvEcNILFNZ86EHHSWOD+W75FvWyT3B0vnwi3yP12MP12m0sGchsilg=
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
Date: Mon, 2 Feb 2026 14:57:07 +0800
Subject: [PATCH net-next v3 13/15] net: ftgmac100: Simplify condition on HW
 arbitration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-13-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015420; l=1250;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=ezU52f1OQn+OfdME2BnrNSlfDj+674WoYoINJjV0Dxo=;
 b=jBgGn7VN3r1DXosYMyHg1R+OEyTXUGNXZ1ov5HgZ3B5WMDXlkVlJ1khp9TP48i2wQEYZyETz3
 /T11MHFi3ijDHOzRmTND9T11VCstOaYYUkzy+QAL9LTTjTUdquK8Y+7
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255744-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: EB32CC9016
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

The MAC ID is sufficient to indicate this is a ast2600.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 491b684a79fb..55a592b3d2c6 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2032,13 +2032,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		err = ftgmac100_setup_clk(priv);
 		if (err)
 			goto err;
-
-		/* Disable ast2600 problematic HW arbitration */
-		if (priv->mac_id == FTGMAC100_AST2600)
-			iowrite32(FTGMAC100_TM_DEFAULT,
-				  priv->base + FTGMAC100_OFFSET_TM);
 	}
 
+	/* Disable ast2600 problematic HW arbitration */
+	if (priv->mac_id == FTGMAC100_AST2600)
+		iowrite32(FTGMAC100_TM_DEFAULT,
+			  priv->base + FTGMAC100_OFFSET_TM);
+
 	/* Default ring sizes */
 	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
 	priv->tx_q_entries = priv->new_tx_q_entries = DEF_TX_QUEUE_ENTRIES;

-- 
2.34.1


