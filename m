Return-Path: <netdev+bounces-191704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63492ABCD49
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665BD1B64C71
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AEE255F53;
	Tue, 20 May 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGWvzKDV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825B19DFA2;
	Tue, 20 May 2025 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708679; cv=fail; b=Eb0hIwPwAtWTECx6nRFrMUjawytd868MubKnfAQLGsVkvqSb7qbAxv+o43Tc01BgpF/9szJlGjc7FggHinP6wA+O154RJeTKSfmhVA7TY8S42CLM7opJZzqtOI9NzjlG+cef1qtCkZ2TyWywB6sIUNwWf3cTgnG/r/1q6Zl6+wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708679; c=relaxed/simple;
	bh=ixkhI8T2JR7oFZ9smpzAQdJ3vSosztYk2q1gkVEW+WA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTDRHJMXmr/mvGsdeVA8HNiDBdSH6mq6fqPrkbGTw/JP+DkuvHp6Eefy2zlVcjwDg2dOZATnNAiri+jjaCUf2tgAkv68S0TSjfrSinP3CGs4J23jB3K5Vpk7fSlRgFG+Cp1pIqLWAH5BLB+nfqouR86x1wzgmnhTi85maSjTmeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGWvzKDV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708677; x=1779244677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ixkhI8T2JR7oFZ9smpzAQdJ3vSosztYk2q1gkVEW+WA=;
  b=IGWvzKDVYx/Z7AGn/f534QxeB1TeJZn36ZNa7KQVWokdwkRDzMa3sIjx
   9pDDePvvZ1ZcVEGdYp0/jS4gIA1Hw/X42WpSlPqYmqtkeQPDKi3ylPnn7
   VJTvfVF/pSIoKLRByliiO0rtmR6BE80C7dYl5tLCNf8Wd8sV+xPqvBe6u
   k8iQc0oPSi7DQTcGU6Vl1fydibGoU9JMSlqZ7aTWfobqOWCrCnocEYzDK
   gPBe3/BveGza3C+nXlB1AGYHq7G4gaIl6YEi005gejHBT1IwUxBrBx6nW
   YLHlKv9HO1dV+pAGGjYENoFCgDaqqjirE5YE/mXQfsXADYqKjaWvUcjT5
   A==;
X-CSE-ConnectionGUID: 2RKYlUwqTjOqFPUj+byMRg==
X-CSE-MsgGUID: y4CvefeJRXSxinKB2rsveA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49323907"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49323907"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:37:56 -0700
X-CSE-ConnectionGUID: oPP5qjIRSMS4x/2UKv4vgQ==
X-CSE-MsgGUID: qtT0aFlbTx6xpeYgANc3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144301773"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:37:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:37:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:37:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:37:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BneezC42ddoz6YYRnF+ULuOh5xvUeFykvyyl5aFeGk3tzop7IQZ2B6pk4R4x7P0dFpoyTTLelnCpgECIxUztVXwtOsemRyYePSUWH6xba1biThtT3hjCKWkzluO5Gd8PzM0QqqZZ0xXkoHWRH4GptK8nSGt3lUV6FcpQXVkDMnWCKrywqbgZOhqYROuynKbHLkd7ay29HQ/8qgtH2mbPdZiWN0LdCEPukhQbKOVfUlcuUFSsrXlqzhLp0HCeLdYkwvavl0zm7ntryg9epO4OeEExtQIwT9p0ScqVSA8bXICHCa8njwO5RC1BVxFZAG4eb/ZlQ0M8WygolReeh15yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnP/9PBYjQZ5GFjz6nu/XRABBv4wkEVaUDA2Srkbeuo=;
 b=tFtLrKjEXeKzMcsqgQM33HDksUBs48lHGPwWH74RjHaQl8WQACa9VE8CJrUwpe8JRQ0TY5/y5IZjUXWEHn4H1Ghw3dzN37YdkUAiCmjw2JKQaBtUsVOLoRkOWS5g91wieDxAfISrVZHiRcLDjdH4BvpBD9ocB9ELYjkvL3chtXZmh4fBSYGUnkxgpOIjMtOtNxDkwuzmSGXh6Rx2MSDPNM+OsoLi3r9bCDDNhyys8MUj+VH4oWKtcRlgZ9a3UaZZSKd39VstBtAJ6NRVj3LqD+o0qPwYOv+nwyTNyxj+YUwYD0q7WSAsogb1ccC0FZ1pir+bcfnatCFMTqyHBPH0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:37:52 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:37:52 +0000
