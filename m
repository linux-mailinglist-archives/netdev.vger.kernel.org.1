Return-Path: <netdev+bounces-299451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c7kvAxb4L2o8KgUAu9opvQ
	(envelope-from <netdev+bounces-299451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:03:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C1686803
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BSHiGLuR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299451-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC158301D97D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C173EAC84;
	Mon, 15 Jun 2026 13:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADEA3EAC71
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:02:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528580; cv=fail; b=kpWv/QJABnY78QXz5PI4DS1d/8eK7Ujecu6yQ/TQ0rV+i6ahCdYPGkqV+Lk+CM5HWvuqUyA5amCWUQ5nUvm1vyMbEbEYTgQosDQoFtWUL0KWT9MxXDZQ+S9z0AzlAGN8tWJlRIewHlNobNMHE7K3toYdudbogdhsx96WhAIRIgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528580; c=relaxed/simple;
	bh=haPtqvrLNGo0RnxWyOToJAhoFxBpYehYYBm61680ioY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZGCrvXHGNDQyAZ4p3ayveLOi59Ol/CR9mz7jINjhxenVizA7pXT11F85y4i/opaKFcrQqGKb38NxpxOw4yBERnvRWefsOd9sOSBZb0M9nilubMDfJvDsBsZJQj1CFnl3ZTEMsVil2jmuVyAXfJQ8q1d5hjGce7wtcnjgXiNxGhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSHiGLuR; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781528580; x=1813064580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=haPtqvrLNGo0RnxWyOToJAhoFxBpYehYYBm61680ioY=;
  b=BSHiGLuRpdTdUoMApjaPCN1uGKrT6Y8IgcV+0FrChqMgxy+fD08fTUTV
   RAiTEKET6Me4V/hiyxZvZx5VHQO8ojEW5T4MuZSsLANFOsRJUzFIybi3V
   i5l2XrLhNeH/x0HsTw9fDLHQZZO2bJVUrjdWeq0tdxQbPAN2UA2MwB/DB
   QbaB3c98VNx1Hs+HcBXVpi36Miex2SiRxogTTgL10F2NzzCJFN+/73sXz
   qGH8VKDXt3zxi5WGR57GsxBOy6+3inVkPYNXI0f/tGo/GEg5EKTHx7++p
   l1VVr2X69ld1Q3yoNiAAywjlxbN3M8Vc8DrEMurZKmmjh35sKXRzcR9d1
   g==;
X-CSE-ConnectionGUID: F/DXKGEdRECcc3sC7d2HIQ==
X-CSE-MsgGUID: T4PeBnPiRUuQgDpIMG3qFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92585272"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92585272"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:02:59 -0700
X-CSE-ConnectionGUID: M6W9AFL7RPiVyOC8dnmm8g==
X-CSE-MsgGUID: ClYL/UUoQoiw+Pbt67lBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251390164"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:02:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:02:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 06:02:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 06:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmdMa3WVv+6//WGLXZeQ2k4+tkjjQp748j+KHAqNTEz7bL1gAGRdWj32/8AS2Fi0OIUTu0NTEZ8L8j6Qiemu+3mvWKPxZ65N9hju1yutEMbJt085RY2yWojrYfrb5ou5vMUejNJrreyfKGKiH1N4JEx7ynf2Uy+fXFtyPbFFO/3ldBnpY6l37Y6taSfxvFz2BjRmYk0L53vAFAnXVRUmRX7Iw1dzxOoE5DPpUB9GEpTj5ZqRXc7lxUGy/BpjO8vwIXZ47+brbOnhW73BhOPT7ZLWy+ZDaYl6bV7/rHoYWy2yZ2ZYnky1hDwLqUzAhiFqjmV49iIhNtn65Q9wMECevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t5bju9vWhp9zl9hPSDqMqBC4N80LT/nWUnFT85mQJw=;
 b=OjNqjytkjt88QI3C+KGDd5agpNmXFfMjbuSGOUfIgVdVUA8ExQzAfY/RtA9zZVivQVkc9pSzZNvk2yu5WvgiZagkBwyLBvQTa20vKk8p8NqrdrwcvYAFKsp4iRIQW22XNPhCPp5vwSQIs1Iy7BbsbL1hc206KcTWPI+R2S1e4lmgIuXuVtv2kTxST076FItW4hhbs6kL0HwggbNXKRwgfQkqbKfZ2Ig3vDbkaTsUTZuYOTB+pVoMryexAyfg8JfnJxcRbQKFkmuq2kTpIH0UlpnuCUi40bLQFP3v+3WLMCFzKojG3UnehDvZVTdogwG2bgifFW3bhRoIv8EkksotxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM3PPFC89313B1C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:02:55 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:02:55 +0000
Date: Mon, 15 Jun 2026 21:02:49 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [selftests]  a3f88d89f6:
 kernel-selftests-bpf.net.test_bridge_neigh_suppress.sh.arping.fail
Message-ID: <ai/3+f7LJp6pyLJi@xsang-OptiPlex-9020>
References: <202606110955.8f29025d-lkp@intel.com>
 <MN2PR12MB4517EDE21D4DA962A55CF1ECD81B2@MN2PR12MB4517.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4517EDE21D4DA962A55CF1ECD81B2@MN2PR12MB4517.namprd12.prod.outlook.com>
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM3PPFC89313B1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecc9aee-03c5-43bb-ac9b-08decade6a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|3023799007|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: McSwVeI0nHdUmE+q7QCHgrQimE/4boDT8eXyz72eGxw+fXOcJUKr1hVUEh5KvTwk3Yg3NXTPlFU6xvHN97Iz0PT4bXGcRdU5VXE3yrM7nYgWuuAkyaX0Z3c0dJJFDbKQFAfUB/5D7n2xyoFZT39y0z21NhaKXOr3IU1Qrxku6X6GH84Glc9t0Kv42//Wnk2GQDv8ddYRz9oWVzlLjQGqtl/4VbWJwaCfSEuwfivEeS+YYaWS5SEVG6e5ZJJUmPw3KKlIIlNxr0GObKAXIIXC1KgEx4ogx4xDKfYP+s8ROsPbe6252EPq02PY5w1Yk86mIemtLS+g9Drco484h7Wvt4Vw5Fb3t9DkUwJVGeiZRFyoHGv2QMCOZKBd9gVX9ifqssPKg8Wrao7UO6ytbt0ZNRgKIyqHQDiHUZQ6s7EIN7DCtIzfrNRm7XPcJLEOkAEGL9ta1GdbQ4CBGK8Dante2biYOjALTMo9iQOWorcSISuGbTRDoHL96v7YvJ3RPic4uSne70pdoOMf9wOKdHIwZ1DCmqay30ofIiLv2KcTddtS2E74M76xATC0fj5jM7iqZfogMthRjD7CQT22bM1EnpUF1oxph+HIT+F97V3bvPtMu+sWtZZNwpRD7yUNYJpDrKpO9N4jerIchgKhDM2zGFf3jeDL0zOm4RXA8NhHDPbQqLElkTFlAhb/PlQ2q6kEclwxVxFPySshVVktaeWHCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zFnwlBKw+yBSjhIlMXNN0qLSaxs5HQbw2M6wCGhm2ZE1YzBF3cUFBqzkbhO?=
 =?us-ascii?Q?YSdn85D4NkEH7loArR4XW57P8Xma5oMWzqp0qsviSu+Ga9pr2C+ZcvgZWUuY?=
 =?us-ascii?Q?HUJy2J2yj7Vf9QIbAVDlhwMDZsGeOgxVoykiwQlWZXQgmxQEAyRHzQVPGBxq?=
 =?us-ascii?Q?DtyG2uTDZ8am8WGEYMhj4nKvMEr7aJxE9LoLO0uSOhEqPsTKU54YwbWRoDBC?=
 =?us-ascii?Q?W1hBTHS399kHbCLOuMV60uCsCZ/lhMleRcbMuiQsQg/hnX8a5/zCVHznEX1w?=
 =?us-ascii?Q?o07g363m2cCKnbneM5rqQVux4awbXSc2iHiN1st71610Lq418e645EAVJFW4?=
 =?us-ascii?Q?xew5OpTyEUqmMiehpMKX+kNHKpLC9J/bbzPZCggwP0vEPx4K9jYmYoUaL9V8?=
 =?us-ascii?Q?k2239UatcTxRE7Mnur7XqhrCkteoT2mWY3VB3vCxMzoi+/AS27gyUKXqwklB?=
 =?us-ascii?Q?4n99B7iN5jo6Gm+/Y3jLM8AXOqP5GGipqTi6zXTw3uLVDZdtQIn5v9pW/aNz?=
 =?us-ascii?Q?Ps5ePTmPJsFs9Xkdy3NFv2ubbP9E9DQjGNrK//mufqjFIFQst3qHjkn23Hci?=
 =?us-ascii?Q?XwD0nqf1oq4iUM10MgC80jY8swduJvULsGOiPPNEqI0Rq+ETv3kfSrPF5zEc?=
 =?us-ascii?Q?usl8jbOJ7zVrydMQcmaeDVYCrvlcMTv5MqxWdj88tpqaJ5kAzpluhMcGq9r0?=
 =?us-ascii?Q?ScZvN53ozy1xzwOixQno3CjXOcnmCBjen+6+Yxh++fRsi6aE1v0KDie0CHsK?=
 =?us-ascii?Q?S0rtpcJRgUqtFEc+IovzK80qFZNL35TV/kc9uOq6Gm+2NBqqFf0Cy/5b83pF?=
 =?us-ascii?Q?b9dConJdHcKwnwI18HtaQ70NmXhe0VX27uASVJB/SwBZXACoZv2jLB/aDtRx?=
 =?us-ascii?Q?2cGpjjN3GcchhhCkZtEHK48wCGlI+C0+W++DD6820myq0/LEwgk9qDC6VxJ1?=
 =?us-ascii?Q?Z6JUIVQc7upcVRdQvUt0FUp4026RtKC7kD1d/MsXjf2Yb2+vx02QEaN/XaTP?=
 =?us-ascii?Q?y0r6rZHP93lqLHWftQJDuF5gkycEKHIUw6pwEpNVm1WaCoKPPz5efxUImHxd?=
 =?us-ascii?Q?4j9VmwARRbiPkBS89cNjfwFglTdG9hTXO8xWJIu7gJJvavKK3CqTO7/CF0Yo?=
 =?us-ascii?Q?b72dVNxn5By286KmZRanQXb8CCIbEqnx6uTT6esI1JNvBQjUp5NGm/cAfqyE?=
 =?us-ascii?Q?+qrQVMPXTL3kJ8Ih2342mfEd6dq4PI6p6cCoYgmNUZI1ge9nYGTQlgyOOO6R?=
 =?us-ascii?Q?Hx00JzrWLodIoYFph/1O3SNMGvtPUaqbLI4s+q8/AhP36o21zigfzJX/mnYl?=
 =?us-ascii?Q?9jrzHRX2g/4kvhq/Owgog1lIXdVyCeBa84ikU8V0vpA/bFNANcOsQ9slhnU7?=
 =?us-ascii?Q?8Q+QhNj7Cn1GNOhgvDWV/ybOL5fvK5JVlB+BUY8GYbB25NTxRyFvT0Iv2hVA?=
 =?us-ascii?Q?ii3VgqutfDmAyAkQ66oKc2ecraGJOkV++af1yQe+F/J32QrrLcS1txfG8RQV?=
 =?us-ascii?Q?0ENlXxkZdK+N6l1+ZYqjpgosoFdMNQgGy2i8Ip5YjTDQPlRsAtuxOkzxPyum?=
 =?us-ascii?Q?BiEuZPlCDlYG4FpvVZFlpnNIeeTOrq/eHRxDjiUjydQARk5eHTccqNceEfbn?=
 =?us-ascii?Q?qGGdLvbUwk8oIO2lyvUpCgYn32rHxoKJS5rnaXGR+yXlc8JpxgWAR8T1lyOs?=
 =?us-ascii?Q?5APZSp9r6TiJ0HIzxBn9UJfQz/oSWiZm3vlh0Ti0RbTyfdOZnv6MlBLczHRJ?=
 =?us-ascii?Q?5Bx5j86Ldw=3D=3D?=
X-Exchange-RoutingPolicyChecked: a5jE5Tn7j10h679vSs+aniuBDvUBSHIqu7RyGmblGHjXqeu0jLui6Uf7TVPqFdTCxcKEedwlibIaYxpDDa4QZKqqOpwlSaeUNyoMmRAFXSGs3VzP/dMxncwtVC5VGLSds2Y5TXkEC8e7fotcLi2RsHVAR+p2iWCjZGI+GXcGnywDTP6G0upM1z2CfhEoJfgIWpZW2nQkd+dyQPZtk51lHkEF3DljazvFLZkFa5BkxjtQF1bcmPQbz9nTWFDD0OXGSxsy03IqrmXams/9Zyq80l5+9gE1o+yeYhSjAoHPZgIEBumZvCcxtHcT8nd1pcsUfJv/zm5cIj24dx6caCpKuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecc9aee-03c5-43bb-ac9b-08decade6a4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:02:54.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S061rYL+G2dJufbMWpwiKnE3Xdgegf37jl067GjV9cDM1Awv7ZR4GsOPGmM508ZHeOc0Ym/4sFrOST74zl2iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC89313B1C
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arping.fail:url,test_bridge_neigh_suppress.sh:url,xsang-OptiPlex-9020:mid,blackwall.org:email];
	FORGED_RECIPIENTS(0.00)[m:danieller@nvidia.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:kuba@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[arping.fail:query timed out,test_bridge_neigh_suppress.sh:query timed out,blackwall.org:query timed out,habets.se:query timed out,xsang-OptiPlex-9020:query timed out,intel.com:query timed out,linux.dev:query timed out,01.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SEM_FAIL(0.00)[172.105.105.114:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[arping.fail:query timed out,test_bridge_neigh_suppress.sh:query timed out,blackwall.org:query timed out,habets.se:query timed out,01.org:query timed out,linux.dev:query timed out,xsang-OptiPlex-9020:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC7C1686803

hi, Danielle,

On Thu, Jun 11, 2026 at 11:44:39AM +0000, Danielle Ratson wrote:
> Hi Oliver,
> 
> Thank you for the report.
> 
> The failures appear to be caused by an arping tool version mismatch.
> The test was written assuming iputils arping semantics, but not all distributions ship that version. Different arping implementations have incompatible behavior for the flags used throughout test_bridge_neigh_suppress.sh.
> 
> Looking at the added log, the 56 failures are not limited to the neigh_suppress_arp_probe section.
> The other arping-based test cases in the file are also affected, which is consistent with a tool version issue rather than a kernel regression.
> 
> To confirm the root cause on your end, please share the results for running the below:
> $ arping -V
> $ ./test_bridge_neigh_suppress.sh -t neigh_suppress_arp -v

sorry for late.

our tests run in a auto framework, I had to add some code to print above
information, but so far, it just generates below output.
before we try further, want to seek your advice if these information are
enough?

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-bpf-a3f88d89f698743a8cd91fb43f997e2d292a168d
### arping -V
arping: option requires an argument -- 'V'
ARPing 2.25, by Thomas Habets <thomas@habets.se>
usage: arping [ -0aAbdDeFpPqrRuUvzZ ] [ -w <sec> ] [ -W <sec> ] [ -S <host/ip> ]
              [ -T <host/ip ] [ -s <MAC> ] [ -t <MAC> ] [ -c <count> ]
              [ -C <count> ] [ -i <interface> ] [ -m <type> ] [ -g <group> ]
              [ -V <vlan> ] [ -Q <priority> ] <host/ip/MAC | -B>
For complete usage info, use --help or check the manpage.
### ./test_bridge_neigh_suppress.sh -t neigh_suppress_arp -v
                                                <-------- seems there is no output here
Per-port ARP suppression - VLAN 10              <-------- seems already start the tests
----------------------------------
COMMAND: tc -n sw1-U1mYwE qdisc replace dev vx0 clsact


> 
> Thanks,
> Danielle
> 
> > -----Original Message-----
> > From: kernel test robot <oliver.sang@intel.com>
> > Sent: Thursday, 11 June 2026 10:23
> > To: Danielle Ratson <danieller@nvidia.com>
> > Cc: oe-lkp@lists.linux.dev; lkp@intel.com; Jakub Kicinski <kuba@kernel.org>;
> > Nikolay Aleksandrov <razor@blackwall.org>; netdev@vger.kernel.org;
> > oliver.sang@intel.com
> > Subject: [linux-next:master] [selftests] a3f88d89f6: kernel-selftests-
> > bpf.net.test_bridge_neigh_suppress.sh.arping.fail
> > 
> > 
> > hi, Danielle Ratson,
> > 
> > for new added tests, we still found some failures in our tests, not sure if any
> > dependencies we missed? thanks
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "kernel-selftests-
> > bpf.net.test_bridge_neigh_suppress.sh.arping.fail" on:
> > 
> > commit: a3f88d89f698743a8cd91fb43f997e2d292a168d ("selftests: net:
> > Add tests for ARP probe and DAD NS handling")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: kernel-selftests-bpf
> > version:
> > with following parameters:
> > 
> > 	group: net
> > 
> > 
> > config: x86_64-rhel-9.4-bpf
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G
> > memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-lkp/202606110955.8f29025d-lkp@intel.com
> > 
> > 
> > # timeout set to 3600
> > # selftests: net: test_bridge_neigh_suppress.sh #
> > 
> > [...]
> > 
> > #
> > # Per-port ARP probe suppression
> > # ------------------------------
> > # TEST: ARP probe suppression                                         [FAIL]
> > # TEST: "neigh_suppress" is on                                        [ OK ]
> > # TEST: ARP probe suppression                                         [FAIL]
> > # TEST: FDB and neighbor entry installation                           [ OK ]
> > # TEST: arping                                                        [FAIL]
> > # TEST: ARP probe suppression                                         [FAIL]
> > # TEST: neighbor removal                                              [ OK ]
> > # TEST: ARP probe suppression                                         [FAIL]
> > # TEST: "neigh_suppress" is off                                       [ OK ]
> > # TEST: ARP probe suppression                                         [FAIL]
> > #
> > # Per-port DAD NS suppression
> > # ---------------------------
> > # TEST: DAD NS suppression                                            [ OK ]
> > # TEST: "neigh_suppress" is on                                        [ OK ]
> > # TEST: DAD NS suppression                                            [ OK ]
> > # TEST: FDB and neighbor entry installation                           [ OK ]
> > # TEST: DAD NS suppression                                            [ OK ]
> > # TEST: DAD NS proxy NA reply                                         [ OK ]
> > # TEST: neighbor removal                                              [ OK ]
> > # TEST: DAD NS suppression                                            [ OK ]
> > # TEST: "neigh_suppress" is off                                       [ OK ]
> > # TEST: DAD NS suppression                                            [ OK ]
> > #
> > # Tests passed: 124
> > # Tests failed:  56
> > not ok 110 selftests: net: test_bridge_neigh_suppress.sh # exit=1
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-
> > ci/archive/20260611/202606110955.8f29025d-lkp@intel.com
> > 
> > 
> > 
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

