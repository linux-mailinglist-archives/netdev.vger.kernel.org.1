Return-Path: <netdev+bounces-136860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2939A3455
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAA91C21D07
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D0178389;
	Fri, 18 Oct 2024 05:33:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2416F2F3;
	Fri, 18 Oct 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229617; cv=none; b=csVUzXzMFNXbRkRBtnVeOegBJMgATr1f7iNfonfl3SyhXKjnRzRZQvWE2AYNETi3f8LQg+BKcprw6Ek/MUeTkRNHmW3af/MYtPkTtn6jgnH2GqAb8b7A1w36xJXnxQtlY7wY7QcmssXg8GDiGFsPHJkH0dGdKn56KoAMDL9LRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229617; c=relaxed/simple;
	bh=iL0+xCycBT1AF4raP1D3zYHwAsJaLFuVUpxvL7Xriok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pU14yek2EOPVrQcTD/51iNOm56th/hFBCAfTxtHCrFO/dZ7yvQ4EUg+Sf0UedRL2ghzMSvCM8yRPwr/oMpHXBOi8X/Msxp415Ni5/T8j108a+TVU7ZYMTUqKA35ipStCxfShtlJZ84RzsZAHqeZ1+RQk19GGg4chwwd1uNwONEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 18 Oct
 2024 13:33:31 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 18 Oct 2024 13:33:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>,
	<u.kleine-koenig@baylibre.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next v2] net: ftgmac100: correct the phy interface of NC-SI mode
Date: Fri, 18 Oct 2024 13:33:31 +0800
Message-ID: <20241018053331.1900100-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In NC-SI specification, NC-SI is using RMII, not MII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
v2:
  - Correct the subject
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index e64a90a91dd4..10c1a2f11000 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1913,7 +1913,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 		}
 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
-					 PHY_INTERFACE_MODE_MII);
+					 PHY_INTERFACE_MODE_RMII);
 		if (err) {
 			dev_err(&pdev->dev, "Connecting PHY failed\n");
 			goto err_phy_connect;
-- 
2.25.1


