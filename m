Return-Path: <netdev+bounces-180591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96929A81BF9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD904A7308
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3581D63E8;
	Wed,  9 Apr 2025 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpVlewXY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56670259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174710; cv=fail; b=jpB9DIQ1d42Z4jgizPIsQ1mlSkU7Qv2Wng/dakng/sjaoUd1IqX/KxaveV6X98GD2f6H/VPrIhJTKKRDo6MOnr3jHq0yi3nGByHPKqbc69+RXIeQNWE8rZrjaeKnNHOOKQvDZellJKWG2SWoDaAvb5LQ1XwunDr8/PLYYJP3Axs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174710; c=relaxed/simple;
	bh=mtdS+/JlMQzZfSsYKKQcSNpi6ueeke2Mx3stfzGu2QY=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7LEPRA70obKsxSPB0s/IRCSl83Kh0C325dVtIMa+DctVx2foj+8gwhcH1Z8E56k3MByULVDZikJkQPsiJOp6CdPic82yxs9Fe37gqpLDA6F7IKP3TPCxX1ZRdj+VCBKhYjWEw+FLtK3d9vCGGIABJQppjcowvTDKqLBnMSXjSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpVlewXY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174709; x=1775710709;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mtdS+/JlMQzZfSsYKKQcSNpi6ueeke2Mx3stfzGu2QY=;
  b=lpVlewXYlyiEnmEo+IQ6yFAIxTevNsBKvVerjXjZR9spUGwpZJKcEP4f
   JEKw4MnlH67JE41piLgSbFjbkgGpCRfcSMoY6UB4Z2oOwBcCY30r2kXA9
   RHOxQUSyeBBgJoW+zle1pB4b6cd8J47s3M9O7+DbZxI8ysamcZSjfMXNR
   SBvfG0UYQJvYcw+LnBYvDixivkIPEN09kzpDaHAZralHgh+mBj4gzaGNr
   R6e2eNLMpn7pwyVak4C3hvKoIpQrat19G+lOMAxF87yMrid5AHbnsx5LV
   amPfAQ9Q/B8IAspE+d6aFiPAFXBsmGDTzaD2zxL6CE1Uo/kkjELEuYc8e
   w==;
X-CSE-ConnectionGUID: WGQIHTj0RDiykCDbmKIQUg==
X-CSE-MsgGUID: cDwXLIdRTuGODonkcQ1SeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45644846"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45644846"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:58:28 -0700
X-CSE-ConnectionGUID: mmpXZ5aHTGeX/KJKccJhcw==
X-CSE-MsgGUID: cfzLE5tLS9al030nb0Dv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129005115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:58:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:58:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:58:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1YJ5At5rNTXOrl0GPLPc41VoGtvg1dE1sOOX1vIQHEukCERw3aKrmD7G8iz/xj5BnS2TewTVpp9FhUzvgCQDv/z/dNE8gqkp/mdaN1jXtavnZWdrRJWaaoVfmvPBfZ2oWojD9MioWu7Mh6Za405oQoPJFkSGDS97hBzbBu/b80k3nBHvsWQekgFy6ifN9vzH2iBYqTBBGzvXPbQDwlk5cjWf9nmFO1U/cYV8on0a9hTs2CpfvMXQmHGGa6epm+iNec+rHum3Jn3p9EYcyruCGoXiW9mULEPQ1ykJIEXcgKS2icgZwpTdECPabJRMGtakfxayHWg9nWjpFDNxslBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKL1muxd+MtkwDW2f6zTEimDzp+RlsY+OaTPc6L2Luw=;
 b=SA91FK83kemON2tfJ2L0HIMb6wiGwPJ8xuIuy7WOIA+YFRbuFEoA592CzZxkURxIMcQpaEtxb8qmoGD0r/4dSA9ErXHGyLHYhAHAIq5Ib7d1ED00UXLf/HyGaoU/6UUkOQ4PEQ/fKrNOiY6kgp9dcmFEdv3oWA+HETyKFkJEh8YCOBAhkHTM/5SUZItgeDGthBHKQbG9IFPJVBb6PZeVBg3tr80M6TcQ4B+kVPRk57WhVqg7Znpa3DwLmlI7W6XBzEHpAtNWC8zTFsT24htdaAobhJlYHdMfJ813qD+TowYTDACT079Bp0Q6j1j4AiVOknVLufamtQ4pQCeNT2Vdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:58:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:58:24 +0000
Message-ID: <710f008b-5d35-4478-b421-b166649d6688@intel.com>
Date: Tue, 8 Apr 2025 21:58:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/13] netlink: specs: rt-addr: remove the fixed
 members from attrs
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-4-kuba@kernel.org>
 <241a1402-6cb5-494e-9830-c74767af72c4@intel.com>
