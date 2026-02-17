Return-Path: <netdev+bounces-259146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGvlEWnZlGk6IQIAu9opvQ
	(envelope-from <netdev+bounces-259146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C30150965
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A72013038F29
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418123793B1;
	Tue, 17 Feb 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLho955n"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C837996B
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362663; cv=fail; b=l0DhLM8pONg0PyUBMmCUN6vBHA/8n2DhGeY+PL5WHeKTlmhBTuNPYD9eGZZqlC4xslPd0zO5JTjha1tBgOwpBdQLiOxg246JXAU3VxGhNjvfm18zE55w956Sfy0jmL/pywjKixzlI84BTy+jdwb1Kf6xxCPzwEusea99AL1Of0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362663; c=relaxed/simple;
	bh=MlGF1H4LChn/SY/p+zebUdKQnOABXp9Ly5/EA3oNcyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqrEpHY/5tF7GXfBV6kYYqjtM2jQVb95AXodjEFgci0kBadkftT7FtIMmeEkC2fQ1umRPFVL2TyG+GYyzImKOXDrTPa7M0rlYz5lqf8VEYTYzguo4TzHBy62IxqUhR4indK7hWrBffnMpQmei/b2Rog3QvwiqrRKXKVIIN3NCJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLho955n; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC40rFAAlH93f8s3GmWLNxx2hYwCkB5Vgdg7QDGa4GeOAZvYM6aGvzDOV8SZZJ5185OJwkOzeYr3WGztRQcnZ9xutA7+QREXY4ec3LHTDO5Z2JW895Y7bc4ARlO8ypEVLLDd8eV3oaAuSB9BiqiFbwatcGzfsxNe8jtp+khX257wmjA0dOBY1L5Lg6jguZRCT4nwJwpKWL/DiidAkeq2HdBXO8otY1S9BPySfuKLtMGNLkH9YYvA0ivK8Yyr0DhE28kZVrgsE2kVM94R5dGOvPF5ubEP18M+csqAQD6VgFNOTgTLueRfTNHzzXFT3q/NsGJn2VCZ4CVc0Yd/PxB1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLTix1uY5Ejvff6zXhn74Z0SLbGTKJ4cWsGvO+oMfwY=;
 b=tRlastp+ZiSHHDru/5Qh69AvuIJWVCxKBBXWEdwQsRAX/C2zfuUBpZ+7yWf4ByY6WIZtk9ZdMep2LmIUjHHilin9D+QoBXuMsvC1vituf1ErizWKr7ijQ8sXp5Fo5xBiwM10JHsjdI6SwFd/fAd9/2KjbKAbyx2iX+7Hk8JRUTOM6QhL5x3Yr948IGCbuOSKNwq4IU0bZrMafg3D+jFL+p3gmhSYN6rV4SNxyBOnwS2bf6Y+fcgxMnQQdOYLhmR/Rgb7EyL5MdZgMSrOvpaEuVMiBJ2t7N1doS2CGdHRG0iSiiHOHv5dFFeXKgBk+M/Ae6pn4PtAp+QgXQZtIVzM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLTix1uY5Ejvff6zXhn74Z0SLbGTKJ4cWsGvO+oMfwY=;
 b=dLho955nBoLYs29Zmh5zrQ0fu9NXDYl6GYY2R1IabX6lzD8/TVUMJ4Ag3K40CFdNb3NUKwGofWsvjSNZcnagK3mIkvb5ZygYWPnJ+nL6JtDjlFdckzI5VYwvAIfxEXwj4dMB81qM/K8w0remSRGbZ0X5MDJd5Ndpj67ic4nQjSM=
Received: from PH8PR22CA0012.namprd22.prod.outlook.com (2603:10b6:510:2d1::8)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:10:56 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::89) by PH8PR22CA0012.outlook.office365.com
 (2603:10b6:510:2d1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 21:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 21:10:55 +0000
Received: from ubuntu24.e2e.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Feb
 2026 15:10:54 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <nikhil.rao@amd.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: [PATCH net v4 0/2] xsk: Fixes for AF_XDP fragment handling
Date: Tue, 17 Feb 2026 21:08:49 +0000
Message-ID: <20260217211019.48280-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 26088cdc-45bb-40ee-cd80-08de6e690a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uA/NNq/3BqBiMqqt8tpUGJGJ1iPQqVE2GHOrFhbtMLiX29vwEw8rnwh94tl/?=
 =?us-ascii?Q?3ir98Sma+/SdDVn+DmktgVZYNax/ZJyfX58ia33TXEfqISUstkp+3RjW1w5q?=
 =?us-ascii?Q?D1VnJfvlYpMabbimfGPMZS2vQ4S/k/iw8haxqeczwSlE21iKxtST7FkvhxVQ?=
 =?us-ascii?Q?lHjrViV1J0skrjnaafsVRFOoAfJcxmWHesODu2d6TuYYWJVM6ElPojJW6NUK?=
 =?us-ascii?Q?UTdiV/8ax4VssR2hXT93hFhSEUdOyAHa9nBkRGJMZyYzrps3AZS2hODmW1y0?=
 =?us-ascii?Q?7ZVAr1KBxwY8CkvGWlM0+DdJDgaGSzIHVrCdgNropqfjheEmXNv6vdQvocqt?=
 =?us-ascii?Q?rsgNXpt2G6rP9N/C7kA0Fph7ySHgfDxR78U65UGLvRirVmTwxRiGQTQx/Gnp?=
 =?us-ascii?Q?oL69vCPhgERy938fCdB3HMSEuuKiTe276/HPVUsHpgPFX4qH6DJxDbuvuR3a?=
 =?us-ascii?Q?DcNhEoysWsZx2/6YnhkiKGjbWUsM5P7UuTwEby9BMlsR4NJEUKdIL57uBsXl?=
 =?us-ascii?Q?o1uKgdI6EZGh21lCRDpmhYBnHMMcjKia8j/lKt97QbOBQ3YrlPfgJmC57E1n?=
 =?us-ascii?Q?l8zvkaDk7o3bICAGjRZ0+scltiObp8175H4T0qOGVuyGSJnj6frZz+X4kc4X?=
 =?us-ascii?Q?H3zdW3ouKK9C8TYuRZ16tWIGyrReYWVvcuwAyFOtFQPWoEc91weS8wq5MrJ+?=
 =?us-ascii?Q?SH4V8jWPWqzlBLwDRZgq1hQl1sTzeV2EGQ1AHX3EhziRSFeBHvQ8PRe494K/?=
 =?us-ascii?Q?XT03CJ8HPAMEXMNzLU+I8Pu54pVdDKse5k6pDk/QMvMEd5sDP79W0tifSWVo?=
 =?us-ascii?Q?Nn2+aKjU3nL2ZnaFwLkXL4uVJr09yTNeh6G9gV2z+eYrf8Ry0wOzcsCNTIBI?=
 =?us-ascii?Q?q9rcmMwVg3stA1b/Mn41mbu4m8btil8UMB57QEX1FeJEElJ8T0UXWZmtd3wk?=
 =?us-ascii?Q?YAx7ZRaJ+fw/4qXUz1VUnDTLILaQdd7ZFtgVJml4HV3m/9flHvMxqRnQsEwi?=
 =?us-ascii?Q?+zybTtrQvCLmEsviPrMfaRZfJsap3Rv1CGf24BL0Hru6HtcwcLThi6uR0eFs?=
 =?us-ascii?Q?I11nT1yu+1XswnUtpO0ZakQHshcbcEUOcWQKHuogUjTm9T2r6iYp4Qpi8/f3?=
 =?us-ascii?Q?4HJ0b7QUI80xt2Hd5wlUrupyDuHLVd+Or1llKCLlUFct9qIdMtBXq0w+MD39?=
 =?us-ascii?Q?1muUlRKaJrRZlo+YO8FhtGMT3MkZL7CDrMkDpQ6MWlEnEW42a6joPyf/AFVC?=
 =?us-ascii?Q?DrlSm5KcihbssMHr8o88UTtmvt2BSlzPj4HsmVAFtxF6veIsDvZfeBPXGrRx?=
 =?us-ascii?Q?Yyom+GmnPVOPaX66NpsxeGsB2/sLS1bQTQT0PMJeBWcl5SBDpdCV4Zsx9Xvj?=
 =?us-ascii?Q?d5NtBzMCDM1OeWt+Nr9eQ6Z1j3rPIOiz7/VodlsNFFHXbR05mDo0GydJnWtl?=
 =?us-ascii?Q?ZF1/ju0xvGcYC7cqtzW9XNclHGginYJcl1vrB3J8kNVeHYfWZd/OWYQuYg0W?=
 =?us-ascii?Q?kkxScSjPukgqN/Wmt759PqoyL944e3QjGakVOKShzlpZSYVUlTJBOLvuHlBe?=
 =?us-ascii?Q?9nbflBpfVnC5izxx48q3e7L3cdT8DrdzRkQbsX8QiGubYs07DKy7OZEx7Wfe?=
 =?us-ascii?Q?J55vdb+tcIvk6JxqwjusWkVrIOeBlZD/X2sse7drWWf3SqMGGag3+pN2Qu9q?=
 =?us-ascii?Q?gqNSeWGaAQpi9ipVtLZHiWKPjpY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m/pGfIFpivdFnkiTloU3RvdfSOtJqkVydAbQybhjLxPkck4xjZ2Ts9wkfmcDonP5ZmuGr6w04XwNydpQLgrXck6CbEwQORDq3DJNKnw63djeO0plvARHtNnQGtw62IepuvdNMFU3WvSgwmnHM/XnO1SGN2qCVwqyeRHCN6peJJ5u7qBMegwBMKL+WwNz1vNfalK839RjFDsvc41NxedFkXicB9Eb38P/prDrQvcgNoM9y7SK9biuyRjf1V4AgcunPQAL/9kvijaKGF0Y1uA60BjgmMy1JjKoGSIzVXqbDP2E3BtVmVLExp/gf6Xw930XRAN0WeBuZF8bJbUPMTbLsK4C7JE5Ab41zDuSFAynV0S3aWM4nzv5vf257pDsqY23tRV8H8ktdoeV4znpV1iNJ+5pUsn97PGoQuAO6U2FcA23CeZX5MnYy5cn1WThV/aa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:10:55.6798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26088cdc-45bb-40ee-cd80-08de6e690a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C30150965
X-Rspamd-Action: no action

This series fixes two issues in AF_XDP zero-copy fragment handling:

Patch 1 fixes a buffer leak caused by incorrect list node handling after
commit b692bf9a7543. The list_node field is now reused for both the xskb
pool list and the buffer free list. Using list_del() instead of
list_del_init() causes list_empty() checks in xp_free() to fail, preventing
buffers from being added to the free list.

Patch 2 fixes partial packet delivery to userspace. In the zero-copy path,
if the Rx queue fills up while enqueuing fragments, the remaining fragments
are dropped, causing the application to receive incomplete packets. The fix
ensures the Rx queue has sufficient space for all fragments before starting
to enqueue them.

v4 changes:
 - Patch 1: Carried Acked-by tags from v2 on patch 1
 - Patch 2:
   * Fix uninitialized err when sufficient space for all
     all fragments is not available [2]

v3 changes:
 - Patch 1: Carried Acked-by tags from v2 on patch 1
 - Patch 2:
   * Check for free space only for the multi-buffer case, this preserves
     single buffer performance (Maciej)
   * Fix return without freeing buffer when sufficient space for all
     all fragments is not available

v2 changes:
 - Fix indentation issue reported by kernel test robot [1]

[1] https://lore.kernel.org/oe-kbuild-all/202602051720.YfZO23pZ-lkp@intel.com/
[2] https://lore.kernel.org/oe-kbuild-all/202602172046.vf9DtpdF-lkp@intel.com/

Nikhil P. Rao (2):
  xsk: Fix fragment node deletion to prevent buffer leak
  xsk: Fix zero-copy AF_XDP fragment drop

 include/net/xdp_sock_drv.h |  6 +++---
 net/xdp/xsk.c              | 25 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.43.0


