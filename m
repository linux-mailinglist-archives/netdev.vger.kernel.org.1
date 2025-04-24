Return-Path: <netdev+bounces-185638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078BA9B2FD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740AE1742D3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA1827F4CA;
	Thu, 24 Apr 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn0eFEDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD827EC6C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509786; cv=fail; b=VdDqly884vgHmAswvx0+zOJSF7P92boWErauBNzS41NJqShW4fOINUrAs34d/KECeSoUvIbQXj/b6RF+Pgwjq0ElHMJluvbvkdQC7FuQwcchwYPUGLKahFpKrD7pFq5VkIxN7deNrt4cKGVnjwmMJSAQsLG5dSPSuVTHdRGdSek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509786; c=relaxed/simple;
	bh=YvEaVSmCmBX+EU/85kACsooF6uWjUnbzjP0aEUFXPFQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmgasnLqTpTRIeZp2nZnBkVQQAwcioneIOJMHwSwyNHDEzMtmX+MlJ76Nv8X37HWNVsqRfVEVjfG5wj7HzVCCaCMy/4lgPUQR7yPe50bfVUtkyvkosaYq6G/DDX1y3q+Oj9IZjKEx0ZihaIKZB5EmEPRSVxMwa7SAQQDDSKWjgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn0eFEDZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745509784; x=1777045784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YvEaVSmCmBX+EU/85kACsooF6uWjUnbzjP0aEUFXPFQ=;
  b=Nn0eFEDZ/ktTJ6xJeYn5lPyQqhAiCe+LVyuT61ySrc4XrXxFiNGu8DA+
   1wuUpSe+X9vjQPd2G/700aYngs4rp/hne9XR2SWwx+cyMVnmk6vSm7vHX
   ly70Ap7eV4owOuy7PvXmOSrcZoMOQ3DnU7b/cMnGsolscIOUmgpGoTZ2J
   bs+wEX02CKQEbD3nfPnoPZGLU6SWck8fCtaCXYfRGu2G97p+IWR4AnQ6+
   Q+59GOEcu9MuQ8vdRBJf9jcvYINsZ6FZdKaO2u75OKuOMWWo0Mtk/FCnJ
   nZMCtnp2EiZJ2IpI8Ld91rvoKiUtcfeKNKRqqpT6Wmj9MwWKlPA7bqcja
   w==;
X-CSE-ConnectionGUID: 47FRgoTASkmMVs2WoTh9Tw==
X-CSE-MsgGUID: SrhI7V7mSyepELIUz+qAAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="49810101"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="49810101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:49:43 -0700
X-CSE-ConnectionGUID: xulGUjkRRmO/6TaUuGCZlw==
X-CSE-MsgGUID: STmWionMRIS5xcOEwgK4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133171766"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:49:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:49:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:49:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljJHVaHUUOShv5GED2gNRasnwNMOGuk4ZEi7RKrpFg3j3f6mOcORA4j0XW6c+eD44bJB9hF7P5bav7qEqYiCw123gTJpMv/0269L5SlLy0dyTvDKYfmmUB1fZJvVOeejoTLm2A0ZRyPlXLoKY/sZRvvSviXXQv6lFOiR+M3zO+V50AflHiVEkpzZF2f6lDcFForzRS/4rUNXaggRvedle5kN7wVEwchCTxiuON6MW0kDI4vvmcoY1HhOCocMA7QlKhN9K+jfdBmlVTdmNo885SMgE5PsH1Cp9+qjlFLvMupO1JCifGDvYSTl9E7rfqD+ur1seuk4ZM9Pqa+SEuuWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bIz+iSG1TtbCAAMSOdc7N1t95SEo3/hHHovgoiLgBg=;
 b=JYhs43NfB5UKMXVfo/8Gqb9CMcmpkVsGsH9nzvmBTx9GUpLcw1pLc40i2RstbjVJKsBoNyK4zFrXEZ95WhSSYHCrUkWJDpgnOS3ZWyqNZX+aW0RormJhVIRNF4Q66KUN9wMML5FNq4gB9k9gD8ixGMG8n3ahBAVNbu751+eS6YtqawuED6cZb3brLwF0pxFQgCEbs4YgKZdQKKkQFTfnw2iWH5XYG11ywkG3hHfw+5+9l5ydKacJZlRxLPwVLeysTuSOI+b9ib7HrrMrCWaN6+5qo4AaL8nvzM5hwRe9sm/YKJEppSdW1PZhApPUzaeEs+d4jkkk2TPiDIUKtcHJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 15:49:34 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:49:34 +0000
