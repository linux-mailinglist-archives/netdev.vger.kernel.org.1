Return-Path: <netdev+bounces-121289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58695C943
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF251C22056
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89913B5A9;
	Fri, 23 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vGHKNUtb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7220DF4;
	Fri, 23 Aug 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405474; cv=fail; b=q/MF3/G1Yo0MHXJNeHkKZ+r92x4OBCQ4+AJeSHmblIHrP+uCPtYl6qSb5ycmY0SFxqL5pdZE+kK712o0yUiw829tZttG5N5Ar4OS7fGd0uTF02WvnI3Rr9XK3M527G4NZzt2S0rSPYZbqMRx1hX+WP+IOWO0+AmHugs+K/ROTOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405474; c=relaxed/simple;
	bh=JW227/nCcBU6WtcMe4InjFOwXY56H3XxF8HWQGLqmgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bvr31aIzTaNeca7+apsYJmYghZedJXPUNbt7hx1ZUkWcj2YQg+UQqbgps25th+frSsb69zth4fMV77v2PJQSntaj2xWi+a0QKdTyqp5geZAn593lbh/1WxNlTObO5WdqWHNQBlPWRLsRDpdGb/UQE/uWPzwnmc32DYmyckrvTIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vGHKNUtb; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5SnhXvOnLZ3zlNY6f91eJJc4Iy4418Fddx3pA0E8iulrOUcA+Z90dIScAsVcrLCwwQvrngDemeeY7ojNcOuxh0peZ0KcZhS0zuEmB5OaOqpLW0dIEpE80zzGUxKvA/vjQB9hMteFGwvse26If5qoHwNbCjX47tkhXGbvjQkKfYhNFMHZaaDu6EUHGNemuopGWOyF5zVsy9t17FDJm9uIXMuiT9pNVwn3gR24cO+UmzeAuqiNpssUUmzwKuU6JdcAj94Gh4rAsHakdngcjpAO9cAQ5K9ECAemll5HTXa6RXR/jUF1rNRMrzmlPX1RrVJPTpB65Vm4LqElEWLL016IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xovwCXOuNM1zR1wnb0VZcqQFrHTYfMVYWLVl7u2AZk=;
 b=ilgc45GlOFe1EltNlb9Wx2o5wNpqJYnWl+uf2b+Y0ei6tzQnwxIFRZ6l1sPQGoJ43WIgf4amYUXL9DV7w26kRg5+vfRSy7zfojakSaNQ+Q/Db7FMYboXzbpy9cpX7JWyeTuUoBz4Qe6CC7dnddGYbRuXGEmAwhjY5AKY14uQIyUkxZtgMN7C7U/hnAPl/8/XYdpExhZ4iA6Iv6gdO+4WoJ9ZLXexTE5ZvHwpITAedI5EyC0+18aOFCRmRHRhcvCTqeqsTVbv68F+bAZvp6tTqMmhK9yUDl4bQ5lnip85HjucO+71i24TFntf0vrOhKaKjAjzqbKziJYs1SWMjLK33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xovwCXOuNM1zR1wnb0VZcqQFrHTYfMVYWLVl7u2AZk=;
 b=vGHKNUtbLwpFHNGQFzHw3v5YaOQ/SkTW01JayGOXYUZoZqutkYM7+8HDMdZKO2zRCFToWCp/3sa/SwxpU/B6kF3Yu5H6Gve1vL2NuSQX7ymLwaCQColEdE59VeriMCEjFOgzyPLQosHIg63kt1oeWaVj/WQDbmpBc9OXH+w2w3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 09:31:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 09:31:08 +0000
