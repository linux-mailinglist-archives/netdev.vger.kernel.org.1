Return-Path: <netdev+bounces-260511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKqPOyqenWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:48:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9D187310
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D8CC30508D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9039A81C;
	Tue, 24 Feb 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZHHGvuM"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3939A804;
	Tue, 24 Feb 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937294; cv=fail; b=PJZ+GwriAePfoYJK/nRnlVKFR7Tuc5s1VvStXdwYWQXAnyWoocgNNP4E8qSWlYGWeXyBFvCrWQ8kTDorTBZY7wKbfYb3jwBIjv5quZTGlpwX+ayvRP/ThiF7wrA6X1kcizOkUlsnaIxwCSfAo/NecHKzzTsDsXR5YIm8w2IkdE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937294; c=relaxed/simple;
	bh=T7Q/ZBh8CaTHH8+lreI3Uddyu0BuqY/5S2003LLa12Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxCEWdDqEySqSHSpglHZ14ieNur6vkNkdd4TnqX2qwpqx7jDba7xZy5HLbvnEwFJk2xP7Y6q3f3cm9ARs/dQH1ocP+SJyWiyFE9ia5qqj8pAwZWsSpIfpwVhz0QPOcpeoxA8zyza+3/I5R2JF62th5NP4eF3vJwKhI3CAeuxzzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HZHHGvuM; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO3GiT5cQ/zwJx0cIfEVwvqALE19mcyz/KLqCFHtzkglf3+LbVsHetL4z5NLeja8kIDLkSM7UtXHhWgouC1Pga4px6lgjnP2VP0kTII9IwgkPtPFvJUvxt/S96wc2xBzNkRP9lAXz7oe7JRxDoy27xq7xHloD/8Jw1qcd3dC2sWl32RCMczlIDegtBM4s+H2T/ewS65iZ/uGdq6M7m8QEC/tirtiHhewdvi3WYmYViNHE44p2RyOAAUb0CVgPuMWJ61Xk54Vm9zC2w6X+qXLuIyh7UymAhhnQbMSOimKNUCl/8tcnbncSAjnziDfyOD54bex74sFv3bMt3XwijYdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OxGsVc6Z8dwAusdytRWE+NA5RI83ZyU9ZRZYtQbnxc=;
 b=Xv6HeNjoErsNQZD6itGLy/oUB9oveWjV5Qg1uEUSZM+Gvzd3j+Wc4E50mtK1D70JA/K55cuHiU28EAc5HSjnXsAiIaaMLoJaHHPqs0xOUaXoEtbTRCmjOxHySi6OV71uMea+9e62I0v39QGIdlTKJpL8aUelRJjQenOcndQY+N1NAWwDkOFXMxzNLuXKjgsqIzlh52HSNCnP+WR/N8EWERuFPKpkKue2zbANp/N8lyj7aVgD8XIznrszyfmaXO7Nqzqdz1AOVTGaFRpcG2DnsdXM055JId7Vdnwt+h1/XYHqVWM6K6GbGamWq+txRjGXzLzlvvJ64vB+quxYLpIVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OxGsVc6Z8dwAusdytRWE+NA5RI83ZyU9ZRZYtQbnxc=;
 b=HZHHGvuMsl5oq73MY/QHSwaqm4j5j7+EXVYF//7MYPVyrfr9UyfLo86YBwKtzCutPRWY8UXb8gftXX4iD8QVmGfZAwHqMtJoafPJ1tgmAtwM4ZAVPmO13HdF23rR2te6P6cGp89vZn6f78UV0v9b5i0+d9uSIAGgiu8ItoiM2OM=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:48:10 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::60) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:48:10 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:10 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:48:10 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OCmA1V2746999;
	Tue, 24 Feb 2026 06:48:10 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61OCm8lw020530;
	Tue, 24 Feb 2026 06:48:09 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <horms@kernel.org>,
	<basharath@couthit.com>, <parvathi@couthit.com>, <afd@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v4 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Tue, 24 Feb 2026 18:18:02 +0530
