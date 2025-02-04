Return-Path: <netdev+bounces-162602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E71A274F4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7873A29EC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F4213E8C;
	Tue,  4 Feb 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeW3DUTu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C89214203
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681019; cv=fail; b=Pa9PyJVa20BEokG9ltTttUcNVoIRXCuweI66FtOqIs+VFFpT/b+pnYP+3jX3K1ALsWukID7YcDIogRPglqiFI4FBQ9Zz/PMnha1NIXOPvMGw4HiPrLhdbcvMDVyfmclsvXq3V3LoKLFGOD0jOfTiH3Zux9Asg4PhmgTYuFQvgJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681019; c=relaxed/simple;
	bh=DErNtOHN7EwIBZPzil+aZE3jX1yd2s6XX7SSXR75Np0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ietbMpqROH6aI0Q20kfZlw/OkniYCV1WC847T4zje+26nLIZVwp1ysnktUKjjUqY+xQI32xA3f9/No6wqUqLBWn3dgEgaur2oFHso/MDuT+3qtpJj2JXQD+9G7ksuBKLaU+vDjix6HIPXiFXzEQedTUELkgfvDk9aBu/xSPEpsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeW3DUTu; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO3UYoYGHgNqP+vr+FGmAlCrjswZdq4k4f86Ow64rnLeDkpuCKxx8bSEyHE7ZDNKSchaBgucvKZU1qk0VFq3e1LT6Nqt/oQgWPrLUttEeVsYVBgmr4gNuYKxVYrX/H8GJteYtF7Cxd5S73GZXPMdBtcrh9AestqODh73Aj6uRGzWDo9ONA7z5iE41tTmgpjyChcb4XxtjUL6ECHCpFz0V8kwUJMEI5tjhd4GV0v8IieOzVg0PbaENUuMGmZd3x6X6W8/DlhXDV/G5bnq8fHOsgKu2SGCCcebhJZzvNZDSebT7vlaQZKnH1ANESqmHjKCqziWVnxDWhbzXG9CLL30LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYHeSd+i7cIObS+yK/jXmi9ZkP8OYqTFibsc1II15KA=;
 b=VwwFqmp7ken5lktdn0/LwDi1TqYa125sY/x1OW0V4wsPiRPZ4Q3mdbGpOU24npA5W8alZLH2mk4HOhklA33L2t4/JnrFlUBrCGfOE8Bh90cA5RiHCtgEKbpn8zolS3G8Khbn0tGmOwGu913AuGqct0RdqUSoWwkRSu5h8Zt+rhXMkYEi3J/FSoXL+BjYN1VL9xqsuIsDOCgsAdJdSorC4WtIxRUQ1bAGEIQPdm/Oc3k0lEK5oX+bhbqqZlVpyV9ZATAAeOIdLCciN1H3OEP3aCm0wkmULiHw9FkpicDr454GB/BWx3rRL6X0j8z34ygxYY5S9e5Q5WJkW0yQmsRayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYHeSd+i7cIObS+yK/jXmi9ZkP8OYqTFibsc1II15KA=;
 b=aeW3DUTum/JE6YTTUzO7ACZUtjEv2SblCMXWNipDcIJ09vOz/tLxISZ8Gx6jls1OxFgR4IBVpqOdkB+4ibJklP/0AwL3SRiLnpMo+Qt4EtrxogDsIJ/v1z3Cy6hPP+lTHloAj8OLzDMuymvqlRCXvh0PBViFmfrL3dP0UXedYm+AuAhR/k/wcu8L7B0no9MQRc/zlTXjpEMO0nCZ7PuYeC7rtt60KM4oKlAmOAtG1vIHpakLkNzyfzxJEKwJEYyF7OVaG0NaUHN3mmIx4vuzcEhznlAo7/QKJDJ9TrBrJXQ1imKLeGpTEaU7ymU3WMHKZclNYp2dXHkvC6WBPiyyPQ==
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 14:56:53 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c3) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 14:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:56:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:30 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:27 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 5/8] vxlan: Refresh FDB 'updated' time upon user space updates
Date: Tue, 4 Feb 2025 16:55:46 +0200
Message-ID: <20250204145549.1216254-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aabbbaa-b407-4c31-804e-08dd452c28c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xu8dXcEnKL/MkFcnmySnqvNN5dwL2h2LpYrd6uM3cJlzLzCOD3f63OE7hGq+?=
 =?us-ascii?Q?3RcWO0PKo0flL7kUzsGjx8nDmJnn2KolY2bHDX+wDeQ98AUbbfbJm79rhcen?=
 =?us-ascii?Q?KTJhg7mQyw7ci/TlE/RoJ3OMBjB4mbUli+NA22HLSSle099SKDvwWx3RPvwV?=
 =?us-ascii?Q?JaHN7/7vMeXsDP7Je25rxh635/VQ7znF43S3mUh4atmQ5MmchkBO11roXMcr?=
 =?us-ascii?Q?LPGYtfhsWdfQcPhhBXYL1Clt0mSHm1YIX+mn2HugEE/byxvAT1xQyN9zyVwZ?=
 =?us-ascii?Q?F9+J5CioYOLcZ5ww/+jOv0KY+iupsfzY70Fw1zW6HVKIwDqR7jyA8sMxOQks?=
 =?us-ascii?Q?5PcoYlQYHY79FFOnZAlF4WY5Fc12wQECwymh5t8q0FEp6MwxLnCC8t5qpvR6?=
 =?us-ascii?Q?lWSsCfnX+j/+Pe9ZECDtb/8q6hcwXa5+GQeYgO5coJliO0/E6Pzzgy00M2eZ?=
 =?us-ascii?Q?xVrFxtQW53QvWscqY0Hn+GIfvvt42A2tyU5eeN4SAg2NNa7cex/2l2ISPe71?=
 =?us-ascii?Q?11Wnux1/qwnnzoS/I4tLTZHDoqRdIhtoTXI96K5CBlzgCVmw24YF54qbiYuV?=
 =?us-ascii?Q?7CypCEhTsqLhgAzLJ+kFsjZE+SlX4pOIPubPi39+sCXalgIHG9bI7BSh1bUN?=
 =?us-ascii?Q?9mmpdtQ8Xizx/czGgBNNIsISFctJAcJifzNHDJy/kz7wWY95iQLQkB9RQGiv?=
 =?us-ascii?Q?ryQcJ0blR9TjWaI9J1PkWY6i1bS9dAf5AXY4zpFvx8+dO+JGzoCRJdJZ0r/r?=
 =?us-ascii?Q?wjxKSuIz1XMT0ky0G+1IxB9wC325JUKXKICoT/jAQc3UFvpsn02n9w4qxsm/?=
 =?us-ascii?Q?XwU775Reiy0WdWEzqcjgOiRTbqsz6oyxDUmjM/14XNl3u7Wj5hC70HadhegV?=
 =?us-ascii?Q?skB6ahj8GROWnTPnMKiCl8jYU+gDDSs1qI/x3H9xxnvx/0lv7qm/RG9cxktz?=
 =?us-ascii?Q?2lIFAndc8Pu7Y2cIzApzh0g69Q09zVyR0AtpOPB2OeMoXQ6CdfuN6d4e/D/E?=
 =?us-ascii?Q?hop3ks3PvGqPeYzVyISNosKns1sncWgc72yR12/T6rcK7HjPFvnaot1SjId1?=
 =?us-ascii?Q?yZAWhzWixAdGrG28b598mD67MJixpCBj6yUZbQxykI+C5mUykOTAn7kjAAR8?=
 =?us-ascii?Q?Urq/Qxng13LcNosd85lP6yHZGLSwLvmLX+MX/cj2qFgKhdoMD4N5YYxqfMrp?=
 =?us-ascii?Q?Pfe/QsXwcnpdllmIKiioCdwaNoD6+aT7Rsjn55Y9SQrgeUBH4Tcm4DTCMUj1?=
 =?us-ascii?Q?QiC8hGh4g+TFwUBsOOttJ3Chkml1uLTsosXszer2B49dO1nhbfkUR5X27wgS?=
 =?us-ascii?Q?eXD0WFanGY/6iJ8eFN5YlY4Nd+FNLFIQh84W1MAMgupcRGpJoipnWz7Yhs+r?=
 =?us-ascii?Q?CC/pRCs9BIodXXNZhQ542qVH5hLkpRoYmdgYr3+pXip+OrAsu9awvFI6aw1j?=
 =?us-ascii?Q?vmrX1kBRnKmPh6MdXND+V1zJj7gSCdWAVh+JtgFd2T1gKqPHfo+Jwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:52.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aabbbaa-b407-4c31-804e-08dd452c28c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525

