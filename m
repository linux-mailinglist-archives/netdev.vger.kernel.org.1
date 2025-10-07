Return-Path: <netdev+bounces-228133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C746BC28A4
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 21:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 818484E1ABD
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F492E54A7;
	Tue,  7 Oct 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYVluIct"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8F21578D
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866120; cv=fail; b=cgJuIDN9gdnGHz8SC2wpRUIO01ni4DIWPnuUeuex7Oi48K+nsYZNxLGV2b4NIlId6aGtHsXzyi/1in8Z9NNPEa/dIpRC467XbS2ypcIMMwaw1GvtWR3TTh8PeIzTI+DazzMjCM9AmqrAaSS4YgsYxkdZF/bxUEOk85WpH1CRxZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866120; c=relaxed/simple;
	bh=GfcRpO1nNjlIndlmrYJtFbdQpI7RbagPEw5xN9BKvXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2trDdJCKFdYNuGDq77Hx/K7TnGSZzIR7kBB4eyM/zGUdsIIGOY1LT/cQtASqdUurnRBy0MTFnTDqzug4HjvG4olty1H73wJ5s9819ZDgbxfKtdWxQCbCB/L36bjHBJ2ZrkPxOMdPW45yfAL+ot9H2FOPM9846QkLZ9yicXFJSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYVluIct; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759866118; x=1791402118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GfcRpO1nNjlIndlmrYJtFbdQpI7RbagPEw5xN9BKvXM=;
  b=BYVluIctlsX2NllEVe4T5hBr0R4reS922Mw4t3oJFrkK5DIaQlL8cIaa
   CBwcAy/ABHPdeLs4nzgqYdIMeHzaIccLXNXqs+SbGEba3f2UauxNlBB4r
   XM5KtS4jwB5WjwwpdOoxAnUC2m/gSGsrQUxxyyB9XYzeLRLCPAQsIejJC
   ITUaEe8x22J0PU3bHu5tp8nPR8MeDLOhn678tmYfwDe9Imc6FI3OanSWf
   ztRL+2u4wXAt8aWDX68KJO/XhD8lb0QHgzNqa6zcCDJ7LFv37WOSgEAf5
   oqJL1G3JGDxyiH6xL96QOBfRX3KI6hs4yyDsiPvnEmIyoD5vub79Z/455
   g==;
X-CSE-ConnectionGUID: dbL2J1MVQbierElw+gh/nA==
X-CSE-MsgGUID: FbVoKWHvRY2Sl0K25U4gPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="87526215"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="87526215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:41:58 -0700
X-CSE-ConnectionGUID: 9u57DNpZRV+uDWI2nqzcjA==
X-CSE-MsgGUID: YvJ+4v/pR1eUEnIvCC+ePw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="211189431"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:41:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:41:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 12:41:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 12:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpedttQO/DfpLRoN6Hnss+h3StGXxTN7zn4dE6tg+2xSH2rqHALC6Q/dFmMK1sZHxScDCh9cyZJ/g9lkyHNRcLVY+bviiBBn/vEqY+rw7t3zX9ixcsr9IFyGmjjlrYHMVjSISGLqh16cDmE7z/lvWs7hIBpv0feifJ5idDsfODnRM/uRXcv32dnjK/kwgouK40QILgB+xeSB+HRoZxFyhcxg2lSs7lwip3EjZC3bGZp1JEcsHBwgf0Zt5yQrC/F8oVXYV/YCNDDhFdUAxG0+veu8hyAVza38vPleaYkGGTYOG8vXbmVg0xQ5KQd3ZIeInyT0cguBC4UxetrnqNJLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z0xNz8G81NLSngLkOiPQ97eP7pEfqF0XjOupI0pfnc=;
 b=FWt2B/suQdBCMbidSLrEm/B7yzyLiQS2sKDV9ADJmoGUhUQOAAbmjtuZRTtp9FNVg2xk7fhpniidN7hOufKEfBlgx+sr2kRUxM7ecqexAsjbOorBaeZf7GC1vb0H3vDkymPX+it46d7JQ7u1SbZEYd+G2F7fkLVZfaHqVOsMC0XlMUr3k0gTHin0RwmRJ4SZgsg+qk83Zy7HF1DH675sZ6jZMy2Wu+dd8xPyp4x/LnK3IhwrtVElNs4i2h2sgR+kLZz8s0UkHWrDuY8p+lavtlBQ9x1HPle1URxHwwoaBSzOrpA1+KQ717Av14zdbQhEzV6VNvBrgEGH3AS6d8BTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Tue, 7 Oct 2025 19:41:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 19:41:52 +0000
