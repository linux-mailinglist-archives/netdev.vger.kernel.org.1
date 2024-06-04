Return-Path: <netdev+bounces-100755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F58FBDE5
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E751C23C27
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB6142E6B;
	Tue,  4 Jun 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7XcyeZm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DE140366
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535621; cv=fail; b=Vi7eNK1rOuGX3VkT12gbHnmcnrnPb2kIaTHitDi1SIlEGqlMqp1ZX2QqaE2uSJfinEvCgBZnhAt+/V9SvWJGvWhAGaQJoBaB5QsinWrq+jFxVKwUtMQ2l25cqy26oZzjZuHC0SjUdfNicnTkSRmDEHF5BxaLhUKDXNZ4RXyXOLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535621; c=relaxed/simple;
	bh=FUddArGdmCF8RXOMO69XY1UniwMl5nF3LOMEnbH/Ork=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pje7kl9AcBGTLjKf4EcDU0qc2/T8u889tcJMotOB+3WhRDC8BvpD3VconL4YXn1xUlNAfiSCVjtLizMye0cI7sRJAXryT1MEhCdqRMsyGOBVEVhI8EI2jqEX6OgPBIno57SwaPfTMKMKZsBbtYLAO5E5/1cCcVw+4815cLMVGEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7XcyeZm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717535619; x=1749071619;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FUddArGdmCF8RXOMO69XY1UniwMl5nF3LOMEnbH/Ork=;
  b=R7XcyeZmVKGNBSuGmyZDkQny3AZtUUxBmFzVr9LivElajKm6SC86vjI5
   YPPS8P0ZkVh90OO27ZpuWogFyxrjJpNUbf2dGigUEER0Cgxj2uMNCbAIj
   QGF0WSou2aIWIucb/20qew8EAGcA+5ZAIq8CXgtvl8EKdzWZKmBu90DID
   A4///A/XgHUMOQCeGqarNBv1QwHELbM8jFmBOTHlHsvKzjBPvc3vsSmG4
   A+49H/GfXIlejK6rMD9miG3zCkFQYkn1cCwbKzPsbdo5MLsdarAEjAk1Z
   ni2X3/2Ga9AFv9aWyYsmyclKxEjGdKWr1L9UvRqvdkSySGcwNMUV1maVR
   w==;
X-CSE-ConnectionGUID: aaNWa5TrRv6tqdkD1I5Qow==
X-CSE-MsgGUID: 8Ro+D7D4RT221+BqGor2gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11906280"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="11906280"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:13:39 -0700
X-CSE-ConnectionGUID: AUgtxos+RLWGKa6PADZMfw==
X-CSE-MsgGUID: r0hDZXf+RP20f8/PwR60hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41789244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 14:13:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 14:13:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 14:13:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 14:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxoMLiVjNRD/UyoqjVP9dr5p3cDyqcxoxI3yE9/qS3+PSBz3SYm8sdKg/YIKe5SC9KiBjjkarSsAV9HaBOD8TBnjiWsvpjCb0Z8tFmxIBVENhtno0h+GjMkLWIFQ3Q774RlvVR442XmfgIpvrE8BI73fMxyHvM4yPwYVGnCE18P9qeonQPniLioBVakoUfgscK75us5TvHnpaM1mTF/TaIw0joKurFfm3zBVHDUNQHjHACz+e5onqjlZbBHUpJAySQytXUv1o5W1qRza26LLyonDbXIdhyTQSNSD3Rr69l1P/k2ySi87660FL9VfjqbOR7wlhrm8mUeg1Q60QHrBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHf0YcLwSCe1l2RiBSPdNYqjWbeoGfz/KYgjHett0iw=;
 b=W1qKfxDWU5DBCBT259aDTZCyQC4QXX/yqFl/4BhGp2M8Eb0Z1pMc7LtqC2GTNEWY/g5kBrO/QGmJJt2T6ubw06CPmk73hhCAt+UUAwyY7WS5iFgfMFYVtnHh9v4L2+Cy1ZlCVSg4Rfr+kNUsqqzKmPxUCOHYz6NUkhNaN1dpV4xAATf7Su8Q/y4ew9xREHerVeTKo8QdmVGLrucGmIT+sf4m607UQrFQz1NK5IkdzYlANogcKxgRFQptPd3oSRLaTOhxI3xfULjV9rwHT1zacawqrZLQW90e21acafCc917x3O5c8U0cylqHtx55Tl6jZu+QhwJydK1lmd8XSOetrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 21:13:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:13:36 +0000
