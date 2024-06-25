Return-Path: <netdev+bounces-106576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7E916DFA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09A01F219F8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4F171E41;
	Tue, 25 Jun 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trblf29N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAD49629
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332657; cv=fail; b=mkwNqtXQ3A/2UoHbr8DjIHg3PSo0lc8UlILAMTRNbv3AndXQC4POd/iItHqYPkDnzaujZwg/VzcMDhr1H8bUQTHGrsaXHvViVl6V2lvbVcDwa9jJtYAavU6ltlpZjMpSn9odAcyQ18MGsgNX07SzF8spRJZ92pGiABqvUuz//Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332657; c=relaxed/simple;
	bh=NBb2vCiSWGfRx7X3WdidnU9/w4lBu25R/cvkIQAKhlI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LOHHkyEEG1PFsAg6HxN5JmJWN4PyeRlUVEbCKlOPTNFtvT94t2WNqewLtuDYdcy73qV9hWIJfaALbe9XOxpsU8KS0nTfsGiFeS9MCh0QehnKg7btQwb2oS2TOuLXuySBV9m3qMtvK1QNRI0l8s4GleeRXcG3oC4A/rGIcyvsqyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trblf29N; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu4vvlSwbjUtnuNtXx1EpweXkqXGY3hB0quADq1yW0HHatSuI6avZbWWFyfqqqz8oAV2+Q5DPziZ6Knmxq4Lvr4Xxhy2bl5Biw5GGHDjWQUdEK2w8AUuFrUWAwxXjD1KYcpZo+QUWKs+98NQq/nDoJABUz3XRZXLgnyH7PRWfpLKYVEl+WMlYu+1b+nneLqTBFuCfhvMfzcxJanyRC7MzTpw7BcmvuhoKwPWv3ZMwQhe796gBcXGaNJ1XHUKZyPVNHpq+cei8aixEATPdYPnhcViq42YbKW9XlvaWBZs+818MGGNejwxovKY4CqWDFUyTH/XyMtkMhIXhIKkkGy7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QnJ6rUJgqyEJWVsLtjPyi1AF6iX1N9sgOD35NXBesw=;
 b=SA3NodcwK+uW78vWWXVWylfgribbZoLKIZqGVrslxoek9s2bFaAypG0WEHFv4gO6ipdFtwIWTfmYdmXibQRqlV8sJvarXrfvytiYI6DuXTV3+DFOKFJ0BhYShhSCSeYHlGYkzbxFKRiR3uMDSiGDxzO9NiEEzudf43Jb6tTibUl5fUPyLR86t2SDLRbDlwwMLqI5kJ6+rE92fgalBAVKa/kRt1HPaAbewDw8TRivgUGxju9eMJ2kHeTApZabKj6onT11nhl65lDW0p/YqI6sgOwCsfNMWdjuEAFUDScksjpAf4OPVIBPW79sr7AE7sL2S58p3SmJpNvN7kLCt80R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QnJ6rUJgqyEJWVsLtjPyi1AF6iX1N9sgOD35NXBesw=;
 b=trblf29NkAyF/ASYnUHs6a7ulf3n3rvwOFlXyKSt1M5svk8W5PeHRBVQkgsLVEwySbfnjfM1NfG6hwlBvYz5NNBR7v9eHZD/krrGQxVr+QYbN5YODu+YVxZxPZ7sMCT6I2b5SrWx76z0J/0REpr90avbsTraaZ89rRyPpXdjoRK8TaRbqgvjHl5pOqvWzsjxiPZ5QHg16QQirFA6oRSkF8ZVoLFM/m1+XEZhFXAcIR8QzHS9OfRwnL2ODb20zxaCkGQr6feMIojLzwoWQBFfIhEoDkTXRHAbekAKpNLiZq5Xg/wcx8n+VoLCg5n4+9Ju7YmrLbQffJlwzES1u6IdRw==
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 16:24:12 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::6c) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 16:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 16:24:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 09:23:53 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 09:23:48 -0700
References: <20240625010210.2002310-1-kuba@kernel.org>
 <20240625010210.2002310-5-kuba@kernel.org> <877cedb2ki.fsf@nvidia.com>
 <20240625065041.1c4cb856@kernel.org>
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
Date: Tue, 25 Jun 2024 16:43:55 +0200
In-Reply-To: <20240625065041.1c4cb856@kernel.org>
Message-ID: <8734p1at4e.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: fe06130d-2f6b-4706-e147-08dc95333f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?prm0VaMgNSaoFeprlRxBwXQgppDhr+plD0V/gYgll+1TXdLvsVbqibRYMVbu?=
 =?us-ascii?Q?Z1yXjoBhUapatrQDUc3ynUM9SOdG/9Vux0n6MqOoQ88kW3LtO9ITmRGwAho4?=
 =?us-ascii?Q?EAwltmmBjDYuFr2tJ/FdZbRTY914rmvQKyAWik2L+pe/IfR4OCOrM5d9oAq0?=
 =?us-ascii?Q?3ck3qUtFM/BLXy7N/fnalZDNPDNvbFNMy9Z6A/fSraEobgzilso/9+0cOHlg?=
 =?us-ascii?Q?kfmUK87GvuQJGzBIAgVfPv3cTEsSIcAnfh5qS7+NcYE1uh3rkd2XFPqgz2Em?=
 =?us-ascii?Q?lGKpmJMX+vN9dTx78xIGX5y6YjWwWmtFXvdvFESdMklU4Buk3xzGIsHz0kRp?=
 =?us-ascii?Q?5i9epUGaEUC2WCJSL3aSLrLuCYTXLUudB/UAFdwIPZSiENjpEsTF6Rh4D68l?=
 =?us-ascii?Q?qTy6HnVTjJOI2aAA0pUQd4/8krIYMvfnCNsDIRG7Ne662S5ZfD11E7gQ1hAV?=
 =?us-ascii?Q?8LGdl2aajgDn3ESCci1Q5ct3hAk1eCjzVmYUcA2bTA2V55Y7bre2tXuixe93?=
 =?us-ascii?Q?Lj/hyB0yA6LTgppRq3mnbVU96o/8UcaoBhbnRC3og5VYq8+CyUFw/MlF50gw?=
 =?us-ascii?Q?+7A4hhQok5LWr42+RzyobepuJzLfqf4DxsJUuty17yxBJ640OxJfNGX4FhFm?=
 =?us-ascii?Q?YfvPQP0n7bxbh3lw4vmtHNJjr5C8cCxgykZ8lxMScT52/Y4anV4qKCdKRots?=
 =?us-ascii?Q?YX/e8LtNV89rXcW99aqXPGvyU63hV+5PI2u5xjzb9SAnX9GhGRa2RHs25Cbt?=
 =?us-ascii?Q?EjKzVDHtkOzE0HoJxQ0nShysjCr3KzsEZMGZPpxz3HVodgiFmBQQLmzNL5mx?=
 =?us-ascii?Q?Bl9nL9i3cMz2tJu5AhDnq1qTc3EaRH537LCZALN5A1DQZHY650wCqLUY1Tox?=
 =?us-ascii?Q?Esre/kBk8XZ+865geaSpSc8DmUTe9I9PhDPqzBbewWnBXwYsJz1vSxqqZ1DP?=
 =?us-ascii?Q?tzT/PDGd7/DbkXwVuetUtKRATZF7ykZ3w3BY69oOOatH0JfaQu2SyNDxSFNW?=
 =?us-ascii?Q?DVQ2xxHtNu1M2YCvAI27SuoOJQ1jcsqvDYyDyk85cb4WeY7QSv0KGCQHxX5A?=
 =?us-ascii?Q?AJH4Ax1EqDhx+clJLVtNFQPgB9+y85D7Ztz4m/tifSTidv4B1rjdKjMmHxXT?=
 =?us-ascii?Q?1PJF0aycoKSQJsK1Zps6LiKUc5AeVsQSuxKSe+4vzc7KjXTqKhbWgOZvAjIp?=
 =?us-ascii?Q?BWj9VbOUcHK4IelT5GfaIclal0utjSNZ0cSb3BjgegQnOZcfCEGgiDSvVMS3?=
 =?us-ascii?Q?dIElVXtvwP8PhBmuuR0hBgfdHp3xcEZGaUXBjK6JQPkjEWFQjA6NbIhc+he0?=
 =?us-ascii?Q?0DHwMPE/hiC9z3i9V5qkvRWU3hRuRcsakifXa3YWNglRi5bDVAQqcYaUPYyG?=
 =?us-ascii?Q?bLTde5zxvb3chPWOXYMJBOA2NHNE7m/6+pMaqPF/YS/afjKRww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:24:12.0394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe06130d-2f6b-4706-e147-08dc95333f95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 12:42:22 +0200 Petr Machata wrote:
