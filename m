Return-Path: <netdev+bounces-118904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED84C95376C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757C11F239D1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF4719DF92;
	Thu, 15 Aug 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HIFqMOWl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C661AD400;
	Thu, 15 Aug 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736277; cv=fail; b=PfP4R8uX/CeQglj9C35mBoEBUmiWDlijyZfcHia77/8Do1c76BzsaJ8MRfwW4+8QMD8hoLz4Zn7sqv0R5Xp95ViYtxWsA9EqcLEW5mPS2L6pUoaFGSVhJ6MRGWXcNb2ID4V4Q923o97puI6Q03M5bx0PATI47cWVkVc+FyJag0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736277; c=relaxed/simple;
	bh=dXKp09qcC9fylLcB7PC3ZbO/k9rZXP9AOHG2jpe8+mg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8YyStPwYWE7JvPhOFNYqClsXXJm2vaHI0WXaoAzHO/EwtMP9UksnPsgnVTTvGT9PyuxoFXlpfrGLgQvSTOURXKW5aCnZFeqHIHvNhVv6QA663zQIdSvbcXHUN6IbazMPC23J0kciJgTYvawaDqHicdVg87dec/OXXhAomLYXvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HIFqMOWl; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I177P4N5bBp8NpyM8JKPF2lKQ3+KMur9CQSjc7YYtdlTsxX+KlTeGW4ldBqtlYOY6RTXsYulPMFj7YaLnXFPN6yc0mbUVWL0Up8XtAWo5IEB1asqwRgdrF0Za6T/agWKHSghn2bl0ZRoco95qwdIdHpIgL2qWQp4AzQQclxnw13HzJGB0z5RkswWIcdtq8s9LknQC5RgNbO+dN4WaZyX7N1urKga2Y07uVtYxqGn0C3dmly2Qjbet0yZDYeS9xKGh3znrzMFnOMyvKYiyuHgu+76lpizkvuRPGzlLSemE8MOaTMRpzktr+VdNpiLvn3CfwTjxRC4MoH6au/G+/i42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6pLYK9MHS7X5qmSIY+SZJk29Xs8/RKEGDwWg9ZqYr0=;
 b=NqUp3tuTLroB6zAOH1cerSaRxTEx9P9WcWsGSKiZ6aMwejSLSWcIz9DWFQJ3rW0pz5jcic6z95H2jDOJCoFoF+Oma8J2L7mgGRzJj9UX9W600IUNFVz0zxIIyXTMeOzyzusmvBk2Z1OfjjP8npgU6rRlSar7E1RtnTueW3ce66J45wYugz1uyEHps8bJkdKc9dgcp6IlQM4XVm3hnUU20i3DWmOYKtJYj8O0LSVHxCyQE7V55G5VgHlxhB0qKgcpqg6c8iHgHDcbrug6cklXhadV1QyDdMvrstB6r7egQghd/OebNpMfU5wEb/5rX0sxZTJQhr13T72RQlmlmNm2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6pLYK9MHS7X5qmSIY+SZJk29Xs8/RKEGDwWg9ZqYr0=;
 b=HIFqMOWlSShvdqRoL7qOfN40+ZCT8tH51HVM4BjwxEO3EmdKzJz1ZjgciMXk0BC/ampHEwowbn0WMf+WO0EhehwNXmrLnxEUhkk9SdL4Gz7BpJ7hPgiUOBvi8tHBlGiBcbptxTwHiVe53GQedoCRze312cngRzQknC9fgK2Jf14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 15:37:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 15:37:52 +0000
