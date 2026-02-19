Return-Path: <netdev+bounces-259402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FE9IpKklml5iQIAu9opvQ
	(envelope-from <netdev+bounces-259402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:50:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727715C2F7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472AA303B5C8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F92D0C95;
	Thu, 19 Feb 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fa65tzp1"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD026A1AC;
	Thu, 19 Feb 2026 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480185; cv=fail; b=OA+8DbSl6H2qRmwNJ79DtEdUodQH4llWpBEcA440b51oXhxDgARClXnffuIVLzw2MkeQp4Z5t0sAvrdvoyPjHSCMUM2KwhKTcaL4fOnx9/MyUxXCdL53fIpck/uCWE9ZGpDqn/dOpBOXNxaTxxwUTpCbA8bJtEnVHoJ3o6UC42s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480185; c=relaxed/simple;
	bh=yoZV6gY7ECH+f3ulF3dfRG3zd6qzTvYp/fmuZDhk90I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENEsXoyz1b0URrsguNP5NVxyut7+cvwD/G1sxTuWEGGoOSXd/rXy6Qmj1IhzrmQfdvvwgchLIaUlm97bjSuV6LYnvoLGn9xeH/IFn3CXrCjH44yE5/JaoZMO04fwOips59ZtdpfzQ4/CrGWFGuQHGaafWADKQtEE3YaONw81Tew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fa65tzp1; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWBugbNWdeO//mz+I+hNmz6SPc/adCKT6AHsFb+aTtekBs8oRWK+7IjqKoOHTpna9pVTJItQtIUYjRZAl7szRhxvafym2uZMj4iPdRkPWQAxiVVXFlj2MnxqFA8iXGNeAmlQn1TxulUEFOXASweUgFXqEAytreqyhdUxUWzqc1tsBmWqJ9bIV/UTB5weq/Jnsav7rBBa3CD/pHJ0PEr5gQvDt0EI8AHmyMXYgRN462T21lth+WtilksQm10PUhTcOgktcbhiPdNhwSHdxya1Oi2MZLHVZ+S9wLg8tnZg1zhvxJNMMpfuVqS7yQPgVB7fis4erFaHEItIHthgEJ0zwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fpk7eQA+BFWFn1n0xCVD2Q83ec575h5/jvXc0XZsO0=;
 b=JEtuHEsKApTkYpiMVxr6i4bj/DNkcIIS3CCGGNxq9DNUf7yEfAptG5Ht37d8pbTGNuAx5BLttEBABvhKT8YXQVn6US8RGYORlrK/HlPIM7JL9nqplZ88eHjD89UhF/wcxlNtLT3AddCGzX9Fwfgdd6v/Ot2YGE3GIunZJhspUGFQD+ANvBCwxrOmbBb0Z3obh7ELP7XDbKd/8kNq+5AVfFVgOpVzJnLL3ag3WLe/Da1a6lQVoLjCSCvyhiiBJTvhnz7QYEUqSNP2TwX6CeOQ4S5k4o+tzb6+0a1uOYMF85FPorMvl8wL0GH6/D0Rr2+8hR4mZedGnu2LGRzeudAEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fpk7eQA+BFWFn1n0xCVD2Q83ec575h5/jvXc0XZsO0=;
 b=Fa65tzp1L3+IL+7cPgptFHrBloNB1hOWmxQ8V7pYH8Jyz3XkVuNDzbk6U7xOvH2SYlDPmRAclWDuMoDthez/htzZlDkg2ZotutM/qBIA64hoeA2wp0R8TJaunoxHztokWBjyrtEjjeRzZftwgH8StkUlPH+k2c4FOso3eWTVMV8=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Thu, 19 Feb 2026 05:49:36 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::bf) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Thu,
 19 Feb 2026 05:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:35 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:34 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:30 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 2/8] net: xilinx: tsn: Introduce TSN core driver skeleton
