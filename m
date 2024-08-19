Return-Path: <netdev+bounces-119735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA57956C75
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD691C219D9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991316C6B5;
	Mon, 19 Aug 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Mol4Abo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F21BDCF;
	Mon, 19 Aug 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075688; cv=fail; b=nUt5aHm+vC8URG3WU4Xa1wRXys4LoLYIURPd98fuhsdm0wVQP8ppP32eO4QzdZM4Y2sTPEnHHQ2DyQnavj0v1XekRgPY6cd2ARba3ju4ex20FX+df4ia21FuIrEcvxfaylPCzySwEMbtSZMBvtqhp0P78/nYnAcVAVQi9oZIfGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075688; c=relaxed/simple;
	bh=CUes7hfRNUmj04VCzqyZoHaIvGHq3+yxfqJlESHRAJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kzq1f1SmmO42CsPUm6Gr4ysbHrr08Jx6VwfNewolco1y2/uZ80jjJYtVZK9oMUe0gMVML7Y5yr64wP0EwrpK6xtvNaWQH8g7nuJEyArvPfasPxPsaLhnuSTX/7N4TLYeTaKAHKYh7TTnkc1YyxEguqnzlf1GRMEHVvyXdrxO/E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Mol4Abo; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF8rAneuMlgGyeKZf6EizObEVfF0bjy8+AkReW7nBG+d5lnapx85oEESkA7zzOlaGEeVqXcxyLZqKRh0PTN1C3W278x4qKwpFbvzmkif984rYWGrc1PIIQZ8HHpqPX3V9LalZJkk5dlnBXG9D+rLsyV4qAQdy/TLc5/K74Lwu3xtmqYqJBAIoziL/JG6cFskx9Ik3PG4aV7Ikf2YB4h8d1UfdlxX3G0/GMWC7U0VgYXX4x0P5Yqt0+DgiwU+Tiyoh+CZ8un3EWr+QPz+k9kGH5SX2xtoJw1mRVHmMc3QryV9deE8OvhkDUvv6tSM+Lt3rtFtSNbTkDXLGGQ+yE/83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3CdT6arHaLEQTS1BHpXGQ+GrqBivJGJLTkkfuSytKQ=;
 b=K+nn/VgClfm35B4cBwRsvOt6ur1knXqrku9IKQZOGuJEBSFgZAZd3NUAaMLBITuqnLdSb+3GjWy5s5LzWu9HhjPwcz5N1KcFSSUQ14DJCcmaPyMgoYs2j+F7JwECw1VHJLv6Fx3QFcu4rDM9eAZbvpCzHRS9NFApo5wodrUEvhq1kObptGQD00AFbrI6RRzwRq14T8rxZPaSltOWa9RvhgGDt+439jhdqdKMf3CbCkyj7nwCilmtV3ijNJSYJp9UGoJ/DJO1/ebpI4BuhQ3yFnbGTd/csEWtAGUqvkm3omrG23foU7emGjw+5+D28Yho//KegWUof5M/pjLjEBTJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3CdT6arHaLEQTS1BHpXGQ+GrqBivJGJLTkkfuSytKQ=;
 b=5Mol4AbodTMBV0YymwN/SRKL+006Bl9uxMBBR0aCsnR82/Sw6QF8a9/ZhD244LrLYjCI4FGQ7bpwRq7+v4FFqrOiE/7foUaI//ToedRjDR0hSkIzX3Kip+njmnvKdEhWSkdtOkU7EAsma7r6BYIvoiCsVPx9GtDp5MfEsL/ykwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Mon, 19 Aug
 2024 13:54:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 13:54:42 +0000
