Return-Path: <netdev+bounces-107141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5391A154
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944812821EC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868B757EA;
	Thu, 27 Jun 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEDJZ7dK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134241A94
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476613; cv=fail; b=AjmRqUcZyJ8NwmGL9+MFA65I3hCKCDU4cLlZQ5ybjyQW88zQaFuHHPFROnpRnQeuhCCTjyHQBw9QRmYR2jrayMh2FGTpUo389eCWAFisT/iAXuc0fFfXCFHQIicyH7IERnMjy4JlZT7CKwCNelUjVoPKwC4FrYMbI93XEuyS2Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476613; c=relaxed/simple;
	bh=ZQmG2m195G93hsro28czzXV9e7O3vu7Q87nomDhrI24=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VR8KzxTzw+FQjzfD2CnUmVMqRep2JdcJDm0wQ5CXotH8jOzRryLPj9vfCQqri3h1t1JcD73bso8mYW6kinzPDbDz7m+AwgJmejgHzCXVvcwWDFmd0Joz2l0RcjSfzUfG41nxqO6UV3dRbWAASSmBuCpwxiYqED/UJl5SsvlPBBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEDJZ7dK; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLBxd+suzQNQWCgHawyW3yFMqow0Ps4ADckugADLG70dwwNlx4zDWDMRiqN8TxF+Wvb3bF/RBymlvQu3DBK8rmaUAO6lUMBTk53p1AzVe5SD2EeFUThXhPY32OHMXUfMVIJRmiuL95V7ucQBswV/9ojJCHPUlFX/28U/q0y6NbOkOMsy/LhC1bttk3m/Eu38kGnUiASkVq5nCU4Z6Jk1G8dSItknVivzr8G7dCagVK2DnyLTS14tZIjdMX4s38zXmLAfXnzVC8xuUlHA2mY7ZKlHFANAvp0Z5IJMHeU4I8XJES8Kjmp5XU4usl/I63LpRg//9iscYwi/uaGESqo9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIlvd0R9I3DtkPot5Sp1VjgkAxBUVznM0+o/xZOHWLE=;
 b=Jfzcj2UOypMXrjXoOIbQGjhlQXRMO3VQpBc9CT3EZ/ZPV5PHCUAfgNvCgOAzCgEfrthZqVwlOeFocBtdjn9hvCZwga5t+hUWDKPodsRKaCy3brOg+MxYE8zE/Sy9gDfZ389SDqj3xRpZZ4GApunoiezPFX9jzKXs/DCQKAFOVC9rrQLEsqDRmlpi2T+cCyiD4jVE93NXO48BW0nbWAzP1hdBocvG+VqY+sdgNPmfO0+b1ecmG5JdFiNOQ4pe2ANWfC95WePtXqEZEL/dS9Apjqdn2TTTq5jiayjsQALwZ05isps7agK+ir9yzjWPHkKsTEAaVvE1q9XoFufAKdeV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIlvd0R9I3DtkPot5Sp1VjgkAxBUVznM0+o/xZOHWLE=;
 b=AEDJZ7dKmM3sz0Eq29Kqy5h+MySK9BdDZC/mucJRR1GQ4w9jZzWMcnvy3C9Js7KNhRs2yeYhtT5lR9Vo1lPvM3AOPaFhIVMr5TJIS0owXbKIBuAEQ+VvPmJZvOBta6GrVEaSvqJ1CFZh0YKWXdpDj96oU4OaDPTFjHGQvhBHRNp2QPiT4ssjE9zD5jvM9Ichq2bTrbnVUoFZR7nVpa+eB+6JLgjXpoJiNaVndIeKzAhYEs/dopRF7e6W0jtIKqhmp9YPAwVYGV5ZYUIUFofS9aFCmsmUld+l9DzKGhpJd9eie4SFJhoVHyPlv2rXlsaFssGKJeG3PSlMZspFysV47A==
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 08:23:24 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::40) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 08:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 08:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 01:23:10 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 01:23:06 -0700
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org> <878qys9cqt.fsf@nvidia.com>
 <20240626090920.64b0a5c0@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<leitao@debian.org>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Date: Thu, 27 Jun 2024 09:37:50 +0200
