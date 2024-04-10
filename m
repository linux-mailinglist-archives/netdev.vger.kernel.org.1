Return-Path: <netdev+bounces-86732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679EA8A0153
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F441C24BCF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4EC5B5C4;
	Wed, 10 Apr 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5LW0MS+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E741C6A
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781104; cv=fail; b=J8+f+eiDJ5A94y/n0hL7jW+knQ9XQUQ+biLwZRlxQgh8fzrXxdxq8rXLfdKUSoQKE9p/rJx+XrzDhnos5Rp6h5yNEdNOIFn93mFfY9t6HiNSSyG/toA3c8nZY4tXjxfcatKZFp50tc0NqQ5JC65CFP/vh5IUSsizgvP2JqSTZeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781104; c=relaxed/simple;
	bh=yHtyff86pHu0zgvHVD5+imlUMsTjGlrC2OniOcRD6z0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0M/qSRvzjHidzjIi3phQaI+agQG70MqajRHHay6kqSj3wvWBoCXxbrkc+knxaD8Ak8YRiAswAqffZFlyRhppt+1+Xo5rQC+d4MpCbTJMYPhxUXsE4AFoTGZpxJMgCmFxWNbufp2X9Vfk2wEJ9ien32nPU7e2ZDY06yrGT17Fyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5LW0MS+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712781103; x=1744317103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHtyff86pHu0zgvHVD5+imlUMsTjGlrC2OniOcRD6z0=;
  b=Y5LW0MS+nIl0M8Ril5F8bjwwxyfGrgNPbcwLCVmRbPaT77jGzPnK6OTe
   p/jn6yEjAEFogExQjybjhWCWL34MmUrw4TAS3ymYVq/aR0M2gAP6dtOOU
   8d6SvL4flqPusF5IeffVQLOW7WUwHIhVYliMikH6Wvj6LSIXUfubVE2eN
   7m0buNUImBVT7YY2ANUOin/d1z4K8qH39WAYTE5iiW0lFTrikOqRTZfyQ
   s1nV0LAec95/ZxjBgb5Imuw0bTAGkqnOx7c1ovUxdk0/UT6ljDkh0ZbsC
   joxlTBRir8jNYFtoHYjC4ZPMWQvV46ndLeALPIpkdfWo8iNf4JcJMPGKh
   Q==;
X-CSE-ConnectionGUID: r4CRMe5TQcOI+QPgDLW+Vw==
X-CSE-MsgGUID: euq/swqMQXiUTSlrfhPc9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8022903"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8022903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:31:42 -0700
X-CSE-ConnectionGUID: RXaPSbHkQ1258ODYAG907Q==
X-CSE-MsgGUID: u+yB85aRT1+OY+pKjgHPKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20762473"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 13:31:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 13:31:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 13:31:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 13:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfpnGgk9x7cZHzjlJpEAyos7HTWLWi/3Jcq5PZcK2uGII1m0MLQd9pP93CtHLuTiZs1CPxCtOq5YnvRvfQ3WjbbstsRcUdPahkbsZP1k5dQQBkC+DrVAIQ4zcYC8PJs8KkL6NkVNalYHHcWLwKUtiW6j46cmVLudelaHO2EYzelpHCjMXsZ6BGIiXDbsEfzG9lu/KLII2h9khfPaxQ+cHI9uWuoxW6iy1eIzROVMXTKgL0W+SnVgeKTzg8CRdrejsyygsDhk6aA4UPmil0DPo2g36dW+ZxkvFce0GmI6Y+R5vzKIaGVcsZpn+lyos5H0TdkEAnmyi1owvk66G/3pOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPDfqx73AgiOIn1DE8d8rk1E0HqKgxnZ713wHg6Zzeg=;
 b=XDMtrrOFf79vYAcLf5YZR3ir7DKUk2xwJUnp6baxZAnonCunVwZI/pBpJzHtpeTcCWdWTNm61/ZcCdKhPrQFME0NhzTik+9xnL2nl8I0jjMvfU0NV4MMUh6TmhZ7G25Q/vPKk+AdcjeVaCqOnHidv4cmWdMMFP/ynw/hvF+VQU4B/oBYw0HF+dG+Ocj4dmCvcVKtDy6os86BqV2k5XVRtaYbVmnR4dXZfB2BxRWw/ynxA2WozPksZgGAFXpNZ3QoFa8z3/WTvrTM33wsK8HbjWRQdvbbfJrLhhlTWZB4hQaofHY7Qq9Q8mwCUvuGkHxVn3KF2WL4fM/rJFuy6F8ofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 20:31:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 20:31:34 +0000
Message-ID: <434a23f1-5e82-4533-9759-12b776850ae2@intel.com>
Date: Wed, 10 Apr 2024 13:31:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 04/15] eth: fbnic: Add register init to set
 PCIe/Ethernet device config
