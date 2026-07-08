Return-Path: <netdev+bounces-305929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXQnMEeHTmqqOgIAu9opvQ
	(envelope-from <netdev+bounces-305929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:22:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307B729232
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:22:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="CBSVmN/X";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305929-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305929-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9307300C02B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595AF3F12C8;
	Wed,  8 Jul 2026 17:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992C383C95
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:22:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531333; cv=fail; b=jvgV5hRj9WmVzJ3PNhwuDOa7ZIAM5/acuwbtOZePY6NtbNcYQ0QareuixmnH7HDRkcqktnwC3i9mXmFMg5AiHsW5HfxNUpJ8nKOKWbr7RCoZK3irfmg8j5t6rcnjCMy1fu9RHST8OvLDIjlK3t8WCCQXsA9zFuko3l3kh5crnnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531333; c=relaxed/simple;
	bh=jfjx59+UbOiO7W/ePN2Ds9XAmUX/4Je++PwNW6tkSTk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4ZXogpiRrzU7Nq7d74BpBcrd/2vnq2j4xK5wBWwq357wTDDuaaUvc4wUqd0BGHlZBHB/NsmIVeqwFvwNS5SGHY3klpXdBm93YTw2LOyDiX+JMNSx1p8XqeUq8ARQmoSE2xOHgMUg/mekklnVXbnBTUCqtt38x46uWefITmx0kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBSVmN/X; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783531331; x=1815067331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jfjx59+UbOiO7W/ePN2Ds9XAmUX/4Je++PwNW6tkSTk=;
  b=CBSVmN/X6oZtssSU5cjgEoQVMHEJKlszBXXmxHdDvRY3KT3ZzlIgOsiA
   A5yUaDIDw1TARoHe/QpkS+gk915zSaEOXJYQuynmfdc4sn4pqgGbQhHLx
   /Y7yuxb6rAJIVyN1eqQfHEaYDhUSDJKsb2Nso0GkXQ87fRvcf7nb3D/63
   Yg9vCOnVgOfPaNAKS8/SSlrnsiVXhBusCzZ64qUv4JCKGOyEQG/UHD5sr
   v8VX2W3oEyk0lvQ8GLxLUJc9ubD7dBNpEoYaoCpZHf8vBaXuAiAoBlxr/
   CDy/Hk1Ir6cUtHGjtm03Gmz/zuXMymUpW1JXbu7va0bWqV3n1rKqaqTi4
   A==;
X-CSE-ConnectionGUID: nlttyBIRS76vD30JnqEuPw==
X-CSE-MsgGUID: ZCx6IktrS2Wv3O3TJAUHTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71723361"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="71723361"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:22:11 -0700
X-CSE-ConnectionGUID: e8wAEY8pRKGZwAsFyOftPw==
X-CSE-MsgGUID: xl2rVXqnRRWIm/Dzfrraag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="259249030"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:22:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 10:22:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 10:22:10 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 10:22:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAKdEMGnYxs0JbV8gjmpzO0v/9aXCNt3lqEvUdusSgoasEjfwszXChCZmmbjjAV/GsOc1GCEEz2QbIXhRIr3QYTgEqkjiHmhqBzqXFsatQSW+WTjY0CooI1Rr+EH055KEHHy3cIpMudNITgr6Eji8gB1EiW/WzgoxFlnOWAuibQREnl7psiTRPN56y0LYVkeWGiiPuRp3+f4Al60sEyb+PYBRBQIJFwA8y/kY4dT8YeVAhLkm+VD1DHUPKVVjV3cU+3kxHwMF0AYCv/9VW1POU2QPPK10oUB7JJ1nptcqxUC/lEbStwESWyu8IePWi0VGUH/sXUWR8R8TTK6at5rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFkGnyVnN5TTqK/K7OLSHDpZxjbaTCmZvM8wjoJDeTo=;
 b=XWuRS5zNPTzsLN2ijtO/W8mcDY2YreL8rM2uFlsXy4Xq3Pu5kIylvRRJBkaYSaOj9rAmH9EjL4Axe8ySQn+X5Mb1hBUGAMzrZXZzm+k3hx84iOLBA9ewauPpV56+1uYKPHhRI0f2/9jLJ5PyIpNgbmLFSuiTPh9yukkuKM1QiV6mcrEBPTwBxtLNi7vVG5Cro6oWAisYUEpGTRq+g/aEEn2Qgp5YZcrD5ouO0ozoC9w0tqAREcBcMg/oIdr36PIS06Vlw3qbyGYJ20glfGX4IIm7n08nwBU3iieJg8PIPWuW0WEe9HF56LRUyuT+WDDDEXRsvrYNDDKppeLpMhwGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 LVTPR11MB9912.namprd11.prod.outlook.com (2603:10b6:408:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 17:22:08 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 17:22:07 +0000
Date: Wed, 8 Jul 2026 19:22:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 net 2/7] i40e: avoid null ptr dereference in
 i40e_ptp_stop()
Message-ID: <ak6HOhJh/pxdloEs@boxer>
References: <20260701124524.13644-3-maciej.fijalkowski@intel.com>
 <20260708150455.1498611-2-horms@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708150455.1498611-2-horms@kernel.org>
X-ClientProxiedBy: VIVP296CA0120.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::8) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|LVTPR11MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8a21b3-9447-4d22-7ea9-08dedd157000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|11063799006|18002099003|4143699003|56012099006|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info: EcJq2NOJH44CUSAb0UEGkiI4wrGfUjsE/h61SAth3vXxuZz7Z5aYsaJz03okVRuXdZbMD59X//jAVbmxfBH/vTqFIfEMcV7Tn4GH3WvKRuZu6el/y+xbnLZx2rOiPuLVwXFNnSXMORCbo4M9wRrKbfQezeifzCk6V1MT4CtxA7Q3wG2jaimQM/YmCMepyOVJC/D+V8hN50Ejq2dR8V/YV9XpDfUAo7zuMg9+2nxpSANn4ckpPvYziWyMagXW1V6lx3sOoSZ7lrfsJrDlJTUKVeckdC4sHIpiNYdroxNS6YQ1JgJuMmr+qE0369pBLhhuj8LwD41CxVKuORPOgUvYQuwEfNLWNnrbPG3EE833F/UyJ9zWcI/4c5ChploUNZ0ZJU77fKX4khghXdWaTNcaH7hZSKzPJwD3Aii5STHrYQNq5Ipim0QBcyX1T3h36eYA/r0T6SUqz8Dk1WNTjtt2OXolphWgmUMk8GLIuWW7SQXo8ydUe/e1vocEqba4NzdqhcrL5yb6dtGcpceMpcS4wJtMX69Y+R9SaJnvfAaSTx/OvXH+1jkZMA6q3s5GDyRzsBn1fzDm2viG2HIfQeDyNEZpK9trxCDYtaNbvCnhn/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QZ4tNZddYhX6mBrogW6Kf/tH9Z7bKgLxc5RhBc6zc2yzLP0b1AWWgb0p2Sij?=
 =?us-ascii?Q?pUg8OkpwNVNVvOiy12K1XuJsFB5DNCeu9E9bVoDDpS9DFy9x5lG35tqnE2x0?=
 =?us-ascii?Q?fBginWsmOJbFtTFjSlNHld5MzJMLZIv61B2jC/DGEz/MCZ49QORzuMnVytws?=
 =?us-ascii?Q?5lDquduFrI4iT6gkmnQLWG5nrJUQ+ARJcKEUCSwtm7rGUJSzNXnrysxj7hZE?=
 =?us-ascii?Q?fQPRal2srkfFQyBErknWiWbUg42NSXZNzUSZ1v/1pggktxVBXHilnLwirENn?=
 =?us-ascii?Q?w6BJk4tqjemoYkSSzGOWh3r/I9aoLBiAKCrIeRm9GmccHoQnsywnOzoRSG3I?=
 =?us-ascii?Q?B/lm4EQjddReqsbfRoYPuglNpUk7Io85mo4BTq5ZpWAZaoIYMNwUOwT6U8wI?=
 =?us-ascii?Q?V1K8+eP7Sv4UkE8JH6vTQlSw1GUQGLYYxGlcy1K6uT21KQPTnwwDAu/ai3v6?=
 =?us-ascii?Q?psBpu52jN9bAxG1irOhhvJ5kM2+u2wik3RXttlDiDpupNMyKwnrAYPQSX2kp?=
 =?us-ascii?Q?MOYFdXovcSkOy33UiIbydi4/DxS114MiVuDficyvEJTsTb8Gyq7x2f/rq4Jq?=
 =?us-ascii?Q?RzgyLoxhAXoqj3f/xJ3XPDN8AIZAF0fOXTL96n3b9IdFwUSSBfvdhXbeCKSo?=
 =?us-ascii?Q?iGBcEttI0HbKeQNnDwMPhppUgnGB3pJI5VBGH5JZjBSlVqTjNPT1qSUZ3gNI?=
 =?us-ascii?Q?dxjCs1yRHkYKOUSgji9saToKAg3GAhvrhQluHupgC8+wVgbuiSt3MuyuZyjd?=
 =?us-ascii?Q?EyYBSjIwbuQeMYznkUdf5IWewuXDmwc0VMBNmNl3LB8AcJI2FVTN33isWGTe?=
 =?us-ascii?Q?Np0z3tq4dSLW3gXaV6WMYwonpiIF9UOcXFEG+q9d3A+FCGtjpOHPOVIMqCWf?=
 =?us-ascii?Q?afUA4k3QgxXwo8tL8HAqSql1nkOOjKuMmbdq/F0JAHQzmcujAGYwV3Qx8+IM?=
 =?us-ascii?Q?RHkI4iUTsnoGwPNmLY5iQFAgHpQxYdDYF/4ydeVSObBOR83KEj3FIe/Wub87?=
 =?us-ascii?Q?tZhb92yH3uJ0qInTsLN9YSHe+Tjjqrv7s++C+6dQ+SZw6j1jVpczRAnztM/+?=
 =?us-ascii?Q?nk8u15FUNMNz4dKnCec3U2kNuCPqgasuc5kXih4oE1MGA3IVZCHlnjFAsZvV?=
 =?us-ascii?Q?NUXGZAx2xoHZMwyhkGtCxhaTC0z5ZffXHDB/r29GQ05b0sezbv87bjn3vnjz?=
 =?us-ascii?Q?/zbqafhnwydO1pDa77Zs/mgH5cla6zVZQokfnH/2mHMkGBLfi+hxB1vergaf?=
 =?us-ascii?Q?YQ7Tw/dDhl7fPHLphd9ei2QIufbZ99RUiwlMaEoYVva9fIFg1UBWoPbrsjv8?=
 =?us-ascii?Q?iSD+A8ojC3fsseJzG1uMKXAmpXOySa0vup9kZwJCIFEALxd12E/1Si+Owinq?=
 =?us-ascii?Q?iWO5euNuywGWb1GPFQNteV4iKnTEa1qJUFJ7ULNhvkFV5AKYWdUljX4nvHmY?=
 =?us-ascii?Q?pcNYj9QfH51trWo/BqE9LRsEdh2JXHcqYP93VdEjih9N0CFiJBSUVMyz36cL?=
 =?us-ascii?Q?/F7m12PgeIAioj2vDwMvqfPD9CKxw8jTKQMgbk7UOSf26XIGPUkRuDC1n66p?=
 =?us-ascii?Q?qtaRyeaiXg9NvLtXw0yUVk9aOqBEY0GASECgMCOqY0+zmQA+q0VZrmzMJwBb?=
 =?us-ascii?Q?gyNT1A0Dc5T11soa13Ky8DmadsMIMf+V+Z2wtx8IrnTE8AHFT9dochSvB55R?=
 =?us-ascii?Q?VzHgs7CX6zpq+riR2huabV+Gf1D9MVnGAonP+2wbZ0LdGp6/HNuTCmu/C7wL?=
 =?us-ascii?Q?0hKMaiU4Xi/4y4Y7vboQtHW2s5m9rfI=3D?=
