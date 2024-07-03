Return-Path: <netdev+bounces-108913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B91E926330
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E611C20D90
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1162178CE8;
	Wed,  3 Jul 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWvrYx3m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FEE17B50C
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016173; cv=fail; b=ATsUohT4ZppLALpopKzo/1pou2zdDNJFItQAcHIQyc1vcTWtU4mVFCtH2urP57A4ogkxtxl2ymzYmxTzctLH86BduWxcSU+xCiE2yjXABEGWyo/k3I6R0HmMZBWSDu1rGoOASarE1S9pD3pISMUsdZqldqjhQ4vL7VTdGzrG84c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016173; c=relaxed/simple;
	bh=UO3q3K5XYM9EIdSoS6xwDD0pYz8vPvc3I4N4Z8ZDoT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kfoSVENyMa25470OhZookQ1tzm63mctn6Yq+KbtmDvomm9Apl0aczt3aj95eeOO6N4m+zKEFa13fv332eDNqkZfk0zwS5BvxwT4caaRlx49arBpp5rftQv/MmYTxsASzhXtuaFHtggB5EezSjZ23KMQMyz6drYQJTgo6AxCzcBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWvrYx3m; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720016172; x=1751552172;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UO3q3K5XYM9EIdSoS6xwDD0pYz8vPvc3I4N4Z8ZDoT0=;
  b=IWvrYx3mxgm/HBkf5QBtGthUA3P+VQevdjWDTjZhqeTqAibY+JKG0iOB
   P96h0K3zQw2iKch2RHi9iw2OkoQFxn31dG0p1/IxJLrxyoSHYC93rLKKE
   CYMIMpNdFkLSY2twM0BsA7hmFpNA92tkd+trwcMpyRvrTCZTwuTNgOaVz
   gxWs+hKFZkFG0fI7tgCWwJmD3IzWDpTnu2p971fW5sVdrirac/5je/EN2
   HVl0kSBmPeHfzadMm1vmICR2qbU7QkCko4MI8isl2vAGnILy5TnSco9FD
   WuTgLm1GDy6GGImdn+m9342ImXd/7wokUspGPwkeu+JpYawSzcQARPW2s
   g==;
X-CSE-ConnectionGUID: +RFnj+DoTHGfEOfGvA1WbQ==
X-CSE-MsgGUID: 2FUCjqcLQySE1pLZKjMBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27854257"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27854257"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:16:11 -0700
X-CSE-ConnectionGUID: yGzesXClRQ2nBMQnvucswg==
X-CSE-MsgGUID: qN686XD0RByCw8WlqC0lzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46047917"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:16:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:16:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:16:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQzSlJjC2eN54ykkGRUVu0Q6Kh4CRm0PlzOIJiNeyCPzq2vCbZo6T5Rg0HZmXEUR07mvYsnFopvjK8HucKXdwcZ+t9S3RQlszPo47KWJXyeN/ABmWkFDBfEPW5bR3hGT1otpdMCTSqKYDqpM4tG7lTHx4TDjN4uiD1oGu9cVzgUJOyYJONK12teFMfKQOAJPt5LZR5Yq3t3KghQjSzptbECH0b0PFhl7kwCIBPHVhlA5y9cZ2+jWaocezHmOfOHQrr8RQ9ftRM9+3ozioa2ZyqRwDKXGKKUSIRgWA/JPl102TjQ68bhzI3yiQIGYVzt6g+b5OTcGX/lFZFBz2TzG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zflLORJ46LpCCetzeawzHuN0VjN9raSi5nfhIrmktwU=;
 b=hr7VmioUFHjGFXVOstYvdxlteETbQPXZfh/Df701emXzhAYpmJYpnOzXOEg0KU55MYr8vIP7UL8FwyGDB5g2Zxc4lHbOQCXTt9ZLz3XG0MKZbMgp4cCqwqg4bQPn87n+9RcpV2kaWtSzN/Ocs0/Yd6+DRrpB3f24AicKvmUdRdmEr753JUEIhD8ifR8tMXej8L86awZW8VtAspj2C/6QiFiXhMoKKMX8bsy0Rw8q50G/tbJnr7InjdJyla2/SqPLwdWjCCiPhT/kcRZ+S5ZjVZO+Tp2PIFyMOY0WhG7R4tt8s8+6JL012XmJRcaJbDNk0BW+Hz1K7Udpf4LH6UX5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 14:16:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:16:07 +0000
Date: Wed, 3 Jul 2024 16:16:01 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Milena Olech <milena.olech@intel.com>,
	<richardcochran@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, "Karol
 Kolacinski" <karol.kolacinski@intel.com>, Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net v2 1/4] ice: Fix improper extts handling
Message-ID: <ZoVdIbQx6OxkrERu@boxer>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
 <20240702171459.2606611-2-anthony.l.nguyen@intel.com>
 <ZoU8cSUjkEN5w7Y4@boxer>
 <ae4c8079-6839-4865-b02e-445607fb2da1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae4c8079-6839-4865-b02e-445607fb2da1@intel.com>
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: b57cda2c-c027-4890-cb04-08dc9b6aae88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cf8gqb9pB2J9IY7TKC5PVePE6uo6qYQtEtJw8AXs+P7ktxsU25qOd/kNSxZ7?=
 =?us-ascii?Q?S4WZiYTRlXVHEdTF2hFmWVO5zVwBO4MrX7kuOWy9m/n1epQWREQocjNwHgzv?=
 =?us-ascii?Q?VZmHmbbe3B5uc6eiTfgn1NG2W77GCdTSRUDjhxLLeXMjzZVpQXixqslyOALs?=
 =?us-ascii?Q?iH0hOBZpAsd48wWXqH6+8BqFA99M2N0z7X578kv6CtXE+YObLHarcARavCS2?=
 =?us-ascii?Q?ZgjfJu4hIGUidrUhtZ2e1pelXRo2SIpCzN1toUuarWoKBzwrhM6e7k2mMCdW?=
 =?us-ascii?Q?9lCK+Txoe4+yTV+xsDvxv5cgsI743PfD2MTvvYAFSvnhQSfaT37N4Dq7nNoS?=
 =?us-ascii?Q?7tbScuHDikBhp92bpV7IeCjmYkd1e4T3x4gXixZQtKy7hlGYD7tY3zLb7ihL?=
 =?us-ascii?Q?b/76h6EzPWwQSXW17vF0KFQ//j5lsFu0TKQASlrHTsJXo5d+2kAU1h1AaufE?=
 =?us-ascii?Q?tXav/0qidc0nCG6lTis67amWwdC0Hisr7htsCHbeGtKnVkGmbii8ljGwVEdo?=
 =?us-ascii?Q?Ge4dwTBW8XzIlbHEvMIrUDIf7DKcMjOdhKpC24G8KvenJRgiSP19tMdO94/y?=
 =?us-ascii?Q?ECtQG3PftEMRv/PA3woy7ifArtlrcsYi8AK21H+8vUnBx70b3NKpRVu+eaW3?=
 =?us-ascii?Q?nJiqO/4IviEd5PwwD1aTZ8SApJGQokOV8H9DgJmk5/WKSs4vJzvAwFT1QSXy?=
 =?us-ascii?Q?NrACgEmVy58C2GiO5pvJq9JM2jb06cl/qNWckZYv8yYxpTCKNwm2c3KXaGlA?=
 =?us-ascii?Q?GcwFFIGG8pRSzGUFHtzO+wu28oqfNGI4F5lKJ8EUGLZxq1wHGDy1EG+AOTJ6?=
 =?us-ascii?Q?09PKONEaOfs2Wg9ratYjN+Jn8X50UliPEt6vNn+3M5KP9QFGPX1yf4U4B0oR?=
 =?us-ascii?Q?JYpIwbgUOpxl3FBAxwekPv3rGKgAlOc/jKIcCVgxy51bj6CN3rA3sSSwrliW?=
 =?us-ascii?Q?Rc63FDxO6MTQsxeqJfsCIqYMtHDQaV8EWx6xUoHIND5AIkssHOKshNg/Ah/R?=
 =?us-ascii?Q?EVoUNMS5xyy9c8pB5W1d8fuxjKNwfzM4X7Vz0gkNXWi9PIrNW8Aceko0mRtz?=
 =?us-ascii?Q?6pHjSCHRlmDRLIbo8ukczDt+tNsKnSkXY6a2ATNGs6oXDLVPmuwVFH+nOvYD?=
 =?us-ascii?Q?Ei60UZiMC1eOtuHHAr3Ps8V/zhYqwRrRzkpY1dFHPiIX3RbdRC14T2O++RGj?=
 =?us-ascii?Q?uHMldaPYfMIqSnvFsLCcAJR9fp8F6doZZluKcTVBblhzxyxmqiWuCPY2aqvo?=
 =?us-ascii?Q?JmtKDYvOqBghImVPrY43P5fm+/lmSsmsYGzn3VO+2z343dRuSJKkB5PtRFT8?=
 =?us-ascii?Q?13k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPbsIy1XgprnrApAlB8BTfcTGF5i2PV9FORNhSmV4IMmnn0QzfrdX57D/ukc?=
 =?us-ascii?Q?37d/DVen6clp6xbEDn6M+jNCQK34/KDPwpXcK/uqYo3q5MAD5UDGentBaFzk?=
 =?us-ascii?Q?nFlrwpm+V8ws0UtoDkZhqHEBJ9UzWbzthn3JeAWCLlgDECFZCO2O5sDTcDzH?=
 =?us-ascii?Q?Y6TCVanBjGNU0Mt24wmLx+cuzUOdmFitOT1KFd+cfRNzT5heV+zO5125LPvr?=
 =?us-ascii?Q?CGSYHfrBzJQLd4CxnjOEfAvIRxRkWk8u2Qkk+FNsSWb0EAZ+6h1XChm2AqtY?=
 =?us-ascii?Q?NDewxZGW2Cc6Ni1v31pe9GQ335681hbvUgSmF7YwDtkwCkANkjy3I8g/1+mC?=
 =?us-ascii?Q?rckW451kRkteCrC69iwu2sltp5e371jo0+jgMUwE767tbZ5inBKN4/9zuvUJ?=
 =?us-ascii?Q?pwSE2mDoFLlNwskIZdsB9Jwk/joSMVmhUMT39vjbeLg10rZ7NS3PlpWfpraP?=
 =?us-ascii?Q?x+Wx8gXEZU32oe8z4UWInatYIdWF4hbbm6lHAPIKekdVGZNj906NY7LIsy7s?=
 =?us-ascii?Q?1oHrH/DVFUSVl7a1842GOzMYbIP9+TFxNAQWj9e4zq+5+97mMeT3Ipo+HKZ0?=
 =?us-ascii?Q?FoiCxtVWwIYdSQvBRiCR6Yj+aFaSNbTjmVRAAMaWNKM4dHnOre1vd0frZeNH?=
 =?us-ascii?Q?gsoHIzIuRKAF58K3LHcITWuEPl54OnCZ8EytxlUMqTSiqxWuoAv5uQk2SOpz?=
 =?us-ascii?Q?/dGaKA3TXot9vnj4vqXXC0EDrxzBF3yqDMkzbRlXOzLXcSWzl8898HDn9+r6?=
 =?us-ascii?Q?XBtNgYwtHAumGAy4fLCphB4qIYBI4gmfevg+3jz5uWCPYUQGJd1McBGviTx5?=
 =?us-ascii?Q?DZFDoZFcK++qAyooc9zMnXGm4rxLBmTeHoiIuzuP1SiiAzQD/VO1N+Ndqi2u?=
 =?us-ascii?Q?sFc07MzRGZfHmAKYtEEtRXLoAIPIFZI7iSqEeWj8W+muSGpbh8DuulHNSAQ4?=
 =?us-ascii?Q?h87x+eMsh2ivYw11j8qRR2FiZ7v5HshvcfEVLbwdnb/Wtour98K5sNLsbqfX?=
 =?us-ascii?Q?p8sQWp1Sjcl226Odyq24YyDijpfz6eA04tgUoepWXJQF8YBzlZ5GRgfVJWuX?=
 =?us-ascii?Q?cV/8GoWfLF1O5kSMxjVLePnveCQMrKTPbUaMNtnWXWsEbHKP9ULImMlOunes?=
 =?us-ascii?Q?Xn+l3kZuRnSqLUY/w6KYho6WCQ0W0Vt+pYbMf60eTuBYB11p97w9V4ww5MAc?=
 =?us-ascii?Q?fxQW2ggvpFsX+9Fiw3M66aMF8gTz6J3GVL4sqmkLU6UKXBagsKLMnxDulgmv?=
 =?us-ascii?Q?l9Kos3NGRcL1wlXnfniEgPmh5ozSIe5iGEzu29olXGLc0Aqni0KPjL+m6lhm?=
 =?us-ascii?Q?OEliuROGStb/h75ZwCVM+BtVx7k9YKoPb5c7LZqZvPDPRapI8CpsTna54rRf?=
 =?us-ascii?Q?CQ0oJXJxz9+asVnJcnDoKK6z2VnSJQz0rzUplee7YJG3OHdx6fNZwUzfLxQp?=
 =?us-ascii?Q?0W0b2Lndj3Pgd7+H2ZXS5uNEaJaouD4rhU2KlL72Qq1TRd27Rl9Vm0P9RNnV?=
 =?us-ascii?Q?j6hYFirN4mmbOvBMbo1a1RfjmGfj2yebyhZCnt31JNCf84bc6PLTX6Y1yZiv?=
 =?us-ascii?Q?ZH73e9u/iPUqCmj/4vRVJuY5Oj0XFI74SOIDL2kTtVBUy4TtgddxYbjP/uo8?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57cda2c-c027-4890-cb04-08dc9b6aae88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:16:07.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLRjtUn/wesLst6RvbKPDXm/TXSei5z2FkAf2kCg4COd3kx7WLPLhblzwjaBrXOrykBSb/BxcnWDbLb7qYhIbTo6INkaMPlYxEwxOja43Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:59:27PM +0200, Przemek Kitszel wrote:
> On 7/3/24 13:56, Maciej Fijalkowski wrote:
> > On Tue, Jul 02, 2024 at 10:14:54AM -0700, Tony Nguyen wrote:
> > > From: Milena Olech <milena.olech@intel.com>
> > > 
> > > Extts events are disabled and enabled by the application ts2phc.
> > > However, in case where the driver is removed when the application is
> > > running, a specific extts event remains enabled and can cause a kernel
> > > crash.
> > > As a side effect, when the driver is reloaded and application is started
> > > again, remaining extts event for the channel from a previous run will
> > > keep firing and the message "extts on unexpected channel" might be
> > > printed to the user.
> > > 
> > > To avoid that, extts events shall be disabled when PTP is released.
> > > 
> > > Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Milena Olech <milena.olech@intel.com>
> > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> 
> > > +static void ice_ptp_enable_all_extts(struct ice_pf *pf)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> > > +		if (pf->ptp.extts_channels[i].ena)
> > > +			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> > > +					  false);
> > > +	}
> > 
> > Still one redundant pair of braces. Just do:
> 
> "Also, use braces when a loop contains more than a single simple statement"
> https://docs.kernel.org/process/coding-style.html
> 
> I even suggested adding that pair only to prevent such request later :D

Thanks, i wasn't aware of that TBH and was following the pattern I
suggested. Checkpatch never yelled at me for that:)

> 
> > 
> > 	for (i = 0; i < pf->ptp.info.n_ext_ts; i++)
> > 		if (pf->ptp.extts_channels[i].ena)
> > 			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> > 					  false);
> > 
> > >   }
> 

