Return-Path: <netdev+bounces-304195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f4EcIvZrRmrFUAsAu9opvQ
	(envelope-from <netdev+bounces-304195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:47:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 202156F87BF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 15:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dD1l7uv2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304195-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304195-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B434300CB09
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330164A3413;
	Thu,  2 Jul 2026 13:47:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755D264A9D;
	Thu,  2 Jul 2026 13:47:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000049; cv=fail; b=SZ5Ap/yiM3VlHLWuC31PEX6YVBLmYajrpbMzW2dE51VFSHBvlOvLyRejFporOqjyphVTHlvm4HgzZcLnINwhcgevLgfMg1Ciol1XZo+Saiwis7gK924pSDoV2Y1fzhIVfLanX1qOKm6voG2qUDqXgSq2+AV7JJzDX5Vpp40vyXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000049; c=relaxed/simple;
	bh=Mg+6wIIx5ps5azPc5xuCN1bnYLJy2Q+Vm6ZCAtbWqB4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUTCgc4bhASnlh/pLhiz1EV/0dveSHBVImHas9kJbAfqlr4lm7Fvh1D6WCOuVSY3hoYcbbRnyv4ujpuG9KO9biH5odAEMm6x9Zg127mZctrM2LvleNLXFm08lT9nV7olTdnygBDAVKSxo3s8VbMF9E4gE7hn/TFTmmjggWScDoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD1l7uv2; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783000047; x=1814536047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mg+6wIIx5ps5azPc5xuCN1bnYLJy2Q+Vm6ZCAtbWqB4=;
  b=dD1l7uv2lom1qcQn0G1LLY15prPgjyqgE3Zt8NXu1BS4aUGSMRCFJrWb
   B1NJTGae4yWhCDg9IWKuCUSyan437naz4aTkRoA4f47Pjv12ACAg5uTnm
   /oCKgaxKuhrm2Xxe3CeOeJIKat3aUJEszUZJrpDHJtzei5v+FxqWBOuaF
   8oTrT6n4WXjFdpxlnmKZQqg4cFRwfdFdVzhDQHC9WZZFGrhDIu0TQYrJD
   mIiY+bdCGQ/rJvqWFG86pWFpAPFb5RpI9wz50ViTyHmNCJI7VSSPZ9y7L
   6xQagKc/Sqo6N1lggF1GHSwTyD8ARhOCUldkc4/fQpoY4dMy0K+YP3rqv
   A==;
X-CSE-ConnectionGUID: YrtdCEU+RCWfVUHaul9BBg==
X-CSE-MsgGUID: lNQ2dPUZSveywMsOhwJsHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94111234"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94111234"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:47:24 -0700
X-CSE-ConnectionGUID: UAIRDfiKS8iLVk9NKtSPEw==
X-CSE-MsgGUID: fmQGt7FNRy6fK8Q8UhOwqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="251807918"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:47:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:47:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 06:47:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLVl3gH2f8pCcYoFjHJiDkP6TrMUMmfp48HinQfJgrNvJ03UF/TM/N/G9TLoPJEjFj/CElQNaM47oQehjbXtSaxTdLNyQT5FOzztQIEeqJu13QjpxrfbJsc7ZNYoLdQ7KdKz5RMKC9mB0+jgCwpvRmhmYChGnzJAkQJM2ZfvaDw1EwQs9JoiNtVKYUB0wTxxdFkfmaID0l+zoByq8c3HdvF+XR/WAtcfm2d1tHL53R+2pEVMdneDO1gnAXNk2juP3LMa4UwE0mQQB4hB5EmRsuiS2BoH23YuJxKkKJ2seEj+WAWK/krTXyMIdR2I5O5QXBPDbVgAgC+cb8yAwd6jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/qHWpWmfcTfG6gWtAz/XFBV8BuRe6ve3cDaRCX/K/M=;
 b=lc+CPuinYTHDZSXL3EdxHFypkL8qQcqN4Pr3hoRJCUA78antdzghgVai/sEMxpMM6elFDU2uDDY06E09nXf7hZnTa1081SXDEFdJ0Gz87PeuR+B9jdcogNcOjbNnEcLlXfS0cztVqDUN1hMMd3rW5jzzDG4jiFmXgYvUjLb6Yr6tBRe06yL4GsQp/7oZ+Fx76YJbHNwwHXL0uk/5zOD7DA8/k6TAF3GtzadYXqOMBB1Z+3y1ieyObQx2VC1yHv7dCzmVGSrpgSzAF/g0a2HAS4uPewLwaAXZv9wAZELvYBtlAlyh1Oc7LB//mpCjeSzyqTZ5C13sWRmUqerNYvMysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 13:47:18 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 13:47:18 +0000
Message-ID: <d2c75404-a87f-4bb6-b17c-c921d08a1f15@intel.com>
Date: Thu, 2 Jul 2026 15:49:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ice: use kzalloc() to allocate staging buffer for
 reading from GNSS
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Manish
 Chopra" <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, Sudarsana Kalluru
	<skalluru@marvell.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-net-drivers@amd.com>, <netdev@vger.kernel.org>
References: <20260701-b4-drivers-ethernet-v1-0-58776615db6e@kernel.org>
 <20260701-b4-drivers-ethernet-v1-2-58776615db6e@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260701-b4-drivers-ethernet-v1-2-58776615db6e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008AA.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::659) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: c09bbd31-de0e-466f-ae67-08ded8406ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mZswNAF5JuHpf/0EI+NVtqWBVNNb6+IKpBl75KqdCTTF3DtO1gMhj2qbcoyORpFbYGguLv5vveutgY65k/uuN9XCtKoGsjYZGdVMXhEo4UwtW7UiwILauE3ek3HrjYTvGSEEbqoK9x+xQ72jrvF6lMmNnK600+nTvvK4Ju0dEeHtOMcVOEz222MUDTwFlVXysrqpmHwvzbl8O9veK3GB2XfE3YxZHboC0+eWGYRqCEZvatDUU8KLKhU3YyI2EZoXnjzIS3ACzvR4XC9bmGLnA+xbVDwimv0rSBxIi7MzzBTnm4RHnR5dr7XFp09nBhzdb6nOoII2V/gYU+IvWIw+PbO2B991yTBxO9DpZiV2dID7tohpIaROaSlNdzSQBKuZ4+56XJgj3k2WiNaVHjQwv/alDxFxakW7ON4XsvjRK6z9/4Layd/i3yV9jR3EEemdr4CDJFtHX6dAIQlshF6VKFpJrmzwRQCEaLwHiCTCpCLnv4uu0nT26AZLDRsP8rQxsxKDbvUKv/mWqAM7wiN3mx57RJYgt0LzlpERUIxlrbY/uaJxkAtTCN8luJg4Yd2Hly8bUMcZCeR/cLZ8caJsE6mZyuupecpAiFyL+Uf43PA38AzZnXJ3GYBSBgV+XA/l7nKKYDfpryxwXJo6SvieTyHrQwtZkQ0KZC2vfrakkGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRTdStnenJ3b0dyNnQzbjc3b1VkeTc4T2IwL1I0aVNlTm85TENVYU91Tmp4?=
 =?utf-8?B?eUZITnc2cW9zWXlLLzE4T3h6TVVEamMrek9tWDRQR0NtSlh4cU5VZ2NnMGw5?=
 =?utf-8?B?b0dZelV3dXdqVldPQWI4R1hoWS9wd0FRT3lCcUE2MmRqTzJ0NVk4ZUUxQWdK?=
 =?utf-8?B?L0pTcVJlWG9JMXc2SFdINHplNklmRXJPb3ljNmxnZ2YyNWxVcllJNzNFYmQv?=
 =?utf-8?B?QkVod2x0bThaeGxVWXlOamM5TWEzbzM3NDdwWmRSTmRhVWcvQkNJcnlDRVl0?=
 =?utf-8?B?Slp3TWp6UFpnZFMwcE1zS050VkpyWlc4MGFzd3hWdy9IN1ZxZHpMZ0NwcWFr?=
 =?utf-8?B?azdramtkRG05TUhhNm1TRjlQQ1FkQjRwSzI1dVNyVkUvdmdBbmFrZzhzZEhh?=
 =?utf-8?B?UTdWalltUU9ZbzNoVmh2QjZrbzF5VlMrOW0wV1o5WkJGK1NqUlhnNW5FSzFo?=
 =?utf-8?B?MTlTN3dMeklKclE2NmtvM0MyMVZhU3E3cW5qWDZGU1dzR1gyUUxNSnZ1V1pY?=
 =?utf-8?B?S3ZycHBWT2lVdDlJUXJ0NDN1VTZuWjFXTWpTUjl0Y2Zva1lOSjMwY2FlTVFQ?=
 =?utf-8?B?ZmRKRFFXMlIxMFIyR0xZeWN4SUJaZ0ZmUG9xaVozeXRPdUlYTTMvYnRDczlp?=
 =?utf-8?B?bWx6SFJKcE9MK3pOTkwySlhFWllmNXZma0RrSkZjWTlNMnEzcytvLzh0SFRn?=
 =?utf-8?B?MndQT3p1SE1lM1grZkZ4b0xUKzdyQUExMjhrSnlkd2w0K2FYYXIwbXZ0R2RW?=
 =?utf-8?B?a1lGcmpSZ2Vsc3lGUFhhalkvOERMeFQ1OG1OSHNzSzBqTU5GN2cvWWtVeXRK?=
 =?utf-8?B?SGNkc3BSVE4yOFk4Vmt6RzREeEU0U1lTUDJpM29lUHAzaDlERkpSbGdvWVdp?=
 =?utf-8?B?S0FWaThUcTVwNjVYOFhzWTFMNzE5MW16Y2JYRitvUlBiaTAyNkFrdVF4QXdz?=
 =?utf-8?B?ZkJDQ0ZhUmFMUlBrMy9aUjErcG1QNG8wVHV2dGdXMXltazA2dUxUbDVLcjJ1?=
 =?utf-8?B?OXNuWGpJMlBiY3NpTnZzdDlwbnNFVCtrWUtxY25mdDJTcXZidVphejN2VTB1?=
 =?utf-8?B?UzNwUjA1NnNhRzcwSGkwM2xGbUVlemJRdnlRSk1YMVJ1UTM2Y0tKTWNLUXFX?=
 =?utf-8?B?K0JibjlwbGQvR3JpQWdtYlJsSlZNM1BEcDJmZmdNdStkUTJTdm9jb3RiWlRv?=
 =?utf-8?B?NzNpbXdHbUJuelBOSlA4NStCVmFYVFd3emthME91MkJzNC84K2o0M2NlYjFT?=
 =?utf-8?B?L2tSbW5DbjZVQ1dNTUEvNUhKRmVvTktlNHdUTEdvMkVmUTZScGxjZlVHaVhu?=
 =?utf-8?B?VW54YUVTaXRHZnIyWlJVdHZ0NGxqOFUxSmh0Qk1GUFlHQ2ZuZXg3d0FGa0dT?=
 =?utf-8?B?WTJWeHcwZTBEdUZkUUNTbTRBc1Y5U1Rxd01NZ1MzVU1oZGVmNmJMdk5keXB6?=
 =?utf-8?B?SXhBZ0hybzVLVFUrYW40M0ZOTm9xV3BuRmdxTUF3R0lHZ1QvT0ZVdVY1VzdO?=
 =?utf-8?B?VEcrWnZkeWhxMUwwN0tJRGU0ZTdRUGt5aktvbGJrWmQ1LzA1cDUvYUMvUzQv?=
 =?utf-8?B?eUJnZUUvMk5HOVpQeGFwbTB0NWJvdmVrQ1N0NVpzVXhSSk1wUHVHQnhLRmtQ?=
 =?utf-8?B?cEZvVW5qMGMzMWprcmQzYTc5UDVkSUo4UHFNcmVRYk1xRUFoL1RkLytPYm5p?=
 =?utf-8?B?Z2VKVW5qQmNiOXZHczJrbUZUaVd6RjFxRnB1UUZKeEpOSStsR2l0d1ZnSkp3?=
 =?utf-8?B?ZjJPZDNIaXpFUUZ0ZXhEVmhWUE50TTRUOU1Ob3pDMHdPK2czQ3RFWC9lcUtu?=
 =?utf-8?B?dlNxRlhoSkZ1YmxRTmZWZVJCNEprNWZTZTcvT3VoOVFFMmhNY2xHdXFPaW0y?=
 =?utf-8?B?UUlHdFJFUTQzTktMbDRudlBHa0RYTmJJdC8zN1d6TW1DS0FiUE9Nd2w2WTJ5?=
 =?utf-8?B?d2NlRWNmVUk3MGJYaEQ3N0tVNWp6RXljMEMwcW1GYmVENTdXTi90K0pMZFk3?=
 =?utf-8?B?Zm90V0puRyt0d0tsUGVQK05hRmtKMWhqbC9IT1o1YTg0ZHVIanBCMEFTNHdQ?=
 =?utf-8?B?UUsyUkpVRUh5Vjl4RUlmSnoySE55TE9lNXZTNUtmSXJWRmg0WFRkUEhvNU1V?=
 =?utf-8?B?Vzd3Z0pnQm1QOVpxaEFBd2NWbjNuK3pVamJvRXNwcXBES1d3a0NESkc4UGJZ?=
 =?utf-8?B?dkh5SWdyMEU2SWthMloyOHM3SEE1YzJGM3JYZGRseUFoZ1N1c0cwRmVqTnV0?=
 =?utf-8?B?Z2NFcHNjQnNHTFhLUE9FUmNhaHlqT3ZtZjBqMVFpUzlTM0dQUjB3di85QUxx?=
 =?utf-8?B?dmUwWk5waGp6Q1RHdlNuNlFEUG4wWTJEVVJOY3BuOGtDWDloc1lreXRHaWRP?=
 =?utf-8?Q?0QjktrQAtxwdyPz0=3D?=
