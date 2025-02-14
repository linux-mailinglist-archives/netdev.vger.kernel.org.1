Return-Path: <netdev+bounces-166372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB58CA35C0C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C2B3AC004
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7B257439;
	Fri, 14 Feb 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixxDu8B7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05615198D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530788; cv=fail; b=qjXZhifQtNEIgYOovbAjxuL7JgqTbUIYsudO+mGYiV63kHRJYby9KmIwUpYBhI5KzfrYyXoXmpN1s46r8pQ6iDTi2uSWGXNntQXhyqrvUNkSMgKptQlqE2JlZuK6HYOxDm6R634TtKXFreNU1kj2I22GrhWzXTTQ0ek99DnEujU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530788; c=relaxed/simple;
	bh=kLwX5+6Do1asyQa9+AK5HCIPtRVrtXZSHiJlLxTWfO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bmEsSwMNwXKWNLnlPrMk3+58UWja0IP3faewkzM5AjzycTqLg6LLMquw/Ga55r1jd+37IAqqPQ6ED35eZnizn8eknY0Klmy8xvICljV5IPgvAZo61wx4J0ZzXI1shrtYCbzlmdSMy9Pdz6d1F6ZhbYtBv515YY/evPL2N/G7viY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixxDu8B7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739530786; x=1771066786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kLwX5+6Do1asyQa9+AK5HCIPtRVrtXZSHiJlLxTWfO4=;
  b=ixxDu8B7fji7qgx70GPArknJm4jliLs0T3uRkuZE+Tf8T2CU0HMkwKBl
   0pl6pi+uOeNb/pmzcK3BTzbss910SOpjSHjNOP793/AcCwO5q0/YHx5xr
   rvpf181GLmw85gb0qMvBaQqiKRtMCgRrjQmacHrtwIcnFx4QOSSNFLi4g
   CpOpVdW+y7lnDUwjI07MLjHQTXImq5cKceIPJCabCFiERMH1hP3oyQhLx
   3Iw4230MM0y/2mk76wtQub9ZggYHO5SSoAj4Roi29vTLxuEwGzPDnSKRc
   YS+NgeTfultGfa2aVqSYcScJwO+N4RaEDb0p7mHnEEZPR5Zaf32TFU/73
   w==;
X-CSE-ConnectionGUID: H1Am812+TwikWEbvxxih5g==
X-CSE-MsgGUID: n69i/RoDSka0ZvNpVlxJYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43112941"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="43112941"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 02:59:45 -0800
X-CSE-ConnectionGUID: fJ3e2aedRYWmhVb+hDu61A==
X-CSE-MsgGUID: tOK3U2p8TpSc/5O92geSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="114069908"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 02:59:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 02:59:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 02:59:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 02:59:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj68/5nKVryj3jBkX0N8eMdZ1FOGjK8fNu0myCcikY0Y+Z3twbsoETh0EMDA3LApZcQZYmYMsLxGsUnRG++/UKYETDxnsuCq+kRaFyg5U2X/qAfUE8xBfsOkqPVnGrgfFvO/u2Oumw+27lMz9AyCeKw7EXAShYmSu4/cQJQK0e0N/XxS3XOMuSvdFiz4du6zuhtSe8Qv2FIesxJGmmGRyedl9lXXuhjNodd1vP83eWfBGVhgGMA5VW5oYSwRDi1rh7lnLyUwLUHYwiVwrQ/j5JM4ig5KkaNMwfMEEt4lAkhEU3YsW2NZsJ7QotmnjjPC5dIOnkIEk2+xxNCEpA3XGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y9CQ/hUQh/cGe+5a5fXF+haaYElxKFONJJacxl/fIs=;
 b=TK4pkO/1T43wN2Fqtf6YfBqwFehZWHEfQgmg2PlD/7A+gNWssXZLT+gWuSWoH2/5LQbm77PbRL1FCF2b+BMB+brO169GFVSWQiAJ7npFTXGBkabF9sdtm1/7iD/c3HxTFvo+vCMSgbImfTphvUtuE6CGv82aGrJHroNQ21QsvJYWfUWE/zuldu38S5p2J9IphXhQo0u5N3Lcj/Wx5tmvb/DK6gc0suDS8+ayh3AmW7nVgDVZK+zPCAeX4PVsj0vDlPS1VZRBD9bQ7Wm302jmCOs6y/uDzY0zYbpv0zYeDRCI1vBHywdnpPE+uPovY6tqA9nJWpynftlgqumNmRYugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 10:59:09 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 10:59:09 +0000