Date: Tue, 7 Oct 2025 21:41:43 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
	<willemb@google.com>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
Subject: Re: [PATCH RFC net-next 1/5] net: add add indirect call wrapper in
 skb_release_head_state()
Message-ID: <aOVs9yvrwkH0dCDJ@boxer>
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-2-edumazet@google.com>
 <4e997355-1c76-429b-b67f-2c543fd0853a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e997355-1c76-429b-b67f-2c543fd0853a@intel.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a00138-7e40-4263-1fe8-08de05d99098
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kb1NxCsYQLQvm+g2go3DRH2Nd8VG2Qg0DP5cX8sGT8FX6j7/Qzcg4xQYGYE8?=
 =?us-ascii?Q?Qka40pKe7MYLl6aZKSnfQQ+Siy17LWmQWxkiH+oyYHiXu70lMz/cI088ykWr?=
 =?us-ascii?Q?j6XOnS4NFW8vpnxHSSkTGDepWje894c+pIruyA1X2aAW6uXLFg7fMf8g69Oq?=
 =?us-ascii?Q?KeabtI2FO0XWuPtooSxs2hbbWLIb2rdgWSyinf7satELMMrsa2dho5BWHaXZ?=
 =?us-ascii?Q?yZyNyT4mAWb4Kb6b47TKd5Q3wIsh64Rz2ygY6iwJQWsV+T+l2EQXN9lx8GDd?=
 =?us-ascii?Q?8vhn2bFtPq2Nq60NfRUkSZnwHW1TtBh/sWcmRETH0BxNNDOhajd5F8vKCcgN?=
 =?us-ascii?Q?CLqvRLYWJcuInu7pGf2wqQ7RGFT60L34y4vrJPcMm7LrypJ2N+0eaKeVG5g1?=
 =?us-ascii?Q?engKUUwmbnywg8lWjE3uCT9jht3as+57B3xv9iRPUjngF+z8VYS7a24wuKVQ?=
 =?us-ascii?Q?m0PWwtn0ZmkwLZodr71UqlzkzJfshDgzeVb86zMEFe5kunx+GM6agbfyGGsz?=
 =?us-ascii?Q?efZdNdvS0W9AMpV7Hmvv6P9egQcQUlCWO/upQ1mxUNVOoxhlWu8ukdSIvFZt?=
 =?us-ascii?Q?lip8AV/I/E8HqlEbIh1+eaiSfyI30Vo+EihAGYz4gP6Zy08kVA3xbaheQN2g?=
 =?us-ascii?Q?tsQ19FPs+EIlZdEV5alnK/M9xI8b6FaK+E6z+ACNjIzNCAhtDkAsaSBofL7A?=
 =?us-ascii?Q?KHDhRlRx7drp1TPFPAguKlf0c2QqffflPg2SlJiturxPwtxYZTeovlYj/UX4?=
 =?us-ascii?Q?6TGZ3SRTjW0tktCcUq+x2Yr5ijVbMnXaY/iQdDrmslAT5Itkpb9uX0QhhdrJ?=
 =?us-ascii?Q?xcwHD9WlHcWvCFf4/fYvkXtgPZ35QuDYgCjvHItfEVhBAvCNvQHLXqaMyR8B?=
 =?us-ascii?Q?zLyI+W2dMhy+ZkB/1usnMPTiMF3YJIVDPDl/8B846ZGJKiOerTXyrtaDurfU?=
 =?us-ascii?Q?gSgtbM3xlEykt2YSGzsFYztJgxvin2EJRyKJigumEkCEAs3s4C9YbEbVjWw6?=
 =?us-ascii?Q?KltV4pLpfs8ddUsCt58JmOMBX0iTUixYSWQZbAsdBubF3lsV49iRnBMOR3vw?=
 =?us-ascii?Q?oP0GIG82AFsAnbaATFQyWNcjg5wbw0X5vg2ildJm9slGZCbgAaVFG1dF8QXQ?=
 =?us-ascii?Q?hqYIvLwpA97t8cT1ZvtFfRQGRQ6sp006pPfXELZuGCSxC/ix8ggO2W6qoXuH?=
 =?us-ascii?Q?fTKBfxL+R0akDcG0zSY45sjOdK0GMr/4Ed/Fxmeesq/hHBqR4rnKBAATPcUh?=
 =?us-ascii?Q?KgVf9uKTSNzH6vyhSiZ6FQbGlvIXyi1NGgTgQWS3iLU/oFj1comXUyBm+uo7?=
 =?us-ascii?Q?Hx5GNrZmZJtloDqtJb2O/ejKTl8bcdt0rty8yH8VvfE4pyBexsKkpQr9CztA?=
 =?us-ascii?Q?5ytNgXt619T0kStwnKChkCE7AYZQknzMAzps4ShJW1MUXRxf1jmK/ESDkH0e?=
 =?us-ascii?Q?L0Z7nMxQ1Xt1yqZxcUFjqDJpcEyiC7xA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIyw1CrfQX9HQ7hHfIbTSi6wxyknqdhEqBIa+KROsGwCm6KTOPkIT21h3tKN?=
 =?us-ascii?Q?OGMnWbb7pshyW4qXKBpCDms2mG1cHl9G+1P+pA8jPu58yBQfYN9RBbK3cF4M?=
 =?us-ascii?Q?RYjKQi7lg7+WyC4uA7A5DjllCMMmPXjIq1MXli+2BME9mwn0Dtfj90t9m/NL?=
 =?us-ascii?Q?gkbELiAGrsUA/MZBmtkV5DVZ6zwQjOtktK0YQa3J+RnrXyVpTgH6GLk3Rj9B?=
 =?us-ascii?Q?xTPFzlBOdytJ5VWA8OCqZIFPZqCiddH2EuCw4ZO4ZU8Ledba6IrQi6lgbC8i?=
 =?us-ascii?Q?Lns5FnR3VuLDirm0e31sHoANnY7n+1ke0qDyusTrUwTApGLJBq4SQ1uj7lkW?=
 =?us-ascii?Q?nChZe8coWiIDkictOZxdH/hhA/IXKJ2LYvl4gT2f7u37HtWZHRHCXOqgmphi?=
 =?us-ascii?Q?2KJd2OJ7UOuTsA4t5QqeXrujl1R2NTtx0OZfVOGiJuVb0IC+sJV5b2FQjlsd?=
 =?us-ascii?Q?wPsp6D6bGQaIl9OME5fI+VlffjqWqmPiKqh8MpIiZrxQocT/0SzHVk1PlLwO?=
 =?us-ascii?Q?bA23mU3aXeIDXQoVKVvDUBdgfEZQ5HVpvtVTLfNUNk7HnMEogflqt6d/l4+Y?=
 =?us-ascii?Q?vugCK5+egYFHai4EnCeKI5BahZqd+SI0CoywFTNxh6aOjsiyejPUj7ew8Wb4?=
 =?us-ascii?Q?MaBdeqP4uNPNtMuCYC0G26/aPDgQMCWP0i75L8F6yqQ30pOHmMvze18rhKRD?=
 =?us-ascii?Q?mc5GzBmuFp1UqzZOBJfFbwHC4yneFlWOVJNZl2uWkc4d9v1UBtem1fH8I4kW?=
 =?us-ascii?Q?3wa1pstSdc/Vg1Mkx+yYarzXgaTDRLlj4djPogXdds4K+L2xk3P5sFQJgOj7?=
 =?us-ascii?Q?EgHD/8dex01ilH3+PuFw4qKsPIflIw7fx7Vs0NJqMmvbQKjTdkCVHf+jqr5A?=
 =?us-ascii?Q?RwHKNHEBF8uOcSQy/Rc6n6NiHOXd8TMIsWMZsEqvLs5PM3Ve6vaAs5b4Cri7?=
 =?us-ascii?Q?N8QDHYN2U7E8okIjNX3zHvLTWZp8Luz0S5ImlotiOowUxOzvwNVIBtGrsM9A?=
 =?us-ascii?Q?0DUCBhyUCvAT4QKnYmG5vGVWD8my4xxf2ROaQsJUaknCX0hkOWf88Iwkeiee?=
 =?us-ascii?Q?EFxLcILBxUFs1fBQpgzzZucAOAmPdNImA8oUZMFcj54r3W+YPJ8F4IfkTTAf?=
 =?us-ascii?Q?LUu2f6A+TuagFSszTo/EpQaJv/NALhNF3E9Sy7MhT1lR7n9MTk6xPsZbDnk/?=
 =?us-ascii?Q?0I/H8ZAS+8jPvwQBmLyu0fnefKW3RIztPSE0myStkEdtFVOpNv6vTmfhOXCr?=
 =?us-ascii?Q?6Cqa8tyM7YzWNgJriVHmntlm1XsjxkV+4e916rTQvV/HLtwbCNNalhpvGBHb?=
 =?us-ascii?Q?LXtwXbDa3JDgBBaJZnJNjDnHIWkjpTmU9D4jjwZdlNf6982H5w1iizVAy9y+?=
 =?us-ascii?Q?dy9quBbkpgXi/UQ5N9SSkyRZT2skL60R70uT4Nc9g+MP2bMyvGrG6xFow4o5?=
 =?us-ascii?Q?rbKAUpUbnrrIR+ZoAdHVHgHoBE2Hse//uGwdHS6Ghu/v5H3hV37DBPaLg6co?=
 =?us-ascii?Q?hQDUGGJfcMw3KB+E5EBZdVMq5cHBMNz09sOVIurFRU8w7ccMSyh7NvJa5gy8?=
 =?us-ascii?Q?2ggzeDQr3XNDupIWv1IE+RyoxE1LzJMSjXWTXwvUQh8QmxSu2KpENUXDLTbg?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a00138-7e40-4263-1fe8-08de05d99098
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:41:52.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjN8iJgYdfhu8lBRB0rnXAIJUMvN2HX5xGFaQx3OUdA7NwF8oPqzyvPrUBXhcPXA01MQmqvqOdtX91QxXQJE+bOFToUlRqHcI/TKWPG447w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com

