Return-Path: <netdev+bounces-277521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIN4HJ1J2WmkoAgAu9opvQ
	(envelope-from <netdev+bounces-277521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:03:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1D3DBC26
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 834853000FF7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFC2BCF4C;
	Fri, 10 Apr 2026 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzS18536"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AB201278
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847510; cv=fail; b=G8S6hLnbvrPEGPd0V+3i5MT/9c2TPr+Zp6kt1dFdYHs87dM/p5AH90IT1VTnv5rz2Y1oBguSjxKWqwX2qbinlPsQtBEpQn5L/nM0IPwm0Uc7SC32n9Pkwrgw7VYdbOr9Kx873jXkgo4gC47+N5eo6/2jIt5keC477V9sWgOGey4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847510; c=relaxed/simple;
	bh=z5umpX8NCgAt067S4LL/TSjo7Z4AkycRZjpD2GoYtq8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1La5wLftdArhVZgva6b4/hFIERqBdI4hGNFo2M27nBic59zIGHqDeXmZtrXC/S8LE2xo33sKoeNjMf8TUdN4b8q7CTg3boDn71dWlJIZqqHp2kR9+Fpk0SFlgwdJYzGI2N3cyZwTEV7kkJT2oM+mOw3hWDE/M7yYJZi+tpGIMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzS18536; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775847510; x=1807383510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z5umpX8NCgAt067S4LL/TSjo7Z4AkycRZjpD2GoYtq8=;
  b=jzS18536nf+mBsZnnewzLZRdtWJaG3PgWa2FrGUv7JpyUJGZXYuhe/fB
   Wf7h4wDmpRYkRvQYNbRIfIPvW4ScNbYt0/Z8adr+lV6BoDwqW1dZxlGCJ
   OV/feYzfEn258vp9btt2guhqst3GIQsmyc/gOpuG5zIUysGSlKGHd0KGA
   rBmtspbigPdOSNK2Ik1+Dlw5LMhKmDbfClORnVL4ivZABOMcP4/WfhwF5
   u66PSqwQZ6yZGa+JqyDvSGuwu+wm9gs6ADDUGOGlDihMb2YmQBCd8q4cW
   8kmbkPULkQKZQ6Bbb0zdWO7c4BRyk2iWa3+yT0Z3UOTkqQ5t/lD0nhR02
   Q==;
X-CSE-ConnectionGUID: f/+v96ulRva96NV2yN135A==
X-CSE-MsgGUID: ziuPeg17Ti2SRWVZCnDLvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80463866"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="80463866"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:58:29 -0700
X-CSE-ConnectionGUID: ggPonxJITbe884YznTLUZQ==
X-CSE-MsgGUID: rHy04CudSt+Sm5mA/RXJBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226433373"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:58:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:58:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 11:58:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 11:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMmnB8baODXPBxZVqytFdJHuUMjWkaF9X9SAa1J21VHw8NCBdRpcTet0TIfpMh0M6bWWcKgCjkN4bU4jx0ghVW+yBck5gwMJI/NPZBjMsmwcQ6sn7go1BeWcNC0AQbKcHMj+ZWtSZSp022Y0C3YmqwTrQfTaU+q9AGqeyPY7CAXNVfyBDa+bncM029hfh3xBRNvOa5kNgoMZfhB5cUFnqhaxxEr8Vjr+cuHi+p9mVpTgZOMMsI+EKDX9KTL7kowjVbmrgqosbJP+nkIXC0rRUDK47wCTKAZ1EoKOmuuKLWuNaxjb5EbYh7Texi4kZ12c6iS/eSlAIGb+G6Pcff6Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxI4e2oGxX7RRSmQDJLpCaBNLd/dYtK4+XNIIN2K1Rk=;
 b=UO5vOaA6hmusMEvedK9nAhh5BlbWOhPX5dFvJ3OptJgWET8GWe/i9NbCzjbpgM2B2jCi8XebeaEb+o95u44Gst1QgPRNvuqV1L94HG5zmJltW0mwSkNqTEZouye976JxLCidzv/AIGvcNP+cSDvwAwt4nWcT1CSd4cVAcL/jneLxFcHTT9l7o7jFfmeZZ0pUnehK6MzW7RXGedShHbsKU8cCGRbBB7NtnQvRWRbNjSdMqewGyL3T45pRACljDBG565WAVIm8O2u+AhoYhfujEiBp98H9RaUURvOEbXWgmfP5sHwxDSzOytU0zc1B6lkZjCVbNKxHLl7SKnvbBbcTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 18:58:22 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 18:58:22 +0000
Message-ID: <6f0231dd-e648-4836-b3cd-76c49cfaa999@intel.com>
Date: Fri, 10 Apr 2026 11:58:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 6/10] ice: check PHY autoneg capability before
 rejecting ethtool autoneg setting
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jan Glaza <jan.glaza@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
 <20260403054029.3789616-7-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260403054029.3789616-7-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA1PR11MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: d236a3fd-74aa-40a1-3f9e-08de97332320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: J0kCHlgYiZsMl8QLu69MMFCVifjjxZHnYSbLq8QGV9rY/KJibfauyNJ05WbKEXFpq8+TSQIxCpKZ83jQa+MVQ83dmwciqjRz3+0yp8dlYZOWvLhC8WbRXVd+hEpJfGlWg76+1v8KfWDrtn5wQHNJKf8RqfuxzZR+j3BN6iAllWA+Qtw3M+SDhkGQmQEwlmf+IX9/Tg13bwTlOd/Q2cUljM6IsEaJZL6leGSTDgVQlkwzwJNWJmLid8C7PCJiBp0Rw3caZnaJNyye4jHPTgNnE3WEX/E5FUjd3x6rDGqUEawc5+Otv0r1J/xsqf3Vk16Th55bhb5y+q/GyhPk1Y+mETYdvINe9bVuB4t/KOPe0WlRG+Gcf5yA/pK8SKKGH+aTgZwpAwSlF8pe/5L7a7h4smFLD43xU75wSwiFjG11evFDhJiRaA7/PgvAm3bcIZRygqvYt5Igwv3l6OKBgbUZMkSQA2WFz3qxn0+m61/zcShzQ3SPg5Ci26MCOwxXYp+r7Ewl9rWJ8atxh0Q/IRj5tkGl1Bh3Ne+WP5hSlMNcnE55MNrKYByqqirU5cIqFpXLGPpqTJRfdG11GTkc3a6OwCnuTSTuY/yDA6Y8zL1W0TtgJDzTdi1sNYmRDxcnxVrC42c09cOOjZEC3qj/gVRkgG12wm0kzBFjF8GNTbU0mw1ZXjXlD3GZ0kKKaypbeSkFtE06uy+IkhjgIQRyD71FXRB27pyuzl2OQFWWOrzCC+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5sNFJTVEVTMWlDa2NUdWRMYnJyNDBuUFdwS2dseG1WWlZmTlhMYWVOa3R1?=
 =?utf-8?B?NWJWVEd0Uzhic0J5c3JyVHVPTnVQTHdDUDRzOGl1UVpoTlU3Um9hL0tCcDEx?=
 =?utf-8?B?dzVBTFc3MnBTR2QvaDk0ZHYzY2pIblFEbDBUQUVaNENQazdKdjZvcmxoNTRK?=
 =?utf-8?B?aFoxbGd3ZFd5SWdscExucXV0OU9TaTdvemQzM1pnRDV1aEJTMzhlZlhTYlhi?=
 =?utf-8?B?akhwWDFEeUl2UzQySTFrT0hhVkhRQ2s1OG5MaFdiMVBCRXdvSWkzR1ZBdHNi?=
 =?utf-8?B?b0c5NjJWb1VYOWFxQ0l6T2xSRmJKbnhHY0RyUndERzMraXdaemhVVXFpeWZs?=
 =?utf-8?B?bU44aUR6anhYUFg0UDNEQ0hEM1F0NlJRM3RNKzltb3hkNHp4bkJmV3JHYmt0?=
 =?utf-8?B?dk02S05OREtWc2c4RDhSTi81dy84VUQ4UXBkMUNOSnNRc0plMVVOZGdXRkNu?=
 =?utf-8?B?MUxqSkx3Y0dTek1vck9oc0xDMUdsSnBDNHJhNUUzYkFTakFVSHJaYzk4VG1N?=
 =?utf-8?B?VDVHUWVWSjRpMFdab1BkYnlhRDZoR1dWYWp4Ri9Dd2RjeHFkOTdsUTIrY0pE?=
 =?utf-8?B?US9KRkJkbTdyZGJaR1kwRyt1MDRJeVVmSjlzK2UzaHRwVS9xaFQya3BnUG5K?=
 =?utf-8?B?aTVzQkJpcTNtRk8rVTR5ZzFlUnBkKzBnRnFaZEIxRXFEY2xQOHhKS2pBWXRU?=
 =?utf-8?B?NVAraHNuODUvbzkrMmFzUk1LeTNyc2F1Q0trOUkyeEFHdkRNQ1lVSmxzUHdE?=
 =?utf-8?B?Nkk4Qk1mVWF4aHdIUXI3UU13WWUvL3hOd0VtMDY5MmloSGUvbFJVbHRYL0xN?=
 =?utf-8?B?cjc3Q1RIV3VqdHlHT1NVdWsyamswV0I0ZG1PVW9VNEJvL0Q4V1oyeTQ5YWlr?=
 =?utf-8?B?SlB1U0U2UkhTNFZkVUlXOEFXQW5IUi9GWjN5dUhwamxodHZwSDhCY3ZzbWZB?=
 =?utf-8?B?ZVlpT2Q3aUEzdWpQb0ZLU1o0WGV5OUxkbmUxTUlSSzNxcjYwZUp4d09JZEFa?=
 =?utf-8?B?RzVaVFFyNVo5dnFRdk9iZlVrZG1GSDB6akZMb3RsUmFrZnUzYklYTzFQYndU?=
 =?utf-8?B?S2ZvMmhQYTZFYm52NmpFN0ZybDBtS3Z3MnNubmZsN0h1Nm8vUlZRbXVhOXBa?=
 =?utf-8?B?UjBtYVpDd0xwam1VNHBkd0RSOFZId2RaYVJiQWlKbDFqbE9CNEw5TnNmMGh4?=
 =?utf-8?B?KzVJZThtNnJOdnhTdnlXQU9YeVNUVWoySElLZzh5TEtjK1hoZkhUWjdvTXZK?=
 =?utf-8?B?dG5EQVhSMDVnK1hFSzRiVW5pODVKaTRFbENmNTFYbDdSNXhJNmZXeDF5cnhq?=
 =?utf-8?B?b2l6M2hZdDFTeDRIYXRGNVY3dU9ueUJEOHZkeFA3ZnBaNmJMb3drazVMM1ZP?=
 =?utf-8?B?V3FhYS9TTDdmVkhFSEdqT3dtMGdRQU5qUzRlTmZMSE5maXNtSGY2aFh0MTVH?=
 =?utf-8?B?NjRMZWdhbEZ6YXl3WlU4aUhHTFYxcSsxc2VWYmswQUtLMGU3TUZra0pTTGFL?=
 =?utf-8?B?dU9JS1JSeWluOUxPOUh4NlU1UkJ3YkpOMDdsRU5TQk43cWlvbFRBVkJhSmF6?=
 =?utf-8?B?aVRIejI1Y3RMcjc0ZkdFSmtFUmRnUDdacE5aSGxKcWdNaVZwUWlsakFFTlFu?=
 =?utf-8?B?Yy9VWklveDlNTzhsdSttTFFFTHI0YkxhS040M2J2T2ZhZjE5MitiaXUreUVK?=
 =?utf-8?B?bG5FT0ZHdG5hbjFKWWNUSmVjU3lVMG9wR1c5TmlwQzBJcEprL1NBN2FzNFV1?=
 =?utf-8?B?QVMzTHMzT29ybHFpMDZUUGwvZmhURHFkMUhjUDRJNmVZMkp3YjdlT1FVQmp1?=
 =?utf-8?B?aXJBb2dyWTE5RVNveTV2blNLNnN1VFhjcHBiR3lVRUdlZVNhTVdGVXpGZ1pM?=
 =?utf-8?B?c0drL2Znc0xBeERnZHRHNU5oV0hrY3pyZFpiVlZ0aEhBMWk5WDRjR0s2S3Ez?=
 =?utf-8?B?OFg1UzRza0ZLTGM1ZkZSMnBrMEF2MDZYTG5uU1ZhdEhnNWowcHpmeW91Ykxa?=
 =?utf-8?B?NlNzSFdsd3RUaXBmYlIvNmxGSGJOODd5TzNNWUtvRy83SFRWRjFKY3dhR3NE?=
 =?utf-8?B?aVYwSGVNWGEvVUk1VVF6WEhKemhaWFJpZDVDU3BFNC9jZUJma3JmYlJvQ0RF?=
 =?utf-8?B?a2ZLbmQxVElsMStNUHF1a2ptQW96TFpjYm5oRzBzR2NxTThKRjE1ZVZHblJX?=
 =?utf-8?B?Rk5WK3pYWGVwRUxtQmQzTEdZaTRIcGxsUW52ZmpRblI2VGp1T0JrUE9WcWVS?=
 =?utf-8?B?aC9MRXV5Q09rZXhwQ2w5RDZIT29lYnlibElIWlRNTytGNkd5RHBYdzJscUpo?=
 =?utf-8?B?bzdVUnpuZk9FVkdwdzc0WDdTTXJWRUE4aktsbjYyQlJ6Mk41OTZPVm1SeTZp?=
 =?utf-8?Q?Ao5tFS2kUCyLvbQE=3D?=