X-Exchange-RoutingPolicyChecked: g+HcOcfdk62kS6z89P87ZtLO3+jiv5SAXYl8byTGqxRyFx9K9cjAWfeK54Ay1glUGi6pGEehJPmG9taJ5/JvOanuQ6wwPqLYbSmQ02wt2OTZExDFBgvxrqZryNAcIBc+9t+ia/Zh3qN6c6NYt9WWIqgaatEJpNMadc8tgVBmI/nH4Ndkp61IRzEw/qn1pfKFWbhR1V7Lzf1K4Ermsuvif3o3drJ1yZQd/xv6FpE13ukt2cOVwtz7pGXxTtrpU86RNrdCmuhB2fUjQMK/2LMaycr3o/xORKAvpx7P7taJ+FhhPbPtL/MenAF0GBfGm5jUaFTXryEHwShdhx06n4OH5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c09bbd31-de0e-466f-ae67-08ded8406ed8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:47:18.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypbAiC3Q3xYZyW9SizqUqLhkmJahIBrs+/+8hnDtnjOgJNKYxSQFkorbCzl4IpEc9PHjWkOfpC3cWozPLr2jieYc5Kte3d8zbia7408KNhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:manishc@marvell.com,m:pabeni@redhat.com,m:ecree.xilinx@gmail.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,intel.com,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 202156F87BF

