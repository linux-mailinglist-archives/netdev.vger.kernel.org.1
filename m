Return-Path: <netdev+bounces-270514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFNLJ2k1wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E72F21B4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B59303E485
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80539A05D;
	Mon, 23 Mar 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0ge+YDC"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F538B149;
	Mon, 23 Mar 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269437; cv=fail; b=jyHr7eZjB36jaYqtmh/ajgHlz/FIySExXtcEORfASjJ06FPJmsouH12cyXIeiDuusqtd2w8qDch3GK8z0xb2/IQBbomhIMDb7/BKU/dHzXhTyhHGvQ48T3uZUU5mTq64KpsJUVmAfD8kJiuY25MhPCa2fjjkijqLiRpAbPPW5h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269437; c=relaxed/simple;
	bh=eMWY5/Nj8HaV3TsBCD7SraH6Zniidw4cdXBPYJDJHoE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZz02qdRG3fZNZBUA2lBrb3i/HeKLjb0nJ40pJTvaGklgve64FkdfgjFoPVz8H/T4CrPik0aBYfhKpMbNFXGwM3/Tcs0vQ/X4aM6QVUY81ai30rlObDqGSMf07AicWDJFOfS+Nbud0cge+LQUd0RPVw1kAf/R4dBREicRXRIyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0ge+YDC; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqnT75eXKvkodX3VN8QsbkH6TBKurHO/qVzrbCzrbodmXlZ8jiq7Duss53JlkHEDrqHKdeNmBUijdVN5TXLOBXtjd4hw0cE8gR9508LQaVls+LzmqLZSLu5kixd/Y1WENDBnTz8veuew0xkF0SRz9Kee+JM+uwLcnlk1zCUVLeN7Q43R2zadU0SSv2XH/meUYFfhM3SqRHIrX49ppKGpl5uBJ8gN4BInIjZs7648d3dqHV93Pl3rQ+ybj4/BP8XxcpsSLX/nksL5M6qf9WLvZWOpqjxtNBs+a71fd0ih0OxmpIiqoN377d4+7wq7kDTAw9ZCdRMxTudS0osInd56Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXGsLik8yqND3axVZO1CcocU/94ZSdes7aZBrxzg2Ug=;
 b=SLyp6OFWZvHndazKYRYdhGGBBiZpz4CixWukO7lNB/Zjc5fCUMPGslNgrp8T5wboVHy/X63XdPpmfL25858+lMrnf/iCjnGZHAbOXSXvMDfVkOtvhVl8XvmlwUF0Lqh/kYPk+3i3fH/Ex6JXl8UkTNJj4J/2eIBKj7AFLtFEFVmd8q/9jwhzbjyui7QIcc1VKnEA9MKfZi4YGDCug1Dc5BCFond/Z1uNGR+Z0YAHfkPCOYdaUGiCxqhFsh/YBiW7fEjQoLedaL6X/kaZ4ERd6uCfcncgIh13MAFFslPM7o5l3N4HEAVKWXkE8NDQxU2rHm3jBKuJA7NyrD1gVl5g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXGsLik8yqND3axVZO1CcocU/94ZSdes7aZBrxzg2Ug=;
 b=K0ge+YDCUsS/qjx6qNPyG2iY2KIcBbiuhsbevAn77TdIzx6UfB239HmI4XKb0QNjUnVPkp80GJ40Dqsq897aD+1txmWMGiH30qjExtbr5HAh0667kFeI+qvwLVOcgNQHUIDA65TKWxK+//R8/C1bFvbfNNRXZsfOcOglOXsAPewRBda4p3hThGSLSXJJpb6J6oLXszFSmSvuHf/pz7iHCOdC2Es9PtdWFtwNsN+JildWwDWIxB4IK5GcMbQApw5ZrTzjiwV4cF9KhYaPjmNXzJHRyWZt6HjOw3R5GcT2tm6f4jTl3Dt7k66AinuxD6XqdiXhY05SG2miSvgtHN2Gug==
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:37:09 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::83) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:37:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:36:56 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 05:36:52 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in offload mode
Date: Mon, 23 Mar 2026 14:36:30 +0200
Message-ID: <20260323123633.756163-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: a6868801-6cea-431b-e746-08de88d8e685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SmGDMPooWjILpCZKe7QfjhI2HE+enYMOlaABUQ4kfD5Sv4FA8w/NMUmTf9K9pZIfq1bCXc7OKrWQcD0WY9BbxfCuJxsvMe2S6KmQKCvEsvPMUUnPh50y0d/QlnnRiwhE1xZEHjqzyufjtcOBCOcWWKNs+s0TOz0lFO6iyh3QB+kX4p9hqUDxqJELnGKG6cJ9YC/B1Ja7yzUhvYySqrj3GE9lNR3ImtCtlUaDlySbppvLI0xKWXmXg9KbbJqqCoscUndIPjGXOVBQd8yZ0aG5aZdBNS9e+50W+KQdpewOciWwkQ3haBBS2TvOjF+axTxqsmmSzYO08sNGLcT+O0o72TtXXc2XYfKyIP9Lsh1+aB20YguvcT0UsLggUoeelkxdMazDtoO639wKKJTXxVNuyqLMz855GRk7UwFziec9vBrLuDgM6JB2jvqEBfDzpYNxSimJP3Fd/CgMqTiHRa/V3InzCLe3SAsCf+VeC9woVfU6bVryYIaNrEdpO8Yb20UzoNHgrjvoJZSnhUl7UYEF/FrTNc7iTr95pY2XH/9c1rmxvc6BMrE2+GBHT2Tdf/IYeqjbp78R1u0tXlNmGX3UwtGQUOpkJZqYaqrTrgtToYgTZbfZePcndMxbDy3ge89b4FQusASG+zeeLUXLXToChR3nsFt5gOu55Cpfy3bwRAEz/PKWzP2Yfv3sp2g/M0JdCCATRr6A4iIwQvYhF69i+qIDTfPq0VLkQzJoauvFC2MNToKNDk+puX8u3buEXxv/DdTcga5rwP1pyV5y5eOJRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z63W0vOVildqPAM5QcvMVk1gXwznaRODYJbza1Vx7Dwd8maS4R4pgPbyDSQm5dlxsbPgc1j1rqQhzy4yXRm9bZwGVY+MH9HuZVwLd6dXRpJ0odHWKLxxrWYmsj0OnCq8o6ScRW8i349lB1rmfrCMKvorElHAsD4XaVk8Sq6LJit3Nv5K3yogr7GDVS0zEY6KZOAWlawYBfC9cx9Y4e2RgYTL7HZE2WzSKN5OsQpJMZaepLk6/976b1uBspi8gTyhIkprvsaNFqvLNUgAG1q9hlfyLlere/k3Z309vV7OdnKCzVTMhO7biHk3VrEDHjMaWMk1YV43vHYzpQQywdUd2QFidQJ35YoohsiIlyExToO/6PaRFjB/BG24/wrTi8lEUPkuVRn32mfT77398j2AYkEcOccIlJwwLZ0r2r6NXxUGnLgns+P5N5sKV5Nid5cr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:37:09.3745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6868801-6cea-431b-e746-08de88d8e685
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270514-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4A1E72F21B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This short series adds support for VLANs in macsec devices when offload
mode is enabled. This allows VLAN netdevs on top of macsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

