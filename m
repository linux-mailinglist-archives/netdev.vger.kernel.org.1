Return-Path: <netdev+bounces-175607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85724A66B8F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2C51776F9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1971DDC16;
	Tue, 18 Mar 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6hCWEAK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859E1991A9
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282787; cv=fail; b=XjpaOp9tPKaCOOFO2oNZ5Vy9HrMwODvNO797zbAHV5Hcbud7YkbFKq6TP2dBJK/4HYHk41jBAKZTOfonB7lRNcV8zcYk0HVkZd0Ahc/f4gc+UH8Zb8VweD+zrXgr1sUAa6UxxcVcXkHS/d0yFilZJBwYR1J01TcbooTNxvSXwE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282787; c=relaxed/simple;
	bh=U2Yi4WXEq6q62j17itn6ogwh8gNFXP+3rUqyWS2Dj+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AcQ7w/LU9L2sVhmUejMj6C/FHwR2Iv1tbuDBELSdBe/COAxOdxBY28lMt0oQwc6y0DQyrxZEeHfQsDB6Piw3Rh6TquiGaGWcd1IMGxFhf1199tQKlKg7bUsOxmrjcGRClg3Ft04rw4+Dw01Wohf8OS2Fvt3Xt18HfvdYpcsMM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6hCWEAK; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5POVirmfQ9hKuZ0eQWAOPl4LLioRW/aTnRv4qMQvTrDixTAcIqernqEspKIybgD/G/BMhOr6LxcIpLKFEAah+VQGMGflyMbod8IaWawf+V+pk3f62MEAvnPQVIg0a83O83wGzJ3m6FAPhHO9CjX5mXTd4jhLcltxBz7iF8tgjRFJUq+PDRFRKzrr+8uCbGFoc38xjNvtBg29iqsGkY2cUshXmX5O5iugMcZIBvCoOjyZcHqWmpfhFFPucjnergWkCr7l/wCbW2xI6qyiGeFvyscRpUoxadP7KdnbPPbeoQVlgAqeFF0Vu6ZsUSC4wIBeIDzXuIiThQ2PEwZD11nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKZAKHraED85TjfDkaEoiBIBfHHycz52igc9wr6K9VE=;
 b=u02O8m+ust5GBtuneChRTv9SfBVtLluXp3/PErJTLy4mXiyKuIixPlgegU+EVIOwIRv+4hPUnA8UKWVLBQ1QLo0BRA/eVHedk2TmViV+8aThu46Zar5nDLKUYS9ZGtlyZfJ/+9FAniUXo+5YCivUs/jJg9U4buC4WqS16uPtn15qEYYKOz2YD7pxfqw0iMyyoJr/u9YHNh3K3Wg9j6AKEXq9GfhzwdgBUHgdY7EE9ySROz72EprEfw8JTctoGFDnZcuP+pYMrvR8JIFpUxB3EofohVs6C72YB/XHuYoSEnPvsn85ZFv/VoBnHrVyAr1nJSYY+sXmK+lUz3Glx5eUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKZAKHraED85TjfDkaEoiBIBfHHycz52igc9wr6K9VE=;
 b=g6hCWEAKr1PyvcTHpl+jwPK9QPtT06Y3U5IjMtayGl8xkORcHQwAxU68nhdBIO/zZG+GA/VraatVcKGsMoHFKvMgbh/+XK5yUw51VdaeHvkii3SAMFwPDd/lvE6pFhEbUeWdHXm5YWis5TECJuvBd4vr14KkzhBaDQpEH8QeYbQV87z70HoHwz0K5N6R5XBzS3PFThRDWexMu4EGp8ZqjUUp3SfkKauBwOXyAudHRzZxiAUqG3GUvYT90KtStAhEIW/aqiPazOarTWuzT4UmQpHi4hKrj38e0U04gP6/K/NB7H0WcRi/M5mfZsRhCRggmJB4PCJuWiD/BS5FKj6sIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:26:24 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:26:23 +0000
