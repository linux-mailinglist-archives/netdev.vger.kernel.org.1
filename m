Return-Path: <netdev+bounces-138292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555669ACDA4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC05282E2D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663521E2606;
	Wed, 23 Oct 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWpKx+Kn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6431FA265;
	Wed, 23 Oct 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694664; cv=fail; b=rEl4l2un0iIO+fC/hp0qWC4ppyHvQjYHPEaqNN9VaK04k+aORBRmD2YU8RxqUhQQ+hMU2SpBqshBFHUm6NdIgEfu+P1E7lgzl2xobtK91eQkKY4r9akhZzC8Rjj9YXB0966wXREuBAvPGwyivl57Xj8/9pkiomSa7G6f7L3D1Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694664; c=relaxed/simple;
	bh=q+Qh9ommb/9fWAiQ97sgy3Q5hwdr1UztEbER2m6cMI0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cV8raTKlrKLVjaOjrDcQC/0GWIPZrLj4U8ug78g30d5Z/0AhqAQZ3hiTZN73P3SezzQHJyQh4223iw0qvxJrIzuEp+OhBMnXFaoni53w9FhbG/qOvnwnFNPrAaQ+Fr17Qqpc4+5yc84RmGPg+l+u1KvdlfcbiAa4eMGut/dqnEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWpKx+Kn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729694661; x=1761230661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+Qh9ommb/9fWAiQ97sgy3Q5hwdr1UztEbER2m6cMI0=;
  b=RWpKx+KnB+20DJ+aN6ZtcHHaedMHj8CAW524GFDi2wo52LTfvSe8FJgl
   ux/1lK6RWfafmmJN1C63Sh0i7IOURCWOjnFvVYMIjMaDs6kinXP4O3PYx
   Q8i2V0//0sLV6YxNuwGy1fwkc2SttVjgC8upucYWsUqGTZ+3BJ14Ckc1k
   tpH2LcPtxOaSk6PrGGR19Uvi8pAQA4fXIujk7oxkMKb5NhhE8yr0c6pcU
   A/SusmHg4nYzQzqkuC7zGsoGQ0mT5pxMBerNd9OyB9AS619toEDqI7r4w
   sf10wO+wAjjgts6WNBssMBCTkkWfGNozmljSULFeE8eZAf6hEUkkC8X+C
   Q==;
X-CSE-ConnectionGUID: zeKD4FksRTamItC4yDMKlg==
X-CSE-MsgGUID: zqsB/NWPTIm9mCUCSmIC6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="32142405"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="32142405"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:44:20 -0700
X-CSE-ConnectionGUID: qgh33Rc4RvKn/XkRVzFpQA==
X-CSE-MsgGUID: hYTsC3Z5SyeqxAhByk5n2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80253832"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 07:44:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 07:44:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 07:44:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 07:44:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px1t8bsUXs3Cd5RQqpEgkKjd/bPoqQGbyW4Trs7lmUcNkyhdjQXbvryXO1Vb/eJXbHvQjtkW3yqegPMpmi8FwrPGXF0oU/Z+HptWopEWWezZCzMUf4XXAWwddVfeTth9jBJVvIx4zE3XAayTalIwVXkpugDcS+Cdd0IQescCalT+VLzCnvG7INtmfpPuprqTinbuT+auuOaAjr87wEAZ6K4tq72G6q1Q/7oNpAHetLMaGNW+NwKT726DXukQSVNb+PI6SMZDUzm3tMDKkkQc8DTTzAOGE/PZp/iIbkCT1Xpj4WYB9/9LnzF3u1lkgRI4l4GNaOTqD8wCDKmtAYNqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd7cjGhgXTlKPBGb5Sq/ECtrPSEeNYL4UPLB2RxwHeI=;
 b=bemtsCsEK3oR7ZrFoZ381jlQc4EweOTBvrtE+AEgud8lqlvHaSZ7djZEjOJemvcuq5T8zTJLt5mcMYc5feCThMUQ8OJjmEWxWoahznxeJXr1GXf5S4CtLusYJ7PcXMLX5GJ7RhU6hjtWXDvNTbu/LrO8yNdUriiHIixJEuwXCeDaVMhb3Q0j6OPFuxhKWmbnyC9iSpzKyyqMIaqaWN2OiR4+8Vs9OLuFDtiud9KDTmHsyB/9xPq1ZAXKkvrO8sW6TvSJOXr1TfEEM4mN2o5kD3tvov0vs9wAvugdgNOnYdhibDUdvECVhjFGpJyGZNTcXTzJBdb3vdYPnd/op8BSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:44:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 14:44:16 +0000
