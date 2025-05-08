Return-Path: <netdev+bounces-188809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F3AAF001
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0704C8691
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BF7DA6A;
	Thu,  8 May 2025 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV9n/rWo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047E2AE74;
	Thu,  8 May 2025 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746664401; cv=fail; b=MCTqs6StdIJN3bacX9ZyjPj7Sd6MOtH7kQsUXeafyh1tSzWmM+QSvDbcUL2zoJETPmX4PJqOHfMBVW9h+Nma10aktsGuN3oy7m1VYWUzyb9R2U4F5qJW7XDKQf6EyFbe2AudhE8LHUHVQvT26vlMx9ZE3XvDZHhvelHBnTW5YQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746664401; c=relaxed/simple;
	bh=11+H40gHGPb5rZRK2GAOkxOt8e80oIo+SqlJmfMDV4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Clf9O0kQCf4F2Tx8e6/eDDrwwVIZxO5yHBnC99bbmsr412/5UPllm2yhW2teXoi8y7JgYenTbvBGx6KX+b1eHmJquDIwao7mEs3UeB0s0iBnuI97Pwd3lQ2kx9AgCgm2OXS5kpAXVlyqgpRf9OcKdkLOlkQ1JJTfpkNlqolWn1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV9n/rWo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746664400; x=1778200400;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=11+H40gHGPb5rZRK2GAOkxOt8e80oIo+SqlJmfMDV4A=;
  b=nV9n/rWoJUuJBpQghSr8xBSE0INCzkJJeK/wnrcLrjGkPPfz+O51cv2l
   6OwJRWDLFRtyYlhsNVLT9KPPWmpvFmriBb8Ee3HYXc0H+I0ftMJANWQOk
   KI1mDZfWcFgauzXbV2v2XGm+I7IpqI3HDwUBo7Padw+Ss9EC3XDsrrFFm
   nEVY+UBrgssrvgzKusxARF429dxcEt66DTTcQpw/fnYvWNSN5CI7nBb4F
   AHN9PmEKaQys7FVspulZ0KZTYU0+RYu1W18KXKBFXviLIloccfWzRqJ/l
   tYgU/z5x59FLJDVtwK62bQg0Hjd+Qd7LtyLZ6roggrwPG0GW5rY6wKPRF
   w==;
X-CSE-ConnectionGUID: muLEOrg6StmwzV24DGUZYg==
X-CSE-MsgGUID: MAi7M2CRS360WKuUQNmTZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59415502"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="59415502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:33:18 -0700
X-CSE-ConnectionGUID: +KPl4WIiQROQM/6kKoekcA==
X-CSE-MsgGUID: OToIBdb9SJmR9PsgzLU10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="136638610"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:33:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 17:33:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 17:33:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 17:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ91FxQVACS+gENGC6UJ+1BE/SVspJH+GEWMjjCFVVZP3xbFI6O66GGR4JN8RPYmwBLayLsgb4CC4sqA3dCzDEdYUV6W9Rhcq1VMaelLhZNnyXP7Vsmo4YDXhSRzpBhZProO73iH5qC7LewqeRQlLMttxLcXIxtuSJ8Y5qRUHqQ3Kejipywh+hBtL9taVaclC9CMlD/94oQOwGAqcWXTMQOOQcVDCpCqOezlo1q+MG4c6UHuRTtwM21+iXEDO4aBruttGtTIC0RdJ5Fv5blohO7WAQKfRnQ8XbHUIRB3yHicfj2OtZuIUSU1+vx2KhYWp3ilAsYVdczlAErVupCFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtmc8BNPFjqJY52SuMJ+aTP2NToRX/mjvLLj3qskkRg=;
 b=XTpTeH2NmzC8DoMgyGaEokd/Pe1JKYFxhvoWCNqn0M4Wg3HWboLNWcbeZsJEEbWxw83Zb5fSgBXczhVxtESWsmn9wq8eio4Cz9KOXnFXSpiiXWuB9bJRI0G9fpELKJAy9YdzdaKwbALHobLYoBaX8T9F+70XYTMZJ1UAdrb8qoloKk4VxdN0aGzZOlw/ZhKNZfwiS2aXGPAyRbn0ZUME539ejeZQKFkwQRYdqkfh6BA932zfoPCZ1vHHY6v0/ZYEtAbF3ehxX+8F0t7PgR08MGR1e0aYXkjBfb9vMwzOGAjBSiqLH0l1/Viu5NfScVN/QCT5IZX7is2O+Twa9m8yxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 00:33:10 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 00:33:09 +0000
