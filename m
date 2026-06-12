Return-Path: <netdev+bounces-298562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0zHOHcnTK2pqFwQAu9opvQ
	(envelope-from <netdev+bounces-298562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:39:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE74678618
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:39:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kENylemi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298562-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C58E531896FD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348803A4F51;
	Fri, 12 Jun 2026 09:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A563A8737;
	Fri, 12 Jun 2026 09:36:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256970; cv=fail; b=nhz8GIz1AXqcSdMtOtQ7nw4x6lOaFUvx+kpODvP9lKAXsdKq3uJUrjMteMSaEKNqCyuyF8AmKOYJpdqeXmNCH7pZbinKn4Wgrf8HfdKxMru2ZPmfQ3IHb1aUPgVj2Pm811Uv5OUQNUahqLuc+EloAMF7IGQWg5tD9yNwqBqNnQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256970; c=relaxed/simple;
	bh=3V40ZRiv2XG3/qm5/usdDYIFqEoi7rF5iUFRrgtMAHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJ+NTr9U/CujIqXqLTWDPqmsZMyVbJTC5IcZTiMiMRDm9J/+SagzJ0DqIYeUBf3SMeKb9oGz9OKY417gMTt6re4ygEitw8sATtJRbm7yMnJyEVkgEi+LWOJl7hFVrsDjBh9k1xIkLHf7fnM4x0Qv5w/+jml0VQr3g9tl2crmwvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kENylemi; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781256966; x=1812792966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3V40ZRiv2XG3/qm5/usdDYIFqEoi7rF5iUFRrgtMAHo=;
  b=kENylemi5ydCzBjrwPN4biDPEq1DMT7G7K6p7gCwwW2Mo557v4264P4r
   lN7IojhjnUUB7HilCn2Tw0RCJuVnnJ5z2drzyA8j7v3vwVdJvGEwGYi4L
   PncmDogkwRMuLamX3hHDqMr1KPq3FHaLOXGqrG2lAgWJWNgrJI+xCC1jn
   CRUVX2nikfYYXh1VkLsm0wBlW/lllJFIx5shnqUDD8xgIK+VCp/yRJbXT
   ttPHyL4ejD6AXxPfRwizP7FgHJRx48NPo/WNqIWOSydKYKeRIQCYnrN/7
   pA+cWQG2dWDNNKkc1NGO2adiZjZOSC6eEhRSngaVOaHqineUm5uwqqMIN
   Q==;
X-CSE-ConnectionGUID: VqSyyv2qTl6WkT/IfHDH+w==
X-CSE-MsgGUID: NIzVtHFeTFiV8nHQO+Omjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81220224"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81220224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:36:05 -0700
X-CSE-ConnectionGUID: HImQlMpEQfuvaCvr0ioFYA==
X-CSE-MsgGUID: K/aGdwAMQ3W5jXO6VrYIoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270817207"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:36:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:36:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 02:36:04 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inNxw/C6z5FBN4I4Zbrtdss6ScAFQHBXntlBeDKe9LdXEhJvmB3c9oQvHoCNEBleSY8+f9XPjlWPNyNg50dTgQVUorHJ4JNWEils1H2r4A9fXrjvOu+A6DJ0ukhmuY8ihx6Y/tSjfs+V89GbDk+9Dhc4wieO4amaLsT9BjXf9LRsyOkEIiYsTjcPS+6nTuz3xR+rpeqcKQ9KHV1Pmene0THXL7PIJ1N97Bcv3J1eJ0R7bJvKg1oxNS+LbpsL3FSTSBleYhdgGW3IjQEQjv/j063HEwmQ6PQu3+zdHu0U2y6opeWUs6HS9nI8yZFLK3bJdFLhtlX6h7WEvjWb6a8L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pJZJ6gHRnVC36cDeFPgzlE3HzfznnV/LX7lqDLnMJ4=;
 b=c9GENkLEpN/ObhA6JuyYOh6jmI4au28npwl6WYolbWf18oHsc73Oy966YhcijQgbnkHN0Q6gjrD7gLMAXT4r3hNgIpKQzBS4t2niC5vrr/wKyRRtX5dLRZZDfVRewNXxdcNh8NEHDL9lpBWdsNsw/E44mLETTaJEV7Nkpy92dvGRUV7KLk2q7bu+dLzVl8jK37155edtEkl5Pu2agrfK1udCxfcWH29lo9mWkJzgIzVvur3pD+6bRZyFAZYZaCaZApVN8rComv1tk8RtqrELEnJvd39b7ODfT1Bi2z15/z3fK42qgYxyIyVPK5r/rG58gJWnWpeFF7kUgJzTYvVAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:36:01 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:36:00 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3] ixgbe: implement get_queue_stats_rx
