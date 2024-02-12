Return-Path: <netdev+bounces-70978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1274851736
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5611F21E57
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D13B2A1;
	Mon, 12 Feb 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0PcljHX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D93B290
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748958; cv=fail; b=o5GPeUZ+vGZ5KgNxydKD90rX5xF9wYJqrRlOsRv4X64ksIXzqMz1wLPIU0Y5V1+pLsdGm6j1RUFPXK0M7aoRUMS+c2GqpRajs5boWYw0wqkAfqTtkTSYQ7OEkB+UiZHbnp/c/2TigrmhZtP9UFQ2PKaiPCo1XIfCKO4YMuFsddw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748958; c=relaxed/simple;
	bh=nFLILh9Cj6+B/st/zvAMkpieEjoFLFA8Slfe+FmQeCA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbe3G53ZCYHWoVGVfULSwontqJ52iSUZ9MZvh6nWc71TeSM56tNuz4mzM9BSDys+BoeyAiTjgW2Fp0HXcE18F/PwzV22Rdx7umDUJeiaSxGDWkva4V8YyFvpa8mDg6IHKEdTsImjiFL2fuzkkOsG/dx0TfSsT04umu8tNKt9Uh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0PcljHX; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707748957; x=1739284957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nFLILh9Cj6+B/st/zvAMkpieEjoFLFA8Slfe+FmQeCA=;
  b=h0PcljHX8fadFZuFZOP7L0WTRPZffR0Eul9hiBUeGFwqI41o7XK4A09g
   vpdESUZU2BwPR0bqvtrk6aqHNrwwfskaD+xpoHkf3sm32aK8U4l7Id/xh
   7tipWE7a1oyIfN/XW9gpAc2iVT5eQzcKaZO/mEq7MZvOkE3yM1UBtoeZD
   btFpmq+ZEHNlbV+f8DDnwd8qBqsDOAVdBJEK3l8uACc2Wa+Fz7WLJLIaS
   7FN+Llw+cMyTFJSZJAsXY98OMCHBK8qYoH8HybbuU0AJLrsagHmQ7cfVL
   ZFOyAEwmMb95dWD6AYdQ4F/meftHP4JY0oNTB9+t7Lbcqb1n8tHM1K8cJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12816131"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="12816131"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 06:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7232037"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 06:42:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 06:42:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 06:42:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 06:42:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtJzIBsvfm09wucdTXakBg4m9q+LNeypaj+PzBPU0Av6goJOM+HdnsV05meDDbyrxwZJ9MfDF1RAVG5eg2z5AOeI2T0HtLUvQxsalmAV4fb4Z8omPk1JEPPh7xQLdBd9LjDCs+IjNLx3zOOKTRncVj/eObVKg7pT/SAOSJUhbAfZVtnKcjyWFHdf49WO6MOrb4B/TbVz3oNj/BlilssTmEbRVnQufCXQovy28noqh3Ko86B41BWjCDYqfYzoBxQIv3k0IXz30aZzN6yvATm//qSuivkTLlOrEq00cKu5jRDPnhwo79czWqfUdGWq316MvxKVNz7kL6Ma5RFukEu0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/iBD5fSnb/1AGWE8a5QI4Njx3q70CU45MbYsg753J8=;
 b=aKj/C5zM5jDrsGsnH5GJKhwGK9MRzCoMEl+uE40lo3xcPhtJZb7kgRjfWGYRwET1PaZlxQ03cVSUxLrCjYHQGNgFwWHhVhktzF3KNcDKvbMvddfIQxm3NidsnqBtZp37eU7NF2BY2kzE9vCfiJU6CF1U3s1ccX09xoOccNOCNzcLzU/ijgMvQIie9NdCtwJDRk0X/sbV30YVPEhSEN2HRWhLuli9Ht+GbHeF8tb6LVOMd7RxwBmnlXAeytuQmp8G+Zoj7ARrsPkgA7PhG9s8TpAA0hqUX+oVAGYe+EaZno492nbguFXrs3wbYghDx4N6+LJK4gSRC05xMsOBEs3/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 14:42:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 14:42:24 +0000
