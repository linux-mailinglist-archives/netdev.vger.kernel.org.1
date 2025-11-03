Return-Path: <netdev+bounces-235291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83242C2E7E8
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE07B189ABD5
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5F3093D1;
	Mon,  3 Nov 2025 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJVTCyRG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B12F12A2;
	Mon,  3 Nov 2025 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214228; cv=fail; b=uOOx3OxCw2Qa4Y/bLRKXFs6zDNLpSuIVe3XDJh1FHO3Z4t9by4h1HTQ1hVKzLzbuFUVF8wJPN2Xf7v6DYPe6krMgfTkZE+GuEuLbkE+KkJ4t19IGyu9eghaowRcHYrkyNCUQekgtZwYjoOkbhZqKYBMGCqmMZc7SK1zpfeYPcJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214228; c=relaxed/simple;
	bh=UFgG8cken1C92GDe/YQddFZptXUIN4SUwinYx7sA3Rg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MctuWASBlqFM+3LXTXvwcXYBi1Y6AfhSeqzYcHznIXf98UaMnkRJ/zHq1F3AqOfAutGN/ET4sUClhYvdZlRNyxELLR/9VNmHYs1zWev1JtgCEMg1Ul4obrUeNCEJTLINQbDIoWqS9dv8q6Hp8HnIF8g9SdlzC36RKilN0UZUCN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJVTCyRG; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762214226; x=1793750226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=UFgG8cken1C92GDe/YQddFZptXUIN4SUwinYx7sA3Rg=;
  b=ZJVTCyRGfniLyYmful2tVsaP/Mnnd7iu998guiMqeFqhQXc68/cXviD9
   //DlUNyVj2smkvupFQNQfb9037lEvlvn9SvKXC9LKwmjFKYUm9ysVPd6r
   uFkLfXiIHkqXGKDj58WUfU0y1CkE1zhjfBBCFGrh4m0Rm0ifeKP1D3kLF
   OV0WQLJhGRSO8OMnzE50qVW1tr2Abj++7DvoKySIhi94uu4IeCkDk8CGE
   fxCE+x4XfXAj4FLQEQ3Hug/mrI7RATr7SITZioUbDaOJ8aIFFKvN67C1h
   +rUmDRitLxp9nhMnO8Lk42j8Q+QV+/JnhnIsB26lpFiA2afStW1sK1hse
   w==;
X-CSE-ConnectionGUID: T1GWTCbvRWSFh5OFXnsYsw==
X-CSE-MsgGUID: 5hc5P+VGSqyoKQgyuzMEaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64186321"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="64186321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:57:06 -0800
X-CSE-ConnectionGUID: 16mWK4GpQua7+JCS5F4fYQ==
X-CSE-MsgGUID: 69IegnmuTPyfYjPDpi8KIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="210512377"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:57:05 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:57:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:57:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:57:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnWTzGP7WmnIsJMDhTWvEmwfC96GIfRaJ6/6Oyu3wVl3VY+CBN1cAbvGXllwh66yMmAnANAAMlps9XWjw6mgtW8Z+s4B8Pg1gc6cMAzCAWe+DUxOqTdNE0sc1JHUCoG7163nLoKHVOcPEUMTQI0Kwdl4Q8uiDm/d2f0jp/JQgNHjtonb+En5aLRM1jo33WeAj2dZL6EfMsd4kgAYKX3zmJWmYeTdKkx0hgrv1Nkl9Y1spgikhw8+XqcjydqQ3RAlH5KQEcrsuhkfAXIKwoJ3Ql2R6ocw3vYSUikv4zEXJkoHm0A1pNuPn0BiasVIEOfC1MEFZISjiSs9d0E2J3+Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD5KQk/ph1F6lmZ618U+mKGCA17ngX+wuen8aeyJfd8=;
 b=Au9jrnMXvW1SiLIz0ga4KiPDLU5Wb9Mo3L3/9vWAGU6+OLcqT0uSHA3xMMBGOaryjK5Ic99rLRPVs2G3sHXiZJhgG9niGsEGV/73y3T/o6ImHdeoEv7//06vrzhx1HGmHayECElbNOQROjHMxtC8Dnnj/Ds6aB4xxpwJFh3W7DJRXydVoxladhDAO7GbsUIKkKMD6g481hApjhejDSdilM4JFv2NnrEZ6DZYhkDUVanBM2kuWdeAw2ZQdbsh7882BLHUpgJVmqMBqJYml2ZoZdEQ08xwXaju8c+c2k+yDpbjZGPUP+qDZN+z2zl/s+YsBi1O7za6JGMs+UehU/mVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:56:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:56:58 +0000
