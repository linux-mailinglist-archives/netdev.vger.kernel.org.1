Return-Path: <netdev+bounces-212639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D88B218FA
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3146136E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAA23B63F;
	Mon, 11 Aug 2025 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5qE9yf5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256B2581;
	Mon, 11 Aug 2025 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953881; cv=fail; b=DgTdBDm3qgtr8qzeiT6NooIz2mmSBUfqHxNaglPvRgONdwNipHpoUmvNxsvsGZzbiqD7s2npSCbSWhlJ3FEgqi38b51G9UrZm8gaxBM9m68bKoU7+e31EPvLhS0mu8LY2tAcIIlXo4uzEAlcHVCsZi6kD//PPlbdlnIWACuCJVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953881; c=relaxed/simple;
	bh=g7JiYqh6kdDmR4S4UXOYT7+HQQHaVCc0R9i/uIYpxAM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip9Nvx+sutX9z8Iehi8RNF2MzBLeeDYCrst8d1ufHnp+nt/M8avI84VscgBXHQmBaodIYNo8XA+JOh00mmhLSPPMOShPspKg5hFlc2RMoOl84hZ/klWDvZTbHT9mN/nwWMRUdwLiVlm3H5/SNcK9MG/SoZ26cMBpjH2sKfHzkW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5qE9yf5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754953880; x=1786489880;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g7JiYqh6kdDmR4S4UXOYT7+HQQHaVCc0R9i/uIYpxAM=;
  b=I5qE9yf5XpbfNLOLx9KHNFJWXr7cGMTIcdn+Dh5PprkavR8g84gDgQi5
   4QcA6hTnxfEndzbQP/9gN9d8K+TbMbuT2KZVX2Gjp2OY/iEijIytAzbyA
   2lWgnsSsOihYNvi66PHDycfTEBvxAG7n36pJiB44tf10eyjsImedECGV4
   4IdIhwtc8/aci7fST8DX7xYfUWGom223lqCwBfTltxPlIymaz71F5Sw5w
   L2y1rDVjb68K5INZP2RfrLnbeSdpovIeRmSji0As03Cr1oYFjNHZ6cBaf
   sli2t6W5RNAIuTlcKmv6AJ/+SmjFuBcgUMncYYt5gjkxsxCcS21ALMwsf
   A==;
X-CSE-ConnectionGUID: mnk+qlBPQgC8y7ChYgQW9A==
X-CSE-MsgGUID: BVzU6y2BRp+5bHKOgryKiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="61061111"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61061111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:11:18 -0700
X-CSE-ConnectionGUID: J6VCUPewQAWoeLOrbcGdIw==
X-CSE-MsgGUID: o2mdckIWRtOme81s0uiSNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166032348"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 16:11:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 16:11:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 16:11:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 16:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2yzzYwZENkYrfkjI6fYXkBMIk6nzF3u8FYU9h5iJHG96NHA/4wV0N+SAEuOH7j+8zmecoXgBQJbvCrZ12VbIqbfQlfh5RNVLHBKpsm/KdUQ0FjxXMSzdGHy5E2NGUydDvDrReEJL7d89a3V0KMj06k5lM6EzqPPGp5GgrWF8E38QewnUV2GaQXHq+RLnCUJkGw/pUbIJdfhSxQ8hcZybeIVqXWy2BdzM/z3hDdovQJHhjopFd4lw++JQWk1ht2GQq9QNNGMzx/UV8UGRP+ifXfS324SNjVwChxDll233ilaze32pNj9i1uiU/2KPq2x5JrXngeSPWY5Y07QFqch9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFadxSmiffaSp1Wi8eaN4YC4DmvSHeE6IjZftoOosZo=;
 b=C3YiNTNXqLT/gyGBaHKCNhTN0XxCuch+gonP56mf71OCcLZxq6x/dGEBp/RfFFuIVGVUh7f0qfmicjPbeuhrhu6aunmTceZ5Mfmtiis1tq5mS29vtMSoSbg8Ym9stkRCrnNneqSl7Mj1FeU3e7Lf05rQt+RuXzwQ0MvaxDu+vUsd3p3PqWcYx+rK9SKAZiQrXBuWc1ZEnzREfzWrR9Ehe1E7Irfsw15OCfrdRLfEGZMjFlM6lWqNowtgauslpWIDOkIRK0p1ivNVOBuIrbItGZ88KG7Mf0SdwFuPMbBIOG3IZH+3ZUwpJ5kX4EZz5HqPJzJNsPW5snB5sr/l5LWqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 11 Aug
 2025 23:11:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 23:11:09 +0000
