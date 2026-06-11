Return-Path: <netdev+bounces-298294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g8jcEF8BK2p71AMAu9opvQ
	(envelope-from <netdev+bounces-298294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19767487D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="ExOdh/gc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298294-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A9E93001191
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B404D2ECC;
	Thu, 11 Jun 2026 18:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352B48A2D0;
	Thu, 11 Jun 2026 18:40:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203232; cv=fail; b=H81nqRqU0ElQBBHWVAknYQxljhoT+F31xVXaP3kAZIuQuXl0PzYT8CHXwMIq+IQ/BsNj0WiREdsrObCVr8GXAUDg/oywLfxcMBozw22ogsQ6PPxTPB1eNf4QC+hQL2VBPvcmrdzw9wnENRZyr8XebRxO5csf9kFq7NZR6d/kkUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203232; c=relaxed/simple;
	bh=wpDjbZQhj6kjyGNGP4X+2Ejl2xzxPopMrKu2hQLwNBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVNCf4Ghtb/OWWyqELOUQRht4Bdf4fdl7KV6qXJdCXLR2JQa6qcKxmlY3nf6Eh0d5eTfS5C1fkLn8abhQljrMMYds6iT4InmJe3ecWJquQckgkz02eqiqxFwJLxWcV1b2OXcb13ipAvKxMO7VefCNPC6WjJMgllR3E3PtyqV1kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExOdh/gc; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781203232; x=1812739232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wpDjbZQhj6kjyGNGP4X+2Ejl2xzxPopMrKu2hQLwNBs=;
  b=ExOdh/gcCSeeBH4Ly62a4RYEFtL2nsRjmvMS9S9LixJ53CJPuv0M8y9o
   nsar7WUbc7xlvaT9Lp+ntEE5hUcyUyjF6lyeiLRy/LxLmQ2YRote+jauQ
   MNCZkiaW8Z9wPLWaTwVUxybFN9cETffghTMKMZkF46WfUhDRKtPDXHNT7
   +fcJzxxRoEjYSla5gyPVgCa2OJxfqMHT8zgVDpACDXIBiys/rRd1QER4s
   b2bYGoCVrvH3pMy+kkv7uPj5LXa0sI4f22TyocMLZJylBMdxMkOUmogmd
   s5+d7CRuzdVGic+OOU+cSt07okDBSq4h9sM2U6Q6c4rTCnp3fjSQmHVlo
   w==;
X-CSE-ConnectionGUID: FUip2rNRRuS0GEzdDXGEiQ==
X-CSE-MsgGUID: VhRhsWkyRFaYT/1B8FF8/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82032746"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82032746"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:40:31 -0700
X-CSE-ConnectionGUID: x/EvSdOmQH6xOe+GAVMjkA==
X-CSE-MsgGUID: qAk8fCTlRy+fK9RKYpzSHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242197631"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:40:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 11:40:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 11:40:29 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 11:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH9dPOmZogmzB+KRfNm2A0PKliwkkfxPngZ6skniAIdL6XGiorGx6RmsFr7RvT3T6H/OGLd1qK7ywlGS1i5IIfwQkLTUMNPoveLqjfY8YRgCk/X8Cm6lxLDPq4kbtOo5IF8MZ1Km+vFVd3OUXRiatVLTXE0rP5aIBPPN26hnZx/SFwd1Ssl3hfbbih3UGiPKWh1OfoRsVUZvMvZ71yTC0n5SLDbh5U32p/q0HLeh6OJ1UH1K5vDxuoyUslbfgxMO6I0w9a+8s7Whl0VSvI1pkRqODjgLEiubQ52TakC1guxmwACDDtwl5qKjU9Vtm7fpsqXkn2oY9T7LKX0GQ3c18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjgECcsOzNqePRO2BK+Q9gA3GjJkvzqfmqF/JjGF8nU=;
 b=WOTE4HKiGO6R7jC03rbbNm9N2mB3JjGJoLZBWjsNDeoKnIf3MHc8lM72sjqymUaeBK77JZ8/3vRKm+ORXIpHmH8nQns+ACQ2SJ77NPDLNCqjDiQYax782h6z/kiUxs/+mstidO7U6h1mAURFb7uCMcxXx6RYF3+OmH/2iE44+DjldKmX2VSJsfDZEBgfHVFKVso9KK9kNhCW5BJlCv/l6hbLdrNiGVgBjxCFgtu5INeMSTp949aYzGW7etIQ+6BOTINQcAPPUNdc2Fjvkzkn3ktIrV5zuqkvle1S1XR4aU2uDMee+JfcO8rCRg+EIC4nm0oghgBZdC7EfAM1I0/X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:40:25 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 18:40:25 +0000
Date: Thu, 11 Jun 2026 20:40:17 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <menglong8.dong@gmail.com>
CC: <jasowang@redhat.com>, <mst@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<magnus.karlsson@intel.com>, <sdf@fomichev.me>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bjorn@kernel.org>, <kerneljasonxing@gmail.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] xsk: support tx napi busy_poll
Message-ID: <aisBEUmSJa1vkFYo@boxer>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
X-ClientProxiedBy: DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|LV3PR11MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bafb6c6-c912-47a5-9390-08dec7e8e6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nDMqkASthuLYNC3mInEg1c8PLlLuDpLUt42nX/4fnsv1s4wAzx9nq0wk9gLqGIb3Ahpfmq0AqFYia+0xkEE/DQV+F8Gygxp7fMJd2oA+ceoLpjfJKXOrz8aRJYxfPv/2XEYdlbf+shXlOLygdasYNCfb0H7g+2VM6yc7kxr0DIoTL3p4ocRjjirjRgZnFW9yn38FX8bLL3C//19Lcw2zepxGxrQLWntxMw7r0ZQPhYk4lNMDgrEes1WCzMN9dAqLx/m3717sSggKFjVaCPLZAk3HBiavq7JNbFtQa0aaxsIwrhETwfwy45Oir6t+WsR28VA3FlmCFTOVVP0/wamoH+NaP6feRAEwhv80padlKXwwyxSVMm3Udv4tPewMRxy6ZHn1ANqQxrpqArwMellU/qg5iKqL9xbzNwrZfUlyAokYWYHvNbTatQiotwVPkh4X/YA2I2u0EFyp2hJzobiULzA8qmEsO8DYtIFlsLo9Uft1QteiWI1WWWnMbWLtGqsWHAaVRF2DzP24Tq3B67M7rT2HmMp4rto8VSYHj3cXRhqJhNFhBpOvrCz9yvaERpko2VOtg6Sq+QHYrx9WAgUIRTITfNJS9vQE71Y+NAGuz10GZ4nb4Fe0+3yUIbsBbsA9EQBTa0PPwS42BNa8Y0GwmOG5/UePC1tWuc1wsrcfgL8UJS+Kxt1CyQxrSIk34grM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfGy95Od+xgWhMKjc+GNUoHQHA6OWRftYeNs1D+QVTvqjM50kLKORVFdH2Zd?=
 =?us-ascii?Q?FS7K59kC6ooVw7NTH50SN0SFuJLHBZw+g70Tg93SN9mxUJ2iyn2VVROQGlCs?=
 =?us-ascii?Q?mH2MHi09E0S3Bo0pHdqEYzfqjSmYm8VQlt2uy6GIPPFMZvD06DkXBifYUUWN?=
 =?us-ascii?Q?J6lan07aHg3N8Z48gOq+6B6Y2wrmI0L/AVhNFkVabILLzmaXxrjQbNF8pBZQ?=
 =?us-ascii?Q?BQLc4SEMzNfeyExwJoM8xfqFDSz263Luu9R+O0tAAqfn7B4comp3KxGKbiuW?=
 =?us-ascii?Q?4G+uOqMowd9bRIwcLGbX7mU1pIZ8QlYZD474J8OghsmEQ8kwwBX2TaeMSfu2?=
 =?us-ascii?Q?Fu5Q+zTnu+ClsteJTHmbYkuP34VJH8jrnScvxexVT3moo+/zwlwktqZW6cRo?=
 =?us-ascii?Q?ppyfzz8V4D/ilBZgfwNF58PH84XJKn0uWepddTPDohPBtfpMWGoQcSYmLkWO?=
 =?us-ascii?Q?kKp37RhZwWtfgpxCBD5Nb+fJG7jRYk9r0GS0TwViFPl5FUb8cpbvdfP3wupT?=
 =?us-ascii?Q?x1YHOBDQpgppCwQl48cymChlZ2YTjylj9MrOzIuTO0lNz0veOlU41F2EvMtp?=
 =?us-ascii?Q?EWo19RT2EPT7bXi7yHNIwsbt0muyyEwMUiSFRbmEwS1oVa19eJSnt6hMeLLZ?=
 =?us-ascii?Q?rAEYjqA7AKtLrDRRDK6Ga5xxrZlzTQtmHDPfzaGsYFFstSY1xjMBjcmlXBH7?=
 =?us-ascii?Q?bBmr+Rs/+h4dlvo79AdWlqkhWd9tC770wHWJPvLbMZFveIkm1C6oaNAOxkdG?=
 =?us-ascii?Q?2BoJIaXZL9ngOYxPg2wJ7ybC99UT+QDA/d/sRwhk2CGUwgJgeHPMYLgQDcRo?=
 =?us-ascii?Q?4a+smZ4qMTQHrvPyRwvOchYAHiz2hw9JpJXyNTdDvqN1VDziQJ1hg52q0TkW?=
 =?us-ascii?Q?u/6o7cdQ1YvTvF9L4MLc5yamxPfweroOzG7mTUUawrah61uTr9OlzDdlhiKq?=
 =?us-ascii?Q?NNwmD9Pa0yshqt5nMEdbJ3TrFrfWzeLO9ro7u7wvl8f+9Z25SD4ZDAXHYEka?=
 =?us-ascii?Q?kf/augorT37F3KCwD1b57n/v2AyBwVG9NR3Do1w6Rh/9XwPfqkLq7i5zV+9Z?=
 =?us-ascii?Q?tnyMZVyXYeidVvgc/L0EDOdRMs0E/i7jLo1fxxowYx9tffkxLWD04OPWGuFQ?=
 =?us-ascii?Q?RJLat+RIbwIiaTem17J8VmcV8RzO+zltfwg2ECUT/KvU9KTX/Y9waAzGlGnr?=
 =?us-ascii?Q?8JIn8V8RvPI9r+1uj1b52PusRmIom1hyaAXdRIiMlKNQ3P3VUv+wU05ULTvQ?=
 =?us-ascii?Q?LZ74DeScBfp66RMK9ZFWMzK6ldsuraA6jz+1fOasTqiBGFvrijVZikrkRHbo?=
 =?us-ascii?Q?UWwMgUCFBPsyyMSMvNaR/WD1UDC252e1MpZO3ZHXQ1mayJ26LIoA4jHbzMEr?=
 =?us-ascii?Q?WH3Jp4gwylmjzGt5DaPc13Wtkh//w4EDkYQ3N6UyJSOVb/nexztg879MMMbv?=
 =?us-ascii?Q?udUb5fw8RzyP1EoUX0JhJ9/yTO/lA3c/CQAwPpYWIFFwKwDiaMP7xkBd/HU5?=
 =?us-ascii?Q?MlZGQpuHlA6ryKUcOTgzdWbkwLKxbiHWpzZ8MIlM7bGBV/5RFiBTvE3qIH9g?=
 =?us-ascii?Q?L0zTEcWIwNIunBWuyghpaHiiFRupJs2tQWHhQchOuoaeye+V7HSj3Qhw02C5?=
 =?us-ascii?Q?+isgL7iayAAHUM5p686CINnxhVimdtml4tJaJco5EvqlEEDSBpOntZSDPSDL?=
 =?us-ascii?Q?Jo6HDwmmUMSRzU90Xm4e/qf+im7AHdiJUE7FVzy22l3j7nLpb8oRvhdjUvPd?=
 =?us-ascii?Q?qxe/f2uVFPUPB5amugPOR86eywc84qY=3D?=
