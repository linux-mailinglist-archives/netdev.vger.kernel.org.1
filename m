Return-Path: <netdev+bounces-304946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Es+rFpSIS2rhUwEAu9opvQ
	(envelope-from <netdev+bounces-304946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB970F7B5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=PlXMZBQq;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304946-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304946-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB1BD303C67A
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC38442119;
	Mon,  6 Jul 2026 09:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A7442110;
	Mon,  6 Jul 2026 09:40:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330845; cv=fail; b=g83/XpHLmqHLbgyKymYwzPhxF4iHBZuwjzTxadGQqLx6SJN0Lb+IN/qgH/FHXm03qwePTp22nhY6Ju0+CLoRpnFIEjJBPZjj6AOZAmXCxMr/Z1iwWZN8B3INZZe6DdAoQBOPUmxXwMsGD8brctluFz2IvoKn6ey1nT19NU0clTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330845; c=relaxed/simple;
	bh=bvgnDdb2RQr5KePB0WVmsVNUzCgRCOAsa/6/TSJSiAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YF41yMWlpcTsz4CqFER+u4z1NrZsgDPAESck29qdgxW/SYmiEWSvisZaT81M0GsrQflB/Q35D/7Wi3hxzjh0FJSAcNaAdJxSssTUlaHnJELXetzGKhY6MfQUNNfqV4jI7fJAE3weie35WrFSqHR8nVcVOHIbZ9bpBEgMUDv24ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlXMZBQq; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783330841; x=1814866841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bvgnDdb2RQr5KePB0WVmsVNUzCgRCOAsa/6/TSJSiAU=;
  b=PlXMZBQqVVY8Cpkx5rS4Al6r4xX7q2FRsXsUZgPfQJLZ86cqexfCT/SC
   3gzAg3OokaCxdOxD1ei40Z5E69S9pMxZ1pQV5Qdg45VRWATkKqIOEUrxE
   geu7icsGYDuUiklBbxz7t2FrFEd5rOTAvRvqB06SJHffdcRRujxfdAtja
   mY9/n50Y+ysY7586qCUKscS13XJoO2IjeDHW3dIaHQD/z8i4hJl4CeYNX
   I3inI9xMHJrKW1BO6Hl3H++6OIuykIuDUfIyFxyzifupnqdNeYPeqtmr9
   /w5MJ4AvRejjLAo00fJkn3xSjkvry2xmOUjGKuDRFPgL0El0eE/qGjnlS
   w==;
X-CSE-ConnectionGUID: YYlm9uppTIG1egL0BwbZvg==
X-CSE-MsgGUID: ADkWmzhQR16e25zUAaAvXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84053281"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="84053281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:40:39 -0700
X-CSE-ConnectionGUID: MSI+h9a6RSq6LzUPuulBag==
X-CSE-MsgGUID: fd9ZA1JiT4GdblRhKkHY0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="283761333"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:40:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:40:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 02:40:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 02:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqwg78gg7fOIR5meGSuXyo/vGfJ/aKZtwaEb7VhQ4hghUiBdjMqiDcfhQOxrHddNm/zEf2g8EOH3P2IbZfNe/Q19KN6j2HsPvgcROgSk84pzzOpmv0N18GCBjDRLteIhVNW5whl8pHCdV2yIpL89+gUKOWTWj1sxLQ1bv025XfHaqvU0VViWtJFs4NvtRUCLGQnEp59vX4ouCT5ZkvpRxYqHcl8jpG6WwUiYmFgiXY0mc15Rc2t2c7Wcmv6Kn0qaxagovyyVjAwTjfpp+WSDzmCA2N1SGshKDuj26NNeEzQN5d7OWXZrv5LZCdNabCZXmVhhRbMReHR5Tr0DXLdUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk8/1Z1KjDiuSvoDf4y7S5ui8qAhzZm5U4wMoZJ+E94=;
 b=O04AASgcBVIt1aHW8BaXFx42ScA13Lu64yzkJ1YpGTyo73UcdzrDHXx4tE9Jc4XxrI5N7K+n8pqRDKE+oRI4zDqMrvhAjDaRdMhj4YN6u5SAjKmqPjTynrj/jwUkvxBiJPrl2P6iHGJ0KvEjxXecwpZU1eyMeuEqn1JnwwMV2Ta/sGywYYm6fJeiviYd/Fe8XKdLna+3HNpDckqXb4FrCgmEhc/qOFkD0Bv3SB5kGcIZdSNBwM5sw5yScFglTcPYxPtKbxq+BwpNqznjhJ2F5mNxwbNAgFpMrNKedBst3p9tzxtWEg0kT4lM52uD7epJGhNzes72/5tkLSeHX5tbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DS3PR11MB9841.namprd11.prod.outlook.com (2603:10b6:8:364::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 09:40:36 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 09:40:35 +0000
Date: Mon, 6 Jul 2026 11:40:29 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] octeon_ep_vf: fix skb frags overflow in the
 RX path
Message-ID: <akt4DUQi4GMRPNJW@boxer>
References: <20260704061511.2350737-1-maoyixie.tju@gmail.com>
 <20260704061511.2350737-3-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704061511.2350737-3-maoyixie.tju@gmail.com>
X-ClientProxiedBy: WA1PEPF00005B89.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::637) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|DS3PR11MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3000e652-c91e-43f3-d0b3-08dedb42a189
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x/hdVSc9Gy9XUtPgBMqWrNlbcB26TH/WCl8HKm/P13Ui5BnOG6feYTAAYvzCHkrSvbAsMGsgGIOMQm6a9QEAw/266CWuK/423Is5Rcg3BRNYSgNVIACvWLlGP7IBWPhIeaef70wlBKACBwTV7X1tKiMdYERGq+bgEuMDbzjMFsTaeEPk1eNFsFVvMGmQUBufKY3sniYPRcFeybEl6RphW811IN1f6HSJpYKhLYs2lSaolG/6w+5yUzNW4xVUyYFZOBv/RrVkJtEmNf/cufo9OywdlFJbEPo7oxtAOmsUU8Ts2p4vzufKS3F2EAh034z+B9+sXORKKDctVpRfB4MNItTSgSuOjJ56UHQh3zqEpUgrBp0ZzPhjKwIdTI+ovrC2ddzZv7fx0Nk0ynk4SijpkHuFjolmvPg68pTtVy4LcGUe0YtH4WTots1wcGgRGE+dG6dz8js8jxtlaA7bAbUSCwUciNVPzpIVr02j+8FQv9i/5CpeJl5DNKe/01bt5LTOYMBhV3zwoYi2gTYDJa9Zu3zAAmi/yM1XuL52vddwrhsmCvde2NzE8bhFFtkpLlhhBdq6nO1IyuaTiLAn25SKMhXIlf7eV38wmZ7Dr2Ep9nOShDbMijZqaOOpE2yuoTLoMf3WZXRzuc8LVCCUXpHbt5XFLQME2MvuJcC8ggPwuOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qW/86UgVkiQnBIlZNAlO062WNPMp9gJfxC85P2OLYTAa80xSgMiJdVCR9eZ?=
 =?us-ascii?Q?Sc6xJDnAcPoCjg4dOKCb0enYlvWqYEmrQt3hhZR89iWRGJflWwIRXOFDHZK3?=
 =?us-ascii?Q?qVMND4cdChwOCWVw74Ngah/FAdXUlRUhA5wp3Xb88LbxBS0O+xMHzd/wRfeL?=
 =?us-ascii?Q?rIkWtxr9PkTlprqgapeDvL1tTQ61ujSaPLgKIQr3gu0K+pTcej63/HxuHBNH?=
 =?us-ascii?Q?3Xr20t3E5kAyjjXweTUrfW+AJtmnkx5L6ccs8EMU3gAAlQxWQ4vst5KQbghd?=
 =?us-ascii?Q?w7Bq3nQrDVsL+mUdlaugYCuWdAf6aktOcVbPUog4/e9G/X2CtCaTyNmY/rTG?=
 =?us-ascii?Q?361MEhMu69M5HstBP/pTXr8+aqnMyMO8KeBswSRg9HOpH7R8wM6jGYv0dnfY?=
 =?us-ascii?Q?uwoHs23TuZKyU0zc282VQT+WBSKt6aRlM/oQAtTzTvW1/1P5L2c1NysDxKId?=
 =?us-ascii?Q?5I8R2FqoDkvTpKmiqjcClJXSD+gnNSypd+7Lh3bMa7mm6AztWDL6/52JDRlq?=
 =?us-ascii?Q?XmgzqmtZN19wjYof7qyq1+5OUGMBauZModKj3PCYNcbZltUgzvwz9VEeNRtv?=
 =?us-ascii?Q?XiwhFqjH2jDhoRtMznxnQcOfm6zcz8Py3wK4VhSuGAlVdfEmomEzk/KnB1Uo?=
 =?us-ascii?Q?YtyOGuGpjTG54FEOUqScieJTRuvCi+lT+YiXtM14vctKgnVlO62i6vxWzQ37?=
 =?us-ascii?Q?VKpEccbsSo4HuYboWXuCIFUsbA2m6w8c+BPn3ihMfv84Go18Q1OOmvUfInY+?=
 =?us-ascii?Q?r5mHEhb3W9em7a1wW5s1UiEsycG30AVUM9z63BxqgjruCwFpdjuQX4ZISVPv?=
 =?us-ascii?Q?WXcNHkTn9s0pv7Nj0r2M1IoCkqJW0bsJCUv6ZJZ2K0VABiPa0LB1ylVhIAWA?=
 =?us-ascii?Q?EqpL8yME61OG3yBd41fCIbpbLGj23KPrk4EdHiijrniN7736WbL70W5UH7Bw?=
 =?us-ascii?Q?UrBcvWLZOTdOW/rD+oCwJ/RvC03WLIvtJdEwJ93TuxaryvuQCVipSIkrJOIG?=
 =?us-ascii?Q?nFC7MID4mKj4sfutRliXFxVsRzmAM5nh+mdOSO7cp9ooN6I8YToOgzenwKH9?=
 =?us-ascii?Q?cpVR/D40Wg4BXwjcFbzsL0Z2mLECbeUqYAgc56zkQJsbgQ8prRVq+0U+GWDg?=
 =?us-ascii?Q?ZeZlKtZ+ss6GbL+4hTsZGfRtd4ohlunTNbWvEkuvWDY/hEgrPAXaHGPnlbM0?=
 =?us-ascii?Q?a+qh2tHm9Nf2Mj8tynDFGrW2MZRIdhLPx4xF32hHtnSbIldf3RtD+MhGmhT1?=
 =?us-ascii?Q?xBVbY2Jqj3wLJcO4IV9Q05xNagFQJ1mlo5YVSW08BdTe9FVtOBWjpbn1uud9?=
 =?us-ascii?Q?odvUvkwPfdPGR/oNIlcUMx0OzCNnsf1Ck+Fj5NTi/0ySJGIN6FRqKneqiXxU?=
 =?us-ascii?Q?dGp64c/2FFDSzS0eq2K7QkEtUtUWMRCLjGi1E7S/GRW+WzM4k+VYkvIdlV2D?=
 =?us-ascii?Q?AapDwRHjvyVP+3/2lJTxXx05r0upe/hkfIXc+9w01OvVM7mvmE/UW2jjkpay?=
 =?us-ascii?Q?PxuPCifOt7iQvaRFxrKhyqVGuiVFY1QdtO4Um/iBFDi4dnCToutcn6QDm+vO?=
 =?us-ascii?Q?y4HKINNMsls4NMrV5Ccv9tnLwFa71mocI1cJGsVV3nklTEMWYb5hp6YtN2kQ?=
 =?us-ascii?Q?IEzBtTsxIuXKwsciBR96ghtLZYkYrfW19C91oTYIBWh/LQoQL0mVkMMBlFNi?=
 =?us-ascii?Q?v0QKXN17ctmp3ulu0SmzodmpbE21STnlvdmp+rsAbDS/FASaHMsh6iYzEdD3?=
 =?us-ascii?Q?LrI5jTSdr4VRuK1uUzjbBuXHs1qyg3w=3D?=
