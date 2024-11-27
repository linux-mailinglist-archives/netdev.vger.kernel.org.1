Return-Path: <netdev+bounces-147591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F849DA6E3
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CA9165A09
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74361F8AE7;
	Wed, 27 Nov 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qe3QroqX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502A198842;
	Wed, 27 Nov 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707266; cv=fail; b=pyhf6VUMx0eYKJAgGc9KsKLHcmq1rPV4qYUzhCoE+AKdYuTIXIXwFlt+Nsrv6G2GVqk6aAuUbpN9dkcBkga/93L2ThB7uWbr/b0On/2o8Me7AfmrgyKT0QyP8lqvyRVJVkqQdkhHegUVcAgAFGgOmf/Xy0BoF4XP1WhzEaUqvJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707266; c=relaxed/simple;
	bh=xn+BQ6A+wG8bxV2po+EytGxSwMpmuJnVposbc03Wnd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tEpu3exKj1Whc8UrkWsXMz5/EvRV2vdvoT13Iyjobi2C7R2KY70R/qI2Rgy6OrV/U5t9hOrIWGKMu4U/cXOMglBDLep5j5Iw1JzyS/gruigiqsV+pvl7mkNxQzvCsePhr/hSQdJxdfCQOrwN/IW4j0U91gLkuSgFXuIYI7e0a0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qe3QroqX; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8t+EzW8J+jC4Wnrw1ZCQwHldeQHEXSeErj8RYaApIZrSACpE3wBysQ6z4NNkyPdONmOYjDxGGqUI/vNH0fOHACFkpf9cyidfkl1KXrzQsXHN/yLm/JxtF6oupoS+06aYGc9aokbya78i0bYjilPtN0x5nYWukz8ZtWi3ovHnRkwfjcSq5cDbLXdhvVlLOpk1Em4xH0yL5Hu1vZuSXtnE3IlYsSgQv98q3fvJ+yFGtXXCZBnZ0Ol4E2FEz8H47yXuBugTnbYYJuPmM23W7zBXTHQprJlKWxDt+Sg1/ZA2uwmbdbX4nvjsbD4xOFW85eptup89/KvvnLXTSR4xfBI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va0Eaf1ip2piIGUVwFph0XGmUxVFD+mfBZx1Ts7EF+U=;
 b=Rc5SZDE4F1ru/tpK8OHFqab/JSrU6rH6FYIhEX0gsXcedDTAxHVaAdWzKYsCKECheZRDXC8a7zC/itmOxZOec0X/2NsIXILj01w/6VlvezJQW9gWOZI+OTDXOWK5ccJMKRvRIHIibCMATT/oP71Cl4NpgNBGJic22GlNGlVl/4ijacHNLnCYTVgLIhfztFSLEuDckRXpp1Jxm0HsEbe4HqWsWX/HyN7aTz1Y/dpiaM4tbunDp6v2egUfxEq7LRvwRQJZd9ih5NOGivEdtKvGxcH4hxNOe0LxqIIssKolSGsGfhBKs3CzCALf/gCBa1/qusqzygP7riqfrF+FCRiPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va0Eaf1ip2piIGUVwFph0XGmUxVFD+mfBZx1Ts7EF+U=;
 b=qe3QroqXJ1YK4kDTsLZKAlDfrm3Ur3qYtfHApywXmAkSAtuP9PF6Q3z6ie8tmdaQ4HlOO7r+BfGtkonWBwM1QBkJEngZRrojrlRjsFbGR2pTbcJncNaTj3nji/h9VeRQszoV69fabtM0w8r2FSpMRZlVRd530qp8WCp2YX6kSvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:34:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 11:34:22 +0000
