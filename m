Return-Path: <netdev+bounces-141639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F99BBDB2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB471C21CAE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386F1CEEAA;
	Mon,  4 Nov 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bH9ygGHy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93161CCED8;
	Mon,  4 Nov 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747209; cv=fail; b=AlJTRMh9cpEQnRjXx0jTbRfrhpkXzzTkhCpqInypoBsuoC8qkyZiT/ioJcKf0iQ7rVcDnFPpxPb9DGbqhJOVz7by08d0DOXTXIYTc9s5UxNeX8OLS6KCZrL0bfvTCEGi1dKnOae78Ok9Ho8hUUYvNccmsoqanuQMGLZmTwGeoLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747209; c=relaxed/simple;
	bh=YlktbZRsVD3Jx5d7mQRlClOgdJ1CGqFhGPkXGOV0img=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZT3QaO+02MVgVH16ZDDn7oDDSR78v1lMCEE18fNeov/XmYMMq7ndvF01tKm2OBj+xyAG4k/+49b8dYlWH2/V5qQT3I7CxElPdmYhxtXlgN5WyKTY+oJVi6wEhRVZGr3W2LUr20O4SmHDITwmwUU14YYQ8pT6pAA5Ap23x+LNaEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bH9ygGHy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730747209; x=1762283209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YlktbZRsVD3Jx5d7mQRlClOgdJ1CGqFhGPkXGOV0img=;
  b=bH9ygGHy/myv2Eg5oZx2zAlM7rzE1XXtCmmf33xA86XaBBW2TES2qKNL
   vsyVStGvcYhY5KZOatDISOQaRW49jj5EbyGR3BJrF4rVezEJqhexe6MCV
   Uth6Oz1xcftPrB0W9UM4dFiaf//b+v74sZuU+gFJeP3UpLZBdkSlSYibd
   klS1GUfqI0Y1ZhNotyVyVYzeRjNif64MmtYi+pOizRddlnvIg3gmnoFzE
   9amP1K2iZjxJWFSBeXmmjk/YuQ/H8iiYp/2Ul3TBaw3AaSpW2GJxHaTlU
   +RuTpv3iWULaujzOa1p77WJUFu4Tyxx0pOu/AKK7TKtzQgYi2SYyxKAVS
   g==;
X-CSE-ConnectionGUID: FRAvP7vzRIyXzMDIhY4wgA==
X-CSE-MsgGUID: bCX30uY2SUugqHuBAWVU5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30575074"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="30575074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 11:06:48 -0800
X-CSE-ConnectionGUID: 9UQVJC/3SMmtOHXTNDJl+w==
X-CSE-MsgGUID: 624DUCQJQVOz5k+BmdbgNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="88571095"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 11:06:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 11:06:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 11:06:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 11:06:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIsaxZN3yart0qtrjhes/WvsdJV89Kr2eUcYJ5fpGcb57+brPBk0EmHgOhi+4UflMu+STQVE5psCLPWWfJtBABqgxMUPYH1ITjHN5wT/UHt+ihFxlaiuPUakMEzNWXdMzHArFvJijkpkuWUgqIDvr33/D6IXeVNiJUyytSa4rw09YcfmNFmcOQ4Pu+hGKSsyENvlQfpgo3iVL+eayRIqCwzou7Qo/pDkeAiXWFyM8YJXl1LshqbBlf96jRuHRv1dsPJVv5icRoyhnhk6+njzIhXCidtRJFyi/2VHWXug4Zdix+YVJLkaJamxw4tBLquMLtgWqzE3EV7SuQpejrVvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKElhRhaLtghUrJuEYq2TVGfHUE/Iki1cyyATx914TY=;
 b=BWQDSiv+p8UpxllLhr513mRp22hFx3x1ceGtRGrQbcmej7b+AGbXS4iiphBKj8I6qRh7SLEumlOlWdUOY8XaMc0GfxBbv5Ph+WBFEYDkxtC3mAlPGwmQscQFFa3TG+RGhu8wYJylaGxydUq1e9TrACiVSP5by1i/ENGGX1T7Vq6tQGPC3J9ynFfPOJj7Avvu3jWUz+ygNYA9eWqOMr0cSAiRBYDSQWBggUUo9nq5yGT11vH7U+oq23wLm3LX4zrKpvxqvIPEiukbFFP0H7lFSDhLNL9Ef8aQBavzC6ZdTSnYyvZtbBCYW3kB3h15vZHKhyy59gfTXb69dp7TGXrR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 19:06:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 19:06:33 +0000
