Return-Path: <netdev+bounces-68567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB86847320
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9566283767
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC2145B2C;
	Fri,  2 Feb 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fs7bFUzk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3B145340
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887640; cv=fail; b=GdVdLIF6yn9AvP16TN9odwBfRuMtrq7ODCn6c5GJ7R/yv97uQQF/XaiBx7C9cMkqhtvreVQBM4uj6HYS1DJviYHmXZkzCbu3y1yY6X+iNu0YIGmZ30FlgquP2OphNVr0aPFwkYrabTxca/vGN9U9AcBwNKTU9xedYFpNWc/EqTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887640; c=relaxed/simple;
	bh=PtHNiYm78lt1wqWxeN7XNt1/GupQCcfA0D9ieRkdgYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHDUmrf/TGwp4/IEBer/mGMUX3xDX/D2aWRdpapC7UShB0gmPNvM8AvUWyzEH59mq2n5rbQaDUmxC5tdDHlWesgR0ORqvP3cUVQwPS7SNITl2S5eovOFlJXucB1HKaIMMVN+a7ZL1M+RDsHY070ImPacjrerRrl8Ft65Y/n1pvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fs7bFUzk; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1dnS+bN002qcsgKEpxUvu0XkazZXF9LiPG5Gusp+XAllGzUaBTAFyZ6YAp+FfoxIJnfxJEqPmgOtXzucQ+/0zzS1EUMElcEg5IXyEJj6qLv7ix4Z2wrXjw9sCdrglDx9FWVBhKIBHzUUQBV6xeOM4tTyf8QVtqGXWAiZ2Z66lgWpb6E2PErC7i5pAxVs3Ul2pYFWkThn7wvu+cWnk8rZvfieTBv9l2KuYr22/ePJLsbR8DN+qYz5w7gh1ljdxd/eyIrKGihFhXePOJ/RGfZbY4/IVc1CdXc1asCUughl3m663GZhCb+qLW4ezruEmnlYN6Ks9pC48fT6w0XryZYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh8xaqDsKJhOynvI9rP/sLuxCCGO5FbyfYzJgf+WB5I=;
 b=UxcirPOd0wkUaeq3ktf9cchiWuLMjhSCTyweV2O7bxxo+temnwc3TzhT0xrMVmOfak0AX3K+aWYhDdasjjwf5Oi1DxqwY4y6f7TPm3aSOE6HUmCvtEfKbawV9IuK/ee1wXromYJoIHjPebCPgueZMH2J07mwG3bXnacKJ55UUwaZHjoYVXRe4w1OPj3GAXwN2B5EQdmZxT1TV9z3NoBrtOBV9GGBB1n9bvtevYyRO1AFPbrufINLtoCbW/rhL9M2fGuu0h51EFffykxiwGt0j2rbDWqiPa7mzqDrI0pA6Ov7rSQwXREgW1fl7htbToMoP01sYuuFfxxTquRZI5juUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh8xaqDsKJhOynvI9rP/sLuxCCGO5FbyfYzJgf+WB5I=;
 b=Fs7bFUzkXNkHv87o1XksBdOHv5GX1HH3vL/lmC8/NqdAbUMZYJ7kZyLFFu8wpjaVaAGs/UsUXM8Bf0ecv3pG/PfGumX6jk4pc54VAkwxUnKyuXwUnA5s2reXlnbUbvgEAC/5hBA3s2aRl3FukdHjizGKiLFt5W+wRhQ9KtnT4CjwI5vMHer3wth+ggd7maVSheyyQcxVTcFiSiIjW0KaiDMr8Y+LnWeQKDYbWLfk7YJjGoSKQh4DkmaDM5Zt5p70moH2xzsfv+dop5wlcXHoMjFyDh68sbVMIfOiRAUKLJ3tXhI1aPXjLGbCN6/v4S43ISGxcsPBcXYnbOSfOa/TkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 15:27:15 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 15:27:15 +0000