Message-ID: <0def4bd1-297e-9cf1-ebd9-0bb92d40cc92@amd.com>
Date: Wed, 27 Nov 2024 11:34:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/27] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-5-alejandro.lucero-palau@amd.com>
 <84e3cd1b-019d-411a-9acd-f03aac1f1aa5@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <84e3cd1b-019d-411a-9acd-f03aac1f1aa5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: ce26748e-b4a2-4084-deeb-08dd0ed7701b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnZucEtWVFFlZkUyODhQdHlzNXJvaG1sdStNTk1VMS93SndrS283TGY1cVRQ?=
 =?utf-8?B?MWpUUGcrejVjZk9Vcm9JRi8zYW9Pd3A3RTUyRFNkdHVYVk9lYzlOcDMxV29Z?=
 =?utf-8?B?c2RCcEV2dGRXSlNZR3NFZmFzWmsvMGE3TXc5NHh1V3k2bURSZUkwM0wxSlRY?=
 =?utf-8?B?UXV4Y3pqNktsRHBCMXgvSk16NEszNlYyZ2JBdElJOEkwQTQ1bjk5TjZXa1hi?=
 =?utf-8?B?L09acVJDcXJWbGxvQlZ4eEVMVzNMRnU5bmxuM0Y3VVdmMXlrVGNCeHFPcytq?=
 =?utf-8?B?YzYzT1VvTGYrbXdzb0pLSk9lVEs0MFNkemNBQkJQNDdYT1dzQk9BMjA3TTdL?=
 =?utf-8?B?WmtkRjBWYVpzZ0oxMk5RRnB3TSsveVJFSVBoejZ3U3ZVdkhpWjFKYnpEamx0?=
 =?utf-8?B?UjVxL3UvYVZqbEtsWVdTS0ZLY01OWkM0Slo0OGNYbk0yY05Td3ZYdUVxT0tR?=
 =?utf-8?B?OWIzVldQcSt3cHdsdlZBVzNKb0xiMG0rb0VuVkcrbXN0TWgzV25JSjlXYUEx?=
 =?utf-8?B?UmFuUXRhbjNrTkVrSUlYSW9yaGIwR0h1UzVOSTVPOS9kNmNueE5EY1UyVWNl?=
 =?utf-8?B?dDV1QmxIazVWSUhRTnU4QmVMQlVHNjVJRStBMGxxQ2hVV3FRMkZNeUVtVnNz?=
 =?utf-8?B?QThSalY0RzNWRFFaWlBwalRudTg5bkZ1ZUVaZlpUMUdvNE1KV29sazJmWjN1?=
 =?utf-8?B?VG8raFppS1ZFTWFEaDdMVE0wekpkMWJhUjJtK0NENC8zSWpjQXh5aHE0NjlN?=
 =?utf-8?B?SGcwU3Qva3hsTHNSbHdzbUFsNEoydXlqZmZqNGE3ZEY2SGRNOVBXclNtZUdt?=
 =?utf-8?B?S05WNXFqZWU1dEN4T083OEpmUzR0eXg2blFNQ2RxdHFLUDVRMjNKVkRySGpE?=
 =?utf-8?B?Szd2MFBSMmZCTkVNN0NaSVZZYzJKZ1p5Ui9Ncit6Uk5SMDh4STA0LzExQk1n?=
 =?utf-8?B?bHZHVWNBb2hwNWRJUDZjekthTTgvL2pRcG9hQTlrUTN6QTFBM29uL05WYzd4?=
 =?utf-8?B?TnVGSjNPb1ZGVk42ZFpyL2V2TU1vQ3pBUzBGb3JVMTV2L29NeFpoWDRIamU0?=
 =?utf-8?B?ajl3RDJ4NUFOd1lHMkhFb05MbENGTmhFbDk5VFE0L3ovMzFKa0dDVmhkK3Iz?=
 =?utf-8?B?enlXVTZ5WndEZjQ0RmtKNTkxVFNaQTRZNDUxQkRtZ2FaRGlqdVZIMHg3bFJZ?=
 =?utf-8?B?RlQ4SG1QMmNueUtZUDNtazI5VmNZRk8vWEJCbmF5UGpJNGsvWjJGQTd5MHdJ?=
 =?utf-8?B?VEtZZVh1YzdRU1ZQUlhPYXlsWkk3dDJhWmV3c1lVcUxiWWNYbWMvWStFTTBL?=
 =?utf-8?B?K3RZUlNUanhSMFBUZ0FTUHJzSFIvbFhtcmlkYlFxSjZkTGdrWEpLOTlwQWcr?=
 =?utf-8?B?UmFCYjZJb0lQbFZQZVBya05OQ282dDc2bDVjNXNSUm1uNklLR0RKZUZYV1Vh?=
 =?utf-8?B?dlFWT2JORFVUUlhhaTZQYWZlTWJ4M2xwRk5NSGd3M0NJT0szY3BEU09XWkpU?=
 =?utf-8?B?Q1JkV2xMSkUyaHJkeFRmcyttdzNWSGtlTGJ2Y3VaanJvb1AzbGY0K0NRL0ti?=
 =?utf-8?B?Tm1NalpxMUJnc1FWb0RwUkJjY2xBbGQ1Q1R1QlFGeXhVSWh4RG8wdFpuWUQr?=
 =?utf-8?B?YkQyS20vNzQzbFN3RFY2c2hrUSsvWk5MN0hQWnVXRlhFNWdxV2dQMS80d0hu?=
 =?utf-8?B?citTcjdPMXZqZlNhWGQ3QkhFaE5XeFo2cVJXNU5yTUJCY2dpUUtxM3lsRDIr?=
 =?utf-8?B?L3E5dnExYk9lWG5lQWJOR25CT1J0cWlraDhGOEh3ZHJBb3MzeEVhN3BIVFVj?=
 =?utf-8?B?SW5qaUxlaTZzaytmNlpCQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBNRzg2ckNSNDNGUWRkcmdzcXZZbjErMXhJdUxhek5JUkRpUStxL2pHc0Rn?=
 =?utf-8?B?aThpWUZOU0lTa3YvUnJaTFFQTFN4Y1FENGRCNCtDRlVPZHhzbldKaU9CV0l6?=
 =?utf-8?B?MENxeGNqVzF3NXZGVUNNcVBzcEJGSDBMSytZNEppWUtVblIyZnorcGcwTFFM?=
 =?utf-8?B?aW1nTEthSDd3QTRGOHIxWnQ1N3JNbTFaU3hSZE9xZUpNWXpveHJYUnJxY1VJ?=
 =?utf-8?B?V1lBTkU2Tlh2eU1uYUFvLzZtd3BiUldoVGRRWmVIT0pyVllJTmhXR2pLMzhZ?=
 =?utf-8?B?N3hOa1FTcUc2SE9ORFJ2TEZRN25BR0RZZkFYOTNJcG5hN0FoOE5hRTROZ3NB?=
 =?utf-8?B?Q2pNM0FwMWtwdDlDbWc3ZHNtZUZhRjNyOGFSamJlWEpJS1hHMDJTOWtzYzI4?=
 =?utf-8?B?djI1TEZuRFc3c2tLWVJwS0tmUUw1ZjZiK1RuMVFYWEpaWFZveEhkakkxTE5q?=
 =?utf-8?B?aHg1OEMyL21EV1BnUTk2c0RnSTZ5R2pSNjR3OUJycU50UmtNOHc3VHQ4RnIy?=
 =?utf-8?B?UHR3MGRZZXppNzVmMWFmSFlGYkFGTUhyMnR1L2o0SHk4L2ozRC9Xa0U3L05D?=
 =?utf-8?B?ckVQdmlMRW1FV1N2b1hKMTFjcGQvQmZ1eFBocjBLTzh1QnAwU0NsV2MxMUc2?=
 =?utf-8?B?NER5ZVJiT2FNNlU0NERCbVFKNGhRQWlGcnlyUmZaMGNOakI1TUFYU2ZEMFNL?=
 =?utf-8?B?VTFyMnBHTFIvZ3BUMXNPRVZLaVpIdjUwbC9oeWZIWm9BYVVtcTBodHRDR2JZ?=
 =?utf-8?B?cmh3QVVvMDdqTGE2TzZ3eHJOVkZiWlVTTzlPMWFaVk9RMmhES2dHUnE0dms3?=
 =?utf-8?B?Wk9PbHAvRzYyUmdEWUc5ZSthalN1VWN2TEtjelVKM0JxMHBaSWpqazB6V0Z2?=
 =?utf-8?B?K2pNcktqT0FEbWRibno2TEhUSnRWTnAzdXpGaVN5Y3RpNDBUeWN4bnhJNnMy?=
 =?utf-8?B?bkJTcjV1b09PYkxTdnZ0MlZ2RkorTzlIOEpkQUxhYWMyVHhJQTJXaEc1WFpO?=
 =?utf-8?B?cXJITVMzbTIzd0cyV1hYL3FHc2EvbkhMakZheVBTZWw2bnZxU2Via3pIanVB?=
 =?utf-8?B?b0dPVis1ejR5M0M1cHJpb3pneG5pcElhZDVKeHhDVllRU1AwcjBmY2s5RnVY?=
 =?utf-8?B?Z0p1R3N2SEdYcGpsQWQ2M2FaVzFCZzY4VktTWUZaRk15cytEM2dvb2lxMHYr?=
 =?utf-8?B?dnZ5TS9FbEp4TVRKMXZzWm13M1ZqUnZCTWU1VlVROU12akxDS3k5c0hITkJI?=
 =?utf-8?B?MWZsWTFac2JMeHArSlQ4V0ZabnJnNU1KS3U5MExVdGdBNmZldDZ4MEtzMzU1?=
 =?utf-8?B?T2RacHV0L1BiY3piS21yb0FKaFV5T3hnakN6OTJTQ1BUUmNZMHFaS0paR2lM?=
 =?utf-8?B?NWhTWlFaYXVOcVpBZ25hR2JkRHhVdUhBNG9WcnFEUGRLS09PRkVCZEJIMzlw?=
 =?utf-8?B?OGt4dm1KYi90bjdRL25neXRHd3BBN1NKYzVRZitNV1RySjBOL1h5YVNwdHZm?=
 =?utf-8?B?SkNMbkorQVBSbVY3Snc4dTEwOUVkRUVrejR0QjVYaVFtblRNQjFocWpMZXc3?=
 =?utf-8?B?QlJtVXhpaWdlUXRkckRzVXBGYTJaVGd0Y1pnaHFqVlhPbjF0NjBIblVvc20y?=
 =?utf-8?B?VVhxV0xleWE2Y093YUFDNkp5T3ZCMGV2d00zVDZkSElFT3dMekpLQUkrb0JO?=
 =?utf-8?B?THFSdEV1OFlrWURrWDA5cHRHRjRPNlhWU3E4ZWszcFRLT0RUckt3Rys3UXc5?=
 =?utf-8?B?SjBsOTkrTWVUdmJ0OEtuOU5YTmFDdUp3T0tZSU11eTlZQ2dBY0hyMk1nTDVB?=
 =?utf-8?B?ZGNWT09IdFdrVFhQMFRGOTlyNDVIM01uS2hTcjk0dWd5cUliWUxGenhrZmtq?=
 =?utf-8?B?T2QxcjlOS01sL0EzaDNENytRODBRekRDRm5hQ3EvU0ZvR3lmTjFneVNjbXBn?=
 =?utf-8?B?RHBza1RPZUFkVFJSaXNCNEFvelRoQVZDMzhqdGFkT1paVFNONVpoZU03UlJZ?=
 =?utf-8?B?THBRNCtnbVNsYzFaUjF0WWptcmF0bUFzd2MrcmxOM0VaUUVrM0hxeko3YStE?=
 =?utf-8?B?VkxzUlgzRW5jVERkakxSSTNGdEw4alZtbWM3VGxYbzIrSVdtSmFHYitGWkdH?=
 =?utf-8?Q?XRvlq/6tWkddz2p5KVBA2saYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26748e-b4a2-4084-deeb-08dd0ed7701b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:34:22.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3BHgFx00oDSOpgGf+VHoqEbnFhEw3WUb7nBSJOjNgkgUhOrNBnUJdzcBkguw1NX5E2KJme6E1yrhzqhl6iT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899


