Return-Path: <netdev+bounces-104240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E390BB71
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C1D2849FA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FA1741D7;
	Mon, 17 Jun 2024 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cusTUBIj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903CD53E
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654056; cv=fail; b=IzTl81LiqbdjlN1U7w1buYM76x1+XeRuWDtKLfIlTk7Wm/tOXObr7CDEpZwnMF2Kmf1cuIKgjejXnT2JDztGtVdUNeoSazIWnksG0l/0qeUOYAMhLJneVA1ulB5SVQQhXBGAxZF3hPfgQCwi42pAtPrqB8U0e87XT4KCsgY0XUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654056; c=relaxed/simple;
	bh=Wy6Oh67ai1dPu20ptgqsYp2O0IVWMoiHg/1KcQZ4quQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iY4aV2/qqkFkICbiXIYB8OeTDFZZ+rC22r+7x1REe7KjhNiPxQBLBUfbatrwbLiR1MmpqStj2U5Qg3PLU7wb1p9LAoQMdXb1UCLstZ8djokHnPzIA9oCo6VYY6T7YwXrm05q0VnTDCXj+gp0FtNN/MaVo5NPupGtUx/vVKaHSvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cusTUBIj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718654055; x=1750190055;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wy6Oh67ai1dPu20ptgqsYp2O0IVWMoiHg/1KcQZ4quQ=;
  b=cusTUBIjTThyTlWs0XtE+YJQtt5Ir4+FWAreH0Hwd6FqzxGJ2f6GlzwW
   NSdJ8Ab4eXzn+vOYZZGxgc4a8lvz9dQ5dLAFSpiArR/r0zk4Adk8tovSa
   D9uwci3xFm7uSGfZ4f21YnGLYm1JWqrv5+HAl3GevUS9nKRYyg8S8qOvQ
   4ys07KApBwMBrc4/D2rfuwYfOrNZ13DdR34q+0tjPXb/BJdWzdcEnT5Q1
   Kg/vWtBE0OiUFWzZgDIddM2BP6yod/OZ7H72R7lyQqtVtbF9m7dJmN1SK
   TkVKqleZRzdO1gzDvg2FfZqdEYc43wfPgISCBUdj6p+eQ3UxMx8Kui8sR
   A==;
X-CSE-ConnectionGUID: B+hWbWesQ7S+Q64pmxe9lQ==
X-CSE-MsgGUID: cu06jCyWRieDd5Xk4xTmNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15629625"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15629625"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 12:54:14 -0700
X-CSE-ConnectionGUID: 1ryy9Jb8Q4Ovv9MM039+4A==
X-CSE-MsgGUID: J42nZdIwTyOJ8Vw+TKh8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="46418449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 12:54:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 12:54:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 12:54:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 12:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKY6J118+cSC/WNNAd+BbfIv6LSjH/JEgqVC95MhcUxnP470xZ3LQgzchYN64dgfotyFEzLBZD3MR/vhnc2YFIjdIevmKjaaaGl+pJy3fpBQ/65YEFyYO4UpufuTja67LqSQVSIP82aRxjNUSGP0UZHya0o637Rx7kDQgvPHi49TMN83u1jkw6VVuiDbH8/NPln5x2M2FECHaN8kH+v8S7dwiK54CgfYWtHj2KA6npXOyzmnFYLYaDNwYIIxTOtSx9H8KrdC9MwcczvEV7gqkjS/TRYSJ1Hgcetx5a9flaz0NYYl/EH1UNefLtetggy4wj1VygmZC6F6baKsZAwwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTckoTNvbC71P/TUMLWfa4wEVcX9ILJATE2k746Z4XQ=;
 b=hs0BsxWvbj0I7ZE6RT77qQ51n0XI95QKPGJj9Q7O19izyTZshIi24FMGuEMCQxKiXJGx/m3Os/5ClLaqavVdiAwH9jjszeWZRTrh2O3eBYJ5HYgzdW8HxrItLHQUmYPNCtJg0vPoqFPb0ilaW0af5pP85gKu0nBWVyH+e+eLL/53H1XgNMtvZItvogpGfCye+4B9EFx9TnoPeroj7JDk0FZqczA8QIFl/bN71QL8qEuNDedJuw2afejcvwjr+tbOkOXYu+pMDz7lmuVVuePzkHDGx9MI0JucxJAaWVzCzV3ljFGp/RpZThf3jB1J6zr/AkjvPlh0+8vdJdg12qW0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 19:54:06 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 19:54:05 +0000
