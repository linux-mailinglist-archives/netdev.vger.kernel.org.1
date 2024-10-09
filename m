Return-Path: <netdev+bounces-133904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD79976EF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E11C22BD8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A66191473;
	Wed,  9 Oct 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj0c7sor"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DD13AA27;
	Wed,  9 Oct 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507137; cv=fail; b=cG4wi4z00AOz3mQfSAJSWf10aUEooPmf1Y2cnxkyrgKhnejor0TAnCQw4oapzXXCxceiRys23+C+ecw1PGNETYsydK3WpkHFUF7o3Ozl5l/cj4j19vWvSqF/87iI+jzEBuL9Fz4VXcIdp0ot0lgr21x938pnqS9TnkogMZizduo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507137; c=relaxed/simple;
	bh=fu0lVNTtO1vXnmLbyKSnRib3QBzfb2KYQhBe7AzYrV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=azXbEj6uDLUjDyA2274ww+lTyKJHOEwvYLcv0pNCp0RLL/wW/wVa0I9sp4bmXmKa60eWJNGZNak/hvrDWXb9PyNJp2fAoWJs5ZaOIxPanN9FbYKwMtx6kv65gt6giW25oUHKvD2AZMAi3FlZku65rnzG6ljzgUBVvWxAAE2xRA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj0c7sor; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728507136; x=1760043136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fu0lVNTtO1vXnmLbyKSnRib3QBzfb2KYQhBe7AzYrV0=;
  b=kj0c7sorX4T8bC051HLPmByatIE5+g3MjvhIsT7alrHagItIbUPTjn2H
   Eij/mBDwQFTQaxTIa9gaKabXo4zKZh/81pX/fbvP7bvucHi/fcwXJ1Gle
   svrA7U6UvpkupPD61Xi6onyumd3o25DwaZxXyo8ZSN+BUCz1NF3zKZQwh
   RhKdvB/QYHuWjQM81TaSiY024sqmTX60E17EC1wUH0wK5N7DkC2BcM4eG
   asHEDRwFuRNGJ80TEP+cIcbGhCpP/3plTKeOsDDbvlA8Xt7crodan4Buw
   jDucetQllv4b9yAz/m0qPWm47tmjQ683m01Z/Cppg+xtbRI9ixl3+Kr9+
   w==;
X-CSE-ConnectionGUID: uyuDHB3uRw+28K2I4Ovvnw==
X-CSE-MsgGUID: J9jaPe+mSrm6pqHY7Vg1oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39229561"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="39229561"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 13:52:15 -0700
X-CSE-ConnectionGUID: bW+uAa9hTs28b3MvZYR2Wg==
X-CSE-MsgGUID: W0eG8IygSaSTF0IeRWuoDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81388906"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 13:52:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 13:52:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 13:52:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 13:52:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 13:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxem9g8dd33n+g5OdUL4veloyNc3HgW4S2sboRIBuHTc3vESJom/1+GEiGVOMsKVzCeIV8C9ClBorqpCdUNcqz40BSAh/vKbe5TecrzWRBaWWCkKu44WB9tOWiW+0MGgLKfQa5krz5RnEyd+JQVg6JroUzN9odO/ku+T6Z6FJ0doB1MKSv/nFTQIlPJC4En5glo7OT8k5eFTlbk88JbB2YJA4LScqNvl/jNAV+r7nPykYCPAIuhE1w2Z0dDWTwcWN6gC4oMJa0EVvdonavbyLgqYT6/bKs1t7YVcstEwajyTE+EhPXo/VwbIW2NNR+wc4nn6rqpxm/vYsa4HLe23RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu0lVNTtO1vXnmLbyKSnRib3QBzfb2KYQhBe7AzYrV0=;
 b=cQpZzgt9EFxBqXCrlSyY+U/tOl03IIBpUDRrw6S9Afr+yjYadP6jwFdK/TzsqvVMQZC3QsJJQsMKKQjDYtKcNIoZDgVhIdLKzQC3rWD5twV4wRXnSmZmDZq6+D211QCmhIRl6pdOkNbxIg5P9fbxJ8lMItXVAycWVizsHD3T5TLoStDsqXlYVs4H9xPeQr5vGzWbAz3EdDLGEvXMqDyw2kxHMcawd62XeUUwRVkzjNX9XxrPV4UI6T8MGM/22ZqtAk6acRpXNNP6+zkM9ynvvdX42PDPaNK+qPt/Rjd81ygSTUM82rC+oOIhJNhdDqbYXCZAPEvsJtn112VefCq+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:52:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 20:52:06 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in
 the pack() test
