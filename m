Return-Path: <netdev+bounces-101786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8090012E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643B91F23A83
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3C186288;
	Fri,  7 Jun 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL2RljVA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271F17DE36;
	Fri,  7 Jun 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757487; cv=fail; b=NckUEeUCpbCmfi2ExpAsBq9tgbpPdPPlXSZHNd9oHCiQJfL3bXgCi2WS/K5Y2Thkjdg7t9WHTc1b1pz7sPyh7uwoJ5ThkxieYoWCADD9o9t//C8Amu2AScDVzdGE7OJhsCevsF3vtROvcxO0i88hrsUAc9X4RIBvBqNZXd4VUNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757487; c=relaxed/simple;
	bh=em+ZkZy4SKcvn44lwrbZRhXIRKTBZ07SGrdnB2zZjBM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqYsoBl8U/JZtb68Hdbx6BfaPKUeqwzpXV0TZW6zvbFk7kaCjOU9S3bLsrPKH0JCshLlOeRU8kpdaeT5rSrERlZ7GLLblBa9Fe+AWt4rxIQZ1fgRP5QFzvz9PJHayC/IB7J9Y0sIBzS+HSQBGnvggHMtO2HpELhePyA9uIQ6o7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TL2RljVA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717757486; x=1749293486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=em+ZkZy4SKcvn44lwrbZRhXIRKTBZ07SGrdnB2zZjBM=;
  b=TL2RljVAAmxeWq66zk92PpmDQYrAw4HiM1fE/anSmga6V45uUSTzEfx7
   OPDQHSIYopu50mIBtL1iBbq8aAWdOvt6/lzWXtNvRzEAmcbtVItWDOPWv
   v2qPQXZFVRHalbyTJnPYLTR8tahOmqR3qXOSR9d8H1kZYsggCA2eYCX1L
   rUpwqsCsCKTYeDnhdDozUvF9aMU25Kitq3CjOym+hB/xwYtyGMB2ya6bV
   5BABn32w3WF3UvbAOR+LbFBGPnJ+y0W3epudgnITds9+BwUQrV/GAXAJ9
   +Ktu0GNUz3bTB5SZT1tTUZdMZcdCKEBjUs7QEM3GQrCsecg4nKPf6a9Sv
   w==;
X-CSE-ConnectionGUID: okIcKBvJQrmWtl2oBkbtaA==
X-CSE-MsgGUID: JYraKFCdQ921UYS6ccqyLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="11962640"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="11962640"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 03:51:25 -0700
X-CSE-ConnectionGUID: uN7dw4pNSfa835IwTkYvvQ==
X-CSE-MsgGUID: VAi9BVOHRGqNdyx4MS0cYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="75769938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 03:51:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 03:51:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 03:51:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 03:51:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 03:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmQA9WfUKXUyKBeqCbSR1UZvbBqHR5dc6p4/wSHoAaI6LIYlBoGD0j7YlO450DwBn4zqHT9gZePyNT6D6FQXZcRy9nonxYv2usSiGV2w3bl5pA04gaG1ZKdX6YGR8BhQclwFP9HuAox9ubqm9lPyeQwhOp7RCvIfaXJF5vLFk5pg315haNsqsku6jRdZvFxyrE7I0+z6uALnWKZnG/Xky+1l9Gx2nI0v1cG647i1+gLV6InREOOhzBC8pklw7jrvpWMbLqDoL3/SKXPCAheGg2313G69DgZafAqd4Zr0RxIpliOKul2JDlvhM7UKktugIMu5VE8rWdEJy3b+b5IRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWND+mvEQHEd5Rngsd/jvGZZe85mNKehSwX9XeheR6A=;
 b=QsTz6n1895grhdE5IPj0x3kQZTfsXVZyx1wB4SmpUH0G9qjd5NzdLOJ+z52SSM55n6NQXE96XDzM9nWle4WEu7jRXhEA6MqcYArp3WqTgerxpwsz23+EkjzI3x0gN8ottN9/oQEH30j+JCd9RPfYA+8iEYtqxTDJ/ovoOYL27aACFJT+V8M7SQM14JxS0oyL5PCu0hBVTejjCzmf2YMuFVJ72DP2KTtTP2PJYQ3+InWsaZ6xiPlgFXMmIiuH+PDlkWazXBIYApnGRftTvkOsJ+tsF4Jzkgi99j/8VNPim/rHJVBkNabQkTFQeZmfgRaWUUflohdLekBgXfpBNaqExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:51:21 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 10:51:21 +0000
