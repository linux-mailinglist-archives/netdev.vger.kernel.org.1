Return-Path: <netdev+bounces-297472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YT8VFjcDKWpROwMAu9opvQ
	(envelope-from <netdev+bounces-297472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:24:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3153666358
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:24:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=raTnQrlE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297472-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297472-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8C530F76B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F93B370AD3;
	Wed, 10 Jun 2026 06:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD62DF3DA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:18:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072339; cv=fail; b=YdD6gSaSEferH6eNSJy09GDsSB32AbIaV8JCEf3WhHuJISJRE0XWbJRpByXNtvv/Tb7fvM32XLyVzSuqeBp34wCxWLLoZ4pSh3quRHRwlubSkVev+sLh5bTFcFnmOaEs8REFzKoR2DzyLX9jrJLZA1LANVR88g4jAz1NbFj/ess=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072339; c=relaxed/simple;
	bh=cTThkk3biifjiBcoyUx6gCGYnIx++EUANDJ/rcLUd6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uxH+UdX/4bMuV/F5jgyqRiE9p+C4kfgPiNHxeDc0jlCzQ2rZ0Qb55TIXMOJtAxP1S9dwBWqPZQwIwrMBWrE/IgmSiJmtBqkx8wU8O8/lMIXJ3AQyXCNrUo5nnK91fmukxUJmZtybGwweuKGBwfP1cZUIiQMm2FaYBRd08QsCxsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=raTnQrlE; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9rkJC6cuPCAqRdzpqf1xursuc1ePN4ITlrfsLv2SSnGuZPBaEvFabkjDYiMEpIt4gRUBgEeaf8iOTh5DgZFeffaTh2cK7uQKBy2fCdTSNICb1t3FrssU3PTaLMvjg9+7PzbP9bzwGUIIOnhEZogkJgADGtQQCKqig4/tdAsE5tcikB/LFTUP6qvf21Vo/XN4FwyMg9uHCAj4OHaG0h5DcXHYdpc/1TucHj9UER1eYkvR/jC2TCdPonxtOu/jTy3Fey4khenLuxd+oXLwsdnAbcSRNMXFmGNgDGD7AVAM6gzb17HQc5nIYXyV9EET/sXbK7HiaZKd6/mRcntSXMN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2zdQWpAhFBzllRBXMQLHrMJrKHDai8cKGieZbH4LNE=;
 b=LJnI4rEnTjNOev4UadfD4yQa6PYc/CZ+J9ajRuFXJqTnPf3OYIUlpkuckFZCaSx4Fmi6WJ77ghOjWqEhijWEw3N/98BCcbH7dPao+g2F3y7Pfo7nhNAOckEUD9HiEAFORKLMEIR9XL8X43IazNr/Vs0XqymlANlBPsphVMHYiRGf8ahLPaS4RiXNBv+ByHPuTnmg6x0zkVShUf2rrtMQj5XaOqNdFpvU1v6L4c5Kv3D3GPu9R5pZezmx3PBx8Gcb+kXjiP27sB7fTbj8hd00GuD2OmFkRYLgUZOLHrRxfO7daRT7AyNNi9Szf2Xbk1NOXIBZD6cZwA/mjrWwceaNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2zdQWpAhFBzllRBXMQLHrMJrKHDai8cKGieZbH4LNE=;
 b=raTnQrlEs56+1wjlpx53fiqSv7fZQlq0rgRpiqLOgCBGa/t5UZNHPuHbveAARrtOinwCN+Mxe2P94L+8BIUwR5dAQFYR75AIGwlY8UPyjtVbhr3lBUu6B6pBOr+KIvXbGwV7t3lGmMzdZl+os5CywswM6+Sj7mmkalrkrw1uXYc=
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 06:18:49 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::71) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 06:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:18:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:18:48 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next v4 0/5] ionic: Expose more port stats to ethtool
Date: Tue, 9 Jun 2026 23:18:25 -0700
Message-ID: <20260610061830.51037-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f91d44-c6ef-4b27-d4a2-08dec6b822ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1qoVqZuJJ4PD0+WWLyfxmpfsT+f0RPLP1eU2vx/9z08frHID7peKLNUeGOhuzW3knixGsBv7sCOChyTGdvj9ypqtV1q/r8IcQtNNZdE6vnR8HnyjiVrRlPYW0gQvD6v2Tlkc02jhEvAJ42yb4Y+vuvIHItg1vjqiaMT6gv2ywFSuaWHhwk8/5Qd5GmRHzwMG0UBnDutaavDFujkCK4FFCBFNDU4ssnlXyBFDWHO7JJoQSHxUDU0QkM5VZoSxkweIEzhYoRwVMwzynX/RX5eiNNlLlCF/Q0f1UmBF2+qGyPuUbV1RE81yyC5EfZyA/lgCTbasvYuFdoKRIhOwZgsLleR2SsnaEwSuJheXHjE0NKpi/Ds6jmGavzEXlfXtIHXtD4aGrXGgCsb+0JVP8Zn8D+QSiUsPbPvv2Qs1kBUGN5Q0NvY5xX8gae9p/0KuBHl6FXDxRSoIl9FQ2N+LITexkrHma1mU8x7EJgBH2wEbtXLm/W+NnywOkIUAEKWQr6xlkf8evY9kWeEFkt5S2g7VuoRdkVuq3g/b1+17FdymZP8Pxw3ehINucgyg3yevwj9nA8E87ouFR6f0neL8ooqz38I6QZrVxx5QNX9bZ3hZQEBkuvgLuB0rIuUqFrkXEJOzY6f2OKnjgQkQLPcv+2lcaGpDulxdgNAEsdoThR7YfLC0FzZXxRFkMFXOcCV80m4yIl4V9RBlVxZTSoaiNZRPCP7hUQz2OznE/9uyiXJBeuQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Yn3S+BcS5WN0FwHTGL17oG3h1AIjcfqoa0yqPcq1q3abTCgh1VaXgN4j42o9xl/Yy3IqZ3I7JlzNwvLfY2yZmrhwLoUN2wrY3c9cZ1Rgub6UH12T1MzUVwBSDzesbh3USARb8bQSo6We/3qBse0tf0DDtZyHGXyGWzh6QrpB/DFDI+r5g3gwkWtsHf6hkD3oI/+V25/Ohmng27T1cB124TsN+37gWh4MFhVFWgI6p99sg6RDgxJetDd0WPPLDFWELXpurt4X4U5hrUro+8Z10jePjZjSKC+Q4SnFtGCVfoG6CkMZfY3HFEtxSJzgiw9fjLhtcWEbteDbynilovJbKJcux8nznXqagRo4XM0ejj9Gf9r0LdBNS64xSOu8dePddbKlKEfPXn7gA5PtvGC8ohuX3V3XwwHTGkHawPdN9Eu4VcBeUucvSv/tzRbGnn6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:18:49.0990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f91d44-c6ef-4b27-d4a2-08dec6b822ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297472-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3153666358

