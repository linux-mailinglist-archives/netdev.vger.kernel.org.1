Return-Path: <netdev+bounces-85389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343D89A927
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB522282D0C
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 05:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72861DA5F;
	Sat,  6 Apr 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T++cZ9Sh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2130.outbound.protection.outlook.com [40.107.101.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943E19479
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 05:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712381307; cv=fail; b=HEk8fFKc6yQ0o/imnfAPr7gC/6sK7nT9WsVTN/UnLalwtnDZ5NSKopxGk/PcIl+4O39zajAFBaXHds6kAHXe4qM8lXJR0rNSd7K4MkiVPizYVVgsSjGCOZY6By7TNDEKxUMGDeAI9GLv63ZVjoiFgg6leYV5eRPcBOEEAhpCXuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712381307; c=relaxed/simple;
	bh=gC4rGEf5aNrTruZvKONyUeRKdY8qrpkEFtLXnD43bOs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=p/SCB+DvmFeo1ZbyyR9j2yLf8w66q+tGw0c/UgoTzJLkomrGAthYALYJM+AvYmCMO7ffInvSQAp06Dulwgt2waZbEYQT0phTBpmWp51/5gVRSrXs8pVAW1C8w7GVEptCt0epw7OqzAfU50NTBcKkAHBOEZXu7yPvPsG1UPqCqb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T++cZ9Sh; arc=fail smtp.client-ip=40.107.101.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEyBChu9gIpZAxvWj4ZrCS7A2AkMsgdieMQBHkA3oN4p1jhxF+wX12/HVyvLbH5t18P6L784DK9dmJwKUdgMZufkCAarJhKGk59CYuWGMh+qjSoRfZq5qRHkN3S2KCEycLUNpsbP3YDkttGuVYZh4wA63npogxT+hUvZsDlxR56cELXhIKWS0SWUGTzeLTKHlg3m8eQOPiVUaSkrN1QcQ/C3cawtt90KZMGZnamgxEItHNXbZ4mhS+mDMioXHlJLoDeVb6Di5Lz5hckLCqPWL4IxM+oG/7KDQ6LfUYO7MJg1BZrd0DORFzsVUQ02LmeBXv3qfHrrel3b7STfZnfHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWTbJm/3Uykoma/ZuQ8XL5Yettyi6On4yRI0ymtVwT0=;
 b=jB+jR81K4C9O5WL/XmAfYn1uoh8eXHWsQKZZhUpIMVyv9WFGevuxH7exqa/Qs3Q5YcnPy+1D/Ta8vsK6OD0ZXOB64Rl7S8Dyf3yhRIWnhzzjzy+NZoLOD0K+rxDdhbu5zsn+VqarHEsNjApn6xKoGP5YZ5yc0TLotFKnAeO3C/++F8Po7yEu9ydnWhGs8UpI3ZJ1zeIlxX8RuejkSa57IS4F1/EjEH9vImXwMB/SQqngjjGJZ9ZnOi6y01Rlu+h99ou45sQ+Dv3a1hhuVkpbRvdd2M0K/auXDYaS5iHjCoDKL9gkxL6jsJ6xb75XlF81S/vdo5487d/b+0piWvJWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWTbJm/3Uykoma/ZuQ8XL5Yettyi6On4yRI0ymtVwT0=;
 b=T++cZ9ShwaZtwO0/PdidwdYsXAChuTsAHpG1PNhBSNvkGHStAHMaxJYS33E5RcV3oncBlRhH9wb6/iAM+y9dsdeEnixsQIQ8+c6T7e7x6LAatGUXmXJwaoLO65aL6zsUct+0a2iO0FjsJaWLWO2dJ6sgA5Zza0g0Xy1XUF5OjzjfgkT9UEdx0oMpUsE6i1Rc2IzCj1WYCYu9biHHWC37FZK8naj2R0DCVUxuXggk1GTUCT0XKC6dl7xo4qXPFPl1T9HZ9748WtebldIkmpCy8TNv1JqllSCFpkajtJzRxrtdAQrNuvC57xjzBP7dBJJNr3Ygvud8fYvRKSVBWDC8uw==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 05:28:22 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 05:28:22 +0000
References: <20240404173357.123307-1-tariqt@nvidia.com>
 <20240404173357.123307-4-tariqt@nvidia.com>
 <20240405215335.7a5601ca@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 3/5] ethtool: add interface to read representor
 Rx statistics
