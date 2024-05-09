Return-Path: <netdev+bounces-94780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6138C0A24
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3916D1F21FE1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02C13C3D9;
	Thu,  9 May 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNQcSakb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6813C3CC
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225228; cv=fail; b=H+QCAggUogTnLKU+ZmffGccSMlZs0US+HNoXWrbcsf8AoV37I37JN68rve1MVLHiruY/xwNHtsz5cGWykIxWvrFDgOBYXqRrTNo7/L7DG/QtMM5UgMALlB2nYwt1S2ZXu9YeTxPfy886PozIAemi2dh0z8q2lOEqdwTj07Kcsdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225228; c=relaxed/simple;
	bh=jPJZq9oB0tbT2egAQLrYDmEdYHGRRxyKwsTjkVG8MiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eG5FLJT9IC/6E2OuS8HmcaQ+2wNyIH/vTptx0pXVLfKGcJbFzVoBrZZ7J0RZHLW8A+mxEMcSs2NOzZUSGLXAJKQ8BWR9h3OK41WIDdrGObT/2Hm5ncOK8XkbcR9bhDEC9Au9qd3Ol6PLShLZSusnWV/1OUucPQo/pdtm8J/xR84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNQcSakb; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDG4vDN2wGTVr8iWX/iBI60rKxkembi8AI5I52XcY/8GuauDUNdf4ieuqwwb654VsnnfAAkopffxMlpIx1G3b+aPVi2cjzhw3NgAq+bhkc/VtTeI+6jzE9U+/yzt6Bv4CNQkEwpFgacs2r5YSdAqhiDhBF3QpcWGpT8CzCqya6BGS80hYf144cewb+EzXKvZY0I47jyivl57Ev3PbHN79FQ2bplpsFJrddzLO6pO/TA5C/n35Wn0C3N1txXIoOM2Ya8rmATwzsl1YHvfWvbgPrXV/btyVXp7sQGq1YpRxd7I4WgLbRnOp6j2DU3tMn8fbVjzk2ncMNO5Tom7nS1/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l6ZuMK9QIxvf64nZEZvh8xZ9eBRWETsMLiNSWxAU/Q=;
 b=IzPe6Vw/Tww1Wvdvsdby/u+MHFAJq/kMBRdiDgW0UNXZRmVMHq9ROpDhvimnouMVFzySZqf+DTUGFoTSK0efyrA6PdZyslUW8YbAMZCBdZ7C2vgCgssEhHTIIgTl6ZdYgZ4bqJPizRdUxqSCoOcluo/rjPKS3cBlNi5moJZn1jkS6NJUEW00euhqsZwkrpryRwlUCwP4/I3CL//SEB/rP8pYv904G835NDu+ZSHYuuQbi91bR4y6VVZwBJC1wsWyQSnGp9XtUI/vdjL7ZmpIpgGOsZLyPFYHmchq8gt0M1kyl1QOofZc4g3H3Fq9i6tlKmAUwMhGpHyesltYGG8KRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l6ZuMK9QIxvf64nZEZvh8xZ9eBRWETsMLiNSWxAU/Q=;
 b=CNQcSakbrcli7xNX3TfBDimCHtGQpnwcEAH6CIZ5j+7UQj+GzT598K6ikZSTU/8KUYmPJVOes63XABgsTdjzwUD/lgUy5ZN5yS6pOMpsDb9Nd7SpgFP2ZnEYOKGDwuWGZXNKk2zbk9/FK1ClhiuVr1u38T083UPugVVgcuStjbjNsC0C6MRIrpFBJUgoUe5gD5jIKd6IAYce+eV1YxWhN8opA7VX25IoymbWoY/oWpc1HuAc2pHxSsjJNHTnHk6F/WMoRaR5lmgAdEPOd2NPeKdm7rNIeVz0e5qkLWoBUJT6Hun/bLHLsEZ+IaHC41ye6yowc1TBWLys4Hh7s/kYtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 03:27:03 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb%5]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:27:03 +0000