Date: Mon, 19 May 2025 19:37:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 16/22] cxl/region: Factor out interleave ways setup
Message-ID: <aCvq9llXtLjbO4iE@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-17-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:a03:167::28) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a3f593-3ff9-4efd-ea20-08dd97474dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4q4f+DPBQR5yINKfF41lE2a3nDHq0k4kZT3zXq9Hrtow0i+967CjmiAt6py7?=
 =?us-ascii?Q?gBla/GIoJHGFKM8ifg8EylUzPqRkrkLMduN7YT1T0rvhtuk/RxD5HN0gywLZ?=
 =?us-ascii?Q?ZtkLUeifAAxA3VS8V7oLkqph2Y8UJAvKQp7eVZwoNgr1lfBNZjIjFrbDJbha?=
 =?us-ascii?Q?1Dr+MeHIzCMWchBa+Nm2lddTcu+cL6bq6UHhyPr6fQnOc48cFwvAhHc5pFEJ?=
 =?us-ascii?Q?aBiPR2HcewcZSB15DYBwMqQVjIB+h5fiG43KpxnizaMbKy60fY1TGPNZfxGp?=
 =?us-ascii?Q?7cMeWDq+3fkZuZJZ+jOluoT02r0IFXP2VuJuncnxxmeuq8S70+ukyjI0TkB+?=
 =?us-ascii?Q?TTvNk8FMqoakIz+Ij9dOS2aUbxgNcfVCIPVOjm5RLO+F4ambK3hdSWvNlCTs?=
 =?us-ascii?Q?7l08euq9kl+UB/wvQcLvkDIadDswfcwf84U3lsKqyMGmFcZE4O0OkwU1UXXG?=
 =?us-ascii?Q?WK7IiUGv8BuXyBUXcERKLengCjXzJyoUGSDdC9tmU+x55u2xq4SuDaX4So24?=
 =?us-ascii?Q?xGlrFmOVEbDvx6kooFYXZ5ZdNbhn4YTq6WeJ7bxiKj5CG3JC63yWsYazstnv?=
 =?us-ascii?Q?oxFedlXAvwZaQup5ADuDNYeNee8wI/nQhIPGH32bI2JKLWrbgizrByMubgmN?=
 =?us-ascii?Q?GdTPlt6yVFHLQ7/cEHG6s7PZtiX8Ukqipu84Hdn9kHWoNuTT5muc9IUmowjb?=
 =?us-ascii?Q?W9risVwrA6Ea/8qoqg7Gi1Lo4SfuKDUCJaBd1VKNcbbmwmFMvUe4biWIguYm?=
 =?us-ascii?Q?a7bL6fpgkIWy3kPaorFMR5xdphdCJj9Am8oZa5Uxu2uxhP0oIbyQtDZZfUbL?=
 =?us-ascii?Q?dWSinfsJ+kCLTkz6AGZ3X6SbqnjJtsQloGeVYwu4Cc9OVixh1x1/ABpTDD7X?=
 =?us-ascii?Q?S8pQyBRwTQRoVqC0EmYJ6hhRQ43Vhzw5DcgfDKCe4IDrXtfw0T5FueMkYGn1?=
 =?us-ascii?Q?dwh+bUZzSHVmhKPTZqqETC9ZcTgHIXt6o4bCFUR60qYkc1mX7oI4CUx7gleb?=
 =?us-ascii?Q?Ehv4pVfZRpYmeD1r+XunjleLAjtawi3c61NYJyPKMJPZ527Ce7keXFZqKLSd?=
 =?us-ascii?Q?VKNOm8hZozDz7vPXVLwQzBu8WZNYzIJSYv0T9c87a7GUcrio+g58XbbDpBsf?=
 =?us-ascii?Q?cTQhaKkn9De7iK9SwZU8Xj9LU6rEIFHA9Fwk1QZZ0uigQU/6ifsMIdRrZnrX?=
 =?us-ascii?Q?ETg5kg8Ay0VHtHe5n9ZYg6jv1PpbMhM/gadqJTSaoduV6Wi8OuXklU0SWUDN?=
 =?us-ascii?Q?cZbTwG4KSL2aM5vcvZzC/lrfPqqYi4XEs+bbRe5pAYOVpQ3qT0ixmZV8BiRB?=
 =?us-ascii?Q?hNlpAEnKW/9aqjvH2BmRGVpw8pNsnVKmyvl6iWsYtGYLgdxHaAjEM3jfrD50?=
 =?us-ascii?Q?hwM2mICylCds8azPdBOVxA+YA+zVO2xIOdiHHlPe8PikoYngcZ0trO8JFzBM?=
 =?us-ascii?Q?S48uZsT68Cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1+SWnu0mN1oGpCpYF3GmPvAW6s9pklaK68igADongXt5ZjoXiqIr3eJdaYI?=
 =?us-ascii?Q?WjkvcjilGRmq5AHFyQOYj7anL3h81vY14hdXpV1HtLJNkamIzWVRhGVq+bpt?=
 =?us-ascii?Q?QnFtAXeF41+nfp4cUS1P7B8j+Jnr1Igf23kziIXvpVlHsLw/P1PjC084q0jA?=
 =?us-ascii?Q?aW/RCV7ZlsGdZO61zRTiC6PH55YXoZlrgvtxz1q5LmJHh8E0TLGJqjVQTyrD?=
 =?us-ascii?Q?B7n5vRwcWL1zMexJK5AbCEFM88WAaqz/xvYVTA034hB+qWyv3Gqz00aHjtOK?=
 =?us-ascii?Q?lCETU1osDGyJIYNRxATJ3QTc8PQGa2gPiGhb8BqvPRhQXTiYPuQJ6JTsDBQ0?=
 =?us-ascii?Q?ZPVHo0dxrkTFOJwZ9iVH2P/fky0P+6BOqpdAH/4e5Z+v/quj+4VOOCdQulFD?=
 =?us-ascii?Q?ljsR/P58IuWmhY/nigX2hEMMDGE80ncnjDVvtFO3kFz8MWkuE+PoA2lugwWV?=
 =?us-ascii?Q?JY5sLJYpkfwzhvFJAMqEgkh0WyLJbdvxBWaTURKNttJNSqHYML+Z8T5vxpVP?=
 =?us-ascii?Q?Fgc9WpX5hw535GkPSa/wtAUSjGfZoy69iXEvOVfqxsfcwZfdk3b/SjDFCgIQ?=
 =?us-ascii?Q?xgFPlwEjaFddFhv21dxwrN01T4FRmIyhXrr6uXp7aprRAKrY6ZqNeMngI8ZC?=
 =?us-ascii?Q?muIMYfg7ofbZ3IGv11wxV0OUE9yRQ1B8QM7O5E5s4VV3+ru2QAps1sQnaNJA?=
 =?us-ascii?Q?Te/6Kw/NToa7PB2mJGx2RZ53Nn/ZyDzsZlsr1qNlXRyw2u7GhyppYzrk56Cn?=
 =?us-ascii?Q?+AzXLaLC7IGGF7vYi6ycnGS9n5uXHdmrq39OufLoVPyjnQb7t6dUloVenEvk?=
 =?us-ascii?Q?r1ZfEwguRM3F/qMOsyf///hYqGgaE1TeEYyDXyWNI/0UOWIaBo88CL2DYe/t?=
 =?us-ascii?Q?R0F7JfENTg+RKHTCMY9ynfn3/wbSz6vvbm+CAjKTVe2E505TSi16sPuKl4p/?=
 =?us-ascii?Q?7ezJqyrUxP/m6F/xMpnfQxmFq+IhVcgM/DlRnyLy5EXOhxfp/K+QptarEMCH?=
 =?us-ascii?Q?f8GRqpaCnyDxDFsziCtMrJaSIpfCZVro7Dtn/LfgxZgX+F1EStIPaCK/ysrJ?=
 =?us-ascii?Q?knBf00VwtqePiww5uncW5WtWIx70lJawRyL4zN/BinMX0bFiT5ULEn+25cq0?=
 =?us-ascii?Q?lZQPG3C4Lp4VzA/TdZISzunWlCwBQQV06TOhb6O5W4VH2ySN2QnhMDe3ku4a?=
 =?us-ascii?Q?AXknubZZ/KH1xbL+gZJrRaGk42FaOcq33Wa29Lxy4IHAmQYTe2pIGf+5tGXl?=
 =?us-ascii?Q?qQio4BuDCjwBBdYtTrd6ZXKJ+GGRAR3XVIXlYuI6jdB16cHEeYYLOWv6Xzf8?=
 =?us-ascii?Q?heCFaBu3y4OVlqDyJV83Xa4fTRIduGFrJIoHwZQqbhxta3hXjp+bIrTk7VSY?=
 =?us-ascii?Q?zVWOhqHrN2mqQtz8z5/qNWVl3P7WuifaKXxofIqOWP94LaB/5t+o3yIsr7UR?=
 =?us-ascii?Q?Z7trBZkX/ifP4sZ70EPiDfs7TPSqEanaTkdAM47FDd+BLE4PnwNqOBe8blp6?=
 =?us-ascii?Q?AZrViHE3kHZ2X/XIcG1KirqC9N20MTgnAjPKCsPh4smJF0cogyFe+bJ/8GoW?=
 =?us-ascii?Q?uHKDXHyZSFrpav2qtbPN1x67gTfnKPcHUfmrVLL3B3drlmLRqabFJOB3vQZv?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a3f593-3ff9-4efd-ea20-08dd97474dba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:37:52.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXdqCqHuxnrhNqESyMEj3HK0Hn7PTnu9lAwYWaJm+AySQUC/06JyLgk67u6Sz5gM7j4mci5Woh34951HyKBD4JspvxFnqhf1L4UQNm95x4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:37PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

