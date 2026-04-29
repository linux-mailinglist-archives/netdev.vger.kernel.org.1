Return-Path: <netdev+bounces-282487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIHiCPdx8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:02:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CB49A537
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AB03018BD0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F34274FDF;
	Wed, 29 Apr 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JJ2MEQvN"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BA26ED5D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496452; cv=fail; b=R/NgQhwLcmABGHtNyyhcb6VJV1/vb0jd7skUn5Bbab9waOhCvcR+I8E0DZD2inpadXd2SFnyOVxSqirLWI8ZRquzLsuCnK/P6VzHwP8gDXWNiJVVJJb+SuIUY2ti0NgqMtF6QuHVMT9+E9WonSmbI0anNz8DdbjQ0Uqoj5W6eBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496452; c=relaxed/simple;
	bh=KKvccr7G1Hx+F/+4Tz2OgebWewx1BQkmwHwEmOtfjyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJOFSyQpFt9jh3M+s3u6ipJuHqTPDhjw3Ir9HZ1kINbCIZC7bFzBBkH14y/7FLxADeExumX9iktJeqE9ZuxXHnSt5BFyJcbGZ3pP4K3p4Wxe16WlLs9z3YU7CKD570tnk4YRMWc2tRUT5/dP5RFsgTmGL/zJM6ZZhxoXaFCyQmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JJ2MEQvN; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd1c330+c2bh8DajK8UGTUBTG03C+aBxwB9P9GyVM33IoEmWWUVLh9/KtKs8x87oHAykS+hZzI5eq/yH406Ofsfr1LZEdnRRR2eS1wfpacjb6Im9RXUN6wOARCb5PLA9kX8V2wxJM9beM+Z9xHp3KJeo538MegaJiP78qRcWAVQEtUXbMr6A4JjzZCRGgoEZ6sdy8c5dSobfRSL9VRqPoF6WVP+71AuptYt0t/htJvrIivJ2ilxFI3XC7A6uubgnjUPnDmzHOpYr59V49tFqO1qjxObuKKaAL0xUmZ02WuP9oTiUCOOch2H/Fh9YwQTyBj48bs5VhVaN5P4GN4Gy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgwGA1ETiwPmmvNORs1DM8Bsn8J9vzL2l5xCmBh7Cog=;
 b=y4a3QGlN2pFnv2TRn3zkL/LgV/19/K4XKJueiWxbpniPojjv64uwLaIQD9g+Q1Q411jXrBkovL43hxbwWnOWI/rvDq7ZueQAV9MnGEZxFr07juLQ5aPawvSQTmfHb8nnqObezJNEYzPNEAV4PuMiojduMqx9nsZYy+W5YGHBKVIY2eS/DB0K7CyzZ+tOHaaGHrHQSO09sb4yf6q2FmkD2l/y+hOalulQePZXHfvZi2kJ5WiRya6fkRcRhA/Et5uW9uEk4fn1Ij3vFMGKgKA9bzFVlHMp6JU1HLDxobGZYU3c7A4I6xXYhACM5OHjvWFy/JPaLxAVkZ3yWAPFlhdlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgwGA1ETiwPmmvNORs1DM8Bsn8J9vzL2l5xCmBh7Cog=;
 b=JJ2MEQvN11eDIdJbLJ2eD+3rrx+CKJZRJZH9GhlhDSUhwyH7wUMup+1C7P5B1xS3L8wlvuNsz4hzPHtQ44IgxrMTQ6CvOnLmCSMGfAn9suCXW3J/XoYCKAAfXbNEybGORMQXb7E6bkiNpFox5s9/cECyDq06pEKlPkNkj5VSheA=
Received: from SJ0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:a03:33e::19)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 21:00:45 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::20) by SJ0PR03CA0044.outlook.office365.com
 (2603:10b6:a03:33e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 21:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:00:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:00:43 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 0/7] ionic: Various bugfixes