Message-ID: <17492545-4a71-4809-ad19-f7e54139415e@intel.com>
Date: Tue, 12 Aug 2025 01:11:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] dpll: zl3073x: Add firmware loading
 functionality
To: Ivan Vecera <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Michal Schmidt <mschmidt@redhat.com>, "Petr
 Oros" <poros@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
 <20250811144009.2408337-4-ivecera@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250811144009.2408337-4-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: c41d24cf-be49-4740-dc47-08ddd92c5b5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXVsWElGT1p0QlBFak9mU2dPRjc3Q0QxUk9kMGhaSmtqZEJ5cWlhTlpZU1ph?=
 =?utf-8?B?a1FUaFVZYXR4bDZaUHoyb2E4SlcwSGVDZUxhN2xpY0w0ZFlZRVliSmxPQU9h?=
 =?utf-8?B?U2ZCejlOK0dXL1BIR2xMa0ZXclZMUVl5ekJmQTJpcWY4aWNUcElKaHRLRzlE?=
 =?utf-8?B?TWY3TTk3RVpWUlZUZXlIcndmV0Zoa1Rvd2piQ3Z1Y2xlV20yMlVzYkQ2cnhN?=
 =?utf-8?B?QkZhVUx4eXA1WjFuZ2NRWVh1R1Z5SklnQWtpZm1XaitiZlJpU1BZUWJ2czZF?=
 =?utf-8?B?V3FDaXhQd1NVdDkyQjhaQkhLdkhUUGp2WFAxOEdkbTBweXVzdU15SU40cFZJ?=
 =?utf-8?B?NjR1SnU4MVZsaUpDU24vMi8vYWRqOFZZMG5DZUZkNUlnQlRIek1XR3d4emJM?=
 =?utf-8?B?THRUaUZZdlovZUxGWUJ4R3NicWtzUzVpTWVaTG1aRVFCOFJaUHdMSkM3WUVy?=
 =?utf-8?B?ZjZqeDJ1TUU0cUd0OWsxZkpXZ0pOck1sSDFKWE5JYkxnZ0ZxZG5meWlMNC9o?=
 =?utf-8?B?eWFPck1KRnltZThTVmN2ZmpGUnZBM292YTI0OURPNVd2WlEzcHlaSUhMa0V3?=
 =?utf-8?B?bmFpVWd0UXYzdTZuemJrb2ZUNHF5N0xENDh2MGpxVHNKaFZrYXE3YUx4dXhv?=
 =?utf-8?B?MS9PR0VNRHJjK1U1MWxqQjNWcVNFdCt6ZURaV2Q0b3BJdkI1bm9NeUsvQkxU?=
 =?utf-8?B?UUcxV2xjbG81cXB2OVZPbUQrQWpFRUpCZW1uSTJqNEhjNEVSbUNyNVRaQ2NQ?=
 =?utf-8?B?YlFDRmFFZ0pPN1UyNUc2SVRycUs1V210MVBodjhKeWhidFJZRnNWZWpnTnpq?=
 =?utf-8?B?aWdhNHVFVW1QTlNZTUQ3a3JDcmtLZTQ5bGZKczFiR1k0UkZ2Rjh4dFBHWUI4?=
 =?utf-8?B?ZEtlUlZrbjU4OGZ2QzVHakdFTERha2RsckVqNVNKNzd4TVNWdHI3UWhkalR0?=
 =?utf-8?B?YURrczRlWlQ1QjFCRkFvY25xMWl6eWZnSmY4elIvWTFSWTA0QTdkM2ZJUXh1?=
 =?utf-8?B?K2h3UEhIWW03cXc4L3Y5UExLN3hxSXlkbUM4b3RzT3lPci90eUFrZW51RytH?=
 =?utf-8?B?Qjhxd0FPZjBXTmdZeFl0MTBSYktlMHJEejdIR2dZWEpsbnQxRldYd3gvUE5z?=
 =?utf-8?B?NmFzWXc0alVFYmV4YjBnZC9MYVFhdFVGOHdLcmxoZG81SmpzSWFLSWNVR1Fq?=
 =?utf-8?B?bUdZK212c1pza2hYWUhpWUZrSXpFK0JKMm81R3g5elN6TllmYUU5SEQ0SFVE?=
 =?utf-8?B?L1dyR0NkTHBVWi9yWSt1L1hZSjZ0YTR3WnFuVlR2dVdUTGhiUXFSanVodWtL?=
 =?utf-8?B?WCtSQmMrc3psbUJaakJ2N1FyNnN6T0V2U0w2SUZuRjRWYTZ2ZTNGS1o1QVI2?=
 =?utf-8?B?M3hkekU3cFlFalhKNjhaY0FWaUwvNmQ5NXFibTN5WEhydlg0RExKRXFianIv?=
 =?utf-8?B?TGVTUzluMGlZZnVQemZ5ZU9rY01MbklRK1B6aFluL3dHVllKdWlRSmE1eVRB?=
 =?utf-8?B?M1VpeHBSc3JaeUQ3cEpqWUZXM2JWL2ppM3RuOHZQUjE4TGxMRS9vTU5MY0My?=
 =?utf-8?B?LzFqekFHR1BBQXFEandRNVV1RXloYlg0cWJNVldjQnJyaUNHTnIxTkV6eklU?=
 =?utf-8?B?T3ZyWm9nYUhXRkNBNW54Z0x2Y3RHV0tLdkNjM1M0dkREcWMrTGlvbVZqM0J6?=
 =?utf-8?B?dDM1R3YxeElJaHlRSmNyVm4xbzIzYVV5RWg1VUlBa2NOTnhnYmZxNkgxZEp6?=
 =?utf-8?B?dElFMDNRNVRwU0lsVmRRZ0YrQTc0bWVHL3JncXpJcTFFMTZMTlpqQXhFeEow?=
 =?utf-8?B?dE9BRFRIZlhXN01hZHZucTN3bytnQk1HZEQ0TDRabStEU3hWMlhmQTdnaUx1?=
 =?utf-8?B?L3hYUWwrQjY5UUxydktIOURiRWxjeGlBbzZqR3lCMFc0ZmNaZWJsNFo2cTRa?=
 =?utf-8?Q?MHDhJNjyPo8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdRUExNQmdrRmJIMEdIaVpBb1ljd3BlU1REYkU0ajdvbURMM0sybFFZenFV?=
 =?utf-8?B?TVRweWFyVllMLzVRdE5IeHhpdlg2MS92ajFmbFJDV2gzaGduQWxTbTJLbDMz?=
 =?utf-8?B?eFJqRDFyVWNuYU9qcDdaNDdISGdac3dKTzNyRmEvZGFHdHNRM2Q0d1ZHY0Ux?=
 =?utf-8?B?THB2dnRwbGRPMkdDUEJ2b3p3LzVMUGRMOE82a2tVdENPZVZsMDJFRG5SZmdv?=
 =?utf-8?B?S2Y3VVNpL2pFQ29rZVUxUm82V1hrOSs5Yk1hSzI3OVNwRkFpbHdRbDRYbkhT?=
 =?utf-8?B?a1JMOXJlZ3BuQisraXZIZzNGRGVqTW0xV2pRRlZiZzBOdGRxR2dZSS9COXpR?=
 =?utf-8?B?N253eUpha3JzeElWUXBiaTR2bnJ3TzJOMmJjc0t4VFExemN0ckcvVHU2MkhJ?=
 =?utf-8?B?L3dtc2srQ09vMERORjMyL3JGNjRwZVgxczZGdC80MTI1Yzd1NWc3Y3A4aW8w?=
 =?utf-8?B?RXl5OGNtY0prcUFQbmIrMFJqR2NsRnFjMDZrREw3YmRtaUFoVDVadlpUWVlh?=
 =?utf-8?B?ZWZMVFVpT2p5THJHSDBaMEVadFM0WnA3L2NLYzNDaFRmQVlTVnJUQldWQmw1?=
 =?utf-8?B?Y1ZKODVHYzFqU2E0ZVltZGdjOExqdUZyU0RFQ28xUmkwcnpYdEN1SFpRNUlF?=
 =?utf-8?B?NmhUak1peXl4SFJWY21KcVpGeTdNaGEwOGthcXdJemd5bTdMZUplN2FJaVQ3?=
 =?utf-8?B?dTlTYk8xM21EMUhVQUkyWWJ3M1ZUL21MT0FIaWhzVGdCYmE3dzUxdDVsc3hC?=
 =?utf-8?B?QjljbmtCSFIrdnlxZUFvR1FPVTlYaThxNlNuUlpHalRlWE42eTUrWmV3NkJJ?=
 =?utf-8?B?V0JZZ0pwWEsvWkMxTmxMNkdCLzBRdHNscWRyMnRqdzc1NkVtM1lRbEdubGF4?=
 =?utf-8?B?VDhROUxYUy9JMFV2NGxQb2o0bUxBVFVsYUF5UDh6TzFnVTFMeFZ5VGJsNnF3?=
 =?utf-8?B?UmgyM0ViY0hGSUQ1MEx6ZEdRMUhpN25uTkcvY1pMT0luTXM2d1RBcTBxd3ha?=
 =?utf-8?B?UkdWbXVLcmFoK1BCdmRQdjVUdzZsUDZPcVdQVFl6bHMyQUd6VTlJTDNXbHBR?=
 =?utf-8?B?eXg4V2wybVNEQXpkdFE5MUhLWGxlTVljbys0MHF5enlEbGEvM2pVQjJtN1hC?=
 =?utf-8?B?WUVwaEZQbzQxaC9IdWhheXNlc2llOUw1Q0tTd1d1UzhVQUJXTlllS0VaMFVH?=
 =?utf-8?B?Mkc2NWlkZk9GKzF0VExKZDVKZXp3QUdjTXhYYU5DRWg1RnBRZHhCSDdhV0Yx?=
 =?utf-8?B?MzIrOXQ4MU1tTWVaUzQ3M21vN2lYaVdjeUE0dlRpbEdiT2Z0dWRGK2Jjaisv?=
 =?utf-8?B?ckdQb3d0TVlraC8rbWRKT20rMk5VTHhJN3BMTkc4dGd3dWkxSGJyUXFBSHpC?=
 =?utf-8?B?TVlid2pQUS93QXhFa2dmeG5scmcvNnRUd2xLL2dzMjZtclhlOUFOdVlpZkgw?=
 =?utf-8?B?VlBLdFJkbktmRjM5WmsrU3poYkRSdmNiRllVSU1reEN2T2ZjVldBWFJDZGJs?=
 =?utf-8?B?SjBna0Q3SHUxdURIdFVtTEpyMVhCYUZlZjFLenlKUDAzd0hYSWc2N1g2S24x?=
 =?utf-8?B?WWpUajFQdmtXTVlCTFB0bHdyYml5VTVHdzhkUGJ2UklqZFc3UzJuZ0Z1MDFM?=
 =?utf-8?B?aFlBZnIwN1g5djY4SG1EdlBIZ1F6NVBZNmZqWEgyajVRaU5OZkFieGYzYVQ4?=
 =?utf-8?B?NlRrek0rTXJQVUFKaGFmc0RPZk95aURKandpVEs5VENPMERvZzVYT1p0Tmtt?=
 =?utf-8?B?Vm1ZSzZ3MExjcHFPbm1CeGFuOFRzdUNiYVFLZFpLbWY2U1JmaGJEVERVTVNq?=
 =?utf-8?B?ejY4R05GRFF6Wk9rZTZuMmhqWGxheFpXcXFCNVlzREZkSVlPQ0FRc0J1c1RN?=
 =?utf-8?B?VVl4RUtwN09yN0tKUGlTY2dlM2JEbnYxMkQ1R0pnVVZtajVDdWR2Mm5qVTAr?=
 =?utf-8?B?SzNvcnFuakVnYzhCTnBNeG1OVjFRdHNUTzBNTXBRRW9OdjlOeW9IWU54Um93?=
 =?utf-8?B?b1dMdjd5VDVtZ0g4WTQrdjRNM2Z2d2RYVm9yS3ltWmtKL2wxZHdiOXpDUkZt?=
 =?utf-8?B?ak92Mi9XVDVWSjgzQkJ2MW9XNDNrcU41azQrMHdUSUk4YzdwVkJnNlhTdGZu?=
 =?utf-8?B?empBTmt0WVJEenlPTGdzcnBMckxVT3J3TldzUWlwemd5TUlLeWJPWlhZMUNY?=
 =?utf-8?Q?sn4L30ol4EH75VvikJsRbKI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41d24cf-be49-4740-dc47-08ddd92c5b5d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:11:09.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1GV2T61lECPUipmTprOnvjKe+1+Ja7ctQ/xEPpt/gwhpppspP/tIxA/JP1TJkLohnXb8F0CPb0jmfGnviu2rYvCSJ14WWO5CfcGvMrBFZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com

