Return-Path: <netdev+bounces-108874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD29261E8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940BE1F22707
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A471E891;
	Wed,  3 Jul 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7HKOynE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4553A7
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013631; cv=fail; b=pvQfGr+Xl5MW0gD3E/MPbrLoAWs5LTZS+1LrOaPnoUZogFY0y2XvGch5eOkWdwzCPNL/MaKE5ruyfvsydqPzmyVb/DXoVm664HisCaw72Uyn82aVsmB5oLBuVlTYm5E0/czPxsKifgBaymJe9xOfD447HxThoVNdcsEXptNAXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013631; c=relaxed/simple;
	bh=d77gmojGd1/F/SKMRki7yhfgbkdv6gH6Q0lpGZ63nZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flKDXCMiiqjw7zv9s0+K9lENnx8gdjO7Byc3QlJH/W0EftajDR5wWPdTG4MWKaSGRSww23zY39b9fUk2UV3R/DzlHBUUObiuTTy6joufJUZHo9NPDGmczws4ocTcMZwyaQSMPVL8kaJlmksFnIIyslz4WXdeglqYK03cK3bmlmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7HKOynE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720013629; x=1751549629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d77gmojGd1/F/SKMRki7yhfgbkdv6gH6Q0lpGZ63nZw=;
  b=I7HKOynE0xg7rEis0bwxbjErLuzjovAgum9UVC8cPDa4I13HYGju2Tzh
   got9q7zNrlIuujSvNtiXDHbbyoyVJE7Cm+k4v22XPiKgarqNhE7gFuoqv
   21s4twxEBB9dahkat7t3nCGkZQl+tsCwvDI8xt1TrgwPWREyZCaE0Y27O
   HNkzlY14rCLZRDnpljXFcyW7MSFLmSeZ+AlK0CHkuRMIwcDwdH8WzzlFU
   kkO/09VO6N0Y586Wgr4GtCbRciNxXfLxRxBQle0SgD53aFPd4wvzOMD8x
   D8Pvo8caJTuiHdRsqja8rzhk9t25ghid8eNd+HBW10ZRwSKFX4YBXMJO4
   g==;
X-CSE-ConnectionGUID: APrVb9S+SEmIGOfP3r/pfg==
X-CSE-MsgGUID: PLqic6yZTyCgEnrBAZq/ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17452519"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17452519"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:33:41 -0700
X-CSE-ConnectionGUID: /JWCbXYOS8a1u1PGXaRyjQ==
X-CSE-MsgGUID: te2xLcHJQZqFs3JooBg00w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50696273"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 06:33:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:33:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 06:33:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 06:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib1Jngdk/HBz62wFkMA73nOI2Xy2u47MvHbOvDjrq0GZb9a1xED2sE7u7HySn0EtcvplOkm/cDJtfSHj5QGnPGSP3udxu0qMQ/LI2DHZONGGmWCb+z975qNNiUhDV7RN6VKbmahpiV7UPcYnNlGiNWv+LTmqX6NvJjMHQ4idNaxnV77u0m0oygUvS3/Kc1IjeyTfK0tWE+mDo4O6/A0omxP4hSPRSjBc5o79xqyouO1LU96uTUKo54n/YkY/rK5ZY0maYmjm1uZywc0UhVTLBAemKEAvl0S6HpqddL5Cjjk2OsY3XM2HGbgX+bALQv1v2t1CDilDvmYTwdIIwLj+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGkgNumCSPya0Bti5b/GRz/1g6pf1aG+2760lWbfyso=;
 b=MJCiKViwq6zPVHIy6ouBzDclfimajRj7aRO94+BDwlLVQVBTVY3i+LzBCZZQyv3SxGqm4zrw7p/fs5lilboNmbBk3t9JFfFTMiYDZhpL1m6to5oRPU1JOUJNrXCSGJL4r542dj13LBKB+ful8bNZhwiqeT57y/E3cNfdB/r9F4y1o+hHwBJ8qteuE/Nkc2IAfb3c5elWvchXyEEWDVSMReEftgQngyERnv9m9jBO1pKrIE5GQJkUXOghDyQVI7kex9yd+7CrA6fOoEbQ6zAzc4WoK3GyqU56TsjAQZdkvu0Q8jn+nAEKVQ+NkzfNToH7hslHN5kOQlnO3+ylwPB7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 13:33:37 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 13:33:37 +0000
