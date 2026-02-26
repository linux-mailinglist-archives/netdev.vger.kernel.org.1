Return-Path: <netdev+bounces-261526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHp6CyGXoGkVlAQAu9opvQ
	(envelope-from <netdev+bounces-261526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:55:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4861AE0F0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCADD32236B5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD835A3BC;
	Thu, 26 Feb 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivB1hGh3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3CC332609;
	Thu, 26 Feb 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129621; cv=fail; b=OwTXqP5YfMLBJ5USnZF2hx7+HNHqqSEjfw0S3Sz54RAHlkkJwtcotkIJg+sO18adKorsnU57QMkDs8pcS7OOfOYf2Q+o6GTkKpZkH1WH3qo6xuASKfkgh10nmny8uX24xazvzyI4KhMeNXvnU1uSHluspBv+tGa7C/pKY4rFuXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129621; c=relaxed/simple;
	bh=5Cxsi5rnRQsLRBGmlGeqLciX7bWMOnk3S8qCMIj7km0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jqg0QJ4x0xB/uPvOiywk7uhxiJnJmDa3Czo8PARObtxUNumORp2u1DlMQg8GhTlP40eFCR7nBcVz7I6YlvLd6aqMluK1T4Bp9u/h+n/YcYocWHTzlEh+y7gS/fTe/Gy2Wz2bO00FNsVJARgCF1p2sK41Zt21ItGj+KyLWokeT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivB1hGh3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772129618; x=1803665618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Cxsi5rnRQsLRBGmlGeqLciX7bWMOnk3S8qCMIj7km0=;
  b=ivB1hGh3nBtFjMq9DfNirlBbwfaGt5UB7Y9hECUuWkSulOIbC6GMzGuw
   IVJax9Rp8TETc3gzsyRwpCpowSZoxPSDRiOVUfLvpCBthsKlLXAw5AkOM
   2B8bYv5AfFYw7FkqfBpHOJQZAgFOL9dGHvZqS/yro9nFmhjb6d4PlQytC
   czEcRCxCBt0zwZPI7l7y0QCMWBkU8f+ay8pgN3ACmaF46VSSn7Wj6Cv3s
   KnSvA+/ZxDmrtA9xNqcF4P0U308lt7gEVF4mu7E/S9fcGqr3HkWg7ngek
   9KsS9LY4C+hwQpTqU3R5W9Y7EoqJBXzHEDlciIYK40YLSCC7P4vi73UiC
   Q==;
X-CSE-ConnectionGUID: NQUnbnRaSt27oVLOcQQGZw==
X-CSE-MsgGUID: rSiL/a8ORMmEsFPz1SjZSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73072071"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="73072071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:13:21 -0800
X-CSE-ConnectionGUID: Hv38l+I6Q46JTW5pXgNO5A==
X-CSE-MsgGUID: 8fSKAEcSR2K99XawuWT0HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="239635647"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:13:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:13:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 10:13:20 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQTo+LVdiL94lcHGK3DaraMOEAh9a3efN9tlSUssl+nEwOhcm9EgnFZlvQFOuIoxBgR4tlsBuxcpxs13VJACNSR3PfZmmOpb75UM13Vfc4lmX9oW+dU0yXtXqGy4wpnBA4AlrzZzt7gR0CnbPrGOVldLdJrHxpFQdcVNFuUqbzG39uOQZgvhLwrPNX2SUxms/Gx/Ah+5j3xI5p81S7SrjBOpCQ+jiLqXKrd/ryn0Fkrxz6pOGALSX2VUsfY/sNQX23UfD8sE8Z0DEeLgDSaZcuJ/+VEjStBXTxx36UoaGMno9ViqFpFFycSWTESQOxfHMN9YH5oIt0fOyC6qr34yDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S345A2eTYDU9oMmo0LH/E5l2GzGaGelRYRlMj5/GREo=;
 b=JZXMQu+xp7OcEwfavhtMFCTVuGSzQKsWX6nJefxnyl19rvM2Umq05NSITPEdG8/gmpiy4bL6HaBkjqzqOuwhnsUvcakQoy9T4QG+ewA/2/azqIeZumAF3lbFKz+Qe0ZP+K/B3bzuEtdCVJfj+r/vZYvHhvKzrOvwMUbv7UOq7xMwxPzQSozgx6yoxyY0XxEhp4Ce2aJ8CWllbONx1SIAKyl6rgmkNtE0703usA/ylrY3hriDtHdxZSWbaPmU79vX0A+f5gQy4RH1Bg1C98emkC2Mj/DEJAf3uuN78adEcZ5//19qQVLZLPn1e7epBtCMBgFdi60cp6l0CYk/lyMbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM6PR11MB4625.namprd11.prod.outlook.com (2603:10b6:5:2a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 18:13:18 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 18:13:18 +0000
Message-ID: <af90b7e6-de47-485d-9e1b-31612456ef9c@intel.com>
Date: Thu, 26 Feb 2026 10:13:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] ice: access @pp through netmem_desc instead of
 page
