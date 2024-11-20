Return-Path: <netdev+bounces-146548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2E9D42AF
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2DA2812EC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173115B14B;
	Wed, 20 Nov 2024 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHzBJlkA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBD13C80D;
	Wed, 20 Nov 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132112; cv=fail; b=hnURF1X+PA4woc86UZNGj93+rMkkdVWWbvxNrY8JA2W4qjq70fR92bDuVJowJwTnL0JYd2RH+jxPHfh3PUXePRc/89RFMAVvqNdc1LWbdLBKc47re66KvByyeo9vY9T3cZJ92uLB9MwYY08yD9828/eIYZOE0Uu8bAPlwR/QgOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132112; c=relaxed/simple;
	bh=KCyEvHaas/CtiV8qzM+vptXcbFv6MKaQWZrj+yX5A04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gjPSBCf2tvqQipqaetUWU4ptI9B4QLFwlepB0RdqYztu8w+wFCkjf+spQckewQR7a7UIAfp4/zMOzVjDRkxt7varnFjM2ire8wNn9Nz3lWtNyWipf3pKhFnipb4ds2yX2nbPqkfrbjDucR0/Nt/fKunGEYQ4h5dtzCNGiVsni28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHzBJlkA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132111; x=1763668111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KCyEvHaas/CtiV8qzM+vptXcbFv6MKaQWZrj+yX5A04=;
  b=VHzBJlkAxvaRJEFF6B5EluFhA1rUDI8W+8ZdwhMG3wDDrKubRkWtOVQN
   GDPrt2RhZmwe3G8u8cLIEiG3MvkLrnDUqXG4ZuNze9Ns8QmcWUOURKTy9
   bQE/vGdhEsqV4N+7GOGZRRSw+o2RecxAPXUWDJ3hsTMjK5BVnfk7HcCzU
   uq+W1PNqAhmtT1M6dQhZN9icHVcbt4nGWpyT56D08CF2QXj6SjL1CMeI8
   P7phvc5gIC2IaELlC8ZL1t/QsWzruHufXZFob43dkbtg1+tgKUc8xO/2a
   ACt1UjzxrJ+PGQqJVbhPEc/Priu5Fh71it2Im7dU58qyViUwUM748ajZl
   w==;
