Return-Path: <netdev+bounces-118894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C5C9536FA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61481C242BB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC01AC427;
	Thu, 15 Aug 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQQYqCEq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111E1ABEBD;
	Thu, 15 Aug 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735252; cv=fail; b=GCnSnvkuWF+TbGRr3601jnWVjZl5Y75ZfsWVCSRUJn2LXVjrhqyKQd4OrJcJ0XEh5Z6BhePcuVxKABTQDa5AABq0ycZ6rwkFLplAKKdkcPthYRNn8l5/zhthA5CPIvpvY44fqYimtVr6P/Flz++LvMqscfdmQXI9ImWOEPTcIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735252; c=relaxed/simple;
	bh=MES9dJmouUrjjOkMeJfNfM5tKbUvljHAc2hVbvDhlPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mcL4Ofk/HVdNFxAKHp7FRv68PNmLWwYtShm6HcQsKfc2fZR/yphIHsr5eE80BHm6JPfhACmKPYmnkpJmhvbh3wAwdSOx0r0d18xeNfM5q38jmgs1ljCr1AGWS6ZfvAFbfmwB1TUbdQkKlRc5iETqA8gxo5LNi7YmXh8BbWtvs0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQQYqCEq; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXHcmBdt30hV4t2QuvHFF68SAtKBHjtjcf4xdcIvEXm8vupYRrkR9YiZycb1UGVjBWEcHvNE6HA4S/1VNrS4mJrkinJqFGgiS/9kmvVZq813k3/U2DT/6sZpBCp+fJFSKH6xfnY9yI0uTqTg0osFzGnHZR1NgSP4mNrelvRHqSAw3Ab92gaU1/jiCngabKIorUZbBlkmC0QK3Ns5+n/eUcLI3JyifxDCFYN1LAWG+eWoQYS8C90H6Dm+ws3BF9kNE2A4Qxh7HDi4bZmnfJdUs9V4BtjR0Cv7CzFkE/cxWJNZLS51emQ2VwDUHoGrise3I1vp+Rb5NsWmDMTGBcRILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qKlGT1UqgjfrjCSkHaf1lWVe0y/IhpsRBWzmIsxo1c=;
 b=NqHa0jCTD6cdWyv+SbM61KK8o6yIW3N0OuHIRolZLtc4cWQQyHC1H4eFo+NgkC8aioVYB1uvMFW0na4CoFWkycicakRCxkhYfpyxZcgNMV27s4GtoA97b5791G3J8PrcTa6ZDV86+MvP8gTKnC1SY4/sDkwzvgt1LhdjP1PkNrzAS2AvWr8+m3iJEfeN2NhMg8bjeCNOFzRQqWWx6emuj4tsVbv604OcRZHOaBYQvwuUY6e1fST2BqImcOF2+OkMiOwkPZX7Dk9EZ3+IqM7ZyjE8dAJQT/78ri+w4S7pLTAoeZZitcl+9PJn3KdKkkY9nAdBMmHKvs82AZSZ5uFCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qKlGT1UqgjfrjCSkHaf1lWVe0y/IhpsRBWzmIsxo1c=;
 b=KQQYqCEqW1NwfkEZcdO2/1a5GETq+ZVWmLijLa5x41bwiqkFxHRwIOnfLUa5dWKSsZayFdOJYzR9IxxBz8YlaL26goi+5TsLPSxC9t9WiVHF9t8ReDQ3iiDmdfv+ZMzriaXPvKQYY41E3/DVM4SJNkRGWeX1+X1bBGXs3IzDPHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 15:20:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 15:20:37 +0000
