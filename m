Return-Path: <netdev+bounces-106812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270E917C41
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077028E081
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C514D710;
	Wed, 26 Jun 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="miG/+sNK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AF16A95A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393309; cv=fail; b=S9M71xWBJpx2IjMUhU8j4VeNzJ8bXJIHTVdbMjWsWoA4qZoU9DOYHOyWQ/3Vo2gg3uTi1XR3B5dxTn03ah7WvD9VZjRMbMGi6hRvokKDmzJgahZ5T7daQ9ki5mDKkyquowFd3o8IzwufD6FglHbLZhlBeW7VcKuzbpeqkBLx6Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393309; c=relaxed/simple;
	bh=2xIrc4uC/M7WebYwaWp1NIOiR+F+V0Ti9l+AyRxAcbk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HEg6ttG3SlC2fglS2Ec1kxwMiq8+HQDGkvTha3JWGs9kyT9Kz0nMocgkfIh7Pi6w0KVOG0QZJkIsf8TLbL7zAP0sJiKVgDBzA58SD5vvbep1qqio5C5qCuIgwMl+goPu0al7ohBknH9+/zjhxkja8+4m1mLTlCy2TkvSqVjtafA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=miG/+sNK; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE7ASO3WkQ8+SssonZIlsIUnp0cbAwvdh67gLE6k9IWhmA9jYv3QcQSeWihADvidItgtKcwJkSuvy9zG4kZYkEl0M1QwlFDhOh10PyeEEMo4qQh8ytkDvmbjWoebzLKy1J9zdIcC0NgVHoLK53KqQeqKhSYXP48sBLtQ0EMiSO/kDXbgF1sT/r0lY428LGpD37UfTFRUqAjeCzstJo7LKUejhq/OzDOQRoGiBi4uk3bWQqT/Pcfe9mgOLrgl/4ue3F0Jk5Fie2kJrbEVSLXCp1W7Va/RMtoLf4wW5XJFL2yniTmD8H6vNkBxCgmCTYG0GfCiOzJozVfj8FKx/0V6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3ykRHhodTHRgKjTIXWNuqZHfkV+sQxqN1JhbsRm8vo=;
 b=AfUUdmc7HBK4CiFEdunssn1aT831mNuMIzRp0+8Lg3xmdEoeEOO91WlyoIp9faGJoXxQDLp++VqGyU/X6z6SPNL+A9uNjJTqWIrk7T4ewYJRI1oKp9RD/F77H5w1+7kGpBuoQ2J7mSRY9Kza6gPxrGnxMMc6WYf4Ne63xQ1v7qY4myFH1icLFbT86Z2d7vW8f7SRS05Tcbs2vPwfop0M7Gj8tIihJET3kzSzPMIEC0V3eOtNihlfWlQjgWtKH3ew9TNBZxHmXVmMLnDuH6fh2itP6zV490wJ3gDbuh0CEK2LuYJXJlghk5MpJ46ujNf5GkWZn/gsL0qMfDPsUE+Lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3ykRHhodTHRgKjTIXWNuqZHfkV+sQxqN1JhbsRm8vo=;
 b=miG/+sNKsraVyGSzNmN2ptzMDhLzpxDXSOSYVP+RM4knUrAAe4NcjD8JHaHtTb+AlpnrPsnoJvLiHdmDVE4VJG1DUOBTzKgd6y4GQoiTaAm2bns6uRAvznMyUxj0omxoMNEaFHGmEp7fN1xMv9UgxBYoVPcfO8qRnnCUZAJh/IkE29eK6xho4ZyY2opMmx0aq/qys+clKb8+Wta5a87YlIceSQv4AW4aXCWPUJHRpQjT2AgbmNfTkl7TdBmWio8pDZxdLm1eY2p1oZsLuX6Fh0qVIxpmjNVjPPawa3E9RwBdr342/AN0NMBIentyhuQLVNBWIXfu+qYlNxfaxDy4LA==
