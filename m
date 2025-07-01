Return-Path: <netdev+bounces-202761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF8AEEEAE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79253E1015
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CF258CD0;
	Tue,  1 Jul 2025 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qh1POdkv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401A2586EB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351178; cv=fail; b=sWqvLah4CutcGv8qWJrVoAQwxqjYq/s/hhF/V7m/u2n8asql7HOj1bTnPBJOdtq/7i5JjakSOGVLSBbk+wYRXJHjdbuqTkHB9wUI9DZnlT6tLX+dIdnu9kILO/kGV0SpVY2tNbLWfNvqA6HTu6yhXgCpXExdvnRpBiLZpg/+6io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351178; c=relaxed/simple;
	bh=/sQft2yu6Ewfrg9vEcnRcaP1mTID3xQxwnaCTwP5l2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/bnuSDxtGMP7aoOY17J6drty1MJU/+s0TNnwkstSOfJo29eQXSGEAKjytTLnPUg5o38cukLwhhwcJxKwynEiws+NNt7orpYhZc67Rqfn9RGFEaddzBs/FlHhwB7eqP/s3flchpzjIafHLzyClMkJ90xgSmI5n6H/ro3WqNUHfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qh1POdkv; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8I/vhPa6ADC/v9BEZNOGggmCBgttO/JvDakZfUcqBvvlRUNgS3pySd8afyHDuQPyaxN7CF666OLLQmPSIRk7HClXXX2JNxLnY83Q74vJHaB2n3Fp/549K6f2RgdAyQQlfBd9hufgvgpWvzMLrNWOFyhP6B9JxiD4IU8AO/DymRGPHwgfSsoi2hGZJH6mcDxmstOJr83gHHiG6YEBUy9/dXAWeAYbPuLNH4F2MksMr7A+zEwf21rpyrtrD1yBTr96soflYwkvusDna3RvOHJsJhcqdSoHvhsxQVKgjUu6GlGaNklq8nvfXr/SHfMKskZCqnjeGYqihoT/OTfjtMTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ygnVP24LhYMy6QHJupn2y46zlejTx+2W3ZaTnL7mBA=;
 b=Vl0Xhxnr7L/lRRAAhT7JZFq+dVooPv9k6QZW69tHqwXKS1Pkebo1ojLYnVFAxnPH+lqTKETGzLiU1vMwyGvxIdOLpfyVKsGlbQ7/4tfZYZ5IAzRpJZLOrTAiBsOUy9eJuPLoyags+LDSNben5tkckVcIEp5wjJnKvFmxwmj7V//qhCLlqGrTMZVRXtDOuCvuvlugOXUeyDYnx8ysMFz4gyNniC9+/soekTZ3uEm/8sopnqZnEG8UHjVadTuV7zQ/wlPjcbswHqIF8JO0RzGzdr2DqZAZyldbcSWQxQLe0JrHSRP75QpBGTnHIVNRZ/G4POCJPWg2aUj/IUrti8Utig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ygnVP24LhYMy6QHJupn2y46zlejTx+2W3ZaTnL7mBA=;
 b=Qh1POdkvPbyB7hUyZ6ieYlCnI6RjM1tjj09mIViZ5I7RreW8IQvR8fJH8Q10s0qxvqmM1spHw9bgcZ9tg5iqueVCmkR209hN8ekDVcsuUVh7r3HxIv/494fR6Lk+dB/YR8CW6yNo7UFM+oyS0CPFjAQfS0Hw2EVj6ZlAdcz8sdmJnLJS64GBGZFKsRynTtZZv/OENK9WCaASbEmsI8LvhSVECUv4Pvbb5LFulFztS44sFxcXd8elWK9BEAU180dDCWKQ0sm1O9GeYUmxpG/E3UeZybAExU2xo+rq31EfQWEVgk+A14Xldvdk1ppL0K/iY5ttnnkAsWTXz3wsumGNqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 06:26:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 06:26:14 +0000
