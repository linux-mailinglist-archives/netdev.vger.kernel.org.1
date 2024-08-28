Return-Path: <netdev+bounces-122553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DB961B18
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D9B228BB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68294DDDC;
	Wed, 28 Aug 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fA8LmfJO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D115C0
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805036; cv=fail; b=fLkfZS6+Xk7j+cLV/JlNNErQgpH3YNF+S9+g/9vs/sdB8Eghb3cYXZGpJC8NUIZHkHKTuUR8a/ISzLwhH3YGzOOmYf0QgFyOPDzHkOPk3CD39MLFeOzTy3EFJQ8KDty3pm+MzHumeCgN4Ta4682g2+gPfg/r9oFK9nI4eIr9S+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805036; c=relaxed/simple;
	bh=csG9Ri8HCvFekzTqr8nJ5Jtchfv+sxyRdTSQ2/PgQA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1OZ7O6CVDw0upXVHhI89VW9MxOfC9V5RENLDLSp0NAJM3cbudea7rUs852WmEXN7pMpZNYttvjQiT95ICL0iXzEGMeeBItKcS/gmbnqfZwMr67GOcVA9hIJ944+sfLW/oe4wT8/vUCiYlUE8Tb3CHQbJz4JA1jk2yunWlJOnp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fA8LmfJO; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFUxs1PG97Lq1bCTmTh+uOSgZg/i8leJ+N9tfAQ1+FzeyATc41U5tUerBNXYHH2c7jsAL9s7m8jk/8kJ4seqA4V+Qt/juI9ZxxN5eLFdB/Odb9/hJtFeB4Wk9rWudzLP27jF2unj1f7TUI71CAu5DrsraoqKXtD3LA0VHxgJviDv6kFj+69FWOuUHpS4CbMAvZ5K3CnGM/qHsL0CDSbVbDWSt9R/L1lChIAL8P8clUb4aC3NCteZyH9ewzwGsCDVdeUXgqG7F6+azHS7TJN3WY2+w9rmgUM/e117017f0xgMwZBNr9uMMOFLhbUAyqrpBSIsv1eH6jnd7xqTD1X4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOYoqUY2tv4OBaLztgIED8TSstpgB/GOw711xeVVlIY=;
 b=BbrlPTplua/COHT8N9dlyFjwPhblVffVV2IjNkehmIP5ZftdK0sWkEtp4XaDXEDXVGudJNZR7xqyR8Kto2MemKMcHEUbOgKySrUK2f+LsZ0phHdo9XiJ5yj3VnMhqMCBj5ORghOyKLx/+2DfCtBq73HQc43X5U4gNzFAXPOwIcmJkRsQD4FAmCP7iXBxYzriJU1i8xti0G/WlDwRAiWH2WgiCrNsIXZIAZld7wvIvk0KbIcBLxmOgt8nSkFaknWU5ajm6rmylv+yMUZP9waqPIRw+ZS2iQeNwZMaPFaQvguL71yOAi74984RZnvacfQxPpojl/l5gzNiItDYkZplQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOYoqUY2tv4OBaLztgIED8TSstpgB/GOw711xeVVlIY=;
 b=fA8LmfJOJdRuMQNZ/6x7TnxCauseT6o0k4RwCGjGeEX0eHu4WznT3qyA8EoUnNBffyL4BbGxQZAdLvVWhJTN18IV1Wf/kYa0mb6F1+RGHcj2jMQZkV+UBkzl4IxBj5FMcg6+oaqi5V+9QdWaN/1I7gOp9bDegabV+AyJBRRWA34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 00:30:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 00:30:28 +0000
