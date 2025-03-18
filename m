Return-Path: <netdev+bounces-175938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D4A6809D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBDD1887A12
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9A213E8E;
	Tue, 18 Mar 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0mH/iGC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8D213E79
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339515; cv=fail; b=Pp90IvjhWZGpV5fSREIHO43o2ernjjLKHh+xCuEfVyUnzpezeonf1P0lV8WP2fwA5dBmNh4ySVWum8dqSYxDoSq0oxoZqBLbPZvphoilkO56GP9+SMkUG25ahG8MvKVBIq8iwOnIo9M5E+Rx5jjn93bfJvUkESKCK6uSeoyK7Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339515; c=relaxed/simple;
	bh=MnOTl4BJCxvX8de084GwhNT7QSXYzx5yR45erIRpj6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUA1PiQPOOXWEnAvz5aazHcLV/a3krMHAEO6A+ti+gKsWN6oE8tJcUDxB3HXZqrfqubZVZ+92fK7v3aHYO9K309K97fajpyc/8yUD6p7si8fbfUmN80vVe/0Hja4cXDxmFK4y2jVVPwsBDIHx+zYkhnksaXa/xxggbl91CPNWYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0mH/iGC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742339513; x=1773875513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MnOTl4BJCxvX8de084GwhNT7QSXYzx5yR45erIRpj6U=;
  b=V0mH/iGCdv2Ijv44CQPjOrZAIkYXAMgbay/xq6V0XeMgJU56F8WVGeL5
   twd7zl5711rEvUw0U2MNeIXQ+Hq7ph9tcY3iPCx0XUTQhjmL2FeuP54ES
   7AnHv2uT2ADCc2dXjanVOkSyHl/Gl976qEFcnDVN28JnXROIhqrSu8jvJ
   nRLGON2JVvUTLnZCrsTSWRDucLxKvFjv/A8zQvJIVDYQwxGtq8iDGd+IM
   tz+WZxQ4aMc/CwJsqC++Wo6IiXlPtA3oTSlHnn7G2jB5iY/5hz+Tll5tf
   E5xt7obOCAvEOHqw9NbwpWbgWMcOd7/MfL0QlMAUQwYaqJIVp080Ij9gr
   g==;
X-CSE-ConnectionGUID: 08Oq2825TEW0RGybQgEHpg==
X-CSE-MsgGUID: erIkV5IATc6A3xiWzL7UkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="65966432"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="65966432"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:11:53 -0700
X-CSE-ConnectionGUID: OpRJ4HrKRkK+utowZ5TVuQ==
X-CSE-MsgGUID: 8LjFySwKQB6gvTJg8Uc/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="159559809"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:11:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 16:11:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 16:11:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 16:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di/B3tiFrHLycQcpIYUEfUf9JRzcoywpNKp8esgmdRfncd5QJolRZBCMyLnbOVGJpop2a9AA8eaqlBIOwkBtu76yCX8Zxjnkyi3fj7T5HTQ70sKp2e/uJL37MVmWlphdkNGpQYNsTYRqpwb/hpzX8c4PJg/aHdMBsVbLcnehYCyGQAuGcvRec3d8lVmnW2SkoAiahQQP4dlkNHarM1FqY7Lny72+hDvD8yPR8xwsNrLUa9Dn8gYB59I3/mt4cgW/iKzuosH9sQX6G0jDUGeSOlVMlwax0P3lTfM/Spem1yrp/mG14kJSGIGGzNtDDPKD/wb6RJ2347astEuOkyiHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNwspY0gMoHDYtVD4Z34Li2uPNI0uppizmnO9yxZLN4=;
 b=X49UiHzKfLor0oC/wf9xmJvmbi5/7OVoJMrUSncEbTDnpbWKBi53IOSJnr49Two4JehmHJerskm4+yybOX1mXsCEAfF1GjBPBFNQYfArFZg1Etst9RYOBWy1QyzBhriLqgXZhd5Kp3/DhiA1Ac+pNreT2u78VFfqH47P7Yk4uXw3ke9bjx6IDgUu1+FP3FFuhq+QwXpZeStdWR1scngFDpylIcmCfCE9/jJJKq3hxZ18Wayva040slg1C+2AshKaHMbT/58Vxg3GQJbnBSQJze76bS/OFg9EHKrPe0IZR3OGkdOaw/XthWegLCzxRXtOqbmdA4cZbAVcWvFDJnKCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 23:11:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 23:11:49 +0000
