Return-Path: <netdev+bounces-267354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI+kMIzZs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:31:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63C28088C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 287C730074DE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD22D0606;
	Fri, 13 Mar 2026 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbLzMc62"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C029B77C;
	Fri, 13 Mar 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394311; cv=fail; b=KWy9I+kd1AfuMqQMnlH+nGcCc/4j+n8ZCboN+/yPZM6Z2wVy4Hgl7naiErpVFoWvaZ03Dgjl9OkQkLWIFV/OvnZnghiV0/FFnxwZpmB8xFatciQcs58LVhQ0IDpRZXgAyzAEdm+NXYh1SaYJonQCutaMWtuvzj55dHaBpO6RRo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394311; c=relaxed/simple;
	bh=/jq0WuSqcWZKUJLwOJg3gfS2AdxlEdAOI1e1mZ/SYj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TnBbZTTrc2xH7M61eK7yYw3Wn4+cLNzTabCsm6vC4EeXjV7Tb14cyasPovfge/chG2DBvh3sojCZGf7HnOzE7nzIOkF185vG+GJAHf5I0p3clru+FoopxUGqUFh/c8PRUwEk+5bRHnMW0slTPzuEILqQIIeftUXJsHDjlcJ9wL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbLzMc62; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394310; x=1804930310;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/jq0WuSqcWZKUJLwOJg3gfS2AdxlEdAOI1e1mZ/SYj8=;
  b=GbLzMc624XQwratj2H4II6elVsbeBq7UXM2Zan3YI3tKoFQzLEOoOL6h
   3uxVwCW8VOU1yAidSJsLc4mJ0Chl9xe4R4VI2Q+oW/cilRZ/1fU8nUMCu
   B8VqEt2PClRVnf6dUb+yX/PBSXojudz13t0ciDpwyFo+OBhCCMcnywqVQ
   tPtdo8dp4hry5yBUhusr5yQVlwX5T0ZKoHdZc9sF2oEdOBOg0YAHWBAwc
   sB3esbVRmho7TPrihtcgaXCjHVcMREYEqtF3gdtIEkuQ4qmQR/xrFyk1K
   L0pbUR6t+olVo8BKTmUD24mlWCr9D6s61F9PuxK3PFC03A4jdY4V3cglO
   Q==;
X-CSE-ConnectionGUID: iIS4+PwyTI2QEypQrbtXKw==
X-CSE-MsgGUID: 6WKiZAJIQXGd3JiEKdjqtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74538078"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74538078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:31:50 -0700
X-CSE-ConnectionGUID: VYbbYZ3YQoKSx66xXNoyOw==
X-CSE-MsgGUID: 5718/CLyRK+/7woDKgJ9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="246319190"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:31:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 02:31:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 02:31:48 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 02:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/7NVplskp6+d3iAIlN5ik/3HrhVunTwGHKz6XzdWVpTvzKZ5Aug5eSg1YYBSND+ZgChzUAhUKOGi9uEep4uC/hcrAfNIhpk6LecF2vaHXc8gkWhJEPQdNPmw6JeH4J4K2S3vMCx18v6tuwbG7EuTH6WAsnIp8Tc7MhSYsIBVu7SpD9qeqhea14T6Dt0MxyaCbuQ579smeUp3wjh6eLZ+TRjy580A80WSzzpTokvVyQxl+fhQA55D/Bo2wuRRUU/GErzRRV+jsj5a2ASngQvA+5FCqOE1jK20Shmg1Ew3L0ZbKIznh5cJW7MkIl8aoqFjTucEFCyL84EjKoyygneZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGK7lV/RI77FE3FstgfXHq7M/TNDwEyhxZVsQ0jx7vw=;
 b=lyFfgIksTeskY8P9ww/i6Xi6dSMtulARSFBj5XEGE/Fkt4n+M+STa3TwOVn0u9FHTt09j0ZyOKiB+MedpwZKmOBdBa/XwzVGmkZUhgxCJCoF/N52Hxk6sJMkdntIbloseMVBedKctwIFksHttgiNnm0rzySjRmrTFQpsq+Me4qSw2NI/m1ye6fF7i/AgA0WQ2FHdlwQ37aolVQVSYM0Wz/GvTEZVxbMsdsNNpqv3lkFeDLh/VwJbBnwhIBnW9ze5uKc07VOPk2Yuf4fB8ZK1rhDbabVRAgg7nSgC2aq6NKwPexH5ozRqk6q5T1FzxvC8lKPpuabQwb8/k2ZSVNgaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 09:31:15 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 09:31:15 +0000
