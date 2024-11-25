Return-Path: <netdev+bounces-147230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9439D8727
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E79B29673
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBA1ABEC6;
	Mon, 25 Nov 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VibUuQPa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D41AB52F;
	Mon, 25 Nov 2024 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540925; cv=fail; b=ccie6mDnK99EqLfUbb9K1+zbCQhGDN77aOee0XTHHKWTrUeD0/but6vHfG7IiRgtKTf6MfKkDhb1DVZTVgQJu4LtMLIhVZk+ypm0F1a0OneIWpTZj6++t5XPJ+sTk0XPfGO51GyH6FoYM6H/Gfw7LO/TOmToNxdSw4tpgLly/Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540925; c=relaxed/simple;
	bh=Gla6/ielZQ4/SsAaYMAGZdQX5nbjx+ShD65Y+UTgyDc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRa1zXmLnI5qrrx+s9qTOXhCwsPjuRa3MhWxgHus8cHzCOj448oo0cGXpwkBSM4haT2hqWTc3Q7mN1BGSzw0vVaCWDWp6OSKFwTLjSlllvVmV3mO0r3Oc3nNyLq/PbSC4vH6P5TVA5KLmwCsk2Lcwsxhkn/fRVzYAXUaEHBvN9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VibUuQPa; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540923; x=1764076923;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Gla6/ielZQ4/SsAaYMAGZdQX5nbjx+ShD65Y+UTgyDc=;
  b=VibUuQPaPHP1BVXmK9DXEf+OM7mvyPj6Hi44W8dBnvQDC0iVsplVFZKU
   SS+IfknrZXs+BswXIauhgilY+IiTxhAMNC92HVylkDI1Wl/Rxfac6J8n+
   Q5RhMQw6tcHkfkGbgxDw/Ke4ATHxS481mIoI18kf5HlRp2bBx25MKXtMY
   +bIsCk/VlnkechVHf5x3thnSpyCOSwS58mjMUbdHgxCDCduXyuMZ/ToI9
   31Znk1H6AqEFX6RIT0VgEQwZ/C2EBfufeTUkS9FghgmETxaPxejK3y3nI
   KcUladWaV0iPOCZIcjfJn+1qbU/i+Qu4XgLyC1k9zkwohCeplOp0WN3SJ
   A==;
X-CSE-ConnectionGUID: RcI2mIGTTOyDk1OSVrLpkw==
X-CSE-MsgGUID: FMLfsSP5TtmTPSiaLw/UoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43710020"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43710020"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:22:02 -0800
X-CSE-ConnectionGUID: vSAVgRWuRi2cKyUYV+jWlg==
X-CSE-MsgGUID: 4F9rG4AUSNKqD0m3ctdc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96320934"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 05:22:01 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 05:22:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 05:22:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 05:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdqU1v0arJdmP9uKkF2am4yGeWKkkIWe/H7I068Iy84hCvBkEdZ4CumLF87n2af4nvy5obmqAPDPB/pw320Yz6jESR4pc5MzfrbeJSyDpKmTx5x77m51PFyMVZhNh3t8DFiyPKMjYQlV0oBtmGpmnge8EVCcPI8ThPI8/gWYfdK8yHg4ahesGeCVwcRu9jDwAI+nn4kd7goB+JpfOILk3sVbHJrL92CF58jBVAhcpS/iDaSnDcwzy6DyP0HvrT44id4b6S9R1j+OX7n5D3b7k+lmM3+jrK0jZBJ/7pU+EVimAtX3GnZuxXkMt0sULjvMise8pg98r7ililZYY+HAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDYJh9z6hxAxzN1hgD04cA90lEa+jjZmXo3PfNrI0TY=;
 b=ZJc2AqBS2ueJfXJj7xsdWmkzUJZSwQ//MoWzHjir0A36sxNhV6HmvYLjPzwOGCacmHvsgrDzm4mtod3Tsde2pw0eepgdIN6Ch5V1O8Ret+TS4mZL264HitzF0q1P5wFh1ABLUmZ6TgcSaAskHOt4Wmg2wRt46IS39YWeBWuKLkUEiP/He5kNjpsM3DUzYdfZ1YX37Mxcb4BOfmEKMq8atpWBKCw1EbAoBA/W9E5b5hCII6mfmLfgQmrwUdlCOpk+5p3lpNbF37oxo3MSbl0Wuv3wj+EkSBmJNQXQiaUZYSHs+Vnw12CbYBTU6pw+GhjangVvwwlvIqfXG2hBzJsR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 13:21:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 13:21:58 +0000