Message-ID: <14462bed-70f3-40ad-8c1c-bc8f123dd110@intel.com>
Date: Tue, 4 Jun 2024 14:13:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Intel Wired LAN Driver Updates 2024-06-03
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>, Michal Schmidt <mschmidt@redhat.com>, "Sunil
 Goutham" <sgoutham@marvell.com>, Eric Joyner <eric.joyner@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Karen Ostrowska
	<karen.ostrowska@intel.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Menachem Fogel <menachem.fogel@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <2e0cc718-38eb-47fb-ac02-150ecc9858d8@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2e0cc718-38eb-47fb-ac02-150ecc9858d8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 772ed9cf-cc55-40dc-f89f-08dc84db32a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEMzcnFra2VzOEJ0d284Y052d2d3VUFBcHhWOXZiZ2drYUNjR1B0S3hmZklj?=
 =?utf-8?B?WUZzcEx2aWIxNDd0cmVqb0UyZmRZdmRKZ1R3V2kwOG13bmJoK2R1bU9DY2FT?=
 =?utf-8?B?K0tOTlROd3ZFVE5IcURxNGZGQW5FN1FCSWFMWDg2Z1J2bCtiYmJUK3Y3dzg0?=
 =?utf-8?B?SSs0Z1psVjJMaXNMelBhbVhUSm5mY3NlMmlWNEN1UzFqSkhkZG5FVUdlYyt2?=
 =?utf-8?B?S1A1Zk9ZVXN6UmY3V1F2N01abStVNm0xNWxRUGdrMmlvZTJtWWc1NEZ1eEVm?=
 =?utf-8?B?Nm9NN0pGUnVxc0MyeTFkK3pZbXdkb280M3d1Ti9WREtGV3pLN2dRTWlGU0ZY?=
 =?utf-8?B?MXVnRnJ2NG9oSUFHN2FvZVROU25wandOSWhTc0ZSZHN5RWkzTWQ1Y0dBc0Vj?=
 =?utf-8?B?dlpKUm40SEtuaXFkVjcrZmtDTFJhMDNsNWJmdERJVCs2NlpZdjJ5Q0dnR1NL?=
 =?utf-8?B?VmJxOUNQNjc3YTdOVkNjeGRCaHE5M2RkYUo0WUViVHpjQUtSVEIyUnV4ZnM4?=
 =?utf-8?B?dFdqcUpSbEhtWjFaVDlYajZsV2JaUHpheHQxbCtGQ0FVb1cvVXJJM2c5TGlw?=
 =?utf-8?B?eTZLdHdudkwvbnVERUVPdFdXc2t2djJXb00rMThxK2lDUSsycmdLNnZhL3Fn?=
 =?utf-8?B?eFdubE8xVkhEdHdxRTRiYTVCc09QdnQzajE5R1h2NnJKSCtRaGRVckI1ZTdN?=
 =?utf-8?B?eXBkbXNza2Q3TjVuS0F5VFNRUENGMkw4UjU5RG9ORUtZLzY3Z2pqOU1OOGFF?=
 =?utf-8?B?OUNsdkJyVWR4ZDdwYXEvaWphcGNreW5XWHlJQUQzbjNPeXh0clBObGlVcUxz?=
 =?utf-8?B?bDVwYjhENzkyYUdwRk4xdlJ2d0FNdUZwMVdjN0pzK0tkclNOSTdVeTBVSERH?=
 =?utf-8?B?Q1NQSzlSeklRSVBNTllWS0c1cEhmQjlDZENIeURzVDE2OVdIWkRleXI0dzhk?=
 =?utf-8?B?ZVlsY3VlcUU1S0Era3AxQnhmOVZydGpDS0xFOWdncXAwaU9vb1NRTVZYOWdQ?=
 =?utf-8?B?RGg1RnhUQUloMlFaZE9OV3BFZklUVzExRHhvMEZ2ZUs0S1NsN3VKTWxQeUdL?=
 =?utf-8?B?M2ZnYUIxN0pWekExaE5kbzVDenY2V0ZPbzRKQU1jdTdXSDVtdGVYS2tOZ2c0?=
 =?utf-8?B?a1FVMDdDUVdodDlIS2FPY0ZUcDAxRlk5MWE1U2prVEJRRisyYkwwL0ZTenBN?=
 =?utf-8?B?K0tYeWNsek1KeVBHUjc3cDZ0YVlUU0REaVp0UzJ5ZDc1K3dRRVhGYzhrSWVh?=
 =?utf-8?B?MGpiSFRXOGZxSHhwS1NBRzhPU25iSThzSWRyQ0FPazR3WmFTNmg1Zzc1NXYr?=
 =?utf-8?B?eUpVQ1QxTjBQTUJPTjNJWVhQZGZKL1JESDFHeXlDdDM1RCtIZGJESmpJTnh1?=
 =?utf-8?B?OUJ5eTEyYnBNeVROSndWU0U0dWsxbkh1ZlBmbUtUSHFoMkszaDV5QTJaTFFK?=
 =?utf-8?B?cHZaVmFoVm15dEhZd0NXVno4YmRQQXdOUUwyWXRDSFZLK21nc1RUcisra2Y1?=
 =?utf-8?B?ai8xbGgrOWdPekozdkdlaWMzQWZZTXhJSndoeVNkMHdDd0s1YjFJeGVqbFZY?=
 =?utf-8?B?U003SWlGRlM4SVdXN1UyWHFNdEJoK2NydGRnUVBSQ1ZKQWZ1eXpRcU5neWRz?=
 =?utf-8?B?blJKWW5QU0JLdVJkMGJDeUpvdUhxb3Y2U2xaVUJ4VkpRMnFRT2t5RG5QNGpG?=
 =?utf-8?B?UGdIcmdIRmpnUHcyZDVMb0tNK0c4YW11REQweTVMMS83Lzh5NmhFYnpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5HeGJsYVZFZ1NVUHFGKzlsYWltRTlKNk8wZnNZT1JNQmw3d1ZGSis4Q0tD?=
 =?utf-8?B?UnFGc0NaOEhUQmFtaVdjTE9zdlVpZ0gzekt4WmpkQWpYcjNSS1lUVXFyR3hH?=
 =?utf-8?B?VmdTSTRIR1kzOVlBUFA3RUkyUHdKU0t5V2g2d0pEUzlKVGpPUVN5VC9sZUpD?=
 =?utf-8?B?YlBEczhhallZTWJWV1o4MmdjZWhsNTJLSG8vUytyY3E2ZGVkU0FpTFplWmky?=
 =?utf-8?B?OW93UlJHcFNPMXRrVG9lKy9PUys3Y01iVHNJTDBDK0xrTTVtNWtpb0hOdkNV?=
 =?utf-8?B?bFpVOHN1VitKK3dycmJLUS9pQXdWd3JiVlVwMUVPWTZ2UTVyRW5lOXhxdk5v?=
 =?utf-8?B?anRydzkrdEJ0dHd2L1Q1UmpqOWxuM2JxY3hqM3hkRExVeGJnYzJLZ3FVN3cv?=
 =?utf-8?B?bkt3dU1xdmZUcHY4cVo1SG9Ta21XcGhvdjVIc1FKN21TcVVUMzRTb0dDTm1r?=
 =?utf-8?B?dmQxZFZBd0hVZVBOcUEyOE9nUUpmS084Mk41YVRRbXoxYUpuQzJSWXI4dlhr?=
 =?utf-8?B?UWNKczRwd1kxOVJpbDBBVFQ5eCtFM3JDS0JXMzJxUW5yY0pzNXc4TTNUTU9T?=
 =?utf-8?B?R3Z6YldGWXdsV3VodmpOaEFDYzdWTFp4MUMwblg3d2ZtNHZSMEttemRkY3Mr?=
 =?utf-8?B?VlVoRGpOS3QzaFVNcUdYYlBHdjV1KzV6d01QQ2lhUWxlNVBMaWxzbmlHTGxT?=
 =?utf-8?B?R04zd21ZSUQzaWZlK0pZd283aFJ2MmFVaGt0M3NWVnNaNWtuRDcyQWF0TUxa?=
 =?utf-8?B?WmxhcDF5NVd6TGcydDgvVFh6dGpIZmczYzFlOWRLU2NUR3gwdHppc3Eyb2Zx?=
 =?utf-8?B?T1RnS2FYem1RRVJOdUkvR240SHQzMVNtcDZhakhTYTgxVmpkbTZxbHBrOTkz?=
 =?utf-8?B?eXNqa055L3h3QjJNZmdxWnRsS0FiaS9vTFBDcWpCbXZjN2trWlJoZ2RRd29C?=
 =?utf-8?B?YWE3NXhYZnh3ak0rVURaNDBYdC9WdEtLMGZZbkR3ZWlFZHdGcTVFdXVGWnFS?=
 =?utf-8?B?VFBQakJsOVBNZmNlNmIxNmJUemZoRkZqczQ1Z2R5bUdzN1VuRkxBNlM3VDlO?=
 =?utf-8?B?Qld3OVJWWlVpZHZMWVRvRXIyS0t6cXBLcXo4WDlDNUIzUlVDTGJqT0kzWDV2?=
 =?utf-8?B?SFFSM2dwNDJocmd0eGYwdGFvQzVqQmx1UmdwOGszNWdrMnk0SSt2c0k0Ui93?=
 =?utf-8?B?dnRodk1ta2xKdmN5NWJYTElRbFZJMjlhMEJxNnR0akxESkhOaEZSZ1lUMXFr?=
 =?utf-8?B?VFVEc3RpREl6Sk42VUNIVEVWVlpNbE1KM2F6VndvU0xNbHhMaDJFbXBZaHl0?=
 =?utf-8?B?Q3FzVnR1TVhocHNIOWNoMXUzL2dZcVJYejIwaWZZV1ZMTS9CRmVEeFNNZ0p2?=
 =?utf-8?B?RkZMb1lNUmR3a3E2cXpxb083VDBJZHNmRVl5WmxuV3FRc0pxYVlUQm9OQnlT?=
 =?utf-8?B?YmxpcW5RYVF0VXovREZOUzNid1FRMkY0VGNFaWs4RlBQK29teFlVKy9lUnRh?=
 =?utf-8?B?U3Y2WG12VjQxTWxjNWxJMEZVdGVmRVNteHFXQkxpNVhWMFV0a2V6elRENkdK?=
 =?utf-8?B?Z0ppMU52blVNNDBlakRydFdib2Q3eHBEMGlWR3ZBeFAwSjFqVjZUUHN6ZVdE?=
 =?utf-8?B?S2VhNkJva1c4N2VGVkRkaThuSVNRVy9zc25iRTlHZ3JwWmt0cm1BS0lEZHU5?=
 =?utf-8?B?NEhqTTU2aDdxZmxOY3pXcWJOdlRDVjVuZFZTY3NDaG9LMERSTzJZeGEwYWlV?=
 =?utf-8?B?R0hwclhDR2RoMzRXZGhzQmRWcHNSRnExMmVxUlRlbnRQblczMlZIb1QvN0xm?=
 =?utf-8?B?WWpLdFJrYUZkUnlScGRXZjJtWEZJdExCSDZhbE1oTmFUaEdxMXdwR1VMZFds?=
 =?utf-8?B?bVhvQWlKb3ovVEZGMjI3RXFWU0JpNHRJQjhhV241ZGpUVFdaN04vUHdjQ0RZ?=
 =?utf-8?B?TDBYbWk4OWt2M2J3NGVNMjZPSTM1aWx3V1FpN2d6a3AxZWJseUwvWjdFK1lR?=
 =?utf-8?B?QWJMd1ZZdHpEU3RzYk11NU5OMVg2NzBiVTlCbzZzeVdEejc0TmFXTDcvMkt6?=
 =?utf-8?B?MHFCTVArazhUL0ZFTDJmV1NoenNRMm0raytCWXliOE9US2w2dkFlc05uaHJ3?=
 =?utf-8?B?NFk5NlZjRlJRT1pnLzF5cUo2T0l2dndYdlZMSi9nb1pYQUpEc3h1RUdxY21u?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772ed9cf-cc55-40dc-f89f-08dc84db32a9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:13:36.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YS4l0wrB6OLeditWbO5H2IK2fM2er/GSvpSXEbWNjrAKvtVWOKvq5LCNInqK2jYc+sr78+v306iUXifuHPOvr2ng58vyfbieFFZKZsdLDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com



