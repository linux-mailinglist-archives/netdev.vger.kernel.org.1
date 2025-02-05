Return-Path: <netdev+bounces-163272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B4A29C11
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6EC165298
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD361DE4D3;
	Wed,  5 Feb 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIY5kNeC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BF215179;
	Wed,  5 Feb 2025 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791966; cv=fail; b=WR5i6JyNtv/pHdb56JQTMH3PCtFzWhcoV8KwFic+axlovsi19g8TI591wmUl6wJ1JJmKHwLIE0jUUNOcmu8t0vf0LdDEAC9cvSAGCls1UMaUCx+XyFFFNInnUeK+Ws3sC+Jsfv7z90KdL3f/pQujeJcO+g9tTgsIcUmqWYBDcog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791966; c=relaxed/simple;
	bh=yXGEAmxsoxLr8G0Ml2Vac1KhWbfFBQZKSxfg/BXVwvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPBKuLN3G29QtrR0WYYkoxjB3ZSYxN6MAm3egyPbMf14cop9QNhfTbOoTXNeCXFehexYCMLyETtyBVvhJcr73gy+2O45qYcjVtJSIkQ3CBVYtu/LLxK4CZpbjea16MR9L6TGXDMHQsGhbluWjDjMSVhRhM42X4euIB+O69X3uKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIY5kNeC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738791962; x=1770327962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yXGEAmxsoxLr8G0Ml2Vac1KhWbfFBQZKSxfg/BXVwvo=;
  b=GIY5kNeCAmMnrZFjv9tYec6kNcn8kmZVkzjhEEQgTNcS9OoYF43EwEaN
   P/PM+reBPk1TMVEXWrk1yfL6DyXcvXgBftIWu/Gd/T55+pbUL2tR2dwqu
   CsuO1WU+EB0vyobfKcqcY2hz7vryqyILEc/AEXvlYzlcBstnlB32cany+
   OaJ+ZV3YiEAhPmghUle4BbY0B8dHr4Q7ZGTIjcNFkGt8GzgVV4RiSHtRk
   bWsRDWZOpKOla2h2T0FBUML8pAwKYZQE5oWcrFfCh93KqynWwZU3DkjyN
   UY0CvkueUJeGgjQMgavYf41EGERhklmuldDvwMX3B1+zZP5E07YTMK12J
   Q==;
X-CSE-ConnectionGUID: OkAmfFsUTEaH0I9BztEdCA==
X-CSE-MsgGUID: XJCGNNdwQ5eZIAvJzm7xkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38581322"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="38581322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:46:01 -0800
X-CSE-ConnectionGUID: JwMvj+VaR8SEqZRURvzpmg==
X-CSE-MsgGUID: VB8p7QEoS9WDa4lO7BxZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116216347"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 13:46:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 13:45:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 13:45:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 13:45:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1LtrmUh4PodpsikRFRU8LuXU6Ibq4e+KTgEkDv3uP+iIcRd7jLFSozzfiYaFVFfwIfdjYSr7A28p/DSQl7gFqInvdUycPROra4f0P8D9rSix84iulJnVZVmxBQIS8MNB9ulgXqjctXPBkOasaXLSl035xSkYNGSC+RwrUQIjzav8fn1xr0HPwLfVuvETEY4RTbs7JKlDX4AAqzKzksoIt0vs9WlzwXgNTGT28sIZrb1zL2iuRB78XW2+Xq7XgLIMOmcfr2uVBWph/hGASuhVUaue7XQh85oUGuhKWojS/hFe6SP3a4/lTUp0g8sr4XwN05HLyOXSGpNmm6QiApfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwjR/VRv01LaPmeBQ+gW4yaq/YlYxdv7E2qwSVJ81kc=;
 b=NnAOIqaTR0cyj/VUyrMcdUb8UUZ1dWnF5FIlKkRwmOoQfz4qKokTVNiPw2EdFwXq2VWqopK9jeSXLyvRTnU8CojBq+XpESWnXTdj2fqr6Ovjdt7V7FJJvp7ng9wUDLlcsrsw/4yht/UtHncPsFZkqZoyUxMCC7BatZNflukWMzQcEK86eXRZ4YItpvDOlx2AJl6PfY/Zn5aKiGuW8sNeVc8ZpqXA3+uxj7HWad7zTqXGtoSnOtTOXeOIjhMMtvetGcjMzEo6DE2XYxH/qS2rpvk5WunLg5e9ehu5DW6EXVfjqfAoVZwMDA31K6DdtgRvXoVQSUfNUFbcI1KCkElOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:45:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 21:45:41 +0000
