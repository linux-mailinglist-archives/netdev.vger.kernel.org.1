Return-Path: <netdev+bounces-137010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC79A402E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205A41F29858
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F631DF24F;
	Fri, 18 Oct 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aBcAK6pP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E91D54D6;
	Fri, 18 Oct 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258765; cv=fail; b=DyllaLKLER/tuNcgdbdYRtCwVWvwrDbGADLYp8qgldNXmFOQdVG8Z6OVCDIGdgKNPgdu1v9SuYRTilvVa6BYk28VHupmosSLHDcnbZPMFYCCIMXIqDE85qmY+pBPRNo9/lVeVmJNdxR5dwmc9tAXb1qZDGbFs+SUMmuwSNCU/cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258765; c=relaxed/simple;
	bh=Iug8NU9P2nBG0kxTPHZSqI8My+u13fUDfFH0OhpqYDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7zLGwkslViitJTl5W51utd+Tya0VawOTk5ecI3uZMlj81sTkdoVQ8756Yrittxlzs2O8c16sM2SxHBqDVuXdArsHN69/MCOAaskZ7+Vp+s2nfxZEudUmc854vxjmBTqsIA78AT1NT8XNyP8zy1hEj/o1WMLfYMINOO51aO2l2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aBcAK6pP; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e87Fw62ccHrQAZj7jlc6X3xeLOl82zAu3sdAc+EZtb+7EKwDCXxuG9169k4ee+/XvrC/VoWnV43XEDHYCF8BdRUVYZkK9yQuhzwhsJrSuZ6kVYwXblGBMa2agpNyklnG7519vbPCgRbvjt48QiqG9KBTFb84vjbG9Q4fo5CPjO34AFgJld+z6ssRTGWeE6pw9NRC+bWSViFnxwSSH1XXSHu9QHS89voLEraS9KwqvoVCBf8SXBHbkHqbLbgizV2u/5IRaVDS2Vej4E/mlYb7N38XsBKo6jD72Kxhihok89yBog+MiJDXrP7iX2gK5Lpr0PdE8OGwKmrm5T6wT5eLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIgzKQxJlsQCDj5pPbXz8Njy+/p6HkR3BjErPvfCHv0=;
 b=JF1F/5OjWWA36n2ZD3do6yn+Go/bzdSjTCb5OhqmkT7wdLXQvlVfu2MCRlRcPCGmMf+K6KL/+5uvJHolYWUpNfy1rK6BPxqpLRNPy0Y3VXabye4EFZnfqMr1nmsf02ucOKPcGRlUgDj+4d9KLbSGq+qpTYCCxhkmI87fl3IRSLRK+XKWsNN93WyRMZEvG6kispi4BN56NnMmDwULsuU82vFOZW0VM7YU0YRinYwBRkAMGkhlsigzE6c6hfU6jlWHuKQ2ec1KHk7lbo2pyqb7nQ85tFDKAFblyzPCRFbqYD1LQvykrH1eLQ9CUO6P7Q7sM0+NOKjTlIqL/lfBZG/Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIgzKQxJlsQCDj5pPbXz8Njy+/p6HkR3BjErPvfCHv0=;
 b=aBcAK6pPSP90M/T3QjmvjMER1FPrMSweKi+aI6KR5cJYGJFFZCfbJZggb9Is/Khp1oPo/JpgBO56tWwL5wWsWy+xWan4Z5MvjIs8hgC2MqQxNtc+wfXIxO7TIrIdVo/GP+iZtRjU4fmS57lXD1aJEcOriyxuA7vT4ayk7G5pZ0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 13:39:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 13:39:20 +0000
