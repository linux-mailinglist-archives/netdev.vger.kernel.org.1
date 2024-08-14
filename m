Return-Path: <netdev+bounces-118351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF79515C2
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC23289D08
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEA4DA00;
	Wed, 14 Aug 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVIBaPoC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5274BE1;
	Wed, 14 Aug 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621632; cv=fail; b=tGe+YRPkLaYi0G8bE1NNriWVbiVxMnNWn5L+jzodppKwRNfnI7T+7SeEPAo0WWo8UtqfPTOMkAsl2JLVI/A6HFaeRET99oLErXfP5U+0aJ4XCwC1dnRMhfT4cIpuqHQYTINJf65xkRVIB4qrFpzWnBCiSwivBps+XGGtfBHU9To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621632; c=relaxed/simple;
	bh=WsmAnKR4HpqP206OR/v87gsWaTlpe6UgUC8N5rO4hvo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCTmPm4TRC3Yb0/KRcyEtd51R5D+zXXljx55d/KTD9T3cPnALcrnI+U3J+0o033l6uxTFTrf/zvsQAiRNx3Yh5Bphbz/+jM+5WAS4NCKZpDqVkNKM+x5VrwoeM/97mp2Wzihsa66W9ILdJ6YqyWVEM+gzmxaALpPNNpNcMuP3M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVIBaPoC; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4mhWwkGA01sMXmFdtdaco/CYmQBYKKg8BKAyVTL3iaMDZZQo2ww424Nwcww8QNy49nwThi73w80MyNpSxwajYdo6p0T2QBWv4VZtsZ8nyulHHoJQ07VUfKkWS1jgMeTdYKQSUBlu2TXWbN2Eg546KmC+fn0S4RfKnYVMv2y8pF5FgcASokYWhWEcRNhuq+12VgyqMWHXlHzyUgZiYiPrHDUvsPcceJGfl4Ow8dj7qEl1SbfqGQ6p6vsDRGw1Tfyx552fIVW2I9l16VrdmV4/CTDWbw1q3dNWkaHq/WRDOQltNdq9iTVhqj1eRAYSbeLmWj5Dr5pqP/xKIjn+N3b8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ2K5UmV7kV+3ZH/CDG4gqzwzgvJrI7NM6tS3Uoas5E=;
 b=Z173TVABkNOvtm1eVQU5w/cZvR5VTyxsQTAh8wxzKHnqbaj1oJbafekz5+9/FTjjGkEiBL7EpFk8V1nQ3Ll0pZhouV0c/LLMLFAyavqDbmvoxnu3USoXQvgnXsFSRNLorPh9zllF22Kkl4nA3bn5ZHG7ux9tQlCh9Bk9F22bukf6aZopbYmI6O4R/Bi3/jUPVQiSUyBcSqIsr0BM+OFWU+1XZ5XmAwbulH/Ln+kJm3+uoivIsFeU8oVrQfd6GHklbbJYTK3+G6rOuU5b940mLeWbn0xEE+cg9FNHubindun1bWt1OGYXaeaFIozHtf1/61kZmybLxa+3BMvBZZm+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ2K5UmV7kV+3ZH/CDG4gqzwzgvJrI7NM6tS3Uoas5E=;
 b=yVIBaPoCQIOmgBBbjz4lbKxWEDJYwsFGAggjrjrGkpMoP8s25YXyWmi49BK72yrhzxsh1ZuYngmJ7Vq8DOFsbaEMDSMSTHCgvdG7iG+AuQ1Nwxw0HmEE54/mC4fjpuEblLT3OoRORwoSWFKiapQWo9x5PahGlXuS2aB+NVyAWYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 07:47:07 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 07:47:07 +0000
