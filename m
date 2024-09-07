Return-Path: <netdev+bounces-126226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05FC9700DA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28D6B23BB2
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3873D1514DC;
	Sat,  7 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHPeth/+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D941547C7;
	Sat,  7 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697201; cv=fail; b=YI9R3zCLy3LpyUAxtKehwHqRQ3uyaswx6sBC1aFVM6aAsuMspoLbT3qLHymy/qUQNlcRg5LDl+51b7GgLP+4fH8675fo8EmUWfNS9TcAV7UNnbeby/BZJFT7DB1BF9KihwTX5Z5QSSyOr9KvKmR02pKAj6K6bZxHsVMaSt5bUJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697201; c=relaxed/simple;
	bh=7Y4TDB0tzf6bsoQf1W7vsNQxeQbqL1p+mNC0L1kQsRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn3Veju4gvy1RT4EnFTykQyGHwHibDwhKcsfkOJ+ewPhDh+iY+MXs8WchhCEGZF7/wDcVzbj3yklOr/NxCRE0myW0oVo4FCo2KyI0+YHnpEpDt7egxiuCeFlAR3dm3eMtcD+Ty+/23XNUJtqIzgfTq6Epx/ga1zCDl0WwScPAeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHPeth/+; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5MC4SFH+Q5r43Mc3RwGl29KkWI3k5xp8lXZF7gosDz57rmT5A+Wl53BnNyAP+MsWnJF60NxBVudGhCw7E8dJc2z3IGZSUChs8Bm5jzknJ82hBGYqYoK5SAnzIhw4su0XTcNbtTE3TpumZCRuY5eOR89v6GPnNXF16vMFMv0ZWmfHtEKTWxeEDn5xaiq2m4usZgdgOhi0wu9eTgc7I59BtIWp456fEuEm+7EJHyuk59PU0G4YlLBlZ+1GIN1MCmL7YAf6Q1JS+pnE9m0eTrt9gZMYFh+Vwps7uMKPoYDBW329ftJ/+97fUp/xEtHNlCAbbOnFk3t0IvnbyM0LTgILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NorrTxfK1Nl1nd3bc61TjZa005rlHGBdl7XNHAtcqp0=;
 b=aN51duMQ/lGipllvXIhcSwSTy7m+5PF++qJ4KmWNK8piv1CB34I7KDicNyABTUlwJzH5y04+aFwYcSe0Whi5W8R7nkJMwSOr70JU1symOHwpnRS4YgxCAlNXtkzE4fHR07c71rs6oAXRY9mgCui5jeVdCZ697fA+1qCxtsYkvXrLEU9brewhXXNguB5ZO0trgdy8lg9s9FCGTBWdREhmh3FEnwtTehilo49KmExiTERettsgxrx+Pu79Qk0ALZAiBrli9GlE5f4B2LW0/6fu4NIXPwJ2b5iVWpSy22D/4LnBg8onQQz8uManvelfunbw7ej+Iniyg+NaHVMIkxfrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NorrTxfK1Nl1nd3bc61TjZa005rlHGBdl7XNHAtcqp0=;
 b=NHPeth/+kuhq8lTVag0WTraYaaypsqx+b0sCnQ8yZtpYkfxQORI+LxH31Hdkyh9OEJjMokqrMoXiHjkdVNKzS+bq4UGJhkcF9fZ7UQpDwiKfQFhm9tfzkSBKQXr4ueTpsMsGXOLdzcFD8A6A0bpCyGtQOlg+edxEuUyQcuqe790=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Sat, 7 Sep
 2024 08:19:54 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::87) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:53 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:52 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 18/20] cxl: preclude device memory to be used for dax
