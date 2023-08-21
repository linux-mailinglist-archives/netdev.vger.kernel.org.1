Return-Path: <netdev+bounces-29400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F57782FE5
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99671280F38
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60636E574;
	Mon, 21 Aug 2023 18:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179D8F48
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 18:04:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625E114
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKeGJ77s9dFOZdmD0ON9+LREZeM3EF/CYNEHyqgUNw88ySXHA4aOPirYz8O4Cau8QrZWWfoiXVFP6p3Why3k2EBariqFf0O4E8PQbfFwP13MEKXUyh5Qs0vJdUQw1aqZ9iGggq18ytoZI2mU8wg1wTB1Ht6/9jsXZjkDI+9WzUUk/QaaDutDTgYHwygUzqA4aq1h7dEf/dUvZpp4lm2XW62fdGGvNFlSz8LaEkiICrVT6Ry+RUbk3QrL09PW1wSGw6Uq9yUlYB3PAh/5Byz3QbuYHbutSMU68RwfAb3SxxpWUk4e64kjG938/mqIQxo+OVHu8oEUf2DIX8u58Mj+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNbe5tlajVYCsUJWPMWUJ/C5M+bxku2TedsTdqPdcgc=;
 b=K3zxUBwkHZ9id9F/kw2xRo+BsfFXoePwKQUq0myiQyraTNgM32mrLrmr4VDewWd5CaJvCtnNhH500FX5SWt8YFgYWG6SMgOY8q0MED3lwi4P+RwOTIozcJZTTeuntrDiDPNfT5pf5Lszj2KTANLkSLP3QEv3sm+Z7e2gdNh8I61GiijAWGv02W1DUxAKG8iHOeZ+SD/HliYao+Gn2Gy8wEiycva1s21nNfR7MNkYJ6bKNwDL3IbrP926gsYC6Z47DPr/5AVgxsz2PGPKUIkSTMLXjBfo4VzBaBsGsPa73ZTE4rEKyCk0rwvv9q707SCIQ2IGdi283/wmjNvDlucTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNbe5tlajVYCsUJWPMWUJ/C5M+bxku2TedsTdqPdcgc=;
 b=vEGHyIx2qqwN1us8pXHqaspJxMvqqW4pGs8sHLxjMj29m2E0Qkt1uhkGSYvz+0DHmauESiEr0C9X9nCY4UKaoKRaEkrcEMbFcZrc0oOjFAB+DnUPu5MSJpMM9Uo2VNlnPiK/Drv+HZqG8pNbtj+r/wVWWZKAruPH9oqm2NzMfpg=
Received: from CY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:930:10::6)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:04:40 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::e1) by CY5PR16CA0017.outlook.office365.com
 (2603:10b6:930:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.23 via Frontend
 Transport; Mon, 21 Aug 2023 18:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 18:04:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 13:04:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 13:04:39 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 21 Aug 2023 13:04:38 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Andy Moreton <andy.moreton@amd.com>
Subject: [PATCH net] sfc: allocate a big enough SKB for loopback selftest packet
Date: Mon, 21 Aug 2023 19:01:53 +0100
Message-ID: <20230821180153.18652-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL1PR12MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: e81987cc-9c60-4b5c-d4b8-08dba27116ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IvCOthuz7E927+eWoZ1+sVtmSp9Hja4cQC7xXyAqIJmyH5MPZCrWqiK2kRaqceb2iRqUyrnKIJ9HszLX9l11lbEilENXWv1HHndagkaTXs9g2DRNgRI4cHbaotRB38+9zauyOnNEQBZ83M8ttpaKgOBc2itQ9m7YERyYX6oHNQnidT/GQwj00QDzRkMPxos7jVEwQpYF04xUnzIdSt8Vg4cSap78vcwlxGFsv5/zlKYjzy6TKt5TIFX7+DJWmq9y7oCpY3kuso3jL58t+KoozxdduMjYaiC7BUyXrBP3aBTqJH1UjmNfORYgtXaL/rc7sAaOKNndB62FvANp0L41Psk4LXjYbOMumHid6Bv2v3Jppp76XDW5Vhd3fgSmZdFI92TzDejFxVFjGVFKuBFVouGvdTd2CIpfCF9dopuW3DM1AeMam2QHd05LlFTDe/KLgqFQRtfxfuA1JSQAOI1saXP7pRx7rLyopXl7ZI+wJHUhsqbrZiQOrOaB4MEBKNPZQvTeIYT26BFjI7GXWVq8YA2TReCi2q7iNXpeYMh0sQhr5u3kW0MfHBAc7e8hCzIUNolHjb6TLH3r+ErXPg+uSC/tswsibo2DxUgmStu8xRutcFhwjPMBwK7BdgNoGUL7DVjXRDUpXgRPwhsXyzxqOhV7LHyPy7RjrfSPUaf5SaSoXBVE+ord2M545+tk5X6zc+6JjhxJjeh+qYaDntCJoxcCoZoxXCpJE39Vj8Ll6TDL/NmwfB+wqWwp2o5r2mamYSafihskza/hZ75oC+AYkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2876002)(2906002)(86362001)(47076005)(36860700001)(336012)(426003)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:04:40.1587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81987cc-9c60-4b5c-d4b8-08dba27116ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Cited commits passed a size to alloc_skb that was only big enough for
 the actual packet contents, but the following skb_put + memcpy writes
 the whole struct efx_loopback_payload including leading and trailing
 padding bytes (which are then stripped off with skb_pull/skb_trim).
This could cause an skb_over_panic, although in practice we get saved
 by kmalloc_size_roundup.
Pass the entire size we use, instead of the size of the final packet.

Reported-by: Andy Moreton <andy.moreton@amd.com>
Fixes: cf60ed469629 ("sfc: use padding to fix alignment in loopback test")
Fixes: 30c24dd87f3f ("sfc: siena: use padding to fix alignment in loopback test")
Fixes: 1186c6b31ee1 ("sfc: falcon: use padding to fix alignment in loopback test")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/selftest.c | 2 +-
 drivers/net/ethernet/sfc/selftest.c        | 2 +-
 drivers/net/ethernet/sfc/siena/selftest.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index cf1d67b6d86d..c3dc88e6c26c 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -428,7 +428,7 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(EF4_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
+		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 19a0b8584afb..563c1e317ce9 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -426,7 +426,7 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(EFX_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
+		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index b55fd3346972..526da43d4b61 100644
--- a/drivers/net/ethernet/sfc/siena/selftest.c
+++ b/drivers/net/ethernet/sfc/siena/selftest.c
@@ -426,7 +426,7 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(EFX_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
+		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;

