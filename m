Return-Path: <netdev+bounces-130397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0B98A5B3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3BD1C21319
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FA1EA91;
	Mon, 30 Sep 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fudOUnGO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00D1E4A4
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703934; cv=fail; b=I+ZjH5KquhCyXzHtBimbJUY8DhMXWRBrjWvfQBCvPXrL+cnthn/aVXH8eYkWz/N9r+vJcapoUb9RbHaPDVZ4RE9d72pIijz2K7qErW/RNSpKDYsZaXgdyCzHjFNlK5DKia0CvmelF9a/c95w+YqNT5n3eUWMUeNUZNMvyzvXu4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703934; c=relaxed/simple;
	bh=yldbs9Ig7BwBIlHHnkplaO6WWgFc0bQDy1ofgx/TC6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oBFMu7v6icyw3guKX2RzRMGxoIxlQ3tfxOyXYBMIrvujSRYmgHZtzj6s1rWUCOoVWol5EGFPW4y8m92DgucXU6ynVcWe4Sb3c9fNBtRl895+9jrDz+IfVrPfPYOhKrMyrypYmFiWwXIG41Yk5XMG0qt7wYOZ0g8h+L9K8uQI03M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fudOUnGO; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7x+AqsxLulkSwmXbxxwAmptA54JFZHxm8ofxh2fVGqiSSYqwC/qNo0uATCD5UZfWiVn/I/hAn7hEzzIS2SPRkbQrO3YXDL324egOowZfPEvgdHavrqwlhOWtxGk+3OLZpPGjNZXpzDY8UWP6DGScrW7mXRuLZr9CU9BSm+F3gINiS9nhTLXBETBb2gqiqAP4yuFiuoGwql7SlXCs8ruebkh/AZWpdGfGPIei9rzaByQeDzFCnWn6RQD/tT73L+ntFK+4m2C+93CCi6Cr7Xl2JUDqRaeqpe+FpkClXd99aJac9w9sMpeo9jrUjzR+KlHhp+LfzwO7CU824ppjQihrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR8VjHbYQPCfq17SQgJZogkDcb51V6U0UV9a9/2u6/s=;
 b=EwlfSzyJ4o8Vjr6H51a9rnZHII7powu+f6OxKXPRP8a1aPZaIlc+GEY+h9jImGEGLkYavH/zOnZpbrvWC6JxrcckjBrP3gV8qoAPM1XWbJwZrmEUG+LNNMQqmddj1qRh4lZNpsEHt1kxhQ42J/Sfy4FUQitdPNcounYWNKT9+OguHD9cIQncsGV3gs5IKATnkvYbM1Ks+311by/lXTaoqsZdNDCwygbmtODQunLrGEtMv7U+hZnWSG3Fd2CLp6Q+uAMFrLA1+f08ii1NuDs/Dnfm52rpU9YfQrO+lawtnx50OQI6HTjR/k+88QJq5iz96goMufSgH/n3HHWNNu7RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR8VjHbYQPCfq17SQgJZogkDcb51V6U0UV9a9/2u6/s=;
 b=fudOUnGOzmrraITgc2oVVlg510Et+dCwowQhe3crvdCsVFEjjm6+yB4YnRltMUq3SLqYvrTas3yIlO5iaXsa6Wk+MOja1Zu4/IwQFQj3H9ouxnpk32qQ5CUV9xp6R+wXViAN0eOm+3zRlsOoiZE58DdEIWe83WAKcVDc0fj1AQBVd81O0uBvPk1rKuIEblLfBu7rDo4cXfOGjK7OLtSo65dnds/hrkqyZ/F35YhbI5aH6lOstGOoHXo8ft52+NSzM2TPm9Jivkv5G2YQu4rUMZZldI+Q5///GQRhqvbR+gUM2EhiIa3nBzo0pXV3eNoVwxsZFOZlaq8i0xG9JUBE9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 13:45:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 13:45:29 +0000
