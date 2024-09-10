Return-Path: <netdev+bounces-126794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25C97280B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C35D1F24D64
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 04:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDC18EFEC;
	Tue, 10 Sep 2024 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeD8FaGG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203818E77F;
	Tue, 10 Sep 2024 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941727; cv=fail; b=SaGmXGNp6wlXmqu8ci0RQHGQP8TrImV4g86DNHRaLCSNmXuyPD1euoKn14fyXiV4xb4aI0WYwHR7TRosqKNPCSZVD//Pt9SbrEF7EacbU2Q/PaK+JHDIY5SWni1A2CRoFeY82rud8jWbKECz6ApU/f+0L++sSAzJgob9GStAhbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941727; c=relaxed/simple;
	bh=igh4QlN0U8Cqu2t7gJb2xKk2cam/rX/FEF2akSlEF70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apR1kHN8zVv4iz9tLTwve9Cj5/3IX9U88WZRgMaG9WCxBM0rPgEaOPO+gTHtzABFLfMKfULld0ynOxyAo8bx+n+tnin+XwZ+TAMhIp39qj2zuLr5DnHjcMfBvIEzjIoaENUWQVVsw14RQKNkjUxo4e7VN1Zgi052z5s+/Kwktbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeD8FaGG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725941726; x=1757477726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=igh4QlN0U8Cqu2t7gJb2xKk2cam/rX/FEF2akSlEF70=;
  b=QeD8FaGGegnxORkkrx9ntyDJzwG0/2MCwZWWX85vbtWucjXzaqvsMA4v
   M9IwAsVx4MYdQYrhekjI1xpAwNG3d3dz3MpJ/sA4mD51aQCJw/vKuPoP7
   phze5uAdb6YAsC/iBSWjDT61IInki6q5E+YZXYu31ywhXnOj/LWUgCUE7
   1Jidk1fr+MmarY9iKQD8pcKxlkFI35DqbnlckxDAcicJJzRnTq0psKINh
   Sa25PtB4ronoz4+hMpGURab3MPNRMNWOX79DDLYxKHHUEp1n3D/Itr1E5
   OUswtUnO5Y8dDgUSjhMOdp2p/F1Cot4mdE8ljSSrmFklWuCeqYCWVkSxB
   A==;