Message-ID: <da0fff05-e9fc-46f6-96a4-5cc37556e7cd@intel.com>
Date: Mon, 12 Feb 2024 15:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/1 iwl-net] idpf: disable local BH when
 scheduling napi for marker packets
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>, Emil Tantilov
	<emil.s.tantilov@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240208004243.1762223-1-alan.brady@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240208004243.1762223-1-alan.brady@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0023.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe53fe1-d6ac-47eb-5c83-08dc2bd8d352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpEodP0nLnWQXNWS1tA6PebaSMl8yc9tYe7wbJi3wtqtOtOEeRObGBChSI0CdygJN5I8eIKfixxSfDIeZznQbRLomUAX3+DEzb5+uqOqIHnUp+4m9UAiXHKUErxgFuPp9quaTs7Kj3O+XFfytkGAsiH3APaV1iwHqsWNZSh3kuqInAS3SakfcbG4BnePZs2uCTuuteDKhHXL7wY7RuwCZm2YMZB8LVUBdnao0+83P5aHQa4D6IQx9iiQEfnzw61OKs4mx0VcqSp4zYRIZm/7gbfDQWVlVYNYsomT3zGbUfxUogJFIeVAELrl9Tgz50+l7xUOv2+jDxOXJJmXetuw5Ltgs71852IzcDlgB5yTj04F09Az+qKkvH8yg+mV1R/3VVjh3E7338UrZxHv5ZVNEdfz+EuvNi7HFMjoFia9WALs9I8UeGgGxEj4IfLx8x5lH9jPJm63AEG15SqCcNTG2PuXIW4o7Uw0a5/xz93iRn4QiHtEF3KuhtssngYghVGNTPRUtJbq46fhnTHbymgb6vPafJ8tGHq5qCdK/8VL0+y4IHkhRRoMgsfOxI/g2JZm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(2616005)(26005)(107886003)(41300700001)(478600001)(8676002)(8936002)(83380400001)(66946007)(66556008)(66476007)(6862004)(5660300002)(4326008)(6636002)(37006003)(54906003)(6506007)(6512007)(6666004)(316002)(31696002)(86362001)(6486002)(82960400001)(38100700002)(31686004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ayt3Ry91R2F0a3AzTjdhUkxHSWFIZURRV2R2d0Z4MGhQbTRid3RLb09ObGdH?=
 =?utf-8?B?Ymxzcy94RlR0UkNXUzdTZExzSUdqd3RVM1BiTjE0VDhxdkRmTldCVmhsNlhP?=
 =?utf-8?B?RVI0MXJrUDA5WlA0Qk5Fd3k3eGpLencvS2JMZGhjZGhBZVAxQ0ZqZEtmdEha?=
 =?utf-8?B?TGtQaGQvS3RKbWJKa3pCNjZGZm1HaytMdzJ2Z1hvbjlLaHpWVG1lazRRQWp6?=
 =?utf-8?B?aXJKdENKL09vME5DUFo1aTV3bFltRVduVUIxRDZ4SVUvK3o3aHQ0MUlnKzFo?=
 =?utf-8?B?Tjg3aTBxK0RsUEFjdVY3UkMvV054VTVkM2dyL3FKK1VkMVlXMEkyeS9XWW9u?=
 =?utf-8?B?UjhXTXN6TXdRUXlHVjJ0dEdQNFR6K0RVZWZiUlpwNFZuL0FXWGpaS0ZDSFBx?=
 =?utf-8?B?UEFhdG9JbmJTblQvYVEzakwvRnlvTG51R3dMU25GbkhhSUMwUHhsM2Z4MFQ4?=
 =?utf-8?B?RHF5S2hoT3p6dWRDREtIRlduTEVQZ0I2S0haRFlxa29ZZk43cmVidDIxSkp1?=
 =?utf-8?B?RXlPNmZEajJ1QWRNZlVRaVBuZE9JdUVSR1k2QUR2dUpmbU90YlZCVzArMHgw?=
 =?utf-8?B?endPRHhYckFYb0JPL0JBNTRXNDUrczRiTHVuTTQyaHhuKzRXU0x2ZGpVcmlk?=
 =?utf-8?B?eXB0c3FnWklyU21LaTBPdm1weGZJQXpKcHVLSmJJOXN2clEyRFIzdjVSYXh1?=
 =?utf-8?B?UzR4d0UyaFdGY3A5Q04wNWlyeGtqZjQzSlhaa2NNYUI5SVdsamZaejdNWjBJ?=
 =?utf-8?B?T3VNT292RUgveC9YUG9lN2orVWdjZG5keFRxWjB2S2ZQRlBQSlF0YWxiRkgy?=
 =?utf-8?B?OFJJNlhrTUxENXlYYWdETGxycTBWSVlEbkJyWXcveXFQSVBsdW4vWGR2MU0v?=
 =?utf-8?B?NHdUcWR3RUk4NlRyK1llMm9leUZqcnV5UWpsV3hGUVZIajNKZlI5Z2VDYWJP?=
 =?utf-8?B?aGNQbEc1Ukk2bUtMbStIcFZGdEw1cmhzWi81c0tVUURjTy9Ba2hWZHdUdGtz?=
 =?utf-8?B?c05uMXpMVTM4Y1AvR0NRcHJvRUc0UFFuNUNyYWtSSXZvS096amdkcGs1NHJE?=
 =?utf-8?B?aXJMV0lMamxITE9YMWtkUXFwUEhXanhxVTdQanA2Q3REQjRxZjNtbEduZysy?=
 =?utf-8?B?YW1pbVpXemcvRk9UbHVxR1V4OUQ0bU9jVFRZeEUwcDBnT0ZZbnRObERTME92?=
 =?utf-8?B?NG1pK1BOYmRqTFpsTG1BeXdNbmJuV0lhWkJTWHlNQ0IwZERna2FoTGEvWVBM?=
 =?utf-8?B?WC9iditZNmNmYmFnWm04bGJlQzRHZmczUDl4NytzeDVvSjcyZGxKZExkVDdP?=
 =?utf-8?B?Qy9aSUdkdklDajJiV091MVVsOHZudVlqV2FXamxHMkkyUmpnRWxXY0dWZGFR?=
 =?utf-8?B?R1c5TVNjU3VBY0t3RGpucE5YcGtQUFFHRVo0V09YTmhPUEIvMXc4dStlQTNk?=
 =?utf-8?B?TExaYlQ3VGRsZXR2Z3RCNjI0YWk3enNVdHludllOMnlNeDZJdlJ3SFEvMHN0?=
 =?utf-8?B?Zi82Y2tSY2NKUE5yaW0vT3VjQWE3OVVtQzBhNXJ4SnRQVTVqS3lpUWlYcitQ?=
 =?utf-8?B?OHZqRU4xOUUraDBpTXY3eWF2ZXpUSUFyUjRQNS9iUlJUNk9waGpJVUgwNjBP?=
 =?utf-8?B?U1lCclRiQjdHTFZkVjdrTjZoQ3lLYzlKMFM1cjd6R2NRRjR3VXJLaTV2SUpL?=
 =?utf-8?B?Y2FaWFVsODZhT2tuUHpWRzQ2Z1ZtNElBbVVrMDk2UzkrTFQwSEtIcDc2Q2JZ?=
 =?utf-8?B?QXNWZGlIRjlSWXpHamZmdUlZLzI1ZFI1Smk1UGxjQzV0SFRrYlF3S05MRHZR?=
 =?utf-8?B?dkdZQWY3eUNSMnplZHQ4anpYck9Jc2NCb0tUc1prUVhOamdkb3NVNmZ0Zk5o?=
 =?utf-8?B?eVNWaEFDc2tGM1BEdTF2QXpBUmhJYkV2enlIUUpmaXJ3MlBzVjl2S1FVVnA1?=
 =?utf-8?B?RGR3ZER1bUZPNDJPMmNma0xEWjhqS3BQUUdjTE1oOVI4enJaVDlYa3hsV2Rx?=
 =?utf-8?B?T1JQYWVpNElEeCtNMEM1d1ptelpkNTJxL1kvZzBZVTFydWx5M1lRZ2lNS0pI?=
 =?utf-8?B?bEFmY1g0S3lHMnFTVC9DSFI0c2g3S2Ezd1B6OVdaYjFtVUs1QStFZUlOeEFR?=
 =?utf-8?B?cXBXTnV4N3Awcnc1Q2VyS1hUSjRrUGdXWjdXTDBEdHNSQXp5bXBGRjJuK1pv?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe53fe1-d6ac-47eb-5c83-08dc2bd8d352
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 14:42:24.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBYwTzJff2uT37UtqZUso0v3rlHGioBYOQSjR/ZitR92afRCceae5qTPSfAYQh4RuiNAaWCdFSy3A+ylMFDeCbvMtfYzbBsgjfXmOar6SE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Wed,  7 Feb 2024 16:42:43 -0800

> From: Emil Tantilov <emil.s.tantilov@intel.com>
> 
> Fix softirq's not being handled during napi_schedule() call when
> receiving marker packets for queue disable by disabling local bottom
> half.
> 
> The issue can be seen on ifdown:
> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> 
> Using ftrace to catch the failing scenario:
> ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
> <idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]
> 
> No interrupt and CPU is idle.
> 
> After the patch, with BH locks:

Minor: local_bh_{en,dis}able() are not "BH locks", it's BH
enabling/disabling. It doesn't lock/unlock anything.

> ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
> ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]
> 
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>

Thanks,
Olek