Message-ID: <fa4d7341-7e88-46d1-befb-1c18bd689701@intel.com>
Date: Fri, 14 Feb 2025 11:59:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: remove fixup-related definitions
 from phy.h which are not used outside phylib
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f090bdd-091b-4dcf-f918-08dd4ce69b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXNRbGdEelpDNFFpc0t4aHpsa2tFNjBsNTNOUDcvbTdhMWJwVTJUK0Y5VUNB?=
 =?utf-8?B?YkRTdTVKMWo2Mk1wOEgyRW5LeGRBYmxXQWNkbEFyazgrTTBsaDI4cDl3endi?=
 =?utf-8?B?c25qNW5helQ1amJKSVFCbENJTmtoTkM2M1hBR2w4VW0rc0ZTM0NVemlXOG5s?=
 =?utf-8?B?aHZPL01oODA5VEIxUmduVGVNMm9kRzRyVnUxaXFkMWFIV3pzNnF2dWVrZGpJ?=
 =?utf-8?B?L2hFR1pEWHpNRnFqOXdFNElEQjlSUURVZXpFK0ZUUGZjeWxoeWdGa04zajVI?=
 =?utf-8?B?blNFVnR4dkJVRkRXblp2bWJFakQ1RGJLYUhqb1hwY3M4bElsMzJZRnlDOU1l?=
 =?utf-8?B?NHZNS0J2dFA3V08wTThtREprRTRrelJuT2U4SElrN09Vc0E3bEhPMmpMWEs1?=
 =?utf-8?B?U0k1SDR5VzB4OHhkekJCVFB6Qzd6Zm1nRU5rZWMvd3VVeGgydHZrMFJyV3Zr?=
 =?utf-8?B?M01EQ1d4bWo2VGg2d05Ma0xoOXcrQVNXcG1wdEwvNmFOaGtSTTF5alA3OStK?=
 =?utf-8?B?K1pmSm1XSFM1VVdCOUJDVkxuODFKVlUvaWF6OTZXeWozd003ZE45cUFNbUlq?=
 =?utf-8?B?cGsxYTQyWWxzdXlPSzE4SmorcTZJbmw2ZFFKUFQzTDFOTVpiOGpZb0xYaVNP?=
 =?utf-8?B?U0RNRW81RW81VE1DMEFGS2pjMGJlTGpZNVFtR1lLd0FPcTNmL01ReEgxTXZN?=
 =?utf-8?B?NEdPR3ZXUXoySTZmZW9YT1hwaVRrTUJWWEhOckN0RjMzaDRFbTZDd1IzZmZz?=
 =?utf-8?B?WUo5VTRCZkpud2hOLytHUG9NZW9wVlI0Y3JrZ0RHa3phOTNDQmR5dnUzYmhT?=
 =?utf-8?B?VXJ0Q0tXUC84dkNmSVhHTklBVGZKWGNHaTcrYmNZQ2FkT3JYR1JPQmRsRFVn?=
 =?utf-8?B?VVlZc1p6dXl6RngxTkI1NDlRKzBoUFVHaW5BazNaTW03WHcwQ0NIbTNwMG5r?=
 =?utf-8?B?TGUwaG1pY21rK011ZytnV3R3cFoyMno5QXV6UE54aUFsL3pxUDBCZFZZMFli?=
 =?utf-8?B?b3lNYndkNUJ2YzI3Tk9mdzlkWGdHeUtySnBuTjZFdEMwNnppcFU5Q1B5VVhx?=
 =?utf-8?B?cFNYbm9OR0Vac3ZHUkUrYTdodGplbUJsOHNlNmxLMGZZNVFjRHJlMFo1Tjg2?=
 =?utf-8?B?U3cyaHhZc0pId05PZjZMZlNWQ0FMeENCNlFpd1lYcEhmck9aMFlvamxIZFQ1?=
 =?utf-8?B?N2M2cW1Gc1J5R0QydFBvV1RwMW0zODhNeTdlYlVCWnd4VVdpT0Y1QlFRUFhl?=
 =?utf-8?B?WnhFQlZuU0IrNGREWWF2cHpwZjVad1hPaUp6bkVNMUI1RWRxZCtTbW5rYmE4?=
 =?utf-8?B?UnowM1BjY1o5azFQUjZZTDNaOHNRakZnb21jNmtrS0JmOTYxRlc5SkJLV1JQ?=
 =?utf-8?B?UVNBMG1rclBRMU9GMGdDUElmeGRsaHpRTXRJNzBHNU8zMDdMQStGK3NFRDFH?=
 =?utf-8?B?UWhOVXZqNW1GVU9JMytORUo4bWlYYSs2bmdiVjFVaG9UM3gvOGhaQ2hXbmtx?=
 =?utf-8?B?RE9weFFSZXQ4eitJNjV2SFdDbWd5UVZtYnhoandoNHVsRHd6U0F5RERQNHFk?=
 =?utf-8?B?RE43Sm9aVDIvc1hKQXVMekRPejVlV0FDcHQvWW05ZmV5a3c3ZFYwOGlwMXpz?=
 =?utf-8?B?ODhXYUlwc2Q0cndLa1ZQcDMrZ2lKVkx3UXJBSDVtbzF4Y3FVc2c3alVnU0I0?=
 =?utf-8?B?Q1V0eUpEZ3RaSFNIUUxnL0hUVytUTjZQMXRvT29WNEthT1N0NHFRTTNOdWZm?=
 =?utf-8?B?YVlYd1htQjVRQUE2KzJUcUc3RHpvbVVHY1dsSEszeVlZL3l4OXMyRmhlYlZL?=
 =?utf-8?B?ckNLZEdIcWdtbUF3cEMyd05KTXFyU1dPNTRDNUNqWlEzVkFMa1c3WlR0YUhn?=
 =?utf-8?Q?WGl6F4bG9ySqZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG8yb2N1eERyUVNpS1FFRVg5UTdKWlNSaG9RTlhwUDJTRTlVdW5OU2Z6SkEw?=
 =?utf-8?B?Q0loL09IRGpBenQzcG5wbnRFbzVvTmtsVmtoTXEwbEtwYlN5enhNM2Q5Yzhz?=
 =?utf-8?B?U01EUnFhRVQyeGo2b20ybmVnNUptZ2p0ZWxMK3h2ZWV0YWJOZ2gxdmNRUjRP?=
 =?utf-8?B?N2hvOVM2cDRIclF1b1dhNzdMZGY2TlVxWmV0L0s1YUNzZUh6MkFyRUR1Rk5O?=
 =?utf-8?B?cGU5RnRJT2htMGo5UDlsTDZ4bVpnYnR6Vi9CUFloS2xzUGVOdTJTUE16cHZY?=
 =?utf-8?B?a29BTFNBejVsc2J6NnI1akpzaHZDTFh1TDRjZ1B5ZGJ0aENTTXo2VlF2TE5Q?=
 =?utf-8?B?MmhsUlVqUTlxekhNb050OVZUTElKaU1jV2RxWFNuOGhQa0NaRXpkS3pyWElo?=
 =?utf-8?B?aERIY0ZaS1JLRDFZNDFSQUQ4UUlvREJjOU9tUlFuNWFidlVBRHN2cVIvSENI?=
 =?utf-8?B?SUpsdExnZzhwdDNCYzhRb1l5SVRWOENQdUdSc1ZJMTNxQjd5YmJRTFFLWXBl?=
 =?utf-8?B?UTBRN0RVZ1lqMW9QY1cyVzZvQ1RWeC9wbm9GMm04a25ZMnpQbWhDMHlVeHBF?=
 =?utf-8?B?SGgxWDlWWUxGVVpKYlRFNnh0NGhNRzA0V0x6QmE1bUZqK0JpZld6WnIwR3Nk?=
 =?utf-8?B?VjRNTWkrQlNZcVNoUnZBNTk1RGtmOFZRRE1Fa2FCbXZUaWhNOGd0UmljQWxz?=
 =?utf-8?B?R0xyemVWZ2FjQnV6WDdUYlZadWNjRzJFSW9JRXpqczA2YUpPcnlOeWkwbmJp?=
 =?utf-8?B?dXJDcGRWWTI4MVYydHlnSVFkWUFjTjZQbzZQUGV0T1RVV2k1Y3hJaXV5SnFk?=
 =?utf-8?B?VDNhL2s5aCs5YkZwUHRZQXFFUXl1KzlwSlpTWjFVOEtrZFFyV2Y4cS9wS0F4?=
 =?utf-8?B?eTY3WG5SeFJpRWE2ZWc5VVFmamQzd1ZhUnZHb1d1S2h1NlJjSFVUSXFCbExn?=
 =?utf-8?B?RmtCeUUreVo3aFdkM29raUVtdnBIMEJQMU5HaWxIZ3AyenZBNE8wMmRIUlUy?=
 =?utf-8?B?OFpKV2Y4L2FCbDBMT1N3M3cyZWZJdHVDOEtlbkdFWGVsRTRwYVUwbytQb1Nx?=
 =?utf-8?B?WHQrNVVwVkcrTlBnTDYya1F0b013ZGhzNDZYT3JkUkxjbExxR0tvKzN4UVhs?=
 =?utf-8?B?TGl1eTJNc1EzYks1ZmwxdkNXWW1sUFdYV2Y4SHB2VithcnpBeTJWWUpUQlVs?=
 =?utf-8?B?UEExYVk4Wkt4MjhUYzJVRGxUVXhvSkJMNEJiT1lIT21jUThhVkE1cFo1VnM3?=
 =?utf-8?B?MHdVRStHWHNJazlLNmFMcHlSK1Z5YThGU3NoSE1hSWQwZ2ZLUHhzdnF1ODQx?=
 =?utf-8?B?L1kyK1lZSW9ONlF0c2lwSnovdTY3VGNoNGREOFNMT3dOekJ0QTNrRERHN1lo?=
 =?utf-8?B?Wkd2MU10aGlPV0Mya1JCV1o5TUgzWUFYYWVxdFdwaThscXMrVU1zVGphYUxp?=
 =?utf-8?B?V0g5QWxaYVFBaGp5NVpCTWlHOVhnUkJiRE5kRnpJRUZXeUFtZDU2UXdaREJl?=
 =?utf-8?B?bUdhdXpueW5xQndVYkFUUTZ2bDhDeXFNc3Y1bzUzOWY1anBNeVhkSVJvZm5U?=
 =?utf-8?B?QkJMYmdYS0dlaUlYRW1MNDJoOTFoLy9EUXQwMjN2dWMydE5tNzdFdE1wa0lX?=
 =?utf-8?B?WHU5WXFuNUZtVVR5UldBSHVSUVI3RUJyZlVQTGpIayt2RXlVdTREak5CRDJj?=
 =?utf-8?B?ckxaeS9TYVhvbzFvNkovMHdXVmx3U0xEcDNGOUZKalpOcUw0RzlaR3dvS2NI?=
 =?utf-8?B?TjFFUTh2aE9ReGRIbkFtME9hclRlVDlyR2ZRSDIxUkpoaGltRlhSamZIeWxZ?=
 =?utf-8?B?VVFlcDhvUVRGMkg0aHkxamdjWkh4SVFTTUtFTHozazd0WVNMOFNkYWxrcTZQ?=
 =?utf-8?B?Zm5jNFgxQ0czc0I5VnpXMUhVenN4dHFFQzRpVmEzTUtYTW01ZW9jNnpFQUZG?=
 =?utf-8?B?Wlk0YXlPelk2QlRKNTlSNy9HM2VRVjM3UGswRnBRZzljSFNDRWF3WEtYczE3?=
 =?utf-8?B?elp5c0lrL3JmWWJVSGNrazRYaFBiMzlJUVJYYU9McERHTDViUFNiL0hzdnZB?=
 =?utf-8?B?dklteHV6Y0NmVzUvdm9qZ3loN3FjbXhzemp2MnlCNFVoc3RJS0x3TmRLNjVF?=
 =?utf-8?B?Y1dEZnR6OGFwVzV3Vm1PaXh3Mk80SUpGRHhhTVd4WWUxNFF3UlJPRGNvOTEw?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f090bdd-091b-4dcf-f918-08dd4ce69b98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:59:09.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp7wB89+Shnecsc6NnMNj0R9j64e+c6QDSNxW2d0YydGVDgxJi/zHQS9flOu8zeol6O/QwiPf1GilhEqwN6VYalMe2EQvPoa4tcpydq0w7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-OriginatorOrg: intel.com



