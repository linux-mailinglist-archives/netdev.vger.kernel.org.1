Return-Path: <netdev+bounces-67702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A235844A29
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B429428C8AF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18039875;
	Wed, 31 Jan 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvjx5jrI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CF39876
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737061; cv=fail; b=ewQR4qhDB9gd57ygX+owZFoeFgl6g8ZtVJkl30THKS8lL3Dxt9zuahu2obD31f7w55Nj4PjbBPipEtIMMJtdSXH1EhEEXCcrKzUN3Wsj/WaGCjyt+snfH1yCQYdR86BxGbQ8n2TTjA3jyyN7dujdC43f40Tj0uKzFDJQf0rMOco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737061; c=relaxed/simple;
	bh=GL5JG8wlze+xa/vWsnOYMkRfe8hnqd3JXN8un7y9pEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlPGVJEyZ8Wk8TFGUe/rn77pNITdkkiab9ZVTKKkzqsj3wk6mOIFoRznmB1VGCczB+azpPvkhBaoudLkQ+McYd95OBz+v2vhtf1hHOcCNfhowBwlYrmLJoPvCxo5zB1Beqe0+56JP0aR8Tf730B/QJ+OzALVzJ6fCo1aHFHZTVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvjx5jrI; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EExkhYro7+0Vi/mwFt6IdHUim+3L70kjvUkAHH55MVIbbMZ6PrnCInGQHCkC/eFJK+5jDrwswvefaTe+XDN2/migO4qpBFyLZzdlO4z/XCngyNHKJmV++Mq21jrJXdeUGUp0jmDlYyXabTaMCbFkzB9HU4DlyErbGwpu9RzYI5DKNJ+nZ+mvK2qzh0nFmA15+e3RKmgem6bkE+H8KZg1VfJPYkUiY7JS6eKzuCPWYzemfDTBUvw3pGdGoVTC6TidMVUvzNHCAfY/0atYVeaAnYzdJrDpHnaOttTLsSv37fVD0HcExpKRKjN0i9tXTYgpcJ7BuJmcklVMUaXxb39kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL5JG8wlze+xa/vWsnOYMkRfe8hnqd3JXN8un7y9pEk=;
 b=AojTNKtAxcusSjVtGa+k64NBTgmfBg8xh841EVnwj52adNynQx8q7uxa/vztBixYm1MemobacqxEzSWKXUqiNhTYBxJjske0TGGmbxI7LM7OC9vxaxHghvrxxNSiQNifwRuRbqkM2SBU1JaNlqZNKFhVn/2V4wdo2maXUXRLNEE2zp8jCROFfNSIqRaeIk2NgYnrtH5Sh7i+VkOjKSHaEMvhqpyyqs+313FfK2chg/lzd7TGEw+ylqvhFK8+h09CWd6pQsyrlSm0ZTvHEdzfEKeO1kIR7KdSfoLRJfkkfBtBPXpsQfYTNEMcFhW0JvULa+C4+HJCziWsckYh3EZS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL5JG8wlze+xa/vWsnOYMkRfe8hnqd3JXN8un7y9pEk=;
 b=mvjx5jrIbbPjqaO815ntzMuQI8wtBBBZDlEi1raCFCLPzkzEaJIRL5OvDqQPsICVyw3Fh+uoP5uXw1rBCbt1IUAQs17Kh3f2ftLUq8Cg7hBIRpJtAKseca6ZVrxL5q/aKEaeA83abvyRTBjudY5aPdsgkFYsCbgBHPSu5RNs4cXldFkVY+5qwiunh+QC33QD8Kj2JSK1wx7KzKUPFvTNsUZY8nyNwI50gnqpulXHSo+si4Ey/NHp0oVT7/NLATk6QOCBnUTzQsStduW9d3xWbU+kJgqNWFzsgxSWudTZ9ZItEUdM8fHZ4tXkyXHgk2Znuo4t7FmYQ46sVoatonbJcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 21:37:36 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 21:37:35 +0000