X-Exchange-RoutingPolicyChecked: KHAhewLOg9xl5Mf6BDsbHtXs42tp7JLgbWxeVQ36RkUKZQGpHsDN3zQTQI22O5L0cywmFOMjGF5F4U4e85LKvBr1Y8eOHcK3obAhpXQ9c/vce+2GlbJ6Jsgfo7gknPkOF6bo3IY4Eu99vjgZEBxsyHq/CFHMPCkITHah5D+d1zVcbCIsHM4ljbMH7ZsPPG7yMXngRud6XEslfOVCVIQkbq91jV0uEmEtpnGR8+uLQU7SgKzlFuvaSnZ4Zno0TEHiPjRRSPXjfvX3ASxEapEMW5vh+NxmN7GGacjO3OsDI+I+tXS9x/1LesP/Yswl6AXImyuA8vOUQSLtSTfvGgIXVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d236a3fd-74aa-40a1-3f9e-08de97332320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:58:22.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93jNAyukUgm7iR59/AyXwykoKV9QOE9td2IiQJCs7JDT4vB/+vZ9TsN8FI+4+6Ki4aNgip0USt38hLMMWNIryxCN5kLJvOsaO9o/D4Ohioc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277521-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 90D1D3DBC26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/2026 10:40 PM, Aleksandr Loktionov wrote:
> ice_set_link_ksettings() rejects autoneg requests by comparing
> user settings against safe_ks which is populated by
> ice_phy_type_to_ethtool(). The Autoneg bit in safe_ks is set
> only if the current PHY configuration reports it supported,
> but this misses PHYs that support autoneg and have it available
> through PHY capabilities. Pull the autoneg flag from the actual
> PHY capabilities (already fetched earlier in the function) to
> ensure the user can toggle autoneg on any capable PHY.
> 
> Fixes: 5cd349c349d6 ("ice: report supported and advertised autoneg using PHY capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 49b9376..44483bc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2654,6 +2654,14 @@ ice_set_link_ksettings(struct net_device *netdev,
>   	/* Get link modes supported by hardware.*/
>   	ice_phy_type_to_ethtool(netdev, &safe_ks);
>   
> +	/* Pull the value of autoneg from phy caps to ensure we allow
> +	 * toggling it on all PHYs that support it.
> +	 */
> +	if (ice_is_phy_caps_an_enabled(phy_caps)) {
> +		ethtool_link_ksettings_add_link_mode(&safe_ks, supported, Autoneg);
> +		set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT, safe_ks.link_modes.supported);

 From Sashiko:

This isn't a bug, but should this use 
ethtool_link_ksettings_add_link_mode() instead of calling set_bit() 
directly? Using set_bit() on the link modes breaks the ethtool interface 
abstraction.

Also, does this incorrectly couple the ETHTOOL_LINK_MODE_FEC_NONE_BIT 
support with Autonegotiation support? Forward Error Correction support 
is independent of Autonegotiation.

For PHYs lacking Autonegotiation, the FEC none bit will not be added to 
safe_ks.link_modes.supported. When a user requests settings via ethtool, 
copy_ks.link_modes.advertising will likely contain the FEC none bit 
since it is unconditionally returned by ice_get_link_ksettings().

> +	}
> +
>   	/* and check against modes requested by user.
>   	 * Return an error if unsupported mode was set.
>   	 */


