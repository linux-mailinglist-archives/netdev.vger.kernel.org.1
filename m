Return-Path: <netdev+bounces-262788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OivMYTqpWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:52:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122C1DEF8F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAEF30AD199
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811B383C87;
	Mon,  2 Mar 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9V7Fud5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167E33F8BA;
	Mon,  2 Mar 2026 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481001; cv=fail; b=M44AGywILUY5KfdKDj9KSx/Ktcl0+EOJsJYw23eKUFF2t59k75VGaiEOMNCEXeaKgVRQhSFKS8TOpuuUu4wdP+fiTyvBzwUO6VIm7mQo3FZN55QkKw5bW1ilNXa7oesNcivsEWv9O20ZKYmaLiDkZ/xxH3RTswu6DYcG3EAtsqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481001; c=relaxed/simple;
	bh=WrtosBPKm/ghQfA7G6aCQSdnb3AkBQCTN6i91BFb/9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibjbp/hTiV3BzY8SOQqql9X/3Hef6C/FxFxmFOJlCf71vv2yhW8/ynFAGtyvd07f03AdtazMOcP9WAt9DqsujQ+1gWIhOpt/h8KkK/3wSxt14ydG5S2EpJ8uL6EMMhT6BVfdHDQCoMs052hfbHrkIV790t+NbYKykd8m0KbWiCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9V7Fud5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772480981; x=1804016981;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WrtosBPKm/ghQfA7G6aCQSdnb3AkBQCTN6i91BFb/9U=;
  b=E9V7Fud5tggo4+NhZmzjCxMxiLmxKRbiCTcE24mlbob5+ch2Jg+pLlgA
   8JVGPr5TLde5pLl5EEVHMqD6GSDLq7qEZdICRCg+fZtpGXHSEfnR4KTXG
   GxQj6HGsPNeYsW5OIaBfUNNggbylq4D276BVBbT8C8sS46HjD2undCpEb
   yaUgtBce290H5xXyiBAjtWjGqxdFN35+1d7bClW3gXR0eZJlSkDsaFaH2
   jl7HATDtrq+GO+/EkYN9HRlwP28wHHfkUEi/Lok+NXCcDRd/DXqu15Ex5
   1mmJjjdBbkdBdRPJyV1dOPE+ovOW59rHFtMvUdd4WXuoOCr4SwB9hl2iF
   A==;
X-CSE-ConnectionGUID: jxbNovVsSNya9iaIhDbC7Q==
X-CSE-MsgGUID: Lzhq4Z06SsmAIsx0ZTC+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84209495"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84209495"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 11:49:39 -0800
X-CSE-ConnectionGUID: mAIXCnXrRJqf5pdnmuWWiA==
X-CSE-MsgGUID: saZgu+wgS0aQid+YN5xTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="248263379"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 11:49:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 11:49:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 11:49:39 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 11:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqCe8AJUsmOirZtLaiTWTPAJuB+YoUdDj0iRbIh0JRsIV/nRJRExSWCN2RMY4vAti5LuBvJcQi7pMsNQ5w5QC2+IYebjSxbU3zEElaAZp9qu0hikchJM/JBw1TQ+qjsHzEiS3x1ZoPxUnw6nY78abzb5J6bfy59QAo+djE0cVGV5E36rVZ4MTSL/aWAnkaL9hrcRv5ko2T8HVqKTO/XOe3McnfVxDKwcsyZj1etrBBPZGDdRTb7/ZuBvNanfnaXvxVlw1rYfzDB+UFluCCFL46IrUIxdjGpE1R5/iq9mspJ0XyRoj16+mXnt93oynkGtJ+JKVgUFBnWL8QoR6UIBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZMYvQidvZv1xe0gZfHZP1xZHPCVUGowiMlhUx6s4Ls=;
 b=iH2Odyi/PtuB2CEwrRe6VrGRgnHWcd/yQCvY60XTLC6iWEka2+UQwlZrSSqLtgGKE9ZuumAHfjwisqvLnrS53WVYSDDz4oMqkwdIBKcHwLFS2pCPYMStUsos/7HpIdc0CxqMDZ+R9glgu5mlHWQOYzv7VwITosSQ5F6Thg0TGSheNqhLelRVPMC3OdiMWToFAyBoAoxDKBGVXdrKmWlsAUUJKtzz1l72yacFVvtDlVEeEBgEXRQORuYa79Fj4kkbmIx0t0xnBiu4kyyFcXAHP7Ga58iNAqRk9GqryNtma6isftjVHvSJuz85mCNpUtdU6abIFx2Px16zqWYvUrbO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 19:49:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 19:49:33 +0000
Date: Mon, 2 Mar 2026 11:49:30 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Yury Norov <ynorov@nvidia.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, "Yury
 Norov" <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	<dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Simon Horman <horms@kernel.org>, "David
 Laight" <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 4/4] drm/xe: switch xe_pagefault_queue_init() to using
 bitmap_weighted_or()