Date: Wed, 5 Feb 2025 15:45:36 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 09/26] cxl: support device identification without
 mailbox
Message-ID: <67a3dc0071693_2ee275294fc@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-10-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-10-alucerop@amd.com>
X-ClientProxiedBy: MW2PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:302:1::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 888d4a57-0870-4bf5-a279-08dd462e6f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hD/4VouTg6EEl50BbNwgqUVipB5sQODl0r+BHmW46ksS2xfJ7qgfe7yJax3C?=
 =?us-ascii?Q?0bHZDvfoSRoJopN3+AziEtVFg+8QbTPbcScXQyVSnxbndDjkzJeMYHxjh7mT?=
 =?us-ascii?Q?cvK/zvT4ENINED5Gu9uI58lfroq82iY4kbFfsuOn5mbfjXqqKdmAmr0IXMbD?=
 =?us-ascii?Q?Wf99wRzlRooDmm065/Q+41bVUrJSX/Tc++joihuVJJaigHdPuk/YQgcEHdsW?=
 =?us-ascii?Q?J+FGQpiXFCjIo20xIkW0+hxSOELUBR/JYQU9d8TGl46RUk5DK/Xos1D20R30?=
 =?us-ascii?Q?8AJSGrpbva/ytVwDge16aeqye3kH3MY4OrmPGuwC9MHP94k86H+x7LE3tlaT?=
 =?us-ascii?Q?kMRkfg1E1LH7I9PhmAX7rPRayTmpQS2DsFsOLrVY7loKMg+ayUvT2HmaSFqu?=
 =?us-ascii?Q?IXK/Omh0bpfjHqzNzpT6/PLwAuf5Pav7cH9+QWOjVRuYM0ULk0DsLBIQg+lF?=
 =?us-ascii?Q?18APDBz0YVgyCQJojulhLfMBjxVj0HOn9rTeEBXGmgXgPPmxxaZ/Su2S4qhE?=
 =?us-ascii?Q?aGWu8wQ+Ns2IN37bg/j09GRrjvrLX5ZL5WXII9DrMijAyTd84revu/FLaOFw?=
 =?us-ascii?Q?F19ke/CiKy6gxJjto9mvls0GqgAmurQ5C8HnY2YBQ0lH8j9AO4lQ+PrtpSch?=
 =?us-ascii?Q?PviLQSa3hDfBnjuf6uBt+/GmsvUU56394n9Mhj6QqDJwU/IjCcTJnCd9CyoJ?=
 =?us-ascii?Q?s0VV2o2mufMqh19ONVe+bpxIVtQFyv+AMBsq0pbULa1TkJqLSBFYZ4W2A3Wr?=
 =?us-ascii?Q?DTQRNDYWnJMzCQcBNs8rjayubOEuhG5kbf/7Y71M1Bx5Wl2z0wF4WaaeE9ux?=
 =?us-ascii?Q?XMPmgEA+uvC0WEjXSePXSEvbKzhB0NPEwv4DGI3R/eleYjhqQGuPwiFpdlBz?=
 =?us-ascii?Q?BfHTxhYaso+h1rdwZbAWlzFsDSeYivTU7yGli6mU3gOx/78SUz1tAUZJuNIo?=
 =?us-ascii?Q?Od8AJkJe6rRsKlpkGgSe3KWqXn6Ki7YlBHYNDgaEiVkcilLPnoBjN5oOn5Ja?=
 =?us-ascii?Q?5kH2fIr14GoeqqMBP4678if55aNmNZ4EF+59xHru9Lu3XcwiKRE5eHu3Srkv?=
 =?us-ascii?Q?D8vZXMEFHJGX3l/gXS6tkG+MR41CL656MNaOR9+qCAlvjj9vjOqaOdmNDBl2?=
 =?us-ascii?Q?V9VcgO+UStkGL9b8o2ivqodazuvwhYDibT+sYadsT39VwfVXLmfaZ/Eazgr1?=
 =?us-ascii?Q?d0Y6ht2ypIJ5d4knmTtYU4JiSwnxHziLTsPbu1THbbpF9nz89asWBRHgUFb7?=
 =?us-ascii?Q?0TcltdlLtiOreCc9AgfvQxhCPQCnXyXrOT0VHwTj2p+ia9qOVnGjX/kPaIWe?=
 =?us-ascii?Q?0lrtq+PqiNnuv23BryrhqvckffqzXf2KzWA2WvKFB1uLqiFYOFTABPI5qfms?=
 =?us-ascii?Q?d+oojiYGZSmIm9fZVvYX2znA/87/Hs70w1NcvaH45h8LKYryOgjhzERzuLTX?=
 =?us-ascii?Q?6MNBwkCRTIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6w5CxY9eNcQ36JkPVMM5/K72jvKCGzW3omOutqJQFk75kHIKNIYjz55mIoSP?=
 =?us-ascii?Q?KxTtZIONGqbYwDb/dOw+bJIiCfZ9as1W8dLj/LkLMW8s21b33JK2o62iNYse?=
 =?us-ascii?Q?3zHThFO3S54+qk4FKtE4KHMiaGSWQfEDVC3NVYgk1pW2EbJHJgUMcXnsw1d5?=
 =?us-ascii?Q?ga2rxEEY1qAw1YxH654e7mo+VJj5/LGZn3m7gk6LJ5tJKBD2cUkbeRY2tXLV?=
 =?us-ascii?Q?PFzBCfgHTrgboi241dxv4tqUAc350Nwokgs9VjH/PFp5KXtN/K15pP5QZ1xD?=
 =?us-ascii?Q?5ACxcOpcB4u1yzLds98/i6JiRr/y4/vzHIPlYLjpvYc7catF0jkaeOGnWs2p?=
 =?us-ascii?Q?UiLePWeC+ksoAuOe2N7SXEYyRy9zRnmS9J2BXlbMWMAriyv9mBDTLxiWH9ll?=
 =?us-ascii?Q?yV5rBAdMjeDnfjIr92+HB1vVBo0HlvHkklFM3W6YsnZafrpEuRhgdJ3cDrNL?=
 =?us-ascii?Q?QcW5TLn6xdvU4RZzPgZOZHyHlXWbeOSgSWTjXsl8x81V902zjvpmzxXZkKHK?=
 =?us-ascii?Q?rVPOTpPCgqgt7Eit9lhbiROGz2q3+esRPvhUfbDPr9rDaRusnTQndE97HFit?=
 =?us-ascii?Q?cpxzrE2AQV8uHvQEGwX/at4hwrsXZIOzwVTmW01hCN4P1F47+2M2C58y5lXq?=
 =?us-ascii?Q?YGFhiNWH8VAFwojEJqhK3OiMzIYr0xRY1aUioYMbtizaDNDFUzXcELG4dl5A?=
 =?us-ascii?Q?Qy/TiGcYq+xlipTGFpv++x7nry8emGR/9qFPTL7+zV806527Tr5VVhBSlzXt?=
 =?us-ascii?Q?l2ln56kDytSCIRlGGgLncNkgVDRlJU62jMaR3IEFQhMWo2LeSND94G++s2CF?=
 =?us-ascii?Q?9/0mrptJoMefDRxaFx0Z+aCU5MtDoRs7LWF5dvj879kw0EsB7HJYMs3yW1+9?=
 =?us-ascii?Q?udjhCX7vYmLltjuNs8MUz+xM9kpzvW5unb2BgHzu6eZFMM7ruRnsQtDJHuAS?=
 =?us-ascii?Q?5mA335fyzx/ZbmtXUyHfHSY4s0jjA3dBSz+FuTrLS1WbeIT8NTYUtxwlfhcL?=
 =?us-ascii?Q?/zEdDOJPHPC0F6jDkxoTXk5/AWniTpygmKymHCOXrGj/Kyy41riAGidjT3r0?=
 =?us-ascii?Q?nNtxiRI0wuUmTAFzQv71dzByyqB4ryzxIJOoOV/mr/6F0NeytB9JfU9hTz+g?=
 =?us-ascii?Q?Jtm8/1HT1OTGd/h3pl8Jsu9jGpWFKln+9hb/ItzpfIWb1W4CV5VNoMXtCrrc?=
 =?us-ascii?Q?hREIQsrrG2fPsESKGWYCbi98ssormhDJY8m73S1U/d7wDPGVwiZv7FEjFKLu?=
 =?us-ascii?Q?YunrJPaGtDfdSIPe+qfJZu5yAj2LbL5SoBeeeFN5LlDRlnDeLQiYWzTUcgfF?=
 =?us-ascii?Q?0WGG2+ouqvGpAoti+fnhZsICNXpi14zabOwqCDxsQlwD8KXfap64rPI0zP8Q?=
 =?us-ascii?Q?Qp9PdJWE7Sd5HvbkhlV7DE+eZN7SEUAuIC+qzJR0R1ZUDhgjnfwVf5wxET1D?=
 =?us-ascii?Q?5DHj/4wqcSOlqLWb+Xarw+8aIwvgV8uqllxCsGgXY4t9xWInm4n/eZudteWn?=
 =?us-ascii?Q?2guf3tcxIY3RRZkiSumHZEjXH8FOWQy0PEzqN5RTSyUUOK+3dYiimkZfMOcD?=
 =?us-ascii?Q?AuQCZG42HozgUaQOMTLRiFznJ0SHcAS4IM/pgx/U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 888d4a57-0870-4bf5-a279-08dd462e6f98
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:45:41.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmXhxQTRavRmuM6Q+nOjwMwN32LSkg5HmfPMGfC8Ma/E6FRRY+i1gLba/m3H+nqvvnUnwcqwdXZ6uSrotH8Jfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params.
> 
> Allow a Type2 driver to initialize same params using an info struct and
> assume partition alignment not required by now.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

