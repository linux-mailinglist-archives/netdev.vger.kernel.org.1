Return-Path: <netdev+bounces-139428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A89B23F5
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178261C2106B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305D18C031;
	Mon, 28 Oct 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZrOO2utz"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCF171658
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730091275; cv=none; b=L/T5VNzpnkMiLnhbDUnGIe8p/XfMlI/e5gc0sJXVfQpUE+sKyfaukI9wuQo0nNGzWruDPBcXguYcYJ/PifA0H89FdJVWf+xnggIsY2YsSog+/HZhphfB6cGVjjxOyi+sqoVAqxEkkW5V5SfzC7G0KEUPtaFgP+Yk7lEbWE66bGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730091275; c=relaxed/simple;
	bh=AQ/rIIB0IT5YrNbMxFcPT/zkpUjbODra3f/E8ZEu33k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMLGyGXSQy/ldwCB0k8x3n7UWAg3o5Yx1/1+m6V+aSJSRcwLg3GGV6rbKL1KtpirRZSuFhqeEmqv0TMWcy4i+ztMjo5g1xKkZDzmUkaCr4EHp99oC/XJHdL63bMq7W+pOWcesWbv6K1ROPWGV4tbCAPJflfSTW70BayCi6PwWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZrOO2utz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730091264;
	bh=oPaOrjXSEMn43Gt4PWWAseGLQY7lO+0eGRPfeU5HzYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZrOO2utziSxQ0W9h/HZuS2V9odPPGND2wV1Se5sA6VK3yOTcCAXUZ/tQHObPP+Yac
	 k2Y72FpBQUOeifY3l2NTJRF5ffpnhvM0uouTzGLGeuplV3kMGVDKOU4sjEZJJluGWR
	 YcOqtHwMqFo5SDPaZo8RE5yasI+UcLyE1LqY1oSmh+hdGFPAqoisRuzUS28Bozi2vx
	 WxUirzQCx2wqByfCOBqJ7UbByzBwWKRoWzH/0N7bxx9ECKYL/ioLRQzC3JVCu9DFz6
	 x2MQCPJzhvD/RBbt+htAKg1RzNmda3wq4kYM7tAV8tjSExT/mRh9GHky1jlcZr3cXx
	 d0TAzvlAFgFew==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 8F91A69EB1; Mon, 28 Oct 2024 12:54:24 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 28 Oct 2024 12:54:10 +0800
Subject: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after free
 on unregister when using NCSI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
In-Reply-To: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

When removing an active ftgmac100 netdev that is configured for NCSI, we
have a double free of the ncsi device: We currently unregister the ncsi
device (freeing it), then unregister the netdev itself. If the netdev is
running, the netdev_unregister() path performs a ->ndo_stop(), which
calls ncsi_stop_dev() on the now-free ncsi pointer.

Instead, modify ftgmac100_stop() to check the ncsi pointer before
freeing (rather than use_ncsi, which reflects configuration intent), and
clear the pointer once we have done the ncsi_unregister().

Fixes: 3d5179458d22 ("net: ftgmac100: Fix crash when removing driver")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 0b61f548fd188f64344ff67136c882a49598f6d3..9caee68468ff5f71d7ea63a0c8c9ec2be4a718bc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1599,7 +1599,7 @@ static int ftgmac100_stop(struct net_device *netdev)
 	netif_napi_del(&priv->napi);
 	if (netdev->phydev)
 		phy_stop(netdev->phydev);
-	if (priv->use_ncsi)
+	if (priv->ndev)
 		ncsi_stop_dev(priv->ndev);
 
 	ftgmac100_stop_hw(priv);
@@ -2059,8 +2059,10 @@ static void ftgmac100_remove(struct platform_device *pdev)
 	netdev = platform_get_drvdata(pdev);
 	priv = netdev_priv(netdev);
 
-	if (priv->ndev)
+	if (priv->ndev) {
 		ncsi_unregister_dev(priv->ndev);
+		priv->ndev = NULL;
+	}
 	unregister_netdev(netdev);
 
 	clk_disable_unprepare(priv->rclk);

-- 
2.39.2


