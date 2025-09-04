Return-Path: <netdev+bounces-219847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD57B436BF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B1F189CE61
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE32E1C7A;
	Thu,  4 Sep 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rclSliyK"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4432D63F6
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977233; cv=none; b=gGb9q7cqf+vfD5wvP6Uwfsso1rUgY+MH4C3pGEyNVPxfK73A0Ted1C6Cxwrrw+6Z8RvV4MwyNwxHvI6aHU1UNGss/051jJfwf8uMtUFdsyXzUMaXnbHrCZ56PWkUW+M3L3e+SkDexRXacv/PTZv6BKYwIVByyMyTOg1fU4gRcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977233; c=relaxed/simple;
	bh=vDkM8EggsOOXVGOl30fMcL/k1YvAF/zoDxLrgle5M3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gx5KaCqs5YxNAFFKY1+XUsWzWJwARYRlILttOZW9mtmDJt63C8oh4ffa8WI9/dbQ9Y1u0KfCKdz8as1RJamKiP3F83mYqeedQLHpKCiVQ1qhTWlIswUcJwCLDGIuTBspgZsVn61f0wtwlQvmjzxM8nunLbki22oxtW8bCtN/868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rclSliyK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756977220; x=1757582020; i=wahrenst@gmx.net;
	bh=eT6RqBWyNeJX4HP85LpnQuIKIs/+p/iHZyCHn709iBk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rclSliyKwhifZ9yUIX3RUGqzJD5ltga02t1Y6Sf1JIcjNOlFEYU6mYTKxFCUaTCS
	 FGobKlQgJnsrOaIkif0oSzERdEZHpmvB5py5SPsLzUPS30iT6xMaIzGK7NXitapPM
	 X9N5DA7m96wKw3KcWYx27JrJOjx2BXCpZRvMl+0xKXu+a/e4j46vPWFMcizBu60iX
	 1yJSf1opxswpbh1vfm7h4R6tt2Mj7KYixPvFsfbkz99lA1V3imyDE1xUwLm+vTJyr
	 14OE0v5o5H0VTOwktAdfvjsiiZs6xG0fC2sd4KucQHpG2nwKLxhymv2s1I9lAE8TI
	 GFgAzod68Fo8z5CzjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1uRapw0Hhw-00tJFp; Thu, 04
 Sep 2025 11:13:40 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH net] net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()
Date: Thu,  4 Sep 2025 11:13:34 +0200
Message-Id: <20250904091334.53965-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:btI13UPWWEk7ztArlV/ss6uD0EXxbYm7I9NyGPnHl77SdL5JE6o
 PpQPv+ZsaO5ojcdlW/3RQP2/xX8tR6h6UDMDyzORtiF2nzDU3yoIBrho7Glf6egcVx0g4GT
 NviZVg0NR3XraXj6mnLlXY4iPmF3Soaelqs2e9Da1ZvF7/w4gOTlkslZxk5gsHOtnNCQGbw
 ZAU6/JdLm5V2nUN6dKuJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OEaK1ffxXcE=;xW6dItEk+U1ckXpjckTmOEUPa8b
 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
 cgNQlibdwQcMGo0vI5ET84jxWsJ5EGiQ==

The function of_phy_find_device may return NULL, so we need to take
care before dereferencing phy_dev.

Fixes: 64a632da538a ("net: fec: Fix phy_device lookup for phy_reset_after_=
clk_enable()")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Richard Leitner <richard.leitner@skidata.com>
=2D--
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ether=
net/freescale/fec_main.c
index 1383918f8a3f..adf1f2bbcbb1 100644
=2D-- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2363,7 +2363,8 @@ static void fec_enet_phy_reset_after_clk_enable(stru=
ct net_device *ndev)
 		 */
 		phy_dev =3D of_phy_find_device(fep->phy_node);
 		phy_reset_after_clk_enable(phy_dev);
-		put_device(&phy_dev->mdio.dev);
+		if (phy_dev)
+			put_device(&phy_dev->mdio.dev);
 	}
 }
=20
=2D-=20
2.34.1


