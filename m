Return-Path: <netdev+bounces-120045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C395809A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299FB281941
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB32189F3C;
	Tue, 20 Aug 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IM5HTdLz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA818E345;
	Tue, 20 Aug 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141448; cv=fail; b=clD9hiP7Jct0NERzeRFxIg4PLUk2EbysYBushrjrXDf2F94zCtMLPEEfiOiWK0JXrxRg3KFqsxqITry1p2GDmwxvzQY82xUDeVIHHmw+TTdSIziCSmC5JhJL1etuozziNO9GwSsLOs9jTTPqZNvSFa2accRmLXykJdDvzldaA5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141448; c=relaxed/simple;
	bh=FfFAe7EcbYLXTVttSGQlyshO6KfzA9JlWAl1AlqnELI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fp0o8ZjJQQf8HNga8mZTtpZFx15XXp3DJhELpKYK0mejhOMsHQAW/Fdd+rO4hRp0DFHvT+Fyd/09Dl8PWFYHQh7ONuGHzEChB/jAyb0dSjvmc2mp68NOsOfjta9ajjcjzJ2RjC9igpcs9r0HruwssaUNuj+EcZcLouzSCMw1jPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IM5HTdLz; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724141446; x=1755677446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FfFAe7EcbYLXTVttSGQlyshO6KfzA9JlWAl1AlqnELI=;
  b=IM5HTdLzcWPhIQxd8fhR9Eda85Ait3CfnQLzJnMN2SIxC9TUMuW+Zy7I
   e4cj40Z3/SztgmH63Xz73a49g8MqxVQcroF06/l/DRPkyygVW+Bkw9eRy
   jm5qqGhfTvZ5ckDejQMb+oSelKoPFeE17t0LJpBPX5iFD74Kiy01rqnh7
   pCxvF4VXRUmIfhR2oRwtU8nz0+c/kGqRnv9flI4CESFeFWIUiVstYMHgP
   XOV8UWzA2TVU+D9RBUz2+70Xy3jlyAjTT/tcqRBTp26ZA2YL6nw0BuSGq
   8+HKQuVxwYyFQkShw9gjDnSuTh/I/tVMiWpk1OaVLhAJN5S2W83Jtqgl+
   g==;
X-CSE-ConnectionGUID: dw/bM0RIQgmT75ggu5+LCA==
X-CSE-MsgGUID: DQs9HKUSTZ2CSBTQYeQHzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44947574"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="44947574"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:10:46 -0700
X-CSE-ConnectionGUID: n/7is1rhQVuxA8CHl3dzrw==
X-CSE-MsgGUID: yyesnMQOREGRQ6BMATB4Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91416636"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 01:10:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 01:10:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 01:10:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 01:10:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 01:10:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2fXKO82hyFq+BQq985nLtlfHZLAklYZrSB43bQur/4/GEkydwDl+FnfXk2TfB1Ke8ZGmjCbcPXLgicWKJifNVzqLzTep3Lj/Tm5EYZNwA/1oowWlWM+Uoj7v5KkC5fDPEB918mqFik+j1wNMnBbqsWx5VyW7loJS2PB3TlZ/YRxqGHwrm9qz0SSEoECl6klZt0nGGA9ZKxwqoXbY8LTm1/ooeucFN8tG/DL/cS+PXYGokkKmEosVPBtJWXaS92UsIc0OlCbAyCp0frNWDTkT0kUQrQ2NbfEPFFNJFaEHuJB1iIrS2O+bHFYGPR+k6YSByIaMdly5EW7HcTZNgI3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmDZk9uPFtcyhG3PyRCv30CzBceAxXCubWhUoENbs0w=;
 b=MQDpci7xdDyyofIBxoq+1hnPKMkZE5cRI7XdFQCFqApODDeo7GsxoWc15O4xhgyUn1476KdJSQHLSirUnVMmC0gZl98ukB2oJiayohVpBR3SEavhvvwph+egdQwhF9E8FAzus7YLkz7DiigWfAi0YeIT+EWZ2nQ7l7xZSHHc/d88NIOY7w+aCI+EUQtFFd6jQKl2+qfmlffBEjOWzNmY30fcHEalm1Ozz5e90/RC7N+9op3yjkLDnjW0ZsC9BJs1vIxQrhTlynOcfr0PS6JJVKUwUyW4FKQBbZNuiD+uyzuw/4BL9QuudmJeGbcx74Nz2wBk/dk70OazVPk970Uqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 08:10:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 08:10:42 +0000