Message-ID: <30df1dc6-1206-4584-89de-e223e5f7d3ac@intel.com>
Date: Mon, 4 Nov 2024 11:06:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/9] lib: packing: add pack_fields() and
 unpack_fields()
To: Jakub Kicinski <kuba@kernel.org>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-3-734776c88e40@intel.com>
 <20241103103142.4ba70d58@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241103103142.4ba70d58@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 470a648a-0ba6-4338-44f9-08dcfd03cc6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5SakZYS1ZvcDFBdW4wTGI1amhjRjk5ZWZKenZueUphZUNzdTdLUWdtekZw?=
 =?utf-8?B?NlNldVk4VUVZTXpkcHkxR1BnS0NaaEMyZVVMcncvd240NklRT3d6T0p3eXNt?=
 =?utf-8?B?ZGdDczJBZzg1R2dOaWNhZHQ1V1JvSTIweFpiczJxRktrRUpBcmNINlN4NFlT?=
 =?utf-8?B?MzZYZlhaTGtGTHA5dlVtRVVYd1BJTnRZUS9xK0JTakJJc0tUbS81UXBjSlBa?=
 =?utf-8?B?cjhSREw3dW92YkkyWW82OEFzVDJYU0YwZUZJNjdSa1FCRzI3VDcwcG5uN0dy?=
 =?utf-8?B?bHJPU2ZmUzhxSVlDTXJLcExuNjc3Y01HdkdYV0J4dktndWN1dVZmbkYxZ2Q4?=
 =?utf-8?B?cVN6cTR6bFZFZ0grWk9kY3JYbnh2UFVoOXVYRXNBTEhzTURCcG5tOHM1SVZy?=
 =?utf-8?B?NHU5aVJPT2xLK29OLzZaV0ZQNEdoTWdtWndvYjNHQjdsV0J5cTNEbER4MEpW?=
 =?utf-8?B?QzYzQ1J1bHFYazdKQlh3bUZwK24xd29hQ3pJa1pDT0RQakpzTDFzQ05KNUZE?=
 =?utf-8?B?R01hWGFodkxCR0tsSnYyeS81eE43UlVvTWh5RS90Y3VLRGdiWkZYdXF2OXFz?=
 =?utf-8?B?UHR4eTlRb0pINVNEOFhseFZNQWJlUUJUbUNXMEFoSC9RdnA4bk9VOFJ5ditF?=
 =?utf-8?B?WnRhaEtrQlBQRDFFRENJemZUaThQOFNPMS9RV2tHWXNrU2JDRUl2MUhPdHRa?=
 =?utf-8?B?TkpFNnVCRURHa3BPNzRuZ2daTEFwcUhGWjlWaVN3eEMzUDUvaEtnbGVTM2xq?=
 =?utf-8?B?aEdEYWFxYzhKYzdGZmFIZFJnUGVXOE9ILzVJS2VpbnpHRytyZ1MzbjBMclQw?=
 =?utf-8?B?cmJ1d0tDRlg0MjNGd0xoN3d6Vi9GYllpcGdyTjNvYlpiRGFMOUFTMll3V2lz?=
 =?utf-8?B?RjE3aFk0c0lMOVZJSWYzcHVVTnl3aGlieVlmd2RCWmNZN3gzTUMzMWFXSE0r?=
 =?utf-8?B?clJ6UjJ6NndnbUdVbmpHdktjbXlETjRMMGVyaUg0azBOeGczeXZWZmNIa1d6?=
 =?utf-8?B?QlBzOWx5Q2xNNWtXZGNPRUhnVnYwd2ZNK29oQlp3azJ5TVBvbEpMV1lISm96?=
 =?utf-8?B?NzZtQTBrcUZPZzNndlBvQkhKMVgxYjRmVGw2NHFnT0lUS0xCZ0I2c2xFR25z?=
 =?utf-8?B?VzFrYlM3S2xpV2lzcGxFd1oyei9PYzYvdmN6VGxQVzd4UUxBK2gyemZkUi9M?=
 =?utf-8?B?NW5DSmpTSDd6MmdaNUp5dlZOOUZVNHlGVDJqbUVTVmtWYlRWRTUvVHFGOS90?=
 =?utf-8?B?YURVVmpSa3hhOGtaV09vWTV4TWFnR01LNDlFb2JSK2pOeVJ4VlY1N3JIUlJl?=
 =?utf-8?B?eHpPemszcGI3Qyt0aUQreWRqRTNVdTJyOGdNNGRaU2Zqb2F2dDNBMHNOU3dz?=
 =?utf-8?B?blBuNmdSR1A2aDZYVDQzN1JibXA0RE5vMUpDMDRVOWMyRnlhYk1WSWRFRnVo?=
 =?utf-8?B?dE1sZ0RkRGl1QlJZSEhpWmVZREc4dE91VzdtU2h0aE1Nbm9GS1dZUVc0MlRD?=
 =?utf-8?B?S01vSmJjcWpoNEk0TzJuaHNERUF6RlpiRzJ6S1o4SXhFc3pqeXlGQnNLczFu?=
 =?utf-8?B?OTA0T29LVUNJTmhWbkwxK2dDcU9VSW5vZUwzZHJESThWbXRmUnF6Z0QydFNH?=
 =?utf-8?B?N2pHaUU0bWY4bmF5dUhDeUtlb3JWOWYwQTVaR1Q3STh1ejFvM0QySXc4aGk2?=
 =?utf-8?B?K05ORUpDcVpLQzBUaHIvY1Fua3ZNL3E3cUJ4TnlxN1Q2eC9PREtRbnZVSnZr?=
 =?utf-8?Q?DSRba5VhHdFicDI+XyQQhL7xl+YfzkCjYvAnNjV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFEakNmZ3NsT3pkRGJtb0hERnZYYTREYU5SZGdMT2p3eVJBUDdGYWJnZU1K?=
 =?utf-8?B?M3o4ckVNcGJZazAyTENzclFaaFNkWmJ2U1pRZzdMWlpiM2VWQkxNVE00c3dT?=
 =?utf-8?B?RlEyWXRPK2lFc0Z3UWRHQ293TE95czN3ME9jYUoxSTNyQUhwU2k0STFlM0Zy?=
 =?utf-8?B?QWVwdzdHTHpmQm5ua1RxQ1RRaW1ISEx3YjhwMyt1aWhDWHBicUJybHAvWGNm?=
 =?utf-8?B?cUxSdmVLNzRFNzdVMGZUNFp6MDBlV1B5bnZ3Q3JZSGRhOGFMcGNwTDFjVzlJ?=
 =?utf-8?B?YWpwem10MmZSZDJvZG5SaE5NdVRyWS9EZVZMWWZxaUZhN1N3RVF3TkM1azFs?=
 =?utf-8?B?RnluOGI3S1F5alhuYWRDVHdQQUVEYTBKU0s3NmY5U3dwNldsQ3AwbzR3Sjlp?=
 =?utf-8?B?OW0yOW5EUDdWdFdERVNnQytWU21WNWsyMC9WejFyNGpjMHBpa0E2bG1teDMz?=
 =?utf-8?B?Wnhrd2ZMN1h4b1JIeWF2S0NHUzk3UkZYYUR1S1dkUElQT0w0TUJlWG1uclFi?=
 =?utf-8?B?S2U5NTZwdG9SVEgxSkVFbW5PSHg1akczNE1FaGJEaG5QVUhXdytMVlJhMFBB?=
 =?utf-8?B?NlRrMlVibkc1ZDdmSDBJYnR1NUpETktleHhncWVRZjZoalB4b0NKQ0dPSjBt?=
 =?utf-8?B?eEJJMjMzOTJSeUpia1VvWmdWc2wxTTk4T2NqVTZzV0hIWFBPRi9mUGFYK1By?=
 =?utf-8?B?UTI5cUxYR1hjeGFhWjZhcnRhcjBlMUdVUnpxWEYxbkpQSVM1V1djenJibDY4?=
 =?utf-8?B?cWQzV05PM0N5VkRBTVlWYTA0WWFVZ3VURmhtejIrOE5RQmh3cHIwOTcreWl2?=
 =?utf-8?B?bmtQU0xoK1BEZWtEa294bDhGYWkrbkZOL1E0L2swa0JMZUhPb0xKYmZ4bjEr?=
 =?utf-8?B?b1VWVVp4bkljOUN0UTdmOUlXang1bE10L1I4VEY4WjgwT2RKQnJJdDJxejcw?=
 =?utf-8?B?Mkx4UGJjdU9YQStOMXBxazVVVy85bVdhNUttMHRsaVJOL212MEVWZmNaWGFv?=
 =?utf-8?B?Mmtqc201RmROR3JJK1ZWdytUS0dVR1hGbHdQVlhzVnZQMzQwU2RKYTlFNi9I?=
 =?utf-8?B?c3d0azhHQTM0bmRKajdoem1QeGwrWlJLdElEWDJPNWZhR3pGS3VOS2NST1BV?=
 =?utf-8?B?UFpZQm1tTk9hRE9Ta1VSdDRiUzZOSlV3MnVURlVHckxyNGpxNitGZi9uRHZ2?=
 =?utf-8?B?OU5YN05oVUJmMmltcGs5ZWlxdmxvQzNJYXlnMmRSMU41MURuNGpQakdqQWFp?=
 =?utf-8?B?TnlUUUwwUWpyL2Z3VXhCOVZqNzEyd3J5NG85TDlHMXF6dnJLUVM2RDhNT1dN?=
 =?utf-8?B?bHUyelU0UU52WHlPTHVIYVNBNFZOdGk3M0xXTTZCSE01Mmw0UWdiVEFYdU9k?=
 =?utf-8?B?YzY2WFJYMnRTMGtyUDN0VkYvdnBGVHVFdERvc2ZGYXkrOG80ckdkVlhxZThl?=
 =?utf-8?B?SDBBM1FUdlhXV011WTM0Uy9VTW94akFYT08rR01QT0hIL1A2UVJNN3JUSlpE?=
 =?utf-8?B?Tm4yeEZlaXNtN0JMZGlZWHZMazVuNXRqb0ZFU1lUNWMxMS9Fc1ZubE9CNnN6?=
 =?utf-8?B?YyttdWR6UVo3VmQ4d2hYc1hibGZPVE01TmM1cUV3OC9FbTR4enBNQmVMVHpE?=
 =?utf-8?B?OWRwR3d6SEI1Zys0U3diS2I2Zm13b0FGaCtqNndpTDZCdGxKZlpNbjRydGQz?=
 =?utf-8?B?aXMycHdRM2Uyb3BFSHY2YmFyOUtmYUVmL3hCK0VLU05GV1R6bUtZZ3JKMkFX?=
 =?utf-8?B?ZGpXdE04M1lQaldHTDVRK1NkZFM1RjFEOU1DVmIrcExlNGlJek5aRVQranY4?=
 =?utf-8?B?Z3VsYlVPSGVxb0grb3UybDNERlNvQlg3STdQTDA0QTRjSHFoRVFEQU9WY3VQ?=
 =?utf-8?B?VFErWTl6dkV5ekk0TDlIZUkwUFZjTXQzaVc5QmtIM3pWWU80UGdhamc2SGU4?=
 =?utf-8?B?RXRSQml3M1I1a2NvMEJPTGI0TzZGa2VxNTdYZlMweUt2ek9uTkhFbFJONGtl?=
 =?utf-8?B?OVJGY2pUanhsVlQ2YXlWWi9lTFBxMzRTMU51c2ZOQXJWUHJGK1B6QmovM1lK?=
 =?utf-8?B?UlNtbW1PUGJSU1dVMFpaUDAwbHIyNHJQV2dRYXRPWk1hQkRSemJyNnQ2WEdr?=
 =?utf-8?B?VVVkeGpRaHZHN0NxeWZFaVVlbXBzYVFibC85YklEbkRYeVhwRE1FU204Y0kx?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a648a-0ba6-4338-44f9-08dcfd03cc6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:06:33.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGP6/wMVFXwA+moKf/Uxsekn7guS4lHjAvZaMvIYTTf8usn5iYCG/+6Gt4NRTBiQC7MmlUB7Y+vpFlrV4wp/wkjJROhprrdlNVLd2mDDkIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319
