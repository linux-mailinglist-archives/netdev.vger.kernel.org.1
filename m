Return-Path: <netdev+bounces-78045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC3873D70
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B791C217F2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010D13BACD;
	Wed,  6 Mar 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajQ8F1nr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C713BAF1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745743; cv=fail; b=jay22aubPAp5nuDbi0s4EUDibx7PqRLBMW2Oa6vHq/wd+vHawvSozqayvuIKk8uphWVObiIDpz8LIWSfkIi2fLKG1SEISgelYndQL2fHhnqeCXUFpPT8/GJY2O5gbnrgVrh7tTDAk0udyEPifuNC1huXFqou2zZF7/N7ajau3jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745743; c=relaxed/simple;
	bh=T2bcoYpQXKdiLY8i2q3YTeguTXvQJZkSRua9j4VJuyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJfb4wevihGzxmUN2EPhuzBjteQGZG+BpDO0zgZJxc1V369QDkP9Yi4F3/S9Qqh6nFtcXkG+//HYx7cHN6yk3x5A281ZIrprzvBoBPSY73c8trTH3y90ZbTVdb+FF840bZUpQWIKB1TYA3cOr683tKfwxRwnl7Lp22LH4XqChFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajQ8F1nr; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glnOLg5MxTI0H0+s0llARJwwUcy4ENJlWTKJVHINLfWfyB9dlnX9V86BHRBTFdYelB/LFdzLlAsbxhs+YI8KdqOw/sIP9UWM51+n1695jWGQ24JfTh6yYEK5wpFVXSHIQXH0iYv0HDCcw8PFTV2T01re3uu6/RqBnw34dPyu+TzQZp7HSlw2QJdUqgxteEZS7D6EokEL9tKfj8dIEvpFHbgYSnYQzB7+pH8YX25si07VhI45rvQd9Co2BBPdcBxapsdd7l6eC73XmaNNvs+Ylew5ygHo2iW9BLSZznGm78OiMn6LKY8qfN/2w6LheYCLg782NWcLn9q28ux1dFJ1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzZfzJe6TTV9pG+wBtfhpJKTr0JxTnoBHnZiveRyrIo=;
 b=ZJ8B3StWnDDaZLD4FxAn4wILufxlRnQJjunTU2coRzZ8m4mjU8c3u1ONW6JNbyAyTRSdup1I5ipQO0QR2lAh/DYKHlhUFMCOMBjEvOoKLQOsRPUo5FSUC1NIPCBFK7EWubMEZHP1PToN3CDryDPlb2pYU9lJexhvlstQ3JE8so1Xt0lAZElnXeCgUYM58j/Qe2/X8ifOld6P93PCT91wsemw2n+ijTeflXHZ8alTNQ3uQ46yTGT/ItjOB4AUaXwZN7w5T7apyMc2kFt7zKQQzl+No6Ys2LlhOTH5V2hYsryge8xCb7W4KROvarSHgOfho0vZNu6idsBmxo20h94DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzZfzJe6TTV9pG+wBtfhpJKTr0JxTnoBHnZiveRyrIo=;
 b=ajQ8F1nrsP7jSrI3A4RzJloHVMRvjVsQbl7t/nnG7DJP9CQfMOxvR+8/X0LwTixNV9J17hPamxnngnyyQmzOFwS2lHuGhhCc9Fl7a7mnhem4F0UULYvQba8/wi8jfiKdQ3yBg7DPa/tcYtKc+ezd5RymWVppdBj3dHnkcWEfCghqEuZ2FgTWXzwaA2ZVKYZX7n55EMPokBEyrg+R3xIgAuExf8keO2RxMVSLAM0r0sy6Cs1mQQkpmxh1rT4Aoll25ulvMH/4k1yWMk4vaNDB83FBwrS1zCsEoKZCfnmQGAE6g/c5WF6O/95IOBqivuT0juj3hylOlHFjv6ZxfhCljA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:22:18 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:22:17 +0000
