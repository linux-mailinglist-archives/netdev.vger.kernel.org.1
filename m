Return-Path: <netdev+bounces-197125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC3AD796A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CCF16F591
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579323AB86;
	Thu, 12 Jun 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lURxrax9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE517AE1D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750813; cv=fail; b=sEmitBD+39UKG7gy5VLBTGcsUmCppdHHzPz8vLSnr5HtR3VPRQzgOnQ0lkh4bswzjVqFExb6aJT8/UV1uQrrw5GREaNp9H3Ld6ngY9ntd4phBxKsFZopDAyTpt3iW3eXWXfgRRHCDu2Exm8ilvPSU/6dYmJ8/nHxtrW1pHLpV8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750813; c=relaxed/simple;
	bh=r7OweyCFg8hIIolPwxHPCIZLZZJ/Qi7FWuaSwefSTAE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mvhvn0bTybspgIgwO6F8LQIOkPPriih5+M9WdOpQSJosG0abFw0LWV1nTADX8tmR5YJT4m+gTRXF4z4OjEH93KQhs26UQj0FuxyRcqT78jd/FNPruf5khBwIV5uxb2uB+aAOszyPF9Ney6tnanDXWnuYCo/Qm0SmHnqOdwBndx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lURxrax9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749750812; x=1781286812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r7OweyCFg8hIIolPwxHPCIZLZZJ/Qi7FWuaSwefSTAE=;
  b=lURxrax987htIEUzUISf2cpODPP9584uH4uzjYvtSMnIq5vSezkrZwn1
   cHKDeX87ekQWcQ4kNEkh60q+rFgnOCiWg5cwr+BjYD7i+FzjlsIuNPc7s
   frQjJT71O2JR9NPcwAnAWryU/D6Pe3aTKuMecc/uoMKZJTdtUYhMy+qPr
   5zEhecrxE4ohz5jnUaXsNFDjKQriYE9WcVPQw8qPvqNmzI2eNzHJ6bbQP
   BlvHJROstMGahzkYNrbtGtgzXZ5gMgiLsZkFk91av0jmQ03PpX5GQy3lD
   OOk231N8eszI/LqGYl25VIajNHYWfnwKzGAl6XiisUpBGrjAHCz7Z7bZW
   Q==;
X-CSE-ConnectionGUID: d2hwN1YITGu38PXw5ZEMEg==
X-CSE-MsgGUID: YpDgBtzHSV2jlb6NnTV40A==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52046217"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="52046217"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:53:30 -0700
X-CSE-ConnectionGUID: o52EoDM1Q+WhspkWwfiWsQ==
X-CSE-MsgGUID: gtRZl5UsSB2YLWJ4AqgjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="147579921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:53:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:53:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 10:53:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 10:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BggJ0IkfQbm2zuTVuwmRKjYX+dmp9fHWwElhzjjFsrNPzqynTdLP4i6GI29rUfSHgVloAWy0fTX56NL/seEW1kpiIRMphv1IxzHJX7mU3odUmgkEcHQAqCJoB1At9CX2V7ncMk6BwtT0tFOVWFjim12AW/GcNHsfaMVk3XqA7XzMyWQd7zguCkhaMzbJ82n7BsaWHMkT8LQNWu6j3smnj6dv4JVY5imFIvOMataQj/m5en1+/N1v19Ybqsfd+0J1LJ3m9GlBQAJ2IVmc+Q8zfSsk3qB9WyzYfM9RAfzWQ9FynOJ6uH63nttrGAdjlV7Cv3dZP2PEr/eQiGuCf/WfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tHVEbm/86Y5iEF33TFyj/Bs+zVS4CD8zLNAtyo5Qug=;
 b=hMpnlBd6A6f8R0d0A2u3Px400qrt8BmiILgOIj7GtqP5Hlmqeah5RScaSEuFDN8a6V6Cy90vU+0hEjmlErZzI4W2s+c2sx9Uwy8FVtkcQ/JYRPWdcmVX0XuP+mQ5phVWjUHlHeS0QHtVgZ0kHaDcgXjJp9+QfKV99SzfKCJMdHfKSLZv+fzofbpLbgCcrB+sL5Ei5ZtWGQDFD2vl0ywjrgljDmzTzq8KFwNXbA/ztdj+Zno5ZnwiLwVp1LdEowIcSfTRasexMYmnaODDYIbCdI/WhT/X2t/1qmSIRqMLP0VUTW7z64sHHuL3l2m0MlG0xPpJOqvTY0eKh3rzKJrQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Thu, 12 Jun
 2025 17:53:28 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 17:53:28 +0000
