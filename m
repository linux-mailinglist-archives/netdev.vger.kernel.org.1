Return-Path: <netdev+bounces-283077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ebs2NQsb9GnZ+QEAu9opvQ
	(envelope-from <netdev+bounces-283077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDE4A9E48
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7333016EF8
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141C1E1E16;
	Fri,  1 May 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sC+NOuQ/"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F2199949
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777605384; cv=fail; b=Dw+MOmEbrg1WREdryGjqVPKA4hN27mTycp5OIiapqwUXslkZI5AjwEK/Eh93kqDjj83tjD3fvWoepGZGrZ4lxcr9PV5NQjNtQ1kFdFk2XkDmaSqcHqgbcWPVGDqNZwEHo/oMZ8U0PO+/VxsKERTvxm7pVMgjiqdn/Li1nRY5djs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777605384; c=relaxed/simple;
	bh=iYyVWrRskaTkU6bV4nO+KWLE2Ku+vbU9n9GZv6Xpeec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNMEr8vpp3mRfVU6pCf6Ea7wgmecDFsrWfC9vJSflkC+z4mgj58XZe0iafCl3PobASEliYrjHJLnOaq8yWKj35fQYZfwwRXqmjIOAWlUJR+0wo+VJG3PqEbg7cd13kpQBv/W1iKbLcx6zit8shCBQMIQ3aZP61aRTmwpQGa4V3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sC+NOuQ/; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9i8V3er0TLZfHgG/xbVz3bGtY5XQW+EIgyin2/0NrNtPTKyjKGXeas7V8YPwBM+qizzax4u08hXAObLwb9URD9mUwXMdi5RzzcyCK5palvU1W40zyPEFBBHvK4sR0XIxpFuyWvpeJJ2X9gHlz3FS761n4cBGfXv2ecaOQi53je0nNC2fTpXByX0A7FWbK8CzBQvpKahFqss4oZ5u2l0Z1Gwsmj1Fxd317HRvBEb7PJHwGrpGqoM933hGYzmtNJE19SHCvLDaX9gIl0SV6CiUCbR957uBzKAwzc6mazB+7D3MU72DuGAJotb1AgfhdvQB0YcdFrgR79TtYvoDL11iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB6v/3g/Ex/Oqivvp9HuWm1+b5G90npW7qDJsPDSsrE=;
 b=CG3JBS1zAcfwyK13wiIc+dFFHVCgFsJY+LYg4TliQNADlCwablAI1I/jxDgDsqTpC4gLgwiHt2gK7odCnOKwjgJvQlzG5GsnfulXZlpqamHRAEIIb8vHkkyw6I4JCBPFtC77mMD0cZWxDnQJmJH7l1QhMbe/z5pdu8Qn7mE7Gtvu6YI72WsOJRFFlWNJUz7eQKIOVRTDcz4smvWOb1hjhitPxw1FHEqRMgTGXgmpsHmNTOWGUoV4qnEdLQUqQxBphKj1ggsHIgK6Gd2JsBOdr/+Joap2UbR+3z+2tJN9cwBe8NOs8SyOGYf1xD3iRDZ6MXqSXxQ7RW6PRGYAUw60YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB6v/3g/Ex/Oqivvp9HuWm1+b5G90npW7qDJsPDSsrE=;
 b=sC+NOuQ/TWHdIMy3tsH9z8109RDjQCQhWaCsd8qb9QNIWMY/JJ0JO9dBYdzC5VtUTUEOoj9H/leFdg/KStLmOhzpx5iLmsw3kcUwJg0Z9cQgRl6ks7PZp6zb8zqPx52MjsXH9CBzabDDSUwEpa3vl26GTYh+5x9QL3qCyeuY5p0=
Received: from SA9PR10CA0008.namprd10.prod.outlook.com (2603:10b6:806:a7::13)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 03:16:18 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::b9) by SA9PR10CA0008.outlook.office365.com
 (2603:10b6:806:a7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Fri,
 1 May 2026 03:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Fri, 1 May 2026 03:16:17 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 22:16:16 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 0/5] Expose more port stats to ethtool
