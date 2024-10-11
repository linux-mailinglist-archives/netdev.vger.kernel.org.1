Return-Path: <netdev+bounces-134514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDA999F03
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE15D280E56
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072320ADE9;
	Fri, 11 Oct 2024 08:28:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569B20A5C1;
	Fri, 11 Oct 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635313; cv=none; b=EYnzPigb21CIORelzWMa2qeLFshUc2GsCZmyCGbSnzChBq3THfFLvfiO46x7UMhPSB2opS1B03gBx8okk4v2vqdE6qFCwDYL8+9dGKlPUYZJzy+VA+FHVWeCZv5TaDwtjT9tuAtm6tcBpWVPAHqDVIhnj/PiMjFl/TimJ1bae2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635313; c=relaxed/simple;
	bh=bfO6IJJuaWQQXCUcioXXr3tZh6+ZJReYFsFkz4ECTCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wx0PtVeQ66UpC6SKctzHSE60AKyKSSU2umpeETMBBeoaeMtQykrVfBXBQvNyHqA1SRwqZU6g2UEgr1Aii1EcgObqb2IYODqP7822u7gaOL4CWUOqqXr2e7bdClpIuq81uVEOY8ZIWsr8JG96BnNmoXT5rH5oIyZgRs3mJun6Md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 11 Oct
 2024 16:28:27 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 11 Oct 2024 16:28:27 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net] net: ftgmac100: corrcet the phy interface of NC-SI mode
Date: Fri, 11 Oct 2024 16:28:27 +0800
Message-ID: <20241011082827.2205979-1-jacky_chou@aspeedtech.com>
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

Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index ae0235a7a74e..85fea13b2879 100644
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


