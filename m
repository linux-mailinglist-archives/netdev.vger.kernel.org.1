Return-Path: <netdev+bounces-123239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E389B9643B2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8A2838C4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5714191484;
	Thu, 29 Aug 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFXsKEcs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570218CC02
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932896; cv=fail; b=diz+PAeojQzWqBgm5KyLKAXAUNTiKMbDIjpLDe+lQCxGVJViHJt7M/iIBozBGUiqP9kLlGuMz/XYSjdPTwrtALv3sP77lTM7WHEuFDj18A4oV8nRasIOK3KVDpYkXXrrlyfz38kXxHZlYbkrBJGX8lJCm54XQyoIP73PQrYgJIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932896; c=relaxed/simple;
	bh=vOztm0jGMlwOlJ6FDwjvPaI3Z1us86s+wltjvi5NiUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJceChxRnxqmVaIu6CFEYJ9xCheRuWavS3Iyl9LFCN8bXOTRzI0fA2zKFXyIvp21Ro56XeGQ5RYFWE2ubNT5/9iqpjip33RmtV9NcZZZYu2CUkkctHM68zAHAyUIgKQEtfBydrsoLxUEVyFroInITCm5/A/baGn5UBrZnxG/5LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFXsKEcs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724932894; x=1756468894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vOztm0jGMlwOlJ6FDwjvPaI3Z1us86s+wltjvi5NiUQ=;
  b=eFXsKEcsVws86oRzydAauALbLfr8tfuBq3zU9RFlKconVN2UU+J4do4V
   RpBnHho5+LC8bR1crSwlbeGLjtdSArxouEhCmpS8NBXxGsqetlOga7CFh
   kNQiR+tbKBURJiEEmEJuUWpMP2gG2B5mMrCMU+wL0nsnRi67JbuyIAqLX
   pK6jHsJSpzHlpvUm6GsPjWz1p7V9S3f/yiwp5hlK+94YQZ6EBfBWKkeLS
   zWghl1nCaWZGCL0tu6mEE55UFNhFlqpYuyWor4bGMbmZT4rW/xlV7gQsF
   7U2HbXAqsiGAlqjy7m9tGvLZKV//mjk0C/Kv7pWG1meOf/UhFvbEunn8H
   w==;
X-CSE-ConnectionGUID: oh4XTBY8Q2mrZS/H2EI8Zg==
X-CSE-MsgGUID: PPBkdoV2T3iHmUv33IS8vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34130450"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34130450"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:01:33 -0700
X-CSE-ConnectionGUID: 83aSV1UtSAye3Y5H1x5DIw==
X-CSE-MsgGUID: zI91rYPdT5SDU6gj/hYMRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63237543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 05:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 05:01:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 05:01:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 05:01:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 05:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKW/ii8+75ANdStDgmEYml8cu2qNVu2pWKQuz3iRDzw9NgK218ny5E0SLrvv7rwpQB/KgSn5xoU0uW6aB1k/QrsqZsmpeAw63XO7/XRa3YTMQiCRtzKWyvCOxQ7oGNZwbBbvRUlSiqgc9xs5IZAd8c7fwpuVhHPAFTlbgzF+kXwXAHefcXQwlqVAoCRflTo+ROc2SZomf94gFRIcFO5jjxh0cDOCcviOHiyn4OfTyEmcJupFZ24OKR/AD/rbsAuk6rMLQvmrgXMAj4ln13bf1lSZx8P0MAAbVPSJ7i3p1vuVIHUxxFIeXYXZUiy0pQZx6+jUk1gED5caFS/KpDr2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFiCl9a5zM2SaxhONF/yQqpifzIRAYL3FirB7XXrSO4=;
 b=vmTIxQKIpB+D5ry0+uJUnkr2hbRrCXQ19fsI5BIvwZ19tYhgecD4iKBYNLj9xrykhe+e38KvDrupvRsTHEUuzUjMYGUU9pmhvqpWGWPbPCJLY7tlgaw+ZdvSg76hQM0tLjKp+mFHV71o5vYTOqI8aqxT+9UY19qahrIjEnsdVTGbFZLtjN/C6Vo8eUfXyvE4oUQIQ1Np87A79EQRBZOBFlfiRjUKaM4J80uesYw1MEvDN7ED9QvVK5ob7XdACpxHVkuJUwHDMoGuRZMXJGERsgKmw0gKzQMvg96xJCpdnlEYIJ8iy71+VvHZgZlGWeniUesZu4SRZ/naJl7c6cqmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:01:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 12:01:27 +0000
