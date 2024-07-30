Return-Path: <netdev+bounces-114077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1482940DE5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1093A1C243D9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACBA194C7E;
	Tue, 30 Jul 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nae9V3Nw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C1946B2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332273; cv=fail; b=GSuosbxGcsUZKSkPxRAGHu678tTUPrly+PJumyYJSC4byclzXM84MD9jbfep+iXFGvzVV+6SUYVmgpI9gDG5HgKlI+ZE6R/riVNo7EFUwSUEOmOCHsGsDqjDooDkR3b1mLTlX3mGCzuO5HDC7jjSCCwZ9vLoSk5pf9Z3QVa156o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332273; c=relaxed/simple;
	bh=bBA+3ZiA80JDqK5IFdwKL3wTkimN9PXskPjLe3kxBjc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=da70xqB7oMRWIT0lePlnOft/YYhAz8yANO2QOFCTu53kbwmBjJQ5TDWsA46KebTwWYhTBaafB3LOWPEdMp18uN9wEPSbIB+prcfV5MwhA9aD4Bt+z4jPtJU2av8XSrO2iXAbnUVO6qulBoaDTwHQQFP+CCPwG5Rfs55wHtQ60+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nae9V3Nw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332271; x=1753868271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bBA+3ZiA80JDqK5IFdwKL3wTkimN9PXskPjLe3kxBjc=;
  b=Nae9V3NwIRpe3vHzpMKIpR2I1U5w2ckOqoq4YmGAyRyGAdOSaMCTpD05
   TUfWQ0skoJfJIFeGIXrOyS5qQPWMDsCfR9TqVSLC9VzdqW+O9GPC+Pxkp
   SeI+iYFLxv1gmQmxXeIj1wx9yZc8rVAqMnjP3JOL9bgaQPwQhhZjHadMz
   Qc0le3tu08YbLRu5tDIdaJmuAUAvlTl5FiKhOHVkKeucwx+1m3UyzCHE4
   M97VlBkck8TCS+OE0ohETV6q9kIvgO/EsrtU8I1Ys9mFCUiBs5rMLtgnL
   vSCkWQibME9Lrbc+0z7a3uNu/pvDHUbqkKxEiS4j2SvZOHGH4OhLbxHQC
   A==;
X-CSE-ConnectionGUID: w6QNFojZSeS3LHRob4T7kQ==
X-CSE-MsgGUID: mhxNvMiCTVGCKONNSyepoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24001396"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24001396"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:37:51 -0700
X-CSE-ConnectionGUID: jWEHikjkRUm/YHpAr8NPWA==
X-CSE-MsgGUID: s4pH07gHSNS06W588CMpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85229787"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:37:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:37:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:37:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:37:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:37:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAj7xHcALSKjYrxb+1JsPsz2hVtgv7hcgDGWkPPElX5n0dt/FJEO8bCLpLI7voQwvDCuhnFxJ5cPPtnC6J/dyogajQITrHhmlKNyUW1aZi4W6mn6R+LTT359I4agcrT1xCSZ4yYDyP05rxnvrEBqmOR9vA03RqfyHTiK4QKDIsEcZSUnDT3t+2a+Ia+Qcl8N/YIICbQ6L3E7dNKFGPmCDg558WWYT1urCt7M6Q5ba+BlE+9xNo8BdtYsYa77gxwhE+n4MdzHL+q+YIc+Iapcd2eA8Rgf0tPYDMennPHmGdyV9elqojErLpCoeuCPETDHJ7mC8RFBvlNphky/Yxa6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTi/ZfChR8hF1YuTeHFCkOPE8vJ21FaaO41M7wr1LI4=;
 b=Nh5OJvR+Jx0KPis8pra1Xe5Z/ClTOmgH+YcitYagCCRUhXDIZMQphRCZjjjTErNKGYYsZs+cvf0UNDKPZC/802Od0cVXW4y5HZ8qk4ZQFNbzWfJaqB/X6wAp+XpqTTGKLkU5kczFI61m5t8Q1zWuF1xZ0mXg50MKb5+1dxUQE41oKxvecnMWk8vAcfUde6n5pRfgrbmc3rqxIlksQ8MXC8OQSgHedMCOcICsHxhIyFeRKczPgjw6aBXTCRu2chHILsjrzN1pg0LZpuAFCujVs8+AbqqCsL1yS4zBRsBhMirHR/3QMN7P+1mDmWcl5AVgtSoOAFM+uvP6+CdPZ3mBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:37:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:37:42 +0000
