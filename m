Return-Path: <netdev+bounces-76028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891786C025
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 06:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A42E1C211AB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86139ACD;
	Thu, 29 Feb 2024 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="llRQktSF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6051102
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184269; cv=fail; b=Zv0iovVq475c+xti33W+V6bicKnemFNgdfldHNn4e7JrSlJxqJ5YFD9LqU5xV6342H1w4Y01Mq3o/mFBr0VCIScvVEZxpm46P1St+1uZNL55MJyNJ1RJVK2mlOc42UedwG+UvmLVi8dKfq6rE6ANZGLxOvxV1dyA3IbVWCWwY1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184269; c=relaxed/simple;
	bh=tU1S0FU3Bs4K4Ulf2OrVBWT2Kp/zdJw/wxUlLAOVTts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcnfk3JZ1PMFHnbHoCI4E+ch3wBFFx4ZegAI5NhGyXaUEV78KFQoKEXhglUBrszbQBjSeey0Ao0lrJETZwqyO1HkoaUK919xxQEXn0jTfG7uE3bA9YeVbY1aondvzkn0R9TZkwBsaQ1C0jD9Zbxd2mfCwXD1ZmW2kBCbPDebPds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=llRQktSF; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGyJLZwmKCDB4V92emAkVkell+fbpVV4iyGozMbrgKSUnj5ZbIwsj9+FTHREQxrTBUBaIEChLnX1BqNCh7oJOGh0xKUto/KosSFvMM7kQSAjJrJmGEBtjdzp1H0eJHxZoDaSrMQr9sU2V0m+/BgG90JKy/xBA6sN45gN0eMRHYyKPvHtD32O736zOkioBjfxb6VUYv84XjuWpqIciFddxNDBAEB/ghPD+HeJiUeq73iTH7Vvs8wYSRTqWJ9ooszhf3NQQpNFZN9AvyUx2D4WdsKbu+CTdDMbycM0rG54ievRePXKBWnmDH6H2NPVs7UdCZaeevZjKDnmvgZPznxtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTzYsr+YvINQH8um83qiYzUjfavvkaGC0G7WYGNgqD8=;
 b=KRiUJqlYx//nr+5AC0dsD5H+OXaW65AcgmxHOhGdhyGNLfW57uSCnHd3zr1xWiAwFXH/kH/HowKMCJ8w7keSyp5qWNqNfKB7q3uldBXqlWeVJT3C5S9vgd0fXPmZQMQNoP0QRlt/wBU1166djY4Em7FG+WR0SpwntFc9NaaEsPlwE/P4pi34WdZOWF/ffemhvxVjl6mimhIrWM3VFVPPpsnVQRsQChR/EOtBaprW7brwUQ65gbk36Avao02WyfLyTLcKfLhon/QJhHvhs4Oi8EDUXnvTnyqrtSIxuSOHWEhX/zeTavezIxm2ciidMCZj8xdaPizm6qGMMtwHn+hW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTzYsr+YvINQH8um83qiYzUjfavvkaGC0G7WYGNgqD8=;
 b=llRQktSFwOpC97IfVfy11DUgjYB1wSpxIkQjw1qJvaLS35b3QhCv7lSkmSQ+A1Z0yjS9stIoEj6qr9KLhy60c6nws3ooy6oPhgJOzoEHsNw6nOabUBZInJhKBYA4zwFAZRNxTbvEBc+VsXhuzS1UfUmMJwLh13MNHsnVYTM/zPkChozUkyzz0qN8lyueowcm6moGbtYU4ErC5dajcUcOOg5LkitL4wXMGBBVAa2Oz6H5lMI0JltJh2vB51IYMRz/JLPrHZodqxu5z8tP0rsu+85OX5Fy/eUTwP/QRVw/e5x/9ESEBFQT/B/v0YAuxbN9UAMbN/cKAf3U48WVy7IHTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 05:24:24 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 05:24:24 +0000
Message-ID: <8b9ad2bc-138a-408e-8608-e9b784192649@nvidia.com>
Date: Wed, 28 Feb 2024 21:24:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC 1/2] devlink: Add shared descriptor eswitch
 attr