Message-ID: <bf736d48-813e-4bdd-b33f-23bb1c7d4c0a@intel.com>
Date: Thu, 29 Aug 2024 14:01:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-3-anthony.l.nguyen@intel.com>
 <20240820181757.02d83f15@kernel.org>
 <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
 <20240822161718.22a1840e@kernel.org>
 <b5271512-f4bd-434c-858e-9f16fe707a5a@intel.com>
 <20240826180921.560e112d@kernel.org>
 <ee5eca5f-d545-4836-8775-c5f425adf1ed@intel.com>
 <20240827112933.44d783f9@kernel.org>
 <ea4b0892-a087-4931-bc3a-319255d85038@intel.com>
 <20240828132235.0e701e53@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240828132235.0e701e53@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::49) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 905b141e-8d01-4d0d-93e3-08dcc8224ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUxsNW1xUTltb21sd0NEU3gxcm03Zzl4dG1YYnRnR2FQMDcyU2JRMFJwL1Vl?=
 =?utf-8?B?dTgxaSsrQTI1dzhxclhtMDN1dVNidW84TUlHR1o5T3JGNmR2N05xSEI0Qzcz?=
 =?utf-8?B?bDZuZkI0T1ZyRHRRMFRnMFFFNkRKclJvbXpSZnJoZnBpTHRGTmsvNjJBendB?=
 =?utf-8?B?aWpFV2NWZlkwK1BaTlVMSUxMeFR6MzQ1eXVxMlZ2U2sxd2NvOTA4ajl5eTkv?=
 =?utf-8?B?WE1zRXJ3OHZrc1d2OG5SQVRpWkJTLzFldmxXY2pCejdhWS9FdW5rOHJMSlBz?=
 =?utf-8?B?endnWThwSGt6Q3BpL2JVbE12eFUycFBkRUJOL1pIZEtMT21aVGRKeDBRTm9s?=
 =?utf-8?B?YUd2VEhGNlcyaXRjZE13V0V4alFVci8rb0Q3dW9mQ2dRU29ydUhST3l5MFlz?=
 =?utf-8?B?VWlqQjBHZ0FpdEdxUG10dFllaGZJdnZvSERnWUo1dzlJd3pHb1FkUWxCTlZk?=
 =?utf-8?B?bDFBVlNLcHIrQVNhWjFodHNMZEwyMEx0MWhPd0pWT3I2K3pRaUNZZHlpdytl?=
 =?utf-8?B?dlY3QW1WNm9QSG1rTksvQkU3dFpuamVPWmFwNWp0bmIwMkhvWUxzdktaSFA2?=
 =?utf-8?B?dDYyckp0Ly95WVNIeDFDQk1lTHlmbHErZlUwVnlpYlY4ajdNQmZLWk9GUG8x?=
 =?utf-8?B?WEJPaExVL3p3ekFCRXRvN0xMVTZkcVQ4elZWNnMvaWU3THdRdFdnbW1FeGxN?=
 =?utf-8?B?ajFRV054Yjc2Yko1Szg0WXozSEMwTkNqQWIraXhNZ0ZPR0J1RGZqcWl0NlpQ?=
 =?utf-8?B?bG1Ya3dwZWxCU2pCWDZSK3NxNHJoTDgrQi9iK016N0VQNVFCREljdld4czFN?=
 =?utf-8?B?UTZEb1B4UENGWXdYMnJSMGltL0JmRExySjJLV3N3SWdZcVpHNkx5UUdzT0pB?=
 =?utf-8?B?c3V5ZnZvRUUxVkRCek9OOFlZZ0tQSWNOSnhIdHZ2blc1TFVERE1mUzVUelZT?=
 =?utf-8?B?bmMzbk1MKzdsU0VaQ2NnciszaWM5QVRnRjg3aTBMUlNtR3dLN3VSdDJqbXZq?=
 =?utf-8?B?YWRMalNoVXFra3d2Y2xCMmYrVFZoVmo0L1I4UTlmQ3k0Q1VoNUtXeUhYS0tQ?=
 =?utf-8?B?RDJXb1RCb0w1a1E2clU4VjZvUk5EaTlRNzh6elZTMjJSQzdHNkU5Z05MekF4?=
 =?utf-8?B?QXlOSEp1VGpWcHhmL1gyNmhLVGtURWNVS0d1YnpyNjJ3alpsV0RySTFueFlR?=
 =?utf-8?B?WGR3T1R0NGVZSHVYV00vZjNDZzgvbHNKNGp4SFUxNFMzWExOSzRCNWFZaWRm?=
 =?utf-8?B?a3hjeVQ4WUxSOTFhRTVWellDUks0TWtUc215U3RGRHcxakhJQWtyaE4xbzJp?=
 =?utf-8?B?T1NTK2FwQWxCUzBzK3ArendNNHo0eEd6cjduRUpxTlUySE55a0dIZ0wzQUh5?=
 =?utf-8?B?NjhXU3dtekRacmZ3aCtpbkhZemhKbDZvMmlUWlhxL3pXaVZadzA0Z3ozMVp5?=
 =?utf-8?B?U25kKzJBWVVKME1iSkQ0VTBBdXEzNlk2THNmY1UyVEl4bVBxSXZxeXVSSllp?=
 =?utf-8?B?U01zY05rV2VnM2JUQXRTZzlqZXBrb1I4ZmFRbDBuMGxNRUt0c3R2UThOREpU?=
 =?utf-8?B?dVBva2RVY2drQnVHbWI3TkUyU09PSUZRakZvMHg2TjhtZ1V3azhtMWZoMkp5?=
 =?utf-8?B?SEZ2OW01ZWtsd1ZWL3BoRzVOMWlyTVVYcUFUeUVuNFV0MzlUSTNTOVo1blly?=
 =?utf-8?B?QUV6RllBMG5XdmZ2VTIxK2lXQkVkREtVSk1FdlNHMC9vVm5ML0t2MVFmR3g3?=
 =?utf-8?B?aENkd2hBZVJYRHNvT08wT3FvVHpWd2ZJMGdmOVVIVWU3bE1heHNTUyswVVA2?=
 =?utf-8?B?UVNiUVhNUUhXTEdManZsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VBL1pLeGVRVncyZEphSUlST3hyNDVkNVV0WUJDeDFlOVRPWlRFeDg2dzlo?=
 =?utf-8?B?ZHg3S3JzV0psdHRDTUpVcUhVek5XR0hlazJXUk9IMStFQkh6aUp6cHRyYWx6?=
 =?utf-8?B?SGJycHlndzdCYTN5ZUZZQmRyRVQyS0NhV0o0OWtpeWk0TGp4YkM4aGJXaE1z?=
 =?utf-8?B?Skc1azJ0U3I4TTBOa1JkNGVaaUJIemJIZ09wOHBKR0tRV0M0WkZCTXZOaDR1?=
 =?utf-8?B?aTdXc0l4Y0hnWStFVitiaWljNk9LQjVtdkFra1VEZmxKdkxzZytFT0pJZEhn?=
 =?utf-8?B?VTJHWDdjRXBKYU1uNGVVQXBzbWZKOTJMdXhSSW8yMVdtRmgvRmt3T0plNVVR?=
 =?utf-8?B?aDY3QVhLMlFYMllrREFtK0lUSkh2UUpURk0wSHY1SEdVNXJLSkRKRTNBaUsr?=
 =?utf-8?B?YnUxR1VyanRlREdIV0tIZVY5MHAxd2I3UkxDOW1PL2xlbXBOZkZtY3NzL1hD?=
 =?utf-8?B?a2s0am1xN2FJSlN6c01UVmNULzhWV051ZnFsZjFjRlNoOC9MNTRSZDNXNk4v?=
 =?utf-8?B?SkdZOGNJK3FKcTU3NHNWMXR3d3FrSWF4YVVYbGhJYUR1d21wNnlCL1l4OUk1?=
 =?utf-8?B?TS9tZHN6ZjV4ZGVHelg2U1Q0OFNMYTdkdmdVbVNmeXRMSCtkWFV3MVBaemlT?=
 =?utf-8?B?WENiSStWWVBDQjJnajlrdmVNdWJ0enpudTZKOXhnOWZBRE1qZVlNWXd1cGl1?=
 =?utf-8?B?bmlHcDNhNGVUalRnNlVPTzJhYk9CTEVjbEhvcDllOTVaMXJybW5Qb0tFeThu?=
 =?utf-8?B?QTBrbDRrNFBRK3BCb2U0SnlFVEVrYzJRUEdhbGp1UUh5clFlaTl1V0JTWHJE?=
 =?utf-8?B?bnkvMVVpek5tNlZHQkFaOGlQT2t4OTlMOEhWUGF3RnZRa3hoUzU3ZUZQYzBO?=
 =?utf-8?B?dEF2cGhmcVVEUGRMdE1uUWlpcG9nams3cjNDd25OTHc1T2RoSnhGT3BubEVI?=
 =?utf-8?B?RE5XZzNwZGJpMnhxSDcyMGtGY291WVY5blBFWEVtZThZWDFJQWlyeWoraTFV?=
 =?utf-8?B?NlJJdjlvT3EyaHl4ZWl4cEZ3ckZwOHh5VnNGNFVUL1dMUU9UNUxJc3M2Zk82?=
 =?utf-8?B?SitxNUtXTDdFdEtzSFBhQVcyMmw1T0lTRTlaRHZ1NStZMkQ3NllCR3FZR0h6?=
 =?utf-8?B?ZS9WdGZPOXRLZVBJMnZlTUsrQTU3RzFJQVRlempyNnAyRHJiNGJLdGxndG5W?=
 =?utf-8?B?TWFjajdYZFJBTm0zeVFqeGRPUU9zSVpBaTE2SWtLVUlKVVc3a1RPQ2dpcWY2?=
 =?utf-8?B?cGdUaHViVU9HK2VCTU1Cb3loN2hUcVJFSkp5VGhnbWljL1R0U3Q4dVFmVUtJ?=
 =?utf-8?B?RVNsQnpLWlBTZDhCWWorN0RWM284UnV0UkJEZnVGK215MWd4RndtY2VqczRF?=
 =?utf-8?B?VkcrRUZpeHRoZlZ2d3BIMTRqVy9HT3YyTENvSENJc2pkdmdJeHFEYWpLUXpD?=
 =?utf-8?B?U25SbGIvaGFVV21LbERzR1g2VDdMQktZekl3c28waGVOa2YzLzhvUW5aZWJz?=
 =?utf-8?B?MzBjTEZ4NnRpQVo0akNLNWNpTllEUUFUdWlYVXhUMW0xMWkzMTlqN0s2Zk5t?=
 =?utf-8?B?dGFOTjJvZ2hPQnYwUFo0QmVpZ1lSdWZEWXRINk1kajNQWEdrTk9Ec3Zld1Nn?=
 =?utf-8?B?UDczSDFMMklOTjladjVrWEtmY2QxWkVOMDRGcklFYkRCY2FpTTl6V3NsU3Zh?=
 =?utf-8?B?aXI0QU9OdzJvVXBucUNSSWI1SkZGZUVuVnJyYmZhTUo1RXBoNExVL04zRkl6?=
 =?utf-8?B?TUNCR043RllXMmU4anFDRFg4YnRVbjdvSEtIQXp6S1RNY2R5OExMUXFLNnRx?=
 =?utf-8?B?K3B2MTJPV1RCeXVOYWVVRm01OWFwM2dFZG1LQVJFcXhtQ0xZQkJkaXIzcHVN?=
 =?utf-8?B?UWZkQ2dkbFNEbVFIRDV6UUd4Y01lRnZVVTVBRTFRSHk5NXU5VjE5WlIyQTlz?=
 =?utf-8?B?czJXV2U2eUxYRU9HWHo1allzSzVHaWFUaThnTGE0eE82d3BabTRQWkluTWM4?=
 =?utf-8?B?clNVUlp6RHlITzdUeDlvbEV2M1lHWkRwcGg0MXdSZm9QSFRJNHA1M0tMc2FQ?=
 =?utf-8?B?T2cxdE5OUkRJaXNtYzA3VkMxazZRbzVabHRYM0hDRXkvNkt1SExBdFpHSlY0?=
 =?utf-8?B?eHVQWGhXaTRaQ2tpcmVyNGhvcmFRM0FmakxiaTVGcllMSDlFb1dqSXdtYS9v?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 905b141e-8d01-4d0d-93e3-08dcc8224ffa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:01:27.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ1rsh7NfnDtN8O0KzKegGE0amZpnrUYJO5Np4Bjhx/p08naa1llegz81FbQKDTbthfnJdQAcZ8kCC+4uCstzwoEpsMGrd06o555Sy/wkO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 28 Aug 2024 13:22:35 -0700