Message-ID: <527c4656-5a25-4b19-82f9-e9826bb5b25c@intel.com>
Date: Mon, 3 Nov 2025 15:56:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
To: Chu Guangqing <chuguangqing@inspur.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251103074305.4727-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------IZjmEBCe8kQoPnj07Sl15nQH"
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bdf406-0ed0-4c0c-f7ca-08de1b34ac96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MThEVzdBUDZEaWZwODVZN1E1cG9RR24wbzZRUUwvNWR2VTZVdUJ6RzRNL0ty?=
 =?utf-8?B?Um5uanZXZEgrOXpSWExnZ1VJTG1YOGMvbE4wRkNaWTNRZmFBR3BlQXo2Ylo2?=
 =?utf-8?B?c3Ywdmk1eG53L2ZtN0tEOVQrSGx2RkhEYkowei9qd2dJM3hrSlRDdDRwMG9D?=
 =?utf-8?B?MzJqamZIa1RyV0JGYVE2a3ovNnlxSkFIblZGUzJ5WVg2bm5RVmN0eGNpSWI5?=
 =?utf-8?B?K1lQcUx1TVV2NDY0bWt3NkZNbzFmODd0Tkx0TkZlNUVjbTVwR0NGSWdqNGdw?=
 =?utf-8?B?MEwxVzNubjQyNEg3dHBaRnFkVWxHam9QK2IyaC9vRUpiMFpyTjhLV3gvYWow?=
 =?utf-8?B?RkppRjNxNzB2VnkrUzBwUU0rYk94OUErVWU5NEtBaitndVAvaEVKVGsrWXJn?=
 =?utf-8?B?U24xRjRnUVp1bWpIWE1uVmNlQ0tOYWVaVDI3VWdsd1YyajBpZUJrNitST3g0?=
 =?utf-8?B?ZU0vTURUV3lLNU4ySDVPRGZXbkpMWkQ3T2xQczY0b2lMNG1CdENMZmZyUk5C?=
 =?utf-8?B?Z0xMRFZuZzVmd2JCNHRlelE4elJOU1U0OFl1cUNrMzNLZjRmVUpyK0p2clJS?=
 =?utf-8?B?SkFuZ0RFUGYvV1dMZzFMRG9ReXpudkRrNWN0czNRSmRWWEVkK0xzNmYzSjN5?=
 =?utf-8?B?SzBzcXIzS1N0eUQ5NUJKdURyYkNmU1dwL1lSTW1OTFZhZGxBTlBMaUNvVjdJ?=
 =?utf-8?B?eHlTWFNkQXg2K1NBcHRIK1BGTm0xL05Hd1VNU1drRGh2d0dpRnFxYkFtVjlK?=
 =?utf-8?B?anVHRXFPS1VwU3JSNFRVaUlUdktOZ3QrVTZ4SnR4ajQ0VFlpN0cwR1RSekh0?=
 =?utf-8?B?Sy91bm5udVl0ZkZqNkhoUnBSR2YxV3ZWWDg2SU9ja25wS1pjeWw5ZnJXZ08z?=
 =?utf-8?B?T1pzcEwwZnBWR1FpWm85dENCUm5jKzJLU1JZU3BlN05FUFBtcW1CTHVLZFd2?=
 =?utf-8?B?RFAxejBrT1Z2dlNlT1Y4YUN5bHdUbjZDS05jZFhVMEQ4VWhRTlE2SWlNQUpx?=
 =?utf-8?B?Z1BUS213N0RtUWJtbis0TUdIZTFLTWpzR1A0cE9ZVlNxWlBTVGJZQlFjM1hI?=
 =?utf-8?B?SklaOWF3REJkYjU5QUxEYzFJN0RWVklxdHdlU2xLUjVoOTBvZENRci8wY3cz?=
 =?utf-8?B?NlhkM2JFdVZQM1dlYmhJdUc3N1RGR1hzYkZHS0pDZkRXS3ZsblgvQlJKaUxB?=
 =?utf-8?B?R0wyb3lzQUFXZlRwZ3NlakI2RUE1NHhwZUtLMTRJbVQwTFMzU3NVb1N2bVBo?=
 =?utf-8?B?STUwbUQvMmoxK09YLy9zS3NUSDVycWp5amowbTAzRy9JN3JZWjJyaEJHVWdV?=
 =?utf-8?B?Z1BuRzFiNFl1Zy9lbzRkeWFsbmY3WFEyd1Y4NXdkZDQ1VUdEdjVhK3hudjFE?=
 =?utf-8?B?Rm5vREtZeDVBQWs4SjA5ZVN2amhPYmtsTWw2Z1Zjb0VRZDhnUWxBbmZLTG0w?=
 =?utf-8?B?azUwLzhDMzZFTThoMzRXZnk2ZnRsT1dqSFFwSklibVhmL3R6dmxBMU1Wdjlo?=
 =?utf-8?B?L2greXhTQkk2dkVqTXJPVUNCd25qM0xxNzZueFhFMitrTGNHUjNiZytxa20v?=
 =?utf-8?B?SjhZUXVnV08yN3lkZ2JWY2hKTUZYUWlYUmZ5ZFRnaXAwOUFKUVQxSHBXTitR?=
 =?utf-8?B?N3BaZk9iZ3dTYVFEYUdQZE1MRXhsZ0ExOWxqdmozbTEvRVdHSWNHRFUrL2FK?=
 =?utf-8?B?Q3RoTHZOWm1Ka2RiRW9PVUJzdWsvTUlEek5LZXVDRHV6ZlhUVXpzeE9EMU9E?=
 =?utf-8?B?Tmt3YjJOb2dmdW0xMGgydENnUnV1YnVuR3lFTkU4bU5OSVlZTlFoc2FWZE9a?=
 =?utf-8?B?cjljeTBvRkxXK3ptWVB6MTZUQXFhdDNmdW9FVGFLL2o0UmNhL2tkUGtjUWxt?=
 =?utf-8?B?Y2RPQU05enp4Ri8vR3hhQkNCY1NWd2ovUWJyaVdnYUNKRk9wN2diZW9OSnZH?=
 =?utf-8?B?bktzUnBwb1JIWmhRUGdlazdOWGxYWjRRUTJjVzZsVzlTRm1kNGhqc0VMV3Zh?=
 =?utf-8?Q?3SS8gr+Zc6WdRYX6E+CCLDWpqOgYRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5ENFU3MVVUK3B6Z0tsSENHQ0d3M0lPWldUWGZyWXJiK3NPRWxXNzA2MXJV?=
 =?utf-8?B?aG9ZNnJpSy9Bakp1dVhCazVtQkozMThQWmlJbWhlY2w5WUhIS2NaaVFLRHU1?=
 =?utf-8?B?L3FHT2g1SjBQN0pJZnRVQjFnMmdId1BCaGxaVFVZTzNGZGs4UmpURmZXbHA0?=
 =?utf-8?B?ZlNxNG93cVZtUWwvS3czNzRuc3VNSW1MNmt6cHVhenZRczBJUVA4RGNGZWM0?=
 =?utf-8?B?RzU3MHlPcE15VHVtUlh2OWtlNy9uQStuZ0VMWWRaYldwUk5UU3NsNjdpYldN?=
 =?utf-8?B?Y3NnMExaRG8vWEhYaWhMOXlYR1lXV1c5WUZzd2s4em5IV0FJbU5tLzZ5SHlt?=
 =?utf-8?B?dHBVMysyMEh1ZlZyTFhwUUgrLys2UTlSTG02cUpacVlJREJBemZ0eGRGb0Mr?=
 =?utf-8?B?TlE1S2lJNGNRSTM0QnpWL1M3RU93WTFXRzFkZm1yZURCVjVpbTZ0cDdORzNi?=
 =?utf-8?B?UlNoMTgvUTdiZU5WUXQwS293bWZlQVd2SERHT0UxV2txclVQeXA4T0tXN1h3?=
 =?utf-8?B?WmxSMFBZYXJMenhxWnRTWERmUHFXbXJTWldMT1A5V1RQOTc4NFR6amY1TCtm?=
 =?utf-8?B?bkkwamtOcC9tV0NuWlcxdXZkSy9pTFdRclF6WGFCQktGOEFxUGVJYUxQOXox?=
 =?utf-8?B?MHN0OUZXWVVwbWRQSmgyQzRnN3hnS1g3VS9KUENGTitsQUwzaDZmNzBIUGFK?=
 =?utf-8?B?YXh6SkQzRzJLODJQemRLYmZyUjhkNXA5YmFjcHA5c0tWODhEYzl6ck5FTkRh?=
 =?utf-8?B?eU1ZQWM2WDVYOXpWYy8ycnN5ejB4RGhpQ2xxSWFKQW80SS9SdjBUS1hPaW5C?=
 =?utf-8?B?L3NqSU5ZdmJIMkVPNUc5UEtiV2Z6TFJ3N0toZ2RJTTF5ZnZvRlVQTmgxZHZo?=
 =?utf-8?B?emxWWlJzU3VxYzNzUzhES0JZU295N2FFQ0RhbUMvSEpFcE83eG9SbCtCZEY1?=
 =?utf-8?B?REF5blQ0bmQrNFQreU9YRHZJczl2Sm9nTzhFSEpGdjAvMkRQMWpJRzZZdVJa?=
 =?utf-8?B?MExaSmExSzNha2EyQjBxT25aU3FCR0xWYiswZmVUQTA2ZHVaRTViMGNvc2Np?=
 =?utf-8?B?UWgzN2xMQzJobFIxK2VCQW1HbVpGN2pkaWhRVWdRaHUxR3pDcGQySVcvRDNv?=
 =?utf-8?B?ZlA2cEF4ZnI0ZkFIempWWFY1Ym9obWRtYWI4U0dDdDBiOGtvNU0reENIMGZs?=
 =?utf-8?B?WTdIWGtSb24vNU90ZVJUTW9vbVdmVUM4Yk5qTTI5U0ovV0hiaGVRbVR1Vzk5?=
 =?utf-8?B?NW9nczlmRmJQbzNrSmZIaHh1T3pIcDExQnFORFAvMUtZdU5lSUw3dmExZXNB?=
 =?utf-8?B?MXllUnViOGJodzRLUG9hWmt1bENZMjd3dkpqcEViaWVjMTJvczlDdVNpWWww?=
 =?utf-8?B?OEFJdS9BTk8yVEZLU3lwaGp3ZTkrMDZnWWJlUkk3MnF4Z2RlVE9PKzR4YW1R?=
 =?utf-8?B?VDZzakhmbVpEaDE5N3FMSXJKQkRkTzVseCtXZ09QazVWcW4rL2NBNEJZc2U4?=
 =?utf-8?B?OVUySHN6bzZFZjZic1Vva09PU0lJbDhMcStKK0NXUXZOeTdvc0pjS0xia0hi?=
 =?utf-8?B?b21oOXc1aXFXWUdUMlQ3S1FZMjhXcktBU3psNkZpR3Rtc2cwMmxwQjNJaU5q?=
 =?utf-8?B?Q2VyWENVeHlZejVGbEoxZjg0UkVFM2tPWFFobXJGbXhlUDJOQ3RHdmVRQnZj?=
 =?utf-8?B?L1RhTm5mRHNTODBVakRhNlZFMmxaTmRueTFnSFBzR3FQb010NVlXOXVkZGw2?=
 =?utf-8?B?YmM0TXRWVGIxbGdyRDZNaEtMQ1JnQkE3dW96d2VXU21TRXVlMElHcGsvNGNu?=
 =?utf-8?B?UUFxcHg0b3ZoS2V6d1JKbEcvRGt0aEZTTXUvVEVnek5LdlN1Yy9hSmMwVkJ6?=
 =?utf-8?B?OEcxejBBdkhJNldOWlcvTnNvYzBnYUNTUnM2RkQwV0o0OEdjTzFFc09iKytJ?=
 =?utf-8?B?V0N3dXhaU3dHb25RWTdUYzZFMGt1d01BSURZKzlrUVlzMzFweGxZaHllYThs?=
 =?utf-8?B?am5hWFJVNlNqSHQzZnJldHExQ24vcGw3YWVodzVDM0hiRVdjRFVtbnluZFVr?=
 =?utf-8?B?S0ZVcUZQSlJWblZQcjBlQ09udTlwM2ZQaUE2Mkw3T1NKaXd1am1nSW9XWnln?=
 =?utf-8?B?VVRaR2crSmpOV3BUcnJDMHR0T1pLMUZEeDliUHJ0VUVVREFhYUZJVjNPSW9U?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bdf406-0ed0-4c0c-f7ca-08de1b34ac96
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:56:58.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNnRYq4vTPLA4IeIEdQcQBi+nVkAiEpSAdYXHQw/jtvT+QnMNrouhB9bOEb/+rxTRqWVVQsEHBOivKzfY8oAIf9R0+sFu+YOXgD/RvgEhZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com

