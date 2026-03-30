Return-Path: <netdev+bounces-273181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLtMFDB6ymnk9AUAu9opvQ
	(envelope-from <netdev+bounces-273181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:27:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7A35BF11
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1433C308FCF6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8603D47B5;
	Mon, 30 Mar 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLaDZIou"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424933D4116;
	Mon, 30 Mar 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876694; cv=fail; b=Svp66g9p8bN/hvKXuNOuHbjkvkrocs2rmHi00iLpAK32aio+DiivX5G57E4Y4K333j1V6frvPHZu97ZFnKHlaC6UlRZecm/m7CKGjZfS/3J5Zx9O3iWCoxofazKubB21h9cO38ey1Z0hJaxCpFqa4DngN90kZY/9cSPwizpafQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876694; c=relaxed/simple;
	bh=pRzVTOTS4UJjgyalL5JYfdmk0syJH8PQpIJRm79OrRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwwYAgb+ksHyYoNeOe7gen3KeBJbOTWHwAkQWQ2sQ56GHcjCvfUUwcrLVWPs/esnDBH+Bp5E97dH4k8QIuDufACkYNq0KldHKdwtVMtJT3dRhaJUj44KgjieqM3HGfWmdNXhNYSevFmQe1a2zKjkQYSaPq+Bv1obe1d25KiJaFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLaDZIou; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774876692; x=1806412692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pRzVTOTS4UJjgyalL5JYfdmk0syJH8PQpIJRm79OrRs=;
  b=HLaDZIouGcKfMU2s56BfgKlTRLjYGj/EWr5zeWBpRygkDiH1SCLx/kk1
   9CHDL6iybRNPeA8OT3xmRrAoz4u8ujkJTn/ldrLflJclbhlLzoEOAz3P1
   HwkBGrgezv7lRpPDnfYjKlwwl0Knj6/BZl6Bb7QldseV6BDUAMT1ffWGx
   /ZWAe9uf4czos+Yu+XdO+0MJwn5aAnD/D3MfFtdZftTvDCer57Pri4jy4
   iqZ3CHvvak2suttL+u+mwlkhPLhwb/bloVKgPZo+UFknpSLlwgL+162ko
   v8oPUOyWaUGeZVJ3s4MKwiGHuc7sVwAov+UfPXS1g4DsAdlc2H1zxmE5w
   g==;
X-CSE-ConnectionGUID: gkhA/WbhRviIsoHl+xSw5A==
X-CSE-MsgGUID: ybFJXm8ITBOHDOUaZBkmUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79769369"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="79769369"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:18:11 -0700
X-CSE-ConnectionGUID: Ltc/ZTR5QOGGLA6b5Wl3FQ==
X-CSE-MsgGUID: +Qiqmo7gTwC+bOdmFb9IDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256562756"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:18:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:18:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:18:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCcYWCfQvOD9nntpgtaPCC0qAFqDGRR3m8z9YrmFVkP/VsAp2Q8FIwy2g7w9bXGdgxUyfcWLm+zNzbnU1M8eEBxDd9wPao///6n7HZeTluCo9+FpM9oyI83nYrflgB+M0lvrz2DRaEzZxQhTSYjHq0IzGIRaBrHTVi0EK4R7/QvDeCvaZdZNumwsReTXMWvcLdCS5pSudq3r20O8f43sZrdsO5UrBLGl52RSk4togxsCmNzi3/K7/7zu1PRMy4nNJfyD3692D+r6mEVWi7yXm93/iRMHv9w2DqItjgPo9LOisXetljHB5OjjJ6K3bEASBjGe9yOFISVkf70MrpNd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loPvIgAnZXzz/VjsbRFbreWa8/1mhG4iGY7D4RP38ug=;
 b=ogDCXRsmIlEf4qGljnX4LN783WsHC16hB5wfQtWgOJlawr7ZRRdZ4Mhb24bA1Y79xbK8PsQjUc2PTEg6QtspfI58jMfZh71e4gv52UypY4q0VUAaY1K3z7WEAmBeAb3YiA+IBE2mErBEvmQjUnFqPVgYoFwIscSXAA4f9vqLLTYhXSn0w/BOCHFpP1bCIKXOR/NFzQNhtw87vkAkQ30ezWmj1rmgprYKs3H4Q6Lq/Xs16uLIgPJgwLNNYLz4ygixgU4UZLIME5PIjTcI/3qFW3xEDwbvb0KT4SEtGGXje0WFuOZplu+vbYo9x/m9NAudbLPIXRbv/vYuZUPATapJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:18:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:18:05 +0000
Date: Mon, 30 Mar 2026 15:17:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Matteo Croce <technoboy85@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/2] e1000e: add XDP support
Message-ID: <acp4BblnJfpVClct@boxer>
References: <20260323182823.5813-1-teknoraver@meta.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323182823.5813-1-teknoraver@meta.com>
X-ClientProxiedBy: VI1P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: 18735b26-db3d-4efc-6077-08de8e5ec6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: skjVbsLk14u+H8n8JOBT1WjTCLEwLkmJdfqrLcW7ump8BJdRDrfIW9s25HW8Cw+ePE56WhWMkvrTEgJZGeVLn/KIbnb/fWQqVD1WfgQzRQZSN50Q9dMFCeL49G+bBgrwHXI58l7PDr/PND2H87NB/VDEpp4Aeq4O3d94aSejfTwEy+uxlMgQxoifcFToOESbRZFc2oTRgE8ce9Dm+IQlC0qPALIUzrTawgqmv6ojLknDTO5y3ZEupUmsFztJ8m2aLn1cVJahWlp/Nyya0SXL+AykH78JJQITWv4ha712AqXb/2hWdrLiKAqk6xiWbTXWf6qx4/m8c31Raog0kMQjKf7PtSVJmlRp8P3oW1JbNSrHSUSRwzrwaM/iG0K/eBaDUfSQTZfb0g0DUsU6V6eEJm6F7O8w6JBdydcr9wlkcGVPxWOOkOHNxwLSzqJMTM8U5fLlYgM6t4m54X2MK8Mni7fAjnYhKUT48YNgN2Z2n1Om36id5k7/0bjPHanF7oRMT3SDQCpaN9owRMg2T8UObUn8Se0kELGz60vLjNJu7LnXNMhqto6RM7yasYCs0HeNC3kVpZUcJxL7ym0hAOU11QGNpHDsYnlXGu2Yi129QfCiEB6mhr4jM6axiIM/jn+NkBnlzByWufkeL5UrX9rEl9u7iqbOraupPV5PkZMF1AbvVagHtZwnDij3y2nePvFurbxF1bxRWMDtalE3+s3sl4Z6HcVp+5+4qPExckCLtUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5UnDnvYVQ3bOotVsLbgfN67cWQcXBzCJc31re+ek4uD1iJkWn9XkUSM1VXm/?=
 =?us-ascii?Q?x8/Z8gDQMANdqE5EMp4QyS4jpBsz93bb/KgRS6tjkQ50RFtDeNBBEF1hoyyJ?=
 =?us-ascii?Q?H0GbLylLgobftRlb7AQNya/8oqDtHJb9og6oUuERbmt5ImmuNVG83WYH1ydA?=
 =?us-ascii?Q?ROs4VJwLQA+1fAtGe+ONmQ6PIiJlk7aZNzY7yce5GRqFHDAvztq4mPoHjhtM?=
 =?us-ascii?Q?lfZRCSSmo73BL68OKX/nv26WA7pagnp3K6jaSLIZ5UBFVbTLGa7shsbbAArD?=
 =?us-ascii?Q?7eusd5KnDolbtA36e8rVHzGCRGyHbVpbsTizBopbdgH5X4Pe1EE0StzLysTH?=
 =?us-ascii?Q?BZYVmWbRPwuOah6Sq3DXTh2EeHElAHNb1hSqLvfpt3QRbEt8Wo2EWaTRVOEF?=
 =?us-ascii?Q?NP/LFILowj7Q7+SSpt+REy9wrsapbLCrzRuvjABHSbGkdXUBdg63mN6clk17?=
 =?us-ascii?Q?IMt3AewZ3Elf3ofDSQMhfFniQXrVkMRF8fzp7gVQ/ovKh7joa5fM9XtMJ1Or?=
 =?us-ascii?Q?+aTvo5ZBp7XMPXsz/v5niu+41HZqaQlAHP0QrIDC+CzT7ycJMTtFOqyIAnS0?=
 =?us-ascii?Q?dK9es0sAQ7vUQBFofhGLhQw43xfcVgNs+JyBgY6UFK9Tp1zLWElUcOJsbcKJ?=
 =?us-ascii?Q?DlI3rWD050hOvYx6vmWyNwZqg/owIPyZ/gwLN1g4lMs0MAqSzmlD4MHqjj88?=
 =?us-ascii?Q?Vin3Ra8a+ZuD+fszDJIiD09CTcWDSwC3Ka8X9jxrCRarNYmXbtgdTB1totwp?=
 =?us-ascii?Q?zRB1El30v+sFHXeeeALnduWkGHHQGwPNQuJPaIMiQlLzPhXlMnDjz+vLcchg?=
 =?us-ascii?Q?uwojFOv1gcOcYuDA9wCC+4FyC7rgW5NVxtWRThlkUDow/8oJ5cqz3YUGg5Yn?=
 =?us-ascii?Q?lDcUkUDrPyIPIYUAlnj0nIOPUZM1me17smoARUQGI3p3wvoBYEBSkk2nWOH6?=
 =?us-ascii?Q?8QMIzNkh4hA/RJ6doHYGhDAGHZwpGT2JzX4Ip0xwvJrhKQCMD8r+Px5FY4ni?=
 =?us-ascii?Q?rl+KyBEj8ctaLaQg9TWcj50Ylu/DNz58GV6BuSbEwXCEQDZO3uu7FcdGscHE?=
 =?us-ascii?Q?ETRlkCkAW6m4LCmhpFceN0K7f99YzRVleL6FvkI7jftnhudGRHfwH2abcD+/?=
 =?us-ascii?Q?W0Ok5aF94aIZykO60BwyXYsqT2HkJbSq71h/J4FS3qch9mR2Q0hZH8qgjnxN?=
 =?us-ascii?Q?NxFvBE6Aui9tfI1O98mFO4SrNBTL3EFMPrqim9KPxZ+cX2CLzS5dMGiJxvXR?=
 =?us-ascii?Q?E2MQJ00QmfrBi0IspL7s4yaYH7Yx8rZ8M2Ra9E0MflohbyAIO9IcY2AFEISw?=
 =?us-ascii?Q?w8Zfgi253fmggRcHc95cRRU2ENcOkm/ycfpzQIvX9r4GFndgNNwrKjA6snhr?=
 =?us-ascii?Q?qpLWe2yFLYymsgvrnIUlNUjwFjtUHM30LyrVn6ZB+B83c8NAHAd9GC+FahTE?=
 =?us-ascii?Q?bLVpGkWuHhH46uWEWnKTusr6MoMKCOLwIBRqc0uAnpHzIgClkhTh3mNB5vIH?=
 =?us-ascii?Q?npkQZROK7HJwQxi7HAuzgi0nfQwnrbDnSsDtkNGID8h/QCUEduJxa8OZ4dqI?=
 =?us-ascii?Q?uB9eHshojTZqneZH5fHU4GXcsF63a8PJ197ws+N4ScOkJBXSVuEad4dE2+zM?=
 =?us-ascii?Q?1EskitDFQH9EJiYgGltueiR8oxkhiB/sgQPER+3W9WX/4XEH7NTg+/FEaavg?=
 =?us-ascii?Q?P/hPq5bqeMVpl7gNwqEg8u7NnT0pHhHtQVmx3eWoENEY4lI1Z1RuObwzNy4p?=
 =?us-ascii?Q?VS7fJlUpjjrN5hLSY+9PBnMa1jU9Nco=3D?=
