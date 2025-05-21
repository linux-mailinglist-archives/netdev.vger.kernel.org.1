Return-Path: <netdev+bounces-192460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9ADABFF1B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A941B61E4C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC21C32;
	Wed, 21 May 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4mHRfq+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7B1FFC48;
	Wed, 21 May 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864115; cv=fail; b=WWtvS+3H4c7g8LtNTdPuImaJTPwWP9O4BW5IORn01jEP8jQxkrzk71d3JbmjO8MuqIbtZsM1shUKVpOCiNvZvHzbxVu3ebUMIyMhJmIReQI77FstthaKLan4mFoNEZkKoC55nG9Yh5nO1gPa+LBNrlLW6uB9vH4mHzD+fvB2QgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864115; c=relaxed/simple;
	bh=LC4kqCBj6BHs2O7khNjKHw7jbIoNGI5Hw2FMXaLQLKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQ1HHtcCwnQ0KxKgj6cXtMLWLXt0Q5Y2q+cPz8TvLX3KAN2qnOv//sgqQCrG6iHwWfsj5FRe68WHhYHg2ssMfeareShmKWMOC6bRyHguVhAoOj6v1MltdmBr6GqEkgtZK3UVI9QEJRMChVPPdX7ryAvc8SUujs01i+9X+ON0+TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4mHRfq+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747864113; x=1779400113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LC4kqCBj6BHs2O7khNjKHw7jbIoNGI5Hw2FMXaLQLKg=;
  b=h4mHRfq+4AfrVgkuXg21g2AWzYVpkm3dViY+M9ZcKJkt9a8+ufZQjNpD
   1ErRuguifXAV8ouNUHpLDYiT0617BYvQ8j21h1wGRbDocK5NoUvOQuocU
   +lsnD37QEwwy434jw++x2JOcDwjuxeZjE5HoGuJSNxMKp+Ly3ZSsn7dpI
   wr8XHrJnS7dgURgpC7w3LxegiKHVrrr641vlJIUYFxFaRYv9+NXXaWqfj
   /xY5DaqWvAtdiduDx1fi3hUOjxkWW/v7p1k5t8JjQgPFomF18OcIOwJzA
   0EqUFbD7oudk5aBnHvRqcGXnjFhxuon5LucNVmm/z5bazxWxkvvMXhMzh
   A==;
