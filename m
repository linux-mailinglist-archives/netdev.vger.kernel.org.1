Return-Path: <netdev+bounces-160141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE2A187CB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6722E188A654
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BC1F8908;
	Tue, 21 Jan 2025 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2mvzN+r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9739187FE4;
	Tue, 21 Jan 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499226; cv=fail; b=OxE7ut4QMgD4cpUJkgGuL8Mv78rMGCjvn8jrJd7vm45esi7o3FzGxQm6hmhned06GEVOorHqZJWjz0b9rMNn/7wWQdRKU1j9aZOz3xu6iKGuetGQ8x/amrFOHR0rLkkuaWI11+pbIBLUzbw5FDvlE5hY2Ip2cKQNe9ZwHMOj+/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499226; c=relaxed/simple;
	bh=geV5bP1Xjv8vRBxfKvkTShw6ZC0/PfopEgTNCVOzPSA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QtP/6g49RIws5QVowSC8Cpb7KWnHWkFeg0x36uncRKysElO/cA2UEYbduQpzzJI4uzJj7U318QPub4qGFpUhLjBgpHPX7P7TeP3C13O6LSNLoIv18Esn8XWMZFySNpVkeVbUS1GxbsX6Rr0R+YMPejwlrd7YOTHiZuJYWjZPSPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2mvzN+r; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737499225; x=1769035225;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=geV5bP1Xjv8vRBxfKvkTShw6ZC0/PfopEgTNCVOzPSA=;
  b=A2mvzN+rCWlQQwVsdH3tjHxd4p1YNi+Q/BiqCsT3VHZGeHYj4UqyeFOs
   OQRx0mRkbIxPuPcbw8/d7/RNj1fo30TmBZBMzts9Zt0NkOHbWy6K09NvR
   QTeoPM3yD55pGDuEPf0snvpoS8OeRo95A+TftRRjLaRa943EbO58R3taR
   /ZSFvtPz0PfAY/DWV4IfZC1Q+7o/l1hzvkOAFr/5M2Kl2br0ur54190WB
   F07v4BH5ydkTGL75gXriKJoZVeTMgbctebfkoJV6Onscww5ZzVPRLINmQ
   LkSrG7yrKLjMiyR1i8356+VXvfn7gWzFzoFWqIpczWTC4YJHLTQCgcM0d
   A==;
X-CSE-ConnectionGUID: SJQFRxzZQPespcRMwp+pLg==
X-CSE-MsgGUID: 4AkowndKTEu2ir4EW19gbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41694969"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="41694969"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 14:40:24 -0800
X-CSE-ConnectionGUID: XyqZcAVyQiWgcnRbGrOsyA==
X-CSE-MsgGUID: H+WUWnIjSrSd9xBgRR6YsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110971590"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 14:40:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 14:40:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 14:40:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 14:40:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9JG400zd2FYY0ynUcU70Ilu/Eci0lJH8WjhGlIm3j3WkhqifJfA11eTbITBc6wsq2m37y2rZ6fWB97R+MqfL/+jyxHNSDwc9yK+71MQM4BoLZaAFqQBGZfSXQyHHnA71LdeNbnW6UIEkmbLLhBmWidnZ972RLUMsHwa6p8f519LOX8A52sJbq8FYPz2LjSpo5Cb4tqwZ6bGtQMevAqTy2RmrGH532MbzMzW6AWz7tTQrp5Xq1WTMI1MBsDyNxIiJwIqwXeTWJCR/6rJMe4GUQ8v1ivA8gmuhtxzm3nRK86Mmhkq6p6A8lLMP/foup+cVQeyjIlv+kVbd2DVR1nGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvWh/vocTUQxz/sTpDMe5g0ZSIzUkLG5Vmr4hGdjjO4=;
 b=awO6rBSPw545kwci2vVUNZB4QOivoQbWnY0vm++QQ/csvhPIVspSI63JyDBbhtHPqHHilCYJZKWNhaU7TBAoWtCPbvAsd6z4APHxhqx8YshUE9rbsxnN5lB5U+UQsa2zO3KDHuKPvtDid6N3Pg4bjWA3o4wn7+cpGyXElPHvaz3Nbl1ILwGji11GDRF7srYx5NkoK3/BUK/Bj5zqtrIS6j5BqQBGbFCfd243dEopoxg12lRnG0Eqdttm519UcPl6ZXuLK0pwenjgPBirQsawv8VUD6buNHW24GPvv0ew82rFVkoKpjVobxfmD42jRWpJ4SzhYK8Sy9LzE7QODU+bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 22:39:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:39:40 +0000