Message-ID: <cf6ca99b-4d3b-4120-aa23-77335fc25421@intel.com>
Date: Thu, 24 Apr 2025 08:49:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] tools: ynl-gen: fill in missing empty attr
 lists
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-4-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 008a8217-a1f9-480a-e376-08dd83479c0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW5ZK21menkyVFcyVVN6M2hKay90UFlDbVI0bzBDN1dxRXVTTVd2c0ViUk90?=
 =?utf-8?B?bFArOGZJT1lyQm5WeGNtTm9aSHFHaUZ3Q2ZxUmM3TlYyanZRc3oxbjg5QnhZ?=
 =?utf-8?B?VjFvTDRNRXRud3Q5UTdLTmo5ODU5STl4SHByRWQ3Vk5yNnZoeERCa2Robm1P?=
 =?utf-8?B?amdWUXlHWVZlU1BEczVuaHdyb1pxUzRSS0lNMHR5enRQZFNtRWE0Y3BLVHlZ?=
 =?utf-8?B?NzVBdWFDcXlCUHhzd0JXVFZjSVU2OTB0UEVBRXNhWjFDMGFPZ1dhejNsWFNh?=
 =?utf-8?B?azd2OEhZSVRYMHBFWFhTSUNhU3FMMExobWFFTEdpMm5WV1hCWFZwMkpmMzNF?=
 =?utf-8?B?TE1ha2JUbE5Md2JuTHdJRGZQZzYyL0xjNkVuM1grWUdpekwwbXRZUDIzbzFO?=
 =?utf-8?B?elJWRjV5elVHdUlvNm1qQ0NxUnhlaStuQ0xLSFg2Wk9TR2hjZ2hYeVpjdHZ1?=
 =?utf-8?B?d3FWV0d5UzZkT0MrMlBZNTVhaitLVWpuT2hFaFF2bDIyZGVEY3R2NTNNek05?=
 =?utf-8?B?dnpBSFBMNlZNdFowbnBORkJtTmR0RnFmNnpmTERhT0w1M0JpNEk3MkJVSWNE?=
 =?utf-8?B?cTFKc3NFamd0R285WDMxSDFURkpRL1M3ZDM4TUtvZUNnRUgxYmtOZzVPUmZG?=
 =?utf-8?B?RS9uNlhmSEhKR2NkOGhvOHVEL2dDNUtYUzAydWxsa0VvQ3pJZTVtdHhwWGFv?=
 =?utf-8?B?LytNOTdFWU4xYXFCb2FuTnNvMWhUQy9Za1ZrSkNUd3VLekNxdUkvMzRSN3VE?=
 =?utf-8?B?NXo2NVNDZU13bk1zb1pVdHNrN2plU05YNnhaZjM4NWVEMkc1amVCaCt4SC9v?=
 =?utf-8?B?eDQxZVpnQVlKZ1VnSDdlSit5TXhNY055cjkxeXpRdWNiVW5jVmNhNkkzR1Aw?=
 =?utf-8?B?U3BUcDh6NTJ5WHFib09DUFFKNU5VamIrdFZTS0NqY1lwQm01ckNqMWFVTUxD?=
 =?utf-8?B?V2R2MGNRR2lkVWhtclNPRUJxVnRoQXFZc1pzSytndEMvSjRzUGpmdkFCTEJX?=
 =?utf-8?B?Y0dzdTZUTjQ3L2hoWm1TMTlkb2Joak41USs0cnZSS3pHR3UvTkVaRVJkOEgw?=
 =?utf-8?B?WkRMZzltOXg2ekgrS0pweHc2S0lXdXRYMkJKN08xSVRKZGhjbTdXcU1HazQ5?=
 =?utf-8?B?S3BGL2Fkd2xIZGlaNEhFeUZjUXowMzZhcEJnQUkvWjFpS1JVTUlJUVFhTVZF?=
 =?utf-8?B?U1p6bjdqVlVCN0Y5YklZdkZFQVhDcXk2YlNRbFM0NTJyOHBuOFFreTZBcGxT?=
 =?utf-8?B?b2QxY1NSTXp4NEJXU3l3YWl4S0lPV2JhNWErUW1IbXozNFhoeDdIc3NpSlZv?=
 =?utf-8?B?cEF3dXh1Q2xscmRoVGNCbWR2cURlSGRtMk91TXpRWHAxUmdjcHhXV0RUKytP?=
 =?utf-8?B?YXRGM0ZlOHI1ZmpIejgxUEpjYXVoOC9rcUUwa0dWbG1DdlY3K0xtUjJYcXNX?=
 =?utf-8?B?SUJsem5wcWxzVTBoeGYyU0hYK1g1Y2U5cXdWb2hXT1doVitVekQ4UjAvSmZw?=
 =?utf-8?B?dC9qRGxpVDk5Rm5SZkFpRnBVVDZvbFVPRW43WDVQTzM1T2h1QVlzQzZuQW1l?=
 =?utf-8?B?eTRNbUZmcXRwNHR4ME9BSUxFUHdOT2pqczl3bzJRcWYwdGU3ZWdjdlY3elBp?=
 =?utf-8?B?VDBnZkNnNFZGeG5vbS9TTHpRV3BoRE5rVVRNRU9LbkU2Q0ZtR0VUWHhaQVo0?=
 =?utf-8?B?ZWZFL2RWc2g1NG9DZXZCQmNrbVZqTVl3REVZeVRPU05SQzhDQlA2ZVJBaUtS?=
 =?utf-8?B?MnpUZHRmN1lZdTducDBmdXJod2pWSVJNY2xtcXhWczdBbFNzY1k1d3dNUERO?=
 =?utf-8?B?b1lNdGlTbDRoYzFqVG5rTmcyZG1jMDBGWGlFaTVvbDdEdUpBcVd5NDFvUXQ1?=
 =?utf-8?B?aTBPbnBONVBrUTR6UDdSWGtIL1VMUncwTnBWUGZMN0srREdDMlBEWHJOV05n?=
 =?utf-8?Q?9tCXBS6piOw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUw1TEQza2d5aHNUd05WODUvLzFlUFdLTHpEN1BYUFFXTU42TWwyeTJteENx?=
 =?utf-8?B?cm9hU2FKZjhOK0ptYkVwc0llT0JmZHJBZlZKMlpEMDFlVzJ1dWVtSnBkUzh3?=
 =?utf-8?B?Rnd1WHFaNVloRGFsTjcwUUh1a3ZGRUVZZDdPc1NPV1Z5T3RZODl6QWdnc21l?=
 =?utf-8?B?VHJNNDJFOVQrREwvMjBGaURsajM3cXlMdHJDdXV5bDZoNjdmdjVPMzhGSFFU?=
 =?utf-8?B?a2Z2eFlMZ1dVVVZPYjlPWWFYY0pyTGFRNGlMQk5KUHhyNS9kdUdTN0taZWhh?=
 =?utf-8?B?NG9kT29vZTFSSHpJa1l4Y29IVGc2cFpYdVE1WVFwS2dMUmNsZVZXQUdhUjds?=
 =?utf-8?B?NWRtK0gwT0RDMWp5eWc4V0ovZW5FSTRWNTVrQWVKckFDVk9vRFc4NE8yMzBt?=
 =?utf-8?B?cjZRQTFwb3hnQkhlSXE2WkJvQmxRR1V2Rm04ZTVjRDdtMVZRMXJIOTB5azdS?=
 =?utf-8?B?K0RqdGZMMjFsRSs1dy91RXpuZnVZV2Q3ZEk1Ynl4WDR4ejlDOUxOSWFkQW9M?=
 =?utf-8?B?U3p1THZHQXAyVEdpUVJsZFRIc0ZuQ092YmdaZHhZN2x1Mm5IK2ZTaHlFaHdM?=
 =?utf-8?B?TUs4TVJUdHpmZGNOUEpuTjRDQkJBazVqQUhkbEdIWm9xWlhmRXFsOUVpQTh1?=
 =?utf-8?B?NmQ3NmJSeFBLZnBscld1NWVGQmJuWUYxNTYxNy9uWDdFSFNPUC9oS0V5Kzht?=
 =?utf-8?B?aHRQY2llYi9zclRURFcvaWt6SkF4ZEFiVThoVlRJQlptdmVwdk1la05EQjYr?=
 =?utf-8?B?M3JvVXhaMmJDL2FUUkpySkxrZVRLTkFPdnFhVFdGRFN2cUlJM2grdjdlMDkw?=
 =?utf-8?B?Z29WakVsRjh5Q244UWp2bnJJYUQ2ZXJVdWFZUDdkTnp1S0dmYWk5MHhBTVR1?=
 =?utf-8?B?QjZzOVc4eWh1c091a0tGS3lCTUh5bGlFMXZGVU9Ha0pQZElveDkwSHEwQi9a?=
 =?utf-8?B?d0tGdG4xMUQyOUJQTG11NDM1VEYvSkZmbEVSek9EbE56MXRmYjZ4ejJ0aWlT?=
 =?utf-8?B?T25hUFU4NUdyUUgxaXpJbkNhZHZoM0E0ZFdzUjlzZVBOQmoydzUvSFkzRWcz?=
 =?utf-8?B?Ukx4WkdFT0pacjhsbm5lS0xVMVZrSC9Fc28yN1RHTkw0OUtEZExwK25INStS?=
 =?utf-8?B?MUVxZDBhdHlmQ2lYMDRKTC9hSGxWT3U1ZXhFK21SUUxPMlhzdU1wQ3p2M3Bn?=
 =?utf-8?B?N0hyamY1QmplWmtKclViSUo1bFZKUDE4NWM2MURON3l3ZU5aZGNMa2haVHRa?=
 =?utf-8?B?cm5pT2UwTmdnMkV1L2FXQ25FblgrQUhqQXRoaDJVTGpOU0cyN0Z0a0d1eGl3?=
 =?utf-8?B?RnVPdGJRc1p0bGNWVXBFUnZPaEtoYldWRmxhbktwK1VkcUVwWDNtOW1tUWhq?=
 =?utf-8?B?Q25FaENxRExqYkJ6bDNNdENPdmFORTFZQTlmcVFFM3hueVh3eEFzczIrMnE5?=
 =?utf-8?B?bkNUdHFJZmZoTDN0Q3NkNFExTGhNQ2xiRGp5ejJCQ0hkVWRnOVh3bi9EVkNj?=
 =?utf-8?B?TUp4elBjTElGQW9WRE9KNFY4UXBGNlFoZlJxZXhnVXhaSm5PZlZjVHNyM2hE?=
 =?utf-8?B?djJhSEdLTkc0V2R4Q003QjBMd3FUR05kL2pzTzdDcGpieGRwMnpaL282S2hP?=
 =?utf-8?B?eUU3UnowRzc2b0hWdVhkWkdnclZ2SFk2N09iNi9NZFozSWFzeW1pczVyRkMw?=
 =?utf-8?B?ZVdYT1RsZ3d2d0VVQVlnbUpVMnVuaXFUdllVdmp0d2RnSCtQQW9hdEtOTEI5?=
 =?utf-8?B?NmNsYllDeGlHZjFpM0kwUi8wR29iVHFVS2RPdGx2WHlNcUc4TEtGelp3bVNh?=
 =?utf-8?B?a0FwTGdwNkhHQXdKNmovWVh3cXU4RmNkQUowMmdXcDZKRjZjWVNSMzJrMG5I?=
 =?utf-8?B?S2NTRlZ3ZkhZUUlTSXNURHdnUXYrQklJd2ZyRkRlS1hsNGJHSEtab2xnSXVz?=
 =?utf-8?B?YXlGZHAvdDk5V1crT1ZjUzNNQWVRYm1xbHpRZXN1Mm5lVzZ5aC95ZGppU3BU?=
 =?utf-8?B?VVk4aVprZndNOGxlWlVMS3VobkVoVGpvd1FJWVdRN1VKK2xXYldHM2FQa2pX?=
 =?utf-8?B?Q01wbGVGR3cvV1lBMmM1eFh2ZDlNdmRGMStlditZb2VrdWlzTTFDWU4xVm4z?=
 =?utf-8?B?UEszN2lTR3Brc1hUdnl3T2xhaHU1SHhycmtLcVhoNkxiamN1WTZiYjN0N3Np?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 008a8217-a1f9-480a-e376-08dd83479c0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:49:34.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0c0H+b0Fd6bNtmRh1DAn6+qJThSIOPVc1r5pFUIwKQpZ5RvL8UIrsX+n0lgSiq0OmpN3vtehocjsNgMQDdzkVLYCH/VJKTntfqjS/m0Ttw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com



