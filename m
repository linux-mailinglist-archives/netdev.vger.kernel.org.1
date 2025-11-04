Return-Path: <netdev+bounces-235547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974AC3250E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CB63AF8ED
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF72D73BA;
	Tue,  4 Nov 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVgyOPlQ"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15123F429
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277060; cv=fail; b=bDwAp3ldxp1IiVCE6QQti7jjgOur4U2Srza/EtgwDebATuKfZdhpHkttFo7+sp/Ip/wsChAXBp0/RgYZhlx3HhWOeJTrHMVJSc4tPbLSNOYr51h908ChmzgnctbWEzOMNqEKIQfDYchXPV2C0D+jdbbd4i8eErjGKPzuF8rtkMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277060; c=relaxed/simple;
	bh=cfOTlR4mdj6yrawTh0fbZ8L0+43e+IDoCwUmpVTVzj4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aoxa0KOU/LOjn5hMaDa+hdniSdMzk61POe9X52hBwymFvT4XgUTWy4uTq3/CAXuSX8mDFnusHCDkBSKjIk9aqZEaln6pViKioJet1hkgthiUDkv+77rI9NS5IUHfZJdYTpuGcMEtULkpbxjNy3KjhY1At9eiolsho7pgcg66EIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rVgyOPlQ; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AimvKgiCpxOWAf8gwob5/oVwmzKsiW4gX5Fy2JYLkJ9Iqg9rvc5mnXQ0KJ3DJg9HDwPowfBGOAu9raqNxi+zLOGh0VQbqSIL99ptS4fKkNJ5/PHFKCUArExuu2e+xNyzCf24f5KpcSj732XJ0d5EDRLiWJVqW9zAInfzZdZDAZDCA0SrK4xbGU4QcY8KLvL40xApocp3qQXtLN8VWAbCcYFmxW3+srpZiN+AoBabMsZwFO9s14kl2Vzrj724E9mCy/jh9GwJyrS+lH2GJJZHiEYiahe07n02EpticWztJ8vqHP7VQahXc5k/i5OKEyV0kceciqHJ9Dfg+FqlXCSNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85rwggkbjdg6el0RLMbwzjd3Ia6KbFxQds9/NkbwQ2w=;
 b=Nj0fgU9oGEfWaIddGZkgMgFLfcIdTapbqPkyqTKLW+xqe8IydxQcaJMxMlvWpTdFG0ix6jLAqakgEKV2xZSJQfuHuj54+RnOpL+TTQ77A/7glNS8OkfnejpZfjqEE65/9dFWvkUWEn8CUWo3FDD7Rbz94V+fdGVR80elJBQko4EmrHKHSO98gj30Z8ImCkVOpKCYcnPX0AfJwTBsSbOB2+MOl1dWhvtutqBFZv04Og62pwavtgspTKYKfz5uM2IW5gJGEVrCuZXJhPUCeM+PNOfrltfzvHERIMJAbgmSD+RJ6YqHNVkYEBkqyNpgixJGV2zA4m6bG8LZOdC+bEL1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85rwggkbjdg6el0RLMbwzjd3Ia6KbFxQds9/NkbwQ2w=;
 b=rVgyOPlQRGYdk01Z1yUohOrqDZZ5yq45tFBaaH/p+FNYNnQoM22hEt9WH1/EvDIBgNySRjl06Ygw6BwxhD94mVNQfqzZQPd/mgkr+bSKG/2tByOf6NgLg/Gz3Esz02kKxBkNpUTUeLHUv8Dl8mQZ8rJkkK11cs9BrotBfT2SDSv/1lWx3IUExoZoiwnUjHL/ouo6f7mZVMT/x9++9hn6cDlMj61Yf9vIDDF25JZ0hFapnpLR2PvJTu00a/K1yQYoOzmx653KZpZ3VD3GzcG3+rB3lM2PJtkUFuYY9Yz0p8zrhzJux7Ptl1eEBjblXZZYancXtAPK+lIcB1jrnplhGQ==
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:24:12 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::b1) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:24:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:23:54 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:23:49 -0800
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-3-razor@blackwall.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: <netdev@vger.kernel.org>, <tobias@waldekranz.com>, <idosch@nvidia.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <bridge@lists.linux.dev>,
	<pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>
