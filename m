Return-Path: <netdev+bounces-170114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B005CA4751A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 06:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74893AB3F6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85B194A44;
	Thu, 27 Feb 2025 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJoarhDs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F5270026
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633410; cv=fail; b=X5VwlOfwFA5cR4+1ShBG/awhKEsIY+wjWFcbOvktAtZQBVWCen9IvwbV2kQRpyAVdEsYv+INBNio4cBPyQ06xINR5YfRwEKJx7b4vuxU1cCjKaK1Z2/CExIZyW1XGd2V4j5yKp/xtq/gD6j9Djo+qpm7We45hZ+aIbQts6oHXmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633410; c=relaxed/simple;
	bh=lrlygwvcZwmPBah1q4lYWjtDxyqtxUzNJ7SoVEN0LPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJq4UZaJHN6PvftapNxPcInMPZZdc0TiMCLJ5YEO5TWRMnMgLQZBpnmMaSUlNlRjBoMit2hTLxtV+Vojl8NhgkCaBWxSD7Ml/QsH+HWb5C/VoHIJLLVloYfuPZe4VRyDmhC9kLe7z7O0uq785Sd/jCzkVgXdXMAuckVb8qk+TL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJoarhDs; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740633409; x=1772169409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lrlygwvcZwmPBah1q4lYWjtDxyqtxUzNJ7SoVEN0LPA=;
  b=hJoarhDsrGARK+QXhN8kgnnauNy7Ecfnppkkqe6OzWTbWzv123eFyFyG
   WiFfwQYEhMfr2fXHMRtEwJcfTZn6MDONnbjJGi9rjo6OlQaAOlVMs4Qpx
   2cFfSgx3qFnr3EhfDKJYnsxv0taFc9/syd0XFcOKg3USv7LD8Ku/swN62
   7CDtI0Uyw2OKFsVy19mHJovL3hgthnqMcvVNrSUBHBQGOAXMAHP73tK/p
   Hn5LVUbodl4L91ouLn7hThRuUXmrlzjLvLtmwDlI44m+0+dCR9EpC4wrG
   dJIU5mRfXcGjhOaf0JpwLEoLNVsncfaYwR1HO8GSJ32yE+IhOlUETqrUV
   Q==;
X-CSE-ConnectionGUID: Zb4tMubJROSwLfgW9b9nVQ==
X-CSE-MsgGUID: N3bYQMVsSHa8lma6ATw2oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52905757"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52905757"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:16:49 -0800
X-CSE-ConnectionGUID: 8+Tev/9tTq++BBLj6J8+hQ==
X-CSE-MsgGUID: gSCIe0HyRLCpIS5lhw2UKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121043112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 21:16:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 21:16:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 21:16:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:16:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5CNl3kF47W1ejXoMUnmefOGRESQY5R672BIpJ0RrIxM/Isec28iXjaKpDDuCs1oZPhtb/0PwFg7gqhiRkdYzmDLVvznrlsN1y0NZJTY7CtMBoVtSvxUpRT2rbSOk2oSP6m3MB5/meu9/Wf/iiCKAGpE5UtxINZP5KPi/jB8C5UO0z3cuX6nmmiBmZY07Yww3bOOLMhceo0Y+pPjQb8Z/1KH5QWyekY2MVkobGoLGS8FOTiBnlVXAwepTpYYdD+Qq0nIsN7et9Rao8/vpJTSMSTl0MuBUtVobbfFL7N+mdS5Z492l5Xo8aEq/4QZLpuFTa8tPFdG+/ysKXkEroFhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NRCnF0rmvFIueX/CT/u4D75LgEYaSxJ9NgwkgJUPaU=;
 b=asJNtP9hsteR2LuVkizNO/nQDUE8aHnkG+2tRHisA1LcimvIYD91nqBCm+0/bDoQfZBn7sml9K0HQoYWallQh2GRvpgFN5Z7SDVrb0ILTlAXTonNPPfyHLBoFOlygP8zGrjVEzpaa09GXJRSjfaoJcXjTI+7wOMh/Qv6Oo3Iuc9gsSDBqfrYsHmfyEGibTqTGf0ycuNfbCwGIiz5XPkit7736NZQ4+NJESfetzsp8EOaicv/q3Y+xtHIas1jowLnzH2yhAjQGzbQdHyQJ8yb1cjG3OvusPk7IqN9q4F0NI2DhRO7BvuIwS3Sj8m+V8zE0bWt2BYTd7WisEdYYhCHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 05:16:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 05:16:29 +0000