X-Exchange-RoutingPolicyChecked: BwLwInI69IDM88ocGzaycvdW9LrubVoU2A/9fgm2Tz7x2vG3kxZlr0fwkVdtYOzSwRyr47FhJu/+YwbKo+hUCBaJd7VzWKt4K9rJBNfaJ2e+vKzxSPYNyTkU/WUIrd1sC50beMjsE88RLd/YAgF0mdydjjlwiKEK1+xESGlkGZQR41Ov6wsCY6CzLsm73Ax6Z9Mjc9TSIK54kxweyvvpdcK+RqOnqShDCI7AcJGKMqk3Yt+NmaQ3oClEhRYxwl3rDR2mUVFeL7ii3mxI/s5zBKaNC9agEL+NtL93Q7JaFzniqYEwj/G1opEwX77qsyqjC7E0OkJe70WyYAFPToV0Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a21b3-9447-4d22-7ea9-08dedd157000
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:22:07.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyf/lkk9wYvJ8ltu8xqcWut3Um+p8wwLJCcrNyVQ4sjO6J49fbqilSj242LmdyrQk1/rkJ67F1hnVPNm2CeQ91KVx4cxTrOkZzUG3B/ZfGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9912
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1307B729232

On Wed, Jul 08, 2026 at 04:04:56PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> i40e: avoid null ptr dereference in i40e_ptp_stop()
>     
> Check if main_vsi is not null before calling dev_info() to avoid a null
> pointer dereference when i40e_vsi_clear() frees the main VSI during rebuild.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > index ff62b5f2c8150..ca93df4d67859 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
> >  	if (pf->ptp_clock) {
> >  		ptp_clock_unregister(pf->ptp_clock);
> >  		pf->ptp_clock = NULL;
> > -		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > -			 main_vsi->netdev->name);
> > +		if (main_vsi)
> > +			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > +				 main_vsi->netdev->name);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but this lockless check appears
> to introduce a time-of-check to time-of-use race condition.