Thread-Topic: [PATCH net-next v3] ixgbe: implement get_queue_stats_rx
Thread-Index: AQHc+khJlt/YYiz+h0SmK6fFltk72rY6pvBA
Date: Fri, 12 Jun 2026 09:36:00 +0000
Message-ID: <PH0PR11MB5902953FA358A3D7FBFABE09F0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612084605.19785-1-kshitiz.bartariya@zohomail.in>
In-Reply-To: <20260612084605.19785-1-kshitiz.bartariya@zohomail.in>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SA2PR11MB5194:EE_
x-ms-office365-filtering-correlation-id: 2efc60c1-3daf-4279-3e4e-08dec86603cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|921020|11063799006|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4GKFYRjRWJVMUmt0Lv6K0tRfsuAGEv/suFwmmXdfKPuvmhs1+pbpy9Hq3DwRc2F7sfm9KWYoDI/jPllyby5CzyDkbhry5DzEBY7qL2VmIXPW68CR6sNFqoys4otwAwd1Tqz/QvWzVdjtxt652x6fMgXRz11qQCpCUb2rl98vIDgrQdHMjjVVTSLiseJYYM8Sz+NLV++R6YblYpE1YC3humilvJ1uiBdvaCTNyznLkGzCPNYhJxtgGlXqcuS7Xa8i+uLTTATcwVItdPfo/pSVGOnHqDBsBWX8kyjidB/T0r5vIFNqu0qIPt4eAWhmU33iYLG6fa6QwSJOlF8RWhlKSgo78Ukjs5S7STAAEXp1evbOMJt8OvypOcOCQ1XqYQhDHAQeKwoIrLIK//+79nqu1Bs/k/qOZPYnICbRRFZLxbLGsg6INU2kcGoKL75b6CVTlILeb4v4DlbCjcgiBndg075hVo0DjQazbAjnCR3vlQlZPAKhq0jD/uXzvhpQTsledGuv04Qk9wuVvEFzWICJ1K7k+cy+pzLlITFE53ebh4b2B8wuxYuCA0eO0hXjp5lN6C5RCE62NBOk3YURJAIBTtw7q/Gl8SIQXWjvesVGC1ssEwjTqtjFTePZKgGE3yUoOAfx3aP9eY2quixqitN08HvquYlJ0FNb8vPm8b9fcnbVzlJrgcVZc8zf9iXAZ4o0qzje4L8r2QwAt4mJX/ChBYhbwNBWCSxnNl11ScfYtkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMGmm2qosAJI1t6LeczJerk6dA8h1AsBL+MrFWlP1SqCEaScslGTdxB5jq1X?=
 =?us-ascii?Q?6VJWYr5B4T6B/XpGfCdAacQtK/0MYcolXeHYRNxRucxqY1Isu7XpIpD+VK2D?=
 =?us-ascii?Q?0dQ9SM6gXFOuZvzstj3AISqReNDdEGNkuKYIz0agLvE5WRMCL0mMHoEzZwMz?=
 =?us-ascii?Q?jtNBDtF/U+q4M2qqwELb0Q6eK52Epls0FV/oh7zlBgfoUwL5ZnYkU5IfK6pD?=
 =?us-ascii?Q?/eu+er+vRPunfkbzIjxY6GMV+j86nAtfR/k97cY0gpprcAT2a9tVD9awEJHy?=
 =?us-ascii?Q?m49AkkBT5Rb5xYqeA0uE9WvwvQ+BC5tHp9jUNyV8RSWnchkI5N6GOdLIOvjO?=
 =?us-ascii?Q?wipybqxFz+jvNznT8JAYK1KFV+L8kJMLcGSaNJp4okfCK3hVDdqQo3ghcc4p?=
 =?us-ascii?Q?SCSOmlwxoL9ZvgPqrHMuM2vYOpGCS9/rPsucclqYDfUX6tF9viiS+ImV0gIC?=
 =?us-ascii?Q?FWJcJMbX1AdAlkvmAnWX4qEYQYFHVlg9HBhRjgYN3g1K47KUiiF4cfXA3zkT?=
 =?us-ascii?Q?R6GEx11cFPiaHThU09/KNNPnYh+JC7pEL1Nhp01zCuNNKEZUwh7IIn70t+OU?=
 =?us-ascii?Q?8veYHqUHuG3PiZ1XbhkAlZke63F3rN++QkGN3onVvS81GRUumpjFhjUmWaIE?=
 =?us-ascii?Q?ZjOLygbQjxnoGuscYfjddu8ip5QKQ60E5lihV0XJs3E05SRLXe+4tBmJwwCP?=
 =?us-ascii?Q?pLBgjT6dYDDo50TWI6pBd82oJRTiFuDgK16NTpWouP+bkB4JUK2sIXlmTE4Y?=
 =?us-ascii?Q?ScfX8xnIs4UM4WBvX0v436jIX62TXs+6YpNvbp27MMoc8m6r8/GjhFRKJ1g9?=
 =?us-ascii?Q?E22VoRmsdlsHvAMndQCdEMvFKImpbpPXz78VU8coBb+dbpEyF2x62DChsAAt?=
 =?us-ascii?Q?GZagcjWg65tk8F6u6IsZDwHO594KjoR74eVH4mwBgThXRp03D7zDjrbcLgvF?=
 =?us-ascii?Q?2cAB+jA39KQOC8PjsoTdsG+yRgx/ah/LrMXTMuUvbZ0aEXYjnPcuAZhE4Vdj?=
 =?us-ascii?Q?dewb4MpyFxs+RtHcnoqjlO+FYbsXLKZB2ycxLU4qMh4Iy2qr3O4Nl3jC25tz?=
 =?us-ascii?Q?1xjCDNGXSeYCgOPq1jnC8wCwdqB9J703JLrV2AMrSXoBVz9V79xaCvTmSiCj?=
 =?us-ascii?Q?06VgL0RZfj28QwV8VVyc1HtEkUx1MdHDe/DOMd6tj9e+MfWp+n2SwqAeA6Cc?=
 =?us-ascii?Q?DJluUemVmznvYLjU7b8bmNyqFDUefzDkQxF5Z4YrYi29MAMgj0GwsOy19PBy?=
 =?us-ascii?Q?jZrFzevT824c+2/SP3u2RjEkNhZUGy/Q8CCZ4Qxn61MKgHf9hfub0MbOpCV5?=
 =?us-ascii?Q?h/AeOMDVYt3bAN79SE48G1L375pp7Z6oOHsKZ0l8F911bK4ABET9ZULTmK1c?=
 =?us-ascii?Q?DMShup80M3OvoG07chb7IL9moLUmq7sFgFH3Rb/vB4Eh7faf3/6MtSVpgQKe?=
 =?us-ascii?Q?61jVOiELnStnrW8HojWgZ85Cw6py29uW9NkwxN327XU16ANUxNW0sEgWEck0?=
 =?us-ascii?Q?X3KA8hQUrSApYmvqPkmLqfRkHiimdeG2JYdeoQeKEjJuvFAlcw7YiB2ZZVMl?=
 =?us-ascii?Q?Y+s7wISQAOIGBLgBdymncA6Nb+sJGmCbI0qSpFNQlBgYtG7DDdp8O6+hOoM7?=
 =?us-ascii?Q?mVXbfpqaZDjhAFS7Qk9e4EX2UrbnH54hz40DfgGYJJyfHWyuxJgRxkV+SK6q?=
 =?us-ascii?Q?cwgfw8Dny9KX8PunkJc9hCJ57+itGYxd5tWfHS0b+sKs9be2ne+ooKlWX6Yu?=
 =?us-ascii?Q?EoeQbURESw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l8sCfiXPijB8JFS2iVOky/5zjphEQWvy708d6Zo6BKlxkffKhTBCpTSoZxDp7LiQuqwUj/IZHULPntOp+bUWNivZUxLXX1D/Ih3NoWyG53FFrjjfYN+g2qyGeXTc5cAjBws2z3DuYfrEYWoqWTaiLll/K+ctNS4OFit5BdRYFcpCCUH024YDU/GRFyaf0IrMZTU9XGnaCtcdnvNvnwaTbXjFqpiehUGGIDnslghs/JY4ytyckqDZjMHgADYHWZO5Sn8tf+emMqOLcHq8x4IbeEHigQzNzRDfH/hSpD/nuBl2aeUUPNuHKd8IGr74yAyBQvozKyki8TgC9lgExHlA0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efc60c1-3daf-4279-3e4e-08dec86603cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 09:36:00.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdcP+UildywcDmMXQatJMQvLVJbkfaWKlAH6KL8euJfJrBfPONNqmklRbfO1W/W6ZUwJ7VpLftKxjdLXMoQg/522POPmMCxzNvY2Ic4KMs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298562-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kshitiz.bartariya@zohomail.in,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zohomail.in:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid,linux.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCE74678618

