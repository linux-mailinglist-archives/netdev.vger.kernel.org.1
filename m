Return-Path: <netdev+bounces-215184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A1B2D7CB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20D6A00568
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3C2DE706;
	Wed, 20 Aug 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Krfcwb2w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAE2E9ECE
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680936; cv=fail; b=KBWp/MANy8cMN1OP0qikZyqL9tccNyPo8xEfSJuLDAGxwa1LqvK9TFzDJ44JXc0E/1aTPK8J1wVo/kYDebZL3Eak7IwBiuBeY98CFC0ipOocdovf/sfKRdEOUvW9d27CY3sgOMb9k9nRY3rZFmHTGl/FK8ajNSpOnFNgRDMtshU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680936; c=relaxed/simple;
	bh=/LQY/LaG1oJ5ZMax1V/qkiQPaaZbDboeM59n9e9Qe0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+d7RJQWJ1HCi3iiX8bpABVy92yPWg63Vb/oboACkglzcADaCMzUVmYP7TdJLonDYSQH6B+EQajapLQR8Ii2bXlsYNHWdmU+L8iWG4ITP4hY/IaD+RO9Y/86iZvJ+OOHOlsW4EEKBw9K0Ea7N7Hey/58tz2yIcETL1bm69MknoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Krfcwb2w; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755680936; x=1787216936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/LQY/LaG1oJ5ZMax1V/qkiQPaaZbDboeM59n9e9Qe0g=;
  b=Krfcwb2wgSDiRpE6domg/K7PyHt8feLAzI67t06cL8i+fUPp9yL4ct18
   Vu5pdsdp5jgfXFtwwrYtSvNCQinJZ3n/iYFtiMKx5tD5eu0ndsRVTt/UQ
   ZXJjlWR3k3VQBB3b58Ps+z4L0xoytWukSLVzBjKjwlDDnM3xSBa4Qb514
   QZ7QQW+6lAQw87hTW6SM1/Vuo18wJEIY+cYzTCAkdHtcLAqLpMtqfs1Da
   UZ1D3VlCf88IorRRhpURq+q5FIfHcG3uTJ9VnrgA2kjrISqtM7iiolK0z
   C6fgD2OUyGL4JVaSTPVkVEfL7Y6Vwu7XF+XG2MHxyMyQcnI8xQOl2wYBx
   w==;
X-CSE-ConnectionGUID: VYseQ527TJurZYV1qv7ouw==
X-CSE-MsgGUID: njxHWg+bT66ljY4zs9ZrNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69389170"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69389170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:08:55 -0700
X-CSE-ConnectionGUID: X6QKWldfSzS1lwwQ+FiLbw==
X-CSE-MsgGUID: pnJCBGYLSGKkziVlmlJZsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167297592"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 02:08:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:08:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 02:08:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 02:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNmwCTZIAfab3C6nDCi5zDCZMFI3IZgGBQhuMHpVunPCrGwfjn1GnOO9+f8P2PIrlb3M0V3zqm/toSN4SaVk7qb2zTHc32uaQ2Ps0K+q2rnr3GAF/edSJ1IjERM9iOmg4J0VtEeCKetH0FttASzYyj1Xe6KfYNntEon6NFxvJiEBAAxwyiB07MCO1xa+eXt25fhq7INLTmrWY1aqyfa9jPtd76y5HjLvo82Oyh6mORdZ2grkQHYCQ9CAq7J/YI+Q9aNYckEP3oZRmYSC63WpRPmdC0OREv7R2kz/snSAq+YxEFRsyYRDZkJgeOOBGJXBjYKYR+8UomGCW3GoYPpb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixOZY0meaIpFrWKmg09P+c9IeibRzkGOdKIX3UU5OWw=;
 b=jyLFvAf3U02iNEo55a5bBbP/OAJ4z2Pku07BbHTSnE3DT+I4pgLIAiBbctfm18MxO4gdI2XmrR1c16IiHlisd9HxpTGo8kHYRswiixz/XV7vbmn+4eiolJNY7U4r0AXscFBmg3/DfSn3jrSJby22kEUDdT0VgcyDPwj6C30XkHHLyvsmtIxiJF9LZNTGl8DsqOg0BVPUkmcU/dFZ2ccaPyQfoHOAZBbIArOvcnPMCxI4J4ltn0Haix3ZS2Bab/CGA8mE73CYX6viGFqAbjx5mPFspQLgL7CmgX/i2xXqwiGcfuWOYrEObzuc/tH6zxvU2VJlStLuoK6kwNGiytCW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 20 Aug
 2025 09:08:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 09:08:47 +0000
