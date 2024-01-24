Return-Path: <netdev+bounces-65663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FF83B4A2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E1D1C21400
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF268135A44;
	Wed, 24 Jan 2024 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0w/Bm/kh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC0134750
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135221; cv=fail; b=G8d2Y/ZqssasZ9Ju83+FRkuDyGbcIGL5VSIITBLYJmSaJo5WQ9ho7XJTciIs1JqfpfrdtaJpv+UeepQFQBFcTuTA0qlrOBklYTPU2wzrdQxF3TuIb/vwmNh9/WgB+rLPxaRoDy9sxZTwP//GDZ828ihbB3eOjf/mNmCLYRzS5nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135221; c=relaxed/simple;
	bh=Ah3osn2cojd32n/uNhj132Oqy0f1mLP0UHK2dKnNxjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KO2kxnzlgfAWvfb2B6bELQKLBbGhIuINfE9DKLCHCr7bk/IxIH002yJMWTmxNYSzIvkDo0EshU+Evy1oYeP7W0iba62S7RgGVDe+67MFacCw6CBEtuR/DHC860c9M4BxKeDFCefXRSFS6T++mzXF8NuB/Q8KsR1Ft3R+OTE4cGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0w/Bm/kh; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUIPkHbHN2U66aNuE9BEJmXZtxZ69vyKkkY61MXT7y7cq+mp6GpcirHVEyUg2e1+F9tXH8Ibs11gE8wUxo9D5m0xDlTgXYTNWTNx2ioKAJ8UMnjK83WJfhaZYGweuv72rPPHLAsdL5Esc84Y5P9iflqllzE9qTgX/eTICRT+FQk+3f8aDj0+tN2jKp55AQhI4mwLuYWNnCNwQ34+q7jR+jRm9q+MINLq2/PlBFCdqRxNqVwDpJk9lC6cHw1RYmTCPOKBlyNQecsEOG7kTVj/xDkfHZ1znxfESuB1biLMv4nHEiLDgMJQ1nlZwqFlH1CmmJ1UMc94zw2ThaazVfJz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChhcyPW2mjI/Mv0D5pcyfAQS7AVL2cG3H8fskdnECeI=;
 b=VjqHJm0nlB6N96nGl47Ve71iUFQu+WoWGWrRKeQBKYcZiQ1E0h1JRtDhndKkXkkh//uJDfk/4HT8YAiMwX73lb13QaEShSIlsMOiMTF1J+GrqT/b2Y/x+J9z1TB7jFiRrzlFghvIYFmeGTh5Fltfjm3qnyO2aEq0Y1qzSMoH/wSRL/EHYcYvDSBk5OKN2pAb1HPVGjL41gUqjYqyVaFfHojtN6YU6P/A2XitcIjJDJJ7c+uValD5putoJoG8dh3HgQeAIIxEq6zGJ++yFvRXJnOvpmTjw52t0nsXifBXmRrW41LaUAy05g/oLiXL9/7l0jFKzglfnrEcaoiPt2gZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChhcyPW2mjI/Mv0D5pcyfAQS7AVL2cG3H8fskdnECeI=;
 b=0w/Bm/khVtqOGQp2itBIhcd9201ODvhBKznGoV8IacWBYR5FtmHLnwjM2Zcx2WcQaIwpFcLkXyGKWMdGroiHFjVyM9czO83oD1WP0Obm202KLcy3MrxaROlooCNm11s0E6w6aq5tBi3hLd54zoMQUgyECFxkCLsy4H5SFkzWSU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 22:26:57 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 22:26:57 +0000
