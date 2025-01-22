Return-Path: <netdev+bounces-160221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0AA18E0B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B3218870BA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74F204694;
	Wed, 22 Jan 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NjiinM4c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11502170A15;
	Wed, 22 Jan 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536736; cv=fail; b=TrqjtnXFSQjN8WPb9o6nwM+RbjL1o8yofa4fNx4e8XU3ehtlXw+5l3dojNJ5U1PCNuZZPLAZ5/KP0Sn891ZJdO8vaOgqccJB/i9xJiLqLksAGIIq+cl0cTzSALE45xsBgRZrtusx/+DlrtxZGcoaa1OjJVCA5KFfo08jpfEXpgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536736; c=relaxed/simple;
	bh=8+DxILEcGv8ARqyoHP5MQPJSie7aG/KZDWBJThdysRo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJvXzNW+ewmtYWAQ10VJ7WSIGoeYiO9W8DYhjQFoRS1sL5QDZGAHjWyXVpC+rfTIshXopR3vWiDEewhDU0amK7iWguPA6/RndPph+zlwI546B63CYGB3jkZ/0ziiJZfV7BF/MFA8w4xi9QMA130Ksl4WnDvV7JNjxnpOf/7Pfa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NjiinM4c; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3uc2x3ZNQIAjfQEi0ClS8X5M3V6FS2GWYltFolntg9TwqXnImCtVhGmT1O+c6Y7puNdg7OUn41Gz4kdK/GplvAkbVc8s9wAM6WwQA+Jsbh94qAmcGQ17qR0fa73A7wMpqbPCWiyz44wDELMwpQoDfX5uQiiQoWu4AfHXN9YjevXwMUa743uudr9tmNh/y7h0nBh5EPXpWt7wJrIUAsaIigDP2QxIQM3EWMxxcHCRf8odLgzxh9zwVPu8uiTD/5D0pk7rzmcmUtxTZ7S1+PUweLKMZODakaIm+7f7k1sC1JWVuwfBjND3b8ZgwZ5KDn11ZvHfQrABKMHGNC3eA1GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvPrfYscZ3jkEkU7/SU4iiuZH+tAXHFduPr7aeomoxA=;
 b=VY35Tj+XA1lVsLDD0+d/y6TzlKHQFRUmTYHVZnl2LaSQXKE3MGnFsIHy2DWECtOxrAjcrfEE42qmCdNBeNQHBogsaVTCZ56pXCczTDzE9TqSjCtWgRKeR8eJ/kOUi3rCICDyVOkGzBL57eczki+GRHhjK/ecXMNe9F+0AFGK0zDQmeL76H246+tybbu91XEEVfjAvfe+eobF1g0nxsCBrNs6+UX03P+KV4DPez2NxoyGUG+kJ1ZU/B+38utGIeCBPf2BlhLbERegDml2XWEBxwxb2rXkvavAAAj3O+oJjdq4WHsJN+qWPSv0dt04mNZPrQLqxVDhJpSBedQv400YNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPrfYscZ3jkEkU7/SU4iiuZH+tAXHFduPr7aeomoxA=;
 b=NjiinM4c49VmhY85RAAgAo7y/LADpzuWwvHzWT5z6KD4pjmG3JZQJR1SumihRmc8T2HIuTE3sOT5wmM6NhiBV8QFmc/vEnVq36CzblTqgYLNulz56YAsfxBrAbFZwSw6t0AZg34Ai1jtzpQWgamjlbxgVUKJR2GUolN84IOEdgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 09:05:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 09:05:30 +0000