Message-ID: <20260224124803.3634808-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224124803.3634808-1-m-malladi@ti.com>
References: <20260224124803.3634808-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH2PR10MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 68557b3f-f897-4c83-abbc-08de73a2f797
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oOKZJTqhAzpQRIbJS9sQzq+JCfoIb+HEqt0sKnO2ynl7pzIHOxvaGzBGvoVs?=
 =?us-ascii?Q?eNmg0GsQ4+4MtiP9/o29S2SRJtUGzhqaLPP5QEy1m8WrWwKJbJaFz19U61Cq?=
 =?us-ascii?Q?M1av1du/+06+HiYVRx8+nyEMGUmrVk+ZgFWo/GaDOo/EB6vfupdAofl7TOjW?=
 =?us-ascii?Q?gbytbwYfBB0hB5s+Yb/0VioEdAClKLpUfFT407iWvOG4Jcp9ZrOl3l/BhoQ5?=
 =?us-ascii?Q?i16akFPjux1DPURuc45cnKyUC6QExpoqhH9MWCR88WnrBz/+8WOwhcXUg5Y/?=
 =?us-ascii?Q?M2lQJC0peT5GR67ppz4vkQ4r//Q2pwNIBkSDrJ76kKqEIZmLJ+Vks/LnxtxK?=
 =?us-ascii?Q?/tgk3Y/TMvlKeAql2qyKTKLKe5/vqDSQfOrj0YvLxqAw91S2QICET57lcmVh?=
 =?us-ascii?Q?rcMF5ku9bmiAEAS6w3p7+Qkgm7tlwvdDj2YW/BeoFq8QfPZrZt4HFETLWsGY?=
 =?us-ascii?Q?mgREbzttvfTPw4o0+KiBlG8TWCjM6nhbGjzVWnWKjCM0Yj7SnkfcPirlkj2d?=
 =?us-ascii?Q?zyC6tEP1qPKIKz4vIz2UAwEx94e+ncE0wxhJ3y1w8PPSbXO7pnp/GebOxZ4R?=
 =?us-ascii?Q?+Bx8kyoWjnNzjSQtRUjvbvtHgLWvm8ia3u7Z4QS1fMCX1NnIU7GXcf7pOkdN?=
 =?us-ascii?Q?E4Mq5iYQpWKw5yGZzJtZqKnwkuKygooVYqpAM9iBZhNVcwRXuWxv+rmhfMsj?=
 =?us-ascii?Q?S3JoN0Cja8couFlPa7Fyebr2PmXwyq8kM9nLhgsxGWljgzpeEYrjU097BgEQ?=
 =?us-ascii?Q?nZHHGWwCfmaB0c26eed5E1rpQ+Yk3JXwP8xWVtoirGGQ0IvJh21b9F6TWDaK?=
 =?us-ascii?Q?l5NwcdCL6akf7w6gfNqy6IgOGCuuSI6265A9K127zRFhBdYsx7YE/YLo+tLp?=
 =?us-ascii?Q?ajdQKSzjnGdfPXaOeZWEWMtmFu1rrRlw+DglROMMSAzE6jtyUUa0SIlxXuiO?=
 =?us-ascii?Q?ZlkeY6pPdrskn2hJEVOMCE2km7NqVRhPmyrqKfG2VA4bIY62PJ3NZSIHkZp8?=
 =?us-ascii?Q?kJTqMc7cNX5842mLuBs95wVJnQN9P0Ok9PBpVQLPJlCdIq+KICjfxBxQaIip?=
 =?us-ascii?Q?f6SBlnB1sobeyWNDbY9l2y5QXMeKauuiC5Ijc0FU0azCot7kjVBkzhD99Ic+?=
 =?us-ascii?Q?fAoOWE4XP33un2w+jeflkNBVHkxs/xKhIZ6B8TBOCzemz3KFV1ocWd5tIRHS?=
 =?us-ascii?Q?aSc4oGX7ubfFCxuzs69IgEhP4hYaT+rkZ1hU1inQTYTuAXPXZVKjPxL35acP?=
 =?us-ascii?Q?Jh66aUeOWhtvkkkUjHTh0EOeYtlh+SDoOfiKpLKUJdlcDTkjqqHTgLOXWid6?=
 =?us-ascii?Q?u/GAVm1El353QSiUNU9MJmNRunIh3LBtvKNtqqO/+le3fkpgenfueRZeIwG8?=
 =?us-ascii?Q?f1/n+NyA2MVn5kY4io4L++HtV+qyENn6Lg/9TtpWEc+o+mmbJqj1wzIhWS8i?=
 =?us-ascii?Q?UHPeSii2I72wuXLatXXeKXODN/ihrXas8EzsgZstIFUTJWjY4aKEuHwS/kwk?=
 =?us-ascii?Q?qynixhGEf2KFjnvlJcEJqHMUkn6wt/RVZ4GqrEBsB41+Dw9y4CYEtDcVnlQp?=
 =?us-ascii?Q?7ETmT+M7xTGfwNgHxZUnW8DtjZwB/hxpTRdPD4wcJikpMwAzRTK/OqinrDdj?=
 =?us-ascii?Q?F676RoXkADEWAAPtjO1bi9E=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RTMZn1qtxAV7w6LYiJhprtqQGUERzeYoAO/jha6hx9X13qBA7JTk9IzXd/cBymlIhtiOiOfs7zNrwi2Ic+WazbNyTySgV2aNvOzHvtBqAwYCD96p91AnnyI8LYOod8dBCyBPA6hIBJ9G9sVBBBctnkfrK77KvnIr6NxC4NWULtZR2fhae7Z/h2VQcXZD3rQx7FjKBBbPXsx7aCDYSg8VPKHvyrP3UWCbVOKrCrqRk8DRArA7lGpb6EW5Yezm4FU6m861RhDKf7oTudHAfNyraJhhtEM123usiuQDk9xVKC/1xw2tZ8LakWD8ktjB3RfMikLjzjKZW87hzlvs+SZTld65SxyuwWV03bkJVqqErmF6GNuO8AYGigfU3A6ckiPuqDFYeUjHalPJqbJsvT43G+4qbBZo9vP6dkrUxMnBheCrOkIVt4fPUDqbVxxfWSG3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:48:10.7792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68557b3f-f897-4c83-abbc-08de73a2f797
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,intel.com,ti.com,kernel.org,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[21];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4EC9D187310
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

