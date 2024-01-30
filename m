Return-Path: <netdev+bounces-67343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC12842E7A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D3BB2277D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147F762E7;
	Tue, 30 Jan 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4k4O7Ri"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445855E63
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648872; cv=fail; b=O6ezKlNUxRoUJkwFAh5nZobozv99wrPIcqT5F5JYVTN3sVSgOkXgP20pY/FQRPaN0qKH5eVspDe1R4a1I+C84MW3Fjhq269nsiJ5/VCeoT4qskMwOIZRnLEaMl/965vGficYVCCP+xcw/jrmSR1aCnjcM53tBf0Cn2n4/qjtiuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648872; c=relaxed/simple;
	bh=KjMfSb0hIdd81S/AnjHCMgc47fn56RkrZcIkIN+S5bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTt8TrjQB6+iQ2oY8GRusacZjpX3hvKPdKWRrMNyfA1E6KSsEtwcd3sVgKGPGLba3hNmPSO5HvuYTU/rwbwTLOHc/i36VgqIqvdjt7ESoXAAIyCEN3m9oSQzjxPCjtEHl+zahA7+aCYrY6g9vvFB4XkwARd7NAq7r1g1eGeavgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4k4O7Ri; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAmOOqWBASNfwjblfch/9BKw5R6ykwVp1Qv/lthn7WcJsUEgNNtgGg3eTU3av9AKk/+Ep/18xSqYrahGzK2bw+UFtLCDk+ZbtxaB4eVolW0sLR/9LSJRsdVKxCl6m7S3BQHku2wNHomZrHI55YFBztEuDvmcY0YKvoeY4ypQ198+0ZNrWlv1lcJdxU2xa4LPBVo+gbPzTQUvc05j5upk0llGmnaSqxuDPKzZblHO+b/PaFmhM1CYxVpqtibPktu6QK4+oC+4gZkN4/BnSj3NDyA3lE7tpkLmLA3OWUMrHIijqMq/+LA9h5OxZDcCENszlgiaVqbGdqC/BPeiaSakEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDS44oD1aa7kYWRhA8FBnJqD9qlEsKspBajOkD1Ya7k=;
 b=CMfIjGF37K8A7KRcdpGgJqNVxJJglTDDOTOFmTQgTrJvab1+XSDzmG6zGxNvk1xw4gNjjYC+YWqq8hzo2xNnhPsZ2j1niFkbEV4v53xanm4iG+H9RzhEvT4ks0VWnc71bVHewGgN98f4gd9z8PmH0xMcobUSywpBl0YegWHpDEIVyuOc3dlwNT0XI+w7Ac3heHSCxzbJmkZyAHLU3gKqens5IM4nMmIl9kfhXjPL9TDmUOeDUtb3KSf/5Xm2tJ0l3m2hYkvy7WIVQ8x9KF3c3P6ywdet5Dwp1QHqLeSleNTJTT08EtSDAP1HGQwHrZ/PUbtxn/ih1p62V8hNBP/sYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDS44oD1aa7kYWRhA8FBnJqD9qlEsKspBajOkD1Ya7k=;
 b=k4k4O7Rit/blo7TmzUW0BVghedmWkX+gnSvJWA9Z1l2zGVqNzYnHgID3/sDzxNbRf0h8Fjn3UJD40+pvb7aubksMGqFx+M10VtPEalwHt/ZKQ+s47Q0wImz9Zv7ZGDjWJFPHBpSQkVaSsH517XrWOeRi52hN8UZDsqGGj8gkQ+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 21:07:47 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 21:07:47 +0000
