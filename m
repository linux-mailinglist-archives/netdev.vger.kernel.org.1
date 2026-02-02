Return-Path: <netdev+bounces-255745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9aGzNMgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:03:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA171C9047
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B7C300DD5A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E4315D58;
	Mon,  2 Feb 2026 06:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20462314A79;
	Mon,  2 Feb 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015510; cv=none; b=eLW6M4L0PWLM1E1fbWBR599kXd8Axp5yMbd4C366A3Y8GM129lKR/OZ3P8E9WmjBnLw4JBcusspSfzB7sui1t7+1KVCTJkValj4GV2f9qPOWKSSJ4fyqTHtu+Dw7/6zJYhRfzdwKrk5UZucM+0uZY/H0SUVQkiPolEFQhMkwsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015510; c=relaxed/simple;
	bh=UjgZvyr3h7j7m5xJ9jp66e9iDUJvnvWRprKsNxTiiq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DtJW5XwbZNmekKFydu3FSzRgNsZEXqu8VDnd4xJkl1R18Q16yHQOg2lYfMG2sPgCdWLgVYoKwUBB1c7PGUNTDVkN+WuLDPg4jGRrM61E8cwx6gRlb5wtIgCX29VUzAXO02ZrJtqrleeBH0o4wObEjrHGMbBjRUr3jwy3YFnL2UI=
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
Date: Mon, 2 Feb 2026 14:57:08 +0800
Subject: [PATCH net-next v3 14/15] net: ftgmac100: Fix wrong netif_napi_del
 in release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-14-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015420; l=910;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=AaqHFFSyE0sFfHM4rRsamXsCM6KZqCk9Cn6V4gwrWUw=;
 b=XoFVsNKZwTlWGjOES42L87QjdfBNMmrevu2+5xBFCQh+HFFBi1nao7/k1yfrQ3Kk5QfFQQMqX
 VdS+AS8QXDJApHgJgz3tUGe+otLn8vFAYNtmTelzW4XlqALFg2QTURP
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
	TAGGED_FROM(0.00)[bounces-255745-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: EA171C9047
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

netif_napi_add() is called in open. There is a symmetric call to
netif_napi_del() in stop. Remove to wrong call to netif_napi_del() in
release.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 55a592b3d2c6..45312b9ef35f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2101,8 +2101,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
 
 	ftgmac100_phy_disconnect(netdev);
 	ftgmac100_destroy_mdio(netdev);
-
-	netif_napi_del(&priv->napi);
 }
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2400 = {

-- 
2.34.1


