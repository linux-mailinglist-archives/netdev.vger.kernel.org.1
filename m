Return-Path: <netdev+bounces-191708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F084ABCD55
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2383E1B65246
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94C19DFA2;
	Tue, 20 May 2025 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfJFcNcL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033171E492;
	Tue, 20 May 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708833; cv=fail; b=LRxCBYudTXPnlh988FUR730XC/PoL/WS7bJokN/+5yOYELm4HO4MY/lznIYUmrUrw+1BXLouoRLYWNLBxKrRpQlI41xE4sm9CgvZtRfdt92cilKCPz7hmEHNXVaRniYiayi9woIV9nbhdRu3LuwCLrk5keNwlcGVqZdiOl4ayyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708833; c=relaxed/simple;
	bh=bDcFXAemeGYkEy/1XmaC07Ps587owcvXWrJIZaf2E4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfaIxpH6LU+Sc8FAsBpjqtr5PwDbDxkZ8UwN/tF5uZV0S+MtG/QHbHUBOWiwfu7EKQ3/z88wprRHbTwWibGu92Zsu20H3V3wMe9xTUXg065We3jVGihbguCwh+YV95MUC9ZaWbfxbDAWMSqkDqLt9h5f993TymCdMYHtP6lJAt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfJFcNcL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708832; x=1779244832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bDcFXAemeGYkEy/1XmaC07Ps587owcvXWrJIZaf2E4A=;
  b=kfJFcNcLUxAszL4PxhoACre7rV7Qsp+Lk03xufnT4CfdyNgraeX/k75v
   sYJxN4riYiW9rlQauaIVs0sLtueFxHGnkjlIT8O3QWeL/a3/tYeau6u1v
   dpY4hkwUDW6+9ISV7lzZm6qewCqwHRctjG8vBBw/FUW8d6J+WjWX9C3uT
   RMQLtpzJ7lf9lDvyu/7FB9GOGvfonvQ2Ge4bMT+nFo92+4AaNZ8sCu4C/
   z2iuF+/Ojc0MV8MhYiuHKfpZqBVGwOisY0GOysS7GVQ2S2Vx0EPLZHxAl
   4nAoffk2XQCcWGaZKi5QNWSA9Y1XvvGNO8QAwez1s7LOlUdoIvjxxE7GR
   w==;
X-CSE-ConnectionGUID: MWCSTzgRRQ2sJ2msImD4HA==
X-CSE-MsgGUID: Oj6wy+tmQ7eYwKP1LqOE7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49780391"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49780391"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:40:32 -0700
X-CSE-ConnectionGUID: q8h612+/R2ORes/mDadudw==
X-CSE-MsgGUID: ygx73lsnQyqSyNtQMaPp9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140558691"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:40:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:40:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:40:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:40:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSaTPtT5eVclOQ+/1VlE9uPa7+r3oWfNeSHxIBkitLdwU1hApyBA4EdWUtUBF5mdfIqJ6oO3wlkeueDiY2RrLjS4CGec5xKW6d62wa9a3D4RxuZ42SxTU6Ae44U5dDQK+6DxzBKrO8p/1Pi8KyKUHZEIdEfzhpEy8U25MHhUvEeD3RA2eDf3b4hpcr+/czzruHMJwKLRm/heoiQ0yUVLg74ce7BfpVdDp56/xH5+EWBRpmVtx/PGJJvm6peBwakXRESRIHgOHgSPvAxP89AoZUNbcA7AenYoBZHF0DmRgxXQe//tgkeOZTsa9q/QwdIgMZy6rYcMr/W+Pk4Y/xMNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL0HUqJpxIc0Z0hNJy/iOu/29m9mQziWty4hSxoSf+0=;
 b=g0OqTV8FzdDLrw2tbDpQtvezWoG7t/EdqQtZymcEo84c4eETM7J88KUBRBypRWeDBqiSIynTFzJjfqsGeDSoi9Ds+65FSquSmQsotDqVmiNXLF/TjEiEAmTVTampn47PcP62QLcXD0maLVsT48rY+uSdQAtZO1P4c568QXwadnyapwl4HGDkQFhiKwQkD1FdHWqkY9xQvVy0mkAmcv0NUSktKFEgX4KCNfqwojJUiUDY0deByVE5O6pjZ0EncgWBTXvsGo6K2mY2x5zp85irwv2jKkOMwfd9+OBbYGdBypAO4HgFKC7PJ/ZdwAVf/GNtnUKrg+DTVvw+CidjmqVhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:40:27 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:40:27 +0000
