Return-Path: <netdev+bounces-180473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFF1A816AD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D26B1B87D24
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EBD2505AF;
	Tue,  8 Apr 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nH8gpGR5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7F254B10
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143184; cv=fail; b=l2ZvNTz4gO85C0L/PL8p1ge2LdRdn5v/baMnty3JZgTD/VBd50taFhzVkMWGBD5z2uu7y8Ae+imF2tq16hW9aR7nIJVt8XiFBRDiT5ypORZ9oe0VuNW58u52TCGwZE0pvMfmIJXjKzN3LIcWrlBlH9FTI6bW3qXhANyqoXNWr9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143184; c=relaxed/simple;
	bh=aMzOj12PNde/KPNS9qVhrJY6oQK1b/3ZBCz99YKojRI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqcxEtuRH5FP+luGbBGYaDesqz/2l//RWn6eR4ynlK7GDUk8UUL4xHW4/n/S7g5bMS7fDuDcAu5aZBGOZovHfPPvxuqwtRxhXczAICOB4bmvULaK5Yq4qLnbu/rfar2UwUhgyVhiDkH9UwByfaG6R7ZsstaQm2aRlPA1Usuon14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nH8gpGR5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744143182; x=1775679182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aMzOj12PNde/KPNS9qVhrJY6oQK1b/3ZBCz99YKojRI=;
  b=nH8gpGR542smgnK6ElGiKOM/HvgJ5g88x1qo8s+MPGcLZ6m5vg/U5+n2
   Q0XKF7+M/up3iv2WkXl5m5foXaRtUkBOf35+EaaLEHhY+GES7XTExL+AG
   o1kOUu084WGWYWNOZuZui5HaLq/hMY3Fr2v627ayLcSG2Fkfz+GxwX46t
   3bijpuTOPzdVzgPHJcyX9cknhKAwaUlfxJ1McHplxA5puku5YOnc9jw8e
   sCXi05suki0ga2jFYKYDt2StfMGwuK+zQYwD1v1sNTOfit+E2lHXdZ5Kv
   kvfnzC6wKNyZPM5EXFh8hEWDeakqGv5IcZFQFKi2BIyvPuoodjsHkCJHc
   Q==;
X-CSE-ConnectionGUID: kHV6uyeZTbSaXbqN6HR+6A==
X-CSE-MsgGUID: Rg9P7kSZShu7AKuVRX3jIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45759276"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45759276"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:13:01 -0700
X-CSE-ConnectionGUID: Zdz/8253T+Cf/gG1igQuEw==
X-CSE-MsgGUID: gYvI7u8cTHCmuenSIy8vJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="159355953"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 13:13:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 13:13:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 13:13:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 13:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1BGTuuQTARCyT82mc+4RATz+Fu7Bbly3SD7yV9M5w/QyYOfaqmXyRcRY7ka98OHx6r6dt98SJUIPcnvK8wBBkRnfxt+dNDB/Tp6QAmOREDByskjit8I9q00lEebA+G4f6orgc47NOH4bxHTZq5eIzh0KgIFGeYuyirLYg61IZaoHk3mPoFb2etnuKqUytmHQiVTY7HbFnpnY7q7Oaf3bTy2kwxafKYDWud3MFmJRIrcrPT4MDeUQs3YJtzPMOeDsT+/0nmIMfkQJlr9vQ2NNEiwytCXaesZDq6gpyajJNe5K5mhM6aw0kq2YOd9wgoa4mERj1sJmns//aVbn22iBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZBj1pu1Gbt9nmf3HPjL8Iajal0YtOWsZfn+N+DCOL0=;
 b=mupr2wXCvQ6ytWGRB+DVvswgEImqTIG2BGNuF+3QtGM3bxE5kC/9grV0j8U1mFAvuRGz9JLL3F5xaKHJ6UiIuczcGmheHHKjJ/wsJpcsZ+Ykh/uA8J1EKkwUmDxWUo24v15ZZldhtD4H7juS8PhmHyJyhpuckpo7teIH3R8UZL+HrxcarCbFoHJ+03Xiegp+s2zQ/gNVzRURjbMgCuiPRd/iBU0Pn1tK5AyEIuqJf7kciEtilLebQuf8ICLO9oxPJkJZuDw8cST7PBf0Yec2o3pphm/54NVe0K/9jzyS4Z16EDTFDERTd20Sgfcb5Fa0pNqvhEHKZzKksQ97Uztpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 20:12:57 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Tue, 8 Apr 2025
 20:12:56 +0000
Date: Tue, 8 Apr 2025 22:12:44 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: airoha: Add
 airoha_ppe_foe_flow_remove_entry_locked()
