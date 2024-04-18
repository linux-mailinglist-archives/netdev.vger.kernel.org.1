Return-Path: <netdev+bounces-89006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB568A9322
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4660B20F22
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3512B75;
	Thu, 18 Apr 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ljeARIcu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00931CF90
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422034; cv=fail; b=p530a09pyJDN7n3T58H3D/xxUlAzoWlj1F4/tCQwq37lB6wekw3uMQHwmpYZb3KbtcWV0lqs6DE+suAHUYUjoR4nFhkUtKVeCCvgN0/Vhc5eZBDYiQzfxRe0KuKkRbW6UhBMwje3H9xWyQrCykUW8V/O+oQVQCJH6qWz/fm7k0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422034; c=relaxed/simple;
	bh=zyCHyjuEd0MHDDuU+a4k3UO4mQlYhd7BkYFW9dI8Mpk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FFwZcDQem9eu42oSVuymuwG2qtSTvxDINvAE9OSLdnvFJLorGK9pjpKN5TTzl95stncJDB/tFUDWyUXPr3ndcRIXQCKcKEQ5RZt0O5IpnXg8RadKAsey34aqJqRoD6gzivY38kSyBni5wzc5guVLq2ZWuiKfo57urdt0lF8hdk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ljeARIcu; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7/zo85cyafSIZJT4C8e+Fybhn9S1DXS8dlWHlSSGLBJBT06aiO4/L9iGBpyFBvD9XPwcA1TGa6bSyspl4oaUX5Jmbx0C0GihbJ5cpblGtr/lm88h/GD4VQVulslLZiKMOl3mttbu0esezIYvBRJvCTX5BqfIkEJWpnV7kwVKSfvFszw6M4QBRflwjjcAp7792Gft/+NqNNpfiZObnlt+APDCHPQ2Ha2tx/6D8xMgffmy22SPxWwPXRC5kFSkdok+DKurvytcwsSrbeiYoZOja7xyTN5n8LoB5/TrC4FD0xAum689Nhnu2nAoVu+3BDsa87iWSm1wSYwBRu9cD4r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBzHGXd+pRyf6+nMHfJTjYIkDfLuXJQRjBkgbqTK7CM=;
 b=J1zsNBWs5HDOOhFUBbhcE+JjCQnLv2Q43r0LIycNYBnhiAjiajakoLRMpL9i3D1wuOvYbU4thdu264OAffLObulNmnMsCTnC5P+H8FT26R1NUbXT9rmPDs4uZfjFEbEbCopvZA8tBk184yaLp/OwNcfnpYj5hev3mFm6+4B8DYDs7813JuQDS5cYZsM7O7Z3E95eBwrNdNyuu1gG4j7AAX8+g0ZFPnRJbc0AI1Cfm/HIiwYtrG6KaiWBKr+H91Uqp5jxx0WatzG4pOvOhHYq1RV2asT8nuKXE8Y+JocxqdPOlZ2moSen1GqMrGr5Omq8re7JUdAlNooG4T4IO6IpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBzHGXd+pRyf6+nMHfJTjYIkDfLuXJQRjBkgbqTK7CM=;
 b=ljeARIcucoFUjuGNV1g9yyBX9WnLcqjlu8TsHB0A0x4NFe8he8RdJA/ytPMepvpYe+vR+0qkPwp5eKV7k6LqDJMG/tV/zguRbrbL248AhZEn2t926CUAFcPs/G6m3jd+rtwby5Wrc1mSrB+WkOs033d/Lnd5ChIoOUsD/2QEEuPZRX+1JSR9O9dZ+ngsHVS0C3m9XUfTuhUOjxEO/8ha1Vhy24bzpCZy3QwjqC5gOUTrb4XdvaNdZWtA9j3HiTGxgHzUbH+MBdd2aeXtpJ6iYaU2hDC8r3Pe3Bc3FnuC3f9gs1qPyekRSuYsoB7SVAp/7CoxCheqWZrv0t/vCoqbXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 06:33:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 06:33:49 +0000
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
 <171338943006.32225.7031146712000724574.git-patchwork-notify@kernel.org>
 <ig5425idiwrshunkl5mw3nkb7w6pewsy3e7tbsewio4qnnj2au@vqr4ivgh67iv>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, jacob.e.keller@intel.com, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, gal@nvidia.com,
 tariqt@nvidia.com, saeedm@nvidia.com, cjubran@nvidia.com,
 cratiu@nvidia.com, wintera@linux.ibm.com