This patch introduces qos support for the icssg driver. This
includes adding support to configure mqprio qdisc and IET FPE.
By default all the queues are marked as express which can be
overwritten by the mqprio tc mask passed by tc qdisc.

icssg_config_ietfpe() work thread takes care of configuring
IET FPE in the firmware and triggering the verify state machine
based on the MAC Merge sublayer parameters set by the ethtool.
The firmware handles the cleanup after successful mac verification.
And in case the remote peer fails to respond to verify command
before the timeout (5secs), then FPE is disabled by firmware.

During link up/down, verify state machine gets triggered again
based on the state of fpe_enabled and fpe_active.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v4-v3:
- Cancel work_sync during interface down and module removal time as suggested
  by Paolo <pabeni@redhat.com>
- Added INIT_WORK() inside prueth_netdev_init() instead of emac_ndo_open() as
  flagged by AI-generated review.
- Add mutex protection to serialize FPE configuration access.

 drivers/net/ethernet/ti/Makefile             |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  10 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 223 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  60 +++++
 6 files changed, 296 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6da50f4b7c2e..6893baf47d46 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
-icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae..1ac202f855ed 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0939994c932f..fc44beda86a5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -374,9 +374,11 @@ static void emac_adjust_link(struct net_device *ndev)
 			spin_unlock_irqrestore(&emac->lock, flags);
 			icssg_config_set_speed(emac);
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+			icssg_qos_link_up(ndev);
 
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+			icssg_qos_link_down(ndev);
 		}
 	}
 
@@ -1024,6 +1026,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 	prueth_destroy_rxq(emac);
 
 	cancel_work_sync(&emac->rx_mode_work);
+	cancel_work_sync(&emac->qos.iet.fpe_config_task);
 
 	/* Destroying the queued work in ndo_stop() */
 	cancel_delayed_work_sync(&emac->stats_work);
@@ -1421,6 +1424,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1455,6 +1459,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
+	icssg_qos_init(ndev);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
@@ -2230,6 +2236,8 @@ static int prueth_probe(struct platform_device *pdev)
 		}
 		unregister_netdev(prueth->registered_netdevs[i]);
 		disable_work_sync(&prueth->emac[i]->rx_mode_work);
+		disable_work_sync(&prueth->emac[i]->qos.iet.fpe_config_task);
+		mutex_destroy(&prueth->emac[i]->qos.iet.fpe_lock);
 	}
 
 netdev_exit:
@@ -2290,6 +2298,8 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth->emac[i]->ndev->phydev = NULL;
 		unregister_netdev(prueth->registered_netdevs[i]);
 		disable_work_sync(&prueth->emac[i]->rx_mode_work);
