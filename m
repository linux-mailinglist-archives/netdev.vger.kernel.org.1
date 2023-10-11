Return-Path: <netdev+bounces-39881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54F7C4ABE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC1D281E99
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604C6AAB;
	Wed, 11 Oct 2023 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8naaFuY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCC179B9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:37:27 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092C9B;
	Tue, 10 Oct 2023 23:37:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B6bA1p113973;
	Wed, 11 Oct 2023 01:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697006230;
	bh=ibJxl3VqApgkwXcPcBAZdilAPVeZ+ZobbrYoKmgyyBU=;
	h=From:To:CC:Subject:Date;
	b=s8naaFuYdAU+pPhK26H3cr/k2QuGyMYXKafJA97M2iSkBzh/Lj368qfPhBRDFv/4V
	 JJVp2RQy2OoBBDdOcTVLgRUtP7CiWGw7XLpeAJhcUXJCSYeGH7dTmq5BzSModAnc0d
	 /W+PAT4Fsbm1FlCq9uhyvDa8cUDSgiW9YAgKYf/k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B6bAnf121517
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Oct 2023 01:37:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 01:37:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 01:37:10 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B6bAUS003485;
	Wed, 11 Oct 2023 01:37:10 -0500
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39B6b9tg008250;
	Wed, 11 Oct 2023 01:37:09 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David
 S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Date: Wed, 11 Oct 2023 12:07:00 +0530
Message-ID: <20231011063700.1824093-1-danishanwar@ti.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
to this the tx_total_bytes of one interface doesn't match the
rx_total_bytes of other interface when two ICSSG interfaces are
connected with each other. There is no public errata available yet.

As a workaround to fix this, decrease tx_total_bytes by 8 bytes for every
tx frame.

Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index bb0b33927e3b..dc12edcbac02 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -18,6 +18,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	u32 base = stats_base[slice];
+	u32 tx_pkt_cnt = 0;
 	u32 val;
 	int i;
 
@@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 			     base + icssg_all_stats[i].offset,
 			     val);
 
+		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
+			tx_pkt_cnt = val;
+
 		emac->stats[i] += val;
+		if (!strncmp(icssg_ethtool_stats[i].name, "tx_total_bytes", ETH_GSTRING_LEN))
+			emac->stats[i] -= tx_pkt_cnt * 8;
 	}
 }
 
-- 
2.34.1