Date: Mon, 25 Nov 2024 21:21:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Song Chen <chensong_2000@189.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<ltp@lists.linux.it>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <kory.maincent@bootlin.com>,
	<aleksander.lobakin@intel.com>, <willemb@google.com>,
	<linux-kernel@vger.kernel.org>, Song Chen <chensong_2000@189.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty
 ifr_name
Message-ID: <202411252134.27764973-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241117045512.111515-1-chensong_2000@189.cn>
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: f59c3e78-84fd-4e2b-dd60-08dd0d54236b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NUm21R/jEo6TAmL+fvT/bOggTAW+68xf+xCVMvQR4ftA0bPoYq4HkvJChfNl?=
 =?us-ascii?Q?y9W/gEHMuo+cAF2/mIwqY92xT4DjBLS6eSxqCM9b93vYyZA5k3Px7NLhZLvE?=
 =?us-ascii?Q?ovuWZ+fB4mJRdlQ8j99i3ls9iyXNLH/21bAzgYccmyIkIKj9JJc4MdbGMb+V?=
 =?us-ascii?Q?ML9wwTXxtLCUBt77+2qSQzRgdIeWNbamMyec44SCfyUU9GauheYWFfjH2kYL?=
 =?us-ascii?Q?pcV/vXg0DFu7kPEl7rRQGBLkiydNEjNLzIp0C8uuuKyk6kYOcnrY5ZSNjspC?=
 =?us-ascii?Q?EJjVaLSZpvf3zFp0uGiqa2XqrkHFwCDvuqureUUbGENTbKnLJffCILkX/Lwu?=
 =?us-ascii?Q?fDCN7hNW+6oA9wXW5+szNtWQtJUSFRL9W3O0lEJfGHSvoa6hQG4+dorFnmKp?=
 =?us-ascii?Q?XCntGAH6scAZKQFcwxlgbz/ZlYOhoeWy4SoTWerTiDJOQAja2Rlb/tKKzkPz?=
 =?us-ascii?Q?MS+z0eyO3wHmx6xhJXns8vl6UTThHmgojKO/zpoUsvtpYGxOBeK8h+qTFQ0r?=
 =?us-ascii?Q?/l918mFg3Um1npmyiiCUIsl4Lc3C9Bybm5Yv4BzCMAm/PmTHA+y+OKaWYjuW?=
 =?us-ascii?Q?LKnB0/DGsuETGhH202mj5UCQZ3X5PSSY7Ndc7XlXtgppyqVyS7baIGO1GqKd?=
 =?us-ascii?Q?sPFvwkQZF7l+wIfKg4oJ06oSVIzItX/2v4J6qCeVSz3o4vGA5Zp/rcXJD3FC?=
 =?us-ascii?Q?PjGvNB96dsVo1sNxyuWpeRLA2y9YmPlvY2tygSUbO7QiAkcR4n7319NklN3C?=
 =?us-ascii?Q?4grJHQAITuSxLyG+QxdNeUzNYKAaVI1C6hhrMA+RUc3nbNefufGoAARf7FTG?=
 =?us-ascii?Q?QPfFcA1dL1cNK3Vjs2b8xVZXS9b+oDFWxdzb/gZyhlvBY95HNoG8NBuqf8jU?=
 =?us-ascii?Q?9HPQ1WfGygZSuzUX3xZefoC8EgX6GO5PGJ6KSERn0qvXaa9kQKZZWPqzjPQO?=
 =?us-ascii?Q?tO8LpHPpGW44Vz3bTocs67wcKoHFR0KLvHj4y9yHAa0NOpfWg13L9B5/z//p?=
 =?us-ascii?Q?kNDPXI8vcUQrQLMoRCr7Rn3nYNo8RMlPu79YpnII1rxGUEQW0TEgxOLQs1+w?=
 =?us-ascii?Q?3QebEJy5MH9EW5vKwM9yw3r//8BPaiqgzZf+DAS5a6MyP5aIDUvJmUAgXjO5?=
 =?us-ascii?Q?uhI2Xb32+uq1gibe6sOUCs067Oh/Nf7ZBcK0uD3JI2fY8+gH4aqQ5VVESPZw?=
 =?us-ascii?Q?tbzlr81Pgb1QoVakDJnXLaZ738UcwflClh0UVMIDyf7El+3A3pXJaOxtM4Ip?=
 =?us-ascii?Q?2KKvrE2ZXAG5KsnQgg3J4eV8i+X5NGt3ksTbccqB7K/VPkKkB5XazhHbZEjm?=
 =?us-ascii?Q?0rnLR3BvZGidrPz8BhWVTuK0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRuFiWPhag5/xeKUlg1WcKXc3pF+nMUkmLd0SgiBK0IAxZBTUiVuK+Tj2KwT?=
 =?us-ascii?Q?mm+uccpV0z98e+sN4WPSS/RWCvNL4LayPhTw0RK57F/u32PDfckKaH35UsV2?=
 =?us-ascii?Q?yZrw7WXFwptT2WztAiej1eWy11aP56dizq9ex9PblS62/1ccyerOLexDGfBt?=
 =?us-ascii?Q?ptArNFHzV7n3DNnlG51+4uiLioPNdIPNnekWJ7A9a98tqOqgGJS0S0hO1NON?=
 =?us-ascii?Q?u/pSHUZqcBlFmah1AboJV1wlC7CcqCNcODxGCyZaCvhvH2UiHMkL8t9n6kaw?=
 =?us-ascii?Q?3ICNFePIjKlp+EmmomXNe4dHwMpk5Wg4GlXQVcNO4Iz02yqJ3FlrMI6EYoQ6?=
 =?us-ascii?Q?48AvYHXX6YOo5/X7/gISLJNuH2r6DPd7K10tfi6vt5FT8uZCa8OWu/Ic6mSN?=
 =?us-ascii?Q?jTa6+APReJw9PljrTKWxDj1hOE86rG5iogNnCq7oEO6x4hhKuSqnnfyOUBam?=
 =?us-ascii?Q?WJxOCpkWoTnCXvS7bEzFmtPOp2+fuBduKyr2JCMXtGMv8GyvhkYxyFn3SXR8?=
 =?us-ascii?Q?jTchYP/pqmudVYWr1P5XbueRR6xgTi0ySHr+SVXwgvyX2vb6P4D6hmoa67fN?=
 =?us-ascii?Q?PsOKKoES9+AQ4DPeGskKk1c6mvhFssGsuhZF6G6EbO8l2aWlTe6NyLkOGdJH?=
 =?us-ascii?Q?yAm5ECT8QcJa/Z8khDUZjJBV3caMcSyfuEWlygZ8lqkJTaqW8j/DQcVPEUsi?=
 =?us-ascii?Q?zeMrSkYwZ+WB8Q/S7jQBGxXt7VfeuQwKUMXbCWlmsNtwIbGcn+9mYPEESflF?=
 =?us-ascii?Q?t51w0pwNbDud19SLZBRTInLi0vfH/0pyMtv7OWB39mdRZ5SsA7Q5RRbZ//cT?=
 =?us-ascii?Q?GgNeRuHN2UjoSbTRhw/+8gEk2xfelwKEMNJih47ykA15hDOZcHv4Duf2ZTPO?=
 =?us-ascii?Q?PygVWgCEANoDN6bY3IROLwJ5bFsTzOuLr2qw4xaqTcsdHQeNh2vpJDe3sPrB?=
 =?us-ascii?Q?xChI5jN2pI37JoZ6fQOU9dpitMHoMEc8TZuGiOrsa6vIn/2GHomSjuyn+7rG?=
 =?us-ascii?Q?mWgPSSIPTo+djDca08J/5gF0TEWTmsBWuzMeoQkwjJBQrfC1dh8hL5BOWtQd?=
 =?us-ascii?Q?NU8qK61u0EJdGUd7SFbmc5llVtaDzPIRdTrR1ZjGCe8cNUcrnKmRylKnmNLC?=
 =?us-ascii?Q?ghkMMF2P8kdX92wcj9Hu5tCIUzO5mDuTdzoBGDS0LF07ciiOaUufQMkfTqwX?=
 =?us-ascii?Q?s8xd74o6BSywm3i0rh3fx6Da/1b1o02/sdvF64nsVy40Ipdru+CMkPScij8S?=
 =?us-ascii?Q?mrzXZnqQ3U3OvpS7d/JqVbxe9etjkkZA4ceSMx0dX0tetmgedCPoPl7mJ0ZX?=
 =?us-ascii?Q?JCX3gU9U6EyJysSSjlKnPnRIiZaf0SnFSNoEz2KKRwqrjVhKx9eplmDFSvrT?=
 =?us-ascii?Q?qI1uPCk9rL/gBPbQrPFXTLgK2Dq1pDYZllljqa03i1TH9Ehv/x84H1Sku+gQ?=
 =?us-ascii?Q?2L1UEnA/58IqtBZd/fMI4u7IRiAHZANMwVRm9oUyguXN0XDjzf1ZPC43Y+0M?=
 =?us-ascii?Q?sMp70Ae8Ja3HtG5WxvqJJgpWuIhcHSMxWqEgp77KepAVYpBASFj5P5mVKQJs?=
 =?us-ascii?Q?pG6IUmcDufrj3iaxOyDHfsZgdbvrHmSYxKRqokXXEw7UCzLKFSLiya+iOngG?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f59c3e78-84fd-4e2b-dd60-08dd0d54236b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 13:21:58.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRvtzHaS856afeCUznU82+eMlRiur7cZiaEQX2ZfhofUahotAV/mgftQTGJzLPRw6SMUyUTwzuVft4IpwwjZ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.sockioctl01.fail" on:

