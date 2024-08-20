Return-Path: <netdev+bounces-120339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF7958FF4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF1C1C21EAB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F01C579D;
	Tue, 20 Aug 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm6Z75mX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AD18C000;
	Tue, 20 Aug 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190641; cv=fail; b=OpOUJeBhHvb7LXknIOuVNgtJepF87gi+R4/O4rN8qSyMYjrXhB/dUjXQoiVFl9TEMA/WUw5psSv/fr3euBbkaPnhSBO5hx9cLlugFvmBmHx+Wvek8K6IDnI4DJ0XdESqYXJxYZuvspQXTIVesN9O5MGtOOw2+C5HOEIugItkAMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190641; c=relaxed/simple;
	bh=yxFxgMc0beoM3AesCABcwCO4qDqcRjl2gAi9MGoomaA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/5Q/uPCSBzOwzkFT2eSBiqXlXfJP4H7tZY1P/7YdNlFT+MYBNDKFwnWn/RMv/QxLdWYO3EfQFOBINLjtXh9M4dDGbNxL2xQkiyIFYLAM8zxoKjjF7kisWH3wKezKmssdYVUMtdNQ3SmUHEVsKBksyZ/DVHhgOCqgZmQAk9T/E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm6Z75mX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190640; x=1755726640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yxFxgMc0beoM3AesCABcwCO4qDqcRjl2gAi9MGoomaA=;
  b=fm6Z75mX7dCrVQLA3UMlZPms5Xl/yXe15fLUZWiD+rhyG9D24PbbTp1Y
   1K80CNQFUhzmZJA/H2pgZbfAEb3YB+BgjXiox+RUlfsVwLNQ2zSvxfDaV
   F8/Sy7cKS/961A08PT29xJFxuIGfE/CXWrYt1KKcR+i6KaRwBleNq5rO+
   eFeTW3jsHCzhRpvI61oFitKxaFn2q4ziPyfBGsJqHhhQ1f4aLoWdUPoqe
   DKDaDOH6ggXW9vuBPmvqMsn/yEn8uDwaRsHD6qgm+XzGjCxTIwrT2P88l
   2a/jsYQ7NQjGcZjUiNVQHivDHRRxeCOdd28rljIIA4d4ZEgrYEiMKQLuf
   A==;
X-CSE-ConnectionGUID: wwqWNXrYRqCgqWUs05C60w==
X-CSE-MsgGUID: jw911u/jSqGFX/smGeBDHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13119191"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="13119191"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:50:40 -0700
X-CSE-ConnectionGUID: 0mNrgDnCSUi22TH71jDb6g==
X-CSE-MsgGUID: yUGIUZ//Q9e2DFgXuiDoNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="61026033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:50:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:50:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:50:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:50:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgcmZNk916Xc7x7IeS4XEwWySGvsTrT5cFBHZg1R6VZO/3bwkHXH+hktEVIZQGtWt2c0j6f9pffKTAFuoBnyzDLEriajLyLvTuhGgMKO3rzUblS56G6Vg+iIzwFQl7do3xDTyUskWPpl2Va+uUC7Ng6Fyk9XHBN8MRS+yYbisM3LdLlFm2RzfuTsuShrxSbMdgJOclzEY9iBVpoo7ChrXKkR8eG1XWF87p8sOUWqRdcjT0CwYMDsyVXRsZuFjKuKQArco0r3VdPFZm/mhjWyHPzhrKAyJK6NLELRCtHNV7mEdaSN849b2xZ8mqS8IK6Ba2wShtpUPLX+AnVTc2q1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujhKBgAcHp4sS3FdvyeUHG9kDLgqQT0HTaeXeT0qhMA=;
 b=QHHVFHZJ+DxdUGC93UWePmgTNGSEgGybcMPZNSb3mKQ9TmQqz4UpW8yiJc44mgpMNxWDGBdxb+nhehlorhPq86QY3xedaN2XLXVhJzTzkVZ0FkdcmuZC4fhanZWplIjg0tkyq90NwDudDeCuNUKoxNeHA7H6XgeDsPNk4syZjzqFfrfCI9yjQPvx+1ygqDnM5LbUsnenB76vV4fEjmSu5IZR1vjhKZ466CGPYoZ3AvkuzkHmIkwf6QdFEf5LSBiUqL8SP1zgw0VJXZR8oAXhHqdOi6DtQ5EWQcEe0PsK3OAYfjG1zZGpVXOjVlF8Ws3Qx/ZjPgUfxT6YgxSbtVynmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 21:50:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:50:35 +0000