X-CSE-ConnectionGUID: BOmJE7c3Sl2p9+ngB6NlKA==
X-CSE-MsgGUID: 1NRhf2lmRDSobqCHnt3TDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49852829"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49852829"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:48:33 -0700
X-CSE-ConnectionGUID: 9mJtmEepQI6jRMSE9jfWTA==
X-CSE-MsgGUID: xR2hJSAnRYmxinkhZf9fjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="144992271"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:48:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 14:48:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 14:48:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 14:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tiu+PYHrNvCpNiqzy2BY3lajbaHeOkQ2bhHt550wDfQpMn7k5hzqvD19d4z/XxoNlJ1XZYEdNHIqpPCHGH3/di82nJMol71nvutfxYc0k1WFRCWSbRSsgtsVX24w7d5L3NdqEUVqeUbeIRuOJRackWGyo4mBgACnYBXCeXkUibvEuOtnsNYSYg78oR8lVAvBfhxioWRbAoWHYFzkToZwyrMH8hufeB0KTL5+7uw6cmcZY6tnjr76QuQxMF0WBgDPXeb/koxS8kLkSDLYK3Qm1p+LSi0paJ0+v1zOtwBXg6Co7c3iNJX2+DfHxDzhYtAS4SKYBbSGR7CzXaPnLlp5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=680mBHs6l3hqtz0e/fJsvUkhBUVYNxPbqX90UniSstM=;
 b=P7AgcciLtsLHtmKUMziHcdSwoRUWV9psNmDjknMXkcIzLmoPeol7gQGKmNPfs7R4sWhx2TUpTUD+fmmN6KRUR/rIK48N19akh5234FliwtqIIvba9zG679ufQXoF70AfvylyMQyqa6hFnHA/SeXv5K9J4mp4qex0tKCH0W5RcNMM+BN0AP06hZkM6rrwSbgE6O7TeQN2O1QXxMZ/gpTLN88c2ts4dMAs2FMZ7vsKz1FS021OEpBvR3ri0JE9aCWHTZ35hLTjrtwpOiCXI40DKc5svnJzeKAMZlZajiakyTW+GhiiK5mJIs9hcn6iSgNvteLT4b7QBxcqb4CvQkCXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6286.namprd11.prod.outlook.com (2603:10b6:8:a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.20; Wed, 21 May 2025 21:48:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 21:48:30 +0000
Date: Wed, 21 May 2025 14:48:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 22/22] sfc: support pio mapping based on cxl
Message-ID: <682e4a2c481d6_1626e1008e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-23-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-23-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b652e51-ee4a-4cc2-1b00-08dd98b139f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kqiftEudyi2IHoPCmbtL1pk3GydBWgFh8oC7NjedR8sX12LJqcLiJzcjO/AT?=
 =?us-ascii?Q?a7pwZxV5E5rAf1rjXTqgz+zne0s3WE0OBQbaKUUPVOwZM2nEaEl0JkTYz3zg?=
 =?us-ascii?Q?6NecE/OOB+0B+iZnfLPbV9y8YdY32DMVNdnky02d2QqtxvEOJ3mfyrZg1HPQ?=
 =?us-ascii?Q?z+TOv5SHrrECKEiKQ56vK9620fYgbwIcRjM+U1ObfDv63zCHFfvtSFugyOgj?=
 =?us-ascii?Q?Mh6OscxaFWUUYz6IFPkpEmGNyszUPtZ1mwxTCKgXqIBEqu9ArkwXc+sZAQYx?=
 =?us-ascii?Q?kBh9zsKlARTrnR42VwsVFeryRt4PO61vP97HrfnBS8G1kHj1fvo0E0mYCPUu?=
 =?us-ascii?Q?ruO21tySg+z1QgaSPZ72T0xKizrqa6ATgUt9ReMBNxW3U113T5/dHrAWZDtw?=
 =?us-ascii?Q?9GwAWKeNtAqrbkuKJDKXWaIv8VeMOQQQD5de5JeQcq4+Amgee1qTCaZlowj2?=
 =?us-ascii?Q?0MoXBdEgvNfI2gZKl3TW5OPvhgVQB2pByfd9CbIpaKP3DzL6DOJqkv/3Yi+t?=
 =?us-ascii?Q?mIbO9dhaRlfxkhop7LfZ4GBfy1MSMZlKR56VsZlRE5vMeQmcWD2wdtznD75c?=
 =?us-ascii?Q?QLbub98LsxAYvyx5F14RmV9uHUAsQLCo76avVLw2IRMTubjugRLW6Ko0F4xu?=
 =?us-ascii?Q?iv+vEvIj3D4c0lCiRDIPpK1ukbWL7CZLOMf20BaGXxoenL/tvqpg+nx3YWrD?=
 =?us-ascii?Q?bIiTzCnPheICVCC4iLlpCkDrPEGF86lfswq3FJjvypmjWy7xsPGEhU/YOZ+5?=
 =?us-ascii?Q?N+ZYKiWpzlYmbELL8ervApvkeIBgfG2IYssq3flFSc2TyXbslrv03Ro9goPt?=
 =?us-ascii?Q?UOb0To8U+6cxRr/KY17YH422cHWuXnV4Kq2kTgHucc9EpJdcRBgcWgP3Nd7i?=
 =?us-ascii?Q?L8S1EtITFBpD9pZtD9E3ApT83w3/uEz9AtzAdTiJe+ijtMDiKbLIJ3aZDjZ8?=
 =?us-ascii?Q?8fCPGxO3lOiNwjhXtAnX4RZktdIz4t984dDuoBFbIb2b0w+GFPJUQD5E4Wgd?=
 =?us-ascii?Q?dl01BiVxFYU2irtowTF48++ag2FEb+mVqPD8ZOFXmCTPtQoiQabQdzqg36+l?=
 =?us-ascii?Q?Ym+ALuoDK4NdhirfRpPruFsKrLjy0fcSGZ5ATq6ctdbf+pzG1eqisDq1skQQ?=
 =?us-ascii?Q?B0FY0IiR0sREYBiczrrhdcdtnce3txGDm0bzMVKynda6Q+CSrAQ95OC6K/+2?=
 =?us-ascii?Q?mxa8GUGgSu9DAux0akpkdPvAkvRtNuCTBOizIKOy0Z7uIgv7aC0v6vnMiIz3?=
 =?us-ascii?Q?TBVXU3flh85v5rA0/09bCncH+p3kIfbD+CfnTP0juxhq1rEmb3U+L5J41iF6?=
 =?us-ascii?Q?RnKnvgmipkYyJMWZJCD9F65a8qgBWWi88ryC73fXXooYknCZa+aRXpnDj03S?=
 =?us-ascii?Q?tQt8VJ+uxMclfuAtnKxV//81mcWK/gcLbroZhvViNn5yRV15/D5RQivUPuJn?=
 =?us-ascii?Q?WzNCTwGDxYYJ0RcBy5r1SVlHrXGluRXbxjEYEZq9bMBI1QLVMtiErw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBIHpvM2oUFNhlUu98BFodyWv7AR9BuvpZanZlBGyadOzqRyqshxlSggj/q9?=
 =?us-ascii?Q?bdjV0hqm8DuLPtFDlrCo1ssf8049mIlBBTmKuXGxsGDTjwpEeWm9bduiUCrO?=
 =?us-ascii?Q?ML/1j0AVKkw9D6Gy5aKI5k9X64sJMHtGSbHhdPDS3HuHh3owQNtmAanyFSgP?=
 =?us-ascii?Q?zGkBuidp83g5ygFhkiKmr8FS5K4tzLhNa5wUvfYSDSlRi7OST5GhPwR4m/7R?=
 =?us-ascii?Q?D4d/e1CsieIVMNj6gy7067icnVkBS3MYm6ubuAW85tHETNrRIGLd1dGPtM7m?=
 =?us-ascii?Q?DHVx/GHxAcevFbMf6iaGQGQCywtsQwmh82nWlq7t05hDc0EgrUWD3WGNlPJE?=
 =?us-ascii?Q?QnBxhBgFzNJerhztIsQMshmHDuEy43keaO3eqCVRi6TWUEVnDlgNVWIxG+lE?=
 =?us-ascii?Q?ik0Ux5+IlfK7qtwOVTNKYcUHhGRwxG5Ey73sdegoz2GADEzHUUxtNarwHIEk?=
 =?us-ascii?Q?/gE+r2ztkbqpH0m9hUPLn5LttP6xKUj/mGGoRoriYrigzISUSCgJrIG7AbdE?=
 =?us-ascii?Q?cfRi29/r9dxh5fzQ3xNfruKLVnVVdo7BkGvNPqxSSOYEbZulEKX8/9FBjSwp?=
 =?us-ascii?Q?sJ+bB2DxnVuFyfiIKivbg8x9b+joJ/rLbYYPX2KqisqnVjXgttj5fNIHYrYD?=
 =?us-ascii?Q?Z4O7Tok2PL3wwqlkrqtF7AQaR/C9h2rkdZmzWxUalZEaaAZ6UYVZpeaRYhRl?=
 =?us-ascii?Q?CK6dGLbhd9Xgy+ny8q9JoaIVBXWmfgFGbNU4jzY1gzhXtWFZEee6KJwQywXW?=
 =?us-ascii?Q?lJatPyEt2ol7kSao6rmWqOmvHQZflV69cp9nVeyZ5lNh6mVcKKJ4xmu0NGux?=
 =?us-ascii?Q?mj/cfBdwTmtEZfXy9YcHLg34MpbYEWygD4N6clqfvlw2IXXGqNyFqMLZ4SXB?=
 =?us-ascii?Q?F9nBc5O2PEHIKzAyM++R1yD3q0v01WPk/duWPokyukpU5143hAuWeNlghFw7?=
 =?us-ascii?Q?q+lulTetg9afDJI7RL7RdUojKpVNVy4zqzmFz85kanYTuXsKCpiJt6lnfF1g?=
 =?us-ascii?Q?9tjOdcZfb21eRnL4HB23w4GhFrZ70UQ5YudYWgHo5yADxTWlu81DHIJ8jJye?=
 =?us-ascii?Q?xQ9qvKEk5enjH6BnmeZxJplz4ZhPpfKjq+mVb1H+mRD+onBFQjN5sWehGG7R?=
 =?us-ascii?Q?NsP+onm+Cf/POIIVhdPrjTKEqDsCZgKjLseZqXdiFCCb6LzcUqkioqYgUvdq?=
 =?us-ascii?Q?8SXZXiM8g1yymTCr3w52Cr67K7qEXv8QDTKSRqmN+K198e7FcU2eL0pw+6d9?=
 =?us-ascii?Q?WCVvt+KXbqfMkcBeI6cqqkmCG4Yy0EY1LnBqQJh/h/WoOvlnru+M1p0WNUGO?=
 =?us-ascii?Q?v+KAl80yT3OXfLnMRaU1DdrLzJjjZyX2DT3YewxwNh8781RfrirMVKTFyOSn?=
 =?us-ascii?Q?2MZ7icE/PvMwlgglWT0hJtYt+wt0cDiIP2YtEF+HzZHvxwE+RaupTvjHopAa?=
 =?us-ascii?Q?wKYmNYh8rHTGM29QjygcKQJwzQr2iWzYvo7e08IjvaFwyrqB1m0EqGWQWelP?=
 =?us-ascii?Q?Lgx7EHeEp/C1afI7nx0cZtTddrwO3/wAmWn16FKV+0nDP1Fw+bBWqaAvQYRv?=
 =?us-ascii?Q?sO9r1F2oWzV1aEgow23UAqKMqMJWS8IN4nLo7vAPnbulkcOeDLDJ6Bc9h5JG?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b652e51-ee4a-4cc2-1b00-08dd98b139f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:48:30.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ5E/WXQHjObnZWCB72GGlwQiPGLvunSPE64lVdaVqHBhKRbeW+F+C8ogBItOb8ZRHE3gCHMcmwnwBIAankALqjMqC8bTEQzvreBT+++MKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6286
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.

