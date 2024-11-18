Return-Path: <netdev+bounces-145813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4499D105C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF8CB219E5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D611990AD;
	Mon, 18 Nov 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtH13DAR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02437190470;
	Mon, 18 Nov 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931787; cv=fail; b=Zi6A497r8oZs9zb7XJyLUNu4OjRx6kfL3+M1wwOjL21woNNETAIkx6xEYMKAu8EZ2tM6glT0ljIs1hVe8Q96jelouCczGXXDHBl734OHHS//I87qvuEZIgrF4YScGqTpSW5SBtPoSVz/Fr39Tg+57WBcnMXBFj2EHCqJ7OP8RbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931787; c=relaxed/simple;
	bh=LGD5XIqdJy9lAAzPE5NUnc9qzNu4XMJnVplk6w0R/4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjUGuTY/mPiFs8sbB8MBeSJ966zGzjlruvQe7awtIUQwJ6cc0ZrDeOOKyInvCRIqwHdk7F/NJ6Gsy8fxJzZ7M9CG2MPI6SFV+0+9gWAS3niYmCi+PmbaMGrIOM4Jk+pEVVlBPbG25PLVs5NKSnHMqEN3ULOALK3ar1cWvHUhXW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtH13DAR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731931786; x=1763467786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LGD5XIqdJy9lAAzPE5NUnc9qzNu4XMJnVplk6w0R/4U=;
  b=JtH13DARfbl8eV39vgauhHvvjtFDSDwCqCHCsHFB4+U8FAi3cLuv/2VI
   CI9GqO6ZxjpMFlcmUqPWgaGHg/2hi2Vwa7mDBFfKFB4hhyTuzlXAeHL3w
   1sclgNomnMJ3n7Benbq4yqWg/2b3cfWVvKOYYoLJSCbNRzlCX+R9KJuZ+
   Ss8aTP/Xj0YhsFHqwL2cnnvaN4B82rK80pa5/arICycQfhZfmDLZ1qpUl
   kiC78T8hxMREnXvoL/OF9niB+rKLVnb9CMwihyz1c7TlpJPnkK5/Of5Lm
   gxDOv9oIpDQNpUTd7SJyzkpIaHf/TeqPOoaJ9P0bDW61fzJta5d3MgZBN
   w==;
