Return-Path: <netdev+bounces-212989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548BB22BE2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C37ACE9A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC532F5479;
	Tue, 12 Aug 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNQMWpOE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18022258E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013354; cv=fail; b=p1/fbQ+GfKu9U9f0r8Es6L0eq6Z8gcSeA0CUvR3H8sWwvcSRl8mGOk0yHiNjtEmD+biIoVJ/ME1ydXImzRFaguEhQ5DI8+B+wweRmwlpfyuBEKX/RE/kDM8qVQHWB14RWDMvWyW+eB9IPEMv6iyTTqwSkHu3X7plsZYAM6MPSxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013354; c=relaxed/simple;
	bh=b8QfOaWA1OIBUFLTx+3LCZ64BrzflqxJkampC0ZdGjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dlbhKml4yH1IC1FQfknF+6pSw3IMvmTlLTaxleesvEwSGBbYiloPbNLTkKaBdsQ4FE+sFR/zK18SCXDUrxvZTKu1HxHd0voGYuqe6H43hgG96r9jct4jmIXDEmCMQae2oRNuVj2KQDGeSznr/VC9GLfR+THRhlSNEPQiPaZUjo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNQMWpOE; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755013353; x=1786549353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b8QfOaWA1OIBUFLTx+3LCZ64BrzflqxJkampC0ZdGjA=;
  b=MNQMWpOEvZuoBWV9KNyn5BoLeFQnTUp72e43j502HYRqdPNTpFjc+y1C
   U8RxU3qmRQ7e8pAKbYdhoo3yT8tCXmgco5lI1tC2UA2PSoLaNvTjxWqeQ
   vdNenY/KV0xleZtdpzCcKnypN4e7M8oklTIXUSOWOqL1JfqC0rh9iI2JD
   xKqg+eIkaVN7i8purHH+CrDYNf4tIjeWx+lWLFohQdlTeouECLxMe4Z1E
   8IcZO7J4DAlwhmM9GIWzF9Ogme3asgRGetGr6A8fJpPowOuP2j5zUtSxE
   uvOdrMWKeCTj8RfGIwvtiafPh2wEkZGOds4TMkoPRrm58h88BU1MkgBaS
   Q==;
X-CSE-ConnectionGUID: dABytmydThCbcZki7uD3bQ==
X-CSE-MsgGUID: YYSuTTYCS72rRRtMRxtmkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67996715"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67996715"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 08:42:25 -0700
X-CSE-ConnectionGUID: L6mQI/qJSQ6rLn/E91esYg==
X-CSE-MsgGUID: ApgWR3OuTPO0LUWOdX+kaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165414630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 08:42:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 08:42:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 08:42:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 08:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqWrlcvQmaaQIttGkIy9Cx9fgXNyisV+7QSYQ+7EAEx9WEUj+lMROJfnO19iBlPpsD6GvYyIitpS7SZDCpFa2yo6VBD/a6CmU58jMTjF5I/XUGueZGWZ9mV2VjaEdCQ/kSc8GAXoZ/Zg8UOY+gmFFB720oKQGhQlaVTJG5v/U/7ySkaaWY86dM3QrcHkS3dsXykh+aZdTT83aih36N7k7Z+lryddj2GTYnvJ3+RqWEnPAj55MTSncpLPUBf3sTtMZOHR1txe+51WV6bNYkf8UFiFVcwNzvnrHh688ugqWblGEfQYSFvSMYUU0y52qrdXIdZAy32An7IVRC86/J0pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GVfz6Z6ewfTRKZ7MRZ4JV0w5+4oGNwYlOuMw1U4kYU=;
 b=lG/1mWskdZdwaox062YRXgtIMFqLq7whS9xYB+TVL3Z3p7QMvBZemghXGnbu7rhAsCKgFpyJcd/D0dImr115d+NDzle46DgJk3eg5D7GXN1xt8D1lCBwM0xUyEHrrDiNTnLlNuoqdb9Dne/YpDYlSTeGVCf0M5vtfCNotAY9jOBLOQX5VQhziJZFHzBfQ3VAJstqSrYgGeGbiETTSgUU53I6uTlXyOOoBZn7Jepmon2Ei/wVwhlqUGMX07hMxqwW50i0P+daeZTsQDrzbsyqva26LJakjZAFvL5fqu6meh78rG+6T0UYKuqbIBuYa+ppGyUHJ96Prh1IJYSojeZ7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB7155.namprd11.prod.outlook.com (2603:10b6:a03:48d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.13; Tue, 12 Aug 2025 15:42:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:42:20 +0000
Date: Tue, 12 Aug 2025 17:42:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<sdf@fomichev.me>, <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH iwl-net v2 3/3] ixgbe: xsk: support batched xsk Tx
 interfaces to increase performance
