Return-Path: <netdev+bounces-255908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEiGA2TGgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:44:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E431CE649
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198E4301952A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6C36C0B2;
	Mon,  2 Feb 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eeuV9jVf"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515023717F;
	Mon,  2 Feb 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046573; cv=fail; b=Xhzt/Nz+jNN4W3VZTD8h2lMukj1h9K0kc7G0hk4YCKF0JN3Dj8jN2g/vBXsL8X+fxPYE3OPNIH8mTrR/V0gIgyIaV7FgFkZ10K+F4CP4jsdnpxTf1a8rT0+fDPiWqKfGlSd/dlBsUe0Hj3qnsygn+z958RBrJifHCIlKBHZRMbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046573; c=relaxed/simple;
	bh=fOI1TPxHZyAoVJB4QxKVxVdYqoOo6FCEEK+5qXVPIBM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcrHkXgqsjZycQZ7OGpdEBpvnsMBJoKo0LZ1+Bj6usro3lFIsQMTqmbjyc9aDUrDzbJsCsqLsZtaevvmOQFsz64PiWZkyw1rS8BqBrAepKWPsLebRwyQPF/bVK1bKC3ySbf3YWTzDAZ1dG5ECJWbYlTM3jkLQMa0OWvEYypHr+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eeuV9jVf; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW0iq4Mqg5goNVnAO3ZzQDTlJXBvs1P4Em3UjnrNlg5YNyZSxzupeeH/qAP6f56Fb+lxRJcMQtXIvOAGqXluM0XG/L2ldj//OYleVkutBoE0oLrFswsWGt+kMs/3DXZ5rK/1E5i8AV9MPWCsRJYuIiW5UplpMDbwfQZ4v72e3+00U4L6EltmVNLA1x3d1WBK2B2b3BVjnOsHNbO+2ekPmGVFfB7CEUYlRf+C7PaPa/RUQohTLjtNojnAbzJIfMUCXvqPys6GJRlwxd+7SkJJbww0aFhk/QWmYjWDz35CmcLomm9PUSOD6tlqcopZARJ/vtS+lpJHWfxizrfdAFTZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qat5/FBe71DRQLVYLFMMtYrdkKaEpK60l9eYzQAFkh8=;
 b=XoWpwPjO4rlbVuwu7YDi3+Vno97j7ZhH+WrbFgpjMn/Bs/qNhptJzt+utsCBHWreiJzZoxiwTm0sqXREZDQtiald8rPpDiLUkfZ/9exmzLHcomelKDN0ZpBUx4l5YJjx4HYrTTjDrJQFcC8qd0s4TKtj2u7L3sW4E+ikNNepuovexckercoMCvMMZRGjlVwUhMMLx8vGMdP7OS890Gufa6gTGJNFA19lt40aajX509i5O7V0SGRQsBfAEp1yilQsDk949RomVf+OC0C9Wm4MtI6NBKiyNRB/cSXAdpcf1haN5yKKmak7Ww1kUl99p3ZsLN/iSebLVjc3yWmQWlL8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qat5/FBe71DRQLVYLFMMtYrdkKaEpK60l9eYzQAFkh8=;
 b=eeuV9jVfO9oxyhD7HdQkHjjAuaRNRjtyyxdP9UTs1xFw6/t0zyfcnYg/h3gV8oeUTZCjH5ysp48l8gQrmweaqz+Vk+XeEtG+QmLNKwoP6TGt9W/vvhH9d6t8OYv9KSGD7JY/eMUD0zVqpweZ7r8Qc79lT2jnIAdAn/R2/QPEJKc=
Received: from BN9PR03CA0550.namprd03.prod.outlook.com (2603:10b6:408:138::15)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:36:07 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::6) by BN9PR03CA0550.outlook.office365.com
 (2603:10b6:408:138::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 15:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 15:36:07 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 09:36:04 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH 0/3] net: amd-xgbe: add ARP offload and RSS self-tests