Message-ID: <9b77e25c-8942-42f7-b82e-42b492b437d8@intel.com>
Date: Tue, 20 Aug 2024 10:10:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] nfc: st95hf: switch to using sleeping variants
 of gpiod API
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
References: <ZsPtCPwnXAyHG2Jq@google.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZsPtCPwnXAyHG2Jq@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4619:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ee791c-3ed4-4965-73f0-08dcc0ef95ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFJnTFdaWUk0NkxwbXZRTEZmMkZrdjdicUlEWTZ5dERJMnFnakl5dkx3eVR5?=
 =?utf-8?B?T0NPWGI0UGN5ajhjdHJOeVQ2YjdOMTBoYVV6MXdjSVE5V3FlVDNrakpXczJn?=
 =?utf-8?B?ay9HS3owVW9PYmViNXB1c200RktHMnIvaThqb09KZGpVcXh0a3VLTmZLV0FH?=
 =?utf-8?B?cWpqdHhGdHdML1g4RXh4M2pVUkJzSk93Q3Z5ODhwK0hsNDRSRWRLOUtVK2tM?=
 =?utf-8?B?NVE1V2hOSDVDdkVJL0o2WmZlai9lUXBTeXk5bHdGd2hOV0MwV0puaFY0bzdW?=
 =?utf-8?B?V1VJR0xhVUtsVXlDcmwvTjNpMjVvckpDQzlmUzRBUWdsdnJqU1Evcmc4SlNE?=
 =?utf-8?B?UXBhMWh1T2U0ZWJVNUQxQjZtLyt0RU0wZytXdUhnTjJydDZGcE5neSt4QlZR?=
 =?utf-8?B?TENTQW9HaDNNRXJBQlVxVFd3MkFnQ0ttaXUvOFJVeTEycDJSdVppSDdobFdu?=
 =?utf-8?B?WSs4L2NwZlFLdWk3TUJubno2N2g2bE1ITW1NSXR4Zm9kMVI5NzJhcXN4SHpV?=
 =?utf-8?B?VHNocEROMzlUbWJGcng4THR2eDdFMTBRaDdURlJ2R1ZZcEhra3hjQ25RM0FH?=
 =?utf-8?B?K3ZnbTJ5azRoYi9GdTFQWGZXNVhjVU9YVjUyV0dodGZQa2xQaDR3SVBZdkhG?=
 =?utf-8?B?ZW9ibmd4Sm5vQkREakU3WVRaS25HVzdLWkNKUlJoNFV0cERpem1kUGhwNEpx?=
 =?utf-8?B?S0NkcytQQ3FyVXA0SE1tNUNOdlNGZm1zcEF5YXM3QzE2OUM4dVQydGtNS3V0?=
 =?utf-8?B?cVo1djZCR3dmV2E3bTdmUWZMbmJ3VVZHZ1Rhb2krSDFwTFBLYnJ0VU02UFdG?=
 =?utf-8?B?N2tScFc5MFFNdlRXL2w2RHBnRm85RTN1VkJHUkZ6TGpIbU1rdWlSODE3cnpt?=
 =?utf-8?B?TTFaNndWL2FOdmRySzA4djVRVm1tbVpoMnI0c0tBdFJldHRnaFpyZlZubk1o?=
 =?utf-8?B?c1hTbXU3WVZVVy9ZL2lLeFZnbkt5cjREUnE5ODRHdHp2QU9xR29PcFdPbHZB?=
 =?utf-8?B?WHRlZmFDbE1QY2FmWGR4eXB3RXR1NnA4ODdFVDJoTkxaUmFmeXRLOFRSa1Bw?=
 =?utf-8?B?LzlJSEFzYUZiWURIeHo0anViVjdHVnJzKzY1WFVKWHI2dkJvcHgwZXlVNFZC?=
 =?utf-8?B?eXQzRE5zM3RhbDR6Z0FwdHRtcFYrcEhCQjQ1MHEyd1lGd0kyKzh5Znp3anJE?=
 =?utf-8?B?bGl1MTgxWDliN2lVS1REbzBzT0l3WHZmaEFjT2Z5T1NCejFUcU50V0NiWjgz?=
 =?utf-8?B?L045a2o3UTAxT2Rka2NUTThSRlJEcmlYbDNCSFZvNnhsYzl5RGg5Slc4ckxB?=
 =?utf-8?B?RW51VEJMbEg0THhiWWJNN2RLd2pmdDJKTVc0UUVETXg2U0FSY1RhR3NmMUhw?=
 =?utf-8?B?a3h2UlhiT0pNekNmd0czcnMxa0xHd1dGTVRtM200R3dpTGtmcFFhRmdzMU9z?=
 =?utf-8?B?WVozK0Yxd0diZ1gxbVh1THo0a1VqM0NoMGUwdlJkM1VIc1Npc2JGVE9jUjZJ?=
 =?utf-8?B?TmNCdjE2ZkJxcE5SdUdTQ1BYcnVmLytzazM2Y1RWaDJLQUY0a214b01SS0hQ?=
 =?utf-8?B?RktDM3U4Z1NSVVhwc1JuY2ZadWhPbnAweDJ1R0FiSm94clFUc2p1YWJPZmxr?=
 =?utf-8?B?V3U4ZUp5MFZ2eDZ6c1VWcno5YmNGY2tBMklyeGpZR3VDSTNITGIvMmtNbjZ6?=
 =?utf-8?B?K0cyMlEwYnBFZlVVWmRqMEFPTG1jWmQ2NUtWdXo3dFNyLzNvU1lHTmQyeENy?=
 =?utf-8?B?M1M4clY3RE95Qm1LSkxWNGRWWjNZZ0ZYTEhFTFVYWUZ6NkJtbFVWY21XZWU3?=
 =?utf-8?B?bjhvUHBNK25FNlFPZkdSQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0MrWEVtUE8rYVdORi82cFlXMXNoT3ErRW0ya1ViTFI5QVJ1L2s2QnJCa2tM?=
 =?utf-8?B?T2laU2RnS1dlcGx0eVNZWVV1bitIaklRNnVsc2RhU24zSjhZN2hISmRzVk1U?=
 =?utf-8?B?OHJHdktyeHZSZ1pvQWVFd2ZoYlF0ek91QU5DOGFiRkFCS0REZm5YaEY4TTJQ?=
 =?utf-8?B?c043SWQrUjdVOVljU3FZYkZIQXRDYmR0dDByUGtYYmhnbTlqemVEOHVmVXYy?=
 =?utf-8?B?aUVSTE5qUkZ1aXJLSU44d0ozU0ZGQ3lNb1NyN2YzeC9EZlFKMjV0blBMMy8w?=
 =?utf-8?B?SDJBWEkxM0pRa2xXQ1dPYUliUnJDcFFCT1BTczBZdWsyeFN2TDFKMUVGTG1Y?=
 =?utf-8?B?S1c2cmErcEJINzkyY0dUYXJvY3ZmN3NOa3VjdlJYTHEzQVpxMWt3M21lRkYx?=
 =?utf-8?B?Q2xwaGVwWjFzWGk2dEZoZEsxZGxNRjFGLzJ1eEFYd3llczVoV3ZCYlVXZzlK?=
 =?utf-8?B?M1NTQlAydnFrSURoUFZOTG9ZbFZYY2U3cHFqdVFMTHZMWTZpdG4xaUZRNGR3?=
 =?utf-8?B?bkxsdmhmendQa3Y5MDNVY0x3Qk5HV2psV3l5MW5lRmdwT0ZFODVtYTBQNWww?=
 =?utf-8?B?QTVFeFgwd25YNjBFUGxOakFvVlQ3S0pDSFpoS2FFYTk4ZWFXRmRNL1dOTmpQ?=
 =?utf-8?B?VnF3S2k5c1Y0TDF0MG52UVkvTWZFeWZtckw5cWJ4YzNKUG5EZVdoaTZsMUxp?=
 =?utf-8?B?dnczeTJlUGR3R291Qzk3SEswWnh3cmxkbklEeVJzclBBaWhqb0QzWm01YzRS?=
 =?utf-8?B?TkdzNVJQVVVXajY0VEl0SS83Tk1EUXFyL0dad3ZGZUJNZjJXT1lnY3c2bk5p?=
 =?utf-8?B?VFRiSkxSNm03SHRVd0FGL1dEWGxtODFRemcwT2s4eTdlWTZFWGVNamRhZGl3?=
 =?utf-8?B?WW5qb1F1eThMU0JGNmVoUlhVU3N6OUh6Z0NhSklWb3hsNjh2NFJGS1dQRFRq?=
 =?utf-8?B?RDVkTFh6amNrREJUU3RJNDRHS0ZDWjhmd2NmT3lkVkVjU2VKTmZ5YmZubERx?=
 =?utf-8?B?Q3BRNElwMTZEVUFsNWlIMXAwRkRreHFCeFJZWWViTHNWWnp2c1YrUGVlVkZh?=
 =?utf-8?B?c2hZRi8rUHFqTEhtMzU1REE3OTl2ZVRNbTJsWmlZQ3NNVlF0RW1MK1pNd2Vy?=
 =?utf-8?B?bGpMUEdYTUQ3OVl6Tm43Z0NaTWlhbUM1Yk9ydTYySE1XdHFJdU1ES28xQjlQ?=
 =?utf-8?B?eUJ6eHlOdWxycTh0Z0lUUk9wOGtqMDBGeEhXMVRjSzVvWUsyTmlLd1VsMUkv?=
 =?utf-8?B?aEhTck9iMDNOY0VKblJaamo2bjAvdzBZK0JXdXI5WXhtNjBXVU1yQnlIaWMz?=
 =?utf-8?B?aVhZNTVJdllRVTRZN08rb3B0VkUxUUpjemtlNjk2aU42d1EvQXh6MGRlOUVR?=
 =?utf-8?B?RllhMSt5aXNHM2NBRGw0cFlJSlhLQ2R3MDMrNUZiS0ZPaXN3d3h2UFhiV3Nw?=
 =?utf-8?B?NzFKUC9GbXVaSUp3WkNLOFVvZUNQRWlRUEVlUVNTL2psRVJXaUZ5WGhWVW9m?=
 =?utf-8?B?cW1zOGw3UDhiTFplZ2NTSW84SFZQbU4vWktGSVU3NWN5U2Y3MUZPL041OUE2?=
 =?utf-8?B?RGlwSXpTZmJ2UnZReUxNcWUrbnlKdFR1UWY3cHJqMFNZTEhXYkNtYXVHRGJ2?=
 =?utf-8?B?ODczcVM2SGQ4QXEvQk1WeVlzTzlpQVNFakFTNEdVVmpoYTB3K3lwN1JVV3I3?=
 =?utf-8?B?MXAvMC9XUTExWHdDYjVFaTlmeWE4U3E3NG9paVlxVzdUNUVHcmJXZDJITU1V?=
 =?utf-8?B?c3lXekZxN0QvYUt2eGY2bXNGL1FmZGZmSzJNK2RmZklKcG5IQ240N0pvdG1r?=
 =?utf-8?B?TW96ejFRVlJIM1A5UE92eHliQTUzVWl4OFRnYkIvdkN5eXFZa1BmSkJWSnJN?=
 =?utf-8?B?dk9Qc2xJVVZ2dUduemlJQlVCa0xYazFhY3dpVXFsTXJHYTIyelNZem42ekVL?=
 =?utf-8?B?VVpCbDRUMGcvVGRrZmdzazZaWWY1cnNNd081Nk8rMWtxaGowNE04a01WeCtZ?=
 =?utf-8?B?ZE1pVmNjbWw4b1ZiaGp0OGQ3R2tiVE1tc2I0QXFodnZ2clhLTHhPVGFnRUdl?=
 =?utf-8?B?UlByakJvSWtuclBWR2J0SWRwQTRiWUJpa0RMSCtnT1dsUEk1Y1dtVjlNUWJs?=
 =?utf-8?B?VTcyZk9seEVDZEF6UmNiRmFOdWZPVXM1eEgvNDl1QmhjRGhCanp3NVFQNExm?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ee791c-3ed4-4965-73f0-08dcc0ef95ad
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:10:42.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMVc1VKSAG/RUBZhEbAESRKMz5sVCAmaU/sFppDj7OYug+yMqE0Na+NG7F8YRfjkryHn2M1fI4NACrzlvVcqNiloXZsXeGVnZmfKX61tfO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com