On 8/11/25 16:40, Ivan Vecera wrote:
> Add functionality for loading firmware files provided by the vendor
> to be flashed into the device's internal flash memory. The firmware
> consists of several components, such as the firmware executable itself,
> chip-specific customizations, and configuration files.
> 
> The firmware file contains at least a flash utility, which is executed
> on the device side, and one or more flashable components. Each component
> has its own specific properties, such as the address where it should be
> loaded during flashing, one or more destination flash pages, and
> the flashing method that should be used.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * added additional includes
> * removed empty line
> * '*(dst+len)' -> '*(dst + len)'
> * 'Santity' -> 'Sanity'
> * fixed smatch warning about uninitialized 'rc'
> ---
>   drivers/dpll/zl3073x/Makefile |   2 +-
>   drivers/dpll/zl3073x/fw.c     | 498 ++++++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/fw.h     |  52 ++++
>   3 files changed, 551 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/dpll/zl3073x/fw.c
>   create mode 100644 drivers/dpll/zl3073x/fw.h
> 

overview:
I don't like zl3073x_fw_readline() and it's usage - sscanf will do IMO

please find other feedback inline

> +/* Sanity check */
> +static_assert(ARRAY_SIZE(component_info) == ZL_FW_NUM_COMPONENTS);
> +
> +/**
> + * zl3073x_fw_readline - Read next line from firmware
> + * @dst: destination buffer
> + * @dst_sz: destination buffer size
> + * @psrc: source buffer
> + * @psrc_sz: source buffer size
> + *
> + * The function read next line from the firmware buffer specified by @psrc
> + * and @psrc_sz and stores it into buffer specified by @dst and @dst_sz.
> + * The pointer @psrc and remaining bytes in @psrc_sz are updated accordingly.
> + *
> + * Return: number of characters read on success, -EINVAL on error
> + */
> +static ssize_t
> +zl3073x_fw_readline(char *dst, size_t dst_sz, const char **psrc,
> +		    size_t *psrc_sz)
> +{
> +	const char *ptr = *psrc;
> +	size_t len;
> +
> +	/* Skip any existing new-lines at the beginning */
> +	ptr = memchr_inv(*psrc, '\n', *psrc_sz);
> +	if (ptr) {
> +		*psrc_sz -= ptr - *psrc;
> +		*psrc = ptr;
> +	}
> +
> +	/* Now look for the next new-line in the source */
> +	ptr = memscan((void *)*psrc, '\n', *psrc_sz);
> +	len = ptr - *psrc;
> +
> +	/* Return error if the source line is too long for destination */
> +	if (len >= dst_sz)
> +		return -EINVAL;
> +
> +	/* Copy the line from source and append NUL char  */
> +	memcpy(dst, *psrc, len);
> +	*(dst + len) = '\0';
> +
> +	*psrc = ptr;
> +	*psrc_sz -= len;
> +
> +	/* Return number of read chars */
> +	return len;
> +}
> +
> +/**
> + * zl3073x_fw_component_alloc - Alloc structure to hold firmware component
> + * @size: size of buffer to store data
> + *
> + * Return: pointer to allocated component structure or NULL on error.
> + */
> +static struct zl3073x_fw_component *
> +zl3073x_fw_component_alloc(size_t size)
> +{
> +	struct zl3073x_fw_component *comp;
> +
> +	comp = kzalloc(sizeof(*comp), GFP_KERNEL);
> +	if (!comp)
> +		return NULL;
> +
> +	comp->size = size;
> +	comp->data = kzalloc(size, GFP_KERNEL);
> +	if (!comp->data) {
> +		kfree(comp);
> +		return NULL;
> +	}
> +
> +	return comp;
> +}
> +
> +/**
> + * zl3073x_fw_component_free - Free allocated component structure
> + * @comp: pointer to allocated component
> + */
> +static void
> +zl3073x_fw_component_free(struct zl3073x_fw_component *comp)
> +{
> +	if (comp)
> +		kfree(comp->data);
> +
> +	kfree(comp);
> +}
> +
> +/**
> + * zl3073x_fw_component_id_get - Get ID for firmware component name
> + * @name: input firmware component name
> + *
> + * Return:
> + * - ZL3073X_FW_COMPONENT_* ID for known component name
> + * - ZL3073X_FW_COMPONENT_INVALID if the given name is unknown
> + */
> +static enum zl3073x_fw_component_id
> +zl3073x_fw_component_id_get(const char *name)
> +{
> +	enum zl3073x_fw_component_id id;
> +
> +	for (id = ZL_FW_COMPONENT_UTIL; id < ZL_FW_NUM_COMPONENTS; id++)

I would type the start as "id = 0"
(as you did in other functions, eg zl3073x_fw_free())

> +		if (!strcasecmp(name, component_info[id].name))
> +			return id;
> +
> +	return ZL_FW_COMPONENT_INVALID;
> +}
> +
> +/**
> + * zl3073x_fw_component_load - Load component from firmware source
> + * @zldev: zl3073x device structure
> + * @pcomp: pointer to loaded component
> + * @psrc: data pointer to load component from
> + * @psize: remaining bytes in buffer
> + * @extack: netlink extack pointer to report errors
> + *
> + * The function allocates single firmware component and loads the data from
> + * the buffer specified by @psrc and @psize. Pointer to allocated component
> + * is stored in output @pcomp. Source data pointer @psrc and remaining bytes
> + * @psize are updated accordingly.
> + *
> + * Return: 0 on success, <0 on error

document return of 1

> + */
> +static ssize_t
> +zl3073x_fw_component_load(struct zl3073x_dev *zldev,
> +			  struct zl3073x_fw_component **pcomp,
> +			  const char **psrc, size_t *psize,
> +			  struct netlink_ext_ack *extack)
> +{
> +	const struct zl3073x_fw_component_info *info;
> +	struct zl3073x_fw_component *comp = NULL;
> +	struct device *dev = zldev->dev;
> +	enum zl3073x_fw_component_id id;
> +	ssize_t len, count;
> +	u32 comp_size;
> +	char line[32];
> +	int rc;
> +
> +	/* Fetch image name from input */
> +	len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
> +	if (len < 0) {
> +		rc = len;
> +		goto err_unexpected;
> +	} else if (!len) {
> +		/* No more data */
> +		return 0;
> +	}
> +
> +	dev_dbg(dev, "Firmware component '%s' found\n", line);
> +
> +	id = zl3073x_fw_component_id_get(line);
> +	if (id == ZL_FW_COMPONENT_INVALID) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] unknown component type",
> +				   line);
> +		return -EINVAL;
> +	}
> +
> +	info = &component_info[id];
> +
> +	/* Fetch image size from input */
> +	len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
> +	if (len < 0) {
> +		rc = len;
> +		goto err_unexpected;
> +	} else if (!len) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing size",
> +				   info->name);
> +		return -ENODATA;
> +	}
> +
> +	rc = kstrtou32(line, 10, &comp_size);
> +	if (rc) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack,
> +				   "[%s] invalid size value '%s'", info->name,
> +				   line);
> +		return rc;
> +	}