Message-ID: <8401211b-4b76-472b-8528-2501217beb26@intel.com>
Date: Fri, 7 Jun 2024 12:51:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
To: Xiaolei Wang <xiaolei.wang@windriver.com>, <olteanv@gmail.com>,
	<linux@armlinux.org.uk>, <andrew@lunn.ch>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240607103327.438455-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240607103327.438455-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aab402d-cf46-4504-57f7-08dc86dfc4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDd6U1FxM0xCYUx6enZkOFZoT0RneENVT1p5bkNlSUd2d24vUjdXZmRGTGVy?=
 =?utf-8?B?Ylp5NlpyTXRsM2pINzR1U0lnMnVtcUV2SmJCZStBaFlmQUphaFgyUDNwa29v?=
 =?utf-8?B?Q0JVNDFlTldqTmRDZGRadkx1VVdPZkZqTGQzSGRlSjJxaGh5cENBQ0lPTUVG?=
 =?utf-8?B?MmR4RjJpOGhjM2paR2F5bERHN2J6bWNIMXFzT0QrR1JXdGcvMGVFYUE4VWdK?=
 =?utf-8?B?RmlaMzVHSWx2aGczeDk1RzJFVnc4Zk9BVitIMkhyYmtDc2VLRG96NXV4WUV6?=
 =?utf-8?B?dmlTK3hKQVVPZkZyTW1xb3Zpc0QzbHppUW5qc1YzczR3a0oxMzc3dHpuQzhm?=
 =?utf-8?B?alNySjZxK25xV0tTWUpOQWxoSVA2cm81cTdJVlkxWVIvRDA5S0xmUnRQUHFY?=
 =?utf-8?B?WXNTZ2JzSTcxZU9YU2gwM3lDUTEwb2ViMzFvanJXcXpYR3lRWVBMdUlweHFh?=
 =?utf-8?B?MzI5d2w5UjNJQm5oZkJndllMcHZDU1R1Z1hPK0Q4Tm9FMk4yWTEwSUt0eFdI?=
 =?utf-8?B?TTI1dDZkSEJkYndNQ2NKTHFmMm1kNFdXSFlNR1BBTjNxMXJxaWx3ell2V1ov?=
 =?utf-8?B?ZncrK2gvTWhhM3I5VXJWaktSdFN4ZFlrZlpjdlJQNVhUSDNhOEZ4RlAvQ2Jx?=
 =?utf-8?B?THA4b0xOd2w1Q29aWkk0R3Z2VURkdnhVQUNJQjQ4eWpTVy9BZktGaDE3aTUx?=
 =?utf-8?B?Sjl0VEF3SVUrN29SL3Y3VjczaC9wVFozdWNnWktjR0dHdENNZzRjdEJMbHZm?=
 =?utf-8?B?MUN6VGJLbzZ6ODdVWVpFR1dFVmpNcTRUOE16YVpuK3RPSVhYeDRiVnNoYkR6?=
 =?utf-8?B?ZkpVRGp3NENQcTg0L0E1VVMzVjNEb1NxVkdVSFBwclgwQnVXM0FZTUVqOXNh?=
 =?utf-8?B?UmFmS1dqNm9hK1Izc0tyUkcvaklNb3BTNTJmNnVackVmOE0zb0xmVFE1MlNr?=
 =?utf-8?B?Wm9hOHlQMUluS3ZhV09jODg0Vkd6elRFTEp6Y09oak9McXAycDVQNzFJeE9j?=
 =?utf-8?B?MDVkYitPdm85ZVZUWTh1NDh0Y1dSQkoxY090dTNxK3hJUXVxUXZ1a2JLaHlp?=
 =?utf-8?B?NjhpUHVGNnhWUlVEK3R0VHZHeWY5RUpibS9KTllqcWVrcnB4TS9rSkg4K2sy?=
 =?utf-8?B?WUF2NXEzallhajJETS85TUREWkl0eWNBYjVmbUJUY051ckpibFl6aDdCbVZ3?=
 =?utf-8?B?KzVzaGVvRkZIQit0RklaOEJRSDZ1cTROL3dJSTY2dTRRUXA1ZXdicmRiSEJL?=
 =?utf-8?B?aUJzU2dJZ08wSWd6NUFhQ1lFL0x1SXhhby8rampOS0RMYldIMzRRWjRiOUhT?=
 =?utf-8?B?bHhLNkhXYkU3WS9Mc0dzNWo4K1RTUi90YXZGNkVlcllwbWpsSDFraDB3RVF0?=
 =?utf-8?B?TS9LdndBWWpqVk9zMi9wTFZNK08rVWJHL3pBc3Ixc0t2ZEVGUGFEaEI2OGdm?=
 =?utf-8?B?TXozdEhNYjdTVGx0eG5aS1dNY0RQcVpuMUVYK1g0UTBTM0E3R25pZUYydjBP?=
 =?utf-8?B?WnZDY1VldTBCN0d1anhiS0Riakd2M3VJZGpiMWFaaStvVWVPc3dHU0xMNFFR?=
 =?utf-8?B?RzF3N3diaVlUa2dtK3pNakpXUmMzWDZJNmxhUmlqRU56OEVrMlhCcUN2Qm82?=
 =?utf-8?B?MUUrYnptOHVnYVFraFRmTkNheDNESVY3VlZnUG1hRXRYbkdIY0JZL0JQSDlP?=
 =?utf-8?B?STlIQ0VwSXI3YjNFcUxzMUNFa0prMWt1TFhtNUswSmNGYW15QkhlbmZ5bXF0?=
 =?utf-8?B?bDh6aFZRb1JvMzd4bjN1eXh4cnZtZUVieTlaOUVwcnBqV2pMWlUwWUlhWC90?=
 =?utf-8?Q?ltboKYldGxqr8psof+wfUviLNQNtmdggFs2RA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhxYjZIOHJBZjJTMmtZbEtOTmFvdVEzaEJWVU4vdkMzZHFQbHdlRGdLVFAv?=
 =?utf-8?B?eGRZNmR4eDRCOVZGMkN6VU1TQzFxNkFJVEJid0lZWkU4NWNHT3FOYWZib1BV?=
 =?utf-8?B?bHZpcTczV29ManIydU5DREZ1SGc3TmtHRXVHbE9qblQ3ZmNmbjdFQVhiaHJo?=
 =?utf-8?B?M2xoRGcwVHd2TmxENXIySWJVMGdYSmc4d3lPMFNuemkzdDFjQnI2NkQybUVq?=
 =?utf-8?B?OVR2SjlaUmFPRnpacUpYSzNjcXFFMnZidGIvcndjVEdrSGs0alZ3VnhDNDVr?=
 =?utf-8?B?aEJuWHRuNHpjWldCOXdqYU9lbEN1ZE5oZEIrMGt6RzVkNlo4YzlHYjJpcXBZ?=
 =?utf-8?B?MW05N0dNbkRmNXhVNnBNUjJocFp6T1krRTgyL2ozYVBPRG5USDcrNUt6SXFx?=
 =?utf-8?B?UWR6eVQ1emd5Ry9zZ3A1TloyRmhNMXlNZnpZZ0ZUcU1JRFVHMjZKWGY1cms0?=
 =?utf-8?B?K2dYZGE4QXltSWFEeVVxaVNqd2Q2T2Jha3dnK2J0Z2g0b2NZVW56Uk4yRHZ4?=
 =?utf-8?B?SUVjYjV4WHkxM3dWNlZUdUJVc0ZmRWkvOFZYQXg5QU9DT2JFZW9STkZvdkgx?=
 =?utf-8?B?UHNzV1I3dmo5cm15dGdJQUNFblRpbm0xczhXYnY4cjNUcmtTWTJ5SzN1Nm1k?=
 =?utf-8?B?RlYwRVRsSnBDbWRyL21xcG1SbktrY1JDMVFyUzFYbmZzVnIrenNPaWtzRlox?=
 =?utf-8?B?NXRlYzRrN3UveTc0aThFQWhsMzFSY04wcEhaNmRBbStZanhJckxaUjVXRmJt?=
 =?utf-8?B?dEJMNGFPQXhTdGdGbTBwN1RzUkZCQTU1VWF0UEZJL3h1enZzSkZBY0J3SUk5?=
 =?utf-8?B?cG1pTjMyN3FFL2lvWDBpa3RJUVo0WjUyS2Z2S1VkM054cUpCOHBXcDQ0QkI2?=
 =?utf-8?B?ZEFrVy9UMzhxcFpmVHN4T0tPNUJDWHFwdEhaRTRGRTVEdWh3Z29sdjlsWXRy?=
 =?utf-8?B?NXF5NmFoOCtGRzcwUzNxcjF4VmpYVjcxc2xzMS9LLzdWcjFFUGxrV1poM3k0?=
 =?utf-8?B?WjVuOHNwMmpqWDRSQjBtYmdiVlZkL3piTHY4aGloMkNxRVBHVitOcmJicjNE?=
 =?utf-8?B?K0VSMnNVaXFNWTgzTHJ5eDJYQzVLNE16eG5lTmVtdVcyVjA5RlJoT0RsYVdH?=
 =?utf-8?B?ZnduMzArZVkzblRUbWx0cTd2TXRiT2JlZDlEanVIdFFNU3ZlTTNLUXc2VUFS?=
 =?utf-8?B?MFB4d1BBKzZ5c2RZR0Z6a0xrSU1hdXZxeGRsTTZLa3Bvbzd1OGwvWWpweW5B?=
 =?utf-8?B?aTFlWklFcmhmbHlXTVVHL2IyaGRqUTB5cm1sSm9RdkRZeFpsbmJBM1d6Wnhx?=
 =?utf-8?B?STJaSENDVzN4WGdBK3MvUVUvd2czNGxIdCtsUmVaZzlwNmxOWVBWWDd4dm4r?=
 =?utf-8?B?OFZPT1JtNXRUK2o5MnZ4SG9qNzExeEVMOENhc3dSMHc0enlRWWxRbHp5YWlv?=
 =?utf-8?B?ejJsM2t3M1l6djB6YUQxclRGUmU1U3VReFVoVmZ6ckk2MHplT3VkL045TDhP?=
 =?utf-8?B?U093S3haTUFsbXN6N1M2NVNIWnV3U1ZBMWpKbU5nWENGWlU2R1dXM2cwbjRI?=
 =?utf-8?B?SERlV0JIenBJSmh5M3VpK3VlcTI1dEcwcmw0alM0UUNSUHdZOXp6czRYNmxI?=
 =?utf-8?B?dFIvQmFlVWpVMzlyYjZibnFmUTVmY3lJR0llcVlZZDViaGNwYjlkQ0YrOFJo?=
 =?utf-8?B?cENNVjRTUzIycDNHN2RQMlBld0l6MmVSRkF1THpEdHRlYmhqczJnMTI0K3Zn?=
 =?utf-8?B?bWlTdkNiRkpXbWgxZDJ3eFNGVDlzNjVmUGxYZkxXWE51M08rUFhjYlpnaW5y?=
 =?utf-8?B?d1NVZTdFaWFXVnhraTdFSjNvWWszdmo3c3YySEV6Rk1Sa3MrR3pJakRIeW1W?=
 =?utf-8?B?VUhCVlZ6U3RHbmJ2S1ZSTHVhU2U1b290VkJCbnRFSkQwaE9USzk0a0ZyNENY?=
 =?utf-8?B?YzB6YWJCQnhCNUtZZS92M1JxaGFDclArKzBLQllTUEM1SUwweUN4SDdONFVj?=
 =?utf-8?B?cnZSajBmWE5VWTIxUWx2NzNETUpXQWZ2dVRyWU9HV3Ywc0F4bjd0aTBwUWQ2?=
 =?utf-8?B?RlBVdE00RzFCdzBHdXlCYkprbWFud0hCQnZTMzRYNWlid1NuWEk0WGU2am9x?=
 =?utf-8?Q?KQugcPw9tolXQ3R7KH7V2jtqc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab402d-cf46-4504-57f7-08dc86dfc4c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:51:21.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiTD0leXalfNCQZB2GW8Mf3tDAyiDdlVnjqFB1JjtxfU3MhskYj9Puk2AjxcUkyaIsMMSBz+/WFE9C/Mm2Uz3lWcVrKRwi+Iw9Jtsx2qSMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com