Message-ID: <bb3c5102-f241-46b5-ae6a-ca0e95b82eb3@nvidia.com>
Date: Fri, 2 Feb 2024 07:27:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
References: <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <6bea046d-326e-4f32-b6cb-dd92811b5fcb@intel.com>
 <82c97129-5d87-435e-b0f0-863733e16633@nvidia.com> <ZbysTRVYtih/1fOc@mev-dev>
From: William Tu <witu@nvidia.com>
In-Reply-To: <ZbysTRVYtih/1fOc@mev-dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8315dc02-a282-48e9-b75a-08dc24036f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Df4V20Tp5ZwvHbB5xuCxRX/uEH6vMjVOAtGGW5eo9CnoalWtKKUQ7bGXN1nl9EFxIbFu6KskKkKsikSzVLVeF2j3ao7+S498WyQv4uLUq+YthWp3ZzoGErVEeBVM8+cNFsJ3xciX9cLOFK1tkXHjCFzrd2/ojpb/5rIT/PQ9VxjlGfo7+VIgeTnLo0X6PMT0R7xcXg0hS87bIjA1/E+4HcictRFUnC7U9Hop5u7FAk51uusbpRcK/KkDElFzk3f7QK/jSrnSBEgIxKf2rvtifbIg5oCNtgREEGQo2UC/ORWytqvGal6Wa7UuJ0REOZYYMsHqaqxClBr+8/a2guh84bvoAFQGL1KLbqBh8yW02JL1kzVcAWnJrbsa/6M5sykK4Nkf6wN5d2QdKAnzhAZP58uervFCqbGNAYkAqc1rkrKvPPCFFhCwi/CV1xaTBRPR1FSMWZjIFecblGsGa+wpXEoC1mZdeOguJFKWddi+FdINxmUh6awvYBtTAaPJIEb4Z0PYlJSdRGq0JpTMqtJkOhjadbYXDiCz6J5fikotKBgrh2FiiaF2LnBDnmqutrgF4UYnj6Z4bBh4ZWkyXTU+D5iSfTrJEOR1dZRgQ1a/wIz1er0MfjmmdTeDf7lUKs5H2MZ1cHMbsexy+vEyHBrYsppzqScI62yytbCotqEdYNmF5eLquPfwaB5m6jYR7ih1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(83380400001)(26005)(2616005)(38100700002)(5660300002)(8936002)(54906003)(6486002)(8676002)(66556008)(6506007)(6666004)(66946007)(2906002)(6916009)(478600001)(53546011)(66476007)(4326008)(316002)(6512007)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmJRWnNYWmNyZWUwRWJhOWhsTWxqeWRycVNGL2hicHI5SHdxUFZnem5ocVJQ?=
 =?utf-8?B?VVIrcjF1TTN4eWFVQ0FQd21xS0dWWXNEU0NzYUd4QTlZZVZtelhORFhKdUlH?=
 =?utf-8?B?bEovN2xvQTA4aTBPWFFMNFVxeDQyU1lEUW1UNWxMWDdyNXVzZ1R0c1RDUGZv?=
 =?utf-8?B?RW1PYjJHMmxLcHpNSnFadkw5cWpkUlFSaWRYcHRPNTVvSnQ0ZEIrLzh4ZlVu?=
 =?utf-8?B?bEVHdjVuakNSOHc1ajB1cWE1V1VQSnNxbG9hOVdjZUZoTlRzUmx3ek9KNzNB?=
 =?utf-8?B?WnNBSGxrQTF0YTZXSmZjR3Z0cVZRSWFldWlscFEybGVqeUxCZjk0MWFMOEtP?=
 =?utf-8?B?VDhOSC92ZXFIVkVQMk9pWHAyTGxjRklzbHFBVjNSS3RqVGltSGF2YzRpMmRD?=
 =?utf-8?B?ZXliaHRDV0JpSFFFNFo5dlJCT1JZd2JMLzdHWlZpcGltV2t4Tlc4clhsWW1L?=
 =?utf-8?B?Mk1oWnFxOG5sZ1ZBUGNJS05rVzFMbk9IUGNpZHNyc200TTZTTnRGNlhDbDgv?=
 =?utf-8?B?L1lQWUpKVmljZDBDcDBENVRCQXkzOE41S3NGMVE2cENMT3VZeHdubWlBUCs5?=
 =?utf-8?B?N2VNZDBYNFZpSzFiNEJHU2ZzMDU0TDh2ZUs3dlJqNEw0TmVzbk5DYmJUd1JF?=
 =?utf-8?B?NktacG1WSkdMOHl3c2RuSEdEaG9XOHRubEFrN09SUHRzbXJCeGFiQnI0bkkv?=
 =?utf-8?B?R0x4dkd5VEY3UmdaaEhuVk01S3lTZzFBeHdaWXJTMmRNZHdIZVR6T040VndQ?=
 =?utf-8?B?ckpKOFZLWjlsOE1LYkpXVTMwbDgxbjUvRlV0Y1Y1Z0NIaFlRY08vN0ZqRTNm?=
 =?utf-8?B?djhGNzRhdkd4UW92Q1ZsSzFBdUFMQU8walVpTUtyUVN6YWlZTjJoVzFKZHFJ?=
 =?utf-8?B?L0I1ME9XNitrVFdCN1pyN0l5YmJyZWU2R3NNUENpSFJEOFZZVDE2blpiTG0y?=
 =?utf-8?B?dW52OGVobjdWZlo3Y0NkazV2bllvQlNpa2tweGhtSktoNU05cjBaWnI4Q1lz?=
 =?utf-8?B?WXBEMGF1cFJGem1VNERtNnhMbEJPTXlSdmpna1BYa2JaZWpFVlBqQzFlOVpn?=
 =?utf-8?B?RGo1R05FQnRSV295TGRxYmJnRUd1TmtsZVhHL0RwclFnUHVRSzdQSFdEK0JK?=
 =?utf-8?B?d0FwRG93eDU2Vk9UVm1tTWdQanJtNllYKzdtR2NKRnJ0Wmg4Y1N6RnBZTnJH?=
 =?utf-8?B?ejk5L3YwdDg1djhnczg2elRKanNISXVRV3dSTU5OZ2pSQ3J4eVMxL2dBYmtp?=
 =?utf-8?B?NlREZEYrTDE3S0w0aUNCN1dFeGFHbHBnclhIZDVHOXExVnY4aXJMMTFzNG8y?=
 =?utf-8?B?cEZDTHJvZGJkZ21PRm5TR0VBRGNYMUpmbkxiZnlrcW5YS25CRHdqcmJyMWJX?=
 =?utf-8?B?RzNtWklvUS95THprVkZaeURueEsvMENaWFZUYlVFbFViamNTVDJzbzdNRmlT?=
 =?utf-8?B?cm9XUE5BU1BDSmlnNzkrdzZ6SW13V0Roc1BrTkhJWHRQWGlkenQ3ejYvcGpr?=
 =?utf-8?B?ci90bWd1blJLWjY0bTJ3UG01azRvYThOdWJyenBFRXV3L043Q3RReWptVFA4?=
 =?utf-8?B?b0UxcHR2NU0xdEVtVTN2M0ZHOGJXWVB5L0gvZGVicXE3cEloZkJQNlVhK3RD?=
 =?utf-8?B?NVZEb2l2OSs5RXU0dXI4c0xuekFDMlV2RkU0bnFKZGNQSDVrTXZzTkphM1lC?=
 =?utf-8?B?RXZzYnFmYlA5a2M1aTdwallPK2kwUDhCY0V2ekpSdk9HeFZBc0dKNmxQRjBS?=
 =?utf-8?B?NGEySm1GSktOclF6a2xvTFJ4VjRtd0pLckd4ZGFIMi9LMVNnUkZlQkF5b3lu?=
 =?utf-8?B?WThCTG5mdWl3UlRZZjhGbUNXdFVmVTJ0VndHTUl5QVpWQzF5bzM3SVRHcjJK?=
 =?utf-8?B?S29pZDNHN1k3OEdTaVlWSEJ4SUdrdUd3MTl4aXRMRmp6bGFtYklCcFJIbEJs?=
 =?utf-8?B?c3lsNUp2U1JIejBKRzFUdGhvNEZiaUhUSE40dWtjYlU3YXVKbThxMElpamdN?=
 =?utf-8?B?SXRNSU1ENUphK1dsSVdEb3NwSFcrUUFldFFYVHgyZXE2U3FPM3pkUHVpQVJl?=
 =?utf-8?B?SEZYUnJGWmt0WnMyd1FpU2w3ZGxzWHBZTytNRVNMK2k3UWdmdGE5aXBVdS9x?=
 =?utf-8?Q?tjooRSLER/g27zZuQOmD1CN+y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8315dc02-a282-48e9-b75a-08dc24036f6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:27:15.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn08SYCM/SjAc9KseWOIIh0nXA1xctWSlZhnD+2bR8wIGzdUOMZS0ryAETxtNXjq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096



