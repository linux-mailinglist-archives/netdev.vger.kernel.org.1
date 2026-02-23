Return-Path: <netdev+bounces-259933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHrrCKYEnGlG/AMAu9opvQ
	(envelope-from <netdev+bounces-259933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:41:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA3172C7D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C12300C58C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1B34AB19;
	Mon, 23 Feb 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WUOSFbGZ"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11025393B;
	Mon, 23 Feb 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832459; cv=fail; b=hf2vvhEtTKwWcHMDdUhozYwaP3t1HOnU2GRZRXjENMbD+9j9mAaCUvFRreRI+j1G1411tKP6ZhK1FMOOmuFmIEFUxLrHBY+z/7U4GU/Df1VztjKByW+3T8E+OOE+xGNaUsj45Oky5i87rkE+oNRQIevlKVbIPRIQ9aHYbjv1LW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832459; c=relaxed/simple;
	bh=UXowEZuTfIwW+erMbgGS1nt4oHCLyN8PHK8tWgb/SAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHSYmkIQgP1WMUVdwUaQrvSZuoxVipiyLIfrPJOKHe5n55gqar/58AIAewYDeUUZjanhAk6v5su/Th9ijLThxApOTBGu0IhZ8xJVuSNxrec+bYOga+1wcjmx9UWJ3WprqjVVnn1cYWL/O4XhyCe3H10DHxNbl+yo73CCvmHbdvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WUOSFbGZ; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZGcsjPsWx9MGQi7hJt7d6Enf3ncT7oKOffl2BoK3iw37Ab18r+C2gVDMhz04w3TeVSdJBcObQqw4CRGlmjOHYjWefEKrPcYtD1O52UXNXnTn8HY/FlBxeZBZ7YzqQtZGtLV99HBCYeBIhVRXuEourCkd0/nk90QGm9U7nGMRssd9W8PNNOEYJRATCL5YFzYN1ZmjYR13+ogAUk6LXrzOR2M9BRG3KhE5/Ig2NHAulvYaxCVbz3AhIbovORTCmLY5XzGipYi2tLDBCaPr2Q4k4eHUI6CVpWfhTAFqrcD8VqiuVYp1KKs8m3sfdxblKbZVS6QY+irWBOmFyNCxvLBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAZGuqeMNBNaFu0YtvrDDloum8q2wJewsHhtGnSaU0A=;
 b=Kgv3qW5/xVsQgo+l8a0BBl/tGKnImUr5m7xX+uvoW58+5/Uw1lOuTb+3MtIDim3pFSH15jjvV+ZiN3+xN9KBb3yC/HjKZOjNqAkDcQTEgYYhWyWC6BAo0gNW6hVRQrvnH6YDci5iGjGBUZfdUPasiZPxbcIn3LrAEVLaLu4aV+4nwamwO/oOd99WLeKuSNv9JQei5FjniNyRE8Zoal9IHvBg+5c/CNImDtvLHKV6W1FgnTjqM9apc8Zt737Ul2SGrShGJbLknN2JQGhV3QMSxFM7MyuxTWKV3rJKbw6r3CXa9hiheaeBnc0NW0MrCgPdEMQmNxF5J3mCgGuEnhlnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAZGuqeMNBNaFu0YtvrDDloum8q2wJewsHhtGnSaU0A=;
 b=WUOSFbGZD7wCKTWc6Ogk6vLiPbIzXxZq2pIOrQY3BrdDtUoqdFJ9dGO85ZCTPC41jJo2/Y+NP+w/lWUoU0QAJnj9ileGFMvHC0eLFvVgbz0d4aLCsLLhZuidVbKZTXx0TQk2n6ed5aJlVWigvyP6JfArqCy2DXhRD0kev6eR5ms=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 07:40:54 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::b3) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 07:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 07:40:53 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 01:40:50 -0600
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: <Raju.Rangoju@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>
Subject: [PATCH] MAINTAINERS: Update AMD XGBE driver maintainers
Date: Mon, 23 Feb 2026 13:10:20 +0530
Message-ID: <20260223074020.1987884-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 443a2fe4-aeb7-4dda-3cb4-08de72aedf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqO8eBQo87dwLKO13HfUxRcPbKzHHIxOEy/pMJ9mH+ZDZg35Un50St16p0sS?=
 =?us-ascii?Q?kTDQEMm0Y+XVzHudXPFz5uyHx9NtPQh+O7K1CE3yVMe7jUt56voq+vntU0Z9?=
 =?us-ascii?Q?tVQ+brhHsD/pjHZ6aOSXQ/UiM8JF12I5bY9CzCzkzQQqpyDsWPxQSW/P20nw?=
 =?us-ascii?Q?kwGZBxzZsAy3n/tzyENvvS034//lATobHSgdNfkfehBnxczM67njjSBS0x6j?=
 =?us-ascii?Q?/vbbv7R1laNk4q7KxwM1JJyHwt8rzfHLh6IbGOKYoLBCLEGNuxg2/h2k8JEi?=
 =?us-ascii?Q?Sp/G9pTgRfcGEuNDzaYtWdiSI+VxOuyJD47wVdDXR+AQGNP7q9Hseh1XnvQQ?=
 =?us-ascii?Q?Koed5XjH7i7rrXpmWee/V30kzjlt2w+9CfRJOvjbiL0ZFkrvFWZBXs7vkKwn?=
 =?us-ascii?Q?f6wcTa5AY4dihauWMkrXJ6+yOxzXbCKzSHe5OPHIHFO34TfUfwZ7stynHNjI?=
 =?us-ascii?Q?O3J30ET5Gge067sUJWm/3wlTYbqo4bgtdkbo09AUzQGa1Q/by/rRU1sHqg3B?=
 =?us-ascii?Q?mzo4zmR0Pgqgnc+e31dwu/y/8qoFIIAqnQNZPrxKnzkMglIL1fyZ0v+4GKXr?=
 =?us-ascii?Q?Y/N1czhFelqBPrX8tewsfosUln6kSQt2R0YgPyDHiLT6Fjxmvr/vR7HLNB3V?=
 =?us-ascii?Q?FWzvk+Y8j+JX4WQ/lj/soG05grLRItHLm7MTEhnhtf8fGdQ+A31ecFiqlds2?=
 =?us-ascii?Q?G2sOH+11AtWxLXThMSy+zfHGMtVfIFd8pQS2jWhBWFs8eXIm0m8I07dd4rAe?=
 =?us-ascii?Q?U1ruifGvKuTXCORrJsND/soAHPBfwovEMakk07eJxzBjwLqdJvKGAe8etIjp?=
 =?us-ascii?Q?GBAPg7KarWpYs4ObPDulvHrYGtLyhmRcK/9SyhK+Yxl5R4gveqGGKyRXN23b?=
 =?us-ascii?Q?Ab0zbDDhgn6jOlqG1yWcyDA+rsC44b8mIfJtfadfSQv+h4cKYpxbVZYcpStw?=
 =?us-ascii?Q?nRJWR1w0Vop3/KixPEFv/4uGlb39fDjW1I8iHKIAFm6LH0Tj+XDbYYhJlK00?=
 =?us-ascii?Q?45rUcr6x7KTraIrQUoymXtjL8JrP3BPyOLNy0t+/eqxOETMhm0Kb+yySzIbQ?=
 =?us-ascii?Q?v+YBvTzedKfz4zl6n2iLyyhYSMuZhcX340Xv2L7/XznqHzw4xVhg9Ur33tX1?=
 =?us-ascii?Q?bp0BYaAP2Ix8x8ZbUHoAXBrYWFxpAL5KwAJNFltD9Pl/SF1k+Oju0G+wdGJI?=
 =?us-ascii?Q?IcOk3xIdB2S4K4ORSjExN3kfb9HXIHPFgu6P+ye5kXL81htDg1QXH19vsbNk?=
 =?us-ascii?Q?BqLmv6BIPTLaNUySXikwa+poRstYv/TRFcnM+Xu9lB1Dr6G8bA/uxQkP2fUu?=
 =?us-ascii?Q?185k5IfpK4VOot5VI/Of19uXvQJWWtoEi7MhRkhSI/Kv4jzQ8hh7qg7RkBAh?=
 =?us-ascii?Q?iKAGZeOWlZegtp2ZN1wbcbpy+af1/DKUDLbK9rkpDe17WI012IAqcien69Qi?=
 =?us-ascii?Q?vMKnoQBG+8a7PfWdZKs4o7KazZUf9nUjxvXyw70BN1Y9zyWSoGX9NWV+E+GO?=
 =?us-ascii?Q?b651CNjxwMvAlMX6fMNA0oNQ7lkiWccsO5I0ilaEZvwlbep85i/7DdbUjeFK?=
 =?us-ascii?Q?1sVlEj2fAm9e1Re09p8TyvQesKbfaGsaFCpe3b+iFa42T/461PHrad+CwoXb?=
 =?us-ascii?Q?vfYOniq7ha4JE6vEAXUpO9NLS6xB+rhCiHNkjlc5uUTXBVD30q2P7MEZFJ4h?=
 =?us-ascii?Q?yuwQbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JaCzmTIHy71BMmaKOK4WQjEaWRbRLe0EkW5897eN98H6Abi50JZZzGXzHzDcSNKLsURJz+rl/jIACk12NbZQbsUP3VsylCKFPVKNJm+Rqzqi16YUwAs1SVySjyZDuHU0dNCCusGBWXIoOgzAdi1V45St1I8Ngmu4vKNE+Ql/0zt7kMpnagwrU/kd1FHLvcrsgx58J23E9nk/clkfuq09eY9yfo2fL99vODC8YD30k9BfQRW9vG7w5q73x8lGhcCYNyD4Y+mS2xTiXzMmYp4Spv1PStoDIqIG5VV9DJ1fKP4Q+RRuhoY98Q/glu3Jwc2xm+7tqSR2xzTzYBP7ASmuPEHDsAwplgJch0uGxxL+a4YXI1j408LKqBVnBCnlsSkswJuQld8+GabE700ryUugNafArVCZAYrSnIoqqsFqBKql809K4/1MfpJrm5OLfw3/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:40:53.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443a2fe4-aeb7-4dda-3cb4-08de72aedf72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259933-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Shyam-sundar.S-k@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86CA3172C7D
X-Rspamd-Action: no action

Due to additional responsibilities, Shyam Sundar S K will no longer be
supporting the AMD XGBE driver. Maintenance will be handled by
Raju Rangoju going forward.

Cc: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..ed72919e78ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1292,7 +1292,6 @@ F:	include/trace/events/amdxdna.h
 F:	include/uapi/drm/amdxdna_accel.h
 
 AMD XGBE DRIVER
-M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
 M:	Raju Rangoju <Raju.Rangoju@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.34.1