Thread-Topic: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in
 the pack() test
Thread-Index: AQHbFkyovMasxAyjhkimZ9GSYotRCbJ2+CBggAdFQACAALAswA==
Date: Wed, 9 Oct 2024 20:52:06 +0000
Message-ID: <CO1PR11MB5089A56FD7E08E9673021D23D67F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
 <CO1PR11MB5089426510DEAF985A5A4CB0D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
 <9fd99d07-25d9-49ea-a450-bc1140cc7859@intel.com>
In-Reply-To: <9fd99d07-25d9-49ea-a450-bc1140cc7859@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 4af91d14-99c9-4c95-0838-08dce8a43c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWRXSElWa3dJUDdwellBZFd4SVl5d2JUVXVHdGhJcW9iVkF0U2FQN29mWWxT?=
 =?utf-8?B?NzNBN1VWT3p1cDl1QStqN29Dd2E0d3hmZ1laMFdnU0p4VW5Cd0FNTEJJcEpM?=
 =?utf-8?B?WXVOQVAybGlxVjB3RkpOUytPRGdDNW1ndFowNmJKK2EwQUxublNnVjhoZVQ4?=
 =?utf-8?B?U0pvcHNhU0NLcEpmTFRwOFR0T1VlanpKUjBzUHNoQzlxN1VnS0k4RmYzVUE4?=
 =?utf-8?B?blhlY3I2UC9lUzBjeDBhc0FQZTJxekJMT2EvWjVFNnhZekFxYjBnclJSZnV6?=
 =?utf-8?B?VUUwZHRVbEIzUW16MHB6MmpERGxXMGFhWVhTdFFwNUZ1T3FtUmFrQThiRHlM?=
 =?utf-8?B?TXhVakJTMTV0MlFKMk1aZ2hIdzJiSlRoQ2s4UWlxZzBteHdkRmI3SjNhQ0J4?=
 =?utf-8?B?NHlLdmRxajJCTGRvQmRTODl5dGp4NithcWlnMm5BTWtTREgvNUs4YTJRbjJF?=
 =?utf-8?B?bHJCMm9TdG5idjRRZ3RORE1zQUxiK0dpL0VkZkwvQWF4ZWQxNGdGUFRaUHIv?=
 =?utf-8?B?Rk0xUjBsVVlzeCtzYTFjN3hzU2RjcUEvZzVzRGRwNDFqWHl5TlErN0s3Umd5?=
 =?utf-8?B?elJOMWkrYWtuVktuNVR4YyszYjhLUU5PbzFsT0lzTU90VjRlby9aSFpSa1ln?=
 =?utf-8?B?aWpmTFFwSW5IVm9LZ0tzMmhReWhVRDluTmlJanZrVkhwdVA4ekRxU1dkdnA0?=
 =?utf-8?B?c1RJbjBjc3JIOXRYcE1QN01xT3JzV3BFR2ZLd0QrSysyNkgxa2Zsb0VINTZV?=
 =?utf-8?B?ZGR1VmdEdGI3U2o5WnVINHM0TG1MSzdyd2w2TTd2M1FMZDhnbUl5MUVCcFlz?=
 =?utf-8?B?V3drZ3A5azBCcHQ3RDc0WndMVzhVT2U5a1BPSXRaOVRMVVpaS2srNTZXWHJa?=
 =?utf-8?B?TzgxNEw4ejFuUTg0dWJTeTEzVFNob1EydjZ3djRTMjlrVmZuR3hzMjdwUGZ3?=
 =?utf-8?B?T3N5T0V6WlRXQVp4WS9sUFd0WnEzaFdBbzhJNERUOUZwR1UrUm9ENUczTHls?=
 =?utf-8?B?Wm1UVEZ3dVJycjh4QnRTR3UvcytqMUNDc3NtcHZPS1RZSS90cVltNkl0d3Zm?=
 =?utf-8?B?eWg4bCtuYm0yYkNUOWRLRjlYb0cySkREbEM3SGFiUmdKVVRsNm9PNmhrMVMr?=
 =?utf-8?B?S2ZlbFhaenZWZFVTYU45bjVkTW9pNDlRbjByWHFLWGU3ZFBuR2VYMXlmU3ZV?=
 =?utf-8?B?TlpnN1plSFEycjdKYjJFVW9LT1gzdFN2TUU3Y0NrZHg4eU9FY3pwM3lVeDJG?=
 =?utf-8?B?WEF5T1RzdG10VXdRTUd6YVkwVlMyNHlqNjBmSlVGSFRUbGRneElNRTdVNTFP?=
 =?utf-8?B?STRyejRZQ3RESXZFTE9lczljak1SUUoxK0hHM3RpTm9kd0lvWjVOeDhScVhZ?=
 =?utf-8?B?T0RzTVdveVB0cTFzRDlHZmxEK21GTXByU2pQVEhLZTE4bmtyK2pOMm53Zi9m?=
 =?utf-8?B?bmMyelk2aDkrTHlGcFFFMmpvVHgvcmVkR253UVVnRDdRc3Y1eWVteWdzSVBF?=
 =?utf-8?B?eExZSHBEeTB5RllLL3pWdnE2bGhpWmNhK01FOVNOWmo3dis3aUk3YUZaQmpH?=
 =?utf-8?B?a0t6MlNpbDZNWjdNYXN4bHY4TUVmZy9WdHQ2dGpBdytwY2FQVTQveWVPLy9J?=
 =?utf-8?B?cGFLT1pxZ1N6L3BOUm1FU1JpVzFrMW9DZGhwcVdoSVpIWUwrRy9BQWVZK0k2?=
 =?utf-8?B?d3lBU3YwUDdjY2htc2pNQ2MrTHhNZzNsdmk1WThyTGlJVUZ3bXpjTm1sZ0ox?=
 =?utf-8?B?N240b1l3dlkyWUJFU2ZxL2liVUNUTEI3Z0RpejhJY1JhN290K3BhMzIzeXhj?=
 =?utf-8?B?eVBESUc1eGNpRVZ3cEpTdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm14Tnc1aTNwdUx2YVJkREhhUmdDRndjTzFyKzdvOFR6UkEzR0I4UThld2xF?=
 =?utf-8?B?a0ZhSWs5SzJFR1dFRGhXeVIyTnNvMmo4ZFVOSVM0bC91MnZZZzNKWWp5dFlT?=
 =?utf-8?B?WmxPQVFocUF1cnFPejVLUjFHLzNna1F1dGtHOUNsWFlwNVZxdEF0NkRITkJ5?=
 =?utf-8?B?VFUzcHBuejM3ZnRlTFdJUjNWcGh6Z29wdG13WVMwQ1oyV0tQMGhCS1ExbnEz?=
 =?utf-8?B?TXEzK2QzK1VPV0ZBVTdIbnJjVE9xZzdlMVE1TlNmSjVRcWtQT01Dcy9scTF0?=
 =?utf-8?B?S0NTeG1XQmtrU2ZUY2htOVpES0lVb0g4dzYwSW13WGdteHBNM3NaSUVtdTJv?=
 =?utf-8?B?blhGTkFhaVNQditnVUx6UkFZUEFGREVxWk1tNzN4U0cybG1JMmFqVnFqWkJT?=
 =?utf-8?B?WVpuUXBVN3o2UnZ2bmZjTVZQWjM4WkovQjlzTDNUVHN4d0R5NC9qR1piUkdl?=
 =?utf-8?B?VGhEV0lUclgwT2JqZDdFd0VwWmZRUWhhVGxjSGMveUg1SHZGWTFwVldhMXJV?=
 =?utf-8?B?Yi9nY1BQbm82SU1xTlA2Q1NEVFdjRS9WNnEzdG0rbmpDRmJQMkwwWnJRRmdO?=
 =?utf-8?B?SlpJcHE0cTBaUUE0ZHNGLzlDNVA3ZStZblpsWXJXejYzSE9rZXRubXJjQ2Qz?=
 =?utf-8?B?RERvWm9WL2V3MG1GakovcVdtNW9JSlpMUlJvNEgwb1F5OVNqL3AybkxLenhs?=
 =?utf-8?B?QWVxd2wrWVNNVEhFMGR0SmdDbFFmVERQbVVnWmdhK1ZlY3lVU0g5SmpNWTZ3?=
 =?utf-8?B?ejd3TlZ3akNHRW00M0g4cVdpdTErMWRmL0M5UnpLZjRSc011NUM5aFFDUG1j?=
 =?utf-8?B?THFpdlBUMHg0a2pWMStTNjR6dyttcncvTXd4S1R6QmwrVHNlVTZrSkxVaTdq?=
 =?utf-8?B?T29SQnBhS0E5MlZrdjVkVWo3QkNhdU9ISm9FYnFFa3pMMWZYTlozcjZ1a1hM?=
 =?utf-8?B?QTZSTlp6U09wL2wvcmV6TUo1SUVBYVU4QW5xYUhrZlZwWGtZcHpmSTZMSjFG?=
 =?utf-8?B?Zm9jZHpNdDR5VVhScEVYSWpudUJrMy94TVFlb1VJS2NESHdRSklDbXRCRTBT?=
 =?utf-8?B?UHo5dEVxdjRWQ1R2VkhxR3g2ZHc2bzFRa3VMdnQ0d3FLb3l2UGd5Y1JUUlpC?=
 =?utf-8?B?WHAxNDRkaGVGVXVhNjZ0QTFQM0FJRWJPNXFPaDJxc0xLRklQRm0wTmc1Mngy?=
 =?utf-8?B?VFhFQVhKUTlWYk1ISVBiRjJiV0Q5alVNRUdub1BIK1J1a3J5QTFoL2FsMWR3?=
 =?utf-8?B?WG1OY3pranBZd3R0aVNOOCtTUG14UW5oaGpPRkRvdVVNby84ejhtd0RZRmJY?=
 =?utf-8?B?ZkNTcXBUa0lvekQ0dFV1ZkFwK0tGNVpUV2NyUWxFcDhMSm1uZmJieUcxazcz?=
 =?utf-8?B?TGY5V3VWejQ3ZTY5eE4xeExBZUVzWmhjdGxQY1JzUU1zNUh3eC9VN3dXYU42?=
 =?utf-8?B?NldjOHk3T2R1RVBNTm1KTFB0MkJ6MnpIWWZaZlJQZEZ2UExDWGltNGw4RUdF?=
 =?utf-8?B?czMrVUJsQTRxd2xEVzVHNGQ1WWFRZG9KTVgzNDNFMkYzTG5mdFJLdDhFMDVB?=
 =?utf-8?B?NzFtV05wYTVNRmt5WC9WUEhKY1dlMnlDSm53U3pITk9jUW1JRElMYyttMlh6?=
 =?utf-8?B?QXZsbXhFMW8rbC92MWFaSW1HV1czcE13YWl6Rmo4cXpBUHZmOTRTMTlIUTNY?=
 =?utf-8?B?TlhxekFGRlB4blBkb1dNeDBNdFQvdUxlNkpTQ0FBQ0hNNlNORnE4akJtQW1Q?=
 =?utf-8?B?R2lSckhLN1Z0TjRkdlVVSHJ4NmdFOWlncFc1UG1qci80cHNtSTBvRmZmb2xL?=
 =?utf-8?B?S1FxLzRxaklXS244Sml6c3NQbmNTb0Nhbk1UR0tUdXVEU3c5UC94Zkt0Qmtr?=
 =?utf-8?B?YllRZ3NCRVNJKy9iMndZWFVKS0huZTd0ZzhOeDRuUFpLM2dYSDlFSi80Zito?=
 =?utf-8?B?LzNmUDdRaUo5c3lZL3VzNkRFZHlVWTdHMFFmbFFYdlVwLys0TkdNVXJGeVdu?=
 =?utf-8?B?WjAzeEtuN09QdnpvamFYOURWOS82dUdSTFh4LzM2RGY5cVh2OUM2bExPbTdL?=
 =?utf-8?B?QXJyUUsvVHErb2N0RXhDVjkwN0w4YVkrS3cxREZ1d21iYXZmdVU0ZVlYZTZq?=
 =?utf-8?Q?wiDMudd3GUlcuzM5GR5DIED5D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af91d14-99c9-4c95-0838-08dce8a43c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 20:52:06.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooGTyAlQJtaAVUa6QlF8s4uNTCk38yFxl8gDgPDz8qfaX7JQxob7lIpKR7pLrOasTYaTOWMqGL12EaGe2ULFOaR51wWM0l8OSexjQ/KV73o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2l0c3plbCwgUHJ6ZW15