Message-ID: <Z/WDPBMIPSCkbg9e@localhost.localdomain>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-2-18777778e568@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-2-18777778e568@kernel.org>
X-ClientProxiedBy: ZR0P278CA0220.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::22) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SJ2PR11MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d60adb-5a22-4e01-c3e4-08dd76d9c088
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cDv9EOrzWb3uemdgK9mexO73XmhNDomo2jndB/rQGRuHVbMDD8GV0WccGlOl?=
 =?us-ascii?Q?Fdmi5jdzn0bW67R7seJlKfWanre1i6NdIwyxvoxBCL6P+wCExzig73An90K/?=
 =?us-ascii?Q?qXjdcKThYn82/TotExxCD/Rj8tjflf2Byd9cf97xooaLp2fWwLZXoNtD4DxZ?=
 =?us-ascii?Q?/rPtHgZDOFvHauN/nQupfInt0IqTBfiHYF6W3i5v4ym710F3u/tDixNNhnNz?=
 =?us-ascii?Q?oub6SwkLcO5mLg+wenDVorwYlr9v/0RSIqAmBnk+U3ba1+rlvsH6+a+zFlqw?=
 =?us-ascii?Q?ySJAo3p4y/55fLDiOnCv+U3pMYaajzfXZbBVwVnuhJQCYzD4b3+lll/ne5V4?=
 =?us-ascii?Q?LEPHcxJQpuvhLUTVG23pw2pAZN9R+kUyZec+d+SZ873BBu0EVPvfkdCROY4d?=
 =?us-ascii?Q?ie7i27M+VIs2VkOd5CxAOMFuB3tGox0h6TMMJfRqp2NfVQMT9DS7pTqzymEZ?=
 =?us-ascii?Q?HBHcl8ENAd3GMHZNj18PhQITYYaM9l2KvyBpRHT73deVFkIud81mZU7NEgaV?=
 =?us-ascii?Q?ySC81wKgr7HZx4yqu/ovTzP7+GsfJ/xOW36uJ4ODZKWUz2HyytvJpjs3Awl1?=
 =?us-ascii?Q?AHG0rbhueURIDCc0dHsgWUqJK+r4/sPh3jHh0cVU2zix9wZgUGuTAVFSlgbE?=
 =?us-ascii?Q?Yz2BW1NRI5JOj+CgOV+Ba8J/0W23rnt3I4KdxVfVfYB1r0sithC8N7zlrCP9?=
 =?us-ascii?Q?1FVXRI3zYHgZJZ5LcGTW3mT9uwVp/DWo5xD5H+plfBDV2mWP3i4L8rMb80rv?=
 =?us-ascii?Q?9oCL6NkLe40YWQ38SOWYGg0kOEURJiE6mme1RMw4dEbU1Uth4kFi2hh0GHN8?=
 =?us-ascii?Q?QYXf22wTVcFLJckPu0IUgjD9vm7VRy6T+UUpDASUzVxCfv8JKqnmeby44vB9?=
 =?us-ascii?Q?0guHXwbEW39pYZ90VQh2nhjRj3GDQhwxmBlvhdAz6jpHeCWoBFCaMnvM71DP?=
 =?us-ascii?Q?053CcfMqREj7Gx9vuPea6Jz0Sy31/yCAbcJcHRgMqUH2/EBmYRWEo5KRC3m2?=
 =?us-ascii?Q?Wsl6XXzzIg4dB4lajHvjqFRuByVRJZC+JjHyZw690IG5zNU1Rd3niHoSFdka?=
 =?us-ascii?Q?C3GABusIhPXC+kHiFB4xPsJsV8IlTtZIr87aZLjQ6AIMIVBJ2Kx5Hr5D1mNg?=
 =?us-ascii?Q?UX88neJYlboR1Aa3N2fg70btEEzwT+xVRZjpyh3JeW9X4XkiCSI7XI3Jls4u?=
 =?us-ascii?Q?4TcXYK7Mhlxdn+vZHvP7k2L5EbSOS5w9lK0Dj0uqOIoOjidlNAPgS6Tx8r4I?=
 =?us-ascii?Q?HkZnDuwyCoQG1KeqleWOZ49RbpXXGzhRWCjiQOlt2WRti9guZaMIGbaR0jHS?=
 =?us-ascii?Q?qzISJZ59wbgpJEtvfvf1u6IE2vQCZoMUBNTFvV1R2JwgX5/elu2cBirpiUpO?=
 =?us-ascii?Q?GWKDr6apG2KfE5Qb+HIV+HTuFvRi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTrexB8VCsAJKQkXedqJm103p2YBZCFgw4t6njk9x2zA5n9BIC5iklisMnft?=
 =?us-ascii?Q?wkDVxg6H74MOscZnFNmFBLsDSeDln7zrvW3fxFs/hzP2glehaIS3caIhOBJ1?=
 =?us-ascii?Q?Q5R/9dP+Z7yNTgLyMkmioHVmyzvxcxD9+unDtDihGzOuyB/A9kUkCWfEbdRy?=
 =?us-ascii?Q?WYkHuQneUogjWHSNXRTdifaiqUbpBwrTvCaXfoDIDenFq69EhXjpgFlOgedp?=
 =?us-ascii?Q?E2oE8SpBAXEQUh6hgWKIyedqVyGnlyWismV2wJ3U6Z22wyDaNjGnciEiIaqK?=
 =?us-ascii?Q?ZbTESU+Oewa75iyJRInsrB0Jh3NvbbcLdksEbby1awg1e3MR8YJPttb5GVd+?=
 =?us-ascii?Q?Wi31fx3gbqLV6rxmbPcNVIegRg80wqKfjuCnQ96YO/6Pi7bi1wDAFOsh5x4Z?=
 =?us-ascii?Q?5l7+hMPzPzS0J0xsuJcPO7Zxr+aTP/ib01U2brY02lF4NRhoGigEqnDHENYE?=
 =?us-ascii?Q?4y6DB5lQeITPX+u5DZWG6fdVO/Qq2cMm1Z2ZHt6Hmu71WnJMYIGjlL3B4xkn?=
 =?us-ascii?Q?Hm0Rc0cj5GBgjoV4gqb8D84mwqjAFyIHKiaxbAwiZnPY9J/qEGrlID6HNl/+?=
 =?us-ascii?Q?ivYvrbOQjDOMBA60PnynPl1jKYZ2Cub7pBREfihskePTbWMzfjmGTEWOn7zP?=
 =?us-ascii?Q?BjZdKZGcnMw64MGx+N5j6cDr/HVU10fDZRtwW8jZNXEevg0fKNZUwn0NqKk6?=
 =?us-ascii?Q?6zH43TaxGGTrjBpEur8ypobA6J1/X0iVf/yJp5ILpOnwBkJ6wEIr+UeQf1Nd?=
 =?us-ascii?Q?DNYxh0fE4bAg71UDXcO+ffFbbI9kYIVQ324V3NZDoUklHb+zWq3QifwEc6OR?=
 =?us-ascii?Q?7YLMWWiSt6q8MIAsfkIqrKXch44WS06iNLpQmD4Yi37On0OdewnVwzlcXNdZ?=
 =?us-ascii?Q?MpVBHoN3LrHixb1vfKoC0QAxT79dBtY16HdGRPFNxUGtnVVDgfdL2w/vIiJ6?=
 =?us-ascii?Q?40cdw/btILgiyji839WByvzH6vjsBVPxwtrlnbqenTLa4a4hGXVivpcIxCME?=
 =?us-ascii?Q?xaUrEwbkGMU9/b6NZWJQv8DNM51faYk4ZogPdZbCn338excqH+3OhdDl2R3n?=
 =?us-ascii?Q?7RrvRrKg5EOUsHv4lIAFiIERQieecGXtDYso8BTgP45/G2rDST3WomzyGAdo?=
 =?us-ascii?Q?Gxm3PQuuBrQW/pbsGYDhQQASoDZcuO24eMCvaE/7dXIyagHAGRUoYWF+l1GY?=
 =?us-ascii?Q?v6721m/kQdOCl2zhJ6c3YdxFs2EtO0oudQUt4tWnZF7i3ih2SB6pQTaH65/j?=
 =?us-ascii?Q?i1tu6q9KX2Bb9mTXHmjy5dyjpedwSLSLp+w3u6uF60c9bAJiRqjEnPEdppCT?=
 =?us-ascii?Q?JvVKmewRdyLeUutRlc7HCKT1x2RmHA3nrf56DU7okhi+Tyx90WU+wsw7lzZi?=
 =?us-ascii?Q?e0JgnKzrYsiKL/R9LtKNskHx3R+DbBgyydv5VNJAMlERu/FInfldXgkNh98W?=
 =?us-ascii?Q?5ZFDcLShjUdesciSn83iKhyr4Jn64CEi/6EqP1nAqTVfvKdJI0wuvzVboWVh?=
 =?us-ascii?Q?5cTYciObqenwTo3i4KHcTXry2FLDME7+9aC5ZXj8OXyQ+s7duM8AkE707dQe?=
 =?us-ascii?Q?0zLcy2Z3sGaIc0k/sFDyDuRngbGsaxI6AfDp/SWdYIyoPxrJN2VXouJ6gENc?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d60adb-5a22-4e01-c3e4-08dd76d9c088
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 20:12:56.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXBto02aK9cb0DqXmdVwatChLCOD3u2Nh+DL1I0sy1F0S/icFMu4mzoe3y4yXFCBJ1IuaafoiEKGo1B8JYKbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-OriginatorOrg: intel.com

On Mon, Apr 07, 2025 at 04:18:31PM +0200, Lorenzo Bianconi wrote:
> Introduce airoha_ppe_foe_flow_remove_entry_locked utility routine
> in order to run airoha_ppe_foe_flow_remove_entry holding ppe_lock.
> This is a preliminary patch to L2 offloading support to airoha_eth
> driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Could you please explain the reason of introducing the *_remove_entry_locked
function if "airoha_ppe_foe_flow_remove_entry()" is still never called out of
"airoha_ppe_foe_flow_remove_entry_locked()" context (at least in this
series)?
I would expect that it can be useful if you have an use case when you want
to call "airoha_ppe_foe_flow_remove_entry()" from another function that
has already taken the lock, but I haven't found such a context.

Thanks,
Michal