Message-ID: <36253a7b-3326-4786-8275-e653573e8aed@amd.com>
Date: Tue, 27 Aug 2024 17:30:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group
 stats
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com, sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-3-mohsin.bashr@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240827205904.1944066-3-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:130::18) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f46503-9a73-4364-31b9-08dcc6f89dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUxWUWJneHJWLzJTVUJUdTZkMTBsRnB5azhnbVNXQ1o4TGZqbGRlTEJWRGJ4?=
 =?utf-8?B?UVZ1bllzR002QTkySldmSGhpZDVoUUNFU0QwS3FUSkNiaE9lUFp3UktGQ09T?=
 =?utf-8?B?OXRiemkxbTNtbmVvTjZyODZ6RVVQT29WeS9tc2dKcTQyR1FjSjRVV2RxS0E4?=
 =?utf-8?B?dkFHS2RTWHJPSHVzUGp4ZkZ4VUI0RnBPb1EvTSs0NUdtVGIybUN1UUxnQWtv?=
 =?utf-8?B?Z1pDS0JUbi9yQms2Y1Y0VUZWMVpwb2QwcEpRQ012TEZkTjhLVGM5QWxUbDkr?=
 =?utf-8?B?L3RjdDlhYjNzRmpPUlptZGJHbC9JY001ZHZkNC81S280UkhoUmZsY1grYzJT?=
 =?utf-8?B?Wk5LVEhDRlU3T2NZU1p5TVlPQUJmZ3ZPdGhTdkRSWXQ4MUhTRjVmTGswVFJR?=
 =?utf-8?B?TU11WDhKWHFMaWZ3WUVqeHZHMmc2YmVPaHc1ZzBBQU50dWxkVTNGNVBiVzlQ?=
 =?utf-8?B?OXFFcHVaK2ltRVNpUzUzRlJqakVNSWNKVnhSdUZKVXdSR2prMytlRS9qM3hH?=
 =?utf-8?B?NXN6TGlsc1paSHRobStsRi90aHltdk9TTSs3SXRPbXA0eERwL21xY2hNN3h3?=
 =?utf-8?B?cG5BaHFPUkVjcWs3cXpjenExc0NKTVJlU05QbHNUWUNNMmZlMkt2Y2syb2RS?=
 =?utf-8?B?eHNZKy9WSFFTckxyOHJjdi9mZ080NG5tRlU5d2tBYUpQZTIzVVNPcWZTMHE1?=
 =?utf-8?B?dlUySE1rQTd0aWtiQStzMWVlMGVpWDNwQ2FKaUQvdWpoUVpobDM3bEJXWFdZ?=
 =?utf-8?B?Ujh6NlJCNmNDRE10a2doZkt1UzJ4NENobTZMendMZTlBNWtVOWRlNy9zMEhJ?=
 =?utf-8?B?aGpZYkF6VE1ncmZQS0t6a3JPdXJuL3M2TXI0eWNiNHFTaVZyZFhwRWFlY1Jk?=
 =?utf-8?B?c2NyaW1qb003V0lIRklHTEhuUkduQWVzS1dWZnVpVTRiTnliK1lQSjZkMmxi?=
 =?utf-8?B?WXJaaWFaejFMRTFYalZxUWRLSHFIbTQzUWVoaHZyZTRyenFHQkxWMC83SjYr?=
 =?utf-8?B?N1Nreit1VU5JMy9YaHNTeVZ5TUdERnQzZHJzaHc5cWViNGQrSjdIdEFaY215?=
 =?utf-8?B?K3ZWcDNTMXJxYVJFalJ5Y2grT2xOSk9UU09jOGNUSEJVRUJXOVkyVXp0TGN5?=
 =?utf-8?B?aGN5QkR4RitlTHVBaDlLOUJpQ0tOZUNKK3c4UzBGMFkyNytEZ3FzZUc5ZVdX?=
 =?utf-8?B?aXc3eHVxMVdmSitiZXZFcFZtS25rYXZFK0ZLcGFIajdDbnYrSitaTlI3NEJK?=
 =?utf-8?B?TDdRbUNaa1pZWmx4SFFDZWJQZms4cVdOdy9PYjhTWGN4dzRxZGxTOUNjWDQw?=
 =?utf-8?B?MGUxcWc1UWt4dWl6OVlqWHVSZmJFQWg1TW14VCtUbnZZaTMyUk9INDBlbUN2?=
 =?utf-8?B?NFo1emtoT2l4K3hZZDB3LzdhY2tKbnhDMmpSV0w2a1ZqT3Q2SUlVd29yM3Ax?=
 =?utf-8?B?bS9Wb2VDRkNES0dIeFppb1RDa0UrSW1pb2R6QStOVmN6L3NNaVh1UHRPbGp4?=
 =?utf-8?B?cXhOcE9WR1owQ1Q0azRvNGRwb1gxQ2NtQUZCdWd4ZWN3V0pDZUVkZkZ0VXls?=
 =?utf-8?B?aU0yT2hjeGtuNnIvK3ZvcHdaQ25qdTFqNHJ6N0lWcGhEU3hQKy9kaTJXcjhr?=
 =?utf-8?B?TDNBRC8yczhwTDM2VGs2RTdHMlI5V25vWkZDcEVPb2dORUpYRTlxRCs0WGtv?=
 =?utf-8?B?SkNPUGI0d0pRRFNERlpIU1kxOENoTWFOdXUrdjRtOWZ1Q0dmVDBIRjZRMVdN?=
 =?utf-8?Q?ZjX21US5JcmLGlm5E8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRGVCtNQXA4NGFtVjEvbnAxZ2hKWFlzRzRRUFpRQVVqYjBEbVdMMEVYRjhS?=
 =?utf-8?B?dE0wTDlBUURwMXdWRSt2TldQeXQ1VFhOUllkTVJvRWJTOVNWdldVM3h5TW93?=
 =?utf-8?B?b01iQ2N3ZDhQdnJJVlpzTVliL3oyRExqNDN5UWVEZXVpdml0UWdGMjlxakVr?=
 =?utf-8?B?RjJta2UyWjN4SFBzZXoxbCtvR20xWkZzRmg4SEY5RE1uTVN3VElSTjJaVnJ5?=
 =?utf-8?B?L05tUGpPMjBYbnhiOTJlV0d5dDBrVTE1aStVTHNtN3ljZFJQaSt5MmxvQ3Zl?=
 =?utf-8?B?bjg4RU05b2ZmMC9QNlNLSXREaGgzOFZ6L2tIMGlrM2Fvd0NUZlcxd2JzaHhF?=
 =?utf-8?B?S0g5ZnQ5YTB2R0lsNVZKeXRmMGZwT3o2Q0JteXRlb01QV2xRcmE0MmpBeW54?=
 =?utf-8?B?TDNtYjRSZHZRNE1VeEhjd3BTY0I4Mk5lTDZ0TnRMclpZNW1EcmhDTmg3YWMr?=
 =?utf-8?B?M3VVRHdscGM4TVN4eUZKYk9YYnN2Qy85M3UveGxqTm4vbkpmYTNveWtxTVVV?=
 =?utf-8?B?VEMzOVBtRWR0UTE4cG5lSG9jcC9sMkpQL2VWSXlHTENzSmtidGVWNDdqT00w?=
 =?utf-8?B?RU1yb0FDa01Rb3hiQXl3a3MydHRPcGpTSHRzakdKdXBMdndNSlRFWG9kc2o3?=
 =?utf-8?B?Q3NSN05qTkpOTUVCVHNwNHQ2ZXFpd3d0V2NLT2wrZStFWGFhMlhPU3c2OThj?=
 =?utf-8?B?RmpDV0hxQXM4L1k2MkVsV0t1aGpld05TYWNhZGduUFA5aVpwWWFOeUtIK1JT?=
 =?utf-8?B?cGpGaFZIVWFzTHZwWUs1VmZZb3hmMC80end0UjNsdi9JTVh2N0lmd1AwVURQ?=
 =?utf-8?B?TS8rWFdTQTdSd29Ed1hiYkJRbzJNKzYwM0lvd0EyUTVNWFJib2V4Y0UycFpM?=
 =?utf-8?B?Q2VDNWJ2L3BMTzhCTWs2ZnRlbnQzaEtXMzJUK09uZlAzQXB3Y1ZsNnkrQmVa?=
 =?utf-8?B?WVlMaFZkZXBVUTZyajNuY3crSkoyTXpLbTY2cU9tRFcxeDVabE0vSEJqRTNS?=
 =?utf-8?B?RStiNFFhZHlxRTBvNmpkWURtNEZPUk12WE90elI4Vm85NjBFN3Bxdzg1Mk1V?=
 =?utf-8?B?cXlDSlBXQzVObGU4UjMzU3dQeW1Kbjd1RnkzbjQrWlFHNDFrMEI1WWxCVUh2?=
 =?utf-8?B?SzhnTXNuak4rWW5FN1NDOUNzWlJFRXN2WGNNSjROZ1ZrejFwbEtBeHJ3Nm0w?=
 =?utf-8?B?M0U0blJzMU5uWDhQKy9RblVQY05lRndkU3lFVDVvOWpKVWs2Q2JNbWJIWk9D?=
 =?utf-8?B?WVQyS2JlK2RMbHZZUHdyV1owakRDZ1FlaWhtaGpidEZTWkkxcjdSb2xVU2tO?=
 =?utf-8?B?VU5scDcyZis1czI2Zkd6bVRJbXIvSGt5OFVoMjZLQWxJYkUzY0tTMXpSaUUv?=
 =?utf-8?B?UUVBNmJiQ0NrZVZGUDI0dDhkR25CQW1jY1dVcFp4Nlo3ZVRWYXN4SzJsdjlR?=
 =?utf-8?B?UmF0OXlCSlhGQmNhK1NlQnFkT1FjelR5M3ZmNWcxN3N4YWx6cEovSDZiMWNa?=
 =?utf-8?B?dm45dFRsSStDcU1PMWw3Sk5CRG5saHFFMTN6SnVSWHJzRVNHbEdGSDkzbVZv?=
 =?utf-8?B?RG9QbDcwT1AzRTQ5enhvK25mcUZUUVEvZXV5cTRqWDBzTmFFcncwQSt3ZlBm?=
 =?utf-8?B?Q0JrRHp2TVp0VmZ4R1lBekdUVzdUUUI1QUZhOGpKbXIzeUhwSDZUdm13ZVRJ?=
 =?utf-8?B?MFNOK2VMWndzY0FLYVEvYW9xQ1I5UUVnd3hwOTFhcXp1MW5xbzRINWhzYTY5?=
 =?utf-8?B?eU1rN1JLS1hvMElrcU5rZkVTa2h0RUlzakRrNHlUY0RaREhSVWhjenhVNjdC?=
 =?utf-8?B?bFFNY1F2OXFTSDdGMUZwMmtYV2Vpam1mK3RKUzVEYzNRZm53UGllTEp3Rkds?=
 =?utf-8?B?bms5NDZ0cWxDYWkvQ3pRL1pHWGMxTTdVc283VXJzZjRhalBIWituV01DNDRY?=
 =?utf-8?B?elZCdXQwTThBbG5DcWp3VVZTQ1VSd016Z2djSE9lbnpNa0YyQzl4R2ZFUmxP?=
 =?utf-8?B?aVE0enhyUjJCWE5VL2RRTjRLcG9iWUQxY0J4WDk1WXY0YkhyaWRrVUdabWJn?=
 =?utf-8?B?TUlLZkVwOUdTcGJYazdjeFd2cjlJRmNMSW1sOG1CcklOdjdKUkJDam4zS1Zh?=
 =?utf-8?Q?hb2WBvxegDB2+yLXfrgM5vKdc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f46503-9a73-4364-31b9-08dcc6f89dbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 00:30:28.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/cFy9/Z0Uvf2Y5QxGvg/Lta/F8Jaz8Q1cYSu22tmJh2Pq9o8raxgL9ELaJqCv2lfQ/uq4mzYUOaINRkj8hbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

