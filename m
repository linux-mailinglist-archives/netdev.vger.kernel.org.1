Return-Path: <netdev+bounces-181452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA19A85089
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B280468196
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75001EB39;
	Fri, 11 Apr 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="szDzqHiR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23913FEE;
	Fri, 11 Apr 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331554; cv=fail; b=OLPPygQXEbjvAeKFJZNRLcJbRWvENN1J7RIydyBkfSLWUDNb5dXxqraCsXykM4AJV4b6Ue4BwDFBb8PCtFrKMeqhAumm97HVon7BJ43rwctYt+hZYAcSGsr3CbZ48O6L93TYHmVOdyc8UO00Nt+Ym/ODNx47vD5HKGlNJJtKVU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331554; c=relaxed/simple;
	bh=IuFk6orzQywZnDOrX+t0oDg8BjG2iIFP6ooBWLNoLcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTMRNLA41wbv4okL5V9Ld5/u2rAUPgWT8ipPRCjZlmbi12Ee1nvtV4u7IDJT1FqT4B8sFv6/xBFZpZK/TmMGv4+OH8UzvECzJA2zVaFnhoeEhl1P6W4AjE3lLYM+2x0vQz0jU6458jaC91WovGbJrgLeaotXN5Rda0N6tbuCzj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=szDzqHiR; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy2HM3P/FjG9YlUmQormy2NJy+tBqIaSrnBShdOqjoUKzU8GTwZM1rlEWbU+IVvKYZ5m/CqAzMQqJ0PAfXEEzT61EnzEQfjkGQq8KrHypkrEVlcqWTEkNU5NmAaGn/dLvFjwE91/rFGoPzYFD1MzwWWDQBm82vFYCRvwKKT+30/BsxEg9GQ5bSVLWXSVj1XJeAJIEo2LZqrxFoNxbKFyc5LP69RhYeH8gEhncB6A1pwke/G05A7L5+XQmNC0/ps+kaGTZVAe9Qxx9CjOFt3KTfo6+vuRVBFq07Nk3Ba0egVs2vK+AU1/P/lkN6rxebpZHdxb6NuQeOpeY8my0pnB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NETXusa+r6pk8sysJOzMu8s+VrKfQSZCzGPQqAO0X6A=;
 b=N/PhEOkfSlDUCwnkS3BtuYsVTG3pjWSHApb4Cd/q/Oc2Em6LrTPdm6UBHOVM60KBwcSiLHldNHFcHw6awNW/2HIzQAyXg/e9IAxM+ix+rjZRM2tOz2V9G266n59iX+4Ld5CGnH8THohzKktrgt/KzyAKHziQBkzydYzGBBFcb5HGss84DGi7+qwKOBz7vfBzFPOLTnHS0a18bzWMzRBOVmShPEtbae3MQxtldoVJ8dkUNmLksXj3aRX6B4OgaK9lG1lpZ5bLynYIFkeZ5DGc4ezt52/1SC19x6Bv6k7TqU1IttJmROb69kmvdyc6lgF7OajKeg8cvkUmJh8C/BD1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NETXusa+r6pk8sysJOzMu8s+VrKfQSZCzGPQqAO0X6A=;
 b=szDzqHiRydhlWdjZejZbxhoUJZxlWg/YMtHG595idMy3dHupjSceVs5M4lntuxVW7rmMlRYyzJ7iZSxq/WRbkqbaEbRrKXr+fhm28KzIyrWtk1XuwNDzicq8iW4/QZ+izNUjXe/eo4JrzUb9mi4pBbYhtbHMjilQYmCHtr+347c=
Received: from CH2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:610:5b::29)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 00:32:31 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::38) by CH2PR07CA0055.outlook.office365.com
 (2603:10b6:610:5b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 00:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 00:32:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 3/5] pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