Message-ID: <aaXpyvLfR/tJ/ud5@lstrano-desk.jf.intel.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-5-ynorov@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260302011159.61778-5-ynorov@nvidia.com>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb183ce-f2ff-4f06-6c76-08de7894d3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: MSInobddk0NpYqN7EVB/TIISGsLjvPpxZPKSALccRi8fRQmk0tcSHHGI/2KCUXfkegM6yk4LstSG20tWXjZmHTzOEpHcS7+2x0OWw7W1/qtPXBIpeQAma6fElBH78WO1q1TmyXR6MRAnKbsO4bs5BZ0fH2Kzg22Wa2epnizTpooDZ/ZKqh2jMcw2xQWOV2fQvlA+DVa6XOuD2kZsLVG+7x+GcUqLcVUB527Ngh5PgNOTGOcOKr5N3nivJhWzWGMznczE3DPHGusHRrVKDHDbTgsZqBtsAvEgn+sSAoAYSZGBfxDTzXj1XYErZUftlxJB2hzKD8eQFLeHbXaTndPEdibOAWxIsTfsfQuPU1p0kfLQ2A//Sz/wNw2ik3DUJ5yY4Knz/B8Prey7wxyH0RGRyong5tccE2Y0bR55l40WZDdWNxLXluMD3ax/RDKHHkJtmg6popW5ZRPwevvBe9Dfsl8pxv3eeJ7jFQ/NRCiEBPTpQBRxFFSf3+zXkzcNi0Vkx+rDMEbXl2J+rnyFs3FCUntAui39CjmUmyXfora4UxbuhjLjxn0ykegngl9Q5Y1Sxfe/P68Rc1yVzOanM0Cs5/PASwOYRV27m5MNwwjIenWZMdN2ACqL0fVeyeMXpnKI1WEeJoQ/f9PTafyW+0JlE1wIJEPTX+KFgwxGpdLYrw/VeKh1X/jt3cIxEEFlQkmhMwmXZXrkEzCa5o/0XCMXksweCXKUjJ7FwYWXmZHD0CY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IH7UZmyhUrfUYm82CeDo+jG4OZvYWwa6LLmQNyavUE2lXUvSIsed2sb740Cw?=
 =?us-ascii?Q?/vVvRvnac1MdFHH9/TO2IdJAth94f1XX4+HDLGyNYeD6kI+oEIyF0dI7xThY?=
 =?us-ascii?Q?aiyS/P/Hs6S/b09RqAWZaER+vCkgqZv0LQI+DCd8vRj5u9GYAA9SMitC+Q8E?=
 =?us-ascii?Q?cxmYWm5F1PRDI7t5SjyRlWSl99J4khHxb0lavy0q8amK7l8rr9WN9qJNtywD?=
 =?us-ascii?Q?MT3xCnd6wvsY04kYjYOb1mn/6qkWOqyTyOnq7gf0RytgSnJ1cv9YxY5Q+DVq?=
 =?us-ascii?Q?ES053LwO7ODwGpy+nZOVc6QAjBtYAUmHeIhI8p8U3qFhO3ON3kt5UWdqE3Jm?=
 =?us-ascii?Q?TxcB7Pint5dE1hCtde30ttXF/+gfS1raNQ2T9z1jYNsbETJ5/lkPiP3GELgf?=
 =?us-ascii?Q?rGVcqTBp+wGd5M/bdc3SvXh8Vmx5ePDgH7G8QBXFRvxZfTbov6HeOzGOLEua?=
 =?us-ascii?Q?L93TXdDGFm5YlGHPk27SgAWijt+Rfy4Uniz6mjWCVC7lmthTpvKEI6a6SuXS?=
 =?us-ascii?Q?WVm5CuLUlihbSo7O29XNFntMPph9toStpiYL3yi8SmE1hvvEsYAz3Ufw1WXL?=
 =?us-ascii?Q?qwk4UAfVLtTRKJFrbAmEWD/CrB15fCDAIamNppsobxyYzVdskOvwgn7+jH92?=
 =?us-ascii?Q?iSZtWr5A0m/onnACZk2g6CZ3KrzYH0T/IzNlxOJXhm7DHR+lQ2fPihvEfhTv?=
 =?us-ascii?Q?4gkIWbybUUHq/2xBdclcNY9qCtxF/3EfC6+qDxCr1Gcp5OPZIw9XA9Kl5cPg?=
 =?us-ascii?Q?1tfy0/ZgZLYzULq5HKbfmNt1ukH9XLqvN9nSO9YJXK9uuxvwro759PbE5HDM?=
 =?us-ascii?Q?gVZCun9FWPeXg+osS49C6SGLviEiQ8ik3m23G6FtlUuOYRsO8yJWtrDwMxy0?=
 =?us-ascii?Q?fs5p13wewvZSXv6MEOkqy2DtZU8HhSio0lMwmlDLVXEcuaVcBlinlL11OMlV?=
 =?us-ascii?Q?+hq0jZhUmfWvjWyrMvB0QGVJy5/0lxhtVSE/kLM3JTUS6Uy/PRHtils/YJ+2?=
 =?us-ascii?Q?X7h1bZRLjdvRyU3orRy/d+lpB6ReMdY1DHDpjWJetwvSgQ05653Q7U+5WKFf?=
 =?us-ascii?Q?LSI9LK9FMfEjL0P/zE+uxMTDjHfjq0xCfnz99fNsZHol7AHqbtIFDoSHDI0B?=
 =?us-ascii?Q?IIEgA6WrbR8NFpwejJVX2SkNt0Yul+UQg7CA4TsyeWwlR8ElnGu8UgVeMFB/?=
 =?us-ascii?Q?AQnHefXAyZEOtEML/vKvkydnN8aXt5wOC+XwruNFMVFHXx8TKmGWs69tm7K5?=
 =?us-ascii?Q?Zv4mtwYzMWoUBIB9fEky8p3T8EjcsZ3zBS/6Ww4msB90T6WA0uECeFDQKFhH?=
 =?us-ascii?Q?vjcRR6P2+uu84LaZbsn1wp1SnKxLGym/QX+kCM5dmfH8BNG1546r/vSBeCqM?=
 =?us-ascii?Q?+6y/D2Zfzxd2uvAniWmuh/avm3drS1Phd4d/8mdZSvUp6A09e7YuzrcnWwW5?=
 =?us-ascii?Q?wCocVSZeB2Oq7bdDMTCxfgNQPEweUpiyiqX9p1D72I2QBvUhbAfFAGzuliWn?=
 =?us-ascii?Q?XfVvieEK3LLy3sVN7E32Nr2Ty7S25cU/vJbEfUHnUArQ251dzhCYJ+sjp2yt?=
 =?us-ascii?Q?MicEzLzxH2LMWEHKIhc/C+cSg4vij3yqy8qhrAXcgA9X2H1+05dzJZy9nS6a?=
 =?us-ascii?Q?4zi3a2zAzNBp7p7P+206DMs2KlFWRI+pu7S2+6S/Hwr5BkbVBPck64rBC3HC?=
 =?us-ascii?Q?+6+9a9KDZGuQ2aitfdWPQQG8gNnc83SrJr2aDoDOR7H1ooHEBkj2KLNIf1o+?=
 =?us-ascii?Q?jaY1D23NgLmwHLuke8RaxAOJUjuy90c=3D?=