Message-ID: <4f00ff19-c87f-8dc2-b100-8a75c3f7f8c4@amd.com>
Date: Fri, 18 Oct 2024 14:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/26] sfc: add cxl support using new CXL API
Content-Language: en-US
To: benjamin.cheatham@amd.com, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-3-alejandro.lucero-palau@amd.com>
 <01ef15ab-dc8a-4796-8fc5-90c2d4107435@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <01ef15ab-dc8a-4796-8fc5-90c2d4107435@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: eec74ccc-5b38-4e56-0a3c-08dcef7a4425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHQwMy94OWYwdk1PNDdQd1Q5QTRnTFRpSHgxbU5pajF6c1ZSeTNVSTI0ek9C?=
 =?utf-8?B?ZjA3ZDQ4UnJQSTZrRTZFU29uNlB2UkhsVVU4NzlFMGIyK2UwZ2lWN1lhVytl?=
 =?utf-8?B?Tkc2VVl6b3ozNTFMdWRGclVNMkFkdmZqYVdmbmRLSm1LeHgwSnFXRTRhaTRu?=
 =?utf-8?B?OUZNRHhnQXBwRmJsNGZZaUJLT1JJTVhXUTF0Y3JUWXJUcVNtMElsN3Qxa3hl?=
 =?utf-8?B?T2o4MVNVSU5hUGNRbERPQ0hSYjZPTG81bW1EVXNVZmk4YnlNMmFQSjhySEdB?=
 =?utf-8?B?S1dMOHR3M053aGlxYW1ROVArRFhsZXluZnhTS0k5NUVuY01PSnJoYTc1OHo1?=
 =?utf-8?B?WnEvWVdoa045S3QxcGpxUjdMc1Y5YU5SVytjb0tkcFZma3d2d0R3dmorY1hl?=
 =?utf-8?B?aXJsZjBLVmpJR05nU1pHaFc3ODZ0aDV4czRveS9wTkJrRzRPbWNlYzMyb2h3?=
 =?utf-8?B?b3llWUV6MC9CSnFpY0J6QWR0RHdET3VDZ2swSEx6N3dRdG1XSHVZSG45cXkx?=
 =?utf-8?B?WDZ1b3V0L04zK3pLeXRFVXM1dm5zaGpYSkc4WEkrYlVUM3VOZ2tZcnBUU1BV?=
 =?utf-8?B?b2NUQUJYZHhIT0ljVWtGWjR3elJtYmJ2V2ZsYmNPdHNncFpUa09KVjl0a2Zi?=
 =?utf-8?B?TkVSazdHbkxWL09xWTRnQXVtaDM0MTFvQ2YvdjFkb2YwNXJPdjFHWXRBYzJu?=
 =?utf-8?B?Ull5Q3dnRTF0dmZjN2hlNHg4U1JhRUdYbDdOdjJvSkNuUHU5ZHhPUHhpT2lQ?=
 =?utf-8?B?T2gyNUhYS2NXaEFRYndjVEFrNFo4L3d6cDVObmhZOGVRVzlXeGN2emVaZWN4?=
 =?utf-8?B?dTNHOGNrUUI0UHlIV2h4SEV0WGxpM21ZRXRLaXdma3hYR0k1WXN6Sm55M3Zs?=
 =?utf-8?B?b1NNTG9xb2lKbyttY3RDRWRBUXQ3TDRyOXoyV3BMd2I2TnA1N1FJTVdEMWVL?=
 =?utf-8?B?dmdxZWxLZmpreUFuOEkxS0hFOXlFTGhhSWsyWWJVdXkyUWpRRVplTTVzMnRR?=
 =?utf-8?B?TFFsUUw3RlJCWFY3UjJQeFBEK0RiM0RRMGVkMGlxNktjenpEYkpoRlQ0dzFX?=
 =?utf-8?B?MjRhTENDNnlOOEt4dUZtaC9vdUlheVJlWE9HTHJXQlFkcDJ0RkRJNS9CUnVP?=
 =?utf-8?B?UnlaWGQ3SkZVOGtqK21NTlplVUNKT0c0MGFUczZmVEF0ZjVSY25YeDZyWFFM?=
 =?utf-8?B?cG1US2pKR2FCdm9PMzFqOTdxL24vS08xdGVIN2tQaUl2emZOQVc3U2wybDJv?=
 =?utf-8?B?SEFnaGZLSjg0cElrR04yT2lLM3dtQk1pdjdmOGxWQ1ZxV2llc1JESkd1QnpV?=
 =?utf-8?B?MkJvU0xXakFmUWpXR1ZPYWNveGRCeTdsRG1zdGplTElLMy9sRUJsNVVSam1O?=
 =?utf-8?B?WWkxdXZVNThDaUU4eVJhNll6SmFjK2h6VSttNVpoOXluUjA4TktGQWRReFkv?=
 =?utf-8?B?QnJLSmNUdXFZZmlmTEZOY1oxeGF2cDRYemRmcWFJZVlEMndteTh5cHNNN1dr?=
 =?utf-8?B?enRESjVNZk04RWZxaFNPZk1qSXY2U2x0Q1ZFMkVvN3NkeCs4eENQTUc5VUtm?=
 =?utf-8?B?c3Y3MGQvV3MyU1p3eGdCcW85NVdBUURqS3o5eVhhc2E5akl5a082T2ZMeUVO?=
 =?utf-8?B?aklzNHJUZmoxekQxZHJOb3RwcUQwbStWV1RwUHorb1NKaW9VNHZ3dG4vZVl4?=
 =?utf-8?B?RkR3UzRHZkpGVHZLb21WR2VBQjNoWVUrblNVdXhMaVFMUmtHMXFNYUxrNG1Z?=
 =?utf-8?Q?ccjn49l1zj7Zxdcliya4A16kkchNbMEoMdUOOOe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVowZEZLbEcvZzlDL3ZMWjVCbDVxZ1E1Z0h2RnpVanZaaXVKOUxBd3pWdHA4?=
 =?utf-8?B?NGlZZS85Mnl4eEptQTZSeGJKS0NsdEdiK09SMUJqTWFHbS9UeWtwK3haY2I2?=
 =?utf-8?B?WjIzZ3RKYnozdXQvQ2xrSTRGVldTUEZ3M3pxTklIY0dFZGVHbTZMNEpIaHY3?=
 =?utf-8?B?UGVPeHNYdGs3TDNzNTRQUEQ1anMwQXJnYUkrSEpLSklpcFdOZGRzYXRsT3NK?=
 =?utf-8?B?dmdtRCtZOGFYejYrL2JVZEVYd041T3UzUzBwbmJvVW5Wb3c5Nkx1OUF4Qm12?=
 =?utf-8?B?Y0NGOUVlbGJRQW02RTNBZ01ITXRTQjZkNGNLdXJUNDRhVWpMOEg5ZE1YY2xO?=
 =?utf-8?B?d0JoUUI5WWR6T0xna3E3WXhaYmlrU3Y4ellaY3dlT2QvYTJQN3h4Vi9xWmEz?=
 =?utf-8?B?RHNON3JsOXIyZW9QYzRZaUFmRGo1RTZXOUEzbWNTUlNrb3MweDNCZEM0SkRt?=
 =?utf-8?B?elZ1MHQ3UG9pMWdQTHJMMFdiaXRyRHcvWjNpNDFoVVBrejVUQUVxZWZ6SUMy?=
 =?utf-8?B?Y0N5eTRRZGEraU1lbVZjamI5NnBGVTBidzgwcEpDMFo1VCs1Q2dWUUhSbkFU?=
 =?utf-8?B?TGs2Z1UxVFcrUVBQYWdoOEZIUU5mNFNxK0g4bU1ZUjZGN0xwcG04RFEyMXlT?=
 =?utf-8?B?VUNldStuY2FSM1VUT2lRWkZtaS9YTkN4VStDMncySmU1Y1dMMmdBOWRjR21K?=
 =?utf-8?B?bUg3UURPV2R6UnlZTGJsOFVEUkE0QTRWbW1FZUdFUjJDZWNkZmZQcDk4VWh1?=
 =?utf-8?B?Z25SdzNaU3l4V0ZHVVBTREx2WE1HcHFQNlRZckVYL1pDVWdRdUZ2YWJQOXZj?=
 =?utf-8?B?Z1dFeC9jSzZzbmM2ZTBVQ1VIL2FQRnAvSExUZGNTSHFhOWJzM0d2NXlJYllo?=
 =?utf-8?B?ZHE2Ujg2RkU4SXlId3RnelhyeWRGd1RjMVhuQ0ZFb3cyaTBUQys2TmFUNXNR?=
 =?utf-8?B?czU5TjRnbFhXeWdicTdPdzk1VXhESXE4YWp6d1FCT1MzZG5LSlZHR3hhVGZ2?=
 =?utf-8?B?eUZXOS9BMDc4N1VlOFlvK0xVU0syTkpPNFFpa2JlMzNSaGpTQTRYN0pmRXB5?=
 =?utf-8?B?K0tlOUFjVVVXc2RIL0hOYmpYRUcrVWNvS0ZjYUhVckpDTDBETjU3am1TdDVV?=
 =?utf-8?B?ckJRbEJ2anNYQnNLSE4wbTFvSEhvcjVGNGxWekdxdnoya0RPaWNUYWYweWE4?=
 =?utf-8?B?OWV1MFNVTEtqZnZJR1V4b2h6VHd2a1M0U1g2SHNaR0tDQTROcnRBd3Iza1Y0?=
 =?utf-8?B?cEpHY1FoaXBXZUo4eVRxWGYyQVVjSlBINkxxdUFVMnB6alA2cy95V3hrLzdQ?=
 =?utf-8?B?K0docGRMM2RpZGIveWNHMk40SFA1M1U4RUw3MXBWS2pQb0dKSnRlYkdsWWdF?=
 =?utf-8?B?a0RzdUE5NDB3aHRwTnpIWjhtWUFGUk04TEVFT3M4UmFPNzdna0I5QnQ3cU4z?=
 =?utf-8?B?Q0xZejZXQjBvMG1Jb0NmbUI3cC9JQS81L3QzbU1CcG1nYVIrTUljNjY5aTdX?=
 =?utf-8?B?bVR3VjNnZHdtV3VnY2JSR2YwVUhtRHZtQ2trTEhTVFMxMC8wQmszSmtsUkFK?=
 =?utf-8?B?NVhoR2I3ZG5qSG5abGFCSFFQcno0RytoenlQS2N3WGliY1BHSHMwMnhGRU5G?=
 =?utf-8?B?VE5pM242azUvd0tBbmZnYWlaNm81c1Y0RjFJOGlFK3FCVlNrWkpqSlNVSytV?=
 =?utf-8?B?MEgwbk9sY3NlY0hMWGdIOHFjeVJzSnhCbWVkamlCSm01Mm1rcjhkYUtNOXlq?=
 =?utf-8?B?RWRYTytZa25NellWanJVR28zbXJ1VWdpRGZxcFBVQlJHQzhWVW5INVhadGlC?=
 =?utf-8?B?WHVudU9vbS94L0M5b0JBK0hkbjBDcWNKVWdZaE5vLzA4QXVkRTdWYWZwK0VP?=
 =?utf-8?B?eTU2Z0pRWTQ5MEp2cjd3WGJrZGVoczRLdDFzaUJMT1dyZ3RjTGRMdzBkVjVN?=
 =?utf-8?B?SFhKWDhtemloUkN2Z3p3QTFmRnV6RU9xQ1hLbDl6bDFPS2ZqL2EzTTJxaEVJ?=
 =?utf-8?B?WmV4eEtOOEhVbDFyWUJxN21nZXVGRkRlRCtpL2dxcFRSNUswQnJIa1dqbDF2?=
 =?utf-8?B?L2pZZVpVQjdiUzFxakhSQ0V4eG52aHM3aWRDckJPL3UrNlIrYVFqYytHV0Qw?=
 =?utf-8?Q?jp40oEiAu64yGvcqHTu0JeZm0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec74ccc-5b38-4e56-0a3c-08dcef7a4425
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:39:20.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NYqhAfIduI3C6gL3bVTBkJs7zNO66aVTbyQY79xx22vS+nCmzRZIHdmIbBTlX2okDy5V9vk2U5ZThjJIj8G6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565


