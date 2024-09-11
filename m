Return-Path: <netdev+bounces-127482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BA9758BF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BC4B25A9D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C141AED2E;
	Wed, 11 Sep 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcpYcUne"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64D383B1;
	Wed, 11 Sep 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073513; cv=fail; b=SnkNf39IjdfHob4nwVCuuIodvmP3uCs0aODpEGhuIHvSkA7dQHHzWniv7WR0X1DlJ8rlMc1/IGzwytnFrjYBYK0b7lCnM7v/yj5cFdfc30zJv7qK1wUguW8yx7LHijsmcvgfiWUQtWM7hxRh0gXmvSsRd+ij78CIYO3kkxFp6iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073513; c=relaxed/simple;
	bh=//h3XXr9PxeqYcYlZd2+A1XZDWanB8ZSktkvEoYj3gs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VY1Lb8+seVXkWIMhVdKZjwFLSeOdlxH/jJX9DWJSexE/MkpIaqT6plnkmMqWLk/c9wErjk5HU4kNzDjgEZzNndk0FzDQF8obgIPKayWy4A0Z6SPfsnBqAb/NU+LRzO5cRMpwxzATbmFCLTmvxr0xiU158hEaN2TAjvFrR1t8Kf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcpYcUne; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726073512; x=1757609512;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=//h3XXr9PxeqYcYlZd2+A1XZDWanB8ZSktkvEoYj3gs=;
  b=IcpYcUnehn3z/8+6v+MA5+D5Pm6cRdyt4yDXlrV6Xfx5fZyLQwmPqPrj
   XirI0/AB+06TAP6NQt3PhTi7RxIFG6vHmDcX7WHD7QudhcRPEws0iM3f+
   s6PO2hZBkhbxbuDPL6c16wxH0o257VFQk8Yp2hVr4rAE8UV6E3suiVX6G
   JAygjebaprapWKJ2N2lH8hUPqheugup5X5sa2cy0B668f+ER/nefQtQ6f
   9absEeNG/1D2zkbHCl9FHpYVpvDJ8H19kMXa8Xflop+Rdw+sG9TRVbRIa
   eiYwWqP+W/7+WhHn2Vw58sTu2vaGFxV+B5lm6MnQXLc1x4cNzHfrk4h3V
   Q==;
X-CSE-ConnectionGUID: tVYqOtbeSYa+cj5UptbnnA==
X-CSE-MsgGUID: KStU1nn1RH+9dNkQ8uLXCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="47403026"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="47403026"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 09:51:49 -0700
X-CSE-ConnectionGUID: mAjJBmzETIiGR7N00Ce4Mw==
X-CSE-MsgGUID: OLt470qiTSeWXk393Gj9tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="104887124"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 09:51:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 09:51:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 09:51:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 09:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMGxKXhozwzXEFWqo3HdV+Rf4gvu/ZucgOnUSPNqkvWUmak8YQLpZkxi7T+a2qwMyy3HBjRnR31ceGaB2/pCOIUWmo5w1omqFhqoHRm6dVag0rP2IFzmF4CZS1aHqOXnOILRJ8KUQgYnkPBhilB5yxKyYV8T6imMiq7WlgybtjLatP7/ABNWR1fe0ZqExscMlzY8bJMMsofD6SMsFTYRn9j+CR8OfGV2M2ePLxEgJeargdt/aSqxgL4OokH8YTfnE9nVLc1OxFGnlrEprZ+MzwORkKV4lfuHF+7ztKY6y19ioaHuDX+qLW5Y/ia57RmySmAnrIwtWI1utaGaA0tRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxXbhjvAViqMBhp2kIVtmkDENrwR0PRjPoC+fcJOKU8=;
 b=MVTl2fArKSMNRROPxsjf2P6wbxXN+IO8+ZNKXT1atQoZ/9HmgJi2zBZ67GetMARCDsQSLmO3fr60Ot6QQQCyVGVUopiregIWlgWuvGrnkuqBffePEp3G/B8up8L2gl41FQc4/OX6C5+xR323A8T/Ti6A1gCzzwZk+z12MvpnhWgMKNPd55PzVc2siTBNim/XlpZAfM4e+p/X3zk53ph9UgfIrCMpHAnCIYzsUci7hP9MD2XF8Px3x1+JyZcVva2RAEdsPwFm8RI5s+OZGuIj4c+OnzLdG4sGwiEeVZSMasaFCdKLtfPJFNvijUC5njCmqvpF2T1e03rIFpBlKgD1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 16:51:46 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:51:46 +0000