X-Exchange-RoutingPolicyChecked: v5pR35PIIv0LHyGv4xFW4HUFuq1JbjSpOrYgRiLvFKkJTKSpKxKV8Dus3aH/JG6meY4KdYSvVfSNF/MHFodv7vCrxKtuvusE6AEFKjp+s0sREw8GHuVUSNZnE4jLM1HCo2weSz0TLbTNNcCnu8YxuPfbG2JRYZR9FrGDaroa7DM2NSXMD354r/N9c+5r3HKgyL44IEG/SKH2u5bgQiN+ZHO8aEn57qzC5ar40OF2pBX5GNuD/20w8j01FCOhkEQT/U8LgQHxl6WSTeQoCSBx5VejHCUUaImXNiTfAaohrt+ajKZCq2RgjWursQC3AQFIFNMpFPOLvc7GiEEn5uN8kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18735b26-db3d-4efc-6077-08de8e5ec6f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:18:05.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM7fBXYwBykiTT5Z7btRRIJDlt/Z4Q9lZug2a/5OiiqZhRPo7QyMBy4bPs43pTxVxI5CDwygmvcvDZNg45ywWeKrcbofoThsuqND9Oitu5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273181-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ADF7A35BF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:28:21PM +0100, Matteo Croce wrote:
> Add XDP support to e1000e driver. First patch adds basic XDP support,
> while the second one adds support for AF_XDP.

This set has nothing to do with AF_XDP.

> Tested on an Intel 82574L Gigabit card with xdp-bench and xdp-trafficgen
> 
> v2: added a missing 'select PAGE_POOL' which triggered a build failure
> with some configurations.
> v3: removed a leftover file.
> v4: bugfixes
> 
> Matteo Croce (2):
>   e1000e: add basic XDP support
>   e1000e: add XDP_REDIRECT support
> 
>  drivers/net/ethernet/intel/Kconfig         |   1 +
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c | 610 ++++++++++++++++++++-
>  3 files changed, 617 insertions(+), 12 deletions(-)
> 
> -- 
> 2.53.0
> 
> 

