Return-Path: <netdev+bounces-275219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFyrCH4p0GnS4AYAu9opvQ
	(envelope-from <netdev+bounces-275219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 807253984CB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E098D301E3F3
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C083D5662;
	Fri,  3 Apr 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDOkTdbV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E322765D7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249767; cv=fail; b=FA1aq6DT2BrQZVXZkSLOyajWzZpydipShDTKWKlzbn2cH/H0AGlc6CkKOzzOuayG1FSrxBhFl/7D3FNlF4mR17PkmASF0/6d6t6uuPOH/kyODuWO9fQQHixJK+W5CUjviWp+Oq3kCsHd5RLU/nmhU+Z00Ex5xfn36NYpDtM8NkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249767; c=relaxed/simple;
	bh=bgFYCOb5paAYh25KYWW8X0XRLO1fxx+4ebBwPSlPzqw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BJAZFgT5Jgw27Ynp9QGlcIgPiIylQ87L/pFG4Am4J+gArb9zdlW0wqW7B/y9d/zkwtu1OWUz87NL+fKR22w4FAkodWzAEl+mB618q2ZQ/IdDkRwi/WzIeVrML0yb7FdrN0sWovRPb6zkb13P4pEbYtz08No2Oq9sfD31Knt9zpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDOkTdbV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249767; x=1806785767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bgFYCOb5paAYh25KYWW8X0XRLO1fxx+4ebBwPSlPzqw=;
  b=HDOkTdbV6AvQpWlDeLIsNN1QScU1stw+GOOuaaMJi6u/VlWRsS8i/gsy
   c+BTeeB1cPLuAxRootmKXVEfjGIrOv7ZbDcRvbgyJj6yrBq1nPc3y3dcp
   5mevD9y64oKHyYwwK1Omg7WxWjnpSLbebOJgi25tzhCDg5z5Cbwt4feqY
   buFyeBNXLkoTi5zl3dsTqs6UzKWTRx9cBMbidpxATHHCzX8zVqkyzYqRU
   40QVHft0RVjXa1BPGcu4kEWZHKSdwW3KcIrCkYFL0pwtlJlJ1/fzdkAfJ
   o1Sern/zsOIKWsRpT5MLCYG4S839aQV5OBK9UHEObYgz7AXfLFlmg42vW
   g==;
X-CSE-ConnectionGUID: csNeFRDQQQScY0GWggwErw==
X-CSE-MsgGUID: 39UwkbyjQX+Mlq3i10YCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="98929752"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="98929752"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:56:06 -0700
X-CSE-ConnectionGUID: LaV+Y+AyQ9aERIzBC26Gbg==
X-CSE-MsgGUID: yrv8hGj8QxevCU8VQJ5Eww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227593179"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:56:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:56:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 13:56:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 13:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig2sT6lu+N6wIXe91NayEwLvxl/54OamFM5ay/D23U1T3woo4x96UGHi71xqdO2vYk5NnoRJwAdOVYHxzkr7MclJWnZcFnqcx1rIQtn5GHG+GbQqTpJaKXYwV1MWnH1v8EbaZQ9pYMpMgT5fsJU6ixRbOlvhiSQavIieGR+jHT7PV2J/Vfssko+pl0Cp0bJWbWa/lmXeMF8jcpmDcoEnXPtQAZENHlvgIuptZONGkipcxxO/X296siDV4p9GynG2r4zioXAgMBDxpzukMKQXV8UqkkpU0I/lP/cI6f8KcihBS86HiyxRsqncudVcUDr09IOfKATjTjU+JkwXv4A4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IcggvIw51VXQc5kmpojwMuyOGDxk9GgVUzRIcVqTNs=;
 b=TBnKx3UTYSOLfddhRaOSK097Wvhh92ufGnCfU3G1zEa7iS2Ik1qMz71lsO5KIvaYwwsmZ5Neln9qEeiMHIiZxNEU21vJJPY+ox+78AT1wr1KFL392oMoJXUMCbkWkMUkG8W7Vs7AtD4MzE/X/BO0YT+ylnsEiaJzkQ4ZLrYvGUOvsbRu5rIFtqV0dedEnAPlaBbf5cjJwQDlMsqGU6g0hzcFdg+LMALotHtkJgsiIC0XnJ2cvRJxjkD4K06ZBARYRlWkGmaQSEXGXDI6/o1VH40x64DvRus9g/wVlDPYf3DXAuOmi6sBXpN8lfDs1NxvQfolQCQv5XPYLd2m57DsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 3 Apr
 2026 20:56:02 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 20:56:01 +0000
Message-ID: <32168654-edbb-4fab-9d3f-025aa1666513@intel.com>
Date: Fri, 3 Apr 2026 13:55:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ixgbe: extend 5 s SWFW semaphore timeout to all
 X550EM variants
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-12-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260327073046.134085-12-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e5f597-7949-4884-7275-08de91c369ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: q3rCOPjPI2n4IZHuay5oHxl4WNQVnRMSoMOqGrP/4G6sfQJeEBLYMHBy7ssTZc0um+ft+YL/Xk4QFStZJvxZ0oa9t28hBmWtD9sOXBEYlD2ZV4pp5RUG5kuqJjzhKSgt8aHRoC7aquUjieP2uzikhGQg6rn7oF1ZYcmUwafeli7SK181Xsvol9KAqRHwJhZBAFu5ZJLDfLlrJ6fZuqYxAVe42tWrkZvxYS1Prg3I6cLqzyGYJQr/AmDpWZ77vjOHAHhLd7k7YAfkGABb3UDmI0f4FrzdMMY2sekzmVLVWOKLwMDVcpE1fz714u8IckN6NtW8Uty07c/+Ez+GK7hvt1YAanGVAFSPZnTSSh4ur3NXtdUsQMaIcEisqh4TQjdjAzdMKZ85ISGGLyueyHwNBncZBigNQ94KJv3aazxR9++mRAp7KoLjJzZTyiIgfGXv3CQPWOY8oGk2ARzJXeD3W1DcoahzPHcE8urCWs7H7bazzIj1Xyx0R1zErTJUOArLc+ODFMHWtPG77Bp4bOe3ARpa7NKgioFFnzrvQWQ/LqP52oWEt4KwS7aZpxEsfuY2H3ACmKgTA5kB+ynMz2SZnJLUp1bmrK4mXoGP1aTVAV+9aFUAeLHtBWxDOE0nDwqbOUJWK02ZQnzhl3XCt64aXObZgHpogeDFF2WF2mdGcim+eJoAl6VQFdpFVDlVHBrZPU9eCnwiKjOeOW/Xt0grLGrjix3VJZb+ebtsKp1a+Ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NYN25sakdSYlJ1SFNjM01SS21UUlJMVzN4SWJZUVl1SEtvcnpuK0F0RGFG?=
 =?utf-8?B?VG4yMW1WVHFhVGtqQVl6azhDdFNXd1l3ejdxVGNRZzZLczZXdjcyaFdtT2Z0?=
 =?utf-8?B?VHZkSy91WGgvWmlJbTEreHJJeFFOWUhQYjYrOVdGT3VLUXZDWStNVW5rSEhT?=
 =?utf-8?B?L3k2UUtsNWdzekZNazN1Nm54enUzY2NzQStkSE1pMHE1RkMrLzZxcEk3RVZQ?=
 =?utf-8?B?d2prMXExU2hSOFZ4a04yaHVvYmNrTEV0aEZVMDlVWjloQ0FJQTVRSURZVjd3?=
 =?utf-8?B?aDJVTUtkSjFmNVM3cW5PamRYS1B4YllCQ2lkQlBCSldENmNOamMyNnA0MGgy?=
 =?utf-8?B?SXZYMEJIMGxLR1dGUENRYldubTBma1VJZW1Lc3FEMVVmamRRR1d1ZE1pMWFp?=
 =?utf-8?B?ZW5PdlZvdHF6cEZqTW1KcEFUR3RBdm02Z0xKdHNlazJYV1lHRndQdlY2WGw0?=
 =?utf-8?B?Y2RkUnppcjQ0MEgxemU2U2o0UCtUQUE2QXNUYWUreUlKcC9teUN5c3pyZUVQ?=
 =?utf-8?B?bTVtSTRYcjJoQnNhRjROUnJJTjJDYWRXWlhkL0E5d3BITys2MmFyejdjTnVU?=
 =?utf-8?B?TXAwWko0S0Z4RzQxSmdmL211NTdIcXM4bnBXUmR0L0ZKNmNJYUhTWUQ0RXRW?=
 =?utf-8?B?YjhZRDJxVnQwZTFtOFFFMFBlc1lLdCsvWFprbkZldU1mVWh1ZW1WWjZ5N2tm?=
 =?utf-8?B?RWI5WVNuRVFlWFpPb3U1c2VFZE1zQzd2NWsvenNjTEdaRUIxRExpWjR1QUVG?=
 =?utf-8?B?WUcrVGU1L2txUHlJcFN6d2ZtNW5TU2gyc240dTJuUW1qbm9qYldPQmN3dlJP?=
 =?utf-8?B?QUt1ZmR1ZEhPTDJuWCszSFlwOXp2OHlOa1lGVkNqVFl4bmtPN3VwR0xiRUlo?=
 =?utf-8?B?U3Z0ZStOZ0VJbVFqMDQrK3dOY0lXWjBtWXA4c1Joekc3T2pHNSt2QUJzZmtW?=
 =?utf-8?B?VFpZdHRBOGVXd2pXc1d3WWxOMjh0cWtpNDRSbENpamw0RDRUb25nLzlVS3Rh?=
 =?utf-8?B?WGorQlhFd2pOUldQOWU0ZEdtY04xZUNIZzZhUTQxajlJWmlhcG9zZXgxVzBu?=
 =?utf-8?B?NWlQQnVXSDdEUFVQMU84MldkNkZhV2xDcWthc3Z6MEZZZ2NkRkRvejlTeCsr?=
 =?utf-8?B?ZE96V084Tm1LaTRDNC9pZHdLM3pJTnBXRTlLbTRWbDNrRTNCNEM0SHNwVnph?=
 =?utf-8?B?eitvQ2pqU3Vyd0pGNEtFRUYrMEo1dUFqM1pMN0ZEWUFoeFRJNDlpN1FvZ0Ev?=
 =?utf-8?B?NStjR2labEdhb2Q1eDJKcG5DWiszSHJ6Q2FCSk1FazVEZmFoYTFQNFJZZEE3?=
 =?utf-8?B?cVM5NWZNVzArclA2OXVkdUU4RENleHAzWmJnYnZsbjRZT3E2eXVNWUsrK2I5?=
 =?utf-8?B?ekF3N3pGQ2NwRlJvbkNXSzR0MTVkaHBnRE9SbGZqdmxqc1kxUU1yTjlIYXBq?=
 =?utf-8?B?a1B2R0N0YWN0T1B2Z1cwbkMwY1VkcGNmTHFSaXdHWWJwTGV4dFYyWVhMYzRt?=
 =?utf-8?B?Nk4zL2NGdERzVy9OT0MyOVQwRVJjbnFXRExRZEdQbUt1c1ozSDNoVjR5L3VQ?=
 =?utf-8?B?a3dwbzM2cDYza2hMSG9ad2tNclRkbDhoeUlVNTlBTGRXUkx3ck1zTzZQWC8w?=
 =?utf-8?B?NHJ1UGlFc1J2NWo0WGY4cEZlR2ljNVVyT1BXSzJrdDB4bERoR1dDMHk2eFZ1?=
 =?utf-8?B?Qm8zU1Y1T0ZaSDVtS0ZCSnd0RGFBTGE3VitlNnhKUGw3a0xLRGNMK3BnTDU2?=
 =?utf-8?B?Z0Qva2xpbU5GZC83WFNCQ3ZBKzNocktueDVORVpRd2N3ZVRDd1NFS0RsZVdR?=
 =?utf-8?B?ZWFtZW9YOU4zSzgwcVhEMHpGb2lrQ3QrSlI4Vno5R1RUam5jZXY3MVJ1MUs5?=
 =?utf-8?B?RkJYK1dFaXR6clZ2d3NHa0ozaWNldG4vcllaQlhDOUxhbXNOaEtkYW84a3dF?=
 =?utf-8?B?VWkxeU9xajg3dXM5eUZDNHh0WVg1eEwzYmhHKytuVVRtWk5XQTdNeWVHWVpJ?=
 =?utf-8?B?VHI4ellJMEw5SVcyQVA4eEdmWjRaTzdIZ0dvazNvL1RNM0Z3bmdyVmtQSGJW?=
 =?utf-8?B?S3JxeFJPZ3dCWngxV1pEVFVKRlMxbXFiamZsSTRyUmkzTDNvWS9rYWFyNzVo?=
 =?utf-8?B?LytqWkFzQ0ViNlJwTWRJWjlwTllEMkNHMC9iZGNucGdDU282TmlLY3dLYkJS?=
 =?utf-8?B?Tm1iZ1pta0g3VGppdERDMlhDNmZPYXFFNStGNWJSUW12WGRYdHBKR1RmZktl?=
 =?utf-8?B?VlNrVU5mWkZjY1hqRWJuNWtzNGgvRzlpVWFvMnRrcUdLZUFKTDNuS3ZtRkxZ?=
 =?utf-8?B?Z3FhSk9XLzB3dThwNXFBVTRTQ25MaFR6ZUNSYVZCSmkraGlMa3FFN2lNam1Q?=
 =?utf-8?Q?qIilxbgh0YfqjqBI=3D?=
X-Exchange-RoutingPolicyChecked: eOMznTJlDQzQ/aC8dOar+kLQqdeqCkBvDiBO8O9ZnwjPyHDannIgM0If8CGs+t1KxHX7ls5o8D9cHzk/5vsGfYnRd3LdS/oZCTLwidAdT/uLcHkOClbeiZAHJ3At9LtHO9aUZ/zbm89IhSlzmxJoJZSr+UKJaguGuVE1YuIsvGSNcJx42Lg9FUpL2qdZCv4XOlCRj3xoFmjyUnZJ6s/XEOR20PcazZNBnrvou9R9/tnzMmIxJBDPP3O0YIq4kXLeXBfX35Okc5u7HAlgBNTFiMfrmcmFvq4sAon1Y2LbyTqwhEmhXalx7SSWsxZ67Er+Fc3JvBRbKpNxMqCvZOESKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e5f597-7949-4884-7275-08de91c369ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 20:56:01.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9LG0WylQmBVlsQ8VLomCfgUdcqs8aFak+k/zcnmQ+e59etxoZidISf6CTjbGWOmZTSJHVA8bUOuYFcA57HcjZrP3lG4nVqwYveDta1XpzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275219-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 807253984CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/2026 12:30 AM, Aleksandr Loktionov wrote:
> From: Marta Plantykow <marta.a.plantykow@intel.com>
> 
> The 5-second SWFW semaphore timeout added for X550 (ixgbe_mac_X550)
> also applies to X550EM devices (e.g. X550EM_a, X550EM_x) since they
> share the same FW and the same SR-dump-driven worst-case latency of
> ~3.2 s / module-update latency of ~4.5 s.  Change the mac-type
> comparison from '== ixgbe_mac_X550' to a range check that covers
> all three X550-family enum values (ixgbe_mac_X550, ixgbe_mac_X550EM_x,
> ixgbe_mac_x550em_a) without inadvertently capturing later entries such
> as ixgbe_mac_e610 which share the same swfw-sync function but have
> not been validated against this exact timing requirement.
> 
> Signed-off-by: Marta Plantykow <marta.a.plantykow@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> index 85047ef..298958d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
> @@ -577,7 +577,8 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
>   
>   	swmask |= swi2c_mask;
>   	fwmask |= swi2c_mask << 2;
> -	if (hw->mac.type == ixgbe_mac_X550)
> +	if (hw->mac.type >= ixgbe_mac_X550 &&
> +	    hw->mac.type <= ixgbe_mac_x550em_a)

Seems like this can be squashed with this patch?
https://lore.kernel.org/intel-wired-lan/20260327073046.134085-1-aleksandr.loktionov@intel.com/

Also, since the X550 range is 3 MAC types, I think it'd be clearer to 
use each MAC type rather than the range. It's only 1 more line and much 
more explicit on what qualifies.

Thanks,
Tony

>   		timeout = 1000;
>   
>   	for (i = 0; i < timeout; i++) {


