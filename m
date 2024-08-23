Return-Path: <netdev+bounces-121337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2595CC96
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A11282180
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43472185B7F;
	Fri, 23 Aug 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="T5W2lB/V"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86E185B6B;
	Fri, 23 Aug 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416978; cv=fail; b=GM+PLp0icjeElQSNUyjl25YO467JCnHpcF7iJ2UENSZQbksAD0GGXpEMKOtlAM9Z3M4m5+0ThHvMUVPerT31Ur8IqWVgd6MoSG5HxoBwndFyJpAGf7iDqYsTddCzGOphV3qN5PQ09SFSVXY7qJR8bItZD23jc/o1QPKnAiv8im4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416978; c=relaxed/simple;
	bh=Ot3kI2dUnQrpGtbw1siGoDr2XWEEhsyh9/hpujxM+J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYmHo+NzJtU0w6qFUY4yoWs78xCQGLZ8HACggmbWPZ5dYyQyExCW0NvBXovZBpRgI0WTVIV/ziAB6XPL1HUkUqqaFWi1695SALXSDB5qGiGOEbWf/uZc4gWjpM+DoMvRXK/GulZAgedZ7VmQJu6ChQqgxBnUXQ+KaNm/r0xzFjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=T5W2lB/V; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPBhzKjOT6AHaBF4g1M6VuVLzv+ImXE2bNGRo6vCPbAst5073rqyAPeJjblZi5NrXrv6kh0fklgfQDRtKerRZHW1xWe/2ydOYqUDvcB2i3+/cQ9JprTspxEIh8Q2XJBzkxkKRXDGOUH5FZJB+6dP3TkZtW6cc8rxXudxG+ziEJNXv20obOVdAtAdUaCCdzusxHLC59MC0X6Uo0el2FJTEe0XIAbcg8EbgCWZGUHoJsWcxUPZG8siJkmDpAccBNuCOUSDlZilZTbS6cy8yReHjSiypIt/tHEjainodzhAt+PKbztIGRvZaBbsRRatcVMxUfFBcoXsC8j1x94msagaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14/BF0fuOAMrL0uGmRceyzw1mBluSYeMnwnwEfwpaDA=;
 b=Hn7fbN1FlMz6eIIIA8ODS9//tXQkQGaQQa9JqWhpWMrRwrE1kzUlU8CNmbDGrGD8ud4sKoTF41Gaqe862t98mvtxhehzxpYKeXg/ikTbZdMbRo2j/XA1woZ0wmeFBA9htrkEsmwEfewcncV8q5slEseJDfVoIWYbFu8n9yLAqQILgODXdPI1rbLr2TG4HB+qQ+Dye/qfDPSwSDbTMksm4lkUqJP0kYcN4fZtifl2rehvvvWK3kcXlwmWq5wgHYAJc3QAH2tx990e4gVGtvlcpf0yhzWUfjKO1k8ViiI06ETbL8R5/aY2H0zJkGSUO7BMEQVbYAMyk3MpDhjUt+vGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14/BF0fuOAMrL0uGmRceyzw1mBluSYeMnwnwEfwpaDA=;
 b=T5W2lB/VOdkz2jBNPDI7ve4hJEAyEj3pfGqimsDnLLNRJLfvQsMumXNpMrsVL7vln4t+emzVlGhtcX7PedAXYDNvSc00AvQpnRi2AAPYuhaN7O/banOZVO+JQPIENMfa60QgQEjgVKC5r/hw/SOtpfgPDMhXo3r3P3BOZ46jHwY=
Received: from AM0PR02CA0131.eurprd02.prod.outlook.com (2603:10a6:20b:28c::28)
 by GV1PR06MB8402.eurprd06.prod.outlook.com (2603:10a6:150:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 12:42:52 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::d0) by AM0PR02CA0131.outlook.office365.com
 (2603:10a6:20b:28c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Fri, 23 Aug 2024 12:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 12:42:52 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 23 Aug 2024 14:42:52 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	customers.leicageo@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next 2/2] Bluetooth: btnxpuart: support multiple init baudrates