In-Reply-To: <20240626090920.64b0a5c0@kernel.org>
Message-ID: <874j9eaj6m.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a39f1f-325a-4ffe-a200-08dc96826984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8AQYDhJb2VcVAnYP6v+W/6AtOOZ7uJwak48HhrtsrDo6Jq9y5MwRa0K1O0mY?=
 =?us-ascii?Q?OyXxpvOLk2eSqNrO+JSrVTMt85MO85Y8GugEy5uWSmGEUe1ULtC0sEz82F33?=
 =?us-ascii?Q?ebn+0ciwdPMpIYARBK/NToTfceJE/jO+ZcSY/ONUIsg1a4kSsDiO5gitTv+U?=
 =?us-ascii?Q?isvlw4ONMub7FL9009W/8Zx0+u4AHR4BtPUntH3bY+ibtdSfA5sdeuZEV4Yn?=
 =?us-ascii?Q?HdgUjKDlc5BXFW3/gccQQpcUZwhQjdBh24/Qaip6DRKQa06QM4eFCB66aovi?=
 =?us-ascii?Q?NC1wOXj6VN4EnucSZEhy8Np73rDn6I97QeWGioYPA/JH8Qa2hX7AHOa0Wzie?=
 =?us-ascii?Q?YVghMSwT4Y0i0H3mUTnJcBctYYlVIs9kJ9v+ku7uUftlpFjiP0SCqPICQ+u9?=
 =?us-ascii?Q?PXXxjyhgfAemi5Cqut6gIqPmJy+BYqTDEJmFZfu7FGfAI2qMAkVU6Y7w8VoJ?=
 =?us-ascii?Q?IqLcM14rYtbhKCufYyNq1qLX60hXbuQB+QV8aKFp8ee5dtpXdhm8L8pOUa1k?=
 =?us-ascii?Q?yZhzA9LYp83JguIp3RZuAsex7ODBjG1YmN0DeGbSbk13IuYsrYcD6CgdLWAR?=
 =?us-ascii?Q?hUaBYmBiUy+Y2Gmf2fvUNpv2oEw0HtczM2jYK9iUBVQvbW12jcTQX7xCiUUz?=
 =?us-ascii?Q?9oo16nbGoZnnJJotpjWwf+ear8ydDF4WwfB3WRIclj9us9rjmzTzNcSUNj7t?=
 =?us-ascii?Q?+GsoA3qvL1iL49smwN5J+YcX2I8GR8EEQGigscTDbfm7WFKto124gO9535pp?=
 =?us-ascii?Q?VyT0qptDNZZd25s1ALoTXdTbRW3qt52OjnBlSk4fXEs+k2lbqssWMuE4oJE5?=
 =?us-ascii?Q?96pNKZ0aJoPi/AgTA+DYPAwhTPy8K37f9RTb/IsfMDuUXYwTFar+Llpbvrgv?=
 =?us-ascii?Q?ibvfXE5LUGxbWca08RkZUH9oMFvyrbSrXQn+v1Qn9u9m7h1lot+CHH538JZj?=
 =?us-ascii?Q?4HFjNBT5KzkJYDmHx92AKuLPlPLiy/vT6CQlArvzj/eVtNPHi5hgXZ+xOCDo?=
 =?us-ascii?Q?63nqp3EauZdMIz2RvjHYwGv0cgjdpnzHCphLd2ALPZOmjGJIU+QiwguzO56J?=
 =?us-ascii?Q?tYEijn9PbvBJLzxcDsmDJBLK6JyEml7BjwBXygiDUdb962RYcxYp6zfrc239?=
 =?us-ascii?Q?zPyI0KRN0Rw/PIkut0C03brHtVJPLhH7GV0W5WqMaJh2S7DJV4lyC7iyA5sZ?=
 =?us-ascii?Q?RialVSTL4b1mw8EpDyLNPlppllX5NNRSziO0v09+kOw5TEY9YuGfdfGLvwT6?=
 =?us-ascii?Q?RZ4Vn0PrF0TJfUf2v2xUFOyjr64FHYe7qYTPyBS+zNwv9scJ0FPy10zfsnAm?=
 =?us-ascii?Q?8eHOJzWl61+G/VAK2qdTwHdW6b4U4kw41/T0B5jiRDP6rku/Sqi0h6IFlHzm?=
 =?us-ascii?Q?H6lfjE3a52mKo8IG6NL9SmFqVfHXqRvls0B5VS0wPtFMrOraf1UG6ug51TJ7?=
 =?us-ascii?Q?7U+R5Vv/O/jucNlwTOO2BI3W24+14uy9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:23:23.7795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a39f1f-325a-4ffe-a200-08dc96826984
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Jun 2024 12:18:58 +0200 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > +def ksft_flush_defer():
>> > +    global KSFT_RESULT
>> > +
>> > +    while global_defer_queue:
>> > +        entry = global_defer_queue[-1]
>> > +        try:
>> > +            entry.exec()  
>> 
>> I wonder if you added _exec() to invoke it here. Because then you could
>> just do entry = global_defer_queue.pop() and entry._exec(), and in the
>> except branch you would just have the test-related business, without the
>> queue management.
>
> Initially I had both _exec, and _dequeue as separate helpers, but then
> _dequeue was identical to cancel, so I removed that one, but _exec
> stayed.
>
> As you point out _exec() would do nicely during "flush".. but linter was
> angry at me for calling private functions. I couldn't quickly think of
> a clean scheme of naming things. Or rather, I should say, I like that
> the only non-private functions in class defer right now are
> test-author-facing. At some point I considered renaming _exec() to
> __call__() or run() but I was worried people will incorrectly
> call it, instead of calling exec().
>
> So I decided to stick to a bit of awkward handling in the internals for
> the benefit of more obvious test-facing API. But no strong preference,
> LMK if calling _exec() here is fine or I should rename it..

