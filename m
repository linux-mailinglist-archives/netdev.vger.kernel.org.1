Return-Path: <netdev+bounces-197616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D35AD9581
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014BA189A158
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D5233D91;
	Fri, 13 Jun 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnf6U0d7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64520F060
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842614; cv=fail; b=izst+NOlsEErU6dZlFZ7UrDaFt4YFVqMwgbmxCtaiZ8FCVAvz8CtyDkEsk4MhBDdxwH3E8xG4AeHu5VKGc6pzFXlwTzvCHCF/zRAtGy4hrF2PYcUD2ze/9fBm33FEoScF8sma//6aulzI1Bkztkg3RmEN6o9jCJECGF7NEChWBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842614; c=relaxed/simple;
	bh=Bfx+nySr9P64kJ6OB1IhUPkBzFELBLtXbtBnVrzcbN8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c83Wmn6nkrluJWNtNsHoBFsoneMbYKfq+Rezw8Cq7HZlzQhkbB8w5ax7Ir+F2QGdqrLXUG1hqthwVAH4Sy3NFspCy1XjoVl7GVjR25UoGgbtQ5olqcdnaReBrY3ydFTa5AX3o6pEQHGyVDZyueA/yNSALRG39cbySq7850xkHTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnf6U0d7; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0KEuof+xZUZJdRg5nbghf6l6h+5WT9kzGuP1xyqtdk4XoUm1xSCJD6NoC73SlEqZi0C+7OAQx1FDl0YxnZRKeaB4+Yq6Aqdg6FRfJfQ0oPVdOGBnspZjGpquLmDjnVW/c4qgXano1swsfq9Bsm0GTk4bD+t8pY6EyYdBe7IXtmlDqMSEWPceU8f5e6+HT0mMXqic8tgpuhVyw9H7yoBB0yKY6DRVSVv69aMDmdDqS08ufwiIONLw6g/xB0Yi/nSKMOBCgXiVm537zhbYsN+Hk4tijiHNFXzZtIwPD8PE/0yP13lhDQ3Eh/LgqxImrVsBgJDbASMMzfqWo5dH2kVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcG3b+dd/UmFuFC31I1+K3OYctGMaEcQircdw0O82I0=;
 b=yjq85rs0wcvBmgVyceuXxRhG0CC6lE6ZiELPqeAmZc/2FDWdrEUeF+pXog59XlAsqK6FnyHw5B8emqHNEKb477tgAhK6drMxVAHYXpd5iSnCGxriKsOTRHXQYXTuNpWYSbF9doQwPBc1szqkgzewVnSyic0qCvYOENUOQaYWg1AlKMSjCyrrBpHuv9gOPodwe+IaMChq61bRryZQuOvRidOBUnnHim0qPLIKivOrdBQw8zWrEDEGZow73CE43KYj83sKO9u2mPvBv0YNAn75nFUSfsbhbUCVrtz2cnppIritzkcIynjtRJsXotCvSAZdKdOw1U3j1S8QOtuePRmWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcG3b+dd/UmFuFC31I1+K3OYctGMaEcQircdw0O82I0=;
 b=dnf6U0d7uQiFOx3YLzDHMAF0wzESMI92xuUR9zDXU13Yx7Aj6N+TRF/isDk3gNQkxd8mfgSoMu5MpreDNBUSfpMZEMNOBeZ4L2YFMPfHAGqu2Zobcrd9KE4zAidC4DsstWaOl/wv8GZ91eKe35g/u+/gKihHVskUIdIAu4SMJ2KUvrJvHKPtwebJFWUF+QkdzaPS0dY+XYxSD4x/Jqk/FmcKVrp6AgaXPdgjB6Y/8J+9Skt9mbJYJG+LJHCXjfWb//9v0/p9sOxohSLT5CdDG2L3rolaPhg053ndyHb4YLyv0DUi1w3vwCPLvEF3JPWmfFKV7m/Lh8T7rZ4idUybYA==
Received: from CH0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:610:e6::30)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 19:23:30 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::df) by CH0PR03CA0295.outlook.office365.com
 (2603:10b6:610:e6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 19:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.0 via Frontend Transport; Fri, 13 Jun 2025 19:23:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 12:23:12 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 12:23:07 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <175561dc917afb9a9773c229d671488f3e155225.1749757582.git.petrm@nvidia.com>
 <20250613094806.2e67594c@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 09/14] net: ipv6: Add ip6_mr_output()