Date: Fri, 13 Mar 2026 10:31:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <abPZXXt/xCis3tIg@boxer>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
 <abCUMtO8Trtzs23d@mini-arch>
 <20260312173348.4e70cdec@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312173348.4e70cdec@kernel.org>
X-ClientProxiedBy: VI1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:803:1::36) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6316ced7-b348-47ca-ca86-08de80e34601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KO1wwDQlBv/Z3ldgc2muywpA8GEOV6D3uRsM1rNchgaJCEbvoR9eV5goCC5QMM0OsbPiDZhMde9ee1MU0ZDy0ZRyB+kGYUCPhZtFJGLXZVS8cNvgIJkZj27DFxJ+RfCKAk+OVNgOQqJnDZlzj8LNYB1rYgydrXBMGzIL0YSRWEUMJ9dbpsePCHZ3jhevOzMZw1ad1MbFYGH1XJhM4iF2FdalmGY5OXNFkBmU0ux3JUIjTI1GbYAY4Tv4PPTBCMQ/ZlBgBmLJij8M0W33f4ZdvcqO9yGHYQUMemXloP+PRQzfkd7wvN4evfq28b1QaBxPdarDoj7L+kWVt5BTF7HV8tdTvnWEJnIpWeMPIBNv57UE/Y/dTATwzL28PAy+f0oXLvjO8a1ipjZgfc2MOnWBryboT+QCJIuTL53RYGgb2E4HBz7M6pym03/8lPF1dFirE6KxgKljD18fElMxLvfh2mfy3KXLmd/JFR4UkCJczIEm1chAQhdZLcLpqPsZYhiZ45II74hawHMueCKL3IZkZynr144YVjbDfcY85tM7/8OP8W5df0CXxvSNQHMiQbqshGW1bYli9/+T40smKjLmMyRdW2ZjqNAInQ/S2sKbD5K/O2b60rnP0qv691JrUxDaLIqcYgsR/pTpdkrakOXT9west9/bACy/qKj2XqdBUIpB0rJG3QqgmB6D21dr/TED3Y1Eu1Ow5Iwv5W3YCotcfeqvG57MwoaaDz122ftt2Lg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f39MiEjhZQQdN6/swZZiBSJsJn+Yrg2p/VcFMeFHIJl0p9ZR1RV7moGnBD62?=
 =?us-ascii?Q?400Jpt3MbAogQ52wdcmJ3uvIjs7P85y7WPn39F+LLWpGcv2NLtSDT21I3FOi?=
 =?us-ascii?Q?/O0TWXctyk6MNJ6pUZd5rLxXwQo9J/39qQYXiewYV/cYVPuVzv3i0OC06RZn?=
 =?us-ascii?Q?f+Neb3QYMSbuPM/Bh4ZCH4y+Lw0SpvKVNuvEvvCKkj4Z+kXP6qXbvujuHkFh?=
 =?us-ascii?Q?KjFDYK49/5q1ey3c8zYH0iefVr7FUHGJhqtpDr+K5mrbGlSj/Sl8a1S2EL5D?=
 =?us-ascii?Q?n4/aiNIKrYrqwZXNO86SymWFCXomYDJzeaVuFz0C3FhAU5LaHtQMj61op8vH?=
 =?us-ascii?Q?WWQdF1pexRp0WD6m5NfCzTxKSbfOGmO0VzEmQpDafJj/fVXR031quLkA5L44?=
 =?us-ascii?Q?3o98vYS2nkNPwQV6YL3qVM5Y0Zc5ypaKoqJutwURBvLw24IoLnwVWQe9I2jK?=
 =?us-ascii?Q?Jzr/EQ8nH2sWY50Nab9Q5HtovS1UDLxLEi+p8HVquttr33zCtaoP523PKj2S?=
 =?us-ascii?Q?5Y3F4taVERZrFNFA22FtUsI2UUzYft0ZN5I+olS85/5P9utU2joA/5sH1OVF?=
 =?us-ascii?Q?PGSHuEUdUCmuS4DtOXPy88x+xGws73rlTimmObVBvjYB2GuwjaoRUeChAogA?=
 =?us-ascii?Q?xbOHMk35h2Jg0vdRmrSKY5okXAtxde/r0MdWvr8hTMm7IfVt0Upm9ptvVwP+?=
 =?us-ascii?Q?k0L+8B/kktfCIXD/WMIuZmbUd4+sWtI18UEvkl0ueOn0C8KTiEUU87cOyprC?=
 =?us-ascii?Q?59SuG8zRm9DKYd4MNopokS+hxJKQgPCo0QA79kKGlbEbfuXqdekQfQl5ERYv?=
 =?us-ascii?Q?KLChFOQgVjw/vuJvBA7h+TlY/XVNMUv2YF8n2F/tBbvJlgQdwNRgjCJJ1mf1?=
 =?us-ascii?Q?pSZjGnV7xUt12Lyl0VgT3lcyy7Wxdlg7ZSif1iRz2m7Bdak11vm4YaJOs/Ec?=
 =?us-ascii?Q?EK1Seo7yqXZXqr0JeH0en5Vfd2Wlyg2AJg/k0mppwqZPrSD7OUnLsGfLzGCr?=
 =?us-ascii?Q?iVTCTxCqM2ErfgksdwiWemVaKSVHbsNUrHAuG+sYNavE3yZhSEFpk+9/DHNS?=
 =?us-ascii?Q?ljrg6AtsfuuBXaM/MBVWXCfWiF9kdeG5IG2ySUkhyeDQEzGTTf7K6SgXdLNk?=
 =?us-ascii?Q?HCNTEj/1PEkiAKkBV5EIXUdFTOcMysVgvqG4XQWz7o57SGi6HWVngBnEp2nB?=
 =?us-ascii?Q?lj6wt9//gSq83IoVpKI25rqnrM6Xts7/QKuB+ogq2XOcOhGVRant8ciaYLy+?=
 =?us-ascii?Q?QxJX0tbKV9DnyEigebhGQqMz8mCqpiZkwIVKIFjRO6QoxpWhdNPr15RRD7Xd?=
 =?us-ascii?Q?9HzzH1P2nFkkR+LmxNUHIGkGVlxkV8vyH+Qye9mC18yYfLTDZOF6z5HOuLLV?=
 =?us-ascii?Q?BSSk9/NAW+uUim83rY8DQBkshegCD5T5z12Wj+EqN4/blJ0J9Zbf7t4TGwBZ?=
 =?us-ascii?Q?HkWNZ6ozAsOOUfZ9MkCXZDrQTUytV812bwo2wL+3rYnyVyx/MVo6LMgnnRn7?=
 =?us-ascii?Q?QEX5MrXwtGR+8r7VlHjAxbwcRGMs8oHrETeGOf/Y4apF7MezFQt8Z6j+8Knx?=
 =?us-ascii?Q?9k8O4Ty5MevJnSrlbj1r4A3Ewb1mJoFRI5kEjUbVlY01jAndpBVNmgOg6wCP?=
 =?us-ascii?Q?/g6crY2g1GxqbzQzYPh+pPRclaheYL5Oi+l4YP3l59LuxeQ2OkOdGn1R07VG?=
 =?us-ascii?Q?+FeoKzHNQqFSPv+tLLFmmr/qL85ND5FOc1w25H7GXu1FeZ2ZHvKWMurEtCCO?=
 =?us-ascii?Q?AQvElIhcAtAiPRK49UXW3ju2UMjioDM=3D?=
