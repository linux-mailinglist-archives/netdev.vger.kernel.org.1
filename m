Return-Path: <netdev+bounces-255622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id quaEAlh3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40851C6578
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9FC30053FF
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14F23DEB6;
	Sun,  1 Feb 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O50t8NyA"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418A223DC9;
	Sun,  1 Feb 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961296; cv=fail; b=f1Dvm8bvD33xhWmnxc4usXx45lsLlJq3nHIlpiPHGm7mga1i9r8I0Vqj5aHFvXL9Qam4fPkQzf7aFRnKXjLDSIOvF6Z5l0inVBDmE5U3CfcXnu9gHScIKuW+PUY38+sjVcQrVEDkMUVDDffzglN2F8n5AskQ2t4aChxg9c1PXeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961296; c=relaxed/simple;
	bh=f16ezKmN/5k63RjgduZQ1yTNWQ0O2q2Nbki/5fZ+WRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTCH4sk11r4+ZiRZXysqpZJ7TxCFzaxRe4yM0mSmzE0llpJrpQdgEAtlUH2Jok+YTweCVRpSzzE+8+Avi2kGQhGfHtIjRoEu89yG68E6GPCVZ9Pleaq913WGf/2CrwdhoVInixn+UNzz1qfqnGoxKGw4H5FzNzqN92SunlkVles=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O50t8NyA; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu7vpzxmamSWX3z/bjZEy5fnS8/6MJziKUG5kDuwaIJjGmJ/Eg4lkSEug69iY3erZx0OYEejgUU7vZPqZd4TtR5zs1petAIDjVBXbPzJccbUOamqwlaClGYOBlfvWIN/IaEyo+ucKwlXUX9E4rBYPSUDhhCiqbqpt75GkF/qNTBVAmAv6cpJ4/BOvYGb34hVZdXYq6VWUZeUhBvrlBRMmN/VSiGxIebAoIvhqa7CrdgIXUzEsb65U/7U6v1WUcgNgZENbK/erhYyEOrA4YiN7iFG3l+UiLNg9GcHpCVe3UNzooFhD18Pr9QH/i6slqvWnVwLSm87XPx0ATP8px+chQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=YJnhitmGpLbCa74ctxrfVCYJwkIL4PiaSeXNgzUFgYbuu3lZOAB7VVsEpLZK8h3x3oNOkLSF+zR30D9pZehkAY6+7yaiM7W4Ld1yHZF+amBWpVAzjcKAL8dVhcaAmEux4dECdbHeDVVZLMzqPrqmat8rvmvDgQ31TAFvNZC4p494N/nsV32jM9FgIeEjLM1al2xe3BiFBZoOqtCeNVoPBU9v8LNp9EvLxlV526hL9FhOIBKXgHhqYcCHbOwl9WXmZgP76FXeQdlMSdYd0RD1HJtLXOldYBpwzHHWiIZcsC3D1jZVOfZIYP1ozAjXrvPn87V2sS1W4ObOtLvY6JfrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xll8yKNcCnxzZs3ub6B5uXOUT6JYwtJzXxKt957pqo=;
 b=O50t8NyA7cKhO5CkjAAV1jbbk6ElzCfkG2RCS9hGCF5e8+zaRSMYdzp8EJMHXUJinowcondr9fmA8WBzNOKl51Q755OwO2+hgV3yQumlXqB9nIEPja5D7R3aXUb9FTW0czgEK3AVduvp9/piFWXp2eF+aLsLmd8dX0t2whmKZgY=
Received: from PH7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:510:339::18)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:54:51 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::d) by PH7PR03CA0028.outlook.office365.com
 (2603:10b6:510:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Sun,
 1 Feb 2026 15:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Feb
 2026 09:54:50 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:49 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v23 02/22] sfc: add cxl support
