Return-Path: <netdev+bounces-86716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4398A0092
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948C8B229A8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AC18130E;
	Wed, 10 Apr 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zfs8kytn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EC17F370
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777315; cv=fail; b=T11IkqUULuxeYRx4zLSloRcikvX3V/wP27yzbb64cktljHoFqVQ0QmsI9nsyCWwmkvToGexrr1L61w5FIZB2WSkbx2CdlQjMt9n2arnMgEc1OZ0HZHu2MO3gkm7Qe2qJaos4DGJqrn0wzhWxcYoA7fHbLgQZIyVKwaKwFEhLEyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777315; c=relaxed/simple;
	bh=3uJvk/J89cKJ8u0ylsmQKGjYx99uLKOpabxjLOTRBuA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hB4zsaZDvMZvOZbJ6thWD8dT7SD8SGdNZUMfbsemII6C35jhCe0TFvShoW+OA+Wg6z31RCQevxjsE0S+E2zfAaV5ffXC2uNk4i5YTQuncelX9D3VDX3MM8g/HXDDI0qR/1pgTAoZlx4PKO6dO0SiDe18VbjKgvC6Xy+wUxfYClI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zfs8kytn; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712777314; x=1744313314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3uJvk/J89cKJ8u0ylsmQKGjYx99uLKOpabxjLOTRBuA=;
  b=Zfs8kytnabIthXB71QJj2e5OtDPTMeJA9R+lUBV15UB4rivmHFBF587/
   Y7MvSRPSCOWnyYgnvF/RqbZrnYpUo560HM64GExmHUfqjxDQXRhceTTXK
   Ek/SiAcRCq7ZNM6usN+XLaqO2sXhT03AD34jcWIYQq4CxSRfZQPmZY0Xz
   su943R/kVhsXnrnGrdkUPl8o6yZOBfLuNbnT5kqZPu/i8C0HYAfVPeTla
   +lVru/TxD50wBRgnZNWXXsGS7Rp2lwLsZA+2UbUwPIUzIoSI/W7slglsn
   qzfi60jlWlkw1KSn2QvceKUfgNo3IvduIVpNK0Tn0QLIX3vCpb3bzEvOz
   A==;
X-CSE-ConnectionGUID: VdT8LAltQdWjmXMMn7vQAQ==
X-CSE-MsgGUID: epMt8YFBR0uHLN04UTW8rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18766790"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18766790"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 12:28:32 -0700
X-CSE-ConnectionGUID: 3HK+FXb+RHScmIxiRaS4tw==
X-CSE-MsgGUID: axm1HmXiT1KsZJ1k5EPKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="58085657"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 12:28:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 12:28:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 12:28:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 12:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXU8ASto0cu9ZM4MOwETXLRlCz8638hjdQ953yoHxG817rbLfqF0ZCxJMvFIJvfJvmtWh4OGh0p9k4kiFiTu7MgJD2rVi0oq5DEcxEy6mXkxajiaMIisY7HLa2Xfp+0F1S2cW4se35aVHU4h8ip3Y7RKp6PrcM4inM4c/miPraFzEeY6dh7c/23nfatdDs2a1feNx6P/ayhV0wZvxit41alJWPLpxwXI/V68M/Pj0LYeo70ns0J4yE4yNP98L9DXDKkmjis7bUgwa2t2WFU64fTkzmjjw+QDDxJ80qb39lA/R6Uc3YTvVQo01IT7uEM7vc1v3W8S5pstl0mExTZx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8B6S2pQyr1vU8zFBm/lLJ7rsN1zAmz/0DQPZ1MVWls=;
 b=S8trFxp8kiSO8ADNjqZ7eY/54Cp1DjZ9VVGlLXyP70fDMmUz1iwm5dSha4BNn2VPF3e6H4PCi+kHg5VGitvRKhmsxvfVSOm8xYOC0vmb/Vn36rerHQzjOLis9nWLnB2UOHwt8Qx82h4VwXxrVKdQ8rSqu9rTAS4QEmoluPnHfiQSo0zfvTP851C10ky9C7bw8xaqUAEo4AMFKg6AECeRlC+KnUp34lSeIwdqtI4si+2GhsnhVTAlFTYm7OG/QYHp+O3CYVWkRrAANXap82E42iqakIH/Om2oBovyzJviQxOVzCjayllhnja6VJay7AD5B8fc4L4WDeC+9Hv1GAZ8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 19:28:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 19:28:28 +0000