commit: 903558372166a07179510dc222f7360583a9ad0b ("[PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty ifr_name")
url: https://github.com/intel-lab-lkp/linux/commits/Song-Chen/net-core-dev_ioctl-avoid-invoking-modprobe-with-empty-ifr_name/20241121-093707
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
patch link: https://lore.kernel.org/all/20241117045512.111515-1-chensong_2000@189.cn/
patch subject: [PATCH] net/core/dev_ioctl: avoid invoking modprobe with empty ifr_name

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20241111
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-05/sockioctl01



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411252134.27764973-lkp@intel.com



Running tests.......
<<<test_start>>>
tag=sockioctl01 stime=1732585843
cmdline="sockioctl01"
contacts=""
analysis=exit
<<<test_output>>>
sockioctl01    0  TINFO  :  Using /fs/sda1/tmpdir/ltp-9HFOb999pn/LTP_soc6SpZTX as tmpdir (btrfs filesystem)
sockioctl01    1  TPASS  :  bad file descriptor successful
sockioctl01    2  TPASS  :  not a socket successful
sockioctl01    3  TPASS  :  invalid option buffer successful
sockioctl01    4  TFAIL  :  sockioctl01.c:136: ATMARK on UDP ; returned -1 (expected -1), errno 22 (expected 25)
sockioctl01    5  TPASS  :  SIOCGIFCONF successful
sockioctl01    6  TPASS  :  SIOCGIFFLAGS successful
sockioctl01    7  TPASS  :  SIOCGIFFLAGS with invalid ifr successful
sockioctl01    8  TPASS  :  SIOCSIFFLAGS with invalid ifr successful
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240930-63-g6408294d8

       ###############################################################

            Done executing testcases.
            LTP Version:  20240930-63-g6408294d8
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241125/202411252134.27764973-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


