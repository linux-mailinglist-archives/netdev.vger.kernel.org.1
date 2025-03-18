Return-Path: <netdev+bounces-175627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1CA66F32
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DFC19A2E81
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2231F4179;
	Tue, 18 Mar 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfAGsgTg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382919DFA7
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288424; cv=fail; b=tdgBxvD+YA1DTihCzljrNJbxhCuLRwMIPwm2kQjDIwCkHOMKrZjWssRsX0neb0RCP2nVx3DJVoxzTqTRSE+R49TBieIM5KvRRASqFibH2shJGVptQ8H2ZAHDzsE7TDaB0UuEwr6RfWthv1SQVg8GQIspHc06ZoPZHBcH4Skuh18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288424; c=relaxed/simple;
	bh=dn2Xr2HNVntXhGXdj9k6uPEuvn/CeTnmytTtKztA5eY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0IpbTTTGqnE2EvGCFBY1HRoJt5hwkjN1Ihj6K9FD9t+aJk5jKsC2Gs0XyphLMnJoqm/9HSv5R5gjRD368zU6A9W65U39gpp4SRwxdfda45tTViAJYvWVkXeqGD12v4glGjYDmJJNeM5QVLVMh1lOITldRGJ3pbxpvBwjbGEo0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZfAGsgTg; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvCFuT3New3klNwD2jKWzyWJjMADd/QKI1DHXp7Vd84ZYpM5bofxDTg2z4JoGfledh6iYc6RhIPahNmfGOywVsdU9+jaLn4XEyM7NjclAdbz3IorHl4dR6iKJuEksmE7PWHc6qMDyXsmpPjjd/HJjkrURay5U7LHffZ7bg7Q68gYs85L+NJqO1z8yy6N8owEaVjKa4DpyA3ZMCp9/jdUUtWhztB5owQao1wsWP+KdSWaoRyQAh+mSV+n3WKicrChQ8tAc1eDUua9uyFm+LSWy3ipf7J//3fPK4RlWCKhDreDFK46YzrN+QFFe1CS418x3IAdMEAiols9/2zEHl90Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4LbRCoLrEw8IaHQqSBFn99EKXHGWSYYe4z8Dy+B+sM=;
 b=rcgpy84Lvqxz1WSOTINhzFy4qSXFvQ519uvBnqlEcmbyPjk7Etgre6Q2Upn6Rx5kJlIaoOi270XGWK9yQyrhePMPUYNA/R5xClH99QsF4hEdJwBlk7VP8UOrw81ygVxRJvuJzqCwFcZ7vzkpLYA91CWNHEJlLxFFmJzpeXgXdTMw8EtHdUvkxDOglfHAxGavryzS3Rtzogu9zeWUd2W9Q0pLfR49xzSVbMZ5+ghcNO2NKhOew2+QJqzHU4GnG/h9scQDmeH+KID0c97btn8F4NV05HaR1jqNADVUphwdq2afDUuGPvpKcFxuiGrr7m41H5YciHXg9yIAim63MLlbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4LbRCoLrEw8IaHQqSBFn99EKXHGWSYYe4z8Dy+B+sM=;
 b=ZfAGsgTgajOXFYys0sOKxISSuUyqv6+zveUPzEr3q4KsLNlt7QH/d0SkoTzd5pfPg90UfKU2l5hHq4Yw0B5N72I0zyJS76T1UZLXlUN493vZCCqNsog9+WeZZTGxLAPgvwi2C8elEIBNf2/gIOJv8yIgKSex8C0Urp1CmAIv62k72SxlrDwN92baGSHhK09oAFeCj8xWTZkF3kR7VAgiqH0ivSXbQdqrQweUZcE7bXl5RNhOfuCeHDq7CFdSfo7Ec0JNsRRzT/KHK2/g16mM8kV8V3FcINVsfUawF9SKqIF3nJKtaQwu0hafrv8As/ERNAXiTwLZqH43AOfw5noHBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:00:16 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:00:16 +0000
