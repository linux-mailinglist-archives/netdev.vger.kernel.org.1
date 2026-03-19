Return-Path: <netdev+bounces-269541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKr6OTQovGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:45:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9B2CF08E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C133334AE0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE43ED13F;
	Thu, 19 Mar 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1UuOnD1A"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E293E9F6B;
	Thu, 19 Mar 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938002; cv=fail; b=q0ouy1JBtue1BekogUevpi1DJFuuvmzmo68XElL0VrpLDbQybKHXOHldIRhtad0I/mNZ1i/FYhIunJDdOOV8KXPiVbAL2N/55d9GOrYU5Hfx97W9P94r6QqfoAf5tDGRtx8QPaZoZXLw46BGXzfhcpwORtpSX4GHjSDeUrFDhoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938002; c=relaxed/simple;
	bh=dRtoQtXwpC2m7Rdg2S8ad5/UdOITyz4mFV0NUbHcwEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rk7Sz86ERQAhh15PODX6lHyEDAVM2TdCpHGd7xY6nV69enRjJpNG1+smrPwtIRVH6k8/1KKVB6fqKDLvm3tC90TFrzhcjKjKcSvwSIrwpmj38p+7o6BcufUp+fTUro0zvGVZipCIyLCPsfHUse1Q4UGu7jxzPedNmAuSG15vRgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1UuOnD1A; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnFzMLSdGM9B4Q9bhuBFOzLbiTCbE/+F5wvkkcflLMAQ7lzFp2pngHT8eSbDVNvOf0WxNMVWp5KZsHlUbYMOdEvyqsgKTIe3p0qoi7ggpCc1IHaz+YVSgx0vASFEls8QBmodvzlhK3wjdOi8f16LGwUwGDCW6adYl7akXJUAiVExrMc+b7mpVd5RaWWJADZZ3ey05DBrMj5mSw4C+gxrMY7xZlusEU1OuRj7yaQoAikQmhhEyIfw9S3trAIwICnK2aehbCdmVv3N2qL6wnhTBBeaJic92ZvJkUxYRLo8VEVflBwhTFU15Ofy6l0HltPqhqv0ERfi5b/gm0InQgv8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73qJBIa8YLj1Ua5Hm5dlOYT5SIJlt9PlI9c6qhNUfHc=;
 b=ZG7AJzv9rsoFFUbL/8pa8DW4U4bH4YFEhQOHWeMkwvSSyrlCeyszdc9xT1YTjxca8/P51wMFI0VQTcyA5W4e3nKZve9rN5QcQjDSKvDIMGTMyUYk8Bi1ECDEMhmjbLwAI9o0RJ82yme65VztRN2rNmmf3nEYYadrYz4pxLADxzux3MR+HRntNWm4hC+yAUZPviTzQYEyv0e/qYX2Nxi7FHj1+cz33hwNARiSOLRN3ytX5NONyit4t3A5Gzeufc+Xxwvm0UHXN9sDYJVbilYhx0h0sUwpG/RWSL7dyTze1vDYelrab0eycdYDkXn9EzqKV3d8O2XG+yDkgmQLgpxBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73qJBIa8YLj1Ua5Hm5dlOYT5SIJlt9PlI9c6qhNUfHc=;
 b=1UuOnD1APwTMqTNtj2zGKo+VxcdRvaKsaKPhXHCO4NYkPMQeLVm7dOQTA/2oEVnP7v9CqYvkmLLd/zjqpmf94AzMgidjSNpbqWRafxooVCIUHvurC1LnEGMZbahENNCf3VWp2cw1zw977SrdTYORudDOEO8uJPS25wF6hEndAQA=
Received: from DS7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::15) by
 DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 16:33:13 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:8:259:cafe::cf) by DS7P220CA0083.outlook.office365.com
 (2603:10b6:8:259::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.20 via Frontend Transport; Thu,
 19 Mar 2026 16:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 16:33:13 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 11:33:09 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v3 net-next 0/3]  amd-xgbe: TX resilience improvements for link-down handling
