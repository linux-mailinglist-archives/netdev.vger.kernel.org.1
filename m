Return-Path: <netdev+bounces-71857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C732855595
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4311F23F5D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCD141986;
	Wed, 14 Feb 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eExolK6g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B513EFFE
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948855; cv=fail; b=OeFWtXsFhrw216fEfJLg+GzfaBtCe0DXtJuBV4ONEmbgE4I3iakX25ID/P8jh1euOaKvNs/f01uWlnZVEo264Wl8eEgn81Xd/ZhdoOop+efx/zbmxTAm8pXwo9dlUwu+udesLCNGD97IqC87BI1pNxhhYdIITCU2SWOw9BWwBIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948855; c=relaxed/simple;
	bh=Z39BNi/sX3AXkl3d4e6FDryaX/ca8klX6k/9AlLn6No=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TuOox2daMf4fxlrsF0PnDcX/SEwn4RJI6NtJR008wQA6v/0JE1ikrBuuxOhf4oyNVUMIrG55+4t712+vzlWIdEPeImbipBvpz8hDs3EQZq5kIzOAuNzaHZ1dNOW0mFRXIvbaZUCvoowvNe5BAJDZke439a/EDV78qCwEnBa+WcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eExolK6g; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948853; x=1739484853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z39BNi/sX3AXkl3d4e6FDryaX/ca8klX6k/9AlLn6No=;
  b=eExolK6gG9eJEDWOFd3WD2xPVWunmgrYgnn8XlUJTJmVCd8reEb2Agwr
   /bT1VNifiHaXdBOeVPJ00834TjXNdPCe5zu22Cavy8EVD+7zuQS+UOYP4
   WMfnsFBcquXcLr6WSYjnb9D1u2XRgPopoeewDEQ+ZgP2lcw6W9AUeLrTi
   PCUyv4vFqU0VSyGiMsg/MHe4Na4c5KsCBf31xmQWzNvs30hdqvBWMUVmm
   itYPOXw4M0xgFRavrKirfZYHzhpDgAj3m3mnxVHeWuK5xZJxa2upkwNz9
   rLTfXzZFNgcL2LOmhPheBASXEpDYReneAn4qfM839WpYJ6fc0MhCqKYKm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="27469516"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="27469516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="34145551"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:14:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:14:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:14:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:14:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7K1GPyMr/OjQj+wd89+kgC8deieeKHYxVhrwFqL2LtWWZ6s8k6ahkgx2E1/jQ9gETn0NpRRSCPyJa0KUUZUahaLts1GYp8Frpel2hMhUExtxiOamd25Yj0mQtZj+tUrQC/pK5UywnfJTZFHWeT5hCdYTvyWaMCvqgsHffWzfIvhNvtUhtyeIK5DjEkpsRGcezjG2sVUkZIKpON+z5ppaWrJFuROqyVdtJHEwd/ANa90/ah/2lRGLRr4rNMFi7B33rMzbhDgAObgb8IPpitQYpZId+gNs+y1T/qKMxHA7mFMSyhcWg8rftP64CB85ft3562xhkx1SewZeVmGs4U8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnXSsfX/RJMAmiQIWwyubl2pYvpKq66iU/OyN0+AGEU=;
 b=Q+ZzXLekg2RcWEjA0S9oEd6mxoPWnLVaJUuWULJUGjcBA/h4xCtfGnaupfMfDMnbYy890idKICiJOiqSNtImz0BKaHFMppNcDtDbwenZAlomes/f94uFmvm5yORKbCPWCynnxCoRM1VGRp1aeD/LsPwtNmcKqECH8Jc0COAruJrLynIloqyl4MB0HZVtbdBy2TxrZflpoGKJ6e3ftH1DfW93jzqbORnFeW797HRFcNt4xDqcC5EIyb02mNvfpQ8Z4wh4Vcknr5TeoY4wLgpZysi7bONZ6jkhoJEFrfGqtY08f1SkysEjNGbHp4rxMtZPvQqtbHJvOxX0j5eNIbRgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 22:14:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:14:04 +0000