Message-ID: <23709427-23c9-46e9-ae47-ead1ba5ab22c@intel.com>
Date: Wed, 10 Apr 2024 12:28:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] bnxt_en: Change MSIX/NQs allocation policy
To: Michael Chan <michael.chan@broadcom.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-6-michael.chan@broadcom.com>
 <7f4f5a1f-1320-4082-bfe2-6b1eb422e37b@intel.com>
 <CACKFLi=m1jKw18p7QnZ3FV1Bg+5quQ8pt3gEYrZfmaS8+8Ptiw@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CACKFLi=m1jKw18p7QnZ3FV1Bg+5quQ8pt3gEYrZfmaS8+8Ptiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4671:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LK5PScPLGHiKz0l5Y0/NK2Zx5nfoecIZfdjrQ5GGz0JsQNmuHAEsUcuetd5axqgGcvE9e8ZQ0W/5FPmtr1PnK3V+B1lTmaWqNhld03Ti8/X6DOUy8hjztD49idwdIVQPRPIjY3Gvg1IxI3x3xNv2CE20kBp4FKEINTL+aLra73VjyhTV9Py6COJZ+VR/sJfsSJpf5Y9EDlPlW2jWX8dv7yM1a2fZMfeUKAI62jHdciNBMcOzG05q2NAHE+wyXepEYPAqhrDVFA/cjQxFzEdk8RyKmc2Dz8YJlsM+ULr7vhREgiGyUsOg7pDL++UR6iwfImRjGYA/roQjiGiJ+v+R+6zVaNW2iTXr06GsvBBEotnYjgKYHPDzQn0V7Qyual6DnJ8jo0/U1/HmOleyPOdE6ISMkRX4fLZBEk5m6j9AanydR8PSYr75865wWKA7LJAEIEf2WVpOXK7P6UxcY4Ud3+o/Bfemnsg/tpMN6uVjM903Xt/ySea1FFcwSUK7VANPRoihyI4MrRXUULmClyq6QTrR+80Y3Bh/pw/V/JfVq1LcX+Y6pzLCmlyBQqFuyKcemPRP1gy8c9S19rdt0Z3e5mPfTwgNPVoEkGpVw83h1Vr3rb522BfFI3zlxtQaBbHjfyWyAn1iLVEDRLPfA6JMVuA+6wcqKU5J1PGjv7+Nynk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNuSlpsRmhYQUFVRzI3ckMrQVJia3pSMm55T3BFVzUrTWhpRzQyNk1FbUZK?=
 =?utf-8?B?ZitKM2FLdncyNExpWWk5T2RYYzIrdEZoRnpuYVV3UlhVdDlUNWtXYUJkMW81?=
 =?utf-8?B?d3krZndxV1pOODJFaTFWSDNTenVlQTF2cStmUzJUYU9lSXoxV3FCMGh2MTQr?=
 =?utf-8?B?b2Z5TktUYkJkSTR0TlBQTGVSUTFwaXYyWm53YlIzOXBoSCtodG0rMXFCUWlD?=
 =?utf-8?B?VStCTVhCcGsrWHBTR1NpWHM2N1E2bUFrcXBwODJXVGRrNGU2Y3FOWCtYWEY3?=
 =?utf-8?B?YzFOV0FJcDBpMysyODcyWi9BWk9na1dsTTZJQlJNbUFuU2pvbVpwWmVDTGo5?=
 =?utf-8?B?a3BtaVpRaS9aRS92OS92WVVWWWFQeUJ0N0lzVExlNWg4Z2ZwK285bFM0cXBt?=
 =?utf-8?B?Q3FESUl0VUtaemwrdUxXdktiSUNPWld2eXEyV0hlN09RcFdWKzlOdllvU2FL?=
 =?utf-8?B?MmZ6SFB3OTVCY1p1dzBoY1hYRXRVeFJ4dENmQnVac1hqTmJtOXpXZEFqaDFV?=
 =?utf-8?B?TzFWNlVUNVY1UWVIWVZqbUVBSjRSNmt5NksxZ3FnKzIxcW9qb0hFek55Szc1?=
 =?utf-8?B?aStRdEFuK3U5MGpLTFNJeUNiSXdRNzNiWDhENVc5aDYzQzJVeVljWlc1cVE2?=
 =?utf-8?B?VmkydDdCVTJPeG9uRWE5Mk05Z3g0WmJIK1RROGFBQUxRL2Z3VkE4VysxWnhS?=
 =?utf-8?B?Mmgyalo4aWJNODh2UTExMXNSYWNqWGtVWnB2MU5Yb2NsWUdvMk9RVmZGTXhM?=
 =?utf-8?B?b3ZxMW95VU1BVlN2TSsxTjQ4RDYxZWpZZU1QZ1ZwZ1pORys2V2FVeGJOT0pL?=
 =?utf-8?B?WlE5STZxVU8yZVhMd1U0YTB1eE4zNE1XV3ZVdlVTOVltaXQvMk5VQ1UvQjZn?=
 =?utf-8?B?bkZNblZqeUpaZzE0ZVp2SUFoYjZDVkVxZm5qL0ZvZWlYcXhMZzRIQjlBR2Nn?=
 =?utf-8?B?ajFGOVdxOE9VYlF0TDVIOFEzeHFnTlJRKzUyZnZYL2RScXJDYmZOb0ZQclZX?=
 =?utf-8?B?V2dud3pQTEpGSldoT3NCRUlYTE5GSmR5SjQ2dUtKQVJjNzhrMmc3a0IzUTJx?=
 =?utf-8?B?Mi84Sy82clN2b3ZtUW9zNjBvRUZRQ0FLWFRYRG9RK0VFbi8rdUhHbDEyQm5m?=
 =?utf-8?B?NzBuR0R4WkY2VUFvakV1cklKS05qaldCVW5LWW85YWpvQndhVFQ0cE4zTml3?=
 =?utf-8?B?QTBobU9SZ0EvYzhsTDNRc2xIY2k4d0hibmFXcEx1TUpPT0pjQlc2cS9ORHpj?=
 =?utf-8?B?MmI4dloxcDV3eUV3TW9TY2RoNGJ5TXRuczdWeUJzckgyMk5aU0o5VllPZGJs?=
 =?utf-8?B?YWhHNC9yaDRaS0phdXIxMXFSU05IQmU1U3E3Y2Q2d283WVV1aHk1a1I3T09X?=
 =?utf-8?B?dzdST2ZyWXAyV3B6dVBNcU9ORVMyWlU2azVqZG13VnI4ZGJNMGVneWJIMDJ6?=
 =?utf-8?B?bGN0cEVJT3BEMkovZmFGZGU3cmplc29VQ0l4UVdtTHhvNUlhby9sVnV0dUlp?=
 =?utf-8?B?S1YrWHpBQWlHNzFSS1dYSE5oU1kvL25hZXlhcjZJMTBBZEh0b0NnVUJRemlz?=
 =?utf-8?B?OUl0alNhck5hUFVGYXhaU1dJVWZTekR2blJsQ3pWZHA3NnhsTjNTQ1AzWk82?=
 =?utf-8?B?M0dTTVJqRmN3dG1ZMDNXcitqU29JeDRPU1VEUlZEY1QzMldmMUZmYUFkYkZS?=
 =?utf-8?B?YW56T3c2RFB2SVFJaG5KbG1QNDF5NmRzUmx6eE9XS2RVdTEvREM1Y2luVXZj?=
 =?utf-8?B?MC9tUCtQOUFCZGRtbWVmTjFYRnRlN1ZDUUdXbGE2TzM3b3A4VnN2dUhVcTZJ?=
 =?utf-8?B?Q1FKbjZhMUNvQ2V3VENNaElVa09RNG5UQTB2QWNEelJjb0MrOTRpRmduM0tj?=
 =?utf-8?B?RlljcmVTTS9HTGsrWWtQTGhFRmdmYzR6STZTaFBxd3pMUGg3WWhtVVFGWCtY?=
 =?utf-8?B?aktIZ3hQTGxyb3p0NFV4YVc3dy9QOURLeFBIMW5UV0ZuZERCZHFWYUJGSXZn?=
 =?utf-8?B?MGFja0g0OFJqNTltK2VHYVlTemJwS2NDQlNDRlNKTkVCckdJWnRTTVBQbEcv?=
 =?utf-8?B?TUY0cjR6RElQTWplVWEwb1hLSmtuZ1h3bkhGQ1NsVWZBUDBudW95czVtanlT?=
 =?utf-8?B?M2tWUTRJUXVraHYzMTI5UXlySjNoV011YnZJZ3FtWGdWQ0VuWmQ2OG9IeENK?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a7a88-694e-41db-0799-08dc59946641
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:28:28.6707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8RsqJls5oJ614pitUJg76msz7YgwA1BoguG45KNkaan0Z3CZ2/U9YYlKUN9S5OrE9DGoXAsCWWOgSSA515xwElK/71T5efJ87mAMgf2GHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com