Message-ID: <e4478663-bbae-40fa-bc85-bbd75e83a37c@nvidia.com>
Date: Wed, 8 May 2024 20:27:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 kuba@kernel.org
References: <20240506203207.1307971-1-witu@nvidia.com>
 <20240507212436.75c799ad@hermes.local>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240507212436.75c799ad@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 562217ce-6c21-4fde-4995-08dc6fd7e4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThrUlNFQkZIb01DYlBQdTErcjIyZTVKM01zbStKdWVlczQ5UWdHNE1HTkZt?=
 =?utf-8?B?UXhyVHhjbmRQQ0U4Uy9HQVFQMnM3cmowZHZsdmVRVGVheUd0SUlobWFrZk5M?=
 =?utf-8?B?L0JoZEN6dTJiYThVdUtKNWRKZ0U3LzlJYm1sK1I5VitRQytDdWo2ZDcyYXJp?=
 =?utf-8?B?ZEVsV2FqZjRyZ2RqTWpwelpBdU9tNytNd1ZiaENESDNNSHVnWUFrcHZibnRw?=
 =?utf-8?B?VEpXaUNqNnVnODY3aTU1a2lJTlFuQmpNWkFSdkFVSlA5cGVKVXQ3Q3NsOW5s?=
 =?utf-8?B?QTVyZFl0T0t5RGp4QjdpY29Lekd3SjBNTnRvTW5TajFTdDUxcTFaNFJabkpu?=
 =?utf-8?B?NFMrOFRJdDhqM1g2dHBhcHhlVXMyL05jV0dCVTlXWEY0eHRaUXIyWWFuS0w1?=
 =?utf-8?B?cVorNFJzblJub01CYWhrc2V0SU1nSS9yZTg3NzgzQ2pJOElzNTlqVjQ3ZmhX?=
 =?utf-8?B?dlJWdXJ0L21rWG9RdHY1QzhiT1hJUWYyMHNRUVhBNkRVRHJ0N0plbWI0THRL?=
 =?utf-8?B?cVV3WXN5N0gzSXJGVXFpUkxOaXRkUk5rc1lTYnRHOXBmYTZFU0t6dWZjaTVB?=
 =?utf-8?B?ZnQxU3pQdG95dG12SE1yYy9mVk5KYlgrdDF1MHk1SVBocG5UNEhBL3VQblBn?=
 =?utf-8?B?WllhMWJmVGRKTHFXbUpIY1NIL2F0Wld6NjRBMkE1K204bDc1KzliOTB0L2NS?=
 =?utf-8?B?bW1ndlBMTXpqN3k4SXZtZXY1ZG05a3NyYWpkcjUzaTZRY21wSlVudHIvc0tV?=
 =?utf-8?B?SjByUk8xS0RUbU10My9xWmtVREZhQ3QzT2pnNmY0ZGVXTC9yYy9RTUlKVU5i?=
 =?utf-8?B?QWVpU2RNWUxWdkwxbk1MQ1Ixcm51VVQrMnFuWGl0T0I4TnhBcmxGc0FHN3Uv?=
 =?utf-8?B?Z0hDTWZOd0NnTmM3OEFlMlc2bjBEU2t3b0FLOVBsSXYxNHFMd3ZNeURPVzBj?=
 =?utf-8?B?ZFZNV29aWldtZkFmbE9EUStrbXVPSDRSVFpaMkswMCtNSCs0dnc2TTdSWlhJ?=
 =?utf-8?B?VldnT1E0R0JaMDJwUGxCU2U5dm0rRGZlSnRKR3RqUGJ4d3ZNM0JpYmd6TWov?=
 =?utf-8?B?eUl1aU1PZG5hTnZpZkJWSTdkSW0yM1FSUVBLcDhoc0xEUlFrV0xjL29zbVJa?=
 =?utf-8?B?NU8xMEhaRk8xSlFJKzQ4R2JIbXVDeEp1WGZmcmYwNkU0RGJyQ3MxeHpqLzl3?=
 =?utf-8?B?YjU2YWVCQ3JLcEF5bTR3M3FVWU9lVmtlZjhmS1NRVytIMUFraFZZZzJzNmIy?=
 =?utf-8?B?SmhOUW1VQkIzL1pmUkZ3QTFlZ3RLajQ2eVJkWFQxWmFMR1F6ejQ0dTBoVGkx?=
 =?utf-8?B?VXl1VkoxUk5xa2c1VjI4RVUzeXdmOUxkN0h6di9FeEF2N1hEVlp2aEFKUCtr?=
 =?utf-8?B?UmZLU29jcHorL3FLdDY4VXZ4elh4MDMyVER4M0JJSzJNd0pBaVh0MU5rZ1RW?=
 =?utf-8?B?TXQxWnNCRGVoWER3cjFhbHRSdTg1VXpSTFBiU29ibWJVZzhKZ0taSFUwTkda?=
 =?utf-8?B?M1NZNlpNaTJTMk9ROCsrSk55Y1J1WVBudVBETnY3OVl2bU5lb2IwNkJIeWht?=
 =?utf-8?B?eEMwOVU0R3pUMVNmMFVCa09xRk1zVSt3VzE3b29zbEFaWHJmcnpKM3hHbEMw?=
 =?utf-8?B?VVJtenZWY3RseEh2a3VWeDJmaGxMckJtekZoaVpPR2V4Um52T3dHeUJoY2lK?=
 =?utf-8?B?S2dzZzUwZzVCcEoyNFhXUEQ5UG9uci9tY3Y4Q24xKzBJM211VTNtZnVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UCtHSHZOYjdXUHZoRmpocVpQZTd5cXpJRWVkSjJaUWZ4Q0lhb2pmanZzWStJ?=
 =?utf-8?B?TloyMFlOMk5EaGlic0pqSEgzaFVuY21aOHFRMXROdU5XNEQ5SUNMeFlNSWZo?=
 =?utf-8?B?WGRDN05kRWxwN3ZoeDJoWFNPUDRGcjk2SlAvOHhlaUF0ZzFOT2RDanBRbXNr?=
 =?utf-8?B?SEtCK2R0ZVlGV25RSjhvTUhhWU9LOVdDYk54VFEwQmFFWU9LcEphczlocS9K?=
 =?utf-8?B?KzJ0SG41RDhFVmZ5NXFKMlM1SWhTZHhUbVFvNkxWU0M1bUdlZnZjcjB0OUtH?=
 =?utf-8?B?ZVN1b0VlQkhEZFF4dXVGZk1zRGdERGU0SGpvWjZ6bkU0T3NJdUZmK2JQT3Rs?=
 =?utf-8?B?dHRlaFArdWFGWmtlaGVoREVLaXhTdUdpUlRuVnlieVE2MlFzNEV4enBwR3hy?=
 =?utf-8?B?d3R2NTdKTVFIdmhOWmJkMTJncXgxWndGNWtYMW81eDFzYzZyMGtDWlRIRGl2?=
 =?utf-8?B?RnVoTTNJMkV4TGlxa1ZyR3ZIZklEemJrWnl6Q2xzU3FmRlFRNmZ3WElUTU1o?=
 =?utf-8?B?aXJaWXFVclM4Znc4bmsza2pvbkZCdWNIWGwwSmtldmVLRVQzeEF4Z3RiUUI3?=
 =?utf-8?B?Z2srTWtpQ0xqRGdxeFFHcDRnWk90bGRVcElibnpaZkt3K1B6RHVROEFjVVhk?=
 =?utf-8?B?V1FmMUUvSXhpV3VBbCtDQ1Q4SzhmTHZKQWx4eS9sVWZmWEVKNElWaEx3QVZL?=
 =?utf-8?B?MWpEY2QxVm01djBoZXVINm9wQ2Ztemd0bFFweTVpVUlPZkN5UWluSTRxNE8r?=
 =?utf-8?B?SXJEWnVGQjdmczBrRnd2a1BnTkk3NnNzY1kvMXFLL08yRHptR1BKQUFkWi9n?=
 =?utf-8?B?OHM1a01QMDVLT0NWbE4yUUNPcHFkN3grbUFjSEpYWGRUVWEvSjVOTjhPUUJw?=
 =?utf-8?B?RkVia3A1NWk1RXpMVlFkZWgzdWoyb096a1JPQUtVcklwdEU5eDJXYWdDejZ6?=
 =?utf-8?B?NVlldzBiYVNHQUNac3huM3l4dXpVUUhrcHVCdEY5d3dTc3ZlYk81Uk92dEd1?=
 =?utf-8?B?T2d3cTNhNkJjSEgxK0R0ZTZJUlJrQ3JCblpHM1g1aC9JcGIwTnBxSWNZYUc0?=
 =?utf-8?B?T2hYcWlqc0Fvd1MybjlaK0lZVVZ3TFMvTFRwWXJubkpXeE5LTmFoR09WM1Zp?=
 =?utf-8?B?MGFnWkhvNUNmMlRRTTJIT0dZbGZtWU5oZnFaNlMrRC9xM1FtZURyRW5lRE5i?=
 =?utf-8?B?RUc2SjkvemFTM2MwQ1NybGp4d21ONCt5NCtaKzhRbEtpcDhRNDVQTlFRNCtE?=
 =?utf-8?B?WTEwOC9QWXdmRFRqcmEvcVlnSlA2cFF5V3l0S3h1aFpaRkIzSnNQaXhBM1RU?=
 =?utf-8?B?L0tSdHY1RE40NHBJZ3VKejQ4c3JnL3BMQ2M1NU1jRndFOWdSRENFZG1QTHgv?=
 =?utf-8?B?UGJiV1VEb1BwWVVETFVtbVNKN2pxL3NyRWdPUk9SZzZmaXZia3ZDVGJONnF2?=
 =?utf-8?B?d3hUQk1GS1dTY2o5TFdZYkNWR0dFQXJNOW9kUHRPb1RJMCtjSEtpOTRzZkZY?=
 =?utf-8?B?alZOOVl1SzJSOUYycy9wK1p4SEpDVGt3djFOZUhyOGU5TzNkMFIxTFFvOUYr?=
 =?utf-8?B?UjI2NTYzOFFjQVN5Nko5OWRmU1pXL2pGWEU4YXIzU0hJczNHUi81T3dKTE9q?=
 =?utf-8?B?VWloUmVLOEpKK1ZyUHphOTQ5SUEvaGpRT1FobnhHZ2tGNjAxQjh5bDZxM2Ix?=
 =?utf-8?B?TTBsTGd6b2lQNXhaMmoyNXd3a1U1RCsvYkpVNkdDMGQ3TlRYSm5UT25oekc3?=
 =?utf-8?B?MFM1eE5DOHlSRDdJNlBTUjJ5LzlnMDUvVnd4aTJLS01ocWthZk5kbXZHTU11?=
 =?utf-8?B?eGZXRDFhWm5nSm42cE0rM2lTTUNMMDBGWE90YzFoTllrRExBc01QbFdlRzRv?=
 =?utf-8?B?b1lTQ1FuTDRQQzNDWGZhYWpsTjJQV0IvaENUQnBRT1dTUFlGV2VHOFZxL3VE?=
 =?utf-8?B?SWdXUG01eFRZUS9STEphVkhiM0VHOXRJdjRScGxmZ1ZHaDVUUzVPSmcyeURP?=
 =?utf-8?B?OWdsTE9CcWtybWVkRWFEQ2ZBQ2xVL2crWGVqeGw0RmNVaXo1OWRBRHk2Q084?=
 =?utf-8?B?b1ZqRjlSaEdSaDBHVC84QU14V3M4QVNvZzRDS2s1eG9rVTc4SElNQVZ2aldZ?=
 =?utf-8?Q?Ro9oxSytOTQgzBKEzHIMenLrK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562217ce-6c21-4fde-4995-08dc6fd7e4e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:27:03.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 984EAtzpUoun6+ls0bWx+1k/L2D3mCmu4VwAV2J0c51L0QFvgaMaaczQIyJa0DeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119