Message-ID: <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
Date: Wed, 31 Jan 2024 13:37:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240131124545.2616bdb6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:302:1::22) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 06047334-4b27-4337-6c79-08dc22a4d6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XdCcTbW548xtGYHphqeV0QchaCsZMM7Bg7MkoPgQEAyUFci6QWay2pAXdiv9IsRC4G1+2cyd5QiaiK48Hxd5nbIIwmD8fUBvYTCmdFKPOVnDKWNPixWl+PXNoBLaL96eePclL7bUgg7knOP78uJaCl8jkLoP9YY8rpTlBfW+gHlFZC+7zI0ERoN7BDK6XPSoc0IC4K0Vc6UdsbYf/XDMl0Tl4Bef7MY+lemjMLZjeFTGBwGKmuUgbn0FWnEV+niD23wot9zuso/D8IIx2K/uOP9HHCq2ohUOoDgRp17p3IuhTunDOopxkxqZJQyLuvcQIiZTaVjO3dXT/pHJOgybi1bOQ3MmAk3LtWUh4Zw7VPEIJwWHFd1sAxNyHAALEgulE9aviVkWIspW92GbuTjVpaYy/a6TTYHK1pRgpWdKswBoGowcMXZ8CfUihANI1JOclTmPlQ8Kro3b+ANNaTI3I7ACMg4Xw/S8F8fJUlgnduCob3rRXVMQjVdEFHIOxIcG1jbU7gQq9jsiJsyO6hZMUcQY/CdMEwO4634zOO5hOvH1D0ZuyIaNVi4pDUMZFEc0x72F7YkWhM8IiBkQuB4r8fxZ4Hgo2QEmH/c0JVcG8L5DhRS5v1Kf+grrUSBCjoB/gGF5G5o6ht/7lYybaR4WQjyfVjwsxSPXdhqvdSxq5LC13yMD7OKfo4tGRyypROLfbYhm9/kMxw0LjuZUZoArTUH+MBIAmZRqF9Z4/YLUl90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(86362001)(31696002)(36756003)(38100700002)(6506007)(2616005)(26005)(6512007)(966005)(6486002)(66946007)(6916009)(316002)(54906003)(53546011)(66556008)(66476007)(478600001)(5660300002)(8936002)(8676002)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUtmaUlJbGpzcHdGazZBVHEzS1BYSmFZSk14RVVJbmpmNk15eDhZSnFxNU9r?=
 =?utf-8?B?a3pkbmt6ZVRqZ2kwZjY1VnFmMXVBZlFmbmFEazBkeW9acU1Lam81b2NZMmdy?=
 =?utf-8?B?Z0VBYktjVlZQYm56VW1TMDQvdG9maTdkSUJKa2ZuZ1g2aDh0bzJ5Y1FobDhl?=
 =?utf-8?B?N205R25uQnBUMjVweFN3QTZLLzlrUG5OZlFIdCtYVFZqSnNsa3NZRUsvRHJn?=
 =?utf-8?B?ODZZajM0dmw4ckx2VnE1V0RaOWlhdWhpZUlKM0Jia2daRmdXNWQ3TERJNVdn?=
 =?utf-8?B?c3NwTmhmdDVZUnNHN1JCaUhEMFlxSy9Ga2pOU1p6UlJmc2YvTW5uOTVWbzRO?=
 =?utf-8?B?VHVHaU5zV0dHam9RWjFmWUtmdStpZHZZUG50c3h3VDdvc0tYNlcrTklHTWlo?=
 =?utf-8?B?a2JZMHFmbDIyMEZqbndyYWk1czhpaUNGb2p1VFdnN0oyMCtuZ21TYkZzRWtG?=
 =?utf-8?B?NmJpRHdMazBtTUdBMmNlKzNZVVo0RGJUQ1FoV0FleUlURkVQSGg5VDRXNkhh?=
 =?utf-8?B?R3pDVExvZ0N5Lzl1N3hvUU5BY1JKa2M0cEtNMEc0VHN1Sy9ZbFRjcWlXNDRx?=
 =?utf-8?B?bVpUZmtGbG5SNkk4c0NENEpZVHBncHMvd0lxRi9NWjV3MFVISmdzbDNkb0Iw?=
 =?utf-8?B?dUZudE5oZXVCcS83c21QREl4VDNkNjczdjFFbXN5cjR6UTJBUGk2UTk2USt4?=
 =?utf-8?B?QlJaWW12YWIzWkpwVXh0SGM1a3FHekNuSzNQUVhiN1l2TjhSaDBCZ28yV3Vu?=
 =?utf-8?B?d2NWOU1WcjFOck0rWmRrUit2b1NpcWNoWTdNMjBPUVU0TnBSUDFlbGhSSmxa?=
 =?utf-8?B?bmxDd0JyNmliQkw2b0NpZlFiSzFmZzVpaVRwMmxaeU1Zc2VpSEdrdEJvUzZI?=
 =?utf-8?B?VmlvTjVoeWZQaklGMUVpUkhNYjZWTDVLU1h1REdyRDgyY1BqRHJlK0VnaHJD?=
 =?utf-8?B?UEpIZmdDdEluRFE4Z3VJYm8vbDJtM2src3RMVXVHQW8vbWE3SmpITURNWjlU?=
 =?utf-8?B?bjFkazFLcVgzVytVSytZWDhqa09oajZzSkhpNDI0N29vek5DV1ptcFU2RFpo?=
 =?utf-8?B?VFVyQ3IwOGN6T3EraVppZnBZcmVicTl0R1Bya2VKc3hXYmZLZ3JQMEQrSm8y?=
 =?utf-8?B?bnpNT09zUXhxazA4VVdoNXVMc1poZFhCREU0UzhkY0s5MjM4UUI4eUxOUzBP?=
 =?utf-8?B?MjFiakNYTzlhcUZSL3BSUWxuL045bDBKMkp5NFh2N3dtTTFERVhLYW5Obk1N?=
 =?utf-8?B?TkRteHRyWUZqV1RtT2FSTGFGNDJ2Umh6MkVyeDFtNnE5UE1JNFlJY2NZSGZM?=
 =?utf-8?B?YXlsMjd3YVhGYzlwenNNTzB3RHgwUmJOdWVtNjRwYmRNbDJVNkJsYjVkRHBo?=
 =?utf-8?B?WFZsdEkzMmtUTFpiYzZJRUZRMS9sc05ZQzdPbDkyV3JybHFDeTBxVjB0SFZZ?=
 =?utf-8?B?ZUt6VXhOaEdsT1BjNzNnUWpreUdreE9QbngwSTJYR0pCZjVhcTFkVkM2ZUVH?=
 =?utf-8?B?YTFBY3hrWjFia1hPaHFtTG5QMDdqM01BTklURjdmZkoyMG1wa3BTdkhuaEs4?=
 =?utf-8?B?U2lZSDBqcU94Ni9zM2hpZHl4RUpaN1M3V3VKcFBpNkVlOS82c0htUWsxNTl2?=
 =?utf-8?B?bXM2NnJ1ekVKK1lYMkUrY1IyNVA2cnlPZ3Y4KzVHMnZPa2RZcjFHZjZSNFlB?=
 =?utf-8?B?a3FKalNXNHdsTThqVXkrZStwK1VoaHFLczVaR2cwQnN1K0JFRlJkQ0dDVGRS?=
 =?utf-8?B?Skd2Y3UxbHp0TnVJYWNzQUJhMXpxRWFIYXFqc3FIem51eGJTSWdSMnFHSW1M?=
 =?utf-8?B?Yi9ZRkF0ZHlvNGFaR0JNSk1QRUdmNG5paFpZRXFwcUsyV0M1R1RDbG9TdUpl?=
 =?utf-8?B?RmE1S1JwWUErV0RWaldHOUJEUUNPSzlOOEkxZmcxRWNhei9WQUVJcHJ0VGFB?=
 =?utf-8?B?M2RmV3pHZ09VemNrR2pZMTdrRlVpZTVOa2xUTmMwcDFtbDN6aHBZWjlFK0hN?=
 =?utf-8?B?cTViWFBCYWd3WWlpcWdvdVl4U0ZySm1tYnJIaGdRUjRKd0FsNWVFeDc0ZURQ?=
 =?utf-8?B?NW1iajlQamJETlNSWmJsTGh2TnNaTG0rMThVaDNLZW4xWEYwbTZwZFh3b0Zx?=
 =?utf-8?Q?/ijUsUTT1brLl3KnDuOy14+k7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06047334-4b27-4337-6c79-08dc22a4d6f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:37:35.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJf8ns8wCIIrVgpMJkUzq8vMbkxhB0IhxZIB6ckBQxcPOSJneujACOobomREf2Qc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694


