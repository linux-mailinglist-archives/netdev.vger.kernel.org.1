Return-Path: <netdev+bounces-42283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3274F7CE0BB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D39281C5B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982837CA5;
	Wed, 18 Oct 2023 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U2NBdHD3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779F3C1E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:07:43 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BE94;
	Wed, 18 Oct 2023 08:07:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IF7NeE087456;
	Wed, 18 Oct 2023 10:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697641643;
	bh=Xfb8xAPoeSQVAD4+8cJSBA5CbVXNlnkSmUPpryI54xI=;
	h=From:To:CC:Subject:Date;
	b=U2NBdHD38jXrWR6Y/XM2VFYzaq5CR4k/MWZajymYWsv01Nn/UMT0uUqsz9VMB2VX2
	 HBU8Ipjct3GNNmxP9uQqY+T8UagilE7ubTT82VFSSOa+Jt4T6aAmTxGTdOyAygz8+N
	 y5Gh9Q4cLsEKzA2lrLkAdcwZaoTJUsUOhZgg1Iq8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IF7N1G084046
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Oct 2023 10:07:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 10:07:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 10:07:23 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IF7N3C093689;
	Wed, 18 Oct 2023 10:07:23 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.31])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39IF7MEm011182;
	Wed, 18 Oct 2023 10:07:22 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Jacob
 Keller" <jacob.e.keller@intel.com>,
        Roger Quadros <rogerq@kernel.org>,
        "MD
 Danish Anwar" <danishanwar@ti.com>,
        Paolo Abeni <pabeni@redhat.com>, "Jakub
 Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
Subject: [PATCH net v3] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Date: Wed, 18 Oct 2023 20:37:15 +0530
Message-ID: <20231018150715.3085380-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

The bitmasks for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD r30 commands are
wrong in the driver.

Update the bitmasks of these commands to the correct ones as used by the
ICSSG firmware. These bitmasks are backwards compatible and work with
any ICSSG firmware version.

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>

Changes from v2 to v3:
*) Updated the commit message mentioning that the patch is infact backwards
   compatible after testing the patch with multiple firmwares. The patch works
   with both old and new ICSSG firmwares.
*) Rebased on latest net/main.

Changes from v1 to v2:
*) Added firmware version in commit message as asked by Ravi.
*) Mentioned in commit message that the patch is not backwards compatible
   as asked by Andrew.

v1: https://lore.kernel.org/all/20231013111758.213769-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20231016161525.1695795-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 933b84666574..b272361e378f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -379,9 +379,9 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 
 /* Bitmask for ICSSG r30 commands */
 static const struct icssg_r30_cmd emac_r32_bitmask[] = {
-	{{0xffff0004, 0xffff0100, 0xffff0100, EMAC_NONE}},	/* EMAC_PORT_DISABLE */
+	{{0xffff0004, 0xffff0100, 0xffff0004, EMAC_NONE}},	/* EMAC_PORT_DISABLE */
 	{{0xfffb0040, 0xfeff0200, 0xfeff0200, EMAC_NONE}},	/* EMAC_PORT_BLOCK */
-	{{0xffbb0000, 0xfcff0000, 0xdcff0000, EMAC_NONE}},	/* EMAC_PORT_FORWARD */
+	{{0xffbb0000, 0xfcff0000, 0xdcfb0000, EMAC_NONE}},	/* EMAC_PORT_FORWARD */
 	{{0xffbb0000, 0xfcff0000, 0xfcff2000, EMAC_NONE}},	/* EMAC_PORT_FORWARD_WO_LEARNING */
 	{{0xffff0001, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT ALL */
 	{{0xfffe0002, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT TAGGED */

base-commit: 2915240eddba96b37de4c7e9a3d0ac6f9548454b
-- 
2.34.1


