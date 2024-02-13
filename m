Return-Path: <netdev+bounces-71547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371D853E86
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6ACB2C5CE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9E626C6;
	Tue, 13 Feb 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ID1zuOmQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160165BD2
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861918; cv=fail; b=rqcQHLUoTVpXTydTY+HJWM7PODJ+/N+FFDnNvgPiZhyJTWopWVvHnxJyP9ZT0ANPfJ1UDdeT5cIo9KwkNKdb8HSg8yPA6mTSNuaSQC9EC8egGh3yHINg7b9JQTtlhLQscik8Vcu7LoYOOIHFYsugyDZYXcmM9x+iLdbGMRwYyOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861918; c=relaxed/simple;
	bh=jz+sACUY+mgicUL7KfOrg+tkmrrydbnXpPSBF6/hY/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAWk7TBc0EAfBDneyoBt49qPHoghtIEjagnxuInTxeoiw3KSGInx2hXfoFyJMV0iBkTGV9Kew34GpXwPXRMg/rN/aBc8F1V1w5D0aSaPvhNuUBc/NDfQh5BNttv6mnbveR4+ulevg/fpB3Rbtb1Ec/sXPFqA4xMvbGMoS/6W2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ID1zuOmQ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F36ju73Flyxdu1pBUNxMXoIxiU6j49XusH3+GY4aomEIghH5zaNOf09r/nKnu9XnsP6cBV3jxcDh+QRdwFgXH3eVMozLBTyD9wZf5n3KUzWAUmD8f197N3DC9MrMl2Y0k33zBiN72nzv7LKfjlAAKHuIhPMv9kjqP+VB/CniHE0fgLwtYLLI7PHdhLgcWWgki14xuihjbgFybf/xBvwYimYwfhCLPs9KJS9NZ9ua7XpaJi3CbV0fPbslJlU1oZ2dS07FGNn5+oT4RZ52qQA4a0yJni7Ii1R2T18r/9mkLJTKBV9htjl0qHwE0ATwd6r04MPuwA00AyGFHZibugbrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao7CgoW/tUd3z1HM+YhoM+5641BBEMEVXcz1NA3sQsQ=;
 b=lA29BjndoEv30nYCxPPP6+Sj6HdOjqgo6vml1iYv9vuL7sTIMnCsrVkCrmUMBCCdz01eQ/+y50Csd/AGkU8JkoeePa+Lgn/SFUdFUsPKNfNLSBYFEqYNl3LO6GIcuLFeJVzRu5gQGmRu8bJKJB7xDmFdW7Tq5vq0L1dBn6yDG/eUp9aUCv9+g0VeHaVjtDVzJcMSfo+ducZGh0RgyT1Qipgamenq7PMF+CWd57zuhlAuG4XWk6DSWJC9U8mV00vgnPI54AGLMybwrc5qzTKvr3Qi3QQJSMq4JQgQQJDPZpoNJ4ZYTg4oR/PtCxkV4jEQBZfzJCZ1aXcbFkSrEOm6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao7CgoW/tUd3z1HM+YhoM+5641BBEMEVXcz1NA3sQsQ=;
 b=ID1zuOmQEc3yrjYHrofh1juzdjR4Oy7jBy3elzdpaaVXYQP1gKgC+5tpKmrLDQAuuzyrJ24X6XRn4fDiIR1AdvMPBw/MgorDako9bTsQss/fMUZNEcGqO3BvvvHoOP9AeyBqxtqmc1dA2l9W0pr310atWf0kASOreONF+ZF4fA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 22:05:14 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 22:05:14 +0000