On 07.06.2024 12:33, Xiaolei Wang wrote:
> Since the given offload->sendslope only applies to the
> current link speed, and userspace may reprogram it when
> the link speed changes, don't even bother tracking the
> port's link speed, and deduce the port transmit rate
> from idleslope - sentslope instead.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

One nit, other than that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 222540b55480..48500864017b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -348,6 +348,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	u32 mode_to_use;
>  	u64 value;
>  	int ret;
> +	s64 port_transmit_rate_kbps;

RCT

>  
>  	/* Queue 0 is not AVB capable */
>  	if (queue <= 0 || queue >= tx_queues_count)
> @@ -355,27 +356,24 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> +	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> +
>  	/* Port Transmit Rate and Speed Divider */
> -	switch (priv->speed) {
> +	switch (div_s64(port_transmit_rate_kbps, 1000)) {
>  	case SPEED_10000:
>  		ptr = 32;
> -		speed_div = 10000000;
>  		break;
>  	case SPEED_5000:
>  		ptr = 32;
> -		speed_div = 5000000;
>  		break;
>  	case SPEED_2500:
>  		ptr = 8;
> -		speed_div = 2500000;
>  		break;
>  	case SPEED_1000:
>  		ptr = 8;
> -		speed_div = 1000000;
>  		break;
>  	case SPEED_100:
>  		ptr = 4;
> -		speed_div = 100000;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -397,11 +395,13 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
>  	}
>  
> +	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> +
>  	/* Final adjustments for HW */
> -	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
> +	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
>  	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
>  
> -	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
> +	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
>  	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
>  
>  	value = qopt->hicredit * 1024ll * 8;