>> > +def test_rss_key_indir(cfg):
>> > +    """
>> > +    Test basics like updating the main RSS key and indirection table.
>> > +    """
>> > +    if len(_get_rx_cnts(cfg)) < 2:
>> > +        KsftSkipEx("Device has only one queue (or doesn't support queue stats)")  
>> 
>> I'm not sure, is this admin-correctible configuration issue? It looks
>> like this and some others should rather be XFAIL.
>
> TBH I don't have a good compass on what should be XFAIL and what should
> be SKIP in HW tests. Once vendors start running these we'll get more
> experience (there's only one test using Xfail in HW now).

Sure, me neither.

>> > +    # Try to allocate more queues when necessary
>> > +    qcnt = len(_get_rx_cnts(cfg))
>> > +    if qcnt >= 2 + 2 * ctx_cnt:
>> > +        qcnt = None
>> > +    else:
>> > +        try:
>> > +            ksft_pr(f"Increasing queue count {qcnt} -> {2 + 2 * ctx_cnt}")
>> > +            ethtool(f"-L {cfg.ifname} combined {2 + 2 * ctx_cnt}")
>> > +        except:
>> > +            raise KsftSkipEx("Not enough queues for the test")  
>> 
>> There are variations on this in each of the three tests. It would make
>> sense to extract to a helper, or perhaps even write as a context
>> manager. Untested:
>> 
>> class require_contexts:
>>     def __init__(self, cfg, count):
>>         self._cfg = cfg
>>         self._count = count
>>         self._qcnt = None
>> 
>>     def __enter__(self):
>>         qcnt = len(_get_rx_cnts(self._cfg))
>>         if qcnt >= self._count:
>>             return
>>         try:
>>             ksft_pr(f"Increasing queue count {qcnt} -> {self._count}")
>>             ethtool(f"-L {self._cfg.ifname} combined {self._count}")
>>             self._qcnt = qcnt
>>         except:
>>             raise KsftSkipEx("Not enough queues for the test")
>> 
>>     def __exit__(self, exc_type, exc_value, traceback):
>>         if self._qcnt is not None:
>>             ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
>> 
>> Then:
>> 
>>     with require_contexts(cfg, 2 + 2 * ctx_cnt):
>>         ...
>
> There are 4 things to clean up, with doesn't cover all of them
> naturally and complicates the code.

Yeah, you can't use it everywhere, but you can use it for the ethtool
config here.

Re complexity, how about this?

import contextlib

@contextlib.contextmanager
def require_contexts(cfg, count):
    qcnt = len(_get_rx_cnts(cfg))
    if qcnt >= count:
        qcnt = None
    else:
        try:
            ksft_pr(f"Increasing queue count {qcnt} -> {count}")
            ethtool(f"-L {cfg.ifname} combined {count}")
        except:
            raise KsftSkipEx("Not enough queues for the test")

    try:
        yield
    finally:
        if qcnt is not None:
            ethtool(f"-L {cfg.ifname} combined {qcnt}")

This is mostly just business logic, hardly any boilerplate, and still
just uses standard Python. You get the setup and cleanup next to each
other, which is important for cross-comparing the two.

Anyway, if I don't persuade you for The Right Path, something like this
would at least get rid of the duplication:

    qcnt = contexts_setup(cfg, 2 + 2 * ctx_cnt)
    try:
        ...
    finally:
        if qcnt:
            contexts_teardown(cfg, qcnt)

> Once again, I'm thinking about adding some form of deferred execution.
> 	
> 	ethtool(f"-L {self._cfg.ifname} combined {self._qcnt}")
> 	undo(ethtool, f"-L {self._cfg.ifname} combined {old_qcnt}")
>
> Where cleanups will be executed in reverse order by ksft_run() after
> the test, with the option to delete them.
>
> 	nid = ethtool_create(cfg, "-N", flow)
> 	ntuple = undo(ethtool, f"-N {cfg.ifname} delete {nid}")
> 	# .. code using ntuple ...
> 	ntuple.exec()
> 	# .. now ntuple is gone
>
> or/and:
>
> 	nid = ethtool_create(cfg, "-N", flow)
> 	with undo(ethtool, f"-N {cfg.ifname} delete {nid}"):
> 		# .. code using ntuple ...
> 	# .. now ntuple is gone
>
> Thoughts?

Sure, this can be done, but you are introducing a new mechanism to solve
something that the language has had support for for 15 years or so.

Like, it's not terrible. I like it better than the try/finally aprroach,
because at least the setup and cleanup are localized.

Call it defer though? It doesn't "undo" there and then, but at some
later point.

