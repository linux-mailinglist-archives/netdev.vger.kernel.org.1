Return-Path: <netdev+bounces-276461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFIpLuRC1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC93BB94F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE84330ED61C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE23BED5F;
	Wed,  8 Apr 2026 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BNyJ2ljo"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873853BB9F4;
	Wed,  8 Apr 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649252; cv=fail; b=hU7HNiSAZ2/VxCPmMxs62r9MBM6DuR1Xv54Tm2kD8FDrf9hLAVZsWJOtetO0iD0QSUL9iTymlvd/mH1gMt1zDlNF50Dfh0nKm1C+2HyjyARH6usDmnk8zF4T3BDengGFRrEixjsYXocTpkrdrzgF+Vf74qzs7Ljrhibd+WEZybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649252; c=relaxed/simple;
	bh=06GvGhF+PhNyrY4/Yu22FNdwU5xXBmSarKVRtNHSLBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aa4m+YeefTa5STgLZqzTsNjEY0HF/yRtx5UnMvcrwvU4FycT3lRSsISdUyQ+cfklZUOxz8Q/MtCObSOSz1OZFqhGzZYU9ovFFBZwE4KKWQVXuaoztMKQSSHPp6sCeoZMdcNUJa6EWG1h0zPMfSTNKrnVIK/qQyqTADH+cLLtoks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BNyJ2ljo; arc=fail smtp.client-ip=52.101.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmktRXe2TBt4PxEyiaYkdxAJX+Dhckl5T/6SlnviTsZuI4QoIc7NerovmW5Vx4q/HOVow4F5qsD3s5gAdNTLpY5Y9sS4pZQ1GP1DF3LSoRzbEbM7v/4DF07r8C8DiLmZYIC1Tt5WwwfB2t6MhJpXXWpd+X5MLTygiPHQP5MsTgyNr/K85PPsWC8n7MHd68/0FNNYsh1WyaDExYss4jRp6866HTESwuNKFHZcpGgFICU2hZFe7/8Wnkv1WRa7Wol0toJKeOM/YgFMDK2HiG8rOyv5UvVbVhUqSAmQYxcr1ISRmaOC48rWFEbbt56T8Xk7IUk8sP+W86xa8h4qNpYV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJHA4BD0dyXj67yC/U9vH36dg6vVHdRRy9C6j2htofU=;
 b=TZdfzviXMpJHb+npy/as/SFOhldzTGkK/AN2AHMoojAkWuyffT9uQD+VnTgailkUGHIC494i2jJwg8Yp9BLRneH7oBLeqkF37P5iTJaFfTiad3PQWWLip08zD+agREQ3Fxe1lUENe9stdvGD1yQZSEJwLJoGmYCDK0YHd6F/6NpMZVfRMnVzCrHswheFeNM0GfVFR+F0IrypN45N/sHIgApH9sSCPJAUqQAr+13k+xtT6G8esCiAjJYZswfxjbtkJqP3vxzDyAWEcCPmpZ4aVpk7DcxVr5Tzlt2xLExQEyN2/KlKE3so01joKvJo+QHHu5+81dT6Qcjrzne+VWSGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJHA4BD0dyXj67yC/U9vH36dg6vVHdRRy9C6j2htofU=;
 b=BNyJ2ljomtA1A+vRvP3CJ0W9oTeYfk/i3XvJhZsBQTUIxcTIj+ufVuZ2wLMzV8zRrq/1pAwMJoZ0iPquWOYKck5GkYH8oHK61O7muEx2adPaaHfjddcBJ2l5QbJORqDBg6V4mKCg3nyXynPoSZf8FnxgO2igZ8C4KjngLzhAQFar5bP/dBHZ+V6u43M9O3bB8Voly+NiEP0DZLGJyPHCuaGSHDAAa3brfzonKHmiAuJeoGnoxdHZHqMEYLj7eHubg+Ift65zc6la3LPzjIPbrpao4/4jXy6f5LRxqJkebZoUiNB7QifnDfoF+VPl2O5XDyi4Z+WMHl9xdyiixbSc2g==
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 11:54:05 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::8d) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 11:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 11:54:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 04:53:51 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 04:53:47 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v8 0/4] macsec: Add support for VLAN filtering in offload mode
Date: Wed, 8 Apr 2026 14:52:36 +0300
Message-ID: <20260408115240.1636047-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 126998a7-4a1a-47e9-9342-08de956588c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5atn8U9iSlgUVMBVyVvliMhphnNS+pmCEF2gC16dfSaMQsmlvdmzIp3m5NJkg9uM8LsBnC9MgRk2SD5LfIik+2rcn4ot0K/dtsIUohixS4hkWLn7Uqa7Eiyb+ZVC3zyELcSdO3+dOkwC7yruU6dWr7Zi0REzNzCRFHyvLh9dKgUD8PPqxnNlzUikQkaApwiXfcoTW/spmCF4hxsZ8EqVjJM/WomUxFKzGu2x2rehb1UUOpGt0Fh0LZSdEprfI03uhyVtzHHrF91fGBQhEQe+P64joKzWmEjFQJPbYkalPssUnGYAMPrTlhsBq54rYoyU4bH8s9yNRQF2b4ei5dyZk06XDsGiJ3GbrBm2yln/7EgM0vpKR221vlMISSh649d9CR9CS+V9LjQSanHsO+/vjxeTSGTyFqirnimBWIuPZuFnasQHtMlZAvFLPylyoiBGOQzDdu5sbIshNp59FaYOax3YDdedxLeCChvj1tngOV7bj+9RWBy1+4F2mUse8ZZil5czdGBEC3a9I9Ks3cFXAZkU83vqZdvFqkot2Wg/BtoKKQuaJzZSdp9sGME6lwWGA43Qv/MapnBB2oJ/Pb8TbD0WclcNXfadgt7dYKT2m26cNFKuCDtVZj5JKMLWYux2/gTPvGF3CQ0sk8uyEcTpPFZDyEuSxihyCnZnTA1qRnHCecAJnxSMeeojDhZwB7FRE7sas0DJnHM9Kr8cgPA8OI6ts21CzwqnjgH4Sha5fcvVfCm0MAfuhIQfnnJnf7Vv14dbXWqsq4Pbn7LwL3kkqw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wj4PKLU44EbKksm+uAgZYV+VWSiTIi7siYAheUL9GH4VIu2kZIFyR4t5YTQ8GlZuiuowFlesMQFPs4xhKt2tVwfGzYwjfOAlh1BCAt1QlBQLo3+1Upwj++Fn2Iu/F6WDmGbTYNYAa0Cw3QbGhjUr++fKUimnqd+9dv9QzfQLdGmkLE47Ts5VSaEJ4HY95NgTsP8sCAn3FniSDxmbL91Cz2Iau+xO0VFVJVKmbvhaVEmbH7xhshlWr8FA+edpsXpfDh4F3Qx3GS13nF2UOqXEr29ja1wf7c8mHH4uRUJcLhXMdSEtUO3VANVbU72AAKcYF6TDS8ByLppgqmntVZG2w6q1DefHjM0CfHP5yQJOh5ZHmzTqPTIklodjKShS09njtXtAG6z0xsEMkEhNQ60k5XEwDzqd0azebWzr7Ujgx9wbfEIeLK64+/+7a3ra590H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:54:05.0845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126998a7-4a1a-47e9-9342-08de956588c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276461-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7BEC93BB94F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This short series adds support for VLANs in MACsec devices when offload
mode is enabled. This allows VLAN netdevs on top of MACsec netdevs to
function, which accidentally used to be the case in the past, but was
broken. This series adds back proper support.