Message-ID: <e4ab55fa-d406-4ef8-1ce6-706c2577b960@amd.com>
Date: Thu, 15 Aug 2024 16:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com, targupta@nvidia.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
 <20240809121036.000057f0.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240809121036.000057f0.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3b866b-f768-4cd8-50ac-08dcbd3dd0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlpXcDgvS3lUR0djWk5RblhQeFFHa092UWk5UWxsVlhuNmJGTjA5OTkzZFMy?=
 =?utf-8?B?OWFkT1lmK01vS3pKMDFsTlVOODl4Sk83ZHZzQ1lJZmYwMUYzZUxYVGNJQWdV?=
 =?utf-8?B?QWZ2K05OQXBpblJqSGFPR2xuYjFmQk1zTFErdHlLTXJLcW9MM09xZmZGZVAx?=
 =?utf-8?B?S2VNTXBZUHZDdUtpUENJTHVNT3NTRzlKaVRnT240WU1YWEYyWmwzc2VKVTJx?=
 =?utf-8?B?RkpQUndXQkk2OHY2MGR3Z2lKQ3BPMDVTTjY2cEtXL1VHRzVWRTdoalpSTXg0?=
 =?utf-8?B?ZlRaRXhOdTdIRGV6TEFEU0kreVZGU2Q3eHVPMFp5bGdpOW5vaXZsdU8walRk?=
 =?utf-8?B?NmVtVUNtNVV4eGs4ajNsTC9BQWNDWSt2aGRFV0ptdS9INzJTcEhIbVFTQWkw?=
 =?utf-8?B?ZHBuRTNQUW8vdHZER20wek5CWlRVRElCZ2dmL016eHBzMWNLcy9UMlVYc0xM?=
 =?utf-8?B?ZlVTZUIwZ3FGZTJ1N3o2K2h2UDErNmFFWWc4S1hURk9hWEE0bTV1eE1kMzRs?=
 =?utf-8?B?Qy95ckw5c1ZnSFhrYWVLaDlrNWxUaW1tUW12ZDA5OXhVb0h5ZEE5aHNabHJM?=
 =?utf-8?B?Ymd5ZHZzT3RHNEtrREMrUjdXVXJvbnN0eFRYSnpXcW91MGgxYlpiYUVjK25N?=
 =?utf-8?B?QnZJUFpnelJwYU9YSTdsOHBDRm9UL0M3Q1NhTHlmbVBaWlJ3SE9HbUtIWEZi?=
 =?utf-8?B?OFArakVsWkdwVlpTTUtnQU84b093UTJuWE1lUVZkQWUyRGh2L21TUzFrMWtO?=
 =?utf-8?B?NFJqMG5pdlcxblcvL3Y3cmQwaEN2aXJhSkF3L3F3ZTBMWWFjbUs1RmRXSzdr?=
 =?utf-8?B?L2prZFpZcEhLd0V0bzM0RmxiYUNyZkh3UGZZYWoyWitJa214WUVtWW1zSDkv?=
 =?utf-8?B?VVhWY0puL0luV1BGZVJSb1NLMHVzMzJxaHp6VzM0QXF0WDVuLzFlMHVNaUt1?=
 =?utf-8?B?eWhOL0hoS056Qk1ialpCcWZxZEJwUjdiazBWVXBqVzNFTlNaaUxnQ08zOVlI?=
 =?utf-8?B?cEtoNHNsck1SYmxvNStRT0RwQnpueXVBMXBmaFhLeHZQcjFnc2l1Yys2ZVUr?=
 =?utf-8?B?ekpQcGJZNlpFRWx4ZEhTQkg4SFRyWFc4TzQ5M2N5ZTExY3Y5MHpBMjdtVFMv?=
 =?utf-8?B?YWhqOHJmTzF2QWFnWmFXSS9pbFZFSytoRmhVaHlkbFBRbWdJMUwvU3BPUStF?=
 =?utf-8?B?QTBzL1BSSU54cXlON0N0REJuL1p1Y0tjdE0zQVZtQ0NIc3JmckdteGdIZXJF?=
 =?utf-8?B?cEtLTU9FeHZYQnFMeHdjL3JsSnZiTURGWHdkOU9WV1lVcWltY0VNM3U5eTZV?=
 =?utf-8?B?c1d0U3l5M01KTGlqS1hoekNmMGFlQkdVd1QzNWdySHdpaFlQaWxHLzFEWExE?=
 =?utf-8?B?TGp5VTh6VXJvVEJFeTAwY0hxKzZBT0FnSXhmVDFDR0JleUE2UXAyYW4wbUlp?=
 =?utf-8?B?eWVuTkFZVllaMitpTUxzQU5uUFc4RHcrSEthZndLc0NqRzNDR2k3RnVJYkx5?=
 =?utf-8?B?WStVNHZud2xGcE11ekF3L0R6MXhPTHZsajJMOEJWc0d4dy85QnpMQkk5Sjdt?=
 =?utf-8?B?aTg2ektpeVpBTlh2SUNPYTZPUW5QeFpJOU5KWjM2b2VPcjNoSnRnOXV4d0Nq?=
 =?utf-8?B?YWNDQ3l0VytLRkZWYzdSaXNleE5QczRDS3ZCTjh3NWxmY2VIZVpuelZrQ2Jn?=
 =?utf-8?B?bjdnak0zL1c1QmVWZDZXUG5hTW1IWExNazJNZnJvc0JVaExHRzBTTUd1RU9Z?=
 =?utf-8?B?RC84a2dxLys3ZjZUTUJaRE0zMWR1ZVNQRFJBVnI0YVpkK1pRMGFOZGxnc05Y?=
 =?utf-8?B?bWZsbFZ5bEwwb0VFWVlRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhMR2hSMkF2OFZoUzdkVG5MSFF1VVNRcW5NMm1lRnF5Q0xVT3dHODIrUkls?=
 =?utf-8?B?QmhKRUJlN25PdFplN3QvOHVLTWQvbnNkdHV4SFBHZVFWNDB5eFhKYm1vTzJI?=
 =?utf-8?B?anhBUCtNalMyMWtodlQ2Mjd4RlFHdGZuUWJMWU9FUDF1RlBvMHNKNXJzWjQz?=
 =?utf-8?B?V0RXNVhPb1pLSDU5NWIwMnoyZ2sxRWJWaVMvOVNGZmNNVjlxYjJFQy9UeTlD?=
 =?utf-8?B?NkRVaEt0UllPVVJEeHhQVUxaOENwVXlCdXg0cDNTdmxXR3grNEZQYXM0bTlB?=
 =?utf-8?B?K21sUmoyN0dQdkZ5Z0ZzVVFHMXhBMWp0aTNTVW1SclNzS1ZJM1hqTCtCSTBI?=
 =?utf-8?B?bWJ1M0wzMjZqWExVSXQ5M1VhUm1JSndoK0hGeE42UnM2ckwzeUhLamJSb3Bx?=
 =?utf-8?B?NmVSQ0lxTStubU5EZmNCa0J3aGVXeG9JanNCU3VYY3pSRWUrOGZoaEltc081?=
 =?utf-8?B?NDRGYldYS0ZVSGRra0ZDZ2hudkZxdk16RStUcDBXSi9KcWt3ZW9iWlB5cHVu?=
 =?utf-8?B?d3c4MzdLKzR6TUZmQ3F2R1F0RmNZQUFFRHh5em9PbzcwOWF1QVg3aHlTMDY3?=
 =?utf-8?B?UERwR0pzZmc1dFZoYnRJZDNKcWlZbHBIdjRHNEJ2MTJlZmdvUmZmUE5xRE1t?=
 =?utf-8?B?QWZiL01rNFVmMWg5MGZjckxiSFFGWTF3Rkh6bWZzOHd6dy9TRytva2s3R1I0?=
 =?utf-8?B?SU1xQThCL05KTHlqeklOcm1mTzJQL0lvVHFjNHU0bnRId1hFenRNSFlEM1Uw?=
 =?utf-8?B?WFJEMXdFeFlrUmxPN0QzWnM5bVlwSTlpL1plVXJGczFIcTF4SDVyZVFtdWE1?=
 =?utf-8?B?eWRhS0dVVHRlcGM1T002UTd1Nk95OFFBMXk0RTJwYmxBTDdXTWR5OVBVZlNM?=
 =?utf-8?B?NGU3WXBHTFVsUXllMXpwamhqbVVKQ0hXbFlCNnEvV3JkU29nazhuMkl3Qit6?=
 =?utf-8?B?SXU1UDdzbjJzSUdNdWI0UjcyNTdFMGxqb3ZobVdXY2JqWEgzaXN4UHhJNEpH?=
 =?utf-8?B?L2F0L1dpc2t5RjVuc2g3SlRUOUJXdmpTMTdCc3NnOXRrQjB2dHhCTFJSblFt?=
 =?utf-8?B?M2JSaFBjQ3V2cHBTNVg4UW4yZ2JqVWh1MVc0RDdhYTRVSnhkM0FleUtGeXFS?=
 =?utf-8?B?N29xRU92V0VNUXBrUWxiQjBVQ1cvWVF5UmQxOEovWlQ5UWpPekVkb2t0RkdF?=
 =?utf-8?B?QzlzNmRwTUV2N20rMW1WNTVEekovMndFTERLTVJwWUZTTnZVRFU2Y0ZIUVFs?=
 =?utf-8?B?OTd6MDM4M09ZaVVXRHl6Z1l3MUlzYW4vbHZhN1ZpK0hiU0p4RDBxdU5IT0xD?=
 =?utf-8?B?RmRSbDY0OGRlUnN0RG5nVHVBVFkvSllLVXN4U0V2VjNIN2dPb0poVUZaYW1P?=
 =?utf-8?B?bmpFMkFmSm80SnJLWU1OUk16eTkralU2VVIvWnorWFNpU2NTYnpHc21RUmJD?=
 =?utf-8?B?c0xvdE1SczdPenp0Z09Wa0dxaDRlTC8ycW1uS3VyMTE2MnFEV0F1azJwdmZJ?=
 =?utf-8?B?WnJtVDFYM0V4dE4vTTJPZlRsdUxZV29DZURyVExBcUk4UnRhSEw2YmlDK3hK?=
 =?utf-8?B?cnVxZGdnSmhnSzF5S3A5SjUrVkVHTmRiMzlvR2hTcFZqcUQ1eGFQbllaRWNn?=
 =?utf-8?B?aWJRMDNXMXVRZ3Y1V3hkOHlEaFo5NnFwM2F3VU4zdklUUWJhQ3JzSC81RGN6?=
 =?utf-8?B?KzNuWmFLSEFMWjQ0R2taTUNvYmFBcXV3bENtY2hialdpUDJSQzZ0cXBYYUpJ?=
 =?utf-8?B?Q3VzdEFqSTNvbWJ0UkM5RVhFY0ViZ1dlRUgyamlpeWZaN21QeFkxNEh2V3RS?=
 =?utf-8?B?ZFRXZTk4SVYwZDMrblVrd3R6Tnh4OXBQakJ3Mk8rTC9ZKzRXQ0luLzZJdlQv?=
 =?utf-8?B?a29FeEZOcWZjSlBOcUhJS2p1dG1MRVBOOU1kQXQyUytjTkJhNVRTT2YwTWc4?=
 =?utf-8?B?eVBpMmd1TlJxd2lib2lOeGV0eW5EcGVhNW15cHZwQmlIbk1FNkI5cWtJUGJ6?=
 =?utf-8?B?azVhU0ZOZW05VTdNL2o0ZkJWUk5vOUhmRXI4SnVIN1pyaGR6b2NraUNGNFBF?=
 =?utf-8?B?MzhUc05SUlEwbEc4bnIyNFV2VUNMbVVXUnRya2JxdU1VQjZnNTNNSXpOV2x1?=
 =?utf-8?Q?InhhR20Qm/Cw/0imtHoT61yzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3b866b-f768-4cd8-50ac-08dcbd3dd0a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:20:37.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BB9cm8uXNqrThBhroCiw/QsVrwJ+UHpd2d57O84ge7c2dmgpPhXzMHVVR1IVXU9L/WNM4ftgKeYZNdaeT4bCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346