Message-ID: <10e8217e-847c-48b6-a643-2fa347fbed56@intel.com>
Date: Tue, 18 Mar 2025 16:11:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ena: resolve WARN_ON when freeing IRQs
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: Ahmed Zaki <ahmed.zaki@intel.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
References: <20250317071147.1105-1-darinzon@amazon.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250317071147.1105-1-darinzon@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 39270c75-ad22-497b-9b5c-08dd66724284
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUU2cTU5aWZwSUJ3TVYyUTIxdEFudUJMbDhJNXVsa3p5ZkQ3V3dLcUREYTdU?=
 =?utf-8?B?M0ZhOVJ0eUVHRmJQOGwzcEsyODBXeTc4eW4zbFRQT0hxUFBLQ1VjQW5wTlZv?=
 =?utf-8?B?OTZ2ajJrVDZXK092RmtSRENlNm80OFNRNnF6cWRGK0tsV0ttWG5FajBTaHJx?=
 =?utf-8?B?N2F3cWFxUnBmR3VUNkVhb0VLTC9MSFFnU1pZSldTR2huWk1mNFpwWEFEaTJ0?=
 =?utf-8?B?U3gyZ1c0dGpFN0ZkZWZLazdTQzlsa3RuSGxVOHdUSGJxeHp4VDJUWjZ3Z25K?=
 =?utf-8?B?WjVpdUR6VUhDWHNyTXE1WnEzSEhYd3pKR0dBYzV1aU5qOC81aVI4UWhCN0RL?=
 =?utf-8?B?VWt3OUtXR3BaanBTOFlranMveEFpRTlLUmVMWFM5K0xUdmR2aHZYY0lrU1R1?=
 =?utf-8?B?cittbDdBY3lVUS9oZDhVNm9GUWwrRklPajNwR09vZnFXWFI2andKV0xmeUpD?=
 =?utf-8?B?Rk1rait3SzhwR0J0MmxpZCtpU3R1cTAwY0dMdzNwS3FDMWI0NnhERzNvVmZS?=
 =?utf-8?B?UXVNTWVXdUtDRTJrSDczdWJ3Y0NLTjJ1SFQwNkNpdWVoanpVSml5eWpGZUQ5?=
 =?utf-8?B?cG1MWlZYYlRpSUphRTJaTWJBRVp4Ni9HZFBaZjNFZFNXN2RIZUhmeUpMbnBx?=
 =?utf-8?B?WmhJdzdheTFGa1NlSE0zaktaL1VRd2RXTWNFaDNKdFgxRXF6SjFTTXRKZDlr?=
 =?utf-8?B?OGtWT0ZFZkZkMy9uS3U1ai9IU0dSTDJRcGJFWHplSjFlck5GSWdmaDUxekZD?=
 =?utf-8?B?L3lQdjYzYklvNldrV3puRHBoMll3bWgzbE9DRGxtYUwvOXNiOXZtZUYvNDZW?=
 =?utf-8?B?a3pSZ2tOVEZydXpncjBWSzFadkUvVnVrdnVnZ3lmK3RXeHFScFk1aHZqQU8x?=
 =?utf-8?B?MzRhTFAzU1VPRlBOVVRnb3lMenZqSGI5TkZNemRRd2EyOU11eGhuTzVNQkhk?=
 =?utf-8?B?aFk4aGtwSWl5WmNOaUdGZUppK3oxL0JrWWtkWTRBNmJtK1hPcHJLMTN3Zi9C?=
 =?utf-8?B?R3ZGRG15TzM4aXRaUStaNUZpemZ5SmRlSjdHMWlZWmpkVklsK0Uyb2ljOWxj?=
 =?utf-8?B?T0Rmc0t0akxmdTFGd3R5R2xUTncwM0czMWx4V2VRUnZUM0wycFI3UFBRVVV0?=
 =?utf-8?B?dVlTR3NmMzFhZ0RESmxUSkoyemdBWjlmMzNZUU1Vd2xTZU5NbTRVQjdWQWFG?=
 =?utf-8?B?UlI3NTNXQ2pBVWcyUzd1L3VnYWlaSytwWjE2ODRWdTFBWkl3NkJmN0swTEdN?=
 =?utf-8?B?dFdPdDRCWTVYVk93Q1owTlA1MVR1VHlDM0VoaU5jTDVmQStPRUcwcmE3NWFj?=
 =?utf-8?B?WHVtRnBZTjBaTXVTTVJIVmwwVnd4WlpkZXRGK2FQQUtTanNTVDRrMkcyOHVB?=
 =?utf-8?B?LzY0aE85MDBhOUR6UUVoV0lHZXZ2RDlUWGQ4ZGxLUTIrdEsxdXhYT0dUbXRD?=
 =?utf-8?B?ZDZJbG90R0piZHdkaGsrWWlSZE0zZGJ0N0cyU3hRd1pacE5ScGp0ZXpvNGtT?=
 =?utf-8?B?cDc0LzYweVNVUDBJclk2Y1pCb2J6b1VhV3Iyb29CczNnd1llYVFGY25tSEVH?=
 =?utf-8?B?TU13dk4xYnVCOVhTdllwdDhwUlZOVk8rcEpTYlhLdnRDTWg1eVdmSS96ZGVG?=
 =?utf-8?B?cmQvdUMwQnQrd0lNMnVUR2VjcUkxcU1BZEdtemtxS0d1VHVuYm1tVTlQVjA3?=
 =?utf-8?B?RW9ubXpTQWgzb3M0NmVHWWt0QUNLREZpek5pbzhDK2Z0NnV1ejlYY1JCc0F2?=
 =?utf-8?B?YXViUXk1L3JBM3NkM3VjbjRlZVkvbEpTTWhzVTJBbXVBWXRYZS9xaEUyd0dK?=
 =?utf-8?B?L0orR0svVDA1azR5NWFRK0MwOVFKQXMyUnI3SFIxRWQ2SmNxZDZ6Nm9nOVlW?=
 =?utf-8?B?dlFXRlZ3WG1Bdk1YZHkwL0FoT2Iwc0s2TjF2NVZveXd3OGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzlxTmVyWjROWHV4VEFmWEZmcmU3ZGN0ZC8rWUdOWTdnRkNjWnBKTVZxNDNk?=
 =?utf-8?B?WW5IcGtoUmZRaEhQSThvQThHREFFV2tUUDJ6OE40WHRsWTVjVVpLWkt6Ym9E?=
 =?utf-8?B?T2tzVjhpNkp5ZDlNdHRhdUkxRHpjaFFkWHFkemNSaHk1cGZzQkhIcGdBT2w5?=
 =?utf-8?B?bjJJQUtLT2NCV2pPeUxOM2hocjVId0VNOXVpbmlVem8rVUdEYzVmTFQ3eVRY?=
 =?utf-8?B?clgxOTFyQ0NoU3d4TEpIb2FJZFVXZGdIek5KOWJSVGgza1pQTG9aOGxOdW1F?=
 =?utf-8?B?bmM0Yk43ZE1UWEhXcXNod2N0MEpTMllwL2kvdjNFaTk0dDVFcnVza2w4dU5S?=
 =?utf-8?B?cnhNbVhYc0xObjc5UnNXRzVUR0ExeHZ4L3JiQzY1SEtCNjROM216cmhsQlBW?=
 =?utf-8?B?OHRiYkQ0L040NW1EUE41TmhGOThDR3hqelBoeXVPUC9OUGRkMGFmanlEU3d2?=
 =?utf-8?B?UVBYKzhEYVd3ZFc5RjVNZGV5U0dkMTA0bytybUk2ZjNPb0E2cmVMS24rcVdC?=
 =?utf-8?B?ZllYVFRveDM1S1pYakQ5b1NIM1dEMUZkYmR2bmdqaHo4ei9qYU5ZRHpNRGtl?=
 =?utf-8?B?ZFU2Z0ZBci91b21oMUxPS296UDdoQUtZQzdBZ2dZaEIyM3dVQmZ4czBZZ0NJ?=
 =?utf-8?B?azlhOXVVOExweXpKN29qaHRRaUVWcUVWb1JEWStyYmZ0a3NuY0QxZmc3WXVC?=
 =?utf-8?B?U0VnYWMvMm1vcjJlVXh4N2ZiTThYRERZOTVQRDlteHI3SGxCdXZLY1BZcEhh?=
 =?utf-8?B?KzNMcE82dkU4bnAwbkxWS0JocVNWQUxPRy9nV3pXbWRKYkdJRmJnb2FVMU1x?=
 =?utf-8?B?Y1VKZkQyOUp0VWpaNktoUlJHaUdVSStTUDdXY1dBbmM5YS8yTlZpeXBUUkhp?=
 =?utf-8?B?RVdYNEFOOEtnUnYrZ0ZaUGJLdGgxWkQzNXB1TE10V2s4Q1RjeUFicUI2RnA0?=
 =?utf-8?B?bDh5L2cvZ09BdmNITktNM29OdjJoOUdiZGZOWVFtSVRzbHYwYk5ndmlGRG5m?=
 =?utf-8?B?YXFSTTRxZUhSOTVZbmFsVkRKSzdNQ3VIN1NrbmZMM3Jnejdza1ZodkhOcVJC?=
 =?utf-8?B?bXpQclNjQTk5OTdPTnBSVllmenZ2VzY2NHNCbWRHVEpjWk5kYjR1ekExNVNh?=
 =?utf-8?B?cGN6bUpNNjllYml0TkVCREdBdlFaS2FTRkxLOEhRVTFaWjNYZ0RnSHlGVVJv?=
 =?utf-8?B?UGJFWGlVQ3Z2dUdobHBOTFZOMEZyT2tOaktxSWZjSWdwcWowdkVEci9ock9D?=
 =?utf-8?B?TjQ0OCsrdEplQS9WdnpCR1hIeFFXSDFjbUh5SGZ6SkxLSGZHdmRNYUlWcytC?=
 =?utf-8?B?WW5QeHhzTlZveXE5Q2FOM2IwM0FKZ0RoVkdHSUtQY3Fpa2NxZFYyUzE4em1i?=
 =?utf-8?B?OWMzU3FwM1FNYUczOTAvMUhJVEVucExkaUhCWUFOdzhLam9xSWh1M1B4bEJv?=
 =?utf-8?B?ZFJUUnN4MXJvNWs1S292V09WelRaRmlqek5rTnFzOVBGK1hicGN1Ri9GUmth?=
 =?utf-8?B?eHhjcktOMlF4YWRXS29EZVpzOThhVjlOR3R5SyszWWNBOFFjbU1LeWlEVDRi?=
 =?utf-8?B?ZmVlT1V3dGVxa0Z4TVNtK05qVGN3YkN5WlhYM3FiTVNzU0xhYnNIbUF3M0lW?=
 =?utf-8?B?NkRtR1Bta01rUXhjeDdMdC8zUXZjcjBYZW83bWpXNGNaaTQzNUJEYWR2cmcx?=
 =?utf-8?B?Z3hPd2kvOEt2aWZlaURIWU9OckRCRHQ5SkhUWUZ3Tm1UMjE1VHpxZU8wYXNj?=
 =?utf-8?B?d1ltVTFTbGMzSUt6dmlzY3Fwdm9TTVlGU3JmdFVSVCticE9TNXNFTklPaEFj?=
 =?utf-8?B?emtVOEtoajlhMk5XTzRnRkhvbTBqdFo0NHR6TjNra3BVNnc5S2dHb2ZhRTdB?=
 =?utf-8?B?ZmpKMTY1NmNKemVTYVUwTjZOTElSK2pOUE1rRjhlMnc5OVBEYVhGMjRzWG9N?=
 =?utf-8?B?Ym9uVHM3MTUycll1TVpaVVZMRlNDc285ZDJDZnhFQjQxYW8yUEw5NFhHTHJE?=
 =?utf-8?B?azh5aXN5YUxycUgxeWR6YVFJczdCNzFIV3dXTjVObndpQjYzVlFxcnVobmFT?=
 =?utf-8?B?VCtlcnF1dXMvajczS3oxTlBVdUo0Z01OOE41bFlqU2JheFBqTlliRllwYWwx?=
 =?utf-8?B?Yk1pTE4yMmJPNlA1SVNUQXBYZnBXN3FJZjVialBSRmY2RHU1cWFMS0pqdFdK?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39270c75-ad22-497b-9b5c-08dd66724284
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 23:11:48.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ48y9xNIw18Yp6v43MfUdqTrV2tu2jZNVFjKGzGhzJbiQtYi8JsJq8YgRYBgfLeglkBp2J6L9LdmeVx0+QssISk/ddOl/UYR5WjHB3NcEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com