Message-ID: <00272299-90d0-6e0c-8a35-dae8fa3ef03a@amd.com>
Date: Mon, 19 Aug 2024 14:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
 <20240804184135.00001666@Huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804184135.00001666@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0594.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0f8669-1047-4d22-681f-08dcc05679f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0lJOStCQ2V4MHNtTHBVQ3lyYzlIdWZXZlczZzQ5S0ZxQU5UY29hb1NUcUxw?=
 =?utf-8?B?V2JzVWdLT1RBVFZFem5xOEZhNFdlWWFKTXdkd1l1cjFjQXN6NGNSNFBtWnlx?=
 =?utf-8?B?Mkd1d3JXMjQwYVJrQVMyaGJQbHZrS0VMQjRGUCtuZk84SjRINGhMUHp0U3dy?=
 =?utf-8?B?Wit2VC9WOEJuSk9Ed0tIejR1dkFmRmZjZFVXL0ZVWU1ERHNtR1JaNWdTZDRO?=
 =?utf-8?B?Wmhmc1U5SHlSdFFpbkNKQ29YNW9HVXVpVGk0RFF1eGdRK0RSdUhMMy9UZ1RG?=
 =?utf-8?B?VmRET0ZQSWpROHVrUG5vUHZYUERoYmgwUVVJWUxvT2dRejlyY3NNOEgvUElr?=
 =?utf-8?B?LzRlWk5BQU5KSGlUNCtRM3lueTMxdHgwdm5IS0lSZVFKQnJJdGVLZWdkSnI4?=
 =?utf-8?B?OUhna1kyTmRxU0J1TjFEaDBnS0g2NE9IYWgwRytrZGR1SFhUV213a1R6eTlF?=
 =?utf-8?B?QUVrV3hxQUVKeTJaVmdzRzZiMGZRTHJNRUNibnlBTmxEeGp6VmtiTjY5aHll?=
 =?utf-8?B?NkRET3BFN3NCcHhDQXNGWW1tdlNIaXFDYjc5em5RWFZWK2VKVllGcnlOWmRp?=
 =?utf-8?B?bzJXUjJhcy9tbHNsSWVJY3J3QWdOY091bUpTcWtSUTVnZUlBUWVGQlpqSi9l?=
 =?utf-8?B?NHkxVm1nK0NDd1lyZjNHYncxclBEK3VGQStPTXlDRTRMU2ViKzgySWR3UGt3?=
 =?utf-8?B?Rk12VCs4UmprSmJjamI3NWhmbERkYzU5SHBoSnUyMnNKWHZhaE56TnJRbUdQ?=
 =?utf-8?B?clVEUVBWZmFBWnA5SUc3aVNmZ004RXNjL05rb0VkL0dXT1dVbStFZHVqOW9t?=
 =?utf-8?B?VHFwa2x3YzRzMFZvTjhhZm9RaTNTbHo3MU1lRW56dTlRWjNDakJNek40Q21z?=
 =?utf-8?B?RXVkT0l2U1gyVFNkSFZ1SGxwbTF5LzFUMG15T2xQVWhqbGRScGJEci9aTnR6?=
 =?utf-8?B?MDFkTFlHRDg2YjY0VUZuNEFocEZwKy94VzdEa0JXVVdkcmpRbjQvVVdLU2Jx?=
 =?utf-8?B?a0Y5TEs5N0pNbGYwSS92RlFRRDJOTjd0QTJWNXg5NjNMT3hheS9tTGNBY0ZU?=
 =?utf-8?B?VDF1eUY1eGJjdlVJeXlydjJCcXcvdmlkZ0Vic2RCNGtzZy9nQU5reU14QTBF?=
 =?utf-8?B?OE4rTm5SeE5KYUFtVEFOOGEzWG9rUUs0aThOeGVYN1I1QzVMVnJYamwzR2cx?=
 =?utf-8?B?c1laa0Q0ZlBpMkJhUGhkVjBOemVFNWZxekNsMjVDOU5jaGI4U3VvNkZPT3dD?=
 =?utf-8?B?UkxiNU9CVmhYY25BQ0JaN3hqZWVwcXV3amZwdTZtTFZHcnpkUUZ2YXpVVHFE?=
 =?utf-8?B?eG85TDhYOFl5WTF4YXZuM2xyb0dVeW9Vb2NGSTJOUXBXdGlLNjNIWGtHQlp5?=
 =?utf-8?B?TWRDN29SeTZhd0luakdyb3JZYUduQXp4MVZwaHFlUG5YMEpTWTJOWkh0eHp5?=
 =?utf-8?B?a2o0Ykh6b0dqWTYvN09NQ1JNVldacGE3QXI1L3MxUE5VM2RSTk1kV2MwdFZO?=
 =?utf-8?B?blRETzBlSFoxYnFJT1Q1VlJmUkxST2dCb01EOWgrejBKU0pJd24xbWMrVlBn?=
 =?utf-8?B?Z21jUGd3bG9CRDc2UUY4cTNkOHcvSEpOYmhndlA2U0RjOGh3SXBVc1YyN1JY?=
 =?utf-8?B?Y0NJUGJ0OWpJc093Y2RYU1F6blQ1aHBabHBmbWlhRkhVaGpuWWNzNGNBNU13?=
 =?utf-8?B?RUxmY2c1NTlERGxNUFpiV0ZtMkZVNy9GMnJPdkYzUXNvTFpFUzUxbzJRUEtW?=
 =?utf-8?Q?Z6q4PHIekyp5dtEsA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTZ0U3VwaGM1Y25hMG5nVGx4QklSV3FYMmhCTUhOcmgvVWRna1BET2loNDY3?=
 =?utf-8?B?WnYwUGN3MWc0eldjZ3o0WTdDN1FFcVp1S3ZEUGRZaFVTaGluRnF3S0RadndE?=
 =?utf-8?B?cEpvWGxlOXJLSnlMRmNGVjR3ZzBqR0V3QU1nei9mS0tLbkx3dEJkekVkc00y?=
 =?utf-8?B?WkxtOGx4bnE3bFJUOXdGOFlKTnVEMkNGV0FuV29KNWtkKzVKSFJUMkFsaVNh?=
 =?utf-8?B?N2V4ZTVWSnZETXNPL2ZlNE9NUisvdkgwR1B5L29SMkRMNWd2WDV6WjErWDBU?=
 =?utf-8?B?aC9ja3RFL1ZiZU9ySXcwbW1DWENtdU9uMS9JRWdTN2RoN1VPd25nbjFxU2M0?=
 =?utf-8?B?Tlp2bFVUc3A2OEhIQzBFQVM2QlJIdnJDWVdwSVYxUWpodEUvbEUzcUpPSGFK?=
 =?utf-8?B?SXJJOERyOEZBVUgzM2oxd3QvRWltZkVLajV4cEl1RUU3TmtGV0Nic2w5ZHVm?=
 =?utf-8?B?dWQzdHluRlNRdUFGeVdDenRwZkIrSmtPbFFsNE9jQTV0NlBOUW9xa1VHOXhR?=
 =?utf-8?B?bGVUbVd5WGR1dU5TQUMvc1Y0MjlUQXcwSmdoemR0b0pXQTFtcFVRL1NEOHo5?=
 =?utf-8?B?NVc0RGtDOW8zUEtyaG10Y3FYTkVJaDFFUTFjYTJLVkEwanBDdTMvVEJwcFJQ?=
 =?utf-8?B?MnFMdTlBVlNaTnZQNkRlMjdmUHRTZXZsNzljd3RCRE1hK2wrSnhrS3lqcUlS?=
 =?utf-8?B?Z2licktpMDVtSGFwOVU1bGlYZWZPMnA1MjBiY1gyR01paUg5Vko1dFBzTng0?=
 =?utf-8?B?OXVIU2VWV3BjbjBwQVQ3ZWRidk8xY0FNS2Fyd1NuMzAwbFBId0tYWWNab0Iw?=
 =?utf-8?B?QmRBRWlocUx1RXZ2dWhPWDVySEtyNW5VSVZTRFZtVUc0ZjhhV0g5c09nVlNz?=
 =?utf-8?B?akRFaHZPUzF6WVBFRDA4azFreHFmUmk0NHdBenBzdXpSeXRrbHdOODgwbUJt?=
 =?utf-8?B?T09KWVBpenpuY1lsNWVHb2F1YUZsSTB4dktvSno2TXhYbGdnbE80SFBzak1P?=
 =?utf-8?B?ZnUwKzhmdGpWOHgvQ3YxbzVDU1E1eG4rMHBWWXN2MDFnT3podGNuNXdRMkRK?=
 =?utf-8?B?WHhpc3R0RExvdzdxVkdzYThIYThUV2JWME5VdERmTG5PUWZHR3BDV01yN3gy?=
 =?utf-8?B?bjhibmRJN2tmbWwxM2J4eWtZZCtEaVV2RXpHeUFyTVAxdk9NU3R0aktMUUpo?=
 =?utf-8?B?WWhwcDlicEV4K3BVZ0JnUVBGZXVsczN0bHJ1dG1JWTYySFE4UnBDMHdXUTlO?=
 =?utf-8?B?SDQ3YXBzRklYQ0dVTTNHaTZpamFycXR0UE1aRndqamo1VE04QURKVGsrLzNK?=
 =?utf-8?B?K2RDUWd3NkxjYThRYzF1WjFNT09HZHVBcHU1NkQxd1FZZHRXMmQxeG1uWUk1?=
 =?utf-8?B?WEhVUm4vTlp3c0c5U2pUN29GeXJ6M0lkVFdOb01QWmRHYzJIdDBUOW14SUkv?=
 =?utf-8?B?WFMveWVReGhRQUtQS1BoM3NTWjZGN01ZdERWeVBUc01UUUJjaWVGdit2bnBK?=
 =?utf-8?B?Zmt0UnpGU3ZLdVY0TU82eFY4QnM3Z0dPLzV4Y2o5TjcxZ3dLczJpUndGYlVP?=
 =?utf-8?B?RWlzdEhEbWdteEg3S0dhcktUanpZam5wVkNJR08zb2VYUmlCRUI1VTB4K1JD?=
 =?utf-8?B?a1VOclMwLzJmYjZKeUJpb0xocXBtdm16d0JFWTVFQytaVisvWFYyenhSby9t?=
 =?utf-8?B?ajgveStYMHRnVm96b2VMZXpPTEhUL2VXNWNWbjl3dnppVEhoaHRlT1huOHIx?=
 =?utf-8?B?QzFHVXZWdEw2WjhTbXRBKzVBSUlMUGJ5M29KOFdwcGZYcnNPMXdLM2ZSZ09s?=
 =?utf-8?B?ZWhqOXJlRndDMEJnTlJIRTBXYkJId3JIbXVjd3RZQWJocWpOcWJHeU5PU3RL?=
 =?utf-8?B?NEJhMkx5WStlOUZPSVhaandieUNsMmw2Vzlma2VSWVFxRlFWQnJOL2g1c2NB?=
 =?utf-8?B?M09ONFplMGc0OVlLQzVYdkQyajhPcFhVMGlGY3pmWjRxM0RZQktBLy8yb3Fz?=
 =?utf-8?B?eTBVQjBVZW9MUlhXNVl1YWVKcFZ3ZXZleGZYNWdDNGRPQ0JmbWNNQWFrT1VQ?=
 =?utf-8?B?VWhYVTU0bm5kaWl2aWdEc2N3TlBnMk1ncGNoL3NqZXVSblgvVy9hSWx4Q2pL?=
 =?utf-8?Q?dDccJn/Eqa9+ffWMbEY3Eho0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0f8669-1047-4d22-681f-08dcc05679f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 13:54:42.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaEi2jRvruLAr0cP/OZRxS+Uz9EGgdTagX7OeNZQM07XjD7tS7cuzUtdNjca9mkXp95pMzFg4jTZJoym4MYh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602


