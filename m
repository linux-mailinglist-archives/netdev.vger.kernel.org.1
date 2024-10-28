Return-Path: <netdev+bounces-139429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB89B23F6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEA91C212CB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743B18C333;
	Mon, 28 Oct 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="edU9txhZ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D84170A14
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730091275; cv=none; b=VSXAwmS7dfUrWzjxzrF+4tOLW2eCaJ7YGf1h2YnANp5Thde93ZVxMwePtc6SRxS1T4YlyO9nf92Kol/Jbm4PHrSDN63H/h64XOSQDjmngov8eeCpZfy4od2op3a36YE/YRxSO9i/osJtwMzdUPNIuYPUHEY6e4Hj42vHWaDAnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730091275; c=relaxed/simple;
	bh=5juCU2MwtuD51rNl0JO8kPZe7YEa8A4xnB3tTZeQ1MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbOKwrFDgQknVTJaPPZ9uWyI9quZdjerQFihJCy6mIcwITdUGymSs7QGWmSW3QUPENbjUIMNgjuwqLXfcn2dncX6hjUOJr6Fl23aExeTiKQP62H/K7dons50DV2rLHzT4eohGQI29dWxYAZGUCkyrrPQl+oTp8t3xd6Y7DHA7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=edU9txhZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730091265;
	bh=rwhNeX6ImQzf0CSAGecHyjNYMwLmkAVQobWFnz2mboY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=edU9txhZWR+2m1gdM+ex0o7kttHzuyVchX5hI9i3+TTjpRvC6XVexJYZftnVlYsKs
	 LBC9p1+qVGL8UZiPoiSKda5nvZzC6Lg1jdSI2H/WsYQ6KzQ+BhREk4EjQEwO4g0usL
	 fcUNFN12Qj19ubu0aQEXk30m2rQRuCePpIf51ueqkgFJLAINlSnpoF0tIvs8dsXdvY
	 wE0o6GNiwYHXsEDpxnPts0UZxENyu1ySjFxdai+rH9kwMUNHr3s9B5lhBIgYYTiTSi
	 aadr0iGGLbdUiCHotqFFbtyk7G9jxXS9NdAyHS+HHo/lslRIixCoTTNPgy4GSDKvHf
	 RDxkSYO3Mk2Lg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 1835469EB2; Mon, 28 Oct 2024 12:54:25 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 28 Oct 2024 12:54:11 +0800
Subject: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
In-Reply-To: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Commit e24a6c874601 ("net: ftgmac100: Get link speed and duplex for
NC-SI") introduced a fixed phydev attached to the ftgmac netdev for ncsi
configurations, cleaned up on remove as:

    phy_disconnect(netdev->phydev);

    /* ... */

    if (priv->use_ncsi)
        fixed_phy_unregister(netdev->phydev);

However, phy_disconnect() will clear the netdev's ->phydev pointer, so
the fixed_phy_unregister() will always be invoked with a null pointer.

Use a temporary for the phydev, rather than expecting the netdev->phydev
point to be valid over the phy_disconnect().

Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 9caee68468ff5f71d7ea63a0c8c9ec2be4a718bc..c6ed7ed0e2389a45a671b85ae60936df99458cd1 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1730,16 +1730,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 static void ftgmac100_phy_disconnect(struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
+	struct phy_device *phydev = netdev->phydev;
 
-	if (!netdev->phydev)
+	if (!phydev)
 		return;
 
-	phy_disconnect(netdev->phydev);
+	phy_disconnect(phydev);
 	if (of_phy_is_fixed_link(priv->dev->of_node))
 		of_phy_deregister_fixed_link(priv->dev->of_node);
 
 	if (priv->use_ncsi)
-		fixed_phy_unregister(netdev->phydev);
+		fixed_phy_unregister(phydev);
 }
 
 static void ftgmac100_destroy_mdio(struct net_device *netdev)

-- 
2.39.2