Date: Wed, 29 Apr 2026 14:00:00 -0700
Message-ID: <20260429210007.40015-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a6d40da-6ded-4047-a1f0-08dea6326177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VsEc8TE7m9zyFY6ArE6TiYtcmtWDRxzdOSCE/LS8cNsM3GUGdeXtECUSryTYPIYocskwyPvdIIYy7gl806HGmnnxbQ6kn+2vuK5RVNbHG/xeSIKRvdpMrekB8wL3cgrF2WjqjwoW0MhQMvBvg9OP7jQlb2uI69gfTf3GVoZxu6ItpLaitGnnv/ruUuOFbTULI7spfRZvbvZvQIjzBag+dbWlEuKbla64ebNvu8zjJlAKEQgEP9uhvZeAezZaBqgUBsUE7dUwWDkYg0tiOhrblVnwHrFcw2drpLDAn5UBLuURFj4lZmTpKbQBZh9PArX+7sH6ShcdJH0bPpICYV0YXp+IWElIyhXGdwQx7t8HkynF5BeP7L9GnbZnyrSqPByRYk+0DSfgRafvW2t2kDm+1eTH0EiMsNX1RRsPLNOfsXCPN9lR6ltmjkWVGSa3BAtLNUOf7nYPiBBYx++fXoOsZDkmJC+H1WzLDNKJIYEFazhMomyPD4Fwv0IjfcPOATE8zxn0m6JQYbyJWeSFVkU0k8BmnYZgyH2ezifBI8V3POs+PpFjk6Rmhx+/Nv9ZcmDnjK476uKcF6d59hedRoBzYWLh0GOzFAwUiJGE6oazw1Qtr/giC4xg4OE30JAUFtPHl3bt5xN5CerbZEDhOWlmJ6wZ9dTT7CxrB50T/jU/9EZ9i3xIKIbz6KvvVfidPn74tGKud36ETYorv5NJ6rhicq6kbawhE9yeKOTdoAhSJKIStV8/RoVQjEjJcfuy3CGCEBMidHyo0glBklYVKT09AQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iAOxpwbs1PTf534lRQNmqr1o+N+L3XHfZjmDowewBLLclDZDixA02VUMSyLaBuLX+uaT/sTjvp9EyiXuj+XcpnMBGwGOo2TOs/jJe2xfVf3WSgfn9EAStW7dlUtfMKn+M+zXX/yeBVQkaRWFFU8f1oCRCfCfvBaSNzLMgO3s0SFunZo0iqiWZ7IONgUjPLdeKMzdXihzZrpO+C6GDaeOut8nAwesxOO80W7yEJxp3nY6+xGk9kcEkFwKVQ997oq+IWcslQWDI5kmivRE4SbQ6GfM7p9iTOh1LjymRIvRKqbbo9Xr8bZMPD7dL6hFLNZYqUEYZwCj/OHdpYsF+ca4kC9YTasBXA0F+wDjGvHsyKQBNa8uS9e7ksx2F1xvj0xLm6yiW0d5gEbJaI6BXAUtnjWFZSC7D+Jv0j+tBiBfwVH3DDQU00Qi1jr4ILhNq0bz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:00:44.6052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6d40da-6ded-4047-a1f0-08dea6326177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-Rspamd-Queue-Id: 983CB49A537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282487-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Brett's patches mostly fix issues around communication and configuration
between the firmware and the driver; the last two are related and were
found after an incorrectly operating firmware caused Admin Queue
commands to time out. This issue and the rest are fixes to issues that
we've observed internally.

Prabu's patch is critical for enabling PTP/HW timestamping to work
correctly when the completion queue entries are double-sized; the offset
into the descriptor to read the HW timestamp is incorrect when in that
mode.

Brett Creeley (6):
  ionic: Allow the first devcmd to trigger deferred probe
  ionic: Handle failures from ionic_reset() when relevant
  ionic: Fix unexpected dev_cmd failures
  ionic: Fix check in ionic_get_link_ext_stats
  ionic: fix adminq use-after-free on command timeout
  ionic: service adminq CQ before cancelling to avoid false timeouts

Prabu Thayalan (1):
  ionic: fix completion descriptor access with 2x desc size

 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  8 +-
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  6 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  | 74 +++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 +++----
 5 files changed, 96 insertions(+), 23 deletions(-)


base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
-- 
2.17.1