Message-ID: <c970e22e-9fcc-499a-8c83-32b41439cbb9@intel.com>
Date: Wed, 11 Sep 2024 11:51:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring
 tcp-data-split-thresh
To: Taehee Yoo <ap420073@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <corbet@lwn.net>,
	<michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <ecree.xilinx@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <kory.maincent@bootlin.com>,
	<ahmed.zaki@intel.com>, <paul.greenwalt@intel.com>, <rrameshbabu@nvidia.com>,
	<idosch@nvidia.com>, <maxime.chevallier@bootlin.com>, <danieller@nvidia.com>,
	<aleksander.lobakin@intel.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-4-ap420073@gmail.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240911145555.318605-4-ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SJ2PR11MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: d425d2e3-d009-4666-c815-08dcd28205d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXIxcDdTcHpYZ0x2aUpSNi9jTTYvR2ZERHppZnlXVmZrOU5VTCsvMTBLOXVL?=
 =?utf-8?B?dmNKdzFZUVZiV1BnUUNOWTUrSkZLSkk0R3QwaDlldGI5VVhmdk1DeGFQVkxE?=
 =?utf-8?B?NzNJbXduS2dRU2VaSXZWUndsYWQycFFpcnE2YjJLZlpNVHBqM2Q0M1BwSFdS?=
 =?utf-8?B?bXpBTkdIb2NuZWhsWTc1VkRPOWNmazJKYzhrQXc2ek1oUUQya0JFRFBHbmMr?=
 =?utf-8?B?OG1IMyttYjRxTWtRd0E3TGRWbmVBbjUyRk1KOTE1ekdUc1UvN3huai9iTjl0?=
 =?utf-8?B?aXZhb1k4ZGRLWGlUS3ZHa20rYld1NU4wVCtYTTRsWkFtRU1LNDF6bk52TXcz?=
 =?utf-8?B?bW5HN3Z5c1VoRUpPZ0pyV3QzZ2lYZENxK0VPa0ZTelR4MEl3ZVVNMGszVFdT?=
 =?utf-8?B?TnNObjhVWG1nLzl0eXhSdkFaaktLOUhmUEE5L3RnekZ1aS9WV1Y1MnJ3SlhW?=
 =?utf-8?B?RXV6VkZCb0loUjRIRHhSQXNFTDdkZDlUL1ZJb2E2emJJYmNZeklxQlFRSUg3?=
 =?utf-8?B?bVhJOE14aFJNbTA3bU44WHhjZytoN04rNW5qcExLaVNmZlpjV05reG94cU9a?=
 =?utf-8?B?YmZhcTcxRXZHbTBWZXFUZHJYRjNIejNXbzhReEFqbTNqSGcxMitIb2Q0YXJC?=
 =?utf-8?B?UEp2Q09LN0dTYWR1WWkzcTEyVmhSNVhzbWxqeThTd0dsNG9UV2s5K3NsbFBF?=
 =?utf-8?B?NWU5YmlCVWlobnlEZ2k3bWc1L2JxUDUybHBoSysxeDVlZmVYSHU5RUJabHBT?=
 =?utf-8?B?VXhVZFhLaGtNQ0IzUU90M05BSk1GM2txQ2FPenQ2TWhGS0RUbVYxdVd0NFZM?=
 =?utf-8?B?NHpuWWRPUHl3NU80R0w4Zm55QUF0QXRWWWpMd3ZHSUpKbWRhQ0hxZVRxVncw?=
 =?utf-8?B?bmVrQ250K3k2UGNmbHpCdEE3RHZaOHVZZFhVMm1zVkdYaU9IWWxoNUgzYldG?=
 =?utf-8?B?N0srZzFPWkk1WmlqdzlsaUFOSWYxcStmMjNTZGpoL1pnbEtoTjMxU1M5VW9t?=
 =?utf-8?B?Umd4Zmd0bklRWGd6VWJKMG9xL2NyU0RsSVFZWEp2bC9iVnRCbktXYkx4enUw?=
 =?utf-8?B?MkoyY1pkZFJLelZGYUNhL0NiU0ZpNW5ZQzNxb25nUCt1S0dXc2VvN1R5UVZX?=
 =?utf-8?B?ZGc2c3hVTE92ckpaOFFzT0UzUmx4OVZ2MG9ZRHhYVjlxTTlXUFpjY3pyQXUr?=
 =?utf-8?B?c1VvWmEreElpMnJvRjBmeGxwMHJMVnNJNjdHcisxRnNPZGRUanVSb1VoalFr?=
 =?utf-8?B?UUFSYWloUUEyY3A4d3VIZTlJaTBJU0ZLZ0FyN3dOcnJneGVrVXoyQnl4T21C?=
 =?utf-8?B?WmFLaDNkcnJyMU1VUGMrU1lQTElsNHFTY0QvNXl0Q1p5MHN5VnFiaDlITHVj?=
 =?utf-8?B?aGFva3Z1MDBScitNSllremJGVW5DaTN4a3k3MGE4Sy92SVpJcFRTeDB2VnNx?=
 =?utf-8?B?cUNrenBzbU5pa3o2WFBUcElKakRkOGs1bThVbDMvSU1UaDhrbU9HamVQVWFF?=
 =?utf-8?B?U0xDenZzTWtnNzNsYjhDY2N5OUlpNnN5NTNJVGpKMzUvcFZSci9VbDN2K0Z1?=
 =?utf-8?B?Z3B3blh6eWEzc1pwMC9reXZPcWJOU2x5aWxUR2RDaXNBT3ljZ2pjQkJaVUVC?=
 =?utf-8?B?NHB4SmNlM2NITUx6QlNpZjFpSFZRMWlNK3E0WEtHTkNQZmhNMm5FTXBtQlNK?=
 =?utf-8?B?QnVwY1Z1RHRjaVZxaURRcm1jakpkWm9PSk41RjdjdE1uNUhHNGVFYkJEL3VS?=
 =?utf-8?B?YVpMT3VrWC9lZ3hXalBGanFEcEpJazJwQlRsaXNGRlRHdGFmL2Znc0FXYWh5?=
 =?utf-8?B?T1N1TFVURDRSenlJemtoZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnF2dW9GdTJieStqTE5rSlhvMTJlRW9jMG91WlVodFVQZ2tuL0JheXZkT3F2?=
 =?utf-8?B?VEdEejUwRHJUamwrMjB1cjZxWjU1Nll4Z0owdXdvbHN2eG9kMkQwRDU2RHpD?=
 =?utf-8?B?bU5CK1ZZWDM5NDZ1QitqaFJaaWF6WDhYOGNoeTh2SVRrRG01SWNMODdvbEhJ?=
 =?utf-8?B?dFB2dHVHMlRvY1o5UWJBY2ZaVVB4amNyR1kyZEhSeXE5a05nL1FvOEt3dFlU?=
 =?utf-8?B?V0t2T1FKVmsvdm4yZ1AvVFB0aXl2SXBzL0xQZ0ZmT3VXQ2hxQ0J1cFpTRmRw?=
 =?utf-8?B?QVBSbmFHV2ZITnh2a2xYTTN3b3VjSHpvQzlFb3lZQ3dTS3J6MjljSnU5cjdz?=
 =?utf-8?B?emtEdVFUZ0dFak1VRU1YdXkxeWREVEc3REZSdlFCeFNtM3FwTGxaa1hQV2NH?=
 =?utf-8?B?a0IxVmxNWHRuOFNpTHBiVnBseVorR0JHMFpsQzFzMWlsb2tXOXZXMlBTSkdi?=
 =?utf-8?B?d0JnT1J2cy9qb29LazVzT3d1d0NWbnZYRnRGZmRHN3NsdHgyRndVclEzNGEr?=
 =?utf-8?B?YjRVK3ZZNmlLVHdCRGRpRzFqL3ZER1hhWU1kOU9iK1A3UDAzTWR0UWJkak1F?=
 =?utf-8?B?RzRYOG1aT25vQlZrQUhRTjUrM0NqbENwYXI0ZjVGeTUxeEZQQ2I1U0NaSmRx?=
 =?utf-8?B?emVjVFRRVTNRNWxDK0taVERTOUIwUExJYUpHTzQyTCt0cVY5bEtHN29IbkZV?=
 =?utf-8?B?VGdrNzd5ZlQvWEFxMUJIcWhrSmoxaTlKY0hKQVU2ZCsyRmszRFdicGh3cFd1?=
 =?utf-8?B?YU9FQzJaNUJwa0MrcEdGd3VHYlZFNTJBRVVnNjZkMHQvWm5GVU12bkRTRndL?=
 =?utf-8?B?RTBwQVhhRE9FV1lOY05ta2pQblV2SS9Rejhkc3dra3E2UlN3QXRicUV3UEQ2?=
 =?utf-8?B?WmZqS21vRVhTT3FYczlqV2tjdzUrM1VCa2o4Y0hEUlFaWWowanhFMnRHTDd2?=
 =?utf-8?B?VllzZ3hOWG1sUjlpR2tOYlQ0ZVVaQW0wazJDbHNFa0o0Z0NSMzV3R1l1VDh6?=
 =?utf-8?B?N3BsYmdSR2RnSm5LeXNIbFRNS25yeGZnMXBaTFBEQTAzanNESGwxeXRqbE1q?=
 =?utf-8?B?VlhvdENNLy9aRHdYMmo0UW5DM0dCRXhQeklBN05yVWhZZHptcHdFYXRBZTFr?=
 =?utf-8?B?TWdFNDRtZzE3dHN2MEorblowM0pmejlhd2JzSlZkVGVYaFVzSHhnZ2JPTE1k?=
 =?utf-8?B?c2lSWjhLazM1L2NxSS9LRHdadlUwME94RmRiQ3Zpc2FnT0NuRnpLT3F4ODYx?=
 =?utf-8?B?QTBJY1dHUDRQSW1CTTRuUHBBQnBSbzNJdTczS1pBekEva1Uva0VyN3ZYdjlU?=
 =?utf-8?B?VXZDRHNOUFIxTWtSNGJISmNIMnVlamFRc3BHMVdycC9Sa05wK3ZCS1lmTk1w?=
 =?utf-8?B?UEpHdzV1VTVLVlJVT2FDbndnckRHTHRIM1RzTEcrbElrWnRHWThBbGlaNnl4?=
 =?utf-8?B?Mjc0Y3VVNDh0K29CWk9ibURTVWpJUzF0TXBrekNwRkRwVnVpS2xIV29WL3h1?=
 =?utf-8?B?c1JYcmllcVZRR0Y4VCtrZjdJeW1tbm1zQVMvSjN5WkpuSXdtVEVEd2o2WmRZ?=
 =?utf-8?B?MFF4bWJsblhlbW1nOHNMU0VFakxGaDArV0dGZGtvV1dwc09JcTVCTkZ0eDJK?=
 =?utf-8?B?cVFuczhBUFVtNVpzbFpEVGpSYXlHM1F1OTZ2VGNJZHJUUGU2UUJKL1V6TzRD?=
 =?utf-8?B?VjFmKzhRcnVZV2Y5Sm5LcElnbjF2aTgrTU9NN3luVUt5aW9FY3hPOFdIT1ht?=
 =?utf-8?B?WUFMUjRjaVJBVWZrb2NnMytjOUhNVHNnRnRYNjdFWVdFMkRhN2kzR1lYUm8x?=
 =?utf-8?B?cjBITWptRy9IUTA5Und4RjhDVk5veWFYK2R1U3NvbXZWYWtMUUYybUp6NS9H?=
 =?utf-8?B?c1JRaFRTQWZwUTdzaEVzNnByRUtSOVQvTDJaMEFPRktoMllIclBsTXpwelcv?=
 =?utf-8?B?d3pmN0VBbkNrdkF1QWFmdGk5Nm1TQUk2VjVwRk9CTHEzN1FQNTFxa1FucnF6?=
 =?utf-8?B?REdrWm1zbWRlZlhNVmorTVp1b1hJWnZKcnRaeXlISzZIWnJLckU0N0RzUlFO?=
 =?utf-8?B?eUVXREZ2NFY2TEdQNTRrZDhvR3cyNm9VS1YwYXdtMmlILzhCU2VoZG16eG02?=
 =?utf-8?B?ZnVyeUtZMFpSR3pnZVdYUHNJOWJ1NW1DUTlpRWliRC9mT1hGQU9zSzBXQWFE?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d425d2e3-d009-4666-c815-08dcd28205d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:51:46.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu8L6GMD9DAWZMsMInbIfx3FfvI6Furfy6YGFujo601NRbEDa+ix7KI7OqfcKgHyIr+gytsb0J4nqpRb4MF3yHtQJsluH3gQP2WXpZFglIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com



On 9/11/2024 9:55 AM, Taehee Yoo wrote:
> The tcp-data-split-thresh option configures the threshold value of
> the tcp-data-split.
> If a received packet size is larger than this threshold value, a packet
> will be split into header and payload.
> The header indicates TCP header, but it depends on driver spec.
> The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> FW level, affecting TCP and UDP too.
> So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> it affects UDP and TCP packets.

What about non-tcp/udp packets? Are they are not split?
It is possible that they may be split at L3 payload for IP/IPV6 packets 
and L2 payload for non-ip packets.
So instead of calling this option as tcp-data-split-thresh, can we call 
it header-data-split-thresh?


> 
> The tcp-data-split-thresh has a dependency, that is tcp-data-split
> option. This threshold value can be get/set only when tcp-data-split
> option is enabled.

Even the existing 'tcp-data-split' name is misleading. Not sure if it 
will be possible to change this now.