On 1/31/24 12:45 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 31 Jan 2024 11:16:58 -0800 William Tu wrote:
>> On 1/31/24 11:06 AM, Jakub Kicinski wrote:
>>>> Thanks for taking a look. Yes, for our use case we only need this API.
>>> I'm not sure how to interpret that, I think you answered a different
>>> question :) To avoid any misunderstandings here - let me rephrase a
>>> bit: are you only going to use this API to configure representors?
>>> Is any other netdev functionality going to use shared pools (i.e. other
>>> than RDMA)?
>> oh, now I understand your question.
>>
>> Yes, this API is only to configure representors in switchdev mode.
>>
>> No other netdev functionality will use this API.
> Hm, interesting. I was asking because I recently heard some academic
> talk where the guy mentioned something along the lines of new nVidia
> NICs having this amazing feature of reusing free buffer pools while
> keeping completions separate. So I was worried this will scope creep
> from something we don't care about all that much (fallback traffic)
> to something we care about very much (e.g. container interfaces).
> Since you promise this is for representors only, it's a simpler
> conversation!

For the academic talk, is it this one?

https://www.usenix.org/conference/osdi23/presentation/pismenny

>
> Still, I feel like shared buffer pools / shared queues is how majority
> of drivers implement representors. Did you had a look around?

Yes, I look at Intel ICE driver, which also has representors. (Add to CC)

IIUC, it's still dedicated buffer for each reps, so this new API might help.

William


