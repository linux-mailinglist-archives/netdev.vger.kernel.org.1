Return-Path: <netdev+bounces-70691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2E8500C8
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944751C24491
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A736AF6;
	Fri,  9 Feb 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rEyd/9Rs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664472134B
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521633; cv=fail; b=Y6q12OtuIxCHeVF2V5jryfedOsDrudUlZPxkJUVsUNHzev7bwV5BxJqa9ZKb6k1QQg7nnFL6ipCQ7hHLSEVJ/Hw7kImbCCox4bDbCzpqC+UNLWRwDFTQHFGwVGHd8U00eWEJLQLHf5b6d0XPtagGGDwJA2oiYbvY5l0rxpRMQFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521633; c=relaxed/simple;
	bh=T+5BV6JzyqSdJCkAkRgD9ezNMrO/0yX4buKN/7ZcKZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=awEUlyY6SS2wL41UMaLdnAn//mmPLmxIRj+TruUq4S7UG+y6moHfvg+82R53mpyuwI2g1Se+dDlvoGdz4lgfwz+X8/nXJYuUQCeTLfM4mA9Pa2ywJLJb43mgZm2SM1as0ofRrPK6BG3lcE9PPvL0gLSOMOLO8VIIsPGzh+9wAbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rEyd/9Rs; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBTqpwPJ9/gGSDf6ESxa33TfxHfeNy9gbYiVgvkIE9X/FWKo5nGoOUE5KsoxGTmlfgrJi3EdJ7947EoDQd0/5RO+uQs3EgDuqRBuEpuFQc/YSDyZUTXH5Sao15qTEIldS6pMfqoIhvF8YfkWPb7JjvtPNkGjXA3ZHcNqQbzqylGKRv5jWS6DPuGhNbMhk2hcRVu6DazREepjwWGu45SHrOPDXQnBULobLygv3VDDZY2wGywtAuFLf1sDmFJSV2Roi7NcXVO+MVT+zthJM+7SErvmKXKl6zTrODA7sht7mtCBmZu1AtxTLtbIDJmFq3wGL40KwqeTv0xI3E+GR+iUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3rq8Aal54MmvwDv6CWpwXfUR/MymSE2xaWAgRwv6DE=;
 b=lUU07+UZUR8+5wIH0kRaXkCO246r+tWjho5GI6UrEWbQROjxr4V1UBgKM1QpiO6cnxOLoZ11+ydZfn/qjgDMWTqfR8j7COEH7G8n6Aw15s4lixp6JLzLVaGm4m3tb0j7u7Csznvlt/SefmsRYOjEKXsB0SeZaWR79/zvUjmrrPeMHRrvISXRT2IawiVG4lXnJdk7TlxZguyDzgQwa6FYCCpp+djwzEaThHW5/NUpOvtI8rXHZVeCl5Xv/DA6hU/YJ7B2JQgWiRDYx9NUj/u1GDr1uTvynuSk5HE66F2KzIlw80sraqCAWdw0QFUjPblOk1rKjlDVF6oiOqUChhhyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3rq8Aal54MmvwDv6CWpwXfUR/MymSE2xaWAgRwv6DE=;
 b=rEyd/9Rs+kgi7Y6p+6USS96/fESeG57pSA+/ziv5lhizBtrX4i+0MpOsndV318/WZxXaZWGxESp6JbzKST6hwJh5NmQ6e2Enl2qVGtMUtKojS4yJu9G6LMH2TkvEtej+/RKXk/eO20xcsT/lNSROR0HMCy9pJIlabLfjvXFTkiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 23:33:48 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7270.015; Fri, 9 Feb 2024
 23:33:48 +0000