When a host migrates to a different remote and a packet is received from
the new remote, the corresponding FDB entry is updated and its 'updated'
time is refreshed.

However, when user space replaces the remote of an FDB entry, its
'updated' time is not refreshed:

 # ip link add name vx1 up type vxlan id 10010 dstport 4789
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # sleep 10
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.2
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 10

This can lead to the entry being aged out prematurely and it is also
inconsistent with the bridge driver:

 # ip link add name br1 up type bridge
 # ip link add name swp1 master br1 up type dummy
 # ip link add name swp2 master br1 up type dummy
 # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
 # sleep 10
 # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
 10
 # bridge fdb replace 00:11:22:33:44:55 dev swp2 master dynamic vlan 1
 # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
 0

Adjust the VXLAN driver to refresh the 'updated' time of an FDB entry
whenever one of its attributes is changed by user space:

 # ip link add name vx1 up type vxlan id 10010 dstport 4789
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # sleep 10
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.2
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c73138647110..c75fcb0679ac 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1013,12 +1013,10 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
 		if (f->state != state) {
 			f->state = state;
-			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 		if (f->flags != fdb_flags) {
 			f->flags = fdb_flags;
-			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 	}
@@ -1060,6 +1058,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		if (rd == NULL)
 			rd = first_remote_rtnl(f);
 
+		WRITE_ONCE(f->updated, jiffies);
 		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
 				       swdev_notify, extack);
 		if (err)
-- 
2.48.1