Date: Fri, 23 Aug 2024 14:42:39 +0200
Message-Id: <20240823124239.2263107-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
References: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Aug 2024 12:42:52.0523 (UTC) FILETIME=[F829BBB0:01DAF559]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|GV1PR06MB8402:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32830822-40ea-45b8-d765-08dcc3711ace
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpXij4mBUOon7cFLIIk6MUNjeFHCK5TZZKrgu7ECDb5zB60D5YyW2phMqcR6?=
 =?us-ascii?Q?qH2pfQyif740mNIZfj5Jbh48AfyGS/zqYq527TU2o8AIE1Mn6iHBr5kMUa8l?=
 =?us-ascii?Q?O+zDgQB5BpfDx3Wg0m07+e5Ujn26Auo9fkI7WzMeNZP3z6ecI4Lr9gZ7WW9u?=
 =?us-ascii?Q?dolNYZVuMH9fXja2QLuCYqZiqqSbMGYzc3PUIydRxKQ81Rai/3ItmsA16Kxp?=
 =?us-ascii?Q?EwszaWzr4PllJf7+BWR9x4yGXz8O7zyYsp7mzmDPEEW365W8AS+aOolN2bJF?=
 =?us-ascii?Q?5Ydjy+UMQTAOLEZPxS3uPMTkmOgzHckI/WOXleNDDaaZRAA3UGJex9v+v17A?=
 =?us-ascii?Q?ny4BaXbz3u27T/UQM65vbgPgByaE1UaupjNWUQBDuXxhyPJdLu+16g4xOW3I?=
 =?us-ascii?Q?ROKqzHPwlrPEJkBHxZU1UyonCAHAoUoqqsdP9RHXe/WssTuG9FaiCTeAjqnJ?=
 =?us-ascii?Q?FeEGkKW/2xMxuF2cI2XCoTD/aTDqqUqdfOSbd6m8XD/LErTI/HMLzWVZJ4sO?=
 =?us-ascii?Q?gwGQqQdAnpoEhZFlfzdLq2z+1C5iMQFF+B9ce7yA42lJq38k0Li4GdT9NwcG?=
 =?us-ascii?Q?A7eaalYx1lnIezXcTno+9Iv/v5iJL2p3ysX+qufeqDRLT1YfZwkzYftFsMT5?=
 =?us-ascii?Q?ZAhOfAFKa5NkTnH49C1l00TPNcZrCSijEGpmh3oPiOVVhcOIEF2h9Sqo1fQC?=
 =?us-ascii?Q?aMv5K0bjvinPdoO2GwyB2QgrtkNiCYrF+U7PacqrxNPrUZHcFkuMkPjVzMcp?=
 =?us-ascii?Q?xZP8bRaEGdBeoFndb+PE6yjs/FBdjGPMHqlIj3ZtpN//fq9UyulwZgzdTETD?=
 =?us-ascii?Q?6X4txHQ1k4liGe12bkHuNmPGmDevYwvbVxP85p+/19hbL/s/zordp5lmQMdU?=
 =?us-ascii?Q?0ml456vTHty7NiwcIT5pKYVqr8lJyAmHDA6tpzgeGeVsqif9l+WDWMghwGDx?=
 =?us-ascii?Q?u88a8b0dQgRxOUZ3a1FndrcFEXq+BPFpyKs/r+0e8+HP9mAkwUTaJhMuNvKd?=
 =?us-ascii?Q?bV4+qGzCX+836k5e9M6AwGjmq+hpKIhibdbmEhOOTvG59dVtl7OFmJhjm9/u?=
 =?us-ascii?Q?XdMVk7YIr4XGn9YDH9iPJNNxarC+Bql0oh3R4ZwqdF8etq3MbtQezxau1J9h?=
 =?us-ascii?Q?deeixzQOIu98ItHm3VvGLlEwT0+5y3uKABUQT45vJzIyHt449amE14LLnkqc?=
 =?us-ascii?Q?2M6lxIATP3D1X3LvaadXFrMWL6WBS+0Ft/Wqm6JF/kSIth+aeAU8Ztta6tQY?=
 =?us-ascii?Q?QsvHRaepREttivgqL8OblQ1+gyMgD45cAxEyBL7wtCzWWeSNfjPOCcdSss8H?=
 =?us-ascii?Q?u8YiWAhq1eSLsnwXHYqu3+L+CurrCnKxUq0n34Tu45dQelp+6Cwbe0dGMDjx?=
 =?us-ascii?Q?+PDM64jn5ngAVIkGlgPSS4iPfuJf5AR4OjPqGAvHBPJcf9FneZFC6jwRsuDL?=
 =?us-ascii?Q?gTpVcqR+YOoNsOrM9tC+aNmMxMRXnCbJ2snjin4D53rM1ajOX0R2qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:42:52.7312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32830822-40ea-45b8-d765-08dcc3711ace
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8402

