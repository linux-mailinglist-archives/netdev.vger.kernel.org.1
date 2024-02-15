Return-Path: <netdev+bounces-72186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EA856E3D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187BCB20BA2
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ECF139594;
	Thu, 15 Feb 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WLaHkIU9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01413173A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027255; cv=fail; b=Q9NcvTxd/oVuJgk7ijEK5dW9/kuJs4KhgMJz06ly///BGMHZ931i5NqOgfmoOhAtbXd3FKr8rISz6j0n4rfTbzPspERBq6Mh2WQjI+FYE3zmz2UvrBZh5bXA3Ki2Ky0+IBGlfAGioL8oUDxzUTNXVmw8882e+GjADD6OytB6ahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027255; c=relaxed/simple;
	bh=F/GrW3/DqdtpQYpBwkHIpeJjjCohgyqBMo/mR/EshKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lu1Luq+iFcM9Kr/4EZ8x1QER3n2LA6W0TdKS2eNmGBDl+j2nZ5BKqEpZX9UL8UTL5BU4HshPkgMKnGc5iWduFlXQAGx/9tD1zB79hXFw0sZmdJYVwHAJ16CZIAyU4TlFhCg8m342Xl9EVEkvzDjXkUR3VdXeHGBPOZQuZYH34PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLaHkIU9; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsADJ+rRs62+DBy9R/WOk6cTLlQZ6Sms/RqFBJ9yTJVxD9GBSqHHRTJYWlRd2Gszl4dra7KxQFb6xCajEURttGNqSF7G6YDnUDOXuAyNhaXJs0G1ATAf/FNf98QbPQ7Hr04okYlgGA+FghGaBDDPmZLwgmp+jG1zoufpt4MU2yEQCgJaEQ7ZefjQ5xhM5joLb3Jm7ryYo4bXYxVE88jzfXz/IHHWXqHtPuwz1UNQEiJLZlefMzOYYQr4Pq9duZNdVUp22PZ1q919n6wRrdHrBojoVIAzSWrRCVCV9HHVGed8XbtsnQiQAYeeK4XrZtTug8bZuTEyJz9IEfNh9bLPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WSH6jrQ57SdeOTHftqG8L48xcra7EvvUCrrHAJpQwc=;
 b=Gh+I2Y2a3RaYMFPE3deh4IXWV+Mu07RHECwMVy68SZb9SqM+t/VelFIlb5UOExp092sqZuAWsUEvgYGsXiAtKGhQwUvOiwu/W1xwp/ax0HUiK+34keITvuAuZ4KkmCYTPBNpDBzjasak+dJ+Ba9+usbYcsYD6RUCbN+0pJeqE7WTAvCX715sYzRn2tVy/pXRbWVjTgBzThqbPtERPgz/NnDWtW9W1Ttv5K04oMmI1KUTwWa8FgIjFfd9y4enerDVt9K3FPftrBzw59sFxD6JtRmIVt0K6575eoGWhzNpd2dkban1oiRGnedyp4158g+B0xNDY9c/Uo9F5jPUk/Hzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WSH6jrQ57SdeOTHftqG8L48xcra7EvvUCrrHAJpQwc=;
 b=WLaHkIU9dgcwOh5X6D92ooToJ1EaJcTWgsUUhsnwHj/a7Gtlx5QKhT5yph36XFItpx+eBTKygrOigc5cpdsq5GvjC0pwO6MtfcB9mdOhggBgLfP6rA/iEMpm6k7o+nczi9S5RuoaeZ5Vak6M6W+sqeSLMmI6wwC0ByWYg7vJIHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:00:50 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::1a12:1ebd:1140:7365]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::1a12:1ebd:1140:7365%7]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 20:00:50 +0000
