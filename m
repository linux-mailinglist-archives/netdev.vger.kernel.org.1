Return-Path: <netdev+bounces-134309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A807998AFF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487A7291659
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E661C9ECA;
	Thu, 10 Oct 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bs890czY"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183941C3F28;
	Thu, 10 Oct 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572774; cv=none; b=JYU0e1jerOM2+RBAJNU1g1oQm2kBLRbpBKqLTLkLQ6CKoxvaS9HoYAYhbjPp6C6wLtTnJV8UjjLouAIdYAci/3HbOmmSmN8DI53iTfLrklIpB4I/dbmTAphK7A6HaeJBfqJMICVyqLvH/X2/PfqjAWAfyjzhtAyTR64SayEkt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572774; c=relaxed/simple;
	bh=m5uw3eXlhRpsgXeXdOs302gE4sX30libvcLIMVUcBAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pSC0i+OOa5XxV5BiXcD6doO9b1yREPZbkH3wuCU59Y/ncsoUBus0UbjVyWfLS49YRS1tiAh3XtRRGijxV6RWdtthMfq5C80Yd7IVNPilm8Te3irvMaUGWNp0K/sAiG80WuK1PsFIv1n4IkFBIS5uGKiCqvucY4Adpv73xTMDYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bs890czY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49AF5mdq037505;
	Thu, 10 Oct 2024 10:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728572748;
	bh=GqRZLvl2DjQ0upPJP7Y+Ph6GptippgBWVgGt23VlipY=;
	h=From:To:CC:Subject:Date;
	b=Bs890czYvAfOqPp1SIaX0SIVFs6r3JxXydwN/VqnhuhK6aMrRd5VadUtk6/X/VU0E
	 yUQ30kPiG3+4byOuaH9CkEBGv3tFtzREVbFODtjfiOhJhfyj3FQYZaI9fyfie7oOiT
	 Tu/iGRRRDmkhUsm7ylbzWAOGD2XKv8rY+ZB28EBk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49AF5msw113165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Oct 2024 10:05:48 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 10:05:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 10:05:47 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AF5hN1030739;
	Thu, 10 Oct 2024 10:05:44 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <dan.carpenter@linaro.org>,
        <jpanis@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <c-vankar@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Enable USXGMII mode for J7200 CPSW5G
Date: Thu, 10 Oct 2024 20:35:43 +0530
Message-ID: <20241010150543.2620448-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

TI's J7200 SoC supports USXGMII mode. Add USXGMII mode to the
extra_modes member of the J7200 SoC data.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
16aef66643a2 net: phy: Validate PHY LED OPs presence before registering
of the "main" branch of the net-next tree.

Regards,
Siddharth.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 12ccdd3f19aa..09e57e66ea48 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3445,7 +3445,8 @@ static const struct am65_cpsw_pdata j7200_cpswxg_pdata = {
 	.quirks = 0,
 	.ale_dev_id = "am64-cpswxg",
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
-	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
+		       BIT(PHY_INTERFACE_MODE_USXGMII),
 };
 
 static const struct am65_cpsw_pdata j721e_cpswxg_pdata = {
-- 
2.40.1


