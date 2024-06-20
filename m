Return-Path: <netdev+bounces-105369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29003910D77
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14A81F22440
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6881B3F2C;
	Thu, 20 Jun 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MDxZdM+I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CF1B3F08
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902035; cv=fail; b=meuIxv/hhCY0cPNRSxLgqwvIWTRTipDL25iNGKJnwSqLZNg9JT0EvFt+k4jikUtUCtjXiufgmJm7etTJpSEkWkzofkzbtKe5pa767jYKUJekW069cTGgeBwRjpLXTTo0YZO4OR0rr1goW4LGXJn4UQcNmK6i4Q2mGPoXabaxpVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902035; c=relaxed/simple;
	bh=zj0syAsM8RrVTqz4rAh9QnugsgTTxvoVLB+ubvXBr0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DmJxD7nmyr/gCQbYZdGyg+ggAt67A6118lSb3OQ97d8eJ3wdOO98tvmSGZKXDaKlyVKl9ml/t2T0CXUQASx0sDYJpTpjWnaBVecy89q+jebylhIetqBpiCgJkFiFHaJQoq9KHC+OiHyuiAatWC7YChcBfvp0XS4uYHHQ7pE87pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MDxZdM+I; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyagQisIHyRanDC84RG/Lz/830+mg4ip1mxiITeOPj+VLYM8zCn5W3EP1GmOoCwRMLL9IjGjtGx2UAJG2DjVM0y+M3vBD8VdheLHzQqj/+ebFyod0OMEsIyj15dt2FvuJVWymruRBhq9OBjEyPr4a7gylAce7FcufXA53Y2vzKysjXtSIJzqWfQgk0uKM5IvDqBJneATS69FH0TZAfP83PCpL0D8jjMlyfXnI9oBnUyX1/LZ3q9PChElpTBBeRs2/0Sj4f9LrOS56dkMkdhYwTcnIn1zr4MYc8rik5Rjfy1fTg4Y2tY5+3RZKvLkt/M/v9FBCupyQVT51koQQLmaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3zQOtstFTj/XtIAsAup43vQBQdRZcxOSUTnVGfGg9k=;
 b=BP89W2E7kRnpr/mpznr6xVdiS4jgHfiITYnkg/ySIL35Vt8czquivhwMxSkNBW/OGh7sk/2VZeKe3YKYm17yz6N3tgkohGOjXrr+RvB4Kr8r/vlcPQSCKHBB5Fo7LG+nTjn6H8X1ytpl82W/i2B53tJClV+YymIPtrqo/0A2T9PJPk26DT6IhvD55YCtFGWse5QIQlpD0Zps6BxJrzr3GwJwfVT/2fFvVSTRsSHsk2YZ7G2DqKBSOQn8QhMGRRbOg19VqBMzSdIkLcCCmMU/83bh+32W5jsAG6n8ZWYcibvM7osZf7JhofDudwtUmXWZsaNFfqO+djHCTkEhmlNMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3zQOtstFTj/XtIAsAup43vQBQdRZcxOSUTnVGfGg9k=;
 b=MDxZdM+IZUeUtO7Lihz9iO4HSvti4jetYj70+z7oCVX1OPQXf9DN6wXPl5p/nElGdYKMurS/g52g8pOWKMg6aK5t5MiUl/6tlsl7XMx77QprPXZVTl8Nrs4ucgmVT0squ0iwTJdQ+0HimZwsT3j0Qu2xrCAORubnQySP488b81Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Thu, 20 Jun 2024 16:47:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:47:11 +0000
Message-ID: <98d9175d-9e83-4b80-9ac1-ac58b9b59b59@amd.com>
Date: Thu, 20 Jun 2024 09:47:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/8] ionic: Keep interrupt affinity up to date
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, David.Laight@ACULAB.COM, andrew@lunn.ch,
 brett.creeley@amd.com, drivers@pensando.io