Message-ID: <e12379d6-8999-400b-a659-a7e03ea4326c@intel.com>
Date: Wed, 20 Aug 2025 11:08:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] bnxt_en: Refactor bnxt_get_regs()
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Shruti Parab <shruti.parab@broadcom.com>,
	<davem@davemloft.net>
References: <20250819163919.104075-1-michael.chan@broadcom.com>
 <20250819163919.104075-3-michael.chan@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250819163919.104075-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: d332ef76-bce2-4a21-9931-08dddfc92b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3Z0ZWdnR0p1WGFxKzc4RFNsOWJUdDFCZldiRFIwbVpOell2bStNbXFEdVRw?=
 =?utf-8?B?VkhwV0ZnVEVTZ0w5dDdrWVViWkJpcmFvWlllMjFjTzRXK2lSTEJ1TmxFRzZK?=
 =?utf-8?B?MlFiTGpJaU1rQlBaeXViS2JMRmhxUDFhMXQ2VDhCYW9ka0FJUGtMV0lxTzVs?=
 =?utf-8?B?LzBZWXJobk1EbVFQRmVod0llRkNEanRyemFzQmw4aDJYR0dqRW1OMkowWml5?=
 =?utf-8?B?WkhWcjVia2VJNHJtanBpcnhESUF4cDZoa3VoWGVrTFBjMi9LRCtZOGhSN0tV?=
 =?utf-8?B?clhEb3VZVkc1bXorRGw1dTQvUWZ1NFVCdHBwaU1HS0Q3OTJIL1g5MG4rZW4v?=
 =?utf-8?B?am1RemVVUEJlcXAwd1FWQmRES0J2Z0pHQ1I0ODBWT1prWFRxNnJiVHR1SEVL?=
 =?utf-8?B?MitudVhEUHlaRzRVQW04Z25LZE9WOHVzVGlCcHIvYUI1S1pHVGt5dSs1S0JL?=
 =?utf-8?B?RlA1eUFvS1dyNkVTWDBNYkF0czYrT2VvbnFXejdEdEFzZ1cyM2xWdU5ud3JD?=
 =?utf-8?B?VUNNMVVNTlZJR2MwVXc3M090OWpFNVZ4bUFkeEdaa3U3ejYramE5OE56WnNR?=
 =?utf-8?B?bkd2VUN3VEJCTG9EYU10OTVTamVsci8yUGhNb2pRai9KU3o5cnpVeXp0clJi?=
 =?utf-8?B?aW9sT0RwVFVjRVlZWU9BMC95Q1dENHBUWjI1T3FRSmNocUZuQ25IOExqRnVL?=
 =?utf-8?B?ai8yMGVORjZXeEVPQUhKOEZTYW9HNHBkVmQzUGVJZFZqTVhueUZiQkIyTW9R?=
 =?utf-8?B?NmgwejFjUWtsTUxZSDZzT3dMRGZIQUVVY1NwRk9mNnNsTGZnTThSdGdYQStC?=
 =?utf-8?B?R1VTK0M5dS9iUmY5QnM2dWdnMFZtb3lmZVNsT3dBaHVyd1ExbTBlcjZBWGdP?=
 =?utf-8?B?SWJudTBRZnc2ZGJ0WGRxcWE3dXdiblBadkxBSWhMZ0VSUjMzMGt0azEyazgz?=
 =?utf-8?B?b3hyQVJJdXpKZmwvWEV1Yy95bVFYNGJYWlF4Y1VqWXFLREI0MnVLbzExSjRm?=
 =?utf-8?B?TGk1cWJyM3Y3R3NWZTExYmpmK1E5NDBQTXdSbnRrRmlaRk9NbTNkdjhYcmFX?=
 =?utf-8?B?ZFpYU3pXMS9kTlRVWGZwN0doZlVENDdzQVBYd3V2QUVlQkxSTUMwN3dncmV6?=
 =?utf-8?B?N3lzL1lPODFOVFIyQkRsUnJibTJleUNrOUFNZGJlTkJORFpFQ0t5V1NUdmp1?=
 =?utf-8?B?SjcrdmZ2ZjBqTGZ2VWpZeU5wZ0YrNWxQWmJCMG5RQ1dkMUc0UTUzSWtudUFW?=
 =?utf-8?B?M2dYcGdVYjlwck9XUW1ERWRrc3NnbWpHKzd5eUcxYnIwWmR2aGRNbHl4RDFK?=
 =?utf-8?B?YkdQUHYzRGVBOHFld1RzN1k1dnA0MUFBcGU0MUpFc2F0ZUJpSWJOaS9LR3B1?=
 =?utf-8?B?ZjZwSVEvbEdybkZVdGE5K2FFQ0VMRkhWRno0VHJUVkhXdzFFZTdkUEd1MG5l?=
 =?utf-8?B?TTJyUUEyb2JkaUFQOG9URGF3NzBhR0d4U0dHNlVYanRRaVhtUHFCTC9GcXFw?=
 =?utf-8?B?MURnNEdTeGxiczJYeU9oUVV3clZNYlpoc3I1bEt1YU9iN2l4NEIxaWNhd0Fi?=
 =?utf-8?B?d0RsaFN1Qnp4Z0RRdWFsUUtGOXVDUHBuK3BROE50WFpQdU1Va1pWWDVNc2Jm?=
 =?utf-8?B?RS9PK1pVS1RsQWhlYjVWTUpvMWw0azQrcHV2Y1JHUTBpR3RjdFJLNkFmRnNm?=
 =?utf-8?B?elFpVFpTNjJVSVJ5SVEyUGdPY0lwZU85L0lNWU5ZTFVQdWJ5L1N6RGhSaXZG?=
 =?utf-8?B?RkRabXlFYTNnSUVSM3g0WE4zWW5ZM0xnMTR2MkVZbWpJZENiWVJuNlh5SFZV?=
 =?utf-8?B?UWpxUFVGZFkrVnl6YVRxWlppbkE1TnRJTklHMkpucEZGZU9Ka2x6WUgvZU5C?=
 =?utf-8?B?N09yVDhRdHh1WTlqRHBDQ3RralRDeFplM0JZZ1hTcWcwK3RNOFhxL0NpSEl6?=
 =?utf-8?Q?kRplExmJPa8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhsYkJvVGkyZlJOZm9PUEYwVWEwU1hTU2xteVdUY3dVLzI4L254aXo3ZXhy?=
 =?utf-8?B?ZWJ1a1Rpcmp5TDNhcThYQ1R5VGt1WlRObENUYW4wTS9YQWZaMEJmeWlYRW0z?=
 =?utf-8?B?aHJ0di9rUE5GNllDL010SHlTSitFWVFNeG5wQ1lPeEg5RWdqZEhnbHlRZmtn?=
 =?utf-8?B?eUZPT0lHL0d4YnZZMjdMN2xPd2xGYm5VUWFsemFuYjdaRjlSZDJUTFJGWUVh?=
 =?utf-8?B?NU9iWXN4Q0w1YnhsZEp1ZkFLL0RrKzRxMGNCRk9FT3pUaGFZNmF6TDB1bkQv?=
 =?utf-8?B?aUthMUl1WGtXWkYzRXdhWUc0SWl1dDZ0ZmVUck03aUNlckVRWS9NSWZIZzdI?=
 =?utf-8?B?aklITDRsc3RtL1pkbGNLR1lPZElsNEJXbGpyQVdnc3NCNmhMRTBPQzh4Z0Nz?=
 =?utf-8?B?RVcvejRLMnhTL3VBME1sVVV0S1VOZTJlaC9NbTduL1VsSmVuSm5ZbG1vTmNY?=
 =?utf-8?B?cXdTbGVxb24yTHB1b1dEbWNhSzFraVp0NEhYM1BDdHhBdzlzQUNDUFVnWHcr?=
 =?utf-8?B?Y2podjNBWGt5empXTEV5a0dyYVVocCtHSGw0SGhES0VtN2hlazFwWG9lU1lZ?=
 =?utf-8?B?VmZqMGNlWUNYckV2WHB2RVlNanBuRUlXWFVWK3VEUWEyY1NoV3VHelF0TjV0?=
 =?utf-8?B?OWlZZnBva0pUcmpLOHdndG0vNjJETWhTVFNqM1hJUzRoMndnUzFrdlRsdzcw?=
 =?utf-8?B?cUVES2lxS21hbVIvd3k5OWJ0S1dXcG12allVOFlPWEUwRlBlRjVWRU5neXpj?=
 =?utf-8?B?UFhyQ0hodFZZNTB2d05YTzlMczVhS3A0cDk1Wm1KVzUya242QXRrQmZJMU91?=
 =?utf-8?B?ZnJHZW9DU3Y0UndvazZlWGlvQStZckVOSVpMSUFPUVhqckJKZ1ZMTEhEZFZT?=
 =?utf-8?B?YWVNMDVXcUNJQ0lrVFpualJjUmdKMGtyTm1ab1NiYnUzUGdxVWVaeFc0akcr?=
 =?utf-8?B?aXRDOVVqVkVUNXEwWTlGbmduQWkxbkQyakRnRXVZZTZQTXdlSGtReVBMZ1la?=
 =?utf-8?B?VVFybWhFZHdldnZ2dUduNXAzaXNaWElGaHdXZ3B1VUFaL29tVEUyaHVDWkhW?=
 =?utf-8?B?ZzlvR2pqY0dNZ3EyZmE4LzdJSVhxcE5NZndkUDZIQVlZTzltTHVlYWtnd1hH?=
 =?utf-8?B?S0hHbjI4cmZDTFBnc05VZXE4U2h3cUtVUU5ScGFSd1MwRGlYQnUxZXphYVFU?=
 =?utf-8?B?cW5OR201eGY2c0M1Y25nUVM2YTJHTmsyMHYwelFUWnR1OWJxVEdUVkJnUkhN?=
 =?utf-8?B?SnpPcHlDaUQwOVZtVTE2UzY4VFNoM2lzZkIzM3VKNVdMbzVJaXk2YTZBMTF4?=
 =?utf-8?B?U2swV2tzQkh0d29lNHVkUzlMVVIxa0UxVHRwajlMc21ER3liQWRMamd3TVZI?=
 =?utf-8?B?QVJEK1d6MnBTZU55L3BXalcvdVd5ZlhlbXVMWWlWbUMvQ2lETXpmUGtnckg2?=
 =?utf-8?B?MnlETUlDbkVGS0IzRXZDaUs1MnE3MnhueklzL0dTa09jNkJyMTQvN1RXWmxj?=
 =?utf-8?B?VmZaZloxTnFHUGQzMDZUVDJoSm9uUWFaTVFIVWkzVk1DL1ZiMUc2bEs1YlhT?=
 =?utf-8?B?ZjliZEkrVlhucnZQcjQxNEZLa0Nvb2p1bzZ5ZjNPY29PNEo5TWxCNVFnZ1Ja?=
 =?utf-8?B?cTdrc0FnVHp6ZXJzQkRJTmhqbkNtdmp0MnZpSmxiN1ZMbm1wYVhuMVdwN2Yr?=
 =?utf-8?B?Z3dFWUs2bzFobklMRWNEZkJoUFNhRXJMSEphUFowbVNjVDdWc3EvamtHQWJL?=
 =?utf-8?B?enNkMVJOZGhNQy9HL1NaMVRBQ1NhVERZeHh6UU1HUWw5SytXYkoxV04zMlJX?=
 =?utf-8?B?L2xtQ3JMRnFobHVlYWN6bDJuV1haQ1ZhUE1pRHhQUlRDeHVlL3BvNDJQWkpG?=
 =?utf-8?B?VVkyT1lERmE3ZVhrZEk2ZmNzb3laUTcyb2x2RGpvVVJHZVdQOEMrVXlwQ3N2?=
 =?utf-8?B?UnRvU3psV1I5NUg0ZjB2NmQydGZTNHl1THJuNG5xYWtHMjlzSkVrWXhTaVhx?=
 =?utf-8?B?UGtNdzN6THVaamNJVnV1TDRobkF1WUR2Q1FOa2JQQWZNcHlDc0gyaTh6MUNo?=
 =?utf-8?B?ZXp2cEFUZXlWQXRKaW50ek1SZ3M0WkM3UWo2T2phR3ZoNmw3VlRoVUVrUlYz?=
 =?utf-8?B?NGZsYkZpdVRFYTdvMHZpQnNBVEFKTHdidmNCZWMzVmN0ZmFNZU5xMVRSRncx?=
 =?utf-8?Q?wGEqWN9X6ShCB91kEcQBvoU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d332ef76-bce2-4a21-9931-08dddfc92b8d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:08:47.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCX/1XJv7BTG86NIC9zQ1AhuifycyurmdUAJm1Q1cXFnXOJFe7Ok97g6psVyQXCdAb9sxrXT/g1c56eUsgI2C3w1d/5+ANyvAPuRzuxgELk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