On 8/4/24 18:41, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:28 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> The first stop for a CXL accelerator driver that wants to establish new
>> CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
>> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
>> topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead defer
>> probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be defferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> The first consumer of this API is a test driver that excercises the CXL
> Spell check.
> exercises


I'll fix it along with step instead of stop in the first line.


>> Type-2 flow.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 41 ++++++++++++++++++++++++++++++
>>   drivers/cxl/core/port.c            |  2 +-
>>   drivers/cxl/mem.c                  |  7 +++--
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>>   include/linux/cxl_accel_mem.h      |  3 +++
>>   5 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b902948b121f..d51c8bfb32e3 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver
> It might have deposited an error that isn't deferral I think.
> I would be careful to make that clear in this comment.


Yes. The situation this patch is dealing with is not easy to handle. I 
realize the accel driver needs to be aware of it what the sfc code does 
not handle.

I need to work on this starting with emulating the situation and maybe 
adding the work as a test ... where we need some emulated Type2 device. 
Dan was asking about some work done before my initial RFC where Type2 
support in qemu was the target, maybe something we can talk about in the 
LPC.


>> +*/
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	int rc = -ENXIO;
>> +
>> +	device_lock(&cxlmd->dev);
> I'd not really expect an 'acquire endpoint' to exit
> in the good path with the cxlmd->dev device lock held.
> Perhaps that needs a bit more shouting in the naming of
> the function?


Uhmm, not clear to me at this point if that is needed. This is basically 
the original patch by Dan so as said above, I need to work on this a bit 
further.

I'll try to get this sorted out for v3.

Thanks


>> +	endpoint = cxlmd->endpoint;
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>> +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d66c6349ed2d..3c6b896c5f65 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>   		 */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index f76af75a87b7..383a6f4829d3 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>>   		dev_err(dev, "CXL port topology not found\n");
> Hmm. This seems excessive error print for a deferred path.
>
>> -		return -ENXIO;
>> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {

