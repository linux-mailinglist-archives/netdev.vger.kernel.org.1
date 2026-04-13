Return-Path: <netdev+bounces-278121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UID6L4UN3WkOZQkAu9opvQ
	(envelope-from <netdev+bounces-278121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:36:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F503EE0C5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 339383023E13
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4E3C2763;
	Mon, 13 Apr 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eObt6P/T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A91318EF4;
	Mon, 13 Apr 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094488; cv=fail; b=FEFUfhP59GNaCAAOJD09+HkID/nkaVbE6Nls4x3Yzr2pLqYvFKgGmNsGeIsR42lvvjJgEQ6y2orJff8/R/bO9kYOiwyG9HUyChh68N1U+kWip8z6+xggFKAfsvpfY6hh2z32h4/ntyq7kB0HXMtKK9ZFiInHFTu2AqtNPT5zq8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094488; c=relaxed/simple;
	bh=DT7JvKYe+IedMG65/Bi+Poj3U5fpiYE5eNP7lXcERWc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jK2XxyUwZTcu3u1CiddAwjNBzVYWoF8W8UirYIO6JXTnsfB7vF5nVeLglWKgUK+3Xix+5TpuZJYCU3CngVfpGCXcctyj7Iu6P20sl8QZ8EpLgKTHtsIiVmcoe2I0UqcJcS73faSiqOaP3vmedK54s6gq22quI2+Lxtzd6sBKk5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eObt6P/T; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776094486; x=1807630486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DT7JvKYe+IedMG65/Bi+Poj3U5fpiYE5eNP7lXcERWc=;
  b=eObt6P/Ttl9dx1+uHiKVb3dtMJSA20Rbr5HITYxq8f6HbjyHtIeFm+DR
   ysV0jwDvZ8c7+6VdF+nyTEOxZWGMr5TuxG3IGeZmHqOgdmYZ8h61e8mqC
   LjC+AkIWlYsmiRjNYq4Nzr80k9wytk/Sm4SJHLNNp1skfUdgZUTzgYssO
   w69VT9bWQWBafkd14q+3moGxrgb0Uo+IOoNqoHsnEH0IPL8JiootcvmWT
   Ti6+mM2E3xss3wYPvZkxeHWKd0IrdOuii4isYaksyAMKgXfXyFC5W2c8x
   87JO/Bp/475rzvPXREGjtfVk61ViYiIs/rEa72/Nn2yMOxSdEHjNrtPPe
   Q==;
X-CSE-ConnectionGUID: UN3dsrECTv6/BYsD0K9LCQ==
X-CSE-MsgGUID: za1avNiOSt65asLXyhhnEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76996156"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76996156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 08:34:45 -0700
X-CSE-ConnectionGUID: 40gBCAkMRHONrq3ywnSDdQ==
X-CSE-MsgGUID: YYyhbpWuROS12o2waU5igg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="223324318"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 08:34:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:34:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 08:34:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWl7acLyIT3xVo1wZ6r76Kr5zfwA5bv4Hn4sUeJWQJgsD7qYb+OM1eR4wYlhXG9yD23b2rdlIQGo/kc4Sh5P5vJq/Y6e4uZmkZz7QvC8ft14p+CRW4gD+ORS7NFRRMNxnolgPrVHjFoElIaDYe+066RE4W8X+7v4kSN88VT8vfflXRwDo/9JJFSmxeQeGnT7IA2Ykau6CUFYSVxvD5R4sxAEEqcrnqmoD/QO3tHK+NyUI+Aiaff0IH4xpX8Ti08CTCDHy/Wza8DEiIV5c5S7ED2zxPvbeNra9VlvMdo3+BirItCre9AZLScXMcYkNcZVkgyFoxrjTfgKS+kDoXyRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c9GxZj7E61YLXOBuEQg6H6ZSD9ayqqd8555+yo28vU=;
 b=bBjhMjcb2K0rbLE7By2GMq35UirqeWDFz3YmtYoBj3nQBxY/a1ySov7AJKyhUEJrwxn5XbJXlWQ3FEJENuWsDVM8zYDP9+YcvSv2IYk5EmbJwnI1gH1feQ2IAEFkjd3MtnAEnXP9B8QWpvV9PepMeBu/WylpHKhKMSKlRzqE+1esT9zZDVjBK5uRYBKRQk9eMy4+qouzA/EM0w8QMCoij+7J5HAXHWtWEna5JBl+mAadE0XZ1sxTAun2bGFVIyCLbxCb3aU/kFb8wJzCiyP7Wg0tCb/GBI65VA0g3vYBlOvnMPsUM11eCs22H6yxitTYNs/9ZOuNcoGaP4VE1JEb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 15:34:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 15:34:41 +0000
Message-ID: <4b2464ad-2c22-4c0c-a771-e35016fcf574@intel.com>
Date: Mon, 13 Apr 2026 17:32:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 1/4] octeontx2-af: npa: cn20k: Add NPA Halo
 support
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
	<gakula@marvell.com>, <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
References: <1775728404-28451-1-git-send-email-sbhatta@marvell.com>
 <1775728404-28451-2-git-send-email-sbhatta@marvell.com>
 <00fc6c1e-638a-4e80-b3c4-14e4dfa3651a@intel.com>
 <20260410093536.GA1783667@kernel-ep2>
 <1dc56269-d6d5-48da-a4c2-0686ce4fd1f6@intel.com>
 <20260410101150.GA1783722@kernel-ep2>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260410101150.GA1783722@kernel-ep2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:803:50::39) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5747e1-526f-4b77-ee8d-08de99722e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i+waExWPqrgoNw81P+h1qxrIQtB8mxy2Pir4wDg57+9U7Q9mRwYITla3Ivtd/eMHqCE97iDCa4I0LhCmY4uy3yMFzHU2MqsnpUDwdsFQ6t3xi2wqPFpIXxUsuJAK8vLx7NPnEGSmRp9hUftUhzqajDR/aHxVnY5jQmMCKHZoLjlrFfoiGvZdlYdFf7+ULD5gzWZBX6zDmLtQ6rJgcF+L2/7/f96Lgs9G/NmxeuJ51r70WPO3N2jB8dTYkVipwt/FW0tQd/Sxi1nbdf91VCeObgqYLuGv7HWObet/TRUwN+5hjNsmzhQwxJn0044zcoEVHIc8gIU5d2Mb1AR7DQ0ELVEbd1xNXE98OyJIkmLywGVVEBB1oOvI3HjdLuz4+aBz4E6CeO9jOtUdLIfHwkLWQ6mdJCYA+/DU8l2z2AJgFXaf+iqjRS9APV8U6sRP/NJTUFaedyXEeVqCXca9D0XP4S3sbcOhEInMKsQRm+zFwaCJRLkiL3JfRLW42a6ohUu9iASuM4/vIGlr6Lrdp+LNyHbWLykXYVoHAYKrxcex9JEz20Z32wN6E6d3NH5rXeKd0iuufBF5YX9knLgd5RxruQ83Al3Oq04anu8MZMu9pzdxwupJ7aId1x7zPQ2vgfQ1CLRT3we6akjAS8aCq15j3hJTG732tKM/rBFpRR+tjFEd8PhejrZA+8sBws8IuBDGygxVWyv76dfNUL/CbW7O+fnDk+lLUwoQYlOAJ2O4d+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWU2S0pJVUVsQ2FOb2ZKQjNRbDY1aVhEMXlscmNRZ1lma2U5eWk4ZWNpTndh?=
 =?utf-8?B?Skp1Z01senlLOU1nWGlXekwxSlNMZU1TMG4vYUJ6YzdiZFo4K3lVYnVrV3l0?=
 =?utf-8?B?NXRIN2ZtOTVOUkY3b3I0T09XVHl5WTRob1hZTXc3L1hCR2RNZXZJRGhRN0Vw?=
 =?utf-8?B?NlFLNG1lRzVlVVROVGVKUGxnTFl2eEh4andZODc2VURpQ2c4elFDaklxczg4?=
 =?utf-8?B?dlR3UXNZS0orNGZtdlJrK3J5NXZ0VnRGNjc0bjhRaW1NbXJ3cWdYMk9pQ1Fi?=
 =?utf-8?B?bkU1V3VwcmtjV3NZbXZKNm1TbERsZjhVRUhVSkdkd1JWRCt3czkvY2twWi92?=
 =?utf-8?B?YjdPQm9CcUQ0Ni9heWY0L2I0akFZTEZBaHV0R1Nqem1PRjNFN1BYY0xYWUtN?=
 =?utf-8?B?U1hOTXgvSWFORGkzL0grUExKaERmYnBnSGMzeXVmMW9uNXRuWEUwYllxenNl?=
 =?utf-8?B?WkFhVkhzRWlqcHBwRy9URlY4OVBUNk5ZeURyQTM2TkduRXAzTVZ0dk4yU1pM?=
 =?utf-8?B?RTVFNHZQZFRXbW1KbStmSUxWQys0Y0V1NVV2eG5mbmpVS0F5VGE1V2JXZkVr?=
 =?utf-8?B?aDR5LzJvQmQ2aHpranVJNWZqN0R4aFRsa2YxM3dVNFpOSFlIakk0YmdSUjJw?=
 =?utf-8?B?VFdrTXFOaG1rVFp6WkQ2S2VYWkF3MGhsbFpMQzlhQmo3QzgyWUpwTUZCVWJn?=
 =?utf-8?B?bmZES2l3WHE3ZFE4Y1Z1OFlKb0RLcWJtTzZ3RDFmbU9jbDVBZXRCRkxqbFFY?=
 =?utf-8?B?UmFSK1RaRCtneDZBLzRxRlFwcU8zOHp4QkVxZDZoWFlOdnlFSkJnMVpYdXRm?=
 =?utf-8?B?ZGszeS9MeTNGZ2lhOVJydkVOWlBDRkVnUWgvUGF0RmJWbmNhNFpzWTF6L1ZV?=
 =?utf-8?B?R2dvQVRZTGVEcFB3U0l1SEhLRmt1OFVEWGZFc1dFdVM2bnJUdmt2dXJBMVRo?=
 =?utf-8?B?cm00YW5qUi9rWC84dDZIUlc2NTRHWHc2QXl3K1BqcTU4Vk1abzAxTGViNjVF?=
 =?utf-8?B?YTczOENlL2YrL3pReklNSGJLMWxPb2hBeVdlSEdFY3h5UkZxdDQrcDgrZVM4?=
 =?utf-8?B?V09ZOFhyYkJXYmVVWE1vQzMrQnkvSG4vZTJCSGhweXZ0eEw2aHk5TUgrYWZE?=
 =?utf-8?B?QXFVcWNtUFdRWVRiUm1NLzVqMlBjQng4NXNPU1JRK0JyMndFSGVUM3ZEUDdU?=
 =?utf-8?B?UU1sUmVGZm1EdnFJMzB2QkRxcVlnRUtPZFIwRHMrYkNoNjNjNUt6cmZZQ3J0?=
 =?utf-8?B?dm94bTR3UlByRzJXcmtJZ0YrQWZUcnIvSTNSeFd5YmtPeEVNTXp5VnphUEFO?=
 =?utf-8?B?L2FBM3FrbVpVQ29KaUhMRkZXWm9paWx3N2xYVG9ENVgwKytYU0hWbzlMWUdZ?=
 =?utf-8?B?NHB6S2ZFdjdoeXhYaGQzT296UVhIQ1A3YUw4amNnd1lzcDZiU1JvM0RQM2ZE?=
 =?utf-8?B?cllWUzl0djQ3cU5xc0pPdEhiQklreTN3V25qWm91eEcwNlkyR3dJK1pSQWM2?=
 =?utf-8?B?RmtCdlhlM0ZqY0hmekhMWW80UVRLV0JYSlRkdjNvTFpFUGlkQVBtN1lYU01k?=
 =?utf-8?B?V2MxYTQxT2J4Mi9tcGRWYVdGZUJISWNURXhueHJ1cHhvMHN3c2pQTEJXYlZL?=
 =?utf-8?B?QzJEa0tJSzZ0cjNUb013SVFhSGtodGFES3BUQmpld1VIRENTbVlBVjdzOWRC?=
 =?utf-8?B?RnlXR095cVVHQWdKSEEwZU04UzJ0QnAwZVZnSWtxeEQ0N2NxSVFzQUtYMWNx?=
 =?utf-8?B?R0ZPL3h5TlRuSFBkYUdhMEQyaU00L1U4RE85WTNROVcvaC83OGVHMEd2VHNH?=
 =?utf-8?B?OXVXYjBUQytmYTkxRlJ5Uzl6b2ZSZFJmNDZsL1I0ZXZlUElWV0xHZTFpRmFY?=
 =?utf-8?B?cWlTTnArVm9ldEhHQkVlR3h5TUtTNjBwVEFXc2o1cGRyWUlPOU1ud21QRFFi?=
 =?utf-8?B?VjMrbExoSHRvNGUwTXdlRkRjaE1lbjdDQ2dEZlRzTWRoZGRKMDE5NnM1Y2Zp?=
 =?utf-8?B?eXB0NGM4aWEwK2lqSG5jSm5EQWNSODR2L2JnUUFuUGY3NUhYNHVmbU50dUxu?=
 =?utf-8?B?VSsrT25PWTdpSG4xU20wY3l6bXVVbEMyUTdVelVHSTZldEs2V1c5NGxibUJV?=
 =?utf-8?B?ZXp5R3Z2eTdCK0tUdUt6QUppNi9JRUYyeGk1dWVjWWQwQUpyTVFGYjVSL1p0?=
 =?utf-8?B?d015YUJuSWwyY0FCMnhYZWcvZkJzbjdxU2QrN3A0SUl0WFpRUXJrUDFXakxq?=
 =?utf-8?B?aHd0cDZjWEhGWWtXRlJxc1VPWFE4b29IVnIxWWxZL0Y1dnBBaGFJN3hRWWFP?=
 =?utf-8?B?ck9nZjZKbXJTOE5tM0RvUHFKakFZblBpSDhRNzBHZGtkdWRzZjVlNnNLc2xi?=
 =?utf-8?Q?1hA82edjg21DZrXs=3D?=
X-Exchange-RoutingPolicyChecked: Y55ICdOeu5j0T7TDrnAiDzTevT+OXqDkMcBTgnUwmd/ieuoWyHWeR7Gf8J5fCF3Bd7EqDTdW3kasaAQ3Pa+hqjHltJ15uIgZ250Ad+gUhFDgPfHzcH7HHwAovEThRq8YNWzNso2QX4c650wsLiOJK+9/5rS0tDkC73B1EOinpj/X901xhdjQAhgvxn8Zg7eQ+JrpEH6isU1gP7gWl3ZF7eeohVQTfuEMyAutPKNlMxu307/y1BzK9bACtIGtQTNaB2cvSWMik7a0Qq/5BskhNkXUORe7CIz4GAtXZKOhgQMek3x7621iKHPTzxXlu9rc3lOkZvhWSHSbAexXJtWyxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5747e1-526f-4b77-ee8d-08de99722e46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 15:34:41.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8X/INQsHYtlGg7boZpc7m0UEb/J4o9GpAg/9803Gq/huju2RYHeP2XF3GAT+nNgvXONsslg4eJ88Ja2hNrJ1ghJHhaF3ja8t+4TYJyHZ0OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-278121-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 03F503EE0C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Subbaraya Sundeep <sbhatta@marvell.com>
Date: Fri, 10 Apr 2026 15:41:50 +0530

> On 2026-04-10 at 15:06:56, Alexander Lobakin (aleksander.lobakin@intel.com) wrote:
>> From: Subbaraya Sundeep <sbhatta@marvell.com>
>> Date: Fri, 10 Apr 2026 15:05:36 +0530
>>
>>> On 2026-04-09 at 20:39:02, Alexander Lobakin (aleksander.lobakin@intel.com) wrote:
>>>> From: Subbaraya Sundeep <sbhatta@marvell.com>
>>>> Date: Thu, 9 Apr 2026 15:23:21 +0530
>>>>
>>>>> From: Linu Cherian <lcherian@marvell.com>
>>>>>
>>>>> CN20K silicon implements unified aura and pool context
>>>>> type called Halo for better resource usage. Add support to
>>>>> handle Halo context type operations.
>>>>>
>>>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>>>> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>>>> index 763f6cabd7c2..2364bafd329d 100644
>>>>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>>>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
>>>>> @@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
>>>>>  
>>>>>  static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
>>>>>  
>>>>> +struct npa_cn20k_halo_s {
>>>>> +	u64 stack_base                  : 64;
>>>>
>>>> It's redundant to add : 64 to a 64-bit field.
>>>  Agreed. But this is for readability, it helps when checking HRM. For
>>>  instance HRM says [703:640] and we define as u64 reserved_640_703 : 64;
>>>  so that we do not have to count bits in mind.
>>>> Moreover, on 32-bit systems, the compilers sometimes complain on
>>>> bitfields > 32 bits.
>>>  This driver depends on 64BIT.
>>>>
>>>>> +	u64 ena                         :  1;
>>>>> +	u64 nat_align                   :  1;
>>>>> +	u64 reserved_66_67              :  2;
>>>>> +	u64 stack_caching               :  1;
>>>>> +	u64 reserved_69_71              :  3;
>>>>> +	u64 aura_drop_ena               :  1;
>>>>> +	u64 reserved_73_79              :  7;
>>>>> +	u64 aura_drop                   :  8;
>>>>> +	u64 buf_offset                  : 12;
>>>>> +	u64 reserved_100_103            :  4;
>>>>> +	u64 buf_size                    : 12;
>>>>> +	u64 reserved_116_119            :  4;
>>>>> +	u64 ref_cnt_prof                :  3;
>>>>> +	u64 reserved_123_127            :  5;
>>>>> +	u64 stack_max_pages             : 32;
>>>>> +	u64 stack_pages                 : 32;
>>>>> +	u64 bp_0                        :  7;
>>>>> +	u64 bp_1                        :  7;
>>>>> +	u64 bp_2                        :  7;
>>>>> +	u64 bp_3                        :  7;
>>>>> +	u64 bp_4                        :  7;
>>>>> +	u64 bp_5                        :  7;
>>>>> +	u64 bp_6                        :  7;
>>>>> +	u64 bp_7                        :  7;
>>>>> +	u64 bp_ena_0                    :  1;
>>>>> +	u64 bp_ena_1                    :  1;
>>>>> +	u64 bp_ena_2                    :  1;
>>>>> +	u64 bp_ena_3                    :  1;
>>>>> +	u64 bp_ena_4                    :  1;
>>>>> +	u64 bp_ena_5                    :  1;
>>>>> +	u64 bp_ena_6                    :  1;
>>>>> +	u64 bp_ena_7                    :  1;
>>>>> +	u64 stack_offset                :  4;
>>>>> +	u64 reserved_260_263            :  4;
>>>>> +	u64 shift                       :  6;
>>>>> +	u64 reserved_270_271            :  2;
>>>>> +	u64 avg_level                   :  8;
>>>>> +	u64 avg_con                     :  9;
>>>>> +	u64 fc_ena                      :  1;
>>>>> +	u64 fc_stype                    :  2;
>>>>> +	u64 fc_hyst_bits                :  4;
>>>>> +	u64 fc_up_crossing              :  1;
>>>>> +	u64 reserved_297_299            :  3;
>>>>> +	u64 update_time                 : 16;
>>>>> +	u64 reserved_316_319            :  4;
>>>>> +	u64 fc_addr                     : 64;
>>>>> +	u64 ptr_start                   : 64;
>>>>> +	u64 ptr_end                     : 64;
>>>>> +	u64 bpid_0                      : 12;
>>>>> +	u64 reserved_524_535            : 12;
>>>>> +	u64 err_int                     :  8;
>>>>> +	u64 err_int_ena                 :  8;
>>>>> +	u64 thresh_int                  :  1;
>>>>> +	u64 thresh_int_ena              :  1;
>>>>> +	u64 thresh_up                   :  1;
>>>>> +	u64 reserved_555                :  1;
>>>>> +	u64 thresh_qint_idx             :  7;
>>>>> +	u64 reserved_563                :  1;
>>>>> +	u64 err_qint_idx                :  7;
>>>>> +	u64 reserved_571_575            :  5;
>>>>> +	u64 thresh                      : 36;
>>>>> +	u64 reserved_612_615            :  4;
>>>>> +	u64 fc_msh_dst                  : 11;
>>>>> +	u64 reserved_627_630            :  4;
>>>>> +	u64 op_dpc_ena                  :  1;
>>>>> +	u64 op_dpc_set                  :  5;
>>>>> +	u64 reserved_637_637            :  1;
>>>>> +	u64 stream_ctx                  :  1;
>>>>> +	u64 unified_ctx                 :  1;
>>>>> +	u64 reserved_640_703            : 64;
>>>>> +	u64 reserved_704_767            : 64;
>>>>> +	u64 reserved_768_831            : 64;
>>>>> +	u64 reserved_832_895            : 64;
>>>>> +	u64 reserved_896_959            : 64;
>>>>> +	u64 reserved_960_1023           : 64;
>>>>> +};
>>>>> +
>>>>> +static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);
>>>>
>>>> Now the main question:
>>>>
>>>> Is mailbox's Endianness fixed (LE/BE)? Or is it always the same as the
>>>> host's ones (I doubt so)?
>>>> If not, these need to be __le{8,16,32,64} (or __be if it's Big Endian)
>>>> and you need to handle the conversions manually.
>>>>
>>>  Yes endianness is LE and fixed. This is NOT a host side driver for an
>>>  endpoint card. This is driver for on chip PCI device of CN20K soc.
>>>  Hope I answered your question wrt host.
>>
>> But the mailbox is shared between the SoC and the host or HW or not? Is
>  In hardware it is just shared DDR region between two on chip devices and both
>  devices access shared region using their BARs. 
>> it possible that one client of the mailbox will have LE and the second
>> will have BE?
>  No not possible.

Okay, so seems like it's safe to use Endianness-agnostic types without
messing with `__le`/`__be`, thanks for explaining.

Thanks,
Olek