To: Andrew Lunn <andrew@lunn.ch>, Alexander Duyck <alexander.duyck@gmail.com>
CC: <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217492154.1598374.14769531965073029777.stgit@ahduyck-xeon-server.home.arpa>
 <32deafeb-82fe-48c6-a15e-08e065963876@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <32deafeb-82fe-48c6-a15e-08e065963876@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:303:8e::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APuVuSOCDXfop40KA5Dsn8e+SQs8VZRhae/2o2k4ZqZpT53zUdqTpVi7eMSBbJ0gk2jXP3CtXKnFpQyeN+N3AJ1yfyOQynqHkqOMTpqr1sMJ1BlC0PbU7Pheyy7zErWwL8K0KreHy8LTL74QX59M40c+XjDQpdBbLAbtUgpW+LD2xqoV8RwBQyPSM8UR4TxszdPQLY2kTZgTyrVRXxPPncgHf0gB7zKS3FSwnC5QxfVNofPH72j6Mi1dQAh2KmUe4+pQ7RHsuDGBQnKJi1VXYOLbAEWVl42BeQj6dppbFvYWh7JbWJh8pCOw4qQ1fYrnMQ8FdhsCvmwdCZh+Tb+evDDhRN0OVWG7lvDJH6VZr27DUjIz0kxnEyouQdJ4uumIzgrCrVAMoNVOqHQ7DSz4w30qPOmlEM5zUccSVe1e1duZIHJ2Ky5rIzkl1io23MwlmEBNWr55t5GbM08OcNRjKQP9GsqZqqUb42jUCavVdoAkmA93L3OJK+3I8OJpHJuWvXF9Lp+Wz58m5sfmWKLnWr7cy3tIJn9JRd3o5b/EVk6JuR2jS6W/Pi6toqujOb+ZUxXLt3YR/1mvWTs1H2zCHQpxQzPZ0GMcSoSoY8yPr9HpVj2qSEg/FEuJncybLpxEX1OQalE1csXTuJ/bJNWNEOjPQLSUF4mnugUGIexVym0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9sV2dZc2xUajNHWjNpdVNnV0IxSDRQbDl1cStLTzRRVHVKTklmWno2SkR0?=
 =?utf-8?B?V3N5NXZPd1RvaVpQUjFjTXJiakFsaGFxOU1Rb1dIWW93bFlBOE1DZFdBZWxs?=
 =?utf-8?B?Y0VpaTQyTHVnYlI3bFRrc2xBVU9lUlBuaE8wWUxzUjhMNHJ2MVRZeDA5UlBX?=
 =?utf-8?B?cUhUOXNNRkdDYnRGRy9Gak9XUXR2c0JpYStMTEc4UE96Nm4zZHJiS2JsN2hI?=
 =?utf-8?B?WTQ3SjdGRTdoZDJ3aVZTa2ZKSVIzdlBkbGExMlFuYzFRa3hkRDA4d2Q4aVI3?=
 =?utf-8?B?RklkWXdYQXN0MSt0WnFLSk9CcytRYXhPeWRNb0xwWCtSaWJwZ0Z0NjF3akVG?=
 =?utf-8?B?YTBST01zYytXNUFIckZXRnZqbEt4UVUvcWNZN3BlWlhIVXJCQ3dweWY4S2hR?=
 =?utf-8?B?K2diK0lhcnRPM1Z0clIyeVBBNkRocEJLdHJ2bDNIeURiZUpvMlZEcVlYRE5H?=
 =?utf-8?B?VCtBbVBXNXprQTVPdFBZdU1aTDh3cjA0dXo3ckFpY01URDgxQkgzQjVxNkRD?=
 =?utf-8?B?UHB4S2UyNnNkdVEzWldGSFRMTlA4RE1UUkJRVDgxNTUyRGE4OUc1R3pHYVVC?=
 =?utf-8?B?RitQWSthd0FUaytoSGJzYmdEcjRMcHNmajQ0TkdnTTkzNTZ5OHNSdWdud2Zq?=
 =?utf-8?B?QjdDSkl3RiszTUcybWMrUEpmS0Q5bXR4UzV3TGFjRDhMZ0VkWW9xOHJyWGdL?=
 =?utf-8?B?VWxIZ3p5dE1ZbUdwMGZVVDZkU21nS1VoUitVai9hMUdMYko2UFl6U0hBY3Rp?=
 =?utf-8?B?c2JTeS9Xc2w0bmtIZzI5bVcwMGVwSlN0SzEwM0JyR1lKNENleGpQbGFTbEVz?=
 =?utf-8?B?SGRSR3pQczNLelF1cjRkaTJVbFlQUXRCcVZHeEhrOVZZSFBoRnR1WFk1cDVK?=
 =?utf-8?B?eUdGdnMrWnJQZlpzUGN0NkZFQ0Nsb29IcHp4T0VRR0VGU2MvaFd6NGEvbkt6?=
 =?utf-8?B?ejY1NGVkc3hwS2pSdWtweEdqeVA1ckQyaXZwSGErVFRrZC9MYUltMnAvOXNw?=
 =?utf-8?B?d0pNWnBVT2xKZkdOVmZoTWtoWTgxRVY2eTUyVWlPalVFb001RGgvSzB4YmZu?=
 =?utf-8?B?SzJ5WGJGaGxzeHF5M3YvTk0rajEwbnNvcnVvazNCSW5LR1NoWXFGWUpUaktn?=
 =?utf-8?B?eWd5bjJrc2ViZnI5QWszcU9yczBEVWxpbmdrTUxxalg1NW9LSmxkZnhiKy94?=
 =?utf-8?B?R3d3TGppN3NRbXlMVGxwYkVLaDhJSzdoSkhoTmVZMWVoSXpOVTcybXJUdG1l?=
 =?utf-8?B?bmUvVnRONzc4Nm5nM0JuTDRpMzRrWFlnL2l4R2FQeUY2c2UyMmZxajFSSmpv?=
 =?utf-8?B?MndlVC9wRGwveVNrNXhyRUxUc25uVGZuM3dOUHArdjEvZStjWW9hamNIeEdX?=
 =?utf-8?B?ZXN5aU5xWHBXeU1EVTRUZlBmaWF6dmxWZVRRd1VwSm5wSUZGWlhXZXJWVTdq?=
 =?utf-8?B?Q0thUTV4UmpYajNSbTFFVHNrTHBEZWx2eWFMeWtrdmtRUmU1ekNEbWZMbjh1?=
 =?utf-8?B?bjY1cXI0RXM3cVFVNDJaVEROaE5Sd3RUUkY1UjVhUGdINHNNVUpwMzZGa1JS?=
 =?utf-8?B?dkxKVDlrT2ZVZk5CdWVLN1F3RFJBM1I1K0ovSDM0RkM4Q2oyUnVuSUJ3SUFm?=
 =?utf-8?B?aWlIMllERW9DeHJrZW5RSFhHZGpXaTFwd3VRNDBpNitrQlRyeTBBZEx2M3dj?=
 =?utf-8?B?TDFoZ1V4ZnhjdGg4TkQ5V1V4NjJrdHREWG5CLy9JQXNjSDNweWFRcEpOY3ls?=
 =?utf-8?B?QVdpSWNFbFVTbHNSZWhqbjAyL0MxdDZqblgzT0J0NDZJUzFHanUvSEVjV2FK?=
 =?utf-8?B?Q2RWbE5yMHVpT25iZWx5K3F2Qzk0TjBsVnUyaVlwUmtGVDlvSXVCODRiM0lX?=
 =?utf-8?B?QVkrUlliK05qRGFFMDM5a0NKNjFmdEI3eHdNSmdLNUsrMkIvNmpNT2Q5NU1H?=
 =?utf-8?B?dnBWNk5YYjh2dzZISG1DMGdBcmk5MW9WQS82aHFQMnZ4L29ueE5GOUhXMkNC?=
 =?utf-8?B?ZWM2VE5qckJuclRmWVhiYnNPcFovTms3Q2NCczg0cW1WUlc1K3dlZkRpSXUx?=
 =?utf-8?B?dlVsYXZwMGFTNTVoOUthOGcvZWI0cnZIeVpCcjF2YlQwS0tjTW5NNEd0Qlgr?=
 =?utf-8?B?cmN4OTJia3U1WDROQllQZzVTaGxES2hYdVIwRXF2WVIzMlIzMTBoTkdoM1FR?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c51907f4-e7df-4c6c-c398-08dc599d36c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 20:31:34.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGmOZGgpI2IpzllN4xSFrJkBKswNaAWOA3edtKmz9+X9QBXcBisDOGhwpin0/ychN4xsr+MeUP8d+sYNxGf30Et3QwceE+OviwtL71D3nbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
X-OriginatorOrg: intel.com



On 4/3/2024 1:46 PM, Andrew Lunn wrote:
>> +#define wr32(reg, val)	fbnic_wr32(fbd, reg, val)
>> +#define rd32(reg)	fbnic_rd32(fbd, reg)
>> +#define wrfl()		fbnic_rd32(fbd, FBNIC_MASTER_SPARE_0)
> 
> I don't think that is considered best practices, using variables not
> passed to the macro.
> 
> 	Andrew
> 

Yea, please avoid this, it will only cause pain later when debugging why
something doesn't work.

