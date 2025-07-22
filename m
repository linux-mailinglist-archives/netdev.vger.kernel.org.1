Return-Path: <netdev+bounces-209030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A271FB0E0D1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BBFAA7925
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086927AC28;
	Tue, 22 Jul 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rw8Tcn/F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296527A927;
	Tue, 22 Jul 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198900; cv=fail; b=D6QFM61JiwdbDDdRzv1hflfbg2U3XCaFSGvQznmvcbbKC0qswRc2jf0dIag2f33ANmDws1zYTUEsDCyaT8pvEB7zDLkfHOQ0PMvtnVyJ8b3RutZuZdMvLiym9apf5wFuz+3Jn6BopxK0FUN5cOKeu7R2AmA+nGNEsiiAafqo1L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198900; c=relaxed/simple;
	bh=s+CSXU45NltTngeq4Zvmdnp9chsn6lhr7AzA3CzOL/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGDn356sgv2GvfnFKB02K4jYEtdI1eFbQQG+B/JV2mV2E67Blcz/v3cOc63bB0DAe4RafwzEQAFyO14tUP3ub7dErYSeYSCtPs/NFfmG1WxKvZbRsY9qmK+qsgJAwX5oMx8ruJmwVUx+PmRSzzCGB6gV/tnQJzwBWOzNFYEyfck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rw8Tcn/F; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBSbJLHKiUlZMgUlKYWAbcDi2PAj7dMZs92C8qcgXbrf/E6SEbLxkoWnR0iZtfp8gzVDZgw42dIC1wOSmef3GoNssCvNdUfyCeDaSq2VdXB8F2pg70PkT5LDxKHDV1yyZojr+K45AEmyesCs+oZHfd3AdDwT+N/34nfJQ4xqSRkFvKNDJh6gK8vjPo5zacFCv7N35Ay6kE2iSq9KJEGrmC1caADKCTo96Q8dqg/u6TX6pXJ7zmoIeDKJKE6/AO2KA4nd1qZVf7XIHUAeWxopS/HOcuTDq43TmLcobxdqbePL9keX2fTaW3fzhEXdRd2UPxkNn3Zzd+vHiSYPyCRVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2cZp2NhQ6TiK6D3tuMxBU/t3aEmCHkDQ8HQqephZj0=;
 b=Fuwq4y9L9vKMU6jkmSIVIZarywgGQiSmxlg0xTK8uJqkFMYjfWuA6QfSuHAcDNAu/LR+Zqe7TJ8mq4tsVZnwWZhKMIHNn89A5wLpJrtjnqkmaVmCZ2q8qu427ZcABA9sF5niBQN8nHB+9EIVOM3nKbojTE0MpcRrHpn6OqgajfWS8I96NwVeRjtNfP0oV/r/xy9RRDyOqxPNu1uqC36ZSIKGvY2qEKct8/0frbQbuhZA2dRFyugX9blT3MOq0CSeCvijBWpPxVuW9YuJBbaRQlw+7/lO33DJaT1teX22rFniIvf063+owxKu2RZZ/I5cRX4Phqtd9hEdSGWxFYP+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2cZp2NhQ6TiK6D3tuMxBU/t3aEmCHkDQ8HQqephZj0=;
 b=rw8Tcn/FgAYOvOvePBygCKZctkwiBsMpzf7Fsr3G9mARHoKWk9BBGpPiNf3LGCAS1++EHVBYYNs+AjMVjUZRJDFkDzSV12CGUtKxW3WeKKEHO7m2ooqMGeh53jY9foj9MZ/34gWftsp//Mz6jv4zYeerNsXJ/Lx/xP1CWG/Q9I0=
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 15:41:34 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::30) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 15:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:31 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:28 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload command interface
Date: Tue, 22 Jul 2025 21:11:10 +0530
Message-ID: <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b2c5373-7fb2-4cca-0659-08ddc9363c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPfPx5GaDhdc6/QHRipvK1AXG55B8BIngz5GblfOOrH686H/BTo1s1THYKIi?=
 =?us-ascii?Q?IFTZ6AESrdC62V7BMVk3E2G46MLaBDVXz2zFnAKJHuGcZmyb8u8wg82p7tdZ?=
 =?us-ascii?Q?JnTyw/kPw3Z6v+NAZ+4GZVSxktlBSDgmQvgIj2V15AFZixV0YNwSoirFtUcf?=
 =?us-ascii?Q?3U5i7hhiUW3ZAoQemu/H/O8zI9F9cJesPq4BTRcu4QE9mXAUkasLMumAwIsT?=
 =?us-ascii?Q?dDM+TmHuOkVQ1/OXQPZ7sJhlIDI0+5woWHwbg4UENQu5bNfZL56F8KeCi1sb?=
 =?us-ascii?Q?SzQQwheaUjaWZAi4jBH1aM4BNPFQe3uePDfRe+LvKpF6HpeFLShfrcESptXf?=
 =?us-ascii?Q?lQrOQbKoiRWT41zv668TlSG8/zReDD/gAIvsgkvS45Da/hlBv4OnVjv2Uc4z?=
 =?us-ascii?Q?WtzWQyYZYm8QrvSi03kriEhgYbB2GNXjekt9b1cOF3WjZtq8ntQ8aaIaclTM?=
 =?us-ascii?Q?xTEcdT1CmUD4i5h8MftW5TWVX/lOoOclIcKZAzKTwF6y+w/cg0ZHCVw1E/aq?=
 =?us-ascii?Q?i2KD4Vh7Wv1bvZLasau5tuCQlZ4QEerwMj69EBcKTLzLpo7BvtJLy4to4FCf?=
 =?us-ascii?Q?AEa6vTo8wir6/rEMjiGJ68xey8dWj5bXxlvarsgKPFbKg18uJfnaSkWiPZp0?=
 =?us-ascii?Q?jdSsZWbRMSBx+nwqJmIoIbrenPOMIgJaX1B+InEGkKmQ837DZdhpE22xaXvC?=
 =?us-ascii?Q?xsuarVAGSAAOvvceTAuDggMGBreRGRkwYLWXKG+Z34yCLsYGECcTltvxZDRG?=
 =?us-ascii?Q?rnqlrY5dUPD1pYmI3K47dMmFZ63gxWNObaoQa+tCm3Ejgna4sefjT0zoKbXB?=
 =?us-ascii?Q?jCDZzDAfk0n1Hi5/L7jhkgLTqM5ffPV7txRbHxYVVK3XBWLNx1Gc7TJ9QYsV?=
 =?us-ascii?Q?0zX7F6bwqOMQ3mUCRKPkbL+v49nSQkIchUMHYdsjMK9utrH9GpjypgieDwos?=
 =?us-ascii?Q?wskEWOcOxxR43Q3fbvtkfB6rxDGHkJnaOyAjPZoODsqFVcm6rvjgOffc9oIH?=
 =?us-ascii?Q?i6tggN/ZyzNa3VIOoOCeublDBmjhxp+FePWsUCGJx41dckPmF/c3gFnC4qm+?=
 =?us-ascii?Q?a3E2+u5JNSzUAuKtXZssngKylPVhWo95xWGmMkGOWFeYG5IQUdyvY0uJEGKv?=
 =?us-ascii?Q?CspQ//eS/KNelpMz2xKSB9GPPR7Nn/7pXzCUbwDx0UN4TCMkila7pjsxYyt1?=
 =?us-ascii?Q?avpU/g2Nb51SFsV0+Ya2Y//O8VmYMPfIva3V/SHCBMj1rquWity7tinc9qjk?=
 =?us-ascii?Q?yfhjgffvMioUV+hJCwARhS4iuGU9jkHKTSBx8OFXGPO7O7BpkRiyJGX1vsa6?=
 =?us-ascii?Q?rP77fC4snDnjSvPFRYrM9tMFkREmoPqVnYUSTf7DiA46j5E3UEuE6EoQP6OE?=
 =?us-ascii?Q?fyWWQW7eayE0yZ4bvn0i+V/yjo1z3GLYjVS+sFA619rUczFLuhhF1WMdknge?=
 =?us-ascii?Q?aZtMHOBsEksKtzHwK2UeRbgJhBZOP8H58rHgLOtXgrtcnZ/xTlUtm9ewKdhQ?=
 =?us-ascii?Q?igimxRwjFNGRGaKje81LL8JJdfmNegKuOPdO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:33.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2c5373-7fb2-4cca-0659-08ddc9363c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

Add Traffic Control offload infrastructure with command routing for
TAPRIO qdisc operations:

- macb_setup_taprio(): TAPRIO command dispatcher
- macb_setup_tc(): TC_SETUP_QDISC_TAPRIO entry point
- Support for REPLACE/DESTROY command mapping

Provides standardized TC interface for time-gated scheduling control.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6b3eff28a842..cc33491930e3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4267,6 +4267,38 @@ static void macb_taprio_destroy(struct net_device *ndev)
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
+static int macb_setup_taprio(struct net_device *ndev,
+			     struct tc_taprio_qopt_offload *taprio)
+{
+	int err = 0;
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = macb_taprio_setup_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		macb_taprio_destroy(ndev);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
+{
+	if (!dev || !type_data)
+		return -EINVAL;
+
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return macb_setup_taprio(dev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
@@ -4284,6 +4316,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_features_check	= macb_features_check,
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
+	.ndo_setup_tc		= macb_setup_tc,
 };
 
 /* Configure peripheral capabilities according to device tree
-- 
2.34.1