On 3/17/2025 12:11 AM, David Arinzon wrote:
> When IRQs are freed, a WARN_ON is triggered as the
> affinity notifier is not released.
> This results in the below stack trace:
> 
> [  484.544586]  ? __warn+0x84/0x130
> [  484.544843]  ? free_irq+0x5c/0x70
> [  484.545105]  ? report_bug+0x18a/0x1a0
> [  484.545390]  ? handle_bug+0x53/0x90
> [  484.545664]  ? exc_invalid_op+0x14/0x70
> [  484.545959]  ? asm_exc_invalid_op+0x16/0x20
> [  484.546279]  ? free_irq+0x5c/0x70
> [  484.546545]  ? free_irq+0x10/0x70
> [  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
> [  484.547138]  ena_down+0x250/0x3e0 [ena]
> [  484.547435]  ena_destroy_device+0x118/0x150 [ena]
> [  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
> [  484.548110]  pci_device_remove+0x3b/0xb0
> [  484.548412]  device_release_driver_internal+0x193/0x200
> [  484.548804]  driver_detach+0x44/0x90
> [  484.549084]  bus_remove_driver+0x69/0xf0
> [  484.549386]  pci_unregister_driver+0x2a/0xb0
> [  484.549717]  ena_cleanup+0xc/0x130 [ena]
> [  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
> [  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
> [  484.550782]  do_syscall_64+0x5b/0x170
> [  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Adding a call to `netif_napi_set_irq` with -1 as the IRQ index,
> which frees the notifier.
> 
> Fixes: de340d8206bf ("net: ena: use napi's aRFS rmap notifers")
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
> Changes in v2:
> - Remove an unnecessary cast
> 
> Link to v1: https://lore.kernel.org/netdev/20250312143929.GT4159220@kernel.org/T/
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 6aab85a7..70fa3adb 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1716,8 +1716,12 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
>  	int i;
>  
>  	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
> +		struct ena_napi *ena_napi;
> +
>  		irq = &adapter->irq_tbl[i];
>  		irq_set_affinity_hint(irq->vector, NULL);
> +		ena_napi = irq->data;
> +		netif_napi_set_irq(&ena_napi->napi, -1);
>  		free_irq(irq->vector, irq->data);
>  	}
>  }