X-Exchange-RoutingPolicyChecked: MrTjH67DMvgkdGPuFP4IaCBkrxTbAhiYfvKv8mABQ1DcWrfF/iUh+1myJnKFZTr+Oyg788+r3V0V+F94ijqYuZfwKGZVgR3Ge/LPXSad5+o+IkDs9kXUDV25AA4Wi27xZM1XlxNTJNAq0cyLmu+x5e2gw+caI1AwraSaf03u/VFwLYrz+VlETDX5pv5mWeqYk4r3yOuca7cqy0+fdz45+xLhaYJuhyYrqKv+84SVhRL2LCq7Z5ab72/39LYmLs0CDSXxkNNRZNnUV5E6OntTGyH5HvJmBfbbrPT3oE68aLftiCvUMsv5XpTf9gS3aVMPLnMnKJ79C86PLdI44r+qRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bafb6c6-c912-47a5-9390-08dec7e8e6c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:40:25.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STeg77Gorb4XIajERkOA1+7LTZdOSjrOZNUXhOM4DYcWLq4HMSCBq15KTgURtITKj4oeYIwbACy5rcYIj/b95RSe7ulPuqsevdwKWb7Iu2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8531
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298294-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F19767487D

On Thu, Jun 11, 2026 at 03:12:39PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dongml2@chinatelecom.cn>
> 
> For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in tx
> ring. The sk_busy_loop() will poll on the target NAPI. However, for the
> nic driver that support the tx napi, such as virtio-net, it can't schedule
> the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk and
> use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn't
> handle the packet sending.

Am I reading this right that you decided to break busy-poll support for
zero-copy drivers that happen to handle transmit side from Rx NAPI context
in favor of supporting virtio-net?

> 
> Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
> NAPI if available. To get the tx NAPI from the napi_id, we add the
> "tx_napi" field to napi_struct, which is ugly :/
> 
> Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
> this a little contradict the design of tx NAPI.
> 
> Menglong Dong (3):
>   net: busy-poll: introduce sk_tx_busy_loop()
>   virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
>   xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
> 
>  drivers/net/virtio_net.c  |  1 +
>  include/linux/netdevice.h |  1 +
>  include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
>  net/core/dev.c            | 23 +++++-----------------
>  net/xdp/xsk.c             |  2 +-
>  5 files changed, 46 insertions(+), 22 deletions(-)
> 
> -- 
> 2.54.0
> 