Content-Language: en-US
In-Reply-To: <241a1402-6cb5-494e-9830-c74767af72c4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d6901e-8744-417d-e336-08dd77232869
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGd0M2hwL3F0THYzRkd2WVk3Y0gzbGFMY2gxa1pycGlFYnVXMDdUSlhJcElS?=
 =?utf-8?B?QTBGS1ZESWVtenF4M0JVNnhBUDl1WUMvaUhGTlBJYi8zUGVFeFRuRDNCdFVn?=
 =?utf-8?B?L05pRFJ2WlYzUVU4eGljRmwxZU5qcERkN0VpVnI2dStKcjQ3a2ZRd0JBODFC?=
 =?utf-8?B?emVXeTRld3U3QnlhQ3FXNWlsbXgyTENTNm12TEVQWkp5RGhQclE0bkoxTmty?=
 =?utf-8?B?U2toc3c2Z1BVMUpKaUFZbDVKNFpGTkhkalhwWjhpZmZWRVBrZFpFa1JZL1Fw?=
 =?utf-8?B?cGwzUm5IL3ZFZjErbG9RYTVmNHd5ZDdJOFA4TFJqMlZsd0R1aExUT1Y3Wjhp?=
 =?utf-8?B?WURnK1doOGl5RUNwUHNQZHM0REt0dlI0aGN1NEVxWXRWUHBycloybkQyMVda?=
 =?utf-8?B?MWJaRVkrY0tEMlFGcE1HWHdHY0NLWDJYbm5sY0g3OEF5VHlCQzhudVRxN1V0?=
 =?utf-8?B?NkZ1b2tNZTJCajczVEpSRHN3YXRkbDVxcDk3d1Zsc2FubWxjMU9hZnB0K3gw?=
 =?utf-8?B?eTNlamNxOFZWTmw3SVlzcU92eWlnSCt3a0kyOTdqcFB5Qnp2elh2UXVYcU1H?=
 =?utf-8?B?cGRiYW9ZbGIxc0lBcTdnNjhvRXhQbnZHcEhBT2srUXlJTGxlSU5LRGZUelhl?=
 =?utf-8?B?NkxPdnUveDZkWDhmK2hUM2FtWVZyWmhneDFzQTlCRjFrY3JyQTBLczBaT0pS?=
 =?utf-8?B?ME1TOWp6Nk1nRDdTeU5keWJSMVF1ck9XTGY1YURTcGR5WC94cGZaUVVBdWpp?=
 =?utf-8?B?ejlhbldnYldmNEUxRTRTRVNONWZTMTdraldxQlFyWk9nY0dkdTgzRk02cG1s?=
 =?utf-8?B?MU9IMlkrWEN1MWYxMnVJNVRlL1RkaDZCZld4SEw5UjMvTnM2ZFNrQVVNbk1C?=
 =?utf-8?B?RWFFUms1Y2h0MFlIVTlaeUd0dVd5alNEQVhnN25MQW5Db0NjRm05SXV6Z3Qr?=
 =?utf-8?B?cjhLdUNTRVNFUTVNOFZXcG9LQ3F1YWZSdzl5c0xOMFhOWVlTVVlhTlNLa01B?=
 =?utf-8?B?NDFYVndCTmw0VXlrdDJQVE8xKzNrWmtHM0RWK3dVQzhlbEQ1TWI5dXNGallz?=
 =?utf-8?B?R3ZWbEZiSDdoaWVIV3lvamZUVjhYaW1RZUVZOGhaeVlqcXhIbXRSWnFoTEhG?=
 =?utf-8?B?SU9ETXVkU3BKdjRCcE1KNDJGdjVwNWtKbHVCT2FFUHhzWC9kMTc5cTJUUk9h?=
 =?utf-8?B?Vi9ZK0VOdW1INTkvb25sVTFwMHVkZ3RWSDQzSlFSWC9RNEk1U1A5d2tvNXNM?=
 =?utf-8?B?NStCU2RGTFNuVUh3TWdvRkcwVW1HVDdxVGhUZXl2QWdhOTU4NEE1S1Q4TWlY?=
 =?utf-8?B?OTgxLzl5dTdsZytuZzhsaU5KS0ozR0J0aW9PNjlJV2tKNm1FamhQUDhyMTZx?=
 =?utf-8?B?d2RleXRwd2VMTHZ0MCsrOWtxZ0FjcjNSeStZR1Fkdy9jd09EZTdvYU5TUE11?=
 =?utf-8?B?UUFIWllzdDZZS1ZZOXllVHR1WXA5QlUyMkYrdTBnUEZBeFhJZVZOWXdFQVdD?=
 =?utf-8?B?VUN3RjQxNjdrZEdoYWNsSE1FS0Z2Qk9zRWRQcU4veldlYWhaMFNQVW5uVEdO?=
 =?utf-8?B?bHFhSVlMWjJYR0FxeVMydE8wVTUvUUIvaXZOUFdOQUhIbE9ZOVpVdm84SXVu?=
 =?utf-8?B?TG5JZjdUUGxFSGxMc1BscktZOWtBSUlVUGcrVGpQVmVVZ0ZrUkR4OTRuQmlj?=
 =?utf-8?B?VHIyUlBRaEVRR1BtQUVKWFhmdlh5MmhETCs4Q2dmT1lUME9jdDRXejN6T1Ir?=
 =?utf-8?B?YzhxWUUvaVUwN1ptZWJtdTFxQXA3V3pNK2d1SWsxL0JwNXEySDBLV2xmVk5z?=
 =?utf-8?B?a0E1K1g4U1gxeURYbkZ1VGhSTDM3QnMxTEZyYy9CRG14TzVmcDI1OWlPZ1Mz?=
 =?utf-8?Q?IxRx8Y+z6idVR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VTNlh2a29UeWVuc2NrcCtiNVFicGZ1c3YySmdNelB3QXprbldLdkxKNFhC?=
 =?utf-8?B?TVkzd0NlOVJsbytIbk1TQk4wL0N3MWpqREV4ZjBwalJQallBVTlQNDRpSGpv?=
 =?utf-8?B?KytSNklnVHVoTU5ubDk4YUh5VFZJTDYzeWo5OTNRM0VUY1dYa0ZKeThSMVkx?=
 =?utf-8?B?ZW1HRkdYMVlIVWp5NDdQN1YwSWJUR3dJa1Jtdks0cFhyeXB1SHM0YWpQQkJY?=
 =?utf-8?B?NTZtWm9kZTVOT2h5d002WG0yaGlDbUt6Z2c3M3pzQk5NZnJCMS8rSE92WmxG?=
 =?utf-8?B?aDJEMmhEeDdNS2tRQnp3SkZxeXdmRVlnTWhGUCt1aThkY2Y4MWtOOGtUS29T?=
 =?utf-8?B?SUNqWEVKanNGWjQ3QVdqRnlScHBxY2VQZHl6UXJ0S2dIY2liMGJMV2VxME9X?=
 =?utf-8?B?aGY3OWl3Sy83dnZaak5kYzl0MHNCM1FwbXdxd0FaMkVvYWoyK3VOZHlxbGJC?=
 =?utf-8?B?bEFqVVdhTmhKN1JkUkMxUWcwLzdpb0tZQ0JpOGlKVGpST3BrdXpobzM5RXpD?=
 =?utf-8?B?QVFWSzBkYlBPT29IWU9lRXlIeEhsZm8yc2pMT29ERjVna1U1eGFjL0dhL3F2?=
 =?utf-8?B?alIzV1V1RDd6dWFKOXA1MHR2NU1ubzFvOHYzSy9YKzJXYWVNRUIrbXRIQXIx?=
 =?utf-8?B?bDUyc212Z1lwc3IxY0xWZk1NM3daZ01ZUm1NWEJzTW5KWVdkeE1EWVk0dVpm?=
 =?utf-8?B?QW4yaWlOdGh0L2UvbFlna0ZWTnE2NGxVMUQ5YjBndFdBY3B6M3I1dkcwUGlv?=
 =?utf-8?B?Q1FNRkVCVFVFMFZ4S0pSU0FxdkplSGt3dEUvWGFSZ2diUDh5cWhaYmRYZGgz?=
 =?utf-8?B?TnJuSmJjQkRYNEVwYXVROWZzeW1SRFpZZGZGVUVRamNmc1N1MlR0cG5GeFZu?=
 =?utf-8?B?ZTMwNEtZQlJKUWZMU1RoYURBczRYQ1oyMWFjUlpydDNLdDNrZnhsTE9xUlgw?=
 =?utf-8?B?b1kzZ0pDekxDRWpDekdaSm1WZk5BT0lPOW9uMTRoV25DMW5XZDJiNE1YQm01?=
 =?utf-8?B?ZDlVVE1wbGxmQ2NQUWR4L3JZejBBTEpVM1QydWR3NnFtVURhdFZIZGZ6Tm9B?=
 =?utf-8?B?VUZxZGFSNUxjWWMzZmU2K0pjVjhDR2VvdVFDV2pvOUhuWXZVdklhcFgvaGlW?=
 =?utf-8?B?TmRDTFp0NG13Sm85U1l5Q1NQUzRhWnpxUUpTTDFPQVBSN1B3RERrYkJERDRs?=
 =?utf-8?B?bW9DVUU2RHZtbFpZdkpzY3NQQmk3VmFHMjVoZG1HOTRwYzdHK3p1RlNoYVFJ?=
 =?utf-8?B?Y01ZSE9QcERMSTVNamYva1BkaktDcFFibE85ZjBWWjdZTWF1MkprWXIrbGVv?=
 =?utf-8?B?UWxqSGN3cWkwZTBCa0FmY0tsejJSdExEdTNpZkl5N1pVekswUVpGeE51UnQ1?=
 =?utf-8?B?SVBpUStyZjQxUEc2OXZTTFFBa052UzFDZU1XTFNudU55eG9ueDJQYmxuTUxL?=
 =?utf-8?B?MWFiejlkVis1aHhXVFVJUXAwNnFXcGZveG9nSW01a1pLRDVqeW9IcGRxcUx0?=
 =?utf-8?B?M3Njd0t1UG4zVFFjOEtQNmhKVlV4TXphRWgvZ0ZtZzMrNGllYm9tZUtNRDVz?=
 =?utf-8?B?d2plYWxUMmxPU0d0ZjdKT3RYYmExTkxKM29yQzkwNzVIOTc3RGRFeTJuMDRl?=
 =?utf-8?B?d1pSak9WY09Vd0I1ZXkyZkZkUlpwWE92VGpKRnJwdUw3VHpyRkdsc2JISnFF?=
 =?utf-8?B?Z0RUemp4eVpia2FjcmN4cU5yREpDNHl4VXMrWm1kQ0tpWHE1WEZKZk1wRFNy?=
 =?utf-8?B?TU9vVlBVQStIakhCcFJoQ2RqUEk4OHNsK25pZWZ0YWUySExFRjdMQTRXNWgr?=
 =?utf-8?B?YzVGL0gxU3l3UUVHVjB4VGZJSWJ4QXphMGtyVy80OVhRUytJRXExM1l5VG94?=
 =?utf-8?B?MFc3UFVhMTZWZTRBUlRyczczM2NkS2ZzRzZ4MXdjbzVSV3RMK0szMEJIaDNm?=
 =?utf-8?B?bXRQN0dMclNXSUFoZkxqUm5hSXJiUXhCV3JuaS9IQmVuaTlqN2I5S2pwOWNL?=
 =?utf-8?B?L3pIUm1QK29mMzI1M1dyeE8yN2M0bHJwUmIvQjZFQ3FCOTJGZ1laUUhSVWU3?=
 =?utf-8?B?QmtaMGdCL1pzaGNmS1FHbXkwdFVXcytOOFFhQlo4Yzk3dnRQNVNTRy9sWEQy?=
 =?utf-8?B?OFo3SklVeXU0RzdLd0tocWdobHFLVllvZXJkamxjRGNrVGppV0NHa0l1Ymdi?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d6901e-8744-417d-e336-08dd77232869
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:58:24.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQf5b0zxoruEN9BOLA+9YfvlkiOUbBUIyaGUCUzGoXs32mC8eU29xHnf47InHyelKF7iCdPa/+lEiPWq85SgeGZ/ZLt3PVyWiRSytM/w6eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 9:53 PM, Jacob Keller wrote:
> 
> 
> On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
>> The purpose of the attribute list is to list the attributes
>> which will be included in a given message to shrink the objects
>> for families with huge attr spaces. Fixed structs are always
>> present in their entirety so there's no point in listing
>> their members. Current C codegen doesn't expect them and
>> tries to look up the names in the attribute space.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>>  Documentation/netlink/specs/rt-addr.yaml | 20 +++-----------------
>>  1 file changed, 3 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
>> index df6b23f06a22..0488ce87506c 100644
>> --- a/Documentation/netlink/specs/rt-addr.yaml
>> +++ b/Documentation/netlink/specs/rt-addr.yaml
>> @@ -133,11 +133,6 @@ protonum: 0
>>          request:
>>            value: 20
>>            attributes: &ifaddr-all
>> -            - ifa-family
>> -            - ifa-flags
>> -            - ifa-prefixlen
>> -            - ifa-scope
>> -            - ifa-index
> 
> From the wording of the commit message, I interpreted it that if the
> attribute list contains a struct, then its members are implicit and
> don't have to be listed..?
> 
> I guess I'm missing something here since It doesn't seem like that is
> the case.
> 
> Does the commit mean that structs are always available regardless of
> whats listed in the attributes?
> 

Ah. These messages have a fixed header which has its members defined,
and thats why we don't need to repeat them in the attribute list. Only
the struct that defines the header is used here. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