Message-ID: <2482b931-010f-30fe-14cb-2a483b0d8c38@amd.com>
Date: Thu, 15 Aug 2024 16:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com, targupta@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
 <e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
 <7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
 <20240809132514.00003229.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240809132514.00003229.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: df65d5af-7a9c-4074-7908-08dcbd4039a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWhqMGVTdXJ3MU1meTBXRlp5VFBrU29OTUd2ZWJRMnlvZ21yYVdlU3ZGSFRJ?=
 =?utf-8?B?cVFjRmFJSWpBQURUYWx5azVwQWxLa3NsaFR6Tnl3Qm0wQlRBaEp4dGp5ZTBo?=
 =?utf-8?B?SytiZ2lKQUViSGh4QlAxZUhrd3ZhNHNvd2EyQ1RGbnhaVlVEUTdWUEowSlFB?=
 =?utf-8?B?a05kTWp1dWZscEp4aU5veVQxVzJBWW1oZFBCSWZQZkMrTlR2YXB2cG1VV25n?=
 =?utf-8?B?WjNOaG1VN1hTd00xYWtLZ3NWZ1RodGM5OCtadENqVEx1bUQrWHFiekpMWktI?=
 =?utf-8?B?RUVvS2c3azJZTk1PeS9uZzBTMVZMdHhUNDF1d0pJNERqVzdkNWVkV1Roa3k0?=
 =?utf-8?B?TWhXelN1cFdWYm1iNWdjUENuRVFXWXdqNVdVc0dTYWhIZENaMzJJQXJqcmVP?=
 =?utf-8?B?Z2piR2oxS1dnTXVwZ3dZYlV2MEwvS3p4QzFPNmI5N3F6b2pEOVQycmh6MzNG?=
 =?utf-8?B?eGJjVkc1bEZXNlZJZWV0b0w0Sk9SYVhnZjRLZ01ZdmVaR1V5RUkzM0Z2c25l?=
 =?utf-8?B?QTh2endsUk00UVA1MmJzclFDRHpGRzQ0ZnJYR0FwMC84aTBPS1hEeVJpdHVH?=
 =?utf-8?B?UW5QbkZvTnRlWDlNV0ZOeGRlaGFyYk9TQVBoQVRQYzdYNmVDODdTZ21VVWNv?=
 =?utf-8?B?d1JyVVdkbmJUUjZWT3h5SEFaSHYwaGJTVmZTM3ZMZGNUbnI3dDRwMVFFcWdQ?=
 =?utf-8?B?RW9CeWRyakI5U2pPUWVlOC81WVhxUGhDamFPOUo3KzAxbW9kWXBjSkppeksw?=
 =?utf-8?B?bU5aTTNJN294bVI5ZFJKdXBrNmtRSXJQN0lQUytWS09JQWlObXZJNkw3MjFu?=
 =?utf-8?B?TjdhbzdOSUErYVozYlQ4TVdtOFdyWmJSN2ZVWWEzR0tmSE82SHhxcG9FRkRC?=
 =?utf-8?B?dnYrN3lhV3BtRFByZ05xUlZnUlhGM09vSTZFVVBLR1dsQWx0eHo3QlNEWlAz?=
 =?utf-8?B?RkV3MHpucG1MZXJLd1NIUGNiTVVXOEJhUUt2blgrS1R2ZmNJZ241ZHNINkYz?=
 =?utf-8?B?azIyTkpoMFR2cFY2Y1h2c2pRVHd1eUZMZnZKbE9YMU1TRFhINHlrOHQ5UHN4?=
 =?utf-8?B?SnBHSEVGWHhIS24rcWZ6dG5VR1RuOVA0T0NBLzRuc3VGY2ZMazcrNStVeThR?=
 =?utf-8?B?aTIwUkxRRng0UmFCZWhMM1d2WWlQR0VrWEJ4OCtZS0lZcXdNci9XOVpUQXdL?=
 =?utf-8?B?bEQ3M3VFcWVmMUorV044dEk5TGFnelZxUHVYL0lhS0xleTVsN1AvZ0lEWXBT?=
 =?utf-8?B?RlZwVjBpTS9RSDFSVW9rcko3R0ppelN2T2NFYnh6OW9Dd2doTEJHeU5Iczda?=
 =?utf-8?B?MWNKa1F0VWF6dmV3TVhCczNWaE1jTHB3YUl5MDNjYmhGTjFMMTY3OWwrN0g3?=
 =?utf-8?B?V1BWTVBoeURjdE9SelNmdDJ3ZWdBSm8wRW5IQWpYTjVUTHowRE9LQnhUaFFE?=
 =?utf-8?B?aytqeEgyeXh5bUNqZHdmRHJTS1hqYWtlbVEwYm9JbGtzVElaak1Fa2YxR1Jj?=
 =?utf-8?B?eFcwTCt0clRCYVlaVkhDMndRZkxLamNOZVRUUDNCTXZzejJsNnlBME9aRWhX?=
 =?utf-8?B?YUJpNE9hbFFQbmNaM00zTTFqaEtLd1pQVkR1ZUVWMStMdG8wcVNGVmlFRE5M?=
 =?utf-8?B?RHdZYmxxV1Iyd0M0d0V1ZExTZFRESTRlUis2YWV3cDVucmRaYWlJZFEyQkZR?=
 =?utf-8?B?MlFHUkwrV2xFUTA3Vnppazd6M1QxWFE2MHhuZUU2N1hxWWtQWnB4b21wTGRS?=
 =?utf-8?B?SXpkNE03bGkxUjhrbnJqRjJRbmRzTmFBZm9teFB5UmJ1L0RuYXdINkJZSkRZ?=
 =?utf-8?B?YmRSNkdqMzZvUDdUT3dCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhob21YR29ERW16bk9vRmx4R3ZBeWxSNnpJK3lIRVNyTXFGa3R2dm1HVjV3?=
 =?utf-8?B?aUxzelpjczR0dDR3ZmFld1I5aXFYNVJvQkRQS25NZGVYb2Q3L2k2OHEvUW5i?=
 =?utf-8?B?RktjVXRHM3NzQlFOTzMzcTdOUkt5TG5kMTJhbEJFYnFLczVWSWhObHdURFJE?=
 =?utf-8?B?RGxCUEhQMUxaaUkzdG1JUjc2cTJ3V1kxN2xQQTZMSWU1S201dEFadmtJa0g2?=
 =?utf-8?B?Yjk4UkMvelhCUnk5L3dxWjVpSXE1aEpTZVFSSEZpWDVCeUxnUkdHV1hCMUZz?=
 =?utf-8?B?eDVPMXpHSE9ZanRDZ3MrNjZ2eEljUGRMZFgvWGhKVDBtZEovdGE0SldQOThD?=
 =?utf-8?B?aVVIMUloa0ZVY3o3d3FUSi9PQU1vaSthOWQyNmcxbEh2Vzg3dU1hekEyc0FP?=
 =?utf-8?B?WGtXbHV1MTFTaDlzOVhaTFV5TkN6VTA2dHBWdFJ3T0E3K1FDRmtXd2tPbmZ4?=
 =?utf-8?B?Mkc4S04yMm5YSVZsYkw3RERsUjJKK0t6MkJETFROQjRKT1FjNEZtcW91OS9J?=
 =?utf-8?B?OUNVWTFYUmhic3JZQ1lMbmsvOVczam1BaDJLdWdyZWlPdXZkTDBnMG9uclFa?=
 =?utf-8?B?elhtbWlhbFJtZ0RmSG5kRDQ4T0U5SXpOOUlkd3VWWFl0M2RzdnB0aHo5N0xZ?=
 =?utf-8?B?L244VElLUVZxV3JHL1ZsL3Bka2VGd1VtWGF1ZDllSVJHVVh2UjFnTElxQ3FQ?=
 =?utf-8?B?VTFFM2JGbzZRWjJkdWlWcXZjcmNTdkthYWxOM2JqUnc0YitzWGJQL29EbHI1?=
 =?utf-8?B?aXpzSUVmMk5ROWpSbXdZeGFURElNN2lvOCswaWxGRmZZZ3NRbGFBc3g0NHBG?=
 =?utf-8?B?cHkwSnFqYXdrbFBqRlZCUmQ1N1RaVHhwYzNaRHFNTUk0UUcrWkQzaFMyUzYw?=
 =?utf-8?B?R0JadE1zWUIxOUtZdXlOQU42RWV1UmZyempLaWhBaERvSGdrdkN6SXFiY3lu?=
 =?utf-8?B?Nk5nQVgyUmJoaTZpbjl2VkI1amQ3cTVNTFlXbGtqKzlIRUFXMFhBTW16VHpi?=
 =?utf-8?B?TDJ4RXhmNU1haVd6akVBWDVPb0JLZEIzRkU1VUZXcGh4Q1ZvZ1g5TktuMGps?=
 =?utf-8?B?ekNHbU1nYU8rbmE0MCtBTUtOVXpkZWl3dHZ5Tys0cm1QdmhWb3plSTVWQUtp?=
 =?utf-8?B?eXhsZ1pkVzkzYUxYNy9oNUw2YnZRMFoyL3U3Q1RMdGdWR3ZYK1I0WnlWd1Fs?=
 =?utf-8?B?Tmg2a2RJQkNURzAwbTdEOWpLM0V6OXBlUkpHeUN1TXV1c2JLTnNGSVBURnk4?=
 =?utf-8?B?UWpCcW1tTCtuUGcxT1pmaDJrZlIva0J1azR5RlBjTUtCa3RBVUFKQi93UFpi?=
 =?utf-8?B?ckpFTEYxaUZuVUlIMHpFelo4bm9Zb3F6T1c5VmpTTmpmTm1QSGg3dTJSYlJV?=
 =?utf-8?B?QzNtTDQyajl5WGlucFFxdTBnZnpYWGR2R3VRZk40aGk1c3VmRENEd09yRENs?=
 =?utf-8?B?MWFyYjBKNW9tQzBaajdtSi9mdGkxd1M2T2VwaWYzOEZYODR4UWxEaFNrL2Rt?=
 =?utf-8?B?SjZiVXphL0pYRmtKNGYyZElDQVc4Sm4yK1gvRDZhVGFELzBGN0h6b0dGUGZj?=
 =?utf-8?B?ZnhwRzJoTStoeDYvSVMwY2ZDbnVFV1ErZGtWT29temxEUmRobElWbXhQanh1?=
 =?utf-8?B?bFIrZW5tdnpZQ3lyZmVOUWhxY25xazBNRlpIUm96RU11a3h4VkxwL1NCWVBJ?=
 =?utf-8?B?Z01WaitTbXkxTlJjMkp0Z01XYkhubUR3QlkxbDJUV1hvTEd3MXFXWUN4K20w?=
 =?utf-8?B?emFnRUdjTUQyQ2l2OWJsZGk2NWxVdy9jT3JaamZ5VS9neXZ3dFQ3WUNiMTRO?=
 =?utf-8?B?bWUzelEwQ0JSREw5MTZkZUNkZUdaNHpFQWtYaVlWczR6cFUzNTMwdXZDWWtx?=
 =?utf-8?B?ays1T2NJZGJqLzRRcGpqR0FWdGRJMDVxWWtIR2lGcEpXNTh2akdwSlJQY0NE?=
 =?utf-8?B?UGhFVUtQZ2l3bmwyenlqdWsyRXZ0QWowSG80NnVHd2xkeVRRL0lkWW5QaUts?=
 =?utf-8?B?RHhuS2FzVlZFenFIT0cyeUFiRHp1UHlNcWdESUxGMC8wOFhwVXI4cWhOd0ZC?=
 =?utf-8?B?MEFNUGt6eC80a1ZUajArcmdxSWlNZTBpS2lyYVczZy9yQWE4UzVaUVh5bGww?=
 =?utf-8?Q?alkWcv1jgxF0SbD6vBZuvH7Dw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df65d5af-7a9c-4074-7908-08dcbd4039a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:37:52.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljxHkqECFw+trjHTk3mdstxhA7YZYPra8OlcKiO7OqvvJ/vh8+GvgRbu/ZnburRTahHSF9adKm8kvONeFArAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534