As part of this, the existing nsim-only MACsec offload tests were
translated to Python so they can run against real HW and new
traffic-based tests were added for VLAN filter propagation, since
there's currently no uAPI to check VLAN filters.

---

V8:
- Undo filters on failure when enabling macsec offload and fail the op.
- Used a better string from 'ip macsec help' to detect support.
- Dropped unneded '-d' from the MAC address getter.
- Used os.path.join() instead of manual '+'.

V7: https://lore.kernel.org/netdev/ac5Wt4vWxHMTcsae@krikkit/T/
- Added missing ethtool feature checks.

V6: https://lore.kernel.org/netdev/20260330130130.989236-1-cratiu@nvidia.com/T/#u
- Resurrected nsim debugfs file for VLAN filters.
- Switched to WARN_ON_ONCE in nsim, which is always compiled in.
- Tweaked tests to check the nsim VLAN filter file on nsim.
- Disabled ping on nsim in offload mode, data plane doesn't work.
- Added CONFIG_VLAN_8021Q to the test config.

V5: https://lore.kernel.org/netdev/20260323123633.756163-1-cratiu@nvidia.com/T/#u
- Merged tests and macsec lib in a single file.
- Fixed Python linter issues.
- Added CONFIG_MACSEC to tools/testing/selftests/drivers/net/config

V4: https://lore.kernel.org/netdev/20260313105227.1884391-1-cratiu@nvidia.com/T/#u
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

Cosmin Ratiu (4):
  selftests: Migrate nsim-only MACsec tests to Python
  nsim: Add support for VLAN filters
  selftests: Add MACsec VLAN propagation traffic test
  macsec: Support VLAN-filtering lower devices

 drivers/net/macsec.c                          |  71 +++-
 drivers/net/netdevsim/netdev.c                |  65 +++-
 drivers/net/netdevsim/netdevsim.h             |   8 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/env.py       |   9 +
 tools/testing/selftests/drivers/net/macsec.py | 343 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 -
 .../drivers/net/netdevsim/macsec-offload.sh   | 117 ------
 9 files changed, 489 insertions(+), 128 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/macsec.py
 delete mode 100755 tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh

-- 
2.53.0