To: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com, kuba@kernel.org
References: <20240228015954.11981-1-witu@nvidia.com>
 <20240228131249.GE292522@kernel.org> <Zd8zECmvTWF_gZO5@nanopsycho>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <Zd8zECmvTWF_gZO5@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0fcfb4-d1df-4d3e-51a4-08dc38e6b0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C8T4E4HMPg19b+Ptu1eRhbM/7rP2pqGg5PtVFmAsRnrbyCgwAoltm2VIOJ4wGtoBe5F5dzQTJWaLKWx8TJgOxP0oLz8yBFsoiqGA4Ejmllu/BK1ftwPMrTrNvRFlNrYVA0aKfIcRozpCFrlR9qBtz4RrYUHuQN/TX+EFwc3IUMW3WHmJZJtVD274Rfm9GzNQQIIXuy/CiwWDcMj3Id27YIYnEC8gzuHCNJu6xZubtRfcR+jFWWqSZoBdorfdRLESvkP4Z9ykn8AwaWrITyMiGb9NJhbmgrXpzk8lfOSh8OTiqBdb4MflBsxR7QVTDXUymc3CyHntqqmqFxzFvVqVceYIxXKa9oEST7PbeS6vbb1wO2EifTCbUJqNi4VImgbCd+tze17fjEAYxCpAA3ogEppquJ5zcjV2sk2egqW929NQWhOIkzONPP52ddRi9YkD5CSCCU0vCzsbCIqqhhWSaEJrwoSHeqAOZsZNARqKB3p150JXEIkg4ZjXvLYMYP2yET1fipaVCo8fv5Rwr1t6lYnwMgUPmJdOLMJ/8BrPt5R4W46Mhfv02WhtP2F7XvggX9SdiwoHwjfMIIVfgu8EQobp0yvb2N4/Z4IIsdnZ2pVKXSr7iRpIzsnaU9QrlsRm5MnRFbAkzFaSDVYo0wikYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZ4R3J2WUNPaXA0MTFLOEg3bnNGcUNoM0ZFbDZwNTBGRExnK3dwQTdxVUMx?=
 =?utf-8?B?R3NJTTNrcnFsaHdWMTRwQ0xhWEpCczFJQmgrYmR2cG02VmV5NHU1UXpCTEYx?=
 =?utf-8?B?aGdMZXJxbnFUanIzY2RXTVRybWJXNXJ1NzVWMWs0bHlGbjdPZ29sMGlNZTA3?=
 =?utf-8?B?aXBndVNTTTVVMk1sLzNmb1ZyenlHaXFqSWNvWHhZWlQxKzVRbW0rL2JjdTh2?=
 =?utf-8?B?NlkvUStYRXUrTFFwUnNVbDQrbEhXd04vUlpaZ09lSUUrOGI1a2tScHFBdHNk?=
 =?utf-8?B?OVFSdTY3Z2JtVWFKdXpxMlNqcnc2dXFMOXFEWnVoZDdLN1ZiZE00UksxdlRq?=
 =?utf-8?B?c1lmN3RhZG41QWlKM0prS01xSDFsaHJMSzlVcmMxM2RLQm03U0QrTTdIUHJx?=
 =?utf-8?B?NmVTWlpMSTZKd0dra0xlU1B3aTE1Ykgvc1RCWVFicDFuUmN2ak8rRHN0SXpE?=
 =?utf-8?B?ZjEvK1lLLzFBMVkwZlNaQ0xjSFBWWk5zbnBOZ2NMeVh0L1Z1U3JhRmpHZWJ0?=
 =?utf-8?B?VjlXcGtTWUtIck92akZudVN1RmNtTTE3TGRZV3hZZGErQWtFUHBVL2xDVnRQ?=
 =?utf-8?B?NWJwYWk3QjVZZGIyeXgzZ2JsQ1JiV3JmZTBOR2VXc2U2dWpremZNYmxBajhI?=
 =?utf-8?B?cVZUbUU2clk4TEFZcWdocUF2MitjKzd1UERMUVlYN3ZJeHNxT2loMUNVUkdS?=
 =?utf-8?B?RFBEM0pOT0NneTM2QXAzK3oyNUVsMERjanlaamlzQkl1N1AvNEJVak1UM3hS?=
 =?utf-8?B?NDgwRm85OVk5a2NDemxjS3JWa09GcUxBcEhFNXM3TzlzT28rcVJ3cm4wVkNV?=
 =?utf-8?B?eDFUSXBhNC81L2l3TjBpSTFCcVQ3ZEhHdHcxUWhqbEpUeHVuaHFFdEN4TE1K?=
 =?utf-8?B?MEs2bnczWS9ZZUI3ckphUU1RS3Q5Z3VBVzgrTVhzSWxzL0V3TVJxRThsMTE2?=
 =?utf-8?B?U1E4dHdXU3pZdEh4R2ZCSElIbDcxTjlNK3lCMzNTS09IVjFITjExVXpYakhF?=
 =?utf-8?B?NmVwL0d5WjliQjZJbG1Gd25hblprL1NHWGlMTzVVdmRiTzdDeUhlWm9vTkpY?=
 =?utf-8?B?WVJqSUw2NXNGTTlDdGpaeFNZeFd1aHhkRm8vamtlVXlwdU1RWFVFTUt6UVZN?=
 =?utf-8?B?RitIVnNKR0ZLVWVhRTAvQXZBQVpORzV3MkE0WC94dzVFM2xPeklKTjVuV0h2?=
 =?utf-8?B?VFlVWi92WDBFVjdVbnArQWhIeWNBd1JGY1YvOEVUY0ZuQjZCL1dHRFFvKzN3?=
 =?utf-8?B?NGhURlg1NjNCY2x5M2VIR3dsSlR3aExUdUVZcVkzNTBJUHNlRGgzbTBLUllK?=
 =?utf-8?B?elRWRWxlYXNYSHdoY2xvQSsrcmFUU1E5dktJSFFHcTc4Q3pvTnFZYUErZWxx?=
 =?utf-8?B?dUdiWlJ3djAyaE01ZGkvRVdrbXVreS9scFVXekdNTkJXcjdYdC9JNHBwZjJt?=
 =?utf-8?B?M3ovWjlqWGNScHZRd0lRZURLQy9rYVNPaTlXcGJYL0Y0SUhTY0QrYUpWTW9m?=
 =?utf-8?B?QTUvMzFFbm1WQWJVRXV1RHM2UCtRNUFUNzUyQXZtZUNGN0JiWEd2Y3JyekhI?=
 =?utf-8?B?WWxvZTUwL0Nhc0cxaDJRSFJnOWNLNnA5UGNaOFNlWFNZaURZdURoQ2pNc2ZB?=
 =?utf-8?B?MG1KdzBGVzVMam5yVDk4aDMzOERxSHVreGNFcjZmeWFzSjhCZFBOQWV6d1hq?=
 =?utf-8?B?MjR2UVVXS2tnVzd0TWRTMk10OXFBVGg0NzdOZUVWalBVemJZM3ZGcXBaUmlo?=
 =?utf-8?B?WjQ3Ymx6NHVkd0JNZUVZbk5IbjhzeTB0RldIQ2Z0MFdUNmMvYXNYSHhFUzRX?=
 =?utf-8?B?eTF1VTBVMGRIdXp0eFJWM25USnJUSEJkK0dsK1NpaDRnTEEzTHpNU3F0MDRK?=
 =?utf-8?B?dmVHa0lYVDhteFR2Y05qb25GK0pqSDhEN29QMm1wd1NXcm5hM2prSEVSMklM?=
 =?utf-8?B?MkxuMktrK1U5eGdMSnF2L1BnSGNLZ2hLSDlNUytWbkZSOXRvV0xRa2Qva1cw?=
 =?utf-8?B?UEltaG96cWdLMXdpL3RjeFl3blQ1VlJPd3JwNDRFb0RwdVl3L3pMMjlBS0pR?=
 =?utf-8?B?RXdKQi9ySFhwR2xZbU5mc0M3TEVvQ0Ivai9vV3pZbGREY2pwZGhGc2hJdmVo?=
 =?utf-8?Q?Qfz62Ayi9BMTHTJWeQUNm9fZ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0fcfb4-d1df-4d3e-51a4-08dc38e6b0f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 05:24:24.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQbhXLgqmW8Sg1I8rwuk3IB8R0GyVL8JLc++zHmSxheizIa1syNrkyDy6Tta49dv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250