Date: Mon, 19 May 2025 19:40:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 09/22] cxl: Prepare memdev creation for type2
Message-ID: <aCvrl6FhLH5-jPPD@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-10-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: c02d26d6-8f92-4be0-dcc2-08dd9747ae00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LHM1aSwqucwI6JnTWV1PXmFXtijAg8idTCLP+RRAyPLDxJPx0J3ql/EwhqRn?=
 =?us-ascii?Q?X6yXCXRsb1M/mkjeZUc4bkjCBs6o0Eymw1F2nvpvH8x3WyVMzB8yZ3oQ/cMA?=
 =?us-ascii?Q?igEJymF3PWM4xNBkrPkneCK3AW2g/k62IobOYWFzhIjDDVrk6R+AejdygIGL?=
 =?us-ascii?Q?k4XKu/j+hMZkwZIMblyCvC0J32XNyNYFDu2X0tX9KE+slx8nzWgD1WDzbKRs?=
 =?us-ascii?Q?O2ND/OSyPk5obndNC4Q3jwtTVPVrrLU3WWCOqPmcEjbeo0bllEMfO6TlLRI5?=
 =?us-ascii?Q?2lB60QyX+wbTnxDPD2bg2mmBZfUY4A33QNxVHTIa8TmokXApRNlGZ7+8Li47?=
 =?us-ascii?Q?avWJuE2pxyHIyzYKzMJ+Yg+mSUltYh42A0+/tz7rxGd3ySrDOADjfmdntBwQ?=
 =?us-ascii?Q?JEROfWjshPkiywKAqUc7weJPtyRsMa33Fdh3uWoFWWbIxUHrg9xPESDjJ2gx?=
 =?us-ascii?Q?fuIjaO641zp0+Ux+q/80IROT2heXqlX4J4BYa6VajqdM0fd4/KSWE2xdEOQt?=
 =?us-ascii?Q?VQE43UGnhwEwUcgToRsue9n1utnKrTs9YrSrCnjbhWH80pLgC4XpmEjKMyhp?=
 =?us-ascii?Q?mowyayQp5sNlfj3y2uu3mP7ydrrFVm5IVjercBqr/sYe//7BulYCpvPBATiV?=
 =?us-ascii?Q?L7w0KgzSiOQZjUt3HfJpgK8TB6Af3QUKyAd+Sy03mS2vMjjLclzIoTvhRIPL?=
 =?us-ascii?Q?djHfjU4kzbwGm2SoqEdR3fH07AUx0WsWSogEoaMvHqle9C1zqT+3JAnp2xkt?=
 =?us-ascii?Q?TgDJ8SbWju4wvw75FsKVLG9J5YD2GxbZOMZ5rCKiEvw/Jv/k6jVOellDobOp?=
 =?us-ascii?Q?929GT1l+WcO9cuEj5fQiWwImliYAlnDLNnGveyJwZKZyVRRvSeRmIBYSuG61?=
 =?us-ascii?Q?ZVqKvfK2vXSmJA2qm8hrzGJnw12rqQeGdU0RL2g5OE4fkYzdEx1INJ+Bo0LQ?=
 =?us-ascii?Q?bqGYInus9GFnvB7+hEQB2xfC/WcVqUF6FzKyHl5nVgiAstQu14DjJH1sQKWU?=
 =?us-ascii?Q?OBoVrHmrUA1UCbQaQhOR+rop4pQVkGQfUGvxKe3onFZ2sh49BeoRh76F5iqR?=
 =?us-ascii?Q?9pGV6qW89OVt2WlP+vj0scmxrNfTDT9KsU1IhnzbaokbRyd4RjDKKqGldQUt?=
 =?us-ascii?Q?PdGF7xmLxAqI9UYaXStBmTTV5nhuFHbE9b9Mw1og3cqHed8Jj6IGA3QF77Bw?=
 =?us-ascii?Q?xeSOpXD3s00hgrV830lfT/7j/P6mkyb3OHfh9gS4RoyFxDEDa5AaIeqmSs3T?=
 =?us-ascii?Q?0SZYx43Vm7LHqNzfvHm0hfOAsA2JMZJOBg4NqHhLJi8fb3Vmq6o+fjw3Lu/p?=
 =?us-ascii?Q?2HYayaGSQiW4grFmO4S7+XpcNbL7H/3OrTALI6jmGvDcZRsQsPT4i3SbWTwX?=
 =?us-ascii?Q?1t/5dfk2HQewZ10ZcmKM67cj8H9xTppBTrddmWHC8E2GdutJ2rmI/ZIl9CVX?=
 =?us-ascii?Q?UgODIQGrbbg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pM4eCtOTb/IiMyU/TNL7fq+k358ZrQYOwNn6bu1Um29yPtdY3Wbm9qRVkKUA?=
 =?us-ascii?Q?zroXmkCwxuQ+q2SSkEXWLtDNCLiLK0USyhvFi6SXaYxifm73ob/BnWE3gpQe?=
 =?us-ascii?Q?oZSGJfcrPCB6fITF6/PLbZloljF9NZZXb6KeOsOtPa/VYsrXgugTMPsvOblu?=
 =?us-ascii?Q?Vh4il2GUyXSiKkg2NuxcXdRFV8R/vSbf3WTyztb6cWjltvg4XWwQjA9FGpQ4?=
 =?us-ascii?Q?VRGglxT25i2O45adMeATCkh0gOkZPJcm6BN62xWKqAdKBqSaYhcYj/Dq1MjW?=
 =?us-ascii?Q?GNhPkmPpc7QNm00IYiuLHs0O/oeEsLc/u9MBUU7dRTU73hM5KA8uV0PZvMrz?=
 =?us-ascii?Q?ibYT9m6sR46EDy5B/Ti8zmlyozD+asCSlCdpY4KlxRDDMKwzs6DN7/jLNKOV?=
 =?us-ascii?Q?jm0M4wW6afYWtJXO+xNPkxneuyXHuNTReLJtku8NpzC6J1TBfu2X+H9X83JJ?=
 =?us-ascii?Q?JXs4maln+fRd1Y+P4Zm2eOJQKA98UhRQZgfURpYTQ2HTEa3KH0UCPtrU/Xio?=
 =?us-ascii?Q?mktMzuJedQLF+AP2o4lHq8V/D029N514xXef9YfplfHbcCN8P/QYih4CQ76L?=
 =?us-ascii?Q?+ra8hvlDUbKDdGjF6OMti1kvIocj+vr9C8+jB9nkuuXUTfeJGdTGvzQn8Rfo?=
 =?us-ascii?Q?PXBRT7mo6HHFsSoA4WEaFICKhps1lomJMjRA5vbm3LS9+gc71mDBYgW/vdR2?=
 =?us-ascii?Q?r4RqqvuXw20UNody7CyJGvzG3VucPPkgBsw6K3MHWS43rzUh8V2/VX8TEMy9?=
 =?us-ascii?Q?Fj3h7pdAXGSP2xtXpsG9yIN939aeRKfXTsuu+SOl/O6+59dZazZKafW6SmU4?=
 =?us-ascii?Q?S30dJ0WayJzEfGjqzFzmh7Beejs/4IL5djLxXTzouMM4Qqw3RK2gCjovDXCt?=
 =?us-ascii?Q?e9H5aLrbfI5ASdtqyWVuOXO3V2DnVgl7mDu7OWK9N8TKWcsrTbAv50yazk1Q?=
 =?us-ascii?Q?HYJA6204w7TTXyzFRr+OcNsFadnlPcC/KLODL+xqWQjWxRuhSHBTStkqOVim?=
 =?us-ascii?Q?ratTHWSAHiv+z/Mzwmm8UX23Ka/+m92PBDkkZknyPtm1FQUoCt6elcFoYrsJ?=
 =?us-ascii?Q?I48D1p5t8AzakgIXzeo/SbNJA0Ufbbt2bcai5Mm0LAfv5JCYhb6AFzKjPCTf?=
 =?us-ascii?Q?p5nmM7HjJmV53tJDtsCx+980NUnWLZODWMCor4ktuR+TJ9/Ma4hd4FK52n71?=
 =?us-ascii?Q?sF3PuMjV9V73UykN3zSkPzdiS6R655mBuyZd5maITWIIE2TfT0UUbhoRbYdD?=
 =?us-ascii?Q?o0MCmGvx0wql8WhBf6MiZRSsQej6/TDfgYHaKPJXURTy0KZl0CZkYRDPJtp/?=
 =?us-ascii?Q?1e/oUTduFeRsQy7bcCjvnlubZFlrq2vpzXPSnoMXTnb9g/E2eVPHJMc2FUFU?=
 =?us-ascii?Q?w89DhA1m3TDV7f7U6Junu9BkexA2WgyA5Zt+sT16ugrCGngZEoBtuKohise6?=
 =?us-ascii?Q?XGdmv/MaWudk1SQsjtawWHT26tctt9KMyWaoRvBTlo3voSnHQU97/fOiRjXc?=
 =?us-ascii?Q?P+NjZmS/QsvnS4s91rLDsLHqX52yRRfY85ZEyuglkxU1oE1QmYRqkYKaEND+?=
 =?us-ascii?Q?snLhwYUsaKjdVOe8cx1BUJyhuCluSn7kEEmLn4AHRLypZeDmLFQTtQh9SLCG?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d26d6-8f92-4be0-dcc2-08dd9747ae00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:40:27.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXTQWcAcwdAaLWNzm9j2zGVdAGm4F1If9w900HXVSvumIbgXNy0OePxlpIfvQa6L9OUubuuC7NKEnh/NKeBqSssNMovbHKWZAA83mfxmQUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:30PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