On 4/9/2024 4:48 PM, Michael Chan wrote:
> On Tue, Apr 9, 2024 at 4:40 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>>
>>
>> On 4/9/2024 2:54 PM, Michael Chan wrote:
>>> From: Vikas Gupta <vikas.gupta@broadcom.com>
>>>
>>> The existing scheme sets aside a number of MSIX/NQs for the RoCE
>>> driver whether the RoCE driver is registered or not.  This scheme
>>> is not flexible and limits the resources available for the L2 rings
>>> if RoCE is never used.
>>>
>>> Modify the scheme so that the RoCE MSIX/NQs can be used by the L2
>>> driver if they are not used for RoCE.  The MSIX/NQs are now
>>> represented by 3 fields.  bp->ulp_num_msix_want contains the
>>> desired default value, edev->ulp_num_msix_vec contains the
>>> available value (but not necessarily in use), and
>>> ulp_tbl->msix_requested contains the actual value in use by RoCE.
>>>
>>> The L2 driver can dip into edev->ulp_num_msix_vec if necessary.
>>>
>>> We need to add rtnl_lock() back in bnxt_register_dev() and
>>> bnxt_unregister_dev() to synchronize the MSIX usage between L2 and
>>> RoCE.
>>>
>>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>>> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
>>> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>>> ---
>>
>> Whats the behavior if the L2 driver dips into this pool and then RoCE is
>> enabled later?
> 
> Thanks for the review.  If the user increases the L2 rings or enables
> XDP which will cause the driver to allocate a new set of XDP TX rings,
> it can now use the RoCE MSIX if needed and if they are not in use.
> 
>>
>> I guess RoCE would fail to get the resources it needs, but then system
>> administrator could re-configure the L2 device to use fewer resources?
> 
> If the above simply reduces the RoCE MSIX, the RoCE driver can still
> operate with fewer MSIX.  If the above has reduced the MSIX below the
> minimum required for RoCE, then RoCE will fail to initialize.  At that
> point, the user can reduce the L2 rings and reload the RoCE driver.

Sensible behavior. Thanks for the detailed explanation

-Jake