On 6/3/2024 5:14 PM, Nelson, Shannon wrote:
> On 6/3/2024 3:38 PM, Jacob Keller wrote:
>>
>> This series includes miscellaneous improvements for the ice and igc, as
>> well as a cleanup to the Makefiles for all Intel net drivers.
>>
>> Andy fixes all of the Intel net driver Makefiles to use the documented
>> '*-y' syntax for specifying object files to link into kernel driver
>> modules, rather than the '*-objs' syntax which works but is documented as
>> reserved for user-space host programs.
>>
>> Michal Swiatkowski has four patches to prepare the ice driver for
>> supporting subfunctions. This includes some cleanups to the locking around
>> devlink port creation as well as improvements to the driver's handling of
>> port representor VSIs.
>>
>> Jacob has a cleanup to refactor rounding logic in the ice driver into a
>> common roundup_u64 helper function.
>>
>> Michal Schmidt replaces irq_set_affinity_hint() to use
>> irq_update_affinity_hint() which behaves better with user-applied affinity
>> settings.
>>
>> Eric improves checks to the ice_vsi_rebuild() function, checking and
>> reporting failures when the function is called during a reset.
>>
>> Vitaly adds support for ethtool .set_phys_id, used for blinking the device
>> LEDs to identify the physical port for which a device is connected to.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Aside from a couple of minor questions on 9/9, these all look reasonable.
> 
> For the set:
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> 

Thanks. I'm fine if we also want to just grab 1-8 and send the igc patch
back to drawing board to sort out the ledctl_default behavior.

