Return-Path: <netdev+bounces-251962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIILAwcDcWmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:47:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B245A195
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD029B076DA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C435581A;
	Wed, 21 Jan 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mz+qP0bS"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2934678B;
	Wed, 21 Jan 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010926; cv=fail; b=dU0U1DpmxFNQdI/pcXJ9Cue8LmbqFd8FAev38EiNShF1PG+u954TNuBIX+6Z9e0FMZwrpqadZB1+SaNMlhDi0OEp4FsLaRsfI/CfT80laRImen1pig2NOxph00hQ/AQ8v0t8iaYGd49jmxW5u74w/cRFqGDrg5f27686mJkZl5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010926; c=relaxed/simple;
	bh=20LtyoNl6bjSqa2HcrxUEC6p3nzQpcGkg5rO4Kv6fF4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cAS/fBTAuu63s5mtRubaxV569+YetPcGR/FoK1CUXvreXsVxku7aIuFlLBSmy2tP9TRrNdV48PwUk8UYbIBcErqsFA9pfXKM2kSrBxmUCGsicmbACY2lKgmGKl3nIn/7XF73NSlkxxauQ/LqtIczp/HmhdwOPl20/51WqCOYchE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mz+qP0bS; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVTwKKHIo+Upu3UDH+tzOZZ27Y4SKzN8ux7MKNGpjf1sQv4xwsTPL9/yB1Dm67PY5BRi02ZXJMlbBZ3NL8Z4BkXO3PIPkv0EAAbIK+TO4CWYa4mCTKMMHn5OSWX1xYp/6/1+/JiGNDkzOpY6ZOA77AhABf478fXrbUI8GhYDv5cskmPzM6u6xiaxIBeHEknOtZI0yx6GWxv82e1DIAExTz30YKArFS4KOT6G9JmQQlM5oJrjM/dEoc/cssuI4HbF8ZWnm8hQR70gaL8813Id3V1irwdXouKgka6cqRrBuoOoTDbMIVHRv67oB450IgLHdmI14X8wK6CCBo1/YJqlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wHixcaE17nXKCMd47/5Cpm6weOow4PCx83Op5Ogzmo=;
 b=hIkfS6ouGpdb5Hh6+bDBNWJIqvGp+tolsEzWtvOHyqgr739nIojtLBR8i8izTkbbjQmWllOG32bJAtXoSi3UFDUQ/Na1UMDIp3zBwCgXPfYai0gAL1uVfGtnlPXVqCmf12p0E7RbbkbTzwgRkXNzKIC0FH+C00Oi++UIYnsUQSe27WL+NZFD+IUZITGYc5DWDafNqsuvVGh+w6gBZgXb54cm6EzW9ODJ/gNjcr0OvPKrEDLYnsDOWQFzTnfozd5Xmc/YBr6EEo9f8stFvCyB6mIJV8UNHdNj6R5xwzQqxgAzru4t2e2QgIc1O821UnOrkEZaoeEsJDDrXXlK7WdMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wHixcaE17nXKCMd47/5Cpm6weOow4PCx83Op5Ogzmo=;
 b=mz+qP0bSqYA6WMxc/qmSaFg4e1PQ9MMoLlzralqQgkDtkmJSmRHsI+NRb1Qx8liTFJcj8ghsGqSZXHpOKYT9bUwcWnl4JhkVrG59ZGvCdGe+kXKe9e7hYbuX+p3G1l4eX1JWb1AAiRx1ORRNEUJNP60RVrfdwafvs7MOrUpiQqGxRDhoknK0tlXqXigcKPXYoi56dks1uy5iyaw94HSNzJxkbTAUbXjcalNKqR+PBq7HISkv7UleOwBdRCL18jeaAK+JRnxR1xew2og/4gMWHPJAUBcF/jNOM13j5Vqxhgm60KGoAIcT+nnwenoLebqqlGrNaYMdtBBhY18ixcO2pA==
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 21 Jan
 2026 15:55:19 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::c3) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Wed,
 21 Jan 2026 15:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 15:55:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 07:55:01 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 07:54:55 -0800
References: <20260120230905.328528-1-aleksey.oladko@virtuozzo.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: net: forwarding: cleanup veth peers created
 via NUM_NETIFS
