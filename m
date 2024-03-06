Return-Path: <netdev+bounces-77769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EF872E3E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 06:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E0288131
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 05:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C91179B5;
	Wed,  6 Mar 2024 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCWgbomY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF59D502
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702293; cv=fail; b=UHVCgddsT/t0A+HFFwWQXizEny6Yh0J6pIrYuD6tksDD26Le+S6pRH/Ud+LyePbzhhEdZAm67jRJFJGeWkBo5K2qdMq7D1MtNR6vE995j0tq8soInwtFTF/XqFDj4afTothXD4tjl8Qnkbl3o1uIj3UXT5s/zMNtUz7lu2VgYss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702293; c=relaxed/simple;
	bh=05htkuv7TAeUU9p7sd+So73BX3Or+tZXV0K6ZsUBxk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Khce60GSMJprIQSX8HmIMPYmteMD6mvaEe/TntdI0UWbw+eddJJRJZfE+xE6Iav5RBNByh9zA7r5lMQDuhuci6Au7+HqtLg71dLCG80JbiQtspTpYbVTO2mBJxMWJWa0kRjnj+bTf868ziR/7aR2XlDtq8Da9lIdfitAqgxdDY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kCWgbomY; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDLJtZxkJpVLeFzl1sGQux9AoKry47XpdTEoH1KUvaXzQmKv//QwIra8m8SLBJzqa/FfW1n8mfzb5UazC5dLhyDBg4hOVmwaQIOdwyiDkjis3BCEcHZp1oYPCCGkjYRof1jweCd0X9dpzKKCDDPBP2Hu+qcGlb/FM2vJLdgD+m8QCZgymuMfEDWljk3vAEHmcqITwoqjUeYMu7ogv1ElUDW5+vDDbRdoG/WLsgL59GaKC5K9E7KWSyxVsc23Qf+5ZgvSZS/oFUq3kAz2CtY9Aw5sBubwR5dnAUvBwzD553Q4Wo9IuIzER+x2bldlp1eCdTolhezSOW4QuqZbgNkBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05htkuv7TAeUU9p7sd+So73BX3Or+tZXV0K6ZsUBxk8=;
 b=dGmhmNCIvRuq6WqUr04T8Ty556ZxlZYAqHxohAGMHMic1qPYEH4Cg6a9kziumQJbxmBOxeC5mRHV4SS6YX26sQMQUSYQCiIsTeWKJi3iqQTlbmMJnR1sPyl7eePSsgnYIM4mVApTzvNU4ARZh+ekEzdBVXtvWdfkQjXDVF6oZ2+j1rFHOOo202ZHPQ2GxdPiS8O6/cUK+CQbHq7Exy+fpXCUOqp53cU3KoOE6KcOBuVhA+z2B0Sd6M6ep9zFOJ1ujJbrToaiUymvalN7qDtdSrjGIHtX1JPhH+R1WMzBgDj0OYlopFZh/X2oe1u7nr4t7s8nJURWjedYJT5Uj3rbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05htkuv7TAeUU9p7sd+So73BX3Or+tZXV0K6ZsUBxk8=;
 b=kCWgbomYezvOBFVA4ZABZi3977b8WIK28KvgjvcDa8En8PRdX3Fik3XaohMm5sMP92lKMeDX2JdFebDH/IieaSajFiMVKWCoV3dEgeyCjuZcCsBoTAvLPVtAumRkBsdW2RLGoW/uYs0lN8IduWzmPzkws2MZAyCntKl/TxTm3cZCiPMgLqvlyvmGDkwcNEeyVv+f/sqr1KUeE6TqOaT8AvOlWfBIMNpwB0uvi9uCr3hySIWPArViYML/iTT20mQlhU3Lk0VIjFff+a8MnyeyfNYvh8SKVG1jPjj/NswEQW2KqiaZZ0v6hU9wB7/LBjQBhiATz32UzCwf5LdF3ZvA3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 05:18:08 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:18:07 +0000
