Return-Path: <netdev+bounces-152212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA59F31A1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362F016875B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA4204C16;
	Mon, 16 Dec 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6/LdGbj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725452054F3;
	Mon, 16 Dec 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356167; cv=fail; b=Rgopo2hQvMKvInIZtD1c+kbWPisnFnwlq/sFgugDsETNgordBALprhWCaB96gYFtnyzk4rGfXPrhLiNmXXjb/MACrreafvwHpLY7VgqU+0S+stG4uuzW88zy2YowsBQVWKAQDh5f3aLThu5lmTkS5AFzL5+x9kFBrKK8t0+2Kic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356167; c=relaxed/simple;
	bh=Ge8KNlkLoYf5HONWi8vdBoh/mbZ4shSSD4oVSP7klV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uFNu/I0cBJCV+oNhjclZv59S0fS/hUARd3rYhT2kWWZvaRHVzyBAOVss29ARER8mpmV7W3fZORmznVjnwjkBvMdlz52ZTABWCGoB7Q4zdW5KxwB+zl+z7tmfY0q/9C+XR9EtG11NfN7mjw09SfKBcFTJLxYbGQrzFqTpSjKwvHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6/LdGbj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734356166; x=1765892166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ge8KNlkLoYf5HONWi8vdBoh/mbZ4shSSD4oVSP7klV0=;
  b=b6/LdGbjhKrnR2yB4kWLM0SZ2gZrI5mCWU0l2cfTLTNMr78jzh7fQBcj
   Z2Xz87w42Qbzkg89PIROVwjdOJ7SALT3bPcRQMfWQSrSQ7NFHIC/uus3n
   +PrRsmnkhjC6wFzFdjt+ikURuqoQ95+8J0vEmDvmMBRRxb+88+oQ4t4Df
   5YMmjq8oFil6jbpILlmqSER3zxIr+Y6H7FywrAXTKc0sSFm1qnfikct0q
   z9Mvyx+12GaVGlJ+H3PbpheEfLv5EbQ8sQ991sltyrQGSNquMfPqOf/fL
   0kGazh559Oi4mW2CTDGGzz3zZ4NJuumUoHHpROABTirLXVQTCtMAveZmt
   Q==;
X-CSE-ConnectionGUID: P9X6RhmrRt+THs3oXihOuA==
X-CSE-MsgGUID: QyTfHBfIQr2rHGOGnSZPbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="45432430"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="45432430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:36:04 -0800
X-CSE-ConnectionGUID: csEknJI9T8uXKXlKKny+3Q==
X-CSE-MsgGUID: gZNcAvO0RQiPpxYyBMoTPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101345357"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 05:36:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 05:36:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 05:36:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 05:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuVsQK6i0h/fJ8vFALExWKt095wAmyw3kdMp567H3v/1l4w5ad3zIiwTiqRykWJOIy2+rTc1cIpoDruBTSl78iFxFXYUPJcPmgI10bgL2XJ91homiM9NplexwF/8mJ74qGpDxERcX8Qof6L6x+uPNLyn6FZxe+HbWMUIlCAdfbKCzUsZZhykvp1EU30MoYps6N5bkPr57rg7pz8mTau1R0MOx4FxIRCR4/RAhnTqng0Fn6QuL82vX71RABrt8aAWk9KnYXJiykrEwlshfKtXrLC8/pABWcACu/vOby4BhZCY/9aQ5TB7zaAdIMX1IJ4BSiPV4VBjiYmMzS9sS9LV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bZO0bzwgQBWlD4UhEUIZVIaw9RrUe5qh6P/eXNWoiY=;
 b=iLK4F7pjLcwNMiY3ZcbFVHDQZFFdFolT2Bww4sIL+1mmeQpCNpZ/OHRwgLqoc4OBXxYfwVPTCKeso7gChF+lt6AtQ9Dqxly7KXbMZKwh5gnUBnxyEHuBJzHuLFNxfRdGN4z1wPr5ODF5qYVBeNd6dFYU2NJbYqxv9xgOqAU2AfO2vHdNu96by4h1cPUldEwtKK1loi4rX8+buhXUBqGMBnnkzJxFvC2DvjC7L4fxahXouL0sAFuRO49OQfF582NcuZWHPSR7X58IA810p3g8QO6HFiskKPm24c0nglWSA3Nz1G7+aHXko+lSbv1oxKXxyjtaJLrzAgPmLasOTDA4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 13:36:00 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:36:00 +0000
