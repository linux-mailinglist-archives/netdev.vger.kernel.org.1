Return-Path: <netdev+bounces-68017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0108459C0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8292A282466
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D325D479;
	Thu,  1 Feb 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="PEN8dAeq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E45337E
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796913; cv=fail; b=cMgwWrcODaN6884zwbYZhyOTQCbhUWBwe/7wWsLsDwMqvMWZe3DouaJiwDF3viTbl/2vo73ZiRQTNBe1ml8rVH1YL4IIlWmtZJWlxH6Ny87XJWmqxZhsMrS2f9pOSa2WCAJQ4PCRXW21o5KHHJttN+GAe/oV4qZ66yta9Bh6H7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796913; c=relaxed/simple;
	bh=S+PjUztL3TPavkwP4djZtCrwjxNq/0Ti8MYkJcH5O8A=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=FvajNJ4iS3ujZ/jmkwvwEti/nNjrcVdXz+lT1ebeLTG0RAQNrui1b4eOATqP3NddVuunc2hvVXj0zFupelXEXUlSpXgtEtuWa//phGnynyQjT2I4P6A/dCOrVTWVPL0IINggaNzDz0LO//UyjQ1AfvVVYhY3wgL0iWBmBCHCUsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=PEN8dAeq; arc=fail smtp.client-ip=40.107.244.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb+Jit08idmnRYdL83Wlkc95r+wrDysBX5LPvVVygulivoWqyPRucAcqsUiSBQvthDxcqOiSCcCOIQSr+8Q1jwEXW2dncecQgyKjh3Oj8Tuko7N1qEpjQtOaPoQ2QzcJPu+MWTKK2V4KIfQNjwkUvMTIf+sjrhynx/SUj7PxOh3vCGomG27V4nvK8P0dKpMSNpinj9FpBH/jfqvMZXeQYs8ozHQCZfqOzLE7LX+e1A1idoHZ1br62i4H6ErvkubGujf88TbROUjfDnaYyGgp6uIKq4OZbY2ioR/UGmyp+tF94GJ9Y8SNcvwDGuqN4v4Insed2aETQQi4a2Z805Sd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkM+pf+TIm2/yPZ8RbCy8ducVsRa/kA8P26FtSKZUko=;
 b=SRDedj9e/X9ug4GRtrfFom/Xn8Bb6r/5rjBTEnVd7BW/mQ5xD59fsdxXlByYexRrJFOuVE1cnsOtbqsN8eDabGAxUED7eQrjG+/f9YIxqz2gWw3MMXgdEJ0gjnUBdg9LRLnHVY72tYKun7ocA6mReWSWCJoZt/0H0e/DO/4Hu+Jpp7atYn/1BQ+G7koCX+Hiwx5yvjMQUOScax27Wwnuu/vffYLy/7Lkn7/1DFNW25grWxjA5ZuWN45V6PRIGPskm97IvyEUxz/YNwJxFPr+62ZsS69z4VJ+mEN4CksKGlOyVkgc+8lgQFhUVQSUWY8Xk7fU1sPVlb8Ohunt6kOaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkM+pf+TIm2/yPZ8RbCy8ducVsRa/kA8P26FtSKZUko=;
 b=PEN8dAeqKEjhJsAJo1hqUe/ABQfeYUvPbYHHtEoTj6Ygqsi69qxV51gfIYPokWVg5SgBGAalzYSuyo7INbev3N4gaS93l9uJAN21oyEvJf1rdJ6HJ52api7/PG/yliI0XadPs1Q9U9CcokV5lSxNovsZPOq0OY/RIrDnf/KFqJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by DS0PR14MB7206.namprd14.prod.outlook.com (2603:10b6:8:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 14:15:07 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::5b72:645d:73ee:123d]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::5b72:645d:73ee:123d%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 14:15:06 +0000
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-5-chopps@chopps.org> <ZVvmVM3E7dtRK_Ei@hog>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 4/8] iptfs: sysctl: allow configuration of
 global default values
