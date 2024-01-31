Return-Path: <netdev+bounces-67661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE538447DB
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C85288D2D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687393715E;
	Wed, 31 Jan 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtQybY7m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95F37714
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728625; cv=fail; b=KsequLzaMFSMLlRq3hgngi3TXUMBMzOlzzBAfLMKu3eevU+5XCze4uF9ourT01vyuG0++J5aTk3fNtXgtn0DdW1QWWyD2VpZLpQ/VLi3Zjp9u62PegOf2rNXfYbb0XaqT9H+PjjxZ0aPRiztzIm3HFXaoO/7QZ7R1RLS93QeZjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728625; c=relaxed/simple;
	bh=7gN8Uc4r9uGP6njwiKXKX+fJHTTwp3mJG7ji/kMxOXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gP28js/+WheFfNajMl+JetgOpR0dDUpc7mrrRojeSyMgEqKEZ95hNbVYIF/kNrfB1NRvnlOAVeFGrTJuGDIvQ/aIpSYBPkfhZSj4j7ekuDRsAxEcIsxMKpZLXh+tRWYUEYY9qv9EfdPfXdkiNKqf6SF1991nS/QCIEteM+PVUB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtQybY7m; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpWFssSW0Q3beH4m16oTn5mLWzpw6X9ZiZnPmvx7970/IdEKWn99Xa4+nBph01T19llxMsQuVkoGkEALdpsY1YuN0O+QkYLYL9daZNjbW5mSODABmms8Ftmepfozm+gj/XNsPnWtW+jQrkCi8EqXt0/rwGVLwwliobnbe2km1SWIrO6UI9rYucywZCNJxqgYrafyiWqc7PSBNOT3yxnFAKqGZIOIrMzQwfDwp7ALR74lhkZ6LrNrsaftDv1jXUzZcwKHsD2CRzQmIxot9+kuhNMV1BeA53qvwIals0hWb5yMbkirYkr/p62FX2aK8ttW8ipUUyR94hEPnZA1V5+5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gN8Uc4r9uGP6njwiKXKX+fJHTTwp3mJG7ji/kMxOXw=;
 b=naEzV2nFBl4SkOcGLtF1qDFxlRKUnPDVfKWFguqfjieW2mOBisijUEMlpeGOfghfMJhhSW/8MMyOzEBzSgMu8gZKQm6DIN94fOtl+axLHa99h1uRoYPDa21qIoplmlXNWLj7MlGrOWCMhT9EHpXNIQ+lcNH7aCJTuowrqI8jpmVKCq91FT7zcDxkWz3Kr5/g4VoZZSf95nILOSTJDEkm1ioLdjlbNHvhZ7s70j5n9bdIshVxYpc0kP1ZlDQ8NCztU/kuRhjrqK6hNFyAs22ATMk2hIKdwsj4h5JLWLHLzphhGdawQ6pSQwOsvB9GE2yE4iMqA+Ml2Z9cx61CzRiZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gN8Uc4r9uGP6njwiKXKX+fJHTTwp3mJG7ji/kMxOXw=;
 b=BtQybY7mrRhhPjtesRmKTkGybPJi2N19768ck+9NlkwTeZup7JVV6MENIrhc8GCxhC33kqSr32+XunTFMte7Q3M8YY1IdaPuYkR1ORugV8xEuc5W78DNkmp2cgCBR7w7OetQkbFC3pI8pKEXDBXLSfOwXDi78VpoIOxQBN28XFyp3RbcfLItlbymIsGV43bwX4fkcf2hyR/gFOKVzQZtim7dB14ohrjdnROgIhyIDjtY0M/xMeYyTND1L2rE306SyF6Ji9Awu5GQ/uceR1qleH4gSHxMmK3KvnQgnKIXZOX9oqzGEHsSDEAxIF7hsGbE9BVRzh0TVEEKFlgEqydD8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 19:17:00 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::c4cb:7b15:ece2:2a3b%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 19:17:00 +0000