Message-ID: <7442ef9d-a2aa-4ef9-b51a-02c4ca7ab36a@amd.com>
Date: Tue, 30 Jan 2024 13:07:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 00/11] ENA driver changes
To: "Arinzon, David" <darinzon@amazon.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Koler, Nati" <nkolder@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
 <8ff8cd4e-294c-4b1f-8e83-c092132a2445@amd.com>
 <fab02eb3391341b3b63c5abf9ff74f47@amazon.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <fab02eb3391341b3b63c5abf9ff74f47@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfa6406-2dd2-4470-36ea-08dc21d78271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RS0FIXKZbRPsZXG445Z1awdJUwlwjU4ofmSb3bYWanZXMqWIxoElTj9cSCOWfWHzua84wLimF6x6eVro1lv0bkDOWjipl+29k/FsvJJCC04ijDZNP+UkeiVzAqtcYgPb5nz6jQVt+QMBdVqMmUnEVd9TSN1cQY9Iemppklmp+d/dKhg2Ud2XFykFNU/jDn+4FhoGirISIYPkbgh0UaaEQ5sz+lXhdvNmKOkthrA3YyDm1hTHaMyklLKErahhvLCirFPvdI+grJRfvlOFC2soyn54TOgIBlwAGYaY+mRKh2jYHQGSMA+m8xQLeODSbYA7Kk1h8EVEPc/W9gEFwQKPCtMUS2c1ABHnork4/fduOAPMhK/iDrEMMDJb+kUqX4MZ8BJ/FMpOQCPYHtKha2xTGfYbAt7/Q9zBbgnAygMWTdS0VVSkUg7cLagQ2t2Ux+f7yGPR1N2N/XdhE29bOIV+iQrRj3QzkB64JBroGu11rvGdICCkY+aJPS7LTL5X/7CvTwVIWay5M401jVlvPElFBnEr/BUjV2toUbXeFg5LuZF4b6feDGqXSO2zYaCXUln1NW5ay3tGLwFpudS2msNqFdZC6S4bdIsjiBH+LRdq5mSFYjkvCc/jPhofGUhLYlAtH0PUIh9vtH16TbfdLtZaeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(41300700001)(36756003)(31696002)(86362001)(8936002)(478600001)(38100700002)(83380400001)(110136005)(4326008)(66946007)(316002)(54906003)(6486002)(66476007)(8676002)(7416002)(26005)(53546011)(6666004)(66556008)(5660300002)(6512007)(6506007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjdqa1lTaEV5QXVUaS9CbE54TDRqS3JhWCtCQ3orN1VlVnI2ckpvaHlFT2pB?=
 =?utf-8?B?OXB1WjE1SGNzOFdoY0JVblpYZUZ0SlQrb2Y2S3RSLzBES25FMTNMZVFlR2JL?=
 =?utf-8?B?ZzlyaUlVWmNrZVN5cU93d2dzOVdUbGNFWUVVTTk2TEZScDByNWs2L0w5cjRm?=
 =?utf-8?B?cUVyeVBBR0RncURqOU1QNHhzaW1oblFWcFdXT3ExcDE4OTVtM2pSS1QreWoz?=
 =?utf-8?B?RDFjRlRQZkM2Q0lHQmdmQ2xrWTlFMGQ4TjJlamlPZ2dtc1VOYjc1UWtNQXg3?=
 =?utf-8?B?ai9GYm5yWTdaR0lya2lJcmd3aTAyeEs4YkpIQnNrcmwwNjlVOHdnVk1yYlRK?=
 =?utf-8?B?MXJhS2l6SWwra00yc1o5YW82bzZCa3hkR0doR2djcFJJQTMyeUJyV3poaVVy?=
 =?utf-8?B?WU42V3lzZFhscTB2YlVHVDI0MTJXdHFJdHRIU2wxYmtIOXFaa2xXR2k5Skpa?=
 =?utf-8?B?a0FoOFBUVm1WaHp6WExvemdjcDQ1aHZvTHo3ZWtHSWFxcGtQM1QwSXpQYjM5?=
 =?utf-8?B?RDNpNGhzT01qOUEvMXpKZklDTTM0Y25MQ2R3Q3BOWFVTdDNJL2xxOG9tOFh3?=
 =?utf-8?B?cCtQWTdwZkthcXZWTHpwVXhLQmhvMFRZek0xc1BiRm53T0k5cU4vTEV0M1l4?=
 =?utf-8?B?R0ZKemlpS2tTSkN3ZTVTUlA0Skcxb0I1dUt2RFBUeDNMcG8zczgwRDNEUFA5?=
 =?utf-8?B?YWR5YVdDMEFCS3JKRDI3SndvWnFISlRNQjJZUVorZ2I2OUNCYTExSW5nRzBk?=
 =?utf-8?B?Sld5ZGtmSUwvbDJSc3laaUMzeFpVL3MxdGhMd09YaUgyRnc3VkY2RHpTOGEw?=
 =?utf-8?B?am9YZmhCd0Z5Y1lWcHFydElPeVZrZGd3VFlSQ2R4cHZUMzF6cGxQaU5CR3dx?=
 =?utf-8?B?clUxSGplZ2U5aFFyK25rM2xqY1ROdnl2cnNueGk4YmkrYUE5RlUwa1dCbEg4?=
 =?utf-8?B?SWU5dFRLemNTUG5jWTB3N0xYSndtR2xXanRqUzg0QThrRGVFbVlRV1lsWGVJ?=
 =?utf-8?B?eFdsVkxIVlhieUROTmtUcjhORkxHamZMT2tOYnpGcktreUJjZDI5TDRuNnh4?=
 =?utf-8?B?bDd4VUg2K1pUdXlQbFhTZ2ZVU0hHUWlvRWw3b0xYOHdYRTk0NUtibEUvdmF5?=
 =?utf-8?B?ZGxzcHhOaXlUZUx4b05NY3RpQkZlOWcyb3NOays4Ukd5UWpmUERkODk0dE5p?=
 =?utf-8?B?V1kzQTJOalE5ek04L1BrLzZTdzhDWStoZkdJbU05M1NvM1hYYWlHNGhlbmt4?=
 =?utf-8?B?WXNMNHpacFdlbGVjZVVTeW1OV1BwNUpYTjV0ZE5XR0JYQlR5Qk1wMGJXcUs2?=
 =?utf-8?B?S2VYeXVNZGNUckJRZEFBTnhsMkZ0anhEdWtyTkZzNlJVWnBxN2NSK05OL0lm?=
 =?utf-8?B?SWZhWk1mSDhPOHZ1eFhlUEJ3L1VsQzBNL3pHYWNPcWdxNTB3N2YwcjBkc2xW?=
 =?utf-8?B?M0llMFlRRGxEYnJQZVMraUVrRjZjYzEwQVZORWRHMU9tR2RBZ0dpMUZNRkFL?=
 =?utf-8?B?M1cvUnpKS2hJNHJFeVFGbzhYdVZML2N2VEd3cHY2K0s4VVFNb2psOUo2SWYx?=
 =?utf-8?B?ZlZaRXRtRys2Q0llTW5XVGFJUUtrRmVFMDhPYzZDbmdCeEk5MGFVcE4yZE5B?=
 =?utf-8?B?ZFRXcnZ1UTd4cXQ3MUlHVngrNUZGMGpNeUFEN2h0Q3dGdmhUNURIRmF6RkMr?=
 =?utf-8?B?MU5WMEYwRmVNS2srcjJMcVF0TkU0UzM5MnZNMmRwSWxOcGYxUkc1bnY5Qk8v?=
 =?utf-8?B?RHVwY1BiZGc1aDJRYzBKelFDU01YUURIZTRkVkpjSnozZFBjMlFkRlpvTUNu?=
 =?utf-8?B?bVlKOXptYTlNMENQZ0gvT3U2Y3p2Q1dib0hNR1Q3OTgraFhNWmVXUVRZUFQ1?=
 =?utf-8?B?K1NtU1pJYkthSHJCcGE2bVBEV2pZTlJRQXBBdldyR0NBUURzcnNWbVZsVGE2?=
 =?utf-8?B?RlVONkREZnkva2RZV1pENzhmRnkzVDBURjBKQ3NqS2FKS0h3dWswRGVsSEpk?=
 =?utf-8?B?alV1SURCbFV3a0JhK2ZYUkEzVGJwT2RPWVNRMk9GWEthOEt2WWY4Q05HUWN0?=
 =?utf-8?B?S1BTNC9VYXJxS2poV3pvYzg2U1lHcXVRYjFBZUZFMmN6aDl1Ynlkb0xzUnBa?=
 =?utf-8?Q?x5Y0XxFaaekWX1LTH3gM/i1rH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfa6406-2dd2-4470-36ea-08dc21d78271
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 21:07:47.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md9MuUN6S8vnueRTy6xkYe6C0DiQzn8ITk4b+xUSjKZlkolK6yuq4PBnmuszoEaShi0Z3BuTD5Ylv0pVDg6pdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376

On 1/30/2024 1:39 AM, Arinzon, David wrote:
> 
>> On 1/29/2024 12:55 AM, darinzon@amazon.com wrote:
>>>
>>> From: David Arinzon <darinzon@amazon.com>
>>>
>>> This patchset contains a set of minor and cosmetic changes to the ENA
>>> driver.
>>
>> A couple of nits noted, but otherwise looks reasonable.
>>
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>
>>
> 
> Thanks for taking the time and reviewing the patchset.
> I've addressed some of the comments, while the rest will
> be fixed in the next patchset version.

Yep, I'm fine with your notes.

Cheers,
sln

> 
> David
> 
>>>
>>> David Arinzon (11):
>>>     net: ena: Remove an unused field
>>>     net: ena: Add more documentation for RX copybreak
>>>     net: ena: Minor cosmetic changes
>>>     net: ena: Enable DIM by default
>>>     net: ena: Remove CQ tail pointer update
>>>     net: ena: Change error print during ena_device_init()
>>>     net: ena: Add more information on TX timeouts
>>>     net: ena: Relocate skb_tx_timestamp() to improve time stamping
>>>       accuracy
>>>     net: ena: Change default print level for netif_ prints
>>>     net: ena: handle ena_calc_io_queue_size() possible errors
>>>     net: ena: Reduce lines with longer column width boundary
>>>
>>>    .../device_drivers/ethernet/amazon/ena.rst    |   6 +
>>>    drivers/net/ethernet/amazon/ena/ena_com.c     | 323 ++++++------------
>>>    drivers/net/ethernet/amazon/ena/ena_com.h     |   6 +-
>>>    drivers/net/ethernet/amazon/ena/ena_eth_com.c |  49 ++-
>>>    drivers/net/ethernet/amazon/ena/ena_eth_com.h |  39 +--
>>>    drivers/net/ethernet/amazon/ena/ena_netdev.c  | 161 ++++++---
>>>    .../net/ethernet/amazon/ena/ena_regs_defs.h   |   1 +
>>>    drivers/net/ethernet/amazon/ena/ena_xdp.c     |   1 -
>>>    8 files changed, 258 insertions(+), 328 deletions(-)
>>>
>>> --
>>> 2.40.1
>>>
>>>
> 

