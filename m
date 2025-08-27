Return-Path: <netdev+bounces-217341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ADEB3860F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3A43B8678
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCA274FD7;
	Wed, 27 Aug 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTba38tT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E39271469
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307670; cv=fail; b=i8TnS9n5POT1mVH+P4wUz/7SDP8wtTDbUAuGrpIVzeteAs3agMMolOfMhNJEpycLrSX4zDkfMdUsXeNijA4kOPVmn+j4oVynhMjCzhCI8lpFkQ43jNLawMdJ3p5QqQ8ImSLU7G2Sr6uG6/YaugzV/EGvjtsqnCP0c7TeK/4P4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307670; c=relaxed/simple;
	bh=vTFanlUvEZvmlzdr1jzMkx4e09JxeIBiewf4cbDAtjs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aODVqNBlPd6+KNc/ldLckRLu4IZEhSG3vyGfdEfcuEtdGGEsF3E0pDaWwWoTq5L9QePlGtwc+DG2vRbd0ARuAaULT4kARj2IYdfF2iPANxhuFEKSpsVTsaraE9Gva5zlnsYwEeXznkO7JrI1xSVjFET7vJr6gfpYdv5LPGf+c+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTba38tT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756307668; x=1787843668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vTFanlUvEZvmlzdr1jzMkx4e09JxeIBiewf4cbDAtjs=;
  b=DTba38tTVwi1+m9mkA5wkJeQFP4M29W5juDSwgnnBcHxJjjEeEbs5b02
   w1KH1cvAMwa9MAbPsg/f0WkcnBx+zVl+SC3GF/g5Lqtt/U9Zq8T4x6KWq
   2tugp5IZTRdUllw8OvMUAsAFTLBbuQjNZVyX1bBILavMPoavAofGiEa8u
   vqouF2fD7LHhZRQsFAPyWg4kqn3B2atnUCyOlnCVm/JejKGtJ7S+WyMWh
   gYtQmDcph9+82l/J6Rp9q1gaVv4GMz7lbqlZwXEpeAkjMmNrFR3qebui1
   aanPU/mZPHuyK0DBo+cFJeQ/udEdiVaECTAgzkNUyiV/Br3NnAvBbBCNn
   w==;
X-CSE-ConnectionGUID: hSNZcF+GSuafHHjrSOq2pg==
X-CSE-MsgGUID: 2yJWFhUqS3q4kV1wqFnNJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69932851"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69932851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:14:27 -0700
X-CSE-ConnectionGUID: YxzD8w/tS/OLvDKgVxZ9LA==
X-CSE-MsgGUID: BKAiJfcuT8yhosmgsfAvSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174028106"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:14:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:14:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 08:14:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.47)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:14:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU+hT2nLdoBVNtZb9RoxTWxdvMlAU+oPvIZzsGCxNFO50oRABwSQbKd/fd2l/ScGqmfY07lh9/5UlXEjvvDGj6xRWook88Hl3tt0+tzAiDrIq6s36PFu/onGlQcL2YFEtEBQYfjzK2hhUnPIXceHGpDjmLTttkINgY5fzc+l0/Lys6j5UF1Ve3p5dgjxvn02F1cvBVo0O28uJAwBH20azK/+1ngehFKbVSyRu7op/i6eEQwd4mJ0xFXdUCveBVRS1b+lu98rZdvnHeOrE5WFeIbN3AZA6DXlYkj9jmgbefe6xOqeP8Wkc5yx5zqqqD3Eswji6+l5chBxdRvkyFGUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M73M9F4+/5mzKBnd7G+RamDl+b5ql3g04t9nagauJBw=;
 b=t8zFJqlkjtMpnreyqqDiWZA6BGQ4HHKQUcgfKqILN4rdAPW2i/akvjqNPZT40y3J/uZRv5dbiWWVw3mPCD9Ru82p1SE9ZsKyk8+vO52j+R8QLjXpdjpnDhV/euzIuwS0qKtefTeBXgTF/9MaiVbfBOfiI0Y0us9aXpk/uC8jWKehbSZ1Fey8Th/xXvF53VoPR44cwm+0Fpub9ReJdejKDgOJQTw0Yb5CWk2mIEhEhKDYgyphBSHeh4ukokYmtaEGIBhUneMmwyb2qbgeNvVn0GiR0eImcPKQpFx1k5bDhsMVwECA39idJ8tGnxs4sOjAJP2ztGGr+u0xqHv2wovglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ5PPF0FD67B0BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 15:14:23 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:14:22 +0000
