Return-Path: <netdev+bounces-256713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDWFIUJRg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:01:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB70E6C4C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D48D73010B50
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BB40F8F1;
	Wed,  4 Feb 2026 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YqG5+9Qr"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90752772D;
	Wed,  4 Feb 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213654; cv=fail; b=nWKfxjgis4r1ocZcafKBU1TEjEyRzm7lTZ2gsCzYfXuleb9BFxevx1yurw5oyKIHZ6geuZocd14whpdk6xBRdvegeq1T9JPEKfRRBMDgkjfwP+kRkiHHGSpCpEok03hqR0nuc0tPp07xy+cr+NT+RlIp4h60rss9qojCU09i/Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213654; c=relaxed/simple;
	bh=FGruOBbP5t9GAoy5ncin6H5A9tfS4lC6bhDkU5FHFN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXIjS6ZkgtR3RtTnSoPyE3U29+lni4wgcs6HoDbE88y6sEtDb1vkouAd2tOrgjgX1CLhNizXsZDDjPNMzYInGCQjyrzyj7a7XCOlEe8y+MQuq5yAuODuYPlG6VOWpdOAjuI4JucIFACsLJaWav/L9YcfWOI3lBmcWInOMZJcGgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YqG5+9Qr; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puLeGM2EsqzdqB/DPOg4gZ5AKObI5ixixyId6E0f8pMSAuAqziAQsD0E3uyJgc4O9WDL/3UmNlUnV8kEk8coLt7HHVl9bmGxEB2igwCz+aGP27WeGeAy7An/qY3O81lo8yRAetefM6Sqp6yWNeVGEN0iz7+D5vRjFDIbgDtV+gWBDJ6iGjcFaZaR7msvPJdtTX/CxQwEhCuJyMwLwDfbJjuY3VvxPx690+yFcIe1XJae6oyMfviMRwkjaRcogNeBPQZIRQP/lk9JuqFILWRG9QNMzCkdIfZQBY1f0+bM4KfoxYp9CNTo5e0o9V3BBzCN5V0ZditeGMVpTe9ajkjuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e2SWyb/IamYJ3N1S7YmOSHPuhUu5A42iRYImCpz40w=;
 b=tA9dkbMAuyIJK3Mjuijvi/7r4nDRq+YH2dCnwCgspof6bduQR7/Sg9DPo7ICRQAzfDiRTMQA5e1GPCgXDWvqrn5hE4S1PjqeqeuCc6j9+95gY1EL/gvNAJcn0i3c02XGX6vVJumqR6OmCq9VTh225+ZgrhmZLbmTaHxkGy1iG3OjTJn3xXvxdpm9oqduXcMYjkjM5Dmb+0sj1XuGG8Sc42QzWN0Ygq+y3MXyWpvpehIu84yMRWCupcTpqqCA3m7WXmt8NbOZ2bcZv6ppmMgPavdsXRXZxNlqLr5rmtBIHv3d06eXvUPz++wkwkEoI1VLUnryadcehCUx1VKonfVlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e2SWyb/IamYJ3N1S7YmOSHPuhUu5A42iRYImCpz40w=;
 b=YqG5+9QrF88B4ST715aBqGWM9u4uDNrhZEF50LyNToP1yLNFaKFdXyNx9uOazuz+K2aN+iY0QeVyy3gnhrinvG2ObaqpEkPGYhVLDKoJG4QnVZnv3/Zf6YoR1I3sjZ3+snNYKckFupWjqEu0xeawBRBO3WJtZEYAFKG/bRZGsS8=
Received: from DM6PR08CA0057.namprd08.prod.outlook.com (2603:10b6:5:1e0::31)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:00:49 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::1d) by DM6PR08CA0057.outlook.office365.com
 (2603:10b6:5:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 14:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 14:00:49 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:48 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 08:00:48 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614E0mVk1657231;
	Wed, 4 Feb 2026 08:00:48 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 614E0l0l002165;
	Wed, 4 Feb 2026 08:00:47 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <parvathi@couthit.com>, <afd@ti.com>, <m-malladi@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v2 0/2] Add Frame Preemption MAC Merge support for ICSSG
