Return-Path: <netdev+bounces-174373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35797A5E5F0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FEF1888358
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669031EF08D;
	Wed, 12 Mar 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjJ24oTk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B821E260A
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812963; cv=fail; b=gIK2wSyrCz0XoFNgLriH7AwWnUUC+JKkUyH+xPLkAvCTGmd7uMqgQ9nGaw2p281ZU8v469DmJ+lUfi4Sa2q9EruZmvjmcOLWjhDMLdmBxmhNMY9lqP3GGO5mLQwQyWt2ZyQ7g1bet5Q0yb/pH1VOaCzADtcO7VpNN48jdB5Ulbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812963; c=relaxed/simple;
	bh=cXIWmnSADmcO+EJU+o8g41e5YLCeRYxIJrCzZ3VFOrE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWoRKbT1YcdZ5O9GaJC+doNElKWTlWb2Tj4YFQ9ygz5C9lFhvjilisxTQzMscJOexQSuzhunIJG0k5kIATVDjvY+bQuB14UNNSQrsprONPszRS0kyopaSAdiQ6lOg+c5ObPiCYeMhh/j1PV1H14EL9mVxuqDFn0/GEFKQsL813U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjJ24oTk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741812961; x=1773348961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cXIWmnSADmcO+EJU+o8g41e5YLCeRYxIJrCzZ3VFOrE=;
  b=VjJ24oTkYVku/F825rmMZWrOx2yk57tdrf7wnb+2oWfD7j4i2vT4lxdB
   HDlpEPw4mIueywaTNQnUsBwM/rIXyNIEv0y0Hq7TgGKy0FfdWQjUKI/fa
   3UX2ih/GYA0KjYBP9NU/blXHanQyWPy/pZ6xKaMiBaEF7JYIcthP0AC37
   ySz4fXVAN+YqEv1GY0GYaTEr2Y8WO+zdqre2YaHohlXoN6UJ5jk/tLR9l
   FKYclzraap6MIc/VB9dSDLkvdjCeCCzlbAA/Bbm7Z4isuV2OwTBVXh4X9
   I+/6AYc4COHpt1bkCsoGCaMuCU26R8QujXoDlqSbNf2zlGKrmZ+p7ot/r
   Q==;
X-CSE-ConnectionGUID: zMVBcROuTom/sdNmsAuZGw==
X-CSE-MsgGUID: /pCBOjcwSuS4Byh5bGhMng==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42077858"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42077858"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:56:00 -0700
X-CSE-ConnectionGUID: claq6tv0QaSs+c0elkdpRg==
X-CSE-MsgGUID: nMLKIR8rTH2y63NaA5EchA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120733441"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 13:56:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 13:56:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 13:56:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 13:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHSbp1cHiRFmzGpQM+PGg3x/W+QvL6AJ7fd8BZctjnIVnKgwwpiD6hLq+G4ijTuW4aorCCbOc96qJVc1BQxxzFqnEUK2DxkD6SzelC4DYA8hxpMB7GREKe3GJ2cVk+hXTzkuAOAHGMrPcNDdTwT6n1ReTZcNxBLMdHhRHdfQCnrtCsXCkHgC/GlpjTdt46YRe0bzUzN1iLBVHK2/l2KPlzoZPS0+KPXW3F8dwJgeay46aWdmYWBqMGQREOrJKd2wee/TVmMACqYOrcp7ky+CdMDGUNV4n2H7/62rC9HMUMzZgZnKNpBMsf0if6KfKixrKz25IzgPfYYpSMVcdSjOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFj1OHvCFDR9oFC1NAPgb36UIakCa+BlGIyHO4gho5M=;
 b=v4bMFemnV7CpxJklLUGaP7/mwrJEuGSPrhP2CyFPtQNA+4b8DDAFXoQyLPD5Ldhi5ehCQIwjjgpyHuOOtQhaxd2U0H4VgMr+SuO/tRIV6xVyMGZvjn7EjB/pdjRR6ZkhEabahUOV7R2ExCEqbf6EPgPvFPEvekMnkHURFJr1lBtQ9exl0MPv10de9Nlf5xqCfO71Gte/DGKQA22W2SO1rYfLmHTd/7Sr0EZWIkCO299rDVLaEYXCBIYxJLRQBXmvQlkjwEy7eADI0CzezIzAlOAiSIRh1f3CTR6CS0nVh/oSSQinYmPqlEYHvz9R5XEwCabeZEKoTPUIYqqlXUECSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 20:55:54 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 20:55:53 +0000