Date: Thu, 19 Feb 2026 11:19:05 +0530
Message-ID: <20260219054911.2017362-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2f2ace-8c2a-4899-92b0-08de6f7aa9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWvzrnUFJr/jlioeo0lq8wMwhj786H+zseFejjhqbg8GUNH16rgv9KtsFr0H?=
 =?us-ascii?Q?p1hNho5wNmUNL+YZy3ZtABZKkzp6lWsb5LuawBd3CH09dnN8S/wlLZjgkXpF?=
 =?us-ascii?Q?uY1F45wBmm7GopoJZAPgwb5jO5NEqk6IiKggaOx1nTcD1fpfPZfj97og3J+A?=
 =?us-ascii?Q?GVr35adyO8KiNbLHDb9VRpbMniFiBvOnv5Xp49W+GcMfHy69bduTDZXGf6HI?=
 =?us-ascii?Q?cLTxgIp6sAueCBmQNwhEhrfH2avFmJuFjaJqCtFH+oTn1DwyB+xt3gJ+dt9u?=
 =?us-ascii?Q?aM/GdB6M1ARWFr7lsPMgYiOPjfihkrOypeCtCMWtqlwKzbPW+WIK+Z1k96UZ?=
 =?us-ascii?Q?UcyWEYW/HzedH8IrJOO+YPXjQC/h7jwBEGXwWmAOTsrOvJYNJqddxQiIFMhp?=
 =?us-ascii?Q?I1ZSAF/7mkfk5GclWmeePG4MjGxCam4y8bX4Lj15/TWYaraCy4nXR6R9Novb?=
 =?us-ascii?Q?ciNRD7pUiqj0PFK/aYgmi7JHwwjw3gux7WoQ2nnQExCsAVzhIG7ID9cPukGi?=
 =?us-ascii?Q?t/KOE4hKp9pNGF+XHNo4e2sf3tGF1XIFllZZppPWO2lkIyMPWKLXyLuN0UIe?=
 =?us-ascii?Q?1XZxabEpe2gajEzO4d6F050h/RJvj4jM6TFpiLL8YJZOJ4HkLxaqc8yEdNdf?=
 =?us-ascii?Q?2Obkx2qA7KolH8wzvrQeWqzKZ63hC7/mIkwg2siZs2ZmKthSlOqRG6CbONkc?=
 =?us-ascii?Q?52BPT4DrH85mi0j1R3M4e5mIHkCDbd73fx3BrnMY6pHExxeyiM9NodOU0ya8?=
 =?us-ascii?Q?xFEM8WxNHePDH4Oo29LZrqMcmvvgPJtUdOHqVJVXUc/SPDfcqqgFk9ErIEpP?=
 =?us-ascii?Q?4prrS0oi7oqcUSOyO8FLFHwCGC6c/ZUM4ycRcGZIerZUYv/DUpXvZkssiPqx?=
 =?us-ascii?Q?Ed+UWE1NYUamaxDvzNcSAP8X7l37PJCqFli4AQ61rwihqO7Gs0CXRQS2nudc?=
 =?us-ascii?Q?A1vhI+USi+1ca/qDdIwpYLmir84XE5WjThpkNlCfoheQfy8a6FNKNNps6Uf6?=
 =?us-ascii?Q?9a3LshmjTAhAvf0sNWofysMdq7+5ONu2SCra/GIwDEEH7vjaokAtjPa6rVxU?=
 =?us-ascii?Q?s2hUKE3dkhPudAr+RK3MyKvA0ML4g95G83qAKByCsNJE1Yt8e7KEqfz+D6Sg?=
 =?us-ascii?Q?701vo2DRAp9NBixS0pd1HRWx8mu0wCqjUX6oXuN1J6aNerBySnLzqHMR44X3?=
 =?us-ascii?Q?U7aAYCRn53sbG7zC7ETITuR3b6xNzMdy5GU1qYLoRbRCG9aFCfYs81pL9iT2?=
 =?us-ascii?Q?kfNfmeJucIzzwaOpkW8uxcPK3KTxxLq8VKqA4Z1s7mNUzfUzoJsb5HTwUepz?=
 =?us-ascii?Q?Nz8KAOgp8L45OKwYLaLjiU/vd5kc5EdzgjHJzPIm2oPa9r8spjk5jAsbTnhV?=
 =?us-ascii?Q?bNhX8na6ITHm5frbsF/2X8DZUlwUWyr3SdWg4X6vWcLLrTinICPSmX28N12V?=
 =?us-ascii?Q?t2vRg5FMsBfeGJaJJg+oCdkLknGXmD5wpPyl42wH1dPwT5ctahiSS7yXwUmP?=
 =?us-ascii?Q?wXnxR3Xqxh4CHDikUdO/nSTqAf2iL58wepevYBHV1lIpgz8HF2eEXwMkLLgb?=
 =?us-ascii?Q?8JkqsxQuw45bwtVGKYBFLskMbxRmpekurJksrl7oZ3LkKPusL+nH8VQ98lUo?=
 =?us-ascii?Q?79s5b6KZ6vpRvDnPuiQe0dbKtgC+qQS6jFO4sC/fM/H6Tt2xTUrlNiC95C7e?=
 =?us-ascii?Q?o61GYHbC9p8q2InzrksHqWTYNzc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TSoTYGMgXtmGkiVf934FIViO6e7EAQ09jlp0h6o3D5TZmAbOxVaLjMk9iAxas7/OO3OxTxzE/zKlpGdfKUf7IkXxs26Y5BC89xFqvHfh8Ft9GQcsFNDnpNzxsuMMN+Azog2dqZy0xyNunXPiNesGFzO3SnOL5oyD2gwOhIrQm5rZUnQR1wXnDC+YsNZeT59HvbADlqKY93XdXNTdv6DvrkAgkmVgeoilJJKalFjNwwt0BIONINQsnZp0OkEUY4rH1uQ2b/15jDllV57+ceTm2fR7m0IfmxJRnVd/sFC26Cth8wQaMjxo3HBiFRhKjbolew7f2KV3hEUmBq1ndUCp6ruEXIVO7h+fgOB4YD96Hw2R7qxRqae2H4Wb5pkWXVAnrIgsl6OA5jwhS+dmOsUijGGXGiYrRlG+4AdLZ3CkGonwRjtwyppgJfM5G4/09eu3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:35.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2f2ace-8c2a-4899-92b0-08de6f7aa9cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259402-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0727715C2F7
