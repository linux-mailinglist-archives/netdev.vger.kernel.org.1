Return-Path: <netdev+bounces-132578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0469922F1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 05:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DEC28298A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9B10A1C;
	Mon,  7 Oct 2024 03:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63F12E48;
	Mon,  7 Oct 2024 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271488; cv=none; b=DtEd1eg3nMjr8Re1AhkV1SUUFVB6cd/ShDG4FhfdG+kg8SOU6gnAFrqOQkKwaUdF4u5IiXOs1HQ79SaNGB90avTPU6DFz7APWxrBPA29iPXZVbRzV/JIqUCCg/kPDNRQucdjsoUdpyX2GAPIehTgxlHeaokPLaaBzkUjmD2rcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271488; c=relaxed/simple;
	bh=FmHJsM9XdOazx2e6DhSVgW+5ZV9B2S4ODEPD/WGaEc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RogrPdlBpF+kAHBU05SgHG14xGSUFgpmFFXRGqGC+wTYs9EN8LqvO047yic4uulpvMh8ul32d7mJE7bujjx7/AyaTT9/cSjdgE+rk24MrL3CKY1zjwOziZn/Am+efxu741yQGiUVZDOaMD8emoJRsghjKKRaF2eZzMVXYDVnca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 7 Oct
 2024 11:24:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 7 Oct 2024 11:24:35 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net] net: ftgmac100: fixed not check status from fixed phy
Date: Mon, 7 Oct 2024 11:24:35 +0800
Message-ID: <20241007032435.787892-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add error handling from calling fixed_phy_register.
It may return some error, therefore, need to check the status.

And fixed_phy_register needs to bind a device node for mdio.
Add the mac device node for fixed_phy_register function.
This is a reference to this function, of_phy_register_fixed_link().

Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f3cc14cc757d..0b61f548fd18 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1906,7 +1906,12 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 		}
 
-		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
+		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, np);
+		if (IS_ERR(phydev)) {
+			dev_err(&pdev->dev, "failed to register fixed PHY device\n");
+			err = PTR_ERR(phydev);
+			goto err_phy_connect;
+		}
 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
 					 PHY_INTERFACE_MODE_MII);
 		if (err) {
-- 
2.25.1