Message-ID: <4217b36d-7999-4c4a-8244-856992bf3d69@nvidia.com>
Date: Tue, 18 Mar 2025 09:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
 <20250317150741.GA688833@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250317150741.GA688833@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8637c1-2320-4c07-a35d-08dd65ee2fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlB5ME1tcFVwNmo1REhzcnppY0lkbThwT2VNVHFjY0dSa2ZzOTcxRWlBVUV2?=
 =?utf-8?B?YVordXFBRmtXSG81cS8wTGd0Q2FHU2xRaVRnSWJhalhmK3VneklMdGxCU1l0?=
 =?utf-8?B?V0p1ZTRUWUw4TklXWHRQenJob1MyVHRXc24zNzJkVEdCSWdIT2Y0dHJMM0Zo?=
 =?utf-8?B?bnNnOGwrdlUwc0ZqZWo5YTNyM3BSRlN5TVRYbkpVZlA0N0ZNUDJLTUVLYkF2?=
 =?utf-8?B?YUx6WEJyNSs4eGh6Tkhaa2p3dEIyYUU4QlVZT3lNUGUwUTgxZ1E1c1pGRUJ5?=
 =?utf-8?B?bnd2OWtSMmhwZVhFVXVuaWxMekhuMnZoekhyajhFWWRuRExaNFRUMktKT2cw?=
 =?utf-8?B?QXViSnpyZWtzVXFXRXYweUd2UXkwc25MaCtaTU5ZOFcrSytRSGtwK3RXNCtM?=
 =?utf-8?B?QWZZbEhRdHFFL3lwOWVZS244S3o0ZVprV3YxL3h6cldMdEJMYnFuMmZ1MXVs?=
 =?utf-8?B?dW1NZmcxUU85eVlpZFdsT0hmRzZ0ZGVWU2FFQ2NTc1ZlQmt6aW5ndjBORnZU?=
 =?utf-8?B?VWF0MW1iRkQwM0JjRFFWZTNDd3MvWjlrSkZUaDR2MVhtNnlBS1pzT2pqUVE4?=
 =?utf-8?B?RWE3QStBL2JnNGtCSWQ1ZThSd3FXcU5sMWJsZ3ZoRnJJeDZlc20yRG5zNldZ?=
 =?utf-8?B?VWE5ejBTenFHVlVNVTVEcTZaam9XVmk3OVRIVG1tenA1NzRacnlYdlpSS2RK?=
 =?utf-8?B?d2l4WmhKYS9hQzFOYnVOaEFTVEthRE1aZkhnbk9JSFdrZTA1dEdKRTJJazUr?=
 =?utf-8?B?dWJMd1Zhdk5iZkpVUEhiSkR3L1ZSRUZlYlduNFVGNlYwUHFhOFc5ZlVTNEZW?=
 =?utf-8?B?eFNzbTVXQktsOVAwNzhYZ3lSMXdUNnlWaW1ubjRwQmdVUG1yT1N3MWJqUk5l?=
 =?utf-8?B?bGZ6VjZqY2VPbjJsd243Sm9MeEpXb0VFMWI1ZjN5Sk1MS1pGU2lWeFZ2eUFh?=
 =?utf-8?B?UlhlaG4rZ0NzaDdvRjJWNVRiNEFaMFN6S3EzTGFZSkFVMVZ4U29pVlcrZXVk?=
 =?utf-8?B?c0dRZE12ZVU1bzV2WHMybVFzMC9OQk9sYlFoN2lpL0c2Uy9HYVhqcXowYzdr?=
 =?utf-8?B?bzFyZ3VWQndrREJyMS9SWHVVRlkyTXg0ZHEwT2ZnSUhVcmVpVS8welpiWkJN?=
 =?utf-8?B?Ujgwd081OWFEZDlTQmMxemg1ZEVwYWV1TnJOT2RTOVhQZGRPMURQODkvRitv?=
 =?utf-8?B?R1ZBTGNNTXRxVFU1bjFRczZhRDJYUExjdG1tdy9WZC9CVW9mb1ZtZjhXT2VE?=
 =?utf-8?B?SEtITmlLOVJHVFNVeVliUkYrNXhHNzY3bHJsL1M4S2I4Z3hTWjlpcEphN21x?=
 =?utf-8?B?MGU3RDZnaG1jaDBQaUZZb00zVzFoUjNuMXFocFVYc2tPemNFTFoxcGxqWU43?=
 =?utf-8?B?OG5LZ2JxVlEyUnp2ZU5yeitCWStkRThPVU1odk93SVFwZkd2cnJXUy9zdWtT?=
 =?utf-8?B?Sk1PMUlIVzRGTy9xZ29PVGRNMkh3MFFVN0pLNkl5eGlNd3hzd1c1c1dMa2sw?=
 =?utf-8?B?Q3dnSmg5YVhjMmU1NFNicm81MzNOUEJmdXI2MVd2dm1MWkYwSWthUW9MUlp4?=
 =?utf-8?B?b3lvT0dTdWVYSVh2Z1VPM2Z1cXdWM1hHaFd3ejQ3NzJtS1dUSFpOUldSSFdH?=
 =?utf-8?B?WU1rc3lvVlRKbHlrOE5ObmxqdnViSkc2QkFtUm1GeXdCeGRST2JkNkMyS3hS?=
 =?utf-8?B?b1ZaS2puSzFKZzRPYit5K2tmRUFtMDQxbjI1RlRMbFprQTFOT2cvVklsMHUr?=
 =?utf-8?B?YnZJaUJUZWtrRzhQa1Rnblhlc2RDYnFSNTdvQkFnVmVNTEpFdU0wUVFrZmlx?=
 =?utf-8?B?eG5JZlFTSEpZbE8wODlkZk9UM2FTQWJJdURhK2l3Q1hyZmNDdXpjdEg2eEQ4?=
 =?utf-8?Q?uLHiIelLDvBzL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhJbmFLMlJSRHdZS3g0TnhsdnZWZ0tKZHlCNGhib1Q3OCsxcjFFZ3h1K2VR?=
 =?utf-8?B?QmdydG56aXBRUERJRzBVTEVJMGRuMkM2VXYvWUdtdlFRTFNyR0s4N0VhVks0?=
 =?utf-8?B?dlcrOWdnUVd0a1orZC9HdE54c1BNUjdWMmVFT1RieXNIVjdrZkV1UjNzOTZs?=
 =?utf-8?B?VGllNk51OU10bDFNamJ4QjU5NXYvb3VqZ1FGSlRZdXhVaytkaHdBMzBYdWFv?=
 =?utf-8?B?ZDJpTml2bkU0VkdTdGxTZkt2YjhBaHFkMUJ4RXMxdzBKR3JRVU4vZndvcWNO?=
 =?utf-8?B?N0txSDJsb1hOWVFQQWo4SnpmQXhJNFdFUWdnaTFHTmFkclR2M2w2Rk1YYWtk?=
 =?utf-8?B?RkhISlRzL1VTVGRKTzM1N0ExNDlHWkovbzIrdVhQQzdFN3U5RUVzNGcyTHln?=
 =?utf-8?B?Vkg3d25Xbm9BZTFRWCtMSWlQM3ZtT3V0d0ZoZjBwV3pSMk4xczh6M2d0YkJT?=
 =?utf-8?B?Q2pEUmw0TTRpeFhSeDFmaU1VT1RteVhSNWlSRkRIWG5ybm1uUW50TTlFMy9W?=
 =?utf-8?B?UXIvK3RvTmlYSXpRN3gyOFhFdlVVZVVFcENtTE82cWJ5RGlKblYxaTV2eFJB?=
 =?utf-8?B?ckhJeEF3czlMUVdiYUZZVmdHWS9wN1FKZjM5bkx4Q3U4cW9YUFRJSzBCZm84?=
 =?utf-8?B?djRiNFZ2ZUdkdjZQcmFQbWxWV0tvN01jck5oQ1VrOTNVWHVQZFNDNjBqUU10?=
 =?utf-8?B?ZHRmaUNWb0pSaCtrVldmV2pFNEZ2aTJ6cVpUV1ZuSERQQlF6RjNuUUhUdzQ5?=
 =?utf-8?B?TUpQL1NNZVIwSVJTbkxGTG45dWRvRHl1VDl5bGxMdGVpNjFyYTAwYkZDQVBK?=
 =?utf-8?B?djNYSG1BQy9NcGtOVnpiNDNnZXNQT1djNTZPQzROT0lDSHF0MHBEc3RHZnM4?=
 =?utf-8?B?UDNQcmJQM2g3Z2xOVkZjS1pUeHJ5ZGc2VDhMMDdoZEdXRUl2WVd2d3ZnTUQv?=
 =?utf-8?B?bS8rV29YVTlORzhhZXNjRjliSHpodTkrNVBIMkRoTVg3bVNIYXRZMkNBaG51?=
 =?utf-8?B?MjV0WTNzOEJMOEljdVp4dWwyT1ByRDNDSlF3V3AwRWdvdXZKVDByQUU1emRB?=
 =?utf-8?B?anBLc1ZEeUwwcDJwZERSZzg5UVRaeXI3NHBzSnQvNUplamllclBqUWlLK05K?=
 =?utf-8?B?a1lwUVNoV0dFbDJYRGw3WFZKRVAvTTFvWDRudDkrT3Z4ZUxtVVFyMnNFKzg0?=
 =?utf-8?B?bGdXNTlXTmpOb1ZsSWk1UU9CdnE3UWNpVFhsMUhZcm1nK0NiWE1EU3FLUk5q?=
 =?utf-8?B?ZGUzUitEeEFNUHhNTHpURk5JQ3U3Z3E1OUlVZmN2cDEvb2FqVkUwNzhIT04z?=
 =?utf-8?B?T2NIT3BnTnA2ZDFKQnNCYUwzajlPdDZFNlVoZEs2VlorQmJXbUlxaW9Fb1dy?=
 =?utf-8?B?MWQ2NVZpNDhKWUJPNlY0RjhwaXpNQ0lZOTUvMlFZeFU2alppNXV6aDZ5WTA4?=
 =?utf-8?B?cDJkV3A1ODVoSnN6NWlSNGRGSm5yTWZqZ012c2VLU0VMUDlnbFNCbmtIdjJ0?=
 =?utf-8?B?QjJkVWVSMzlwM1d0MDJNMTY4TitaR0RWVmpZR3p2MlIvL0c1MkhFRElRUmpz?=
 =?utf-8?B?d25hNzhTNmgyblRRWGdpUTVOY2VrZ2syZnZRZDFjcWxXUHo4ZjZpanFRTW9n?=
 =?utf-8?B?VmorVEp6NUc1aGp2YzdpVVp2VnIvTENPUG5BTlc3TDRLZitTTU9PVmFzK212?=
 =?utf-8?B?Qm9vcmhFd3N5M09tL2U3NmNmQXFZTUxLSmJMamxtNzNUVTExNE5JOWJTcDNk?=
 =?utf-8?B?RlIwVEFPaHJ0Y1BxdjhUN3JKTjM5ck9vSnpEa3phS0Y0NGtJQkFDdWkxZXVm?=
 =?utf-8?B?Z0NLNlhiNm94UGRqMEl2R2dxK3RkRTIvTzBSQ0xVelZROVUxK29RR1A2ODE1?=
 =?utf-8?B?M0Y4RDNBOWhhZ2t2Mmd4RDYrNDVUazM1emhkRmEvSmgzVXhOWWtYY2c3OEU4?=
 =?utf-8?B?Q0s5VEhhQWhsZUZrU3VQZm02a05GTUZ4Mno5MENOR1pnT3hxZnhFUHQyTHpW?=
 =?utf-8?B?MjhYMGpPQUw0czF3R24ya1BuTEFUeCthNGswb3duWk9kbUxoSGRvQ1pMNGY3?=
 =?utf-8?B?aVMzTVNpWnFsWU5OWEhlZzlDZ0dTUW1zSEF2YWFYdjVFWTlQWkRvQmF0M2Fz?=
 =?utf-8?Q?7yU/S27O5+MyYlP0L/An8pRrp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8637c1-2320-4c07-a35d-08dd65ee2fbf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:26:23.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dosL8cjTqU7Qo9cyelBO0xXLyzAbbjlj0upHGgIIyN4ZDn81pIu3onw2w1IV7Auw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On 17/03/2025 17:07, Simon Horman wrote:
> On Mon, Mar 10, 2025 at 09:23:29AM +0200, Gal Pressman wrote:
>> Symmetric RSS hash requires that:
>> * No other fields besides IP src/dst and/or L4 src/dst
> 
> nit: I think it would read slightly better if the line above included a verb.
>      Likewise for the code comment with the same text.
> 
>> * If src is set, dst must also be set
>>
>> This restriction was only enforced when RXNFC was configured after
>> symmetric hash was enabled. In the opposite order of operations (RXNFC
>> then symmetric enablement) the check was not performed.
>>
>> Perform the sanity check on set_rxfh as well, by iterating over all flow
>> types hash fields and making sure they are all symmetric.
>>
>> Introduce a function that returns whether a flow type is hashable (not
>> spec only) and needs to be iterated over. To make sure that no one
>> forgets to update the list of hashable flow types when adding new flow
>> types, a static assert is added to draw the developer's attention.
>>
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> The nit above not withstanding - take it or leave it - this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Will change, thanks for the review.

