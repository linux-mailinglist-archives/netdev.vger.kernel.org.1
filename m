Return-Path: <netdev+bounces-147258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3C9D8C1F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486A2284F92
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF91B413C;
	Mon, 25 Nov 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQ2VJhk6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66D18E047
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558754; cv=fail; b=tZB6EknGv31LWNeTDHzQOeJqbEjeFGtMw4NuKWMezbDlqGGOOTkEUGOf2tgk5uNm0iP8cq0EWTldV9NVJ4kL7zjeP30VZ4qFqs/V1P2/G0LwcNkR1cuhutMyauu6Unwf8BuJOtW0umRltkPUkwWbs8prLMgKq3rm6l6t3+3W8CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558754; c=relaxed/simple;
	bh=37aixnSkfYsix3xQSwD5MgKhKHRu02jU6jxooITomI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezY10TU7uHL84d5riEPiGnFHzZCI9sQnvvsFUgIkHi710mU6JL1smjO3hGd2oBPvZcBFSSXv2Qi9FUaufCf+2aQIl3zwqJ/jaNgRMlLtT89a6wMy3WGWRweNM9JX70CVPOxkWIXAH6yIp9f6kZUqiGvwkUtrW8rC75F3a1Cp8jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQ2VJhk6; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSLzzodZecGe7SSY/0e7aljtxNpZohWPKcZ5+8Qf+R3eADbolr+Llb71qyLrtx/UnmfAXWtoV8Ikm48NayChmtf5y0xrKqtZ+oVL1Do6RqmxuB+pz5w1NdpN9p/uzqzWHW/ikccS5wwgcGlK6iM3kbL83qEvE9OBzvIJ/KluzNhIcfta0ZwF6y//uOdx4D2yVA8xYaVNEr4+F9o3efV/qM7TLI4Olnh4oJkwlvka8WJpFJR/Tm1LFqTCi/BqBp0ZcDMoOUW+Y0IS9eLo+MB2f1rHSwOLUM/f7VOcP0sHmNGgitsJKqmbqriTbT+xFnn7KTIFFdo0v1svOBjG+tW5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEGuKNi7cW0UiEdbKgCJ2VGF5g2yYh9k7kv2b+LtCgk=;
 b=if+nELvaSxhF0Ho9Nhh0kdymlXBnjrT196w6Fl6uuOHz3CJRAnoGE2iOQlOVnMZ0bEyyV9RsAJ4xpSE85r3dcaz+catbCiMWXmUEbPKDUCJjNcA3JRBx3jNTvmGDfsFmnaX9a8vKfdxPb9JQednS1GAxWPD+7wpmRAHj7af0iczOIdrEC2nTdOqDYsGluoQ/PpHoZNT9lKcjs8HmpGJvcXYxZd+S8rr7Ip3YFicsZtJ+5F0UpD4hW0ZpXZkbZ2o7BFNuukGj30SYE08CXeB5ze0PS7WdEhqdVDYH4v3QB8TW4+auxUS99pTl51CuL6b0z2iaKuqbn/6DKIUKGeTLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEGuKNi7cW0UiEdbKgCJ2VGF5g2yYh9k7kv2b+LtCgk=;
 b=RQ2VJhk6uaC6uMWvWAWcZl0v0YK3CRjvC5sI9IZ9PmwlRZsqNPJz4VSGbOLdQZkhBZ53efrAMNlFQhoZHi+G4idKJaVkTBolack+gsHpjLpU/NEc/USLZRURW1tNzqrLPNb5YI4Y5gfXfyAdvjhSElcxF9TYS26pAzCh6kmzq8w=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:19:10 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::2) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 18:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 18:19:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 12:19:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 12:19:08 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 25 Nov 2024 12:19:07 -0600
From: <edward.cree@amd.com>
To: <mkubecek@suse.cz>
CC: Edward Cree <edward.cree@amd.com>, <netdev@vger.kernel.org>,
	<dxu@dxuuu.xyz>, <gal@nvidia.com>, <kuba@kernel.org>
