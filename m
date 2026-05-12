Return-Path: <netdev+bounces-287337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH58HbStA2rj8wEAu9opvQ
	(envelope-from <netdev+bounces-287337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8252B0BF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A177305887D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D383A5442;
	Tue, 12 May 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGvXMuUi"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A514394499
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625881; cv=fail; b=N94zcHBVcN18NnlgPPVrDu6++JnsEcmpaGrq3U5BGSu/CPV/io/PtMpx2pERbhYrftr/K8Mjbx+4Qsm5pBGOxxlP3bSyzR+itv/n1a4hpJmqY/RtQ/ghvrRfzxrv7KLMj2kmEj1v1d4b71X6PRjzdXS6Si0ztTPdznc37HQSP+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625881; c=relaxed/simple;
	bh=+AFHqOZ2gN8+mXd/u0C1ijzEa+59JT/btVaV1ps93VY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kBZzFP3Xdbs1eJGOMTQTavxlKwh2R83HXZSecqC2qKQpdxffPVfbMtzqx75ht7T4DRO2/6Fnfl1dp1RTsNI5Aap3kyUqPmZVeKwll1nKTn1BwG76Id7Rh6EzvIMFyOVgygYkAYZUfwM5spot3LMjoDai5BeysCnI4qLg1+UtAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oGvXMuUi; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AliQqBU+YpN0ohkKd7zamsF1V68NJtqFMKO8KCIjitkb4KYUcwecy3cp9uea7JMhIljUZF+Vhj270PkPm+W6oVxv8VeCMb9GzbbkCkBtTLdqKIyQz7cGceYIo+HmWgDgbJYYqCr+vb8nCS83BfxLNV/RetsY4GgKx7zQjYDedl/bIclQMEXcQ0LXYbWdT2sqzqzf7b0FX4cSZ2+Z7qZmPLs5xa3Sro1txnmKteG+Zle90Rl7u5N+GSe0yRd2bltorjclDnwaO/jv8W5yQ8j0gQXKHyYziZUOUuMNkhXfD8kOuUwMP5RfcK6hhn3oNerRlVJVjAWjsnuOaSc+mKEm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIDvGUMuVLi9TVgil8EW4IBl5uSBwngkjF0bDXjF7Og=;
 b=v/W6uoOjNQNgmJd/SayrvoJtoENMPVdu3gsKfP5WH4PG/jKJ6/HGbvkfQF4xuFcJXy5oRzwujD/FklzCGIkjDPeHRIT+fGpiT7ipDm1qUX+4zZXt2JitVkYZBNFF9yQfrPLv74h7+aR365X/zpigNPQYAkqHuxpFqBrUbxNjk9j4dlynqTx5pYZVrHTpf7t1r4XI6FZdRcfxGoTKbTIyQyY3nqTkv2ReeW84lJBuG16WT3DuhxCEQUiEkEQBF4cFVbOsqTUJF7h6bnSFommfQrH3diuyoNJW+S+rsVCQg/egNnTb5jsEejEoSDsICt8qX4O9oP6dkQjHhZyuaMomeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIDvGUMuVLi9TVgil8EW4IBl5uSBwngkjF0bDXjF7Og=;
 b=oGvXMuUiixbNU+eWSvaLuOiu9SRQiuWGYkaDJJ7mQReyvDxa1mXwspPewe28lIeBxdEi5HX0Rk7LfRJGhI5OPBgBDWRazzaSchTyoXF9jm9OwKK1bAUKdIFUVPKB0d1GxdPuqhhtpaZyWNlfnwLXtChNBXq40qrC0zx3z6HOPbU=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:44:35 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::88) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 22:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:34 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 0/5] Expose more port stats to ethtool
