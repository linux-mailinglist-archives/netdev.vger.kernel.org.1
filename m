Return-Path: <netdev+bounces-121206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6395C2EE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2395B1F248FB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9AE171A7;
	Fri, 23 Aug 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeQv4YTG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5841E868
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377325; cv=fail; b=TOaCNhGUX/Oi4qBQepY5+d8surDRPAnug3Y7mXcUCjZIggcsFVv5uX9KoQ7z1xroYq+q9VgLmZXlgIhmt8jI5dF2gYscPTCBdYywYDKbA+iZnYM5kuiXgWljbDUQL9HVOGQOpvaFsMhTno/PAhqy9eYa8QA01IubOTc+F/CkDT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377325; c=relaxed/simple;
	bh=UfAtGTTdmP7mEYTSD3ZAjZzP/mP2bntIsIgMBGIQBH0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LfkdtFU+58yX7EsILXTuF8q6KvKx8AV7Z9UZjdGbOwvtkiK9yzxp2xnkEH4ebzwRKh9B8Wy2PBW543WkEFBoVuQUY7q4WeniVneS3SYIPc8mavWj+MGEbhRgB8XNF0/vx/bDKiYhxiayfKnFnxLIt6ld2IRzj84FbH8RWnDey34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeQv4YTG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724377323; x=1755913323;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UfAtGTTdmP7mEYTSD3ZAjZzP/mP2bntIsIgMBGIQBH0=;
  b=WeQv4YTGaTi2xvVZKWgsxIyOFoRlDc5BoNSSA21lIQE7lS4hNLY3CqJh
   RurRp/45NJDF3zt6prJDGNrs69gP07KjZduqst+wnWWJm8k/9lwDSGIpt
   H16Ve0XI1OAa+StCiF6GO64Ej9iJBRMSF0+8ubXFZbj1PPDQlwRMLHeVw
   k1cTMxRBffZlZtE6kDH08zTqaMZ6c9WqMlOfW/xN7/TLbfhg+iSJsXHOI
   Fd/6nExYTJpQ6WuxAj16WI/ovj+WogvAqGl8tH/8/OsFTvP9+742pnfyF
   6EYuolh2Fc+HjjkxV20tyF0qtQZg9ykH62uP8erwk9F5/XGGPEDmyrKbn
   g==;
X-CSE-ConnectionGUID: Eu7yNXTXSWOXHxSaFSDvvA==
X-CSE-MsgGUID: n+lJe+bcSP6sojfn5D3MlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="45347236"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="45347236"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 18:42:02 -0700
X-CSE-ConnectionGUID: ZE3wOyT+RKWZZGKRimEozA==
X-CSE-MsgGUID: pv8xE97BREm2LXN1c+zMZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61353524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 18:42:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 18:42:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 18:42:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 18:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoQqq35+NivHVDkJU8Iq9jyhMx8xJjsQNTbvsHjgj7Vk3/XnZE6iRo7PYt65D6Pzo3UtDjWQQh9XVwM3m3pmRixn+mVTEVVjcZCgQt53ZzFFq2MBm3tAWeM+B+cWNTTvAeRpiO/2HTNQXD7auebj52h3RYNf0iqrfoIFfIurH+pAXbxgECrtbSh9ymVwFDkB/Fm6K0ugwxsrp3HPowb1e+4gCYvpAw6EVLV5Ac3kMoHn5w1yXK1dBQ6AF7dvSYovJcqpD5aSYV4Hy+q+WbVZYKSdjJ1x0LOTdv+fDGPDmlGKOlq2U0ZYyu34uQ2hEe5ZNB0IdqJmx2OixYhhPDhhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGJATr9vSMHZcwtkcFw5J2C4N/d6KOuzmzpoyCIbV50=;
 b=Db7QcCwNNmhFgFI7q0tM1zDIzXmbVha+ocM1Enh1+xiCJYdL8HZ0MUeYIuTy8RodxXoCb66b94Xm30Xm0ndfqtaAkKw2m9UOwnWjjyqqCJkU7gBV4ZzuI8U8hJo5WkfDApy05n/tsiZJqGNjWwhesLLISnVK5LTD/bP/31wMcKvjSHx7W+n1SmWHm72h/REBhGewc3BJqk/BnnWdDTu5wzmfY/Uuwjp+lYQ0tyLjbUiZt/A4J0j5ANhUPe/fN55P04fC0kdrZG1tJb1w00tMjrxz0v6OxicESX7K52ylPCiQrZSy1m737iTIAxpIVyh3uFEljDVgGfABrQ54Bttvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 01:41:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 01:41:59 +0000