On 8/20/24 03:10, Dmitry Torokhov wrote:
> The driver does not not use gpiod API calls in an atomic context. Switch

please remove one "not"

> to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
> controllers that might need process context to operate.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Code is fine, but why not as a fix?

> ---
>   drivers/nfc/st95hf/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
> index ffe5b4eab457..5b3451fc4491 100644
> --- a/drivers/nfc/st95hf/core.c
> +++ b/drivers/nfc/st95hf/core.c
> @@ -450,19 +450,19 @@ static int st95hf_select_protocol(struct st95hf_context *stcontext, int type)
>   static void st95hf_send_st95enable_negativepulse(struct st95hf_context *st95con)
>   {
>   	/* First make irq_in pin high */
> -	gpiod_set_value(st95con->enable_gpiod, HIGH);
> +	gpiod_set_value_cansleep(st95con->enable_gpiod, HIGH);
>   
>   	/* wait for 1 milisecond */
>   	usleep_range(1000, 2000);
>   
>   	/* Make irq_in pin low */
> -	gpiod_set_value(st95con->enable_gpiod, LOW);
> +	gpiod_set_value_cansleep(st95con->enable_gpiod, LOW);
>   
>   	/* wait for minimum interrupt pulse to make st95 active */
>   	usleep_range(1000, 2000);
>   
>   	/* At end make it high */
> -	gpiod_set_value(st95con->enable_gpiod, HIGH);
> +	gpiod_set_value_cansleep(st95con->enable_gpiod, HIGH);
>   }
>   
>   /*


