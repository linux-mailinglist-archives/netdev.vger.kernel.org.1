Return-Path: <netdev+bounces-127936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE19977160
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BF4287176
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C921C5794;
	Thu, 12 Sep 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UijYXb/v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B21C57B4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168514; cv=fail; b=EJCval4OVCbjstl33lqoY/zYB4r0wffo8PdmXSxZVd1ZqVBAg+v/A48EUNSrWof0K6cCIkGbaIdDIQe7YMTyrb0mH8U0O5AUHhLVzwkZRFF7/68uAn/umKDnYfamXCTu86/XVu28dFM8tp2YmkIUH5MWVeQ50r5SnRCVRIpKDVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168514; c=relaxed/simple;
	bh=nxMRUrHtXzVvIwqRdytxRCw9+JfW82zb83UU2v1Luv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWPGjGgyI5gYsZbXvqQdfiCH2E+IunfRE7GJDDifXOuVy1dezo07jLcpCYv7BTi+9gO0vcN1oGKrouDBaG7EdLAJYDaWdRxxAXIxolUpMpquEUsn8fs4W2R+p0o5FuI80ZUpOwCdOhejJ3JwPRoq3BAC3xjv+fMlL5dSYaUajp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UijYXb/v; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168513; x=1757704513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nxMRUrHtXzVvIwqRdytxRCw9+JfW82zb83UU2v1Luv8=;
  b=UijYXb/vpff2WR+GUVoxHAymsiq8e0ijrxJqgK5URCwIW2e+GPqut316
   K10u9aRwskz1R8BL8H2gEZSvUH8rXyuuguRBlg5uxjBx6B0rsgRg92njs
   ygDzQpVeq19AZlEOUjPx0w68mAt+XRm3KIbdjPsEtYVzPnH762z/UNBV3
   lT57woAEsz3WROvOO6swUvdufVxDn8G5q6E1ZsJdSs3dENFTQ1i4uupZr
   MVVFyuxcTPzeDYkmqb3iXbxcy3wE9tviZJg9yxA2AjXqmGhV61eFkLvuE
   eMAn/thIgcG2HDORHs5hY4vPixzGtNfC95Ug4TMQabUmKqJTXJ/c0CiZ+
   w==;
X-CSE-ConnectionGUID: Xr8qhEN7TYmiPXpfOcWBYw==
X-CSE-MsgGUID: i1QxAutxQaK0v6asBrPT6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36396419"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36396419"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:15:13 -0700
X-CSE-ConnectionGUID: yRtu303aSXiB+LCFxzt5EQ==
X-CSE-MsgGUID: HXWcq3IwSwGKPjim4mMPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67517401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:15:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:15:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:15:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:15:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj6EldE7ofeHL3kWvBh5z7n2RwD1biHZ8BI/29G6LWipLMov5Sx4UVulRWjTqHJjWbWi/mAe1uZfRvE8bJE035rsYc+CVXI107LyHHITRAhk7VLZZK6uNJ+HJeAUeHQxCmvYjhImCJPSGo4gJwn1WaC7meUhpm7NmFY80PwRu8qz+T65TOtrszcmErF/gvExo3d0VGpTtsIz7F7oTlEeYjajFkVFrgIRRG2TCk7P4e9wbX4QJwRRtDbqn889ubsnWIhxBz7Wl66zgg5ITu5LuEQuuPqgprRqIsqf0QhmogpTGmqQNaETbpVRMkHV0sd8fTVC1QHvjJwHCYeXXD9tzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKH6cl49fwZDOq8JwrGsVkDaE7OtNvjqzlJDaTYWmfg=;
 b=dpUgyQ+4h3dOW4xBy7x5rxAEnRurN94arnxSw7oAF0DQKKRm02lb6BtofG+ZGMqknKw1q3b+mDo2gdhobiibon8xVrK4Ve3UkeBpGDgYR1546Qpi6zscg1lqxtO1oDblJc9HN2WHsN8N+LFdv+gbKLH4hsOU88zHS5SU4vN5B1lasOLOZr/DgGlNfmiZkBS/VpsKfNLNnNld1euuiTcp7wVPMRqDuh32oR5A3ExeCzUozCJY/F88RaM+31fX7UDHRgCFyH8vCxfcQRbrTnbI4nvPUPov0CoQ/13P8bcE9lysj+OvtBahWHlES4c0Fj0jrxnT1R+t6/lkLcCGp06Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:15:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:15:09 +0000