X-Exchange-RoutingPolicyChecked: lwLvIcCytdNcCjxSpiOt/pU5e3KwGJfc1ZzgzqcTfH8sVu+9pqdxZalAd6PXTYPXfYnu/1F5w5Vpl2CEYbmcYvpqWmoQ1QaaA4Yuh6XJRm+Tu7yo2ZUR55ueZmWx09nAgtTsJ2yazPiPLFtafXcYyPbOsTqe7GziFvHzlaEuAvL6EDU69EBluXaMi0pd8SRSbp0PuaTWq/Oi37XgsOF3K+XMTzK7PpAKQaTigGT+f3Aoqq9Som35vaUln2MYQYWRGJOQCvD3Yq8IXa7/CifcgqinjngcvE0ZVQYXs3bL7NjDlt0Bci/hRcnh8whza+8WyIvdRhfjIPGNhNIWKJ0lsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316ced7-b348-47ca-ca86-08de80e34601
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:31:15.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoTmiaLl9XetlBVSYcvdO3Fxw2DQXgz8+JCa0oWbIZ+CLptgGBmjj3zg5/HFc6jfPyEj3OPBonX6RoMFxrLwnmVxx2akgMACDUPYgdVZOzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-267354-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EB63C28088C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:33:48PM -0700, Jakub Kicinski wrote:
> On Tue, 10 Mar 2026 14:59:14 -0700 Stanislav Fomichev wrote:
> > (build bot seems to be confused because f620af11c27b went via bpf-next?)
> 
> The pre-req is in both trees now. Please repost?

Will do.

