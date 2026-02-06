Return-Path: <netdev+bounces-257660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH5UGpVvhmnONAQAu9opvQ
	(envelope-from <netdev+bounces-257660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 23:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D857E103F15
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6288A303AF05
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8199244692;
	Fri,  6 Feb 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hj20CWKl"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0CB2248AF
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418064; cv=fail; b=lZI/qgblX5eQvElCCfKTTRCQIlcMnX49MjI9or7Bx+RlvlcJUffRafViaoEv4sR7q9etr/hLuoJKDjs6H2jZjP44tdnb9lrCzi3+GW0qp/cJMO7vr7MOfip6XJViLu5kQi3+/tXIV7GM+6ZWshJTHrReMYPuVOrdUkREWpSpOzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418064; c=relaxed/simple;
	bh=WX44Kp5dxi8hzPuRkrXtTtC+hbx7AhlzNoWeJRlRixg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gu3V1MICYvLGGeUbaZ0vK8an4qau6a/4YeYXv/vwL/CeasJ3r4hgrUDU8viQsZPu/PbS9dLyMIBSL5L3Uui/BjXizZzFDMVlIBmUDAAowA3dq7gsM2zng+5IkiaPRLqcD/k7vhIwWuz+oeOCBXiS3rbmO84H58cgoxrofPUwf5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hj20CWKl; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdW80yotj8gu6HE4/glkCXXEcqMgMM0PhStdqg5fua9VEkbx7x7DssgSuc9fWIx9SsZrNQO5W7tTtAn8kVnObh8RnLmrzbp4gZAAvj/agCr6aqcqSDUewAhGBZyvAEv0OWFlLOEVVSlD7c4g+qqUT7skfMSLdoycCkmeORQ+C6LHorutfPeSyldQgOSv4+WrSB7L3JgM9+Yel5UoBmM4Mfw021UeBlqH6KTzVBuOr31HUiRPivf/guuWgzfqxbT5jKoN+7ZB2nCmeCYg8yLhKGAov6yqVfyiTtlRS8T3oVSBMzvqFeJt6Z/fccu8blamyf32+WyEYYF+AoXV9B4wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nef240Ow0isxLJYZFyI6VqQT35EKTms7edkWJeXIh/Y=;
 b=Vb8dqX3w6K0nNMFxlNRC/rVtDD5QMgplcibaG9sif6SZMevoebm65xGQGCjthYAZk6bxDBWuCNX+tw9BORIZ90HDggiIbLunIDBElO7Fv4ErOGTybsomR1sRsha7d2bFUeGBlyKcBvSmgOgFCPIVDjDRe/hCCUdA4XExZfOUnHhJzNA9EIDxRbM7OY0DPuwayXSO1Uux3WAaQKj2w+1yT0jQupYm9kCkfd8mAEijKnh8cg84+Eag8LHV1zWnq06wX3VTM0sOgPE/VtrfOzzxrMAGm0WwauNvfw0Lw2QgFWRPyseb6lGdCv3WXTIG0lvMfLiyhK8fsJGsIlzsTAY7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nef240Ow0isxLJYZFyI6VqQT35EKTms7edkWJeXIh/Y=;
 b=Hj20CWKlwVXgJ2VfGas2f7QXijOSXgWKw80pNq+T4gQ52dvq1DCVe9FasywNsVuDG8Cfu/Y8ufWA2fjlm4v2FpjaavU3aoWGZBjRd0U1hSAS/7Pc2AJNmLFI4T1h45SPP3R9OIlpP/+7UZYSw6J7dHYvxlXG/jCPopAw+Qj91UI=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 22:47:41 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::28) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 22:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 22:47:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 16:47:39 -0600
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net] ionic: Rate limit unknown xcvr type messages
Date: Fri, 6 Feb 2026 14:46:51 -0800
Message-ID: <20260206224651.1491-1-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: ae03bf97-9a0c-4938-d7c6-08de65d1bc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6z8+69L6quFAVusitoMCZwabxnL7qkQz74d7zYAysyF2rVH97y4/6IzYZoIw?=
 =?us-ascii?Q?caZw/hto9ZVS7P+VucsYPtt1N7CD142kDwRWAtxLhMJGjv69MqJoDF2xVHL3?=
 =?us-ascii?Q?/CPrQwActbvSFq3aFkbi9mxM480WdrI8PPAQ+qyHaVbUvTIgHV0GG79iaXJX?=
 =?us-ascii?Q?iZGC1KmgbEmo9GYzzyZ5s/7wa2PmwV2QE+UIhrhfNQKdv+CybWNNi4TjH938?=
 =?us-ascii?Q?iiyzeBcQ4LabYCI9tZLW9jEjEUbuznV73kLVqQrdPGMuiymzNNa6+sspNviK?=
 =?us-ascii?Q?xFrDnLRIt18ect0sAIE5ireGSZnojC0e8P088ffiq1S1bQF7WC/v6RZeSZ4g?=
 =?us-ascii?Q?DleiuFlXRdyccJLoA3sHYPNV4NOR9bxIpKU1ijcIEOzn7eFh35E00uz2Gk4t?=
 =?us-ascii?Q?jBiLA+aIeA0P2L5tjc2QemrBhzhdS9nENVJ8STpO+nkO/2K5xQ/EHBqxG8YF?=
 =?us-ascii?Q?0GOlZNYNjRpQEJbbo/g8h7WMbBZTfckW+Hhp3lpxBtFCQSEZ7fG0x+tzol4Z?=
 =?us-ascii?Q?MdmUnR8h4iprXtkCYxpgnP6oslrgcvXEhEAb16vnvAjOFnSszews5Gglc+sv?=
 =?us-ascii?Q?WIDRrjOgbS/phG/d1PLL72cAaVkPTUpZ5xba5U9rZxF578azajAncwDUNCtk?=
 =?us-ascii?Q?qvDXf28/ZZhK7W/6s3cidRv0ptrEaHhRuhoU4ojMWpe4VTGcLxzOjT7bhy7y?=
 =?us-ascii?Q?K8AvWYBWCCOGb3dOyYCPnXSuRVoOUP9P7tXBvj4Ty8RS4vtq0YIsGxPlqjB5?=
 =?us-ascii?Q?yrd4BroH8ceDYK/oM1mx5uAYplCaxEsAoOAJuCK85fHOTnhrzMTteUc01b5R?=
 =?us-ascii?Q?1fDTHvQL1HDlZQJyimO+iJxzEM9yCu5FwUv6DKc0dO8lxsALN9dxMUd30Lw4?=
 =?us-ascii?Q?CkwedhTqamLMeIHAB7gn8YUzLi3yiuKWAzT3DUXgulHvtPK//yufZuGj55Sv?=
 =?us-ascii?Q?1RDYwxux8/yn9Lyo28pItatnmhLp2A5py4Htb8/pmXFfgI5KDWVDW28Lware?=
 =?us-ascii?Q?euiTgkuOVNRG5O/tcmW436qubG8JIgIabKl0Pdu6rp6orJOiWnc384OVr6cN?=
 =?us-ascii?Q?qASok2Qgb+AN5eGEaUwxlzyyEMhXVPLdmgzMz5iclaF3LpTblKVjQ4CGDOyE?=
 =?us-ascii?Q?foTSllMU6UEbsMr0wZNrN8jQNzLvvPrIdLXVH2Ap0aNPoM2Qd6IUycuDHILs?=
 =?us-ascii?Q?09K3B5oeI1qZEBHXBrEQI/sWLpHT2V0IEil6xk/3cG0zP8HvCr5yEbw5RW+m?=
 =?us-ascii?Q?j90oRivBzfteKg3+MuOut/LYULKD+rYylCT7i2l6n+AUhRO706c9HgdUmhHn?=
 =?us-ascii?Q?L/5b37sSllQmswebSnBNXKcbvsmVfNLPnBAFvIglRbe0eZsIacpWYTPIDDMH?=
 =?us-ascii?Q?BGu+TjzuImOWlHUn/ejj4zglznaAQcLQqnRAAZZDIPTWp+e3cTUVsG4gZdrp?=
 =?us-ascii?Q?imYewMwZGJU3hIfUlc4m0Q6eDhg3/TJOkERMt3qChWjI7xbhrhLhyjkCLpAv?=
 =?us-ascii?Q?UMG9mDiZ9jo8hF2e/qIcMZ6WWOiAoXzj+Fyt0bLHNvsh/FoplKJ8EMcivGUH?=
 =?us-ascii?Q?h//fFlNFJlLfIiDiCv+fK6hA5CNGb+z4D7XEbjfsdrxczIMzbjIIXY3p2C2I?=
 =?us-ascii?Q?mwT/Lo+5a20A53hBPBDBusGs6n3oHjN0nWOp4/oGnMpd7Rk4AtJilYSip8nV?=
 =?us-ascii?Q?g+DqfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	86wGzJ2euvT2xloMjMvN2zk6aM2adY/Z8fiZh2BC1y5GhG5LPORUer9MunpDg8JbDuddcK3BhonEQJEHFCUJFp2TG34FIua/DkFgXExlOKjDG27MAvHfU3cKz2QWekfdCI8tuHHSNJm4d5uCrIAijEgqyZJLWeLMRsOjDZDMSrp+ntbzImYaH7sH5PEWhK/Vhs0bK+Ez0gZOw27JYUih0dWwk0I2UHcT5VrhZNcQJ05r1RuUcaTd6MOKr85DpWkN8F8uOWa/c3AXpdX+/Bdph/PuGMCe3io0RMT6wDhYMZR7q/92y7AfWgbvKrxQkiuPOHPp1rYTUOXM271irc3TYqYJi3RJMXkTswgYViuLAh5BlAapoYsNYSHYL6R3bHHg4NUNmOpXpSSNESljea4XPtM/V/ZFsaqLhBWVc1mc2wvbP4XsxExEO0JodiLfDc1C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 22:47:40.9776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae03bf97-9a0c-4938-d7c6-08de65d1bc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257660-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D857E103F15
X-Rspamd-Action: no action

Running ethtool repeatedly with a transceiver unknown to the driver or
firmware will cause the driver to spam the kernel logs with "unknown
xcvr type" messages which can distract from real issues; and this isn't
interesting information outside of debugging. Fix this by rate limiting
the output so that there are still notifications but not so many that
they flood the log.

Using dev_dbg_once() would reduce the number of messages further, but
this would miss the case where a different unknown transceiver type is
plugged in, and its status is requested.

Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 2d9efadb5d2a..347b0aff100b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -263,9 +263,10 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 		/* This means there's no module plugged in */
 		break;
 	default:
-		dev_info(lif->ionic->dev, "unknown xcvr type pid=%d / 0x%x\n",
-			 idev->port_info->status.xcvr.pid,
-			 idev->port_info->status.xcvr.pid);
+		dev_dbg_ratelimited(lif->ionic->dev,
+				    "unknown xcvr type pid=%d / 0x%x\n",
+				    idev->port_info->status.xcvr.pid,
+				    idev->port_info->status.xcvr.pid);
 		break;
 	}
 
-- 
2.17.1


