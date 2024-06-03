Return-Path: <netdev+bounces-100351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D28D8B53
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCC9B20D6B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667413B59B;
	Mon,  3 Jun 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZvvaLGV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EC25601
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449246; cv=fail; b=pNQFifotaef/3puzAEndPm9zoEtyH0ZY1tHvm495Kcyi/fD+7LgTK/6MasASKnT//4Njax7UR73+L4aQpjyPTKQtIJpqgbw9NVKY0wpCymeW6fxPmOIIQe0RaeabmBryZFuSHsEsgbyriAh8YKwI+lxGSMkMRZDlBQsPd1G+8tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449246; c=relaxed/simple;
	bh=ShL/A4xC+Iao5NBS5icmHs1RC+O4K/php6SxQgaNJ9M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOuZbbXzlOJYV1EP5gYPy+Hz+f//fd5QdbMjmx4/4LpvwXDhyH0FtfcmMxl4nDb5T5MCjTbob2hDmfCL1Fjp1M9MA5sUdN2oJNboTP0uyO7DqOb7sO4GONM3ULCt4Nn0ztfl6sLTUP5O0p0tUrewEiPUtG1l8KCOBkAefPyKlSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZvvaLGV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717449244; x=1748985244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ShL/A4xC+Iao5NBS5icmHs1RC+O4K/php6SxQgaNJ9M=;
  b=jZvvaLGV1/nDVShXgt8pzOQ7lwtUP/Te0yv+OoBApMmwdrl8v7hOZpw4
   DwV1fuWcy0DNXbQknsrPYYjNa6YtaSrNeFIL+xYKBLjIYd/tt8ODPSn9b
   tKJKMND8SAqgA9CauLwiVbUV22CDTCxdWacsSDmLXbkHCCQVv7oG0N58N
   BcpnzIIvawsaT3E4P2xvznYEIMjKXiz2S794Sis2WeCoDml5W5oXykwm4
   01vgLtsSAtQ4KuIC0htf3h+SXxWyNNKYrsP6ZcpUK/xN9QwamaG8voBhJ
   XAiS7PN3bDYxEhG3e4ExiT+ZWDNhqO9h7F4ZcHu0npy2Tc+SBlxYJrZWu
   g==;
X-CSE-ConnectionGUID: gnAk9IX0QcOCVB+eWUhEhw==
X-CSE-MsgGUID: zaJi2yl2Q3SgswdFmHiqvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24624141"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24624141"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:14:04 -0700
X-CSE-ConnectionGUID: 7NHq7LBcRE2SqbZLMzeHUA==
X-CSE-MsgGUID: FFINW/PPR/G+2voUuvcMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37026908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 14:14:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 14:14:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 14:14:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 14:14:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBZ2O0hfXfl2p2NJDNnF/c3o6CrPKYrUfKD+GzbwxjieylmEVt3LR4QUcuPHFeUUvjyiNDG1cwBjzLaUe9Ll+Y1inLc/GfhKoeooeSrLEPaeSlc+r+7XZe8jOmnZzpuVRtYdwJDCO+61ICXQzQ5Zdl/GJ2P+2FZ2pAwwWT4loNqdSPQ/aYzNBVbj04fhdWJ6sAvB4MZ3PNybAw7XEYH3m7maoVNhhpChgsHM9xZEADO4WGkYbMRVe1kCwMNO6KMkhCeWB776+ERpGZGOmhz6ref3l/wy0Fal7JKxptBSeTgE5tQYd80Wvgiv77278IJKmQx++fsB/fFw8UPSOSYgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEfndHugQwK7L5+8lkbcFBbbfXr/pmTSBzRbhoxYTRA=;
 b=a7FSsgOfqfRNdruzCRS0oSqk/8uOxT1jiO+PqCLOJGcUZB1nsqTv6nMjeDHExSbQugFVwLqrm+FoIKZWwJiS3MPTuWg6nc/MMNfabg6xwJKymEUmmMobQF06LiB2b0dDEY3UDer2bR372lgz9RAPqZeJJEq/6r1dl7rCLSGaTeDdb1GYEOIBTd2vMct7QQIImm91ivHdz31ayW9pw8ENLxbrNES5gxV0yPGVckmZr2wmAVIbywiHmvL++MQP9PO7Cw6UQIXG44drHvfMiHnMtoSrHUdBKHa3jrs3KORyYtOqshcfnLcYEmGw7i2vnvdSBx/OTutqAgqApjrqTcTIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29; Mon, 3 Jun
 2024 21:13:58 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 21:13:58 +0000