Date: Thu, 19 Mar 2026 22:02:48 +0530
Message-ID: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: eb580da5-b115-4a14-7f76-08de85d53770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k2qURG1fwhp5sIooBDWbpcH4jct9p2CRkNilG0HbzKD4gJl6YbLw2Dp6lMw0RQX9t0xjBZ3O38yLtdF71gYb1LuoMhhUUaERwmEav16Bmqhdd+RK+MDsF8QNtj4K5IS/u7pN3DzFlnwTNRpAwP6oUFk7Hfk6DasOVQm53f9CiPerizQHaby3gEKhAkD9k13/zufm+0oDHyMnrvqIPIhBBhQhMU3xvmZJZWZzjUe/gjHq7LtO05WkYgknDjSFAcIlTH3UWRguUGXraZ8uUus/NPvyHw0z3nqMvhfcjbmgOfGSv1H+/QgfMFDGNQdrzay5bNuwjsh+V1q39bycepYhXPH7+hFOmjV768hGeJubVgpSrx3VDBYTe3CU1/nnRury/E3F2t5jzy+p2L24NZcuroLMPV9bDV6FWYF0QFf2aoEGWlIicToOvbmAFUdf/QMIOP1FyjDrDRfvLUHAYJ9r7BtQFH8yC+fff/RFjKt4nXxtnxSQC96liGRVJJt+uNHOB4aaI/UmRFJfExJlgkI/50zwui12cOfpZzOXgLq0VoPpN6lbdF5YkunwT7aUKPapNBbGPS20fEFem0AwEa1olp8vSQOm/7zhfI0mIXc6vUNPCsq/stITJZaOoOm2lVuwfmlweRiDGYRVOCuvbYTPL8v20ijQrENYXF0KQQQ/w/s+rdMOROmUnoNPQpB1xGasBImONEXMNqTjEjzZ7oQ2gwQ57Gk9/qp9qlKrNfdqD+RJCnFxICeUFnBTVT90j5OG74cncMWigtSHsliHjqls3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m6+/6idVtpEnvkLydFb60DNEjNu+tF3BSXM26FbymMHIntmClnS8gS+/65ilZEI/aQkoONL3rtDJWOO9Uoy4rGvvG8R7+Pc8TY3ZXEIUiVJCSuXRWKZMUD7bRnlaMDmAJ5qhXuifwVlbMFGr/o4JXGjJAjZhfjq8Tdicg9bHXc/n+f+NZXD/Y4FnR9kesBKbXk6dVP/KWOXNWJooqR2t25ayU728ouZHVmQfI5WsdFYwbM5HqkXuLNUJUFwQY5xqlfyJIdI09aC1kEfK1wVNL0waQixHJtCIXA3gW8CzZlKhEceaa65Teqs+AVYrfWUV63f6IdiTgPZnXSC5hMyrutJ88xwB8tQV2vMR93Jo9ZXKTf2Z1OHMqhqlXqwXeOIzZdd8GVJmUDKdk4Yc0+9c8WGUQGKEeePUm2oUoSsClL2zSDwIBHMwTKCaJVJnKF/x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:33:13.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb580da5-b115-4a14-7f76-08de85d53770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269541-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4FA9B2CF08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series enhances the AMD 10GbE driver's TX queue handling during
link-down events to improve resilience, prevent resource leaks, and
enable fast failover in link aggregation configurations.

The three patches form a complete link-down handling solution:

1. Patch 1: Fast detection (know quickly when link goes down)
2. Patch 2: Quick response (stop TX immediately, skip waits)
3. Patch 3: Clean recovery (reclaim abandoned resources)

Changes since v2:
 - remove the stale function xgbe_reset_tx_queues(), otherwise it would
   result in undefined symbol during linking.

Changes since v1:
 - The original patch is split into multiple patches, to better
   isolate each specific improvements.

Raju Rangoju (3):
  amd-xgbe: add adaptive link status polling
  amd-xgbe: optimize TX shutdown on link-down
  amd-xgbe: add TX descriptor cleanup for link-down

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  4 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 86 ++++++++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 67 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   | 18 +++++
 4 files changed, 158 insertions(+), 17 deletions(-)

-- 
2.34.1