Received: from MW4PR04CA0266.namprd04.prod.outlook.com (2603:10b6:303:88::31)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 09:15:01 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::a8) by MW4PR04CA0266.outlook.office365.com
 (2603:10b6:303:88::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 09:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:15:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 02:14:47 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 02:14:42 -0700
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-5-kuba@kernel.org> <877cedb2ki.fsf@nvidia.com>
 <20240625065041.1c4cb856@kernel.org> <8734p1at4e.fsf@nvidia.com>
 <20240625100649.7e8842aa@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <ecree.xilinx@gmail.com>,
	<dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Date: Wed, 26 Jun 2024 10:42:48 +0200
In-Reply-To: <20240625100649.7e8842aa@kernel.org>
Message-ID: <87y16s9ibl.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: edcf14cc-db86-4d21-36ed-08dc95c0753a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmzdH+BzsPVtY7CnMSFScyzMdiZPNpPseUvwFn7IlOgIsg8IXNlzqCVe6iAi?=
 =?us-ascii?Q?1fYEjwMpl6HwpjxskhKXbqGZSG2/L5RVgtJEzPCy0oCpOFlJRGAX/ZAWqCrd?=
 =?us-ascii?Q?a1ZJogyg1BEI3GSybZbngEEqnFgD3McEYx94L7Ulb+F391gRsuQ+6ro/7sCO?=
 =?us-ascii?Q?UF3amZhJqMpwu9iwnLObo/UlYGXWnyD/9RWwlWyWpMBdYNIemvcwvKFaCep8?=
 =?us-ascii?Q?SFfH89e+ElzCzjfcT0UCqnoj760zd19HXk95zRcqMNfuJyS8dF7k2cCTN/zd?=
 =?us-ascii?Q?zFFGl1cc+n2woSrIxwDg2zXDz+kZHnzjCK6/pKxYL79w6NAkIKSLRjVxdU2V?=
 =?us-ascii?Q?H77LWX+OLN6hr2rwKxiyCx0ZJMXB7fr4GB52VClk2rVG8+p2vlniVGx5fEPN?=
 =?us-ascii?Q?T0ZnMwsMku9JztYPysQXS+SMMepgPclbvRyneCUHeO1/XE2b7uHIKpjCLl1q?=
 =?us-ascii?Q?WeSybt/f92Xd0EzgsarbA1dRSLGcrg5wQgBC/e+Gqhmh4mVYWERHMXJveRIP?=
 =?us-ascii?Q?EZR4N644HFMZ3p5YzbyY1cHMvsTydbC9IRFrHEBBULCbnCE+eWegwA4DuOVs?=
 =?us-ascii?Q?jvP3sFqzg1qKiXi9inhKwTznMkWXwQI/0GqsbY4kSYPo4kDpXDpsvzAssO85?=
 =?us-ascii?Q?EBhJvHHHSl/vWs1JccLPi9EYLBN7JpvSa2Ne4YCpXON+ngajkTBe3pTnbEE2?=
 =?us-ascii?Q?hOp6ApgcGQ9nbyrbBMwEZOysc3xA1b+/1UII8wif+FauxoYV1OIObb8KbCgW?=
 =?us-ascii?Q?iuAxFdl4YqtRMrizaJgYFWcD3eTAXAXvVOT8ie8FKnG/eWDmiv40EwR5Odih?=
 =?us-ascii?Q?mcUUKjLBzRe//Rpcx3sf1UIdZ81Z9XzplbAVWYAtIPV3mHNzbT/Afl5WHOPK?=
 =?us-ascii?Q?4+Bn/qazRNIJkbi2Xypy1xZsidr+01pYlNzebQ+V6IrusoD7Qp1QQORr/cH4?=
 =?us-ascii?Q?2rHS9g+6caN2oh4J85UFdKffHaJRQbzXjjfsnzD7pQ9SRtay3EFs1hfl8mXg?=
 =?us-ascii?Q?86vmGLLwDgW7Jb0z42dF0znWaIS2C09HcFafeySst/c2U/dYKjFY830MBzpm?=
 =?us-ascii?Q?nef+LZKOBXFW+z8NCUKWsV9Dp2YOpJq/omPPJrtJdXaX89KkfxNQvodMtxp7?=
 =?us-ascii?Q?6aiQZepngoNSqSHd236XKcM5guS9NM8PbXG9NDrI+SoYr6W8W5zZGvViMv4m?=
 =?us-ascii?Q?nSo7P6rsgAAU685UeXl6h5wLVtmSp4VH5VSr/NvyzpFfcTrpCMpmrOzVtqf0?=
 =?us-ascii?Q?2lxHxjMipEADQwgRD9vOPeBXtSYV4vim8tGiCGwxRa1Nvo0yp0rYV8h97vF4?=
 =?us-ascii?Q?zq7Npcr1foE1zi1QpD74kMnSsOaKxbMB0lynMfkMMutR1lHWdm+Za+oYzNA9?=
 =?us-ascii?Q?8EA776xY7EncIm8MvsCBNoBF9/dU8LziicImDviNQL9Ydgmjy9bsz8hyLpLs?=
 =?us-ascii?Q?HT/uX06yBawdQu1e/YSMfjsk6GJx9dRb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:15:01.2620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edcf14cc-db86-4d21-36ed-08dc95c0753a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 16:43:55 +0200 Petr Machata wrote:
>> > There are 4 things to clean up, with doesn't cover all of them
>> > naturally and complicates the code.  
>> 
>> Yeah, you can't use it everywhere, but you can use it for the ethtool
>> config here.
>> 
>> Re complexity, how about this?
>> 
>> import contextlib
>> 
>> @contextlib.contextmanager
>> def require_contexts(cfg, count):
>>     qcnt = len(_get_rx_cnts(cfg))
>>     if qcnt >= count:
>>         qcnt = None
>>     else:
>>         try:
>>             ksft_pr(f"Increasing queue count {qcnt} -> {count}")
>>             ethtool(f"-L {cfg.ifname} combined {count}")
>>         except:
>>             raise KsftSkipEx("Not enough queues for the test")
>> 
>>     try:
>>         yield
>>     finally:
>>         if qcnt is not None:
>>             ethtool(f"-L {cfg.ifname} combined {qcnt}")
>> 
>> This is mostly just business logic, hardly any boilerplate, and still
>> just uses standard Python. You get the setup and cleanup next to each
>> other, which is important for cross-comparing the two.
>
> TBH I don't really understand of how the above works.

The decorator transforms the function into a context manager. yield
marks the point where the with: body runs, whetever is before is
initialization, whatever is after is cleanup. The try: finally: wrapper
is there in case the with body ends with an exception.

>> Anyway, if I don't persuade you for The Right Path, something like this
>> would at least get rid of the duplication:
>> 
>>     qcnt = contexts_setup(cfg, 2 + 2 * ctx_cnt)
>>     try:
>>         ...
>>     finally:
>>         if qcnt:
>>             contexts_teardown(cfg, qcnt)
>
> Are we discussing this exact test script or general guidance?
>
> If the general guidance, my principle is to make the test look like
> a list of bash commands as much as possible. Having to wrap
> every single command you need to undo with a context manager
> will take us pretty far from a linear script.
>
> That's why I'd prefer if we provided a mechanism which makes
> it easy to defer execution, rather than focus on particular cases.

I meant it as a general principle. Python has tools to solve the cleanup
problem very elegantly. I asked around in the meantime, people don't
generally find it hard to understand. It's a simple concept. It might be
_foreign_, I'll grant you that, but so will whatever new API you cook
up. And you can google the former easily enough.

OK, look, I believe I made my point. I don't want to split this
particular hair too much. I see you already sent something for defer,
so I'll take a look at that.

>> > Once again, I'm thinking about adding some form of deferred execution.
>> > 	
>> > 	ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
>> > 	undo(ethtool, f"-L {self._cfg.ifname} combined {old_qcnt}")
>> >
>> > Where cleanups will be executed in reverse order by ksft_run() after
>> > the test, with the option to delete them.
>> >
>> > 	nid = ethtool_create(cfg, "-N", flow)
>> > 	ntuple = undo(ethtool, f"-N {cfg.ifname} delete {nid}")
>> > 	# .. code using ntuple ...
>> > 	ntuple.exec()
>> > 	# .. now ntuple is gone
>> >
>> > or/and:
>> >
>> > 	nid = ethtool_create(cfg, "-N", flow)
>> > 	with undo(ethtool, f"-N {cfg.ifname} delete {nid}"):
>> > 		# .. code using ntuple ...
>> > 	# .. now ntuple is gone
>> >
>> > Thoughts?  
>> 
>> Sure, this can be done, but you are introducing a new mechanism to solve
>> something that the language has had support for for 15 years or so.
>
> Well, I can't make the try: yield work for me :(
>
> #!/bin/python3
>
> import contextlib
>
> @contextlib.contextmanager
> def bla():
>     try:
>         yield
>     except:
>         print("deferred thing")
>
> bla()
> print("done")
>
>
> Gives me:
> $ ./test.py 
> done
>
> I don't know enough Python, IDK if we can assume much Python expertise
> from others.
>
> What we basically want is a form of atexit:
>
> https://docs.python.org/3/library/atexit.html
>
> The fact atexit module exists makes me wonder whether the problem is
> really solved by the language itself. But maybe there's a deeper reason
> for atexit.

I think it's just incremental. atexit was introduced in Python 2.0, with
statements in Python 2.6, some eight years later.

>> Like, it's not terrible. I like it better than the try/finally aprroach,
>> because at least the setup and cleanup are localized.
>> 
>> Call it defer though? It doesn't "undo" there and then, but at some
>> later point.
>
> I like "defer". We're enqueuing for deferred exec. So another option
> would be "enqueue". But I think "defer" is indeed better.
>
> rm = defer(cmd, "rm example.txt")
> rm.exec()   # run now, remove from internal queue
> rm.cancel() # remove from queue, don't run

Looks good.