On 2/2/24 12:48 AM, Michal Swiatkowski wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 01, 2024 at 06:00:54AM -0800, William Tu wrote:
>> On 1/31/24 6:23 PM, Samudrala, Sridhar wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 1/31/2024 5:17 PM, Jakub Kicinski wrote:
>>>> On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
>>>>>> I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt,
>>>>>> ice and nfp
>>>>>> all do buffer sharing. You're saying you mux Tx queues but not Rx
>>>>>> queues? Or I need to actually read the code instead of grepping? :)
>>>>> I guess bnxt, ice, nfp are doing tx buffer sharing?
>>>> I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
>>>> I'm 99.9% sure nfp does.
>>> In ice, all the VF representor netdevs share a VSI(TX/RX queues). UL/PF
>>> netdev has its own VSI and TX/RX queues. But there is patch from Michal
>>> under review that is going to simplify the design with a single VSI and
>>> all the VF representor netdevs and UL/PF netdev will be sharing the
>>> TX/RX queues in switchdev mode.
>>>
>> Thank you!
>>
>> Reading the ice code, ice_eswitch_remap_rings_to_vectors(), it is setting up
>> tx/rx rings for each reps.
>>
>> "Each port representor will have dedicated 1 Tx/Rx ring pair, so number of
>> rings pair is equal to
>>   number of VFs."
>>
>> So after Michal's patch, representors will share TX/RX queues of uplink-pf?
>>
>>
> Yeah, right, we though about solution like in mlx5, but we can easily
> get queues shortage in ice. We need to allow representor to share the
> queues. The easiest solution was to move to sharing queues with PF like
> (I think so) nfp and few other vendors do.
>
>>> Does mlx5 has separate TX/RX queues for each of its representor netdevs?
>>>
>> Yes, in mlx5e_rep_open calls mlx5e_open_locked, which will create TX/RX
>> queues like typical mlx5 device.
>>
>> Each representor can set it TX/RX queues by using ethtool -L
>>
> I am a little out of context here. Do you allow also sharing queues
> between representors? API for sharing descriptors sounds great, but in
> ice we also have queues shortage, because of that we want to use PF
> queues instead.
>
thanks.
Yes, in mlx5, each representor still has its rx queue, but only the 
metadata/control part of the queue. The actual queue which has 
descriptors are coming from the shared descriptor pool, and is used by 
all other representors.

For example below.
In the mlx5 fw/hw point of view, it creates only 1 shared queue with 
WQEs and the shared queue is used by multiple representors.

+     +--------+            +--------+
+     │ pf0vf1 │            │ pf0vf2 │
+     │   RQ   │            │   RQ   │
+     +----┬---+            +----┬---+
+          │                     │
+          +---------+  +--------+
+                    │  │
+              +-----┴--┴-------+
+              │     shared     |
+              | rx descriptors │
+              │ and buffers    │
+              +----------------+
William