Date: Wed, 4 Feb 2026 19:30:42 +0530
Message-ID: <20260204140044.4086725-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR10MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 54558082-6898-4343-fcc0-08de63f5cd28
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tm031pPUJ98nrwxODHOFdZoJeybtxNUdyrakmOxgg2iRxskZlovTd8Al7pdA?=
 =?us-ascii?Q?HOF4Lw47MCkjpYieayMPo6T8eGDAhro5kPAjQ7nw2czli8HhLMw/PUDu1U1X?=
 =?us-ascii?Q?Zu8QSp/Nu3iWVFDo90yWSWM5SC3N0B7VADn88OQswj8i6ke365AzHMs0qB8v?=
 =?us-ascii?Q?TmovWKPsPZ5fqcmezj/fy9m04w7A+/T7Mb/54en8oukf8vEHatR+8qUYYkUg?=
 =?us-ascii?Q?WHgzQ6+WUPunEX0PiLqnVsNzKJ8vTq3lffyw89Mb9iWMN6DnqL1hCsj2G66v?=
 =?us-ascii?Q?bwRqLpEPQp7YXKz2o6qsJgxjiwpZ68PqfJMPvehuh+Nr+MYOxMoMsgfx5ELO?=
 =?us-ascii?Q?XVBL/reUifmcxwCYPDMRZPPDiksat9dN+j1cqXL0tyn6berTBs3zsxeZlfXa?=
 =?us-ascii?Q?l/jYR21slxRke1CEx1mRDUyl/aF5g97pRGIcO6pTIC7tzWURsSnhNUnCeV7b?=
 =?us-ascii?Q?2esVl/p2H5xwMeWrW3XZP+8zTOL5TdQ6QsQDpUBp1DtbDciLaSloyl9IV4Bb?=
 =?us-ascii?Q?mNhkDbxoIPP0/AsTJVs1afJr9gcRAREMG3ghNyf/Z5wK3485cV/xA6SDlMVA?=
 =?us-ascii?Q?+TnTHeZYyZEdyGhfn7akAWCzb9HvuTEhCJK2onoNIK2FYpt/aPOoBiGTTMW2?=
 =?us-ascii?Q?4J1Op7TTOoM6qYRRAj2wJ1nFL/2i3jKPO5DggpYZ70wqDyWEAoA4N2+PBkVp?=
 =?us-ascii?Q?YCRkeBa2tGklmnn4tAwgXh9WMw0BxU+OPxOdsSOxOQ1hWG8YicFc07KBis28?=
 =?us-ascii?Q?7j4M+H8F3CIYBiiqLAUwEgsRu5RJm3LV6H9+b5qjBSZ6BqfTwlFg+aa6G6uG?=
 =?us-ascii?Q?iStZ2pgGm0P95PX4sowh4E/3PbzlcVZIZhiH2QFNfSUy72aBodvwuS7Yvbky?=
 =?us-ascii?Q?AwfOJvZwewtIYCkofYWNmUhDFeevpqYeHp3cXOazYy4u853xG0EUUni1GHvC?=
 =?us-ascii?Q?DEZ1VucvFA6EdQhBv9UpQFYnnEIgwDSNV0YZSK7nDiFDRb8b+fEXSyX7Obgy?=
 =?us-ascii?Q?24G6WtdzADL7BIRDYRsw6xq13NnM9ZlcJcxxHwtMoyEL3Yjim7tt8fRViYZg?=
 =?us-ascii?Q?mxg4wVlE2hOFRf9DODEoY6i+RHWL1oomCN4mVf3WQc2kgyS9pGQMmW9iiw7s?=
 =?us-ascii?Q?CWdrbnMadCdPebmGCjEaOzWMDnu0ACsNtouXEGB6KXVr00K1JxRdI+2gpCSx?=
 =?us-ascii?Q?dVdZEQSH1ME/3bGAIhkj5CQcr0/P5f11MCkcb6aOcjmV9+V7zycfZjCZQSFI?=
 =?us-ascii?Q?TMDBdIbFOJOOp3IqLjiQVq+WhQppaos20NrGdS+ZBO0STna6JuxCs0i8QjJi?=
 =?us-ascii?Q?T/bsFRyLa2z58zDYWQ9BQ6mLaEP2dBmuvDNB+UcqstvTPV7FTCzBA42Evs8W?=
 =?us-ascii?Q?+ll/3eozM83FQfwSFeBs8IkIXsFuWpmFCx3+C1BHDqlX94n6APJ9jXx0DwRt?=
 =?us-ascii?Q?wUm73/9daOLxSKI3turKqsZcisdqSV+OH5gJqKFtK0GODhBb+drpgFYMwSlb?=
 =?us-ascii?Q?MPZs0pUKH2VfKJpzBWGwhjya4qk6EHSXvXUZi3TRvX24UPKT17iekuRWXaOL?=
 =?us-ascii?Q?HsAXMN7JEeXFCv44OZ5/ykmiug+EQ9RMcuXJ99eVgp/cVim9o/daKUj25GwE?=
 =?us-ascii?Q?d5HY8mZTPE1pD4RJL6ojopIUgXcKxm1pQNpVwG9QZHGR/Ya8aXuMMLn3Doq3?=
 =?us-ascii?Q?NTfm+j4fAJ47P2D7X6vE0CsURgA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ihf7kPFE1pFIvwGQXMCra/rGfp8BGwO+uiFJib11xhJq5IqmMLYJ8rOMo90WU2nVqngAbNunkS2Pbb56mpyS2CLGYy8hPaYyzV8YxmK89TPG7zngkEPZdGQ97pn2h05tNq4/xkqU+FtwVSQAahdYLkoNr7PXb8C5XU1Wje0hUR52WdTZikp0ZDCicdffUiRmimRKBs1pOyJjcTLdUj0pVFF+YzuGzfkfFHU75gMQPPA7Vt1a49VLFXZudLDc5mpxbcpaGCmZFGstbxoLWM4qUcVg3j3inL2n5XckIdIzNrAWQXfXaCopNFPJ9KUW0BZSbIaZmmHwKLvG5lQr4swdiDStnelN51MDsD9N0n9vDMR53Mzrv2aqMEbBp5mFc39K/+NiqEZ4XZnOBe67j9jhIKOQ93AP9Pjnf0BDTCEFBkN0JF964BSbM4n9F57G4FJH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:00:49.2211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54558082-6898-4343-fcc0-08de63f5cd28
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0CB70E6C4C
X-Rspamd-Action: no action

This patch series adds QoS support to the ICSSG PRUETH driver.
The first patch implements mqprio qdisc handling and TC offload hooks
so userspace can request TC mappings and queue counts.

It also integrates a driver-side mechanism to program the firmware
with the IET/FPE preemption mask and to kick the firmware verify state
machine when frame preemption is enabled. The second patch adds ethtool
perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
.set_mm and .get_mm_stats so admins can view and change MAC Merge
parameters and retrieve preemption statistics.

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
  net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   9 -
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  86 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   5 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 216 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  78 +++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   5 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 10 files changed, 399 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: 9a9424c756feee9ee6e717405a9d6fa7bacdef08
-- 
2.43.0