Message-ID: <2bb49dd2-7a26-4a45-9759-ddc14b250c16@intel.com>
Date: Mon, 3 Jun 2024 14:13:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: extend tx watchdog
 timeout
To: Joshua Hay <joshua.a.hay@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Sridhar Samudrala <sridhar.samudrala@intel.com>
References: <20240603184714.3697911-1-joshua.a.hay@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240603184714.3697911-1-joshua.a.hay@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0239a9a8-6494-41d9-e3e1-08dc8412158c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3U3dW80c2tqUzlXK1p1Tmg1OFA5TFYvUVNVQ1UyN3hzUU5kaEliaCtPVTU3?=
 =?utf-8?B?cWc5dzB4NVAySDZ5WXRVbmZTVGJZeENoY2JRN1JTVmxqMXBwOG1WaVlDdWpY?=
 =?utf-8?B?OEZJTWZLTmkzcGI1b1lHR0RHeU9LUTZob2xTYUhqWFNkZys4dmJ6TkdlSy82?=
 =?utf-8?B?ck8rdXRxRllhaXQ5OGNOb1JpbVB6eXVnTFc1UGh1TkpVWFEwKzdDVklYYW01?=
 =?utf-8?B?SlpLcnVyTzZlU0dtbWhISmwwWlJBS2dJdjgxUzMyWHh4UGl6aVVDbnc3VGxY?=
 =?utf-8?B?TlBtaXFWa2Flc3d4RUhuRzBveDNZd3lUSDFWbU56bVJKQUJtUU1oQk41dEd5?=
 =?utf-8?B?R0ZtYTVTTEx5a2ZyMVR2K0VvWUxicVBNdzBxRzVnWTJpYjBZTWcwOHRVaDFV?=
 =?utf-8?B?QmdrNEFSRUkxbmp4eERhcmkrRVBXaTdESUt5bjE4bGNUcmoxL0Rwc3Y3Q0VC?=
 =?utf-8?B?NGlvSi9yUk4yRkd5bHNEOTZ2NVU1ZmpzVlN3b0RYREJEdmdUTXEvZlJLOFdO?=
 =?utf-8?B?cUd1TnZCc3VJNjMxeEZmcjhjeXIzYmVFTm9JQ2s2dDBCRnM4M3dENXo4R1J1?=
 =?utf-8?B?OUFPQUxvU3dkcExNUzk1b3dmMlRpVmp0U3dldHV0UStqL3FyRE9paUJhZmdB?=
 =?utf-8?B?dHVGS3RpdDBZaEhNZkc4eDQ1cVJsSWNMRXRLRWNrY0lHalpYeFBzQkVOZG1S?=
 =?utf-8?B?L3ZpMVdILzYvZFE0SWVFVFRmSUJwbUlsZGQ2MFUxRGxZSlhXQXdWb1RTN2dw?=
 =?utf-8?B?eGZpdW1kSXZjZG5ibzQ5L0E3bGwycEg0QVhUSHVuUlFYeHh1d2hLdjVldGFX?=
 =?utf-8?B?WTBhTktRTXdPS2NaNTVNcUFsdHlpR2t3cnJvUFdtUmtNR1dlSFh4R1A4S2ZL?=
 =?utf-8?B?Q3FJT2J4ZmYvZWc2ZUR2R0dEQ2lQcW9sUDhBeXROQVNTTExNNTV0Q0o5V0dl?=
 =?utf-8?B?OEFzbno1VDREdklOaE1WRjNEYzNwZ29UeWNxSUkyMHZ4bGYxMXYwSXhBNFdY?=
 =?utf-8?B?K0k1aWJEMjRnb1RXQ1dUTmN6aVEvSmlsWjVHZlphdkhNcU9uZW5PWm8wZis0?=
 =?utf-8?B?TFVySlpudS9qRmdjK1Y0bTVoUUh0WWdXb1JtbXNkMi9kZ21BRGVYNG53K2dk?=
 =?utf-8?B?YWEvTWkvbWY5RWtDSnRhN0wrZm5IK2N1WmRROWw2K1NnaHp3bDNBcFN3UGxQ?=
 =?utf-8?B?cndEMW1lSkRPeDBiaU9JS1BzbEcrakluaW8rckZVOGpqeDJYVElqd0FaamY2?=
 =?utf-8?B?YVhnTi9UWFBoNkh4d2thNXlJeDNEa2FudzVINkJIajRtNWluUFFrZWVNYlVr?=
 =?utf-8?B?WTZqaGFLVEtoM2wrU3dGVThDajRiRldpaGgvVm94d3h4L1p4QzRNVDNSOVZL?=
 =?utf-8?B?alJJYWpFUUFLaktPZzNFalN3dWJuM2pESHB2c3J2ZCtkemtId0drT2JHdldD?=
 =?utf-8?B?NzRmQ0g3ai9uWWZibEZmQVNBY1FnbjNQb3RpazI3YnVxVVdpQTFwUkRjNkE4?=
 =?utf-8?B?NVBMbXNkWUlZY0N4UzFiOVUrTS80cFNaVmF4b000MERjU2J1UWRmUTEvRVRw?=
 =?utf-8?B?clRTL2NxUHBjdHVCNE5CWXlkZFV0OWdRRmVhZE9EYVN1cWdtMHQrUmFHbVBS?=
 =?utf-8?B?S2NRNFVMMDF3UVA1WVdkY2NEZGV3REZ4SitGTVZ6d3ArQ2ZuM1Bsc2Y5eUhT?=
 =?utf-8?B?NU5rc0dIUTVndGxJMGFlalRXd0xyV2xVQWlFdTFVYXNiZXJEd1VFcGJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFGVWsyQlczdUFHclZmUXpidnFhZjZoL3c3cVZBeXJpK2J0dW5jei9rNzRh?=
 =?utf-8?B?VlZ4SGFvS2lFVk5TRFJqbUVYY1VLYTNsVUhuQzI0SGlXR05EQkVTVElwOTFD?=
 =?utf-8?B?eHFrQWFqY2pyTVJvb3MzdWhDNi81Q2IwK2dwS3pYVnhZd1NGVEJqQit3alA2?=
 =?utf-8?B?MEo0a0l4TnVjdktzQlJYRkhzNWdIMjljWnF5WU83YW5EQUFHZUVkSHcyNHN3?=
 =?utf-8?B?VmhsWmc3TCs5enVJbDJyUVhPaUgvMk5Jcjd5bWQwZ1N2bVpsdlMrYlQyL3RM?=
 =?utf-8?B?TGI5TllJeUxIR3A3WWM2dUFFb1c0ZkZpcTZHWWhuWmtkNG94RFM4eEFmS2tU?=
 =?utf-8?B?clRhVFpZeWRzUk9xNGhyNVFra3I1Qm5NeXM2ZlNDc1FFLzhqWHA5a0dwclJu?=
 =?utf-8?B?aHZQVFpRNW92a0JVR0JER2J4cktvdHVqSm1ZcjZYbWhtRmJOY2gxR2xmamsw?=
 =?utf-8?B?S1R0NkIxZlRrcVMxcG95UTJ1cDR3Zy9HVlExNGZqbXNWTXo5Zm1KcG5na2VQ?=
 =?utf-8?B?dG9PZ2szY2dQQlhxSzJCOXprUmRqek5yZmMrbTU4NnVSOFFFU0lVV2FuMVZH?=
 =?utf-8?B?WmxnYi9vT3NuRExnVnpsblluT2h1Uk00b3hkNlg4TGkrTnVkRm05OU5IR3JI?=
 =?utf-8?B?WW1rKzIrVlMva0hXeC9tSjlZV0d1OU1oQzI1MHNyVWJZK1dVcERyWnViWEhW?=
 =?utf-8?B?enMvYnVzOW85cjVkWmZIdG5lb0lPREhhdkZGTllYWjZER2lmVkV6ZHBSMFNo?=
 =?utf-8?B?Tld4YkdGeE9aaHNNOXNuNXV6eERoQnZFQ3YzK09tMzVUREltSzhNWXVzL0g4?=
 =?utf-8?B?MU5aS3dxaS9DdWlleXFUWjEwQ05QMkJVM0UzUTY2S2cvT2krQ3hOTUFFcmRz?=
 =?utf-8?B?ekN3TlZycG1DNFZqbWpEOGw1bnhkVE1mZ240cC9HblNyckNhZysrVVo5bjZW?=
 =?utf-8?B?ZWgzVEMySDFiMnhiZUNMdHlOcXZ4QmhtRlArZFdmdzUwcXg1bXQ4QnNBOTlI?=
 =?utf-8?B?TWdGVzNMSUp1U2RNK0xuQVo2VG9rOThkanhOT3VyLytNNEpIQkJJV084cmRK?=
 =?utf-8?B?VFg2NGYwTmZiRENmQzdiejgvRlBONndPcWRaYlRHTVhYV2NEMVZERE9hQ2Qr?=
 =?utf-8?B?dTNTdlR3WjVpaEFhR0NQT3hKTStvd1lQb3FjWFR6QzNHTHRhM2hlV2prbm1G?=
 =?utf-8?B?aG9ta1N6OGp5YSs3QzRuQ1J2Z3kyWGJzSTlMdGlJZ2FIVFVnY0wreDZXeEpL?=
 =?utf-8?B?OUFqQXFZZGN2ck5rZTQ3RFNGYU5OQWpkM0ljdGlkd0FsVFZxd21Yb08wZVpY?=
 =?utf-8?B?QU1UNXdWblJmZC9vMEhHL0dGZGZOYVEwRHdGaWRFR0FlMm1CSEdRNWEyZDJ6?=
 =?utf-8?B?cjd3cEFSSjdhRk1uRzJBdFEzaFBtdFNOUG03ellIUFdodVF1TEc5TUhJaGF2?=
 =?utf-8?B?UjJLTzc5dnB2Y2VoaDVPMjkwNXAvY3QzYXVSY05xWkdLRm1IMXUxbEh3ZlVQ?=
 =?utf-8?B?RmJBSTVQUmRqRmorNGM5Rzl3MUo1UUZsaXQvOU16OVIrTVRWVStmTmNoeWJR?=
 =?utf-8?B?QkZQOGg1M1VQSDBTNGhoQVYxTHV4V2JCNHZQNFBYTzJJOEs0SnZ0cENiUzMw?=
 =?utf-8?B?bjNWVVBlWnBlMmgyemZRTndkelplMWhaa080eDBDeDh0eXNWQzQzRTNEdlRW?=
 =?utf-8?B?ZUJzMm5nLzZuQ2lTeVY1M21ucEhUZC9xUklrNGlPcStHTDlQVS9admh5bEZj?=
 =?utf-8?B?ZUhpd2RzbFhITEt6K2k3bEFrMXZuNzRBRll1bkRaWndlODA5a3djNXRCVG5G?=
 =?utf-8?B?VE1KNkxHU3JIYWVVQU1uVUtlOFZKVG9vWkRqODQxTHltdE9QdU9GTGlvL3py?=
 =?utf-8?B?eU5LdEc5clJwZTY2L2RXaWZ6Q1RRVXZRVWZDdVd6dmpBRnhHc2JJZHBXNlBv?=
 =?utf-8?B?NzhBUHdiZUt2b1M5eUxMd0doZVlmTWlYZER5c1BtNm9mSERtNW5sQUU0dGlD?=
 =?utf-8?B?UXEyKy9LREczVnR2cHgxK0toTmplV0liMlJFdEl4VU9GQnZ6dVcxZGJ1ajl0?=
 =?utf-8?B?OUQ4UW9ibnMxZmp3ZGFkbS9EL2xEN0hrSzRUOVMzSFZwR3ZkMmQ5UzVNM1Jw?=
 =?utf-8?B?ZFMwNHdIbFR3QkI5d05ubWVYMXd2U2NIR1JtU1poL1BYRVVlOWYwcGtSWTlW?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0239a9a8-6494-41d9-e3e1-08dc8412158c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:13:58.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21ZBgrvLdpCQ4/I7WYCOy4tmwK7J192M+IOOQa3MSHTsSfDY9Aa/XuvYrzoARchRn2novXdgNzq9GI3c6dl9oWQuZ8lwvQ+AGAciHzVjE3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
X-OriginatorOrg: intel.com



On 6/3/2024 11:47 AM, Joshua Hay wrote:
> There are several reasons for a TX completion to take longer than usual
> to be written back by HW. For example, the completion for a packet that
> misses a rule will have increased latency. The side effect of these
> variable latencies for any given packet is out of order completions. The
> stack sends packet X and Y. If packet X takes longer because of the rule
> miss in the example above, but packet Y hits, it can go on the wire
> immediately. Which also means it can be completed first.  The driver
> will then receive a completion for packet Y before packet X.  The driver
> will stash the buffers for packet X in a hash table to allow the tx send
> queue descriptors for both packet X and Y to be reused. The driver will
> receive the completion for packet X sometime later and have to search
> the hash table for the associated packet.
> 
> The driver cleans packets directly on the ring first, i.e. not out of
> order completions since they are to some extent considered "slow(er)
> path". However, certain workloads can increase the frequency of out of
> order completions thus introducing even more latency into the cleaning
> path. Bump up the timeout value to account for these workloads.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