Message-ID: <aJtg0gsR6paO22eQ@boxer>
References: <20250812075504.60498-1-kerneljasonxing@gmail.com>
 <20250812075504.60498-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812075504.60498-4-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DU2PR04CA0271.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b979fa-25db-4c2e-669b-08ddd9b6d319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BVnF/sqtQaemQGFJuTABcbmzZmV8noJgK9FZfHUW6itVN/nf78HuUtpKY+2J?=
 =?us-ascii?Q?Pb1vPQVFdyb6RsCo787zltfeE7AkkryjiX8/uQydPnGPpFeL7rGjlvrslmL4?=
 =?us-ascii?Q?7ktfuVB4ZiNOUdNUdyZHIuHNtznOBdHR59RygHtbV+9+A2NFWZvlqV+Pba9P?=
 =?us-ascii?Q?Bxx8Iry4OF4xQ9h/aODoWsTNK8mX4ppauAbAK1EHPBacpXwJ+rPOVjnaRu90?=
 =?us-ascii?Q?zCK+2X17/KXuyHxBz4neH+C89Z+S7jmqrFfKevAURdxes9qoJWxief6v7AFm?=
 =?us-ascii?Q?ExZbowysYevo2PUrT9japGLPkG+sLbr5nD66jUD1AaT/fJapriWgebpVYUz0?=
 =?us-ascii?Q?xZT2CpiBXhc8IixDLfVg5zz3Ko6i56lZhkNS5A3GEJ9oJtn4/hiXySBywEPu?=
 =?us-ascii?Q?rvLSL3nl+AfT/LEiw5SpKp3ZvHGNUcmlrE0hzHMUfUYWG9wYQjBi6JDA83rC?=
 =?us-ascii?Q?OclYLLUY7J1MTvY8sdVm11CPictYNtQSfdVFLx5dJhqcDqpr2K3pyfJL5UKH?=
 =?us-ascii?Q?A0LkQ0iM9F835PpVyJR6Tc3DLYxUn2LCzphIobcexK1ZoultAWWH411knLKX?=
 =?us-ascii?Q?2Wmd/rUH6T0bbOE3Vb9jGPE+ipL2Glfs+3m6dUmkfBd2tZN8uFo67hTA9/bV?=
 =?us-ascii?Q?4DJa21VcvRAhFb/O8ZSPfwwxJhcuXqD1rMyXRBvK4U6Oi6S4MnsYydmakuSr?=
 =?us-ascii?Q?7kOjxgIlHHy5r22lDSQeerQ9xmHtFn2RNWTRi5UZSwptqzc1RadvRru+7Kcr?=
 =?us-ascii?Q?o7SgwuoIs70Cr4Q3r2aQvyQrfzpvxVwBMqTXsvyR8qa/9Qt6v/xeHlF8Yn/8?=
 =?us-ascii?Q?Y1E/AabgBUEuMcs2OdMtujBWpM4R5LLQ7TCteXG6R/lq/2BxMMNasTEVtARd?=
 =?us-ascii?Q?uze/iAVeLLRyAACuu8IxP1ESXq+l4Mg2g3ZYt+K7kK3lIGQ098UwuWt3urFh?=
 =?us-ascii?Q?BA0RtETI67eQrKyekNGDfbl24kCErhzcCzXz2vYszjTI6+n7rzkAttlLntj7?=
 =?us-ascii?Q?cEdmJExAMMHrCQ+Ku6QZSYDD0J9nqRRSyvMAuMJj5S5SW8oZIYALGXy8rdxO?=
 =?us-ascii?Q?X8QnQH6svUS8VYNqkEUEAACYcsOah2effpW9rvfZrO+NEv3YUanhsndq45CU?=
 =?us-ascii?Q?57wGklDVtDNeZRCHz5OgzYviBGjY1qGssGgWoJURXRRqphKIKRae2tVOOBlu?=
 =?us-ascii?Q?uzK27JS4ezPL6ixtwR+Gui6XEeWNCOmfPjEsI83cDrw35WgIOZTThbtyrUbv?=
 =?us-ascii?Q?Vqwn+wLcbyMgiOx7Fw6nshz9JWsZcWH59NGuGhyFDryNqxcZfbaVb3WoGa3B?=
 =?us-ascii?Q?54OvfVDvwBZv8/NmuS/iSFq56obwwBXx3zYP95SDwuIu4Nwnu/93AXYeqUFp?=
 =?us-ascii?Q?q1M3EAs9QwNme29QPm21mRLqWOOcdPFB4mElHYE3ZbEX7iYpwJ53O77D1brf?=
 =?us-ascii?Q?mILv+g+/uIM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbF8x8nSlON4eRzaSGO6G2gtRVpuI1F5BhIHkZPaZj+b8vW+IOCr099I3kW6?=
 =?us-ascii?Q?uT7ByFKpwCTCTunnZdPM4KopzRWsVksivonnBlf5dtMIGKxGkR6uVyjr3tHN?=
 =?us-ascii?Q?fjQzuKhOF40iukkpCkAmGnrdwOSUb1o0ROrCii3L0zaOfY/ho6tX3Bla/TXv?=
 =?us-ascii?Q?wo8R0M5uWMIcrPifGdEleMwEByfWIJu4XxovrIM38fCKr7hP3WFbbTuQjxgA?=
 =?us-ascii?Q?VTsqk6pF7wur4ogzcYLpFo6lfxAPsd8R0rW2hDwZaipQCjso8a+yeHNjbfJw?=
 =?us-ascii?Q?ZwfYGb0o+BVCQUb2x6orwvAgIHmeuapJIyol2zymg+U1byg15+XwoQnlQkVL?=
 =?us-ascii?Q?zd2BKx7O9j5LJ7U2EZr74OoRgU495xl949zzH3FqnJmh0uI/zclgm7xX5Pec?=
 =?us-ascii?Q?1JJvk9eN8cBkr6Rz9TwS9yVPCDCre74yEJec+c75XQdPXj71y4caoDEsZZDx?=
 =?us-ascii?Q?NaDDZh0pFIZtPdJwtl5PLTCRmMO2ztectlIR8I1Sxy4SZC43F1O9tE35VaCf?=
 =?us-ascii?Q?YaVx9A5IGVclcoJrz321zGeIxxInMF0Xku4FddMoxzcrowrk2DrpSInrdwr3?=
 =?us-ascii?Q?Wb0uml1OxJKlWepdVWCMmK2t2tkMQ1mMNvW9R4RfeniyPSAxiuBg/Z8bXFyF?=
 =?us-ascii?Q?8YOcsrcYcmBUzlg6MY5c1y7SrGbqMKwsujtHW8lXScwEEkJoPDMqrf2Twn0P?=
 =?us-ascii?Q?gTLX32NwTdLGAm5O6dAAOqUegalXVErqmkll1mvzecO0ImuXYPpkOYvTm/je?=
 =?us-ascii?Q?lgX5bGHr+s8teyd+q8ZOe8/4MqoIb8TKVRacCJ9cyhl03KL6Jo9dORENo8z2?=
 =?us-ascii?Q?7319TlStUC4l6oBChVVAuKNff/dolSzkJdUShd7K29302+8aWoYQjJD2M+vl?=
 =?us-ascii?Q?cX2GJtIjgE15wqz59hHA4hILUk2aLLIb0sahWCRhJl+7a5GoPMdc2V85owmB?=
 =?us-ascii?Q?j1DmQ9HOz578n66HH6gh4NZuefy/jFcuLsFA+CSI/3Ayh58lH2ror9wNMOV8?=
 =?us-ascii?Q?hO4H2SXLXuJ9ZiuYHG7O2v6RRkw4wAEqN2ddUqrR8YRjixipXLsXQJQrnpRT?=
 =?us-ascii?Q?erDL3XG5r317LfTBItsQqQT8b4sPfOXIrrtTJ1hktbxZfV5ul9gxcbcWyZvX?=
 =?us-ascii?Q?CYzAg4stlA+tZVy6AQr6HgbVIYnSiGX+nTdmF7oLjtUR+nmOZNw3sTvLfg58?=
 =?us-ascii?Q?vK+8U9J3ZVyPXilM/G914b0ztSKPLWim1vdy9vCud69WBNpn5t6p7220E3NQ?=
 =?us-ascii?Q?Eehvw65zbivcoq1fQdXTA5j5n3816E6hak/803y7exVN19j5OCfVr5U/8f+k?=
 =?us-ascii?Q?TmHYS1P+OChbFbyN1BEWTMXAo7QXwujLl3bUyK6mN6eSEF196uwiLKMzGgpc?=
 =?us-ascii?Q?kBhBENZ57KvpT0M2WwoyaRoHgAjTAUeAXcYe+cBZyA9kMa9xtK9v0Yv4feI5?=
 =?us-ascii?Q?XlK+xT26Txx39ypr43c0dBII9epbmlZU3Rt0PerfJLnDjXH+qtPbgeBY4WF8?=
 =?us-ascii?Q?X9EioTSB+8I3QmH78viTXOrGcf0dOYlbeuoIohLTutlgFg6gybvwlMoSEElT?=
 =?us-ascii?Q?CtRxnV1yytkTfrVxnvUzVcZ6N5erOWPWekLWfPih6jPRgtkPWC/YBy3sZl14?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b979fa-25db-4c2e-669b-08ddd9b6d319
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:42:20.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmXls5PM3ztGDPQxFhuWeEdBgy1K9aZ9PIb3buQKvXPMVJD5VhIZmxgt/WXyPxqoJNZZtlxBNsOEyyZKEtoRmKfDrugChP5Ms8C+QPo+0BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7155
X-OriginatorOrg: intel.com

