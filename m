Return-Path: <netdev+bounces-40670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0F7C843B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B142829BC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46313AC3;
	Fri, 13 Oct 2023 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mvdnQnFV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AD125AF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:18:21 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3891;
	Fri, 13 Oct 2023 04:18:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DBI52X086289;
	Fri, 13 Oct 2023 06:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1697195886;
	bh=mKykF8/ZfDw84jIxywVinD83yzu4QCQr9UkkPhGWAbw=;
	h=From:To:CC:Subject:Date;
	b=mvdnQnFVPtwwQAieobIzH97okaXazGG3QF8GkfcybXqkQf2DJILKtbHPOkso9miw8
	 wI/UJvgMRP/9dB/VRxNRwv7X42C4tdTNYLcFO0Nqkfi54qXhmuzhOnsyQnCjqO7AFc
	 q3eAkGSX5YXRYVKpwnXcI7Gbn+0D4WQl9afDannc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DBI5iU081350
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Oct 2023 06:18:05 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 06:18:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 06:18:05 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DBI5TA031023;
	Fri, 13 Oct 2023 06:18:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.31])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39DBI4fe020483;
	Fri, 13 Oct 2023 06:18:05 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman
	<horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Date: Fri, 13 Oct 2023 16:47:58 +0530
Message-ID: <20231013111758.213769-1-danishanwar@ti.com>
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

The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
in the latest ICSSG firmware.

The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
EMAC_PORT_FORWARD commands do not work.
Update r30 commands to use the same bitmask as used by the latest ICSSG
firmware.

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
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