X-CSE-ConnectionGUID: ZhA26ifoTHK4yvHXjgTwWA==
X-CSE-MsgGUID: JZAwWwc4RfShHTIT/6yYGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43281066"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="43281066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:09:45 -0800
X-CSE-ConnectionGUID: az1FSJYDT82XgFPXtStppg==
X-CSE-MsgGUID: TALkM4tzSDaq/dn5/nWPOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="94025039"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 04:09:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 04:09:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 04:09:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 04:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bncMR/3nhbwiKgd8zMw/RYHrbVpCWAUnar/DFg7vsKUHrJXIaViyOjQCFc2CE7kDh5n6GOG/K2Mf1kW9ibNzdOceWhfFJf7T51jE3UVTy6gRUXzXz/ZI9Jxz9wrexjoY9/lORE8m6v82vE9xwuTWVjXLyTCj7Tf+s1AOYuudbAjOrrY4zKciSjX8j7XpPQ+jQbHtqDf7A4UnWCdqcibN+8dHB8MD1bGXSRHa8dtYHCg2ifJfttvPpe5IYPsymSg3lfdVMzgSptEiLZmoKcje7M/NgTalaC1yF6ZhbUOsxSfO9uxGnr4Yl1/6FEGkd3FlLNNRXn1L0GGOsvWils8j9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55Fcl1256+X3cu90abkASuK+0tiKjCycLKUT6P/XK7o=;
 b=gqvkc1IMlJ90tghgT0EcwTOnYOfyX46Jdxuyny8thAtaZL5+PEPyhIzjNUqlNCICdI3Rqecy/vM5kvpBXRAQc1pmV3NEvIuwrfEXvXGRngnUK1r/Y29c14XONp9dGmpD/HP50CvqsxxiUMi0x1mNw06UYBldmBaJB5araXiK3jHT7Hmq00ncRBKjOXPQOvSUN/PzgGzLDPYekpaLxVJ37ElbOFO5KQaZMzxf8AKtPdgzn6s3w05Zg55xJtmuzesiypwkNVlXvI93oe0zbRGX8wW4ww3n7PnRVud/NJlTXgVfbkpxTjUtIITy449bkLPoKsVedReQxvRy9kn13SB9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA3PR11MB8021.namprd11.prod.outlook.com (2603:10b6:806:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 12:09:42 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 12:09:42 +0000
Date: Mon, 18 Nov 2024 13:09:37 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
Subject: Re: [PATCH net v3 2/4] rtase: Correct the speed for RTL907XD-V1
Message-ID: <ZzsugTPBgp9a70/F@localhost.localdomain>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-3-justinlai0215@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118040828.454861-3-justinlai0215@realtek.com>
X-ClientProxiedBy: DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA3PR11MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: f11b93f5-6ae3-4b80-f9bf-08dd07c9e27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RT4V9BoJHcOMMO8u3VpufIGHwDUlNvnAO3k0kXaZmsvYUUG9KmTpGDrTMzsC?=
 =?us-ascii?Q?iw4mqywZyOQiz4LdYlMLPZlgRvmnjjxaLY+ZaI086lz9y7dztjha/UkoTdc7?=
 =?us-ascii?Q?oRsszl2ImckFsW5bzkJNZKRq7p4Z48iiZ3FCxAXLcLDuWY7War7gg1L2l5iZ?=
 =?us-ascii?Q?9MPwkN/bqjtUXuyxLUrHJgOZGS/KyvLs4ihcNXNw0xhX2k0z/P88jC6I9d7g?=
 =?us-ascii?Q?G+V+roMMEF7O1AWi7+ADxRXS5BQqqD7Spj22t/zNt9SLytapvkoRq5y2Di1e?=
 =?us-ascii?Q?JSyTXrkN/4fSac6QEoNerO0opcq7HL73vlZs5RTNpnthQ8nx2DdPcPUmbA/g?=
 =?us-ascii?Q?10Tb3mb9xR8hBM/dpWt6ysKxXpda6XV4AyLnzZDoY8UYAA6F70ze2Die3tsV?=
 =?us-ascii?Q?tvMBE+jYR1Zw+DO7tLz9AP3E1Ovmwh9+ghF+03rgHi8j4pdLC2CVGxq9zPgn?=
 =?us-ascii?Q?lMtQFpyO1oLwuNawCDT2171i0Bm//Vm8qVwOTVCm422kc7gMDdaEE2jj9oR8?=
 =?us-ascii?Q?/7vkEh5VEM1yt5hqW7sLgtRws1tdXgkjsglhbov9jg/pzUOaV3mc5nhtyPkj?=
 =?us-ascii?Q?3GN2NCCtLiM2DPmDKfOInfvM/eZEYgEg2n1khVvjKE8kOdmJEVfHh2V8PQmD?=
 =?us-ascii?Q?H8hFRdV1WAHyk2eBmguBnHLHNbtiTc1wjGRcX/yhjqEvctO7ecIYfIJMc0T6?=
 =?us-ascii?Q?fGIVj63U8u4ZhYlF+tE20sC0DDOLkMPAMoeWNknBaRQueiGiY54ptn6xpWCw?=
 =?us-ascii?Q?gREFMvedQnLaobV3OPSvXNYoqXTeOpSXKMHygP7tGcuizRJNXqspeXN0D/Kv?=
 =?us-ascii?Q?XdPm2dPomDOAteD7JVH23QL2bmgD53iZYjKRw5vNJNJic0VAmHjhJ0G4HEXM?=
 =?us-ascii?Q?/eEiLnmQhCrC/BVsC/Ymctf7TDctCXaqJZkQ16gXNbjn64K1ZQe1pTKPgecq?=
 =?us-ascii?Q?wqsOLFoZQdHWj7wG3nWrpXt8cBzEot93J41SfvvEItSG6scqLdiDZx149SbO?=
 =?us-ascii?Q?ig2kQi/sSNWLAyAlvYE61Hrqh11LVdLP6ffhVIUXC4IylnDLPuSQGlzAnWAT?=
 =?us-ascii?Q?zB9/xxunCWiwIkezyOYjz5WvQ9fZ1vpdFjaJrXQCJ2XCTM5wyQ8preT3xHpD?=
 =?us-ascii?Q?Z4Qsj2UFl79pxFbLt3KNHXE36p4f85U/EnFebs2PsmnnfaSsDVZ7xMZw9qZM?=
 =?us-ascii?Q?U07VqeC1we2e+FEkXTPHU614QlR0rdRm6neISnLeWfBnI9k6doUBA82UbA1t?=
 =?us-ascii?Q?PTBpLlT9ptOIvfMcAAU+W7o1ZV4MACVFxDxWYVUoMUKm8TK/V7E/w7UC0QpR?=
 =?us-ascii?Q?O7H3y9LLv2Lpg11p8L0tL+O9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pUK+0ihvJzp35OUVogMXp1TL/JHuoQyW1X6voWi3ILCFkFG/dtca8R3delw?=
 =?us-ascii?Q?2cNVcKk7F5JqKApRF59o14Y6Yqt8whrbX5n+qWYFr0r6835K642JeHSZ26f9?=
 =?us-ascii?Q?Z6dGusyM1drSLZoPGeZ3O20zJFl4+2/p4vrH2KNSwZH2fGwpB7AZmtDdbVOy?=
 =?us-ascii?Q?HIfA1fN/IoihuMHuks0pX7jbw3EpBehenmW+A2FAyRGVxwXWCNrMJypi+8Fd?=
 =?us-ascii?Q?R5jSMy7+K4JaxKXMu+hVQTYyraCd2V2yTx9hziSlCGMz5x+fdMM4BBsZmB7B?=
 =?us-ascii?Q?6X4UxSnOOSCbYdA8k0t9CbB4pLx6qhgA5m595tdi2RrEhbcgWnop44SiY2Ep?=
 =?us-ascii?Q?UmHKPWyeD0ZpZq6mDKUZTWIGpnXweTpBm9RihfGbWrlD0+lBNBBwYYhDO8xs?=
 =?us-ascii?Q?fkEZ4266Ub8JPKks/Sg2Fn8nfFmXzhXYc5Cs/scgQmeQB0W4h7megl43WNlk?=
 =?us-ascii?Q?i+kQUjpcj34WDksqy9n+mnJBix6FtNHNgDbwY8dyJ+KGB9hlYp2nkskkmHP5?=
 =?us-ascii?Q?EwrPKHzB94uYW9NQTJDGA0ovfyOjekNZ+hn2WEWdf26uf7akZSbcZpNMSiR2?=
 =?us-ascii?Q?7d6pPtwFGtR5XRXeQFcMQBgBwg4jYsfmhxdBouaW2l/0/mwKDlfiMkoTYX+d?=
 =?us-ascii?Q?7ejDEQxDQHHjkPFd4lzecQW/r6gvgtLvkN+UB9QtVdPrzzX71ysZgJrKXZ/j?=
 =?us-ascii?Q?fs3b/hpJc0W+k76INsMncerQX4FLFSImWbfrgLSmxRInRd4ktgutbe96CQdx?=
 =?us-ascii?Q?KaNi9Vwr8xEqGiLwWbHvyK9mNo5W5BOmyEx7Xj69MsC5aPx6vZ+C+fE70OI0?=
 =?us-ascii?Q?st1A3HvHrjDdmtJZEVFWNf7CPI8Hm5043JG4hT+AWoKhRA3lmGnbkQxWheCw?=
 =?us-ascii?Q?luqMvmhGyw/HIiIGYlXUxGGyjJP+0hGfn1BFATPWFHu6J7aELL6Iq7YcfFW5?=
 =?us-ascii?Q?bs8Bg7FKAtQ1u6GmBTHH/gxzrgMHf00++RTXA5YYJLlx6XrnxhtoLIJrO8d/?=
 =?us-ascii?Q?4Yv+U3uwZwKGxlAk29oeZeRLfKf9X1W4lKzaA/djtN3DAVRUYzCd3JbHSmwL?=
 =?us-ascii?Q?Wd6wney35KbKv6440/8pFYIqBp+37xkb2R9kcHErNLoMIyF9YItjkp9tqlun?=
 =?us-ascii?Q?fmgHbaTnxzesl9UVv6shb9nxoge6CJaitjfglRAOe6OgJkWOUa1iZ/0zah0l?=
 =?us-ascii?Q?SykwI4J/wD/0aUtrwiCjJN6AYaF1zI7r6GzyAMBf1oS09LEyx2WQ05uKEdR4?=
 =?us-ascii?Q?DkHUVX0GOWfrGlvfNCKTOkyG5qyBuSvuqZ9WQROy/Nb9mmIRMPPsHrDEKsVM?=
 =?us-ascii?Q?C7Vi6+AHIkHjlnXwtuGXIrHSqW/PlCdaOqMsRPFLDM4qmNBt23R0x2zJ/etX?=
 =?us-ascii?Q?t7c0cTqCB8k0BYL4yF8wsVVynXqz72nMx1gyd979eXj436h+zJINILCMz1fe?=
 =?us-ascii?Q?N5wqdoFcKvSzxiINHXiTl+/c498jIMmSvxfMJC9cEoeIio15T3zz8al3MbCH?=
 =?us-ascii?Q?XFUaw+zA0donmuE3CKK3TYdJqwitGmmpZmctUs0gl7VEmyvpbFDMoFM3wy/y?=
 =?us-ascii?Q?lSfMo7XUQrVf74Rjqa2xDKcpm10SYM6voJhwoHaKnCc6HAXdcJply6KU/VOA?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b93f5-6ae3-4b80-f9bf-08dd07c9e27e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:09:42.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+y1rq3ZchzgqgUMvdHNoLQo2sTotFl8yEo6F0tvCEHW3RlYRVbfxlYfGwFbGVFAgqDDI/UaIXN3XvS9GslEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8021
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 12:08:26PM +0800, Justin Lai wrote:
> Correct the speed for RTL907XD-V1.
> 

Please add more details about the problem the patch is fixing.

> Fixes: dd7f17c40fd1 ("rtase: Implement ethtool function")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 0c19c5645d53..5b8012987ea6 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1714,10 +1714,21 @@ static int rtase_get_settings(struct net_device *dev,
>  			      struct ethtool_link_ksettings *cmd)
>  {
>  	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
> +	const struct rtase_private *tp = netdev_priv(dev);
>  
>  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
>  						supported);
> -	cmd->base.speed = SPEED_5000;
> +
> +	switch (tp->hw_ver) {
> +	case 0x00800000:
> +	case 0x04000000:
> +		cmd->base.speed = SPEED_5000;
> +		break;
> +	case 0x04800000:
> +		cmd->base.speed = SPEED_10000;
> +		break;
> +	}
> +

Above you are adding the code introducing some magic numbers and in your
last patch you are refactoring that newly added code.
Would it be possible to avoid those intermediate results and prepare the
final version of the fix in the series?

>  	cmd->base.duplex = DUPLEX_FULL;
>  	cmd->base.port = PORT_MII;
>  	cmd->base.autoneg = AUTONEG_DISABLE;
> -- 
> 2.34.1
> 
> 

Thanks,
Michal