On Tue, Aug 12, 2025 at 03:55:04PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 

Hi Jason,

patches should be targetted at iwl-next as these are improvements, not
fixes.

> Like what i40e driver initially did in commit 3106c580fb7cf
> ("i40e: Use batched xsk Tx interfaces to increase performance"), use
> the batched xsk feature to transmit packets.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> In this version, I still choose use the current implementation. Last
> time at the first glance, I agreed 'i' is useless but it is not.
> https://lore.kernel.org/intel-wired-lan/CAL+tcoADu-ZZewsZzGDaL7NugxFTWO_Q+7WsLHs3Mx-XHjJnyg@mail.gmail.com/

dare to share the performance improvement (if any, in the current form)?

also you have not mentioned in v1->v2 that you dropped the setting of
xdp_zc_max_segs, which is a step in a correct path.

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
>  1 file changed, 72 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -2,12 +2,15 @@
>  /* Copyright(c) 2018 Intel Corporation. */
>  
>  #include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/xdp.h>
>  
>  #include "ixgbe.h"
>  #include "ixgbe_txrx_common.h"
>  
> +#define PKTS_PER_BATCH 4
> +
>  struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
>  				     struct ixgbe_ring *ring)
>  {
> @@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
>  	}
>  }
>  
> -static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> +static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
> +{
> +	u16 ntu = xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : xdp_ring->count - 1;
> +	union ixgbe_adv_tx_desc *tx_desc;
> +
> +	tx_desc = IXGBE_TX_DESC(xdp_ring, ntu);
> +	tx_desc->read.cmd_type_len |= cpu_to_le32(IXGBE_TXD_CMD_RS);

you have not addressed the descriptor cleaning path which makes this
change rather pointless or even the driver behavior is broken.

point of such change is to limit the interrupts raised by HW once it is
done with sending the descriptor. you still walk the descs one-by-one in
ixgbe_clean_xdp_tx_irq().

> +}
> +
> +static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
> +			   int i)
> +
>  {
>  	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
>  	union ixgbe_adv_tx_desc *tx_desc = NULL;
>  	struct ixgbe_tx_buffer *tx_bi;
> -	struct xdp_desc desc;
>  	dma_addr_t dma;
>  	u32 cmd_type;
>  
> -	if (!budget)
> -		return true;
> +	dma = xsk_buff_raw_get_dma(pool, desc[i].addr);
> +	xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
>  
> -	while (likely(budget)) {
> -		if (!netif_carrier_ok(xdp_ring->netdev))
> -			break;
> +	tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> +	tx_bi->bytecount = desc[i].len;
> +	tx_bi->xdpf = NULL;
> +	tx_bi->gso_segs = 1;
>  
> -		if (!xsk_tx_peek_desc(pool, &desc))
> -			break;
> +	tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> +	tx_desc->read.buffer_addr = cpu_to_le64(dma);
>  
> -		dma = xsk_buff_raw_get_dma(pool, desc.addr);
> -		xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
> +	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> +		   IXGBE_ADVTXD_DCMD_DEXT |
> +		   IXGBE_ADVTXD_DCMD_IFCS;
> +	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
> +	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +	tx_desc->read.olinfo_status =
> +		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
>  
> -		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> -		tx_bi->bytecount = desc.len;
> -		tx_bi->xdpf = NULL;
> -		tx_bi->gso_segs = 1;
> +	xdp_ring->next_to_use++;
> +}
>  
> -		tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> -		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc)
> +{
> +	u32 i;
>  
> -		/* put descriptor type bits */
> -		cmd_type = IXGBE_ADVTXD_DTYP_DATA |
> -			   IXGBE_ADVTXD_DCMD_DEXT |
> -			   IXGBE_ADVTXD_DCMD_IFCS;
> -		cmd_type |= desc.len | IXGBE_TXD_CMD;
> -		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> -		tx_desc->read.olinfo_status =
> -			cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> +	unrolled_count(PKTS_PER_BATCH)
> +	for (i = 0; i < PKTS_PER_BATCH; i++)
> +		ixgbe_xmit_pkt(xdp_ring, desc, i);
> +}
>  
> -		xdp_ring->next_to_use++;
> -		if (xdp_ring->next_to_use == xdp_ring->count)
> -			xdp_ring->next_to_use = 0;
> +static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
> +				  struct xdp_desc *descs, u32 nb_pkts)
> +{
> +	u32 batched, leftover, i;
> +
> +	batched = nb_pkts & ~(PKTS_PER_BATCH - 1);
> +	leftover = nb_pkts & (PKTS_PER_BATCH - 1);
> +	for (i = 0; i < batched; i += PKTS_PER_BATCH)
> +		ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
> +	for (i = batched; i < batched + leftover; i++)
> +		ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
> +}
>  
> -		budget--;
> -	}
> +static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> +{
> +	struct xdp_desc *descs = xdp_ring->xsk_pool->tx_descs;
> +	u32 nb_pkts, nb_processed = 0;
>  
> -	if (tx_desc) {
> -		ixgbe_xdp_ring_update_tail(xdp_ring);
> -		xsk_tx_release(pool);
> +	if (!netif_carrier_ok(xdp_ring->netdev))
> +		return true;
> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, budget);
> +	if (!nb_pkts)
> +		return true;
> +
> +	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> +		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> +		ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
> +		xdp_ring->next_to_use = 0;
>  	}
>  
> -	return !!budget;
> +	ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - nb_processed);
> +
> +	ixgbe_set_rs_bit(xdp_ring);
> +	ixgbe_xdp_ring_update_tail(xdp_ring);
> +
> +	return nb_pkts < budget;
>  }
>  
>  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> -- 
> 2.41.3
> 