Message-ID: <33be63c5-3746-4008-998b-87b7fda06281@intel.com>
Date: Tue, 30 Jul 2024 11:37:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/8] net/mlx5: Lag, don't use the hardcoded value of
 the first port
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-5-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: abdbb930-32dc-4a98-36cc-08dcb07b422d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUhSSVNvNCthRU41Q1JXSThqVmtpRFBKaUdKZkp0VVBUV1EvWXBCdGZHZ2dR?=
 =?utf-8?B?MmJrU3FuYWtZRDkycCtvSjZhTjhQc0o3OEFnWnhDZk1rV3NqbzgwVGtlNTdo?=
 =?utf-8?B?ZGRubXh2TW9COWVRRVhjSUcvUkNITlFnaFJVbkFpYVlGL0FQZ3BrZEE2NjlK?=
 =?utf-8?B?dCtYakV6YjA5T0c3MFBjZzlMVGlHbnZEaEJ2OGxWT1Y1TzhwVmRnUTVCWm5S?=
 =?utf-8?B?d0VlYmlpZzNYS1M4UlI5N2dNY2ZVdENlaFd6NUNHM0k2RWxKN01VaUNvVEha?=
 =?utf-8?B?TGxiRGZLajV0ZnpxM0VpTDRiOXhFbWx4QkpWcnVrTjV5MGFCTGMrU0doSUc2?=
 =?utf-8?B?M1VlN2doWVpNZGRGcFFTemFOYXUxQXVMQytCUG8wODlqTGc4SWFoSzRLNERx?=
 =?utf-8?B?OVhZendRWGgxbnBzNGdOSlN2cVY1VFJYbkdJWlFYSGxBWUYvd2VYeHRjelpY?=
 =?utf-8?B?V2E4NUVNZW5CZCtiUGQvekJSWCs1VlR2VjZLaHBZM3hSTTBySHFYazdRbUoy?=
 =?utf-8?B?bEc4Q3poYlN3S1lFRTU0ZDZ3dk9XSUJUTnV2T0RRV0JBVDk2UWxJKzk2U21v?=
 =?utf-8?B?RjFINE5VakZNUXJwMEk3SWVyaVdQcklWdEF2OEFDTU5vcTVBLzVYQ1BDZlUr?=
 =?utf-8?B?bGxCMXN6SGVrbStNbzZHZm9BSDZxN2VPWjNHNVYwNFM0SWdpZ0owQ25rMkNk?=
 =?utf-8?B?UG5adnB0MWpWWkF0T1QzQ3hERlp6d3RXTk15bUdWSFU4YklqZ2tZMHFPMXBJ?=
 =?utf-8?B?L0h1WkNuOUN5a1RwRDFlTW9BYmk3SEpPR1hnWm9JMFFxZkJyWGtubWhPdURr?=
 =?utf-8?B?NjB5NFBXb2hvQ3lIVXBKZTN1cVhCQ1BWU09Panh1VFdSMndsVTdHREVJRVpy?=
 =?utf-8?B?MnVuVFRPQ2dxVmZWYngrTnVKQllJa0YxbmhwOWY1T1pQWEpzTjNYcWV1VmVZ?=
 =?utf-8?B?U1pmMjh6dlFMYitDeVA3VmVndndmYnd1Z3VFQ1NNMWpoRmUwYjY1Q0tZTEZK?=
 =?utf-8?B?Y055MHFDTisvUGxlc3lKOWNvSTZQajZWdjkxcndMemZGL05xYlN4ekR5N2g0?=
 =?utf-8?B?aWVkK09oNzVQL21WVTg4WTV5aHArSHBaWktJdU9CYzRUa0E2aXp4ak5rZUJu?=
 =?utf-8?B?NHA2Wllha1d2SktaZVU5RzlhNktNWlp3dTUwNFlOV2tVNWhhTFR3bjM4bnRw?=
 =?utf-8?B?TTdUOStWMjBUVG9kYjFSa3VkenBqWWcwOGpzVDMxOHlPUGFHRTJWQ2dFUDFH?=
 =?utf-8?B?bHJGV2N3ejBjSHFWb1dnMEJoSXRzQlA0SlVEeWhxZlA2VDNjWEwzeXNlbWlI?=
 =?utf-8?B?Z3N0Rmd4TlhldUtuTFU3U0pIeUpGK1pWM1pKZ1ZNc0xwSGRFSVYveEZaUUZp?=
 =?utf-8?B?alczc1FYSXZoQ2dHNjZFUG5oYVo5SkxBVlFxWnFFWG1OL1ZUSjFNNHVOMTZN?=
 =?utf-8?B?YkVxTXU2MFRYLzRBZjdlSFA1Qmx2YmVybkV2dkljVlhHOTNqNGhoVzcyRTNJ?=
 =?utf-8?B?WU8rODROWUVIZGhXVXIrUHdNbWV2ejFUZHduWWZNLzdhMUxZZXp3VGFsWm9C?=
 =?utf-8?B?MExkQU85dERZcnNBZndLRmk3Q1lSNFE0WWhQcFh3RW9LS1BPYVhydnNCYjRG?=
 =?utf-8?B?U1FVZ1pHODhQcFd3bGFoRDFnZlBrdTNseXJMdmNZNUJ6RElETXBHMEQ1QmNk?=
 =?utf-8?B?N2VpOTRibHhHNmg2Q0pJQlB3bTB2WktWbm1LM2JwUVk2THl1MjdZZXI0Vitt?=
 =?utf-8?B?Sm52bk50REZRRlh5UUhteTZuZnQ2TVhFbEx1eWZkY1RUdnF6R1l1Y1dvV1Nx?=
 =?utf-8?B?azFsY2VQSEhiZDZuRG1PZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRTaFl4U0loRDNlSGRTV0Z2SkVIOUZMcUlRaWtaT1hUUG5uL2VzSmlBdDMv?=
 =?utf-8?B?c1Y3V3VzQkxGUThVUkVEMXVFQTZqYk9PbkZ1MTZlUm01RU0wblQ0QUtjSWt4?=
 =?utf-8?B?TnlNOW9pa3FCNG5qUjMxRWZuR3BWTnM4TzFGdTJ4UmoyZnZWZnkzQ0M0bGU2?=
 =?utf-8?B?b3dTaTJ0bjNBUGQrVUY5R1JreUxFK1hjandtMnlRT2hqTUhMN3VBZXlCUkFo?=
 =?utf-8?B?SE1yZmh0eWNDc0RKTVJ3aFgrQ2ZCYVFkdVRwVWpzUVYySUxYRkNObFVqL3Ev?=
 =?utf-8?B?R0x4YnUxZ0dsdkkzSmoyRXhsWkdTdnc3RWJ6TFpWMXdDZkpZTnprbG5PVDI0?=
 =?utf-8?B?R3pkUVJxeC9HUDBNK0xzMy9DY2hoTUJERXVxMTI3UmVSUWpGbXVGREJzb2Za?=
 =?utf-8?B?UXhJMDJZdW95dVNZUEE2eWtFYU5JOUtLVDlqdkNmeElUNHFQQ2hLdFFkbVZZ?=
 =?utf-8?B?TXJ1bTA2S3NZbzN6aUNqWFp4MFJiZGc3YzNoU0Y2MkRacVJmSGtJMVpYcjRQ?=
 =?utf-8?B?ZnNDR3pBMmE0Q1hPbHgrLzVyay9GTGdkOStwcjJ1UHErRG9zdWZEWmxIZHNh?=
 =?utf-8?B?Qmtlc0RJWVpDVDBvVWRORDdUSURDRG1tWFhJZElJWHVWVmhTeGhERzNKN3Iw?=
 =?utf-8?B?eWdKSWIrN3Z2eVpaaUx1ektBMjdRYXdDSGVnaXREV2NXK2d1aDRzenJGOTZG?=
 =?utf-8?B?Q1Y5UVRwa2kxUno2UE9OWnBiSk50eHFmL0hMVzFnSFBmL08zRXpQdDI4L2tW?=
 =?utf-8?B?ZU1zUzJ0SkF2UmluazFFTE04VkdoLytDaDB4VExZWmRHUEpFQ1hYdHY1ajdh?=
 =?utf-8?B?SHpuclhzdDJscXE5Q2tIQ2s5TTJ3TWFIa3M5WnppdER6OTNxTHRjc28zTVF4?=
 =?utf-8?B?OFhZMnptOHVhK3BtMkpNbktwb2Y5Y3NoK3JYcVJEV05aazFkUUVrTDNpT0px?=
 =?utf-8?B?Z2lWRFRzYUdySDExNGl1K1RodEVuY3hNZDVnVG9iMElhNjdRMmdZRVZoMnF5?=
 =?utf-8?B?NUg5SW5TelFlZUlRZ1RoVDlHUmtWaHZENTlzV0hTODg0ZE5jMVY0d3QrUFVO?=
 =?utf-8?B?V1ZyNXpLTERwczh4NGxaZlVtN3JWaHl6aC94ZExtczBZNnREbUZiaW40WjZw?=
 =?utf-8?B?dVRIeGg5Z0lWL3Rya2l3U1NReEM3anZ6SG1hSEVKSXZLREloMmxOM0owdnlv?=
 =?utf-8?B?SGJlbWVla0YzR0NlNmFjbWNic04vZWR1VUxTRi9jMVJ1UXVjNG5QNENjYTQ5?=
 =?utf-8?B?UlZVQVlZVStpdmxoTU0wczhteXppZkZ1VktHWExVQkpadGpZRjIzZU8vdW90?=
 =?utf-8?B?WHRXK3U4NE5UeG5FTFhpdnIwZ2ZJQitldm82WjBiaE1OeXJRUUZidEc5dXJs?=
 =?utf-8?B?YnJEeVRXTFl3MStLaHUyWm5wbDJualpuTkRTOUg4S0Q2b3VQYkFQQ29kL0Rw?=
 =?utf-8?B?cTR2aEJIN2h6d2xGZDRtdlBFRDZjS2VycC9ISEVRMHFVZXhUTGdudlUwTzJK?=
 =?utf-8?B?Y0ZTL2tEbCtuMng0Nk1CYjNkM3pidHlvNjFuK2pFZGFRNTFkSXFpL3FHTTM4?=
 =?utf-8?B?dHh1bWd4cVNEVURocXhJZiswb0pjU1BLZGFremFBVXlUN3FCTjJTSnZTNC9D?=
 =?utf-8?B?ZnFRNTdaUlZ3SVpuSFA2ZXpmcmR1eURyNUtDSitkcXc5V0RNWGRMbWE3ait4?=
 =?utf-8?B?WlFmMzVFeFZkR0J4YTlUdDRoTlFiOHNSSGpRc3M3TjI4VFdZalhNZzYvclF6?=
 =?utf-8?B?UjdIRzJLazBtM0NMSE93WXE1Wk9jV2xsY1JsM0ZDVWRzWG5valpOTHRhenpx?=
 =?utf-8?B?M1hsY0ZXaGQ3MzFBREwrVGxQMkZDSUthQkkyWnFyUFRpUHE4VFF5WnBCbWpx?=
 =?utf-8?B?dmhSbEFibXJDa0RzcllHandRZ082bFMvNUNsc1VoeTlWaG9sN2NxWjljTjlz?=
 =?utf-8?B?UWQzYlBYU29oRlBkbmVjUFJPcExFcndmSDgwN2lLZGF5MnRSZHRjd1BZejRz?=
 =?utf-8?B?a29hdFl5K0xnK3N2bDJxekoyZXpDQUNXWnJlMHRlQXBWQUNjaThrRlhTcGtn?=
 =?utf-8?B?T2dYVXh2Tm9CWVdjcUd0ekN6Uy8veWsvb3cvUVllMlh6WlpJYVhRTU82Yjlo?=
 =?utf-8?Q?dOkLrI4woc6xEwSVrYKdlrsfE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abdbb930-32dc-4a98-36cc-08dcb07b422d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:37:41.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOUyL92Hju80ukTVgSLrLBvikzCMWeXGxumSKJAB16/6wifRrXRQxL00ZnmH0KmD4mTxTJt+UUwlPsMiJXxiTszIPj3Y6yxi//TWikK9Ozw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> The cited commit didn't change the body of the loop as it should.
> It shouldn't be using MLX5_LAG_P1.
> 
> Fixes: 7e978e7714d6 ("net/mlx5: Lag, use actual number of lag ports")
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index d0871c46b8c5..cf8045b92689 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1538,7 +1538,7 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
>  		goto unlock;
>  
>  	for (i = 0; i < ldev->ports; i++) {
> -		if (ldev->pf[MLX5_LAG_P1].netdev == slave) {
> +		if (ldev->pf[i].netdev == slave) {
>  			port = i;
>  			break;
>  		}