Date: Mon, 30 Sep 2024 16:45:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>, dsahern@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Message-ID: <Zvqrb3HYM3XogzOn@shredder.mtl.com>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <ZuQ5VNo/VUBWbqNl@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQ5VNo/VUBWbqNl@debian>
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 113359de-4ab0-49e2-efe1-08dce15625af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxVZMUav8nWivuMQaGD77/xgMXDXW/NAj7prd8vKVDhu8Hz5WWGG3Vjm0IL5?=
 =?us-ascii?Q?h3Y+ndl4NcDvkHvx2g0aR8EHhMK96votCot8lJQADwkRBuFLOn5X/8P+caRo?=
 =?us-ascii?Q?TDGimSu0gsjK05h9ieE5buA/7W1pKqFdBqamSaSFhPeVxPynrEz1IY3pBmqh?=
 =?us-ascii?Q?5+Sjg4xIt0Fn5yhFp1NdwnqPYqlhzHXOWcUVHh0rh7Asz9GNyeLwXf1wez3p?=
 =?us-ascii?Q?iB7Q025c9UZIvztzWo+zIZS/sgk0nn7fQoT4nZlUxgK14aAYy2LYQ8WEjRrF?=
 =?us-ascii?Q?PiH+JvtgdTKFQzPWQn6/XTqCO+AwTv52C9nb0wCpxa82KSiOfyWOBxa01Kh6?=
 =?us-ascii?Q?v+L7ug8pj+10qaUh4nVu5Mztzet8Lsukkp8Fpw/JoeXW9sLaX71RKu84a9/D?=
 =?us-ascii?Q?Cthbq2cnEe414i/ZsjgTjyWBZ7t1OWWW4bbTSObKjx+/UFTSHj2SNN4C3PsD?=
 =?us-ascii?Q?sELjO9/88ci6Rs87T2/AOVrK296+62tgG8pGZoGTk2e9qe7W9Y9Lw7Zc7I00?=
 =?us-ascii?Q?/V/t5ncU3vIjMSSvsXy7euIYHjRHma6WJVVLmIRKEFTEfLbird97Y6znW2Ro?=
 =?us-ascii?Q?57OubIMBl1kx2tFbs5MvbsaKeCEFqgFYukIoM19vWyx2pSyLAYFrc976EhbR?=
 =?us-ascii?Q?hSdcoQ6ddEtq7Eo4v6BKoGf1pO7qCFIwiFeh2flmuYZiicvIBHpv9ZyI03qP?=
 =?us-ascii?Q?7bPyT+lXw9grsBZ1n3EVrBaUfKGNIEmCMKOnobyG9gHXPNIoUGq6EDhIUsHb?=
 =?us-ascii?Q?40ajqh6Tx10zPFCzpM7R+FxwIYYufVMvhMxM/XEck0aUtId/3lBtBRGdh7zO?=
 =?us-ascii?Q?lCXB71zUob5YH+CObVStnZRWsBRMv1wy0QzQfWqyBHiSgZhhCglEKu+hdjQo?=
 =?us-ascii?Q?oSL2utuE88tHeb251jiT08W1BfnT+7dSJlrlR6zgSGtU0D9S2ncD0gpP1JzS?=
 =?us-ascii?Q?C4Z6ROYli+l+ysGInPGpu0eTbg5KcuVuG+C6MNO8QM6BgtOoXOsbeYPrRKus?=
 =?us-ascii?Q?195KNGLCmKjM7jmmwpqJfpxvS6wZaesNWlGR9iasii0Vot5X4DfzarUQs6ok?=
 =?us-ascii?Q?4AE+AGb5lymmUvLIvsS8NW7NU3tL6+yTwdrq3bqSEMwI07iKCt3D4GIDSchd?=
 =?us-ascii?Q?gYrzLq+NRB1ZsOVNDWDfR//uOivyDNF6Bb1eG0V39E310fz6KRrgifRWcnAc?=
 =?us-ascii?Q?dJGYVJeN0MdsOKW0bdnGwMnz+iPwomavL1o7VQa7SKk2x+gZF3BzJCpXFBX5?=
 =?us-ascii?Q?+Y51jwdEytHoo6yO7vXllt5CZcNanb53UPsnCEzXErQKTxehT5p1fyNbWf9V?=
 =?us-ascii?Q?FB1mqeRNjfc8iCfA/j3URtjNFdYo0qqzymCXrwCL9s7rzA17KZ3SOO4TqzXE?=
 =?us-ascii?Q?ou6lbsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbLWxpzZJtRe/5Rj0QdxIr7NoyLjihLb7ep9Bzi7woNUNegUlwt06xIWnOky?=
 =?us-ascii?Q?m64JWPa2YKJl1Dhd/cKJ2s06IQ6SulumQl6RtrGy+V1DEeUh7lcuUNM4oJqW?=
 =?us-ascii?Q?T5AkR1hDyNCRWx2W2swT0wvt/6mjJ6zlnTHPEDTV9pnca7Oh5v5zjSq/cWYv?=
 =?us-ascii?Q?zKxh5Mw4Uq4qAmqjXeiq90EPBAEH8fnyou51d9QDsvVGqZeI2NNRMtXdaDSl?=
 =?us-ascii?Q?ww/6cwr34hTq5pa6OYlCtPs5LqUP1Ddv7Y3vrWF3Czfk1LIWK0R/HIhWw0Jk?=
 =?us-ascii?Q?c5pfXQAym6EaNkX8uUcMKir33YVO18XrSM7S+FmqGfNJsV47iay+GkHGS7Fw?=
 =?us-ascii?Q?jEoyu7NYm9b4O9MhmPjRCYfoQ0XkZroDSJt98el0MSYLHPmGQ9IaEtswadqv?=
 =?us-ascii?Q?nSu5O76UKfDe1RfNRflL+fMgXFi3FWj058o3S4+f7BKuJyM2IPEX9MBM3F79?=
 =?us-ascii?Q?L6TGMPqTPQpeqfbo4ikKEkDhAl9mbywKioxyewcAMI7xSgtNe7AjuyHFfj55?=
 =?us-ascii?Q?p2r7SIK5NMxAJlX9YsC/+zb2fOT/RJdhUkisL2YJX6bs5Pt7aelX9EK21y6O?=
 =?us-ascii?Q?tU+NTTQZEFPFFuHSu7rzKLcjPuYr117KnilTlXJLrWQ0yZ1kLG5GFk+Ys9ZS?=
 =?us-ascii?Q?q5YmggALmRiQcIus2mKz3Oiie191sWFpkIQ9cO+vvJVLJaDqKGcouszPSJT2?=
 =?us-ascii?Q?4zhcAmSSZW8ICEqBlqE9Hqeld5pwyigT8QKyznB2QmyUzirXpeo7BeHfWZNq?=
 =?us-ascii?Q?HxVFL16HPR2K4nPd3De5Yb5I7yiIaSKyf67Y1UO5yInqKom2DK6QNAdYPvHe?=
 =?us-ascii?Q?46mm2cn/+e0HJ7Z/Isf1i2mEPBlnCMh8DZ+h8xpE1fjmc93ACEqXGWm1JkL6?=
 =?us-ascii?Q?HRPWfLnVb5aVX6frsYxHg0mjMkoTXji3bUFzB1AmF2MiwEHGym6fmwHmVCD3?=
 =?us-ascii?Q?c8M7bQ2NHQbkX7ELjkysmtBAKVCFGdJivmN0NRuix0lifdeGzUTYZd+UDy6Q?=
 =?us-ascii?Q?CkJ5R4GIw4qFDCCr4AtYtnIh7jfOerH7Mf1QhDm8viiYVd2RIQY2cdx1f47k?=
 =?us-ascii?Q?qo16f63N8oS17i7Q4yotBfEDbO3D+2Bbd+aNzCd6AsYLuq3i/rReiGhJ/RSU?=
 =?us-ascii?Q?MUydbvVQK1BkgbZyjuXx18KGvwUOdQNAPAVG+1TqNguu2njDfgmyqR9P0QyE?=
 =?us-ascii?Q?NlseO0qhqkWmen4N5T+GsbPqKwQ8P2YFGMRdjNtnX9BCGAZQuet0vFhq2t55?=
 =?us-ascii?Q?xGSJqPAvCRvPF0oQqeB2VlSFx0SdwjpK1r/s3uXEiJGGE5k/9pvN3ADVtSMP?=
 =?us-ascii?Q?AJc25oObUktl+pHeXNOpdMEegKE3gziLBvPn5wx5T5sk2w/nikrk3bS0yU+j?=
 =?us-ascii?Q?IcDj3g/SmiKIiMqvNXRXZLBZJogtoBw8TFBRShTDF9/OzIvy5ardeOAov16w?=
 =?us-ascii?Q?dxt0+tM4x1EtHYgHyepM0xsLfaAXyH9UrGA/gi6G6NP5qkfgdlAW7rWD9nCc?=
 =?us-ascii?Q?ShMhxCvVwYVkMHZlvCmKbMMbaHvHjuifWli+BuHlVQ1GYJYyiEK8s0f0MmnK?=
 =?us-ascii?Q?8k4rWxxHCHKs4foAE2oz5Qpcys8pquZ+gBBO+uxQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113359de-4ab0-49e2-efe1-08dce15625af
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:45:29.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/hFoNBZMv6vE2lSEYpOzasMuXdvlaX0dsqZhiaskM0BSLQ3WuylHss+WasiCMYHyfjGeviH/nRAzy/K69QVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632