On 11/22/24 20:44, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization. Allow those mandatory/expected capabilities to
>> be a subset of the capabilities found.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 22 ++++++++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>>   include/cxl/cxl.h       |  6 +++++-
>>   4 files changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index ff266e91ea71..a1942b7be0bc 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -1055,3 +1056,24 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   
>>   	return 0;
>>   }
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>> +			unsigned long *current_caps, bool is_subset)
>> +{
>> +	DECLARE_BITMAP(subset, CXL_MAX_CAPS);
>> +
>> +	if (current_caps)
>> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
>> +		*cxlds->capabilities, *expected_caps);
>> +
>> +	/* Checking a minimum of mandatory capabilities? */
>> +	if (is_subset) {
>> +		bitmap_and(subset, cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
>> +		return bitmap_equal(subset, expected_caps, CXL_MAX_CAPS);
>
> It looks like there's a function called bitmap_subset(), does that not do the above? I didn't
> look at the function since it's the end of the day when I'm writing this and my brain is tired,
> but I'd rather that be used if possible. I also don't think you need this is_subset parameter and
> else branch. I don't see anyone using this function where some expected capabilities are optional
> and others mandatory. If that's the case then they'd probably split the calls instead.


That is a funny one. I did not realize such bitmap_subset did exist!

I've just tried it and it works as expected. It is going to make the 
code simpler!

Thanks!


>> +	} else {
>> +		return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 8287ec45b018..3b3965706414 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>>   		dev_dbg(host, "Probing device registers...\n");
>>   		break;
>>   	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 528d4ca79fd1..5de1473a79da 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -813,6 +813,8 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_register_map map;
>> @@ -874,6 +876,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +
>> +	/*
>> +	 * These are the mandatory capabilities for a Type3 device.
>> +	 * Only checking capabilities used by current Linux drivers.
>> +	 */
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (!cxl_pci_check_caps(cxlds, expected, found, true)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
>> +			*expected, *found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index dcc9ec8a0aec..ab243ab8024f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -39,7 +39,7 @@ enum cxl_dev_cap {
>>   	CXL_DEV_CAP_DEV_STATUS,
>>   	CXL_DEV_CAP_MAILBOX_PRIMARY,
>>   	CXL_DEV_CAP_MEMDEV,
>> -	CXL_MAX_CAPS = 32
>> +	CXL_MAX_CAPS = 64
>>   };
>>   
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> @@ -48,4 +48,8 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>> +			unsigned long *expected_caps,
>> +			unsigned long *current_caps,
>> +			bool is_subset);
>>   #endif

