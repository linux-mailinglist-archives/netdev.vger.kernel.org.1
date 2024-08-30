Return-Path: <netdev+bounces-123566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAF965527
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AC11C22566
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522034D112;
	Fri, 30 Aug 2024 02:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DD4690;
	Fri, 30 Aug 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983947; cv=none; b=TpQINw3gw6pyTZdXyf8YcwLZ38b5yIv6cqMjOmzpO2NTUw9C6jgqGk5gP3iAIj6dHHnwrriyqePRNpUxXOLcVbgwzLId+7oMBL6smuFLJCfirp3aWVXBLlo45xEZvTafQOQbM+BJC85RDJSM10or/Cy7mRUvnGzMpsmEmcmHD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983947; c=relaxed/simple;
	bh=MkwRKOBfoOnsuwu0XckngupwHeVgGbLS/P1lio8d648=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9PKRF5dyY1dxAzzExfnDQkJ7SJYcsxjGCYySUTrTNo17xtZYVBfLc2tBdWZR4CSG96rXDfEmZK6o3L09IJXEzUthsKpdU1p9IG55bsncmQeACRMMIPwIDie91O332/DKMRl2bKs0/6XRsKMZSZiObqrNqegc7mWXAcPWhZj6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww1qp0gXwz2Dbbb;
	Fri, 30 Aug 2024 10:12:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 83295140123;
	Fri, 30 Aug 2024 10:12:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 10:12:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <f.fainelli@gmail.com>, <ansuelsmth@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v4] net: phy: Fix missing of_node_put() for leds
Date: Fri, 30 Aug 2024 10:20:25 +0800
Message-ID: <20240830022025.610844-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The call of of_get_child_by_name() will cause refcount incremented
for leds, if it succeeds, it should call of_node_put() to decrease
it, fix it.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Split out for net fix branch.
- Signed-off-by: should always be last.
v3:
- Add Reviewed-by.
v2:
- Split into 2 patches.
- Use of_node_put() rather than __free() to fix it.
---
 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8f5314c1fecc..243dae686992 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3424,11 +3424,13 @@ static int of_phy_leds(struct phy_device *phydev)
 		err = of_phy_led(phydev, led);
 		if (err) {
 			of_node_put(led);
+			of_node_put(leds);
 			phy_leds_unregister(phydev);
 			return err;
 		}
 	}
 
+	of_node_put(leds);
 	return 0;
 }
 
-- 
2.34.1