Message-ID: <eb3badef-2603-4bab-8d7a-c3a90c28dc64@nvidia.com>
Date: Tue, 18 Mar 2025 11:00:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
 <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
 <9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
 <9af06d0b-8b3b-4353-8cc7-65ec50bf4edb@redhat.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <9af06d0b-8b3b-4353-8cc7-65ec50bf4edb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::10) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: e691605f-f524-4624-7b13-08dd65fb4d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2NJdGhreGVtcUx1MUI4TUFvVlZJeVVKWkY1UHZBU0EyV1pTd3JUWUZ1cGhx?=
 =?utf-8?B?NGpHZm1lYVgyLy9GYXY3ZGx0U1J3TG5kMXd2WDMwYmEwRFdLTWhkUjNQamph?=
 =?utf-8?B?eDJPOUlscVRheU1pamM3R205WFVPVTRxbWxhcXg1U3A1Q3pVQkMzeTJFT0VM?=
 =?utf-8?B?d2dibzJPbXR3TCtmNHVUZmNtZnFsVkQzby9jRGNUamMvYUkwSHpIbFg2WEZW?=
 =?utf-8?B?eldhNzNrSTBuRmFKRVdnTEpCMERuVm9nb2NvbVk2c2EzNlZSZ2d5aVV4d1U4?=
 =?utf-8?B?WFVhc3cxUTdrdjQzUmJPZnZrbFVobXdFVkFsRlhYRUIyUm9sMG5wS1F0S2V1?=
 =?utf-8?B?eElZd3dWMSt1bHA3TXM1QTFyUUxRWVdzcmRuc3JXbE9mRWhjRHIzWEtteGwv?=
 =?utf-8?B?Z0p3MWZXdGFGVlVUMHhXcmdyK3hqOEQvc3BHaFFCeW1xOGZ6bVl6SUd0NmZj?=
 =?utf-8?B?Z0ZOVWpIMjFBWUY4ZkZMQUgzS1FBUVg2ZDRoOWYrTEJDaUtKWlNXZXQwd1dl?=
 =?utf-8?B?UDRFc29JZXpzZlRDTDFxQi9WSExqVEUwakxEa1dHU3FRdUhLdGUyajZWcTA4?=
 =?utf-8?B?M3BUZWU5dzhXVHVOdVRhN3lodGVIUEZ4dnNxS2pZRHJ0VGtQUWJOTi9rODhk?=
 =?utf-8?B?c2JWRGpJdUdWUWREUUk0WVZrUGFBcmo3VjQ2OUIwUmlmYWkyRG91dnFySkFS?=
 =?utf-8?B?M3B3Y3p1R2RkdW5hM0FCLzhSTUdhRDF6YXZBSWtVdFdhejJPcGx2ZTRIVVFq?=
 =?utf-8?B?WlFkRTNKdndBYmpMTW5FcEZLcCs3cnU5TU5SYVdaZ2VndVJtN294RlRTaUdk?=
 =?utf-8?B?Vm1oUlU3Rm1QMTdLN0Y2a3JsbHEvYXBYanUvZTNyb2hOVDErbnJtSzFNalBK?=
 =?utf-8?B?K2RVLy9zVURVU1dkUDJkZFUvZFB5dVpBUjRVa2lmV1dUYUUzMllmanQ4ZXRK?=
 =?utf-8?B?UlB4Tk1xZGpNQ1RRc2QvRXUrcFlXTHhRdlRMUVgvRytnZ1AzQ3lJdGF1YXU1?=
 =?utf-8?B?NFBnS1Q4aWpBbi9zclg0ckRIOTB0a3NWNU9kYlhMYzJBclhlRDZqcFRZejln?=
 =?utf-8?B?dEVqRlVrdW4xY3lBMlNNRU5DYTJRSEpyNFVhWDZsQ2gzUVhIc3NOU1R2ZUVj?=
 =?utf-8?B?RW12NUtmTnJSRnk2ZFp1bllLV1AxYjlHRi9ncTgxRHlQK2dLbmFwZ013dHVF?=
 =?utf-8?B?WER2UVhrVUNPeDlNRGhSVEFGQm1SUG9jZWZacjVRcHlNSjRLWGdWcklMUWov?=
 =?utf-8?B?Z2ZOT0dZUFE4WHVRcWMxYnJGUUdyZmlIOUN3NVU3cEtTOHdOZDd2YkgzVDZY?=
 =?utf-8?B?THVuV1llMzRiZ0libHFMaVZrYkFmZDBybkw1cTQvWXVNcU4zWk5DNW5sTm5Y?=
 =?utf-8?B?d1V5NG1BMHdSVWx6SmpEb2QwMjMvNkxTMi93d1ZlK1IrS0luSzhXS1RzUWdM?=
 =?utf-8?B?Z1lWSGhPSUQyV0ZnU3JTc051MWxhck1SbHVmaks1cC9XOEZldmt4T1pHYUE5?=
 =?utf-8?B?dVRaWXlwSHRIL3UzY1JtNWZYQ2dROU9Ld25aa21XdnBLOW83eVRMVVJaNG4z?=
 =?utf-8?B?OFNPaDQrZWlqYzQ5dVNLLzBzU24yU29Id3ViS00ycU9zcVdXbkFyVkYwaStt?=
 =?utf-8?B?R0NaUXg0R3daSk1FQ1h2WWZ1czEzUHNlOTlpb2NGODlpNmQ0RW5TeGowOE1M?=
 =?utf-8?B?enhOcVJhRmtmYUtrK0NYcUN2MUZuaUs0NnlMa2NQUXo3UzZkeW9KWnUvQlVW?=
 =?utf-8?B?SU9iN1ZXUGtRVGhCaHV1bFVKTkZOSVFuZG5oVmNyKzdVZmR4TGhGMEJFZEQ3?=
 =?utf-8?B?NmJ3MXl6MmZGc2lUU3gxL01USjNDcmR0dkVqNXZhZ3VkSEVtaVV3WUcrcytm?=
 =?utf-8?Q?oM7PhsUhhRo8Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b20xQmJXLzJZamcrRklSdDRrRzV1OTI1K1ZYRldWK0pzNmtwSGVwekJld1Zt?=
 =?utf-8?B?b2c2V2ZFREtwa3R5cmpHMm5aRmorMnhJTzhFRnNyZmpyOWZ3Y0hLZVlaZnFN?=
 =?utf-8?B?elRxblJ5MXlLOUhaT01heW1odUxlOElyb2luMlkzMnFBL1luS3p4SU1ITzNp?=
 =?utf-8?B?VUkxb3llUTQyYmpBRDBvNVprOGhING1DMkxPSTRNVjV2cjdOZmU1anM1VjJ2?=
 =?utf-8?B?NHpjK2Z3L3B1QTlTZDFsZWt3TnNsLzFyMDJSOHdlaGZKRjkrM0NmUE5jUGc3?=
 =?utf-8?B?YWdHV3k3eXRjVWN0eFNYcmV1Q1p6bXQrZm9tNFlzMmVVMTduejNtVDlBaHVw?=
 =?utf-8?B?S0dNYXBORG4wM05oV2FjMmtiOWFsb2dNM01LOTY3QTdvb25oczF0RWV4TTZ2?=
 =?utf-8?B?RlZBeFFrZ2FzbmdrS2dlL0pZdWx4UVpncXR3bVM3T010dmFZdGc2RTFsTi85?=
 =?utf-8?B?ZXRTQ3hjQWwyOEp5cWZ4b2JjZXJDZEFBY3lsaXhyeVpLenZsTEl0NW1EVi8y?=
 =?utf-8?B?SmhhY05hVUZEcGUxOFY1cWRLelRSTldaVGVRUWxkdXZWTGs1NVpad0JSOXdO?=
 =?utf-8?B?aWZCb3ZKcksyK0gybzVsT0dCVk5EZm5zRWRVS2lCeDZISCtVYmZXYnIvQmFE?=
 =?utf-8?B?cFpIRnh0YU5oeWxTMVUwUnpFeU44c05GMHc5UkVnYVk0UGthQlh5UklWZk9J?=
 =?utf-8?B?TXBXaDFZYUVXaTBKeTc5TTZ3WjlwTVVaMEIxTkh5QmFyamU0VmVhL0Z2cGdY?=
 =?utf-8?B?aEhxcHlNdEdlVUNxdkhUc0YwYWxFc2xMQmt3eCtOZnRTcGJGV0w3Mk84RGJG?=
 =?utf-8?B?b2I2dk02VzdNd3plRGF6bVIyVXNvbVdtMGlQM3crOFNmM3puUGJCcmlWbXBJ?=
 =?utf-8?B?Y2tVa2J6cnZwV015UmU1emFIS0Vyd1VKYVVUUjFBYlJteG5jWUlwaHJGQTQz?=
 =?utf-8?B?KzlrcDQvQXJEdlhIMmZDVG1QTndlOGl0OXM5TUhaOTNDakZnekR3NEJ1VERX?=
 =?utf-8?B?V3pjQ1A0RWpQemtaaXVvd0oyTVV6d0ZPM3NTNGY5SGtjOFNYVi8vdVRlM2R3?=
 =?utf-8?B?emdGbUhHYWd6TWdFRUF6bzZVWlQ2UVdTMWFJL2UvaXpORmhoZEkrOTc5N0da?=
 =?utf-8?B?TTlsc0xiUG1KUE9JMCtlcFdYTGdMYmU0VG1DRFZSUmt0WWN4WnNzY1VvaFNt?=
 =?utf-8?B?RThZbExncUhSdFNRWlB3VmJzdU13WGE0Sk15S3FrMzVJTitPaUp4aHp1d2ZZ?=
 =?utf-8?B?Tjg4b05LbFJMQVZzdnl2bjBuOFM4OWpGWFY1MzUzNkxkbDBrcU9wejU4dDJ1?=
 =?utf-8?B?alEvekdLaDQxVTlHWkNvNGVRbStFY21jVjRDN1YvUnAwdnRmTkVES3NjdWgw?=
 =?utf-8?B?dlJ6N2piSkhDUmZSYldBNE9TeEg2WURjQm9MQ3NVQ212SEVwbHpRbXFidUJj?=
 =?utf-8?B?WjRqbkV2VXMwb2tUWXR4UWxEeUlZZW15WUU2OE9CeXhBZCtNZ1F0ZXkzNkp5?=
 =?utf-8?B?MGtkai9URjZhVlVzbmRVMEpSOFVobjl4dzBnQjRxaVZwMmpsRUtqWjJva3Zh?=
 =?utf-8?B?TTdSOUdpUmp5Z1BPT0lYTWxjdnFpbUJxWFNDZVBMOGNQNlRRdnh3b29xRnl3?=
 =?utf-8?B?ZFdhZjNNbHRYRG9HbjluWTBhVzY4eDFkbmNYN2M2RTFWd0RBOHE5RjFqRlBs?=
 =?utf-8?B?ekxvemlRMldGZTNQM2NDalZqVmNHUk5jdVBzMTdDRFlJNDhiMDk1Mm1VS0RI?=
 =?utf-8?B?NXhOOUpOUDRSK2hvNGxITEJGeFNWODdtYTI1RVJsWTdiR2FFYXZaUzZFbkVj?=
 =?utf-8?B?R0VrOEJKaUJXRUtPQUpISUlKTzB4aW1NMmtUOCtkdEhFOWFKcHRvZ2tPZ09I?=
 =?utf-8?B?QXEzOEJ1aEhVcGhFM3ZBYkR1R0wvOUZPdFA4cHIzRUtsRDUxdysyTWlBaHNP?=
 =?utf-8?B?WmhDZG9sOFVKKytBTkZHNEk3SzhGOWFSK1g1YnhCOThGS2pRRHl6UWJnNUU0?=
 =?utf-8?B?bHFEQytYQURZM3VLYWNBOFBSMFp0d0lraTRZamNZSExBYlZ0cmNsTDYyQ0pS?=
 =?utf-8?B?SjdoRE0rZ3RIS0xGWGRpMis4dExqUmUzbkJjOGt1WU91RFQ2NjFKc1RCdlEv?=
 =?utf-8?Q?pOsDiUoZkSJgbfHHqfwZbm8ei?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e691605f-f524-4624-7b13-08dd65fb4d22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:00:16.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGtexgua21usrm6b6hcYtFc+HZX3ARzo/2WF7QNS+oxcl1y14+g8T1D16GI9InV1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

On 18/03/2025 9:36, Paolo Abeni wrote:
> On 3/18/25 8:28 AM, Gal Pressman wrote:
>> On 17/03/2025 22:19, Paolo Abeni wrote:
>>> I fear we can't replace macros with enum in uAPI: existing application
>>> could do weird thing leveraging the macro defintion and would break with
>>> this change.
>>
>> I couldn't think of any issues, you got me curious, do you have an example?
> 
> I guess something alike the following could be quite common or at least
> possible:
> 
> #ifdef AH_V4_FLOW
> 
> // kernel support AH flow, implement user-space side
> 
> #else
> 
> // fail on any AH-flow related code path
> 
> #endif

Right, thanks Paolo!