Date: Wed, 21 Jan 2026 14:39:47 +0100
In-Reply-To: <20260120230905.328528-1-aleksey.oladko@virtuozzo.com>
Message-ID: <87tswfgdv8.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 837d4523-468a-47cd-b050-08de59057a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFfybVTT+41Vcqhs8DrkkGPNDfUnTbrVP3Om6Ze/IaBgWZvL9NztJK0wio3u?=
 =?us-ascii?Q?bFDm2bwrZnhlclCO3GA7m3+bTCSh0uJK3Zamxgu+Rrm1DTxW9UgZ3UVcqfRC?=
 =?us-ascii?Q?WEw7YokEOEGpUnYkvQ1BD3Z8iy7QulECtnwRWvdetfQQ9DF3ULKpL67oiPBC?=
 =?us-ascii?Q?BiRnwb8AvcHJbofV+xDU3/au3P4k+AiWfbw9y6Q61tzCSys6kATe4abeCmpo?=
 =?us-ascii?Q?NeU9tYDo5Nv5iP6dUF3MPOnQX9W8u/sLKSImphPoaRldiFGsSFehAfbO9rvW?=
 =?us-ascii?Q?YqKEOLdzX6Tpn3F+9mw6BycI+9Nsf/7tLBdrUpMS2u5sO73rtLDnzwvssLlp?=
 =?us-ascii?Q?rRpU0tmL2xnW9H9LgJ3gpvlhn2B52NRaYFTosGQPlM7zLG4hnQ9ulceUTE7l?=
 =?us-ascii?Q?r0v013dIMrLc1y2fZpu3HBQf4oDkjQwyusbltWIyZDRUKtTnS2IQmmx+O4+W?=
 =?us-ascii?Q?I9WkPAQ8Hye+mP3I+zeD81dkwGl4DvBD3YWqQOK0lW+PiDyUamsNMy7EifwN?=
 =?us-ascii?Q?fWvNnePvwpPDtdOHZPnmCir+2CA0hQGfgPrQaoJl1ogNwdRiokWILntDpqzZ?=
 =?us-ascii?Q?5pX5Z3sahrDM5yCZU8kbF6pzTSjZZ2cyR1bXuJ50bCMGO4q0IoRUHhwJ3gv+?=
 =?us-ascii?Q?WKW7prc/meg53xRitKWmmQuF2T2pnPHHyDu0rd4GolYmENw1pzZbnWlbo0DE?=
 =?us-ascii?Q?0F36ujN36x6IhSMI1LwfEMkfQISVQYEIUlDOYVgAP4LIbDyMN2LJs+c+aZib?=
 =?us-ascii?Q?CHrwwLKSUB2pb7YSb+o69LNWWqsiK8QuEPMqvus7KQqy0B3nQe7kxf7tbXO7?=
 =?us-ascii?Q?ETBSm6JaJDOoueDzTQ0gDKNJAC7e4QI5b9gDbIrQSIg01pUt55VD8YmbgJt4?=
 =?us-ascii?Q?UXqjrCi/ioAMGESqgax/uIP/qWIiUIFjkAjWKTO0erJLftNdF4NrcjCiHVX8?=
 =?us-ascii?Q?7eG0yDHBsk/d+B6/JzuHtH7rOUUJi1mAM5nXnzc1XgoiytLJgOomO4T79xTB?=
 =?us-ascii?Q?JcY4v/WBETNbxRQL98gfomU9T3LiUJv8DpJfpwx8F5Ky8D+RL/jc3wVaK0e2?=
 =?us-ascii?Q?MyZLYLxh7OcK/OQ2vrE8VV5oGciOmcYROCFgT3S/ZpseUt2WTLIVtWm4+AqM?=
 =?us-ascii?Q?FH3QtwHYMA1A8LfABNMOc0FsZ8qlxoTsYZQZ5/zCDll4s+Ldl5ElaxcHlT1Z?=
 =?us-ascii?Q?JsLFmTgTKbjVGgQnUKjBDyYyzK8WS1H6JYjJA97OB7TGhXledH5EpqutjaME?=
 =?us-ascii?Q?MAVrtXtVPfyvYlmSzB8Rwh+cSC55dRh9s5mm+15uFj6nOOO5LjEPpGpuEQJr?=
 =?us-ascii?Q?fkaYe0DBDkrg46h7WwwBAclczejjUef3c9I9DOb9i7dTvih7EEh2OSUkfdUS?=
 =?us-ascii?Q?Z1yjNBTAcjtq9Ml596N1DlSoP8GuxU3fncYTDNHeGR+cDaZ6FbWrtLI+1DWp?=
 =?us-ascii?Q?CHFN76UqOvdxa39UIFP0LHDIi2NdwovLwqaBjhxlk0c1uuKDDRl7oe4HKJtj?=
 =?us-ascii?Q?0KFTSBE/uuLirJNb1mvupp51oeAFJ0f42pZMnq/FynUy1WI9ufBNW6jjt1by?=
 =?us-ascii?Q?WgtKJMeL8sb0y8Hhow+lzdYr8id8yhzm16iYcCzB769HhvfdD0a69t16TsFI?=
 =?us-ascii?Q?46Kf3jl09/kgrNSUQqBmHhsgmGXP6u9CSFGAUbKduf6NxeTSmLswH26pTdLb?=
 =?us-ascii?Q?vhJn3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:55:18.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837d4523-468a-47cd-b050-08de59057a0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251962-lists,netdev=lfdr.de];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid,bridge_vlan_unaware.sh:url,min_max_mtu.sh:url];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 75B245A195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Aleksei Oladko <aleksey.oladko@virtuozzo.com> writes:

