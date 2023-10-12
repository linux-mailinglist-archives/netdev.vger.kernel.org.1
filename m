Return-Path: <netdev+bounces-40238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0D7C65D7
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185282826CA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D48DDA4;
	Thu, 12 Oct 2023 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KgwEtSUt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A8D291
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:46:51 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2FE3;
	Wed, 11 Oct 2023 23:46:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C6kahW083440;
	Thu, 12 Oct 2023 01:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697093196;
	bh=Is7w++Rkxx1cII9J8DEgQ1/plc9LVUG7tLKet8JyB0A=;
	h=From:To:CC:Subject:Date;
	b=KgwEtSUtaGRUec0Sv7435q25RFuygqV7AyHVOpu5DJ75IhYztt3BP6nYh6tsDBVjD
	 6B3HBeTX95AkVFmI4pEUS2pMtnpQhrgAJoPyyrDohWrZlRKxjLRD43BXRc/Z9XCwli
	 SEdBrEvIcbQws2UVVxuaLnwTtAsTywMpy/4lxxQg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C6kaTL007495
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Oct 2023 01:46:36 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 01:46:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 01:46:36 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C6kaZx102705;
	Thu, 12 Oct 2023 01:46:36 -0500
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39C6kZcs015018;
	Thu, 12 Oct 2023 01:46:35 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David
 S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] net: ti: icssg-prueth: Fix tx_total_bytes count
Date: Thu, 12 Oct 2023 12:16:26 +0530
Message-ID: <20231012064626.977466-1-danishanwar@ti.com>
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

ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
to this the tx_bytes of ICSSG interface doesn't match the rx_bytes of the
link partner. There is no public errata available yet.

As a workaround to fix this, decrease tx_bytes by 8 bytes for every tx
frame.

Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>

Changes from v1 to v2:
*) Rebased on the latest net/main.
*) Changed stats name comparison to stats offset comparison as asked by
   Andrew.
*) Modified commit message as asked by Ravi.

v1: https://lore.kernel.org/all/20231011063700.1824093-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_stats.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index bb0b33927e3b..3dbadddd7e35 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -9,6 +9,9 @@
 #include "icssg_stats.h"
 #include <linux/regmap.h>
 
+#define ICSSG_TX_PACKET_OFFSET	0xA0
+#define ICSSG_TX_BYTE_OFFSET	0xEC
+
 static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
 				0xb18,	/* Slice 1 stats start */
 };
@@ -18,6 +21,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	u32 base = stats_base[slice];
+	u32 tx_pkt_cnt = 0;
 	u32 val;
 	int i;
 
@@ -29,7 +33,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 			     base + icssg_all_stats[i].offset,
 			     val);
 
+		if (icssg_all_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
+			tx_pkt_cnt = val;
+
 		emac->stats[i] += val;
+		if (icssg_all_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
+			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
 }

base-commit: 71c299c711d1f44f0bf04f1fea66baad565240f1 
-- 
2.34.1