Subject: Re: [PATCH net 2/2] selftests: forwarding: bridge: add a state
 bypass with disabled VLAN filtering test
Date: Tue, 4 Nov 2025 18:15:52 +0100
In-Reply-To: <20251104120313.1306566-3-razor@blackwall.org>
Message-ID: <87qzudn256.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: f62674eb-26c3-4ab8-eb61-08de1bc6f8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bBD40duwhqVJipnASVrUUiLnqOQXXVNog8o6QI6aAqPIBiR7aSzKuaJzsOD?=
 =?us-ascii?Q?MegGFhsjtaHYU41xcTps2tLHpYxluZWXZlK6hQUYJudITkWfKou6ml3AVsup?=
 =?us-ascii?Q?jHRpzCeO3MLqaNDtF46rtCivXwbXNu3a17s5wLwNj9qDRjhuxUzdboI5fvu3?=
 =?us-ascii?Q?X4Gd+Mwz/TXuFbb1we8tZZrJZ4V3pvD4M8CBXc3Cy6k5qlQ0z0qgDEOc4aGI?=
 =?us-ascii?Q?XC7lUIhkKmd7gPY1cLG8cW/tggS9TEhwelcyQMxn+qhDzqaiDoRc+7wCxLah?=
 =?us-ascii?Q?wAk/Zl1hTcl6hw7ANmNtTuySODLq/JRv+lsYtj5VF7XLqsQvCCq0JyUJf8HY?=
 =?us-ascii?Q?XL4cmAvKf76RbtzJLoIztGAZj+8PYnk8izfibxlgGjxgTRLQx2GvARMlTw58?=
 =?us-ascii?Q?hOuVaMob8h6hQmWGkRCQPc5GP6YXyJk/rVZTnUARDcIhWroGX/SzUy+9jIwi?=
 =?us-ascii?Q?w0w8/ZqG0WRgjlsxCGEwV+Hc4qV0C3CEeYo7h5sKIgKmkrol1p3fIWZgoNn/?=
 =?us-ascii?Q?RJ4waJBzVi2MveAR2AaXKP1dpEj4xKtzanJ+G1TPEY+aP3gewgm305YXcRSp?=
 =?us-ascii?Q?5ASCyXCRlC0j6rwvre74CHAqnETJh9wugGazMRrWEm44i5qP2/dk6jiXl0QP?=
 =?us-ascii?Q?vcNd8keBbh0gFBerpFqIFIPuG58dSCy284+sUYRtUKAJSx/8uKGnlY2bBoqW?=
 =?us-ascii?Q?2Abu0MMrqn/AxGc7ZGgizPU9FB+UiRpNySsS65r5B8tcXcBXAuGkjNtkgsch?=
 =?us-ascii?Q?4uYGNK+MZsT9e6fZQGgcFsR9MRyVR5L3wNFQwqOywVrYzGwFeqs0xkXkx/YQ?=
 =?us-ascii?Q?FxnWwhti4VD9L4V90K99SVZEX8GX4wltH2xyvXZXrlt9MuliLdK0IDb4DqTg?=
 =?us-ascii?Q?ZbhDLqkqfzJrJRMR0kCN00i9IpPWoN4D8CBFrMAAMV4awetdVMeR+8br+s/R?=
 =?us-ascii?Q?vEyxzLDxEqsbCwbkHcpnA79+kcUfIjXpq2MpQkv8H9UokTRMIUNsRG8zOhQu?=
 =?us-ascii?Q?fZ1/zlvSO8398YZitogDC/vZ8h0zCJR9d6m6m4LRo1b/Sra/WB/KSONYj7cx?=
 =?us-ascii?Q?QDtq0pgA+QtOFu+6+Wr6IFMguXRTEVnvGUOXC9NCbGG/aunMN4NEIemIzAe9?=
 =?us-ascii?Q?F/A0grSv1Abik4+42kn3SDcb8w79Ld8d23QIu8sIw0Ef0dKDj9tPsibJzb/o?=
 =?us-ascii?Q?GrLnbg1kj8FsIpY8m5pP3BN9nex1PazGk1Qba4JayMPT+5YuQ8x+uUAvzdID?=
 =?us-ascii?Q?BfOXx/s/x85RUaNEi738HBtl3WEUPGQ+IGaJYuEVkzSRfp7TdYbIvEx/U+ae?=
 =?us-ascii?Q?IymJokc6OVMdM7qfvxhSI6OgA7u7rSVnbkt01IATl20IWrBeGkPNBIwVuYZt?=
 =?us-ascii?Q?EXW4iWIxpRlETBw8ZYJBLQY5aTZ3bfuVfsv4NoTSyFk3LMI6KHwlRxhLxvOR?=
 =?us-ascii?Q?d4o3sg1S7CeJZhegFhmZ8Uu0ogeD3SQfLihjGsnvby1WZFVoRgVbArTDtGk+?=
 =?us-ascii?Q?lFxD6uwLs1EWSCKSPailv1d7q4AdOrxD5UA8dGmngvh+oYDDKxV1RgDEI4fK?=
 =?us-ascii?Q?r0ra7XXTVI5t3fnJGik=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:24:12.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62674eb-26c3-4ab8-eb61-08de1bc6f8f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608