Subject: Re: [PATCH ethtool-next v2 0/2] Userspace code for ethtool HW TS
 statistics
Date: Wed, 17 Apr 2024 23:32:45 -0700
In-reply-to: <ig5425idiwrshunkl5mw3nkb7w6pewsy3e7tbsewio4qnnj2au@vqr4ivgh67iv>
Message-ID: <87edb3w56g.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: a496d1ce-3f0b-4f3d-741e-08dc5f7181c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d3zzGIsSbNuzZ6ZxJj6nycX/piRdCC+497t3cczqfsV9HPq3qI8Ax5jt/CM+nvhoJg8zO1z2r0//SKu3m+1KaxtUDs3ZBMQg8bKEwl799LNP+L7Rna+DqSg2HJpoJGbnXyosbOCjNOVbTmD5LFU0YovYp8z78gJwUaCTMX0qf0L9Ty30gptBj52rnG7iAvpv0VkE1R82FfiHZeVEDUXU32pf2BsCjA6n9eWQLdc+Nq/WwTedhqLaX6CdHbr8iBy81AuZYfhlt+XyeShO0XSSt6uSFMOQ8MR/IZlLOW6slFILe/fxZBGhh6wDyfKTAV3p9aYfzh2sDm+J4ciH4kY+UEymuTPNnc/NnTjYSdUkkWEBysVtNOgMtqK5oq9YCq4fDYp31mhy8zIp+j2MSE7Lq81LPwmnchDvr+T25Z4+7OV9cv30CScpo+wBcnboCdR6QmTTcyvbdc/6RGc3jT81CZ6zjguVUw1PISMtbPdPELIC3DD8rKUTbKWRTnirNkICLTA21H9o7O+BnB2Tw4I9zd9sSAJM95M6+IdC20lcvxd6qpInGCAXGZUjQtdBE7mvqShbsyR5eV+sPZL5LSo5J0xTec2bSw5XfzAOj3HYMyWoG4r7ImDt6fE5u90Ljtds1FhfbQOIfNfuEOYeDJjNJsZrxzL+a3+FkfE951ZlLy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JB1uDAtWSFG0y7kYIp9fQZr6b1+Gh9/RMAU72eEt1X3umt3jOU+uYpxBYWrn?=
 =?us-ascii?Q?7zV7F60NsX+E6MonQjfJ11eMZvICXmlwK0s5P7YnoKMiBLwpGEg9yjC4Wy6X?=
 =?us-ascii?Q?IBntzfUnJuiRu4OoEYdD1cCY9QM+/j7kAIUW2+oGnEWsghg3Jar+hWKgtrS8?=
 =?us-ascii?Q?0zYihGxg7aSpNkbeAX0N5Ib3f3Ibs7zIaaOYE6gVomxduZUyg1Hd+hZZr1RP?=
 =?us-ascii?Q?3uPaI9SRvH0sbEDgzHZ7dwCtXApBbkQ+QIgQqyNbjbgvhutBIsyeZAJi3UHV?=
 =?us-ascii?Q?uV7LpV5QxJc2pjWvvpVsMNrQrM5/T6ox4YVClLzc5ebPSNZFHhgmanz5ZxPr?=
 =?us-ascii?Q?IgB8eHi1PlzHHdE+mzZ6zxQtRPQv8M2pNebtZxQ//dbo17EWcslEu/b4Mi7z?=
 =?us-ascii?Q?tWJ/+UjwZqrJFiUF4ts2+v/E/InubvcH9MQ5PuECeMuK/TzPQekrpeezrfOG?=
 =?us-ascii?Q?3n3ZqW4jPWAa+F50NR+F2Hg2mmZ/gQKZxevvIupr08WmAucWXQoRfVFfWJm7?=
 =?us-ascii?Q?kb8hSpaGcUka6jBsdi7Oz7t4hvjea6N+6/r3ATV1iOnO5Eg+nKPKuQLn708g?=
 =?us-ascii?Q?v5BwllF5xUCIHjaycwbKmutfrGlHCix6s4iqGOrpHPzzWdT+gG6xikIxDGeb?=
 =?us-ascii?Q?V3NMPnbYBN1Fab8acqDMNEnCBlqSJRLugGbp3bm/HV9saeDI3BJIDbytFwWj?=
 =?us-ascii?Q?4O7SV3EkBH3uMMO8sJZXRxHwlzLSWCHH96HOIh8FsAZpONbVppaibZ6CMTre?=
 =?us-ascii?Q?F3a+CJMLO9SJuja6vBTPJoQjl6PqihS/AjHszOM/qRHY5/48MHQ6tl49INuK?=
 =?us-ascii?Q?AO/ED/N774SJwKFDPZrStdk0WJ//x+zhqK7oVolu4viFa9aQ03dsxjmcD2dU?=
 =?us-ascii?Q?mft4Xp8gvH49/4Xos0yN7vWD2CPuMFnGa/l/F82+Vv4q2yRi6qPyg2+a1Mw7?=
 =?us-ascii?Q?Twi8e8WLtBFaI1Xf2sgKiUsZp6GhckZI8qOxoLCqBj3qaX0ob8YZuIqipl4z?=
 =?us-ascii?Q?n6z8h6fB4aeMC4Gp6H19pSW89mYCLQMZm9102/qJ77xgs0XER7ECyY++OaZc?=
 =?us-ascii?Q?BYDZq5KtXHVQ86ENf83FfhHjuVNiufWnp4KRrLdYDqGoxlRx10kY8tRsbd5t?=
 =?us-ascii?Q?baJ/mL9OiF/jREZevBzNcDTNGCvQ6/hqC3FK8z/8gPxq82I/EcRuP3xFn2ny?=
 =?us-ascii?Q?yGvr1Fa2Lfiym42t61R57t9DmDcepSZcEnKcTLzO/jEVLMbarFTInmXKKtGJ?=
 =?us-ascii?Q?ma/pIE9AdMhh521MxuafDbgTgP17l2oCcQfE5AVrXJ0S/tpwghJ57u3Fij6v?=
 =?us-ascii?Q?szk18p4JmOsBeGGudqMZ2/gPx7n92bwClSUFJZ3PsIGjwvnDSKeaX/PGP25i?=
 =?us-ascii?Q?4skI7/d7PNu917PQKmPBtlbL71vfzH9e4Ah/ihth00lGzs2jz1cBol2ptBqV?=
 =?us-ascii?Q?+vD2Vhc9uT7KLpoMh/Womz2TjbhzzcnDc4LbJjD9Moj5K575MieMWJCo/5RA?=
 =?us-ascii?Q?PXFmo5wMcGpYVoXXlHaJAA7jPBzDt1580mdTYXF/v/tq/Y2ujjCgRNG4mq8S?=
 =?us-ascii?Q?MtdFyzYhuSGG3YExOXpOaGnMmhS66LZOD3jkJfIoma5du8pTgzvM4NGP4if2?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a496d1ce-3f0b-4f3d-741e-08dc5f7181c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:33:49.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcG9Pw9gsB5Md0nGlbgAruECN1hHEXckkkTDpvcA+yX+n76MN1YE5IQlZNBQ0p6EVJqNQIeS1sloZ0Z9Y6bDwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