On 8/27/2024 1:59 PM, Mohsin Bashir wrote:
> 
> Add support for group stats for mac. The fbnic_set_counter helps prevent
> overriding the default values for counters which are not collected by the device.
> 
> The 'reset' flag in 'get_eth_mac_stats' allows choosing between
> resetting the counter to recent most value or fecthing the aggregate
> values of counters. This is important to cater for cases such as
> device reset.
> 
> The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion using
> high-low-high approach. This allows to isolate cases where counter is
> wrapped between the reads.
> 
> Command: ethtool -S eth0 --groups eth-mac
> Example Output:
> eth-mac-FramesTransmittedOK: 421644
> eth-mac-FramesReceivedOK: 3849708
> eth-mac-FrameCheckSequenceErrors: 0
> eth-mac-AlignmentErrors: 0
> eth-mac-OctetsTransmittedOK: 64799060
> eth-mac-FramesLostDueToIntMACXmitError: 0
> eth-mac-OctetsReceivedOK: 5134513531
> eth-mac-FramesLostDueToIntMACRcvError: 0
> eth-mac-MulticastFramesXmittedOK: 568
> eth-mac-BroadcastFramesXmittedOK: 454
> eth-mac-MulticastFramesReceivedOK: 276106
> eth-mac-BroadcastFramesReceivedOK: 26119
> eth-mac-FrameTooLongErrors: 0
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> v2: Rebase to the latest
> 
> v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com
> ---
>   drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 ++++++++++++++
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 49 ++++++++++++++++++
>   .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 ++++++++++
>   .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 +++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 +++++++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 ++
>   8 files changed, 211 insertions(+)
>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index 37cfc34a5118..ed4533a73c57 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FBNIC) += fbnic.o
>   fbnic-y := fbnic_devlink.o \
>             fbnic_ethtool.o \
>             fbnic_fw.o \
> +          fbnic_hw_stats.o \
>             fbnic_irq.o \
>             fbnic_mac.o \
>             fbnic_netdev.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 28d970f81bfc..0f9e8d79461c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -11,6 +11,7 @@
> 
>   #include "fbnic_csr.h"
>   #include "fbnic_fw.h"
> +#include "fbnic_hw_stats.h"
>   #include "fbnic_mac.h"
>   #include "fbnic_rpc.h"
> 
> @@ -47,6 +48,9 @@ struct fbnic_dev {
> 
>          /* Number of TCQs/RCQs available on hardware */
>          u16 max_num_queues;
> +
> +       /* Local copy of hardware statistics */
> +       struct fbnic_hw_stats hw_stats;
>   };
> 
>   /* Reserve entry 0 in the MSI-X "others" array until we have filled all
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index a64360de0552..21db509acbc1 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -660,6 +660,43 @@ enum {
>   #define FBNIC_SIG_PCS_INTR_MASK                0x11816         /* 0x46058 */
>   #define FBNIC_CSR_END_SIG              0x1184e /* CSR section delimiter */
> 
> +#define FBNIC_CSR_START_MAC_STAT       0x11a00
> +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_L 0x11a08         /* 0x46820 */
> +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_H 0x11a09         /* 0x46824 */
> +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L \
> +                                       0x11a0a         /* 0x46828 */
> +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H \
> +                                       0x11a0b         /* 0x4682c */
> +#define FBNIC_MAC_STAT_RX_TOOLONG_L    0x11a0e         /* 0x46838 */
> +#define FBNIC_MAC_STAT_RX_TOOLONG_H    0x11a0f         /* 0x4683c */
> +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L        \
> +                                       0x11a12         /* 0x46848 */
> +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H        \
> +                                       0x11a13         /* 0x4684c */
> +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_L \
> +                                       0x11a14         /* 0x46850 */
> +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_H \
> +                                       0x11a15         /* 0x46854 */
> +#define FBNIC_MAC_STAT_RX_IFINERRORS_L 0x11a18         /* 0x46860 */
> +#define FBNIC_MAC_STAT_RX_IFINERRORS_H 0x11a19         /* 0x46864 */
> +#define FBNIC_MAC_STAT_RX_MULTICAST_L  0x11a1c         /* 0x46870 */
> +#define FBNIC_MAC_STAT_RX_MULTICAST_H  0x11a1d         /* 0x46874 */
> +#define FBNIC_MAC_STAT_RX_BROADCAST_L  0x11a1e         /* 0x46878 */
> +#define FBNIC_MAC_STAT_RX_BROADCAST_H  0x11a1f         /* 0x4687c */
> +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_L 0x11a3e         /* 0x468f8 */
> +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_H 0x11a3f         /* 0x468fc */
> +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_L \
> +                                       0x11a42         /* 0x46908 */
> +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_H \
> +                                       0x11a43         /* 0x4690c */
> +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L \
> +                                       0x11a46         /* 0x46918 */
> +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H \
> +                                       0x11a47         /* 0x4691c */
> +#define FBNIC_MAC_STAT_TX_MULTICAST_L  0x11a4a         /* 0x46928 */
> +#define FBNIC_MAC_STAT_TX_MULTICAST_H  0x11a4b         /* 0x4692c */
> +#define FBNIC_MAC_STAT_TX_BROADCAST_L  0x11a4c         /* 0x46930 */
> +#define FBNIC_MAC_STAT_TX_BROADCAST_H  0x11a4d         /* 0x46934 */