> Some net/forwarding kselftests set NUM_NETIFS, causing lib.sh to create
> the requested number of veth peer interfaces.
>
> These interfaces are not removed when the tests finish, leaving stale
> veth devices in the system. This can cause subsequent tests to fail,
> for example min_max_mtu.sh.

What in particular makes it fail? I tried a bridge_vlan_unaware.sh +
min_max_mtu.sh combination at random, and that seems to work fine.

> Ensure that veth peers created via NUM_NETIFS are properly removed at
> the end of the tests to avoid interference between test runs.
>
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index a9034f0bb58b..ae7699c0c7e5 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -597,6 +597,10 @@ vrf_cleanup()
>  	ip -6 rule del pref 32765
>  	ip -4 rule add pref 0 table local
>  	ip -4 rule del pref 32765
> +
> +	for ((i = 1; i <= NUM_NETIFS; i=$i+2)); do
> +		ip link delete dev ${NETIFS[p$i]} 2>/dev/null || true
> +	done

This would also erase interfaces that existed before the test was run,
which seems worse than leaving garbage behind, which I agree is not
ideal either. Although yeah, existing tests create all sorts of ad-hoc
interfaces assuming the namespace is available, and then presumably
deleting them. It's all around fairly hacky.

Nevertheless, I think if the test should erase what it created, then it
needs to also track what it created. Then the 2>/dev/null || true
business can go away, because it's supposed to work.

Hmm, that's basically reinventing defer. But we can't use defer, because
few tests are defer-enabled. Or maybe...?


Subject: selftests: lib: Delete created veth pairs after the test

Currently the created veth pairs are not removed after the test finishes.
Ideally we would just use defer to selectively delete exactly what the test
created, but most tests are not defer ready in that they use the EXIT trap
for their own cleanup management.

So instead invoke the cleanup from vrf_cleanup(). Almost all tests use VRFs
and typically call vrf_prepare() first, which makes vrf_cleanup() a good
place to do it.

Defer-enabled tests however schedule vrf_cleanup() by way of
adf_vrf_prepare(). Invoking scope cleanup from within scope cleanup is
obviously not a great idea, so instead add a __-prefixed helper to do the
actual work, have it scheduled by adf_vrf_prepare(), and only invoke the
scope cleanup from a sans-__ wrapper.

This is all admittedly a bit of a hack, but perhaps less so than
handrolling a list of interfaces to delete, when we have a perfectly good
library for exactly that purpose. (And the hand-rolled cleanup would end up
being invoked from vrf_cleanup() anyway.)

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..729d6bedf97b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -392,6 +392,7 @@ create_netif_veth()
 				echo "Failed to create netif"
 				exit 1
 			fi
+			defer ip link del "${NETIFS[p$i]}"
 		fi
 		i=$j
 	done
@@ -591,7 +592,7 @@ vrf_prepare()
 	ip -6 rule del pref 0
 }
 
-vrf_cleanup()
+__vrf_cleanup()
 {
 	ip -6 rule add pref 0 table local
 	ip -6 rule del pref 32765
@@ -599,10 +600,16 @@ vrf_cleanup()
 	ip -4 rule del pref 32765
 }
 
+vrf_cleanup()
+{
+	__vrf_cleanup
+	defer_scopes_cleanup
+}
+
 adf_vrf_prepare()
 {
 	vrf_prepare
-	defer vrf_cleanup
+	defer __vrf_cleanup
 }
 
 __last_tb_id=0


Like your patch, this doesn't fix tests that don't use vrf_cleanup().
There's at least bridge_sticky_fdb.sh, but there might be more in
driver-specific directories, I didn't look. It should be pretty easy to
deferify those tests FWIW, the gist of it is:


diff --git a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
index 1f8ef0eff862..7d51676c886e 100755
--- a/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_sticky_fdb.sh
@@ -40,7 +40,7 @@ setup_prepare()
 	switch_create
 }
 
-cleanup()
+setup_cleanup()
 {
 	pre_cleanup
 	switch_destroy
@@ -62,6 +62,8 @@ sticky()
 trap cleanup EXIT
 
 setup_prepare
+defer setup_cleanup
+
 setup_wait
 
 tests_run