Message-ID: <1dcd305d-1968-4ec7-ba3d-df66f214e131@intel.com>
Date: Thu, 27 Feb 2025 06:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: fix checksums set in idpf_rx_rsc()
To: Eric Dumazet <edumazet@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Willem de Bruijn <willemb@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20250226221253.1927782-1-edumazet@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250226221253.1927782-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e8e18f-6e85-450d-4f6e-08dd56ede44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVAzMTBqVmNac0xKeFcyUjMwUGlWeitaT0RPWEVUclZlYmhyRjhWbGhmKzV0?=
 =?utf-8?B?cnZjM0J0Q1VxbWZhZ3kwLzNCNjhWT3pKKzNvSnk0SmxtVHVoVjBIS1pQaEwz?=
 =?utf-8?B?bWJPbXpyOGZEbmNROHhEK1lDL0dIam9WVHZVcHg4cXpQaEtDSXY4c095czhF?=
 =?utf-8?B?UFRzeDNNVEhFelhLYUcrSEhhMWtjeUpHUmRBb1VyZEtEYm02cSs5SUsxakZE?=
 =?utf-8?B?UnFpMmVzT2JlTWFab240QnJUZXV3Y1pEMmF4Z2c1NkZESGRNSG1peXZpWUZU?=
 =?utf-8?B?bTh1K04yYUQ1RU5rVzdvWEVjc1JKeWNiMkdDY0R2TEVyTHd3TkEwMjkyZVBK?=
 =?utf-8?B?YlU0QzllNmtvQjNESHFCbWQ5MW9TTlZVbnQxN3BPdWdSMHUwWnpIL0ZrNUJ1?=
 =?utf-8?B?d2pDMTNxTFR2dGdMamM2czhDRFl1ckVMU3RzMGlpaERvYURObjcrRklhQUdv?=
 =?utf-8?B?Skg5QjdQMWFyRzBQOTdEZTBjb2xqNVdxaFBHMHRNL2lUdTlTVGd3QXljYUFa?=
 =?utf-8?B?aXdhQzFBWjZlQjVVYUJFKzI5aTJFeDQ1dllRK3RxbFlVeE1aVWtHT2VYeUlQ?=
 =?utf-8?B?NXNjQk5rOUs4WnJNNkgyVEUxS2FnRm1PSXdUcUVXckRtRlpjYXVwOU9jRTVr?=
 =?utf-8?B?RWtKL2pXSjNyOHFONlVQclhpNTl2MGo4ZFhnTHBEL2RhSkhxZW9WazkzSzJr?=
 =?utf-8?B?SHE1ejdlbWUwUzBJNS83WkdJZFpXdCtQZkQ5Q0F1RHhWcjdYaWNFQVJKWmkw?=
 =?utf-8?B?clFSNEZVaC92aEtkdGxFWFlvMnBKRDhGdGdtYTlGYk5kSEowTXNWWk4yNjh5?=
 =?utf-8?B?aitid2U1SHg2VHc3VDJxd3RsbGJZZmFOeHBtQzdnVjFKbXNQS1VZVUZEa0Z6?=
 =?utf-8?B?VFJLQUI3cVc5ZXdheHVCd2w1dXRaUlV6MElUNlFUM29XRHlxbmd0RmhlbFJT?=
 =?utf-8?B?TlhUaDcrRzBXOUt1VTUvWWNGMFdPRmNEVVdBM05pT2xhZGlBWWlQb0Y5QTZo?=
 =?utf-8?B?QnBlanZQVnJXcWxnN2dJbUhEZ00wS09QM2kyaFBQMXd0VnIvaWNGTlNUOEpv?=
 =?utf-8?B?SFBLRVViWXY3SmppYXlnOXlRd1gxdUxTUTFMazNqYklJZ1VMckI0b3ZKZERR?=
 =?utf-8?B?MXJQMXg4THB1Y3lGQ0lnMGd4a2hZT1djblRublBTOW5WU1Zpdld0cm1OdG9E?=
 =?utf-8?B?WGxzZWNYSXRLaXMxOThFZVV2eVY4RVdITnpueHFCOGtMVEhDSW9kSFhDWlZw?=
 =?utf-8?B?eFNsUjhGbFpqT2pnc0JSL3gzVngvRTFHUlZhSWczK1IvRmNJMjR4aFUrWHhO?=
 =?utf-8?B?L25DRzQ4aEFJRWFzbklZQllGMCs2d1FLdVJIaHJnS2IwUTVNT0JSQzFEcktE?=
 =?utf-8?B?OHk5VExEV2xjRGFtaTBxTis3ZDAvK0I0NG1yUTR4L3FhWUxOdWRNb25kY1BH?=
 =?utf-8?B?MzY5VnpEZDAzN1MxdnlCSTY3K3lEbWhSN1FNSUhXN0F3NkJPakpKVmhBT2xq?=
 =?utf-8?B?TWNZRWJLenJxcGNUdkNNU2dZemJocmJqeHY3bWt4VjdIdGtTNzI3WCs5UUZa?=
 =?utf-8?B?UnoyaytqYXhON1VlQVdLdHNBN0JBZlE0RWdoRldUVmZxQ3NxSkxYZHZENHRl?=
 =?utf-8?B?RW1odEVvVkJoNS9nSUF0SENyZlNjV21LZ3RWbUpDdE9hZG1HdmdvVFMvTU9O?=
 =?utf-8?B?WVU3UnJBN082Z1hpSlVFSEUwT2psS1cycERWMTJLWlgya3MzMW1rT1lIbEUr?=
 =?utf-8?B?TFNYNVV4UWdrbzc0K0FybmozK1dpN3ZsYlJHMi9Lell1NUcrOC96ZGlXZzdG?=
 =?utf-8?B?UXZsS1ZqV3c5Z2gvR2ZtRGx6WU1yREl6QXNveVlrREx6WEt0NlFPVXI1YW9F?=
 =?utf-8?Q?cqS1rdcfoKYh8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlIrYlFxRkZsZVVuaG1Gczk0MkVJblgwUTg5SmUyVDBTcG9sUWZUV2pXK3po?=
 =?utf-8?B?U1RvMTYzZklwYUg2UDlmaUdLQmhRMk4xbGtsYVRpYmRmcHVVSmk0YjNRbTNt?=
 =?utf-8?B?V283MzExalA2Ry80OVlvcmt2UWlPcUtwb1huTG0xaUczUzdRTFl0V2tJRW85?=
 =?utf-8?B?K0hZakY0UUpMZWNHeldlbklGeENFOWRGdnd1VWVJU2dqRTV2emljaFpYV1Ir?=
 =?utf-8?B?RkNySmZpMlhmOFBrYmN3akRHZGJ1UFhUdk55TFNCcWVsSWFKWk1yTHZlRjdk?=
 =?utf-8?B?OVA1bjJjWjZjU1d5aGFJNmJjZXBKTXh5ZFNFNGRGN0s0bHQ3MFF2cXRwN0Ni?=
 =?utf-8?B?ZFpWellDdVdBUURPNW5qcHUvM1IxU1UrVTZQd0U3SkRNZGRxZ25rTldJOEkz?=
 =?utf-8?B?TTVaNUpUY0t6dGMydGZVVnJDWHl2RWxUYnlqTDcyM2IrY0JlSHVwZVQ3cEgv?=
 =?utf-8?B?RjRHYjZtbHJ1NElBQlNtbTAweCs5VzlFOHU0OGxrVkVnQVZTcVg1ZjJmZDE3?=
 =?utf-8?B?OUdkVk1TVjB6QTFKTGU5clhvT0tHYnAxOXh4YmQ0QVltdGFvTFFQV24vb3Rw?=
 =?utf-8?B?a2JjOFVlc3dhVWpvemJYdUFCK1F5QkdLcTFmb0kzcjhhUjJ6QnRDZVpLcU55?=
 =?utf-8?B?ci83SHFUVm9UZWhaVG5Ubmt4b05Mc3JhMnROaEtSRkdjV2NzckJxV0ZEbUJa?=
 =?utf-8?B?c2d1VFZsdGRZdUJGZzlKM1NMdDFrNjhBK1hJcEMwTG5GZUtSUVY2cEdrQzlv?=
 =?utf-8?B?eHFjK2ZveWV6ZE5RMzZDN25EOFNiT3JTOXZWUk85OVJ1bHFEVU9hZzJmT09k?=
 =?utf-8?B?QTdHZ0NTMEdtSkVqejkyRUFWR0Uzb3JrMUZYSHJSeUNLNjdmT0F5L2dBQWZK?=
 =?utf-8?B?WUJnUkJjdHVJODZVN3VzSUtqUXlKSlc5VEl6U3NFL1pSU296RXo0N1BBWnZ2?=
 =?utf-8?B?dmN6WXZjWUpZUzlZYytTV2EwWExZRmM0NWxheW4wL1B6WHdxOHNuOTZJczRL?=
 =?utf-8?B?QTYzRy96UnJJYmgyRnVpM1NHRVlta09SSVBpU0ZjRHFubnpMZXNSZTk5M1FK?=
 =?utf-8?B?eVBNZ2NLbHBVNkJQZW1rRGNsWVQ4OWhmdGN5Q2hqenNLZ2dKSEF3NmRhMnFU?=
 =?utf-8?B?R0ZVTU5nMWZaU014T3pVUzQ0TkRXek5CK0cwdzgyWStQd3VZRWd4TmV6L2tG?=
 =?utf-8?B?V3M1QnVCMC9KOUVUSzJUVkJjRUxPL0lKcmNEZDZSakR6VjhlVnQ2d0pZRk5l?=
 =?utf-8?B?MWV4dHFjOGFOSGllS2NSeHJqMEtadTYramRteGNJb2MzakNVcEJzbmdCd1BR?=
 =?utf-8?B?ZnZkZlR1MFdqanVLb0w3UmVMa0lGcHVwVlVReTVKaHJQY3RDaG4ySkRlVElC?=
 =?utf-8?B?NGl1Y3IyYitDZVRDbmdjcGpUWVBJSEd2YWlsRnl6K2pFTDlvLy9Ock1NN2hy?=
 =?utf-8?B?NDQ1S090UjhzOUtlMUxpUnFMZUw1YndLT2k1WjhsYzN0cTNJdS82ZWYwSVRD?=
 =?utf-8?B?eUc0bnZCbnFocUgvNkd0YnFoOHFSQ1YwcW9ORkVSbllyczlvYjFMZVhSSnEz?=
 =?utf-8?B?Z3lMQmJwTVh2YTBvdVdnZkV2L1lTRHFRODA5NmZsVjNoNnJmd2F0VFpUMnpa?=
 =?utf-8?B?bURtSFRwa0JQSnEwMHRSQVNLb2V4amxaR1BpRUlETEJHdnk4ZzRjV1RvUDIz?=
 =?utf-8?B?QjIrV3hWYlZTOUlVVWF5WGNCUGNTc3Y0ODVGcGFJMXEzazc5c0lra2tWTnNs?=
 =?utf-8?B?TUNzcTlBNDBITDFOclZUY0loYmZiUkxTWXB2MStvaE1XNElQRnBHU2xXb253?=
 =?utf-8?B?ZmtDQ0YraXBsWGUveVdONERiZE81cU94RFE5RW1HMGNTWmV3ODFuYktMeml3?=
 =?utf-8?B?OWNTWjVvajhuRUtHTWlQS0xqNFZUT3JlZEd5VW5EMHRnQ0xkUjY5N2dwRndl?=
 =?utf-8?B?QWMydXFKd0cxM0R4RG40YmMrcGd5YlgwTFRhSXJwNVBkdG1iaDBIZGhLRHdO?=
 =?utf-8?B?OGs1UzJ2Zjg0aHVDaWUvNWJxZUNOWmNycDczLzBiSjBCTUZMQUNPN2oveVV0?=
 =?utf-8?B?dHZNUjJ2MWwxeFNSUDFSV2J4WHcvb3pRMlhucVBBY2cyL1NIMWlPMngzait2?=
 =?utf-8?B?SW44aFpTWXN2THVudmNGaVYzQ0NOQ05FQzFMSHVRRDdYU2hOOWNMeEZxbXBa?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e8e18f-6e85-450d-4f6e-08dd56ede44e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:16:29.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsmDuzluAbusUSF6DD4VxiVCXizPBHaW/FHPLYnIAOhNB3AWTQbb5Pn/h/Y/NRjAriJFPlNCewAQzQ0B5NQGN298kNOWAr9aoG0rGdcDeR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com

