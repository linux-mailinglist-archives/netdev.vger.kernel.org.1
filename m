Return-Path: <netdev+bounces-198297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C20ADBCE1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A025189165B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD4215F7C;
	Mon, 16 Jun 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2kAqBqY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017F19DF7A;
	Mon, 16 Jun 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113165; cv=fail; b=QdnAj1pGqh3d+W+dulYQkzcnZ4VqHwBGso2WvUVNEh5RazkUvDtKNRu+mHzTwQbsZukeE7k5MZLbfhQBHTmGCtKmrR/e/x38CqvbwDNJQJSbnH86EpD6HIeBJAl0RfUVrA+3u6DwLRz7ejCu3yplaNAPbcqCoQDXgiZnfQ4McsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113165; c=relaxed/simple;
	bh=cvfDVlJf2DHkD62Vlh+l/6yxE3ERhDZ3VdCuQBEuXu0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHD0YiifDVQopy7yw5lg/7jNSc21UJp56SNT2+443PYHu6lNJ8kKbMFS79aPAvS+qPDi20pobRhlL13jVkWeOIEwRxZTBLYjLJ8pSZLis1Z23GADeLQKsYbPK8VfK8UI0JLGyrmhE+baadsoLty83jZDESFUzVZp7RMOd0mTDvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2kAqBqY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750113164; x=1781649164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cvfDVlJf2DHkD62Vlh+l/6yxE3ERhDZ3VdCuQBEuXu0=;
  b=l2kAqBqYkyx4P1JUS55XPhX3xJY2J/QK3kzDWIkfqR/xJewbfM5v4Ael
   czXo7zbTU/QLigtI+gAU/HVeEAVTX6EjxgSWMRu2oa7jusa80nPrWVeCC
   k4K3ZrDuMka2WET6e+Gc7LHU654LvRYCQOtauhVtuQ38oDXVpQyago38r
   3Vd0WO9nt8W1+9+Mf9KbkkoKF56mC5DQ211U7+yYHj/AzilXxbjM63CxW
   U71DvJs4YcBu9Jmck/932IE/eynQlV4ypgEISMBdS2CpNhkjjW8XnRvtG
   JI8KcGap60YNsFbq27cWZ1JFHVjrtMlGd3hEoo1Pim7OQQA6+mtT+zHYh
   g==;
X-CSE-ConnectionGUID: B7uxWdFfSl2d0F8o/Wu6pg==
X-CSE-MsgGUID: iOaVcML0SC+qWQelJy+7Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62876481"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62876481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:32:40 -0700
X-CSE-ConnectionGUID: 345PVKRgSZm0Wkkd/k2UvA==
X-CSE-MsgGUID: 3oAXCmMOTm6qZ53TJCtIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153476753"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:32:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:32:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:32:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEYETmIlIDGG0eMoBV7p27bagLsRrLhsHMR4gHYnE/7hydvlR2qNnC5zY+W+pOQ39LXyIbwq0DTsXDOiWcFfARkdyp4k78dUBKa3APoUQHFcpgPurbLgVdN3tFyzd5hki1mgNd1tPioYhSZAHcLyz6FPUQH4rOnEaeIDDwkzmoIjFH/qvbr2JMCHDpro2BH8g1ECi/2IDjnfwyI+t4o3BY/pbl3LDvME4z2G6JOiC34+POpbb+YzaoYkvhM4kpzS23MgNLJvFtxN0+hlZzWULvwTtF5rkS7j52mi0Abi65vaPt0EOun5pphQSzwOLT4M/SGUFGpoOcAB2sKO+U0Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2xyCxn00yE7GHhwdvALgkMSs1advPEPFUJ8TyG7hi8=;
 b=pz7fS+KBUhdha8cfvu+oSA0DbxC0OriZZKmUuyjkEp8nvCwzMA4yUX1IGHP1y4EvwXvmqLlh1lDurNtVrA3z+Vm83pP9lCADOoHbHCGwfAI0lPsiAi4j9taw0ZV0mkBbRlDqcdLDcIrHJsfOs86YfXqRzCD39rlXK7NEEzxhmIoFczi0jrN/blYYI3rn4IsZyamS6U1g9gm7HcuWyJReOw0r+3DTTqJB1Y6yVMPAexN8rKbRa/3G4ynwAaMslS3CYeiagvgPppIFAVg+Tkp3B1Dhvr4HUeYJKoeZtdLjtpghdWR8SwXUegFXPyVpoxug0dpbJdCQDCbUbbqoPqQ9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:32:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:32:31 +0000