On Tue, Oct 07, 2025 at 05:26:46PM +0200, Alexander Lobakin wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon,  6 Oct 2025 19:30:59 +0000
> 
> > While stress testing UDP senders on a host with expensive indirect
> > calls, I found cpus processing TX completions where showing
> > a very high cost (20%) in sock_wfree() due to
> > CONFIG_MITIGATION_RETPOLINE=y.
> > 
> > Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
> > 
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/skbuff.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..c9c06f9a8d6085f8d0907b412e050a60c835a6e8 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1136,7 +1136,9 @@ void skb_release_head_state(struct sk_buff *skb)
> >  	skb_dst_drop(skb);
> >  	if (skb->destructor) {
> >  		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> > -		skb->destructor(skb);
> > +		INDIRECT_CALL_3(skb->destructor,
> > +				tcp_wfree, __sock_wfree, sock_wfree,
> > +				skb);
> 
> Not sure, but maybe we could add generic XSk skb destructor here as
> well? Or it's not that important as generic XSk is not the best way to
> use XDP sockets?
> 
> Maciej, what do you think?

I would appreciate it as there has been various attempts to optmize xsk
generic xmit path.

> 
> >  	}
> >  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
> >  	nf_conntrack_put(skb_nfct(skb));
> 
> Thanks,
> Olek