Message-ID: <cea9c68e-758a-44ce-8afc-448294456317@intel.com>
Date: Wed, 23 Oct 2024 16:44:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <amadeuszx.slawinski@linux.intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>, Kees Cook <keescook@chromium.org>,
	David Lechner <dlechner@baylibre.com>, Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, kernel test robot <lkp@intel.com>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
 <202410131151.SBnGQot0-lkp@intel.com>
 <20241018105054.GB36494@noisy.programming.kicks-ass.net>
 <a7eec76f-1fbc-4fef-9b6d-15b588eacecb@intel.com>
 <20241023143204.GB9767@noisy.programming.kicks-ass.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241023143204.GB9767@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 684b6d99-282c-4b2e-d57d-08dcf3712b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MktMTW1uVUNuUExSdHVlbWJhbUNrSlRac2ZzZkEyTWF4ZXBIUFNDUHpzNXVM?=
 =?utf-8?B?a2VkejE1cWcxWEhFZ2R1NVRaNTJRNi9GbjZDdEc1YWtiNS9iQWMvVENCa29s?=
 =?utf-8?B?UlJjL3AyNTJwRkZLNXAwelFzNmE2TllRaHJKZFlCOS9ETkkwMnVmOE5IaEtq?=
 =?utf-8?B?T1ZXVHpZQUpURmN3N1RUaEYyQ0kwY2xxQStDUmtrVzZEbEVHT2tiZXF0RUZN?=
 =?utf-8?B?KytvSTFkaU1rcXlXZzVKOUtEcTVQZmVwMXRHbUxlRjNuRThUeGRDcy8yMXhE?=
 =?utf-8?B?RzZtWHRudUhKWUg0ZTJTSWs0N1RHUTRlTDFmR2pUbjI3N1pwNEVKZTlHYmJv?=
 =?utf-8?B?RTVmN3o5cGpjQzlUZk9TQk5DSm96TndDR1pCVUF1MHdIS0dmUzFkaE1kMURP?=
 =?utf-8?B?Kzk3ajk4Ly8zUE41RVJQVDY3dFVMU0xIcjQva2ROZm5CT05YOXJnTjdtdnBv?=
 =?utf-8?B?SEdjYk44b0pnU0tZNjVOQml4blE0Q3dSbVQ3YWpPbUVkbEJ3MVlsNFNubmRU?=
 =?utf-8?B?YndWcTBJanVCWkRpS3NPY3R2TFM1cHBLbDZwRnREK0pKY1EreklsYm1aU2Np?=
 =?utf-8?B?MzhSa1dkZkVTNTdQcXNXS2tYaU5weVdXUE80Sit1OExGaW9YOWZOc3VTY3FS?=
 =?utf-8?B?Yk5CRG4zY0VKTGdMNzRPQ2dzaVkvU3hpUE1GS1RlVHJPOG5GYWR5SThSSnpW?=
 =?utf-8?B?TEhncFJWczZjd0dxdXgxOHErVExVV3ozWjcvUmhzaEhkcUY3VyswYUorcU9T?=
 =?utf-8?B?UzRZWHR6b1hpSjZvTi9pZ1FOL0xSTEdPYjkzOXBzcFlUVFJwWWdlRGRvRElm?=
 =?utf-8?B?NHlZRXU5b1hYV2x5SkxuMk9nMVFjbndYbVJCanNhK0xweTlmcUVDYzYyWUND?=
 =?utf-8?B?MkhzQWlaU0gyS0t0WCtpdmwxUmpWL0R0SjF3UExUSjBQZHpIR2I3Q0pJeFpG?=
 =?utf-8?B?N29rTExpV0NSUDc2eXo3M1RiRU1uVy84a3FTY0g5a2JmaEpGYjF5SGFRdFRT?=
 =?utf-8?B?bWpydUZWZVZBRDEwZUxWZUhxb0RDbDRjZXhpZFc5YUl3SkQ4T2kwZ1BjeDE4?=
 =?utf-8?B?ekE5NkhkcHkyWFkxZjh0OXZ6YjA2dDZVemVZNW8vQ1dOR1MrbllVc0o5bm5m?=
 =?utf-8?B?c2FBbDEvVC8waU9RNDZpRjZqNkhWVjFEY0pRYW5veENjb0I5Z0JaTitnUEZq?=
 =?utf-8?B?aG1sWk5qV1B0OHFhYmlDcW0wN1NEejNZZmNZVFFHU1c2UE9zc2NQRTVJQ0FV?=
 =?utf-8?B?Y0laTTNYa3U3QzRQbml0VU52NGlpejZ3MjFRaHNYa0RETEpTL2VMcUNLZGg4?=
 =?utf-8?B?Y1ZIRGRBaHFwSTliOWNFQmRaeUdOdnpCV1QxSnExeFJORnN2Q0FaZFhTQzJv?=
 =?utf-8?B?SFhvZ0hybEUzVXJnTHpsTlUyOWlXWjlidXgwQ2xVWVNCSVR6by9oeW1TQjQ4?=
 =?utf-8?B?a3ZNQnpHaDNYVUdOTFdEZzdvZXJlenR5YkRmZFR5QWU4R045VDhNWmhtcGhr?=
 =?utf-8?B?MHBHcnowcXlKdWVXckxteWpKb1Z6MVpqZ09JK1pDTkd2T29DUmZjUWszeWRS?=
 =?utf-8?B?VnRaaHFtamlIcHp1REtBY3kwSjMxM2xtUTh5azJ6K2Y0SzBHeklLMmJNY213?=
 =?utf-8?B?VVBYMWJUUjZaazBBQ0RCRlNpR3NmVGszRkpFSW84VmdBNFZQTnVRRDhoRzh0?=
 =?utf-8?B?QTJHZDdXTUxncHZ3akIzYUpzU0Fvbm00VEdpeldKT3dRWHp1TUxmaHRhTEFN?=
 =?utf-8?Q?rFkEA7tTl0HLFSElYaSlccX5BH4uo4msXjeo4sT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVnMldlS0hMSFV2QStMZk1QZlg2Qm91YVV5NFhLcHNROXlKRURpVU9HWU5Z?=
 =?utf-8?B?RW13MU16c2lnQS9FQ3U0K2gzS3JIYUhXcGFweFhydlVNdW80cHFLQlF5Zkcv?=
 =?utf-8?B?eW04amhJMDhGNUl0RUR2QlpaeHJMem1CMWtVNFg1RlFtL3JDTjh2d3poQUw2?=
 =?utf-8?B?SlFXNTFkYnhoWGZIV3JzaEpqeEtKSW92empvZGJ2VzZWMW5NMVFQdDBvMDhv?=
 =?utf-8?B?RWZIZzc2SlZtM1gxR0Rvd2pIcm5vaE5LQlByRjdmRWFwQmVYSENZSy9sZ0Zo?=
 =?utf-8?B?VTIzS1ZZREVRWlVNREhobzQrMmZqelpnTkFUMDExa2g3QzRKaE5ZUGxnUVdk?=
 =?utf-8?B?bDdUMlJ0RTJxZjQxN2FLYXhmMzB2S25ka0RSRWh0aFFXSzB3T1J6dVNDcFlj?=
 =?utf-8?B?VjhmWFVyUXRhcU1YajlkNDZPbGxQR0R1WGJScWRpSXBuMWZHeUxmZW11SGhx?=
 =?utf-8?B?NmdZeTMybDRvYWp5ZWdvbm0wazBKZnFCcVp5OU96eld3cEVOaitlejNPV1o1?=
 =?utf-8?B?M2d3dUJGbUlpTTRnVnR4c01td1p4Mm1kd3hnczFuOUFadzdtNlpSOXhSOUhY?=
 =?utf-8?B?M1orTkxySzNrc2h3TTlHRjAvcUFoSW95cnhVWmFpVWx0MTkrQU5Xc1psUzlR?=
 =?utf-8?B?MzNJOTJUZGtKbUoyZTJnQmVWemZHeVpROEphRmlUcmsrYmdpMTQxZTM0aFpR?=
 =?utf-8?B?Unp2OGh3T3NKUUxiZFFvd3NGVjBaVTYzcFJ5UFJyeEQxSGoyK1liY3VTTjNM?=
 =?utf-8?B?N21USUxrNldoRTE5OXNpMXh1L3dXRldtc2FqT3BxbnF2OVRoeHNiaURGZzVr?=
 =?utf-8?B?aEhUcnhtMi8rWVloaWJtU1pLRjFScG5CWTJtY0NSNUtJdkFJUWIrL09oYnBV?=
 =?utf-8?B?TVNweUQrNUhZMExUN1VBTDZ5THdGbjR2RWlhNjNLYkxLN1NOaTVnZWRUcFVP?=
 =?utf-8?B?a05QekI0NUlya0puYzhqZ3dGQ0psNFZrYmlNSWRTbEhtRVhvRUVaSFVjWC9i?=
 =?utf-8?B?eVBHMU1lSUx5MFlNN1kzUnBuZ1BSdzB4eVkxSkEwZmFkMldMQ2E2aTl2MFVU?=
 =?utf-8?B?OWNoNEZFejdmQW85QzVmNG1WV3hveEJTV0pUR0hwbW5vclRBSUR4aEFVKyt2?=
 =?utf-8?B?NEZpQmZLZTlTdkprTzFnamNiOEx3aUJreVJQTnV5SWhubEJ5WjBrR0Frb0ds?=
 =?utf-8?B?ZCtMOHIwRHRnNHBGeDE4T1M5eGJocEZrc0xITVI5RkVpZjJCblh2bndlTENj?=
 =?utf-8?B?TUxNUEJrS3pQMFY3czBJb25OM1FwaVF3eWhwbUdKODQ3ald4M0dMT2Jod1JM?=
 =?utf-8?B?WXdOemg3UGI3ZDlEVWU4VGkwRzVKTTY3eTBqVDMwVTFONXArOFJyWTZETmFE?=
 =?utf-8?B?VW9uRysvbWNrVzJOdHliU2N5aTBrSUFPOXFDYlVwZ0VFZnU2MHMwQjNSSWVK?=
 =?utf-8?B?bEx5Yk5CaU9MejI0R0pIOUVKNW1NMTJGcjE1SkRTTnJBOUdoV0hMNlNuVkpI?=
 =?utf-8?B?UXFFc2xmd08zeENhbzMrbDRXQjlVNm5iV3JCc3VETU5CR21QRmlTSXE3MFpO?=
 =?utf-8?B?bUJtdElXZ1lqMlFsWkpmUHRVU05zczU0NElsVVR5Qm9oRTlZdWhTcXNLNmFy?=
 =?utf-8?B?Q2p1eEhoelYzczdzYTFCOUYrZXlaWnZ6T0x4UU8vNVkvYlhSS1phd2VraHU0?=
 =?utf-8?B?RnA1S1E2MGhZcWg0S0xseFBTcDNORU1FN0gxaTlhZjlaTkIvWlQvTUhpUW9D?=
 =?utf-8?B?dXNzb3BtcmlnOUdleHFUaGRoVy9DSUVTLzhJWmVodUc5YjVTcWk5K3VHeVZp?=
 =?utf-8?B?L3ZNTUlhaWVsN0FSWmx5Q3JZNVdaYTZGbCtIQVIxaEFQVm9jU1FpanBGVTN1?=
 =?utf-8?B?eUFuc3p1bzB2TUxQMFF2RmE5MjBaMEJROXcvRlgxWVhxajZnUWhSYmNXc3RB?=
 =?utf-8?B?cElFbHY2dTBub25EVGljaFpxSDlENjFDTWJsTmxDdlJpQWhwcmZGTENMeHcw?=
 =?utf-8?B?WkZZV3BpcEtCZnl5Tkxqayt4NnFoSStaQms4WDlLWVNLS1JqN3FxZjRkNGFR?=
 =?utf-8?B?WjZaR2JUQWloTk1wbzE4UThBTTVsQ0RFTTJnMkVlMGJHSFdiYVE0MGV5M1BN?=
 =?utf-8?B?ZUErSlo0RXhqdGU2elhsUDMzd3VYcFhqRnluWmNtQ2RRNkQ5VWIzL0FQSkJq?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 684b6d99-282c-4b2e-d57d-08dcf3712b0c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:44:16.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iWwXEZ5rGy/n8mqNPxF3bflcehycbJsNnHGs/+3jFRfHZIt3pj2WJPgIv9QCpns2CUlfvF2duwNomAjk/8sfeiQUtcO0baWOtmqfoP9q9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

On 10/23/24 16:32, Peter Zijlstra wrote:
> On Wed, Oct 23, 2024 at 03:43:22PM +0200, Przemek Kitszel wrote:
>> On 10/18/24 12:50, Peter Zijlstra wrote:
>>> On Sun, Oct 13, 2024 at 12:01:24PM +0800, kernel test robot wrote:
> 
>>> --- a/include/linux/cleanup.h
>>> +++ b/include/linux/cleanup.h
>>> @@ -323,7 +323,7 @@ static __maybe_unused const bool class_#
>>>     */
>>>    #define __scoped_guard(_name, _fail, _label, args...)				\
>>>    	for (CLASS(_name, scope)(args);	true; ({ goto _label; }))		\
>>> -		if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {	\
>>> +		if (__is_cond_ptr(_name) && !__guard_ptr(_name)(&scope)) {	\
>>
>> but this will purge the attempt to call __guard_ptr(), and thus newer
>> lock ;) good that there is at least some comment above
> 
> No, __guard_ptr() will only return a pointer, it has no action. The lock
> callback is in CLASS(_name, scope)(args).

Ach, true! Thanks again for taking a look at my series!