Message-ID: <314eb564-6366-b94e-ed46-98224d14417e@amd.com>
Date: Wed, 22 Jan 2025 09:05:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
 <678b092428a86_20fa29462@dwillia2-xfh.jf.intel.com.notmuch>
 <0063f9c6-9263-bc4a-c159-41f9df236a7c@amd.com>
 <679024f84230f_20fa29478@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <679024f84230f_20fa29478@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0392.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 894c99b5-8ed2-4f49-9479-08dd3ac3eb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXhzR2RPMG1aRDFCeG12WVlCR3V3a2ZkZkptZ0lXUTZROXAyLzJMRXVtS0N4?=
 =?utf-8?B?SjB6YjJPREFwOG1ZeFlkUXllVUxDUzlyOTV3TG1qc1hFZW1YUG5uZ0FOUWxV?=
 =?utf-8?B?VjZsbHBId1FPSkhaWXFoNHlTVEQrQlR3bEphQ3lhZjFsbTBvMTB2YmFrdGRs?=
 =?utf-8?B?bHNlZFFsKzVieDJYNnd1azB0U2QzVnlmTVNEYTB5cmthdTREVmttMkN1MXo0?=
 =?utf-8?B?QndESCtzcXoxTDdtQ3QwKzYxanRlV0M2QURTUnFicVNLT1JwZnZXZjdWZVBl?=
 =?utf-8?B?bUE4M3VuZ0pBTHZ4U3FzdHNrK3hQcUYzVWwwZE91cHVRRGVSd0N5NC9CL3pX?=
 =?utf-8?B?UkpqR3JZYW5RVUR0YTdzc2kxbEhEaXA4RVpiNUdBbnVjWWoxcWl4SHgycE1t?=
 =?utf-8?B?d2F2K01HWStUcG5xZlUzaDNkZGhTdEZDOHZWUmJtSWVtdWU3OGhJTWVDdFIw?=
 =?utf-8?B?RHlHc0diZFFZNFF2bmxtL25ndVJxVzFSa2J3QS9jTTB6ZzJ2b1REYUVRYzQy?=
 =?utf-8?B?cjliSlZlV1pLUkNNdTcxdy9wQTRSZTYxZ0I3RVdXQnpiVU5Xem5uenJrbFpq?=
 =?utf-8?B?OUZKakM0U3NTSjZldTZyWlJ2T1p5WkZqbFFrMHIrTzR1WCtSMkNpaVN0QnM1?=
 =?utf-8?B?UUlMbUFNTTgyak1TWjEwa1IyZjU0b0ZyZitkaXJTbU4rS0VZL3REbXk1T3lu?=
 =?utf-8?B?NjBHVXRlSHYzSjN2R1ArVnZSTWFMdGJKclU4NE1vL0U3T2RQNHpubkNSQ3M0?=
 =?utf-8?B?RGZ6VzhFVStYS2lsRGhvaUc4WmVoQS84T2Jwa3JDZVNvSjVCbFFXNG15L0tO?=
 =?utf-8?B?TG9OLzkvYkxYTitSU1A2L0k5V094aHVsaVNRWUtxSUVFYmZkL2N3bDdja3Ra?=
 =?utf-8?B?SHBzYVp3ZDBSWlhZTXpFeWs5UTdnL3lCdzVrbUtHbHBPM0grZStibHBQYUdz?=
 =?utf-8?B?VFIvVzV5L212M2tsa1UxcGVKbGVjVkNMaGMyZjF6NzY3OTZJejN6aFFFajEx?=
 =?utf-8?B?TzB3eHZtUDU3Q2VDcjVvVXlNcjgycU1HeURLNFRiSzJOemZneTh6L0xYMDBI?=
 =?utf-8?B?RHpiRWhkODNEcXR6TWUxS3NlRGVOaHRnUHhCN0x3dXNac3FvT0EwK0djT1pz?=
 =?utf-8?B?YTNLZEsyTWM0Szc5NUdISUdKdldJVUlZU0ZLSjBZUWp5OXNic3puS3RRRURR?=
 =?utf-8?B?eFBFNkI1QXZZTWJBSUNjaXNxYSsxaWsvRFNrUUt0RkIxWHJ1eDA0S2hHSmxU?=
 =?utf-8?B?QTB0VVZKR2hxMmFidDhmSDZRZ3NudnFJRWF2cmM5NGEybWhPK1I5b2VVZ2xE?=
 =?utf-8?B?VFN6ejVYVFhvUlRvNDZpNlpqb29uYTNML0JQVXVlMHlsQjFzdXBabHFXVjBJ?=
 =?utf-8?B?bDYzWUc1bENWSHBNaERoQVVmOC9CT2d6djFueTZZNm8rb2lnTTE5OW54Q1Az?=
 =?utf-8?B?bHBCdERZa2RxZGN4MFpPYmxrZUdPUHNJdDIrU3JIeU10NlBIN3JrSGUzQXgr?=
 =?utf-8?B?M3JSTE1MRE50emx0T3VQTElrLzdsU2RzUU5BaWlKanBnSkVjSGNSWlJ2Mjl1?=
 =?utf-8?B?akdaZHEyM3kxRHhBUDNrd3hmSVZVYjhWdmJtajJPOGUzS0loUnk1TFBEdGpi?=
 =?utf-8?B?Y0ZkZGJkOHhiUzFKYjlDaUozbTVDRkhDMExmcEFBMGZ3NGtUa0J2VnN0SUVu?=
 =?utf-8?B?QThNL3RzbWhLZnhMVm9LRy9rZjRsQjZZakhlUzVSOTFiUnE0NWJNSTlmS1o5?=
 =?utf-8?B?QWNsS0xIdmtnWTdOcWFqOWtWS0VsZW5QR1NLSjlSREZGN0QwMkV6UjAyUXIy?=
 =?utf-8?B?MXluZHZ6ZCt4KzAxYjJPdFpWdUdTVkhyNnZuSWdoU3dwTXI3elZhOE5YUGhY?=
 =?utf-8?B?OXAvMFRFd2FYdHIzSVRDSnZVTk56VVZ1Z0N0c1B2em15a3NqRFpncWlaeWNj?=
 =?utf-8?Q?NFPuL8+Np9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkloaXZRbmtRMURZc1NyUituK1QzbFBic1NMRjBRSWFHMDg5Y0FRaGJlM2tp?=
 =?utf-8?B?SiszRVV4YVdaTHpxTitTZE9VRjhGcUpSbHR3VVNxSldEWjZDSnlMd01zMkJC?=
 =?utf-8?B?Uk1WcFIrSUxYaWNvTHdlMmRoT1ZwZmZwT2RGZWRYd0pWTEo4b2U1cTA0ZkVn?=
 =?utf-8?B?T0ZIVk45SW9hQU15NHRreExydUxIUmpEdDF6cjhsWGxTeDRiWXNicTltT2c5?=
 =?utf-8?B?OHdPR0xiclMrdmtCckJmdjZLRk5oQzRKK1dwejhQbzlSMXh3S1MrRUNuTUF2?=
 =?utf-8?B?TGlIYmRjWnl5c2xNTHp3dUg4MkNNVmpmMkRBWnR3UGRpeWwvT21UZk9uQngv?=
 =?utf-8?B?T2pyWDJWNmRaUjRzSFRvVi9WMW85ZW9xbGhpOTJOSmFpYnlla0ZuN3ErdVBq?=
 =?utf-8?B?QVFzUjR1S2JxRk1KdnZiMCtLWjNVTHRWWXpjQ1BBNTAyTmNWcUZaWTBPdzB2?=
 =?utf-8?B?ZFd3bkc0V3JQaGpPVXVyamFGSnBSSm5nZjA5RjI4RldBNHJPWEdtZGlXSnln?=
 =?utf-8?B?R09DVHMvM0pIZ2V6MFJQUlJEMXZ3M3ZQRHhQTFpockx2THBJMkxVLzhlNno5?=
 =?utf-8?B?S2JnSW82cE5WcmRXS3RRbHNoMEdlY3ZvNWp2N3duVFNOcnVma0FKSVhtZmZp?=
 =?utf-8?B?K0l6OGErTHpJRjU1ZkhvaVNmRkJSS2l3RG4yVGptQ3NBbjdtb2tjMkp0a0d1?=
 =?utf-8?B?QVh3YWVXR2NRcUU3R0c5VndhMnhCYVFVKy9qKzB4NFY4ZUJnVkVxRVBRRmN2?=
 =?utf-8?B?WWVMWG53TmdacDhaUFRvVUlybmgwbnZZNTJ3ZkROU3prMmhiYXc1cCsrWTQw?=
 =?utf-8?B?YVdoTG4wdHRmclgrZmtXNTB4bTF5SmNOUGpmZU42RE5WbnRWTFZmMmI1WDlM?=
 =?utf-8?B?RENwNHVHeEVGWjFiZE44elM2ZGt0VHNiM0hJeWxXVldSSDY4QlZaUXhFL2JU?=
 =?utf-8?B?RFl2d2lUQTZxTkw4ZzZWU3lEcStnb2RyZ0Y2akcyT3YyZUl4aVhsZ1UyeFNL?=
 =?utf-8?B?cHRkOWFkdW90a1pMWDUvVHpiVEZxejJkTzkzTk4wRUJnUDNmalBQQVcyTlpB?=
 =?utf-8?B?cWxibzA0SDJDcTZhRGlucVFobVJFUTJqc3N5NlU1UDJQS0swLzVKRG1BY0ZV?=
 =?utf-8?B?eWtvdVpCdnp3bVJyYWhtb3IvSkc3RnRHMkwwM0xYRENHL3ovaWZYeUlRME1H?=
 =?utf-8?B?R1hHL0duMllweGdIV2ovajhtczNNOEVjYlVxTmRiZUVzODRISDlzY3FUbG9j?=
 =?utf-8?B?b0swRjl1RTRGRFlMUTZjTVVETXM3TlJjZFVwQ0RJZ0lsUXpQYVA2VlN0MHRN?=
 =?utf-8?B?aUl2VzBvUFV0bmUrK3RZK0xqdjRYMlJBNWVKSVM0cXcrbmJTSW15blhtVm04?=
 =?utf-8?B?K0NaK2Q1cGpvZDB6eUYrUXNWRVdqSWJ2K3JwUE1oclB6WmRMdUkzdXZON2h3?=
 =?utf-8?B?aXdndmVRWVgzVEZLd2lsMTNrcEFTcDlrK1FPZ2RnUy9DZDE3ZnFUS0l0QnJu?=
 =?utf-8?B?dGowQjFHREE5V2dtTjV1dHNaRkpwaTV3RUxiUXJoamJRbXJ6OStidnhNdWNO?=
 =?utf-8?B?aUhYWkV2c1dYT1VaQ3BKd2NmMjB4U2RtWTVBVmd4eXRnOFpWVTVsQjlvYzYz?=
 =?utf-8?B?YUpnTjIxTWVuUUQ2SS9KNnk2T1hSZjE2WVh1Q05RSkdmYUtlcUNFQ1RmTC90?=
 =?utf-8?B?N2ViR2RiQXNEUHFPYkhkWWIzRGxtNVRjUTFrL2ZLbERGYkFGQlljM2dlSExx?=
 =?utf-8?B?VFBHejZGZFBFTXMvZEpYbEw2d2VVNGUrMXhCSFJacldoYUVuL3B2RHZZTUI3?=
 =?utf-8?B?eEJZbVFiSDBCa2xCWllSSzBFVEJWbmZzM0t4Mmo4Znc0Q0s5MzkrbXVCWFMw?=
 =?utf-8?B?RDlRUThIYm5sc2JETFhrNDlQc1V5cVA4S0Judmc3OEtnTmFGNitNNkVWZXFD?=
 =?utf-8?B?UFVJMlJxSU9vUkNBdFdBbzBycEx5WTZmMkZYQXpaUUZleWtLVUJzQWRkOWl4?=
 =?utf-8?B?MCtVSTVuVStTT3ZQOURrc0xRdmRGRnYybHBHNHNwZ2dZR293WkZXTGdma0RN?=
 =?utf-8?B?aGhzeWF0dWJ6R1R2NHozZWpQSnRDNC9DY2grTmozWlJ1RG5BS2Q1T1o5SFA5?=
 =?utf-8?Q?1uTqTcNyxim311Mzybsajx6v+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c99b5-8ed2-4f49-9479-08dd3ac3eb7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:05:30.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lUso4j5PpzBYhJmnEVrmHWblNTezkopi9heO9pVA+RzHFr07S0x0909npxIDvWGHs5GObplCyHi5i/DKmQAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234


