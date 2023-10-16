Return-Path: <netdev+bounces-41429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3A7CAEB3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914CD1C203E0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC72E645;
	Mon, 16 Oct 2023 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BuVTZJ3d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452128E24
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:16:01 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1736A2;
	Mon, 16 Oct 2023 09:15:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GGFXNq100868;
	Mon, 16 Oct 2023 11:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697472933;
	bh=KUI1YZQF+e2I5/EmK98OhOJUzMMaVq6d4VLQ6Wded+M=;
	h=From:To:CC:Subject:Date;
	b=BuVTZJ3dp2qphcvPflja5RVToUdp9+aspi5lJ54v6z5TqryecE/xbj+w3C7Z9ZLK/
	 9uX212paSd94qcTwDoZBzC4n4HQ8x6uJrAGi6LcQZcDgHAi13e23thRZm3d9LN2x26
	 JUsSPokA33yCa8f/E9ARByClQaJ49IUDq8jG9+6U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GGFXEO108192
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Oct 2023 11:15:33 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:15:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:15:33 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GGFXQ4121826;
	Mon, 16 Oct 2023 11:15:33 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.31])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39GGFWN1016754;
	Mon, 16 Oct 2023 11:15:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        MD
 Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Date: Mon, 16 Oct 2023 21:45:25 +0530
Message-ID: <20231016161525.1695795-1-danishanwar@ti.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
in the ICSSG firmware REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.

The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
EMAC_PORT_FORWARD commands doesn not work.
Update r30 commands to use the same bitmask as used by the ICSSG firmware
REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.

These bitmasks are not backwards compatible. This will work with
firmware version REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05 and above but
not with lower firmware versions.

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>

Changes from v1 to v2:
*) Added firmware version in commit message as asked by Ravi.
*) Mentioned in commit message that the patch is not backwards compatible
   as asked by Andrew.

v1: https://lore.kernel.org/all/20231013111758.213769-1-danishanwar@ti.com/

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
-- 
2.34.1