+		disable_work_sync(&prueth->emac[i]->qos.iet.fpe_config_task);
+		mutex_destroy(&prueth->emac[i]->qos.iet.fpe_lock);
 	}
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 3d94fa5a7ac1..37de534e4d43 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -254,6 +255,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..388dfcea426b
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	int prempt_mask = 0, i;
+	u8 tc;
+
+	/* Configure the queues based on the preemptible tc map set by the user */
+	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
+		/* check if the tc is preemptive or not */
+		if (preemptible_tcs & BIT(tc)) {
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				/* Set all the queues in this tc as preemptive queues */
+				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask &= ~BIT(i);
+			}
+		} else {
+			/* Set all the queues in this tc as express queues */
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask |= BIT(i);
+			}
+		}
+		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+	}
+	writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+}
+
+static void icssg_config_ietfpe(struct work_struct *work)
+{
+	struct prueth_qos_iet *iet =
+		container_of(work, struct prueth_qos_iet, fpe_config_task);
+	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
+	bool enable = !!atomic_read(&iet->enable_fpe_config);
+	int ret;
+	u8 val;
+
+	if (!netif_running(iet->emac->ndev))
+		return;
+
+	mutex_lock(&iet->fpe_lock);
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(iet->emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+		goto unlock;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, iet->verify_status,
+					 (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED),
+					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
+		if (ret) {
+			iet->verify_status = ICSSG_IETFPE_STATE_FAILED;
+			netdev_err(iet->emac->ndev,
+				   "timeout for MAC Verify: status %x\n",
+				   iet->verify_status);
+			goto unlock;
+		}
+	} else if (enable) {
+		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(iet->emac->ndev,
+				   "F/w fails to activate IET/FPE\n");
+			goto unlock;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	netdev_info(iet->emac->ndev, "IET FPE %s successfully\n",
+		    str_enable_disable(iet->fpe_active));
+	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
+
+unlock:
+	mutex_unlock(&iet->fpe_lock);
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Init work queue for IET MAC verify process */
+	iet->emac = emac;
+	INIT_WORK(&iet->fpe_config_task, icssg_config_ietfpe);
+	mutex_init(&iet->fpe_lock);
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct prueth_qos_mqprio *p_mqprio;
+	u8 num_tc = mqprio->qopt.num_tc;
+	int tc, offset, count;
+
+	p_mqprio = &emac->qos.mqprio;
+
+	if (!num_tc) {
+		netdev_reset_tc(ndev);
+		p_mqprio->preemptible_tcs = 0;
+		goto reset_tcs;
+	}
+
+	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;
+	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+
+	for (tc = 0; tc < num_tc; tc++) {
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+reset_tcs:
+	mutex_lock(&emac->qos.iet.fpe_lock);
+	icssg_iet_set_preempt_mask(emac, p_mqprio->preemptible_tcs);
+	mutex_unlock(&emac->qos.iet.fpe_lock);
+
+	return 0;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+void icssg_qos_link_up(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Enable FPE if not active but fpe_enabled is true
+	 * and disable FPE if active but fpe_enabled is false
+	 */
+	if (!iet->fpe_active && iet->fpe_enabled) {
+		/* Schedule IET FPE enable */
+		atomic_set(&iet->enable_fpe_config, 1);
+	} else if (iet->fpe_active && !iet->fpe_enabled) {
+		/* Schedule IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+	} else {
+		return;
+	}
+	schedule_work(&iet->fpe_config_task);
+}
+
+void icssg_qos_link_down(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* disable FPE if active during link down */
+	if (iet->fpe_active) {
+		/* Schedule IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+		schedule_work(&iet->fpe_config_task);
+	}
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..653dbb57791d
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos_iet {
+	struct work_struct fpe_config_task;
+	struct prueth_emac *emac;
+	atomic_t enable_fpe_config;
+	/* Set when IET frame preemption is enabled via ethtool */
+	bool fpe_enabled;
+	/* Set when the IET MAC Verify state machine is enabled
+	 * via ethtool
+	 */
+	bool mac_verify_configure;
+	/* Min TX fragment size, set via ethtool */
+	u32 tx_min_frag_size;
+	/* wait time between verification attempts in ms (according to clause
+	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
+	 */
+	u32 verify_time_ms;
+	/* Set if IET FPE is active */
+	bool fpe_active;
+	/* State of verification state machine */
+	enum icssg_ietfpe_verify_states verify_status;
+	/* Mutex to serialize FPE configuration access */
+	struct mutex fpe_lock;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_up(struct net_device *ndev);
+void icssg_qos_link_down(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