Date: Wed, 7 May 2025 17:33:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
Message-ID: <aBv7woc3z3KSMK8Q@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: b1977665-5a1f-43b5-651e-08dd8dc7e8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JVQyCLpqNpUVse7nkx1A6KwB+YsglO4aZwN6I8Zf3ydQ30KXwmNKKxy0IdLp?=
 =?us-ascii?Q?77YWF8xiHlJv1rWIknIfdIJRSD5a6qtFiBW4s6cRmL5cLbxdshEFJhpmx4wv?=
 =?us-ascii?Q?jfKKhtMxtpd8f4UBq51OdtrOcURCquxu0Z3N94AJG4qXc2dBqx7RuH2+zmke?=
 =?us-ascii?Q?7X2xF5BhTJyGtD2YJiBp1stnaWdgB55y+2X9YtCcD614MnlLk7bsWW5q5//J?=
 =?us-ascii?Q?pZ6FfaAN2BrAesJ6YqBzA4H/Es9TcQ8tkyFba+QVZJf/GFUnZDvXqweBbk9T?=
 =?us-ascii?Q?9hK6u5lKd5e+7EBhPwVbQq+vyccQekSBSnOrhrbF9FUzj8DvbfSuWHf++rR0?=
 =?us-ascii?Q?psx7fZgiOTWyjmoLnkyUBS2aeHX06CRXisTTEL2BKzf+dwAYeesM03iYnAF2?=
 =?us-ascii?Q?c6hJA+HtF0SdYBHl6qzyR/z6FjywZYOvasklfNiCrbBG54d70VjZrEVIe+WS?=
 =?us-ascii?Q?v3kNYQBi8yIRnks7YYxIj83oCbhniDbehvbmZJ39+fNA4IreiuycoobdbkQn?=
 =?us-ascii?Q?XI/BKoznJkBFKIkXEtIFvD2TIDDEeACmVWN1vAmJGX1/dna/bNnECP48l7iz?=
 =?us-ascii?Q?VrPrCKRXZ1Xgx1yn3mvivP/isp/B2LCOXXmYm4IqCiXp4ZIbOkFrBExR8CJJ?=
 =?us-ascii?Q?texaSah+PueHgkEyLJsCP2BKrN4pTi1icxw4EJQNVRj+hUmsZBrU/E8B1Xtg?=
 =?us-ascii?Q?trdUlDlPOK2PCozioWmmTAwAr4tZ7J+4v83TSfigqvmuQCX/2dblIOebJsXS?=
 =?us-ascii?Q?rdCP5FhNP5O79A/ke5NmXjS62NCX7ukHEiSdShcr+NSACZEXbBI37T+brLHK?=
 =?us-ascii?Q?5/FfcZxzRqEE63JG88B0yVM4VK93MMdzDNTCYMBWvPzJ9tUmO7Jr0lhhPRP2?=
 =?us-ascii?Q?kN/LOANkJ4HLK4vx9yweBpDl/ozKniy7AUz1A2p9nok5dJVQTsWk9qAJZvmH?=
 =?us-ascii?Q?ntSzwUXYQrE+M+n9P2BDt0MVdRbFMTleyy5SLe1jbzd/OieRB4poeqJjwwI3?=
 =?us-ascii?Q?xNkM71OLaJeexMjg+Ye4fZ0Cpo5QhT88jfuZKdZ+GiYBSvr6OajgDeTkLeG6?=
 =?us-ascii?Q?hfHlLafh/T9pLtB3+Cx3Vwvus3Ucx3biVu4jGbPMV9KQNDvflNBbDWezo/BE?=
 =?us-ascii?Q?7YnSHI6f/XxlJr/TvnKAwmCLwR0vGtGHKB4zrf3eACqPHJfVpH67Xh4LfU4S?=
 =?us-ascii?Q?g+dOq3HYSnvNVZn3PW3iGNNiAE6zaSxVDN0Ac8U4LmcZ/ngPaplTmEgGeI6r?=
 =?us-ascii?Q?gge7Elsq5t1PQPYk0mFCVYCkvHR3ZOLAp0pwaTh0/tvnFRjxLbNyQqMyVkg6?=
 =?us-ascii?Q?BZ6+CclaH6Cg/loqcmZo4vOl0q9EAAhgMCT+x/7yTTo0O6pfjWSWfFE2BlHR?=
 =?us-ascii?Q?cFqW7lz+wtZT0Rh77esI5fv2CwBAHqzm9Jj3QUhtpKexP3Kr4sa46mZQ02PW?=
 =?us-ascii?Q?N4cHSZR7wvE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3KGvKmfNAADPKpqIGXnI1phz14JB7CaZKdzGhXy6Nx/NwI2Va856JISa0Bj?=
 =?us-ascii?Q?ImoJO5Rq+QCXyMsZa518JAehWGf5eu69PFkZDuGRxIH235ooBkH0i+L/hi40?=
 =?us-ascii?Q?WcQRpOOvSpoe6Rxm4lGVBnjPy+Z965EjFRgR5mIitj4ZYD4GvwfyzBIcAzSz?=
 =?us-ascii?Q?rNxKp845y7aFOjCdwhjMZVkCqjT9pNUxtoFbnRpUme3F8sIP75axNOSG4tr3?=
 =?us-ascii?Q?yBZyyIwZEnAPMZkZn1pP4yeKvgyNydJSWUpUgRkFSZ7DKrSoKi4j5gdXpPgZ?=
 =?us-ascii?Q?eIJCNIZCGaelkpGkguipy57GMyMkZersyr0jtj4oIwu5hnn0A16fUVKQOYo6?=
 =?us-ascii?Q?K414PXjMjbENeRB2I4kZMUJNPXO7UZDyaEBy3/cAXMJBGhAMQM/Yafp0lVtj?=
 =?us-ascii?Q?m9Q3pA95b1vljRPCdO0Bt+8c15R7+QqMknQ7GZKX6B6ucQk07EYVZcwT4GUX?=
 =?us-ascii?Q?RuOcTX5Y13TWKF5bpTov60FrS7JXn3IffFv7H+09SMfdP0UFr9960hdHfpZ9?=
 =?us-ascii?Q?jz3czefCezEykDPSmYUJeYY8LYsTWwK9sVE1kxQJT5EXFcpPm1CcKgsE+2FF?=
 =?us-ascii?Q?v8go7iLw0Qmn5KZ6zzSXosO5JTsTZ7DBZy+zXHYHjitjfDEkyhiWH6NIRfLu?=
 =?us-ascii?Q?VKC+M2GBTjFpjwpEBB1jl0QpSxRP5t9+vACCJ88NbJR/JdmrwNpRUGbrP94a?=
 =?us-ascii?Q?CqFJW80YZW5Jh2iX/w8sk1g4abWVX9W4eFUUjJ2+yAi1vqnCfEJrIhHPa6EB?=
 =?us-ascii?Q?pcNXDOZdDKpmFPRCRXeZtIU5l3DZ4UtLXPUJu5Fp4gzbMJ9wb8lyyZ4CQF0Q?=
 =?us-ascii?Q?gdqWiL9t/tLT9AjpO9d7J2kQbZ7H7yOpo8N0tbfLUus9DcstkC2GylbTBPww?=
 =?us-ascii?Q?RdQ8sRiN9hDAZ9VNFscEtkx1shAseLZJPgVHMBEIl0euJo0/QzB0oBB/EvU+?=
 =?us-ascii?Q?tgEyZDFaiBhTSzc1EIfDrsbGGF3QZ301JnMENJxDnge4aNjnf+bVATrxJ/Cc?=
 =?us-ascii?Q?nU81Ve9WEMXhYWvmBTd+o3/A/d0L3mgndaEAP62NrxBXVEB7zRwrphQ8HlEy?=
 =?us-ascii?Q?bY2NwPNVkDpEJK0gInKw2R+5EdnKcePpmCseSq7heKuC5wS5vyx1FMmCkJAi?=
 =?us-ascii?Q?TAd0UW1N11zujwS8b8GBDDfMPT+MLyrejbYj6YV59JJLh5Q/I/cVOD4XtqQ4?=
 =?us-ascii?Q?FgeAN8xZUqyJlN1g8X8TiCz4MpIZdbl8PeTSolrR+y43K7gAmUEy+iK3ZaX/?=
 =?us-ascii?Q?qYJNvszdRMdwy6rsHfDCkFZIhW/Ys8eRD3+1y5bE39fPYeu7DT36nzrWC0Rp?=
 =?us-ascii?Q?QB4fmN3yIlU5EvJsSME4IdEd5oVDKWX9eSjFgrLUme9CDvMRp7753KtDyxpl?=
 =?us-ascii?Q?+DjWT8n3caLl53DNHeGlS+neKejt6iRpSliu47wYzsrw254qKFxB+hE6qLJv?=
 =?us-ascii?Q?Ux8e7Gz7YoJoAysIqTpP1G6lWn0Zo33VjPgcEuA08gjXkno+aOJKx/4y76uK?=
 =?us-ascii?Q?xbErjuraLhwmsw68GsG36RHGMkPUdHEUa7g6HN3QOsrWNJOa+UUT39FfZVW6?=
 =?us-ascii?Q?zOGGkasIzBotERWHYKQEJylcqDDFr9bLwoxFle5c0eL8eVeU1PtH7+AyJWtK?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1977665-5a1f-43b5-651e-08dd8dc7e8aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 00:33:09.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU4eVkneER9XRwPWELOZDEGhRMcVrc0PWBWrrW4kCkXYd3maGk2dd0tpbCbH5ZjdkwTt/Co+8mQfDuuFtoNiisXpWuYCbnhUDF6L/Ue5Q+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:05PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index c4c43434f314..979f2801e2a8 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS >= SFC
> +	default SFC
> +	help
> +	  This enables SFC CXL support if the kernel is configuring CXL for
> +	  using CTPIO with CXL.mem. The SFC device with CXL support and
> +	  with a CXL-aware firmware can be used for minimizing latencies
> +	  when sending through CTPIO.

SFC is a tristate, and this new bool SFC_CXL defaults to it.
default y seems more obvious and follows convention in this Kconfig
file.

CXL_BUS >= SFC tripped me up in my testing where I had CXL_BUS M
and SFC Y. Why is that not allowable?