Message-ID: <6da03516-4c77-4f8b-aac3-ad1598f6d6f8@nvidia.com>
Date: Tue, 5 Mar 2024 21:18:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com
References: <20240301011119.3267-1-witu@nvidia.com>
 <20240304203758.2fd0f6be@kernel.org>
 <49a53cb9-e04d-4afa-86e8-15b975741e4d@nvidia.com>
 <20240305183049.2f2b8490@kernel.org>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240305183049.2f2b8490@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 24476698-36ce-4630-ef70-08dc3d9ccec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cST6uonoiYvM5JG+ocrnZUcXKQfI2Kwkr8D3DDBaWGsPUEwHtyKU6Z3BL6r1IXwvdlZyZ3r7UXmEHvH17FJuiSorIQsUJ//bgNTnwMWYo1wZIl30x6CAvq6T4F2OeSsM2t0y09mwiJjmkZoncByh3/MhpiZJrfi/XzOHuiFzkG6WhHsgpuFLeXLhtJE0fePcA2kmjjBLZLap2aG/86BKiaOnrFa2mBXiUdU4AztNBVWvOmUIfbPmElwBt6Ix48qPNYjH1DjX+m1Xi61w3oJdptcbRh83m+XbN6iMj4KWE+s8We/tIvxkhA87WMLbpp3mjQTw0jY92ivwlcooPjhvW056HU9HEJX8vqxwLdjx4w+VavJyrltq20l/0rtLBwNzFZbCtAtyEzuoSdKTFMU1ZWuVuXzX84NB9IwWZ5ZXczXQ3XrTn8ecjrWddl5YsFjcqdtFZJPC/RibcR/Ug7F51cKY7ymayn/dR7xhL+lsTWLwus7oVse6ybJ3B+Dkz6yfTJidddZA2LDl9bl4AuOs2F10+7hcgN1zme8PZhO3Z5OBIHo3nAdNaZGkILVkCaH4ebRoD5Pf0UlC1Wts3D5jF0bjr98lX64fkqtSvA1qBx7jq5zssTog8mc97YSzU5q76f3CBUKvqEeR8Pp6bbJjIGKm1+EBzwkJ21LeKdSeXms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGppNUpDUFdaR0VlTEk2Rkg1TGloQ0dCMUNlWXVja0JMdGx2QlJCekVjQ0xu?=
 =?utf-8?B?TFFHTVQ0anJkUmszZm5tb1dTUHZKUU1HeUdDaEk2M0JudTRpK1VGRUN6SDlT?=
 =?utf-8?B?V0ZTOXVrcHd0OVJ6bzFwQjB5QWMybmNPbUFEeWtJQmlkaUxTTmd3L1U2b1Ft?=
 =?utf-8?B?UXFyNGd2azd2Q2QxRUpEa3MwY0psQ3VDQVFtdCs3ZXlDNndrSTBtK3lURjBM?=
 =?utf-8?B?TzBNVjVKcmxwalJCUTdpazlaWUtrdGZ2TDNDWFQvODNKUUpvUVNjbzJqTUN6?=
 =?utf-8?B?NDk5MUk1MFdnZXdQYWthWm9qU2RFWlFBZ2lqOUxHUjl1bWlwM2NqSUJGSVhM?=
 =?utf-8?B?eTFEbG9lV0tycG1ENGNEM3ROUVVtTEp6ZXNmREJlMlk3ZXBlekFTUVN2UldH?=
 =?utf-8?B?clBjcmIxNnprdWt4ZjViOENKQk1YY1VTL3Fvd1UwQllqQ3hYK2VzR0YySzRi?=
 =?utf-8?B?WmJ4bmtFM2R5SEp3NGQ3eW5uNzROYmcwa2MrYStYRGFXZHJZbTFOWU4weG5U?=
 =?utf-8?B?UVV1Yk5CNXp6dFdLaDZOSFZKZnhNSWdIRkRIcEF6Nm5iQVUyUE45S3J2TFRT?=
 =?utf-8?B?VGNoRzdGQ0dlTDhQNWpEbWdDVGxZdFJnUW82T00wcmNCQ0hUVGZwNjRicW52?=
 =?utf-8?B?VjBtc3NjWnllU1g1NjMvekUwM2hYeEZyNHhMclB6S0ZDeEtoZjVKbkVMNzJz?=
 =?utf-8?B?NjdlUzI3TTBVRVZpZkp4dTFwN21WbVpTZ1oxcDlTbnk3S2NMT2tkU2FvbXc5?=
 =?utf-8?B?UmpCTXZIRnhuWk02VWJiSVZMRmF0Q0h1OVdSOHE0aW56bDJnNU0yNHVSUXEz?=
 =?utf-8?B?OHhWUVVRQVpsOUM4M2dqdXJ6OXFnU21XMzNuMmtDb3FMYUNTbUxML3VXZWRL?=
 =?utf-8?B?andFWnJWVE1yUE1sUU5wLzVDVEFxbXUvTFpLelNRQ1RTTjREMktkZmllQ2FY?=
 =?utf-8?B?SE0xUHcwTnZBQW0waFNyaGk0YlFxUEwxeUo5SVdUUWVQWUpFYmhpeHZTd0Vl?=
 =?utf-8?B?UjRrSnU0SHlhVDRENnhiZnYvM21MMXE4ZjZFTEpzajFxTEFRZUd3QmJJMFdI?=
 =?utf-8?B?N1RrTnRONlp6NXBVWXkxVmQ2ckFTSThYeHdPT2MyeFJFZUd0bHlqQmE1OXQ1?=
 =?utf-8?B?SHJ1bTgwUVQybVBsdG1BcHRnc2w0c05iVkZ4d0pmN3Z1NllkZE1HaG9aL0pR?=
 =?utf-8?B?WlFzSzRRRklVWnZxTTRJanhxazNqYWhmQ05Gc3ZKbE4rVWZuN1Z4V2VrcmNs?=
 =?utf-8?B?N240MGJ0T29tQzJ5ZzYxZFdZaGQ1bUlkVk11MVpXOUhkMnlsVXZraCswT0pi?=
 =?utf-8?B?aEtvQnkxeUpyT2dpT2ErK0JzK2hobVlMYkEzUGc1QmRtd0N3Wm54cFVPSUtq?=
 =?utf-8?B?SG9aVmpjYzhYOFRzSXl3bnduREtpNnRLQzc2bFo2U2psSnBxOXZ6WmNuZkVi?=
 =?utf-8?B?SFI0Y2phaWppWjJrMWRtWGR6VXp5S0hnSVIrbkQ5TlcrWm9SUGFZeGFBN1Ur?=
 =?utf-8?B?YXdUVVVLVFl6Q0haZE9tRmMrajNiYWxUOE9kaE5LdFQ0VXRZTmZIdEs2SWYv?=
 =?utf-8?B?eThKZW1XT0RyWllDQXFWVWQweDhrZFgwMXZIN2xVdGFpbHJFMVNxeXM4bDhV?=
 =?utf-8?B?VVhaSng5VjQycTEzalBBTm9zdzBGRDRLT0tNT2o5QWNEais5WlkwVWJxSEVJ?=
 =?utf-8?B?eFYzaUlRcm11bm4wSUVZdk5VVEZZc3l5aUl6WUxHS295ZDdIVVpmVG96ZXlm?=
 =?utf-8?B?VTlnR2pSeDNoZ2gxVFlld0tTVDFrZmpSbjlpQjdRSXg0c2NIODcwRWVlamtF?=
 =?utf-8?B?SWVSOFFiRjY2b3grWUhjUmloTVF5SGNRVlB2SHY4OGkrZ09Ka1NyNC9aZm81?=
 =?utf-8?B?bDVYcWJzTVdsYWFEWU5GTStDL2lJV01qYzZBK3RsRU5iK3kxN3pBUGVrdGJX?=
 =?utf-8?B?NU5BaFhtVWNWU1E5NktaSW96TG5VTVVDUDB4QTJKWE5Bc2szWEVvRFZhdFNk?=
 =?utf-8?B?LzIvVkIrY1JyL3c2NzdXMVI2MXhaSFU1MWh0aFJSRzhUUjB4ajlVRDh6UTAw?=
 =?utf-8?B?Si9TR3orTFA5TkRmdVNTOWR0SUVVQmQ3VXVqREpIOERSa0dUOTdaOCtiNnhP?=
 =?utf-8?Q?jF0OyVb+PKSr+YhH6MOSX+T0Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24476698-36ce-4630-ef70-08dc3d9ccec8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 05:18:07.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo0lH33WtB4ad/gCZoaXmQPvRtrPsYjCIkyzhdvj//qnTXNRP7qcIr5NFiSqvN3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243



On 3/5/24 6:30 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 5 Mar 2024 16:27:50 -0800 William Tu wrote:
>>> Can we use bytes as the unit? Like the page pool. Descriptors don't
>>> mean much to the user.
>> But how about the unit size? do we assume unit size = 1 page?
>> so page pool has
>> order: 2^order pages on allocation
>> pool_size: size of ptr_ring
>>
>> How about we assume that order is 0, and let user set pool_size (number
>> of page-size entries).
> Do you mean because the user doesn't know the granularity,
> e.g. we can't allocate 12345 bytes most likely?
>
> For shared buffer (the switch buffer configuration API)
> we report cell size IIRC. In ethtool a lot of drivers just
> round up to whatever they support. We could also treat
> the user-configured value as "upper bound" and effectively
> round down but keep what the user configured exactly, when
> they read back. I like the last one the most, if it makes sense.
got it, I think that also works (round down and keep user's config).
I will work on next version, thanks!
William
>>> Do we need this knob?
>>> Can we not assume that shared-pool-count == 0 means disabled?
>> do you mean assume or not assume?
> Sorry for the double negation (:
>
>> I guess you mean assume, so use "shared-pool-count == 0" to indicate
>> disable?
>> That will also work so we only need to introduce 1 attribute.
> SG!


