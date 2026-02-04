Return-Path: <netdev+bounces-256727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIkHM41jg2nAmAMAu9opvQ
	(envelope-from <netdev+bounces-256727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:19:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6CE84AC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0291830D9E7B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1F41C2FB;
	Wed,  4 Feb 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kfKwnQRL"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F035029F;
	Wed,  4 Feb 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217140; cv=fail; b=K7ji+yGvh32rGwhwTWZSClWjiwvI0X3ULLiEMDJN5RmBkvg8PutrNwFWcO3QtqLr4ZWdZZ1yJ8BBb6cQhMY35lXrXngYG83jSf3PISuD6CrIMGQM/c3tlJ7elvk7CTApmf8Ov3mNHe8A6uzHqfpogQKW+q8MjmSCwTbQwOMiUdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217140; c=relaxed/simple;
	bh=j8Q9OHLPTysE5/DRM/Tm51EuTIWM6lnUJPycHhj+CAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REeqaOo5Tz9jjPs2YCKkZj8geSqn7g09LVPrIP5yV87GL5yg9Ya2dan1TycaYMyTGUZ6nlBJbDtxZQLBlAEDPj6dFOfK90C+MJJy+ZEz8gXXSfu3WPpua35helMEk/Y/bNuCty1rfURPL9R+g4vDkzuSMHnW0tg3Rj6Q4wXmrWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kfKwnQRL; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtmRljZB6dZtSMSvhTDK+rkcXCSFw30370FMPfm+MgHO0yamaq772uU1v1hZbiYHGGKysgq3J21hBQcL6nL4BS0I/veOXjRd0hjfwAFYD4JVlC+EsIRBzU0He8ZNOvT4iloz6EuSOOlxP/n3fveHzBVeISDR1p4Y6ZAAIWfhXfH51QHQaym2Wa7ikvJ0eaIQvA0Zk401DAbCZ0EsBdyVfsn46FSdSbQSraqteKDQAiGau2taz2+vg9N6yBS3tLc9jxMJZXeLFdYGhj1nIIWr2lZJ8+X76nfI/u6/r/Nci+E9GGdW97bIk1jPAxPdIIzdwuYNq21ydXYBc3l9AxUe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNRdjJ80fxEqkBGFGqOC/lzZkLrqrS3hARS1Bsocq60=;
 b=qR/7em3V1tErlfPfCI3sy8U1MARpC25YsCIUL69itWE/90tJm+nXKxhFA8j+g3gcWbJ2zukfTK6dwKyyXWVHMGRDV0cdqclyue2xVUC1tJ1VKoYeoacVXIP7HYqakkJitXq3voNW6XKwwvFkYbR8hz9C/lQ1k9vrPRIrhKGSnqfYiHajeRyXtuV1jdzecFEablX4ZgV9oATxSwMst0h97/GM9qslHvd7slULERAcfr2qIN8nWxCrdZy8gTnGMzMGHdiun3+A7hC273tZpKoPaRFL4qtdIncwpEbbnuiAxj9kLH+ut8J2nzClq86uilMBMtvCBg6JUjWBpbhwKJ8EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNRdjJ80fxEqkBGFGqOC/lzZkLrqrS3hARS1Bsocq60=;
 b=kfKwnQRLj83IN5Lho01yFtkdilYWhISth75BXiONvdlqCS1nXxSX6DTHTkbeJ/iSRqN8JYmh9jTu88nqnrigpkcu/TIsgpUf8WDMtrYdYMtd6HH9DOvgpwtQZGcf625homCC6rzqfPccUPdZAtuDp5AyLVi6n4H7LhY2OtE63Lg=
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Wed, 4 Feb 2026 14:58:54 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::70) by DM5PR08CA0040.outlook.office365.com
 (2603:10b6:4:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 14:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 14:58:53 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 08:58:50 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 0/4] amd-xgbe: add ARP offload and RSS self-tests
