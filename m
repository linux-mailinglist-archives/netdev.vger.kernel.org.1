Return-Path: <netdev+bounces-121444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DA095D2FA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DC028947A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DB71898F3;
	Fri, 23 Aug 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJrz2DMD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363D12B6C
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429711; cv=fail; b=q5wSvUMCp38FKFMc/ROSpLKpAi05DkkJdnyTODVysXSrsibk/eY9MnNZUgrQHmE+NLPux+Yep+y/HrdxvdSXqbemPUZ+THBvLpbL1FPMFcV9KSc/Aub8EmRbWIsijxmGLLCvxaJlDNnrnTc9vjGPhEqqLIgql+fR1TRwhAucNDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429711; c=relaxed/simple;
	bh=gxRb7r3UqCuUqsf7yHFMh5cS77LNBcp1Gcwl3EmfoZ4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aPA5crAlHz9/wN5OLg0thL5fLoQnep9HdlsBP+Mp3flT4bGfffF0RmjcB2ZW/ierTByy9eQM/meJpJdP9cqe7oDEySbFvh6tU3hsxr2N7Glv58OXUZUcgrVMx+cslWeRNrEqJkeFafxH/IFqvF273oJNJTRxLikdpyb49WBifZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJrz2DMD; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osg6lI9gMzGOKmjsQE6Vi165Xc7A5IJ89fgT32Kgpf7kmyTAKUjy0UasxTMwboL6I8Ga3XaD5EHWZAN72yM7jEDJZc0svkm32bX7jfmjsTaZ3cxLD5Xvaowkjk5XJNK3jQzFxYSCcO8+Hg5VCbFcERCDff6zYqmLojX4BizqI1hRR/5iSO/osoIDNULfbgvf6Ot7USu3M9n47goXphqLUfTIU19focMRaoR/6HQGvmF2PQQyWxsKKUg49ivwaxAxQEdXpf0lPVD3rOK6ONnOgGpwHrYbF40Xl5rF59FRFGZ0p822DZtIN08PrqhTVJii2oXhIDuaL17CfQXs+10F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ARGXgnySVQY/QYrIACHlx2ywU1Y+uC5OY/bx0obBQ=;
 b=sz3tZBPu9Yn8/rcO7Vv+LjvdOBUE/zy6qf/3PefTRMBGSblHdswXr6RiHAaSd7J3Ry1iqD2owi+9Te5L2HOKxOThBq/Ph2Ocy7lASxAR9JPNzXRTydVQsL6giZGQ9bjVJvI1OjShhBkaYRGsdQ1O3MITjyQ/GyL2Br41L5hh4i4+B3wyfkOYXQossuaG1/DE2aJrE9aHBnExBANK6vnvEaasDexts62bRk7wg+1hdaGy7do5+YgmTCS4BdHdqeJJ0MgROcim/gI9JsHWgkv8o5xG4tokDXaYDiZ9gIhLJBUUJHwxKsj400ivSKYzPGod8kUiehixVc5zBbsYw2zmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ARGXgnySVQY/QYrIACHlx2ywU1Y+uC5OY/bx0obBQ=;
 b=RJrz2DMD3xi5azGiAg+IZ5Gdkqjy7+ivue14XattMQeZIQm+roR87PiFvUFpJ0sg1vTYRZy7iPFU3N8yA844kYIXrGbIF6Qk3VmRc1RJ4LpEiUoWaIo3xpc1T3X0S1bPQ/VJRQLrm0khAf3PZlsjiZiGrbw7pyXsMAIlObZhp3dEHBM4If66nZ+65gXZOsgTFQy63ZyJ5kNkR6+sgBZGxG5spZKPllESX4z2XkDGAH1tDQRWvp4TKUXz9Z5nWieTbS3Ou6mL1y5jOWLhC1wAeKTydulSDUpTuVrlX3Lg0SlYFGLlWVfYmiZMepT97wYSmDjyAnLvbq/snWMbyKiSjw==
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.29; Fri, 23 Aug 2024 16:15:05 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::f0) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 16:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 16:15:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:14:53 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 09:14:50 -0700
References: <20240822083718.140e9e65@kernel.org> <87a5h3l9q1.fsf@nvidia.com>
 <20240823080253.1c11c028@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] forwarding/router_bridge_lag.sh started to flake on Monday
