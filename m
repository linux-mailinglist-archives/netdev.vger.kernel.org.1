Return-Path: <netdev+bounces-130971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C245798C4BC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F9AB21B33
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBF1CC151;
	Tue,  1 Oct 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2ifd52o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5971CB521;
	Tue,  1 Oct 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804628; cv=fail; b=N4kR2UdczhgZhDmAerWL+r8uaAhapjAtM/vygp3cJEgnDO58iaCPfZqfY4o4ZnSDqK4YJweERsAaLZICsi1pI5lSiNlsrHuSWDxa3fxtKkrCxjv6r1PWbGITpxaf3tGQKdrYD/3YunZ8+A7zVISwiEOrx1IYKYesxSmkbSOB4nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804628; c=relaxed/simple;
	bh=2yRafni2JGsPNZca/Wpw4VfonG2e/3OOBOnqsFvAD/k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzYykjeCrQEu0hng0hPtahAcH7NqqV7xOIXZoMV+R/OINxC/SUhhm47fyfRmVULNu5Pp8pSiQSZ2e/hXA+r1KZtwQ2sIgtdcthdeBIWmCAW02pP6gEPnA1RTbtUqws4Rs8LfO2NV3I6ZkmCvR+/f0AxIgXDUUWVTe2y682QIG/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2ifd52o; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727804626; x=1759340626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2yRafni2JGsPNZca/Wpw4VfonG2e/3OOBOnqsFvAD/k=;
  b=A2ifd52oKFUdpEi0PJ9M37PIpdQcV9+6jArxIzuH2gWnnzh/IgCf4RFo
   YGo0fwGKWkTIMqoceF9jnkDdXGxj6yKI5+w9bIjMCQ+urKglcXRG90f+g
   ghLP7PuXWrPkcnmLYhTNTR9n78WfxfNFFQFdfCU83B4dhYzkBBu2GwYbQ
   51IWGVw73njTiXj8VrlPGaIZh+7BMhBu7j19mwlPxkOy/p+t1edBH+gdk
   kNxFOVPNRa80VsEI8Y7vTMj4twz5HHn4rCC+J8pAowA3LwMLNdbCZF2Oz
   sSbwiwobGYrTKAjsMnHS+jDDO2xRiiQ6Eq2+8d/QiP9i/RNjYMk23Sca4
   w==;
X-CSE-ConnectionGUID: tLPVv7hBSlqLZncXfcwOKA==
X-CSE-MsgGUID: EcZGlPCgSFeX+8UqRECekA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27092807"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27092807"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:43:46 -0700
X-CSE-ConnectionGUID: kZSyIOs2SR+Mwg/DGf2JrA==
X-CSE-MsgGUID: w4gGRpG9R72qKNasu/Fo8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="104526979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:43:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:43:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:43:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pqnzt1P6jw/mJOspN7q/0ujnZ13QPwo1ct6upysbRMY0W/29A9LRAn2WFxt2Rs28vQFEMpqOThLoaqAht9rWAXWHuxMyMJeSL0ed9ioe4I8T1Djy62UZQTlYx2FfTaZOE4MyXs4qkdH/CbNKorLqKYzm+Gt60dlN9NPInNG1WOK3zENpJczgt5zKtdTO/5GjmtPoOeWvnSqsAyIfHNN2UgDeQpe6S6sNvx80NsWlesr/mTWwDb1lLA+kYjRm39XYG4P8/3Ox17ciAfMAdcSqY0lOGMU6QRbcNx53keuc7VeM6zBItL8OOqK84Nuy871PUTWBH81GdoAK68QszhjeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCb04z8yP09uRBgceB/0O9zNohKd8aC6xAt+Y20Vo3U=;
 b=QbiD3AexRiGB8juugCne5BfcD2KLHyPUFNPMWQ0Zx8aMfl1Q78jrPyw/BBzEqk+Zk+dx+259akjvNxA8115zpiusS0O9Jtj74NY6X73bFpIrPEP/DimorSSmvbZmqYjhg9jmikROK2TLiHBykwb2mEV5Cz2TdoiWV95pzzU2+Dv4MeRUXQ2H9OxiQhHMuee+LyOPXTbE6AIRTwDPIo+OtWaaDG1mEXhcTvgqGDMB2E11ct5LUMCRlkYoRFE5e86YD7Rp91yuqireAhQ5R+6s67GxvhzmXMJ88fb4e0bcKAScoh/8PCoIJBdrzUEELIBYiY0J682HGQSk9LcVyF+/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:43:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:43:41 +0000