Date: Tue, 12 May 2026 15:44:16 -0700
Message-ID: <20260512224421.25236-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c9bed7-b357-4dce-8461-08deb0780a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LUyQLqhxv3Dc3PpKVwAApTOF6lWi7OTZB0DbZbh2hXP+eNk60Kjv/qlVOeem7BMMvQb78c0LroL1mk+JR0T/cZ54DhVlt9R5X/RjaxfB4C+ImS5ZwkXjt7YRe2K0lLO4wAZFz+AmBC7O3SGSGPCJMQpKsCj6E31gC1uLXqnIdsZHyuHizZHSUs+ukfAAIje6nOfwrVaFuTq1L0QkXrWwjCUgjJt7hStMvUvYYV80jzMDW/nOjq3wCQzlEvdAxYg8lG+Oe27UUXNMvYiDdahUGPcpflpFX928L1rAzoutA+6yfw2iRdX+wbcyLw6vsce8n3ZZp46wc6LCVrUxcx6hPrORRJOxnqWAlRui+R+wx93dm8nOUNsHO033IH1xgdsZgspsHKAZi91OfFoFEaAheaxJEHGRpkQjwmVLjyGyb93mHmmN2ecPIMkO0gmMvd+M8LonPhEmtNQ4TNAMRjrRaRr7ZeWq/SxqBD4oMBXc22ubhl9kK3rrjNVX3q4h80A+uDgmnQlu096V+v71Gs6VcgcEGTS4xE+N7Q2HhSjx5Ohs+E/tbZa72xQlXchIXLUSpp7tghKEYZDvM0oi19wEH0fz/z8YadtUVwg1Bb8NwyS/78uzYsZEDWjnmqKD+E2fmRZ/5z1RhhfCGU/oyoWPjrlv5xUYuxRLLl4inPj8TCBnvfNeErqAOAjhdUdrRb1WAtA/olyCEzwEq0exJwEwvKhp5GYMfDfk51XnT4GqFgY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UwbrjNGWS0nQrFI54TWDCBggT6duDdKqqNopBMM456KF/jTdwA0giGBkWrxgc9thy2VJw2kET16orLfONkuBnRBlh8KqTZfKT8XsQ8T7NIjZ9Nikvh3hXf961JlNTyBj1IfXBxc6LAFs28rM9ETj+4u+9brRBdxN7CgOYbmdxETl/Nm0EqE7vXoxOv8z2SYCOpqTHVS32pOxZnclApksffLxmCE7RywzWKAoeA+j3MwbC9DUrjw/ghDUeTddt6dcjYV75kbtHbEw6EGg7Wr2J9wIaL5dBCbDfTsOB16/Q6oaTYvnodrrYuo28ihzY/trohbhuzwlnPgS9DHNUB0Y0JRwOjTeJSJV59HP85jel+sNgZDLjuMlm3DnHc/6Wdrnwr1qyO9gBq68uzrdybLDYxZTVZ0dK0TZ5YUNIw0HlLyelJplheyBIUd1SMaLNs6V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:35.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c9bed7-b357-4dce-8461-08deb0780a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
X-Rspamd-Queue-Id: 1AF8252B0BF
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
	TAGGED_FROM(0.00)[bounces-287337-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Newer hardware collects a lot more FEC statistics than older hardware;
these include FEC histograms and corrected/uncorrected word and bit
totals. This patchset adds plumbing to pass these through to ethtool
along with another link_down_count stat that is another port-level stat.
That link_down_count was already being sent to the driver by the
firmware; it just wasn't used.

Brett's patch is a small unrelated improvement to devcmd handling that's
still nice to have and will help enable deferred probe functionality.

---
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
  ionic: Small improvements in devcmd retry logic

Eric Joyner (4):
  ionic: Get "link_down_count" ext link stat from firmware
  ionic: Update ionic_if.h with new extra port stats structure
  ionic: Report rx_bits_phy stat to ethtool
  ionic: Add .get_fec_stats ethtool handler

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 63 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_if.h    | 36 +++--------
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  1 -
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 -
 .../net/ethernet/pensando/ionic/ionic_main.c  | 11 +++-
 .../net/ethernet/pensando/ionic/ionic_stats.c | 15 ++++-
 6 files changed, 93 insertions(+), 34 deletions(-)


base-commit: 8c699be3dad7bba87cdda485dc099226cfc2f706
-- 
2.17.1