Message-ID: <70c8b215-2b1a-4f3c-8757-4aaaf6d151db@intel.com>
Date: Thu, 12 Sep 2024 12:15:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 14/15] net/mlx5e: SHAMPO, Add no-split ethtool counters
 for header/data split
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-15-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-15-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: aed3204e-bf28-4eca-6dd9-08dcd35f37ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2tSZ2hpUkNBeXJGeHczRGtnT043TVBYb0pKbXd1NzhHSjJVQXNtQlNwWUZI?=
 =?utf-8?B?dExYdUVuZEwvTHZQWDB2OUVKckZWZHJLbmtyV29rWjBjWE1SZzZJOHhKNC9q?=
 =?utf-8?B?ei81Zmg1bXpPU0ZRV1c1bXdYSG5YTG50NGc2SGdyTXBrU3YzUXduSUoraDdj?=
 =?utf-8?B?WGdIREZ5bmlIeW1RQUNUL2Jsd0M2T21yeXBrOWxydVR2MWdTcm96dzVlNUdX?=
 =?utf-8?B?RjB6TW5KZ0JaN0xENjZMcm1TU2lab3ZwQk0wYldjUHBoRWtUN1lzK3MvL052?=
 =?utf-8?B?OWUzMTBPK0FEL1F0NWRsZ3p4SUhiTVlPVG5EcmdVSnNTcEM5TlVWWTRvb296?=
 =?utf-8?B?bEU4TGNiRmtuaklsaHdkVVhKNzF4aTR6QlNYb3ZoT3BOeS82WTEzNDJkOG54?=
 =?utf-8?B?N2VvTVZ6dHQ2U1E1UlRMcExVa1U2LytKWVpRM1M1TUZUcURaRjd5dGRuK2Vs?=
 =?utf-8?B?SmRJNmZCdmxXcWxVRjdLRDArSW11MWhCOGZsbWpTKzg3RHdsZ3hwUUM2OC9j?=
 =?utf-8?B?ZzBKOW5KVWJDVis2MW1qVDhMYTZndEl2bmQyaEJlUzV0R1FnRnBRN0s1cWdr?=
 =?utf-8?B?TXJzZFVkc3Zhc1EwMU9JNFp1YVc2SDR3c1BlQm9RSHd2aGNVdzFpcjBUdUtH?=
 =?utf-8?B?VlJPV1Fsc1I1alVVeXlTTWwyb2F0NlJadVoweVFHaUxqem05MGJjMi9EM09a?=
 =?utf-8?B?TGdwK283eHpad1NQZlp6VDkvNDVDU0I5anBTMkw2Vm9lYzlFb2J2RUY3YWlp?=
 =?utf-8?B?Q21jQlZqS0Vvc0xSQ0hiUzdPRXpiWTgrUm9UQ3FPeE1DYmpiTTRLM0E5U1BC?=
 =?utf-8?B?U1JBTEl0ZzRMMTFFckJQNlBGaTRmUnJGVVh3RTI3L29qM1VCKzg0RG9DRE12?=
 =?utf-8?B?cGlUekE1azJFMlYzeXdVWmxENmN2UlhsQTV1aXd1bVVYcjJWbG44N3ZhTUNT?=
 =?utf-8?B?NXQwQnUwc0pkSTNra1pxeUJ4SnU1TUt6d0lvbE1SaXhxN05IZ1dobVhub1B4?=
 =?utf-8?B?Nit1ME92ZGpkR3d1UUVBdlh5Vks3ZFlSUktmelVaMXRpUU1pdHU0eXZXeWE2?=
 =?utf-8?B?bVJCRmk5THo0cUN1U3RVcG5nWGlwZlVTRE5hT1JLbnkvZFQ3aStvditlc0d6?=
 =?utf-8?B?ZVlHTWVqRG81NUo4eWhmaEFFZmlzcnlRMXZBL0lJSmhqK0VKaDhtenIyMG5D?=
 =?utf-8?B?bGdkOFFXVGFPb3k0Zi9paXkyY3ZFYlhRUytBTUdFNHlzQ2xRbXNoK01CWU41?=
 =?utf-8?B?VDdVTUpnL1QveEdTZ3Vza1AxNS9hYUYzelJrcFJHUWJhTEV2SEIyRGJwa1g3?=
 =?utf-8?B?V01UVEhSODFxTUlKSXhLZFVpaERSdXZiZGthQ0t4YXI0NUFyS1BxTWVqZVQ0?=
 =?utf-8?B?RnpMTTE0ZVRZektLVnpDdGVQYjV6Uk4wbkJHZG5ZQTZYWjJZWFRnZlcySk52?=
 =?utf-8?B?NXFPSVk5eHRTbWFiMU8rak9sRzdJUGorbGY5VGs5RGUrdGp5enNLU1lXUVBh?=
 =?utf-8?B?SkQ0YnFYMUJsMzBRb0Q3NWlNVHFZQmZhemNwRjJLZU5Td3hNVEZHaG5lS2RJ?=
 =?utf-8?B?YjFZbHBBd0Z0K2ZleGY0SkdqSUpaTy82NGlsWE1NSDI2U0FvaC9JVGZRYk9m?=
 =?utf-8?B?M3FmdWw1dVZOQk44ZEordTB2cml1czJ1cWFJTHNjK1M0Sm84NUtkdVpRZzRx?=
 =?utf-8?B?QW1rLzdoK1g1cTlkNHQ3UEliUVQ2M3lNWGM5aDQyUUpYaVJPRnN5Y3B5dExr?=
 =?utf-8?B?NnNsbXNVcEhHa1Fza2tZMU9yUzdIRktNajdwVy8vZHA3Qll2YnVxb01QY2VL?=
 =?utf-8?B?cXFjb0FkYWI3cEQwMUt2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitCaDhOVWtWRzNXOG8zNlVBT3NKc05PaVVCOUw4L1VuU1hkOEtaZ0FMZFVq?=
 =?utf-8?B?TkUvUmEyM2hNaG91M1Bjb2Z6czZrWTA0cTRLL3RsSUVwQmtna25vQjU2VVZF?=
 =?utf-8?B?eXdQWHN1R2h3WUt5M1I5L2R0RW95L0ZWbGxXOTROd3RqTnAybjV2U2d3aGRa?=
 =?utf-8?B?QjlOZWNGaVVuc21lRUt2d25pUExUdWc4NTNnUTZFcGY0aWU2ZDIvak5LcFZF?=
 =?utf-8?B?RmdZa3d1ZEJxbEtHbnhuV2pCNy9ZSUFvUW9qc0c4a2JsbHhZcHN0YzY1bzJP?=
 =?utf-8?B?aXcvY0VMYW5CR3A5WXZCOU8ySTZzOGQ0Q0NKMVdBS25keWdaZzNTVnd3Z1BJ?=
 =?utf-8?B?TXlPZzFsRU1DRk5GQUhLZWhEbVloMTJ6T2RUOG0ybmVZeTFQeTJ3eVZobG4z?=
 =?utf-8?B?aVZRWFU5aFd5cXE3SzZDVm9tTDRhS2h5emlJRTZpTWg5WjNHNTZnMU0yVUVx?=
 =?utf-8?B?V0luOUdjUGEvRjFKT3d6R1NCcTVqYjVqbFpDaWRWcDZtZm5wSWE1VEJNVVBJ?=
 =?utf-8?B?d3FBcm5lMTJZbUFhRU5GZmMydTlWZDdZVWY3dngyS25vVWRmbGdtWFVueHg2?=
 =?utf-8?B?Tm9iQUI4QUVpR2ppMW5GVDRTMkg3R3NDS2YyM1dKVnE3U28ydjVrRENYK1Vo?=
 =?utf-8?B?cHlocXdQOG4yVUIwU0Njbk9OTkpkV0ZTTklKQ0FEWnNYV1docG9NN0FCUXlv?=
 =?utf-8?B?WXRORld4OW5wRStWRWJ5eTFqL1h2dldaZGFSRWk1RkwxQXc2VzBicHlWVTQ0?=
 =?utf-8?B?RnZLcVJaa1hwb0RpQVFzZWNieUViTkJ4MGpFMVJHRUVTUzRQaDdmVDA2TUFx?=
 =?utf-8?B?bkRrY0ZMS2hGTGJid08wNGVjNHNwcTVHa25IbmtzMXBEZ1FvMHVuWlpOdERZ?=
 =?utf-8?B?Sk1wRkthNW9sUGN3RzE5ODdhblpITzJOVWtuT1pCVXZ3RERxL2JQRTcwM0hP?=
 =?utf-8?B?c0NlVER2aDh0N0JSYlZSRU5nOVd5SzIxeTA1SDZzY1ZZZFpqeU1sRnA5dXMz?=
 =?utf-8?B?R0NDVVQwRnBRWUNpQy83R1hqT0pmdDlSNWx4bERrQ3dwd3Fla3JyR1RPYTRB?=
 =?utf-8?B?clhqazNsUS9BRHVxQ2xuSWREblgwaDFPVkk2NDhEYzRRN2ovQ1FQZFdqUElC?=
 =?utf-8?B?ZG1DcnJLb2hhYjR2VE4yVTB1bUhETVdSaXZvRUh0U0hQcXpzaG50N0xmZjZs?=
 =?utf-8?B?eUZ5V21YZTdzOEJMYUQrZXVFK2w1czlGeW9WRTJBeEsxKzhHT0RoTkQ4bDE2?=
 =?utf-8?B?QXBNc1lKdHVxZ3hzSXo2cng1SGxoSGgxaSt4OVA1ejV1bW0yRVF3eC91L01m?=
 =?utf-8?B?d0ZqdHZLcGc5VW93cmNUUHZXalNKcGdnbmsxYXpnUkE5dWhsa3dDMHlOUHZx?=
 =?utf-8?B?WG9NajRFN2t6VUdHNkZ1VnNnYXIrVUdsWGNOK0xyNkdMOEVFaHBGa3BVWVdB?=
 =?utf-8?B?R1hmQURNaFRBU0Y0K1pFSThveUFIOW8rU3Y4L2syUzh4czQ5cGhHME9vQVBB?=
 =?utf-8?B?cm4yRkdQVjJuQ0ZRVWN6WTcwemJ5TE1hN0ZyUC9GNG5pZ1ZHTjdvTUxzWFJw?=
 =?utf-8?B?MnZseW9SMU9ZWEtFblNLd1BKUmxwUFpySVYyeHBuYzM3RkxXcXgyTkc5c0xu?=
 =?utf-8?B?TFdqbEptL1ZvZTZVRU90a0ZSTG80VFFpUFl5Y0ZKcS9tVzAraU1ISGxJN09R?=
 =?utf-8?B?a1EvKzdDYll5KzNYZmdNWDFtQXNCSlIyc1VrbUJkSWxVbXo3RkJlVmdJakVn?=
 =?utf-8?B?ZVk2dGdaZ2ZzSU1JU0ZVa2FhSG5iOW9sV25nMG9TUWh5Qm4yeVBjSVBvNzM5?=
 =?utf-8?B?ak9BdUE1WldaZ1NEQ1hSNXJ3TGxVbUNTNHlpNmhwQ29TS3dyZUFhM0hKS2Fp?=
 =?utf-8?B?cWUrTE1tYWQ1emVjSVVadTRXZ1dzei9HTDdVZUFvWWhBd25VcWVabUhObzRG?=
 =?utf-8?B?Y0IybEpjd3VGazRORjF1dGtrNmV6T0tXOFYzSzFpamZkWGpWUEpvaEdmZEkw?=
 =?utf-8?B?aUxmTk5HN2NXVElXNWVPQUZGM1JnVkJKaGVrRDJhZm1XZG1FVGptR012MENl?=
 =?utf-8?B?WElTbGZXcmU5NE16NzNPQWREMGgrTXMyK2JDNU1JeWcrS0dUL1Bhd1FjOUdU?=
 =?utf-8?B?a0hjRzlFK3JBamhwYWJ1TGZvZjVVbjhkRFdNOU1qcmM4Zm5hdXdYSVllMjM0?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aed3204e-bf28-4eca-6dd9-08dcd35f37ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:15:09.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHsPXYBPbxz74PdEBJ57jZiuIQlyhZ5x//0yYq91zLTKeN4o2cCax5m019/pUKVYHiLJbOse4dNseAEwYFK7nsI8HN4zhJWLeHTv2VcWDlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When SHAMPO can't identify the protocol/header of a packet, it will
> yield a packet that is not split - all the packet is in the data part.
> Count this value in packets and bytes.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

