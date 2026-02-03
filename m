Return-Path: <netdev+bounces-256328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNI/FGoNgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:59:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EBDAF2A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5FE9304EC86
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008C3939C9;
	Tue,  3 Feb 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IWsog3D5"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40622F513;
	Tue,  3 Feb 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130652; cv=fail; b=hiYsWrUFmwtMwerDZyAMoJtMPXRvLayy8zY6S9n8+B/ysDjVpYiemou8Kc5dzpdN4jcFLPLQYTQ8kx9x+4uhyP8MgTP4Q0dmsqDuoqWpFuNxb+EF8cliaEEfLIPkAnsHhQWOV9dI0tjwJD+z+g8p6edqcXzujgoGZTs1KT7wMj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130652; c=relaxed/simple;
	bh=LkOs0jWTGYXN4LEh/FnBBBAhJlSHxel2F3z0JE7wJo8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzbuvyWe5jQ6OprvOMZMMfcTd6Ctlerr/qgjJn1dCS0r5w3josD6OnboWFx7q0P/bqgxm09UNg3WEy0SRLa4PM0PFVcElqvOKQqnZk7CR8LdMmcsEFpGctwYrfujOOxw5oOg/1nGT1yctAyGLJmHeroIt/M04IKmckcSLDBcCgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IWsog3D5; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH4/ESAEFnyMTSW9dBPHgEeVJvKMJe0rpVRV/K8+ZiOgqXYwzwJ/IEnwilMqKNvvTOaA6rLVvPlKXnnlMv1n1pon8qrNfwQWj4znvcCemxPwjk2uOKSJmFdp1yYsWMXKa+4IuI3rBGv1Pdrvo2xpcyGqaUJ76FU8OAs0TQLfCnPvrm76K3phk5yR2MynyWYakbUMm8ORfqriGzNRjMGVQX8ENdLSX3jH4AOjHvJsuo8Vio+w+GEZV4zTzty+EBfnVy6EOj4cCA4jHZJoz8mLw68DyTqbidKzgHb0s/rjFnayPCDTs72SgKbJJDVOZZSxbQgg/cZGl1U1QzEh5UZNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woDDAj6sCFAcNn7kPqxQpUd6RcQfiLoJMV52Mv1GFmM=;
 b=TsslHahw32tcOlXPk07cx6ctvFmrsXRGNbo9xZrvK9fe2SYcw78TT4AbSt282pvOwJUOqxP4WpoyrS9wbeOEly0jLp65trRmEQo5oBuZwo0K4pyHLz1do7t6bh+lwp7VrKH9FCtrkgfMxZeniDU5gGoP/QXaIJ7IN/1MPLO7im3nyURyJUnIM0qMlsFIaXjWITeptVsiLsKPxMXIlc7A5BDrLEDKaaian7PzANkR9dnhs04quMqNinIQnTg2R39TaWQwQDgKWl5+6bS8fQREwMeNTpWEP2N9hPu+j8/uupYPLJCy7Aq3seRVAG9gaD/NvH9rhsZCml4PND0OsUMpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woDDAj6sCFAcNn7kPqxQpUd6RcQfiLoJMV52Mv1GFmM=;
 b=IWsog3D5JtzPg1hGISferKeeQVqUZBBJxXLsbXfeJkcBR5Dfn53lw5ym0qzfw9y15l7p8BULhAbB35wq3+V6/ULtgrfP7ZxnkOOdtgg+TGAmCbudUkpd7gC7ZP8Jwq0hG3ItVCzyWrcWyXGyPSvmGUQE/lhELnsx8j1sOTd8Dgw=
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:57:24 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::87) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 14:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:57:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:57:17 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 0/4] amd-xgbe: add ARP offload and RSS self-tests
Date: Tue, 3 Feb 2026 20:26:54 +0530
Message-ID: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 258920c5-3636-416b-fd8e-08de633489be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8CCLoBF78k4uU0GtqbJjovSh9ccRpMr8o2zP/gQAZktAyWUemIrunAkn4a5e?=
 =?us-ascii?Q?2yZP41yoSLByFoqnmYTM/hXKt/wr4NrOGMsrLub+Y2jDGfRSRU5AxnybiLQ0?=
 =?us-ascii?Q?vgVEHq1LgvwA/ajLGoywEZl1euJoT9u3wrsRc9wudwtkIHmQI1i6lb6Yp2qJ?=
 =?us-ascii?Q?0eYM1SdOVnOTwPcKd/C364Grk+/brDUzvNWK+OJjqCf+nzpPSPo+ZqIJaH0n?=
 =?us-ascii?Q?tJ5IhVDbeXvRwvNer6MXVqyC4Y0LxUvErhLstUWqeZ7uzG5hwrJOSFFzz5sg?=
 =?us-ascii?Q?AeCSQVZRtEdwXw17ns0gwZPNvCZKcCgrxIqE6xQDqlcCI/ebXrKbMeIv+PeR?=
 =?us-ascii?Q?qXiCLDI4hNwGK8+0x4CooIZsAhM8CKNldbeaJOyKqVzspIuZV6Nb+7INMsnc?=
 =?us-ascii?Q?bPZTYjbCF8ZNCHkzP91mvVWKAwp45L7Jglltgzub+dPY/HM3aLPLLif3sofv?=
 =?us-ascii?Q?oDUZ8cJrWhRu5Ss6v4Iyu1QQK5i9Fs8TeY/i+qaXS5g5au4vc5/IifDTt1o7?=
 =?us-ascii?Q?CZdCa/ENIVhifW2HTxthZhfkOZSH1/is/HQuHUn6RIgcI2luLATKicyhPx0L?=
 =?us-ascii?Q?KnhNY2KrzngssxgwIRhI6n4yfmv+4nQtUdjn59RnuH7SV8LpKkD+BbQA9Gkk?=
 =?us-ascii?Q?6vMfPQb0/I306i0WwkouCzGRHOpa7TqCFzSeyEooFvmeoNQjEdpz6NZuCiXS?=
 =?us-ascii?Q?ShxAV3AaXNAhq+YNmhxcDm4KBrn3cmns9i/tNrVsLqwiG/wkGIJV9AT/E9yo?=
 =?us-ascii?Q?nZytex+SxR2RPa4SpddQE4mIAmjtc39fswj/jHqcTgKgGvO2m9ZNf0kafdm7?=
 =?us-ascii?Q?5FBM0pYU5yk2EkqkfG5LJWyRkLE3uW2mKRpe/at2WjjGVqKmFgI8s9GfyUHM?=
 =?us-ascii?Q?WYQbdKVF9Fb6VFeHKpbJWTZERgaRW2QehbsrH28YF4vO9MJbd8HLH1BmyM7r?=
 =?us-ascii?Q?6w0rETLDL1Ce6fzgr90tk1nipLdblrD0Hp8/3onEB+rivSjq0ee8wjNSIADz?=
 =?us-ascii?Q?XLeGVCkHs46FWZRUqsg8DzNDVySWUnB42H8yliQhyiS6vv3U/NL30xKE9mbr?=
 =?us-ascii?Q?x3p46yA2/YtvGcXxu1j58fWgDbOQFVwxe3meR7BXqQiVRP+Oeca84dcSvLhl?=
 =?us-ascii?Q?FpU0EOjlgiiNtHd0CXlPNkxiuRPcBhQsL4NUG5dXdnQPsZMHMQQOjVsHoeN+?=
 =?us-ascii?Q?GCoajMTma1YwlzUCC9D38Qpx6SQhaOC71Nryk87O2fhs6HL92ghS9e3qIRlZ?=
 =?us-ascii?Q?Jm4NcICEaPrvnYLHB+P+Q+3XpwNSdxZPKPMVeAcVXpYKrH0kPFm05rZwAJfd?=
 =?us-ascii?Q?RfxJ2xxP0rZEmFDgkUy5Yuo54Fjd9FJRrQfYNHWtICgb4iq19A42xXpmilQW?=
 =?us-ascii?Q?/u2rUlZ4j8r/L7oivifWJZwKZtBBE9IxDE70i/A1wlcyxj4AvZhKbIcl6ufK?=
 =?us-ascii?Q?zUWk2cBDzqIYpXetCayRnHu+y1WRhJZarxUEybZoPAbzrqHj4GJLSaBNyCCY?=
 =?us-ascii?Q?gtFuDM97qRBuubZ+EdHKRYZW+XEYQOU6u9c50RVi3r/WSMu9OtdsbrMQ2WWh?=
 =?us-ascii?Q?4ofxsE+octHG1XJAarUsNPLqv1YamPAlVvhDtF60q5Z1k4o0lIxyyACLKw1C?=
 =?us-ascii?Q?X8ST3ZdE04M7Eobzfjqm2aAkDSgECBeKvDykRSFO6F4+gWjGoMskJ2Qr6Y0R?=
 =?us-ascii?Q?5zkcZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/0TjX7rCv4g9PjhgwxOvMg+UJUxplYd6te11OXkEnnI/PY5gIFjQpmBNXV3BZGEsq3CQktqzdtNjYir/2bWUBVO3G1V40JB0WXUC3FawcVeKYHbWCEoiLmF1SH77jdSoUqXhwG8OqGSvScLc62t7Wr8u04fcuImcwy09tmKAS0i9B+Z+hVBCp/VyRyMyAyRN1BEF+YTuqtWxTn0+fBaIH/CfIdei1JyPKAJtRVyfaZUuNrwwYqzmPdB8Tdbz/7R2Q9Qc1LtxibXowU9rcII65Svf7yegmqr6un0z32LwUApKbTcqfS0jwV1RVvyq8p1FBGisJsxQUMU1zOFcy+abw1kVQaV1e1bDF07ZpSBfXccZz6WlYNaqrysMeLyJ3/WYMrk6L9w2Zret3DU8oPkRBJrY1GG5hG99eYo6MBBNB0T5VoAy91uaWhp34tjwPoZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:57:23.2745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258920c5-3636-416b-fd8e-08de633489be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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
	TAGGED_FROM(0.00)[bounces-256328-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E02EBDAF2A
X-Rspamd-Action: no action

This series adds ARP offload support and ethtool self-tests for the
AMD XGBE 10 Gigabit Ethernet driver.

Patch 1 is a build fix for randconfig coverage.

Patch 2 adds hardware ARP offload functionality that allows the MAC
to automatically respond to ARP requests without CPU intervention,
reducing system latency and power consumption during suspend/resume
and normal operation.

Patches 3 and 4 add ethtool self-tests for ARP offload and RSS
functionality respectively, allowing users to verify these hardware
features are working correctly via 'ethtool -t <interface>'.

The tests are integrated into the existing XGBE self-test framework
that already includes MAC loopback, PHY loopback, split header, and
jumbo frame tests.

Test results example:
  $ ethtool -t eth0
  The test result is PASS
  The test extra info:
  MAC Loopback       0
  PHY Loopback       0
  Split Header       0
  Jumbo Frame        0
  ARP Offload        0
  RSS                0

Changes since v1:
- Resubmitting to net-next as this was mistakenly sent to net previously.
- Fix INET=n build breakage reported by kernel test robot
- Ensure ARP self-test cleanup is safe on all error paths (no dangling
  packet handler).
- Use link-local IPs for self-tests to avoid interfering with real
  network configuration.

Raju Rangoju (4):
  amd-xgbe: do not select NET_SELFTESTS when INET is disabled
  amd-xgbe: add hardware ARP offload support
  amd-xgbe: add ARP offload ethtool self-test
  amd-xgbe: add RSS ethtool self-test

 drivers/net/ethernet/amd/Kconfig              |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h   |   3 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  24 +++
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 153 +++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   4 +
 include/net/selftests.h                       |   1 +
 6 files changed, 185 insertions(+), 2 deletions(-)

-- 
2.34.1