These might be more readable if you add another tab between the name and 
the value, then you wouldn't need to do line wraps.


>   /* PUL User Registers */
>   #define FBNIC_CSR_START_PUL_USER       0x31000 /* CSR section delimiter */
>   #define FBNIC_PUL_OB_TLP_HDR_AW_CFG    0x3103d         /* 0xc40f4 */
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 7064dfc9f5b0..5d980e178941 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -16,8 +16,57 @@ fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
>                                      sizeof(drvinfo->fw_version));
>   }
> 
> +static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
> +{
> +       if (counter->reported)
> +               *stat = counter->value;
> +}
> +
> +static void
> +fbnic_get_eth_mac_stats(struct net_device *netdev,
> +                       struct ethtool_eth_mac_stats *eth_mac_stats)
> +{
> +       struct fbnic_net *fbn = netdev_priv(netdev);
> +       struct fbnic_mac_stats *mac_stats;
> +       struct fbnic_dev *fbd = fbn->fbd;
> +       const struct fbnic_mac *mac;
> +
> +       mac_stats = &fbd->hw_stats.mac;
> +       mac = fbd->mac;
> +
> +       mac->get_eth_mac_stats(fbd, false, &mac_stats->eth_mac);
> +
> +       fbnic_set_counter(&eth_mac_stats->FramesTransmittedOK,
> +                         &mac_stats->eth_mac.FramesTransmittedOK);
> +       fbnic_set_counter(&eth_mac_stats->FramesReceivedOK,
> +                         &mac_stats->eth_mac.FramesReceivedOK);
> +       fbnic_set_counter(&eth_mac_stats->FrameCheckSequenceErrors,
> +                         &mac_stats->eth_mac.FrameCheckSequenceErrors);
> +       fbnic_set_counter(&eth_mac_stats->AlignmentErrors,
> +                         &mac_stats->eth_mac.AlignmentErrors);
> +       fbnic_set_counter(&eth_mac_stats->OctetsTransmittedOK,
> +                         &mac_stats->eth_mac.OctetsTransmittedOK);
> +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACXmitError,
> +                         &mac_stats->eth_mac.FramesLostDueToIntMACXmitError);
> +       fbnic_set_counter(&eth_mac_stats->OctetsReceivedOK,
> +                         &mac_stats->eth_mac.OctetsReceivedOK);
> +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACRcvError,
> +                         &mac_stats->eth_mac.FramesLostDueToIntMACRcvError);
> +       fbnic_set_counter(&eth_mac_stats->MulticastFramesXmittedOK,
> +                         &mac_stats->eth_mac.MulticastFramesXmittedOK);
> +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesXmittedOK,
> +                         &mac_stats->eth_mac.BroadcastFramesXmittedOK);
> +       fbnic_set_counter(&eth_mac_stats->MulticastFramesReceivedOK,
> +                         &mac_stats->eth_mac.MulticastFramesReceivedOK);
> +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesReceivedOK,
> +                         &mac_stats->eth_mac.BroadcastFramesReceivedOK);
> +       fbnic_set_counter(&eth_mac_stats->FrameTooLongErrors,
> +                         &mac_stats->eth_mac.FrameTooLongErrors);
> +}
> +
>   static const struct ethtool_ops fbnic_ethtool_ops = {
>          .get_drvinfo            = fbnic_get_drvinfo,
> +       .get_eth_mac_stats      = fbnic_get_eth_mac_stats,
>   };
> 
>   void fbnic_set_ethtool_ops(struct net_device *dev)
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> new file mode 100644
> index 000000000000..a0acc7606aa1
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> @@ -0,0 +1,27 @@
> +#include "fbnic.h"
> +
> +u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
> +{
> +       u32 prev_upper, upper, lower, diff;
> +
> +       prev_upper = rd32(fbd, reg + offset);
> +       lower = rd32(fbd, reg);
> +       upper = rd32(fbd, reg + offset);
> +
> +       diff = upper - prev_upper;
> +       if (!diff)
> +               return ((u64)upper << 32) | lower;

Is there any particular reason you didn't use u64_stats_fetch_begin() 
and u64_stats_fetch_retry() around these to protect the reads?

sln

> +
> +       if (diff > 1)
> +               dev_warn_once(fbd->dev,
> +                             "Stats inconsistent, upper 32b of %#010x updating too quickly\n",
> +                             reg * 4);
> +
> +       /* Return only the upper bits as we cannot guarantee
> +        * the accuracy of the lower bits. We will add them in
> +        * when the counter slows down enough that we can get
> +        * a snapshot with both upper values being the same
> +        * between reads.
> +        */
> +       return ((u64)upper << 32);
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> new file mode 100644
> index 000000000000..30348904b510
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> @@ -0,0 +1,40 @@
> +#include <linux/ethtool.h>
> +
> +#include "fbnic_csr.h"
> +
> +struct fbnic_stat_counter {
> +       u64 value;
> +       union {
> +               u32 old_reg_value_32;
> +               u64 old_reg_value_64;
> +       } u;
> +       bool reported;
> +};
> +
> +struct fbnic_eth_mac_stats {
> +       struct fbnic_stat_counter FramesTransmittedOK;
> +       struct fbnic_stat_counter FramesReceivedOK;
> +       struct fbnic_stat_counter FrameCheckSequenceErrors;
> +       struct fbnic_stat_counter AlignmentErrors;
> +       struct fbnic_stat_counter OctetsTransmittedOK;
> +       struct fbnic_stat_counter FramesLostDueToIntMACXmitError;
> +       struct fbnic_stat_counter OctetsReceivedOK;
> +       struct fbnic_stat_counter FramesLostDueToIntMACRcvError;
> +       struct fbnic_stat_counter MulticastFramesXmittedOK;
> +       struct fbnic_stat_counter BroadcastFramesXmittedOK;
> +       struct fbnic_stat_counter MulticastFramesReceivedOK;
> +       struct fbnic_stat_counter BroadcastFramesReceivedOK;
> +       struct fbnic_stat_counter FrameTooLongErrors;
> +};
> +
> +struct fbnic_mac_stats {
> +       struct fbnic_eth_mac_stats eth_mac;
> +};
> +
> +struct fbnic_hw_stats {
> +       struct fbnic_mac_stats mac;
> +};
> +
> +u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
> +
> +void fbnic_get_hw_stats(struct fbnic_dev *fbd);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> index 7920e7af82d9..7b654d0a6dac 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> @@ -403,6 +403,21 @@ static void fbnic_mac_init_regs(struct fbnic_dev *fbd)
>          fbnic_mac_init_txb(fbd);
>   }
> 
> +static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
> +                                 struct fbnic_stat_counter *stat)
> +{
> +       u64 new_reg_value;
> +
> +       new_reg_value = fbnic_stat_rd64(fbd, reg, 1);
> +       if (!reset)
> +               stat->value += new_reg_value - stat->u.old_reg_value_64;
> +       stat->u.old_reg_value_64 = new_reg_value;
> +       stat->reported = true;
> +}
> +
> +#define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
> +       __fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
> +
>   static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
>   {
>          u32 rxb_pause_ctrl;
> @@ -637,12 +652,47 @@ static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
>          wr32(fbd, FBNIC_MAC_COMMAND_CONFIG, cmd_cfg);
>   }
> 
> +static void
> +fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
> +                           struct fbnic_eth_mac_stats *mac_stats)
> +{
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->OctetsReceivedOK,
> +                           MAC_STAT_RX_BYTE_COUNT);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->AlignmentErrors,
> +                           MAC_STAT_RX_ALIGN_ERROR);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->FrameTooLongErrors,
> +                           MAC_STAT_RX_TOOLONG);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->FramesReceivedOK,
> +                           MAC_STAT_RX_RECEIVED_OK);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->FrameCheckSequenceErrors,
> +                           MAC_STAT_RX_PACKET_BAD_FCS);
> +       fbnic_mac_stat_rd64(fbd, reset,
> +                           mac_stats->FramesLostDueToIntMACRcvError,
> +                           MAC_STAT_RX_IFINERRORS);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->MulticastFramesReceivedOK,
> +                           MAC_STAT_RX_MULTICAST);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->BroadcastFramesReceivedOK,
> +                           MAC_STAT_RX_BROADCAST);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->OctetsTransmittedOK,
> +                           MAC_STAT_TX_BYTE_COUNT);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->FramesTransmittedOK,
> +                           MAC_STAT_TX_TRANSMITTED_OK);
> +       fbnic_mac_stat_rd64(fbd, reset,
> +                           mac_stats->FramesLostDueToIntMACXmitError,
> +                           MAC_STAT_TX_IFOUTERRORS);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->MulticastFramesXmittedOK,
> +                           MAC_STAT_TX_MULTICAST);
> +       fbnic_mac_stat_rd64(fbd, reset, mac_stats->BroadcastFramesXmittedOK,
> +                           MAC_STAT_TX_BROADCAST);
> +}
> +
>   static const struct fbnic_mac fbnic_mac_asic = {
>          .init_regs = fbnic_mac_init_regs,
>          .pcs_enable = fbnic_pcs_enable_asic,
>          .pcs_disable = fbnic_pcs_disable_asic,
>          .pcs_get_link = fbnic_pcs_get_link_asic,
>          .pcs_get_link_event = fbnic_pcs_get_link_event_asic,
> +       .get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
>          .link_down = fbnic_mac_link_down_asic,
>          .link_up = fbnic_mac_link_up_asic,
>   };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> index f53be6e6aef9..476239a9d381 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> @@ -78,6 +78,9 @@ struct fbnic_mac {
>          bool (*pcs_get_link)(struct fbnic_dev *fbd);
>          int (*pcs_get_link_event)(struct fbnic_dev *fbd);
> 
> +       void (*get_eth_mac_stats)(struct fbnic_dev *fbd, bool reset,
> +                                 struct fbnic_eth_mac_stats *mac_stats);
> +
>          void (*link_down)(struct fbnic_dev *fbd);
>          void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
>   };
> --
> 2.43.5
> 
> 