Message-ID: <d3c8f29c-22ca-4ece-8beb-ed14587bcaf0@intel.com>
Date: Mon, 17 Jun 2024 21:53:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] mlxsw: core_thermal: Fix driver initialization
 failure
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Vadim
 Pasternak" <vadimp@nvidia.com>
References: <cover.1718641468.git.petrm@nvidia.com>
 <daab03a50e29278ae1e19a00a23b4f73a9124883.1718641468.git.petrm@nvidia.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <daab03a50e29278ae1e19a00a23b4f73a9124883.1718641468.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::20) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 127ac092-0bbf-4381-9f2b-08dc8f073e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjdhTDhIN1JQb1YrN1pUcmtpUGFjaWJHYnMwV2hsVUxOTURaL01ucE5DSkY3?=
 =?utf-8?B?SEtSazVqSUlXMXdVTEYvaHRqYnFBUEFCQ213NXAvVEMwSEVkN3hndVhlU3hC?=
 =?utf-8?B?ZkR4Wm1EY1NEc3hEOHN6dXdoYzFLTld1NjUyRWxvV2oxKytTdXJoSFJ1NWFI?=
 =?utf-8?B?UWNBdU42SThMZUFmeU5UZ0ZYbno5bTY3UHppMTNLUkR5amcwTVZBaDRNeDFC?=
 =?utf-8?B?V2lIdTAvRHgwN1I0LzIwRXZLOVVVcGE3b1pKQnk4N0VFWXpnZmtlQkxQTlBx?=
 =?utf-8?B?aFl0MUNEYWZiV3FLQjVSMTJSN0lzK05uOEIxTnNLZWxmWktqWVEveWJqN0p2?=
 =?utf-8?B?RjlGcUVzaUZpWE1oTCtsUEZyTzhRY2YvSFB2bG1MaU5SN0ROM2twWEtmaWMy?=
 =?utf-8?B?Vm9YZE9CcWkvck9yQjhMbmQvZGMrd3o3Zm1TN1lGVWYxSEJ5WGUyNG9kUWo2?=
 =?utf-8?B?d3FxTHNhVjZocUNuU29KckZpbERwNkJPblZ6aUsra3U1eFVVcVNBd0NVK1hJ?=
 =?utf-8?B?ckQwcEZ3dDhWMytiRUYweTFsSmhGaG9jL3pYc1J3K0NEMXphRlFtVGxxTmFo?=
 =?utf-8?B?emFQdmRPNGo1K1h2eHArNGIxV1RnSVAxMy9IeEJtUnU5eEpBbTZUaU5tRFZZ?=
 =?utf-8?B?c0RydVBORS84VVdOS3EvT0NYdVhUaEpZK0xacVdWVjJEdjYzYndWVkpMVjBQ?=
 =?utf-8?B?NEt3RTJBdWhyOHE5SWwzQmNFS0FsRnVCbkttMFNsRFNWWG9uelk2RStvSmR5?=
 =?utf-8?B?VmZjcjJmVTh0M3BCUXdranhUeW44Wm5jTUNWWlhoN2MrSWdsVzAzT1RMWVdx?=
 =?utf-8?B?VmlhQ01JUDFZV2ZDVkRzSjdET3IzTHBtOG5RODRMTXdVbFl6NG5XZ1I4QzdD?=
 =?utf-8?B?UXBacHladFpXTFY3MkdUaG5yb3FIcVRhb3g4OWpmb2dHSG16YzRNYzkxR0ZL?=
 =?utf-8?B?MlhWSCtVeERHM1MvcUhPMTdpNlFzMnhZMGJOdTMzREI1NWxBdER2bnFjMkFO?=
 =?utf-8?B?WXdmT1IwMDg2cUkvQVlDTnJmQktmbGhHZFFrd3lmVHFleTFyOXI4YWZ6eFl6?=
 =?utf-8?B?MWFieVBNdlNocTNXd3BkenJVbit4bHVpVkMxTVlVZUIwaW9udXQ4T09CbmNi?=
 =?utf-8?B?SkkyUm1DUUJJVXZ6dUtxYlc5UDFJN1QwNExaQUo3RXlSV0lHdW5qdjNwMUJn?=
 =?utf-8?B?NWpXVUJjeGdqTG5GOERCWXJIdWRsN1BlNXZKbkVMcy9velVWZHB0V21wVHhO?=
 =?utf-8?B?bGtNY0J1M0l0N1l2TmF5eVhnQUIya3IxZktqYUQwcGN2Yk5MdFZRQmJId3BJ?=
 =?utf-8?B?Smo4N2h5c0VpbWY1RGJtaFhBWlovUFM0UU5DckltUHdyK2RKN253TUdldytj?=
 =?utf-8?B?UzNwVWM3K0NIa3o1SHZZQmtRR1BpaVVyNUEzS0NxVVlEbXNEOVg5VTNjdyt0?=
 =?utf-8?B?aDQwclZJd1FaYWdHMGxNcy9zUDdzZHhHV1Z3NVRob2JtdEwzWjFzTTY5c3Rj?=
 =?utf-8?B?RE90RXd1c3ZHd0ZnZkJUUVR0QnZGeVNTWXRLS2ZTLzE4dGc5Zm5vaDZPRGkx?=
 =?utf-8?B?TVhSdjBQOXhRMkVQVmZxYlcvd1krYTNjbFNmdmlHOGZzR2NZbVRuaXJ3cnU1?=
 =?utf-8?B?VmlGTjF6VWhVY2VsZ3phZnpTM2xtVmd4ZjZKZVpuT21XaU00aGFKSUdvdlJD?=
 =?utf-8?B?d3pVaDdiaTFzbWZmNHJsdEs1OHgvMlYyVG10bVVsNW5IOFNVcnFLQ2JPa2Vv?=
 =?utf-8?Q?o0bXZpNfLm/CyPCFUU1n/12U7aTUX+AI77VKYcf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtLbkwrUS9xTVl5U2RvdUovRFpVNTZvZ2NaN0lYS1ArVXNCeUpWQnNRcVhy?=
 =?utf-8?B?U280TUlNcGMyUm9zaDNpcUUvYTNScThqTzRuY2MwRE9uN0o2WXVVMVYwSzNE?=
 =?utf-8?B?L2I5QVcwb0lHNWxabXA3T2U4dTQxTnk0MVJSNW5Td3RPM3BvaVNkaW5ZeXdB?=
 =?utf-8?B?ZmtFOW1WOEFrajBBSWdQV2Jid0Vydm04Z29WbDhSY3dsZTZhTjRuYmx1REVY?=
 =?utf-8?B?ZXNpTHZFSE1DdzU1aldtOW41QVA0YUZsQ3hlRjJUdzdZcDI2UUNaYUZkaUgx?=
 =?utf-8?B?QkJENnlJZ3ZCMkx4cTlPWkJHVURIRWxyd3dzUU14bndjZ0FjVXRkMEZHT09S?=
 =?utf-8?B?dE1oSTY1dXQ3ME5vZ0dPLzBUa1ZTLzR3Q20zN3dBSFRRMVh3UENzc2tQK1lC?=
 =?utf-8?B?Vjh5ODhCTWFqUnloMkY0MVhscVVJSjI3SXB0R2IrQ2M0c3NlUUxaeUtIais0?=
 =?utf-8?B?QmtIdmtZRkZ6QmdadnZOdXpaa1lqWTlwc1BtMXZSeVJleUlHMWw3NUNaVDBN?=
 =?utf-8?B?a3NrNDFVL3Y3TDNZVnNwcFYwb3Q2RmxPZ3d0VG1uc0FieGd4Z2pBZUkybG1n?=
 =?utf-8?B?T0hMN251ZXgxaW10TkZQVmtWZmxqeEM1SExBY3U0QnlxeG16eFk3aTllRlZr?=
 =?utf-8?B?eXExblJTeFIwb2w5QjA2TTRTRWpUR0ZEZmNMMElzYUc0c2xhSC9VQXliYkxh?=
 =?utf-8?B?QXNMRUFXQzRWRmE3UllIWW52aUFRM2lGZWt3NldXY3pvd3NtK0R0dVJNRFdQ?=
 =?utf-8?B?VUYvTVMzMU1ncXdUV201MzlpZzY0ZUlsWllWZHNuajJMRmtzUzdvcjd1Y0RF?=
 =?utf-8?B?WjFUOS9MUCsvbkpMRDZQczNDeFZGNEJzVlZBRnZjWUEzaVYxVHF4cnNrdFlT?=
 =?utf-8?B?QTNSRUFMeFBRZk5TTE13Z1hsR213Wk52RjVwT3lOTm9WZEZ4NmpHSFpTdXdE?=
 =?utf-8?B?YVV2SG5TT0R0UDZJZjVwYmtvcm80aXRpRFRMRE95ZzdPTWIzaGd5Y0lua09v?=
 =?utf-8?B?a0VwSytlUHlvQjdKazJ3eGQ3Sm5aakZvRHVEWUcxbmYwaXZwcFA2dk15YVp6?=
 =?utf-8?B?WTR2YWlnUk1JWkdIaXA4VWRRM3psSXFTVGdKNFRxWHVwRnR1aUlLR0k4WUc4?=
 =?utf-8?B?UDBsUTlsNXpyL0h6WklPUEpJNkFzMVh1cG9TU2dabG0wNEVvbEhvb1l0RFVL?=
 =?utf-8?B?aUlIMTVMRjRkWS9wVmdhVHdic0VYUHJxZFMrRVl6WWEzSVE5SXU3dmMxdzQy?=
 =?utf-8?B?L2kvNmlhY01JdXlxaUxiRTR0YkRKTzkybU50bzY2SVJKelZMazQwRkZyQWsr?=
 =?utf-8?B?cnZYZVJuN3BUdTZQWERoSWkveEYzUGdocmIvbjUwNTZkUGl0dHczblV6bWFN?=
 =?utf-8?B?WDUxQTRjdytla2JyZ2lSQTdNenZHSTdLSUsrYitvSGZkaGZOV0oxendPYm5Q?=
 =?utf-8?B?VTlkU3lMdEszaHROK3JMTjRTQXdQQ052aHo1MnFjR2RVMTBMMmVxZW1lczNN?=
 =?utf-8?B?V3Jkck05TlVNaEFESkVQNTVIMFd2eEZIWnM3V0JMbFl5RVpsdStiUVpHNkNl?=
 =?utf-8?B?WDNFbFVnb2t6ZytweVEvZkNzSTU4bkRYdjdHUFFlOHBPRTd1Vk9VU0NCN0li?=
 =?utf-8?B?bi9FSjNBejJYUEZjMUwwQ3FTekhUVjBPZDkxZ29IeW9jSzNyL0dQSXM2KzZR?=
 =?utf-8?B?RVZvVnowNGcvV1IxVEhnUEZmQWd3WWtVc2dHQ2NSajErN2MzdXlpbTBYYmtJ?=
 =?utf-8?B?cEd3TWVtWG81d3ljQjVPSTYvckZ4c2oyblpMWUZnYVNYdU9aMGVySk5BOWJq?=
 =?utf-8?B?b3JsQ3pmTEowZU1XTXFUM0pSY0IzZ0NsblJpRzBtekYvTldGdlRLbDByYW1a?=
 =?utf-8?B?L1dkVUsrWllPUG91a0ZFdHk3ckdQeWFGSVpUTnlncndBUFBrMkxEWm9YWThX?=
 =?utf-8?B?L1J2SzU1Tk5POHlaQUswNG5XamVWTnRiSzJKdHNCTDNYdGZwaFJTSFZadURY?=
 =?utf-8?B?VG9kOHk3eEQxK3V2V2hsSU1BakM4S2Fud1VtNVVHK1hRaTNzTmFLeHk2L1dG?=
 =?utf-8?B?MDBTMjV1VFhzZUFqNXJXQ3Q0d0ViU0RObzM4Wm15Ui9tNFFaMWRhTjk0MFRZ?=
 =?utf-8?B?bUw1RFhlRWZoVElGVTB0M1FtNU5EemczNEZ5YmRHQXpza0g1djluVS9raXhY?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 127ac092-0bbf-4381-9f2b-08dc8f073e86
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:54:05.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5I39UE8kr4/9PXq8LOAqDKKzOC6eQp/AaBhXkmgRhjA35suQMGr9RHZuHi93HzFHrucNc8W3l7HY7QlHp6rVig6+s/sjbVQgXhRi+Qsc1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