Date: Fri, 23 Aug 2024 18:13:01 +0200
In-Reply-To: <20240823080253.1c11c028@kernel.org>
Message-ID: <87ttfbi5ce.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 09142605-b334-412c-a36e-08dcc38ebff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fsJVe4GZJZpZh6JFGZPuXJwV7xJPK3OBjkU/vpm3tBJiOyqIR4+N4/w9zH/F?=
 =?us-ascii?Q?qUlgH5Jy/Eh7rEsI9ohpJXSIsCqcEJj5FBNLpGPFz9kjzUpjRC/OiBxaWe6q?=
 =?us-ascii?Q?1qkuiZh4MAYHy7HpNLWgrNBtq5a+WQJxIsDssY1l5KC2x8QfTNNYSn6B6CKx?=
 =?us-ascii?Q?ph+Z5VEos1SWwcn7QdzXhvTStbTwYnNU1wcrDgKJeWn2z+vt9f2AOL4woD2i?=
 =?us-ascii?Q?3XDmLv3e+C9GrQZ1Ih6DWC9ZXDLh5fve26NZfudz9y5AExwZB5h+cfBp98DP?=
 =?us-ascii?Q?/rX792BX4W54NEoaSH23gbiqNFyD+yV4l3jbEFUsaq052zmUy03i/SSd3wWW?=
 =?us-ascii?Q?9AXH3jldoxnrJTpZSV64eC8H3E8ASKRQG7gW9iC9+hppfuGXXg93bRExkR2z?=
 =?us-ascii?Q?JRqCpHQOtPIvIKV0glmBtZGTB5D8DOSvF3dXfl+hWlWTDOGJH730fp0GRQxb?=
 =?us-ascii?Q?3BMjSRDr0JAn3Xao/48sO1Io47AA1tdqKvsGVYgbD0HxS3l+H8tGQjm0GxAh?=
 =?us-ascii?Q?XKvSXUCKp61GlBfRNPWUvSv+FO+BbyPY9jjuxWdjwOw0pZKUjxkKR0QWX+gD?=
 =?us-ascii?Q?vUvLBQCwXlrWuSJfThe2fZYoXPJjbWnTTrsH9eLQcZmvFYQQ6m9X/LrxYasA?=
 =?us-ascii?Q?mX0uTfSXgTUCsJ1ZTC7u82Z+ES/ffgCs372EMJ9EuudFi/bEX46v/zHTncu9?=
 =?us-ascii?Q?HA6j2VShK5tu0PgQVKSpIcOt3EB87vA7tVpugi22RNsM0EoR2sCh/osvSIQ7?=
 =?us-ascii?Q?b8BALDCY3dxnSb3YTP3BqVvKISMoQh+g2z0VOOxe+cfGt4fzbT+elmZuQpod?=
 =?us-ascii?Q?RTXQ6TEvq5Msl15Wp3ogACCt8O5nrs4TfhGTxGa5Tu/UPjp2Z1V52ViYa8Ao?=
 =?us-ascii?Q?LN0DICe+oYGWrmLIkUplIgR9wsMGDH/deWiSqUpgfxznHHmyoWUs6VLH/tfW?=
 =?us-ascii?Q?WcBaxVwDnkBisWRaOsYiCwBsiU5ubV3PFVZPQYmupEF3NCBULazEbIZ4hlLy?=
 =?us-ascii?Q?JYfH6UwoiXRjkqefVV8q5d1AhXm4Gqy/Gq24JVOzNDQ9A/X/oYGwxiTqq1RS?=
 =?us-ascii?Q?TveURb1fyX5Bzx0LjGklgHLvM7BYpKkDJ1S4dI1ZKTfvcRTLh7e2nMwGp+7K?=
 =?us-ascii?Q?7N3A2NGYdAt1p7H6Px8ZStRmBn1rvEhs60S6R1Jops0El0d5hX+SARz6rAi7?=
 =?us-ascii?Q?sv98WN7PcOIt4YOjPhJ1foky7c8V+eG2gWSkSmucW1vMHqQSzJJBVhpTOjaU?=
 =?us-ascii?Q?dQF9cEXvoaSCJuQShUxxcCM+LGt8zQ9qT3I9sEUnM8Q44tJ4a+QmzfGFfrkV?=
 =?us-ascii?Q?aBpbJL0APrNEl7OINJ+eLrc6vurugHVkr7jxCvfC39UrpdZpNDloeiA7rU6V?=
 =?us-ascii?Q?3PwUGCW6X60qnujh9mn6qIJm8nb3zz+E/XxvhOFaZjBTtGnB4pyO/cR7M0/A?=
 =?us-ascii?Q?nPMP9C/nNovDWn4NrqphbJ9jQVpiG9mr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:15:05.1876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09142605-b334-412c-a36e-08dcc38ebff8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 23 Aug 2024 13:28:11 +0200 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>> > Looks like forwarding/router_bridge_lag.sh has gotten a lot more flaky