On 8/9/24 10:10, Zhi Wang wrote:
> On Mon, 15 Jul 2024 18:28:24 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what a CXL
>> accelerator implements.
>>
>> Add a new field for keeping device capabilities to be initialised by
>> Type2 drivers. Advertise all those capabilities for Type3.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c            |  1 +
>>   drivers/cxl/core/memdev.c          |  4 +++-
>>   drivers/cxl/core/port.c            |  2 +-
>>   drivers/cxl/core/regs.c            | 11 ++++++-----
>>   drivers/cxl/cxl.h                  |  2 +-
>>   drivers/cxl/cxlmem.h               |  4 ++++
>>   drivers/cxl/pci.c                  | 15 +++++++++------
>>   drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
>>   include/linux/cxl_accel_mem.h      |  5 ++++-
>>   9 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..2ba7d36e3f38 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1424,6 +1424,7 @@ struct cxl_memdev_state
>> *cxl_memdev_state_create(struct device *dev) mds->cxlds.reg_map.host
>> = dev; mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>>   	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>> +	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM |
>> CXL_DRIVER_CAP_MBOX; mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>   	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>   
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 04c3a0f8bc2e..b4205ecca365 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -616,7 +616,7 @@ static void detach_memdev(struct work_struct
>> *work)
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev,
>> uint8_t caps) {
>>   	struct cxl_dev_state *cxlds;
>>   
>> @@ -631,6 +631,8 @@ struct cxl_dev_state
>> *cxl_accel_state_create(struct device *dev) cxlds->ram_res =
>> DEFINE_RES_MEM_NAMED(0, 0, "ram"); cxlds->pmem_res =
>> DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +	cxlds->capabilities = caps;
>> +
>>   	return cxlds;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 887ed6e358fb..d66c6349ed2d 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device
>> *host, struct cxl_register_map *map map->reg_type =
>> CXL_REGLOC_RBI_COMPONENT; map->max_size =
>> CXL_COMPONENT_REG_BLOCK_SIZE;
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, 0);
>>   }
>>   
>>   static int cxl_port_setup_regs(struct cxl_port *port,
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index e1082e749c69..9d218ebe180d 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -421,7 +421,7 @@ static void cxl_unmap_regblock(struct
>> cxl_register_map *map) map->base = NULL;
>>   }
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t caps)
>>   {
> Can we not use uintxx_t? Just like any other one in the
> cxl-core. Generally, u{8,16...} are mostly used for kernel
> programming, and your previous patches use them nicely.
>
> Let's use u8 for caps.
>

Sure.

Thanks


>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
>> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> +		if (!dev_map->status.valid ||
>> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
>> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
>>   			dev_err(host, "registers not found:
>> %s%s%s\n", !dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> +				((caps & CXL_DRIVER_CAP_MBOX) &&
>> !dev_map->mbox.valid) ? "mbox " : "", !dev_map->memdev.valid ?
>> "memdev " : ""); return -ENXIO;
>>   		}
>> @@ -455,7 +456,7 @@ static int cxl_probe_regs(struct cxl_register_map
>> *map) return 0;
>>   }
>>   
>> -int cxl_setup_regs(struct cxl_register_map *map)
>> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps)
>>   {
>>   	int rc;
>>   
>> @@ -463,7 +464,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>   	if (rc)
>>   		return rc;
>>   
>> -	rc = cxl_probe_regs(map);
>> +	rc = cxl_probe_regs(map, caps);
>>   	cxl_unmap_regblock(map);
>>   
>>   	return rc;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a6613a6f8923..9973430d975f 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev
>> *pdev, enum cxl_regloc_type type, struct cxl_register_map *map, int
>> index); int cxl_find_regblock(struct pci_dev *pdev, enum
>> cxl_regloc_type type, struct cxl_register_map *map);
>> -int cxl_setup_regs(struct cxl_register_map *map);
>> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps);
>>   struct cxl_dport;
>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   					   struct cxl_dport *dport);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index af8169ccdbc0..8f2a820bd92d 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -405,6 +405,9 @@ struct cxl_dpa_perf {
>>   	int qos_class;
>>   };
>>   
>> +#define CXL_DRIVER_CAP_HDM	0x1
>> +#define CXL_DRIVER_CAP_MBOX	0x2
>> +
>>   /**
>>    * struct cxl_dev_state - The driver device state
>>    *
>> @@ -438,6 +441,7 @@ struct cxl_dev_state {
>>   	struct resource ram_res;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>> +	uint8_t capabilities;
>>   };
>>   
>>   /**
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index b34d6259faf4..e2a978312281 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -502,7 +502,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev
>> *pdev, }
>>   
>>   static int cxl_pci_setup_regs(struct pci_dev *pdev, enum
>> cxl_regloc_type type,
>> -			      struct cxl_register_map *map)
>> +			      struct cxl_register_map *map,
>> +			      uint8_t cxl_dev_caps)
>>   {
>>   	int rc;
>>   
>> @@ -519,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev
>> *pdev, enum cxl_regloc_type type, if (rc)
>>   		return rc;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, cxl_dev_caps);
>>   }
>>   
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
>> cxl_dev_state *cxlds) @@ -527,7 +528,8 @@ int
>> cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state
>> *cxlds) struct cxl_register_map map; int rc;
>>   
>> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>>   	if (rc)
>>   		return rc;
>>   
>> @@ -536,7 +538,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev
>> *pdev, struct cxl_dev_state *cxlds) return rc;
>>   
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> -				&cxlds->reg_map);
>> +				&cxlds->reg_map,
>> cxlds->capabilities); if (rc)
>>   		dev_warn(&pdev->dev, "No component registers
>> (%d)\n", rc);
>> @@ -850,7 +852,8 @@ static int cxl_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id) dev_warn(&pdev->dev,
>>   			 "Device DVSEC not present, skip CXL.mem
>> init\n");
>> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>>   	if (rc)
>>   		return rc;
>>   
>> @@ -863,7 +866,7 @@ static int cxl_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id)
>>   	 * still be useful for management functions so don't return
>> an error. */
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> -				&cxlds->reg_map);
>> +				&cxlds->reg_map,
>> cxlds->capabilities); if (rc)
>>   		dev_warn(&pdev->dev, "No component registers
>> (%d)\n", rc); else if (!cxlds->reg_map.component_map.ras.valid)
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c index 9cefcaf3caca..37d8bfdef517
>> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -33,7 +33,8 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability
>> found");
>> -	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev,
>> +
>> CXL_ACCEL_DRIVER_CAP_HDM); if (IS_ERR(cxl->cxlds)) {
>>   		pci_info(pci_dev, "CXL accel device state failed");
>>   		return;
>> diff --git a/include/linux/cxl_accel_mem.h
>> b/include/linux/cxl_accel_mem.h index c7b254edc096..0ba2195b919b
>> 100644 --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -12,8 +12,11 @@ enum accel_resource{
>>   	CXL_ACCEL_RES_PMEM,
>>   };
>>   
>> +#define CXL_ACCEL_DRIVER_CAP_HDM	0x1
>> +#define CXL_ACCEL_DRIVER_CAP_MBOX	0x2
>> +
>>   typedef struct cxl_dev_state cxl_accel_state;
>> -cxl_accel_state *cxl_accel_state_create(struct device *dev);
>> +cxl_accel_state *cxl_accel_state_create(struct device *dev, uint8_t
>> caps);
>>   void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>>   void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);