We need to support simultaneously different versions of the same chip
that are using different baudrates (example: engineering and production
samples). This happens typically when OTP has been modified and new
primary baudrate is being used. As there's no other way to detect the
correct baudrate, we need the driver to go through the list of configured
baudrates and try each one out until it finds the matching one.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/bluetooth/btnxpuart.c | 45 ++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7c2030cec10e..2bfb0ab114f4 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -180,7 +180,8 @@ struct btnxpuart_dev {
 
 	u32 new_baudrate;
 	u32 current_baudrate;
-	u32 fw_init_baudrate;
+	u32 fw_primary_baudrate;
+	u32 fw_init_baudrate[8];
 	bool timeout_changed;
 	bool baudrate_changed;
 	bool helper_downloaded;
@@ -1159,7 +1160,7 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 static int nxp_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	int err = 0;
+	int i, err = 0;
 
 	if (nxp_check_boot_sign(nxpdev)) {
 		bt_dev_dbg(hdev, "Need FW Download.");
@@ -1171,12 +1172,20 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
-	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
-	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
+	for (i = 0; i < ARRAY_SIZE(nxpdev->fw_init_baudrate); i++) {
+		serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate[i]);
+		nxpdev->current_baudrate = nxpdev->fw_init_baudrate[i];
+
+		if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
+			nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+			err = nxp_set_baudrate_cmd(hdev, NULL);
+			if (err)
+				continue;
+		}
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
-		hci_cmd_sync_queue(hdev, nxp_set_baudrate_cmd, NULL, NULL);
+		nxpdev->fw_primary_baudrate = nxpdev->fw_init_baudrate[i];
+		bt_dev_dbg(hdev, "Using primary baudrate %d", nxpdev->fw_primary_baudrate);
+		break;
 	}
 
 	ps_init(hdev);
@@ -1454,6 +1463,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	struct property *prop;
+	const __be32 *cur;
+	u32 value;
+	int i = 0;
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1472,10 +1485,13 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	init_waitqueue_head(&nxpdev->fw_dnld_done_wait_q);
 	init_waitqueue_head(&nxpdev->check_boot_sign_wait_q);
 
-	device_property_read_u32(&nxpdev->serdev->dev, "fw-init-baudrate",
-				 &nxpdev->fw_init_baudrate);
-	if (!nxpdev->fw_init_baudrate)
-		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
+	nxpdev->fw_init_baudrate[0] = FW_INIT_BAUDRATE;
+	of_property_for_each_u32(dev_of_node(&nxpdev->serdev->dev),
+				 "fw-init-baudrate", prop, cur, value) {
+		nxpdev->fw_init_baudrate[i] = value;
+		if (++i == ARRAY_SIZE(nxpdev->fw_init_baudrate))
+			break;
+	}
 
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
@@ -1525,12 +1541,13 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
 	} else {
-		/* Restore FW baudrate to fw_init_baudrate if changed.
+		/* Restore FW baudrate to fw_primary_baudrate if changed.
 		 * This will ensure FW baudrate is in sync with
 		 * driver baudrate in case this driver is re-inserted.
 		 */
-		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
-			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
+		if (nxpdev->fw_primary_baudrate &&
+		    (nxpdev->current_baudrate != nxpdev->fw_primary_baudrate)) {
+			nxpdev->new_baudrate = nxpdev->fw_primary_baudrate;
 			nxp_set_baudrate_cmd(hdev, NULL);
 		}
 	}
-- 
2.34.1