Nikolay Aleksandrov <razor@blackwall.org> writes:

> Add a test which checks that port state bypass cannot happen if we have
> VLAN filtering disabled and MST enabled. Such bypass could lead to race
> condition when deleting a port because learning may happen after its
> state has been toggled to disabled while it's being deleted, leading to
> a use after free.
>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
> index 2b5700b61ffa..20769793310e 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
> +ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change mst_state_no_bypass"

I think you'll need to adjust this test for v2, can you please change
the above line to the following while at it?

ALL_TESTS="
	ping_ipv4
	ping_ipv6
	learning
	flooding
	pvid_change
	mst_state_no_bypass
"

>  NUM_NETIFS=4
>  source lib.sh
>  
> @@ -114,6 +114,39 @@ pvid_change()
>  	ping_ipv6 " with bridge port $swp1 PVID deleted"
>  }
>  
> +mst_state_no_bypass()
> +{
> +	local mac=de:ad:be:ef:13:37
> +
> +	# Test that port state isn't bypassed when MST is enabled and VLAN
> +	# filtering is disabled
> +	RET=0
> +
> +	# MST can be enabled only when there are no VLANs
> +	bridge vlan del vid 1 dev $swp1
> +	bridge vlan del vid 1 dev $swp2

Pretty sure these naked references will explode in the CI's shellcheck.
I expect they'll have to be quoted as "$swp1".

> +	bridge vlan del vid 1 dev br0 self
> +
> +	ip link set br0 type bridge mst_enabled 1
> +	check_err $? "Could not enable MST"
> +
> +	bridge link set dev $swp1 state disabled

Here as well. And more cases are below.

I've got this in my bash history. Might come in handy.

    cat files | while read file; do git show net-next/main:$file > file; shellcheck file > sc-old; git show HEAD:$file > file; shellcheck file > sc-new; echo $file; diff -u sc-old sc-new; done | less

> +	check_err $? "Could not set port state"
> +
> +	$MZ $h1 -c 1 -p 64 -a $mac -t ip -q
> +
> +	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
> +	check_fail $? "FDB entry found when it shouldn't be"
> +
> +	log_test "VLAN filtering disabled and MST enabled port state no bypass"
> +
> +	ip link set br0 type bridge mst_enabled 0
> +	bridge link set dev $swp1 state forwarding
> +	bridge vlan add vid 1 dev $swp1 pvid untagged
> +	bridge vlan add vid 1 dev $swp2 pvid untagged
> +	bridge vlan add vid 1 dev br0 self
> +}
> +
>  trap cleanup EXIT
>  
>  setup_prepare