Message-ID: <47fa96be-181e-4d71-a0ce-244bfbe93cb8@amd.com>
Date: Tue, 13 Feb 2024 14:05:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 7/9] ionic: Add XDP_REDIRECT support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
References: <20240210004827.53814-1-shannon.nelson@amd.com>
 <20240210004827.53814-8-shannon.nelson@amd.com>
 <9f254fa79f100133319f1ca824becc0cfac38cd3.camel@redhat.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <9f254fa79f100133319f1ca824becc0cfac38cd3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b89845a-da40-4fa1-bff7-08dc2cdfdb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ke7MBCaxsIkX6RaxEcUoIf7zPZGY3sU8Xtw2FcIkvEFNCBvCYOPC2w5JhTkC9ZLvPUM3woBTvlcsO2cqSv+/ntxfaPhf2mB3OVtj2szVU80DKUJN7D8GgJ6g6ZYmzwUVv7zGTTb75OuesEOyGmkyohFhLk1uHMDI7/m4+Cq95Ma+FoJpOqh4iOCjvxbtmH2Nj/aQG1IqIGgh06oiDYFgPz789/ALhl/kcoZ3C83th5h03vqXvmOZXzZno4BYMX/6cgr9gAkHVS27x7XNj+e/JjoQjniYqoHDkwBrCDPXAuFbtO1esWQwxaPKJgEvaFKHWzpGPKNPzgYmNz5MdOW7zaewMMJxwbMJMAzP/+ar4P1lzE6V0uGSc+A/wsZ/Mv/zuyBWwzJjOVObD+zHHsYcx+q7OR+/VlREP1v+mrhQB6YxMNS3tjhYQh2ccYxktnbvfW5mZpUzqodgl7x6aLsTIYk0fIWgkneM+d3/8ksn5FO4wjNtrRyDEQLNwlq6KHUVp4EGLZ+40+8u/gA263Fz6+CG55yOSmHE58ZLOPAzylO49fV/IYdmMynPKY7XOXQK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(2906002)(41300700001)(8936002)(83380400001)(5660300002)(66476007)(6512007)(8676002)(66556008)(4326008)(66946007)(26005)(36756003)(2616005)(53546011)(478600001)(6486002)(316002)(6506007)(38100700002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3RwdDlmMGx1TmRGNEswTmN1UzQ1RHZhYXVjR2RaMXFENklHQm5lc3l4bHZX?=
 =?utf-8?B?c1pxeFZWUklPRVhnMHl2bXlEbm1ZQ0NNc3dHVjYwL1c1T0RtM0NPSldmbXV0?=
 =?utf-8?B?MnlMSFg4bmVDY0Y1ODNMbzVEWkJkY2Y5dGkxQVVkN0ljM2lQczBRS3lVb2xU?=
 =?utf-8?B?eng0S0ExbkI4NHF3Z1VHZVAyMUhnMlMzREdKRjVxd09WcU5SMkJ1d0s2WXlx?=
 =?utf-8?B?R1NNYklwMDRXWWhWb0Q2blZDdVlaU0xTcVpSSUNJNlMrWkdUcERKU3dnRXlw?=
 =?utf-8?B?UlgzOFlzTFpKd2xTcWZIeGRxNHl4RDl6ZGkxSFhiNEhmTEkydjZ4ZjJxVGox?=
 =?utf-8?B?aDRCK3ViKzdmWEE4MU9NaE1QNjZWSjl4UjI4SUI0S0didm9qb0JKRkVyUjZD?=
 =?utf-8?B?a1d6dXVlVWJ6bzU4b2FGUnBzMW5TejhjelhXTUNJdE9tT0EraExHNC8ybGVw?=
 =?utf-8?B?Z2w0OWwzY3J4SEMxYWFLMmRDZzZXRzFTK1dDNjFmQXdybTN4SHA0MWY0K0Ja?=
 =?utf-8?B?aGN6Mm84T1pleEx0VFJLeFBtcU5EcE1VWkl6Rm1uazd4dDVaRlN2ZjZibjFD?=
 =?utf-8?B?cm5vMS9semN0aFRyQnVncFpwTlRMd25ybWh6cjk0RS9XOHZDaHlac3d3RGxM?=
 =?utf-8?B?WGxpU1B2MUk3VExZWDFwNkxoUjNsOTlkdjVJdmpzUE1sT1Z1NVE0ZXByS05i?=
 =?utf-8?B?d2xrQXRsV0toTVdsUmw5Tk1jeldvUnhyMUprcUY3QytpR3ducHpXYlgzQ2ta?=
 =?utf-8?B?aERTcktVbDV5WmxFNXNPYmFYUFEzd08vbysrMTE5R2k5c2VuRVoweHZxdWdY?=
 =?utf-8?B?TlVtb0JHRHRWdTJ3MVZ4alh1VnNFS1ppTUZ3MmYybWlFdE9wcEc0T0h2R3FK?=
 =?utf-8?B?RDNxd3YyMnhwQlF1WkxLa3lqeUE2WTBUUHNYWEYxTi9QQjVEY0NmNVZzbWd5?=
 =?utf-8?B?M3BDaUh6TVQxVjBPWTdCa011WXBXM2hnQzB6djM3VWYrSENSQVJUaGVYN1Ju?=
 =?utf-8?B?NzFvbmQxT3FUY1lpYnR0aFY1bnFveGQzU09ZeDJkdW1wdE9aTDlaQVFlekd3?=
 =?utf-8?B?ck1WL1o5WnNNVHEzTytMeEVOU2l0QkRjcGdqWGxPVlMzRkhUMW41cXptT0Jh?=
 =?utf-8?B?c1ptWDA3TzBKOU5zVWpTNE03M2RDSmRMK08yZlZ1Q1B6SVZjdzltQnUxQUNS?=
 =?utf-8?B?ZEIyby8zVlNGU1FjZnFaeXBlTEtpNmRuZVVhT1pHV0xrdUQ0L29kNmFyOGxC?=
 =?utf-8?B?R3pzT2VtRmx4NFlwTjM0YWt2aFdrUXpTQW04TzM1RjdrQVR1VW1lYmNHRUdI?=
 =?utf-8?B?cHVsWkVET1lnd083T1RSUzZ0ZytFMzRDK3N6ZzFIbm1La2ZBNGJnWHh4aWhq?=
 =?utf-8?B?MXJNWVpxMjluRVlhaVg5SDI5UitIY2N0cEtHMzQ4dUVsdmFQZ0JYWFU5Z3BZ?=
 =?utf-8?B?Zk1TMjNteVEwODVCVkRmbTNDR1pSVHFqaHN4TzhrV29NcGxrNnZ5bTZRRmkr?=
 =?utf-8?B?cDZMTmVEOSs4NkhaakVWOWZpSWJHSlNEQjlUbS9ObGNEbTFZdGxxSEk3bTc4?=
 =?utf-8?B?eit0SHd4cTI3dmVKWmFHWDRxZ0pwSDlWYUNQaWRZZmQ1bGtFMnlNb0U3R1B5?=
 =?utf-8?B?WEgrY1FDdm1ueDNwbWdjNmhmMFpWWGpHTmU1QWhyelhBSUF6ZDNwZWRIZ3RI?=
 =?utf-8?B?ZXFXOU5oYXIzVmlyNUxYTFJIQW02Z3RXVEVTdThzYkh1VzcyWnhUYTJIUjZJ?=
 =?utf-8?B?L2tpYXAxdjcwRkpnb2syYVJRSUtESStWRGVJSUREa0NDK3BOek1LZUx1V2Vi?=
 =?utf-8?B?RkN1WnlCb2lJbUNMZ2Ftek9lMDNocjJVdG1SVjlUaklHTFdWeWcwUURSdCs0?=
 =?utf-8?B?S01PSzJiUW02SW92ZlpTVldrNVViM09QdUx5MEtESVlNcUxxdzJjcUd6dG95?=
 =?utf-8?B?d3JlQUloM1hobXZSUDIrTEh0K3J6SEpoa3RKbzVXUTdhQ1RBQVNwMFllZ0RH?=
 =?utf-8?B?ZWF2K0tzdDhHTXUxa2hnNVdZRzhTc3gzczZQUUJHdmxLcXNDcjJWbU1pd0N5?=
 =?utf-8?B?Q0NFaTZ6UEZlRm5NT1hsR0xld3ZNSjdIOHBFL0ExN1E1ODJXclVNTWZ5UGpw?=
 =?utf-8?Q?nQLD1alYNbmvNKhIyOXocIORw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b89845a-da40-4fa1-bff7-08dc2cdfdb04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:05:14.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNW85rpyFjOZD99alKqGObYLSjV1LPo1LUCG3ZatWfGpuFhJWt3jbOSdMPVgs3xuqetC8OLSGUnH+bKxRuLUSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

On 2/13/2024 3:27 AM, Paolo Abeni wrote:
> 
> On Fri, 2024-02-09 at 16:48 -0800, Shannon Nelson wrote:
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index 6921fd3a1773..6a2067599bd8 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -413,7 +413,19 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                break;
>>
>>        case XDP_REDIRECT:
>> -             goto out_xdp_abort;
>> +             /* unmap the pages before handing them to a different device */
>> +             dma_unmap_page(rxq->dev, buf_info->dma_addr,
>> +                            IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> +
>> +             err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
>> +             if (err) {
>> +                     netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
>> +                     goto out_xdp_abort;
>> +             }
>> +             buf_info->page = NULL;
>> +             rxq->xdp_flush = true;
>> +             stats->xdp_redirect++;
>> +             break;
> 
> After this patch, there is a single 'goto out_xdp_abort' statement.

There are three 'goto' statements - error handling for XDP_REDIRECT, 
error handling for XDP_TX, and for the XDP_DROP/default case.

> 
> If you re-order the case as:
> 
>          case XDP_TX:
>          case XDP_REDIRECT:
>          case XDP_REDIRECT:
>          default:
> 
> in patch 4/9, then you will not need to add the mentioned label in the
> previous patch and the code after this one will be cleaner.

Sure, I can put the XDP_REDIRECT after the XDP_TX, which will clean up 
patch 6/9 slightly.

And thanks for taking the time to look at these, I appreciate it.

Cheers,
sln

> 
> Cheers,
> 
> Paolo
> 

