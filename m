Return-Path: <netdev+bounces-256728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIHDHQlgg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:04:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1742DE7DAA
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 911603015C85
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B128853E;
	Wed,  4 Feb 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0hwqAU4l"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BC285404;
	Wed,  4 Feb 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217245; cv=fail; b=NEHinqnsMKl0IG+tJOgxnT3RLGXxCV2EJnzIO1vL+z6GQwz7gTPMycZqBB3O0ck6UF7hDDyoKTIB8DPw8t3ELDmZDMX6k75dhPm1m4qvl2CWz7CjSsfpkPASYnlF8Vu3aDBVLRQRPUn4FgTUCkY0ZFjWkRtu5qE1W4gAY6VjpRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217245; c=relaxed/simple;
	bh=j2q4iXLecORDtFdUhEpSiuiA6h0oCX1Fw9M22YZtvHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FV+lCOArcUeTT8VBYFnynAF/QJHDU7Uq1vqSBndTUyvuHAxNMGbddIIezJxiTNVGTgBmWOFQPPz7/vsgovd/5TfD8yj8pjJubR/2Y99Doapvvy4ek9lQsYFvkqghyrRUmP5P7MuY8R2KQ6t6kYh5ZLBdPwxk62HayNZmbOz44aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0hwqAU4l; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrkdJrMPqgdwIkkEMhU++yOwbc+ADZo3C8JeNnr4jYYrfzOxbx/APXq9jDmb/klIH4aL7VcQCL4lLfNtfNjAmSzmUMEDKWNaPVEJjdcJ/wTZKWgyigMrllT3Y6axjZbhITpCGa2XOqIOXl2QSY1dWetaX81vsPfXhbIy7xreDkB1+LNmx/WcXhOjUMZXfDS/hwl09y50wFh0jJ7nNPenHWQKEKn3SR8yPBleMOQgOSiJ/NLxG6VHT1rM+LFRdQHHwsjaE6nYe9o8jrlncA9WWxoe9b85+/GSIvE3zvCmEoY8mnzOsr1x4jJRRLfHWQtvv/NRadrt3C1PKhBlfGlj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HX6T1XlZAoBlEFrRJRq51LNfpEysqKNgsg/s8ZfIe8=;
 b=GSll6jVzOdIe04Nx6OvL18MTiAaJ1dd8jZ7FLfNNushHO+Lt4lFh9QObAN9OexXGXK9qF/AT95DXov3JN2eD4IMOKH7M8vmr+TlqBXOHqasXQNboBa8qwqUsDbbQ9ZJKkHhNCAcNWghfkD46iEEsWCgsWH7XlIa8u8ItDbIXsgrJLZ8gyMdG13CA40QSgwHfjpZoKp8lQPO78cD+qADTSZScR9gMYvSgZ5LNaHNwtAss0vkEglH0Vc1rRHClPrktjcZZproinS6X5X0FIefoPWcz4gKD5p6TdWiqoaWY5vMXd5FR2NHhtVRu7ysLyIHxNEbGrBfjXtwfqjKcPUOa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HX6T1XlZAoBlEFrRJRq51LNfpEysqKNgsg/s8ZfIe8=;
 b=0hwqAU4lz+73T7+Vlef7Z/smg8jp1a6I41ue0ORPPA48TWcm+vmnw7qpGVNZJY4VcmQUejwzBBAebMqU9hKfCiLg0KSYd8HBp18i2lZ5owqCw3Dw82JyBaNws508mcMLRPe4bYh5GjiBIaQuVd3k2kKv1XLslFbwkOc1TAdY9Bk=
Received: from DS7PR03CA0217.namprd03.prod.outlook.com (2603:10b6:5:3ba::12)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:00:41 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::53) by DS7PR03CA0217.outlook.office365.com
 (2603:10b6:5:3ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 15:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:00:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:00:38 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <maxime.chevallier@bootlin.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH net-next v3 1/4] amd-xgbe: do not select NET_SELFTESTS when INET is disabled