X-Exchange-RoutingPolicyChecked: Wccb4Kb46XeAXX9ESIpaW8hB8zJk0qPGBizw3KVhdr1qHMsejHE9pvpMR7QPMaVai/qSTzSjWRSH0hO+CCbzUoVpUsatBRCRD9likX33r/79vkCxFzKAQFSc9Mu3jdMRxtl/A6R+56x20gi92Ckb8TN0bypilPwz5W1voRggV4gwOqVZeAyzx3YaGPXdkc6n45ytgN0EdPUgPKHI4ZhkqFXuhJHUOVy+3uFBgXIQNJTjGKHRXxxoZ7f5a9gI4V6f5Fny1vUCLHS6nnGei0IXyEvVtW4B/BCRMt1wAAT5bGwSNlgz50Pv90/hbPuBYKFm8h5xO76padNGa/5amMJXRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb183ce-f2ff-4f06-6c76-08de7894d3bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:49:33.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMJ9dk5Y3H1uwFMp9XmeCQSWFeNmiCWohfHNUAoDrHWA0yPY08Tpe9lQUO4y/H5L5KrnB+HBxbXEMkzm9eQRxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7317
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7122C1DEF8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-262788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:?];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.997];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 08:11:58PM -0500, Yury Norov wrote:
> The function calls bitmap_or() immediately followed by bitmap_weight().
> Switch to using the dedicated bitmap_weighted_or() and save one bitmap
> traverse.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_pagefault.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 6bee53d6ffc3..c4ce3cfe2164 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -285,10 +285,9 @@ static int xe_pagefault_queue_init(struct xe_device *xe,
>  		xe_dss_mask_t all_dss;
>  		int num_dss, num_eus;
>  
> -		bitmap_or(all_dss, gt->fuse_topo.g_dss_mask,
> +		num_dss = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
>  			  gt->fuse_topo.c_dss_mask, XE_MAX_DSS_FUSE_BITS);
>  
> -		num_dss = bitmap_weight(all_dss, XE_MAX_DSS_FUSE_BITS);
>  		num_eus = bitmap_weight(gt->fuse_topo.eu_mask_per_dss,
>  					XE_MAX_EU_FUSE_BITS) * num_dss;
>  
> -- 
> 2.43.0
> 