To: Byungchul Park <byungchul@sk.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel_team@skhynix.com>,
	<harry.yoo@oracle.com>, <david@redhat.com>, <willy@infradead.org>,
	<toke@redhat.com>, <asml.silence@gmail.com>, <almasrymina@google.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20260224053546.62757-1-byungchul@sk.com>
 <20260226010811.GA16777@system.software.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260226010811.GA16777@system.software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM6PR11MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 4456d80d-3f72-4476-fe77-08de7562b748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: zFxfdnQ4BKdvOV30rfFA1/E1PK0aTK3aP8IHTPW0Mg2haaLmyHx4siuV7aofQqDc4oz1jeo6lNSD9hIMsPafTWKF+CCKAbmskatPXu2wFbjQo+n8GQUZ5icn1yECw5A/DPktM7SSwqAguxswsfgjzw85I//6osMQV/HCugBpRZoVFETov6JlBQ6Vp4ZNAHOZCi5EV6erBi4JyP24CySoAc2o+P/VvTo0NL+kMUFME2BzjcPQIzov6aNcYal45OdtqOh8quG6d4RsAizLCw360IxB+8IRCAQ0s4+O0oP+cJcaMID6DA+mIY6HffY9JENYv3PvHHsDoZVWKdMC2QWJX2cFDvCR1hlt5DHC0+Wqis4KonGMQgWLtxKqEQgc4piisIh5z7Ppw/9Ugq4olMLUu7o3MidVfffUraddHCzBJRXuIGaaNr7KrKLULFUMsiwPuBku9Bzmdpfv3b7Vpp64Jdecl0/QOoa8iscy6/NKVXpb9fSDcbvcnqyS5uN4ygBl4VjNeOOWg5TUslwIkcAxrpKsnnIZ4q7M2S/7EdrJQdvLFv6hHFFb/AmBnipsacgK31K4N/2wSclobJhcZoj4LdsUoKBB1NmmbQRiDerBx5TohhwuMr51Bu9NTV66pSXBYT/lBmP8kN3I7S+g+SB1w7XbBC6cVv+NB76nrAXsnu+gI94sG2xMMJBgbz1A/OGwKbaaLp8xhxXpIaAJTA79nFRTZlmYp7z4kQSPHwCbQY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjkwTWplNGlXRWZOUXNGdXpkWHI3QytvaVY1dGFNQzA0K2d5Mzh4dUgvcHJx?=
 =?utf-8?B?VzJHK0FxOHRaN0tpTWkreG1UUDE2V3ZvdUx2bnArRytKVGIrZklzeVNCVGZG?=
 =?utf-8?B?UWVQenNNYStIMTczUm5wVU1xN3hLcDRKeDJRNnR5a1pacEFUNnNVOUd0alJa?=
 =?utf-8?B?MkxLN2dzSWdRSGQ4ek8yeW5wTDNtekxNdm52d1pFblpoR2MwdDVTQ2ZCbC9M?=
 =?utf-8?B?eWg5ZCs3SW5BR29XTkh4ZTdYbnpMQStNbjYyeGFRam1wSUJkcVRhVWtuUktr?=
 =?utf-8?B?MnVwWnl2L1h6UDFKYkdoZFdnb3RSZ2dUNzZZMDNZOXdoczhsSW8venQ2dVBM?=
 =?utf-8?B?OW1heTF4YWVvd1dRbTduVWUxSDFmRC9adzhNWXdYMmg0ZE8vdmpGV25oWlJz?=
 =?utf-8?B?YWpCeVRIWCtUVGVCUFd3VzNDajJ0dlRyeUIwNU1DTjhnRnBQOWlFNHhWZzNk?=
 =?utf-8?B?SU1PTkFHcksrb0pIaGtzbTJFemo1NS9EUTJMWjV2NnAyT0pqK3NvY3JMQnZG?=
 =?utf-8?B?T2kxelphcFppVEh2U3hocWgyemFVVFBpTzhyOENYK280cWtSZDlaS253cExJ?=
 =?utf-8?B?cmZsQTVCbnFXUGFZd1QwcHNXV2dJSUlXOXNtY1dWbm5CbkFwOXI5STVDb04z?=
 =?utf-8?B?enBFVDlCbUFwQWVlZTJnSTRZRUtPSDczUEY2RllFaUdoRWJ1elcza0hMdm1l?=
 =?utf-8?B?WkphdzR2U21jakkxVzcrTUNIemVXZVE2WjhqU3gwSkp6OFRSL004aDBPcVFB?=
 =?utf-8?B?VHI3YzNmQ0svdG5zcmhzQU9qNFlkMmlTZXI3dTR5Z0F4QVlnK3J3VmM0TDFH?=
 =?utf-8?B?VFZjTFpNNXRmYTZjamhoVU1GTGNEcVhEM0FsYk11SUJHT0dTd1FzU1lXdVB1?=
 =?utf-8?B?M3RQM1YyWGFtY2N1cDhVMEhNd1VaV3Jtam5INVVqUnpRMldiM242REpGdUp2?=
 =?utf-8?B?TE1uWHJ2K2tZcnhXMXFJbVAzMGpqZjlNdVNwOHU3OWN2K3E0bzcyMUxBVVZu?=
 =?utf-8?B?bVVrQ2hwUzdyUlR0blVKK0QxZ29odGUzSTZya3d4ejB5ajcrU1VHMllZenhC?=
 =?utf-8?B?MU1BcmdqdGMzYXEvVHZJL1BtbjhYRnRPNnEyNGtTbWNnMjBrakJaOFJzUzgw?=
 =?utf-8?B?YXJ3aTRTRmpZQmR4Qzg4bXlsbjhhaFA4Nk8xZVUwWjJsanNBTFp5VjF2cW9I?=
 =?utf-8?B?N05VcmVwL24zS1pXb0JaRjd2OHppbmRxUnR4cmtqQWlsblk1Rk5zY0RYYWdR?=
 =?utf-8?B?LzZIWTZWaGNVaXk0YjFzRG9oa00rLzFjR0J0OC91MWJKbGpqVEt4KzdEbkFs?=
 =?utf-8?B?NkhpTUwzdVdJQzZqRndlczhJOWJzKzQ4clhaUDNXWDBjcU4wL1htQzcweklJ?=
 =?utf-8?B?TDdFOEFyeDZINHJEU0RZMUxYWXQ5ZkppWURjMTZpUlo0UXUwUXlYaE5Vamlq?=
 =?utf-8?B?MnNaa0RZUG5YRUNVWEVmMzVYcnFYeFA3Y0t6WFlRdjY5bDkxM0JFNXVDYWVX?=
 =?utf-8?B?ZE5INXkzeWRKV240RW5PU2YxK2czMHphKzJmcUQ0aDdhQ2lCZmJtTHhkcWh0?=
 =?utf-8?B?S0hyWnFicldPbXNnSEdXYkN5eTRIcnB1UURpeW4va1NmSFVjQWZQekFZRmdj?=
 =?utf-8?B?cmkycGhUZmRTVWdCVGVrM3NuTm5hZ09CQ01qc1gwWkh5WkhhVFZSeVROaGcw?=
 =?utf-8?B?MXpEendlRTJlZWttZ0E1eDZtVlpVVER3ajZWNkFiUWFxcUVRejBNL01oQzB1?=
 =?utf-8?B?ZUR2eHNOQjJ2ZVIraHNFbjBzaDlqUmZ2R2U1MXN6aU5kWnplRjZueCtGMmVz?=
 =?utf-8?B?bE5NbTBMb0lZZnBoMU9sK292M2FFVTRBRXN2U2h4YjRkaTdXS0libUEwMWR6?=
 =?utf-8?B?T2NvV3JOMGJvcklyd2pFc0FtdGtVbXZZbzdyajJmQzI5R29DZS9aR3FHbE4x?=
 =?utf-8?B?SVVFNW5TRHcwVGM0QkVvc3RFa1g5VEJ6K3U2T3RJTlhFYk5FRU1Ga0Z0RnYz?=
 =?utf-8?B?NmMwTGlqZ3hwbm03UUF1blM4VnhJWFN5Wi80UGhsc2k4U29iZXpQdHlyd1A1?=
 =?utf-8?B?VGJTNGFHS0tkMlFMQngxZTFnL2NSck80QXNWNTZLbTRBaXBDSnczUGpBUVFB?=
 =?utf-8?B?UmFTSmxua2dqRzNDV004VTJMbElpcXBSQ1V4TXlIRlh4WTBYdHc1eFlFV041?=
 =?utf-8?B?d3oyMVF1K1RwWk0vc29EcUFBMWlYbWlsTlpja2Q5aytWUHczMzVaaVozd1lI?=
 =?utf-8?B?WVFUYWEvd0tGeCtzQVNGSEg1aFFSMnFtYVJpdFBzS0wzUGl5dmxoeXAzMnFN?=
 =?utf-8?B?eCtzaGFuaHNpSTFrT1VPRnMybTFCdWZPQW91Smp4V0F2MU52NXNZQ204V3Vp?=
 =?utf-8?Q?WjP3EFeCfxBpSbQI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4456d80d-3f72-4476-fe77-08de7562b748
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:13:18.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+2vwTRixMyQVyWuPrMiN1zPJfXA6U1P/z5xm4f6yePcu6iEiKoJol1H3B1wZxmfp+ypTTV7PwNHpZaseVOZLjHlz5WAfOFidtF0c0rJdbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4625
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261526-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,redhat.com,infradead.org,gmail.com,google.com,intel.com,lunn.ch,davemloft.net,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sk.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7B4861AE0F0
X-Rspamd-Action: no action



On 2/25/2026 5:08 PM, Byungchul Park wrote:
> On Tue, Feb 24, 2026 at 02:35:46PM +0900, Byungchul Park wrote:
>> To eliminate the use of struct page in page pool, the page pool users
>> should use netmem descriptor and APIs instead.
>>
>> Make ice driver access @pp through netmem_desc instead of page.
> 
> Hi Tony and Przemek,
> 
> Is there something that I'm missing or something wrong with this?  Your
> feedback would be appreciated.  Thanks!

Hi Byungchul,

Nothing wrong. I plan to apply it today.

Thanks,
Tony

> 	Byungchul
> 
>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> index c6bc29cfb8e6..c16e54dbe75b 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>>   		rx_buf = &rx_ring->rx_fqes[i];
>>   		page = __netmem_to_page(rx_buf->netmem);
>>   		received_buf = page_address(page) + rx_buf->offset +
>> -			       page->pp->p.offset;
>> +			       pp_page_to_nmdesc(page)->pp->p.offset;
>>   
>>   		if (ice_lbtest_check_frame(received_buf))
>>   			valid_frames++;
>> -- 
>> 2.17.1