On 2/13/2025 10:48 PM, Heiner Kallweit wrote:
> Certain fixup-related definitions aren't used outside phy_device.c.
> So make them private and remove them from phy.h.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/phy_device.c | 16 +++++++++++++---
>   include/linux/phy.h          | 14 --------------
>   2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 9b06ba92f..14c312ad2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -45,6 +45,17 @@ MODULE_DESCRIPTION("PHY library");
>   MODULE_AUTHOR("Andy Fleming");
>   MODULE_LICENSE("GPL");
>   
> +#define	PHY_ANY_ID	"MATCH ANY PHY"
> +#define	PHY_ANY_UID	0xffffffff
> +

Overall looks like a nice cleanup but I am not sure about this space
between #define and PHY_ANY_ID or PHY_ANY_UID...

> +struct phy_fixup {
> +	struct list_head list;
> +	char bus_id[MII_BUS_ID_SIZE + 3];
> +	u32 phy_uid;
> +	u32 phy_uid_mask;
> +	int (*run)(struct phy_device *phydev);
> +};
> +
>   __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
>   EXPORT_SYMBOL_GPL(phy_basic_features);
>   
> @@ -378,8 +389,8 @@ static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
>    *	comparison
>    * @run: The actual code to be run when a matching PHY is found
>    */
> -int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
> -		       int (*run)(struct phy_device *))
> +static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
> +			      int (*run)(struct phy_device *))
>   {
>   	struct phy_fixup *fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
>   
> @@ -397,7 +408,6 @@ int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(phy_register_fixup);
>   
>   /* Registers a fixup to be run on any PHY with the UID in phy_uid */
>   int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 29df4c602..96e427c2c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1277,9 +1277,6 @@ struct phy_driver {
>   #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
>   				      struct phy_driver, mdiodrv)
>   
> -#define PHY_ANY_ID "MATCH ANY PHY"
> -#define PHY_ANY_UID 0xffffffff
> -
>   #define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
>   #define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
>   #define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 10)
> @@ -1312,15 +1309,6 @@ static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
>   	return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
>   }
>   
> -/* A Structure for boards to register fixups with the PHY Lib */
> -struct phy_fixup {
> -	struct list_head list;
> -	char bus_id[MII_BUS_ID_SIZE + 3];
> -	u32 phy_uid;
> -	u32 phy_uid_mask;
> -	int (*run)(struct phy_device *phydev);
> -};
> -
>   const char *phy_speed_to_str(int speed);
>   const char *phy_duplex_to_str(unsigned int duplex);
>   const char *phy_rate_matching_to_str(int rate_matching);
> @@ -2117,8 +2105,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
>   void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
>   		       bool *tx_pause, bool *rx_pause);
>   
> -int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
> -		       int (*run)(struct phy_device *));
>   int phy_register_fixup_for_id(const char *bus_id,
>   			      int (*run)(struct phy_device *));
>   int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,


