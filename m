Return-Path: <netdev+bounces-42258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BD37CDE27
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D750C1C20ADA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FFB37140;
	Wed, 18 Oct 2023 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="neBjnd24"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D336B00
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:00:32 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599DFA;
	Wed, 18 Oct 2023 07:00:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IE0FJa070433;
	Wed, 18 Oct 2023 09:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697637615;
	bh=cF8uxM01yGbcIgO9pF4+ZLUEaOrjQiH5Dm3T2BN2y40=;
	h=From:To:CC:Subject:Date;
	b=neBjnd24P6RJko5TpR4GKsFhRUo4mP+ERg/Bd9BI141tBcsygW+xy6EwEle+KL5x+
	 MV9dmnmkqdZJt99ceRCwss2XdOyy/Zz2/TWE66YaH2aalTKD2s/mCTr3mjOKD51eeo
	 RAoelw089XMQsYc9sXD1gJfW1k0x8ZjyfckvYKJI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IE0FOk085324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Oct 2023 09:00:15 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 09:00:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 09:00:14 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IE09kg028716;
	Wed, 18 Oct 2023 09:00:10 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <nm@ti.com>, <rogerq@ti.com>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <r-gunasekaran@ti.com>, <srk@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the revision string for J721E
Date: Wed, 18 Oct 2023 19:30:09 +0530
Message-ID: <20231018140009.1725-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prior to the commit 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver
to accommodate different rev structs"), K3 SoC's revision was
interpreted as an incremental value or one-to-one mapping of the
JTAG_ID's variant field. Now that the revision mapping is fixed,
update the correct revision string for J721E in k3_mdio_socinfo,
so that MDIO errata i2329 is applied for J721E SR1.1.

Fixes: 07e651db2d78 ("soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 628c87dc1d28..998fe2717cf9 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -519,7 +519,7 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
 	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
 	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
 	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
-	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
+	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
 	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
 	{ /* sentinel */ },
 };

base-commit: 2dac75696c6da3c848daa118a729827541c89d33
-- 
2.17.1