Date: Mon, 2 Feb 2026 21:05:39 +0530
Message-ID: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: b071980b-bff6-46a5-3140-08de6270c867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/XDf1jLI2sO31qZzxUvUe/t0g/AKrbKEkDUOUnbJ0R+LrR2qoY5ZgpeN0+eP?=
 =?us-ascii?Q?IFOwnaJ92n0Tv+dJEu7j5EPX+egnvfhReD+Ou8wy4Cgs2X7GIKQU5cwDPEsU?=
 =?us-ascii?Q?8TDxS/q2/XhLcJ+BwO2GzhlbJdZ/La6QnHvHOQpqGoynxdS1luScxc+JsXgz?=
 =?us-ascii?Q?ZZAuhtBn4rQstIBjh+M2Af87m7IjQfcJSpIeeIPALftWmqJ2nGAXzRWQiMch?=
 =?us-ascii?Q?WMIsYqKCC4jl9AZWbbqFHlJ/jU1Z8UpsAco5YtRrED3GMuvq4ZEMDHzbCVm6?=
 =?us-ascii?Q?hS+slckGNQpPQGaav8ws/E29XGGblvtlmC/F8o5zPkAiOIp840arnFR2vAKo?=
 =?us-ascii?Q?XGrvtz5N6tk3cUfW5rNVAS4lr/ddozbLj9dTZXxBUZbJdICwSRshxF3tvnWq?=
 =?us-ascii?Q?A+30vRtEfMRLVVnlqO6Z7t5+0UsHlRsioBN8nI/Gxy7839+Splmk+MrFpAkI?=
 =?us-ascii?Q?Tt0NhCwUxFKKXIEeGisuvuEe7BykuKXOVOQ0DUGM+uU29qrA5kgoXmVec7mf?=
 =?us-ascii?Q?TTnhn89wU3ktXDSopnwFGYErUAkLkLhPUd8gNgomVUjJ0YQHKHhGQAxGjF2c?=
 =?us-ascii?Q?wGM4LOBX1Es2fPKJS0iLZqpPRKNGKBD6E9apCCSi8fP6B+/Q62HWmbA4e4C+?=
 =?us-ascii?Q?ossPMvhsKp1YnfnKp/tyvDYcBMHVrYXkDXCp9PGLKS5Zbn5utcUiL1pd8ceF?=
 =?us-ascii?Q?ICe7MZ04qPaNsTLMYXfB7q+EgwZB49LEIW1MKv5kEDoWsxGR8WTE04Oc6ROJ?=
 =?us-ascii?Q?KtGLEBMiCEYNaG7Zbko8Jta9AsZaTWxTjyGtxKHTQVUfJW7Q0Dq07+jBcI1O?=
 =?us-ascii?Q?P8/c086WLB7buslsbMR1fLrCwSR49nnm/dyw95xTmxP7WjKdSgSN6ZpR8vf1?=
 =?us-ascii?Q?G8QC+8/tsJjAnaQXaosCri80lRarFU8GmVjbYtp/lO0ImZXawN7uYNL2ziLj?=
 =?us-ascii?Q?/gIVW519Af/ogt6tXIhkjd4uYbZjyK2jSB6sFXmWpkcSdQ5RpgAC10sXkMhM?=
 =?us-ascii?Q?oUYX7FvUeuFl4d32Xrk3aRYR6vmQnVlsvAsHXzJPHc9K/YMaI9FYmdCO73dz?=
 =?us-ascii?Q?/1qfaezu7glUsER4WKuZEgR4fTcJ++47p7xu1Kga8h8kvTJeZpHjGcOFcnhu?=
 =?us-ascii?Q?KpCKWvKSQWBna7l3V4qliDLcbN1vkTTaea0TGGXe9EfpMVYRf4VHLdakuvR+?=
 =?us-ascii?Q?HtsjZrVahsUBByDH4PLiq5F33DRSZvVgzHlZDUwcGfDM9jL31HoDMlOYQuS6?=
 =?us-ascii?Q?qhMl18fYYc/WEMZMzCp9zXY6eVLa2GDG8JSYH1HCS0WSoI2iq09l8GDlwvXL?=
 =?us-ascii?Q?WwyYxZ9zOGoYTUo1ePEXSOOzu46IfW7TNgoR3i7BxhGlYpacIjrKhHM5sZNT?=
 =?us-ascii?Q?Z0K4zoAy69V+aRe59qqERyYMksSLiihM+OZCKXIidOppFAnwYZ1f64JoX2sr?=
 =?us-ascii?Q?XYfENxgX0Bf7JzVGFDrBQUVzJSu2G/9ZQmTg1b5GrgZ8Ec50+mY0bU+t1ag/?=
 =?us-ascii?Q?825KhSEz83OldhUf2k9CO5dhkrJG+HNBuZ2fs+1QohuxXF2rcRfw2k2HyG/h?=
 =?us-ascii?Q?wd3MvLRO/f6tmiyawelB38/Eq4Cehn1uakwYNeoKCCr23/Oahe/s5jUZbJoL?=
 =?us-ascii?Q?0yjHsWFgadtSXqIDRWn4Of51LejsDsqpbOZK96i35zW5v534hcZfGLhLgmhI?=
 =?us-ascii?Q?TYSrnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	91XvwyzyiK61K7dZkmvqo6qDrJd0khIHQht/q74U5hYa8SYpAozC8txl37ggTXkLt2nchMZhHSCMdnBaMm7Asg53X8h7Jq6Z1y5jP3nPMGV+FV/l8fyXWSjmPM3tFQK1hmHYjQzrpWuLllZHUleEXVRrV4S3JgLIowDe0dLhGCeFmiIBK7kNKsxlC7/6smTodRM3XRSXdRZ46POjpUEPdOdpobqZMTNQZR0gPH8qz6LAsA7/RPGYSjw7kZR6MT1l/qRvLelYL7euVAVhrx2pck1PErvndKicVds6Gneb7oqJl/uPMX7ova6A+rhthi0FhiYvqWbiJELZmWEZRtRga6q5gHW6MlMKWhSUETB+Ivkg2iRKzlNPoaSiscybfT40duVK/iU9w1Km6oUxb9PMfV4t9ZXDV50542wJyA2yhEaxrzpyQRBaP7u6CYbq+sxW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:36:07.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b071980b-bff6-46a5-3140-08de6270c867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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
	TAGGED_FROM(0.00)[bounces-255908-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5E431CE649
X-Rspamd-Action: no action

This series adds ARP offload support and ethtool self-tests for the
AMD XGBE 10 Gigabit Ethernet driver.

Patch 1 adds hardware ARP offload functionality that allows the MAC
to automatically respond to ARP requests without CPU intervention,
reducing system latency and power consumption during suspend/resume
and normal operation.

Patches 2 and 3 add ethtool self-tests for ARP offload and RSS
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

Raju Rangoju (3):
  net: amd-xgbe: add hardware ARP offload support
  net: amd-xgbe: add ARP offload ethtool self-test
  net: amd-xgbe: add RSS ethtool self-test

 drivers/net/ethernet/amd/xgbe/xgbe-common.h   |   3 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |  24 +++
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 149 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   4 +
 include/net/selftests.h                       |   1 +
 5 files changed, 181 insertions(+)

-- 
2.34.1