c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBP
Y3RvYmVyIDksIDIwMjQgMzoyMSBBTQ0KPiBUbzogS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtl
bGxlckBpbnRlbC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAu
Y29tPg0KPiBDYzogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBE
dW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQtbmV4dF0gbGliOiBwYWNraW5nOiBjYXRjaCBrdW5pdF9remFsbG9jKCkgZmFp
bHVyZSBpbiB0aGUgcGFjaygpDQo+IHRlc3QNCj4gDQo+IE9uIDEwLzQvMjQgMjE6MjAsIEtlbGxl
ciwgSmFjb2IgRSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+
DQo+ID4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA0LCAyMDI0IDQ6MDAgQU0NCj4gPj4gVG86IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA+PiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEph
a3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA+PiA8cGFiZW5p
QHJlZGhhdC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47
IEtpdHN6ZWwsDQo+ID4+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCBuZXQt
bmV4dF0gbGliOiBwYWNraW5nOiBjYXRjaCBrdW5pdF9remFsbG9jKCkgZmFpbHVyZSBpbiB0aGUg
cGFjaygpDQo+ID4+IHRlc3QNCj4gPj4NCj4gPj4ga3VuaXRfa3phbGxvYygpIG1heSBmYWlsLiBP
dGhlciBjYWxsIHNpdGVzIHZlcmlmeSB0aGF0IHRoaXMgaXMgdGhlIGNhc2UsDQo+ID4+IGVpdGhl
ciB1c2luZyBhIGRpcmVjdCBjb21wYXJpc29uIHdpdGggdGhlIE5VTEwgcG9pbnRlciwgb3IgdGhl
DQo+ID4+IEtVTklUX0FTU0VSVF9OT1RfTlVMTCgpIG9yIEtVTklUX0FTU0VSVF9OT1RfRVJSX09S
X05VTEwoKS4NCj4gPj4NCj4gPj4gUGljayBLVU5JVF9BU1NFUlRfTk9UX05VTEwoKSBhcyB0aGUg
ZXJyb3IgaGFuZGxpbmcgbWV0aG9kIHRoYXQgbWFkZSBtb3N0DQo+ID4+IHNlbnNlIHRvIG1lLiBJ
dCdzIGFuIHVubGlrZWx5IHRoaW5nIHRvIGhhcHBlbiwgYnV0IGF0IGxlYXN0IHdlIGNhbGwNCj4g
Pj4gX19rdW5pdF9hYm9ydCgpIGluc3RlYWQgb2YgZGVyZWZlcmVuY2luZyB0aGlzIE5VTEwgcG9p
bnRlci4NCj4gPj4NCj4gPj4gRml4ZXM6IGU5NTAyZWE2ZGI4YSAoImxpYjogcGFja2luZzogYWRk
IEtVbml0IHRlc3RzIGFkYXB0ZWQgZnJvbSBzZWxmdGVzdHMiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gICBsaWIvcGFja2luZ190ZXN0LmMgfCAxICsNCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2xpYi9wYWNraW5nX3Rlc3QuYyBi
L2xpYi9wYWNraW5nX3Rlc3QuYw0KPiA+PiBpbmRleCAwMTVhZDExODBkMjMuLmIzOGVhNDNjMDNm
ZCAxMDA2NDQNCj4gPj4gLS0tIGEvbGliL3BhY2tpbmdfdGVzdC5jDQo+ID4+ICsrKyBiL2xpYi9w
YWNraW5nX3Rlc3QuYw0KPiA+PiBAQCAtMzc1LDYgKzM3NSw3IEBAIHN0YXRpYyB2b2lkIHBhY2tp
bmdfdGVzdF9wYWNrKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4gPj4gICAJaW50IGVycjsNCj4gPj4N
Cj4gPj4gICAJcGJ1ZiA9IGt1bml0X2t6YWxsb2ModGVzdCwgcGFyYW1zLT5wYnVmX3NpemUsIEdG
UF9LRVJORUwpOw0KPiA+PiArCUtVTklUX0FTU0VSVF9OT1RfTlVMTCh0ZXN0LCBwYnVmKTsNCj4g
Pj4NCj4gPj4gICAJZXJyID0gcGFjayhwYnVmLCBwYXJhbXMtPnV2YWwsIHBhcmFtcy0+c3RhcnRf
Yml0LCBwYXJhbXMtPmVuZF9iaXQsDQo+ID4+ICAgCQkgICBwYXJhbXMtPnBidWZfc2l6ZSwgcGFy
YW1zLT5xdWlya3MpOw0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPg0KPiA+IE9oIGdvb2QgY2F0
Y2ghIEkgZ3Vlc3MgSSBoYWQgYXNzdW1lZCB0aGF0IGt1bml0X2t6YWxsb2Mgd291bGQgaXRzZWxm
IGRldGVjdCBhbmQNCj4gZmFpbCBpbnN0ZWFkIG9mIGNvbnRpbnVpbmcuLi4uDQo+IA0KPiB0aGF0
IHdvdWxkIGJlIGdyZWF0DQo+IA0KPiBrdW5pdF8qYWxsb2MgZ2l2ZXMga3VuaXQtbWFuYWdlZCBy
ZXNvdXJjZXMgdGhvdWdoDQoNClllcCwganVzdCBhIG1pc3VuZGVyc3RhbmRpbmcgb24gbXkgcGFy
dCDwn5iKDQo=