This is exactly the type of thing I was hoping to avoid by removing these
members from the mds.  There is no reason you should have to fake these
values within an mds just to create partitions in the device state.

Still wrapping my head around the entire series though...

Ira

> ---
>  drivers/cxl/core/memdev.c | 12 ++++++++++++
>  include/cxl/cxl.h         | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 456d505f1bc8..7113a51b3a93 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -655,6 +655,18 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
>  
> +void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info)
> +{
> +	if (!mds->cxlds.media_ready)
> +		return;
> +
> +	mds->total_bytes = info->total_bytes;
> +	mds->volatile_only_bytes = info->volatile_only_bytes;
> +	mds->persistent_only_bytes = info->persistent_only_bytes;
> +	mds->partition_align_bytes = 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_state_setup, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 955e58103df6..1b2224ee1d5b 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -39,6 +39,16 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> +/*
> + * struct for an accel driver giving partition data when Type2 device without a
> + * mailbox.
> + */
> +struct mds_info {
> +	u64 total_bytes;
> +	u64 volatile_only_bytes;
> +	u64 persistent_only_bytes;
> +};
> +
>  struct device;
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  					   u16 dvsec, enum cxl_devtype type);
> @@ -48,4 +58,5 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlm
>  			     unsigned long *caps);
>  int cxl_await_media_ready(struct cxl_memdev_state *mds);
>  void cxl_set_media_ready(struct cxl_memdev_state *mds);
> +void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info);
>  #endif
> -- 
> 2.17.1
> 
> 



