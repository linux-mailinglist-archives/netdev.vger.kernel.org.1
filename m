Return-Path: <netdev+bounces-276950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H2rE6iS12k2PwgAu9opvQ
	(envelope-from <netdev+bounces-276950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AAB3C9E06
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC76530116B1
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5A3C062C;
	Thu,  9 Apr 2026 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyFXM4Rq"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39B39D6C5;
	Thu,  9 Apr 2026 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735425; cv=fail; b=XeGuCrUX+7f0xoyBXl7vdxKvmBKOprO05PYNYjPwfofwIc+e3FrpGcclqO1xdCCF3JBJBpeXbTir9l471fxLeByXYdcvYOGxCACVwPWSNiROwH2I5A3Bk4M+uYgpAYOyVpIpnsXpdAli4hxIrf3RSpnK4QhwmfEEEuSQK0R2FGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735425; c=relaxed/simple;
	bh=Sb28UwTBpZ/Ua6AqHZfzKmNQwcMBRClhnHQl35DWIHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlTixalL0shMwNSIsoSn4NsnNV0TOHk0NII6/eoO4ti7M/ESSdtUEYeuznejgV98vX5VCMJ9WGd03eJ7Ljdn6HePQSqZ9Djp16GabhNx5knngFeEQUCL+N/SrzmGsdT2WFHwVGIEx9YffBqQSGgDSTtEpUbTuuBImUgA0zmAoXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyFXM4Rq; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCzJwoJwrw8UqezplLFYdq2cY11guBxQZNItqvktj+Oxhsr+8GFqrR6RLckCQAqOmOXA/dObKw+huZLFtwQjssv9z4VxoPLhg7eyLHGZF3zlU7lReW8CTvldD0aQ/qBgG+9SwDz2aYz/vHh8AEf+2naLlZ7D+2PYqv/xdIwrVtnLiUuS7CfG62tGLcyaS1WJlI/BEkjH4e/mrUsO9L6wpl4qRage43bhQYp6eSuFAmsAr0uyeNCGmJnFlA2hJG9dx6RotBqZb2T5LkvAdzqPOjwXOxnw3jVg4Pe1s79gaJStr5KgBe2jSrVCh0fcESY9nTzZKVK5kkjCYL8Ze1z9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5F+nKVw+YMVadcxvQy5vz/N77ZpKwcCmL+iiTee7wk=;
 b=aRy7KZkSBHWixMTQs77YvJ2mtFFDFsRgtT9SAjZzQ3qorcaPI/T3z/cVtWMX7yMC/3m/5v1WBUMY0r/ZWKAsbad5L+sMP/Uaygg5qi0wX4p5OSIjF2nemujFoWYJIfJACXNYH/vkqZVybIP3KkRsR/2RqaJxRYS/JtUjvUEkT4hB/hO/p4ZjyXBcINzVPkHip6WMMJhgCKbVlljieQaeLIDrecu8h5zHsnuMtx0ZlzkhaMN2GIkl+qlEqWaDe0ONKj2/gTPooLPIydwDaoqeaK5/jE4INQLorgtxAX2QDvyUqgrbWjYpv0rrQ3eK+UJiIq5jFMA1Wwk0JqklVYpPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5F+nKVw+YMVadcxvQy5vz/N77ZpKwcCmL+iiTee7wk=;
 b=tyFXM4Rq0bWshilpgVNA2jsA2v6w1vGVyTs+AINjexlM26o7GIOjEd9K9agTXuU8ETaJpHalyrEke5+znQIwY3sPGuCvo8U+26os/I8Ul+njIA4njbAMOA7eH1TCBif+6yVsM4FobOUvXeSFokKIMP075Y9/jtGYqViQUo8J3nrL8LOOTpmSUCDvXEwb0/2oVN1pGAow5owrYiMEt6xE4ux1hiLcN3Yj2ATAaeGM7fSoMIAHnR5+rhM9tDT9+DmglO3eMilkNu+qFH6YELqqgOcQ8hMx8KUn8sXC2ozWqZ0mGCMeLTJ5cIkteuFWar8U7TuqQ5vvHCIJkaWrumLkxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 11:50:17 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 11:50:16 +0000
Message-ID: <c2629827-479a-4512-8ddb-c8abb82b1e86@nvidia.com>
Date: Thu, 9 Apr 2026 14:50:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: py: add test case filtering and
 listing
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com,
 willemb@google.com, linux-kselftest@vger.kernel.org
References: <20260407151715.3800579-1-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260407151715.3800579-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: c85a7089-25d1-49dd-014a-08de962e2aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uRbRxhg0C4IrxyqjWkBSPWJasXA08m0Emg6aoL32j8NZ9elNpJcDJ+As819ffg5rOf+43gs+XVxAHD0oejnIkFR9ig6YerJwBmu19guj9MDdL7wOEq47tfz3s2DDAqaGwSx1CSEkywe/mkOEBnBPlxPwleOIpevl4U1w69910SzNdEqXrvKh/jMwgX/A35bIqHInaUwDnaebqLPvechm9kewkq+GtaNI0IKGD8JGuWg92ebgbnI9LE6YSZPBbIvhg3eoOt9zNHMKkQdBHrvCzaf9iXjLHd8VHrUyv+PcBictNmzQ/eTR1cQW8vtVg/9zLtyy4rf4QOKFLB1cYOLBlpvIswFAjK+rL8dsPU+xxftY2H7P8oVx7xLQhjKaDXHidh3vIvTgnIwWVSCTRdA2H8NQjhOCZpX3HCPUp6cAw3vKsI5kpVKN/7PDIYVmH+2vHhmyW2e6P7D9anC8yAUtiLC0u053CTDkJQwKtSAd/LbkrP733NjO+YXqidnh93KTwxx57KpdBFeMzUuhANV6Xowk5GvKEPrI8gjNTn8/1QDfjQq41pddjXpucATH7QyMxry+lIYQfp5vxLSNTEJ1lXExxvddaUIKfFEVIlek5zY5TbkgAgRmDiIRiXrWnqWQxN4NHnqGErORvzRtVMmzthSkm61SQuaFli2lLg9amtfebKOa8U3Nkf9OEMLaadTfAYGgQrADQUVnTSbYPSdG8YM2tEjvskn+r7FLsTez5GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJCcVpFNUdGMFBPZkZtUExxNVFVQ3RSbHJzNFI1YmJVMWFnekpOSG53SnZK?=
 =?utf-8?B?clNWMEl5dU9idE1EQ1NXcXBpdmNjMEl3aXptbXJXOUlkTnQvR2NINnIyNzZy?=
 =?utf-8?B?bStmZXFXYStVNFBXbXFmeGlnV3F6MGtKMVNFWlhUMS9oYUpkanM0MSt4aXNW?=
 =?utf-8?B?VnFaZlkxQUxVNFBmd3l3a3JtWDlhMzJWRnRDdDBJV2VCVWo0OVJEZzBHMGhB?=
 =?utf-8?B?enFYNElXNWZ5VDdxOHBaaStyUTd0bXJkc3lmWVdleFdXT0k3YlVNdTBwQXcz?=
 =?utf-8?B?b3BZaHJ1eXMxVU05bzNVTFpqeEtLOEQ3bWZJWm8zUytWekQ5NnNhL2Fwdy8x?=
 =?utf-8?B?bE9jRzRBTHNPT25WMVhJc2M3UWdYMFBhR2x4RThXdERZRUJ3c2xvdlNYN3dq?=
 =?utf-8?B?bnBQYURnWUoxT2wvbzR3M1RBalFzZFFNd1RwMHJXWnFmQWZ4WXJjMk5BN3M3?=
 =?utf-8?B?cGJHdG5GTWxMTTBJdEx4bEJ0SW0yWmg3a3hnNnNjNk9UbTErNGIzYmF4RmxE?=
 =?utf-8?B?QTMrRlpGUFRJYVVCc3RsU092R3o0YWFVdmYvMlJoNXE1Q2RGSXpZVjJvTThx?=
 =?utf-8?B?R1RqZTYrRXJUSDdSbTBncmVCRWV6ZFF6YU5FMWZ0UHhBUnVnT3pJWWdidjVX?=
 =?utf-8?B?OUkxQ2lyemh5T21mN0dZUENXelc1Nks0N0x6OUhLYzJsdUJKa0xzRjBOUUJj?=
 =?utf-8?B?UDdMc3hOSngwMDZQcUthRzB1TGxIczB6c2FWTktCMGRWWmhDRTdVaS94Sjk3?=
 =?utf-8?B?UzBwaFE4Mll2QUh5eGovcE40eXdhL2RCZXJZcFc3OE9obWxMVU5kcUNQR0do?=
 =?utf-8?B?ZWFKL0U3NERiQVZpMEN6eHhLSUdla2JpRlE2OXRMSXlQNXpTYi9mSGt0NjN0?=
 =?utf-8?B?eEZpOWdFZ0dDNmlUYXVvQ20vS1h5a2JRTVUrVGkvZk8zckhjSVRPd0RGMGds?=
 =?utf-8?B?L09jZmdDeEdzTk1hN1IvZG9VZmN2LytNWDMvL3pIWlUweG1xU2V5SDJLUmF3?=
 =?utf-8?B?ZkxUWm1HRDlKMDRVcWFGMnZYTzFndG1HcEtnMzJtOUowQ01MNVJxc3NFSGJE?=
 =?utf-8?B?TTl6RWhHdExMVjhJWHMvNGdUNFYrcmEwYytXVURNNVljSThHUCtOM3htU2d6?=
 =?utf-8?B?ZVBLYURYbklRendORFIySXJ0SUFtd291ZkhVUE1KZ1V3Q1lIM2V5WU9SUWwv?=
 =?utf-8?B?cm51NlNvOVR6U2Zsd2hKa0dOY1l4TGxYcXJ4bHRDbHFIY1dmMHppY3lKMi9l?=
 =?utf-8?B?dWExM2Zlc1hmUDRmUHhXbldLTzdTOUJDN01tcDM3eWptT0JzbWFyNjZ2NDls?=
 =?utf-8?B?bWNxNy9RaWNaVFlpeStuWi9DZEJPeFI0cURDNDFOWlJOUWhQaEVrbThTb29J?=
 =?utf-8?B?bWNXcFNVSXI5VlBmdjRqNi9taE9NdWVPcmVYRUowS3RtT202ZWJmcXJTNjZU?=
 =?utf-8?B?bFFMTnZYYnQ3Q2xRNThlN0NLQmNOQ3VEV0pJdjY2bnFqQTFLbzZralhRQVgy?=
 =?utf-8?B?SmJpMEtaQVR5S2tHTjF0Q0VkMjd1cDhhMGp2aGJySDE1Ry9MSXpBbCtaRkpo?=
 =?utf-8?B?UXdoT3ZWNkJ4WXVIL2FjRENJOFZQQzNhM0FYdHJaNE50UVRQVjRJT1lIUHJM?=
 =?utf-8?B?Z2ZjWmh3a3lERlRFZ3Q4bUVQWUFXclVJdHFhOEtrZlVqbWRNWndYYnk4VGJC?=
 =?utf-8?B?WEpPVDljU1VESHZCZkxQb3BDc2ZMZWVHZ0x6dnZWdm52QzUyb3czREZYbTdi?=
 =?utf-8?B?WDk3U0NTN2U2eGZrNVF3dEx4Z1M1N3NqZnFCZkJYaFBUNlJBdkFHa0I4NUlE?=
 =?utf-8?B?L0dCeHpEY1lQaE1rY0RxaDc4VUEzRDZVUTJtRXcxeDgzeVdnN3RDV0YxQkNZ?=
 =?utf-8?B?RUovVDR5N2lORFk4bEU0UUZjU0lpQlpqdDI0U3I2dklIckkyb1ZvUHJVZXZP?=
 =?utf-8?B?RW5GUm5FcTgwMmR6dXpwNGZwdjJTT21ucXgvbVA5MjdBTVltcUk2RTUrU1B6?=
 =?utf-8?B?K2JmZ2VBcFZrZFg4VjNCczRGeGxkaXZjSDJtZTYzNko0Tmw2ckNuTTJyTzNF?=
 =?utf-8?B?cHcxdndleEYycWk3L1c1S3d6aktFMk5INzZ0dW5pUXM0RGluK3hhL3RYdnN4?=
 =?utf-8?B?dEJFQTlvc3R2SzFLb3BGb1AxaThZa1Fuak9Ja0R6bWVwM2w2UTA3TmlXdVha?=
 =?utf-8?B?WElWQ3F6YkxTK2ZoQTlYL2Rxd2pVL2Vrc3hFRkFJejBkNjZLVkUxSGlJNkRV?=
 =?utf-8?B?d1FPa2FRMHk0QS8wYTg1amdrSUpyeHFjK09WVXV0ZFRZL2dRYlpyMy85aHhU?=
 =?utf-8?Q?5KUcfdsOKNrFLhQDqy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85a7089-25d1-49dd-014a-08de962e2aeb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:50:16.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13t3vd+KEYCfytdfT3Ud5jKDU3ADedYJlCvx2d+9IPkzXs9zonjXyj4Oyt4W0/mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276950-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 53AAB3C9E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 18:17, Jakub Kicinski wrote:
> When developing new test cases and reproducing failures in
> existing ones we currently have to run the entire test which
> can take minutes to finish.
> 
> Add command line options for test selection, modeled after
> kselftest_harness.h:
> 
>   -l       list tests (all or filtered)
>   -t name  include test
>   -T name  exclude test
> 
> Since we don't have as clean separation into fixture / variant /
> test as kselftest_harness this is not really a 1 to 1 match.
> We have to lean on glob patterns instead.
> 
> Like in kselftest_harness filters are evaluated in order, first
> match wins. If only exclusions are specified everything else is
> included and vice versa.
> 
> Glob patterns (*, ?, [) are supported in addition to exact
> matching.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This is very useful!

Tested-by: Gal Pressman <gal@nvidia.com>

