Return-Path: <netdev+bounces-79028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48B87776E
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 16:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F95B1C20929
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4066374F2;
	Sun, 10 Mar 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ix3o3ZTx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88E36B00
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083419; cv=fail; b=O1EX/fHeS3iGiB+XmISSg038sJ3Fh1Z9ZUgymlaHYKl/wu2qkKXy7zoHrd2UNvVLUYiGphG6W8NxnAjyXaBVQ5wu/Hql6PUlVlWSMmzKgEwYIXnxmliaHFfQwwAyY48e9ZEiQT6Pr4rFzgT0AC6yxoWClRfot+diwaZDqx8dfm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083419; c=relaxed/simple;
	bh=R+fRB9HMa16wM80OuYBJdjnxIz5jSZXqkNBlUYdcGE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cy2zRrO6Xm9hQg9Wke1ewY9uRBbYazDpdh+GSAsfNGXUM7TL1uB7c486hBcAUxT1S373UfqFa5thx1JTfbE4R/HP0mNZqvspUShFH7DoOmbBJQECj8OW1aaEfgizPXTmqtVWIRKrTd9bBYQWgCHkXpH8CdotF5GgnUna9VlozmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ix3o3ZTx; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTuYEypmLqYVLiBF3QMMMwuB3m6S7l2ruWJOqcZvjqqyHFbu1CoRA8J6xj9DWyuHjgmCTqhs1sb1N6dgk2iuxYISwFhKqF1YuU/TZnrHHvSVxMeWO6A58j9FHNLJOfYPoHCDOFJleXo0avs6aOltHWL2adcIXFlRdSxGra7fSoyxdQZtkBq+YzDU1+RORxeBBzLA+B8cwRfT9XfHogURqviGQASXlvtcP5jB63vZtE4aaVHlP1N1+TYqatou6SSl2fuq+bvHeF9p7H+d1daujMRL4VR57B3Unly86JIgblmWR3YiqtwdGfbGl1IKZwQMfOiLYsSvGh1QV23rYHL7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOwoh17pHpKGoL60+kkFetNZHBqcPPdUvG4ysfMbO+o=;
 b=HCw8vgUmo9qFltC/GUvfJNAdICYs3cbYTIYdVGmt5vNnXBLzhC/KVII8Xr5aLCa+9O0V4KdXI61MmqerFnHzPE9+fJhI8GzX5uWuE0EIpWGhdC9HqpNiJ59vMeF3yUC1ApfZbqnpyJYVdFLakmGkbnYt0mP6zlRLw2+07xdl8JYp3eir7+XblEui8qR8vdG87tyjYtZmopeakYuvfU8kveq9ty/C4vYXRg8RQ9u2IIc8iLrHOojABEt+07/3LjTNTDqRuMoUxJTy/IIUqvIS/i9MXv815cy8hdnhjHl0JrGe5s6aJ2QMbcB+HHck8i5L4Y1rHlYO2Mwp1yOmSUaLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOwoh17pHpKGoL60+kkFetNZHBqcPPdUvG4ysfMbO+o=;
 b=ix3o3ZTxjfXgvwR2EG7cDYQ9ZKVlujZ0f4LMqgcLFdy/0hKq5kFvd15cbLrV8UppE5lWTzE7RHXXGEWnMqfH7UiVW+3HbE+fDxCvwwKI+vX4PFxslAqBTe5b+HcBv3ShVo3us/n8epaWtm5PpBICTLk9Zrai6ftMaNJBKi8QT0ocFsSL20oj8iIw0Ls4t2zXKGzrBVH89jOwGmo7Loj/tE88WjBfiU8+IrFxLOhvcx3fecX2QCu9J1F2Y755C/W1ULcBIuhZ6TsJ4yw+7vasWfKakr0IEZPxlz2ABIgqCQoZrrj+gS5mp/Age+QlXwpAgzfgeDWUkmBQESlFnVEWfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 15:10:14 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 15:10:13 +0000