From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>=20
Sent: Friday, June 12, 2026 10:46 AM

>Hook into the netdev_stat_ops interface to expose per RX queue
>statistics through the netdev generic netlink API.
>
>The following counters are filled:
> - bytes: maps directly to bytes
> - packets: maps directly to packets
> - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
> - csum_bad: maps directly to csum_err, which is incremented for both
>   IP header and L4 checksum errors in ixgbe_rx_checksum().
>
>The new per-queue stats can be observed with:
>  $ ynltool qstats show scope queue
>
>Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
>---
>v3:
> - Added bytes and packets stats counters
> - Implemented ixgbe_get_base_stats function
> As suggested by AI on=20
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603174857.78666-=
1-kshitiz.bartariya%40zohomail.in
>
>v2:
> Amended commit message with command to get RX queue stats as=20
> suggested by Jedrzej Jagielski.
> https://lore.kernel.org/lkml/20260603174857.78666-1-kshitiz.bartariya@zoh=
omail.in/
>
>v1:=20
> https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zoh=
omail.in/
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 30 +++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_main.c
>index bc16e4c93fd4..fb15b70e91d9 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -9759,6 +9759,35 @@ static void ixgbe_get_stats64(struct net_device *ne=
tdev,
> 	stats->rx_missed_errors	=3D netdev->stats.rx_missed_errors;
> }
>=20
>+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
>+				     struct netdev_queue_stats_rx *stats)
>+{
>+	struct ixgbe_adapter *adapter =3D ixgbe_from_netdev(dev);
>+	struct ixgbe_ring *ring =3D adapter->rx_ring[idx];
>+
>+	stats->bytes =3D ring->stats.bytes;
>+	stats->packets =3D ring->stats.packets;
>+	stats->alloc_fail =3D ring->rx_stats.alloc_rx_page_failed +
>+			    ring->rx_stats.alloc_rx_buff_failed;
>+	stats->csum_bad =3D ring->rx_stats.csum_err;
>+}
>+
>+static void ixgbe_get_base_stats(struct net_device *dev,
>+				 struct netdev_queue_stats_rx *rx,
>+				 struct netdev_queue_stats_tx *tx)
>+{
>+	// ixgbe has no inactive queues

Hi Kshitiz

that's not the way we are putting comments in the netdev
code - please use /* ... */ even for oneliners

>+	rx->bytes =3D 0;
>+	rx->packets =3D 0;
>+	rx->alloc_fail =3D 0;
>+	rx->csum_bad =3D 0;
>+}
>+
>+static const struct netdev_stat_ops ixgbe_stat_ops =3D {
>+	.get_queue_stats_rx =3D ixgbe_get_queue_stats_rx,
>+	.get_base_stats =3D ixgbe_get_base_stats,
>+};

please put ixgbe_stat_ops declaration next to the ixgbe_netdev_ops

when both notes applied feel free to add by RB tag

Thanks!

>+
> static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
> 				  struct ifla_vf_stats *vf_stats)
> {
>@@ -11662,6 +11691,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
> 	hw->phy.mdio.mdio_write =3D ixgbe_mdio_write;
>=20
> 	netdev->netdev_ops =3D &ixgbe_netdev_ops;
>+	netdev->stat_ops   =3D &ixgbe_stat_ops;
> 	ixgbe_set_ethtool_ops(netdev);
> 	netdev->watchdog_timeo =3D 5 * HZ;
> 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>--=20
>2.50.1 (Apple Git-155)



