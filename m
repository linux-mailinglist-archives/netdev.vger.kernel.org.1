Return-Path: <netdev+bounces-257288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDMsFE/mhGlf6QMAu9opvQ
	(envelope-from <netdev+bounces-257288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:49:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B94F6924
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7516B3047E65
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50957301024;
	Thu,  5 Feb 2026 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gbmieBj8"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8CEACE;
	Thu,  5 Feb 2026 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317283; cv=fail; b=TYwBZjbB/btxOXWP9zsyC1mq9UQ5ZVmh1K342TyrGCWngG53xIAago8UyQvgGGmC1soo1QL5bpZTU1VGpzvc1EOFM6wh8gwSE2sS4ax+NwumSpmHdqIKhtXdcLf+WHy3J0QwtjV+SN3rrSXPLEmehZdMa7EeZ0TimCvLojuDWZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317283; c=relaxed/simple;
	bh=oD+jpQqwhG5OiaygLBZ7VpNT4QQYldd41oRbPY9GHSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMj85MblMo4sCXQ+Xd4kgu/NiUlIredYBK709ozPF1l1oeKrAu8K/IZZSV48yT9vV1HrdIEnss+8W7OyuoRmrMSB7hac8VIaRQdHQc3W12DLFDEXtoyHrb81JP4ImG+aMGwgdpktBkRMizM7eehHfV/49cSRGtxDbyRossc+VK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gbmieBj8; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2TrPhhNpHt7rf1dhLn4eCBmv3CIU/RQjvAyes9OS8vtu3n8gRL95dbkWWTI8aNhYp0khoXYNRWFGwgC2+15TuZnByDWRSWoFjAvISA3VI376puM3IqbvpykD4wNjuEv1thhsaNasIODCPVA9yHYUVYWPQyua9mNgGRWZIjdWgT+CgFlJewDNrG8CokJu3a2nOvABVy/8p1YK5CjrESxM0cH09HS5t3zRKIT2MrS83iEghZ3IXe4ueEGk8mG2nFhia8/bJNkeCokCsDPGMnW8aIWnTiL4jUfhk4P3oE1IDgmN75pcx+ZyaCGJL6iHWt0C9azBaraFTal5Dt/igCXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KITCf7MerN31744upCXntDMHW1AnR5ZC0XJZtL1dl0=;
 b=qZYgHwVmJqq8pV4DgmrTq9W13qHyLIQP3m/a+vWMg48JAEyXL6bp3g/jy/SZK6qZDHheGT0nmuXSmnQl0c3jsuhasXHnm8SbcmL8Xrw6VhokUHJ+Pn7IZGjKKOf0SGDQXQfdGRRwc/3J7ngHvY7O+s3OGU6r8FZmlmtcscucYwEF9S979EhsOhHvwIBU0PBgZj38nbw7ZG3GivnqKad8mnMGzb9ubogh/OL5Wdlv1Q64UrLk/tNU9zFwUFqL+HiSwn7iUQKtBC0/jAWdcvicZ1gSPMGBI1C3Tu/v5jZobg5qNptXHP1yfA8TEsAiOqary6cgCSJUgpugke68NsLakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KITCf7MerN31744upCXntDMHW1AnR5ZC0XJZtL1dl0=;
 b=gbmieBj8chIdctuEl6UdY/dymIkEpcJDIofrLLpCH6fUbN4Sno+AG7mJVjABP38bSLTtOsMntyU6vYp/Lf3efCqMOi4btw/3++XydoxTKX/epP6rtERNgDZQURoFnVFE7d2Kb8yThHR52fE7m+QWJoRybrRkPfINn+QgKUoJQBE=
Received: from BYAPR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:40::31)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 18:48:00 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::53) by BYAPR04CA0018.outlook.office365.com
 (2603:10b6:a03:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 18:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 18:47:57 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:57 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 12:47:56 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 12:47:56 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615Ilu8h694413;
	Thu, 5 Feb 2026 12:47:56 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 615IltrX028686;
	Thu, 5 Feb 2026 12:47:56 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <m-malladi@ti.com>, <basharath@couthit.com>,
	<parvathi@couthit.com>, <afd@ti.com>, <vladimir.oltean@nxp.com>,
	<rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v3 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Fri, 6 Feb 2026 00:17:47 +0530
Message-ID: <20260205184747.2451816-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205184747.2451816-1-m-malladi@ti.com>
References: <20260205184747.2451816-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 80971913-0e41-4195-7e08-08de64e71488
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4fpzkdRWDF6q1xA4qDQT+WXR8HtgedX416SnSY+lNFGMqX83SbjqZn4cob0?=
 =?us-ascii?Q?2NN51xYSDM17+mMNw8XNY0p+bV35xG1v3RvhTnTzMvREhbp6gNdrENzODc59?=
 =?us-ascii?Q?xwgMv7wvbsSNW1K5eQu8S0Jk84WRLhuPeuLDmTm2JO9HH11JE3nro1BWAcnY?=
 =?us-ascii?Q?HunrI8pIoa/rcdMSuuoJfJy/0PrwNOdjOvyFggFchRxx7AbnxsPrvOWvbwsZ?=
 =?us-ascii?Q?8yxVoS0LhPjZ2mQa3L5VY0YDRJsYbS932rphTzFrvBLkGmZJZcSWtaXMrNmg?=
 =?us-ascii?Q?EZKLeQoORZyTY/zVM+dW1HByw/AvFEbh+1S0Tq+0DhPiV7sH0jFBf9NrDvoY?=
 =?us-ascii?Q?1mWcaRSSOraGGLi6Ek1HCb2992ZSmqvcQoPHEScQHCwBUkJOGweeBgvuh7JE?=
 =?us-ascii?Q?/Tw0KprJc+DOfl4J59+DCOMC0Lx0Xr9Q/lkVMg6vXgNg7hTTcQUAEAfGwP/V?=
 =?us-ascii?Q?rZx5jkMJD9gT3Xh+Cq8Ka4nOxxYXO8zEBmhfdbd00v4wEEieIY6Oy6QG+/5I?=
 =?us-ascii?Q?ECQBTSd5ODHd8F5blzPHIvY+xHBqt3JYrxmyuoiDbhBnXrMGtIb7bUN2bfHE?=
 =?us-ascii?Q?YRr14BFr4ULRRNtRYKVsd/pv4R1zxoJS5SUA/vvsW/i4cpjpGPNufnpRGwuM?=
 =?us-ascii?Q?G2WSztGgHx7sr1ybcvLf+wfJTjXdm2v4aXE0DNrpLnqTCY9Jk7Ym893YcN0q?=
 =?us-ascii?Q?j+yGI0DP1tEmYkdVLhDpt/vQjjNp1pkqLLIuNsoir4VmoT9hqUYIJa/Q1rAM?=
 =?us-ascii?Q?SOXZEjeawWGLFNRhXK/tk/vz0wLkHDvAr814u+/G9Q5ZqpSqp7JWOMJNm+H5?=
 =?us-ascii?Q?sMGvliOCkyqk0N8m/bBel0TZRz4MBDVicE450gQSuUS3zoTZv4yM8CSK+hoX?=
 =?us-ascii?Q?nPCobtFC3DCIASCBiXtbmJrg2J3m8ihDyX8uF1o8yOdQlXJivuctYcOF3zPa?=
 =?us-ascii?Q?ElLdrGz6+nx8ekXqXiHfzJLZw2hm5qCv+ie3GpAzNjSZC2rBHiZhVTSd2fW8?=
 =?us-ascii?Q?pw4UuLzJ7V1dUFkA+7Mt5B2Ye1fSDy7RYy0W00Uvs60CmfyFbfNxtgq7AS3H?=
 =?us-ascii?Q?JesqyzYSRUFp6k7mkdTspGXomCCALw5VCWMuOfe4JPqdTwwFTs0hBW82z8Nv?=
 =?us-ascii?Q?6vAcgVNnfNAGn97Budj1tvZMB+yGe1hFgnuwGDi1NBpDyuzgsF1Ee68/qZEq?=
 =?us-ascii?Q?gOl3tLlW4lQhZe6rUS8pXiroGiusvHyA2L+emcqYy8YCcq1TW43PUP6oKEVT?=
 =?us-ascii?Q?Ru/pSiDcPuq9kAQ55oG0sfikDeFSDKxP9zWaVwRROA5SeVAa/cgL5yRDeChp?=
 =?us-ascii?Q?ByVfVVUwrAYXt71VSZvdnZ2yrsilTTFDqRg2E3xgRmGWsob5JmNWg0jqNwoa?=
 =?us-ascii?Q?mqoXuR9vmFItbxow6h7ii4+O7pP/eE7xdyZmnnjBsPyFMsY2lPXTRdhS5ujP?=
 =?us-ascii?Q?lEnuKLnFfBLVJ1v53sjeJVoUzdkbrhgmtgrAVT0Mn67R6dRj+fP+1MMnsLvk?=
 =?us-ascii?Q?L/vYboC5JJFJJQbzHNYPjbLO8AuUo1Z7e1cQg+WGOwGehfNhAdMWfzbWgh5G?=
 =?us-ascii?Q?dKnc1FBb0ETuiaO87h5uZAZcPw8bQbrGLlWKnnR2nJ2315XK3iQOyTCO1PJf?=
 =?us-ascii?Q?vEH5AdTEYYMUNk/hvKFWpiJoGjzBn4/wgSiFJMJ3grbTsXlJtMqKRPpuuseY?=
 =?us-ascii?Q?/+h40CfcLI1R9X4E2Y9PI8Trf3M=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qPmHbTekEHMyv2hLjEabDLuhyMnIdwM7WnyWKQ0piZ0JBVa488MMFnD5CwXn2+aoUnc98Gbckn0bexbNlaPjyOoXhvFgSE827vrdgGaYCsGziGukWXM0sKmFTAw859gDj/BaesLQfM6hPUTDGakScbT2bd7WMdT/oWF2eNIQ4xpC77prwtdTx92wUUgqvneoKqu2iDKgLhmiTKuSAFB/x0fsL0dWHK6NuJYvwVKH0UXHL5HtKOTxNVF0Kmg09SVL/RuPYFgP4smstPK3/a4yqizfT1xxUJwo+CKF9QE6+2rgyWQKRfUIaw93YBnc5yUxHZOH2960GwYprf1qT/X//jWM4zDWQVBv4ReOM2ftLevNhuChllaoB+wPW81Px8PPrQPisv43QmTONCbdiSgTGeLD5143CWByTdNiRTunZNhKf0MwYkD13Tn83nsdN0QP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 18:47:57.6586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80971913-0e41-4195-7e08-08de64e71488
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257288-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,nxp.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A9B94F6924
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing / changing the MAC Merge sublayer
parameters and dump the Mac Merge stats via ethtool ops: .set_mm(),
.get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the firmware
without leading errors is 64 Bytes (in octets). Add a check to ensure
user passed tx_min_frag_size argument via ethtool, honors this .
Add pa stats registers to check statistics for preemption, which can be
dumped using ethtool ops.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v3-v2:
- Fixed build warning raised by kernel test bot
v2-v1:
- Following changes have been done as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>
* Add sanity check to ensure valid min_frag_size is requested by the user.
* Add comments wherever applicable w.r.t min_frag_size.
* Make it uniform to return all valures from the driver for .get_mm()
* Use ETHTOOL_MM_MAX_VERIFY_TIME_MS macro for 128
* Use NL_SET_ERR_MSG_MOD() wherever applicable
* Re-schedule the iet work thread whenever there .set_mm() get called
based on fpe_enabled flag.

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 86 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.h     | 20 +++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 ++
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 ++
 6 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23a..3c4ff154f6d1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 
 static void emac_get_drvinfo(struct net_device *ndev,
 			     struct ethtool_drvinfo *info)
@@ -294,6 +293,88 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	state->tx_enabled = iet->fpe_enabled;
+	state->pmac_enabled = true;
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	/* 64Bytes is the minimum fragment size supported
+	 * by the firmware. <64B leads to min frame errors
+	 */
+	state->rx_min_frag_size = 64;
+	state->tx_active = iet->fpe_active;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+
+	switch (iet->verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int err;
+
+	if (!cfg->pmac_enabled)
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+
+	err = icssg_qos_frag_size_min_to_add(cfg->tx_min_frag_size, extack);
+	if (err)
+		return err;
+
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+
+	/* Re-trigger the state machine to incorporate the updated configuration */
+	if (iet->fpe_enabled)
+		atomic_set(&iet->enable_fpe_config, 1);
+	else
+		atomic_set(&iet->enable_fpe_config, 0);
+
+	schedule_work(&iet->fpe_config_task);
+
+	return 0;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +398,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 7a586038adf8..5271a013df64 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -58,8 +59,8 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
 #define ICSSG_NUM_STANDARD_STATS 31
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
index 8aa79b68ad54..b18a93f9181a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -55,4 +55,24 @@ void icssg_qos_link_up(struct net_device *ndev);
 void icssg_qos_link_down(struct net_device *ndev);
 int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data);
+static inline int icssg_qos_frag_size_min_to_add(u32 min_frag_size,
+						 struct netlink_ext_ack *extack)
+{
+	/* The minimum size of the non-final mPacket supported
+	 * by the firmware is 64B and multiples of 64B.
+	 */
+	if (min_frag_size < 64) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be at least 64 bytes");
+		return -EINVAL;
+	}
+
+	if (min_frag_size % (ETH_ZLEN + ETH_FCS_LEN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be a multiple of 64 bytes");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 #endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..d27e1c48976f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 #include <linux/regmap.h>
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..f35ae1b4f846 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..855fd4ed0b3f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