>> > this week. It flaked very occasionally (and in a different way) before:
>> >
>> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding&test=router-bridge-lag-sh&ld_cnt=250
>> >
>> > There doesn't seem to be any obvious commit that could have caused this.  
>> 
>> Hmm:
>>     # 3.37 [+0.11] Error: Device is up. Set it down before adding it as a team port.
>> 
>> How are the tests isolated, are they each run in their own vng, or are
>> instances shared? Could it be that the test that runs befor this one
>> neglects to take a port down?
>
> Yes, each one has its own VM, but the VM is reused for multiple tests
> serially. The "info" file shows which VM was use (thr-id identifies
> the worker, vm-id identifies VM within the worker, worker will restart
> the VM if it detects a crash).

OK, so my guess would be that whatever ran before the test forgot to put
the port down.

>> In one failure case (I don't see further back or my browser would
>> apparently catch fire) the predecessor was no_forwarding.sh, and indeed
>> it looks like it raises the ports, but I don't see where it sets them
>> back down.
>> 
>> Then router-bridge-lag's cleanup downs the ports, and on rerun it
>> succeeds. The issue would be probabilistic, because no_forwarding does
>> not always run before this test, and some tests do not care that the
>> ports are up. If that's the root cause, this should fix it:
>> 
>> From 0baf91dc24b95ae0cadfdf5db05b74888e6a228a Mon Sep 17 00:00:00 2001
>> Message-ID: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724413545.git.petrm@nvidia.com>
>> From: Petr Machata <petrm@nvidia.com>
>> Date: Fri, 23 Aug 2024 14:42:48 +0300
>> Subject: [PATCH net-next mlxsw] selftests: forwarding: no_forwarding: Down
>>  ports on cleanup
>> To: <nbu-linux-internal@nvidia.com>
>> 
>> This test neglects to put ports down on cleanup. Fix it.
>> 
>> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
>> index af3b398d13f0..9e677aa64a06 100755
>> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
>> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
>> @@ -233,6 +233,9 @@ cleanup()
>>  {
>>  	pre_cleanup
>>  
>> +	ip link set dev $swp2 down
>> +	ip link set dev $swp1 down
>> +
>>  	h2_destroy
>>  	h1_destroy
>>  
>
> no_forwarding always runs in thread 0 because it's the slowest tests
> and we try to run from the slowest as a basic bin packing heuristic.
> Clicking thru the failures I don't see them on thread 0.

Is there a way to see what ran before?

> But putting the ports down seems like a good cleanup regardless.

I'll send it as a proper patch.

