Return-Path: <netdev+bounces-210041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8073B11EE7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A91881C45
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C932EBDE4;
	Fri, 25 Jul 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGaonOuv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8F2EBDC9;
	Fri, 25 Jul 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447343; cv=fail; b=lvJCmbzEr3mYkNaScGdopKS/TjVpTGJH2v2/e6LzwLmIDHvlXcQkRsByJLV/wPsJu9wQ01i7xk+fDTqfZqbLVy2IY5urq6SxOHsgSfvVluC1J/xc8sgtIszsMCp9kyNDqfOGKsltPG1t1vN1ze52f3bsYeO6luDW7Tgu2HXN3OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447343; c=relaxed/simple;
	bh=9YVEIcy17NjC0yUt37PAndXk7TIp0BuPPzUQnR9kFxc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RhndtLqo4PfyyxE+J1A+apJrB6FbmbgcPw9g1NB8JstFNSxqVW/NV0zYjBjucroZwwId8JOAQUFkd2A6WWUHII+trs/unkfOPhYAb+0/Hmfo57IjvoDZKfVMjnc8Whrcl5m00JpPBRzDPYyW4APLvexk7js++OOPhW3g9+p+4N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGaonOuv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753447341; x=1784983341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9YVEIcy17NjC0yUt37PAndXk7TIp0BuPPzUQnR9kFxc=;
  b=bGaonOuvM8HbvHuJdMNVL5mMnXpA8G6z1GR3KMSl4Lm1XF1Okhi74C9V
   bE3ofPc9zE2QX32miKMe2hISx4LURdwIgkqx3ccVjYWKtBCXzkIY08G22
   y5cNgMoRPhbdyr26MWbthwN9PLxe3CpuKEEXHglKrPWyLIWa4WISghz7A
   j2jHOFgEeZCmv4DJ/KOb6sDP6Ub3s25ci+JZZ1B90Av/FGIOJxqTKAAC2
   9qSgo8vLdJ/F7So9846Lpm/P7BHqzHRTNGh63OP8YS7xStqHTz0kaNsMh
   01b7BxF/eEYOA2j2qPy+aDGHP+9UsQvBcK9ovZSedEImciU4uH9UyakoD
   A==;
X-CSE-ConnectionGUID: qUHQKq1pS1GnGAA7QuP6ug==
X-CSE-MsgGUID: M2zjneXpQCC/kbccISYsZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66479749"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66479749"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:42:20 -0700
X-CSE-ConnectionGUID: 8a5UVqq2TxaQdyI/MZQcYg==
X-CSE-MsgGUID: urRvzqZzSv+u49h1dY80WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161150023"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 05:42:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 05:42:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 05:42:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 05:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMLGsEY32LgtFIjT832DjXGuUYuVd73NBLM+EwgSI/o9O6LcNEkwykXIOCAWdhIryoExjLKRjunIbTWc6PM5AWP9JkMdmzxPxHAlI9p1a+8DGWhBkDQoxQlgyt1v0UYiHvR3fk8bKW0QL32Eo70wKwkC/jiMZn610U50LqcJf1XjclURQmxP14nQuPb/0VyCE6Jbtl42JECXBteDeu6pm+1rBmkCc4wvgOZWJqNc+Jd3WfN6IocfnoLliGZilWGGinlUcezRKEusTXOnSFqUpAbH0E3VItxkHkT63WHaYYCEBv8otKhRCBjxl8livSpcs/L6FbS5hi+IWuEeyleU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmqaNgKDzDYGjTB2DZLrlCx11tHiMIq5oKLzTtHSPl4=;
 b=NHfdq5zW4gGPGPLw7TiylH4Elhoyl1eIPTg1Wx4H7GF77uXFHq/q1wEcONpefov8KjksSDKTqyQEDHgEpgW4CES3Swp3OCwQfSeva8XzOrgHe25dZrpfmy6zlzNGQcj2FWw6E4ydc51Kfu8w++TyjHohg4O/PVJIlxUQ80AyQdWHDatWKbUSz/b/u/RiWLoYy6lbW61EEYmyxUL3MP1sb+X+e/+KIy9TqXP1txPIDsUCxOw+TWo///FPxYnGpZpiyrZIojt80wUvx8PTHdvkDDx9Dnf+8TtRwQEPOLsQs+wldIpRiSaMGV2iAPmArQDbZ8Vfka9yU2j37M+FPjL2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 12:42:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 12:42:18 +0000
