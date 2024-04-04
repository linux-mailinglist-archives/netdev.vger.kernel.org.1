Return-Path: <netdev+bounces-84825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7678898730
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621081F28787
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C971272CB;
	Thu,  4 Apr 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efjYofd0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70D127B40
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233216; cv=fail; b=KLtyRzaNm43A78AadWelrAgMr+E9/ER7CBg9/jrn29Ie5WkqfWxKpBjG7OwLacUzFKf4CEsnByd79T8irOsGHKnEMJhF+aqBSpErAtDDsFWugFjC0e3LO2ufLK/zZ67uAnNU1oRICSOLQCfvillpmCI6cQDVtsZ+8FDiTTbPTtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233216; c=relaxed/simple;
	bh=ACwKl6s97rC5kT2RO44BRfpAc+sEWvgqBmlCY/XFLpU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tAA0roLktKmSZUqyUkmv5qIMZxcuc01Gjd/p2RVeEVCmE9BH24ssXeADhKIulgBRrJ0m40x0UvkTZLvgPuyHzcC6hKBgSJIWijAESpE6p0WqtaSd4Cm23nprvx7TmV76BLL1EcwRq7lNX+vUkuJZCvzaFCqEQ+Mhjp1N0XgyPPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efjYofd0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233211; x=1743769211;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACwKl6s97rC5kT2RO44BRfpAc+sEWvgqBmlCY/XFLpU=;
  b=efjYofd0IIpAxPNUpVr0BmqnLZvQGH4XtwviEAWKlNnwhEsM5usPanFX
   TailGJaNYNv2WkYOIJSVpUNCJHKXY+ky452eCxjUK27/CrTXl9Soyn31t
   bbg0XrrBzYAr1SrqTj53B2MkurVCVdrQt7rZb7RNRKeDiQPAcbHbQsuiK
   fPIZrdZnMkghrFtekcxei+uipo60esFi5k4e661kytKsoC5oiKClUQTUi
   YFWesTpj7jRghrk2rckD38zS8eGE94wk7uvL36YVQN3PgZKdzqlz61AYo
   yUmNkPxNDH0TxZqXLLEitRh/Wdwcxk101dOfr+/5h8JZ6257HmfbQNDrU
   Q==;
X-CSE-ConnectionGUID: u7zki12DQGq84Y7wxggbNw==
X-CSE-MsgGUID: w6XYmpl6RVyK/+v3GqZp3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7675373"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7675373"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:19:35 -0700
X-CSE-ConnectionGUID: Bzsjov99S2mMsvmjmAGqCg==
X-CSE-MsgGUID: lj8iSlnbSA2czdy8fyiB1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23458102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 05:19:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:19:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:19:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 05:19:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 05:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCJCGGpubTMw18he8GwiJVHk6yZfNHFSmNkTbJAbBcSkGV1xv9/VD+N+2pDt1JueadHFjofI8pXd7EJbgtJeni6Zi50JqXe6Frp3nHewuFN2lkM76QD9YrhUBACYuv/6xAiTaMRUh7/Rhd7CrT3xMiFN64aXwvUyyBrKfLfA885N5bakCSoULD2vzB3fOIU50Cv7my2dbpU61e0ZTmwP71M0FxOHfB9JXVohY+QjEFVbEuL/AtNagh7YlM3E72miCuJha8wP4sPD4ZDhhNLoqe7oGsBnG9m2mSijKeqxc69dvq4wGQ9G1S17XdVHayXBDoPZNUjl5po8bB7cM4wZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9Ii34nKmfAt1LQxSWvk8xbamgGzXhwmcOovr2KIaWQ=;
 b=Pl403Z3E3TsTArMgCkav64hckpJLVxv0MEhKanFDwfDe+hYdKg3Xf5QjRc6KHdOnpZZLwjQI9KCReorduGgfUqHT1y0ig/TtOSdY3Lwz4LNmC1wcBuRPR1wxJjzUatDJaaAkYFz660h38IDCIGob8KUp3eg6DAgU1neYds5AByfujhKY8kgTMGXClCGekEp9ImHgvpxg0wQTPK8Vvf9rkKCz4y7cQa3TuAmxbw84dZO9vfZhZ2l70a5v+S4+4vpG25lHwgIuFyjFlfELrHvBIesWUiyVWjlxCuqb0zueE5xgv5j864xWEj7PCbO9/ccyrm3qkqXwVNbs0etukoZ+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 12:19:30 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ac3:a242:4abe:a665%4]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 12:19:30 +0000