On 2/26/25 23:12, Eric Dumazet wrote:
> idpf_rx_rsc() uses skb_transport_offset(skb) while the transport header
> is not set yet.
> 
> This triggers the following warning for CONFIG_DEBUG_NET=y builds.
> 
> DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb))
> 
> [   69.261620] WARNING: CPU: 7 PID: 0 at ./include/linux/skbuff.h:3020 idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
> [   69.261629] Modules linked in: vfat fat dummy bridge intel_uncore_frequency_tpmi intel_uncore_frequency_common intel_vsec_tpmi idpf intel_vsec cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd libeth
> [   69.261644] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G S      W          6.14.0-smp-DEV #1697
> [   69.261648] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [   69.261650] RIP: 0010:idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
> [   69.261677] ? __warn (kernel/panic.c:242 kernel/panic.c:748)
> [   69.261682] ? idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
> [   69.261687] ? report_bug (lib/bug.c:?)
> [   69.261690] ? handle_bug (arch/x86/kernel/traps.c:285)
> [   69.261694] ? exc_invalid_op (arch/x86/kernel/traps.c:309)
> [   69.261697] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
> [   69.261700] ? __pfx_idpf_vport_splitq_napi_poll (drivers/net/ethernet/intel/idpf/idpf_txrx.c:4011) idpf
> [   69.261704] ? idpf_vport_splitq_napi_poll (include/linux/skbuff.h:3020) idpf
> [   69.261708] ? idpf_vport_splitq_napi_poll (drivers/net/ethernet/intel/idpf/idpf_txrx.c:3072) idpf
> [   69.261712] __napi_poll (net/core/dev.c:7194)
> [   69.261716] net_rx_action (net/core/dev.c:7265)
> [   69.261718] ? __qdisc_run (net/sched/sch_generic.c:293)
> [   69.261721] ? sched_clock (arch/x86/include/asm/preempt.h:84 arch/x86/kernel/tsc.c:288)
> [   69.261726] handle_softirqs (kernel/softirq.c:561)
> 
> Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

thank you for the fix,
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> Cc: Alan Brady <alan.brady@intel.com>
> Cc: Joshua Hay <joshua.a.hay@intel.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 9be6a6b59c4e1414f993de39698b00fffa7d2940..977741c4149805b13b3b77fdfb612c514e2530e6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3013,7 +3013,6 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
>   	skb_shinfo(skb)->gso_size = rsc_seg_len;
>   
>   	skb_reset_network_header(skb);
> -	len = skb->len - skb_transport_offset(skb);
>   
>   	if (ipv4) {
>   		struct iphdr *ipv4h = ip_hdr(skb);
> @@ -3022,6 +3021,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
>   
>   		/* Reset and set transport header offset in skb */
>   		skb_set_transport_header(skb, sizeof(struct iphdr));
> +		len = skb->len - skb_transport_offset(skb);
>   
>   		/* Compute the TCP pseudo header checksum*/
>   		tcp_hdr(skb)->check =
> @@ -3031,6 +3031,7 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
>   
>   		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
>   		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +		len = skb->len - skb_transport_offset(skb);
>   		tcp_hdr(skb)->check =
>   			~tcp_v6_check(len, &ipv6h->saddr, &ipv6h->daddr, 0);
>   	}