Message-ID: <9170351b-3038-419a-8414-fe8513a5bb57@intel.com>
Date: Thu, 22 Aug 2024 18:41:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
From: Jacob Keller <jacob.e.keller@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
 <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
 <20240821202110.x6ljy3x3ixvbg43r@skbuf>
 <7f9c481a-28a9-439f-a051-5fd9d44aa5a5@intel.com>
Content-Language: en-US
In-Reply-To: <7f9c481a-28a9-439f-a051-5fd9d44aa5a5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 204ae6d8-062c-431f-dfc8-08dcc314c776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnNNMGpkWnRqRWo0SlRveFlDRnRtQTJlVWRSOW1SekI4YnVZbHVlcWwzcDlX?=
 =?utf-8?B?a1diU2RvMmVFY2k5TWwwRmJXL3BYell6TWhjK2lhNSt1RVJNajdBeW9qUXh3?=
 =?utf-8?B?eUdETUFkU3pHQURublliSllZWUZ0Y1NLWDhuL2N0WllNVUwra1R0UDdyVWQ5?=
 =?utf-8?B?SC9FdDFua2puaUhMVTN1U2JRWHQ4TDczYVB2Rk5yNnBUL2JnMDYwQWJrL2Qr?=
 =?utf-8?B?SEZDZWY1RVRScE04Mk1MNi8xTlJZSWZseU0veHZrRkxJT2JxYWFqamhZR0dO?=
 =?utf-8?B?b2QxMURaNmIvQktpZnZVY3hsdWI2NEJ6KzBRa3VDN0paNEU0ZncvUmNCTW5D?=
 =?utf-8?B?SjFXNnNqU215ZmRJSXdnL3l4UnRpZTR4M1hVeEtaK0pHejEvcDhXM0xqMm9E?=
 =?utf-8?B?ak1RY2ZoanBkaE5iRjVaNHZUaUloQVRLZWxGNlArdTRZUVZrRXhaTDJtY1cr?=
 =?utf-8?B?YkFjMm1tcExFQkFJS0hyM3lVRkdqTzg1eHJ2ellDZDBHYWh2enFaNzhORXBi?=
 =?utf-8?B?Vk5HclhCa0VhUDUyVUFHeGYzaHI0aWNlZTNTbU5LaDYzWFBqUGVqVUN0ZmtK?=
 =?utf-8?B?T3d6dXlXY1k2Mjd6YnYydTFhSHN3ZUlHN0JZU3FQckpxTU1BS2ZQVzRHZnlz?=
 =?utf-8?B?U3VaMjNYaUlqdk9hNUlvSml5by9QVG1jajk5bmNHaFJCa1gzZDN1b1lWOEtQ?=
 =?utf-8?B?WFhrd3NndVdqaitwTXlsN1M0QStUZ1V0dHNOTlBSL2RHL3l0dW9OVGRGRGFz?=
 =?utf-8?B?ajNURnI3WHZzYm1GMEZ3LzlRT0tzUllEMHROcUVqcFE3czlXWUdLbXMwYWhJ?=
 =?utf-8?B?U3REem1IYTBwcXJweEU3bkcra2lqc0JnS1BnWE9WUHluOThFOUhxUDBYSTVJ?=
 =?utf-8?B?TUxDMFhYK3dvMWp2SVFIOXB5R0d0TWRTZ2sxL1A4Z3p4NlJBdUM5NTl2cHBB?=
 =?utf-8?B?NUNhQTFKWlpscitJbFc4cldvYldYV0pvakV6aUVzWEhUZlJkNWNrTURqYjR6?=
 =?utf-8?B?UjRUVm9XVHVhYnlQejN0WWpmM0VCRDFOU1lJOHNXRGdJVlJOcU1pckpJTGl4?=
 =?utf-8?B?NHR6aHNrR1hlNkpUMmVQYmRCNlBuRFRJMEk3TGJKK1E3bit4Zk9wUVBHaG1w?=
 =?utf-8?B?MmNDQzRkbVZvTXRHb2VxWDI0MkNDWjlOMFZQOERkS1FDRzllZzBoeExhaTlU?=
 =?utf-8?B?Zlg4elNGQTdIckVZQ2U3aktUVGgzbnQwbkU3QVAwUVBqekIwMUd3cTY4MnlV?=
 =?utf-8?B?SkF5ZUNQdFRYSnBQWmhkQ09jdEl3UkNQeXZFc01PRTlmVTM3QkkvZ09Na20v?=
 =?utf-8?B?aW11TFZ3TWtOMFNESEozcEw2Z0hWdEwxS0lkeXc5MmcwcmcrSG4zM3c1Yyta?=
 =?utf-8?B?bEx5MHVhOEh4RjVyYytRQUxoUFVjMFQydU10MWwrNXRUaG0ySWxWeU50RndY?=
 =?utf-8?B?dzBveHNKajkrMFNiSityY3RZZEc5LzhNYUVMbDNxZ0JPU3c0SWlpRGczK2R1?=
 =?utf-8?B?QmNONDdIS0NpaHV0elRvWEZaS2JiamNJdDhBTGZiNWVpR0h6WHpwSkJTdk80?=
 =?utf-8?B?TjFXa2JaNXVZTk9kcDNPNVQzT1kveG10ZFlSa0psWFNRL3NpTXhXRTJrVU5i?=
 =?utf-8?B?a2tWTHlTQkEySC9GMnJSVG0zMFZYZGlTc3pDS29KbWQrZFF4S2xOU3RvUEQ3?=
 =?utf-8?B?TURhcXR1KzZXMlJsNWJyTEg2enlvcGIrYSs3OTRuZk5IMEpkOGdrdVI0SWFw?=
 =?utf-8?B?cCtaOFd5UXFIT0UySGhOM3AxeW5vUHVtdXNxeDVuVFZmRVZwVWFkdjM3MGlH?=
 =?utf-8?B?SzgydUh1MmpyOTNJeTl0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBhWG82S2lpN3Zra1A1b2hpTDRtdFprUUxZYXg0VG9kbTY3QVRydlBlSWwx?=
 =?utf-8?B?RHVRU2VwcDZrdUdBU2duWlYxNmI4YTBlUFF4K2ZSVEczZHZTTWFlczBMU3hL?=
 =?utf-8?B?R1QrVEZsRlVPZnJMcnBoY0EzdXFIS3RlT1Q3a0tEVDhyVXR3WUpBbXI0ZjBZ?=
 =?utf-8?B?ZDdSNG9HSnhCMWtDUm9UUzJrVHcrMlY3ek13eDhoOHFyNlJXSmllM2FZaTBR?=
 =?utf-8?B?OE1DdlhIa3V5MFhWdVkyNkF3NE1iK3U2UEx2VnlhemZZRUc4TWZzdG85Z0ho?=
 =?utf-8?B?SHFwb3BIZHdwcWVkTnh3b015OEFzaTg4WGpHeGtla0VBdnhFWUNmeGRORmtn?=
 =?utf-8?B?b0dVanM5QXpIb0JsRFFkbis1STd6L0VSbHlma1FxeGdJdjFEMjRzWkNRMUVr?=
 =?utf-8?B?RjVmblJTY3dHbHFvZlFaUGQ4M1FwNFJ2UlZJbFpWb3Vka2ptSkExc25EdENS?=
 =?utf-8?B?V0JkSXp2b3hGc1gya21NSEs3VWxBbm0zYjNMR3NwUERqUnZZeTEzemRTM1JW?=
 =?utf-8?B?R0hTYXJiZGJlTGx3TjNyQ1JlTy9hME1SazNobys4RHlNaDZKOHNpdElUOHhB?=
 =?utf-8?B?K0w1Y3EwdGZBYzRkdnN0OFA2VUlHdlNZbkZVRUZGcGcxVzk5TUo4YUh4Vk01?=
 =?utf-8?B?STY2cGh4ZEEyNEVvZFhhL09hSUUxcXdYeXBiRS9uWnVDd3doaWp0eUpCMzlZ?=
 =?utf-8?B?YlBCUUFIU0xQZzdvWnpPd0RldVlqaUhIRnpZbEF6QVMvbUxuWlcralRwKzlx?=
 =?utf-8?B?Z1EyY1NWc0NtMFlqNHNHbUFsMjVUOVgxOHR3N0o0VUpYTnVOSGQvaEcvK2xS?=
 =?utf-8?B?by95T05GTmdJbU8veDNod3IwemFaUEpyZ3BORUJ5Y2dkV3hoVnIyVFRZSE16?=
 =?utf-8?B?bUtMVjJsOEZyVkFYWnRzVjdicHBBR0NvS3EzZU51T3UrZW84UWZ2eXZBdnM3?=
 =?utf-8?B?WDRPbVMxekpSWVF3Ui9pRjZ1MnloZ0FLNzJyVWdaTk1oL1JnUzFKVUZSbkdQ?=
 =?utf-8?B?b2hBeW5SNkZ2VkFxZGJFMG1SeXQ1bkJkWldpNCtmSE9ta0t3L3lIb1laamNy?=
 =?utf-8?B?cGNvSHh6NWUvMW4xMWpKUlNHWjVYdHhycWNjOFh1NU9naC8zRTJCUmo4ZmZB?=
 =?utf-8?B?dWJ0M01lbkRYSWc4RU5SQStXNm8vTWZIaUNMbUc0VGh1V1dHTTVzQ1FwNEFx?=
 =?utf-8?B?TDVhWTlMcUsyWm1pUHZMSEt6ZEc0NU5QaXdlTllOOEoxYjdGS2RPbENvaSt2?=
 =?utf-8?B?RVdYeGFiN1o0R3BuRnNvTDdPbGZ6aTRyV3lDN1lCZXhSa0lzSHg2cnU1MHZk?=
 =?utf-8?B?Vm5FOE41Zy9IV3p2TkFBYk1DSnhrVEl1blArRGNLUmJNcS9lenpGaFJWUmln?=
 =?utf-8?B?UE90OVFJUSs4bWMrV2MrVjF2MDdVTkF1U0VRc0REdjlIUVZCUFlIUEVUZlh3?=
 =?utf-8?B?UXBPbDlrYjV2SG9uUVpwTmV1Z0pCYUJOQlMvWnFNNG9JZld4OXlIK1JBdTVW?=
 =?utf-8?B?am1HY0R6MTVtMXhUQkZrSXllMEJVdnlmUkdLT3pLNzhkak5RekdaSmhOM2Jj?=
 =?utf-8?B?MVRYWVpTL3VyemhDb3BUZ0t4NW1ialJOS2RISTZsQ3laNXF3Uk9waEVOR2tR?=
 =?utf-8?B?SEEwZHo3dzJsVVFhUjd5cFBwbm1DZzhlUk5zc0NKM3NBR1cwOXAzV0dZa3R0?=
 =?utf-8?B?U29QTVM3eTNKUUR5OUIvcmRzZHRFbWRjYzVKNG02Yk1sd1JRajduaUNlbEZG?=
 =?utf-8?B?MEVGY2VGVHI2alJqTElhRFRFNi9mTWpYcUswNGgwRForb0JqV25vOUx3cFpL?=
 =?utf-8?B?eVpMVmhlbFJMN3lFWGF0QTZMTFREK1FkQ2JoZTI0ekFJL2Q4Z0NsTVVUU0xJ?=
 =?utf-8?B?a01NeWlnT2hsNWxOZWxUUytnMmlVWFNRLzBmYkgycHA0QTNJT2w3Y1kvYnYz?=
 =?utf-8?B?cE9rdGd6WVp6T2tLWFFxUU1xSHk2UittRXFFbUlnMXovb3hGcnF5TDA3Y0po?=
 =?utf-8?B?TGxiTGJBaVMwbjAwS1FxSGRubzVhQlVXUTVMbnd2MXU1N293ak9vaFRqQjgr?=
 =?utf-8?B?c21kUTRHV1h4M2RHbDdXZUNpdkhhQXRYU3VsNDIzNllCN2I5QWJzMWNmNCs0?=
 =?utf-8?B?OWNONjloSUNxdUg1TVR3eTNhWVFILzBkMzNFT3BXTGRtcGFIRVE1T2x0QnE4?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 204ae6d8-062c-431f-dfc8-08dcc314c776
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 01:41:59.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzktrFnvo72SkzTiZTm8eW+TNTYOx1jSgOep+tyQ0rCatHhSmy2JAD9i3BAa425nDyflX2ZBdFDHpXNKAIB2q25cBmRtAgnSO6E8JasQzqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com