Date: Wed, 3 Jul 2024 15:33:24 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v3 2/4] net: txgbe: remove separate irq request for
 MSI and INTx
Message-ID: <ZoVTJIGmBMP4gCD3@localhost.localdomain>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
 <20240701071416.8468-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701071416.8468-3-jiawenwu@trustnetic.com>
X-ClientProxiedBy: VI1PR0102CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::16) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 855cbc42-f441-430e-d7ed-08dc9b64be44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7YFvv7Sq4INs4w5XbL56B694K/3RTRSe1cbumHAC/xUgIL4lJEUbLvKlle8P?=
 =?us-ascii?Q?ukq0MZ+tN+ac7clExBHmxJqrjUfMeO7B89yjgQJ6CiDBIeQ+JBmsUoNsis0K?=
 =?us-ascii?Q?1ZQspvPUBMVivZGKTBW3XiGDzETvh8wSD7QhZPZ1H0+SXPzML+wNX8IZ0iAu?=
 =?us-ascii?Q?dv5d49wlXu8XTtwQqQ9c12iHzQe4mk81/sQ77TxJrQn46OMesL2r4NhOv/sh?=
 =?us-ascii?Q?0m3Yozt3szZrWD08qIUqY70XP91sl8Yf4pKx7KQImTcDpj3S0i7cGEfLQaoM?=
 =?us-ascii?Q?vR6DM0UB5OhN7SOGpvBVKNWZ46NMFsSGL6qjNTxmCTzFWDDe8zjW0TmpbTB9?=
 =?us-ascii?Q?6O9Sc9VxLQ74787XTXuacGXx1mhiSs5U4Wd6fVVvNW2SB7wTEw0iDMT5wpZ8?=
 =?us-ascii?Q?8gQexspwi4avYgmELhHcnNI4XrahxXRusuu0VUC2a8K2hbFo2j127Tf7DrWO?=
 =?us-ascii?Q?Q8VyBfySvxGLOkZ3yD2lRprzf5SBPCOZ+QQoaj+5eWk4K3LeewylKr5dDGlA?=
 =?us-ascii?Q?GWcF1yIn9ffcWFufzeICicTfgS5sOojpzNOg0+EEc0gRlPtL31xzntuoV4bW?=
 =?us-ascii?Q?8eW1wLuII47atGPAIuqW06XvGuuueoGokfBNSDYqhNmuFZRMQCBhZkFWXYrW?=
 =?us-ascii?Q?DG4vvX5JYVAtru1//xNpI5Mutp+QzeeW7xJiGuS1jFkx7PVomUfbfrN3WJpD?=
 =?us-ascii?Q?O7fX/l5xlrZkeNLITeYU4CdpI6CkIUpwpkWM7xfMhwNSHDyFHvFCwESKDUvd?=
 =?us-ascii?Q?8UJ6iLHhBvUX0Oo6Re6wtypcqhgXZjO0ppXigWeag2Yuq+kGMfL/YoMuerjp?=
 =?us-ascii?Q?JYtZzmC1NJl5N3QIe2WHp3juN+YG4bh5ydaOp6YQNC1E4jvLfMyBDgJ92lo9?=
 =?us-ascii?Q?iSfaKXLWWWiy0l9B090yEgFy0aH9sY5URwC80YXGInxobxAzeCbbfQnaPbzA?=
 =?us-ascii?Q?i7w3acnJllB8Redv1Wbjiv31IzD19ZSijdy9RO6g2S/CfFC35qMROIzaIPAu?=
 =?us-ascii?Q?7wstComSRFPMpR5hOhHP06q9XGa6pDRjLou0KsiLmBFcZh1bVDxvBAsiQZ/q?=
 =?us-ascii?Q?59xLJz3D5kbGapS03ARMc3hC6DY60gVPlGhRE6f4OWPQtdzO/D5/CLrG3nnV?=
 =?us-ascii?Q?i5pGBJZqrIVzFA7/synIkkanqeU4nUgRFdKemaJYwORlnifpaxMcYi+SqRyb?=
 =?us-ascii?Q?WB1+ZziJDSJhq3J7souWRtk1URlei5CLVxBejRsaAc/5o0EKRE/SR+IT3eHn?=
 =?us-ascii?Q?jCzDksTSMmEMuY5JT878/r4pdbPldlDf9rf3oIoaQZ7s7XoLe2jdX9O0H72t?=
 =?us-ascii?Q?sGW7LSKGCHEqIvJ3cAPGvXd/dRy6dpW4TSgXr3HUWCwNog=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnPscvKmQYdahsvqIpHYMJ7t1dgaKbN41l3/afNkxzbMLdIKdUaS1vzxcP0H?=
 =?us-ascii?Q?35ZHWQYv2NSfOTOVGVLZ4QoO6+BNAqXsV4LKUqZkH5xd5eTdrFm9TofvtyjQ?=
 =?us-ascii?Q?3QX2H8SllC590kvALCERo0IBjLXx5/JD3C+JUOQez7JpMHsNJ7I6sNYTBJOZ?=
 =?us-ascii?Q?JopduQ5dp/y5i3B6uskj1d0tZR0iQERMyWih5tkRDCm7rbmpxApJBZKW2cb4?=
 =?us-ascii?Q?q617Hes2v3sYp0r71FyC197nx9v+a0uX7mbcef6ADG3APO851D6Oqy57ktbA?=
 =?us-ascii?Q?+PVIBhzf/L6KGKRZjmrP+UuXwW8febbr696Hn2XrAc5TCthyNjk8lyqxplXG?=
 =?us-ascii?Q?+GMItm4t6Y3sidr2fbySsWNS9kGJAKaBYNak7MVKGXa/V1LmjIZD3PDshp4g?=
 =?us-ascii?Q?pZyuKrGYqVsA/bs1+78mx3Vlh0HFJwjzE/ZzsEoPIkq5QAqgWJsjLoVuAfzJ?=
 =?us-ascii?Q?K/YrXjlqN5NOtmLewEKTmfN7vcayy5LiAuKpiACuSNvTG/MIU3tX4gX3zacR?=
 =?us-ascii?Q?AoYH6g0cqDboAxoyMJtwbotCubAJhTkm4JxbxyHyHqOTbAjXmnzGReH1F4Yz?=
 =?us-ascii?Q?uAPJRsRATW9ZLf5fSWdVY/uLAURyi3Wk98EPDvx0I7NDiUYBdlQm+Txi9cAy?=
 =?us-ascii?Q?RI+vSFNTgbCudE1HTrtKWeSHiP6hjHtkFgJPP0RPNS8/uFtRjr+AMp6ZC1d/?=
 =?us-ascii?Q?Ege5H/n68NeomXYZAJf29V3QQvKHYa9xvGyO1wwN684MVEeaioN5Amb0IS9O?=
 =?us-ascii?Q?H79h4ODtqrfvQAl34yd2j2WPy77ELASP5mF4DB0B1qaYpdboTNRsm8chyYv+?=
 =?us-ascii?Q?9xPhZrgTp96sMotUvGQvZdTtB13KHg6UNb/5H+tKe6+r6zWAjB6R5MZuG4Z6?=
 =?us-ascii?Q?MmpWIEw3K9B7HU9RBs7iQUK+Pawm5e6zSD3y6iDVpHCNOtqo/Yzwu3ATZzi8?=
 =?us-ascii?Q?mz+XmZrBF50u0gKKWb2PiVwRuEKYSlRCnoAhO9nm+il+0lrsPm7VsRzPYS5G?=
 =?us-ascii?Q?rNf0dltHAQrF5uZEmpCzrFfwWgE+BZdJr7cq3wHkQUQecKa9Ya9xSr7QTLDt?=
 =?us-ascii?Q?rmnlbiT5YG9Jl8WrqRVcborkt+SDASphv9I/8XKh8UjX1cb2MJy7HAmcYDPu?=
 =?us-ascii?Q?uMXCaQsbHpuyADV1U5nRx56Y6AekzVFsf0Tv2sN3C2iM1uR4nhA5geKWlR9e?=
 =?us-ascii?Q?+xX8BSN8a2xjBKyYHfxppl4SchaA8vcX+z0LFnoMDSfv4k510S5qvxfnOs5L?=
 =?us-ascii?Q?AP6kwZUEvjs+4SWdp0H23N21R7HntCpJqsftTCUGP9q7um7+1pknztGM1hro?=
 =?us-ascii?Q?tp2LWxjDKk+iqchJycWHUXpZAF5MWFVmFc1noZcaNyknZGFDlPi0hi0VgS6a?=
 =?us-ascii?Q?HV3MbGolVBWrIGSjMOunNqkDD8NjF1uPwutpGTTk3lEBeZz1w6VmwAWNSsj5?=
 =?us-ascii?Q?5+28zSd75ekEMBV99If4S3pFZIkpGdWBjJiB6wO9Mjd+xQKCMNkmEwfKsFbv?=
 =?us-ascii?Q?v+JI5WQo1V+9gbzUymFNNsVjlR/0FlvenLM7X9S3jZbgHKgf1JQSguF4592z?=
 =?us-ascii?Q?QPZ9eHa4hqWHAqX1jC4/eA9CWIS8NS/qfGJIB3Cntl3TVWkrtKbtcLwhaIKK?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 855cbc42-f441-430e-d7ed-08dc9b64be44
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:33:37.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nc0OoFymPZoMqLbBMTSMzz3AcbqiHROntpdvpboiWc3afnoTnMFbch6+TriTRUbE/RnQcbNfH+sgIi1w5XrN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 03:14:14PM +0800, Jiawen Wu wrote:
> When using MSI or INTx interrupts, request_irq() for pdev->irq will
> conflict with request_threaded_irq() for txgbe->misc.irq, to cause
> system crash. So remove txgbe_request_irq() for MSI/INTx case, and
> rename txgbe_request_msix_irqs() since it only request for queue irqs.
> 