Message-ID: <46fd972c-14d9-4876-8df5-1212f6530971@intel.com>
Date: Fri, 25 Jul 2025 14:42:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>
CC: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>, "Michal
 Ostrowski" <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250716081441.93088-1-nbd@nbd.name>
 <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
 <0861d960-d1e7-4b51-b320-c2e033b49f12@nbd.name>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <0861d960-d1e7-4b51-b320-c2e033b49f12@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: eb041e6a-a066-4658-73ee-08ddcb78b0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUpwTWNFMnQvUmVzdGlrT2o1bWRlTmRpeGZhb0x1WC9UQmFBWUdFOTJWdFkv?=
 =?utf-8?B?U04zT3BKL3lNSEpDRTlaeVdDZ2JESnNybXZjK2x2bVZGcDBzbVJLQ1ZMY3V6?=
 =?utf-8?B?dlRNdm51ZUc5Rzl5YjNiRUw3aVhtbVQ5VjAvUkNwZUtHMzRSODM2L2Z3a1ls?=
 =?utf-8?B?UHo0VmVvZDlrdnlsZ2x0NHVKMmJUT3ZtS2JWZXYvalMyd3NwRE1kcUsxWkgy?=
 =?utf-8?B?dW94YTUwQ2E1VlJlVlc3bUZTdy9PZ2IxY0dpODZxMFk3M3g2QkN5SGNTQ1dm?=
 =?utf-8?B?Sm95V0habmx1V0YxSlAxYjByQXRLV2ZmM2UwcXJvZ1JLbmtwOXNxem0rTGJK?=
 =?utf-8?B?dllKa2FZcDAyUmwrcFVhLzdDQjlheSs2UFJxVG9FcFVSSVRUbWJlRk5zM3hy?=
 =?utf-8?B?YjNtM2lwVXlacG9WNXVZU3lXcUswckVqUlhkRksvMW5uaDlMbSs5Tk5UZ0FY?=
 =?utf-8?B?UXR2SlBXV2NkVUpYcGM1SU1uV1UrVEh6L2tjV3VUR2gwWVl6T1pyeDZTZWpY?=
 =?utf-8?B?bDB0YnNVZ2p1d1hPOUcvaDZzalZZeEZScjFkL1l2M0dZVXZsVS9UaWYxd1N1?=
 =?utf-8?B?b3piWC81RVJscWhEcUNwaUxyc0pid0NOYzFMRFF2dHg5bnZHbFBjbTRpMUZN?=
 =?utf-8?B?NktxMFhwdkkybDdZSVVnR01SUXlOOGNGeGkvMjdiRGgvMnJUUTVjajF5clVk?=
 =?utf-8?B?U3Q4c2JjeTR5dFhZR1BWdWNTVGI2TGxPUlZlYVIrRlRod1JNTktWdzVtZ0VX?=
 =?utf-8?B?QUtBanFFd0hBWDFDTkRvNTRwYUE1NEFpbkc4Wk9wSDNBd0R1WDhDRndvdXlx?=
 =?utf-8?B?ZU93TGRPZklwVXc3dVlKZWc4WVVIUVlNeStjK3dSVFNtWGZjYTBZSGNhdDJB?=
 =?utf-8?B?Z3paK0l6V1p4MWFWWG9EUWJpMGJjOWJ2TGlHNEpWdm1Wb0VJcUQvUE5sdEZy?=
 =?utf-8?B?ZWFKVHBYRjVCSzJQM2ZLZ21teTJRMG1MdVJQZVNvWDZLMkU2dWxrVGs2OVlD?=
 =?utf-8?B?bEVIcWFxVHhhbmYzY0ErRkZ4b29XZUhzOG1oMk52WEFWbDh4ZnMvaWEwQlZW?=
 =?utf-8?B?STBjeUQ1cG1iTHR2K2FON09TZDkvaW4rQ0IwR21hb1RJeEdQbjk1VHlPV1d5?=
 =?utf-8?B?dHA3cXoybytGdmJHWms5bkRHT2VjcW5xV0YzaENvdTEyYllhUU1ZU0Z3Y3lC?=
 =?utf-8?B?NFVaam9DSTZVT3lsNVY4OGl0NG9KTlp6MHI5eWVnMGFraHY3NG8wM2NEOUFi?=
 =?utf-8?B?RVJ1RGpURHg1NlVtTWZzZ29QYkpuaEpvUFowR3htR2pxOStCVG1RRnEwanRl?=
 =?utf-8?B?bVY5R2JzYmsxYWc5TEE4MTRUd011NVVJMVlsSWlJaDNjRE5MYmxyVmVaUm42?=
 =?utf-8?B?bWxGVG14NDF3UTdLTEFzWi9MaUErR0NiRURESkpFdm9HeDh0U3lhL1I0dnN3?=
 =?utf-8?B?Y2djS3p4WklmL01MUlJTUkZnWE81ajBsQVd2TUc5QXBsdzQ2WFIzeFR2aTNL?=
 =?utf-8?B?M1lXa2hmcHJONml6QitGUmpycFhVYjRiOW9nb0NJYmQyTFVZVE5meldPOGhN?=
 =?utf-8?B?N2ZyZ2oyRnJVa0FvZysvZVh4bmQ4Mk9VdjA3UDhHQmxKZFJ6VkNnL21YeE51?=
 =?utf-8?B?RzNvSkZZdUZxOGIzZkhESE04YTgyM2hRK05icDh6b2VyUkhVcmthdjlJTjUw?=
 =?utf-8?B?S1U2Z3BSTlBKL212NFNLdDNvejhZd0NDYnNsRDJPL3JjbkRWdkdTaW9RY0F5?=
 =?utf-8?B?NjF1eHhPYVVwZkxVVnlJUFdmTmdCa3ZpU1dMRGJiTG5wMGxlUlFudGxMZVp2?=
 =?utf-8?B?Mkc2TGNTWVlydW9xcXBVa3NSUzJwL0FHQmRXWVdzdkRzVlV4cnZ3N0trZzg1?=
 =?utf-8?B?OHFvdTNuU0h5YkR1K3ZjTUV6ZHdMb2JxZkVDRmRFZHkxTkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdiYU53M2F6OTRXWEdSZWxUNGhIYzlxMERvbkdHVWhFK0t1Wkp1V3hNSEx3?=
 =?utf-8?B?bTVFTjVLYjhKLzBjUUNYNlB6N1RlaGNGYWIvL2hSeDcvRFBDWmhQMDYzL2px?=
 =?utf-8?B?SkQvZlRPRWYxb1dDdFppNFZmZndGMm83ODdZTjRrV2VKLzF0Qyt4M3hIK0Ni?=
 =?utf-8?B?QS80UEFzTXc1Y2ZEbEFhc3BjaDA0YjZTV3pJZk14SnZmR1NlcGlrSlJNL25Q?=
 =?utf-8?B?SERYQkloQVNlVklsV2VXU2ZaYWFYQVFZcUViR0lqUXlyMVVoMy85SDlPa20w?=
 =?utf-8?B?VzNyRTV2TVh5RzFQN0ZteXo5M1BUZ3liMTNOTk1rLzlUdjJPNXVSRHBQOTZp?=
 =?utf-8?B?Wm5qa0h1b1NUQ1BlV0ZuMWE0dlRZK0h3NlFic1hCTkUyaWxrd2hpbXZwUjhK?=
 =?utf-8?B?L2hTQU54cDU1Wm1DSStOTUJTNzAxdDJ2WnpFLy8xajkzb1ZZMGxENXk1YXEz?=
 =?utf-8?B?QmVvOVBITUQva25VNllwRkUxVXR1aGs4anM0dFN4bzRvU2dCNlFzeldZNDZG?=
 =?utf-8?B?MmJPdGJ0aWVlM3lJTXhZdFNkd2c5L0NTQnN6TDFXVzZxOXlpMG9yV2hmNHN6?=
 =?utf-8?B?ZDljVHgyUzdRdXJCUDVaeUNvdzV1YUpZOTN5UytzY0NSRkJTbDhYU1dvdWJH?=
 =?utf-8?B?V3h6UXlsYUF3WXRDdXlvaHBOMHRaR0hzMTFKTk5NY3RSRW9SOUk0QTdXNnB1?=
 =?utf-8?B?bEpsekNKL2N1MG12RG5pRlJNM1FFRE1Fb2YrOG1lUURabUtCSWZYdDVmSVFw?=
 =?utf-8?B?dUdxbVpsT1NDUHpRTjYxWGFwWStGYk9lN2FyeFZGWWxFa05TVXNwRTZtRTQy?=
 =?utf-8?B?ejcySVNzdlZvQkJnVitvZ3UwdElLNWx0OVA2SnRORmRvOWlFUWdWMEVpUnJG?=
 =?utf-8?B?b1dqRXdmdnBIODBQMUNoWW9IeER6R1pMcjcvTWhVTExkTUE2TlFhQnR6U2xT?=
 =?utf-8?B?SGcrSnMyWDN5ZC9lcUlkT3dDTFBJM2lSdHdRL1NrYnRZREJDZmNoT1dOdEFt?=
 =?utf-8?B?VE95aldWQlk5andEdWw3aVBtaG5zSDl6NExWckpLNlF5RDRXVE1Ud2tXWnpY?=
 =?utf-8?B?VzJyV1ZNbDlJS29ZSjFKU21RRzZNZ3RNd2kwZ1pKSjJEY0JsdHozbTlmRVN1?=
 =?utf-8?B?WjJvYTJQalI2WGVLOG14aXNNMFZ1dWRoempMOWdvTDF0QkgxWWFHcFpNajhI?=
 =?utf-8?B?Ny80Q1JNcFY1SXRZOTJWK1lMV3ZJaExBYWRnbWdlek55ZldrOUZsOGhpZkdi?=
 =?utf-8?B?Tko2Zjc0amw0WUNEV2plaG51dFZYMUFvVk54M1RzUzdVUUx6VTk3TkVIOXpn?=
 =?utf-8?B?WjdyVjdjSWliQ01YUEZvYmEzWjlKSU5kNEdwU0V1QzdkWk05N214TnIwUFVw?=
 =?utf-8?B?aWVJcHZod0h2RTZEeHpHdytqS0FvZ2tDMVpDSW5oOE03VGdxYTl4OGttMG1K?=
 =?utf-8?B?cHQ3UlhDeVlLRjlGeFJuRnVoUEtEV1F4YUdzU1B6ZmdLY0t0K3BDZXk2QWND?=
 =?utf-8?B?UUV0WlpndDB2a3E2dHZxMUYrSUtvMmt4MVRVeFNzZGl4TWFGdDNwZUU0Y2ZT?=
 =?utf-8?B?TXVkVkdLUlJUdE0yN1UyRzFVVU9FUzZ1bUViU0xBYlk2UHl2THdUNnlJTCti?=
 =?utf-8?B?ZGNocGtLNmtmQmw0NTR5RWhkS0tqWHI4c2RLU056RTFNMzVkSEVJbnQyVWVs?=
 =?utf-8?B?SVc4TnJtK2Vnck05MFd6ZHFEMGlNeHgwQzlZMVR3eTZCRmxTdmhvd3Jqa2lo?=
 =?utf-8?B?UW04aUl5ZCtWb0M3aWh6cDJVVkt0MGh1OEsrK3RGK1ZYYWU2S3dBNnJJT2ti?=
 =?utf-8?B?TjlsUkRRS2xNWXlFaVNsOU9RWEdxOG9sTjlCL0JkUFpsQU8wcE9vSlBBQ1Fm?=
 =?utf-8?B?ZlZBSzJickRDenBNcHlaLzlqZ1I0bnFLRUhYU0hqWTFLdVd0N0x4dXJCZ0Mx?=
 =?utf-8?B?cW9lK25FZlFINVp6TkVEUkt5OHBmTFhROUxFMlNEaVg4QThUYWhqbVFoYW8v?=
 =?utf-8?B?N0tyaGpNUW1weEhYaE83emtoQkMxazVoSjB2bzRRVHFKaVBoaThjclE3NXlE?=
 =?utf-8?B?U0YySWdmQVJ1czBVNUhYNUxKSWk3YnhNam5CMEtwQk1oRmNUVXV4ak9nOTFY?=
 =?utf-8?B?aHlUSFJ1Zlg0UXF5K2lKZWxLUHVTdWlNMXhDeGFKYkdZL0huQ0RsTjEvUk5V?=
 =?utf-8?Q?BleQG747MVpgGZUXWt7t3ac=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb041e6a-a066-4658-73ee-08ddcb78b0b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:42:18.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvjM4+ZlFOil+vZsd45lB3yxv4oA40/ISywZzGHSvDlRLAOghdj1LrEgWmR1EtYydt4qpIXHf+UyCNuYqqoOLqN1iv2CYndfv+p/Ga2Zvjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com