X-OriginatorOrg: intel.com



On 11/3/2024 10:31 AM, Jakub Kicinski wrote:
> On Fri, 25 Oct 2024 17:04:55 -0700 Jacob Keller wrote:
>> +ifdef CONFIG_PACKING_CHECK_FIELDS_1
>> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_1
>> +endif
>> +ifdef CONFIG_PACKING_CHECK_FIELDS_2
>> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_2
>> +endif
> [...]
>> +ifdef CONFIG_PACKING_CHECK_FIELDS_49
>> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_49
>> +endif
>> +ifdef CONFIG_PACKING_CHECK_FIELDS_50
>> +HOSTCFLAGS_lib/gen_packing_checks.o += -DPACKING_CHECK_FIELDS_50
> 
> This series is marked as Not Applicable in PW. Not sure why.
> 
> I can't bring myself to revive it, tho, this isn't pretty. 
> It'd be one thing to do the codegen and the ugly copy / paste
> 50 times in the lib/ but all drivers have to select all field 
> counts they use..
> 
> Since all you want is compile time checking and logic is quite
> well constrained - can we put the field definitions in a separate
> ro section and make modpost validate them?
> 

This is a much better idea actually. I think I can figure that out.

> Also Documentation needs to be extended with basic use examples.

Will fix in v3