> On Wed, 28 Aug 2024 17:06:17 +0200 Alexander Lobakin wrote:
>>>> The stats I introduced here are supported by most, if not every, modern
>>>> NIC drivers. Not supporting header split or HW GRO will save you 16
>>>> bytes on the queue struct which I don't think is a game changer.  
>>>
>>> You don't understand. I built some infra over the last 3 years.
>>> You didn't bother reading it. Now you pop our own thing to the side,
>>> extending ethtool -S which is _unusable_ in a multi-vendor, production
>>> environment.  
>>
>> I read everything at the time you introduced it. I remember Ethernet
>> standard stats, rmon, per-queue generic stats etc. I respect it and I
>> like it.
>> So just let me repeat my question so that all misunderstandings are
>> gone: did I get it correctly that instead of adding Ethtool stats, I
>> need to add new fields to the per-queue Netlink stats? I clearly don't
>> have any issues with that and I'll be happy to drop Ethtool stats from
>> the lib at all.
> 
> That's half of it, the other half is excess of macro magic.
> 
>> (except XDP stats, they still go to ethtool -S for now? Or should I try
>> making them generic as well?)
> 
> Either way is fine by me. You may want to float the XDP stats first as
> a smaller series, just extending the spec and exposing from some driver
> already implementing qstat. In case someone else does object.

I think I'll do that the following way. To not delay this series and XDP
for idpf in general, I'll drop these stats for now, leaving only onstack
containers (they will be used in libeth_xdp etc.), without the macro
magic. But at the same time I'll work on extending the NL queue stats,
incl. XDP ones, and send them separately when they're done. Would that
be fine?

> 
>>>> * reduce boilerplate code in drivers: declaring stats structures,
>>>> Ethtool stats names, all these collecting, aggregating etc etc, you see
>>>> in the last commit of the series how many LoCs get deleted from idpf,
>>>> +/- the same amount would be removed from any other driver  
>>>
>>>  21 files changed, 1634 insertions(+), 1002 deletions(-)  
>>
>> Did you notice my "in the last commit"?
> 
> I may not have. But as you said, most drivers end up with some level of
> boilerplate around stats. So unless the stuff is used by more than one
> driver, and the savings are realized, the argument about saving LoC has
> to be heavily discounted. Queue xkcd 927. I should reiterate that 
> I don't think LoC saving is a strong argument in the first place.

Yes, I got that. In general, you're right this hurts readability a lot.

Thanks,
Olek