Message-ID: <74e32f18-d0ee-4f55-99a5-5d47f1017a24@amd.com>
Date: Fri, 9 Feb 2024 15:33:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 01/10] ionic: minimal work with 0 budget
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240208005725.65134-1-shannon.nelson@amd.com>
 <20240208005725.65134-2-shannon.nelson@amd.com>
 <20240209140935.4230d626@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240209140935.4230d626@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:510:f::34) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: a6aeb43d-a9f6-4f89-57e6-08dc29c790be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MUCyWFklpAtF0R3kvpB7qwo7vT8IofyrQz35du5G7iINVQO0olOSov2GlWctle30asiUdYRplXxvY52zS39HQw9C3beNesyYwJtjjbRiJOsIO47JE7Qbx/k4dQMuHLkUj9fIdW3UFqZLZ8RZhON6YQn05N4/4Bg979n27hun3jgdrpwtof41AReIdwnHcikTQn/UFnIMgyYRadnKXQuj9IPt/+Kga1B6QFHQxvvQV9l6SRURpxciFlwQx8ImItRnxwUt0oXlqbR4hmE8RXewq7J+vaKYMb6XF54I3oDC7GtaZAnjU0IC4+Zc3+eUXBLb0kQrWUKGOHMz5c3tCpdflfH78rxzKujDwMTVamUclXeG+o0leORViBp+cTqaQg5xQ8X1GG3rqog6L2TnzwZSTPF7vcMNZk81nLbMzg9hXsU5G1AHPGO0xhkZ0+XbllKYlYzzLsYfybjayRAaonVkM58EfnoF7lbVYy7j0EHcGo/16L4bgukR3TnQKWxvW9vLWPHJMWBmGXZKkyWkHaU6blnGrsP9mywq5zjqgleEWwn/VBKL89eH4+4xAbxNFWAL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(8936002)(2906002)(4326008)(8676002)(66476007)(6916009)(316002)(66556008)(66946007)(31686004)(4744005)(6486002)(478600001)(6506007)(86362001)(26005)(2616005)(6512007)(53546011)(6666004)(38100700002)(41300700001)(36756003)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29TMk5Vbm5tQWN6ajFDeGtic2h6RWUzamk3SzdPaUpuZmdDdmxQU3B3dU5m?=
 =?utf-8?B?Rk1WZE1tR24vbE1jREJjcmlEWHYrQUdTOXZOdlVnKzhuSDNTTjlpeFJwK3dU?=
 =?utf-8?B?eW9maWJuVDdhSmFySnVBUldTZ3UxS0JtZ3dVRU9jQXRQVHB0SGtSR3Q1b3l2?=
 =?utf-8?B?a3VJZE1YNGtPVVoxbDhad01HK0VzQ290R2F6TGdEdkJ4UlEvYW1VOTlLY2tu?=
 =?utf-8?B?VzRzL2x3dVNHNEEyQVVQWVdiSzR6d3JHNEFvOGpJYlhhK2JrWjQ5Sk5LbUYw?=
 =?utf-8?B?cmptclNvYzN1cm5qUUNXM1Z4L3J0SExZS21ydFdHSzJZZkJLTGZrN3QyRWNY?=
 =?utf-8?B?dnNLUEFoem5PVU01TjNYa0NRSlhUR0REQnlGeTZnd2s2SGZwVWtuNHJtdTNp?=
 =?utf-8?B?N0ZzMWk1VHh6ejYrRkRlQVVyN1A3Ymt3V0JxS1ZUVmZ3ZTIrMGRnNHFid3ho?=
 =?utf-8?B?dW0zTE51RUlJMnh2Nm9UK0dSQVZRNGs1akZzbm5OVGZTQitNQUhTZ0wvZjMr?=
 =?utf-8?B?eUt1OFpzUEFnMkRnOFZ1dnRKaWlxRDNuVGdKZit1NGtnNVpUQkJ0YVZzbWJM?=
 =?utf-8?B?bzFTekM1bmVYUmhpSDVFd3QvRmdDL0xSOFVPcDNIcHQ2WWtZd3QzWUU4YTJu?=
 =?utf-8?B?aE5zMSt5L3NTcnZyVTMrN08reHFWTlkySFg2RllVZzhjaTY5YkdabFVwL2hS?=
 =?utf-8?B?aExRdU01N2w1Y2w5MWZvM1ZSNjFIdE1TNHJ4V1oveHRraGIxZUk0am9acmxP?=
 =?utf-8?B?TlpIRjZaZkFTTHFNWjZ3NDcwRkFPZ0hZcktMMnBsQmNLNHlhMWdoalVRWkdv?=
 =?utf-8?B?THJyczhMOEc5dXNwRGZTbEZPTEpmNG1JZHBSYjF4bzlHSSthbVZyNW1yOGNU?=
 =?utf-8?B?UENUUzNpaW9ZZDhPd2lOSU9uUXZNa0NRclBwek55dFNiRHFJYlg1VGIvK0VJ?=
 =?utf-8?B?dkIrVVhMK3dSdlczZU9GYWJ3NWdWbGJ0Mk5ZamJVeUZQL2dxZTJhVjFOdG5j?=
 =?utf-8?B?RWZOODI0TzIwTktwelhPbnBXelRZc1pERXhmemtxTWlSQmVrbHdXN1lQSXdF?=
 =?utf-8?B?cEc4aG11MHBrQ2tUbjFLQ1lHWStYZ3lmeEc3N0JHenRKUTlWTC9odktRc1gx?=
 =?utf-8?B?Rm54WVRURTFoYlJIZzA0cG9DNnNTb2pCWWNKTWZwZ29LekhVTDlaazArSzNp?=
 =?utf-8?B?bTF1Y2p1a1ZKc0JIY3A5M2ppMGt1ZThSb3dOWExCcFpvaE9VRkFaVWNwVDFP?=
 =?utf-8?B?Tk1FSkNSS3VYcW5VVlFaKzBySUs3Y2U3R0JYWWdqeXBMd0xvQWRIekh5cjVO?=
 =?utf-8?B?cWpzaDNxMkVWZTFQWi9DNmhtdTBZRkFjdUdRM1A5eE1tRTdMZHdaTGV5L3Yy?=
 =?utf-8?B?QnZPVW9URHdZS3JTZHdFSW4wNmYzNG5tZlNzaWR3dkVjRTUvaDk2M2tFb3BJ?=
 =?utf-8?B?dDNSTU9Yelh0OStoN3VUQVU4K1YxemR2OU1xZjdiRjVpbk5BM3JkWWNMWHV3?=
 =?utf-8?B?TDRqRDRMcHZ2bDlzVXE2RFJ1VUU3Z0h6SVp2ZG85akZTR0NWY05zTDUrV2Vp?=
 =?utf-8?B?ZkVWZ2JTa01MRFJpVEF2b25xMXA4STY3eDljZlBGeFhLSmVjY0ZGSE1lK1k4?=
 =?utf-8?B?OUhKbHVlWFlDNjdwaURxOXkxQlR3Z0NoRjJ5L1RjWkIwVUZWZUludXdkSm9h?=
 =?utf-8?B?MmxXeUxiUnVKcXVhaTRhZ1RWN1pFSWFzZWUxaGpQQ05mOTNISWZqay9WOGZW?=
 =?utf-8?B?MmprSGs1dVZwSmVZL3ljaFZkS0dwWFdVeXI2RmE2SnRtdmFjSWZ4R1BNSkZj?=
 =?utf-8?B?dkk4dzhNelZ3R01TQi9tQ3MvWDBLUm1odEcrQnFKMDZaL0h6Z1h2TkFERTJK?=
 =?utf-8?B?WW96VjJSYTRtMllEMVdVQjdLQTcrbnhVdFBXbkVoME5WR1JTL01oTzJNNUs3?=
 =?utf-8?B?TEFub1RHNjNZY2Qxd2hIMnBJN05odXZ2QmFlM0Z2VWlBcVkwaUFIUHh3UC9Q?=
 =?utf-8?B?empwN0dIekNpYXZ2YjRoT2VYd2dSb0hTSWVid29uSnFEUTVqZm1UUEI1ZE5K?=
 =?utf-8?B?ZllaVk9YNW1vK2YyQjdZK3ZSYW9iWndVV1ByZzZYMUFnVENBWmlhMmQ1dVJo?=
 =?utf-8?Q?+PIouVDrSfGub6AU/3ql6FQKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aeb43d-a9f6-4f89-57e6-08dc29c790be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 23:33:48.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL7QqVUL9iIHMT8izwQvycsx3hIspYn0Unfj4V9CnmvCyMbLxBO2jOrTIlQLFiEOTvK0T/4studZwatHSydC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

On 2/9/2024 2:09 PM, Jakub Kicinski wrote:
> 
> On Wed, 7 Feb 2024 16:57:16 -0800 Shannon Nelson wrote:
>> We should be doing as little as possible besides freeing Tx
>> space when our napi routines are called with budget of 0, so
>> jump out before doing anything besides Tx cleaning.
>>
>> See commit afbed3f74830 ("net/mlx5e: do as little as possible in napi
>> poll when budget is 0") for more info.
> 
> Unfortunately to commit you quote proves that this is a real bug which
> can crash a non trivial number of machines if kernel printks meet an XDP
> workload :( This really should go to net.

Sure - I'll repackage that and send it back out.

sln

