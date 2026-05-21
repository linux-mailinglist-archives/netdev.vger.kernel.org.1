Return-Path: <netdev+bounces-290375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DE5Hxf1Dmq+DgYAu9opvQ
	(envelope-from <netdev+bounces-290375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013255A4816
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC97D302BE0E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D337BE62;
	Thu, 21 May 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzf59+7X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B033554F;
	Thu, 21 May 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365006; cv=fail; b=ZqCTThkesULwlVeDwKmSiFtyS6IpToxG9yfFEs29Ac80SXZMkPTyXfN3Lye7G/4wQ/DA/BXQr5Ok1mVaLIEh2P2tkABNh222Z7O0o7YVwH3RCBz+WWVXMIzbFpZzKvZeyaLHgMY2y32TzinglASETCK6Tu+QQZsImSJJtCZBjps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365006; c=relaxed/simple;
	bh=aw4X7Fzym/W/tvrPE4w/jSI2b5Y0Up9PmayF1uR2ZP0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bvtphiuTuCRfyio8793S0sEShuKrqMl6K3dnwW00cX85Xnf7kRU2sRcud9kJ5LPU0zthno8UBJqi6vSJBnbDjmRU3ufm0DqTRAVzeqGGkCV1PY0KlNMIFEoy70Y+S8NvqdXelUhlXV3lzgl2CVckHmo5hHGlsqjRXrXbKzOg5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzf59+7X; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779365004; x=1810901004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aw4X7Fzym/W/tvrPE4w/jSI2b5Y0Up9PmayF1uR2ZP0=;
  b=bzf59+7XdtvLeQyjC7IgYhkZbmygvxumuMxpRPp4MPt57HfWENCgt63h
   YBIukIiY0n9E0TUntx8sDHmtgSwvtHzbfu4CXaS/0JHy/NDvZbXZ7joVI
   BNwgwOnFWUdmY62ztXHp3H/BG2BK6cqroNPrbiSkgH5XgEupXNM2Oa10q
   yNbt/TlOjFP6c/MSmnZuXVt7YTUlQHvuIkoWsNALunFWrFBC3pivBj9Fn
   lQIXAJODA3gKzQ65jnEWfLZilk12PNznZ9MOnEd7ljQ48SWJVl0LsJk6B
   CMA+R7cwr6npr8k2Q4Qbmnri/otBIo7LsHI2KBXxMXzPfvTPoxTgtWRt3
   Q==;
X-CSE-ConnectionGUID: DMcN5FKRTfKzYKjNNg98Qw==
X-CSE-MsgGUID: DqNA5YmERkSEcBDzrxCIFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="105742594"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="105742594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:03:24 -0700
X-CSE-ConnectionGUID: 2HIcTdqqR+mrIKXpFOXY9A==
X-CSE-MsgGUID: rMsLCoHhSIeZUAncCbA6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="239657297"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:03:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:03:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:03:23 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bpp2yUNM4/kwoiOpTuOAwDZvJ7fBuWUD/TTaZ9KsMde7NmC73mNB1XqgVaPfU8PlVHq330Z3971W5sWx/uJXceLQ2LfPmiTa9XwSBnAtvD4+fsJgkriKO3wQe2bL6fOL/cdUqpabPci5meGpxlwveZPSOu4ubCaPsqycL/gXt5RgEcX1RZfA4OWtm792GrlN/93qbteuyeBw14dywAI8W5tVOUTcejLf/GqVihhyGNu4IBwHlsxr18J/zj1odpYuFsI6h/CJmnWY39a50HSfA0uKivKScdw9d0O37DxTcC4gbLmsQwEnGUyqCFQMU7krkTxNP7jHQtSi7S48+l89vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vI6dEVcdLugbEjrkNWonXhnq6VMTQo/5Jbowz9ArWs=;
 b=bmF+/JYLMBMJG6pWhbWVG6cai0FwHtnqnl9eMb0q9ikBpUfKxqjCxVC/quzgzoZPQZfTG8CcnDs72bTd/x5vHZbozv+a3zcewWhaqTz55wcaCSyRSnlrpBrvOoiG5+Ix4dqmamAZstyzAlBaOvdVLBCboVRMfXRRMDjES/MDe0WcGHbMzToDb035zyiMOnN+ImCWBCRSQ7zPQXnmgTIX0EuPW0vtawBhXFQ5JGkXT5hR2zZGPrJyFlmldudU/Hi5Wj1QxhUvYhf3XquPBnE/XlZSBMIl5yeXbtuYFzgMuhYQqTQlFadStTT78OmAtcYiKCT8p1WPRb5Y0901Lv2G+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 12:03:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:03:16 +0000
Date: Thu, 21 May 2026 14:03:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 2/5] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Message-ID: <ag70fei+zF5WAHZs@boxer>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
 <20260517063311.28921-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260517063311.28921-3-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VE1PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:803:104::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e49c74e-ce01-4e9e-a2ef-08deb730f119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 44xjUlhWaoESaKkYpgv+DjIyRLC7sf24fJ4+PDwkkiDoNRfnI0pVJZu8hQeLL5K9IjxQ6pm06YazoBzZNZcl+Ask7FpCP9wtg+5/dZ8DwyLmEExUmIhkjNt1/pQMcUB36aeozO9rxRiHzaEE1+luFhJXnu5dqsTreVHAlPdpbZ4bYN4ptEqzPfxR5UcSx2FyQtuCW3ssN+Vh3W7K9x4NcmfY2XwDPwtnxJQKKw+X1NnakCvBu5re0x4cPsp+cib5DMfT55ajCKoZpQj5Q44KkAyi0iaVujTqXjHYIWPHNri1E7q3iy4E2bJic1gj7SenGk3fh/nEqAWxMwT7CYkjT5d675n1joecSKY6R0+/mGfFskrbk4rLtY8c3GdEm1bqxdK+GWnVGfbtq+50glHIp2prNUj6QVD7TMMZGiZjbHEqnd7RoIlfnPOelh3inxvGqI0EAZc7Rrh8LGXOqKAA9L+jVFT1WFm8oubNZuA4tmOOh3fh7YTWQNNK+rfi48Dtq5RhRurtIj8kqXagFgwTGfF+GrxPVe2qs4usZaFHIbzs1w1svla8INbYscyL2b7PD6rn1V5O340t53Fg43gp3QB8o98aHACDSJG6Jsm5P/2x1dILXL3g5XQeL2QMapcG1Q392jisuLm6t1e1TVv0Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhMcV/irzM6GO5ohY3zm8pMeIT08ecmWtkoOI2+BmrLvVGLqCNrybNBdECgU?=
 =?us-ascii?Q?eAwY+c0bsyiheJ7J5qbBsojso1bDeBQHJLEqsOq98rUl0wgaQkWY91Sa5A37?=
 =?us-ascii?Q?f9xUTutFSbV/QPMLBRlcMvs20h8scYDVMX5OznrqgH5FfI3/kPtin3VtZABM?=
 =?us-ascii?Q?9bUIG2X38NFhlOZ1FmNcKu1Qw8Ya2lnwMY23JqxRLWK9qofe/++nkOn0rUnW?=
 =?us-ascii?Q?yXcNGJkeiX3i+C4PUfRwfT1amsGJcYSXiYQuwPdXKm9+639j+/bfSzDKcH4L?=
 =?us-ascii?Q?Kf2yTH/dAACpiyiyhvXNcxR7/XS3OaIzMnAwaHyfJ21PKfO217qnsEKHbBiH?=
 =?us-ascii?Q?4Wen9l4iRRLzZaaeiyfWNUIPA6KvktOPlXW15i8PMYT5pA4daHyxK0ebBp23?=
 =?us-ascii?Q?xS/AIoBTonvaFOXoUnXv1kKU1PhQ/RTOF4BLUVA5XDQWTj2EyfSsykoxd8QA?=
 =?us-ascii?Q?Rj2gkuVv5ZpAl1GgSD3VBw2eN/tM8TuEyFDKCNeVkHSUx+XESelvU4d2Adlt?=
 =?us-ascii?Q?1fXvsSz++Cw8yW27pIGOyLAjuK9jeYK7NqIeKEdsNIZDPjysjvPAksx4x7Gi?=
 =?us-ascii?Q?/MH8Tmw+yQNMjLdFIfawioCbwG3MkAk8UykWrI2d3Ehx1tYWvojnmJUVh+Kh?=
 =?us-ascii?Q?6CL9aGClHfnem41cAA+787DiGNPQkXB6iS+55BVhnBvYs2q8fFGSZ6mnRApt?=
 =?us-ascii?Q?nc77ngGvVRGQzS2jwtpdUV6s/RRDIhMaHzzLTodHB2kkkKpR8Dc4LW87TmmC?=
 =?us-ascii?Q?8Hi1ULCW+iPtmmIoKlRgPcXfq/MWTQevpX/wtoTSFdGD4Aw92I/LdWmKvce1?=
 =?us-ascii?Q?7t4qH7tsEx6PdMdPmXFq28wkOHdH16A5sEkUawzdVB16Nne6Oc6wk+tvfe5D?=
 =?us-ascii?Q?jyxB7wsrlzPCWpSS5SNJvz9SXGLwqG+OiWsqUU/4CVDVAgY+LZsWwk1EGudj?=
 =?us-ascii?Q?0slnlEyCOsLDD7Y9FsWEvt6I/QD9zn7n6hOmKOQ4GKSyxnp3A6kNAn50C2Wz?=
 =?us-ascii?Q?0AV3hVoiGy2KBTW8Laie9ehm+qz515iXmJM0Sh0bgN5FtD3kuiRQj7HQNMMm?=
 =?us-ascii?Q?FMOmrs3ettqa2KgmeAVWf5FYghx3SE3pVNJroQJLiXAN6EGqDXVGtFSuajUM?=
 =?us-ascii?Q?1NkY6DUhNQy2PisnNUJSkSw3gsL+Ld1s+u7J5XxA+DUd+mZudX1H5a6qw/nR?=
 =?us-ascii?Q?36foRxB9VdXnGuTfq6sEb7N/wJcnTrsoa0eGdatYKkd8l2WQKKWs0NjOZyGx?=
 =?us-ascii?Q?pTL0fyZAicydVpfKxo/8YtMpWJBhJTvnOCGhhjHbs17piuF4u/j/UUjB41UW?=
 =?us-ascii?Q?SYGq8IaJuXIKOXuGzF9/DO9aFI5BLmwkfcL89rlcfehsVEacKqNI3u8MKEio?=
 =?us-ascii?Q?iUr/LDv2Zjv0gdM5gzWzCAXXnxeH+AN9221rc7fmgVPMCb29WQDbKNiBTxUr?=
 =?us-ascii?Q?CzkiuUrnCyLpq1le8SpMXeogjUGqVCII1K+cPfqebwvB6T//zoA0XVKwrMgk?=
 =?us-ascii?Q?0ya0tn61baHQxz/6wjN0rjFnSfOHLroT7+Rt6UVRoWjqZ2fKYSC4ZbezCOAw?=
 =?us-ascii?Q?8J9ecwiGclIq3e+b1L3oTp58Wjz4ioQcu+6e5qM8QNRwy2o6UFvnUM41sWqH?=
 =?us-ascii?Q?z0AW4CJGpaooQjeUFyWOmMogJ2a3W9ZpmSvJ3yXu3JIh0VjIHfdgCXmSnXIc?=
 =?us-ascii?Q?ZmgYwRETfhg/yTaheHPrSS8dtVR6QsMhBNZq3SLiAEtqkB8veR9X9aPL84xB?=
 =?us-ascii?Q?Wo2cjTbQab3F2/WbEMLh2G316as+Lts=3D?=