X-OriginatorOrg: intel.com

On 8/19/25 18:39, Michael Chan wrote:
> From: Shruti Parab <shruti.parab@broadcom.com>
> 
> Separate the code that sends the FW message to retrieve pcie stats into
> a new helper function.  The caller of the helper will call hwrm_req_hold()
> beforehand and so the caller will call hwrm_req_drop() in all cases
> afterwards.  This helper will be useful when adding the support for the
> larger struct pcie_ctx_hw_stats_v2.
> 
> Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Update Changelog
> 
> v1: https://lore.kernel.org/netdev/20250818004940.5663-3-michael.chan@broadcom.com/
> 
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>

thanks, now it looks good
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 43 +++++++++++--------
>   1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 68a4ee9f69b1..2eb7c09a116f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -2074,6 +2074,25 @@ static int bnxt_get_regs_len(struct net_device *dev)
>   	return reg_len;
>   }
>   
> +static void *
> +__bnxt_hwrm_pcie_qstats(struct bnxt *bp, struct hwrm_pcie_qstats_input *req)
> +{
> +	struct pcie_ctx_hw_stats_v2 *hw_pcie_stats;
> +	dma_addr_t hw_pcie_stats_addr;
> +	int rc;
> +
> +	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
> +					   &hw_pcie_stats_addr);
> +	if (!hw_pcie_stats)
> +		return NULL;
> +
> +	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
> +	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
> +	rc = hwrm_req_send(bp, req);
> +
> +	return rc ? NULL : hw_pcie_stats;
> +}
> +
>   #define BNXT_PCIE_32B_ENTRY(start, end)			\
>   	 { offsetof(struct pcie_ctx_hw_stats, start),	\
>   	   offsetof(struct pcie_ctx_hw_stats, end) }
> @@ -2088,11 +2107,9 @@ static const struct {
>   static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
>   			  void *_p)
>   {
> -	struct pcie_ctx_hw_stats *hw_pcie_stats;
>   	struct hwrm_pcie_qstats_input *req;
>   	struct bnxt *bp = netdev_priv(dev);
> -	dma_addr_t hw_pcie_stats_addr;
> -	int rc;
> +	u8 *src;
>   
>   	regs->version = 0;
>   	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED))
> @@ -2104,24 +2121,14 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
>   	if (hwrm_req_init(bp, req, HWRM_PCIE_QSTATS))
>   		return;
>   
> -	hw_pcie_stats = hwrm_req_dma_slice(bp, req, sizeof(*hw_pcie_stats),
> -					   &hw_pcie_stats_addr);
> -	if (!hw_pcie_stats) {
> -		hwrm_req_drop(bp, req);
> -		return;
> -	}
> -
> -	regs->version = 1;
> -	hwrm_req_hold(bp, req); /* hold on to slice */
> -	req->pcie_stat_size = cpu_to_le16(sizeof(*hw_pcie_stats));
> -	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
> -	rc = hwrm_req_send(bp, req);
> -	if (!rc) {
> +	hwrm_req_hold(bp, req);
> +	src = __bnxt_hwrm_pcie_qstats(bp, req);
> +	if (src) {
>   		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
> -		u8 *src = (u8 *)hw_pcie_stats;
>   		int i, j;
>   
> -		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
> +		regs->version = 1;
> +		for (i = 0, j = 0; i < sizeof(struct pcie_ctx_hw_stats); ) {
>   			if (i >= bnxt_pcie_32b_entries[j].start &&
>   			    i <= bnxt_pcie_32b_entries[j].end) {
>   				u32 *dst32 = (u32 *)(dst + i);