X-CSE-ConnectionGUID: Vkd8dgFuTnqYN52ZBpgrBg==
X-CSE-MsgGUID: 55/CKR0CQ62O4MzYUqXb+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31607857"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31607857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:48:30 -0800
X-CSE-ConnectionGUID: YsTjfRIORkirO1/0NwqHfA==
X-CSE-MsgGUID: cgQ+qS2gRBCLJSC2i2F2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="127552876"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 11:48:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 11:48:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 11:48:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:48:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKV0DA3ByQ4hnofAy6LxgczcO12qPS2KORPIzbSWezX8Nt5KebqJ8G+QKvM3pogP15286mrFz2hXn0dpSyA4dnCRS/TQixeFoJF95emgqkJHgANx/tM0Lt/NeQstSl/KWxgBbXCVuV0MK+KrcLWrEvUGvPj6jJfF1LjPNC8PUQWohIkscvX8lCWKKIhmqxsmc5eXdg7uOMmpYDgXS8mBD1CZ0c4Q9GHiEJngmG5FzCVv9xyXU2pmKNDzgMT5es0CwNOUG8sdx59IOW7VSGXKf6Nqeuc+TNRhQa9XUKqJ1zQWzFcGsCphTY9ZDUkivVKVeforsSRHf0/zoqHtzh2STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=745UOAP2+MF5mTpJd+RtAUIFrC55sdzVWckk4JLZS6o=;
 b=hslAqfpXWJDw7UL+3nsV3+4oaOJQlg9T34BUArQ1LncTSQdIl5jejli4o0MKWkaZUP5eWBSN4zHBEOwVl+PP3RoJ72OrHCfloUX/FxNrNnD74iD/0AGUMFLlEyXxhhPojBJ8YRjT8Kr+DO5+I3UDQJjnAU/LcViYiGxMcTOEJlAxx3BIjQNQwx+QaovcWRIInnPc3RdKPEzq++gOCZ0m4ZWYbJ5cAgV/3RLUpwiZlvE05VLsFHfFCjG+PMN82P614Pb7puFUR4hDtrHKHYaAXW7Op9fpnEA+zp6IhBiFih8XFUSxM1Cdspjq9xoyhOmXiLGahSot9ew9PC7splALhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6345.namprd11.prod.outlook.com (2603:10b6:208:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 19:48:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:48:23 +0000
Message-ID: <9b768de9-5404-4efb-be17-86dcef21dbd9@intel.com>
Date: Wed, 20 Nov 2024 11:48:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: stmmac: set initial EEE policy configuration
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Russell King <linux@armlinux.org.uk>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
	"Maxime Coquelin" <mcoquelin.stm32@gmail.com>, Oleksij Rempel
	<o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
References: <20241120083818.1079456-1-yong.liang.choong@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241120083818.1079456-1-yong.liang.choong@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfa1061-2def-427d-5205-08dd099c4b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHVnVEhaQllSQXRXd2QwbWx1aUVsekxBTitCMVVlcmMyRFJMeGtrNG5ZcVIw?=
 =?utf-8?B?K3RGdjZrRDBRbHdrK281bDQ0S3IyMlNRaFBFN3NwY2JxbEt1TjB2aTIvVWFn?=
 =?utf-8?B?bHJ6eCtieUhJL2JmYkF3T24xcjhnZncyQ3VrU0swVm91bjIxbXp1VUtTM2Zk?=
 =?utf-8?B?Qm0reDlkR3pMV21YaUZkc1A4N2F3LzBKQ2NBV1lYYXE5QU16M3hCZjZWbktp?=
 =?utf-8?B?dUtkUVkyWXBuOWVJcDlTL3F6NlVvaUQrWmVGYUhMSWhyb1hLbUZvMDgvOGpB?=
 =?utf-8?B?ZjZFS3VyaVZTWmJ6aGZXSTNURlVEQzJTci9GSkY3UmsrZXIrTG5XSm1jV3Fa?=
 =?utf-8?B?ZnViMDNCSWw4WGtyNU9tZkZ3RGdiUzNTYkgwVkdoMSszdnMxYjl2VnFtbHRs?=
 =?utf-8?B?NEw4NXpETzgxMDFxSzJ1MVFvQ3Q1ZnV3UG1vU3hNckY1cEdWRVYvdHk5WE91?=
 =?utf-8?B?TDRua1Z1TGxUY2lMbEExcHRUSmZPRVM3MUhTT0dLZHdZSURlMStvcG93eVhp?=
 =?utf-8?B?SVg0MC8vTkpYOU9VanM4alBEVGdEMXpBcklXd1JORndiRzE2WThRL2VlZ1hp?=
 =?utf-8?B?bXVYU21YRDlhOUZrY0dKbHYrNHhRcXFWMlM2VjJPRVlFMHdTOEloMEZ4NUty?=
 =?utf-8?B?b3liUjNobkd3OXpaWWUyeENLUHB1aXYwOWp3aVZmUUprOG9naW5JS3hEL3cy?=
 =?utf-8?B?NUlGaXdTRzlCQmNySkdKc1RpTjZ3ajN3c3RQU0U2TEkreGErVWZZU3hpQ1RR?=
 =?utf-8?B?Tmh6V2srNW1VdjVOMzJGR1BSQ2ZkNUcxOElDWk5NbFB1SlJDY1k0Vm5iTzdX?=
 =?utf-8?B?OWg0OGliQ3IwMWM3TVBjS1dYdVFMeGdYQWpOOW1McHcydnJ3QStQK1RSNmMy?=
 =?utf-8?B?bXFKU2JLRW43YXRTQmJWbnZUUUlESXhVdS91RTFGc3ZycGhvc2dlVXRLSS9V?=
 =?utf-8?B?NWVlUmVDdm1HTGxoVDNLT2xpTTVMeXRLL00zZWRoS3JRNlhUM1lwazdxT05U?=
 =?utf-8?B?MzBkeGxXZ0xwemU5TXg2YUkvbUFpM3J1K1M2QzhscWJLblNTV3JwQUNHOWo4?=
 =?utf-8?B?Yk15OWlqbms5REVZejZ2RUhUbGtlTzNTbnMramNNYzdVVTV5cGk5enVpVEdM?=
 =?utf-8?B?VmFjWEdLdDhhdmpTTmppR0dZc092T0lWZGk2eFhYQXo1MTh5NkNsaHhtKzhP?=
 =?utf-8?B?a1pKSmRLZlhZTkMrL2M1dzdVaGZLS3hWclA2ZWhtVnJydmY3NUtRY1dOYlJa?=
 =?utf-8?B?WlBVYllXM1VHWVBnL2d2VEFLbmI1QkQ3aC9ycmhwWjhMNkhiVkRhWWQrdVBE?=
 =?utf-8?B?WVJ2RUFCcHRFU1pqM1g2YlNYU3lFMHU1b0hzNmdkczVhK0lLcTVYUHdmeU05?=
 =?utf-8?B?bUxRY1owbWFob1FtV0JTRnpPb2hsQ3Q4V1VHSDg2UGRJV1V4KzZ4bGlPQm5k?=
 =?utf-8?B?UHpuT0EzSElwNEJSOTViN3p1Mjg0UHQyWXlBSGxvZXJlYkxLb2E4VmZjNlhV?=
 =?utf-8?B?RUI2WmZHYjdmUlEyTVNPbFhNaSswc1ZwQXRGTFBxTU5FQ1ZUUHNPRHBzN3M1?=
 =?utf-8?B?SE1qSnN2Z1I2NDR0eTAwVFJwbEtFMWI4NFo0T3BIa3drMDU0d0hWNnJyWXpM?=
 =?utf-8?B?dTJLNXl3enJKSE1ucVE1Tjc1RlFCUGJ0bzVOUjlyaktaUGJMWHhJL1R0NGVQ?=
 =?utf-8?B?Q0lzZzJNMjZhQ3VHVEduVWpySnVoNUZ0MXl1REJCbGo2cFlpYUxYZnczMXRa?=
 =?utf-8?B?UmtmT1NwUHhYRlRsSktqaXV3Rk9NeURnSHd6UXh5WU9NNk56OXlyUXNJZ3Zw?=
 =?utf-8?Q?oudfHVADaSXNw5s53XQ3jfjSKQOQ5O1kaecBI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V05xTFhIVm9KWnVWR2xkeDRHTVVpOXZNVmdWRnZGZlBiWDBPaVcvMFZDWWFF?=
 =?utf-8?B?ak90ZEErZmVJQXJtUmdOVmppVWh2RGV0b2dTbk5XMHV2cGYwNHVJdzF0ZTRV?=
 =?utf-8?B?ZktZSTlkUHFQc1orYm03M2piM1k3VlhENEVLK0FsNEhiMWQzaHZrendxdDJs?=
 =?utf-8?B?Rm5LeUxYZDBabFpRUUxaeEU2eE0vcnFjR1FDd0NhZDF6Q0dHM3JPMWJjUUcy?=
 =?utf-8?B?MVlTZG5sazRwMndjSmpyaXl4a0RHM1lFcmR1TGlCNCtWZ00vTTNKVkgrWUpB?=
 =?utf-8?B?Ty9BbGdQN3JqeGtad3VkejNDU3VUeisvVk9CUXZpU2JXSnJnOFF6ZEo1SHhL?=
 =?utf-8?B?NUJGbGlTSUdDNUR0bFowTkR3VEptK3pWcFRhV1JINFY1K1JqQm9YU21LNXJM?=
 =?utf-8?B?YS9iTnBLVjlqUXkwY0pSZWFBM1h4VElVSEl4Y2x1WC9UdUxMbU9FWlVMR1d0?=
 =?utf-8?B?VWlQN05YT1pjVE9IdHdUQTIyZDJXdzVQaWZwMTRqNnJMRTg5TTd0ckJoNVV4?=
 =?utf-8?B?Rk52T2xqL1JKSkIvWDVXTzh5VnNiSlJtb3lsRktJSTlES2xoT0ZBdlU0VWxW?=
 =?utf-8?B?aHNhWVgvSjBaNnNOb3pwb3BnQ3Uyd0RYQ2hlK2hZVmJnQThxNnRlcVJ6RnZG?=
 =?utf-8?B?cnBad1g4VHVLZ1k4aTNFa1hpcjZrenRsLzh5UjhDL0l5Z2d3cldTalhxNHJW?=
 =?utf-8?B?NWJhb0lRNWo4SWRZd2lqYWJTMVlrZG5QejFraVBlcFE2cVAyb3FGcG9HMzBi?=
 =?utf-8?B?MVBnVmRUNThrcmJNUzJIM3dhWTZkeHQxOFZHVkxVa0hhTW1PZ3c4a0NGUy9P?=
 =?utf-8?B?MWR3cWE3dHMySG4vTy9YMFRydCtRK2VxNGJJRHkzeWVtbVo0QW1VWU93Y2JZ?=
 =?utf-8?B?dVdlaTRDUXNUU0kxd3VDaXlFS3VGMU43L05nNzZxOHJrZW9PQUlvaVB0bTJZ?=
 =?utf-8?B?L1gvSG90dkg0VjV5VCtNbXVibEtUalFzSWxSdjl3S0o0aEhkUm5GazdraWhz?=
 =?utf-8?B?My9jd2NwYWRwNGFtQVpyOWFxeXpPMVYxeTRxUEs5Q3pSVnlsd2diYnl5V0VM?=
 =?utf-8?B?WVRMMjVNRkFqbzJVcmZzNFF4b3Q1L1BYRTBNZ0N0cGE3OWV2cHdjbzV0Z1Yv?=
 =?utf-8?B?Uyt5ZUloZzNaVTJWcUdrZXR1cE4wQXVZc1hMQTJFTnM0MFdBd3hSMVp6K0JK?=
 =?utf-8?B?RE5sY3Q2YldlQXhDZ0hqcWxxeXo3Z25TVkdSeWE0Nm9BcFl1cnJGZC9UQmM1?=
 =?utf-8?B?YURUWHNyS1RJNDhMN1U1d3JjS0Q5eThWZ1g5Y3hxLy9kMkJFUWNhb3Rtakc1?=
 =?utf-8?B?WU9vdGFVV3JqVzhYTjVkeUd3YlFham1scVdORDl0RkhYMktDaGMxN01iN3NR?=
 =?utf-8?B?NGkvZzl1cGRoRTJJUGdqeG1nZy9EOHhKZ0U3Q2xMNnZ1c3JiN05oSndjZEJz?=
 =?utf-8?B?UEw3TWh3bzNKUWVBL1NEZkpUOHNYS0dac3J0Q3JCWTNrTUMrakFkUFlmaW5E?=
 =?utf-8?B?dUliOGhKYThKWm9VSEl4T0NYL2E1VnZ1VUNpMFcvcVJEbVpsekhsdXNZeHgy?=
 =?utf-8?B?RzJPcEt0czVYUkhidkpUdHZhcVY3VjNUano4eVBzS1padXZISGZXc0FXVXNU?=
 =?utf-8?B?M2pDL2ppMUQ2K040MERvRUE4SHJsR1orNFZMdzU0aEpNQjJ2NTZITjBhQnZv?=
 =?utf-8?B?d1lpNTlnSXVveDJmOEZJejdxUllPVENKeXdEZHBBSzhGN0RBaWc0Yk03bXp4?=
 =?utf-8?B?cC82NWg2WjNoWWd6dE0rempRQUxDUWQwSm56L3FsZTYwajN2bkUyQTJFdlpX?=
 =?utf-8?B?UlhZU2tYalJiL3dOZEtoV1hBdDNnM1I3eG94MC9mRUE3Tm1sRHhpRHRNMlRl?=
 =?utf-8?B?RXMzc0JoNVVRY1dKaEhVLzkyWnBRSVhhM0UyOWZ1eFVSWTgzdVBMZE85Mldh?=
 =?utf-8?B?SnYzYmtzUjZFM1VaNlczUUVISmNnQUlVblI4NlNxei9yeTFxR0M0ZnFGUCtO?=
 =?utf-8?B?dlhvaHRlU3hnMURhMVBDcE9wOVNXTmNQaDFDc1NuNnJvUVN2c2xTMGdYU2lN?=
 =?utf-8?B?YUNweWZjY2RBYzBBOHFTNm9BcE84TmhWUDVtRHBub0NCV29ZSG9OR1pmOVds?=
 =?utf-8?B?RERxZndpR3ljcU9BcEplaDVQcThRWXY3UHRIOXJGZWtwWHJiVjJvK3BJcTQr?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfa1061-2def-427d-5205-08dd099c4b28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:48:23.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvBKpCEbccpcyqnkl+juEOnnAaAVlkQx1wAlABUxEBRlH/pZ+9QG5gAJgEjV2UApqkLfEr0JSsGabdlR69II9kDn0E6hrUSG/M1T9YqiEyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6345
X-OriginatorOrg: intel.com



On 11/20/2024 12:38 AM, Choong Yong Liang wrote:
> Set the initial eee_cfg values to have 'ethtool --show-eee ' display
> the initial EEE configuration.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7bf275f127c9..766213ee82c1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1205,6 +1205,9 @@ static int stmmac_init_phy(struct net_device *dev)
>  			return -ENODEV;
>  		}
>  
> +		if (priv->dma_cap.eee)
> +			phy_support_eee(phydev);
> +

Ok, so priv->dma_cap.eee is true, then this device supports EEE, and we
call phy_support_eee which will initialize the values indicating that we
support the feature for ethtool.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		ret = phylink_connect_phy(priv->phylink, phydev);
>  	} else {
>  		fwnode_handle_put(phy_fwnode);