X-Rspamd-Action: no action

Introduce the initial skeleton for the AMD/Xilinx Time Sensitive
Networking (TSN) Ethernet IP driver. Adds the Kconfig entry
(CONFIG_XILINX_TSN), updates the Xilinx Ethernet Makefile,
and provides the base source file focused on device tree
parsing and clock acquisition.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/Makefile          |   1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig       |  14 ++
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  60 +++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 218 ++++++++++++++++++
 6 files changed, 296 insertions(+)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Kconfig
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Makefile
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..c6d704c8d3d4 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -41,4 +41,5 @@ config XILINX_LL_TEMAC
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
 	  core used in Xilinx Spartan and Virtex FPGAs
 
+source "drivers/net/ethernet/xilinx/tsn/Kconfig"
 endif # NET_VENDOR_XILINX
diff --git a/drivers/net/ethernet/xilinx/Makefile b/drivers/net/ethernet/xilinx/Makefile
index 7d7dc1771423..66dab012650b 100644
--- a/drivers/net/ethernet/xilinx/Makefile
+++ b/drivers/net/ethernet/xilinx/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_XILINX_LL_TEMAC) += ll_temac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
 xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o
 obj-$(CONFIG_XILINX_AXI_EMAC) += xilinx_emac.o
+obj-$(CONFIG_XILINX_TSN) += tsn/
diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
new file mode 100644
index 000000000000..53734842700b
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -0,0 +1,14 @@
+config XILINX_TSN
+	tristate "Xilinx TSN Ethernet driver"
+	depends on OF && HAS_IOMEM
+	select PHYLIB
+	select NET_DEVLINK
+	select NET_DEV_STATS
+	help
+	  This driver supports the Xilinx Time-Sensitive Networking (TSN)
+	  Ethernet IP, which includes multiple Ethernet MACs, a TSN switch,
+	  and an endpoint block. It provides support for scheduling,
+	  traffic shaping, and time synchronization to meet real-time
+	  requirements of industrial Ethernet applications.
+
+	  If unsure, say N.
diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
new file mode 100644
index 000000000000..420497f2d402
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
+xilinx_tsn-objs := xilinx_tsn_main.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
new file mode 100644
index 000000000000..fe613f73044f
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Time Sensitive Networking (TSN) Ethernet MAC driver
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#ifndef XILINX_TSN_H
+#define XILINX_TSN_H
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define TSN_NUM_CLOCKS		6
+
+#define TSN_DMA_CH_INVALID	GENMASK(7, 0)
+#define TSN_DMA_MAX_TX_CH	GENMASK(3, 0)
+#define TSN_MAX_TX_QUEUE	8
+#define TSN_MIN_PRIORITIES	2
+#define TSN_MAX_PRIORITIES	8
+/**
+ * struct tsn_priv - Main TSN private data structure
+ * @pdev: Platform device handle
+ * @dev: Device pointer for this TSN instance
+ * @res: Platform resource information
+ * @regs_start: Start address (physical) of mapped region
+ * @regs: ioremap()'d base pointer
+ * @clks: Bulk clock data for all required clocks
+ * @tx_lock: Spinlock protecting TX rings and related TX state
+ * @rx_lock: Spinlock protecting RX rings and related RX state
+ * @mdio_lock: Mutex placeholder for future MDIO serialization
+ * @num_priorities: Number of priority queues configured
+ * @num_tx_queues: Number of TX DMA queues
+ * @num_rx_queues: Number of RX DMA queues
+ * @tx_dma_chan_map: Logical TX queue index to DMA channel number mapping.
+ */
+struct tsn_priv {
+	struct platform_device *pdev;
+	struct device *dev;
+	struct resource *res;
+	resource_size_t regs_start;
+	void __iomem *regs;
+	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
+	spinlock_t tx_lock;	/* Protects TX ring buffers */
+	spinlock_t rx_lock;	/* Protects RX ring buffers */
+	struct mutex mdio_lock; /* Serializes MDIO access across all EMACs */
+	u32 num_priorities;
+	u32 num_tx_queues;
+	u32 num_rx_queues;
+	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
+};
+
+#endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
new file mode 100644
index 000000000000..2a7f5fbc5510
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Time Sensitive Networking (TSN) Ethernet MAC driver
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include "xilinx_tsn.h"
+
+static const char * const tsn_clk_names[TSN_NUM_CLOCKS] = {
+	"gtx",
+	"gtx90",
+	"host_rxfifo",
+	"host_txfifo",
+	"ref",
+	"s_axi",
+};
+
+/*
+ * Helper to parse TX queue config subnode referenced by
+ * xlnx,tsn-tx-config. This version enumerates child nodes in order and
+ * assigns DMA channels sequentially (queue0 == first child, etc.)
+ */
+static int tsn_parse_tx_queue_config(struct device *dev, struct tsn_priv *common,
+				     struct device_node *txcfg_np)
+{
+	struct device_node *qnode;
+	unsigned int queue = 0;
+	int ret = 0;
+
+	for_each_available_child_of_node(txcfg_np, qnode) {
+		u32 chan;
+
+		if (queue >= common->num_tx_queues) {
+			dev_err(dev, "tx-config: extra child nodes beyond %u ignored\n",
+				common->num_tx_queues);
+			of_node_put(qnode);
+			return -EINVAL;
+		}
+
+		ret = of_property_read_u32(qnode, "xlnx,dma-channel-num", &chan);
+		if (ret) {
+			dev_err(dev, "tx-config: Q%u missing xlnx,dma-channel-num\n", queue);
+			of_node_put(qnode);
+			return ret;
+		}
+
+		if (chan > TSN_DMA_MAX_TX_CH) {
+			dev_err(dev, "tx-config: Q%u channel %u exceeds max %lu\n",
+				queue, chan, TSN_DMA_MAX_TX_CH);
+			of_node_put(qnode);
+			return -EINVAL;
+		}
+		common->tx_dma_chan_map[queue++] = chan;
+	}
+
+	if (queue != common->num_tx_queues) {
+		dev_err(dev, "tx-config: described %u queues but expected %u\n",
+			queue, common->num_tx_queues);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * tsn_parse_device_tree - Parse device tree configuration for TSN device
+ * @pdev: Platform device pointer
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int tsn_parse_device_tree(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct device_node *txcfg_np = NULL;
+	struct device *dev = &pdev->dev;
+	int i, ret;
+
+	/* Read number of priorities */
+	ret = of_property_read_u32(dev->of_node, "xlnx,num-priorities", &common->num_priorities);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get xlnx,num-priorities\n");
+
+	if (common->num_priorities < TSN_MIN_PRIORITIES ||
+	    common->num_priorities > TSN_MAX_PRIORITIES)
+		return dev_err_probe(dev, -EINVAL, "Invalid xlnx,num-priorities (%u)\n",
+				     common->num_priorities);
+
+	/* Count TX and RX queues from dma-names property */
+	ret = of_property_count_strings(dev->of_node, "dma-names");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get dma-names\n");
+
+	common->num_tx_queues = 0;
+	common->num_rx_queues = 0;
+
+	for (i = 0; i < ret; i++) {
+		const char *dma_name;
+
+		if (of_property_read_string_index(dev->of_node, "dma-names", i, &dma_name))
+			continue;
+
+		if (strncmp(dma_name, "tx_chan", 7) == 0)
+			common->num_tx_queues++;
+		else if (strncmp(dma_name, "rx_chan", 7) == 0)
+			common->num_rx_queues++;
+	}
+
+	if (!common->num_tx_queues || common->num_tx_queues > TSN_MAX_TX_QUEUE)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid TX queue count (%u, max %u)\n",
+				     common->num_tx_queues, TSN_MAX_TX_QUEUE);
+
+	if (!common->num_rx_queues)
+		return dev_err_probe(dev, -EINVAL, "No RX DMA channels found\n");
+
+	/* Setup clock IDs */
+	for (i = 0; i < TSN_NUM_CLOCKS; i++)
+		common->clks[i].id = tsn_clk_names[i];
+
+	/* Get all clocks */
+	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, common->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get clocks\n");
+
+	/* Enable clocks */
+	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, common->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
+
+	for (i = 0; i < TSN_MAX_TX_QUEUE; i++)
+		common->tx_dma_chan_map[i] = TSN_DMA_CH_INVALID;
+
+	txcfg_np = of_parse_phandle(dev->of_node, "xlnx,tsn-tx-config", 0);
+	if (txcfg_np) {
+		ret = tsn_parse_tx_queue_config(dev, common, txcfg_np);
+		of_node_put(txcfg_np);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	return 0;
+
+err_disable_clks:
+	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
+	return ret;
+}
+
+/**
+ * tsn_ip_probe - Probe TSN IP core device
+ * @pdev: Platform device pointer
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int tsn_ip_probe(struct platform_device *pdev)
+{
+	struct tsn_priv *common;
+	int ret;
+
+	common = devm_kzalloc(&pdev->dev, sizeof(*common), GFP_KERNEL);
+	if (!common)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, common);
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
+
+	/* Initialize synchronization primitives */
+	spin_lock_init(&common->tx_lock);
+	spin_lock_init(&common->rx_lock);
+	mutex_init(&common->mdio_lock);
+
+	common->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!common->res)
+		return -ENODEV;
+	common->regs_start = common->res->start;
+	common->regs = devm_ioremap_resource(&pdev->dev, common->res);
+	if (IS_ERR(common->regs))
+		return PTR_ERR(common->regs);
+
+	ret = tsn_parse_device_tree(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * tsn_ip_remove - Remove TSN IP core device
+ * @pdev: Platform device pointer
+ */
+static void tsn_ip_remove(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+
+	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
+}
+
+static const struct of_device_id tsn_of_match[] = {
+	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tsn_of_match);
+
+static struct platform_driver tsn_driver = {
+	.probe = tsn_ip_probe,
+	.remove = tsn_ip_remove,
+	.driver = {
+		.name = "xilinx-tsn",
+		.of_match_table = tsn_of_match,
+	},
+};
+module_platform_driver(tsn_driver);
+
+MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
+MODULE_DESCRIPTION("Time Sensitive Networking (TSN) Ethernet MAC driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