Date: Tue, 21 Jan 2025 14:39:37 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v9 03/27] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <67902229a7e7f_20fa29437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-4-alejandro.lucero-palau@amd.com>
 <678b05d3419d8_20fa2943@dwillia2-xfh.jf.intel.com.notmuch>
 <7ca6bcac-8649-5534-f581-b36620712002@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ca6bcac-8649-5534-f581-b36620712002@amd.com>
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cfb788-059f-41e3-eb67-08dd3a6c7df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9hnl/gwiWMCQ3ZZFBR6RNtJfWB+2c7/23fdO1yRqZbfSUPSyaE0C6X/sOE8v?=
 =?us-ascii?Q?UwV+k6t6wUiOGk3eXM4cXkUSZdfzEsAjmPFOGLx7naAqMTFpYDpYzDXzjUcV?=
 =?us-ascii?Q?PNMerZVRYs2PImmNj0SwGnEl8nZ1pe57mfz5ngCzcYJECKbKkXUnd2K6mlqf?=
 =?us-ascii?Q?GQjmWHfvkSgmYholbkHPA5iqWworraYJTDqL7wDuG6NwWbyWLBkBV+ImxOq1?=
 =?us-ascii?Q?qZPICfbnBDefAUwAyWsUMFi82fUTidJvKNaGlJqmEVA4Qj1MydPPpMMcbFIw?=
 =?us-ascii?Q?M+7rAt7d4SOCXSd+5t/toWp2gLTSuirN7jWHegk3iwtF33wrIlvcFEC8c5hN?=
 =?us-ascii?Q?SoPw1ct/BdVXLHKYjge0rJvHkFH3Wu+vXle5i3xUWrCzvJdi4ooHWXLjb3uO?=
 =?us-ascii?Q?3fmwfBLnkvEV0gbBaSBeuI6SMjdFnM+m4qRWH/eB+ZWZ0UmXplWBd2FUz+Li?=
 =?us-ascii?Q?xnWHdhWRJ5w6K7sESOwj769rwDC/CbtHrE2nyo05eFebE7Ge4ZCHHx7RqCdL?=
 =?us-ascii?Q?K3cehkphCuD7gixVx2NYV54LIqulVpUS3paLxqDAuEzY5cdQPhAt9i5psGp3?=
 =?us-ascii?Q?pOMjM/ZN5Vtk9P4OrFe/s9j2rfkmeAhXq4RsHqLZPU+io1WGsN82UDxWcZ/S?=
 =?us-ascii?Q?jhC6HrzHdwrivRJLeNLECDVfGYmlp1X/PCDeRdy6FcYXrjy6kByQqF5dXO1+?=
 =?us-ascii?Q?16BG9ieJNWpfuwwdZ7LR1pqwVspyPGFf8ydCn6Zvxbf18fvVeK0RJtHyr8Tt?=
 =?us-ascii?Q?Dyl0JmdzGDhH/SVYIqAV+DZHe9qlBFVzEbP3gmqroe2CeKY8ioDMtup+cHjp?=
 =?us-ascii?Q?P9HyJl3Kg71C7twPrSfbV64bdD4chjXLOWQPCRxJthGkRAAI93/IbBtEDj7J?=
 =?us-ascii?Q?41iCRsx9xXvnZWi5GfZD1VIqfW81Ypir4s2hYiQb54J7umLPNrlEGxhjApWW?=
 =?us-ascii?Q?LRGHmbj65R6BbwXj1kHbNZ94iFTYOP38P4LUWn+1uDwnys+CWs6GTzSNTMAR?=
 =?us-ascii?Q?vVQf3ND8dGsBfIYGjiRpRQihlHvGYkxI6g+B9mPMv9vTOOGns3Os0UlSMUae?=
 =?us-ascii?Q?/5Lkwu0sJX/8r85q7+KvBmFZLpJKFrgnVDLLKi4669IT2iSHY71KnE8lfqph?=
 =?us-ascii?Q?IhT48usI+6HpCqc83lb4+n3NYoT7XjtLUwckuxlp0juSQqxhJAxgmkQZggaF?=
 =?us-ascii?Q?eka8zD+U0mFkhh1no750Glz2cappuKsXZOKxrmPKv3OpIdEqpbtQj9muAva7?=
 =?us-ascii?Q?GWiJCxZkYdLyBE0stzAPzWlNZ69lib8yBQM8j2z1Fk4lXPOtkwxkKa8rWDDn?=
 =?us-ascii?Q?g05hbJxGG1Aebt0hsnp7fVSduFd2vB7uJjxwlTf3069gVQo7CSwN9leKlPOI?=
 =?us-ascii?Q?02hmLJiWmJVzhIVOqR2qEULPNtvZEdl08FqM46KhzoUvGEDAIcrqqzaPjssI?=
 =?us-ascii?Q?XCbYyvy2ipE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwBmg2a+TzmFVXwH41Yqt1m7QfbooiWW9OJ4dPxd8DSI0UQQqKcRJ1E01RlQ?=
 =?us-ascii?Q?l+EBhqfHOMVULL15IV/Ec9QKyyxr1+KqHGXO3H+SmajUfaAZKkOYp1jox7+c?=
 =?us-ascii?Q?TUT3378A7gIeMjdvZhx6DEgwePTxCyHAzoDnibk4BiUyj14DPgkGuKpmjJzy?=
 =?us-ascii?Q?SBk/XvGUKhlEvzkO9i6Y1MGDZGzU2tl4qvIx/cdLxVtGrkej4loKKqtOeVjb?=
 =?us-ascii?Q?K122OVfEfjoMC41aCk7tYdku4cIf1LM2vLcU7A8d+pjotPUWaTzerdpsIQeD?=
 =?us-ascii?Q?n19c5qivnSLR2e0888nACzpLexQ49F272R6tWFvkj66WTMcpER5hFA2mXLOe?=
 =?us-ascii?Q?K3kj3eS0tvQ1R8d5LGw5drdwCDgderwLIUUjR8QvkA2SbumgqdcHygyID9WO?=
 =?us-ascii?Q?frPXUYhAJiq+//d4mJ8EAdHvtxUgPSeEAuMvespn/1WohK+ILpdLtn9VLBBq?=
 =?us-ascii?Q?ToXzO3vb6AbRVD0f96x1swmRX4/DpYR2U3F2sQYNXl996r1IUW2e5DMwIgsp?=
 =?us-ascii?Q?hDlQ6N/EY3U1HJ8jP5iJaC8Xp9nkRGAQxchi6pvzNW1EjMZQchOGH1U4TrBJ?=
 =?us-ascii?Q?1lvxQxmvA30sXUmMHi7cjX4Uah93j3sUzJcismAbQV5GUa2hpU5Thc5jKxua?=
 =?us-ascii?Q?IBJ/Zokm0nmd9ksQJCi8NZGvFzMnkLOFVrTo+Iuaf+TimKgI/e+V48n13ESN?=
 =?us-ascii?Q?r6E/F60gQ/AoWDAII8zrEOiDgTeeVN1YqLy+vgoBgKQhILYdInrehCNCCS0T?=
 =?us-ascii?Q?xKebFqbFMAFuassGudGRwTiI1sbSblZ+tSqKmvipdDJM6dXGNQU2R6wb7kNp?=
 =?us-ascii?Q?EYFy0UMy8iEqpYE0MM0p6pmgqkj4II20LqBCJbREhiVEZzqOuBLUJ51r0S6O?=
 =?us-ascii?Q?UQSB8j2Nl3giLVG3O/1dgXh2xv3ynDciMAuaCqp+kfY4xP4gkflgGiOpB1d4?=
 =?us-ascii?Q?aDE4bb/1LpaHt0ZK5IQ3gsVgoR6mMeh4QlWf+eX6GaIZvHqJSEWQU0PtHIIh?=
 =?us-ascii?Q?ZoYnK9/+WW5m/kpN3J2TPUJSlvOy2GNwY1zPefUDfUtL4tN6Acmcrlzn/lMo?=
 =?us-ascii?Q?4IUStUX9eN36u7ZphVNF1dhMlRYBPlGvMDX/FF+PqrPRgZ/rELzCCWR+zz/v?=
 =?us-ascii?Q?QRVEY1WnKAVtyDrsYYbhAMGw06md06sn5YXFVpOl8098Sl7qCSbx5JzpYKfm?=
 =?us-ascii?Q?TW5NGc8KBssa6l23HanbBZ4Wq4K9OsuMeskI/Fn1hld0lKMrZoxVHK/sx5Ht?=
 =?us-ascii?Q?ROEPBRDQ4Qzdngl9/Mv2Z5SsNUq9K4sb2nAgs7qO23435uqdvhW2nSd4kTkw?=
 =?us-ascii?Q?ST1dZ+RUgejgRfpfk+Q9Ix6HEs/uPor8E7eb4GsxS0iqjhtDm3LSSvgfgkBx?=
 =?us-ascii?Q?Yy1O3P3vaj6EV6taaVnkTp3IHvhKZXAp4OrzG1HX2SbPO8S6lA5MCVHkd3rB?=
 =?us-ascii?Q?nOBeDTwRBtcG6d9bsjdNET0Km3IO1A+Vnfl2W8xpOiJz+UmCaunSlAJG3sdg?=
 =?us-ascii?Q?v/DCl2zpWxnA5n3SO2suZUbbgMQFBLSD7o5aO4HaaZJwsxdrOB1vBHkRyHqN?=
 =?us-ascii?Q?8W/BXrA0pwOhK7XIpvDoqfNit6K06Nm1ZE/WeRBKz+6vNyJyh7B23obMmB9r?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cfb788-059f-41e3-eb67-08dd3a6c7df7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:39:40.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPayEjdI/LH/I31SKgEMONrjDT5xtBpwAImfOjQS3q8y393njwBo5yxGtJ2KPFgIwoaPnAuyI7SkTU2Kq2MKbSzZ1qB8YdlWZaDPLGd1w3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > I do not understand the rationale for a capability bitmap. There is
> > already a 'valid' flag in 'struct cxl_reg_map' for all register blocks.
> > Any optional core functionality should key off those existing flags.
> 
> 
> The current code is based on Type3 and the registers and capabilities 
> are defined as mandatory, I think except RAS.
> 
> With Type2 we have optional capabilities like mailbox and hdm, and the 
> code probing the regs should not make any assumption about what should 
> be there.
> 
> With this patchset the capabilities to expect are set by the accel 
> driver and compared with those discovered when probing CXL regs. 
> Although the capabilities check could use the cxl_reg_map, I consider it 
> is convenient to have a capability bitmap for keeping those discovered 
> and easily checking them against those expected by the accel driver, and 
> reporting them (if necessary) as well without further processing.

That is just on-loading redundancy to the core data structure for a
workalike way of checking the available register blocks. The 'struct
cxl_reg_map' already tracks this, the only needed change is to move the
responsibility for validating those bits to the driver. That work is
nearly identical to teaching the driver to inject a capability bitmask,
but more flexible for the case where the driver wants to optionally
enable functionality. In that latter case it will end up checking the
valid-bits anyway.