--------------IZjmEBCe8kQoPnj07Sl15nQH
Content-Type: multipart/mixed; boundary="------------gXDO02hPYMfdmMkLQG0in9JZ";
 protected-headers="v1"
Message-ID: <527c4656-5a25-4b19-82f9-e9826bb5b25c@intel.com>
Date: Mon, 3 Nov 2025 15:56:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
To: Chu Guangqing <chuguangqing@inspur.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251103074305.4727-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>

--------------gXDO02hPYMfdmMkLQG0in9JZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/2/2025 11:43 PM, Chu Guangqing wrote:
> Fix the spelling error of "separate".
>=20
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..1e6f5e650f11 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3760,7 +3760,7 @@ static int virtnet_set_queues(struct virtnet_info=
 *vi, u16 queue_pairs)
>  	 * (2) no user configuration.
>  	 *
>  	 * During rss command processing, device updates queue_pairs using rs=
s.max_tx_vq. That is,
> -	 * the device updates queue_pairs together with rss, so we can skip t=
he sperate queue_pairs
> +	 * the device updates queue_pairs together with rss, so we can skip t=
he separate queue_pairs
>  	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly=
=2E
>  	 */
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {


--------------gXDO02hPYMfdmMkLQG0in9JZ--

--------------IZjmEBCe8kQoPnj07Sl15nQH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQlBRwUDAAAAAAAKCRBqll0+bw8o6FfU
AP4mYdpoFz3zhG6eEwMQlezapxuesSMNhex/q6qEbNzPlQEAyJgNkbTSA+N7OKuRdhm4IHrWJf9s
GWIXwra77cdRMww=
=wxd9
-----END PGP SIGNATURE-----

--------------IZjmEBCe8kQoPnj07Sl15nQH--