Could you please provide any test scenario how the crash can be
reproduced and/or add an example crash log?
Also, could you describe how request_irq() conflicts with
request_threaded_irq() in this case?

> Add wx->misc_irq_domain to determine whether the driver creates an IRQ
> domain and threaded request the IRQs.
> 
> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  1 +
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  5 +-
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 80 ++-----------------
>  .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |  2 +-
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
>  6 files changed, 15 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 7c4b6881a93f..d1b682ce9c6d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1959,6 +1959,7 @@ int wx_sw_init(struct wx *wx)
>  	}
>  
>  	bitmap_zero(wx->state, WX_STATE_NBITS);
> +	wx->misc_irq_domain = false;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index f53776877f71..e1f514b21090 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1997,7 +1997,8 @@ void wx_free_irq(struct wx *wx)
>  	int vector;
>  
>  	if (!(pdev->msix_enabled)) {
> -		free_irq(pdev->irq, wx);
> +		if (!wx->misc_irq_domain)
> +			free_irq(pdev->irq, wx);

Does it mean "pdev->irq" will never be freed if you set misc_irq_domain
to "true"? It seems you set it to true always during the initializaion,
in "txgbe_setup_misc_irq()"?

>  		return;
>  	}
>  
> @@ -2012,7 +2013,7 @@ void wx_free_irq(struct wx *wx)
>  		free_irq(entry->vector, q_vector);
>  	}
>  
> -	if (wx->mac.type == wx_mac_em)
> +	if (!wx->misc_irq_domain)
>  		free_irq(wx->msix_entry->vector, wx);
>  }
>  EXPORT_SYMBOL(wx_free_irq);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 5aaf7b1fa2db..0df7f5712b6f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1058,6 +1058,7 @@ struct wx {
>  	dma_addr_t isb_dma;
>  	u32 *isb_mem;
>  	u32 isb_tag[WX_ISB_MAX];
> +	bool misc_irq_domain;

I don't think that introducing a kind of global variable to determine the call
context is a good idea.
Also, it seems that member is always true after the "probe" context is
completed, isn't it?

> 

[...]

> @@ -256,6 +190,8 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
>  	if (err)
>  		goto free_gpio_irq;
>  
> +	wx->misc_irq_domain = true;
> +
>  	return 0;
> 

Is there any chance that member will be set back to "false" after the
initialization is completed?


Thanks,
Michal