Date: Thu, 30 Apr 2026 20:15:50 -0700
Message-ID: <20260501031555.43259-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c20d9ff-863d-42f3-cbd5-08dea7300297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RVO/HevRDfELamHzImAtnK2HaxQicjGOJU9z/Os5PExZPyGc0G4h+50rkJ3oLSbxtjzCsq1xWOnOIpMbrvW9g6IQpElOWQn8VnwIVAWbeWu8JKv1WALbGujyHhFblYqiRk81uo3eXt8jDfMxMKP+ZxcI0xGmK7LhVr0WlKFa1Yk3oJ/9AoBxIiGP6g6pTOLDvqubktbfL6I0zJ4pbfScpO2OD/ShuckN+uC9XW/Q+2Czs3Wwa0EWeJcp5gNoen14JuEnX4xLwalYbV65/W+kdxS0XZzdD20HWttu9gyNtq/yqdPb68rgfIdZyIBtl64Zmxe6IIyX+oi/yQsSgfZtGoDXEzdz4iEjqpusHvcppx/f0ozGi1eSIIm4D3X8SjysMOxXhSv6xgi7/Trm2LQlc+T1ifV+F/iuYTTc1JWpqyVl8ke0KqYzIHD7td30Ab0rpJamSEk/RlJ2mW+9IxgbxHI671bWYzoZS6DwkCOaElM3/qbJLGE/KV27KNCNIPSXHssSWyc9YlGHwjYzFkFGtuvQXD/pVS0rV2rjXBfBLGP+NvSuDl2I8v5i1w0BPoLfLPG9kD2zaElr94lXeBvODgi6008UJBDC/d0hlN8Ak/OPHPSkhE7Iontd0YSdDe1KvCD/i60QOJ/toAufHJA1Et7J2W9I7k1ZppiUtRg2azewlrPwnMB9E9i6vv9wLtMqHZg0hpzluJaSYWKmN8HnBLzcrUIihsJGExDKzyuB97I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tN5RWaQ3s2bXQVVrQfVNZbH/1RziR8+8kY9R6K1uDFYn/wpE0nsJ+ZpJBdGyp/25vh8OEyjBTJGo8DY9qC0YCR2XJusUDviz2BGn6k5Ht7u3nApKSYMiWffZFpSUZlXD7yGolxTf1yTbfnf0Qm2laEGPVeID6i9deIWsh+henHOqr0O+G2n4EhzmQCjj3QkfzbxwbeK0f3/+FobszlFi2aVap/RtxeuzMHxg4kq747LUPQlF4OH91JpNgIs9qe+VujVSK+nXVxsin4BzK6u19m0/LMsfchqsS4jSgL2XsAoBxiM0B2mtMKOrbieBowLiwKgBAyjvOZ2FZasYuXBTbLBOeTJVbgncDrOtudq9QCYzlhJajUt27pixcHnHZ67uJ9hBoTmCrY+wTRpIgkz5nE7PsybNC4UALFmD/Vksm5nUv09XVVfSfVnHMo7OEirS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 03:16:17.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c20d9ff-863d-42f3-cbd5-08dea7300297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Rspamd-Queue-Id: 2EFDE4A9E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

Newer hardware collects a lot more FEC statistics than older hardware; these
include FEC histograms and corrected/uncorrected word and bit totals. This
patchset adds plumbing to pass these through to ethtool along with another
link_down_count stat that is another port-level stat. That link_down_count was
already being sent to the driver; it just wasn't exposed outside of the driver.

Brett's patch is a small unrelated improvement to devcmd handling that's
still nice to have.

Brett Creeley (1):
  ionic: Small improvements in devcmd retry logic

Eric Joyner (4):
  ionic: Report "link_down_events_phy" in ethtool statistics
  ionic: Update ionic_if.h with new extra port stats structure
  ionic: Report rx_bits_phy stat to ethtool
  ionic: Add .get_fec_stats ethtool handler

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_if.h    | 13 +++--
 .../net/ethernet/pensando/ionic/ionic_main.c  |  7 ++-
 .../net/ethernet/pensando/ionic/ionic_stats.c | 18 ++++++-
 4 files changed, 84 insertions(+), 5 deletions(-)


base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
-- 
2.17.1