On 5/7/24 9:24 PM, Stephen Hemminger wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 6 May 2024 20:32:07 +0000
> William Tu <witu@nvidia.com> wrote:
>
>> When a system has around 1000 netdevs, adding the 1001st device becomes
>> very slow. The devlink command to create an SF
>>    $ devlink port add pci/0000:03:00.0 flavour pcisf \
>>      pfnum 0 sfnum 1001
>> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
>> spent on __dev_alloc_name() [1].
>>
>> The reason is that devlink first requests for next available "eth%d".
>> And __dev_alloc_name will scan all existing netdev to match on "ethN",
>> set N to a 'inuse' bitmap, and find/return next available number,
>> in our case eth0.
>>
>> And later on based on udev rule, we renamed it from eth0 to
>> "en3f0pf0sf1001" and with altname below
>>    14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>>        altname enp3s0f0npf0sf1001
>>
>> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
>> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
>> through all existing netdev and try to build the 'inuse' bitmap of
>> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
>> every time.
>>
>> I want to see if it makes sense to save/cache the result, or is there
>> any way to not go through the 'eth%d' pattern search. The RFC patch
>> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
>> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
>> scanning all existing netdevs.
>>
>> Note: code is working just for quick performance benchmark, and still
>> missing lots of stuff. Using hlist seems to overkill, as I think
>> we only have few patterns
>> $ git grep alloc_netdev drivers/ net/ | grep %d
>>
>> 1. https://github.com/williamtu/net-next/issues/1
>>
>> Signed-off-by: William Tu <witu@nvidia.com>
Hi Stephen,
Thanks for your feedback.
> Actual patch is bit of a mess, with commented out code, leftover printks,
> random whitespace changes. Please fix that.
Yes, working on it.
>
> The issue is that bitmap gets to be large and adds bloat to embedded devices.
the bitmap size is fixed (8*PAGE_SIZE), set_bit is also fast. It's just 
that for each new device, we always re-scan all existing netdevs, set 
bit map, and then free the bitmap.
>
> Perhaps you could either force devlink to use the same device each time (eth0)
> if it is going to be renamed anyway.
It is working like that now (with udev) in my slow environment. So it's 
always getting eth0, (because bitmap is all 0s), and udev renames it to 
enp0xxx. Then next time rescan and since eth0 is still available, 
__dev_alloc_name still returns eth0, and udev renames it again, and next 
device creations follows the same, and the time to rescan gets longer 
and longer.

Regards,
William


