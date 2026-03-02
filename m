Return-Path: <netdev+bounces-262485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNcSAdoVpWmL2QUAu9opvQ
	(envelope-from <netdev+bounces-262485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:45:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9B1D2FC6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1DEA300B58C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FF2701D1;
	Mon,  2 Mar 2026 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zENcn9gD"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7B1339B1;
	Mon,  2 Mar 2026 04:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772426711; cv=fail; b=IN9c3Ak2F/sqOQDcI+68/u6LfttHJon6F/vqCntUkVHeHKA7lJ5MbRkBPWpCioccCr6MadUwQw8u1rsnUNH8ztdICaE/qSOxt9FwICpb+ux2wpOvtcTFqtDPK60qSy8irkLIhDHNIUmCR1AovevTL9l4p2kzqbwvSBGC2OWbgKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772426711; c=relaxed/simple;
	bh=bl5LhlB/e8ABn/4rQ6Ecc4j/r8V3Pm0MPaoUuA56+yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvjcg6jECUdU0FqNfgEm83REN1Z2j8SnTzqJj1K03GBdtg1V4zVyZmEYQPh3kJ//LRgCEqScNBEfV9qzXgsuGm254aIJnpLGWwoR58Jfp5r5KR4ByLC+zmlLv3yTKno2jDPYNhQHHN1TMAvZXIH9AxUrHaullWXWyr9ZBErwGg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zENcn9gD; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRDJQ+N6oWU2IxXWFX1srgenroeiULeQj+wM6ZRYuWoxqELmAS/0uWeTljAtNw69dNszNUJKTKAeNqelCZoFLrTkiFBJqsjB6k7+uF0tMlD+seeOtqUU42NCuEPknQLtjmF/OsYX8DRScbmWTbnO7tmsGG8UIo7xoFhyvdc1Xc1bd0nmoV8RzmuxokOsStkERbhoqxV55vTVeXpUPnaxXWmjzta8YSywcCD/e4ShY9EffVtuYqCOMGmL2SZvHAIlgWvUWYrCxe2EUhenmZC1Nu7ZUonXtUvRCpOXpJlb6SOQYaRRJsm48szyN+5BUnAHofbiWdZFb9IRsuidEdFlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpvIhhbwUDeFtWszu5ZU5sxFEAfsx50Rln2E/vcTL2E=;
 b=B/AH9cukTz6kBkTM3ONDov8A4pCrBqRcuJAAkTwip5lom5qqo+W+8iX2VWtMZrGMtVO1ZRlH06Wk+JMEJfIFWn/nv7CMNcfadep7xNKO8JhfoTG0LQDBQp/UIj2LJ6y6sslnVS4FnjkCfbsKdQ6NPrXhaC88IuUjWoUvKyc+TlAD10DNeK80RK7O4nvZlVjKmrwgMPXo/HzIgiFWGYgq6p7HGsektPOE7mUjY+ihDkNmUZsr+jX65ISlDQiJJHna9YqVNNs0CerU/2epnCaEiGCO6SbnXPKoUGAPCYZGz8YvEtFwIJGz3/AP3suGdicKd5MelX9yZXALWgeYBSeFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpvIhhbwUDeFtWszu5ZU5sxFEAfsx50Rln2E/vcTL2E=;
 b=zENcn9gD2QjnxKqdp3iPGqhx8vuuobbU9uwO6cU4JUnjNx6yyYq/l8L8l7tY1RIf7R1SfI0SehOWBaUpijO7TXer/rQEUL8wFWfuM+IGOS8xh5y18L6Kk6Bk+yAEvhI2qI/QOPLQXS9/d15llAQb8p+xP13t3B55orQEeJCsvj8=
Received: from MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 04:45:07 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::f9) by MN2PR11CA0015.outlook.office365.com
 (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 04:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 04:45:06 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Mar
 2026 22:45:04 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 0/2] amd-xgbe: add support for P100a platform