Message-ID: <9dd2c1ea-b2f9-4dc2-bf3e-8b1f8072d1d2@intel.com>
Date: Wed, 27 Aug 2025 17:14:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: fixed_phy: simplify fixed_mdio_read
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Russell King - ARM Linux" <linux@armlinux.org.uk>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Miller
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c49195c7-a3a1-485c-baed-9b33740752de@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <c49195c7-a3a1-485c-baed-9b33740752de@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ5PPF0FD67B0BC:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d05c8d-2887-4611-6a20-08dde57c6712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVBlZFBobUt1L3c0NEttTFFXUlhKRHNCSWcyMUsyQmlMVGxtcGhCa1JOd0VT?=
 =?utf-8?B?MVI4aFpwR0VFd3VwQXJWSy9PL0dhek1lOTQ1MzluRFliZElaNnlsVEFYeExh?=
 =?utf-8?B?TEpKTUx1Rm5oUnhHMzl0cmdpeDJDL3RnWC9kcFRlay96RlVIMVptV0x1ajBa?=
 =?utf-8?B?ZG9tbVBMelZ0NVdMNnhHdExtanNrWlV4NkFXL2RuTjhBRmRpbGp4dUxFR0tB?=
 =?utf-8?B?cDRSLzRLWS9ONjNqOUtyY2FwNTRTZ3VtOVF5MEZ4WFpBdUpYZXpCZTBuOVhT?=
 =?utf-8?B?ODE2a3N5MnR6MVA4dEl4OHRoVENIck53eFljTDB6bTNTaDlCTVo5SXBOVm5Q?=
 =?utf-8?B?cGl6MklBY3U5amx4eUtMQmpXZzU4SjdiTjFDdnRCdnNzVEQvY2RKZmV4VGE1?=
 =?utf-8?B?NUlSY3BtYVdPTFFacmxvWE0xOTdSMWxpY29hWk56YVI5WUFiVk5lR3VSZXdX?=
 =?utf-8?B?K1Y1N0hQN1ZGMGhranVPTEFURWVXbUdpMklvV21uU0Z4N1VnbmFZRUhiR0dS?=
 =?utf-8?B?UTByYVRGaVo4M3VKYU8rbEpPUjZITndyb1hNejhUQmkwMGIvTXlXaXRyQWdw?=
 =?utf-8?B?SXhIckJSRk5GNkxlNm9NQnlZMTVyZkJ3QUkwd0FRTEJBSjNEL2VKZGlmZlR6?=
 =?utf-8?B?NnE2WjFUOEx0cVZCNmdZNmh5RjR1WDlSUUpQZUZyMEIvQ3BEMXp2bEcvNlY3?=
 =?utf-8?B?alFEL3FEQU9uZW1zVExTMlo5VGlKQnRleE45QWZqaG1HRndmL25PcUowY1NT?=
 =?utf-8?B?VkR1Q05SdSszeUNlSzBMWEZCeXRnYyt0YlYwc1lmN3lRd3dYcjZuZVVrOHUx?=
 =?utf-8?B?UktuVmt0Q2tFQ0JOaUVSSk5Ybm5PYjJFWXVLZW1CT2dYSnpuTlcydWNGekp1?=
 =?utf-8?B?VXRMS1Fnb1RpakthZ0NGQmdlekZ5eHYyMmNXNklLNlV5NjRLMTVJZ2hDNjN2?=
 =?utf-8?B?dDJrY3Y4dXRLR21TT01DeUd0NllRamMyeW9Rb1FEYjFrKzFqMGlVbTZrNEdK?=
 =?utf-8?B?enkzYzllcWd2OVhZUkQ3c0RabXo2U1A4QmxvUEtiUklwWjhFbThMREtxWW9Q?=
 =?utf-8?B?OW1mTC94OWE4NjJmcjhoSmM0NzNHS05QMisvSTVTdjVJY3lvaktTejB0ODA4?=
 =?utf-8?B?OUxlYS9abGZTajRhQTNXV3MwTldLUzh6MDA5L0xFSkxTZ29ZSkZiTUJkSVhl?=
 =?utf-8?B?S3J2aWlybmNsRk9VbURnYnlxcktjcVZ4QytqbVFYdy95SnEvVERhUWV1U2xp?=
 =?utf-8?B?TVdJdXU1QmxMLzF0cVRtMWtrUmJBTnBpRFJWL1VJNXRSRmg1Mk8xeWdkdWgr?=
 =?utf-8?B?bWJlL2JrNDFFTHBsZzJ3QVhSQTVDa0tHQkl2NWg4ZVBUSzhFRCtEQnZQWjlT?=
 =?utf-8?B?SnQ2SSsyRG5ROGJzVENqcUE0Zy94Ty94LzFiMTJNSTExZENvSytpVTBZd3BY?=
 =?utf-8?B?RlhrRFZxbmZRd0c2SjU5Z2J2YjYyT01qakhsdXRlMXhBRzRTblNIamc5Zysw?=
 =?utf-8?B?YXUrOVhteEZjL0h6WUNheEpvLzFDNTVGMHAzb050eFd1VUczQmNYait2T2I3?=
 =?utf-8?B?T3BXM3VYMHFLQXkrTmY1dDFoY25oRGNVeGdIWGZQWU5kYmdNZWV3aytJVjI1?=
 =?utf-8?B?ZVZzbGs5WHZZaUtxRDZMZmtWN2tnVDk3RzlreVBMS1hsRU1QZzNha3hMSzZH?=
 =?utf-8?B?NmN1S2dXY2s0UE0yVDVIWWZmWGs2czMzTGZxVzh4dEF2dmNlczdYcjZCUmFv?=
 =?utf-8?B?bEdmWjJQblNaZW1JNkFDOW1rZlNhUlNNN0NvRFplZkw3aTkrbVRVUHAwejRX?=
 =?utf-8?B?WE4yZkFvL3dwYUxVcmNSWlIyRXNjbzl4RHNlbWVUVk1DMVBBQzQwd1FzWDUv?=
 =?utf-8?B?ZVRjdWZhaDluR1J4OTJwSStSWTZWUlE5VHpjajBzdTJiblE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dXYVgwdUd1d0hEclNkaGtGemRzQmd1TmtaaC9MRm1LRVg3bjNPZVZmdHhK?=
 =?utf-8?B?ckVkb3lmWmY1ZDVTWS8zSVpWa2ovcGVBZDlObnQ4cncrRWkrN1FnVjhpSUpr?=
 =?utf-8?B?eCsvb0dOZkVILzBBcHNEMC9jQUhPR1VrNVorK2RyMy9zbUpZaE5yVWdPWFdJ?=
 =?utf-8?B?MXFicC9UR1lNS2pQU3l2eGFLZlJDMm45QkIydVRlN015SGhGd1M0U1E0ZjVF?=
 =?utf-8?B?UFdJZytmMHRrbnpoVkpDdGtSYXFkYzIrNVdXMXNoVHo1VnUyWmJZMktZNFBD?=
 =?utf-8?B?dEptNHZlOTFXdi9BR284bmxXZHA3cU1FSVY1N05meHp1RGF1RlZoRkdiN2dI?=
 =?utf-8?B?RmlVTG5LZkZyQUt3dVltbU0rLzNqTVc1bkZVYVp4NHBpUHJSOHNuZnZ2eUtD?=
 =?utf-8?B?Q0hFb1REaW5uNXl0TE9KUEJxQmh4dzMrQkpaOHAzZ0FZSndRMHJVeW9oZm4z?=
 =?utf-8?B?czdIaUd6UFpHd0J0ZzMxdnR0MDlyMEJpSnNUY2RST0hrNUlzb0xhZHZIRTk2?=
 =?utf-8?B?VHNxZnlpM3dPSzcwcStyUnRtV201YlJuQWRpQ21RZk9FOC9sUzdTblhjd2RO?=
 =?utf-8?B?RDlrVW4wc09WYWRqUFVSZTZXdERoaFZ5V0pTeGYvV1Y2dUZveHhxRG1vV2RX?=
 =?utf-8?B?SHhqcktweVVZeW5mRW1KQXQ1NkNzaWtCVHlSaHdGc1NMdlYxK3NLdklJVXNK?=
 =?utf-8?B?S3ZqS3lpWXh2VmF5cXhNRDF4RGxSZHlFQURHTU1BdWVCelBmYmJORWJTRml4?=
 =?utf-8?B?VFM5T09jcTJ4cFVpVy9JQnliM1NmdDBNaHBhdGk1SHRyY0lVSHlibmZXWDZP?=
 =?utf-8?B?WlNQMkFSZ0pRM2hoQWp6UkZ4anYwNjFDSXRvZVYwM2ZnRWllT0hBS3M0WjZt?=
 =?utf-8?B?dGo5MEhDdzU4UHc3a1U0L1QvdlRhUGhweE5HSzIwRndxenkxTXBoSFE1Uk5p?=
 =?utf-8?B?S0dwV1dya1l6OVR2ci9BZGxOSHRTd2pERlIzdzNnaGNiYkZCWnh2R0RmbG5r?=
 =?utf-8?B?NTdtTGZZVTg0bkRsSHlFdnc5LzMwdDRFUWVsTTNUNm96TFdPbFJuN25lR2dL?=
 =?utf-8?B?eG9JN2JZcS82SGNweUVodkE4RDI3NTlBZFhLUmFJSE42aHp1Q3pnS1Y3cUpi?=
 =?utf-8?B?RU5UdVlSZ3FSOEkwUGY4KzYzZDhrdDJEREJydHFQbVI3ZkRlYUhWS3AyU2Vh?=
 =?utf-8?B?S0QxWW85U21zVEFTOFRzSzNrTUhZdk1pUW80SWdaZjdRR0htUzMrQ2VFaHE4?=
 =?utf-8?B?Zmtvckt4MkVNYk5NOE9ER0RSb1k3eXZacFdzZTRHTURwNzYvWjR5QW1OMUZN?=
 =?utf-8?B?YUVzQ09qNmF0RXRiZnl3T1h5YWRpaG44R2trcHBKaEpQZ2RkaTlWb2d4dkVh?=
 =?utf-8?B?Qmt2M3NxL21sSGNWNlBYcEk3Skd2dmR6MzRVd2p2b0V4a3ppN0RtSFozQTQ0?=
 =?utf-8?B?UGJhbjFJSUJHNWV2V3F0Ui81NGc0VFZMMVJnVkRPcTRrK1BOREdpamdaUnpL?=
 =?utf-8?B?VWx6aGFRZ0xrazc4cXl2em9Sa2NFODZ3SlR5Y0lGcmd1RFZwMkxrMFN6WHoy?=
 =?utf-8?B?N1NoRzlSQmdJdGtSTUhwdERSZThpaUIxbDZvRXRHdm1wb0hlZ1hvQXhoQTRP?=
 =?utf-8?B?T2NTUEFYbzhKaUVCOXI3ZW9mUXVPeCtXczdUeE5NMzdxOThqTS96VmZ1Wlhv?=
 =?utf-8?B?L1ltK21OTUdRWTIwWHExZEFyMGNPVGtVSUN0TjgyOTh6RGpMY0FsaDB4T3lJ?=
 =?utf-8?B?MlNjVUdRMHZxMU1CK2hmMmkvSUZFQlJ5NXl3c1gzbXQvSWI2bjFZSlUrbDFY?=
 =?utf-8?B?UzY5SDBVZHdsald0anJXUnRYSWovTTZJWmp0dFBkMGs5MlVBQnNBdnltMFVC?=
 =?utf-8?B?aCsvN1NmNXVmRDZFa1BoUVoxVnhWSkJVQXJZcUFId3U1dU9aNElQNDJOWEdK?=
 =?utf-8?B?V3pJWWNkaHl5MS96Tk5nVW1pcFJLbmVvNkpkcnhUemN0d2xCTjNMTm84Zmp2?=
 =?utf-8?B?ME1ZaGtidUtSQk1ocWVDYm9LSmRUa3JUTFJpY0ZvNHdIaUF2eEkxYURieXN5?=
 =?utf-8?B?WjBJRlVuUHJKelhOZEZ2TVNWOVdtZUNDZ0VWOFI3M0p3b1VOVmJ1eHpTclp4?=
 =?utf-8?B?MnRoOW13UVkxVnRTbE43R0o0TXo4TkhvYitSZlh6c2t6N0xCUnlBTldmOFNw?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d05c8d-2887-4611-6a20-08dde57c6712
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:14:22.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI8/vtKP9Kb1x3UtLLOrXNpv0pDlwE2lFj3Xm+X+yFYKKB2FBlZS9Eib1EgxyN7GqT/sxL/8ffWJdixcrAq9ff5Onmug19VqRZoz62BTfdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0FD67B0BC
X-OriginatorOrg: intel.com

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 26 Aug 2025 21:24:44 +0200

> swphy_read_reg() doesn't change the passed struct fixed_phy_status,
> so we can pass &fp->status directly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/phy/fixed_phy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Thanks,
Olek

