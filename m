Return-Path: <netdev+bounces-225147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94AB8F761
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBA17F515
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1292FDC25;
	Mon, 22 Sep 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gKucAK+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D8218AB0;
	Mon, 22 Sep 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529056; cv=none; b=jikHynI3jC4Cp8Hd4yxXDOnHYRcwvskUYDCK8XAe3PxagugnM7C8pQ24H3/LvNgcTB8mY6g5gE3lIBnm+CG41cwukjJQrEa4g+/YDgYxF2CvcSAI4fFRc0rrVBa4gAlu2SPVi590p6D/gwKibKD2umTE3Z95lJ743lmkoXOhOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529056; c=relaxed/simple;
	bh=9SREZZTyiDqdcLc7xZWTEYKmZReN9A4zVPYLUHALnSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnOCDDN0aq0E5Juix8lMSbef0s+FgfiO1Vd34RBHOCXwoFW2fsw8/khRxmE0y0v5L6rPglb1AZ3MeUg/56S457BhwB9EF0dpU0HM7cvB5wn4IJHKYUXE3raN7gSAYzGC/XJcdyqDcgiTrUFI8086r+sjieoTxUFXW5C+YO33MEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gKucAK+R; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 0bb6vy5ucvg3e0bb7v1jYX; Mon, 22 Sep 2025 10:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758528516;
	bh=7pAbNunLZ1TePe1chECcJ/N1WfLPdRA2dzqza0j8kXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gKucAK+RFQAiczKiwL2sTCFFg8ui8u+kvyzxkUg6BRmwNV/tJ7rAA1hjxDOSM3MOU
	 0hifTTRwyA/3eJNgELoqGhhunQaQTItmdabY5cvU9avXHp5jiczGsb4dbC9aR/gGTC
	 vTyGfp9C8B6if+EmsNGn1g5yCb/YHAM62qu5evFOPfclKO63UzY+p6jDKO9RX3eiyD
	 JKUyzBM3KKDOz0Npo5xeGBKmZoLoroJVYiw6joj8DcFbrX0itwkzbZoxwDXGJHdc2k
	 HaSNEHJsgaC2UMtapVoToCpBw9O793BktxsT7QvF8hFocx/qM37Fyrg89rlGuJ0rA4
	 TJUur9Kv6ROtQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Sep 2025 10:08:36 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lennert Buytenhek <buytenh@wantstofly.org>,
	Andy Fleming <afleming@freescale.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net v1] net: mv643xx_eth: Fix an error handling path in mv643xx_eth_probe()
Date: Mon, 22 Sep 2025 10:08:28 +0200
Message-ID: <f1175ee9c7ff738474585e2e08bd78f93623216f.1758528456.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after calling phy_connect_direct(), phy_disconnect()
should be called, as already done in the remove function.

Fixes: ed94493fb38a ("mv643xx_eth: convert to phylib")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative and compile tested only.
Review with care.
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 0ab52c57c648..de6a683d7afc 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -3263,6 +3263,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
 	if (!IS_ERR(mp->clk))
 		clk_disable_unprepare(mp->clk);
 	free_netdev(dev);
-- 
2.51.0