Message-ID: <bff762d5-5141-4f36-9ced-64e843ba89e7@amd.com>
Date: Wed, 24 Jan 2024 14:26:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 2/2] ice: Implement 'flow-type ether' rules
To: Lukasz Plachno <lukasz.plachno@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, horms@kernel.org,
 Jakub Buchocki <jakubx.buchocki@intel.com>,
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240124152141.15077-1-lukasz.plachno@intel.com>
 <20240124152141.15077-3-lukasz.plachno@intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240124152141.15077-3-lukasz.plachno@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: e8810e09-745a-4d5d-7501-08dc1d2b9337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wPGVZHmQhUU4o4yd8O7AFRYQ7QYb4D7uu2+Aw5goYyvVWbY+XbPpJhTo0pKnZGEYXgQ5pQJVbJ5Gz6Y2AqDrKyC/9dlVpbBqNpmsdSsNcD4oBOf9o1IHjmxYD9ozqL0AAobo8Oi4RmTDMDtc+nTHDzXw/ngZ61ytXEiirkXqKP1chcR4Pfv3Je1wQrw9OuAroTlRq/7oJRSiiFkkHRg6ATkHDU1j3tIdXpcFB4t3TD1fzaLbb8iykpIGE6el8n/+2ly90D0Zo8abm77VnXA59nFwucdmIqRqECR4xrVs5FXhClfy+ErJ2NE6T0A+avNMReqs8pM3y3DSejRHIeb7ZMBHtSg53BAzq/QlU/tahZnYHfh/FOnW4Ay4fIdlpJjn+hfZAucCZypIQyGVnpZsEDSgIbilolI+eqf96BLP9QVl5Dz1zKVMOde5Qba4iMlIoa9rq/FDhHmTdIK5li49Re99QAv/HeEYkPxBT6tkix/a569pGRaVDH6T7SWrUEUOXM99cQaS10WndMzKLf7kGtdgAxSWhRBCdw9FV0DyX9dJN/3gQwiNNvSdKMK3uBMRDDEFxIIaj5/xRKchdsHYtVhhP62Js3cPa25peScvX8SzM/C8rq0ZiZUocebf5vHWSPjwekkU6OABX8ilYwOCOmubYR1PAepOV5Ev8RNlgVHoXqY317bWqqpttUSkXgb+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(66556008)(31696002)(36756003)(6512007)(26005)(38100700002)(6486002)(478600001)(53546011)(2616005)(41300700001)(83380400001)(6506007)(6666004)(54906003)(66476007)(4326008)(8676002)(8936002)(316002)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtqd2tsMGJ2L2lZQzlGMVVVUkpmWThaNUgwUWt5a3VqRnI2alFJSnFOUzd4?=
 =?utf-8?B?RFVLM2o4ZVBiSnBjWG80RlhEMkhHNGl0Q2l0R1YxaEE4NDdDZjNJYUJ5dllP?=
 =?utf-8?B?YXF5RmVVS0J3SEhsU0wzN2NZcHIrL2NWOEw2bFZUeU1rODhkMzk4UUdaTk1U?=
 =?utf-8?B?RWxtRW1JRW5aWFNwS25EbStUUUl1ak0weitNemgzK25GK083cnczeTNpTU1l?=
 =?utf-8?B?T1I3YlVGNlRTS0FBT3dxWFFuSHk2NkZlbUQ5U2plQ1IxeElXeGx3bWwxTlVW?=
 =?utf-8?B?WnhhQ3lIbDVZZFovbnZ3bkpta0FPaDhiT0FRQVVMeFFnT2lSeis5NExHc3I0?=
 =?utf-8?B?c3grbTYxUFRTQ0p0a3VNNFF1MzVkYm5WOUIrWEJvdFZ4VjdvYlVlYll3MTVG?=
 =?utf-8?B?RDNKbHIzVndEcU51MnVCYzRXdFh0N25WUUhXYm5jbVlMN0Y4Tmw0NzRicmU4?=
 =?utf-8?B?ekpYb1RBS1lkMTh6T0FYU3ZoMXdJUVRGSUdqc05xbmVIdVlaTXc5T3ZnOXVE?=
 =?utf-8?B?bUQ5YnJxUnFoWnpqMTgyaXFDMGdSOCs5Z2p5NXJFL095OUM2OGtScUlRRit0?=
 =?utf-8?B?a2xmVVl1QjcyU1NmcTNJelFlUWRacmpEdzFtTk05RTJDQUJIR3I1U0tIbGx4?=
 =?utf-8?B?S1ROanExU0FsSVlRemowZ3NvQ216ZllURHJNbThlUGlROXhRSjJ5QTkyLy9m?=
 =?utf-8?B?a1BzL044M3dRd0VzMHJMZXRtQUEzcTQza3YwdVkzNE5ZRmNRdThHaTJoTkRt?=
 =?utf-8?B?NmJFbys4cW9JRkRuWVBjaW45M01QOGNaazlJc3RkVjExZFRCUm1EMzFzcDdU?=
 =?utf-8?B?MGpCTklmdHdwTnBsb3h2L3YvcmZQMlRNdTlHQ0tkM0pDaWNwYkdORThtR0R3?=
 =?utf-8?B?dGtZckhQa1d1ekw0bmlpM05GZ3MvT1dxQ00vN2FRMTRiWG5uZm9HbGFTcDVN?=
 =?utf-8?B?YXl3ZlNHUFZKR0xRNXBqU0RHdUhmR3dySnZUTlF0TE5XNGdkbmVDaTZmeC9C?=
 =?utf-8?B?Wi9LODdQWGNRNEhuSjdTcFBGeCtVQkNJUkJobUtvVzN4ZkdmVzZoWVJHemcw?=
 =?utf-8?B?VExRaFNLWXRIN1VTKytJTzY4UUpYNDVCTEg5UzhsdGFKVVpXTFk1bFpqY2lG?=
 =?utf-8?B?dSt4RXNwRDk4VFFiaWRBNlpuaHF0NGlTKzExRGU0OVhLUHRjbmdXTlplR3J1?=
 =?utf-8?B?S3hDSi9EQnByTDVTaGNmUUpVb3BlRzEwRGp4dWVZUkZjNnVJQjk2VGxDcmZO?=
 =?utf-8?B?blh5MXRwNXJEVDVIdGNhbHFxZHRDM1BDOE4zRzZRblhaTFZjbk5yaWhpK0ta?=
 =?utf-8?B?Zm5vSThHSGlTZFBhUnhlZ2dFYVIyNFg5VnFzdk5aZzBKb3RDYjlQYnZnc0Zx?=
 =?utf-8?B?aWllUWxEMHpWZFdKVVZXNUpmRVpWSkVXZmxXYW9XdVZnRjNBdWV5eWQzSlBX?=
 =?utf-8?B?MkdtM0pQRFdZYlA5Q1FXWEZjY0l4L01Va0lMS0RmbW5KTmtxMVBsekdlVlRi?=
 =?utf-8?B?OXA2YzFEN0hsL2cyOGRZeFRkNU1ySEhKcG96ZFBVK054WXNVeGRKYUhVUi9r?=
 =?utf-8?B?cFh6Q2hSSGlnNmhZTDRHUjRBYmg1Q09nQXBLclk5ZDNhRWR0ZzNtU0lyYkJw?=
 =?utf-8?B?QlZmMEpoM3RJZ2tPdGprZnZZSHhzVWZHSEY0bFJ1dVprZURqNU5CeHdiZEFH?=
 =?utf-8?B?SGc5ZGZhUVNhcFYvWDRVbTJNMThxSnRhd1huWjYvYm45YXg3WDNSMnJHTks0?=
 =?utf-8?B?ZGcxT2dVVitrUDNsTDhnOGNPbnpva3YrQU1wWWo4N0dkdXRHb1VrTXRFc1Vk?=
 =?utf-8?B?aUlCRXRmcFEwcTdWRzdlZUk1MHo1VC9Bb1hGOTI0dWJ2cFQ5M0dzSW1PR0hG?=
 =?utf-8?B?ODF0bjlpNS9Cd1djSDFmOUV1b0NsdVpLcmhpNjF4aVhLQUV6U0Zya3ZhWUxz?=
 =?utf-8?B?QkNRVFdHMTU4NFhyakV5UFU5R0F5SnprTW5PRnVhVWJCT054Sk9qNTk4TEZW?=
 =?utf-8?B?NHdFaStQS0Y5dFhXZEhzRkxlT2lBdDAzZDBYMDVUUktBV21Zck1UTVRSUlJa?=
 =?utf-8?B?NUlSejZzMWpRZlRTYjFBN1BXd2F4RDdrZWZtUjJaS01BOGpEZytYc2pxL2VJ?=
 =?utf-8?Q?RvkeuU1E4btDO6UPvH6ezBnoN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8810e09-745a-4d5d-7501-08dc1d2b9337
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:26:57.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8bggTLkJcUaYQJf3zyxgG7htCnga5+2PDl/gXBJPpRReIglgvoon2Df1KOF4WjWm27QFqH1MzfN3fallNT73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020



On 1/24/2024 7:21 AM, Lukasz Plachno wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Jakub Buchocki <jakubx.buchocki@intel.com>
> 
> Add support for 'flow-type ether' Flow Director rules via ethtool.
> 
> Rules not containing masks are processed by the Flow Director,
> and support the following set of input parameters in all combinations:
> src, dst, proto, vlan-etype, vlan, action.
> 
> It is possible to specify address mask in ethtool parameters but only
> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
> The same applies to proto, vlan-etype and vlan masks:
> only 0x0000 and 0xffff masks are valid.
> 
> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 140 +++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
>   drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>   4 files changed, 178 insertions(+), 1 deletion(-)

FWIW, Seems okay to me. Thanks for adding the warning prints.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

[...]