I was really hoping to get to the end of this patchset and read the
compelling story about why anyone with this device would be clamoring
for the CXL support to be lit up. One of the best ways to get
maintainers to accept complexity is to offset the complexity with
compelling end user impact. So, every time someone dips into
drivers/cxl/ and gets discouraged by "ugh, the complexity" they can
refer to this patch and be reminded "oh, the benefit!".

Maybe that would be more obvious to me if I knew what a "PIO buffer" was
used for currently, but some more words about the why of all this would
help clarify if the design is making the right complexity vs benefit
tradeoffs.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx_cxl.c    | 18 ++++++++++
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  4 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 47349c148c0c..1a13fdbbc1b3 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -24,6 +24,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <net/udp_tunnel.h>
> +#include "efx_cxl.h"
>  
>  /* Hardware control for EF10 architecture including 'Huntington'. */
>  
> @@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
>  
>  static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  {
> -	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	size_t outlen;
>  	int rc;
> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  			  efx->num_mac_stats);
>  	}
>  
> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
> +		nic_data->datapath_caps3 = 0;
> +	else
> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
> +
>  	return 0;
>  }
>  
> @@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
>  static void efx_ef10_remove(struct efx_nic *efx)
>  {
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif

Not my driver to maintain, but the ifdefery really does not belong here...

>  	int rc;
>  
>  #ifdef CONFIG_SFC_SRIOV
> @@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
>  
>  	efx_mcdi_rx_free_indir_table(efx);
>  
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
> +#else
>  	if (nic_data->wc_membase)
> +#endif

...in the header do something like:

#ifdef CONFIG_SFC_CXL
static inline void unmap_wc_membase(nic_data)
{
	struct efx_probe_data *probe_data = container_of(efx, struct efx_probe_data, efx);

	 if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
		iounmap(nic_data->wc_membase);
}
#else
static inline void unmap_wc_membase(nic_data)
{
	 if (nic_data->wc_membase)
		iounmap(nic_data->wc_membase);
}
#endif

>  		iounmap(nic_data->wc_membase);
>  
>  	rc = efx_mcdi_free_vis(efx);
> @@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	unsigned int channel_vis, pio_write_vi_base, max_vis;
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	unsigned int uc_mem_map_size, wc_mem_map_size;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	void __iomem *membase;
>  	int rc;
>  
> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		goto skip_pio;
> +
> +	/* Set up the WC mapping */
> +
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +	    probe_data->cxl_pio_initialised) {
> +		/* Using PIO through CXL mapping? */
> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
> +					   (pio_write_vi_base * efx->vi_stride +
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
> +		probe_data->cxl_pio_in_use = true;
> +	} else
> +#endif

Looks like another static inline helper.