On Thu, 18 Apr, 2024 08:30:48 +0200 Michal Kubecek <mkubecek@suse.cz> wrote:
> [[PGP Signed Part:Undecided]]
> On Wed, Apr 17, 2024 at 09:30:30PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>> 
>> This series was applied to ethtool/ethtool.git (next)
>> by Michal Kubecek <mkubecek@suse.cz>:
>> 
>> On Wed, 17 Apr 2024 13:38:27 -0700 you wrote:
>> > Adds support for querying statistics related to tsinfo if the kernel supports
>> > such statistics.
>> > 
>> > Changes:
>> >   v1->v2:
>> >     - Updated UAPI header copy to be based on a valid commit in the
>> >       net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
>> >       the catch.
>> >     - Refactored logic based on a suggestion from Jakub Kicinski
>> >       <kuba@kernel.org>.
>> > 
>> > [...]
>> 
>> Here is the summary with links:
>>   - [ethtool-next,v2,1/2] update UAPI header copies
>>     https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=d324940988f3
>>   - [ethtool-next,v2,2/2] netlink: tsinfo: add statistics support
>>     (no matching commit)
>
> Looks like the patchwork bot got a bit confused here. I accidentally
> updated the UAPI header copies to the same mainline commit yesterday
> which was probably identified as accepting the first patch. But the
> second (i.e. the important one) is still in the queue.

I saw this but was not sure it was intentional. Good to know it was
pw-bot hiccup.

--
Thanks,

Rahul Rameshbabu