Message-ID: <35c5df1f-114e-48f8-8ad2-ceb0b2e6efa1@intel.com>
Date: Thu, 4 Apr 2024 14:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<idosch@nvidia.com>, <przemyslaw.kitszel@intel.com>,
	<marcin.szycik@linux.intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329092321.16843-3-wojciech.drewek@intel.com>
 <20240329152954.26a7ce75@kernel.org>
 <f7c6264e-9a16-4232-aba2-fde91eb51fb7@intel.com>
 <20240402073421.2528ce4f@kernel.org>
 <348ead57-cdb8-4db7-a3d7-e8053a5f00c1@intel.com>
 <20240403171825.31d6867a@kernel.org>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240403171825.31d6867a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ2PR11MB8497:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGk8hL39DUW7NVP1gksoCCExlZ2npWszevaPAEFr5V2gnUwr8PRYiVZIyfumBUKmTofGmSGDIHEU7k85EIccts3Q1m74yB3G2fGgjKwrknLijcgtOlna8ESNChXiFXjCkIP3bL5nPkVw4HEDpNJxN6qNE8WKFrGRjT+WmQNhzpcCyNz1lKEGHgL9+dm8zVoJqxoYMLNxqDJKjGC/QvxVROvuNgPPz0mcnc+zvp8EsNKXSEi4hnSl/6nzRGrvVaa+e+mFOQ49+AuELqUc2xfBQcC0RgEq1WR5z0Z8tfJnGsTzsUrZT61iA5C2N/K9Y9I6Vzjq/uojtuY/5S8dxMfReMnD5OX8NFIKZDk7A0cCnPwIZrB5R1dpXkwyujK6hc4R7G7Rl6jqDvlSKaSqSdWz67vvrLG0fdAq6pwK15lKKH6vr6I7WZ7KpXEWRXaaEQsjBjVvjhDDCWVMLxFj5cwWFU8lLsmrMKGHzIF2g1Uhdg2uElKgpw2mrhN8uDcsYM/rSD/QlH0pJInrkU9BqQtRJ9Nbv7suyvF8JUpmuFBXmc8IgU+9uLqFmoQRtbxUc3eKmT71lqOgop5ova0pCGcPDDvrDiRjivBFIpXW/d8W8Y+PoYx/EFzLX6AGWFvxL4RZ1igft2SuVGXri+32uPCBtVIU3jel6jQL/sALfhbA7YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRHUW9aOGRFekhtUjRqeHo5WVR6UCtKUnVEMURPWFIxWktwREtmR3pCT1p6?=
 =?utf-8?B?VnYxTzFFQ3dlUzZqUkJnMDAzZWJDV0RnZ1NiaEdCSmxkeVJaU2c4djAvSWp1?=
 =?utf-8?B?K2VGWVJKYjFvZDZyRDdRMEFQMXVzWXVDU0FXNnJ0RGtnNkE5alAwVUlsRmh1?=
 =?utf-8?B?Z3NBYUpVWmx4Rnp4Rzc1dmJIVVhCcUdDOHBnQisvWW5jbXErS2xNdTF3TTcx?=
 =?utf-8?B?b05vTjlBMmpXWDROV3VhUmpQZDJMZkVQVld1UkhPaytNdThRd0ZHTlAzdzNi?=
 =?utf-8?B?QTFNUEVxZ09GbCtOMUgxWWZHTWJmSkhSSjVvZmM0WjlTZk9Ddi9UZDJQSnYr?=
 =?utf-8?B?dFhtUWNMcXRHc3V3dkFQQ2Z6bTcrSXhDKzFaQnlnVGx1VFQwZk5VQ1NJSEx6?=
 =?utf-8?B?OGpSdkwzLzIxS1Z1T1habTBxcnBuMThHNU9LRjFnWndIUEpxNW45ei85Zng3?=
 =?utf-8?B?Tk01azNPNG5BWWRhK1NjVGlzTGlVaklqb1RnOGl5c2tYV3pacXJud1RteERj?=
 =?utf-8?B?dExJTTRiaUd5WWNUbWRydG5DS3Y3TlBRa0wxUWx0dVFJVnRrNk9wUlRCTkVW?=
 =?utf-8?B?RUZKSkVFMzVmV2tGT1lDQk8zV29hRWdMZHIzVDFIazdyNExveGtVR2hkQXVm?=
 =?utf-8?B?ZmN3UktvUGtVaThpZk11NDdCemtYOEdiRFdCVTFoNloxWjYwQVpoaVB0YTRh?=
 =?utf-8?B?MTNZQkhGa1ZYVjNBcDI2SDFacWdwdklQQnlEZXB1Ti96d2RSSnFhRkN1czVm?=
 =?utf-8?B?RjdFVVNpOWN6L1dsOEFNNURCMC9KSFpjZmVMdEtzbFhWYUhWVlcyRTI5R2NC?=
 =?utf-8?B?elJZTUJhTzJpdGR6SUpJTkg4OUpXSWVML0VKZy9aY04rTW1zZUVOQTRzRDA1?=
 =?utf-8?B?VGdZWHpLUEdGTzUwamlTbWk5WlN3TDdkSEZQQWloMmJSTU9FaG15dHJaNUJG?=
 =?utf-8?B?MVhvVTRVVTdUL3dpblpuNnpzWjhEeXNSRHpUdnpSczRZREVoYklNQ3U1SFJG?=
 =?utf-8?B?RTREd3QvWENMbjMrT3VKRFFKNXI3N2tuMGV4ek9CbTdoYkZ3aCswUXAxd241?=
 =?utf-8?B?ZVNMTlU2YWcxaFoxd1UxbFpKSWVSWnhjTGNBSzN2SkFEc214NG9wN2ExV2Nn?=
 =?utf-8?B?bWc0TGhjV2RiYmhORmZLcE9PWDZSQWpjbkRCdU9DbkxBN2VOU3pQYVZRQkxI?=
 =?utf-8?B?bklZU1IvZUliN0doYkJIdXJ1WVlOVlp4aVo0RkljbW9GenJOUDFqenFESVFs?=
 =?utf-8?B?MjZPeHIxRnZ6bGUzWGtTWFZ1a3JrZnIrU3B4K05odHZvYkNjY0xkWjJhaG41?=
 =?utf-8?B?Q1l2RXdYRXppS3JzVUNqeUJWZ0hyZXIrSlNmUlNOYjJNWENPWHpDaEE4TVpj?=
 =?utf-8?B?dlNIVk1rdW9uV1lkMGdvV014VmFKR2FmSVhGMGI2ZXhLY21jTVJVM09oOUdN?=
 =?utf-8?B?bU1XeFZ0SW4xOEJiUFNMWkpXbmhJY1dsclQrSDg5WHBIenYyaWNhZzBFM2hm?=
 =?utf-8?B?T0pmaStlWWc4Z3B2VjVWYXVFYVJLVFhhbDVLSHNGRyttK2hqKzF5UjJiOXhL?=
 =?utf-8?B?YTE5OEtMbjd6K09qQkd4M1dXNlNrYUlEQWVXejg4ZDZIdEs4L1dhVW9yL3JB?=
 =?utf-8?B?THVCemlHWHl0OHF3RUlJQ2pzTExTaWpsZTR3alBCdWtRTEUrcDJvekxuWHgv?=
 =?utf-8?B?aE5vYVNWWHRJNUtTZEZBMGhaNmxOUUQ0NUkvb09zWG1FRnJyRzZ6cDJqOHJ3?=
 =?utf-8?B?Wkl3VGE5cFY3NDMvOGlCZDkzUktFbkprNWFDT1Jna21ISitVYlhTRmJSQW1I?=
 =?utf-8?B?MnIvRWcxRzBBVUYxRSt0YWxsQXFCTmE1cmYwRWFUakl4SXRyckwrM2dzbW11?=
 =?utf-8?B?U1NDWEIwL1NPOXNxSGw0N1l5cFFyN3REUEJyN0RUZ3M0Y3NkNXlRSUFKa2RD?=
 =?utf-8?B?WWppaDlDa0FYOUV4WFJtam44UWlpL0NnVnBEOXR2aFFTNk44MnQxM1p5UTgw?=
 =?utf-8?B?czdxMWVGcUFYWU5JUFNqNkFFa3JGTndCeE9zVlVPNVFKYldMU3Zwd3hmNWhj?=
 =?utf-8?B?S2hJbHk4VFdqd05tZ0JBcFBiSnNTcWRrcXpnb25HeUVURTlDaW1WdGpjaFpP?=
 =?utf-8?B?MVIwQWFGTXZKWHpuVkpZM0ZWYzZjREt2ZXp6cm1vWm5zbDJWdnZJaHZLWmxV?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1def60-b62c-432c-81be-08dc54a17ab5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:19:30.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0NA8NP77TTbGPGmI5moAfDQCWLwdIBgD5MSZh8y9DsnKwQAZ+znCaXF1QKlrZJ4ED5ZqgJAtmaP68x2E79hXvxjBXZlJOzT5fmoHXnqc7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com



On 04.04.2024 02:18, Jakub Kicinski wrote:
> On Wed, 3 Apr 2024 12:19:57 +0200 Wojciech Drewek wrote:
>> You're saying that if min_pwr_allowed or max_pwr_allowed taken from get op
>> are 0 than we should not allow to set max_pwr_reset and max_pwr_set?
> 
> Yes, return -EOPNOTSUPP and point extack at whatever max_pwr attr user
> sent. If driver doesn't return any bounds from get() it must not support
> the configuration.

Ok

> 
>> And similarly if policy was 0 than we should not allow to set it?
> 
> You mean the limit? I'm not as sure about this one. We can either
> treat 0 as "unset" or as unsupported. Not sure what makes more sense
> for this case.

I was talking about ETHTOOL_A_MODULE_POWER_MODE_POLICY, attribute that
is already present in ethtool.