On 10/17/24 22:48, Ben Cheatham wrote:
> Hi Alejandro,
>
> Thanks for sending this out, comments inline (for this patch and more).
>
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependable on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  1 +
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        | 16 +++++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 92 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  6 ++
>>   6 files changed, 145 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 3eb55dcfa8a6..b308a6f674b2 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -20,6 +20,7 @@ config SFC
>>   	tristate "Solarflare SFC9100/EF100-family support"
>>   	depends on PCI
>>   	depends on PTP_1588_CLOCK_OPTIONAL
>> +	depends on CXL_BUS && CXL_BUS=m && m
> It seems weird to me that this would be marked as a tristate Kconfig option, but is
> required to be set to 'm'. Also, I'm assuming that SFC cards exist without CXL support,
> so this would add an unecessary dependency for those cards. So, I'm going to suggest
> using a secondary Kconfig symbol like this:


Yes, you are right.


My idea was to force sfc as a module if cxl_bus was a module. I tested 
that case, the cxl_bus within the kernel image and sfc as module, and 
both cxl_bus and sfc part of the kernel image. And I forgot the case of 
no cxl_bus!


So, I've already followed your suggestion, not exactly, but I think the 
idea remains. Now there's a cxl option only appearing and therefore 
configurable if the cxl_bus is a module. Inside sfc we have already 
another option, MTD, which is a similar case and requires kernel mtd as 
a module, so I think it is good enough.