On 6/17/2024 6:56 PM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
>
> Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> thermal_debug_cdev_add()") changed the thermal core to read the current
> state of the cooling device as part of the cooling device's
> registration. This is incompatible with the current implementation of
> the cooling device operations in mlxsw, leading to initialization
> failure with errors such as:
>
> mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
> mlxsw_spectrum 0000:01:00.0: cannot register bus device

Is this still a problem after

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=thermal&id=1af89dedc8a58006d8e385b1e0d2cd24df8a3b69

which has been merged into 6.10-rc4?

> The reason for the failure is that when the get current state operation
> is invoked the driver tries to derive the index of the cooling device by
> walking a per thermal zone array and looking for the matching cooling
> device pointer. However, the pointer is returned from the registration
> function and therefore only set in the array after the registration.
>
> Fix by passing to the registration function a per cooling device private
> data that already has the cooling device index populated.
>
> Decided to fix the issue in the driver since as far as I can tell other
> drivers do not suffer from this problem.
>
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
>   1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> index 5c511e1a8efa..eee3e37983ca 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> @@ -100,6 +100,12 @@ static const struct mlxsw_cooling_states default_cooling_states[] = {
>   
>   struct mlxsw_thermal;
>   
> +struct mlxsw_thermal_cooling_device {
> +	struct mlxsw_thermal *thermal;
> +	struct thermal_cooling_device *cdev;
> +	unsigned int idx;
> +};
> +
>   struct mlxsw_thermal_module {
>   	struct mlxsw_thermal *parent;
>   	struct thermal_zone_device *tzdev;
> @@ -123,7 +129,7 @@ struct mlxsw_thermal {
>   	const struct mlxsw_bus_info *bus_info;
>   	struct thermal_zone_device *tzdev;
>   	int polling_delay;
> -	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
> +	struct mlxsw_thermal_cooling_device cdevs[MLXSW_MFCR_PWMS_MAX];
>   	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
>   	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
>   	struct mlxsw_thermal_area line_cards[];
> @@ -147,7 +153,7 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
>   	int i;
>   
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
> -		if (thermal->cdevs[i] == cdev)
> +		if (thermal->cdevs[i].cdev == cdev)
>   			return i;
>   
>   	/* Allow mlxsw thermal zone binding to an external cooling device */
> @@ -352,17 +358,14 @@ static int mlxsw_thermal_get_cur_state(struct thermal_cooling_device *cdev,
>   				       unsigned long *p_state)
>   
>   {
> -	struct mlxsw_thermal *thermal = cdev->devdata;
> +	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
> +	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
>   	struct device *dev = thermal->bus_info->dev;
>   	char mfsc_pl[MLXSW_REG_MFSC_LEN];
> -	int err, idx;
>   	u8 duty;
> +	int err;
>   
> -	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
> -	if (idx < 0)
> -		return idx;
> -
> -	mlxsw_reg_mfsc_pack(mfsc_pl, idx, 0);
> +	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx, 0);
>   	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
>   	if (err) {
>   		dev_err(dev, "Failed to query PWM duty\n");
> @@ -378,22 +381,19 @@ static int mlxsw_thermal_set_cur_state(struct thermal_cooling_device *cdev,
>   				       unsigned long state)
>   
>   {
> -	struct mlxsw_thermal *thermal = cdev->devdata;
> +	struct mlxsw_thermal_cooling_device *mlxsw_cdev = cdev->devdata;
> +	struct mlxsw_thermal *thermal = mlxsw_cdev->thermal;
>   	struct device *dev = thermal->bus_info->dev;
>   	char mfsc_pl[MLXSW_REG_MFSC_LEN];
> -	int idx;
>   	int err;
>   
>   	if (state > MLXSW_THERMAL_MAX_STATE)
>   		return -EINVAL;
>   
> -	idx = mlxsw_get_cooling_device_idx(thermal, cdev);
> -	if (idx < 0)
> -		return idx;
> -
>   	/* Normalize the state to the valid speed range. */
>   	state = max_t(unsigned long, MLXSW_THERMAL_MIN_STATE, state);
> -	mlxsw_reg_mfsc_pack(mfsc_pl, idx, mlxsw_state_to_duty(state));
> +	mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx,
> +			    mlxsw_state_to_duty(state));
>   	err = mlxsw_reg_write(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
>   	if (err) {
>   		dev_err(dev, "Failed to write PWM duty\n");
> @@ -753,17 +753,21 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
>   	}
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
>   		if (pwm_active & BIT(i)) {
> +			struct mlxsw_thermal_cooling_device *mlxsw_cdev;
>   			struct thermal_cooling_device *cdev;
>   
> +			mlxsw_cdev = &thermal->cdevs[i];
> +			mlxsw_cdev->thermal = thermal;
> +			mlxsw_cdev->idx = i;
>   			cdev = thermal_cooling_device_register("mlxsw_fan",
> -							       thermal,
> +							       mlxsw_cdev,
>   							       &mlxsw_cooling_ops);
>   			if (IS_ERR(cdev)) {
>   				err = PTR_ERR(cdev);
>   				dev_err(dev, "Failed to register cooling device\n");
>   				goto err_thermal_cooling_device_register;
>   			}
> -			thermal->cdevs[i] = cdev;
> +			mlxsw_cdev->cdev = cdev;
>   		}
>   	}
>   
> @@ -824,8 +828,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
>   err_thermal_zone_device_register:
>   err_thermal_cooling_device_register:
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
> -		if (thermal->cdevs[i])
> -			thermal_cooling_device_unregister(thermal->cdevs[i]);
> +		if (thermal->cdevs[i].cdev)
> +			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
>   err_reg_write:
>   err_reg_query:
>   	kfree(thermal);
> @@ -848,10 +852,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
>   	}
>   
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
> -		if (thermal->cdevs[i]) {
> -			thermal_cooling_device_unregister(thermal->cdevs[i]);
> -			thermal->cdevs[i] = NULL;
> -		}
> +		if (thermal->cdevs[i].cdev)
> +			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
>   	}
>   
>   	kfree(thermal);