As part of this, the existing nsim-only macsec offload tests were
translated to Python so they can run against real HW and new
traffic-based tests were added for VLAN filter propagation, since
there's currently no uAPI to check VLAN filters.

---

V5:
- Merged tests and macsec lib in a single file.
- Fixed Python linter issues.
- Added CONFIG_MACSEC to tools/testing/selftests/drivers/net/config

V4:
- Migrated nsim-only macsec tests to Python, usable against real hw.
- Ran these tests against both nsim and mlx5.
- Gave up on nsim patches since the tests no longer use them.

V3: https://lore.kernel.org/netdev/20260306151004.2862198-1-cratiu@nvidia.com/t/#u
- Moved back to net.
- Added proper rollback support for VLAN filters in case of failure.
- Added VLAN as a requirement for the new macsec tests.

V2: https://lore.kernel.org/netdev/20260227090227.1552512-1-cratiu@nvidia.com/
- Sent to net-next instead of net because of apparent complexity.
- Changed VLAN filtering to only function in offload mode.
- Added tests.

V1: https://lore.kernel.org/netdev/20260107104723.2750725-1-cratiu@nvidia.com/


Cosmin Ratiu (3):
  selftests: Migrate nsim-only MACsec tests to Python
  selftests: Add MACsec VLAN propagation traffic test
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          |  44 ++-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/config    |   1 +
 tools/testing/selftests/drivers/net/macsec.py | 305 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 -------
 6 files changed, 346 insertions(+), 123 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.53.0