On 1/21/25 22:51, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 1/18/25 01:51, Dan Williams wrote:
>>> alejandro.lucero-palau@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Create a new function for a type2 device initialising
>>>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> ---
>>>>    drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/cxl/cxl.h      |  2 ++
>>>>    2 files changed, 53 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 5821d582c520..493ab33fe771 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>>>    
>>>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>>>> +				     struct cxl_dev_state *cxlds)
>>>> +{
>>>> +	struct cxl_register_map map;
>>>> +	int rc;
>>>> +
>>>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>>>> +				cxlds->capabilities);
>>>> +	/*
>>>> +	 * This call can return -ENODEV if regs not found. This is not an error
>>>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>>>> +	 * mapping them should not fail. If they should exist, it is with driver
>>>> +	 * calling cxl_pci_check_caps where the problem should be found.
>>>> +	 */
>>> There is no common definition of type-2 so the core should not try to
>>> assume it knows, or be told what is mandatory. Just export the raw
>>> helpers and leave it to the caller to make these decisions.
>>
>> The code does not know, but it knows it does not know, therefore handles
>> this new situation not needed before Type2 support in the generic code
>> for the pci driver and Type3.
>>
>> This is added to the API for accel drivers following the design
>> restrictions I have commented earlier in another patch. Your suggestion
>> seems to go against that decision what was implicitly taken after the
>> first versions and which had no complains until now.
> Apologies for that, I had not looked at the implications of that general
> decision until now, but the result is going in the wrong direction from
> what it is doing to the core.


After yesterday's meeting listening to Jonathan and you discussing last 
reviews, what I thought was mainly related to this patchset, I was not 
sure I had to address this concern, but it is clear now.


I'm a bit disappointed this requiring new design after so many cycles 
and about something I thought it was set and consensus existed.


Anyway, I'll work on that, not sure yet what I should change and what 
should stay, because the main reason for the current design of an accel 
driver API does not exist anymore.


I need time for figuring out the work to do, so DCD should take priority 
now for trying to merge it with 6.14.


>
>>>> +		return 0;
>>>> +
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>>>> +}
>>>> +
>>>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>>>> +{
>>>> +	int rc;
>>>> +
>>>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>>>> +				&cxlds->reg_map, cxlds->capabilities);
>>>> +	if (rc) {
>>>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
>>>> +		return rc;
> This is injecting logic in a bitmap and a new CXL core exported ABI just
> to avoid the driver optionally skipping RAS register enumeration.
>
> The core should not care how and whether endpoint drivers (accel or
> cxl_pci) consume register blocks, just arrange for their enumeration and
> let the leaf driver logic take it from there.