Date: Sun, 1 Feb 2026 15:54:18 +0000
Message-ID: <20260201155438.2664640-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: acc8ea26-b298-4541-d8d4-08de61aa3bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V4gn7FEKebBZq7pAx+FXcRg/4OEa6sw2tYJr7/bvXo8f0IdLH6ljt1iMKK8y?=
 =?us-ascii?Q?sViOPebQySDEhcTE5HKUMYGFd1rweBYwyxHYHQBtSp0XBEDs7n7OYCETw3Tw?=
 =?us-ascii?Q?jOxAF0yvYqBGP3K0EAXHBbniYYdXnjO8KdCM8TMncYnQaQAFK6KIXa66yc3m?=
 =?us-ascii?Q?SO5H16dlgws7jeyoXL65yXtI08lSiwIY3fL4lFhtEkhuhCKZTZ6mQs3EHshg?=
 =?us-ascii?Q?5USB0x62I0Wst/+9iMu+QwDmfyEO6hAZ0ollfXd69Nd5X2k+W+zoe5pap3R1?=
 =?us-ascii?Q?MgVR67ZfTxkrnDMaNAP3NMAbOGGWMKe8/pj6afJHCyKtwU7I97ztBCcMxP/N?=
 =?us-ascii?Q?saKmRutz85z6iazHHPsj5vrPIyPLw8pEWnQZq5Y7tBKFabwb84G5TAsf0PGF?=
 =?us-ascii?Q?Y0RK5DdhYrfpi8UJgzyYZGFAc5Wfqio3cNrEOVw9nAUgN25aEBm0MeFxRQVr?=
 =?us-ascii?Q?nJmBrTFujUAZZO9hiDr7L3RpycotMyB5Rx67LMR5YowQ82RY8MM+8MhUjTag?=
 =?us-ascii?Q?fUetNiaVOrA2G4TGsESdoc7ckLNnCu6//Y1vbSecs5gcBEa8yzkqJu1nFmva?=
 =?us-ascii?Q?eCTYyUhj7cqWeB0P4s2tc7wDP4ihRxxZl2OpQvZUfwOSOuVhI7NfEfHjClWH?=
 =?us-ascii?Q?+8T0v0fmhjhAv/gfZA0HZYChGFwXmyjTbT+g4NtClN8aPEnRHHyej6ejWTWz?=
 =?us-ascii?Q?y7Fq6f27K5XhkLmnyLAJnzdqvFmkitZ4KHIV1lXs2fWlr9m1IgSgCp7DJuFV?=
 =?us-ascii?Q?kpGtuTtbMpigObFlAxUSTnxW57LtHGQwou7JsU56wU0HVJna6TZr4hH60SyP?=
 =?us-ascii?Q?pwxoptXglKWu/8NRGKpjvKa0XxEFHQ7q+kPGSRFKnWpxWXXWS/dDJ5ZUYrse?=
 =?us-ascii?Q?r/vgzQydzvEfpMolpgcT9npo3P3DkXNoOG3+rUdcpcbl2LLVHlg6YjurSNOz?=
 =?us-ascii?Q?APPnFLe/Bs1dUQac8GGcPgTjkgQ1ANiQNREu3uHRIBzb0eQHJdOrad6rEaK/?=
 =?us-ascii?Q?9wQSv0UWW4B7w9DVUSLTiD6WPPvY5EeL5AXls5CTcK707/baTUS2zryvBrTl?=
 =?us-ascii?Q?hPIY2T0HDLFCC3Mdq9elo77dcfvgGeSNfXB3+aJUbLCmBjyuNeilPV1ho2Rn?=
 =?us-ascii?Q?+JFD2Em0GAw8lHs976Yb1OSKhW+pkurqWxf/gezH5pHGvhDY+3tE+aFrDLwY?=
 =?us-ascii?Q?4y6Y0OoUM2jUALXFN/vumm1OmpQcF1eq2YTnHU1kY+jPtkBDLGNbWUMD4QQp?=
 =?us-ascii?Q?Xt0YN//x04gsvQqnI0TS9xzc6mVMM/PBJsg7Nc0rOmWDBfoJ0ycigGetFOZ3?=
 =?us-ascii?Q?tZpq5bNB6RL2t2i4DXPt6dYvhdjW9HS7y1/EJgb6IVivm5O6FeGS1xiwMDbi?=
 =?us-ascii?Q?OpzTr7PGb5+GwoxxSFTwthnpQFjzWJJbGiPURsCEm5MrxGzGab5I12iX7POk?=
 =?us-ascii?Q?fWZAhIRC/nC8DIqnvuKgQIUQ3a2W3f7PwGLMcJphYPgbfKFRCHkQpxLdAyww?=
 =?us-ascii?Q?gqJqVEA0On7hV5PfpQNofF9tL9rsRHmPqRyaC1ee7Fz4cgYOMXVsBUfxFgUf?=
 =?us-ascii?Q?tr+P+gQ3V8kxZqZMGCaj4A7VKG5fPpqxawmJ4OQFKzKfFkDVQEIupNJRz/nx?=
 =?us-ascii?Q?dZukZtgsnQQ64pkzCHrk9dZz1MyhGmENQ9D8nBZW3alk8QyGQVr2FPKo23UN?=
 =?us-ascii?Q?TX2flw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rarwb/Rhg1q4/WiU42NJZzPCrH2S+1UFrvA8FEJBYJv7D1Nkvluw7hp71VmgZ1Tb0/SeC/4nNDB2UAPZU0V0voyqMhyrM67CL0wVWomFDqKvzSOsebJqjXgqTgIwiShYH5PKKHjQ7jZyLphbwijNwVbZ1Nh4iCKXzJ5mfmIumI1d0TvRkjL5ZTPYB5xNh9qWglZC8wKfup0eiTrTZFR8IbWy+CGOIC+7vcpVbUINxfFLiHaXZo5FCv3ctL2GTJ8g8q1w6AqxHqylZ+4rEB1bawuz/PN8dfYKEi/2FH0Fr87UCJdNjUVQagiI/4PfEyXaz0J7Uj2jZrIVMwrmezNgxl4jbMXcJOK5EUDhNtNoAueF3ukfdSTrVM7zzXHCKXIILXaAvuhtsLJZU3OoVrmvKNZnfWYQSB7UjPwu/M5aUJKT/jGTrCGDo8jx5WQ+0nHI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:51.0522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc8ea26-b298-4541-d8d4-08de61aa3bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255622-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 40851C6578
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 56 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c4c43434f314..979f2801e2a8 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS >= SFC
+	default SFC
+	help
+	  This enables SFC CXL support if the kernel is configuring CXL for
+	  using CTPIO with CXL.mem. The SFC device with CXL support and
+	  with a CXL-aware firmware can be used for minimizing latencies
+	  when sending through CTPIO.
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index d99039ec468d..bb0f1891cde6 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 112e55b98ed3..537668278375 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -981,12 +982,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1190,6 +1194,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised will be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..8e0481d8dced
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	probe_data->cxl_pio_initialised = false;
+
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_dev->dev.id, dvsec, struct efx_cxl,
+					cxlds, false);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..961639cef692
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+#ifdef CONFIG_SFC_CXL
+
+#include <cxl/cxl.h>
+
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
+#else
+static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,24 @@ struct efx_nic {
 	atomic_t n_rx_noskb_drops;
 };
 
+#ifdef CONFIG_SFC_CXL
+struct efx_cxl;
+#endif
+
 /**
  * struct efx_probe_data - State after hardware probe
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
+ * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1