Message-ID: <c12687e1-88a3-4ad8-ac39-731a5724ae22@nvidia.com>
Date: Sun, 10 Mar 2024 08:10:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: Add documentation for eswitch
 attribute
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com
References: <20240308000106.17605-1-witu@nvidia.com>
 <20240308201435.2790b7b4@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240308201435.2790b7b4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: d7782ffb-0ef7-48c0-c758-08dc41142f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	beSeFpH9Ui5SRx8FNxAqjCLqc+RlR/LEeKaH1mYkClPcnrsByGnJ6e48rDEhPXVJVSQtxP9homDt1pboL1H5LbpfjfI63aXRqXQdyck4QmKY+FcegfQhw9ZjPZuu8I1OBd5H+nZ6clFDjhrAuEA5bdxejyEktOKlJNgzsSIMJKCBKEQ5h9iO8cGN98t28lz+rmG13RPu12U4kCcgtTpNXEt5SWipeZzPy49JPTWPJBwf7DNiwClQrpDhkETI9AYv6/nJ76yXGu3OKjtdlbkRTW/TK8CLIsHI5uVub34AL81ZuY5VIXT88T2JKgVjYVLHESaScgb+HEIfEvu0rtMvm2l1GokmAUwa7CctmaLvJQMrrWBo/S0HlaetVGuFTCmWzBXsrrLazY0rXIiFTf1VvN7P1CjuSJ2NiYCoAJQmpXyaXypBh44dXd2ePvNN/pPSieIctNG6eWdQLeZ6yGh205OuDbjqwqlKC8vIRlnwlG/9PoiACp1dKlTi4oy2UdFrl0xjcTX73AodEgjO5RdXJhzjKRAkcfZYWlAEMi1oYzdKSuMGhVgYhtKr87IBfE4YUxUZWTP/BY4GyoGMD7F3xRF+2eI2+C7ojxQipKkAtqezdlwjbdyVjp3XYzaaoW3UiGU1uMURGKfkn916D6SqgL0pDYxEe1K1Ej+PbXP7RpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVRnY1d1MjVleTgySFplOEhlUWpkTDU2eW1JVHZPQ2V6aTVkN0hJanhNaVVt?=
 =?utf-8?B?RW5tSlpOV1Fja0FYc056bXBic3F2VUtLWTc4UThRczQ1cWdpMzZoWlZjMi9C?=
 =?utf-8?B?V2JTVFY1N3ZkaTdWT21kN3A3dk5pb1pUaVBjdzNpdnVsNGwrYlBzZjNMUk12?=
 =?utf-8?B?WFlnVUJNL1g5bEM5RWprR0RRVmRlamZuSGVuVHYvck5RVzZlUmlyK0UwOEpN?=
 =?utf-8?B?QlVsRitIT2hvL2dZN0ZoeFRjU0ttZGpCU0NwUGs4V1NjRE5yeUxXUStReG9Q?=
 =?utf-8?B?VjZ2RGdYUGJ6YU9oK3ZUY211emtwQjBTb1U5YnNnMTlYUDNEYzlqNmxBcEpY?=
 =?utf-8?B?clpoV1BmUDJVWlZvZzJ5RkRud2FWOVJiYlJYd1hTN1J0S0RELzBOMXgycTNI?=
 =?utf-8?B?ZE5iaG9SMEw4ZzZZTk1ZYXM4ZUM2WnNGMkM5THU3WG8xM0NHRFU4di9NRmNM?=
 =?utf-8?B?TytTbURKbXVRSXRpMTBQYXRaRzh1TG9rOVNlZ0FjSDdZUnJmODJiRVl4Z2xz?=
 =?utf-8?B?V3RWUG51cmVqcWVqSkJoRC9qNmZOYzRUbGhLMkdtdmpFUEFpTWNnYzlpdVpz?=
 =?utf-8?B?bFQycVl5V2R3cW1Na3dUakxETTd2bWpyUkxTWmZOem9wTHR1aXpvajdFWWY3?=
 =?utf-8?B?SVhLYURKekJFSmFXdHhSck9lb1dJLzZnSDFuY0N4K3FIQzhkYzFIODBiMUxO?=
 =?utf-8?B?MTQ2QXA2cDdhUHBMSjJhcnFsMEtKYVRiZjBzS21PWWN1L1FZak84OEJpUm0r?=
 =?utf-8?B?WUk2QTBEcUZ2bGJ6WXREVUluOTNESCtlVzIrUzAvYXVQZEl1MnY4S2NCTE5h?=
 =?utf-8?B?dUxZa2MySFpCeUFaRzJJbmp6TGg0bmJVWUdocXJaWkZpb05ob0o0dFlOQTFD?=
 =?utf-8?B?dzhEUTB1SEhCMHdMVkd5WE9zREJtMU9tSFJsRGVtUnJzSjJnRHkrVmN4UVNw?=
 =?utf-8?B?SWw3amtkQ3VsVjB1QTVoSHQ5TVBNcWtLa1YyRVlXa2k2Y05QbG5lK0ZZL24z?=
 =?utf-8?B?aERpdklVQWtQQzFUcUtBNWIvbTRSaWVFRGc2TG1RYlFxbk5mdkpwZThjSFdJ?=
 =?utf-8?B?WmdzTDlVT204VVBMMVhISXZYTTZIMjdZZDVsYkI4bnlRZHBRalpoVTdrUll2?=
 =?utf-8?B?Y1IvTjJONTMwa1FjaHJLR25ObUJLaUZqeENGd0VoUEdaa3pOYVdFZVdzOTBP?=
 =?utf-8?B?N1VmQ2RPQUJhUXFmMHJXTnRVbjlQSWpHNVI2dms1N2t1WnNZSFdDWkRCOXRE?=
 =?utf-8?B?UzlmTUIyV2p0c2xsRzVieFZUYWM5NU4yWk9jQ04xbXlIcXA0NlNWMmFOODNY?=
 =?utf-8?B?Y2NzWUlPTE0vcTVFVFRUQjBUQ3Y1aXg0aFo3VWdvejhHQmVaa2N6VDh2Mzdo?=
 =?utf-8?B?Q3BwUTRWcTFobXR0YTRvdVd0KzJZVEttTnBrT3Zrb0lRY0pHNEJ1QkM5cnNa?=
 =?utf-8?B?Sy9LanlUeW0zUERsVWRqdnI1NllKRWU4bVZOb1VieFF2MTZkay9DWE9IYkNH?=
 =?utf-8?B?WThMV05yS2lVbUFMSTFlUytsQStxWVpuY09qSm1JeTc0M2k0RjVFT0p6RGhU?=
 =?utf-8?B?a0JLMk5rcUxpV0FPUnlKTEJDZU1Rc0w3QVBVTFZhdmxXTEJtTFk5TmU4eUJy?=
 =?utf-8?B?MkpQaDh0WEloU0VRWHhDdC8zQUhrdXpFQUFYR2JCSW1oU1p2MmVaK2JwSW9r?=
 =?utf-8?B?RlErdURNWE8zdHI2MWxJQ1VBUUJrTTFWcWZzRThOVW9WWGpHQ3V6R1F3OHp3?=
 =?utf-8?B?c2FwSTZQN21xRDdqaVNSQ2RIVk9nSnBkUWFXRmlnTytjNDY4N1BxYld5WTkx?=
 =?utf-8?B?SmlOUTl0M3RUUFFuWElaUUdnempPYmo2am94QlVJYVJhZlVIcHZHcFRnVk9P?=
 =?utf-8?B?OERZc0U1NWNkQWo5eitZWWFUSjRod0pNSkxOR0ZhY0ZCUkY1ZXJ4V1F0T0M2?=
 =?utf-8?B?U0hiWmkrL0hBOWhNbnIrYjZ4c3BzcVVacW1EeFUzV0QwSHgwbGNZS2FlTzk4?=
 =?utf-8?B?VnBaT2hjQ3lFZkRTZGpFdHRQY2VuTU9XenA1UHZ3eWdBcVg0aFdNd2xJaHZQ?=
 =?utf-8?B?dHVvM3gwRml6aHlsNnRyUHV6ck4rdnU3RllEWjlBMUh6YkFXN3JnZnoxbnZP?=
 =?utf-8?Q?Df6KGvkLoHzRbsRyMqHh6X+zY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7782ffb-0ef7-48c0-c758-08dc41142f81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 15:10:13.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOat5qPTp/EZgQQZUegScNJmeW++YfSqMXbNWilUx5KmW9Lcv5gWPwbGaq0O6lGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374



On 3/8/24 8:14 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 8 Mar 2024 02:01:06 +0200 William Tu wrote:
>> +   * - ``mode``
>> +     - enum
>> +     - The mode of the device. The mode can be one of the following:
>> +
>> +       * ``legacy`` Legacy SRIOV.
>> +       * ``switchdev`` SRIOV switchdev offloads.
> In my head `mode` is special because it controls on / off for
> switchdev, and none of the other attrs do anything outside of
> switchdev mode. But thinking about it now, I'm not sure if that's
> actually the case. Let's clarify. And if other attrs indeed are
> only meaningful in switchdev mode we should feature `mode` more
> prominently than others. Separate section perhaps?
got it, will check their dependencies and put in doc.
> Please link to representors.rst and perhaps switchdev.rst ?
> --
OK
William