The primary aim of this patchset is to support the reporting of new port
statistics (and one old one) that firmware sends to the driver; these
include general FEC codeword stats and the FEC histogram. A scheme for
these extra stats is introduced in order to prevent devices that don't
support these new statistics from unconditionally setting them or
reporting them in ethtool.

---
v4:
- A big addition is a new scheme where the driver will only report the
  new statistics supported by firmware if the firmware sets the statistic
  value to something that isn't invalid; more details in patch 3, and this
  is used in patch 5 to prevent FEC stats from being unconditionally
  reported on devices/firmware versions that don't support these stats.
- The link_down_count from firmware mentioned in v2 was moved back to an
  entry in the general ethtool statistics; the existing driver-calculated
  value for the ethtool ext link is more appropriate due to the firmware
  value being a small size and not resetting between driver loads.
- Add netdev_err_once() call recommended by Sashiko for ethtool handler
- Drop devcmd retry logic patch from previous versions for now;
  explicitly include Brett's patch from another patchset to fix the
  ionic_get_link_ext_stats() PF/VF check

v3:
Address issues mostly found by Sashiko:
- Fix potential return of uninitialized variable in __ionic_dev_cmd_wait()
- Fix bounds of wait in __ionic_dev_cmd_wait() to prevent function from
  giving up prematurely now that the wait period has changed
- Add NULL check to ionic_get_link_ext_stats(), following the example set by
  ionic_get_link_ksettings()
- Add missing le16_to_cpu() when copying link_down_count from firmware

v2:
- Add missing cpu_to_le64() to FEC histogram stat assignment
- Remove unused pb_stats field that's replaced by the new FEC/extra stats
- Replace ethtool ext link stat with firmware stat instead of adding
  the firmware stat to general ethtool statistics; remove old driver
  calculated stat
- Add explanation for what EAGAIN return value could be used for in
  commit message

Brett Creeley (1):
  ionic: Fix check in ionic_get_link_ext_stats

Eric Joyner (4):
  ionic: Update ionic_if.h with new extra port stats
  ionic: Report "rx_bits_phy" stat to ethtool
  ionic: Report "link_down_events_phy" in ethtool statistics
  ionic: Add .get_fec_stats ethtool handler

 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 83 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_if.h    | 39 +++------
 .../net/ethernet/pensando/ionic/ionic_main.c  |  6 ++
 .../net/ethernet/pensando/ionic/ionic_stats.c | 64 +++++++++++++-
 5 files changed, 164 insertions(+), 29 deletions(-)


base-commit: 93790c374b9d77f3db15786d7d432872d92751cf
-- 
2.17.1