On 8/9/24 11:25, Zhi Wang wrote:
> On Tue, 23 Jul 2024 14:43:24 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 7/19/24 20:01, Dave Jiang wrote:
>>>>    
>>>> -static int cxl_probe_regs(struct cxl_register_map *map)
>>>> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t
>>>> caps) {
>>>>    	struct cxl_component_reg_map *comp_map;
>>>>    	struct cxl_device_reg_map *dev_map;
>>>> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
>>>> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
>>>>    		dev_map = &map->device_map;
>>>>    		cxl_probe_device_regs(host, base, dev_map);
>>>> -		if (!dev_map->status.valid ||
>>>> !dev_map->mbox.valid ||
>>>> +		if (!dev_map->status.valid ||
>>>> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
>>>> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
>>>>    			dev_err(host, "registers not found:
>>>> %s%s%s\n", !dev_map->status.valid ? "status " : "",
>>>> -				!dev_map->mbox.valid ? "mbox " :
>>>> "",
>>>> +				((caps & CXL_DRIVER_CAP_MBOX) &&
>>>> !dev_map->mbox.valid) ? "mbox " : "",
>>> According to the r3.1 8.2.8.2.1, the device status registers and
>>> the primary mailbox registers are both mandatory if regloc id=3
>>> block is found. So if the type2 device does not implement a mailbox
>>> then it shouldn't be calling cxl_pci_setup_regs(pdev,
>>> CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init
>>> right? If the type2 device defines a regblock with id=3 but without
>>> a mailbox, then isn't that a spec violation?
>>>
>>> DJ
>>
>> Right. The code needs to support the possibility of a Type2 having a
>> mailbox, and if it is not supported, the rest of the dvsec regs
>> initialization needs to be performed. This is not what the code does
>> now, so I'll fix this.
>>
>>
>> A wider explanation is, for the RFC I used a test driver based on
>> QEMU emulating a Type2 which had a CXL Device Register Interface
>> defined (03h) but not a CXL Device Capability with id 2 for the
>> primary mailbox register, breaking the spec as you spotted.
>>
>>
> Because SFC driver uses (the 8.2.8.5.1.1 Memory Device Status
> Register) to determine if the memory media is ready or not (in PATCH 6).
> That register should be in a regloc id=3 block.


Right. Note patch 6 calls first cxl_await_media_ready and if it returns 
error, what happens if the register is not found, it sets the media 
ready field since it is required later on.

Damn it! I realize the code is wrong because the manual setting is based 
on no error. The testing has been a pain until recently with a partial 
emulation, so I had to follow undesired development steps. This is 
better now so v3 will fix some minor bugs like this one.

I also realize in our case this first call is useless, so I plan to 
remove it in next version.

Thanks!


> According to the spec paste above, the device that has regloc block
> id=3 needs to have device status and mailbox.
>
> Curious, does the SFC device have to implement the mailbox in this case
> for spec compliance?


I think It should, but no status register either in our case.


> Previously, I always think that "CXL Memory Device" == "CXL Type-3
> device" in the CXL spec.
>
> Now I am little bit confused if a type-2 device that supports cxl.mem
> == "CXL Memory Device" mentioned in the spec.
>
> If the answer == Y, then having regloc id ==3 and mailbox turn
> mandatory for a type-2 device that support cxl.mem for the spec
> compliance.
>
> If the answer == N, then a type-2 device can use approaches other than
> Memory Device Status Register to determine the readiness of the memory?


Right again. Our device is not advertised as a Memory Device but as a 
ethernet one, so we are not implementing those mandatory ones for a 
memory device.

Regarding the readiness of the CXL memory, I have been told this is so 
once some initial negotiation is performed (I do not know the details). 
That is the reason for setting this manually by our driver and the 
accessor added.


> ZW
>
>> Thanks.
>>
>>