Hi Guillaume,

Sorry for the delay. Was OOO / sick. Thanks for reviewing the patches.

On Fri, Sep 13, 2024 at 03:08:36PM +0200, Guillaume Nault wrote:
> On Wed, Sep 11, 2024 at 12:37:42PM +0300, Ido Schimmel wrote:
[...]
> > iproute2 changes can be found here [1].
> > 
> > [1] https://github.com/idosch/iproute2/tree/submit/dscp_rfc_v1
> 
> Any reason for always printing numbers in the json output of this
> iproute2 RFC? Why can't json users just use the -N parameter?

Because then the JSON output is always printed as a string. Example with
the old "tos" keyword:

# ip -6 rule add tos CS1 table 100
# ip -6 -j -p rule show tos CS1          
[ {
        "priority": 32765,
        "src": "all",
        "tos": "CS1",
        "table": "100"
    } ]
# ip -6 -j -p -N rule show tos CS1
[ {
        "priority": 32765,
        "src": "all",
        "tos": "0x20",
        "table": "100"
    } ]

Plus, JSON output should be consumed by scripts and it doesn't make
sense to me to use symbolic names there.

> I haven't checked all the /etc/iproute2/rt_* aliases, but the general
> behaviour seems to print the human readable name for both json and
> normal outputs, unles -N is given on the command line.

dcb is also always using numeric output for JSON:

# dcb app add dev swp1 dscp-prio CS1:0 CS2:1
# dcb -j -p app show dev swp1 dscp-prio
{
    "dscp_prio": [ [ 8,0," " ],[ 16,1," " ] ]
}
# dcb -j -p -N app show dev swp1 dscp-prio
{
    "dscp_prio": [ [ 8,0," " ],[ 16,1," " ] ]
}

So there is already inconsistency in iproute2. I chose the approach that
seemed correct to me. I don't think much thought went into always
printing strings in JSON output other than that it was easy to
implement.

David, what is your preference?