X-Exchange-RoutingPolicyChecked: Ebbq9zCwZFbiyxfgyErHFX5sfdpmF222R5Rwv62rvy3P7clG9S4FFBKIcpLyoxcuyffPAbUcWdvTeCxAoFVmmQy8hsmaaHExNOk9ClGE75pY/2NAyCRFt4ltKzkrQFFmoYiCh/uk6Hh7Ho2WNFxUABhUKKfi9i5N8SrGlD8DSYnsRLrBiGUPdRoR93CiPmPVeq/ugGdkgvZeVXIC5SURHq/5QWiIaA9dUz/Jx/wKYpPNRpMbauo6u7y56/UauOH27VhmHUzTYdX3avpZPFhoyJ3KtZJPhGQvYf+clFr2uox4l3CyNxcoI3uhzeKE7DULM8LcgrNTnPKVBA/qJ2eUFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3000e652-c91e-43f3-d0b3-08dedb42a189
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:40:35.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmaCXN/l7EBB5RQWk4+PKVBL513HImdFtG1gv9mACdq0d13ZhIUS+4j367UWguU3dfGn/hPRNFrftkoJEz6UbAz5BPQvrFxsTT94M6e09y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9841
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2FB970F7B5

On Sat, Jul 04, 2026 at 02:15:11PM +0800, Maoyi Xie wrote:
> __octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
> driver. buff_info->len comes from the device response header, and one
> fragment is added per buffer_size chunk with no check against
> MAX_SKB_FRAGS. A long packet yields about 18 fragments, one past the
> default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
> shinfo->frags[].
> 
> The fragment count is now checked before napi_build_skb(). A packet that
> needs more fragments than the skb can hold is dropped.
> octep_vf_oq_drop_rx() drains its descriptors. The napi_build_skb()
> failure path now uses the same helper.
> 
> Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../marvell/octeon_ep_vf/octep_vf_rx.c        | 46 ++++++++++++-------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d982474082..aa77b673ae 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -357,6 +357,29 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
>  	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
>  }
>  
> +static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
> +				struct octep_vf_rx_buffer *buff_info,
> +				u32 *read_idx, u32 *desc_used)
> +{
> +	u16 data_len = buff_info->len - oq->max_single_buffer_size;
> +
> +	(*desc_used)++;
> +	*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
> +	while (data_len) {
> +		dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +			       PAGE_SIZE, DMA_FROM_DEVICE);
> +		buff_info = (struct octep_vf_rx_buffer *)
> +			    &oq->buff_info[*read_idx];
> +		buff_info->page = NULL;
> +		if (data_len < oq->buffer_size)
> +			data_len = 0;
> +		else
> +			data_len -= oq->buffer_size;
> +		(*desc_used)++;
> +		*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
> +	}
> +}
> +
>  /**
>   * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
>   *
> @@ -431,25 +454,16 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			struct skb_shared_info *shinfo;
>  			u16 data_len;
>  
> +			data_len = buff_info->len - oq->max_single_buffer_size;
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}
> +
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> -				desc_used++;
> -				read_idx = octep_vf_oq_next_idx(oq, read_idx);
> -				data_len = buff_info->len - oq->max_single_buffer_size;
> -				while (data_len) {
> -					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> -						       PAGE_SIZE, DMA_FROM_DEVICE);
> -					buff_info = (struct octep_vf_rx_buffer *)
> -						    &oq->buff_info[read_idx];
> -					buff_info->page = NULL;
> -					if (data_len < oq->buffer_size)
> -						data_len = 0;
> -					else
> -						data_len -= oq->buffer_size;
> -					desc_used++;
> -					read_idx = octep_vf_oq_next_idx(oq, read_idx);
> -				}
> +				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
>  				continue;
>  			}
>  			rx_bytes += buff_info->len;
> -- 
> 2.34.1
> 