Message-ID: <ecd1e9a6-4357-4a92-9024-a1b5c1f6496a@intel.com>
Date: Wed, 14 Feb 2024 14:14:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS
 routines
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Sudheesh Mavila
	<sudheesh.mavila@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-4-Raju.Rangoju@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214154842.3577628-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: e287ccf4-bf8f-49c1-745e-08dc2daa4179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNrglKk1xqWn9jn9GW0PseKltN1YK5usY+2TYzclL7Lir3YhZoxcm2EccZ/HU3ioJWZoFT6/5GimR5e+yibBS6E2a486jegXsndQLoy71mVjO/jMchKP5bBVGLf4pDt7vB7aDJYGkIyg3knvCoogaZSJMN5vBTJo++s0N77WzJ3sJMd371aI9I4HekZK021lxccW/50bOZeeyDgyXZ0nW/FZDRJiWcq27N5tGvYBLi0yEspglRhk/gL4puEXcu3TMuCyZXN48smZeTx2CyYDuzDCsTeKFawIsbcGqKuLz3gqTYbVBdvX2CQkcNdQEsR+uGvRVcz3/0w0u/+/4G17pkrXbks65Viv+ibjXkLkRZeKwJsGpLJveohBNRFZMYDJslJKvo/lpXcb1KUcVQ3nwJtQVgMvnow3bqbudbNHhy6BjxF4FWHRq47CSwsuMRI13dhClSX5W3uoe68/fRNIhlT+dixWeLioa/6emTrqlXK/zhan/LSG8eUZsweprn9Dbm4NDNmo2hXkCXrpx8/+RCbfWqsG2o+AQFrN0zOXIZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(86362001)(31696002)(41300700001)(26005)(2616005)(66899024)(38100700002)(6506007)(2906002)(6512007)(5660300002)(53546011)(66946007)(478600001)(82960400001)(4326008)(66556008)(6666004)(316002)(66476007)(8936002)(8676002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtGQnVseURPNGk3SkU2ZDNLN085WFJnZEpLaXNkcDdsc2VuMDl0L1ZzSlgv?=
 =?utf-8?B?eURKdVUrQit6Y0hSNjZVd0NYVVozQUx3bEU3UzdoWWs0Z2I0VjRqU2dRbnQ2?=
 =?utf-8?B?SStKOVBRWDhXaTdRdXRMMHJtVVZSRndzMVhoeHFwZWpCNm5nV2dkVTU3akJV?=
 =?utf-8?B?cjEwZjExWXRmRFR5V1B3dlVlOGloY2pQdHhSYUVWd0pVN0xodWhpbjc0dEY4?=
 =?utf-8?B?K2dPN2NkWjRGTUFZN1hDcVNSN2dnTWFlZzZXRnJncEZvSkx4dlJNWFlLNTVU?=
 =?utf-8?B?a2VUU2Vra0ZPUUJjSEtVcStVQlJveCtXWThhS1J1bytRSHk2QXpkdnh3aGFT?=
 =?utf-8?B?ZE94WUx2OEV6ZmQ0dnQvZ0xaSDVmQ1N6eWQ1akx6bDF2bW1nbVZLb2R4LzRm?=
 =?utf-8?B?M0I4YXQ1V2FxNENWWUFhZEpaWmp6L2dYbGlidkIrWjh6Ymo2Smx4Q2t5VXZr?=
 =?utf-8?B?YWZZUXZUZmVzRjZDWEVia25IekNrYVJMUTJBY3FtdVdkNzRQaDlHZ2NLMlVq?=
 =?utf-8?B?ZHIwZGxtdFArRWVQaGZTQm5KRWVRTXNmU056a3RrVWw0eUVYWFlaTnBDbFRV?=
 =?utf-8?B?NXhkNjA0WGhQMlZoeW93Tnlwdmxnd1c4ZmtoNE1oaklXVjlMdGVDUEJVaThZ?=
 =?utf-8?B?RHFwdEdhaXJqNXBFSm9GOWFmSUxWeXRKRWZLR1p2WDI2Wm5WUktFTHhqdlRW?=
 =?utf-8?B?NU1nWFFROFgvWlFNSHdBWmhRbUhGbE1Dbm5XSTVlVlN5RGlZZDdJVi9JMk15?=
 =?utf-8?B?TXpLNVd6b00wVEl5UTNQcTZpLzJMN003QVFPTlQvb1I3c0dnZ0VSczYxRnZG?=
 =?utf-8?B?S2lqaGlzTnhZQ1JkWnpaY0taQjRwQzFXMzJsSkowbHVJRFdQUGFFaU5iMmw2?=
 =?utf-8?B?ekhLbnp3SHNsMFdtem9keHg2bzNLU3krV0NBWE5XM0MrU0FUdVNVNWdiUjZD?=
 =?utf-8?B?dFc4VVFkZ1lxMHc4NUJpWjhMVnRERUNXSG54c0U2ay9RcWNnTmZUbWg1d2Rn?=
 =?utf-8?B?Nzdya3dMaWg0WjVoazRUbk9yaE1ZNU8xTkdjZEMwd3NiNE5KZDJPcUpvc3dq?=
 =?utf-8?B?dG1kbjdoVjFpazU3c3VaSXU0elo5RjhabVh0SUIxenlrT0pmRHpWUHB1L0xm?=
 =?utf-8?B?ZU1sT1U0VUhVTHhqNDBxWldVQ2llcmd0ZzVUSDVPWFJTbU1oVWh4SlROSXVD?=
 =?utf-8?B?endHSWd5eGVNcWdhcmcrT3hlRkl0cmZnSmlXSFRXY3BKN1p2Q2FxZEpyRTI4?=
 =?utf-8?B?OWRZMHI2c05TVmNCU3ZoZ3NsSlFhK3RJY3ZYWkk0YWlzdGhvQUlCNERMeTd4?=
 =?utf-8?B?N3Y0QlRFOXBaT0VTUHp0N0xZL0FCNTNNb3laQ09jcEVFbzRpcTJuYk1DS1VI?=
 =?utf-8?B?MVowWUcvcEVjTVk4MU90L1UxTDRhRm81bHRPTEJsaU1SUnA2RXNFR1hQVjdZ?=
 =?utf-8?B?N0xXcFVaeHB4U3c4ZDIxQTZNeDZtQWtmK0RSbkpoM2lFQU0xeE05T3B3ZmVV?=
 =?utf-8?B?RlVXaVErTG9LNGkzZGM4ZWoydnE2L0MrQkliTEU0TjZUZDRreVB0bThqdHVO?=
 =?utf-8?B?bVd4TVdnaDBHZW5yOUxjRGwrekdYRGRQSDJDQ0szUlhNdSt1bUJhY0RDMDV0?=
 =?utf-8?B?SkJuK3VrRnBWM1FsRDBRUThrRzFORGdCODY0VmQ2QVVSSUFrUzZRakxLMWZJ?=
 =?utf-8?B?UnlETHMzbzhOQ2hFM1FEMEFpaVVlaEdUVENUQjlGOWIrRWtOa1JJck5jeUth?=
 =?utf-8?B?cStOVUkxMUdOUGF6djd4azZJdjU5ZUFRcGxJWXFkZkFoZnhTVFBkTkpQNzNP?=
 =?utf-8?B?WmZ4em8xWGNVS1BTTE5tWFkvcVlZTjVWaENOdis1YTNQMXBJdW5FTk90Ym1E?=
 =?utf-8?B?S2FjVlYrcE1ZUituRi9QaXROdm5nNUhSckJIeW4zMGVuV2hRTzk0MDlVQVd2?=
 =?utf-8?B?bDBsenppdGYyVG9yMG5TQjFMRnlYVzAvVTNQTjZGTkJQRHpCbDhBWUY4aUkz?=
 =?utf-8?B?dmg0Q2dpRDRqc1JGcHlVT1U5alowaTliNWZkd0tDajBlMllyd01VZGE4Zm40?=
 =?utf-8?B?QTlHdlM3QWFVcjlmdGdUMDRYbEF2TTUzbmdBWXlwazVTWitYRC80NFhhL3o0?=
 =?utf-8?B?U1RkY3JoMldQanJQUm1iSGE3bGo0cGN4bDM0RVo5NGZOV2xvdWNIbXg1V050?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e287ccf4-bf8f-49c1-745e-08dc2daa4179
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:14:04.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IT55YR7SoP14woq0EA2C7ovUTQI+bS16jcpw5g6iIiMiSRYB6xtze9fx689UYmr8+uVbKRtO8EV4tsYFXwD5vam3RSMEmBr62V/U9o4fYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com



On 2/14/2024 7:48 AM, Raju Rangoju wrote:
> +/*
> + * AMD 10Gb Ethernet driver
> + *
> + * This file is available to you under your choice of the following two
> + * licenses:
> + *
> + * License 1: GPLv2

<snip>

> + * License 2: Modified BSD
> + *

<snip>

> + *
> + *     Author: Raju Rangoju <Raju.Rangoju@amd.com>
> + */
I'm not sure if its a strict policy but I thought Linux kernel switched
to using SPDX headers instead of fully copying license information
within each file...

See: Documentation/process/license-rules.rst:

> An alternative to boilerplate text is the use of Software Package Data
> Exchange (SPDX) license identifiers in each source file.  SPDX license
> identifiers are machine parsable and precise shorthands for the license
> under which the content of the file is contributed.  SPDX license
> identifiers are managed by the SPDX Workgroup at the Linux Foundation and
> have been agreed on by partners throughout the industry, tool vendors, and
> legal teams.  For further information see https://spdx.org/
> 
> The Linux kernel requires the precise SPDX identifier in all source files.
> The valid identifiers used in the kernel are explained in the section
> `License identifiers`_ and have been retrieved from the official SPDX
> license list at https://spdx.org/licenses/ along with the license texts.

This implies to me that we should prefer SPDX license identifiers,
rather than including the boilerplate here.