Message-ID: <3165b1e7-c66f-163b-5101-34293453cc32@amd.com>
Date: Fri, 23 Aug 2024 10:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
 <20240822160730.00002102.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240822160730.00002102.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f92574a0-9fe2-4b89-3b7c-08dcc35651a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWh0Yld6ZFY0cWRKOWc4YURTbHBQYTVNY2pIT0FZVkg5UDlyNUNxdHpNN2py?=
 =?utf-8?B?c0NLN2lYWThKNG52clNHY25hZzZxVmY5bGgveVd3Z1k3V2lTd1oxazdwTjBP?=
 =?utf-8?B?Q1RDZy96VmlFOWtoVGtOMDRCUWd4SVBDS2JsdzZmeFl3QWF0cFY0RFJBRXR3?=
 =?utf-8?B?Tll2anJOSno2WEhHRlZ4V1h3RlJFQWxWV0svbUlmSFMrT1h5RC9OanFqckJJ?=
 =?utf-8?B?bzRhR2pzdmY4eml2SkpDNHE3dll4cXcyMDdMd1lNNGlrV1lkZFZGZHNkSnRj?=
 =?utf-8?B?bHBWRzlkeTc2VHdHZDRuUFRwYzRMSWNhbFpGZTQ4cENmelk2VElWdDVKOFBT?=
 =?utf-8?B?dVUwaXpCUU5hbWpSQUVENWJPS3Y4M1dYOTUyYnY2VWM2Y3BnaDc5QW5uOWxy?=
 =?utf-8?B?RStZRVJPRzIxaEZ6T3V0ZUpmcGFBTzNSaDMxcjhLSGhGUGlKRENiZkVxZ0Y4?=
 =?utf-8?B?RGt1bXVQTk9zODVDTWlGMVROUTh1a2RqR29SZHNGN3llU3hPdTRPSVc2WEFu?=
 =?utf-8?B?WW94ZCtLdm1PSE03Yk5LbkY3MjhMK2Q3bExpY3dONW56VE44NmVYNjB6UGVR?=
 =?utf-8?B?ekVVRFYyaE1mcDcrOC8ycU0yTGd6RkRTMVdPb1BlVWw3YlhEZUMzRGFmOTRw?=
 =?utf-8?B?VC9ocWkrUmhpN25nVWdZNlV4YXNtRGJEZStZbVF4bkk1L3cwNUFVaCtTTG9P?=
 =?utf-8?B?Q0J0ME1GamV5MjZ1V3VxUUxJM2lVWlExaUdiOEFIT2hFdjFlUlJsdjFrRGgw?=
 =?utf-8?B?RTNVNVRMRmR6VnBWZ2ZuVmFlN1k4N3pIYkpvQWhrOEwvei9MTnYwaUsvZ25F?=
 =?utf-8?B?d0dXTDB2VXBwNTAxcUlmT1ovR2VSZ1FjMkVGQXJpRjhlUmkwRzdlbHMxR2FU?=
 =?utf-8?B?ZHRkZ0RVSkE3Q28wZlZMM29zSXhwTVpUTmJEZm9US0hoMUwzRmNnQ1NHZW9t?=
 =?utf-8?B?b0lGQ1BqV3Z2aGpNeFJCOGo3RlBpTDJDM0dqY1RGTG5xS29FZkQ1cnlpOWpK?=
 =?utf-8?B?V1ZVZENualNXZGkySEFzb2FsS0RnWitIcHgxc1hjS1RXQlZnZHArb0NQbmhh?=
 =?utf-8?B?aUNxaEtYcFdTd1JqVzNwdzAyOVdSN21tRG1iejE2dkR2b3ova0d3aW5odkl2?=
 =?utf-8?B?S1NTUTdkTm5SeHlKd1BBd0RLZ3p6d1ZWNVhCNVM3aktkUEI2a1NnYmlPMm1m?=
 =?utf-8?B?RnBueGU0alJ3Q0N2ODl0dGpQQk1BRHpsWjJGTy8wVWM1bDVaSkN2SFN6dDVT?=
 =?utf-8?B?UW93cnRXQkptV3RmdWpiRUNJbHVVSWE4RFZZYmQ3Y1Z0SUFidEp6dE5VZ21I?=
 =?utf-8?B?SW9nQTNoN3htSlRBcDVJT1BvSTgraGdISGtNakVwWEtlcGdTSEo5b2puMEsz?=
 =?utf-8?B?WHpuVkZmQ2Z4d3RSQlFacGxuenBDaUp5WjUwM3dOL0tTVTBaSEVzOWVWbjNV?=
 =?utf-8?B?NDR5K0tOVjJIdjZEOGozaFRKSDZxSDVhVkhrajVzbEdGdnNQdmZYeFF2b212?=
 =?utf-8?B?Wm9vTEsyQ1psM2psNTRqU0psemhXb2hWR2NwTUpUS2RnL1pHa1FDbXp4WVQr?=
 =?utf-8?B?ekZBUmh2TmJlaHErZXpKS214V1RoMis2UDY1K0ZzeU5keDM4WWNaUXdxdkxO?=
 =?utf-8?B?dlVhVmlYdDlNYXAwc0pyTThXeVI5K0NSUlIxVit6dDRFRWRYNzFSbHZtVm5M?=
 =?utf-8?B?V0w3Z2lGVVllZ3YvZUpaYkRic1V3SVA3ckJuRmxtWWdkNVJwNi9CZXMrdStQ?=
 =?utf-8?B?V3dzNXpTWXBRdllJMUpiMlNsRHpSaEhvWjkvQVB1M1NSM0ZqY1o0alc3OVd2?=
 =?utf-8?B?a0NwQmNPZXVkZ21Oc3h6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxnRGl0cy8rT2tZa29jN2xYYVh4a25leVY3OE5uM1pmVld6YTBlMWExTnVr?=
 =?utf-8?B?azRnaDFnRkhVS2lQNEpDNHgvWWs5S2h2S1pJWTZiaklWVDBEaXdDc3Uxa0Jl?=
 =?utf-8?B?U3FoT3BXd09EbUhuaWh4WTN6Qmp5WDB2VVc4NEVlVUplU3Y1Z3p6NjA3TmlQ?=
 =?utf-8?B?YXcrT2ZuV2d3SVBhNXI3aktWUkZ4VWZCYzE3eldtTC9Rem83ekxIMHd4c3BW?=
 =?utf-8?B?STR3UnVPUndaa0J1cVpVSXZuR0w4VVZZclRsUndZeUVMeFNaL0U1bndqN0Rw?=
 =?utf-8?B?Qkg2SzU3SFZaRWtWNHhyanByQ3IxME11aElVbzM4RlQ2NGhVeE95aGQvR2hR?=
 =?utf-8?B?Ny8wcHFPRmpjWWRRdkJYa0Nxa2hud0U5QVhHcnBZdmF3QTRuY1RkRGdSQkxx?=
 =?utf-8?B?SFdQNDRoMklHL1YwZlp1bHN0YngrRTBCOS9LUnh6VjBsSDVISFYvei9kdndW?=
 =?utf-8?B?OXgreldIR3d4cDVwT2M0YjRCOTAvMVIwN2gxd1JIR0pJMThsdEFEK1BnbFRD?=
 =?utf-8?B?M0VzMmhmdkpjWElyU3RuaHFRY1BhVGlZNFRNM1dueHZoVjVVYm5VelhPMkVh?=
 =?utf-8?B?emhNMEZReklKU3o5VTF3ZTBLRHdDbDJHZzhhc05DWW5Ed2c4V2VKRHZ3Q0Jz?=
 =?utf-8?B?STJyVFZFWDZpS0V5Q0c3ZmEwVEsybjExWWNjV3I0ejNSUkpoSE1waWRUdWNB?=
 =?utf-8?B?dHJ3a0JrMEFjSWNRWVNhSjNuYnVVQ24xRm5Xemp4ZTg0czlqdzUwdERSaWkx?=
 =?utf-8?B?Vnc5WDhVckllRTlya29KYUNPRU53cnVxVDVjMVRQdEdZN0NSaEtHcWQrbjNt?=
 =?utf-8?B?OVJIc2lyK3ladVRNc0ZKZm5mVTFCSmg2SWs1UkxGWXlFdTg5eE5aQVlqZ2xs?=
 =?utf-8?B?cDdMaDJ1SWpnTUd0d2FTUnMyN1hLb2RDM2pSa1VzRWtYcUxYWFhvVFhLb3c1?=
 =?utf-8?B?WE41K3BSa21yNHVRV0I1UW14YmVobWFVb0tFS2c3Umd5SWh6cGpVUGJ6WmdM?=
 =?utf-8?B?cE1qZnJQMWMvNWVCdDI2elpqK2lIUERsN0NUOUova2FPNEIxdGw4WjVlRzMz?=
 =?utf-8?B?a1N4UDJacVdBQXVINm9raGcrMjJrOFBLMER2TFpTMzhYa1d5VGJhbkxHT2VL?=
 =?utf-8?B?cml2T3RicXpGWTlMYjcwdnRiZ1AraGF6WGkvZ0dYeEs1bGVXdkNrWFBQSnQ4?=
 =?utf-8?B?SUhhQ1JxWExqRE5vcTBJZGs5bklhNXNXZmZ5MldQMnZtcWxRaE5BUThaREhH?=
 =?utf-8?B?d0Z2SGZFVWdWa2V6bEh6NnI2Nkh6Z1J1bGx6S3VyMmJ2a0ZISkdMVWI2TDdV?=
 =?utf-8?B?bGN0M3NLZkxFNTE1Tm5jY3JNZjFNcmhwckdISVlJZkhaOWFxcFB3a000VTBt?=
 =?utf-8?B?eGtNeUd5MjFmd2t6UlJtYlkvT2JISXdseWJTYjJmZ2Y3V1ExTWJxR3pPNE5o?=
 =?utf-8?B?YkVvYzV2cW5PMDhqOG9maFJCWXc5N01aR3JzaTd0SHhITE5FYkwyc0xaM0hR?=
 =?utf-8?B?bXpZSEExbGRyVU5ha2ZBT0E1Y3hQWElHRU8wZFl0ZTkvTitYOStGbTFPMGJL?=
 =?utf-8?B?UWs1RDg0R09mUUoxd2s5QVBGd01xQkpranowVFVHQ0hmUFRGWWlaZEU3eEVN?=
 =?utf-8?B?c2RMNi8ydUM5MFlBNE81TEZUdWs4M1RYWGJ0SU40a0pQK3JIOG5NYlVleGVN?=
 =?utf-8?B?WktqSUJLVHUyenFvL2E2MHhUZmNXb1dtc21tZE80RitqNXRQM0ErQXdLQU5v?=
 =?utf-8?B?aWpIR1BXVTMzQVRQSjlpU3BsTllUUEkxTFd2cmVuR3pYWVhKN2JoNDJCdUha?=
 =?utf-8?B?RFlSUGcxTjJWOTNPU1dKcUFaeGtSNlBlbGF2a3J4T2hBSjFwQTZoRVhKSTZz?=
 =?utf-8?B?TzdkckxuYmlPNlpSM2poVjVBTHUzeG5JamwzSXZTbDQ4a2drNjh5bTlDcldJ?=
 =?utf-8?B?V2tWUWdxLzN0cEd0bldUeDRnTE5uQ2NwLzlEMXRJRzNKZjdqdUU2ckxheGd5?=
 =?utf-8?B?SFJLdVplRzNva3pzMkNjaWlZOVcyZzBPZlpzMEN0elJ5Uy9tdktKSExYaWdH?=
 =?utf-8?B?ZXpsL1MxRHV0eFBYa3NQQ2M2cTYrVjF3MnU5ZFhnNGJZb1RPUlQrTS8xTlVp?=
 =?utf-8?Q?Zf/juE2+7AkbwPRBC/M4pYAu5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92574a0-9fe2-4b89-3b7c-08dcc35651a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:31:08.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E50ZosfW7keCj7U9/jpsRKfa6jAJFayQI55vLX9I6zzvVniIgsP7zvbVYlxFMo73XUdlqjKmOvRAGlQ3Jq1cvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966


On 8/22/24 14:07, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:23 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device requesting a resource
>> passing the opaque struct to work with.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 13 +++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>>   include/linux/cxl_accel_mem.h      |  1 +
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 61b5d35b49e7..04c3a0f8bc2e 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state
>> *cxlds, struct resource res, }
>>   EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>>   
>> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool
>> is_ram) +{
>> +	int rc;
>> +
>> +	if (is_ram)
>> +		rc = request_resource(&cxlds->dpa_res,
>> &cxlds->ram_res);
>> +	else
>> +		rc = request_resource(&cxlds->dpa_res,
>> &cxlds->pmem_res); +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
>> +
> Hi Alejandro:
>
> Since we only have cxl_accel_request_resource() here, how is
> the resource going to be released? e.g. in an error handling path.
>
> Thanks,
> Zhi.
>

Right. I will use devm_request_resource in v3 using cxlds->dev and the 
owner.


Thanks