Date: Fri, 05 Apr 2024 22:25:21 -0700
In-reply-to: <20240405215335.7a5601ca@kernel.org>
Message-ID: <87ttkf2h71.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN2PR12MB4272:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5qef7b6hSe14kfRvXWsYLhXzUe5OtQmzGlz0xmmsEyoIgzWW8shhtNjiZWVeS5pE7X/TCU6tUBLg+diP6edLeJAaKbGpsjQopdD8Bb5zIAc+3rsQ3dcXP0fVMsKI6kJz75nPO1eFtCVV3j0YQSxMdDlHphtWmGOa2MFpRsM6hmYHMY5ZmBhgCOaECtsM7Pypl2gVbOa/M1Bnok6T2XT4fOgOjRfQmK9s4fvnsNS7hiU30v+n9ki1IW/Rm4JNmA4eU+FJBo+yAYGKRtjvKixiitSugyNENPTSWF1HSn2CvcKWJVdF5CQ+a9iPaqMuqgBX9PWtnBGpwvN6a79MDdRakUQGwM5kOXo7Z76oJppE1sY69J1bxFKqFuHwodMXIAZQx+Ylsoem+0S+KLLTFe10OM9XBnRUL1v/0Q6xXF0u/AVpjlqULWbR33U8IZSZQOgO+pMeFQ0GQvBRKcPkjNQfrjldvvFZVhh9H1SHnJaMDbzE771TV21pXvI0qYdl5i+xkwfUezN9g97+ap08CQcAMvgEGMspCHjcqqtGc6WNRUxCXwhGA1gYgSVLtvDnIFxeOCIEe8DO+KC9LGV5jB/YPJ07AK6kwl/e/6wlXvtxTvB7AtPp0X/B51AaSWJJKvvTgNq4ifgRkLsX2Lq6vM4zEF+T3hMlYPKqrTCKHPHz1uU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v71iM4Oe6wlzT/s0NgRsEvDGuweDUCw5s9p0A4bK46iHHdTxt37RFXjq4sC3?=
 =?us-ascii?Q?MzUiPtQGpPfb842mZgnXZPdqAi04V1xTJJCgi/3h4aYi3VNsmrsRSajKBo2y?=
 =?us-ascii?Q?Yfq+4Ihi3EarKxUCYkWDK0pP6WonjbyRbnqGhCBvKuJMebYF6XN5AGQl02RW?=
 =?us-ascii?Q?hix2nVKSU4bZ77BqMObUW3Dsj9zs6RjXEipKgLLGSGDujLqjLQZpoB50vkh5?=
 =?us-ascii?Q?r5hfWQHdDh/oJ0geP54896m/PTluYdsx51iRvEQEWwlzpUzo6Rxf5WGVbyJg?=
 =?us-ascii?Q?y76qj7ckohzZSZs6J5DPhOTOLKgpOwOnBFEx9rNC5UZD8CD2jm2kLzhnr47h?=
 =?us-ascii?Q?Sm+E5EBzM7bVO6wOP+Gqwx7BVs7koi8RhuHwOrjDHlKYTsR9NS4Is6PxgFpD?=
 =?us-ascii?Q?QUk/cLTfnQstHjqfiHFSlw4YbuQrPsTREiK+PYuXHi4bQ/7pUg+C1JAoPSIb?=
 =?us-ascii?Q?Cu3g2joipYWjJCXPQsbFLXtpPZWA6kwRnuLr3bx0Y7Cvk3LgkTakxYJVoltC?=
 =?us-ascii?Q?+y1nn9MX4IAC8dIaNn8jGuRv5HD8nKM5UdfeBSU6+Td7gt4334YLIbtxwTgd?=
 =?us-ascii?Q?B7LLXJX/wrIo/6nBxO+azbqAzI7ZcZGmiKi+N3bDEYrySQTI7PEaGdGIjGjy?=
 =?us-ascii?Q?GAl2a2t/HylpMtsO8aF+ZiDuKTZY1WK3v0tC2oPIujHdBWtDUYJgRnq4EX16?=
 =?us-ascii?Q?uEPk4owYeQ1tQjGatmjWt7CTjVkWZnfOK6CKra8qfM7bcESbHHdfRVWUGKzf?=
 =?us-ascii?Q?LHUpUAWSLtV2AK7zvGGepJ1KdZfoAEJHsODtO/OZRvhpzTm5Qvx6vW7BESVr?=
 =?us-ascii?Q?f5MvPIso+hGxds4L+lEjUdOYUfvWaBOXv+RdVG5YIrTY8SvjhpbyeXSbT3oT?=
 =?us-ascii?Q?ys1iYQG403zPzzmTrecdbeATDLgGK6mxJLYXoi79Ur27sd6aQVdp1j9kFXQB?=
 =?us-ascii?Q?R3UjF/WvNej7ySX/T6FNYEQl8p5CohsoziwJV0SqLzp5rqWOYA8Qafh+jgjX?=
 =?us-ascii?Q?4QON7e6mv5U0Z1XY6wTloZX9/Gsl4AMK/kdI+8OKmNKyHR6vG4lUR/f1N1Ux?=
 =?us-ascii?Q?IgAiTjWLclKeAsOYCgWO8t169kXn8Gkdut/RF0RasNYerJL/PkLtJ6bsvfU+?=
 =?us-ascii?Q?bD3GA7l92Y4ot7EWLeIVxCbWSl+SqcFvobW/mq1OLEsUUSx6s9guHs5payTa?=
 =?us-ascii?Q?TEkuz01XVmxpjFNugef+r7tH9a/NmXO04j6P3FRLIGUaq/wKjWvYimFddNED?=
 =?us-ascii?Q?qVqORSpjbsNfe2O07t3KAig5tLiQFebjR4J/oEq0yiGsFHPkYCAUhr2QzDi/?=
 =?us-ascii?Q?9tzT1VUefDdXaThbMpNAgAV38ibB9gDKTsC60RIf6039FpqN9ZCixrG7/iVF?=
 =?us-ascii?Q?/2a5DwL4tdBb8BzOr0695EFkFRtnhMtUJlY6quSSFj4TeaRC9MCUXa6xhAsQ?=
 =?us-ascii?Q?GXbku8BPOV78oMmpaNXJJjkA3lMvo3bull+i9jukNTyzwGNSJtnwOYAL7ppv?=
 =?us-ascii?Q?x1Loa0x5xE86S48oVru+YEl7CiICR+n6G+LXQWz1Xi2oNff18DQvhBe+Uxz2?=
 =?us-ascii?Q?fI5JxRZsZQirs6Xkkv9IFAxy6NiOaTZHS4aEt7wTizxebiKwRpRjqq1vXlN/?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec1974-77cd-480a-c2ba-08dc55fa5fd0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 05:28:21.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqOk4ac+lnPQOf0Af4CWOMQuZkNjpH3cuC8tsJ5n2SIZdCmfcTgp+f6dHnk41I7ba6D5NqPYfS+Zxv96QQnoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

On Fri, 05 Apr, 2024 21:53:35 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 4 Apr 2024 20:33:55 +0300 Tariq Toukan wrote:
>> +/**
>> + * struct ethtool_rep_port_stats - representor port statistics
>> + * @rep_port_stats: struct group for representor port
>
> In more trivial remarks - kernel-doc script apparently doesn't want
> the group to be documented (any more?)
>

I took a look, and I believe the behavior of kernel-doc has remained the
same since the struct_group() helper macro was introduced. That said, I
think allowing the documentation of struct_group() would be a reasonable
choice/maybe worth updating the script.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50d7bd38c3aafc4749e05e8d7fcb616979143602

>> + *	@out_of_buf: Number of packets were dropped due to buffer exhaustion.
>> + */
>> +struct ethtool_rep_port_stats {
>> +	struct_group(rep_port_stats,
>> +		u64 out_of_buf;
>> +	);
>> +};
>> +