Date: Wed, 4 Feb 2026 20:30:20 +0530
Message-ID: <20260204150020.883639-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: d7837128-1c86-4aa4-3e77-08de63fe2a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2f39+pNiguC+utW8HcsIWOynX6cdbrYmpiKd23ZFcpyET0kzMWCNM1Vzosez?=
 =?us-ascii?Q?sra031JZeo0KlTjbK3vWp5Fh/rMNpEEp8xna4Erv5IZRK3ypGPR24v01Z06l?=
 =?us-ascii?Q?y4kpo7mEJKtWGhRI/qRyHLDdDB7ytG2dF5yJCt7Iybp15NoJHHWXLS7ywOEe?=
 =?us-ascii?Q?gGXYvvORh8kFe/E2Y1y3TiW2UQlR7STK2LrZmpbGpYXYO8Hq5CfcQIM4KVBo?=
 =?us-ascii?Q?SPN9hQcwM5UxkLZLgEPpPMHzsbWv78Y22eJA1D6z/X4yax8ud2oNc0T6999P?=
 =?us-ascii?Q?RYczdwcA+3iK92ixdoK6t5h/MLDLgNBAHp8M1dqojcwIWySsGjSNHhowNDgH?=
 =?us-ascii?Q?h12C3ufo0BDrKazk44LdUs+m+uM7UXx49rWuGNXRtlw8QHN0faMo8Dr2rkp6?=
 =?us-ascii?Q?PIp1h+gZo7yw6y5oj06Wo4RZoZP2UyIPqVTm++CS5vPOdDWx+k2kbdh2gSCW?=
 =?us-ascii?Q?99sP/Kn9G1RRWOlRcGzTSlgJQb9m5KGEz4RiCXkvKcahjH+AYo5woRg5jcRe?=
 =?us-ascii?Q?MivqKYdaTg8ISpbtlwOmFIgeLga0dl3dwCh5aceHP62bDMGa6vwrB1ozZWQy?=
 =?us-ascii?Q?mEw/yR1l4HLE2KuWnNLF1SPb2cg2TUmHqSEOuNvWwydfoXvsBgsjycYZcQ2q?=
 =?us-ascii?Q?/X0OzMxayZxttJ+CNqZkg4fSx2R2VXURAXZ/NJmMXfRoKyT/Lw1skITnXHKl?=
 =?us-ascii?Q?6S0qG2DuHZ0PYnphGh/YOFdaDRVNJgpiPI5zml2Y+phuds1euwEA+e35xL4c?=
 =?us-ascii?Q?+zjDiidsPVIX6lsQffI5j4tuiSapVa0ytWrr8/zlE4HJFVRhLU7KlpZwna/8?=
 =?us-ascii?Q?YskP+H2mJQJru4EGko34m9KXikrZJsp3c4eluC83DcT01h+Og3oWG4g179Ro?=
 =?us-ascii?Q?YUeOaxXjwO9tms4QNRmIXEeiSECETNGqYv6WkhzaPFZBg96ibhck5zYDXO56?=
 =?us-ascii?Q?Ki2ObNGvdc2dsFRglMsRYL7yIhasfCTMYH86SGNc9rej++QRt5OPo7C5AizD?=
 =?us-ascii?Q?6O/o44yA3vEahu6rivEh6TGtmwG8dXJ1Gep4YOHDeW5joW1nLB8qMnEAsh5H?=
 =?us-ascii?Q?cTqSqzR79WBBigrtCjuR1FZKa7V8MH7/ERmgXANFFuZ+fVtHUVritSnz5lQg?=
 =?us-ascii?Q?bcbNnPMv9zr1eS+/XmUUyn4oh9fUcH0P3mcDBRndPh7+sDhYTgc3woFuhmbj?=
 =?us-ascii?Q?c/U9mmwCsPi+5xJvjj4LsLZanlZnCrz4Wl17+/SYRELhV5AvBmQoWwxF1zP2?=
 =?us-ascii?Q?ZTmErQwooIEWDqrG+DK0VnBlfan0D321W8kK6o2KzlDwWFAK4CgMHYAzpV9e?=
 =?us-ascii?Q?r+oTD2pzIZrwiD9IswaExPB0U8Y/gP0tLTPWQFrF3f5m6Uf60QxHf+5N8RZE?=
 =?us-ascii?Q?GwEAiKwq8KGZ71cVX6cpm6LSK2VCl81m4rBuY/x8erh+VPklTsiKsQooHptu?=
 =?us-ascii?Q?gYH12F1Ouk/f/H2fogVWPYnBE9I3N02QJRdxX2Z0mp3t2TDoJ64yQUIl+7bA?=
 =?us-ascii?Q?RFTsThIwMOd6kC6xyKIBZBe1xbABKGb8h82dDNBdz4VVnijPxXCDte1P4FR3?=
 =?us-ascii?Q?6QkeotXeQw68abkDIBY1tRHhoqH+wAiwtoZGTybAKpuBWypIR8fpN1o9BOCn?=
 =?us-ascii?Q?M6ELO3xv4Vd8UT4JFpz9ngkz4Be/Pdjya3tq6VsjkkgzC8kUKC3sAm9LNAvA?=
 =?us-ascii?Q?UnaeCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VOHa3NgQ3bamIUMxfHQ4kl2VKuqOa3m7m6hZWnOht11Yx5bttzRjTQZKM7c28TKwGAIP9oAFyJ/qzll8E76rILED8hD2a2F9t3KAZMCVblbfaB9BWmesT4V503s/dWAcLe5ByRpL6LsAJi9fpdyIFo0J5UFs9DDybE8sJVA9zETABcnJ4DIrCGPJ70dE6DoAIsPmtWgomVcl3zNxIym70f1/byIQ1mPm6fudAepS5rMD9nlgvnMM7dVjpy6J+dqbp9+mlyXEsF+IsWkVWy7P0Bgu4jl89BFXC/Z3LUnlL4fCWW043H119xURj+Abkkb7tK9nFL2RsvsmIcZb3U8pTRN7nIyY16oVXQfYEan9NrCNieW6Gn+x0Er/iilmuqvVJ+N0UkNPaJAyAyPbxswtfi+8esKx2WC0Rfvuf80x2IW2Hm0+wI9smMvl3EoSdkSk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:00:41.4779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7837128-1c86-4aa4-3e77-08de63fe2a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256728-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1742DE7DAA
X-Rspamd-Action: no action

AMD_XGBE currently selects NET_SELFTESTS unconditionally. Since select
does not honor dependencies, this can force-enable NET_SELFTESTS even
when INET is disabled (e.g. INET=n randconfig builds).

Fixes build issue when INET is disabled.

Fixes: 862a64c83faf ("amd-xgbe: introduce support ethtool selftest")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602030920.SWN7cwzT-lkp@intel.com/
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- CC maintainer

Changes since v1:
- Added this patch to address the build failure reported by the kernel
  test robot.

 drivers/net/ethernet/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index d54dca3074eb..45e8d698781c 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -165,7 +165,7 @@ config AMD_XGBE
 	select CRC32
 	select PHYLIB
 	select AMD_XGBE_HAVE_ECC if X86
-	select NET_SELFTESTS
+	imply NET_SELFTESTS
 	help
 	  This driver supports the AMD 10GbE Ethernet device found on an
 	  AMD SoC.
-- 
2.34.1