References: <20240619003257.6138-1-shannon.nelson@amd.com>
 <20240619003257.6138-3-shannon.nelson@amd.com>
 <20240619174317.6ca8a401@kernel.org> <20240619183035.51ec1beb@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240619183035.51ec1beb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 92112214-0332-4c12-10cf-08dc9148a155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXdQcUpWRDhNMGdDKzZTZ1M4UGZmVG03MElqS2svaElnOWpjZnBxWFdvcFEw?=
 =?utf-8?B?blgwTjVFcVBmb0RXL2VaR0ora1cvd1I0UnMvbEpqZnprR2FQNXIxeDNVRVFv?=
 =?utf-8?B?aEY0QnhKb3lSc0NSd2w5S0hCK09HNjV3eG9hVkI0anh3ajd2NzRQT2MvVldx?=
 =?utf-8?B?c29JVmlCY3RsTC8rYnNCTE1BRGN0TjhSUGRUMkZ3amlEV3IvcjI2NnJmN1dH?=
 =?utf-8?B?R1JJNkwrZGxUbHdFblQ2dHhuQVBsM0Q5eTNpMFp6NysvRjh4RjhOKzFvc1RI?=
 =?utf-8?B?M012WmRyK3k0eVc4blkvUytWUjJkaGJuVGpZOHhtSmFxMVZoVE42aXc2YWta?=
 =?utf-8?B?b2pudlJKKzhVYUlIWmFid3FoUDRmRzk2L01CSTJtVVpSbTNxVERwQXlFV2VS?=
 =?utf-8?B?RWdTbXBaZWk0cHQ4MkRyS1g5ZEg3VjdmRzdNNnJvdzhIUEc3NWg2UFpmL3R4?=
 =?utf-8?B?dXlQTjZwbHJvZWZRSVlmdGJEb1pZMUhIU3VWdjhROFJrVnpPQzhOOG1IZ28v?=
 =?utf-8?B?cGhpZDdkTVVIMzhLRU9hRFlGbGN6bTMzWEphUU90dVVpWWRiQlZFWTZKTitx?=
 =?utf-8?B?MjhQejZsWDhiVmdTaktHTHhGWnNMUnA5d0FsdEs4b2k5MjI2bmVEUDlxMmJs?=
 =?utf-8?B?amJ5YzFiU3kzT1hmTjN5cVQyOFplNHBmT0hVTzlDTkdWMmtSSmpPTERUTmRS?=
 =?utf-8?B?MktKMlNzMVN6dzNsbDNsQm8wellrYjYxbCswbUJCWHJUVFVLQTFiOGNYOWtG?=
 =?utf-8?B?a29NYTRXUkxaaW5tQ2ZWQ3dwYnFFbVVDb01FNFNFQXYyTWl6d3BBZFFBTW8x?=
 =?utf-8?B?a2FGNXNTY21DSVd2OSs2aDBrUTlISjR3cXFDT2hKbTRtRmsvZ0FITDJQSHdz?=
 =?utf-8?B?aUJmaUpVdUV4bklRbHI1UVlxM2NaWC9TcUFVaXNYRGd1VjNHdWJIbHJBWjVs?=
 =?utf-8?B?eDgzZWV5OGkxdXdyL3R0Sk1HODJrdEhUVkZGeTl1Rld3YkVESjJyMkNtdU9T?=
 =?utf-8?B?UEtBS3p2QW5JZTd2dFlzT01EVTVaVnNBclZKWEdudUlBTk51Y1R6TDNZSWZX?=
 =?utf-8?B?elB4dUNVbGlCVEViNXF1TS9FZXFoMjhKcExtRTNxUnBRSE9TTVlKVGF1VHdQ?=
 =?utf-8?B?M3NEb0JwYzJWWXNqUkh2RjRBVFpYcGVNdFY4MzVoN0VKVVg4c3UyVS9FWmFE?=
 =?utf-8?B?VllGS0t0dlBic1AwZ0NaVURobmJ2eG1RRGh3cDZEOWV5c0RrNWdDMnVWN0Vl?=
 =?utf-8?B?amtpbE9ZNGcrRWVsdTVvMnZSdjRzWlNESFVpbUU1bmZhWi8zNFBZa1Zmamla?=
 =?utf-8?B?Sy9QbUsyZXVoUXRDYXBQL0o4THA5aWZhTDc2Q1lZMmxpY3NhcEV5VEh6TFYy?=
 =?utf-8?B?U1M2My9ORy9laXNLZTBOSzQvUTZOYUc5WHdrSS93MmVoaWR3b0I2VTQ1UFFu?=
 =?utf-8?B?VVhNSkpuQXh2NjFSVm5UU1RVditlaXJDaGZxczkrMXBKVzVYQ2QzbU54dmR1?=
 =?utf-8?B?WUtKcWNza1lvbEdqSEdMenZyL2pTcHlhd2JlVVhTUy9vZFpZNXpMSGhKWTZO?=
 =?utf-8?B?cXVERlRXWER0SEtBcHNDTWNPc0hTV2Jwb3ZacUpzbTJ0Rzlzc0JvdVRkckx5?=
 =?utf-8?B?ZHlLeUNMZzdVS0QzU2t4MzNuMFNvVkRjMzhHZGtLZGplcS9pTmxwdk45Nnpm?=
 =?utf-8?B?QUFqSU54Y1c0d2Uyd2Ivcm9HNmJ6MHk4RzNuT3Rsc3Q1Q21rY2d5ZDFLM3BK?=
 =?utf-8?Q?0Jh5m3uxjIyUmdPLXqDkeTYZt+VEx3AHYJoKme9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2V3WTQ3U1R1ZDlveVpyMGREMG84ckFyWGk5RGhkZDc3ZGk5c25hL3MxeUZv?=
 =?utf-8?B?cXhVN3A3QzJxN1ZhUk5ybDh6OGc1aXdCVURpd0Q3N1hUdnpZWnVTWGdjUVRZ?=
 =?utf-8?B?TCtJelBoaHhXVVEyN1MvcUFGellZZWhUTkNsbTFaOHNjMGFhRE11bjN1UGUw?=
 =?utf-8?B?SGFXaWRYdER1VEk1U3d5K0VuY3V1NVpiV1R6aFZJSmpEMVBOTzdLSnlvWDV1?=
 =?utf-8?B?NU0wTEY2aytwOCtmOXdBOHNQVk5MbzZUN2MzTGdWWkk4OXZzRXhHZlpSQ011?=
 =?utf-8?B?U29nTFpPQ2FZaWpIU3RoM1pnbG1nUnhMY0ZPWDZRTUZqcGUyZEtWc3pmdml4?=
 =?utf-8?B?aEo3TDZ0Szdld0g4MDhYdit4RWVuWFQ2NU9taXZPd09lbzBuWXIrYzROMkZi?=
 =?utf-8?B?dGxTcWdOWmtTUmw1L1lPbXJ4aTJsRmwvYm5tM1c1ZjEwZ3dMNzZlb1pTejdI?=
 =?utf-8?B?dUhXaVNiSnV6NzJRMDBoRUc5S1ZyOFozK3RMMEFkbDU4UE4wM0NtY3BtaDRD?=
 =?utf-8?B?SmkwL016SzZIK1dHclVRSEVCV2pFVHNIVmVWaGQ3bUlHTEpSbmZlY051akZq?=
 =?utf-8?B?QSs3OVU1bFltTjZSVC8yd21rdE0vaTBSNzJmZzFkWERLai9UdkJBVmZsVnlI?=
 =?utf-8?B?STdKUFpGZXlMakdYYVY2YWNWRDdFc3ZFcnRyNVY0aUltMFBmdFI5SkdRVWgr?=
 =?utf-8?B?VTlvdEl1QzFmOHpqMXFLZG9ZNDNOazJ2YklxVmlBVFRnTUg3ODUzZlloTy9i?=
 =?utf-8?B?dVAxTHFSa3Z3cThrbVRReXBHYW9Bd1dEOG03aUM0dldVSWQ4cDByZzdra2V3?=
 =?utf-8?B?UGp6ekdVN2ZYaVU2ODJZUlA1SXNER0RzL0REWi9YSnVMOHQxQWdlaDVqbnRH?=
 =?utf-8?B?alRieUJvL3hPZDg4VUlMUUxPUlhBN21JSUFuVnR3WFFxNGlYSjhjT2hYa3dK?=
 =?utf-8?B?OEpRN0wrZVBtQVl0RzZMZjROUWd0RVRPaVk0L3N2MlBENGY3T3BEaGF5OHFS?=
 =?utf-8?B?K1FzRzk2dGU3RTNLWHRDc1kvV21LQnBha2VxTWE4RzNhZTJUUWNPa2JTZ2ZN?=
 =?utf-8?B?M0NCeHNUaVdSK3lQRlJwMDdXU1AwT2dMRGhvRkU2UXZjZkh5eCtzZmFHZlNm?=
 =?utf-8?B?eHVPdG9ic1lPTHFJa1k0dG11U2w5bVZRQ0hiTjFOV2pjUUhNZG91ZThKZFh3?=
 =?utf-8?B?SS9heG01STA4VG04eXJpaW9xNnBmdTJDWWxMTWxoUzVuTWVSblhOUnMrN1p0?=
 =?utf-8?B?ZDhOWm9GWFp5M1hLekVyR2FyUW1zUkllNWhwcmR0U09FTVdlamxBa25HaTV2?=
 =?utf-8?B?QUl2TjZRcUlORGJldFpFY0IvUFZoTGl1UmlldjJCZ3JGM1l2c09rUTdPQ09F?=
 =?utf-8?B?Nm00M3F0L0x5bENmV0FIYStGdVFQcDNMYjhQLzM5SmE5S3ZDcVVnK29nWWZS?=
 =?utf-8?B?NXRBVHFSb1VQMWdHQzloelVkREs1aWhLY0N6Q2N1enpyN0ZpQTNsVUdxcFAz?=
 =?utf-8?B?RXRPcUhkM0pFdVFtcXNsOHU0b1NRR0RMVzArRjJNTFdZMHJVRHpDVS9IbTdI?=
 =?utf-8?B?SCsyYUJYZ2t1d0dSZCtYZnNJZTJJcFllWTdEY2hSQUJHblZhMjJRVkJ6dmdK?=
 =?utf-8?B?M0g4Qkx3cW5Xa3RMU2ZjSnlWZDRJQUhybFNKUUxlQXF0aVUzMWdESHVEOWVQ?=
 =?utf-8?B?TUs2Tng5Z3R5RDdvcWQ3Y2R1clZMRXFYcVlKMzltYm9ubFdOckM1R28xNVlX?=
 =?utf-8?B?Vis1bGF0bDRsTmFma1hsRytTLzE0SFZlbE5vQkdkbFh0YXBWK21qeXc0TU9m?=
 =?utf-8?B?aFE5Yy9qQUxwSzh1RXdPcXJkZjdEN1dUbmlMeUJZTThETEl4S2lGTVp4RGxq?=
 =?utf-8?B?VzR1RnRraURNWDZJd1ZCWkR1Q29BVGxpaTUySGFNOWhUWjdSRW9TRHJGREFX?=
 =?utf-8?B?ZzZ3MjRtbGNQT29odUN0OGwzWUhibzhKbjFoSW9iR2lyVU54REFWSkVZR2Z2?=
 =?utf-8?B?MCt3Z2tKUDFrQmJxVElkTXhlbXlFYXlxSHZRbThndm9rRnpjeEx5VTZvZTFw?=
 =?utf-8?B?Y3ZtRzJxalFYVXIzRlVXWEpJSXlia0JYdktxV1ovdnd5dS9UOHdlbG92eXdV?=
 =?utf-8?Q?/xhtpeYz+K+o2rfgk/Xwa1EFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92112214-0332-4c12-10cf-08dc9148a155
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:47:11.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHgTbn2ATWcxHd/ldf0WsEGpLtOnzWbtaVdranfpeIkItit15/Yub+s/u9Ne3pLdNdjl2FslwFYxMWXeCPwzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139

On 6/19/2024 6:30 PM, Jakub Kicinski wrote:
> 
> On Wed, 19 Jun 2024 17:43:17 -0700 Jakub Kicinski wrote:
>> On Tue, 18 Jun 2024 17:32:51 -0700 Shannon Nelson wrote:
>>> +   if (!affinity_masks)
>>> +           return  -ENOMEM;
>>
>> There's a tab here instead of a space
> 
> The rest looks good, I'll fix when applying.

Huh... that slipped through our standard checks.  Thanks for the help.
sln