Subject: [PATCH ethtool] ethtool.8: document the addition semantics for ntuple RSS rules
Date: Mon, 25 Nov 2024 18:18:02 +0000
Message-ID: <20241125181802.8765-1-edward.cree@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: bdea3651-96b5-404a-9abb-08dd0d7da806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/jAwwhH70fsuXoZipvoazHySqHgw2EJk//dM6uijpB7DxrIfcAzfsKOj6Fl?=
 =?us-ascii?Q?NRbjNZSJxtexSDvHl4+8TgDOjnVsc/9pTPilPXqad1bga7Xgl1jc9d3x/BV/?=
 =?us-ascii?Q?JeD+ZrzFlmH/zXB+wi9vwYydUYI/rxPIRxS6xUVO5TENCmGib/Xjp/QNNB5L?=
 =?us-ascii?Q?v/VHKm9sLS+Q25/wn0AhVWL2L24kU39cjObnjWBb66arfYOECR19nxROBMsX?=
 =?us-ascii?Q?ER4lKwuTkZoI42beNbtogvFyUcLUM7un822JO396MX1tQC0e4IKqzAIsj97e?=
 =?us-ascii?Q?zIYWrdpu2UKdvTsYy+bcgFdbxIyHGiWl6rU0UUQ5pdJ+khGAldq+FCYCvhE2?=
 =?us-ascii?Q?VhYT30tdbhQMkclQP3H7HC/LVj1La8D47RehlpZfdwG/cykzC8ooIIDk2oWn?=
 =?us-ascii?Q?fL63EBeMYs7VvT2nR5jM5xUua9Zbgtc0cMbrRUGX6pHwIUjIPhFXAzLTbrUs?=
 =?us-ascii?Q?R3ew1atvkCY13JPzrHWsijQYHgHvFow8DzAfkvrtXIOdBcKpQg/gnMAbl8Kx?=
 =?us-ascii?Q?vWgNx6UYfp4vCmk2RIrIhnX2HDSBZD9dEnpOH2HQvsHvRRg5eNvlyiPP7vdq?=
 =?us-ascii?Q?SCVRvClLIj8F7XZe5BbQzBYx9f8BiSjGeN9mY6f0a+JFPmIkCy6LSAly4YRk?=
 =?us-ascii?Q?bboiI9efnqOmNjmMEpTBK6y78sRi69LDuAWvFy2dEKN6I1WmQUS58eIAToRi?=
 =?us-ascii?Q?RV27x9DEpqMy/Cry7iXVNsTtbSMApaTAa64fAfyjbAgOhBOMMF5bhmziOueJ?=
 =?us-ascii?Q?EO3zGprla2fR+ZXRXssX5JSfNvVfXpQEQWvlaWIZiYB7Rwkw9WVcdwmwGMQn?=
 =?us-ascii?Q?CuG3Il/vEdkp1iNRBTsauLqvtxcfaffz7I3hmCpJ8budPRS9/V9LbFXAmHOE?=
 =?us-ascii?Q?KdZg7neP6Tu5cgQM8cI5HG4kje/1pbHVZDyo/hFQ75W8G/JK35i6KR/9zBgc?=
 =?us-ascii?Q?HRJVdYoavXfFX9jx1LBVMNgG54ywFv72H5Nwbr0NouTduTWRDj9j7lU/HkRc?=
 =?us-ascii?Q?NjMcyYaSc97ZUhbP9O3PPP6n4ycHv3aZGDSyIQJIhwwJ7dOKkgyv7jUUGjod?=
 =?us-ascii?Q?RaxxfDpHsBnGjsEihUatrLRx3bYgMpIRu/nkY1JcV8VfsWmB2h8lspurXuVX?=
 =?us-ascii?Q?R9BamqIvQ6wzMUYcLm0yYjI+kJ6b2xSr1W7DWBKnXBW7YAJUd3z6sZV8mYNd?=
 =?us-ascii?Q?EHZ8iWcE0ZKJ3Rzk1hC+xLVkAfw6+UkNXW5TV238VO/s/8Gye3e+/3EMAxvX?=
 =?us-ascii?Q?ITDeUJJo20qUJNkLvvEq/qdooZ4+oHKldl+f7CkpeC+y4Sg3qZjOYyVkqk27?=
 =?us-ascii?Q?14UjRgvPR7+SZ1d2Al1UQcT0HXfkZLRA8RLnnLaAPETmhdbFDN9id5RoG74k?=
 =?us-ascii?Q?/1AIQSsTJBrB+nzcSK2n/QQNKwQCtBhAptUGmv1QExj6JlMyRggcCaXn7bv8?=
 =?us-ascii?Q?WXyNZxQ8ocNwxnJmmhHs/dpFxwBrAoev?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:19:09.5994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdea3651-96b5-404a-9abb-08dd0d7da806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313

From: Edward Cree <edward.cree@amd.com>

Signed-off-by: Edward Cree <edward.cree@amd.com>
---
 ethtool.8.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 60a598c0091d..9e272f7056a8 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1200,6 +1200,10 @@ Specifies the RSS context to spread packets over multiple queues; either
 for the default RSS context, or a value returned by
 .BI ethtool\ -X\  ... \ context
 .BR new .
+If combined with
+.BR action \ or\  queue ,
+the Rx queue specified will be added to the value read from the RSS indirection
+table to produce the actual Rx queue to deliver to.
 .TP
 .BI vf \ N
 Specifies the Virtual Function the filter applies to. Not compatible with action.