X-Exchange-RoutingPolicyChecked: PfGCf6rD43jlp8rMbcn3P2P4gh0xQYn2SrhYQ3fu0mL1+A7+xUvxhgStM7k3bwBQKGFl8b0CROUdjcl6q/ShbnnkqfrkGrr3Oge/gfFgDZ6tM+LVqVXl0ls10h+lgt5Es9J8DPJu2J48WbvOBRMrMbYArszIi2kqF1r/sCMls3kB+p8KPmVh3pGtKDIynVpjaBRPQx1QeUr8DU4KcrqjTfd4Qmkn4eDLIO8enzxEBLAzUEI84wPpsPi7f5498+g4itovoswEBgCtfmBJp3dmdNiZ8xkLqnQ9KNRcTwiyAaMG8kooRsiFXhLXFSS5vQSBhLFQbJ5XM+nXFHPGZ8GTAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e49c74e-ce01-4e9e-a2ef-08deb730f119
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:03:16.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id3QEiwgJi/Ud0bxWIKkMIyKBZYHQ/koHdF+E1Aa3KaAceASo6zItXm7H8NHMcVGAdGJ+bmHSYLL12+Q0LQB9wb0njcqZa+ap1SA8FRJKl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290375-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 013255A4816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 02:33:08PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch is inspired by the check[1] from sashiko. It says when
> overflow happens, the address of cq to be published is invalid.
> Actually the severer thing is the whole process of publishing the
> address of cq in this particular case is not right: it should truely
> publish the address and advance the cached_prod in cq as long as it
> reads descriptors from txq.
> 
> The following is the full analysis.
> xsk_drop_skb() is called in three places, which all discard a partially
> built multi-buffer skb:
> 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
>    the TX ring prevents the partial packet from completing
> 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> 
> In all three cases, the TX descriptors for the already-processed frags
> have been consumed from the TX ring (xskq_cons_release), and CQ slots
> have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> the buffer addresses never appear in the completion queue, userspace
> permanently loses track of these buffers.
> 
> Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> destructor, which already submits buffer addresses to the CQ via
> xsk_cq_submit_addr_locked().
> 
> Note that cancelling the descriptors back to the TX ring (via
> xskq_cons_cancel_n) is not a appropriate option because an oversized
> packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> which is an obviously deadlock bug in the TX path.
> 
> Also move the desc->addr assignment in xsk_build_skb() above the
> overflow check so that the current descriptor's address is recorded
> before a potential -EOVERFLOW jump to free_err, consistent with the
> zerocopy path in xsk_build_skb_zerocopy().
> 
> [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f8c8a8c9dfba..0a6203c42576 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -793,8 +793,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
>  
>  static void xsk_drop_skb(struct sk_buff *skb)
>  {
> -	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
> -	xsk_consume_skb(skb);
> +	struct xdp_sock *xs = xdp_sk(skb->sk);
> +
> +	xs->tx->invalid_descs += xsk_get_num_desc(skb);
> +	consume_skb(skb);
> +	xs->skb = NULL;
>  }
>  
>  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> @@ -876,7 +879,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(-ENOMEM);
>  
>  		/* in case of -EOVERFLOW that could happen below,
> -		 * xsk_consume_skb() will release this node as whole skb
> +		 * xsk_drop_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
>  		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> @@ -968,6 +971,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
>  				err = -EOVERFLOW;
>  				goto free_err;
> @@ -985,8 +990,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> -
> -			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
>  		}
>  	}
>  
> -- 
> 2.43.7
> 