Message-ID: <02d6f5aa-e009-40c8-9f3f-869d004c24ec@intel.com>
Date: Tue, 20 Aug 2024 14:50:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>, "Sai
 Krishna" <saikrishnag@marvell.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
	Kory Maincent <kory.maincent@bootlin.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Roger Quadros <rogerq@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
 <20240820091657.4068304-3-danishanwar@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820091657.4068304-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1d0594-431f-4e93-7cfe-08dcc1621f16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWpnbkt2c0FZYXc3dlBlYkt2T3psa3VyTHc2Z3R2RmpNUDkzMnhDUVpyc3Ux?=
 =?utf-8?B?cVJtSEF6RjU5ME5ZTUNkK0plN2hERnU4L3ZyZGk0MytqVTZWZExzN0UvTDJq?=
 =?utf-8?B?RFRQcXF1ZWJHQTNrbzh1R1MyQWJRU0t1SVdZei9tcnZkNjhTakNpQmdreThL?=
 =?utf-8?B?MHZLQVpsa1ZFYzFSVXRxUmtWMTIxa0FndHBhOUlNK0NYRjVab3ZVT0loc2Uy?=
 =?utf-8?B?enVqWGswVG5XNXMvMENYVEdhUXRJN1FrdENMaS9jOW9uMzN5MVBXZ2kxMGdw?=
 =?utf-8?B?aDFwcWNSOGZ2REZLeUJ1UnVaS0pDc1pZbzB5bVQwejRpbVcyZ0VZUm5jb2ty?=
 =?utf-8?B?VGw0Q2pTVEpkbG9DeGtZMUVDdGlKR3pWR3hLK2hSZE15azlRaXMrMHRCQkVK?=
 =?utf-8?B?K0NZV1h2aDRvUHNKaEp4RGpQUml4bmJKdXp6Y09OZ1RSYUg1T0U0M3FXM1Fl?=
 =?utf-8?B?UmpzRjRURUFjSG5LODdkWTNuM2xiTTlkVnRISDVheStRemNBWk5SQnoyNTFI?=
 =?utf-8?B?dXdJQjdybzBNRXdzVUN1OTV1MjdDRWF5T0pJQ3ArWTFJNDkwWFJ1cHo3OVFV?=
 =?utf-8?B?U0t2UjJwR3YyU25VZXRzWThoelN2c0Vrb2xXenluZDJtNnNtMTdJOE02RkdR?=
 =?utf-8?B?VGxEeFRPTHQ2RnJ6bUVqOFpjL2VZNmVhUTd4ek9YVUk1Y3lNSkVxUXBkSmdU?=
 =?utf-8?B?N1pkR2lTKzJPMEh3d0RpS2UxdDRRcktnTmxvUjJDOUFXc3JKMlhhREI5dHRo?=
 =?utf-8?B?aFhLVi9Ea2Z5dWJQbkhyL1AxWmd4aGJNWlVNbjE3ODBpTWNoOXlwZjFWcXAr?=
 =?utf-8?B?bmxXbnc2NmRmdjBnSjIzUElVVy9lemFXTnoxVWx6Q0R2ZHFvV2dIcmRldFp0?=
 =?utf-8?B?dkFMRlJHMmQzMWVPVG5LRk5VMHFZSUlxem9vaW5ZSnZ3ZWFJK0taUnRGMmpC?=
 =?utf-8?B?VEtxME5BTk1nZ2xJYXpuNUlZNEZhb3orRWVKNGNJUjhlaE9CK1BlVmtEaXl2?=
 =?utf-8?B?cDcyOGlxcmIydUlGR0xRdHd3cVFkbzVyL3VyYzM0RG5Ec0o0NkpwSFIrUkFi?=
 =?utf-8?B?Y1VMb3V1Ty82RWE5VUc1TVdOWUo3SFJkZk9zV1B6MTlBOU9YaFRBMUloM3Fu?=
 =?utf-8?B?V1RXQmp3VFArQTFhZ1pPUzlWM3J6MmJCd1VaQVZCQzBFN3JIcFp4VlB0cnNL?=
 =?utf-8?B?U09uTHA0U2x5akVqVVVQV2U1SFNITHpIL010dkRWcFk5cXlYdnZ3NUtDQ0k0?=
 =?utf-8?B?aG9yU292MWc4eHNGT3hOQ2d3cDk0eHNKb2RVS05XZ21yNkE5SHkwK05DOUJD?=
 =?utf-8?B?c0s0R2RSbzZwNk5xdEgyQnIxMmY3aEhQVm9NZFptUjA4Z2x4dGFhZnJyc0U2?=
 =?utf-8?B?VTMxSlRxMDQvbS9LYks4OFZSSUJJMVBqY1hEcEM2NFlhUHRZbHhONkhZbXkw?=
 =?utf-8?B?aEw3UjNvM2RUVUJ0OXRTbXlJYzhQVzErM0k1WndHa1VYMjNNN1Jrd3VpRTIv?=
 =?utf-8?B?d3FRQ0hMTzdST3dER0svQWlvcUNvUkxrd3VPM01VNmFGTTZ4eUJwRGM3SlUx?=
 =?utf-8?B?Y2dHVmpiUFBqdzZIMklMN1dta0ZHQXNGNU1sWURIWFBBaVRsMUFCazYvNnRz?=
 =?utf-8?B?bG9IZTJjd0ZlU2RaQktBTmpQdk9HOWhYbE1BNTdVL1ZvRGROWi9wYkxWUk9E?=
 =?utf-8?B?LzFVTWFRdDBjcy8rSU1TQUpPVTh3c1lhajQ3b2JaWXBUcmJ0cVlEaHlIQnNG?=
 =?utf-8?B?Y21XYjZJcTgyYmFGdzd1bXJwZnRoZDVmUVNEVnNneDd4MVdjOEs5elZBUjIz?=
 =?utf-8?B?MVo2TEdVWHpSM2RrbHNsWXFsVTViZU1sZDY4YUN1K1h6S0pUSzVPR1pUejhq?=
 =?utf-8?Q?YeWe7T7YzKeGR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRURVlHaXBsekV6TjFTVkQvRFdRTUtmeFpRN3VHUnBpMVVBMjdUcmFlVisy?=
 =?utf-8?B?WG01L3ZrMkZDMTVBVTdITkJxaXJXckVlQ0ZDN0xFWGpVNEpVdzZ0enFSZE4v?=
 =?utf-8?B?Uld1Skxsc2o3Z2pzc2thalljZXV4SUgyUmFZNUUxcWY0bWMyeGxWdnVmRlJ2?=
 =?utf-8?B?WTNIRjlZTXBjMWtXVk9iVWxYcmI4aGw5dEdkUC9URHVvWlZLeVFkVDV4eThE?=
 =?utf-8?B?UUZBVmhKZWM3MzhCbnh3MVd4T2tLODhvNTFCaXozaGtYSDBNeWs4Snd1RGZD?=
 =?utf-8?B?YkVuQ2Y2dGxrMFFVM1ZUODU0d0pmNWRDbE9iMVVpRkhIQTI2RytqNEpvRjVF?=
 =?utf-8?B?Q3RWOVZ5dHl5ZGZZZXd4SGNvVWJlNHVEK1NDMGVpU2xHVHM3V0dUL2JRRlU1?=
 =?utf-8?B?Ri9kVkhEMXpMNCt3MDZNWnFCYW1kMncxTU1saTk4cnB6UDB3M1hrY1N0Z1Bx?=
 =?utf-8?B?bjQ4bmh6TXpRbExtVFV5Ykd2dkZKV2NCOUNYZjJ3K1JsWjVKOUQvaFJLWTZm?=
 =?utf-8?B?ZUVUZWFtOHB2SStPYWtPZlJHeURMNXUyamUrdHpwbnJLQmRSYWxCV3NBbGUz?=
 =?utf-8?B?ZUQvSWM1YndhSkx1N1hZakFVK1g2VUNRV0VJdHpHUjFMUEtmNVIzeFBwVUtN?=
 =?utf-8?B?cWFLUWN1UEJxSDVYZ05BZHNNRTMrNFBYWDJpNXFTNm9lanhCUVorWTdadjgy?=
 =?utf-8?B?cHJxTXB5L1owTzdGNVh5NHhSTkdhU3dtejA3VTlKM1YrLzdFVDcwVnNuaWRh?=
 =?utf-8?B?KzZBNHRLSkRtbjB0S2hpUytCVzdTMWt3NE5sSjcwVzlYSmM2aFZzb0lYcXVj?=
 =?utf-8?B?bWFycTFwdXZ3WWJKbE13ZUN4cVp2dlQyb3AxWkNWeHZwSi9UTi9ybkV1Y1ht?=
 =?utf-8?B?ZjB3VFZqc2FGckhIejZzQ21uZndQWTUzbWRET1A0MjBIazRMVG5vNitueU1G?=
 =?utf-8?B?UTkyUWdTNGxHWGdTSlRxdUxhdnBNMUE5d1FyUXBqRzRjMzY1L2h2K3IzbS9S?=
 =?utf-8?B?QXhQc0xZUGpsVnlQYkt1NzRESjZQU3FhdExBU1R5U3B6WFRRaCsrTSt6ZnhC?=
 =?utf-8?B?dU92d2xRY0NiSzhNc2REaVRlNVdpK0orU2FoQ2RTNWllR3hUQ0YvZWxlb0xQ?=
 =?utf-8?B?SU9neUtlN1hybllTMTBVZ1pZUGphNDZpUmpuTTNQdjNnd0xPT1p6WVFEalQ2?=
 =?utf-8?B?NlZ5eExUVFdMV2t3OXJJNktsYlJ5V1dmS2pEbkZyVnJwWW9zWkNUV3JOUEFk?=
 =?utf-8?B?MW5tQzI3TWdkcjBCNmlpM2plMVQ1S0E4aUJ3RUVjWno4Z2RWU2hlc1RHU3R6?=
 =?utf-8?B?SkI0bDN4bmIvME9QSjBPYVNIbzZMN2NuTFM4bStRWDZ0RXVYMjVOaXpySTFY?=
 =?utf-8?B?MFhYVnUxQTlPbW14RlFRcVVBTzl0QVNBZWtJbFM1R3ZTUjFCU0x0TzQrbXM2?=
 =?utf-8?B?VXhKUXlEVWg0c2VWZFJGVWxQMUhjS0VnRkIyYU53a0k1d2VRUXNiazRUYjVY?=
 =?utf-8?B?ckhOdEh6Tys4NmVFblVMMjZQOFA3aVJEMmlaN2YwcUNldldkMXgzS2M1VlZP?=
 =?utf-8?B?SEtTV3JvMWUzY01jYktnc2Znd25LaXNnaUVjemhMZ2ptWXQvRDgyakxyM0ZV?=
 =?utf-8?B?UzZtdzJqTmJ1V09zcUhrbXprRGowZXdqaWE2cHNJZllKL0VSa3QwVFFnTlh5?=
 =?utf-8?B?clRObGptOWg3OEpsZ1hLWFRIeFEwblI0bGNERDA4OVFRNk5mNEZhN2RYOXFH?=
 =?utf-8?B?c2liSy8yWFE2RXV3UXN5THoyUzJFU2tIRkVtMWl1RFpadUl5anpBcFNoQ0d2?=
 =?utf-8?B?cFNFdVp3d3ZxY2FVZWNrV21ySXNvUGFwZ0xiOGh4YTJVV3preng0RVhRY2FZ?=
 =?utf-8?B?U0hCRkI1Zjl1MkNJem85TXdXS0FwZUhFeFRrclZPT0JGV20yVFcyNkorTFk0?=
 =?utf-8?B?emh4MEs2b2pkTW5GdzZUWlBHaGFHQ1g4SEhCcHZNVWV1Vk8zM3NySnBDQnFM?=
 =?utf-8?B?VzJRd0Z2WDNZWlp0WVVsdlZtdC9UaEduVDZDNThuMjZxczBwQ2J2NzlGRDl0?=
 =?utf-8?B?TjZocjdBbW5uUUJIeDl3VXhycXUwWDRJa2NUN21Oc09RbTVBSSt0TjBZL1RB?=
 =?utf-8?B?Y0g3V0traHl3RGpjd2xmNzY4TDZUVDdITFhrLzI5cFdPWE9uVldpQ3A2bUQr?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1d0594-431f-4e93-7cfe-08dcc1621f16
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:50:35.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RBcaSMrx0IS2JeQ4MTmVx0Gd68cF0vVe9LfqZqs63MVV1T8l+bOUpERQLSlju71XU+8bKHb1TYpzjo4oqz5SVmOY5OvjId+9nzj5BXyyDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com



On 8/20/2024 2:16 AM, MD Danish Anwar wrote:
> Add support for dumping PA stats registers via ethtool.
> Firmware maintained stats are stored at PA Stats registers.
> Also modify emac_get_strings() API to use ethtool_puts().
> 
> This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
> and creates a new array named icssg_all_pa_stats for PA Stats.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