Maybe call it something like exec_only()? There's a list that you just
need to go through, it looks a shame not to just .pop() everything out
one by one and instead have this management business in the error path.

>> > +        except Exception:  
>> 
>> I think this should be either an unqualified except: or except
>> BaseException:.
>
> SG
>
>
>> >      print(
>> >          f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"  
>> 
>> Majority of this hunk is just preparatory and should be in a patch of
>> its own. Then in this patch it should just introduce the flush.
>
> True, will split.
>
>> > +    def cancel(self):  
>> 
>> This shouldn't dequeue if not self.queued.
>
> I was wondering if we're better off throwing the exception from
> remove() or silently ignoring (what is probably an error in the 
> test code). I went with the former intentionally, but happy to
> change.

Hmm, right, it would throw. Therefore second exec() would as well. Good.
But that means that exec() should first cancel, then exec, otherwise
second exec invocation would actually exec the cleanup a second time
before bailing out.

>
>> > +        self._queue.remove(self)
>> > +        self.queued = False
>> > +
>> > +    def exec(self):  
>> 
>> This shouldn't exec if self.executed.
>> 
>> But I actually wonder if we need two flags at all. Whether the defer
>> entry is resolved through exec(), cancel() or __exit__(), it's "done".
>> It could be left in the queue, in which case the "done" flag is going to
>> disable future exec requests. Or it can just be dropped from the queue
>> when done, in which case we don't even need the "done" flag as such.
>
> If you recall there's a rss_ctx test case which removes contexts out of
> order. The flags are basically for that test. We run the .exec() to
> remove a context, and then we can check 
>
> 	if thing.queued:
> 		.. code for context that's alive ..
> 	else:
> 		.. code for dead context ..

That test already has its own flags to track which was removed, can't it
use those? My preference is always to keep an API as minimal as possible
and the flags, if any, would ideally be private. I don't think defer
objects should keep track of whether the user has already invoked them
or not, that's their user's business to know.