From: Felix Fietkau <nbd@nbd.name>
Date: Tue, 22 Jul 2025 10:56:10 +0200

> On 22.07.25 10:36, Paolo Abeni wrote:
>> On 7/16/25 10:14 AM, Felix Fietkau wrote:
>>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>>> +                     struct sk_buff *skb)
>>> +{
>>> +    const struct packet_offload *ptype;
>>> +    unsigned int hlen, off_pppoe;
>>> +    struct sk_buff *pp = NULL;
>>> +    struct pppoe_hdr *phdr;
>>> +    struct sk_buff *p;
>>> +    __be16 type;
>>> +    int flush = 1;
>>
>> Minor nit: please respect the reverse christmas tree order above
> 
> Will do
> 
>>> +    off_pppoe = skb_gro_offset(skb);
>>> +    hlen = off_pppoe + sizeof(*phdr) + 2;
>>> +    phdr = skb_gro_header(skb, hlen, off_pppoe);
>>> +    if (unlikely(!phdr))
>>> +        goto out;
>>> +
>>> +    /* ignore packets with padding or invalid length */
>>> +    if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
>>> +        goto out;
>>> +
>>> +    NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark]
>>> = hlen;
>>> +
>>> +    type = pppoe_hdr_proto(phdr);
>>> +    if (!type)
>>> +        goto out;
>>> +
>>> +    ptype = gro_find_receive_by_type(type);
>>> +    if (!ptype)
>>> +        goto out;
>>> +
>>> +    flush = 0;
>>> +
>>> +    list_for_each_entry(p, head, list) {
>>> +        struct pppoe_hdr *phdr2;
>>> +
>>> +        if (!NAPI_GRO_CB(p)->same_flow)
>>> +            continue;
>>> +
>>> +        phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
>>> +        if (compare_pppoe_header(phdr, phdr2))
>>> +            NAPI_GRO_CB(p)->same_flow = 0;
>>> +    }
>>> +
>>> +    skb_gro_pull(skb, sizeof(*phdr) + 2);
>>> +    skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
>>> +
>>> +    pp = ptype->callbacks.gro_receive(head, skb);
>>
>> Here you can use INDIRECT_CALL_INET()
> 
> I did that in the initial version, but then I got reports of build
> failures with the patch:
> 
> ERROR: modpost: "inet_gro_receive" [drivers/net/ppp/pppoe.ko] undefined!
> ERROR: modpost: "inet_gro_complete" [drivers/net/ppp/pppoe.ko] undefined!
> 
> Should I leave it out, or export inet_gro_receive/complete?

Could be exported I'd say. This would allows more modules to implement
GRO support.
INDIRECT_CALL() here gives good boosts here, at least I got some after
switching VLAN and TEB code several years ago.

If everyone is fine with exporting, I'd say those need to be exported as
GPL-only.

>>> +
>>> +out:
>>> +    skb_gro_flush_final(skb, pp, flush);
>>> +
>>> +    return pp;

Thanks,
Olek