Message-ID: <0886cbca-f1bf-483e-b23d-fb1b2fabeec7@intel.com>
Date: Tue, 1 Oct 2024 10:43:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net: sparx5: add support for private match
 data
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-1-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-1-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 75764cea-b3fd-461b-0825-08dce24096eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2RQRDd5T0ZSeE5iZWhjeWNLMTZ3eXV6a05WZzFTOGM2Q290RkRmak9IT1JT?=
 =?utf-8?B?NXRXdDVURnRjR2FTc1htdVNPOHQxMFpXbE9vLzljaUZHVXozeDdHTlZzUHYr?=
 =?utf-8?B?YUNLN1EwQlBBNFlpa3VORU1odDE4QnQvQUhjNEdxNjdlZ0FLTWZjdDhTcVl4?=
 =?utf-8?B?Ym5YTDBQWGltbmxyWG5QZkh4YlZnMnRNd29Ld1BLUWpmWTM5ZFUxdzd2NUVT?=
 =?utf-8?B?UWpHNm1DU21nN0NrUVlKNzdNZjV4eHNHM1dNZnZENnRsSGJIeUsxSnoxT0Mv?=
 =?utf-8?B?VlJ5UUNtRzBnU2I4eTlvU21Bcnpmck5kMVhxQkNtdFBuT0hhZlZKQXU4Uk9t?=
 =?utf-8?B?WlNTWUF6WEoyeFEzYmllUG9CRG5WallEVDF3WmM1SEc5MmtjMTFkaHoyRkkx?=
 =?utf-8?B?RUxkSnp4anlkSDNBOUJ4TTF1c0N2TlVmTHlSRlFlS1FFVndnNFQyVjRuMmM5?=
 =?utf-8?B?NFRKcTkxWnpvQkN1U3I0YUFZeGl6SVdaWG96SjVDSituQXhFQzlJRFN3bUkr?=
 =?utf-8?B?NXhqZG5vMXZjRnRWVkNUVFBGeU5FZWlabU0veThDZ1JOa0FJcWIyTWtSL0hz?=
 =?utf-8?B?Y0oxY1VoRlNDRVBGY3ZPcU8rb1UzS1JUUW9wc2xXeFdMcktualE1dVRPbXNY?=
 =?utf-8?B?eDkxVGxYTUgvZHBCUHZHUDYza2VWR21Kb2JKS1hjcjVWRTQveU1UTDliOGFD?=
 =?utf-8?B?c3g5RU1lRUdLUnh3Z2VLRXJKL293L0p2enB2bnE5Yi9hQlZNTUV5RDErOU5r?=
 =?utf-8?B?d0kybVBNSEdINmpBK05XRkplTEhERW5mRDJDTFF0MTl2YWRXMXAvZVcwaTVP?=
 =?utf-8?B?ajV3QWptbWtzbncvLzl2MThIRjl4K0UweWQrdFRNK0xEaDQyZmY2blFacTM4?=
 =?utf-8?B?MjB2SmlLMk5GS0E5QWsxaDh4dmdGS2JWZTE3dUdYZ2tDNXhYU2xwU3dOMFdt?=
 =?utf-8?B?V2pTZGdrN0tIaFYyUlJ5WkRlWVlJSlN1ejBtTWowSXRGNW1TckRtdnoycDJr?=
 =?utf-8?B?bjRFUXFHcEFoWHVWTWx2VUdvK29UZTUwcThHSkV4MVpOWmk1bWViRjhrcFha?=
 =?utf-8?B?UTVsQTdYWlJ0YWF6MUJ4NWFySWtqYnM0QVJwUnRwWWppb0JUeHVIaHgyWXBh?=
 =?utf-8?B?RkcyMGppbjVFc2h3MHR1SUgwcUxoM1h1ak9FY3FIVEJaYnZVUG5Cd09QUlNC?=
 =?utf-8?B?cVZWM3pFT0ZKZGlXZXJIeVN3YmZiM3RlNGI5YWJSVnE0elhPQjFiTWFJTGJh?=
 =?utf-8?B?YUpZTGNqVS8rdlVMZVZFdWZsVmk0aDJBSkpYRFk5U2NobFVKOUFnZ0V1OXFo?=
 =?utf-8?B?WnYwOWZEZzBWNGxOaktQVDlLR0VkNGRJcWwyeVA0Y0VrSFFIbERFUXExcElH?=
 =?utf-8?B?Zm91ZUptRU1ycy9zeEFScHJNaE5BemttdWl1Ymo4aitNd1FhUkJMMkMrSWxS?=
 =?utf-8?B?Y3lWT2RFNFhuWThycEFzTk1CUjdlWjBIalJDVDZNTXM2Q3JRbVlBVkZQbEVW?=
 =?utf-8?B?cjRncWJjOHBGZnhPLy9xdnQ1TGxIZC9iT2xaL3IxSmplc1dLS0JEZ3RwcFpC?=
 =?utf-8?B?bXl6QmdOa1hETVdXMkx2MXRLeWIxSG1lbXV3Vk9EUVdWeC9PR0FOdmZ4aXRa?=
 =?utf-8?B?eUF1WURnaDI0SW0xczVKeC9kRDRtUnh2N3RHQmRUQ3l6M1dPUndyMjVpR1h5?=
 =?utf-8?B?Wks3VUZ1SHRFc3N0Wk12WXBPS0pZYUxMU1BXSWN1dUp5Vzh3eDcvR1J2cnNu?=
 =?utf-8?Q?t01DAxaVWLJOwNt5eiQKg+3LVZFojEb3Mwd4Qwm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2w2Y3p1b2hIMEZvd0VWTCtKZnVIK3JzNFVVdk9XRWlsRllPVlFpQkJDUkRj?=
 =?utf-8?B?aytnMWd4cGw5dlI1KzFqbXhPeXdIYk1JcTk1UmlZNHNXcHZIT0EyUFB0enM3?=
 =?utf-8?B?RzhGcnBYRGdPeElMeThXWXpmUEF2eVR3VFlzRklpa3VzNGpHYVJwWC9saUh6?=
 =?utf-8?B?RTdPZzBreStjdXpDTUNSRmRxL3lObTc3RnRWS0h5a2F6K2RYRkZkaWh1dStu?=
 =?utf-8?B?TitoN3l6NnRWaVlaRmF1dHpCRWIrRThQSUhOTXBoYnIraGhmMDBzbFhUaEVa?=
 =?utf-8?B?a1ZHdkhFSGFSR2lnVTluL3FGSGMzV3RCWUs3OGRDWFZpY04yRlFpQ0RReVN5?=
 =?utf-8?B?dXRudU4yR2E4ano2cmdGWnRFcWJmNWl1VjBkc2lNa1dScHFrek9oSFZNVFR4?=
 =?utf-8?B?NXN3OEdEalZrak41azQwR3ZTd0NFSzl5aGtITjZGRmprbVB5S2tWMzgveU1U?=
 =?utf-8?B?ajVoUUR1RDc1WXlsWi90NGhZN2c5aks4Sm0wQ2M4dWJmRWxaMlF2Qnl3R3FK?=
 =?utf-8?B?YndDVU53ZXQxUCsxWlN5dGxKQ2V4Yk0rUkNTOGRheEZmTVZMbDBJdnVEODI0?=
 =?utf-8?B?eVh3d3FHOXowbk1QOUFpQ0ZiTERQZzdNY1k3alNQWWtsRVpxZk1adFFHSkxJ?=
 =?utf-8?B?aFRuVk0yNVU1RXF2VE5IY25WN3ZaVlEvWUtWVnlzWHlpTzhuRzVFQXJiLzZM?=
 =?utf-8?B?bWZuQm9KcVZFSXVSekpqT0h6SWExV3FVWXhSQ2ZNdlhjYm9sSjVGZStRMXoy?=
 =?utf-8?B?Smx3R09Mc2FjaXdMcExNV1B2SnRUK1k1OWJKazZiaS9pRnJTWVBkYjdPZVZD?=
 =?utf-8?B?ZmhZY1pEV0dNbVQyTE5TMm1EU2hnaGw1VDlSMHdabzlMc1o4NkJUR2FDMmZj?=
 =?utf-8?B?TzIyYWhmS0VYMGliUzQ1RmlmbERrOGROZHo3OVp1RVlOWDZrUHZuSGJwN0Rj?=
 =?utf-8?B?SDVEa3Q5OFF4T1h2WEF0SmxxUGRTOElycmVGRVYrK2o3VXhJMTNzRVhlSzYr?=
 =?utf-8?B?d1NhcXY4UW51SnZJUi9yZEVQaUxXOUhSV2g0Q1lqZXFNYlFMZ1Y0Ty9EYUN0?=
 =?utf-8?B?NFlFM0hFUThPUDZ1bnZBb1JwZU1JVWFmZUc2cTVENUh1YzFYNDFpMENpTFls?=
 =?utf-8?B?dlJLbUJjOGpuMU5aSk01TlZ2WTMrZEI5MnFDUWhOWXR5TEhHbVZybHQySWwv?=
 =?utf-8?B?VTI1bVZyUTBISml4c1JiOGZFSnVFbkg2VGdXRU4yWDBwdVpNV3N3cUtsdWNq?=
 =?utf-8?B?eFBjak1YcVN0Ly9OdU5Mc0NGeVNRaFlkUVFoVWRodlV4RkN4SFpIQU90V0ZL?=
 =?utf-8?B?MVRnZmlPckhvU1hFN2QxTTJGWCtMSUJUVW9WV2NwVnliR0owMWtrZUlIL1o2?=
 =?utf-8?B?VUM4U1AvS2JKTTB0eXVPWDdGZzZoOG4xeGN2MVBnZEx1MDNJR0NZUFUraGFL?=
 =?utf-8?B?QzlwN1pGbG5SQnEycHhzckk2OWRkVEU2STJOVzBaREhBL0dLZ01YeVgvdVZJ?=
 =?utf-8?B?RnI3RkVuS09WQzVtU3cxclliYkdDMTlGOEI4aFZnVDhKbjd6ZHJtUGwrTUdB?=
 =?utf-8?B?aStQeXlMRWlENTVHU2p0SE1tVExuK0lGT1pqWXFDYy95Vm4yUklLNkFmUGFJ?=
 =?utf-8?B?N1BQYlU4T0FwRjRWYVpqWTlzNU1sZmNwZWp6QUN3bTZxWFdxaFRHZXpIelFo?=
 =?utf-8?B?TkY2S21qemtVbk5teXBDRC9PSktNR0JQb1VEaU9DVnNIMHgyY3gvMC9YME5m?=
 =?utf-8?B?bU5SYmluUGZ1YkZzMU9GZlBGYnIzQ0VTMXRxSkNOUUNOMkxDek1JMVJOZysz?=
 =?utf-8?B?a3BKN2pxZTlIZFpwN0xXREtHN0VReWxsZWhvRjFPUzRVOVdZUHY1UHdjeHpR?=
 =?utf-8?B?WXRLWkVnV2tlZ0VadXZuNDRtT1hZcXoxWnRxcksvSjJDbVg3elFVRytENkhS?=
 =?utf-8?B?S01ZRnNlaGdyVHVmUDJNNjJtZmc3emU3K0tWcHJzWXFRUE1nZjk1U3lDRUh1?=
 =?utf-8?B?cFZGV080Tkk4NjRGMG1QL0p5YWtGRStQdE9udU1SNTJMZ29nUUlyMFJRZUpk?=
 =?utf-8?B?WlRFMis3bFdsaTkxZG05clFjamxRTWVLZG5SeitNaytMU1d2VG41S0RNazJv?=
 =?utf-8?B?V1pmRU5zaGJSRlVGczZseENoSzM2Zjdxd2xOdjVQUmZ0eXBwT1dtMkwyd3pO?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75764cea-b3fd-461b-0825-08dce24096eb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:43:41.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig5fbCEwk8cN3CVVTBj2zUUgYG25CB/N3vktmi+pER6MJ3WxHDSOE90voXm1NBHjMi54ROpKxGo0daGxI07yz0IO8pLBwv/SNzzDFg9ArM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> In preparation for lan969x, add support for private match data. This
> will be needed for abstracting away differences between the Sparx5 and
> lan969x platforms. We initially add values for: iomap, iomap size and
> ioranges. Update the use of these throughout.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---

Nice use of the match data here.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

