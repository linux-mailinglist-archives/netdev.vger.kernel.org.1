Return-Path: <netdev+bounces-31387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F378D599
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 13:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7121C20AD4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2075525D;
	Wed, 30 Aug 2023 11:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4F5385
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:37:56 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99473D2;
	Wed, 30 Aug 2023 04:37:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UBbiDi037424;
	Wed, 30 Aug 2023 06:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1693395464;
	bh=+IuvtcMd1sFlLqqC+3ASlwRUxQpLaQqflNX7KZMmrkA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uvAODyNuwHJW4n5M9Fn27pz/oY00RoFsEA0sEpPNVLJVloB7Yhe+yg5V7oK6G8j+c
	 IhaPzCVJSGA7vTxHqgL1kQhIOJmj+HIL6j9R+EIu0wLH9+NiM2QPCArzKd93zPsM9W
	 QGj2MmhXul2rxTtuP/Dl8/2zomrW4WFd1tvND1Aw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UBbiFV041851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Aug 2023 06:37:44 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:37:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:37:44 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UBbirI077275;
	Wed, 30 Aug 2023 06:37:44 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UBbhHY001546;
	Wed, 30 Aug 2023 06:37:44 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add AM64x icssg support
Date: Wed, 30 Aug 2023 17:07:24 +0530
Message-ID: <20230830113724.1228624-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830113724.1228624-1-danishanwar@ti.com>
References: <20230830113724.1228624-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add AM64x ICSSG support which is similar to am65x SR2.0, but required:
- all ring configured in exposed ring mode
- always fill both original and buffer fields in cppi5 desc

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3236af45aa4e..c2d1d0c7deb0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2676,8 +2676,13 @@ static const struct prueth_pdata am654_icssg_pdata = {
 	.switch_mode = 1,
 };
 
+static const struct prueth_pdata am64x_icssg_pdata = {
+	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+};
+
 static const struct of_device_id prueth_dt_match[] = {
 	{ .compatible = "ti,am654-icssg-prueth", .data = &am654_icssg_pdata },
+	{ .compatible = "ti,am642-icssg-prueth", .data = &am64x_icssg_pdata },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, prueth_dt_match);
-- 
2.34.1