why not sscanf()? it would greatly simplify the above, and likely you
could entriely remove zl3073x_fw_readline() too

> +
> +	comp_size *= sizeof(u32); /* convert num of dwords to bytes */
> +
> +	/* Check image size validity */
> +	if (comp_size > component_info[id].max_size) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack,
> +				   "[%s] component is too big (%u bytes)\n",
> +				   info->name, comp_size);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Indicated component image size: %u bytes\n", comp_size);
> +
> +	/* Alloc component */
> +	comp = zl3073x_fw_component_alloc(comp_size);
> +	if (!comp) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack, "failed to alloc memory");
> +		return -ENOMEM;
> +	}
> +	comp->id = id;
> +
> +	/* Load component data from firmware source */
> +	for (count = 0; count < comp_size; count += 4) {
> +		len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
> +		if (len < 0) {
> +			rc = len;
> +			goto err_unexpected;
> +		} else if (!len) {
> +			ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing data",
> +					   info->name);
> +			rc = -ENODATA;
> +			goto err;
> +		}
> +
> +		rc = kstrtou32(line, 16, comp->data + count);
> +		if (rc) {
> +			ZL3073X_FW_ERR_MSG(zldev, extack,
> +					   "[%s] invalid data: '%s'",
> +					   info->name, line);
> +			goto err;
> +		}
> +	}
> +
> +	*pcomp = comp;
> +
> +	return 1;> +
> +err_unexpected:
> +	ZL3073X_FW_ERR_MSG(zldev, extack, "unexpected input");
> +err:
> +	zl3073x_fw_component_free(comp);
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_fw_free - Free allocated firmware
> + * @fw: firmware pointer
> + *
> + * The function frees existing firmware allocated by @zl3073x_fw_load.
> + */
> +void zl3073x_fw_free(struct zl3073x_fw *fw)
> +{
> +	size_t i;
> +
> +	if (!fw)
> +		return;
> +
> +	for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++)
> +		zl3073x_fw_component_free(fw->component[i]);
> +
> +	kfree(fw);
> +}
> +
> +/**
> + * zl3073x_fw_load - Load all components from source
> + * @zldev: zl3073x device structure
> + * @data: source buffer pointer
> + * @size: size of source buffer
> + * @extack: netlink extack pointer to report errors
> + *
> + * The functions allocate firmware structure and loads all components from
> + * the given buffer specified by @data and @size.
> + *
> + * Return: pointer to firmware on success, error pointer on error
> + */
> +struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
> +				   size_t size, struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_fw_component *comp;
> +	enum zl3073x_fw_component_id id;
> +	struct zl3073x_fw *fw;
> +	ssize_t rc;
> +
> +	/* Allocate firmware structure */
> +	fw = kzalloc(sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return ERR_PTR(-ENOMEM);
> +
> +	do {
> +		/* Load single component */
> +		rc = zl3073x_fw_component_load(zldev, &comp, &data, &size,
> +					       extack);
> +		if (rc <= 0)
> +			/* Everything was read or error occurred */
> +			break;
> +
> +		id = comp->id;
> +
> +		/* Report error if the given component is present twice
> +		 * or more.
> +		 */
> +		if (fw->component[id]) {
> +			ZL3073X_FW_ERR_MSG(zldev, extack,
> +					   "duplicate component '%s' detected",
> +					   component_info[id].name);
> +			zl3073x_fw_component_free(comp);
> +			rc = -EINVAL;
> +			break;
> +		}
> +
> +		fw->component[id] = comp;
> +	} while (1);

s/1/true/

> +
> +	if (rc) {
> +		/* Free allocated firmware in case of error */
> +		zl3073x_fw_free(fw);

I found no call to it on success.

> +		return ERR_PTR(rc);
> +	}
> +
> +	return fw;
> +}


> +++ b/drivers/dpll/zl3073x/fw.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ZL3073X_FW_H
> +#define _ZL3073X_FW_H
> +
> +/*
> + * enum zl3073x_fw_component_id - Identifiers for possible flash components
> + */
> +enum zl3073x_fw_component_id {
> +	ZL_FW_COMPONENT_INVALID = -1,
> +	ZL_FW_COMPONENT_UTIL = 0,
> +	ZL_FW_COMPONENT_FW1,
> +	ZL_FW_COMPONENT_FW2,
> +	ZL_FW_COMPONENT_FW3,
> +	ZL_FW_COMPONENT_CFG0,
> +	ZL_FW_COMPONENT_CFG1,
> +	ZL_FW_COMPONENT_CFG2,
> +	ZL_FW_COMPONENT_CFG3,
> +	ZL_FW_COMPONENT_CFG4,
> +	ZL_FW_COMPONENT_CFG5,
> +	ZL_FW_COMPONENT_CFG6,
> +	ZL_FW_NUM_COMPONENTS,

no comma after enum that will be last forever (guard/size/max/num/cnt)

> +};