Message-ID: <277f279b-59bb-43c6-a434-23d5eb9d3c65@intel.com>
Date: Wed, 12 Mar 2025 14:55:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ena: resolve WARN_ON when freeing IRQs
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Simon Horman" <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
	<netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
References: <20250310080149.757-1-darinzon@amazon.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20250310080149.757-1-darinzon@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0238.namprd04.prod.outlook.com
 (2603:10b6:303:87::33) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 207ef1aa-730d-4262-c619-08dd61a8475c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEVzN2lQZ1NtTENiQ0UzemlWVVFqMUptaHNhMlV6aU5aVnRLN2diWFMzYzJy?=
 =?utf-8?B?WkZqajg2RDF2VmZQTEN3Rm1IR2RINGozNjZaWHpPWDlOdTdIbXpkQjBKYm96?=
 =?utf-8?B?a0p2NGYxeE5NNmp0cWsvZFR3MUpoWWFuNy94b2FySllPeHB5QWh0S2pMQkRr?=
 =?utf-8?B?VnNGMlUvTWcvNEk2aU1GMXVVaHdaQ0RSVm5SK3Z3TzJsTUN5SzVvWk94SVR2?=
 =?utf-8?B?TE5XS2tIaUlVdzZIY3NaVktBNUVFOVpqWTVDdDhYTnZ1Z3pmQVpCcHpNcHlV?=
 =?utf-8?B?dTdBd2FFaXRzTVlqOW0xMkp2aDUzRjY3dithSDVqSkY3aUZGcGJReHlZckla?=
 =?utf-8?B?MFJUSjd6NVZOeFBtZTlKME02U1lYZ2o5bDlyWDBuR1lvZVc0Qk5KL3VnYmhv?=
 =?utf-8?B?Nkl5bWgwVmFwT3JjQm0rRFp3aFdwdWgvcTZiaFNmRnM0TzJaWENNMFpUYm1q?=
 =?utf-8?B?ak5xV1ZCSmhLTWk0N1lWK09pOFhvcW5rakltc0pjQXk3WHB0aW1kMU5kb0ts?=
 =?utf-8?B?bXB2bmFXWWVYanNBZ3Y1THhENUp6TEN6eGg2dC95cVcvbnZOZEZUUlV3UGF4?=
 =?utf-8?B?ZHhoQmQreCtraFBGVHF1cVErTkdDSVA0cWdFSzhZcWZhVkpWNHdqMCtxaSti?=
 =?utf-8?B?SDYzQlNVblpLenA3UG81R3RiTFRyNGJXVllXSThVZUZTYWtRWGs2UVQ5VDBt?=
 =?utf-8?B?RVRES1VOT3hXZ1IzZk93ZXp0RVJRM2h4N1pGSlhJMmNPTWdMQklpd1BEL1JU?=
 =?utf-8?B?NWZUSEZMRHZQZWZRWVdkY3RpTW9CL3FmQXlXTWtBNkFTK1BGazFHNVBIckd2?=
 =?utf-8?B?S0tSYkR0bW1YcG1KZjJDU0h5V2dzWmpFM2V5TFN6dzVTV2g2dzN3NnBONDlG?=
 =?utf-8?B?RCtESVp2ZHJNY1BPUjBmR09CbGphTEhaeHJXbVNhQjVSTWhNcXpjK09pdTEw?=
 =?utf-8?B?VEg1TUR6dWlyK0tTNVpjRzhGWG5LVDFMRHRJM1oyZTJqbWpoNzhzSmZZRzEv?=
 =?utf-8?B?d0pYbjd2NUtyN3BGME8wME52aExZZnlJWVFtclp6dVV4YlpSSk5BaEp2ZTVC?=
 =?utf-8?B?MkVpbUhpb0w1YWVaaExOZHNJekZ2UGkvNWJ2YlpLM1drM1VPUFVYai94MUlL?=
 =?utf-8?B?QTFaOGhvdkN4NjdlMXNLQlZHYjJQaFVUTUpDN2l6UkR1STZVSTIxZDRxVEVk?=
 =?utf-8?B?cjhHTVlUekxKZHZkWUM4YzhPU2tZeGJDS1ZYVnV5SzQwbHhleFEyODE1clJT?=
 =?utf-8?B?NW1TRTA3YjdobXlCcEpYQWJ6SEowL21iRGYzMklLWVVrWTdRRHdDOEtsZ1Mw?=
 =?utf-8?B?aFIvdzg0ZWF2WWYrVEhUTjFVVzlsd0xrS1ZsN0NNMzJrWEJ3bm91MmNzSUtB?=
 =?utf-8?B?MUJOWWJOb0tRcmJiUlhXOTlVTVl3eG5kSDljeFBnaURGKy9keGdqeHJpaXN5?=
 =?utf-8?B?YWErUEpJOTluSHBDNGJGNndrOVFKaXJ6VlcwVHJmYU9hajNNK0dOQmlQdjB4?=
 =?utf-8?B?U2lWTEtGdTBNM3NzTTd3Zm1meXRFb0FoRytsSDZYMFBFWEt0bG9zcjZIUjND?=
 =?utf-8?B?bG10Mk9tV2plR2lDTmhFMjdpbkIrQ1FMMUJTeUpOQXkvWUIvVVhsS1FIQ3FQ?=
 =?utf-8?B?RU1KSXo3c1RBYzAvVmkyNDZIY2Zzd0ZUNGRZS29uTDl6MllEa1FJaVRobVF6?=
 =?utf-8?B?MWtSV1AzMEwwNlVWekVqQjFpNi9qTHJINTBiVW9pSVpHZWV4Ry96b1JKRThq?=
 =?utf-8?B?OGQ1NWNPMmM1QzQ3aFUvRE93SlVMcWFQSkxqcGIwdHc1ZVh5dDUvMUV3ZWc4?=
 =?utf-8?B?VlFwc0ltWDdXbm9USHF4ZndzNitYREtDMjZBbzB1cDlMOFp6dWhzeTU5enhG?=
 =?utf-8?Q?K+sqYWXpY8BPk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FxZFIvQW9RV3l2bmlMU0FzaVYrVE9LczFMQjhJeVRLdGRrSjZYMlJrMnVp?=
 =?utf-8?B?a2wrL25zOFpBVENQWmM1SmIzWHQzcEcvSWc5TEtpcEhsK1g5dnlWZFhWVVpw?=
 =?utf-8?B?RDBFc3NOdGVMMUJSSUtNNWRXWEVNVHNQMisvY0NIOUQyZXBsdTNiNXA2cGU4?=
 =?utf-8?B?bTQzajVKRTJna3NqNytqcTc2WDhtMmhxSnZzUUFZSEVkTWVHaVlFcVAreUhy?=
 =?utf-8?B?UElkYnU5ZXc1Z2ZETjFSTHdBOFY0MDVVZUZTajFuTVZXT0JqVVhqMHNXWDNw?=
 =?utf-8?B?MFZXazhEcjZ6a2pvYXlIL0NuZXgxb1pxdGF1L3JQNGhPNDBrQjhFTGEvNkNO?=
 =?utf-8?B?ZWh2YXNxMncxY3dyMzRCS1VHQmEyQnUzYmlTNnJibm5rMGpCdFNWWGtCZW4y?=
 =?utf-8?B?emFtSUEwSFZlNHdQVWNkd3l5UXVUanE1elBkMkJyNEh6b0p1NU4rd3haOHRG?=
 =?utf-8?B?bnczTTF5Y09VVmV6SmRFTS9KZGxMMjJPUnRIQVlTR2l4RzFFVHVVOCs0NW12?=
 =?utf-8?B?TmIrcW1maHF5eWY5TkEvSXoxM2xENHVqeFl5aFlRRHVtbmllRVJFeU1TQ1ZS?=
 =?utf-8?B?eU8ySVhmQklwYmVFQjVTZDA0S1krNHRGSTVMVWUyMHpha0FFY2pTTmlrZGdT?=
 =?utf-8?B?d2QwQk1WK2N6TWd1VU5JUUtPdlluQVNSdnFkZituM2JFdUZvd3haOG0vV1dp?=
 =?utf-8?B?KzdqOU50RlJMMS91dXJYSjFuY1Q4eXBKNU04SXZMQ1lqclAyRjJDOFlFTEZR?=
 =?utf-8?B?YVBxTGJJNkFpY1I3RTlGYkJTTjBWN2lObUI1YUR6U3lobTViM0JhTSthK0FZ?=
 =?utf-8?B?Z2IyK1ZncU0rUlltKzdnNU1yMWlpVkFzaElIVk1MbEwrVWl1NnFmYVdoZTVX?=
 =?utf-8?B?bUJpVlVMTFpzMS96dGpBVEQxT1hJVi84bVNScVBTQUlyRlREUnd2ck5LajJx?=
 =?utf-8?B?ZHhPK1NLeTRoUEoxRHFvRGI0VmM1c2g2OTNyVnAvT21CQnRjK092QXJXQlJt?=
 =?utf-8?B?NWJ2VUJGcitqUFVCanIzRHBYUDcwS2pPK3NtWjUrN2prejlhTHVZOGIxbGpK?=
 =?utf-8?B?Vk1CSUpDSE9JK3BuSUdGek1MQjh2L0pOdlFMSGxXdzB0Q1RHV3g1S1R3S3py?=
 =?utf-8?B?aGczaVZVWGEvNzU4VWRxNklQWFlGb2RVK0RIeEIzZmI4dVhhbk5tbFJmMDlo?=
 =?utf-8?B?WHBoNGgyaU83bmwvbE5sZW5lTzh3SG5sTzU0ZGUyUEFZSlNOcjFRREVKbzQz?=
 =?utf-8?B?VnVBczVzdmNuRWR2NFVnVlB3V0tWQklMQkFtZmFJLzMxc0hOMnNBRWl2U2Ns?=
 =?utf-8?B?WE85T0NKV205S1pjYngvWDRuWW5YSWJzUlhrcU5sMnZuRnh3N0Ztc083dWtD?=
 =?utf-8?B?NzQ5VUpwN3ZZQ2FqNHJybDJFY3JlTFlMZTRLTjNWLzZtYlhXWU1DdlRPNmF4?=
 =?utf-8?B?V2VNM1FKYVRwazRzaE5VdjRpK2dGRXdtSEJzL1c0RDRxOWs1M0xXRTdrYmJl?=
 =?utf-8?B?UzF4VHRTTk5MNDlocG9INHZIazA3WDVuRFVDK0JVdzFhU096bkpndEtnTlRh?=
 =?utf-8?B?alBJSUkzVHZFOUtsYmpxVFl3Q05BS09WNGQ4clptM2VGclR5Q0RXblVYaG16?=
 =?utf-8?B?U0kxM0VKaHNlK0kyZjZyVlg3eDZwUXlTN0JRSGJJRHM0N3hsYk0zN3pBQXhO?=
 =?utf-8?B?ZEp0ZnVnbzRLdmM2ZmhlRzUrbFNsV0NFZE5SdnVab3p5RDlNaTRHd3U4cm13?=
 =?utf-8?B?MFd6NSsrUmFmMlBSakxMZEVHNGh4eWFEbkI4Tk1sMGNSZEhRSmNvRVlvb0Np?=
 =?utf-8?B?VkV3d3Yvcm4wa3NsTHV3M1I5bzB6dlZWTEJmeEFLQWxpa1dtQzNHS1lSbm16?=
 =?utf-8?B?Z1RmcXdoS0JCRHRJL0U0bXA2SGRuS05aT3A4VExjMFJtOTVpcS9mdzBkUkNi?=
 =?utf-8?B?a2RtVWRkYjZINjNrZm1McG4zLzdJSHpaUzRJVTdLRURSNnV0WjFsWkF2UGx5?=
 =?utf-8?B?MmRYTTUydU1INWphbXhSb05jSURITkNEb1gyYzhRcHBqWUxQSXpqVHRIazhh?=
 =?utf-8?B?YW9STG9KZStDdmh1MWl0VW54YjlyR091cE9JUUsvMFRodExCbHRpamlqeWNz?=
 =?utf-8?Q?dGCLhBOir+Gw+387kckgIeUNj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 207ef1aa-730d-4262-c619-08dd61a8475c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 20:55:53.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7cgKRQqqDBV/4RUT7npiyI2KkYcQwkh+CYfPO5peiNzyiVTBnMV4sgWktoNaoA2tbdng0mFB8xYurpPaVTN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com