Message-ID: <c3926eff-513d-4c43-9074-696495caa3f4@intel.com>
Date: Mon, 16 Dec 2024 14:35:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/6] net: usb: lan78xx: Add error handling to
 lan78xx_get_regs
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Phil Elwell <phil@raspberrypi.org>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
 <20241216120941.1690908-2-o.rempel@pengutronix.de>
 <c7ddac7d-debc-44eb-9c43-7746ad3edb55@intel.com>
 <Z2Ao8r3gJRnQLq_I@pengutronix.de>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <Z2Ao8r3gJRnQLq_I@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To BN9PR11MB5402.namprd11.prod.outlook.com
 (2603:10b6:408:11b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: d4414673-092d-4c65-83da-08dd1dd68bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHNkaTBKQnI3c0hBOU84THp4RW5yS3VDekxVb0pEbjYva1grejV4U05DY0lL?=
 =?utf-8?B?UGJ6ZVhTUDVSK0IrNUZmV3dYL1FjOVcwQkdQaGozZ2E5M1NvSDZUeEljeG1T?=
 =?utf-8?B?cCt6Q2kwRWRnbngwdFNaVllKc1U5SC80amlCZnYyYTZPMis4bDFBZUNZVnpZ?=
 =?utf-8?B?RnBaaU51MVZWMHVCcndPZ0VGZ3MvQmlqMmpuaEtkWVE1SnV2L1FaVEhqR2ph?=
 =?utf-8?B?SHR1aFlWYXBRdE45UXV4dm1hMjJxMXNxUUo3cm9CaXVKakZQYkxXN2lNcG01?=
 =?utf-8?B?b0JFamxsZlFpMGxGSkcrY1QwM3pJUnFnWU5VeUlLUEFIOVMvL3NUSDE4WWs0?=
 =?utf-8?B?RGxLMHE4MkhoZm1BVFBBSm9qSXlMQ3M5cXQ3ait2c0ttNU5NVlRBU3M2ZnJ2?=
 =?utf-8?B?NDE0aHFqcW5sTGtLbkVLaktNQzRHVk5vN1dqZnNmSGl5V2p4eEVLdjB0c21S?=
 =?utf-8?B?VXUxV1Y5VEpMUmUrZUlYT3dOaW5IbWV5T09YdG1qdEJRQllFWUdiZG83bmpL?=
 =?utf-8?B?dVB6QXRqVlpueDBwaXZtQVFyY3NnWEVwK0JCRVNxcjdaaUZlKzBpRVMvSUJ2?=
 =?utf-8?B?bkpiR2FXWC9KRys2TUV0R2lwM0FObkgxa1E1OTIvRmw2RFlyR202UFlQSFZS?=
 =?utf-8?B?RXoxS2wyTXllU1l4M21LRFV0eGo1VHBnZDVwWVM2NlJZaXBGTi81dE42T3JS?=
 =?utf-8?B?UHJwdWxjczVYZXUzeElOWXFOL2lFVHJ3RGdOYmluMEQxY21oL2ZlUE9EcEF0?=
 =?utf-8?B?cjUvZzJiYVFzWjhWSWFsb1FKVjAvajhQcmZ5SzJiaHNueHJTUVcvU2d2WmM2?=
 =?utf-8?B?Y0tWVW5HWUpRTXFrN3dFOXZaSDkyV3BFNjRyM3hvNGdFSUtlSFlLaHB6cG13?=
 =?utf-8?B?V1pja1BObVN5YmJUejZ4Z0doTmN6UUlGRU8vdmlxZlhCRXFOZXpTU1gyRCsz?=
 =?utf-8?B?eHhwSFp2U2N1eG56ZXFHVXdGTGYwYjVVdVdCYWp4ZE43bHRRZ2xJclZ0Smxl?=
 =?utf-8?B?ODNlNzNDd0lMbnE3SGxWbDFnZUZINUUzL1RsMVUwSlRCZGFwWnNlMk5RcHlH?=
 =?utf-8?B?UFBMNlV0TTMvajNEU2QxdUJtWVpQYVgxZFNhekRZVnpMcXlJaWVENThGRlpx?=
 =?utf-8?B?bXFNa3o4K2hTNlREL3hjQytVR25saXQwYnFWYVhzNmJISjlVaFBGV0RveEJv?=
 =?utf-8?B?SnhNU3g5WG9oYkNPbE03RnVvZ1lnaDBpWmxSZFZGT3Z4TmxjbUZXR0VrTTVZ?=
 =?utf-8?B?NEgzNC8zOW9WeHBUTE40YUt4OC81Q05hanluUk9GK0ZFdHQrTVJiNlA0QnJm?=
 =?utf-8?B?OFBNNjRRemx5SHBaMlZUYzMwVXVGYnRiMnIrTU8vQm9oMVhBbVpIemoxc2do?=
 =?utf-8?B?REUxS3Awb0xRVVFrc3M4UWt2M3FxNWNwQnNGMzJNN1JKQkRLeURFM0h2Unlw?=
 =?utf-8?B?N1NUY2hZV2taWC9DckJUUVBDSTI2UjlrUnJ6cUJ3KzM3eWdHQi91c00veGJx?=
 =?utf-8?B?aWtIMG54WTRERE03QmhZOEhTUFFUc1dDTDh1NGpyalFhSDdRajZZUHBWS204?=
 =?utf-8?B?M1F5V1B6bU9TN0ZMRkNzRGFLbHFSV3paaUVZMzA0bm05bytTNkw4VDBORllG?=
 =?utf-8?B?UWk4ekNHZS90dHlsY2Y0d056aFo5MWVxSi96WStFeFQxWVpiVDFJZ3ZleHVH?=
 =?utf-8?B?K2ZKWXNZSFljcTY1TmhPZ1JwN2dEdlRmd09oU20vRkJpZ3hGb1lJU2MrMGQ3?=
 =?utf-8?B?RW1MTGcreGZua0gzNTRoRFVCVDZFOW5sMjdHU3VXVTc2cW4zOTJKR2tvOXVU?=
 =?utf-8?B?K2dKbVM1VGZSWGR5Z3NFZHN6cEh6ZjRZNmZVUzF4aFU2cVNsSXRwVWVwNExt?=
 =?utf-8?Q?FS6YVHYP2XWJE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRJRlB4VkdVVkF2UlBJRGxVZ3BJb3FneFhSejdDR0cwQlVrbzk3RzREUWZ1?=
 =?utf-8?B?UEFBZ0xaYy84TURpcTFxYUd4MmFaUmxOaS9tbHNReHZhOENpcHVkS0NOOGht?=
 =?utf-8?B?RzR4cW93VXFhaEJiakhETytsczRjS1hZZU1WMklIMXVJbkw2K2xONmlJMHgv?=
 =?utf-8?B?V3BtcnU0eHBUMzc4aTBzL2ZwbnUraDZJRXM2MHVzTkZEUDBhL3V0T0loeE14?=
 =?utf-8?B?MXMvUEgvbk9LRFI0TVYyTlpISlpkWDh6cG1hVTJEV2xOcHhELzRWRm0xUVVO?=
 =?utf-8?B?ZE56ODhzYXRIVVFTSHpRVkI1TXN2cmc1a2s0U3p2bDVMN0FFSkZyVHNMWGpT?=
 =?utf-8?B?QjBGQ2lPQTBSajBZZXMvOEswM0RnVU5XMDdDa09oelJVYXhyWXpJWStPeEZv?=
 =?utf-8?B?aDd5NitsRkw1aTQ5Q0UrZVFvZmtqT0RYNnNmUWxsSEI3Q2Z1SDRsY3RCRmhz?=
 =?utf-8?B?ZTcxamJ3eTZLN1ErUmpSZWRJTWJkbm5MWFZjN3ZibG1EcGMwRkptSGI0eHMy?=
 =?utf-8?B?VUF4K3piZjZ5T2UyZG1Eb25ZUnY3Rysxd2Q5OG5oVkdJcGVMc2N0SWVFdW5I?=
 =?utf-8?B?RmdmclNobStCSGNQMm9OMWxmT2dUTlR6a0hnOHUwcUEwV0cxQ3d3V21DZHRO?=
 =?utf-8?B?UkFNc05yYTUzTm9tQzBGYmMwams5bDErZmN4QTg1UXhXcXBwY1h0ckFGZjhi?=
 =?utf-8?B?Y2xkYVlsWFN6dVY0Uzl4THdPS3MwOGYvZ0JBMmNGTlpWV1gxNDl0aXVpNlU3?=
 =?utf-8?B?WmZFNnpxQzlrMEg0ZklWbXl3UFArNFVkc24rdGxpNGxRbnNEdnRHQ3lQbzVp?=
 =?utf-8?B?dnhZa0ZXUndXdWRZN1JmRGtEbUtpUGVhUTZtdlZQOXNkTGN6S0RvbCtOUlVH?=
 =?utf-8?B?TS81U3MyTExSUjgxMjQ1SjlrTzdkTFYwTHdjVVQwK2ZrRVZ5akxhUXpvVUJy?=
 =?utf-8?B?bHBVbmpHdzNtUVQ3aFVuNEVmVDNhbWVCN3RscXowbHIzMUdiOG50SVhxVVBL?=
 =?utf-8?B?SVVPdkQvSGYzaTBFWHRmVktyNmRtNkI0eUV4WkZhOGpHMDVGdGFwNklCV2xn?=
 =?utf-8?B?RldGTVdjWUxrZkhIZXhteVBYRHk2b2k4bWFxNGJ1RGpaZ3d2V2dIeFBtS0J3?=
 =?utf-8?B?OUtmaXlHQVZwNk9uR3pweXdURkY2SUowMGRyUnpvSGx0Sk52TUEyZUVWYkFN?=
 =?utf-8?B?Q0JObGNUSHRyUWZYT2p6ODNyWEIyQWdUOWNMR0pHSGtmTlJMR1E3ZGFOUStD?=
 =?utf-8?B?eE0yUU16MnM1bVZ6aDJsR1JKZ1dDL0dkS1lWU1pNcEhrc0pyWlZEK0htN2h6?=
 =?utf-8?B?T1IzSituZWs2WVBYNXlLNTlyNzJGejR2RVV6SWZhTnhNdjJEbG05c0R2YUdR?=
 =?utf-8?B?YWVDZVFPNU52ZGtJNktSTWtRMDd0SXgvNHZqczh3MlFaTStCM0JaVStPNEtq?=
 =?utf-8?B?QUw5MWJTa1lZakVpTGlWMHJDdmI1dXllWlVMN04yYmtTRnJ4eEUxM3l3OXFH?=
 =?utf-8?B?d1lpeThPZW5WRVB1b2FwNVFnMGk3emxtRHpGT1IxNVNEWW1sY1NPb3doVS9a?=
 =?utf-8?B?aU5lUXZka0ZlcjhGRVBvdVJYazYxbDVTYWx5MjUyOTZGS1d6ZWxzNXVEVlls?=
 =?utf-8?B?SXlaYnVWbGlSaEp6WndJb1JURUZydG02RG5pVzFPZTl0T2pSdmFKRW5CTmZp?=
 =?utf-8?B?bVpIK0JIYm9RLzM2dU5pakg4Q2hHbnMxUVl0MEZudDhVYkMwbTl5dTg4cFk4?=
 =?utf-8?B?cWhMK0hTZGVMQWdFWUYveENtOXBBd0M2cFlMWVI1MVRMUmNGd0c5NVFFZSt0?=
 =?utf-8?B?VnA5amZjYWxuYmYwUnVwajZrUEUyTUh4c0tLbXpCYmQzYk9aTWJodjFKMG15?=
 =?utf-8?B?MnBRdlNTRk5keEgwQUJVNXZtNHd2SnljSmFvRThEbGlVR3dQQmxRSktWbm1k?=
 =?utf-8?B?UmtOQVN4RXhHMjd2RjdTUUI5T3J4VVpGNWl0Yis1OTJiM0N1V2xvN3RCRHR0?=
 =?utf-8?B?QzhIZVZKS0YyYUlHdS8xYnR2cyt2L09UUUJBZVdJS3BjdUh0dWVPSXFmOUxh?=
 =?utf-8?B?N3A1cFBHWHIvczcxQVFIdTVVMWxyaUJNa3pHTmNhd2NWZmJZdWIyRFEzMEZV?=
 =?utf-8?B?bmxUMklYNUlXN3JRYW90ODlDUmIyMjJjZ080eWpISHd0OEdFc01EUFBkVHdJ?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4414673-092d-4c65-83da-08dd1dd68bdb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5402.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:36:00.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgPUk+oicbK2MJCzBGaPmUyqNvg8P3Sj8myJOHsSBcEiW6okit4UXhlXqGQxnQ4obzKWWZkAiDf4R/GwlFWYMWx49BB3hqNomDNja8P5BYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com



On 12/16/2024 2:19 PM, Oleksij Rempel wrote:
> On Mon, Dec 16, 2024 at 02:07:37PM +0100, Mateusz Polchlopek wrote:
>>
>>
>> On 12/16/2024 1:09 PM, Oleksij Rempel wrote:
>>>    	if (!netdev->phydev)
>>>    		return;
>>>    	/* Read PHY registers */
>>> -	for (j = 0; j < 32; i++, j++)
>>> -		data[i] = phy_read(netdev->phydev, j);
>>> +	for (j = 0; j < 32; i++, j++) {
>>
>> Maybe during this refactor is it worth to add some #define with
>> number of registers to be read?
> 
> I prefer to remove this part. Please see patch 5
> 

Ach, now I see that. So please forget about my comment