Message-ID: <ae48aa95-15c5-09a0-a24c-eefb8c1b35f7@amd.com>
Date: Fri, 16 Feb 2024 01:30:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS
 routines
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-4-Raju.Rangoju@amd.com>
 <20240214172730.379344e5@kernel.org> <2024021518-germinate-carol-12c2@gregkh>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <2024021518-germinate-carol-12c2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a04d96-f78b-4648-9710-08dc2e60ce5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	72MlsWvAfLteHLDtUS1cB3CKlYlr4PPu47f54pk5M6E8I3wIS3A15L2Oer4+33RL/DRSzggHKLGrB/ZWN3M3wfr6twezuecvti0bKunV0ZqxHP4pY4P7E5ca0nOO0UbJx7acxpSq5BiVBmro7AS+KU62GQD5r+koCEVU934zJd0C8yE7jePR5ixD70oF3M6CRWLtA8e9pyg7mZvF+siGMoonwsGzVdLiKv7pq+kUMDKRACgoSkrqg/EIl55J/cfCZaGf8Iab54MtDMlQDCMv+75XYKeEVpXA3rvdR0V4MbBbTQ2T4Al5+kS78R6SLvN+CMueIoFub1qr2PZEnOed5gmrJXYdHmv5TSATbpzfj+9dKCB7hK7ZVj7HrObZdFYsET3mi6H9uXycmq1sMT+pIXe9RnjpJJcZ6QS/41bfS/7pwxumltW4pLMQAk3znUHl6bR4oNmXxxVZ+fZ7yR7CJM3GPQ8xN4nRUPqb3tH/TUazyERsp9P11JDYjRGQAgoph5ls5Etga8wd3RA8i5hnsXF+WmDfIHmCoWeHfzb9uXxOkjLFcHE7341lBdfxjSA+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31696002)(86362001)(31686004)(66946007)(8936002)(66476007)(5660300002)(8676002)(4326008)(6486002)(6506007)(478600001)(2906002)(6512007)(2616005)(38100700002)(83380400001)(66556008)(26005)(36756003)(316002)(110136005)(6666004)(53546011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2V3UFVKbk5ScUc3VUNxWlVLRWxCc3Q2cE1VRDd2T1JJb1JWZ3Y5Y00zWFVM?=
 =?utf-8?B?QklpK1lHWTUyamtlUW0zdVBFcGlSRkQxWEtyTWhXeldhUXlwZTEzYnFDckYz?=
 =?utf-8?B?eFVNZS9tM1NLdVJCSWdiSFczdkZGYTJSWk5JNmJkbk51MS9JbjNVMEd6TkVo?=
 =?utf-8?B?a21yaEJITHBZajEyNE12b0R6d3F0NW01RlkyY0hiS3FIZnVXWDZrTTNYTmUr?=
 =?utf-8?B?S1kzVGRkZXpaeWFHT2RkRXZrYTF1anJXNkVCR0lPMnkxV2pwNGU4WmtHWkd1?=
 =?utf-8?B?TkIxL2Z2b3hnUGgyRTFrQ0tJVVZKS1Z1dkkyMHMzS3E3QVg5T3NlT29vUlpJ?=
 =?utf-8?B?YkJXRjB5UHd6RWdNL2FjcWNJS0tHaFVONkNFb3pKVVp4bXdUb1RUM1YxQVBT?=
 =?utf-8?B?bDhEZG5JeW5oUkZGUzVYcWc1amNuVFJFOHNzS3VvWW5vTVVRdXpxMFJlaC81?=
 =?utf-8?B?eVdZbmtWb0NZS1RoZ0NwSFIxa1VlY3ZxakNVU01ENys2a3NNakxpWmx4Qmkx?=
 =?utf-8?B?QkxUZVh1dHBIY0tSWXlRYmVUNm4xQ0RaL0Z5ZzVqUVVNeTlWVENZMWhwWXRP?=
 =?utf-8?B?bG1oNEFRVWN0ZTV5UFRuL3ZPWXkyYldEUHoxRmFnclNzU3JzdTBOUUZoNUE1?=
 =?utf-8?B?VGRxUHVibDFRbXpmNjRlMXlyWjlpdEdzRWhVVzluT0k2TWxRYzBGMktPVG5J?=
 =?utf-8?B?ZThLdG11NEk4SEFFZWZBN1l5bEdVSHprM2JHTXRGL0hYdjI2bHdEZGhNNXp1?=
 =?utf-8?B?dlR5SElHV2FRNHl2M2lhbEoyTG1OK2RjZnU3S2Zlbit1M1lidm5SbEZ2VXZR?=
 =?utf-8?B?eERoamFJUUdBckNWSElxeVp1KzNOTjA0WnVMTTV1SmFYQ1ViODNvSWdGZUZy?=
 =?utf-8?B?N0dmMG10eU5kN3E1bEtiQkxWT2l5Q1F1K3dmYzVlc05MQTkwcUFzR3U0eDBz?=
 =?utf-8?B?Q01RcEZLMXVqMW5zc1ZtNCtOSG56a0tWS0oxU29DN1VzcmxJVFlKc1FBQU1t?=
 =?utf-8?B?V2JVUi9BSUNjSXpucTlvMnU3ZWJYTVRJL0VVUWdYSTFYWDE5MGJranUyNlRn?=
 =?utf-8?B?VGhqUUF5dnBQdnNsam9TNTc5cmEzRWwwWTdGUnFQS3VsSjZESVYreWQvbHBi?=
 =?utf-8?B?ckpzSzFLMVFIL0lJVzl3NGJxSXRSRzhXbXZvdU5DYlZEOHZiL09jZVRLanUy?=
 =?utf-8?B?YUZrSUNhcXRhbVlhUnhRTUowazBKeXpnd3JHY2pZQTNBVTNvYnNUSm9Lb216?=
 =?utf-8?B?T25WM28vNndjemJsanY3a1RjekxRcEg3MzlKdlhqUDlhR2dhU0Vuay9mRGlJ?=
 =?utf-8?B?djMwbUNVYlFrRkNscnhmdnhpQnNKQnpBRjcwUlJFYzd4aXRZQjZiQjI5Q05z?=
 =?utf-8?B?cjBlVEFaYW5XY05TY0U0WWpMS2JtbzVHb0dKZDdLT0NMcS9YUjlveG5mcVIv?=
 =?utf-8?B?RHkwU0FmalZ4S2FaVk1CTFJFK0VHckJjME5RTVpXVmhUaExzNng0eE1mRy96?=
 =?utf-8?B?RXVkNFZiYWlETnhWYWxGa3ZoWHFTV0djUXQvYlZqRTFYMGtQZHpQSnRTNncz?=
 =?utf-8?B?ZXNtWnZ4ZTExS1BOTmZvbnBzVkgzdzU3Q0V2Q2dUUHltWWJ2bkZ2dW0xdTZ2?=
 =?utf-8?B?WFpTWXVxN2p5dHFST2V3bGhlRi8wUitJcklBaGNpVndER3dGZEZYUThERHNk?=
 =?utf-8?B?OWsxS1hqMUpHMGw1MmZ5dzRTVHQ3WGZRZGp6TjNsekFxeWgyS3ExMVYyZHpS?=
 =?utf-8?B?N1FrMkhpK0RtV3dKQk9id1Q2WTNCZk9WV1JIN0lEbkFjSnNsWjNQVGRlK21o?=
 =?utf-8?B?Z3hrTThtazNQUUMvOTRZejhFVFVZRFRjRDFqTGUyL1lBdXNHV0owYVZOUXJ3?=
 =?utf-8?B?a1B4SE45N04yTWQ0MWZrODhDYmlRNmhhUXh0SnM2ZGV5dCt1ajkxTElNMnJi?=
 =?utf-8?B?cm1RY3VWejN0ZURrSmNPWVZlVlIvMWVmb1UzcXJjZk51Umk4N1FzNTRhMXhB?=
 =?utf-8?B?SDRaWVhJVmkrWlV2Wi9LR2tPa2RhUU5scXFBQjBpN2ZTM2dwL1hXVjJ1U1NH?=
 =?utf-8?B?cHBxNytJWUlSMS81Tm5Cd0tMR0Q1WUlrVnZkcWVGVFloVXVMWVFMUXh0NC9B?=
 =?utf-8?Q?vqkmkss9SutRVDatAGN6Lxz5N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a04d96-f78b-4648-9710-08dc2e60ce5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:00:50.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo/tkeHjLa6d9LL0nQCDrt50wPGnXBGUw74n2v77pY9ItjVnuOdTww9/QCQ7HB66/+xH1SymNvwN6BY3Q+At2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238



On 2/15/2024 1:15 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 05:27:30PM -0800, Jakub Kicinski wrote:
>> Hi Greg!
>>
>> Would you be able to give us your "no" vs "whatever" on the license
>> shenanigans below? First time I'm spotting this sort of a thing,
>> although it looks like we already have copies of this exact text
>> in the tree :(
> 
> Ugh, that's a mess:
> 
>>
>> On Wed, 14 Feb 2024 21:18:40 +0530 Raju Rangoju wrote:
>>> + * AMD 10Gb Ethernet driver
> 
> First off, checkpatch should have complained about no SPDX line on this
> file, so that's a big NACK from me for this patch to start with.  Just
> don't do that.
> 
> second, this whole thing can be distilled down to a single "GPLv2-only"
> spdx line.  Don't create special, custom, licenses like "modified BSD"
> if you expect a file to be able to be merged into the kernel tree,
> that's not ok.
> 
> AMD developers, please work with your lawyers to clean this all up, and
> remove ALL of that boilerplate license text, all you need is one simple
> SPDX line that describes the license.
>

Hi Greg,

Thanks for your inputs on this. We will work with our legal team to see 
if we can use GPLv2 instead of dual license.

Thanks,
Raju

> Also, I will push back hard and say "no dual license files, UNLESS you
> have a lawyer sign-off on the patch" as the issues involved in doing
> that are non-trivial, and require work on the legal side of your company
> to ensure that they work properly.  That is work your lawyer is signing
> up to do, so they need to be responsible for it.
> 
> thanks,
> 
> greg k-h