Date: Mon, 2 Mar 2026 10:14:07 +0530
Message-ID: <20260302044409.1388430-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 425e841a-30d6-4383-8459-08de78167a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	2JGyjCDJOi+RtzdilhmfqrdfnQk4aFBP8MGq3qE5lakS37anhBQiXhPkqnvDYS9paSj1rIobyBEwlO0bATgHvdPATDJ5pknX2vw3If+bLhjT9a6L8BjDdH3dJoErbqReHnKJT/bjkvl+lf+JA62M2Dt+kQEFgS8PzO6URy0TOXyazn73Z0uhrSrixBMNSLLPseKg+X45rlpcsuktNYafhNFIY6x0UNYxhDbXurThBRWvl3H6+hA37pziJvT/hH9Lsh49T1LvyOP1D3t7RSNoGWZhz99HEco5wI63C0FXUlskt2CX1jO156hXv0z8Ihe828ceHYPIdovXYV6DD7xnvONSQtv5F7abIQho+I95OMvdc4Up/e83hXMk8aULdlopMdXVOLBGv16/6ejwF59HkDTe3dZ5LgIORuZR/Ydgj1HH6WDy9y09P5+BF58eytHfZkzf4a8XKwxHqqCZ4GmV4QotHicpfwaMuuSz/DtXSLdU0yUBLnDx/8QnaLBYGsqeuf9PILjU/HDZ9/u8nH+lLk1GMBWB/EY3yUC9IJqb6vSBJka8sT2GePjzNUj0x7s5Npu82E5gtAW+kbiaV62Vo4k3CKlxqfTVtlBXngQHLijp2W0AiIrmlPWD31aleUWzfElQIYVBTO5zpKVkNm4HlnmwzUnPwZqD02AwGUJDMZKCNhWec6x5ODFPcbgl8FIWte8UWaeHuysIVC0oyqoLtxLPR/lAXFf2rytdTTanZWe3QJGrGPrnvlfyoJ4P6pDjuAQzDuwK3+d6aPbqGpNWyVB+vgseM3FceVW82LJFnyIrlhG8j0m+l8ViDtuw7688
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ypi6Tn+ZPvVsGGPjVH7VFXMdXQSxuAPF1IrAROHILhwvNqAJEf2UPKoXkNjHi8F6PGFFq/0GLj+MQGO4xt9aZpeCBuPOLBw9EAFwpkSvVxYqO+SRPBiQ0y+TaJYd7z7UP6m3uw+NExd7Lb15cLLON4N+6/5rWCblqGfRsZFwS7Qj09lNCryNfEf2jhkghtzuh9LPGLXx2+ARSie9vH5OPP6EdBXXuBs50m+mhxIvG7kKLzoT9klrpSxS6VQ6nPIonIKFsWxPASA4nNcj5bLRkZLl9zEaFCVuC0F/9Bkqh7NOPqZWU9B7B46FR+XMURmt0yMrMGWJvybO4MiyTSqKynFW3ukUQQ3r96FrTpCniISwe26oJxJFCyUDP9MykGVBg2p+doTmtbn65tq2Lxb+8uYczkELY3sP6v4cLd9DYQhVy43yMou5ZFLOHmE1/RAZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 04:45:06.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425e841a-30d6-4383-8459-08de78167a36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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
	TAGGED_FROM(0.00)[bounces-262485-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B6E9B1D2FC6
X-Rspamd-Action: no action

This patch series adds support for the AMD P100a platform featuring
the ethernet controller PCI device ID 0x1122.

The P100a platform uses different register access patterns and speed
encoding compared to previous generation hardware (Yellow Carp,etc.)
Key differences include:

1. Different XPCS window offset calculation due to changed memory mapping
2. 2.5G speed uses XGMII mode (ss=0x06) instead of GMII (ss=0x02)
3. Extended port speed bits (6-bit instead of 5-bit) for 5G support

The series is organized as follows:

Patch 1: Defines macros for MAC version numbers and speed select values
         to replace hardcoded magic numbers

Patch 2: Adds the core P100a platform support with PCI ID,
         register configuration, and version-specific behavior

Tested on AMD P100a platform verifying:
- 10G/2.5G/1G/100M link establishment
- PHY initialization and auto-negotiation
- No register access errors

Raju Rangoju (2):
  amd-xgbe: define macros for MAC versions and speed select values
  amd-xgbe: add support for P100a platform

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  4 ++-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 39 +++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  8 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 22 ++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 25 ++++++++++++-
 5 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.34.1