Message-ID: <3df3adb7-4ed7-4f32-9a15-eabdfa58d1fe@intel.com>
Date: Mon, 16 Jun 2025 15:32:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
To: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
CC: <imx@lists.linux.dev>
References: <20250616184820.1997098-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250616184820.1997098-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:303:8d::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c78126-840d-4c36-e612-08ddad25aeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlphZ0Y5dkFITTFxNElHeTZJRzFhdnc1TUcxUnFwQUIrVi9PNUtwSEhoZ0Za?=
 =?utf-8?B?eGJZVFgwazArR05BbHo0bkQ5SFZWWWNLdDVYUlRFeTBuVUMyblBJRmpCYWZt?=
 =?utf-8?B?RDlwUCs3TDhCRkhNZ2J2YjJ6Z0ZOMUQwc2haclI2OUcrNDVSSjlhSFlNUjlt?=
 =?utf-8?B?UnNrVEh4d2hjTU84STBjVHY5RFFrQStLTE9LY1Nld1RWNXpIeFlLS3F1cExH?=
 =?utf-8?B?cUxaMmR2Z3ZpNWtoOXRLa0YwTXRDZUhMNTY5Q0hSRENEdDB3RXc1NmZ1a0NM?=
 =?utf-8?B?V1J2YVRkVjJFOW9zRW5BNytYTTIvd050KzhkZGRFblBIRDg5MVRwUDBnd3RG?=
 =?utf-8?B?em9WTktvcmJNUEg1Zk1FandQVkl5NlBTMHdFWU9RaE9xaTNZcjlZWmkwK2d3?=
 =?utf-8?B?WFB5TTNHWmUvejZOS1U3cURZTUxEdEJ5R0FDUHNDaTJnb2w5Z1VzT3hUVzFx?=
 =?utf-8?B?MjFSdXB5WHpvVDdNQ1ZRNC9BdmhMTlNLa0FEbW16MVA0ZVpBdHlkNVJmdWJr?=
 =?utf-8?B?UEtFVTduRTNKVWVid1FhNzR0YVo2V3l0QkJ0a25yZUpIQjdjV3ZBbFJYTnZq?=
 =?utf-8?B?N0FLbURScVQ3YUJWcjc3emthVEpTUlBubkRPOXdPYkxEK2hMdmg2WlJscXVR?=
 =?utf-8?B?cHVOZ1lybjhsNTRGaWN6OVg1VDM5KzNiWURaM0RISWh4SDlUVGJMWDkrK1Y1?=
 =?utf-8?B?ekEvbDhkS0NDdktRWENsdEJjeHBwaEhtT3I4RVJnbnBGdkVNaUsvNU4xSHV2?=
 =?utf-8?B?OWhiT1ZsUlpEYVp3ckJSUGoxa0hBSHI5K1dGYVI5djY4a0JsNGxUVi9wcHl3?=
 =?utf-8?B?K3RGMWl4ZzVFSUJWanlzMjNZWGhsV2k1bmlBTiszeGhkT1QrVkw1YTFBcG5B?=
 =?utf-8?B?WDJrVjBoWFdvTHpHSkVSWFNDVFZnQ3JkRVowaENoaTBGb3Nob1dobGN0NC9V?=
 =?utf-8?B?OXdxRmlSaldhUi8wVnhJbU5CYzNIQis1VlZ4c2RwdnA1V1JjV3IwamF1VHIy?=
 =?utf-8?B?bGRIWDFWbmVNTHBKRVExeEtoOHFQdzJJSU9GcDVBazlSM2U2bjN2dGZzTGhZ?=
 =?utf-8?B?U1hoUnNrM0FjWkNud2d2Q1JUQ0JmQ0g0a0Z0NXFVU2tCQ2gyTG0yak1RTWhG?=
 =?utf-8?B?ZGgzSkxTWUZxOXFsQTVZeEFPaTVNOGQrZGt6aGt6Sk9vTnhGaU5UdnVBUjBy?=
 =?utf-8?B?VU9MemZKRWdOZ1RJc0JxMkgySnJtLzNya0xmZXBQekhvQWxaa1dNU3V3SHlm?=
 =?utf-8?B?a0FNWFAxT2Q3VDN0TkJxaXRYNisxUDNpdm5TWXBDWjMyQVIyZUJsZ0FJVFF1?=
 =?utf-8?B?WG01WjV6aU9hQ21jTlpTQzVic0hhS3ZIbUJvM3RlbitudlFRNVRUN3RKZkE2?=
 =?utf-8?B?WlkreFRCY0ZaZ3ZWTzAycCtyQUtGTGlUNExiczV0dTJwOWNoejJrTldwd2tZ?=
 =?utf-8?B?QVRyZlRmZkJiWGIyN3pCQ3lWRmdxbnhabUtNcE9WaTh5OTEzdWRrbWVaOGlm?=
 =?utf-8?B?dTdvR0pmdVJYZ210NXhQQjlZUjZmVm4wOE5FN21UYTVJQnN2Y3BZdFgwbUtx?=
 =?utf-8?B?UVFXa0hNYVBnZHE1WHhCUzJZYXdQc0VJQ3VtV1M3Z0RYWS9YVzAxRjd2S1Fz?=
 =?utf-8?B?WndCR1c2elp4Qlg4NFhzZTFnaGJrbjBTNG9xNFdyQjJFbWpPcSsvdEJzKzVK?=
 =?utf-8?B?SXR5R2R1QUQ0UURLYzBQaXk1R1RmU3ZwS3VlOG5TcUxhQzFUU0svL1huZUY0?=
 =?utf-8?B?dzFBUTUrZGYzb0tXaFVxMlc0K2srMW1ZN3k2S1BUTTZSVkZmVngzd1lORTJT?=
 =?utf-8?B?WXBkTERJZ2NCOUxPd0YzOHljMFBlcEd6Y2JoTkg0TU9GOVhxVmpwcityOXNH?=
 =?utf-8?B?ME1wNEdMTTNxd1VxNGpMT1FEcDFqQlRHSFdaNHBZejI3QUxjL0FCNWUxcmt2?=
 =?utf-8?B?NHIxODI1blNPckU1U3hWSUJuSk83bnl6RCsyNWVpK0F6VHIvYXVhbEdCemFN?=
 =?utf-8?B?K0k0OGdWRmNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhQb3ljRXZpMkZXeW8xaHJxZTRyR2NSMGNONlRwdnpKZFBGWDZIeTVacUVW?=
 =?utf-8?B?TVRZQnFJRCtKK29LMTdsM0o4b3Bxa0t0NGdKenBZbzAwcnd0MU0xQlRLSVhk?=
 =?utf-8?B?STd1S21zUkNrODFSSjhjZk5TMUJub3loakVwWkNJSzJuUUVRMXhnbDNNRG96?=
 =?utf-8?B?OWRWMndjakIwWUJpUEhST0l3dnFFc0tSWU9tSysvalNhWDZ6RDhNY1IvWGFo?=
 =?utf-8?B?YjFVZ0cxZDRFUHhJekY2RklaK3lKd21tMFY0S0pyU2VYWllhOFR6UG4wV2pi?=
 =?utf-8?B?UHZrdGRJZE5hQkpCU203MEJKOWEyZ3Z4NDJSaEh1T0o5c3BRbzZQbnZEVW81?=
 =?utf-8?B?V3JCVUlFcnh3ZWJEWEhUMTMzS212MVRBT3R5UTh0STM2NnNnL3R0cWZ5d2lJ?=
 =?utf-8?B?RE9CZWFjSW5sMXN5bTRyTmpLVjFyR3VWcCttWFhjQkJTamk2NzlGS2t0MWdX?=
 =?utf-8?B?THBaeXdES3RrZVVXcmVwaUJ1WUVXbzlvS2ZmOTRnd1grSGlubWxFQUE0OE9D?=
 =?utf-8?B?dWdzQlhZSklMWlg4NTU4U1FSZ0hCMlZGUVNlZ1V1OUxCcFQ2QUZrTlR2dFJh?=
 =?utf-8?B?RkdQOVByenR0VjQvcGRkQ1VlWnlwckgyUzNoTXdPalJCajV4eG1xdW5haFRB?=
 =?utf-8?B?cGFSN1plNkZ1V21tYjViR0JFTEZxbk1uRXllRzV2L25rLzZVdklJZkcvd0Uz?=
 =?utf-8?B?cSt2ZFNnRUUxQ2F6OUdubVZiNTJVMXNkSVRCQzNRZm0rZGZ0T1FLNVZINUNw?=
 =?utf-8?B?Y3gyeHU0NWtoUGpPbzdxbVhUVFYvQmM2MmV5WXNBcktjMW83L1QzM0hnQjht?=
 =?utf-8?B?RURSWUE3S3JwU0owL2JDLzBtaW13QlpQd3FTVlh4aTA0UlB0aTFnMVREQnhG?=
 =?utf-8?B?UTQrcmxINXhFRDNBL2FuUXJzMkxENWF2NThqVnRpdllsWHZ1MjF0L3R3TExh?=
 =?utf-8?B?YmVxdEFLUWhlUm96cHhkSmt5NVVuSTFadUwzQ2VVSE9yUG90UjZtb1h2QlhS?=
 =?utf-8?B?bHNjcjVNVjdxdWp5c2pBTmR6Qlg3dEhqNy94V2dJbFJveTFJRThmNGZxcHNu?=
 =?utf-8?B?NmlhUmYvWFM2aGxDY2daeVR3T3Q3U25ZV040cFRCdG1GbDdDRW5jdlhlSXNJ?=
 =?utf-8?B?WFFkOWIrRngxcmowT2JteWhid1FnV3RWM3FMSEFZUTgyeXptVnFtZ2hSTVhn?=
 =?utf-8?B?MlJYQzE4SlRnN2NqUEV1NUsyMi8rSUZ6dkU5Q0gxaXBqRVNlUDRNektqM2Uz?=
 =?utf-8?B?OXhxNnBDVG5JKzJlUVFCTnRNNFF4ZWJjQjQzNXNqenRFbE5kYWoraUJXQThS?=
 =?utf-8?B?ckN1bzRzZHdUcElZbzJFTVV6RTRCTmU0ejlqSi8yZURBQ0ovc1gwSjlXL3Fn?=
 =?utf-8?B?cDdPbkdzK2ticTJWZ01QamdYQitMRjR4djNFenJQQ01veEVPMUlLSGVEekVU?=
 =?utf-8?B?eUNpd2NoQ2pnZ2tZRE0yLzZRZW9QQk9TdGE3ZWJwd1h5RWZ3a1dOdmtxbDRr?=
 =?utf-8?B?RGlEK0MwZWxzeE5IS0xmK0dISHpEZkhzUnlaRXRNeFNHOTBqNzROVkZOcXBp?=
 =?utf-8?B?MDBudmozcmFHdEs5RjV4SERvc25raVBLNHEwTk0yM1NRdnh4c3M1bFRJVCta?=
 =?utf-8?B?V1lxVmFoM0RqZDJzaUJZZkFVNVNKTGgzMHBsUXZ3WVVpc1E4VUx4L0ZRV0ZM?=
 =?utf-8?B?S1RhYlRncnBmenBwbWhFaWZ5L3JuNW51Ymtva0JvLzBzRVpkbXNyTXB5c3Vo?=
 =?utf-8?B?ajBNcEVaTm5neW9qTmlWdmxOZVFQeTN1bVJVYmNaREtvV0NvdUtRRHp6OE5W?=
 =?utf-8?B?YWY3OUI1a0JRQzc5Y0pJdllrT20raE9pVi9KYXNWRC8zUEhLMkhqNWZGMkFY?=
 =?utf-8?B?TWs5K0ZWYlpvc25COEE4RzFpNHdSUFVBV1BJdlhqbEdxb0ZTOWhXSHhXMWJr?=
 =?utf-8?B?Y0IwRkk4RXNzMTNJZGJSdmgvMmZBQjArSUdFWDdNUzRyOU5lVjVaT2ozR0l0?=
 =?utf-8?B?WmZkUlZFYzFXMDNzb3RFQVZ5RkVpZFVieU5seGVDczNobWhyRGowd3kxTGhu?=
 =?utf-8?B?SWo2L25MZVMzUUpvTTE4SEtLUmpyb0JORzFWUXhBeGZYWW1NL1NvSEpsdDkr?=
 =?utf-8?B?WW43YXBiTDBKUWRIOWttWlFsd1FFSnlhalVQTzF5OUY0aS9PZ0dhZXorbHVv?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c78126-840d-4c36-e612-08ddad25aeae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:32:31.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UndycdNKZz4e7nqUg2KXNc878DDdOXvFrfTHdhYWmgXcOXjStf554KUzDeBISwVBwNF+uYcBe7rHWS30uWyhhhsG+itV5eR6Wtool7z19I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com



On 6/16/2025 11:48 AM, Frank Li wrote:
> Convert qca,qca7000.txt yaml format.
> 
> Additional changes:
> - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
>   ethernet-controller.yaml.
> - simple spi and uart node name.
> - use low case for mac address in examples.
> - add check reg choose spi-peripheral-props.yaml or
>   spi-peripheral-props.yaml.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

I probably would have separated the additions out to their own commits,
but this is short enough it was relatively easy to read and review.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