Date: Thu, 01 Feb 2024 08:57:25 -0500
In-reply-to: <ZVvmVM3E7dtRK_Ei@hog>
Message-ID: <m2h6is6zko.fsf@ja.int.chopps.org>
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: CH0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:610:11a::28) To CH2PR14MB4152.namprd14.prod.outlook.com
 (2603:10b6:610:a9::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR14MB4152:EE_|DS0PR14MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 6691e81c-f5ab-4553-e854-08dc233030c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k8NVEswDpqv7FhYZUWsvZsWCBVSebrVWsLr0RgWyRO91SnO8l5fnH/jQikyJe+UM8es6Umca5iKWcn06KnS1o6pgnFQUd5WigT4sPqPDbX4mvfVGFoKM2N0PIDzCut+YqYkfj0/tkpBDZjna3TYeIk0Mgfa13K83oBAPuKQ4YDq2c6XVHcxqt4geOWPi4x0ylUDeLzRmS8WvkZ6J2CRLbnvknl6HoaDy3N3rXRBbmvK8/tDt2lvuPBY2EASzCDhznjaLmN2/MACKUCYrNWR5/kLzeiJbeiIiUFnGV++iJhzB4ePMB0lp0swMOttovBMDY+kbbbedUL5lU3mrGv6URd5dEVoe19pwhK9I4QBLCtxok1/EW75Z6S7nOIrQdKxYXZNeIyK5BcFalJcnEtvNNL7KuNZx1V71d/QLI1qRtO/dWQQPKzAhWThxYn+wCQNtoIiHy9jdtMPqgOu/vwWmjooX0qu5G8bDaE1s3RzmjFWUXOKU3WnWLWChdAdvAnvuOhtyLN/Hm1eJ/ai9bVVb1L9+l329vsfS6oE2GbnCvZ2y2zwzZ8Io89yt2ysl0ZQ6f1Y1ZG0QZvu/s3Iq31ryMbv/QKIxcTKaV75vNqkHjpHHPRpHCqAkzmAkZEtCDYZJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(66946007)(66476007)(6916009)(2906002)(54906003)(8676002)(41300700001)(6506007)(8936002)(6486002)(4326008)(66556008)(38350700005)(86362001)(5660300002)(38100700002)(4001150100001)(83380400001)(26005)(52116002)(107886003)(9686003)(6512007)(21480400003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LEXJRkCgxnB21OEtAa7ySq9cODsl5YrZ8vrbQvUTtFG2u681uZvfyacUqHwv?=
 =?us-ascii?Q?EqgGMe7D6O2jATm1i155l8psoe2HJMjhKvWkMBwjRevZ0O7QOLFiFbVgyLT5?=
 =?us-ascii?Q?HhCtNgUlrQ2n2Fr4EuGpEW58O4+gteYOLlLdY84AQrnjict+7mspDy5IltxP?=
 =?us-ascii?Q?dHnCAtk462H03io62nUNf8ZxRM/iDx0niR1I4lCqIbC//JXuAR7AplfjjsC/?=
 =?us-ascii?Q?H5y/3CCzFiTsM3DWIuFf2h4p/3AFifbruBjP0sfxzEzOHgCRxZpsMPRiO81M?=
 =?us-ascii?Q?3wkJdKbl1U0xF8rxh4tsVv9IcL2gw9jRA4n59SKt3SdyEn1M0rWCGLr8sTY9?=
 =?us-ascii?Q?B4hGH7snIZzGBp0VI4dVY/fapU6Wu+SIJd3hDaNKQBB483QrVNHe4Yc9r5JX?=
 =?us-ascii?Q?Orfa9dZTTXXT74Lz0DE29iCTo4QHa8uZOsY10aeFSW8U2G5OJigZZ310ZIkd?=
 =?us-ascii?Q?mjx1iQPu3hXO92D8QGFt58K7oU4eGp4G3Bqs61YwZPy6DGwltWIPzl8OfNo1?=
 =?us-ascii?Q?mFgajQfvLwHiY9UVmzRjFg+p6u5Rhd0elawF1PGc7n20DVez9U6Y5YQ8M/C6?=
 =?us-ascii?Q?ID0846P2Hpt8/8gMkVuFPgbqcm3fS9XiPWlzLyywIJ0SuUEX2XTuckUlJ27Y?=
 =?us-ascii?Q?mVSnLvI4EalUgtkniLYgLgDUlLjwSMru/X7NaICoyL3uVe9THWpB71m6mU55?=
 =?us-ascii?Q?oypst53ySJJRpy/5OrDH0qY+yv/AxUK3R3JHMBRpb0mEsK50DnktpKcZKSS8?=
 =?us-ascii?Q?wjxTr860Xqudh6gly7m8B6i1iYANMKqLYOzbmU9zghHu/r7gZLBdP82oWipN?=
 =?us-ascii?Q?bertixP/ew7DmXdWeIDLXeuIaRe7MsJ76CC1xECOPggwSzLpY9IPIyJmFbjI?=
 =?us-ascii?Q?yk4p0OIbvcv/hvzHeidikVlOge588JkEOIbgFJhT13I7O8sdDk/0XsLp+Bhm?=
 =?us-ascii?Q?ZnVidfqnjIdtLYxTZO87e0NcwKuGrlOR0F5rqW8zH+L0PkBamiHcQ4nAa9NV?=
 =?us-ascii?Q?sVNKGe/rkMLN8TBy/yTDQmTU24X69nvzeCkAM0PjsTwOBceKiF6XsBXwgLyP?=
 =?us-ascii?Q?bqteoMKfrGd35wzJiHz5BKGN+4XaZSZ4dV0IH4dFw4TMrYYG6er6OKjfHR8/?=
 =?us-ascii?Q?/yroF/NoECKRju4UWuciku7VsSveMFPHNXqEqSSnNL1i1jNxsW+nv+FyFjmX?=
 =?us-ascii?Q?2h41g/3kOSbQxf1jY5Bfp3qgjhrd5RuLDoFiSyR7BQob4NkjooCRkjib//9I?=
 =?us-ascii?Q?z9gojEmQd1aR0Zb80Y3ELdVlGEzr3dqjbX85ebqlhziLmFsy2AKuagTy9Gbr?=
 =?us-ascii?Q?mlz42pjzGKUlNhvd9PlvsmojZ7PpibJNybdFRa0BPO5tfMwfokDGlaNcCPj2?=
 =?us-ascii?Q?o0W09LpFxy7tHRNi5mK8GEzmz9vgxBec8Z24ZSYiQjuasDhTK4MjetnDR/9n?=
 =?us-ascii?Q?VC97JLR3c1P8qTMhxzyY9Lo72Soxqzn8QlF7wgZsoG+9jf6FJBaOZp2r3Wut?=
 =?us-ascii?Q?LGIKPixvP47cymDp9811RKsaD6wVi0oqPt52n6KrDjZVFpkRHjefdyONsBGu?=
 =?us-ascii?Q?myiErEinN/GqD1COAGOu0EcNhQuX5xHaT3Z4peAp?=
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6691e81c-f5ab-4553-e854-08dc233030c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:15:06.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q7XHVNt3TSz61nht61mAgovivVUCmedTT9wllQH+hci3XvCtLth/k9bpmfmq5XUCOO2GYKpnu37AxCyZv8oBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB7206

--=-=-=
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> 2023-11-12, 22:52:15 -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add sysctls for the changing the IPTFS default SA values.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  Documentation/networking/xfrm_sysctl.rst | 29 ++++++++++++++++++
>>  include/net/netns/xfrm.h                 |  6 ++++
>>  include/net/xfrm.h                       |  7 +++++
>>  net/xfrm/xfrm_sysctl.c                   | 38 ++++++++++++++++++++++++
>>  4 files changed, 80 insertions(+)
>>
>> diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
>> index 47b9bbdd0179..9e628806c110 100644
>> --- a/Documentation/networking/xfrm_sysctl.rst
>> +++ b/Documentation/networking/xfrm_sysctl.rst
>> @@ -9,3 +9,32 @@ XFRM Syscall
>>
>>  xfrm_acq_expires - INTEGER
>>  	default 30 - hard timeout in seconds for acquire requests
>> +
>> +xfrm_iptfs_maxqsize - UNSIGNED INTEGER
>> +        The default IPTFS max output queue size in octets. The output queue is
>> +        where received packets destined for output over an IPTFS tunnel are
>> +        stored prior to being output in aggregated/fragmented form over the
>> +        IPTFS tunnel.
>> +
>> +        Default 1M.
>> +
>> +xfrm_iptfs_drptime - UNSIGNED INTEGER
>
> nit: Can we make those names a bit more human-readable?
> xfrm_iptfs_droptime, or possibly xfrm_iptfs_drop_time for better
> consistency with the netlink API.

Changed to xfrm_iptfs_drop_time.

>> +        The default IPTFS drop time in microseconds. The drop time is the amount
>> +        of time before a missing out-of-order IPTFS tunnel packet is considered
>> +        lost. See also the reorder window.
>> +
>> +        Default 1s (1000000).
>> +
>> +xfrm_iptfs_idelay - UNSIGNED INTEGER
>
> I would suggest xfrm_iptfs_initial_delay (or at least init_delay like
> the netlink attribute).

Changed to xfrm_iptfs_init_delay.

>
>> +        The default IPTFS initial output delay in microseconds. The initial
>> +        output delay is the amount of time prior to servicing the output queue
>> +        after queueing the first packet on said queue.
>
> Does that also apply if the queue was fully drained (no traffic for a
> while) and starts being used again? That might be worth documenting
> either way (sorry, I haven't processed the main patch far enough to
> answer this question myself yet).

Added: "This applies anytime the output queue was previously empty."

> And it might be worth mentioning that all these sysctls can be
> overridden per SA via the netlink API.

The description of these values as the "default"s implies the fact that they can be changed, I think.

>> +        Default 0.
>> +
>> +xfrm_iptfs_rewin - UNSIGNED INTEGER
>
> xfrm_iptfs_reorderwin (or reorder_win, or reorder_window)?
> I'd also make the equivalent netlink attribute's name a bit longer (at
> least spell out REORDER, I can live with WIN for WINDOW).
>

Changed to xfrm_iptfs_reorder_window.

Also renamed the netlink attribute REORD_WIN to match (i.e., not XFRMA_IPTFS_REORDER_WINDOW).

> [...]
>> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
>> index c9bb0f892f55..d2e87344d175 100644
>> --- a/include/net/xfrm.h
>> +++ b/include/net/xfrm.h
>> @@ -2190,4 +2190,11 @@ static inline int register_xfrm_interface_bpf(void)
>>
>>  #endif
>>
>> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
>> +#define XFRM_IPTFS_DEFAULT_MAX_QUEUE_SIZE (1024 * 1024)
>> +#define XFRM_IPTFS_DEFAULT_INIT_DELAY_USECS (0)
>> +#define XFRM_IPTFS_DEFAULT_DROP_TIME_USECS (1000000)
>> +#define XFRM_IPTFS_DEFAULT_REORDER_WINDOW (3)
>> +#endif
>
> nit: move those to net/xfrm/xfrm_sysctl.c ? they're only used in that file.

Rather than move them directly above where they are only used I just removed them entirely.

Thanks,
Chris.

>> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
>> index 7fdeafc838a7..bf8e73a6c38e 100644
>> --- a/net/xfrm/xfrm_sysctl.c
>> +++ b/net/xfrm/xfrm_sysctl.c
> [...]
>> @@ -55,6 +87,12 @@ int __net_init xfrm_sysctl_init(struct net *net)
>>  	table[1].data = &net->xfrm.sysctl_aevent_rseqth;
>>  	table[2].data = &net->xfrm.sysctl_larval_drop;
>>  	table[3].data = &net->xfrm.sysctl_acq_expires;
>> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
>> +	table[4].data = &net->xfrm.sysctl_iptfs_drptime;
>> +	table[5].data = &net->xfrm.sysctl_iptfs_idelay;
>> +	table[6].data = &net->xfrm.sysctl_iptfs_maxqsize;
>> +	table[7].data = &net->xfrm.sysctl_iptfs_rewin;
>> +#endif
>
> Is it time to switch to a loop like in ipv6_sysctl_net_init? See
> commit d2f7e56d1e40 ("ipv6: Use math to point per net sysctls into the
> appropriate struct net"). OTOH we don't add sysctls for xfrm very
> often so it's not critical.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmW7p2cQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJUdnEACNXoL8pzGpIvTzatqxz7OrL34Ares5hzT8
+WEcLkA1Kz1fE1Da6ubPK0rOJndXrk463GIajbma0PBvoNU95oAs1eIF00vsqvw8
2ll5521ThIRpwFvVY3yZWdoGhwsUXt2DP8mSZ4iD8Y1L+qNqsAqwMvCVJgvZS56j
mZjPa0jG8vTlVBhdzdNGH9jPq/toljldcVffHeuNVIzPvRUy2LqmHrcsi1I3RXXD
HM+YDQrcR44TaqriMrJnK7G3W0XwtfGG3FOxS8G68tRlgT8gFL+AtGEzcD24em+e
9rrTJoSPjKIHREFTrHxGheSVltZLYtg1nosnFaAK1iveQT3q20RsAJTkSTG/wqM7
gVMcBiB/QET66IAU/Lp/dQl/hf//ESM4TzRZI+a/jiZNo85J5H3fxqZqCIl2AvRZ
bS+0vK2zAJMgIxC0PPkPIMHMInLesU7dbfcbqU7Eb9Ks6+8sK64p1+0nZQCU9C1o
7P1y1IUFc4vJsVXabyecalcXr+yjQGyy3aOCNTsrYhNbE8R+azoFsjQtLykorz0z
ZUDim0v28ODr95Tz/Wb75oDntxm5WJxpMpfxbhr3++RjqqxAbYinboJMUmpPDeuL
D1bhszKIQ8twrizOntt3bPRqm8q2WINNVwj9e+OuJa8VGBOmB06kNchLJnTijEEi
4xs5QShHMw==
=Eed4
-----END PGP SIGNATURE-----

--=-=-=--