Date: Thu, 10 Apr 2025 17:32:07 -0700
Message-ID: <20250411003209.44053-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411003209.44053-1-shannon.nelson@amd.com>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f8f684-703b-4184-23e8-08dd7890586e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rq9Gwng5bTCLjNhHAF57dMYLFGECNaU7LKOM2UKL/3eUPqXyxu76ez68qNjj?=
 =?us-ascii?Q?M+PKxxD7Bwfv/mK/NsfRlfDHivHcCaI6+5rtxR5TA3oBZUmIy5BAK3b1M2b8?=
 =?us-ascii?Q?Jw7O4xHP5AdPB9Zqx09q8dC65O9W/tCvq8q1cB9UYt4PV6XkRxag7iWzCS2w?=
 =?us-ascii?Q?jMz7t4Y4v+u3DN6ZKa+5u/0a8MUJTuz/aHLwywqIY12DYV7CgNhRtjZZQxEV?=
 =?us-ascii?Q?0t/wQ83ljD0Oh5hyTHVrxTwX9gVXVHr6thf+tWYAY00zQZ/XNMQnP+iRjQOv?=
 =?us-ascii?Q?O8lJSkc75WSNQst8hi49W5fB9a6dQq/hfTnpQ2anlS2ulJ3ZVXnoll9eiRJf?=
 =?us-ascii?Q?ZB17TBze77pG86l31y6+pprn/mcmIZb+p5eerIYeYS0sFA1ZTCMUZjujxxJF?=
 =?us-ascii?Q?r5YAh8zNYvdSD1ZFQBZkP+Lo9HJKDz2UvpPYE/cYYQrkmDKv4ISCwT8FaQei?=
 =?us-ascii?Q?ISqBQ8fflCiD/M6AqzE0hzARKz+CN5IGvW0OZeexKhiIGvPtFLCLjFDO+fOU?=
 =?us-ascii?Q?umZfb0UX6LQarorwgxbuqDdJtd5aIXlL5A+gsTctlEPylSl75FxmBvCOI9N3?=
 =?us-ascii?Q?Qp/R8SEwditK0bR7XbomHBjs3kgRsp0yY4N3OdfHL9VsN36yZBLxKIBpo3Pc?=
 =?us-ascii?Q?/IPqbEhqHumxYwUqsysYv0wAP46zNRzw7Ha/BWv6KfWegU/QsO/6P61O4TR+?=
 =?us-ascii?Q?6IJjphPD4+ao5WEbNNtDs01viLID0BcAUYlZOH/p8wZBiOE+hAj5yaMaUGbp?=
 =?us-ascii?Q?AKCxx2cBoqS2T2rr/38i2/BOLQnF2iJe3l2eJ8dzTL7mZJU+6cj6KOi5a8RA?=
 =?us-ascii?Q?yWNjWrqsLomRz0HvA2FS4xWIFSfwVBxv55LzPMqkUQB6reDLPKSJWNYICCKO?=
 =?us-ascii?Q?WDiCgaL9N7yHg6X2SOwnqa5TGrIp5x/zbk4XaxZviQJ+0ziHxyS/E8BvA8md?=
 =?us-ascii?Q?hH8sGgU+vfsGeBCpAehQF6gLmYcNzcSSWj//6gpLdyjcRMyr6dP3FpN8x5OH?=
 =?us-ascii?Q?AUPJvT9lNE+talEir3cbtcgTiWIRBLYBkr4R8fAJFUou2gKkmCt5CS9T0aFb?=
 =?us-ascii?Q?4mX3NE29IxWDIKmLcYamW+KD8TUkFUERpBUckCIbD7XHDgmjMLU64cU0k8sN?=
 =?us-ascii?Q?evrPqOsMy3Hy4/yjOx3XDu4uhY1aqEJwl0Yuf8RhdvgGsNfpTNqwiqhWcuwQ?=
 =?us-ascii?Q?nXAtypsNus4zLhyNW7YII3AxZjkRiYGa556kMRxoXuEJgUZex58Wx8LoRiQP?=
 =?us-ascii?Q?wgVUbpllpt2FFg6vt+0zdDPUuXujRlt2hhkYFRkYc78Wixblq/eq1egN9Yw9?=
 =?us-ascii?Q?XiXc2JVVrStiGYkhf/xDdvssR54gSdul76gByPFDfthagpb+65YGD7zr0KXF?=
 =?us-ascii?Q?Dajo+Iv7ARiZ5J8BQJ2MAtxGKokXOBzJ2SfRvJ4hoI7aqt2O5C2ie/BUXNpC?=
 =?us-ascii?Q?QfNZBK0Z4M6E9n7Jf3b/RiFtSwOeJguvExfwS5pH+yr3sD5EloXZpR9TQRUW?=
 =?us-ascii?Q?jrX5W5E4SiuTEwM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:30.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f8f684-703b-4184-23e8-08dd7890586e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8

From: Brett Creeley <brett.creeley@amd.com>

If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
the driver might at the least print garbage and at the worst
crash when the user runs the "devlink dev info" devlink command.

This happens because the stack variable fw_list is not 0
initialized which results in fw_list.num_fw_slots being a
garbage value from the stack.  Then the driver tries to access
fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
of the array.

Fix this by initializing the fw_list and by not failing
completely if the devcmd fails because other useful information
is printed via devlink dev info even if the devcmd fails.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index c5c787df61a4..d8dc39da4161 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -105,7 +105,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
 		.fw_control.oper = PDS_CORE_FW_GET_LIST,
 	};
-	struct pds_core_fw_list_info fw_list;
+	struct pds_core_fw_list_info fw_list = {};
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
 	char buf[32];
@@ -118,8 +118,6 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (!err)
 		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
-	if (err && err != -EIO)
-		return err;
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
-- 
2.17.1