Thanks Simon I saw these, however since all of the issues are classified
as pre-existing issues IMHO these changes are okay to be taken and then
we could go with another round of fixes.

> 
> When i40e_remove() calls i40e_ptp_stop(pf), it does so unsynchronized from
> the background i40e_rebuild() task. If i40e_rebuild() fails during setup, it
> calls i40e_vsi_clear(main_vsi), which frees the VSI and its netdev.
> 
> If i40e_ptp_stop() caches main_vsi right before it is cleared, couldn't the
> if (main_vsi) check pass, but the subsequent main_vsi->netdev->name access
> dereference freed memory, causing a use-after-free?
> 
> [Severity: High]
> This is another pre-existing issue, but I noticed that i40e_ptp_stop() doesn't
> seem to cancel the background workqueue task ptp_extts0_work.
> 
> During device removal, i40e_remove() calls i40e_ptp_stop() and then
> subsequently frees the i40e_pf structure. If the work executes after the PF
> is freed, will it access the deallocated i40e_pf structure and trigger a
> use-after-free?
> 
> [Severity: High]
> This is also a pre-existing issue, but I am looking at how pf->ptp_tx_skb is
> cleared earlier in i40e_ptp_stop(). The teardown uses I40E_FLAG_PTP_ENA as a 
> gate guard:
> 
> i40e_ptp_stop() clears I40E_FLAG_PTP_ENA, then locklessly checks and frees
> pf->ptp_tx_skb using dev_kfree_skb_any().
> 
> The interrupt handler i40e_ptp_tx_hwtstamp() uses the same bit as a guard:
> 
>     if (!test_bit(I40E_FLAG_PTP_ENA, pf->flags))
>             return;
> 
> If the interrupt handler passes the test_bit check just before i40e_ptp_stop()
> executes clear_bit(), both contexts could concurrently read the same
> pf->ptp_tx_skb pointer into local variables before it is NULLed out. Could
> this result in a double free of the SKB?
> 
> [Severity: High]
> There is a similar pre-existing issue related to the teardown of the
> timestamping state in i40e_ptp_stop() racing with the TX datapath.
> 
> The TX datapath i40e_tstamp() protects the state using a bit lock:
> 
>     if (pf->ptp_tx &&
>         !test_and_set_bit_lock(__I40E_PTP_TX_IN_PROGRESS, pf->state)) {
>             ...
>             pf->ptp_tx_skb = skb_get(skb);
>     }
> 
> However, i40e_ptp_stop() checks pf->ptp_tx_skb locklessly and only clears
> the bit lock if the SKB was present. If the TX datapath acquires the lock
> and is preempted right before assigning pf->ptp_tx_skb, i40e_ptp_stop()
> might execute, see a NULL ptp_tx_skb, and skip the cleanup block.
> 
> When the TX datapath resumes, it assigns the SKB pointer. Since the device
> is subsequently destroyed, does this cause the SKB to be permanently leaked?
> 
> >  	}
> >  
> >  	if (i40e_is_ptp_pin_dev(&pf->hw)) {
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the driver's
> cleanup paths, I noticed a potential leak in the i40e_probe() error handling:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_probe() {
> ...
> err_vsis:
>         set_bit(__I40E_DOWN, pf->state);
>         i40e_ptp_stop(pf);
>         i40e_clear_interrupt_scheme(pf);
>         kfree(pf->vsi);
> ...
> }
> 
> If initialization fails after VSIs are successfully created, this cleanup
> path calls kfree(pf->vsi) which frees the pointer array, but does not appear
> to unregister the netdev or free the actual VSI structs and hardware rings.
> 
> Could this leave an active, registered netdev with dangling pointers to the
> subsequently freed PF, potentially triggering a use-after-free upon network
> traffic or userspace access?
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed an ad-hoc locking pattern in
> i40e_remove():
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_remove() {
> ...
>         while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
>                 usleep_range(1000, 2000);
> ...
> }
> 
> This attempts to synchronize with the background reset path by spinning on
> a bit flag, which acts as a sleepable lock without the standard fairness or
> deadlock detection guarantees. 
> 
> Since this ad-hoc locking scheme fails to provide proper mutual exclusion
> earlier in the function, could this be the direct cause of why i40e_ptp_stop()
> executes unsynchronized from i40e_rebuild()? Should a proper mutex be used
> here instead?