On 2/28/24 5:20 AM, Jiri Pirko wrote:
> External email: Use caution opening links or attachments
>
>
> Wed, Feb 28, 2024 at 02:12:49PM CET, horms@kernel.org wrote:
>> On Wed, Feb 28, 2024 at 03:59:53AM +0200, William Tu wrote:
>>
>> ...
>>
>>> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>>> index c81cf2dd154f..ac8b0c7105dd 100644
>>> --- a/net/devlink/netlink_gen.c
>>> +++ b/net/devlink/netlink_gen.c
>>> @@ -194,12 +194,14 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
>>>   };
>>>
>>>   /* DEVLINK_CMD_ESWITCH_SET - do */
>>> -static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
>>> +static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT + 1] = {
>>>       [DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>>>       [DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>>>       [DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
>>>       [DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
>>>       [DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
>>> +    [DEVLINK_ATTR_ESWITCH_SHRDESC_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
>>> +    [DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = NLA_POLICY_MAX(NLA_U32, 65535),
>>>   };
>> Hi William,
>>
>> I realise this is probably not central to your purpose in sending an RFC,
>> but my understanding is that the max value set using NLA_POLICY_MAX
>> is of type s16, and thus 65535 is too large - it becomes -1.
>>
>> Flagged by W=1 build with clang-17.
> First of all:
> /* Do not edit directly, auto-generated from: */
> /*      Documentation/netlink/specs/devlink.yaml */
>
>
>
Hi Jiri and Simon,
Thanks for the feedback. Will fix it.
William