X-CSE-ConnectionGUID: JYGHBEkERDugnfRC8mVZYw==
X-CSE-MsgGUID: rf3tYO4LTA6PyQocRgNjDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35239272"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35239272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 21:15:25 -0700
X-CSE-ConnectionGUID: HbGNPfg5Q5aw0iG5Nw68PA==
X-CSE-MsgGUID: ILktLtu8TeWDdKTaLuA0HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97700248"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 21:15:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 21:15:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 21:15:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 21:15:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 21:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRNvV0nCfIRKliw23RB/JurSKcshq/9RQfw7FhITq6WsYzrdKjT+8VIBNcto/5KNniZNopOsWWNavS4RV0UwK+HrHB55owfZqPK0jiHVv5zPx/nQilFcyYjJT4iGNyBtReugeYx+ATveO/rQnbYDZS2tyb5qBW0DhTGzku4AlN33p8ebwikCv/YOxPwyVAGy8QF4U/+PwTSZDmYA2U6PXqdBhA6RfsbAtcqF2xhZY+mVlZ6MhdeONUT6tVcJMeAvp662/KcRR+niSquNglP4fnO55Tw8/dLXWZYJc0gjwUoujaeOkFM0BsdUM3Irql0K0CBoQ+rr3EwtG0UNGEYNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sLPjLsowBduiwzoR+TYMfaoOaCqOSQysGuf9cnYnCc=;
 b=nuuAoXE09pFiGVCdioDo/tstOGuNKfw981BU0oytLx1BSLSIS258TaiVWiRYVkTW+CnSJ07nFBE1g3tmCAAMAhWR7i0MiWCJKxTgfR74ofpL5vvR9aAfk/NRoeWz3ZWUVjisglBUKXftjSh1LTV8MY+Ionlni9YBvzVNf0yMH/7zLT+QebX2yBuR65pij0gMTtFM+wVLn67MrCIcDmYrWqZcM/0vKcNg14DesPuKJZSHfpSdcSwmntVp/EGh2BMGBC+X/rcwZOnmZVEmSmA7zjVXV6GUJPk0LKlsezTdgMblsqnVKX8u6yrxFdc9na28qCDWTkVY9Le13+swPR3wVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6256.namprd11.prod.outlook.com (2603:10b6:208:3c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Tue, 10 Sep
 2024 04:15:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:20 +0000
Date: Mon, 9 Sep 2024 21:15:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Dan Williams
	<dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Zijun Hu <zijun_hu@icloud.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ef96c-4478-4296-ad01-08dcd14f2eda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NdfdmZUZqqYRjWHiol6uZzV7SKLOMSOPKuAtVv/rh/yjLY5lN/XXVblBhXBS?=
 =?us-ascii?Q?T9KeiAF8KBgt3HKT9aj4Hng09cvRgkb8KGOXFU1SX3Za+EOek/dEMskXhdLQ?=
 =?us-ascii?Q?h/kmjsAU1WGspwHljXik7iQcKZtfPbPttaCjMdzc4wQjEqQxMGaMe0QuCwCn?=
 =?us-ascii?Q?Laz1vqHz2iGDbNUlcW/+3uCB2gNY/lFIgF2ED0RSzOd/2no72QJkRP/wh/1P?=
 =?us-ascii?Q?g5IxduQld1KWtt8z0IrZNbTJvXQ/PAwayKcPuKgW5zA0OTxpdt+d3NimCUik?=
 =?us-ascii?Q?Zj90N1tnkf/tQ+2e4NFANUyeNsP7/biWpyJ1KLXYTGC5dC+/UtbCl6cmvpRx?=
 =?us-ascii?Q?q/NcHDzKWxo0CcwbtXnQPLtHAWoXLz4LEX0lvmZO+5aeKwl3OZY/7v0woL49?=
 =?us-ascii?Q?8Q/ctO475AvP8TlkMIlH39qZmQQPtKf4UXCcTrLNUd0rYVIE4x83Aa5V9pUv?=
 =?us-ascii?Q?tEhEEly2lH7r8MFDyRzGHmF8UoygN6tz9182izWfTYTFVKvdUouz1FSGRTXJ?=
 =?us-ascii?Q?aIAxC7wq/8++YwuTMibTlyhr7hiod8bHc7VDO6uVsSYk9SHmNn4SWA8CzA7P?=
 =?us-ascii?Q?HTvUiyew7PJRRAm57FZqdy4vV8Zpax8HrS0kJqldTOgBBpQbFG+t8FfmYY65?=
 =?us-ascii?Q?DA+PKliNomiewg1I+ZWFAqqL+bhdHqKUJkD0y5b4dDYD9DFjY6Z59Q70u78j?=
 =?us-ascii?Q?LjfaXWuQn2GyeubScojl4N/E0vawviKRSI/ukBrzfrP249MoZNHD8QNIoiLs?=
 =?us-ascii?Q?yJRjy5lgg2KI+aGKqhsPJd4VIqrxSdy57bmvAx8YEQdbBHoT5nMkCPWMZenl?=
 =?us-ascii?Q?eE2OJaM6oy7S+8cbrGYmkA44Gg3rqYqetubsEHqJyiWJKK+xn/gzBS6gljQY?=
 =?us-ascii?Q?CaCOJC4gLC4ZuAWm77UWbjyxENYYRus04HbsLUP1b3OgAWCgUnDbX+OqpSrs?=
 =?us-ascii?Q?lNJHV008cQdjqFqCt5XBLEItdWh2k83E0ZMWy33UGkQi2/zGqdWL8kUUFSDv?=
 =?us-ascii?Q?tGY3bCB9++KZ8tB0l23mD8B9praFDLkZg9uSioxUXPTzwIHzMcxvPgeKRg3J?=
 =?us-ascii?Q?rx++HjZAcQ6pLFgzK4GCMZOXIJsrWwN9R/1IXBSTnQx5uv7J/oytHhhJRbzn?=
 =?us-ascii?Q?D9U4GwhS/QGJh8eJfgNKAKvmj4VjNKSnK9U+/mR+z1Dm5xuEiENy3AJ3onjb?=
 =?us-ascii?Q?rCERlEtpPSE0PxMUq5VviejFLm9nbwrwpwLpJ1sb6S/9gkwM+YS09ynt3JuV?=
 =?us-ascii?Q?kycPYGtguGM2tOjxtxwBa6SbS4LuvhIfS9dz0o4QY+WMhnukYDp5Ev8mjL/1?=
 =?us-ascii?Q?JepFPeMiooQ9HuSXGp7+f6RZoCznhek3iCZfJ37s9gN+feMIBZ0cwiIxWMoD?=
 =?us-ascii?Q?oflPI1Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rtCwbvzu5uqrtbb0EXOiD/EFWJ4bp6QrVAxpY9d0PQDGcE9g2gtv2i+MOPVB?=
 =?us-ascii?Q?OECR1SUfH2GpJ/AlFWqh6PUt4IUOqsiChyaoZu3EiRxeyzW4aXpisCVnGWRl?=
 =?us-ascii?Q?/8TjMh5foZ1csUbsX0ipr/51K9r4R0d2fS+d5SDxRjmn6F+h6Ts+5QXy1YSE?=
 =?us-ascii?Q?b9iSSp5UGcgSMRYOMvesbs1vQWMUHebWHLDHNeh8ty8g7nwgLKaaulW80Za+?=
 =?us-ascii?Q?6X5L7FQSaQR+rSt9A8ykvh1TkFGMKVXEbAlhbfMWDnCEQO/g2I5Rz1GYaOvq?=
 =?us-ascii?Q?bwiB4gjERM1rFjy/imT0aCbfWrjExQcC22+kNlniwM3nzxmQ/wOdTTshnly3?=
 =?us-ascii?Q?X/2Znl9wQSCzgpdpa9fWepVeP8ecH0Mv5JlJZ8ZzdSEkr7Vc6uiWla5vZ1Wh?=
 =?us-ascii?Q?hWf0/9EENBg/cg59RxVefPohPYZ07ZGCYZnkkqmliygaRR4Ev1dJ7TegwZZ1?=
 =?us-ascii?Q?C2MGPXFFJxMe3ALcCSbvpsPh8MXt8z2/7sWb1oTDYYSi4WL3ekfwYbORcc3z?=
 =?us-ascii?Q?IaAge2zqGNrqChhhPfA+gDgTSo0hOOwFO6CP11JyLJHBVdaAkrJHzmlV3Dgf?=
 =?us-ascii?Q?5OGBd+kHZLfDfICrBqWrtyuBcg9jYmfWraLue+ZS3CyD4vPyIIA64a9H/cco?=
 =?us-ascii?Q?/ANfDD2SjSPywqgONYlSeOlT4gTE4A8hQ7rmxNCa5SlY683proz4N52ydCt/?=
 =?us-ascii?Q?jm7p5N7rRP/dp6OaLUzTnP//nm5dC3owfYIIMyLfkQ+q8S2M7NCoKBd/iE3Z?=
 =?us-ascii?Q?PM6ic2+v1OPEP89fo0bOaWvUW1yW20syHZXc76wefJytr8HbZaIHR9yAq8Sl?=
 =?us-ascii?Q?9frCp33oglhsw6pVqEQIAiXdcgYkAoDw2HD+iitlOTpbIE/YkRELHHiXt0HN?=
 =?us-ascii?Q?z49m46x+V5R74IZRVD9GQVwMuHV7+STdQywn8DvxIdxZWhW9YDKD7okPGARI?=
 =?us-ascii?Q?uMoatQZ729dvPZZtTiI38Yr1YhqWXVECUUl4coocFUANtXANRJmaYowTBh2u?=
 =?us-ascii?Q?EKzlL6j2vTqVmYVmlKWDHwFd/wKGnaqnJbEMRZKjISOOHWu62FH6AkcL5fmL?=
 =?us-ascii?Q?NIw2LQuo/QJ3eXEQy69+5jdaaTDhTlp/RqJwZiA11LmuV30KmahcFluLZhNI?=
 =?us-ascii?Q?oZCNhgd/Y0Coja3O3EMuKzHf7DdK7sy/09G4+Go+ijX1cqwXETaR1YUMrFAQ?=
 =?us-ascii?Q?ORYvUB5iKS4jYeMC11NxyA7lwnruf8EeSVrowkwG0qf73q8nOqG5LKniDk0t?=
 =?us-ascii?Q?YRLM8EMCh7NYBg5kaktPvO8QanT20GC5PDVeHM5a6QcoeKsP/dYZu4tTlHeI?=
 =?us-ascii?Q?An9LJ9rTAN1f8W8YMftzfnVFKt7JLYQL9+ni3UFjX/c+gkjX/lFpN0VLnf16?=
 =?us-ascii?Q?U/2e4i9WiVfNJQSIo9tLmBek1BpBYl9IO8cd4maDttiNf3koVs8rJRtGr3Ji?=
 =?us-ascii?Q?rxWKfewo98Tdq+my9zFicfdgTe0r247Ba+4P+Bu9JkZnbzfkkVgAwk9JvfUw?=
 =?us-ascii?Q?p8fkzk9eWgR5wtOCSbhV51gEB2ciIt87AbQB4m30ZsTZLTqqlCWhsPrg4cAz?=
 =?us-ascii?Q?d4pEykxITN7VeJ+VqCnkIaAXiLJLvr6rHiyR2iXB9mtcavrErMVI5qH+0l/I?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ef96c-4478-4296-ad01-08dcd14f2eda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:19.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4Ls3k21a7U4IyPqS1ayrPwfEgs72xnm0l0wpq7GXBoMs7xIdUyy5yVjYm3XqzUhtctCZ8P6JSEXSr8nQjO9mS98ePhpoebLcqqt5w2uLWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6256
X-OriginatorOrg: intel.com

quic_zijuhu wrote:
> On 9/10/2024 8:45 AM, Dan Williams wrote:
> > Ira Weiny wrote:
> > [..]
> >>> This still feels more complex that I think it should be.  Why not just
> >>> modify the needed device information after the device is found?  What
> >>> exactly is being changed in the match_free_decoder that needs to keep
> >>> "state"?  This feels odd.
> >>
> >> Agreed it is odd.
> >>
> >> How about adding?
> > 
> > I would prefer just dropping usage of device_find_ or device_for_each_
> > with storing an array decoders in the port directly. The port already
> > has arrays for dports , endpoints, and regions. Using the "device" APIs
> > to iterate children was a bit lazy, and if the id is used as the array
> > key then a direct lookup makes some cases simpler.
> 
> it seems Ira and Dan have corrected original logic to ensure
> that all child decoders are sorted by ID in ascending order as shown
> by below link.
> 
> https://lore.kernel.org/all/66df666ded3f7_3c80f229439@iweiny-mobl.notmuch/
> 
> based on above correction, as shown by my another exclusive fix
> https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/
> there are a very simple change to solve the remaining original concern
> that device_find_child() modifies caller's match data.
> 
> here is the simple change.
> 
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -797,23 +797,13 @@ static size_t show_targetN(struct cxl_region
> *cxlr, char *buf, int pos)
>  static int match_free_decoder(struct device *dev, void *data)
>  {
>         struct cxl_decoder *cxld;
> -       int *id = data;
> 
>         if (!is_switch_decoder(dev))
>                 return 0;
> 
>         cxld = to_cxl_decoder(dev);
> 
> -       /* enforce ordered allocation */
> -       if (cxld->id != *id)
> -               return 0;
> -
> -       if (!cxld->region)
> -               return 1;
> -
> -       (*id)++;
> -
> -       return 0;
> +       return cxld->region ? 0 : 1;

So I wanted to write a comment here to stop the next person from
tripping over this dependency on decoder 'add' order, but there is a
problem. For this simple version to work it needs 3 things:

1/ decoders are added in hardware id order: done,
devm_cxl_enumerate_decoders() handles that

2/ search for decoders in their added order: done, device_find_child()
guarantees this, although it is not obvious without reading the internals
of device_add().

3/ regions are de-allocated from decoders in reverse decoder id order.
This is not enforced, in fact it is impossible to enforce. Consider that
any memory device can be removed at any time and may not be removed in
the order in which the device allocated switch decoders in the topology.

So, that existing comment of needing to enforce ordered allocation is
still relevant even though the implementation fails to handle the
out-of-order region deallocation problem.

I alluded to the need for a "tear down the world" implementation back in
2022 [1], but never got around to finishing that.

Now, the cxl_port.hdm_end attribute tracks the "last" decoder to be
allocated for endpoint ports. That same tracking needs to be added for
switch ports, then this routine could check for ordering constraints by:

    /* enforce hardware ordered allocation */
    if (!cxld->region && port->hdm_end + 1 == cxld->id)
        return 1;
    return 0;

As it stands now @hdm_end is never updated for switch ports.

[1]: 176baefb2eb5 cxl/hdm: Commit decoder state to hardware







Yes, that looks simple enough for now, although lets not use a ternary
condition and lets leave a comment for the next person:

/* decoders are added in hardware id order
 * (devm_cxl_enumerate_decoders), allocated to regions in id order
 * (device_find_child() walks children in 'add' order)
 */
>  }
> 
>  static int match_auto_decoder(struct device *dev, void *data)
> @@ -840,7 +830,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>                         struct cxl_region *cxlr)
>  {
>         struct device *dev;
> -       int id = 0;
> 
>         if (port == cxled_to_port(cxled))
>                 return &cxled->cxld;
> @@ -849,7 +838,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>                 dev = device_find_child(&port->dev, &cxlr->params,
>                                         match_auto_decoder);
>         else
> -               dev = device_find_child(&port->dev, &id,
> match_free_decoder);
> +               dev = device_find_child(&port->dev, NULL,
> match_free_decoder);
>         if (!dev)
>                 return NULL;
> 
> 