On 4/23/2025 7:11 PM, Jakub Kicinski wrote:
> The C codegen refers to op attribute lists all over the place,
> without checking if they are present, even tho attribute list
> is technically an optional property. Add them automatically
> at init if missing so that we don't have to make specs longer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 90f7fe6b623b..569768bcf155 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -938,6 +938,16 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>  class Operation(SpecOperation):
>      def __init__(self, family, yaml, req_value, rsp_value):
> +        # Fill in missing operation properties (for fixed hdr-only msgs)
> +        for mode in ['do', 'dump', 'event']:
> +            if mode not in yaml.keys():
> +                continue
> +            for direction in ['request', 'reply']:
> +                if direction not in yaml[mode]:
> +                    continue
> +                if 'attributes' not in yaml[mode][direction]:
> +                    yaml[mode][direction]['attributes'] = []
> +


This feels like there should be a more "pythonic" way to do this without
as much boilerplate.. but I can't actually come up with a better suggestion.

Maybe some sort of try/except with a catch for KeyError or something..
not really sure I like that more than the list approach either tho... I
guess it would be:

for mode in ['do', 'dump', 'event']:
  for direction in ['request', 'reply']:
    try:
      yaml[mode][direction].setdefault('attributes', [])
    except KeyError:
      pass


I'm not sure thats really any better than the approach here.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>          super().__init__(family, yaml, req_value, rsp_value)
>  
>          self.render_name = c_lower(family.ident_name + '_' + self.name)