Date: Fri, 13 Jun 2025 20:59:27 +0200
In-Reply-To: <20250613094806.2e67594c@kernel.org>
Message-ID: <875xgz4fag.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: c845d104-6c52-4ba3-a219-08ddaaafc770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ocu1estuMmPv0Zo1xLEfGqF0ajHolL17uty4M20fsy0RWmTeSD3dn9RSxKmh?=
 =?us-ascii?Q?3sioEL7MC2WTRXaHKlsHQbqLoL0IaKQIvMHJbUURqtQ/ZpXgTFI1sRcxauxO?=
 =?us-ascii?Q?IDZIVUP/RisQ/yqF275vub7TB8VLi4b74xo4POQwHwqdWSne2tGAlXs57nw1?=
 =?us-ascii?Q?hM5QXQiq8bBjU2TOcftOsf8E+NCXxI8YbqCl32kvE/danw31jojeM+gQOqrc?=
 =?us-ascii?Q?3MJsMqleIivo87iobTRbrVc4VUFUX/ZbvUERJC5qWLVh/PWiBMlqns+Pvrud?=
 =?us-ascii?Q?tDSdfXGfeSldqQdfia+hA/odnsnrWsqjma3vyN1xhDtxtcOdtVx8OS62AQA0?=
 =?us-ascii?Q?qQPQue6kmlzp3KP1gkCpO5cKLbW5FvMPBKCDeM8kvacSJB9S12tYPUGmPrgp?=
 =?us-ascii?Q?dvoWZQ0MGw98/B+pYio8cxLv3y339ptfciV5ObGxMwr584alNd3QocaPpDDK?=
 =?us-ascii?Q?lSjVEBYfkBlMjOWFKfeaJTBfh1IjhuMLyvW0UBXSsyVetgOIVJcPDQKxl0ca?=
 =?us-ascii?Q?R4mN7y4/pWFaYupA9AiH50Ip40mE+ImNs6RorT+6O4DbQhWwdyNEJgUseEyp?=
 =?us-ascii?Q?xtylT64/GUykIG/XysiA6s6wpcdURS3Qjbvp8ty5kK2aSqmbC9qZsmnDEVau?=
 =?us-ascii?Q?p7ngjbhZzKJfaIbvMRJQoSON/Bqnt2CPQzO4KIUW6DLtGMroyHF7AdRVY/uW?=
 =?us-ascii?Q?RtdrmGbeU28NVM5MkD65ayQQM77emuRqoGjOhmVv6xq6truZE2Fewr9kmFA7?=
 =?us-ascii?Q?HaTBak43mbS83i4xnk7H7de6sBpPStMI1BGESDGzeuXB+4W796mUpghvcJZQ?=
 =?us-ascii?Q?nhj1mOwoihVP2AK00W6WibFDMB1AK8+GrNpyigqyeTojlYIhkqiJe2pRS9pi?=
 =?us-ascii?Q?f2T4WLgLF+DTL7akevJ8GrWvfUukVvz+131DzOVQmeoKXhV/I2scZbkd/6va?=
 =?us-ascii?Q?BiHbVf/J92ivMjErKuKDjseC5Id5exXl9sDNI98NOzxV3MlAZYSKSyZAxD6K?=
 =?us-ascii?Q?dgiIffJ3s1pFN+c3VrTeNbf8Ux/G96xOAhFHLuL2liLktl3IfoURDjqtnbOs?=
 =?us-ascii?Q?jAUu+MldruBnqkbnV4uEyC/2tNV7Cpnv94wvypwxz44F8hGJAIkZ9G3InLaG?=
 =?us-ascii?Q?HH89+cmaQ93pxhH9e1xeNdZt248hqhclfGbWU1JljugRWw2U9Irdw8mSjhNm?=
 =?us-ascii?Q?0M5zbMZgPeApCffyShAcbRiLM4uqLpkmAYteeP0QGoo40QOufk9mFPsqIo1O?=
 =?us-ascii?Q?0Hdr2D2b0DIey8yu3cd1rkY4shb2VKvS/9HRiJ/xNmHB/hKZd//qERLy5i7M?=
 =?us-ascii?Q?CX4oN8U9akshgYfuPXOAGkItCDFI/s+Ht4MtwPGwE+oGTdqGQ3l8vj1a/D0X?=
 =?us-ascii?Q?ZcinMew50xaMRnoPlED2XEfoIyIbpAbyDTpMpgQeHekhhfr27kL9chL1ffnr?=
 =?us-ascii?Q?rdh1icKuHy82mjbS29qaB8iSgkLKZKlFBIAiwT1aQXEq0sjHeAQhYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:23:29.6796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c845d104-6c52-4ba3-a219-08ddaaafc770
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 22:10:43 +0200 Petr Machata wrote:
>> +static inline int
>> +ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>> +{
>> +	return 0;
>> +}
>
> Shouldn't this free the skb?
>
> That would explain why you're not seeing the problem our netdevsim
> runner doesn't have IPV6_MROUTE set, and you probably do?

Yep, that's what reproduces it. The NIPA how-to-reproduce instructions
show they use tools/testing/selftests/net/forwarding/config, but those
enable IPV6_MROUTE, hence why it didn't reproduce for me.

This ip6_mr_output() fallback is completely broken, it should be calling
ip6_output() obviously instead of silently leaking the packet :-|

