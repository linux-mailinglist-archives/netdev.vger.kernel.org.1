Return-Path: <netdev+bounces-246893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597BCF2248
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507FA30E3D37
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230CC2D8799;
	Mon,  5 Jan 2026 07:09:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBA27E040;
	Mon,  5 Jan 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596969; cv=none; b=AbTU2vOaGX8A7KCYqW8PpxKEWR/v3fZ+PmDna0locXk9CuE/jqa+8AykaaTQNoaSJEfI2x+TvB+qPR726KtcT7B2WiTiEqKaUCVCbRPTVLwK1Ty7i/Jef1q2bTK38c6HKLr2CYrb9kqKU7fj+urjEjGXs7DelwMp4Tn+3uR23Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596969; c=relaxed/simple;
	bh=aD3Y/J4WZhGKsr3d7Oz+Ovnk92GYeHT4AmKUjOZT3PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qRfy/7aXj1r0aKJ7ZOKhHyGVHIXedeNenxOwBWckg9uSkMShC0fnT8c3w5SZ16WjEEQwXFBN6wCJfqQoBL1uWfO9uw0khzXMbLQZhhK9uV1CKYWziLJBH/6piQ3xdzXHY1slLfBvba/orfwbi+SRvvX7osFYYMHDOVj0gkvG8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:53 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:53 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:59 +0800
Subject: [PATCH 13/15] net: ftgmac100: Simplify error handling for
 ftgmac100_setup_mdio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-13-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=910;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/wYKQIprzeIHoGUa5tn6VzD6FBP9laPgt1UMjBwnQRw=;
 b=Fxy3lHdN5MMoqKUVYXdwnt+CqbcXs8YszPaIW41EdFyeS9Uh8JYdlHMBotOQ6i8VDpdd7ep3/
 FcETLZqJzGGAnNw2KKjEdAKRsN2BL3NU3l0SLFhOZC9TTJNh5QkUOUa
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

ftgmac100_setup_mdio() cleans up any resources it gets on error. All
resources obtained by the probe function up until this call point use
devm_ methods. So just return the error code rather than use a goto.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 23a2212ee3bc..982944ab1ff1 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2012,7 +2012,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	    priv->mac_id == FTGMAC100_AST2500) {
 		err = ftgmac100_setup_mdio(netdev);
 		if (err)
-			goto err_phy_connect;
+			return err;
 	}
 
 	if (np) {

-- 
2.34.1