Date: Sat, 7 Sep 2024 09:18:34 +0100
Message-ID: <20240907081836.5801-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 5040b25a-176f-4dc0-7121-08dccf15da48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8o+qP1i6dffclzSyI3XLgBQDQJq2d72/zQ6E5nwgXDodhi1RTf9hp0QHhC/?=
 =?us-ascii?Q?8FCIrDJSDwff7EHU8ZlOSMrW5/KmDtQ9zgyY9uug9EVIJ+frH6ru/JWw5GKs?=
 =?us-ascii?Q?BNwW+jmeEnUnYu5sU16wJd/4q0g4hiNu9uUZtledQSs/fkTWc36xamA16Uf8?=
 =?us-ascii?Q?gkhmwTd++4AMG5XpfgKeq7jxCm20NK1G48nkGUzWgeAWCndJiuDY4kAYxltV?=
 =?us-ascii?Q?lRqWdLUVeKrf8KQx9A8TL0p9nki6Xbd3wUeIYNWfehePEE1Cf6fU8LOxwMR5?=
 =?us-ascii?Q?t1Lw04sA1s82FFiSnLqdRqwpTeiTvME4tLJ4w5h38mJ8Hd7BjXyUQJebg6OI?=
 =?us-ascii?Q?0oQQKBgR6Vg1xzBBdRxZwiMio6hBtx16EEn4KWGgCeQkFb6T6Ubtc6RqNefn?=
 =?us-ascii?Q?tpWN5uF9KqWqrPWhBNNZ5WidCTjBKx9zzj6c56kn5FmWxFW0kzcGgPHyZrF+?=
 =?us-ascii?Q?KIzmQmMazJlIxe4qXn3zTK7KPilSXkqPM6k8kNi3LcV8NBQ3FngtimUuFTqF?=
 =?us-ascii?Q?tSgkcMZwyjbXPcjC7E0UoCeEJzhrSHNaJDuvgTq+IahFXT2AEZn0gZZB7syc?=
 =?us-ascii?Q?UQnZbOx14CoesoDgLh8FEYdfHbpKYIDqa4Uez8wIMolP/jfJMmTULtvU6DeT?=
 =?us-ascii?Q?6tGAfED96SpP2JG3KbbuGi85NHCuo3+QiaX3kp8FVhOqzZ434MQjqCFCzN1L?=
 =?us-ascii?Q?KtVCLfqYUVaCH4jjBGl9+mMzexffEVmx+3bb5+pvZ1KpUYTeaBftaY2WptJD?=
 =?us-ascii?Q?Yv0kIOdHUQ8S364KLlK2+VLun82UkXE1kMJnwyXyCeYW8VaCN+EkAmrCeib3?=
 =?us-ascii?Q?kTi1zQ8pLbUQn3IMWaecAGcRIJwhKWNKVQXfdSDHjwzl+DfMHIa5YnG/EkHz?=
 =?us-ascii?Q?kEHjIIuthecuf4J5ZD6v/JRQFeNTWUNIOdk5bMFeJZSrJAtFj4HLZfzUQkY/?=
 =?us-ascii?Q?HZMiM+6eS/uo10RM2ydHOyHzlh4kPXhnT4p5mr2hpy+WOsq0o+A4kSZDc7F9?=
 =?us-ascii?Q?/eLykKwKU3QD67xh6lDtDw7DFTaGaR+5RXqxaQTCBJQtO8408iiHYURNpeJ8?=
 =?us-ascii?Q?xJQjRvI86D5cbONOBC9//EGsqwDQxHy7xGqAM00H7Y2XRtTx5piI3ZC6uVaq?=
 =?us-ascii?Q?L2sYYAX6meUbe/h0V4IlO4dT4YU5KdqbAkQMH7M78apVYfP98G5FPC1ONOir?=
 =?us-ascii?Q?eynoXNDAsjnIfEopTttI4PVJSNtVv/cV0NHR5E5Ra1aQ0ysRrIZXv9hOMsdB?=
 =?us-ascii?Q?3sy9hpvgy9rD4cvIRc3OC8Mrei9Yls4oDA2wdgHia7/RG8r7pncfHsKlQgQj?=
 =?us-ascii?Q?Nu61MBY5z0IYXtAMXaUXwtn74eb8pP0gWu9zNv07in+nwMqTt2fy36h4zDfD?=
 =?us-ascii?Q?L1CNoXeRrx9Ge/Q0WcraDRb3psieJmMSRPOWNtHdPlfC+tqoXOM9CRSihdYc?=
 =?us-ascii?Q?n6FSGDzvMc1rIYycsomRVjtiv5bCzReZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:54.2117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5040b25a-176f-4dc0-7121-08dccf15da48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

From: Alejandro Lucero <alucerop@amd.com>

By definition a type2 cxl device will use the host managed memory for
specific functionality, therefore it should not be available to other
uses.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d8c29e28e60c..45b4891035a6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3699,6 +3699,9 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
-- 
2.17.1