On 8/21/2024 4:41 PM, Jacob Keller wrote:
> 
> 
> On 8/21/2024 1:21 PM, Vladimir Oltean wrote:
>> On Wed, Aug 21, 2024 at 12:12:00PM -0700, Jacob Keller wrote:
>>> Ok. I'll investigate this, and I will send the two fixes for lib/packing
>>> in my series to implement the support in ice. That would help on our end
>>> with managing the changes since it avoids an interdependence between
>>> multiple series in flight.
>>
>> There's one patch in there which replaces the packing(PACK) call with a
>> dedicated pack() function, and packing(UNPACK) with unpack(). The idea
>> being that it helps with const correctness. I still have some mixed
>> feelings about this, because a multiplexed packing() call is in some
>> ways more flexible, but apparently others felt bad enough about the
>> packing() API to tell me about it, and that stuck with me.
>>
>> I'm mentioning it because if you're going to use the API, you could at
>> least consider using the const-correct form, so that there's one less
>> driver to refactor later.
> 
> Yep! I've got those patches in my series now. Though I should note that
> I did not include any of the patches for the other drivers. I'll CC you
> when I send the series out, though it may likely go through our
> Intel-Wired-LAN tree first.
> 
> I've refactored your self tests into KUnit tests as well!
> 

I was writing additional tests and I think I ran into another issue with
QUIRK_MSB_ON_THE_RIGHT, when the bit offsets are not aligned to a byte
boundary:

When trying to unpack 0x1122334455667788 from the buffer between offsets
106-43, the calculation appears to completely break.

When packing:

> [18:34:50] box_bit_width = 3
> [18:34:50] box_start_bit = 2
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 2
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 5
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 3
> [18:34:50] new_box_start_bit = 1
> [18:34:50] new_box_end_bit = -3
> [18:34:50]     # packing_test_unpack: EXPECTATION FAILED at lib/packing_test.c:264
> [18:34:50]     Expected uval == params->uval, but
> [18:34:50]         uval == 1234605616436508544 (0x1122334455667780)
> [18:34:50]         params->uval == 1234605616436508552 (0x1122334455667788)
> [18:34:50] [FAILED] msb right, 16 bytes, non-aligned
> [18:34:50] # packing_test_unpack: pass:19 fail:1 skip:0 total:20

Notice that the box end bit is now negative. Specifically this is
because the width is smaller than the start bit, so subtraction underflows.

When unpacking:
> [18:34:50] box_bit_width = 3
> [18:34:50] box_start_bit = 2
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 2
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 8
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 0
> [18:34:50] new_box_start_bit = 7
> [18:34:50] new_box_end_bit = 0
> [18:34:50] box_bit_width = 5
> [18:34:50] box_start_bit = 7
> [18:34:50] box_end_bit = 3
> [18:34:50] new_box_start_bit = 1
> [18:34:50] new_box_end_bit = -3
> [18:34:50]     # packing_test_unpack: EXPECTATION FAILED at lib/packing_test.c:264
> [18:34:50]     Expected uval == params->uval, but
> [18:34:50]         uval == 1234605616436508544 (0x1122334455667780)
> [18:34:50]         params->uval == 1234605616436508552 (0x1122334455667788)
> [18:34:50] [FAILED] msb right, 16 bytes, non-aligned
> [18:34:50] # packing_test_unpack: pass:19 fail:1 skip:0 total:20

Specifically, it looks like we basically fail to calculate valid new box
offsets.

What's weird to me is that when the box width is larger than the start
bit position, we just calculate the same exact offsets, so I don't see
why the existing calculations are there at all. Something is obviously
wrong here.