Message-ID: <b7af48b1-3d51-739b-1421-b1a029e5086a@amd.com>
Date: Wed, 14 Aug 2024 08:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
 <da346636-a458-4ec3-a065-6ce56a985573@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <da346636-a458-4ec3-a065-6ce56a985573@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0602.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b3d32a-7968-4eab-922b-08dcbc354bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTVRMmJVVVBnUjRrN2V0RGtmenpqS2RzOFo2eVI0c2h0WUgrRVRKYjRjMnV0?=
 =?utf-8?B?Q3NRNTd4R0FhTGpVeWIwQzk3RjdKSmlhL0QxbjNNZHlSdzFGQUVmVE05czhD?=
 =?utf-8?B?MFVvU0NIQ2lJdGZvdXloOWdwUy9LUVZvbVV0b0c4dkNRVTFYUWF5a0pIY0tV?=
 =?utf-8?B?aWdlUU1tc212dnFIeW9TVjZtd09QdTJiM2k2RWVrU0RSR3lvSmc3aWZpYkVY?=
 =?utf-8?B?SnA1NDRnTkx5Q2x6MjVkbnBmWTZkQWtIeXdRb2FQUDBDWGlJS3JRTFZzWVlv?=
 =?utf-8?B?TGJMbXdSR2dPbmY3RE4ranFReHl5aEFXMXdCSU92WWljdStrdFd0MFBDdkQ5?=
 =?utf-8?B?S1lqZjJiT0JLZmh0S1puUU1HUHNCZHpiMkIyYy9vUmNsZGRHMXZtcnhaZnhp?=
 =?utf-8?B?WFArU0FBWEhVWjZRWldZOHJ1eHNYSUlxdUtqbURZMFdCV1pCSTFXVldSV3Rr?=
 =?utf-8?B?dkhac2VkNjFvOWo2SEk5Rk5TSGQ1V1pKMjdzaUJSc3ZqY1ZzaDRWRitUekhE?=
 =?utf-8?B?bytrZlM1YXkza3NkMzFwc3krblRESjhaYmRHbkhXQ2dRbERNcUVabXk4T2Q3?=
 =?utf-8?B?SnBsbXZSRFdnOFhkbUd3WjhidVlCbUpud3VFQkhhY1RDUEJsSnl3aHk5ei9J?=
 =?utf-8?B?b01CSG5JR3lseVVKUTNoV2dKZ2Z2dGQ2cldjczI1R1pNbmtGRHVCZkxPR3c2?=
 =?utf-8?B?UERkSUZaRWpXT1o1TG51dUh4NnAwT3lUWEZKdlVFNldOMXZnN0dTZTB5c1ZE?=
 =?utf-8?B?N0s5bjF5NDlpdXVNaWtuU0xkdmdMVU1sRERieEJqZ0EyREtwYVJ1RHcxOUMw?=
 =?utf-8?B?eHQ1V0FFY0dqOEVXcGpveEhRNVdOL0x0Z2pHZTkxb1hyVDN2YSt1bTIzWFc4?=
 =?utf-8?B?SHk5YzJlQ1pDWUJsczBIUmtwai9QSzE5OWJMNnhYODhQS3pjSUowWGY5NEhz?=
 =?utf-8?B?Tnl0MkJFbHdzeGs0YVgzVFFzMWxFQmFMMDJERkZ1ZDNpUFJiSGIrYkJhZHJJ?=
 =?utf-8?B?cHZIWG9NTGh4NWUwUGpERVliZml6dCt2SE4wVCtKY1JSWUlCYjBaRmRaaWlB?=
 =?utf-8?B?aWRmdE1jVkcwQXUydzdtakorc3Q2alJoZTI5Y2x3ZENyeDlIVENtVHBTeFZK?=
 =?utf-8?B?ejJhc0pIRC9iVjl4T3RDa3FoU0d0QUN3dmlTVTBKY0QrOVVVTEJQSTQvcHY5?=
 =?utf-8?B?bHZlWG1CK1hlaGU3NkhHQ0N4dEdUQ1dFUVRyZmR4SG56U1QrUUljSHdNc0tD?=
 =?utf-8?B?MzhVU2ovcUo1cUZ0dWJIWEd4ZndRb3ZnZlhKTVdwNWxJdUI1Qi9zamRQWG1u?=
 =?utf-8?B?UElSUTVvcTFUZG4wYXVZcTlFVldDZWxyQ3FHMmNIWmp5aUNRcGd0cjNFMGZ3?=
 =?utf-8?B?b0RaU3FPUHBZYVB1WFJ5ajBlZWpqNDNITENzOGk0RmJtdUZIUGtKNVZoOUt6?=
 =?utf-8?B?b2pORy82WEY0TTZCcVRpNUxvYzN3dS9rTnNhem5sbjJzM3NZYU1WRmdvUG5K?=
 =?utf-8?B?ZFBaWm9EemgzNU8yL3pmZWpoNERqdFAzTWtoVW4yTXJOT2YvTGNpcklocVJO?=
 =?utf-8?B?WjU3VEFkcVZMNmdRYS9YWWwzQWpzejdjWHBLVlo4Tm1STC82RDEwempGMkIr?=
 =?utf-8?B?WTd2Ti9ScUZkcDhLQUplMy9VcmZMeVRXQTRmaHB1RHlKVlA1bEFQS3huSnp1?=
 =?utf-8?B?Sjd0b25hNDRWSmV3bFFXWkwyOWxHd2hndnZoQlZlcDhOQURQTlJjTWowQ0xs?=
 =?utf-8?B?OHpJaXBYK29PRlpnS0hEWmQyVDVrYTRLWTYwYW9yVy9IYWdzTFVPQjJ2bzQx?=
 =?utf-8?B?clV3bWsxeFhVcEwrQU16dFhaSWFJT1lTakZzNlNiN3BJMjdzWlhhaUd6NWR5?=
 =?utf-8?Q?+ICpic+93v0Ov?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFVVSUpTL2oyck5CeGVZN0hjNDFVV2Nud05MSThlWXVJNWdhMXpOdWN3aGha?=
 =?utf-8?B?ZGdOWkhwLzdoVUxCVE1sZ2JhbjU3RnhSaElaVlNqWitHVjV3M1N1bTQzWEM3?=
 =?utf-8?B?Rlk3Q215UHRucHlqOEQybVQ1ZTZyL05CRmo2MVpJbHpzVEkxbHVnZE85TXhJ?=
 =?utf-8?B?S3VENmQybVRjYmYvSE5qa25nYlNUbWJwUTIrbXZrclYrUHBKandDVW5vWVZZ?=
 =?utf-8?B?dFVGajB3MkJMZzFBMk9kbHBrc1JNbGViMjhxMlhIanU0c0R1cG5MNnF1RkJs?=
 =?utf-8?B?bXNPbStJc0k3eGE4R1hzY2l1eDJUL016TnY5ZHlqakV3TzZUYzc0V3E1Wk4w?=
 =?utf-8?B?RGRyUVU0cFFlWUxtc2U4aVBKTEZQTW9Td2NZM1Vnc2E0clNJTU1ZZHowTnZi?=
 =?utf-8?B?SGFlZnAwaUVjMUExSE5ZZWN4Zm93WkRqaDFTTFZ2SUpqdW9aT0o4cEcrelEr?=
 =?utf-8?B?a0prM0JvWlB0dzcxbTJXdmNuVEErZUp5WHNicFRWVUcxUjZYMnk1cWhLNEhw?=
 =?utf-8?B?OWg2TVNLeTNxVS9Najd0bjVwQlhwL0dRSzdSR1BWTTJacndGcU1HcEthTXpm?=
 =?utf-8?B?ZURnbENwQVI5SUk0YTNyZm5jTUg1WUk3bDNQUUlTMDFjZmUvbHlPZ0d4d0Jo?=
 =?utf-8?B?VXRxS0ordlJjdEFRU0ZnMVpGdHlvdU9weEwyMXFzY3gyWW1uWmhsVWNnYUxw?=
 =?utf-8?B?d0NVSFhhdFA1c0lmZnNLWkVUaVlqakZ6NVRHOHMvVy8xQlBabXVrMzlsWFJK?=
 =?utf-8?B?em9SbDh3NklOSFp3ZWgxSG9HSWNWQ3FEVzNQRzQwRlp4dkdXUkdGSmhhdjRU?=
 =?utf-8?B?TkN0eDNyWVBZdjdkM1dzenQ4ZWRtVTI5V1VaVmNXcTRsbGlOOFFhQ3hGbmdR?=
 =?utf-8?B?S2dyOU1qSG16dHBtOXo3NXllS1NIZjBNTlo3djFVaSt4ZVBLcUEyVEFtdVpu?=
 =?utf-8?B?bVBRQ2Q1Sk1GR0RnNHRXcERIYnNhVk0zajBsUmNjMGRSNHREbzA5NGZJWG15?=
 =?utf-8?B?bW96SFNLOFdwaVR2MWRDZ2tZU3JVNEFqZnYxdmpoSW5xelpzY2h6M2RKc0FO?=
 =?utf-8?B?YytCMWRCanpIbysyc0lwSlFOVnFDOU5JZlozbUVob1BDTjNVci9oT216TkhI?=
 =?utf-8?B?UjN1VmIyMXV4cnNGOXJLaU03b0R4SFlLaDBjYkFKOE5YNDA5WXFOc1lFMXV2?=
 =?utf-8?B?UkxyZWl3Q3lESVQ3WmVUQmhGZERHWnQvM1BNbEJqUjQ0aUZUR3hNRVlZaHdV?=
 =?utf-8?B?WE9VaXNSdGNGWm9mR3NtR1I5Y3RoS3g4RTBBc3VmNlduS2RCb2gyNHU2NmpL?=
 =?utf-8?B?dmRNWjVHclRtb1Nla1oyMWY5L3c3UE41N0h1VGR6Y2tlenczZ1B4UjZGVHJY?=
 =?utf-8?B?QlNGYjBzRTRsdDdmQ0xhME5NS29LMEZqV2VoRkN1NFYwYjJhbWJXTFNRWEpW?=
 =?utf-8?B?MWluZERuQ0JkV0lZMXNMT0ZhdThXQ3NZSUpJL0tjZGdKK2RpN0E1THNyOWxL?=
 =?utf-8?B?UEhQY2lUQnZMWHptdDBQTk1KUzluc050b1V6OGdWWmRYeTlqZXdUcWhiWEhz?=
 =?utf-8?B?OCtCWWt1QllBUFZkS2xIV1NiYnVhQUFwNTFmcU40QUFtVDJXZnhUOXkzOEZO?=
 =?utf-8?B?L3hHdXZ5MlBSUFhlLytEQ0JCS2ZqM3BxRGg4ZlJwL3VvYVJDRVdKTVJ1Rzg4?=
 =?utf-8?B?b2pzT3JLYmZuelRmbXVVRTZWZmp6RkRLU0xjblBoL0VVZ3kyU2x1WERMZnhC?=
 =?utf-8?B?QlUydWVBZ1dSS3BERndhM1BJa0diQzdxTERDZzdzakRrTkNjQ1dQdWtHSEZs?=
 =?utf-8?B?aXI2SHQwWXU0NW5oOFc1R2dXaVVWbTlqNWxQVTJRZGdhRkM2STVHOWxLMXp6?=
 =?utf-8?B?U2VwcGUrUFFDY0dYNjZSeVlmR2lBckU4WGpCQnh3UHhJVEx2TGhaWndhdEM4?=
 =?utf-8?B?RkZkaDBqcjR1VnZWa0ZjRUVJK1lmOXdyanJsVURsRW9sTi9ZR0pjNUxRbWY4?=
 =?utf-8?B?WVk4ZEtpbzZNQzY0eWN6OSs2RlBXQ1FrNnRZaHE1MHU3ZEtDbHJtZFdlaUxk?=
 =?utf-8?B?QUt3T2Rpc1c5WHNZWnFLYzhSOHBNdDlvaWZKbENMM2srdEJCL1hBbmVkRHNG?=
 =?utf-8?Q?fcPg+EGbznkV1xU9p6WNZ4Ulm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b3d32a-7968-4eab-922b-08dcbc354bbe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 07:47:07.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rRGWibS7T8rEGqQdu6wM7H1pDM3oo7orrK2tzTIGulOayh0zlDsCZR7d8dog44CMTzaQIzs0FDvrHw2415SIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190


On 7/16/24 07:26, Li, Ming4 wrote:
> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising the opaque
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
>>   include/linux/cxl_accel_mem.h      |  1 +
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index e53646e9f2fb..b34d6259faf4 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl_accel_mem.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   	return cxl_setup_regs(map);
>>   }
>>   
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map);
>> +	if (rc)
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
>> +
> My first feeling is that above function should be provided by cxl_core rather than cxl_pci.
>
> Let's see if Dan has comments on that.


This has also been suggested by another reviewer, so I take it as an 
action for v3.

Thanks


>
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4554dd7cca76..10c4fb915278 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>>   	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>> +
>> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
>> +		pci_info(pci_dev, "CXL accel setup regs failed");
>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index daf46d41f59c..ca7af4a9cefc 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>>   void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>>   void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   			    enum accel_resource);
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   #endif
>