Message-ID: <ff8ff586-207c-4c8a-bdad-ebe014196b24@nvidia.com>
Date: Tue, 1 Jul 2025 09:26:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: ethtool: reduce indent for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250630160953.1093267-1-kuba@kernel.org>
 <20250630160953.1093267-6-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250630160953.1093267-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 060bba3e-d56b-46fc-4392-08ddb8682d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0oxN1NHTWUwUGtIUEM3R2FaWVJZNW5vb3hLU1FCSUNZYlhjRHBuZ0JlbjZQ?=
 =?utf-8?B?N0IzOE5GLzFnVHhnaDFQd0t3Ti95eEJKa1RzcmoyMW1ObGxwWXVsZ3haS2M2?=
 =?utf-8?B?T3E1UnRaVkQwN3QxQXRTWWUwVkhobFRrVzd0cUQ0d3haSzRQNUNrV05rSldW?=
 =?utf-8?B?dDR2UmZ5azZhOVlFTkdoMEppeEJoeHFYM3l0c292akRoYVU5Rmd6L0hzbm5O?=
 =?utf-8?B?d01IT0JUZDZWa09mMGhFUzhGNHU2SDlJaElGZ1dQbU5IRE04K2F5bUZOU2dz?=
 =?utf-8?B?anNWak90eGd2OFBSRkMrNW96dlJBZ0J5cm5BLzlkRUpuMWdnVlk5ZkZVOG96?=
 =?utf-8?B?Uk5leXJaTTF1aFFsZDVCbnVtN0xBWXdUSGJuTXcyTmlKTkN3SHRjWTJPKzZh?=
 =?utf-8?B?VStYSWRUd0hYVGZWbDU5YXhiamFhMC9pQmptZ3JJcEdDNTkreWJkeTB4aEho?=
 =?utf-8?B?OG9VZVgwSmNtUkZHazdBWkdRcmxwWU02SUx1SzN5clhhbkdYY0p4a2tieVVD?=
 =?utf-8?B?UllNSjNjdmd4ZU90dzJraStmc3V0WnNFcmhxb1pQZFFrUS9ySXdBK0pqR0pI?=
 =?utf-8?B?aStLZGg1UEk4Y2orWkZ5dURtcWhTbm9HQjl4Y0hRdUhmTFM5blNMTGJ1R0tx?=
 =?utf-8?B?ak5DNHRKcTZrNmhiN3gwWEFuRlpkRDhYMHhPNmk4UEZHeUkwVnhYRHBGc2R1?=
 =?utf-8?B?dlBjbkRiWE9lSkk0U3czaENVVDNnSzIvNDBwWHFiaXEranphUVhwb0M1TVdy?=
 =?utf-8?B?SzF0MGJMbENrTG5uMWdxTDZpdTB4TlRiL3BUcUZ1OVNEejA4WXRlUzF4MEJm?=
 =?utf-8?B?dmNiSUNKUmw0V0E3c0l6YjNBeTBvME0waVZNZm1wMktOeFBhb3RHbUh5SzRU?=
 =?utf-8?B?Qnowd1p1djhmMlNwNnR6aG1wZnEvdzJMT3NiRmlVSFd2TVJEQTNNL0EyMlRi?=
 =?utf-8?B?dG9XTE9NK1FRZnlVOWhGMjF3c2FQc0ptMm1zWnNZSlUvK21FcE00TTlpREEr?=
 =?utf-8?B?NHRXUTFXUWVab1YzcEtEajlwcWNaWFpSNzh6QkxZdWF6SS9WU3RlbWlCNmwr?=
 =?utf-8?B?ZlZwNWJ1VFlhai9oTjR5VzE3TUhvam5INnJML1YwSmJIeTM2MUtYekRyUGh4?=
 =?utf-8?B?NzlDeEFBU25vWnp5ZXFVYzE1d3dFd25qREZlYnZuVlJsNkRkejFrckh5ZnhI?=
 =?utf-8?B?RzB4SjA3SEt2bkI2MC9xOGU4TVZJZzdocjY4bFg5djVyY1B3Y2FaQXNSSlBz?=
 =?utf-8?B?OHk3b3NjdnJhY2RxNVpQZ01TVUd6Q25XdWJJTWQ3bXljeklvNkgySDJVVTgx?=
 =?utf-8?B?MEUvT0R0Umh6UEdjZTk0WkN3bHJ2bGFmVUw0QjU4VHZGbGFvN1FLQWJOaVpS?=
 =?utf-8?B?Y3VYL1V4cG1ZUXRvWkFLSkxnS1RmL3U5cm9UeFlmWlQwYVVpNWx1cm1QS2lB?=
 =?utf-8?B?WjdZOTdTcFUvWWhHSXFPb1VScVlCK0NwSTNDL3NlcXNrbUl4a2lpWmV5dWdo?=
 =?utf-8?B?WFRmb01DUVRLNjVkb0VJd1NBWEQrMjNIWDdEM3dCKzJDMEhKOFEyYk9mL2Zy?=
 =?utf-8?B?V2c5YUVLUVA2WDhDejZqcnVoKzBIaEk5NTgyOVFVVmxSRWx2MzlZRXFUOVJv?=
 =?utf-8?B?RldxZ2c0SHF6U1hIUUg4WU45WjduMUkwVG15S25JeFgwVlhUdkRwM2hzY3FQ?=
 =?utf-8?B?aU11NXR3aUlPV3gzUm81TEFRN1NmQWRXZnJrekt0b25ZUGI3S3BJam5obkhZ?=
 =?utf-8?B?aWxBZ0N0QlREd3pabDVocnNHNWFxdnFaQlMraW85MGZ5cUdKVXlpck4xK0JY?=
 =?utf-8?B?bWY1RGg5cnJTbkV0ZVhiWjhFK1pYeCtlcndweW5EV3lIc3Y4Q09kRlZoVHor?=
 =?utf-8?B?WnlFYXV2UVAxWmQ4SkdHamx6ZFV5MEh0enZOMTlnOEJ4NEJ0NHc1SWlobEl6?=
 =?utf-8?Q?YiJjLPvJzts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVUZWlEejdFbnArelcrUlRrTm41TytVeEl1MGNjbmM0czhnM1FWS2lmOFBM?=
 =?utf-8?B?dHR4R0JMT0FBMzB5amFxOHc0NTFxZHBnNGU0amFXQWdRK0c0eG1Zaktxbk1S?=
 =?utf-8?B?SysxcTkrdVczMnR5cnNZMnpvalhuMTRjbEs4cGV5RjJKVzdMTWJ5NmhjMEtk?=
 =?utf-8?B?RWFuK1F3aVZOUGN4aEZHeGo3MXBTbnlvMW9LYld6OFdZVmtUUWVlRkNnQ29O?=
 =?utf-8?B?Y1VBSllFcEFOT3pRWHZJbUVYNFBJeGo4endVMW15aVhScUJSRWpzRVBLZWtF?=
 =?utf-8?B?dW9LdEZTZ3l1UFM3eWh4RUNNUVlmMjIwNkZQYUhhbDhCQ21zTlJzM3hjdDJL?=
 =?utf-8?B?cURLLys3SVhuYjRPK2dDTTZTaFpodW9sVEgveGNmT0YzYUdGQTFyMGJnK3VG?=
 =?utf-8?B?UUVDeGgwdEpBbVBNRVFBVFR3RDFZbHdFNTAwNHBSTnJuT2RvZ2xUR3NUK2Mw?=
 =?utf-8?B?elVFNGRRc2dkZ0o1UzZEMHRNeFRkT2VJUytSYlFJa0tYSG9PQllrOFNycXlV?=
 =?utf-8?B?K1FtaXZVelFmTXZTRGphOHJmRFJsZlRaR1U2S2xQYnFNK3ZrbFlPbytsWnpv?=
 =?utf-8?B?a2UxckdkK3J1VGxMWER3WEJxS0pZa05YWFZhbnVnNjZIZkUwNWlaZkZYdVBs?=
 =?utf-8?B?NUVjZktrQkNpcndpU1Q4YjB4TWlYUzE2anJ6WmthWWRoenVPL1FtaWxRZXp5?=
 =?utf-8?B?WERiYnNRWTM2VWNnMjZ6NVJVN05XUlRzZUFPZkNPRnczdDFWTEJLei9zaGtN?=
 =?utf-8?B?RDg0L2tlV1laMHJTWjVqUHFQU1FMOWVjd1prZ0YvMURFS1dzcmxGdVp0TWlX?=
 =?utf-8?B?TUthVEdDQ3NKV1NKTVFVSStHdHVxTXlRVDFnVmEzemZCNXN3NDRjSTlKWHdJ?=
 =?utf-8?B?VElENysvTjhOVXpDbWxLTmNReWJKNHRSbVB2dEN4Z0tsWDFrY2dlS2dvYVYv?=
 =?utf-8?B?OFZ5QWtqN2xkemhMMlNsWTRoZ0tReS9TS1pPdHUwam9FcUFNa2pEaE5YK2Zh?=
 =?utf-8?B?UXVFYlBBZllvM2I4L3ZVMVNUR1FneEFZVDV4aXlrVmIxWEoveFRDeEhLM2tQ?=
 =?utf-8?B?VGVzb2F6cVVYdHJmNk9xRUxMMzh6NUxDZmcwaG13OVZPNzNrcTlKNVdLbERm?=
 =?utf-8?B?WEZGNkpBUE42RXVjZ1l3UnRUZWVQMUkvT1pmMU1qc28wWnpMMkVIU1ZZa3hV?=
 =?utf-8?B?cUVGMXdhL1d6bU5LNlBCZWt0KzFxa3ljUkY3MGp2dlpwRzA4U2ZoaG1LWk16?=
 =?utf-8?B?dTFEc1dOL1d0TjdFSTltRHgvWjhQdFA4TWFWdCtyWElmLyswa0pTTlVCOTdx?=
 =?utf-8?B?VVQ3TXRUcFM5cXR3TFFJenFNbE5adVV3UThMbkNXNW82RG02ZVAzcWxCL2dH?=
 =?utf-8?B?a045anZrOGZja2tGc1o4VUFDRlBENTZOT3RLUE96czZKUkZTZm1zZHBwb0Fu?=
 =?utf-8?B?anJMbDBkTFV2b1huVTc4M1VkTXVUM01GUWNYek1mdSt2R09qQUJtQlpuV2Z5?=
 =?utf-8?B?a0ZyNnlqTU0rTTBqei96d0V3Ry9lVFNIT2JZcjV5Wk4zUVF2OVdUaGw0Z1RL?=
 =?utf-8?B?NjR1UHlVRDJQdVJiVC9HR2hPVHZFd0ZpUzNGMmkrZnFwYXlVaGVqQ0ZBU2dJ?=
 =?utf-8?B?cjRPbUZDNWplek9WTmhMdHRoYVBaTnBOUG53Qlc2eklSRkNPaURFOUJSNlJU?=
 =?utf-8?B?OXd3RXVwYUk2VU5iK3RBSFFZS0dydXhYTEdnaUkxSTVBTm1WeGE4M3lWSmFC?=
 =?utf-8?B?QnY3dEl3YWRhb0dVMi94UmFnWWJCNm41alhFeWxzMEFZMHM4YVd5RlY2KzVp?=
 =?utf-8?B?ZXp6ODhOa3pXdmlrMXFUZXpLMjBtenNCOTV3ZHNGV1JZRzNyb3lFU0RlTXNu?=
 =?utf-8?B?YW5McUdYUlhQcXZVR1F3VVYvZGxSMmlub2JRQ0lMU0t6MWhPYUdRUm1CSVAv?=
 =?utf-8?B?NkorU3NSUGZoZDBnMDdITXFpZkhOVkZjMTdXSEMzSHE0djU4eXpRYnJENEVT?=
 =?utf-8?B?c2trR1JMRS93SWpCbkdkVHZDVlF3NFBpd2xGVUxibXg4VHFUcFRrUlBtQThx?=
 =?utf-8?B?SFhUak5ZMVI0bEtSZFhVa1NTbTRvdjVOS25pRUxBbVpJTzVnb3lTZXBlR1kx?=
 =?utf-8?Q?/reI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060bba3e-d56b-46fc-4392-08ddb8682d9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:26:14.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt5S/lO213Srm8xQwzBWtZoou5Ih4ZkrpCAze9lWEhISejbl6oV/yrujdJoozsUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On 30/06/2025 19:09, Jakub Kicinski wrote:
> Now that we don't have the compat code we can reduce the indent
> a little. No functional changes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