Message-ID: <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
Date: Wed, 31 Jan 2024 11:16:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240131110649.100bfe98@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 591bfb60-9f85-4811-0595-08dc2291333c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ilIBvgJk0mlWLXWUDoiWASwEn+WCQnlWd9HZ7D2KL9yoU2btuCD0JKSm18tFskbR0UEPxuhhvYF5dh5kEjkdMKTGzMMny+aL3BVEUrt97vDbvQKL7kVkbz8Wuc+9m2ioGzx8jVBMOiHnDALWAzEzguAG2U1vYANP06c4dQMAE3VhcJQVluL4SBQXRoRdUi313v28FcgexKvXPLOZuCMuYXz0rgQpZoCC711Mg3cKwFvuIedA2HjkvqMpkern2E8S/gUkRvkqPEpVLNKKP9hr5dbLBoipCB6sCyuCMEKtm5qWAu7FO4dNZKBenuoei+9diFyW0OuDdy8OTr+yG/Smuofd/g+3F9tcwTCaoE8Oj7KUm8fBjFYbjLZjk/Svg46/jz6AfG9HNQv7qPMz8e3c1GS+B6DCpW3jj2K4QUbOQxtWU2diuZJMKYJRv8EiI//UiEEQ2nZvSHJthddOiwrySUdPE6yGzaN8S7X8IXSmyT9zGGTjVn1Nlr3i5hddXj8Q/jeVqM1H4IYpQblNvgZ3/rHsnrDBOJuYn9AFtyJsM//H4JxKlF2EMdFZuYag382fvOM/6RGInuSu3AZ1uDV6xhu8gXZ9Pmf1otcY3TFMcupggCYodit3ZLid441A7LGRHLEmTc5ZBtWptjbXbmVaLFP6mvZWhLc7ldAtyjMl+nwMn+tYVrCWs5545cukgrbf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(107886003)(38100700002)(26005)(2616005)(6512007)(8676002)(4326008)(5660300002)(8936002)(478600001)(6916009)(2906002)(6506007)(6486002)(53546011)(4744005)(316002)(66476007)(66556008)(66946007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THFVeFRJLzgzMGI4c2IybFZFaGdUaFRDZFRWVjV1Rk03N1FHL1lScTRMcjFW?=
 =?utf-8?B?ZmhtYkVhNFRCdDY5VnFmZkdObmZmdGN5ZFlXQzZ1dXFPNkVVVFM1eHNKK0lr?=
 =?utf-8?B?WTF0amIvYWlEQS8zSUlucHdvaXhCVERIaFVQMlVVbXRueWNjZjhFQXhUMzYz?=
 =?utf-8?B?ejRBbDhXcHFEUjZPNHlPVWVmQklUdk00N1EvcUR2Q2t4Z2lpVlFONXNrMEYz?=
 =?utf-8?B?QkdqamlqdXIwTFVKYjlROWQyNC9wQkl5a2h4N2ZaelduZWtyOFVTdWFBUEdD?=
 =?utf-8?B?WXVTQjcyOE9wMHpHcXBXSWxvUHpieFNZZGUrT1RjdGlmcThBbU42OHljc1BD?=
 =?utf-8?B?SEY0bTVGWFB5ZU5NSWQ2Y0dLWHlFd3RGWHlEM0dSbE1lZHl6RTNGUkYzOE0y?=
 =?utf-8?B?eXFmMDJTendWTUlKeTQwZllBMzZRUTZlalV4VVhUYVpuMjJkYUJEV1cyWVZl?=
 =?utf-8?B?VEpkMVVjQ0ZEVlMxMWlsSWxFdW1GZloyNmRwZU1IZ3RSVUlyYXdxNERNNG5I?=
 =?utf-8?B?OUxVWTFyV25obDZkRWdsQmxZNVVMcDlyc1ZaNk8wTUtCbUhkY1Jwb3lQOXBI?=
 =?utf-8?B?L1FCZE56cGhkVW9vK3lOMVZLczVNSFNkS0JmSnlmT2JOQ2NBWE1XQkZycGZI?=
 =?utf-8?B?b2s0NmE3aWtSYlY3M1lxZGhrSDQwclp3VnlFdFlTcnBpYnJCdUhNdzZwaWp3?=
 =?utf-8?B?SHBhckpkQWlzTHhpUEFGZmhLWXRSaUtjSUl0djZucnlLRUZDRm03QzZrbU1V?=
 =?utf-8?B?YXNWVXdxejA3c1U2YnBTMk1WSFlGYVBsSmVlOHJDdG5vVWs2V0Z0b09hTFlh?=
 =?utf-8?B?Y1ZpbjNrVEhrVkVNSlZ3MnAxbzhsQThKYVBKVkdqWEp2bVpubUtjQnlHSDN0?=
 =?utf-8?B?bzNIN0lpdmY5S0MxQlY5TXN5c2xwdnhDTUczYncraVRqaHNkN2k1OCtVL2dK?=
 =?utf-8?B?QlFVamw2Y2NsdTVLS1hTMnlqSjIvUjJUbElmeE95aVNYa2FmWXpYR0M3MDNl?=
 =?utf-8?B?TjJMcUVqc1dUT3ZCakxib1kxQlNlZ3NTNDNURGtNZm1yQzNqYVc2Sm5HUVhh?=
 =?utf-8?B?U1pqNXEraDFsQlk1b0E1TFF0UTRwVTlxU2M1TXV4dmZYckhHNVdmdGpzWk81?=
 =?utf-8?B?NE9hZ1drVjRwandxQ21FOXQwdkpSWGpwbXJuVnhVMUo3S1owTk9pTEExRnJK?=
 =?utf-8?B?T0RpWlRhUVJZMjJkQ0F3MHFxWm1tTUlXSXR1UnVwRWUydnRUMkloTFN6S040?=
 =?utf-8?B?dDNzU2sxa2NiOFN3TEhVSUhuOGloWnJHQ21STzFYUGVEdFIzZGZOOEhJS1lZ?=
 =?utf-8?B?c2JsTGluY1ZLV1lVcWFKT1Q0RDNmUVlwWFl4eEE3WUwyTldrLzZkNFpuZGRX?=
 =?utf-8?B?eDZLWGNJSFV4ZnFpZHZaTEVVblM2bXlpUndIVXNOcXRhYkpsZFQ2ZkZWcUJD?=
 =?utf-8?B?T3Z0ZWhQZzBwa1FaUlFSbWM0M0Z1Q1RoWHNYVTJQUzJCWHdNTUc2a0JLU3FE?=
 =?utf-8?B?V28xb2docUlZN2JIQ1NhUTBaNUFIVTA0NXBEdjJsUllJTVlMREZkNWQyZFVi?=
 =?utf-8?B?OFJQYWo5TFVWTkdrL0FmOUxVVnVQZ0lmWGUvZGh1TjdvZDdYQ2MzYVdYV09t?=
 =?utf-8?B?NUM0SE1hZUdCU1o5cjBqUW90T29Ja3NOeG82VHhDV2tjZStKY2NGMkpmWDBQ?=
 =?utf-8?B?cUU1SGg4MEVkQ2creTlVcElhRWxTaVlUMG9VazFrRjJNQzFMalgwQmVVNk9r?=
 =?utf-8?B?RWNPM1o1anVqc0dHNS91UHpMbGU2TDVxWmJ2dUhSeXNQMXV3aFNEVVhsZVp2?=
 =?utf-8?B?VC9DMjBqMUs1NjRpNng0TVEwRGg5RDVJMnFPMy9sUHVselM2ek05VndxSTBs?=
 =?utf-8?B?eURsenFEOVgxNGdELzdQL2QrMnBadTZXbzA5c0pLN3U4bmFScDhSbkZDMzZI?=
 =?utf-8?B?RXBFS09DaXltNU9jUm5tWmV4UXR0N3IzalY5MURNdmpTQmhpMTZlL1AyZ0Ev?=
 =?utf-8?B?d2hWRTYwdm9XM3BjdmpaRGdvR0dmSjVZODBjU2NLWVRRa1A5WkpOL0E2L0Zx?=
 =?utf-8?B?UFdnbHhIVnBab21WQXlabTVRbDFLamd6OUZtaU95TVgxOEFhYXB3YVkzc3NO?=
 =?utf-8?Q?Fl0sImCayNbuWbsAsXJw3xXre?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591bfb60-9f85-4811-0595-08dc2291333c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 19:17:00.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJmQV//NK2qYJ/s5m32Y058VrhAH9K0QLpsiBsw+lCHNZtloGtb6/IT5L812/6WX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822


On 1/31/24 11:06 AM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 31 Jan 2024 10:47:29 -0800 William Tu wrote:
>>> Do you only need this API to configure representors?
>> Thanks for taking a look. Yes, for our use case we only need this API.
> I'm not sure how to interpret that, I think you answered a different
> question :) To avoid any misunderstandings here - let me rephrase a
> bit: are you only going to use this API to configure representors?
> Is any other netdev functionality going to use shared pools (i.e. other
> than RDMA)?

oh, now I understand your question.

Yes, this API is only to configure representors in switchdev mode.

No other netdev functionality will use this API.

William