I'll do a bit more of testing and do the changes for v5.


Thanks!


> config SFC_CXL
> 	tristate "Colarflare SFC9100/EF100-family CXL support"
> 	depends on SFC && m
> 	depends on CXL_BUS=m
> 	help
> 	  CXL support for SFC driver...
>
> And then only compiling efx_cxl.c when that symbol is selected. This would also
> require having a stub for efx_cxl_init()/exit() in efx_cxl.h. That *should* have
> the same behavior as what you want above, but without requiring CXL to enable the
> base SFC driver. I'm no Kconfig wizard, so it would pay to double check the above,
> but I don't see a reason why something like it shouldn't be possible.
>
>>   	select MDIO
>>   	select CRC32
>>   	select NET_DEVLINK
>> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
>> index 8f446b9bd5ee..e80c713c3b0c 100644
>> --- a/drivers/net/ethernet/sfc/Makefile
>> +++ b/drivers/net/ethernet/sfc/Makefile
>> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
>>   			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>>   			   ef100.o ef100_nic.o ef100_netdev.o \
>>   			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
>> -			   efx_devlink.o
>> +			   efx_devlink.o efx_cxl.o
> With above suggestion this becomes:
>
> + sfc-$(CONFIG_SFC_CXL)		+= efx_cxl.o
>
>>   sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>>   sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>>                              mae.o tc.o tc_bindings.o tc_counters.o \
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 6f1a01ded7d4..cc7cdaccc5ed 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -33,6 +33,7 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#include "efx_cxl.h"
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
>> +	efx_cxl_exit(efx);
>> +
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +	/* A successful cxl initialization implies a CXL region created to be
>> +	 * used for PIO buffers. If there is no CXL support, or initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(efx);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
>> +
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> @@ -1380,3 +1393,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>>   MODULE_DESCRIPTION("Solarflare network driver");
>>   MODULE_LICENSE("GPL");
>>   MODULE_DEVICE_TABLE(pci, efx_pci_table);
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
>> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..fb3eef339b34
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_nic *efx)
>> +{
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> With suggestion above you can drop this #if, since the file won't be
> compiled when this is false.
>
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	efx->efx_cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		rc = -ENOMEM;
>> +		goto err1;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	efx->cxl = cxl;
>> +#endif
>> +
>> +	return 0;
>> +
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> Same here...
>
>> +err2:
>> +	kfree(cxl->cxlds);
>> +err1:
>> +	kfree(cxl);
>> +	return rc;
>> +
>> +#endif
>> +}
>> +
>> +void efx_cxl_exit(struct efx_nic *efx)
>> +{
>> +#if IS_ENABLED(CONFIG_CXL_BUS)
> and here.
>
>> +	if (efx->cxl) {
>> +		kfree(efx->cxl->cxlds);
>> +		kfree(efx->cxl);
>> +	}
>> +#endif
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..f57fb2afd124
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
>> +struct cxl_dev_state;
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_nic *efx);
>> +void efx_cxl_exit(struct efx_nic *efx);
> As mentioned above, you would need a #ifdef block here with stubs for when CONFIG_SFC_CXL isn't enabled.
>
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index b85c51cbe7f9..77261de65e63 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
>>   
>>   struct efx_mae;
>>   
>> +struct efx_cxl;
>> +
>>   /**
>>    * struct efx_nic - an Efx NIC
>>    * @name: Device name (net device name or bus id before net device registered)
>> @@ -963,6 +965,8 @@ struct efx_mae;
>>    * @tc: state for TC offload (EF100).
>>    * @devlink: reference to devlink structure owned by this device
>>    * @dl_port: devlink port associated with the PF
>> + * @cxl: details of related cxl objects
>> + * @efx_cxl_pio_initialised: clx initialization outcome.
>>    * @mem_bar: The BAR that is mapped into membase.
>>    * @reg_base: Offset from the start of the bar to the function control window.
>>    * @monitor_work: Hardware monitor workitem
>> @@ -1148,6 +1152,8 @@ struct efx_nic {
>>   
>>   	struct devlink *devlink;
>>   	struct devlink_port *dl_port;
>> +	struct efx_cxl *cxl;
>> +	bool efx_cxl_pio_initialised;
>>   	unsigned int mem_bar;
>>   	u32 reg_base;
>>   