Date: Wed, 4 Feb 2026 20:28:29 +0530
Message-ID: <20260204145829.801839-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: a996b55e-ec37-402d-3a5c-08de63fde9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hBlsZJl45ks74nKTXyUSzK6QiMvH7ct8XHTcvYKxBZjxm8v9yZU5tpgA0qX?=
 =?us-ascii?Q?HMUS2gVSbzXEEQXaxabChVcCTbJ1Y6Z77mDJicw0T/GgJvAhLHAO0uGfxTAj?=
 =?us-ascii?Q?MsJCROQkb5Qs4v6gwbP3FxVGU6dMBVt/0ml+k0Be17PSLC4ZmJSEN60rYhLs?=
 =?us-ascii?Q?tZOl04egFnV7beddf6qEMO4+FUEoKajElcrEL/E7vIB6kn+aTT7kRa1zD6tx?=
 =?us-ascii?Q?ymd++3gB9hLkXTcLbja+LQe4MrsQAPbn1NJfI7rkE2YnH4j4wopK9n91oa1+?=
 =?us-ascii?Q?SwFJG7PJWgUBiveam8RKZDKS32Tsm2qJNdszVjlH67TTcnDxDH5DlBNt3jTj?=
 =?us-ascii?Q?lOJZRnF6p+bFIyAderfAKUKIjY7+KEKmdKjc5XjMO8c2Hg4XMB5pwVLYgQJy?=
 =?us-ascii?Q?nRtRXLNpXVBzU2i3IrOy2mtI5pWeV/wVrc0UWfSjnKsjh8I6wziUKnUajE2H?=
 =?us-ascii?Q?y5b/V7REy+7AKVajNXyrKk5iVoOmTknek6n9+qsaRJObTtDiiGdodk6u7NHp?=
 =?us-ascii?Q?9xvwUux1M0bZFJFW0RTljzrhrJIBIbakdswGAuPsRdjuHdzP+VECEGkq0M5x?=
 =?us-ascii?Q?d2pPtq3FxxFXCSFdfE3cJKQhAsVvZ1uqQV3aXNIjcyUwxhmFx9aFo40v2RUX?=
 =?us-ascii?Q?1N+Tw+GIoDcLfBX4QHF4nBS5mZK7K94hEgoze0fCcY6DxLdUM+6ciHaVi7No?=
 =?us-ascii?Q?yL6dk4ldtj40GYQlgdWXFytnRWuryLf1o0QL+pNZtyutLbejORD9/GsJVpT3?=
 =?us-ascii?Q?FboPyLM94c9d09hqjSGYw52I4Ykurabuc4OGujBP5A732pig1+ITr9l3b+Q2?=
 =?us-ascii?Q?GFpbP5fT4mtKAdt4r49PIowrWowC5vRRfJYsz7IDfEfZ/TzmsK+7lLZS13kJ?=
 =?us-ascii?Q?dLV3a6j/2cELBGxZ9AEhbifYHA+UoT7Y9mhJmz9Xdrc/hTzV9GnOnQa+zhOQ?=
 =?us-ascii?Q?Z0JLsxMdMrnLGJdx655qqq0hgrcB2wZEKGkZD9YIRlSjO+vWzdtPZIInWNvq?=
 =?us-ascii?Q?P1OUIlbkk47Lr1egJVpXRC1cRtuO5WObFEY2fjzGv7q+Zsn5AtLtkrO8jwDk?=
 =?us-ascii?Q?YXDuKH1N2d6PCyBOvlzFG2fVKy7KcGyGktVEq0dGtwmyKJHVjhz2kSXDjLFS?=
 =?us-ascii?Q?jGs/sLYnlIqwmKevuSpjgID2AmiJ7migbRVmQvBKQ3ckIZrl/BNoG+nkxWzW?=
 =?us-ascii?Q?ETHEQhKhXQ3X/vZJ6UnJRhWEfUjiNxDbO6klKeYbCpn6oi/oHyFA2wvgdo1F?=
 =?us-ascii?Q?yOjMWNDc9o9nTQXRaseR3eZEzhCZNyMqMBK6+Q+4/bjPkRN3+BG/khcelYNR?=
 =?us-ascii?Q?39cZXlkWcxcEAFY+PA35mAuFXA6lsCQljBcnalOSGD9WnHiQRztKl8HHVIG+?=
 =?us-ascii?Q?BTwbcysX6JL2dP4OlcY05InH5kRNo6ylNh9jnwOYcPdE4DUA9lbRJQXKudDW?=
 =?us-ascii?Q?UkrTj9m0LqCjk62HAnYhGuOtoCX2VFV0ZSrox+CEISqy4XEHcYH3iztcn6F+?=
 =?us-ascii?Q?qLypfeR7hUkeMpdInhLJSHemT+mMrAqacvtbIlAkFbLNk3kZwsNxH2RmgtGV?=
 =?us-ascii?Q?XjHCBBcpp6/Gje9WR4fI63S9ZLZlCrKZHsJCpoZ1WZtIChMnLeLQC2+mIjnr?=
 =?us-ascii?Q?XjhGNZ+08zgkOaGuodhrDh5xl1ODMaRV1MNkM9fD0jD4OD80I9MacwrnDIBh?=
 =?us-ascii?Q?XmcPFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	stxXpTJga3C/6uOW22g+6cG6e/mTzoJ9vOsBR93B4sG5Nst0IVGFeVlJo1Sse+YOnG33iLbvQHDqHb1bNEP/1yu5/pVMij9vponIajWeeisrR1RpksZE7/DEwCVTGF0qszNUfxmkmN90bCTRokZLRgqtGfSush3FTmiYVNq1JU4tqqOolADHGKsfAwmF3kUJf5pUh4O1Ho7dqHYz2SkuZtm9Qe/FfoKAhHkRs0F97Ha5JVMAZfgbRnbLfSjNwuOcex4//jmmmrW2GixmPjBCYPgFlfNfEWssOwHP08oZAhqHbs24s1cVZgY/GYXUCv034M0OHUAl/gngEH8m5FSkdZtVAcoHJEmcGXsF1Xa8HPHrI0bHhoP3HV1vSF0ffDoQy0vfbQVfLeIybt2Z/0S5ZhEsQ4Q2W/P4bHlfeaYyki77tT1sgPZF6w6xWXZRjo93
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:58:53.5881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a996b55e-ec37-402d-3a5c-08de63fde9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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
	TAGGED_FROM(0.00)[bounces-256727-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6ED6CE84AC
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

Changes since v2:
- Fix warnings about line length
- Use kfree_skb() instead of kfree() for skb cleanup in self-tests
- CC maintainer for patch 1

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
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 154 +++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   4 +
 include/net/selftests.h                       |   1 +
 6 files changed, 186 insertions(+), 2 deletions(-)

-- 
2.34.1


