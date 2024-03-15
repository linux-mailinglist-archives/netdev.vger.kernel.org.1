Return-Path: <netdev+bounces-80058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C63087CC2B
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2EC1C214AE
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AE1AADE;
	Fri, 15 Mar 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NEStVgzo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECD1AAC4
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501480; cv=fail; b=sW12o0ymnJQuzhX03YU+7uNHFmjOROyq3+0yndX+6ZohlW8ktcrKgIOYNa9noDL1947rlI7MnTpG0LByXc2n4eVo6E+td/uE7uKJcJ3Y/qGBqeJuksqUXRTc9X7lwYx8g5XZJlv5q2ls5nG1cwtEXl2YKPf8yJE5COmV/HzuNjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501480; c=relaxed/simple;
	bh=3sTRa9qz7QdG4wHcuEMDKpm7P21AGRKfeSEBnGsx+GE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qTLwnZZh1azQzPQEtn3Vvee3Bc53yoP1tS+P9stSmGWpHeGpVPDGl9zBSzYrn3d8xXIylUTmSiVK4GawA3S4UrhhY4pGJROpzbuoBeropKZh6/Ry9z50ppIPIhsAwknFhJYMidD74aVEkgexgfRJJ3J5n1gOKf1FoP2AA7VLViQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NEStVgzo; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7tUPEJc4WX2wxBpADS/sOxp+emUnDqvllgW8is6H2ARRsDKlRqMRu0IfbYYTWAiISsWBt2wlRp87CLnN1bWUo1GJTti2MVaT406rJKUW5f0VffoGXWkPNRkXQHOfo6OemLReZYXunEtFpW8c1mwWf2MAe7qLzGulliasqpCJ+Mo4tgIvRKIxLKHmElzLBe6ucLXXbfcAckU01QVp9DaRm+DChlqoRt7yQWcAudSqUKzRRKturOeelQIeY5ms04uwxjaTeDP0zABzSBjhHoJtzoWxZ1VbvXIca2qAikbc1npQliPUP12SaPx33RZVOuwN5gUysVYumXXc+a6F66ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BmDqgiKjEhuHJKXOj1kKrqePLiz0ifYVB1FL6XNtL4=;
 b=Ksn/MrRL7NHvANkkyXHzJ2gkBi1dyrcXBXsCs46jhtX+ybRtvdcQ/Pf2aFsxDGx6TgrSr5O86RzX3N+zhZ/RL756BLmIsa520IG+OizYUVZIW0L6Y2zDla7ItaZqhFDQzLdu0VG31T05TiGjq2sNNh71dYw5eigSmGgPRLfrQ1+AK8NOU81XLqF7ZbwmvpQFo+Qp3ABc6olyDMsBcs9YXyMKeGUYPqB3cdCbqGfSIDhdG8UuFUud1fZe5sxA5xHO5VxcNxDLrdBmjvqJS7BS5kqpnTGsYK5fowtJ59SxtICM4uy0Xgu3f3DHKUJC60VFuZ4cmi+S/UD8YwOikJjnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BmDqgiKjEhuHJKXOj1kKrqePLiz0ifYVB1FL6XNtL4=;
 b=NEStVgzoKHwTJ36mfjSj5FnhkrqJ3JokXcucTOBwz7W1rKWmLZMkqYKk97rRjTjCuTKhU7eTVH1pGtZxeimnUcOvkSoQvO/B/QD7yvvGopTpnTft0R+CKnxvojf//BqDrltetWmoOUyvVpLecSt9/2bYZhA7VLuybX2VHT3B5mSRH0bRI/xwdauK0QM1WkLBN/7Agzoga4UB+GMo3rVTeDTGF4p7jGDsYT28sjpkAfhKZJLc6UTr3M3EvHYYxy9o6pLKotF8nM3FUkI+HBc25Ctrzr0iofLGuORM4lSuKADdWMBLFmIWynz3yPJO6qf1IEepSBOsds52h5Z9uT3CYw==
Received: from CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::16)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Fri, 15 Mar
 2024 11:17:55 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::9f) by CH0P221CA0012.outlook.office365.com
 (2603:10b6:610:11c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 11:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 11:17:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Mar
 2024 04:17:46 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 15 Mar
 2024 04:17:41 -0700
References: <cover.1710427655.git.petrm@nvidia.com>
 <66b2df7b7226a5a25bfcf32c9ef7f41394729ef4.1710427655.git.petrm@nvidia.com>
 <20240314085143.251f10be@hermes.local>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 2/4] ip: ipnexthop: Support dumping
 next hop group stats
Date: Fri, 15 Mar 2024 12:15:51 +0100
In-Reply-To: <20240314085143.251f10be@hermes.local>
Message-ID: <87il1nkalr.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d62e4d-6f2d-4a2d-20af-08dc44e18fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	75XoE3HrLjIONDTpkl+I3OfdtRWvBrTLsIWhEZIxFLV4rvAPsXfVOTeIi0sGMHmuR0L3A7RQwgGY8nHruBFuV6dl72xnwclHg1Ic1mFb+HT13EGdFzim0CuSrdPFdeECrrqjJp8SrhcJPlv/TK1WpTYifrW9+aCP2gN0C3iQlbnFXJqxQzmELoKtA8Dr0dOU5H5mDnZ8BbwKVZJIuxt1CLDpe4z7JEt/dffZbEcTP8h+0lDszhe7AE7fwmOuhwSOV5HVmrsB0j3WwZxL1LzGWNFYAjNrdffR74j354CKM/SxEVmFVLQG+c/kF5zehKOtTEKEFQ4TY2tP5+EYxaLNmu7ottveR0HfFJH3gl5l28UxYzckGIgLu8wf4mfvQzXsDN82f9zGMab2MYEgUX512+6eLS+yBq+yonBo4cxCoE0Gk/BtW92PHtnQNaiL57iIZhzQA69JNFbaXfKmwHBupgnI3XYV2Gdy3ti5i2Zb4e90WwgwTxFRgcwI8iFVAkN6KqkCoAA8xXixFQapI5KlquH6opMvSK+lf4F2RcR1ZBtijbaNCXZwDLr31V2pu1qPh3P+g13e/DM8Yj5Qf51cQ+KiQuPX0mmEKIwHJlCqkCxi/DsaaG76ru5WQz4KRbTcex+LgSRW0Eapjj+2I2ADATWiBYqBAq+yKNIKEk0cpBAnzqBC6PFvQb8KeXtIhOw3kQIVydTHbAm4W+dcqtJ3C9YjDppQeFI1i5dYGXeY+2T0tyc/WFyDDrCuTkBcg4i2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 11:17:54.8268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d62e4d-6f2d-4a2d-20af-08dc44e18fc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542


Stephen Hemminger <stephen@networkplumber.org> writes:

> On Thu, 14 Mar 2024 15:52:13 +0100
> Petr Machata <petrm@nvidia.com> wrote:
>
>> Next hop group stats allow verification of balancedness of a next hop
>> group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
>> 'nexthop-group-stats'"). Add to ip the corresponding support. The
>> statistics are requested if "ip nexthop" is started with -s.
>> 
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>
> Checkpatch complains:
>
> WARNING: braces {} are not necessary for single statement blocks
> #273: FILE: ip/ipnexthop.c:568:
> +	if (show_stats) {
> +		op_flags |= NHA_OP_FLAG_DUMP_STATS;
> +	}
>
> total: 0 erro

Yes. The next patch adds more code to that branch.