Date: Wed, 6 Mar 2024 19:22:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v4 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <ZeimRPbhmo4m012Z@shredder>
References: <cover.1709727981.git.petrm@nvidia.com>
 <b66eaea956cb860a38c7ea77bf8571e386de5221.1709727981.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66eaea956cb860a38c7ea77bf8571e386de5221.1709727981.git.petrm@nvidia.com>
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: f1557f4c-a1f0-4ac7-01a6-08dc3e01f8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ljm2QVGzS6iv+qhLNuVMZYkOBuIZm0xRvoSCjMc1OKy8BbJDWgmTxrSLRZj5Ls753odxv3MEajGPAFadCQ76VC35FIIC18KPILzqU29AMa0VX8lCZ5Ybb4XYK+qrag5DqMn2TE68XdsuAry/nHZSdkF1hD+puiIC6iRWsa4EHT7z4xIU3OVYfC0IT0ClqQNK5bAZ73TeAFXy4SyLYYkFqxHwUhbyD3xvp1VBrZWQDGZ6xEcl8jLeev2+ftDeJNbq29mG3Oiob0NIBuYNqVt/zkxRgVu/jAEUaL2bYR+TbgXLhPAYQ4VsriFDzAXUSIHWQpN9xr3DzlDrKTSgV0HkRp83HgqeErnzQgAxa1DquINV+WVDPj2mERHEdvxrQXgX5jP+52J+7Eh0sG2/0jAA6fih9V5VuSjQ2yypRCsmfeXhJJaCLZdDyqHjozzXwCzBZzyytFUTVHQjoaL/i5HE1+Vi8BvRHNq8femioweNADmVak+dwj9D1wzeAMZXIDPxbYKoBdUrJB1PwLU4AseIh5x1dmVM5TOzHGlL4R8z/PuRWnGZvc/ykLgosdffF5CCYBGvispr+prYq7hx+uZ57n5XqCfbR2tjcmiRWAVkmOOiIBkkzxKW1T2MM88HBBxwfe6nTQR4nlbZdxVKkA11LaknO29tE1EMG5yVMN4koSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CTJtSHDNtYMCoKi0avShTqxBkPB8AQD4K3lsISLgGvr0V1dnHzOB6dim/NW0?=
 =?us-ascii?Q?oGT+TWtSqPPwtwAuaeEX49ikHh/W6hE3kVIjnC1/OgXhLDf64H6en1jtSUBT?=
 =?us-ascii?Q?kpjOWQ/O5/xSoUWx9yR5L5CZ2euUf+5xvt8Mm+AWdrMwMPmifCXDO1Jld/rL?=
 =?us-ascii?Q?628TjdVDqhE9hig5x+Y4FetI1GcJxy2TlY2H3q39j0oNNPMnYuKnzHLJu7sx?=
 =?us-ascii?Q?3BFq/v1WekbfS7hwTok9qOhmruPmgoswgASJHyQJv7uTpJUnYIvB4PwPgEkk?=
 =?us-ascii?Q?YPxcHcIr/Jm3bHBgWgJ+txHoCfE2N2CyTGfYSbs/TdZAwiX+J9fDB1z11qEp?=
 =?us-ascii?Q?+wAWynexochth6FDbVtnMOTQo71PR9uCNmWOgEi4Wmrkb8ymHiTKYP7W8ANz?=
 =?us-ascii?Q?Uaru3YVQLfuN1NL9ZpZfkfIqwPd4UQfBN1Dl8vRxpd8nWK9UseQuD0Gti/U3?=
 =?us-ascii?Q?4vvEyh2A4UvaFT7Lb6o2QYnFKyrhnc/euFEGbpfAzlAcer4oELuO0O2E84fo?=
 =?us-ascii?Q?MDLjJk2IDRjS28ivbf3CyJKPRJryFe/gDDVOuIPDG7rRqGy2KZgVWCC5tBq+?=
 =?us-ascii?Q?gro1Y2ptGzjSQ9rnGpWRme7tw388O23FE2YOaSazWPJThkfWEqVqZjgdroVQ?=
 =?us-ascii?Q?ksJdagtLKrYcsjjhnqQ7BMWdVkGcEyji9otpWR5kFoBf0qnkA4KedLSV7lTz?=
 =?us-ascii?Q?45Yw+bQYCYoIEwmavcoZkA17Sg7th2SY0/sLEgZD9bEizTgF2WpksmYZulWx?=
 =?us-ascii?Q?i0nc8z+i7dAXtOtomr+Pn2/TbJ2JdNwk5dUeSkZ/xqXjsVtNNPlthBDVSSPF?=
 =?us-ascii?Q?NXDVZQqAGP+G9LmYu/CxkTMtIvrWUb/p3l/+AmcHoS+Tb67ZmYb/WOuj9z8e?=
 =?us-ascii?Q?kYI7YY/CmR4RYetkgT7li+Om1hYhDaBxqkeChZIPpxKoIFbkgnAnqDUWpyAg?=
 =?us-ascii?Q?Midrv73nOBeT8WBBkSC9T2wRJgsMmo0frIhAnogWy+V/9g5TrfKpRjHdgJ/b?=
 =?us-ascii?Q?9+4ayJ4QuV1P1aYVh5n8O1gVDADo3pCd7gZvbu4QYzAp3Kj+FfN1Gq+BZfW1?=
 =?us-ascii?Q?wt9l4BkwwU9IyyRxFJhP4jW+2vpX7Pd6SAWlx7c0A22v6pOrGGAEF+miwGq8?=
 =?us-ascii?Q?U428HyQg05i+VL/PMzMh8v2zxKPC66ntheAKadUeK2SkluVjTse/2j67q8zu?=
 =?us-ascii?Q?E4x50DmCDLVaYX2VjWs0b5xB5E8MxTsQyc0CW89wKFAyfJ1zIJucR5jH++9X?=
 =?us-ascii?Q?ZBB4WY6fJrONSdwpAjK7AYaEs/rhUOxMdYO6e/21+qF+s7Tjo76HiOWSRbiz?=
 =?us-ascii?Q?KgAGYahH9wBC0mzaH5grHFHACSEfjvwU5ntxhWXaCE0x5xIdmhQMx+/nrJih?=
 =?us-ascii?Q?PCGu9m7PoR9rB9F1s4IM78SuKTsnDY+DD0g4kYHu2GtE5xSWYZQHy88FJzQh?=
 =?us-ascii?Q?lygWbTIS3kxIGaWn2FCZ/ikRpv1+4DuHQZgcjsA6/fu2QudwX+c19rQSm/Kc?=
 =?us-ascii?Q?GKwsjm7P/EFCLGSdGvm4Fr/VAVHFyto/GBZkRyLGFuDb7b1b68oDQIGXhUUw?=
 =?us-ascii?Q?O1TxhrchHwu9b7gndp23QIGNVPAXzOPiisN5oMAS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1557f4c-a1f0-4ac7-01a6-08dc3e01f8ec
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:22:17.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV7ZxD9IfRJb/W20K0TuK8fJ2FGywTLnpqZoKK0WKlgmrdDIDQcW1n3evChRqP+YeUemG0HxM7FtTuVssjbndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

On Wed, Mar 06, 2024 at 01:49:16PM +0100, Petr Machata wrote:
> In order to add per-nexthop statistics, but still not increase netlink
> message size for consumers that do not care about them, there needs to be a
> toggle through which the user indicates their desire to get the statistics.
> To that end, add a new attribute, NHA_OP_FLAGS. The idea is to be able to
> use the attribute for carrying of arbitrary operation-specific flags, i.e.
> not make it specific for get / dump.
> 
> Add the new attribute to get and dump policies, but do not actually allow
> any flags yet -- those will come later as the flags themselves are defined.
> Add the necessary parsing code.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