On 7/1/26 15:57, Mike Rapoport (Microsoft) wrote:
> ice_gnss_read() uses get_zeroed_page() to  allocate a staging buffer for
> reading GNSS module data via I2C bus.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_gnss.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index 8fd954f1ebd6..7d21c3417b0b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -2,6 +2,7 @@
>   /* Copyright (C) 2021-2022, Intel Corporation. */
>   
>   #include "ice.h"
> +#include <linux/slab.h>
>   #include "ice_lib.h"
>   
>   /**
> @@ -124,7 +125,7 @@ static void ice_gnss_read(struct kthread_work *work)
>   
>   	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
>   
> -	buf = (char *)get_zeroed_page(GFP_KERNEL);
> +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);

nit:
from the code it is clear that we read at most a page, and @data_len
stores the actual amount needed

comment:
I don't know why we limit to a page, it's outside of the scope of this
series, but likely you have removed the limit (which will go into the
loop - single AQ call is likely limited by a PAGE too).

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   	if (!buf) {
>   		err = -ENOMEM;
>   		goto requeue;
> @@ -151,7 +152,7 @@ static void ice_gnss_read(struct kthread_work *work)
>   			 count, i);
>   	delay = ICE_GNSS_TIMER_DELAY_TIME;
>   free_buf:
> -	free_page((unsigned long)buf);
> +	kfree(buf);
>   requeue:
>   	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
>   	if (err)
> 