Message-ID: <d263e6d6-72c6-4b52-b07f-aa6dbbb7f29a@intel.com>
Date: Thu, 12 Jun 2025 10:53:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: simplify phy_get_internal_delay()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb7977b-33bf-42bd-5c2a-08dda9da092b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NC9YZ0JFeXJrSlRyVVQyZzJKdlJ4UW8wM1pEYmpKcWdpcXlPclZIUzc0ZS9p?=
 =?utf-8?B?L05ZQ0tsQ1c4N0dRTUNzejFieUY4R3Q5Y1I2Vyt4c09xUWtTSnovR3lkRDlI?=
 =?utf-8?B?ZW1ETGNlSDk1TUZqVi9KdU0ydFBaZ2lpUHRXc29IU2xhYlh1MWYxbnR0Rk4x?=
 =?utf-8?B?UjVKdlJwdmdkdkNwVktzZm9tQkk3eXZkZDRMNTZyL2pQU0ovVkFNV2p6djVG?=
 =?utf-8?B?NERtbUtuZUFBa1FONG1lNHgzVnIwVDUzWUc5SlU0K3RNUE94UXZMenhBdnJy?=
 =?utf-8?B?MlI5eUNIRjI2WkpRTVRoZmVRRzFPNUNXYno0a1U3ZTl3VjUyaWVRVUVpTHNQ?=
 =?utf-8?B?N2wzWFl4YXF6d2drZTBPbkJ3a3Y5NmI1NkxGT2tMYmg4ME5rSG9ETVNocmdP?=
 =?utf-8?B?VjlocURJUlVGek1TZExNNElaZ1JBQmtEeHdjeGRiVzZiQWg2ci9pOGl5Nkts?=
 =?utf-8?B?eVowZ1RlWCtVSzlPY3pOejlFSXc1OFhqbFZHSU1HU29zaGJRRjI1RVVvdFNt?=
 =?utf-8?B?ZVRwcGtha0FqbnlNanQrZVRJeEFQSFJIdnVrandvU2JTRGVlMkpaaVlCQ3JE?=
 =?utf-8?B?ZVlkTldsNXdQckQ5SWl1MEJWc1pobFlqbFhkUERXWFhJOTJacEh0QzYwMnNw?=
 =?utf-8?B?R1M5ODJ5NXhtaWFWVEhBdldsNjVteGZSemVia21pb3k3SnJtVTBMQU9GWlhC?=
 =?utf-8?B?VjN6SkcwT2oxK2prYmlya1ArbWVhbFZWcWFhMnY1eXpHaDhVbWpWYk1tZEJP?=
 =?utf-8?B?ZWpPRldqMjBkcWtFRjBENCtBZEthVjlMZjRzU2dRYmVxakg5cjZzYzUrd213?=
 =?utf-8?B?SEJ2SjBQQ1ljellneUV4UGNkdlVVWnFZcllLNElabjB0UzVQZ1FYUzh2MGdw?=
 =?utf-8?B?blU3R3pGTkM5cXdOdkFXNHFWNHROUnFJS1VJZ1ZxK2dTNkJvQlptd3Bua1Qy?=
 =?utf-8?B?UHRkUHVoRWZlcjdvVmFkVW1mMUtzdXA1czdLb0pqcU1iL2lvMEZvRG12OXVE?=
 =?utf-8?B?WnBKNVRyWnVidWNBbVFnN09SRmRXRjZjYkNuOHV6T1NGbG5kUUtxQnNaWXFU?=
 =?utf-8?B?QU1pekhoLzY1dGRueUR2RmN1blFtV1d0TGFTaTVOZVFLNks0SGFkaGZ4WlFB?=
 =?utf-8?B?dG1rYjNYeEU5U0F5cVJ2SGRENHVsNnVsVFB0UitUcjdJblg4Wk1oVWNMS3M5?=
 =?utf-8?B?VzN3UGNjUE5wbHNUVGVkMUFnbFRRUGR0RUtDMWI4K1ZBb0VXVlVLWnRsRkky?=
 =?utf-8?B?SGdBRVpPdUtGeWZWNFdXNDlFRUc0a1AyeDRwZDdwSURiY2xrVjEybzA2ajky?=
 =?utf-8?B?VktXZzFoZ3gySVlRckVSRS9URkIvdVJnb0ZmazdJc3N5bkViY05XWm5ZSmZN?=
 =?utf-8?B?Y3lGdFd0cmRkTVo3Nnltd1lNekRIaHlodEROVHVOWnp1WDg5Mm1Ud2hzNEZy?=
 =?utf-8?B?enFwV2hFSzFrYS9sRkxtNXEwS3UvYW4yWUpucHhUR3F2dnhkY29FeVdQdGV6?=
 =?utf-8?B?cS9zaUltOVZManJuSkZVUGlwNVVtcmMxZWZtYTBsR2lXRTNXOEs5bk0za0dk?=
 =?utf-8?B?VVF0L1U1bytwa1JqekF6Vzcxdkl5M0xBQVBqSFBjKzhQazNyWmJzSGtJWFk5?=
 =?utf-8?B?U1YwVysxaFR0L0g4UlJrRzlSQUc4NXljTHlORkFLTlkraFJXREtjRnU1ZHZs?=
 =?utf-8?B?TmN6eEF5RHRhU2lUNWR4Z0U2ZytxUzJXY0RpMWhBdi9XVk8reVhScTlVaUZF?=
 =?utf-8?B?VkpuQXcyUENDSXhuYW1QcFlwa21hVG5lTkZWTVo4b3hJNXUvdXhEaXlQZlJu?=
 =?utf-8?B?ZVIrU2xTWWZ4WVg1dzk5cUE0b25DOHdvaGZyMkVwNklEVUwvOEVVNGJ5TjZ6?=
 =?utf-8?B?bFJJNTJRMUFLdDdzTjBJVWl5UFBiUk4xYVZhTlBUV1ZuMXA2V1RvTExGWk9B?=
 =?utf-8?Q?6+hiOqqvz+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlkV24zOTFlY2VFUmx4V0lTZnZqUHdmaHhmeEJvOUIyLzRON2N1MkhIcG51?=
 =?utf-8?B?VmdVb21qNGNWa21kQlY1NXBwNFQwcElIMG9Rd1prZWxLZVRSL1VyT2k5VmZB?=
 =?utf-8?B?RXRIcVZBWHNOUXd6Sy9ZcTh2VXAxMVZaREIxcXpzTXhGSWpyenczUHFGbEZ3?=
 =?utf-8?B?bTZtTlBJRjRwZFRocVdjb0tIbEIzY2xNTzNLR0k5NEZQcjFGbzhrczQ5WXVh?=
 =?utf-8?B?OEMxbnI4alVWTTY2ZVRQR1RlTEcrR3Z5TXRSMnRmTDZFQmsvQ0pBVVkvRVBh?=
 =?utf-8?B?cmtYejVVU003Ymt5YyttN2lpNXpEaWtzSEI5WXFRQUlQeTRwVDdYSm9ob0ZR?=
 =?utf-8?B?bmlBRDRRcU9tZ2lwSlFjcUtwUlJVVkF2S1lmYi9nMlNUTzFwZWk4aXBGQldV?=
 =?utf-8?B?ZHc1eTFoT3ljNnFtaVVCZjg1MTc2dFA0aE96akpiYU1lblhnTDh0UG5UOG5P?=
 =?utf-8?B?L1FERHRZbXlkN3RFOUU2SEVzaitxSm4xYkc5YUJxMUZCL0hDVnM4N0JsNy9S?=
 =?utf-8?B?YTlJY2xyMzdTY1JWdnFSQ3F1bDMwUlVqVkRpZ3RBTHdmOWhIaXNoVFJpR1hV?=
 =?utf-8?B?eUl4SjZEZzhwaHJlQlpnV2YyMUkwajYva0JHNlVXRGhKVitnT1BmZGhxUGZO?=
 =?utf-8?B?eVAyb0NnZ0JkWGlYcUxhM2ZVMUYvcm5Fc0t3Rk5CUjRSNURBczh5ZU9Pdnc0?=
 =?utf-8?B?NVlxS0lFQldqSDFuNW5iejJNaSttQzFzZDhVTXlMVmlMSUYybzhUdzVtK2l5?=
 =?utf-8?B?UTdNVjRyUnNiMnVzalJib0FWKzZKN2FXRWJJU0x6NGdnZDVOOGFldWhiRm5r?=
 =?utf-8?B?WmRzRU00TTg3Q3pydFRLam95SkQ4WUd0Q3h3MEVHYThYY3lDRFR1c2ZHQ3NE?=
 =?utf-8?B?NjlONTJ5aGxqanltUThOaDJNd1JPMEFFc2lvM3ZobkZQbVZuWFdIK3VtdlVt?=
 =?utf-8?B?WFRVS3RrdTFwUkNXUEJjQ0RKSmk0WjNza09WMVUrUEQxZVcrWEZtTnRzSUdt?=
 =?utf-8?B?bUxQckt2T0VSVmdHanAvTlRDTTZibE4ranhYdnhpK1dGZ0d6MDExbHJUc0FL?=
 =?utf-8?B?MGkzRUgvdlhZT2pSaVhVUzk3RGlaNUh0VHB6TDhrNVVzZnNCaS9ya1E4bkFE?=
 =?utf-8?B?UnpDazFkZmpTTW5UYTNXTk1Sa3hIT1NQeFoyRE9kZlk5RTdQcUlKMG5OZ1Ey?=
 =?utf-8?B?NzFKWVhGOENoUnFXV21lRVNXQkwzOVpZOUhCd1R4aEFrM0lRMCsvVnI1N1FN?=
 =?utf-8?B?U2ZMV09uNi8vMDYvL3RwVjZFU0MrZVFlU1FFMlFnQlRSQW5CamhGNFV6a2Vk?=
 =?utf-8?B?bW8vTmVNS0drdjV2NElIL1RETmIySXFlNWErQ0txRllHNkxnbGQ5WHFZVEdq?=
 =?utf-8?B?ZlVjekt3Q3NONW12dTBrK01VNmhuS2FsUW9XMmVTZVUwRmhhbzNOZnZuTXBG?=
 =?utf-8?B?RzcwUWNKSzRGTDlsSWhOQUtja0JBZmJRL3JaZlhHSnJYeVJ1UUNhOEg2aXVz?=
 =?utf-8?B?ZmhDSGJtQ0RKQ3NEV1BmS2NjWGs2amx0ek9Qa0JkUFdQZ0xHZ21oRWU5U0Fl?=
 =?utf-8?B?R3Raa1I0VExELzh1VWFPM1lKTXV1dzQ3b0ZuZ2dkOTY3QUp2Q0diMHV0UTN0?=
 =?utf-8?B?K0Z3U3czQlVCMXRQZStsMTBjd295M0lsVFh5STRnT1l3VXhJQ2hzRXg2NCts?=
 =?utf-8?B?WUhrWWJ4MVZYNHQ4Z215cWdwaHdjYVRxdDJ6SWp0clRwL1gxRDNxVGlFTjJm?=
 =?utf-8?B?WEViRWVvSFpUOWlBcjJ3SkFXVnRZQU0wNzUzSm9kUWJ1aVRiOFlsUSsxY1ZD?=
 =?utf-8?B?OGRJeVdYQ0ZOdXhFRm1aZEN1RWNHOHI3TXY1L2w5L2lRaFgrbnFLam5MRzhJ?=
 =?utf-8?B?Rk4xQmtQUnFjTExCTXVsVDhEV05WU3lEM0xsNVVNM01uaG55c3VxTmc4OFMw?=
 =?utf-8?B?UDhqc3UrbDhubDRydDBKQ1ZBSkNCV3FQWmlDdjkzYUloTHpQMnhlVkRtSURr?=
 =?utf-8?B?SW5XMzFEckZ1UkVPSEpjL3RyQ0hnc2lhRGIzTEdrTWthaFZFSkprT1VsSHZS?=
 =?utf-8?B?T3p4dm1EaGxlRkR3NjRST1I2VFpBNEZFUXdSSTMyTGRTTHpBMkZuNzJUL2hE?=
 =?utf-8?B?cGVCcUhXRnJmTE5vck54dUxsNkM3b1lwOGlBYkErVXpueVdxK1docnl0bVVo?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb7977b-33bf-42bd-5c2a-08dda9da092b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 17:53:28.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzQi2LjbF0oqbGR4sMa3wRS1rDEhMI1oDfuRfmuJxCXKTBZ/LnDJ0AHiQ63LUsGmo1RYmg154yNytpJOMsSBhURDwdPocHQkaUQuhjFGj/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com



On 6/11/2025 6:56 AM, Russell King (Oracle) wrote:
> Simplify the arguments passed to phy_get_internal_delay() - the "dev"
> argument is always &phydev->mdio.dev, and as the phydev is passed in,
> there's no need to also pass in the struct device, especially when this
> function is the only reason for the caller to have a local "dev"
> variable.
> 
> Remove the redundant "dev" argument, and update the callers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