On 2025-03-10 2:01 a.m., David Arinzon wrote:
> When IRQs are freed, a WARN_ON is triggered as the
> affinity notifier is not released.
> This results in the below stack trace:
> 
> [  484.544586]  ? __warn+0x84/0x130
> [  484.544843]  ? free_irq+0x5c/0x70
> [  484.545105]  ? report_bug+0x18a/0x1a0
> [  484.545390]  ? handle_bug+0x53/0x90
> [  484.545664]  ? exc_invalid_op+0x14/0x70
> [  484.545959]  ? asm_exc_invalid_op+0x16/0x20
> [  484.546279]  ? free_irq+0x5c/0x70
> [  484.546545]  ? free_irq+0x10/0x70
> [  484.546807]  ena_free_io_irq+0x5f/0x70 [ena]
> [  484.547138]  ena_down+0x250/0x3e0 [ena]
> [  484.547435]  ena_destroy_device+0x118/0x150 [ena]
> [  484.547796]  __ena_shutoff+0x5a/0xe0 [ena]
> [  484.548110]  pci_device_remove+0x3b/0xb0
> [  484.548412]  device_release_driver_internal+0x193/0x200
> [  484.548804]  driver_detach+0x44/0x90
> [  484.549084]  bus_remove_driver+0x69/0xf0
> [  484.549386]  pci_unregister_driver+0x2a/0xb0
> [  484.549717]  ena_cleanup+0xc/0x130 [ena]
> [  484.550021]  __do_sys_delete_module.constprop.0+0x176/0x310
> [  484.550438]  ? syscall_trace_enter+0xfb/0x1c0
> [  484.550782]  do_syscall_64+0x5b/0x170
> [  484.551067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Adding a call to `netif_napi_set_irq` with -1 as the IRQ index,
> which frees the notifier.
> 
> Fixes: de340d8206bf ("net: ena: use napi's aRFS rmap notifers")
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 6aab85a7..9e007c60 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1716,8 +1716,12 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
>   	int i;
>   
>   	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
> +		struct ena_napi *ena_napi;
> +
>   		irq = &adapter->irq_tbl[i];
>   		irq_set_affinity_hint(irq->vector, NULL);
> +		ena_napi = (struct ena_napi *)irq->data;
> +		netif_napi_set_irq(&ena_napi->napi, -1);
>   		free_irq(irq->vector, irq->data);
>   	}
>   }

Thanks for the fix.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>


