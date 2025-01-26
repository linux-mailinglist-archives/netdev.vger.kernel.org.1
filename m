Return-Path: <netdev+bounces-160952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEAA1C671
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 07:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9C18878C6
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3D78F4B;
	Sun, 26 Jan 2025 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJMVWICe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803D28382;
	Sun, 26 Jan 2025 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737873037; cv=fail; b=oC0M9jak4KrcdTAU8bmiNIhxdUrotUQrbUeg2R3fqIWufmeU5gpPfQQyxkkbIhgOFVAh8XQAYqd+DYEW5eGm7na5cW2Tb/r7fYEEODPgGC3GDGWoB4WLzqxL/QjAkMV/BB65uX4OCWvHVneTPR4e/heFCBGlmmXUZGS1q6kQlHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737873037; c=relaxed/simple;
	bh=pU5bpYyc6ZErXD8d318851HUqaImxc5RFWAaZLy7cXQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HK8n1CizDOf+UHIadBBc99NdyDAtlSiADA+cHHDPVeshO5uDcp2VaOTp5ce1EApjEbSoKrHrLGBS+1XYPkahmCIXPV2scyjHC18t0ceAuu7ssHAmLz0OW8UoZfWcTNhs2U56YgvxbvRZn1T/P3l4gN3FUSoC5e3esGtoQMZEhoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJMVWICe; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737873034; x=1769409034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pU5bpYyc6ZErXD8d318851HUqaImxc5RFWAaZLy7cXQ=;
  b=eJMVWICeO8TO0XD3BDaGIWhkXtl7at81AKVi/LAKy+okaEC/RdAzzZRd
   meeJS2CuFwdNxpLV+FhY9YARwSL3Dt3EHLkToYb+rAzgWcBoRAJ1wL36z
   oC7D8Vx9IfOA4IPVI7WfMbwZ9bEMvNAsgYvGqrhqZgD6sJQhj9s+7Rmn4
   sMJu+VMxsbTMlU6YhYXwem5R0+zGNVy54BN/4pddOwSHji7comDSFK4Ou
   ehK097UfwY0dbo7hE/SiRrUQKpwU2eY0ODtpxHSEmmuFDUgz1MBLar5Hi
   D3vVYgij0TEVugbykOIG4fyvGYbo68H/UtaZZvzad7RabfgCQt5uAqhe2
   g==;
X-CSE-ConnectionGUID: i/3Ugn3KShGdgTKHyUVYSw==
X-CSE-MsgGUID: uaU8HCxbSISsWM0/o6cm3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="38613531"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; 
   d="scan'208";a="38613531"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 22:30:33 -0800
X-CSE-ConnectionGUID: PP6nL8CCRV+YKjr44Ep//A==
X-CSE-MsgGUID: JTpojfy4Q/WnxGFZaBtt3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112760690"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 22:30:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 22:30:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 22:30:32 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 22:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZchT+0n0ertojd0dwCqhlXbmWluC1sRG+VuogRBQP4TYZFTu9KTK4QTJwb2B4imdbLEipb4vl7ehVDgttZuLiFQxSh3lPEdb2Zb8hfcowZKVZPBkVZSrWK5J9nsQQ4uFUzXICzIgEtYyLHO+/9s3C4IRweojn2nW47ZyO96+FZM4e/aF+QmQJj57FYUUZiWQ8WBuwkSa5etAItYQvNwDfaqO02eBlOvaVRVvRAwThF+WsScQeH9bVeHa6GYkxx1gQgnQoPx3aFzBp64UrSdNl8lTkOX/quGhJM0zAcbGP8eUbwck/EETyN21HA7AesxoS2YHXnqxLNU0QVlKbWpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiNYPDhiBSWIrmkQyA5e5ixONs+E0SumHt1cXuAHpWA=;
 b=p8VdbwcXQaZVWYmdM7hv8CFnFVz+0yXksbVJyldiBP3Swryc5/Wt0SKXdNZ5GxU/v0UOlzqPZfvILrhuU1vvM28LzAGt66+ceeBIUsZmsyctWAiskcsHYikM7jajU8bGyzBa2svex+A3V197x3obCPJsJ+gIYlejKGuxpfYnGE5sH8FaBrgZv+g71FQmQd4+9BG9IU4ucSAqOXb/OQaYhmedjPMt28O/9T21g9Hd+7brrVD9zR3LGpCUb9+qIo4wlPQBip8guWgbdD8ZXkrtljTLaRCR+GuD61/Gs9hwd8U7H4O0/2+ACR8N8jm4vhxk8OMrP0APZJm4TpFgp+k0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sun, 26 Jan
 2025 06:30:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 06:30:16 +0000
Date: Sun, 26 Jan 2025 14:30:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Jason Xing
	<kerneljasonxing@gmail.com>, Neal Cardwell <ncardwell@google.com>, "Eric
 Dumazet" <edumazet@google.com>, Haibo Zhang <haibo.zhang@otago.ac.nz>, "David
 Eyers" <david.eyers@otago.ac.nz>, Abbas Arghavani <abbas.arghavani@mdu.se>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tcp_cubic]  25c1a9ca53:
 packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
Message-ID: <202501261315.c6c7dbb4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0547d0-3a88-4450-645f-08dd3dd2e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKrSAg8JG2YjQS9hP6GqQFx65f7k9k8g0IuvnmVZB6mFC+rGLhY6/Zxer+3Z?=
 =?us-ascii?Q?jh2p3GMhRZUs0A+3pRNqUg7TvYPBzqUR4ZfENVp/4LRyEdw5XDA/xUF0oLh2?=
 =?us-ascii?Q?G4MJrPXU5EFQTG8mxPSp6DOkoDTWSRhQk6zctb7pGxqcTeNiDXKevJTnstyH?=
 =?us-ascii?Q?7AgvkVnKJq5a5Xld0nI0k5lS4vMzQIE8Q6F8H7QRt+EjusyqHOuElCycGcEE?=
 =?us-ascii?Q?o9Gf5Qk8aaQWVn5r5LeCd5hE8pevICZTNXvl0w0CwrueMy97HNo/H3xZLyTb?=
 =?us-ascii?Q?VyEf5ZAnLWjNO6H6Sr81CEY+xOOYLK/ZFPudqZJZXV6gWWaisXE9W7f4Ylmb?=
 =?us-ascii?Q?WYrHHfjkFxnCMhXNFdF98pmkILoiWxrV5o3gxZkZxFwHxQ21YV73t1RZoWRR?=
 =?us-ascii?Q?sNvW9Qea5zPYLci1vypp/cx3ly5s5E6P+F3A0zNr1/sRfLKC171B0BSb18if?=
 =?us-ascii?Q?NOR51qoOLSQ9O21ZVJFo/oAhB1TutRjmnuRNnTVoDeE9hXuN8ksJbIyqcsYn?=
 =?us-ascii?Q?yrj/JB6X9LR7JzPfOXw2vxQORiGZID63QbAmL9ilY7gsHLlq8Woaje9ECynV?=
 =?us-ascii?Q?MDySxgAiywGjuH5z6tqy6sudk2ag/kSJSi4DxJQJGOX09l4CzD6fZgpoJsOQ?=
 =?us-ascii?Q?bUpxNIpm5nad1KwGCjTS+BQcqxXxY/pFP8IRMM6NwAwLyy1hUEIBjvg6LgkU?=
 =?us-ascii?Q?vfY1B0dsRmTlc304D5MB7dI5ZJMkcvc8h706xAfSA2/RWV07e2djlU9Ft9hM?=
 =?us-ascii?Q?O89ZSiZMhoEMoE3SdZOnNEVUlQqM3bSwYQ2wIhWkN57ynAy12CUVId0BK2iu?=
 =?us-ascii?Q?uxo4nO9C1oaC9h7X1XGhRPm555s/TMe+UW+R7fszAFBbxfspnDayMtTTEDZN?=
 =?us-ascii?Q?JzGo9wz0C9+1dS5tZErduxIS5B2ay9GzhiwvPPysg1/GsRLKnBwnXTk/MrnO?=
 =?us-ascii?Q?IFxWRvdF0zEdTTrSIUmzayRQQfVw4P57kpFJzhqCtGph2bll4bzJK4OEVyWP?=
 =?us-ascii?Q?Zg2h1Fm010o3/rw3KkYwSFJJfWW7yLwNX13mcZ/QdQ0eX92vvG8ow6YbuS8n?=
 =?us-ascii?Q?HXREL/hqdkuZksW2EOQLcOXtLOU7Ww9zsZFBj5ZqhKL5Gk6Snh5rCncb186k?=
 =?us-ascii?Q?HiGTYooQL2zqPHXjn05lpIYOtCzFANY4HFS8SJic6BiHNyDyN5owyc98B2L/?=
 =?us-ascii?Q?T3/FyP5xido7h/LgW5PUJS7acYeulpmqv/KK4/dSv/nZRZbBdNMRHHiHrUKt?=
 =?us-ascii?Q?zy9StoZEpIC4L9/eaeLM9NEv7eBJrbaTFKrGsa0h/2o9V9Ma775rx0L5ftXV?=
 =?us-ascii?Q?+tScisiInTcAkyalkTmS/xi2PNIcQQYYp2GKtLMSb+6QYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKzTxv+SlJSRb6rlScZeA01pIG1K4guyYxv1TsLPBppHfDHjvCxGmKnl9NMJ?=
 =?us-ascii?Q?nHwrxlzeqrGtswyn8+mXQbxtKdVI7yLwngs/oW1XBgWeLXP387zh3pZZSqsX?=
 =?us-ascii?Q?WafzS3L28mmykBb4cZqcfijcNdOoQvE56jkdmR7os8GjMnbOjfqVVvZwxR3z?=
 =?us-ascii?Q?SvHPL3V5Q8tYg7czmrTgBFpyDSllGLjZTERCiiXEOsKvD2TPmbEr2jZjQVAf?=
 =?us-ascii?Q?Qvg8J/MeCzVgpCyQbElO4ApQkz5L1wmceCkRvjo7blcszhW0TxpQYtH9YxRl?=
 =?us-ascii?Q?RVGDvlOR0mAzM4aBHvHWQwGHrWiUVK6F5clWaIgekXE+c+e7XU7GIuOrmRYd?=
 =?us-ascii?Q?oWUgLzR/nKlK/kuFzaI/k3+w2rTnJEb3m9opwBLBfaOmW+6J0RTdsQIoHB/z?=
 =?us-ascii?Q?k65OCGrlh1m+F9pAnk/bESZEfp9fnC3mB+amKPKLuretJ6Pb/xFelQc8wyGj?=
 =?us-ascii?Q?a0pndiRSm8p6Xcld5yGMVY8Xj9a+1udvtTG7Af7W0l2BVCUoIUNr804kw3sI?=
 =?us-ascii?Q?ZHz5A3bCfMJ0FxymAbIRBg3LTptCuXDXk4n8gftEz72dxgUFrxND+U31/1K5?=
 =?us-ascii?Q?Q2V4fGl3tdUZfuAwSM1LzsWcPWZ+qpTl57/TsPigZI3/IP+Xjs1+MxQ2NyrD?=
 =?us-ascii?Q?ld9x7Z5rDVPeyJ8gbS+Pzb3HIDxYSbN8iPbwzGhQUa23NkDOrwZ+aExoP/cE?=
 =?us-ascii?Q?Wz3J15WUtVsC5Lj4IGwMyb1DsTYvTkLEQ2D681k3bPv+Ixg8T4PN3lOmL7rW?=
 =?us-ascii?Q?D2A9WFmVidKPKjnIA2Nkmf9sY4equkJnhM6elr4BfyvCYp0cGHRxnCgRtHq3?=
 =?us-ascii?Q?Uiyyx2xuksI0opMGBDXYxtUXfTAoisbm8qFY/1bqXjwAWFvwGG3imJvU+2Ed?=
 =?us-ascii?Q?7e9Mom69EtL2Is31vDy/CktZLhKUFutQYONZcwI+BUsMxPREhl4KlH++npMX?=
 =?us-ascii?Q?e5LtNDFJSOeDrF7EYxwkNfiK7qGVqb/Kj2iSaL0jSMGLRyoBox5el9nIe39t?=
 =?us-ascii?Q?SOhMwtlUwoT95SXgzbmiYE+uF08Qkxe8IBzYdNuhszdb9mQiP7PWPIXVmeg1?=
 =?us-ascii?Q?DvRDj4mpJLGciED224LuoSMcoMgcMWQJTeoBmq6T8LHFPBifbq6ATKWSsh2Q?=
 =?us-ascii?Q?A/djRCihlqk0A8bkK0BfTQ/Hp898VYxhfBbClnkl9Br4qo3RnG7Dm8bxS7Jt?=
 =?us-ascii?Q?GRjNDmZp6RrlFIVJETK/kFrYTHnbyhmDgFq6zfRoCQT3A8kWSYltmts2/vFa?=
 =?us-ascii?Q?l0fjiVQSb1w4pRzyL017AwQHPlvMqwSNtG63GcjV6AueLe4LZCu1EBA5eux3?=
 =?us-ascii?Q?pZP6lrt/hjkjimKwTsz5uv+YMo5hWhZwxGpBEULF6dZTeRpgbHP37Wof+nN7?=
 =?us-ascii?Q?1E8mAEUMihcRyzjv9VNYfBMBDMrgTjN/SengHWnUUpn+ZDMe5Ix/xbWB5FYL?=
 =?us-ascii?Q?vlYv+T0CN8JIETF5307UcKDFS6mZ5utHxcW6Q/DTv8lIyS1f1B7EU22XSGaL?=
 =?us-ascii?Q?SBi0wmE7Gvn5n7mWqwgELeHYok8+EkaH5Xi14f1NxyCNzOTIhLT6CLlyvyXr?=
 =?us-ascii?Q?AaQhegsvNQAoUyay0qvRW+cLUK0cDcpsFYePyg9sioNj9wy5bgVPpfunuE2U?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0547d0-3a88-4450-645f-08dd3dd2e593
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 06:30:16.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UDazpkCRPz1qyFAPgtQiPIJQAh2Y/XB9Nfc9jre70vR7/y12IJOOQfnajRspUodCLz9oFEnuzwYZJygpfhofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail" on:

(
in fact, there are other failed cases which can pass on parent:

4395a44acb15850e 25c1a9ca53db5780757e7f53e68
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4.fail
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv6.fail
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4-mapped-v6.fail
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4.fail
           :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k_ipv6.fail
)

commit: 25c1a9ca53db5780757e7f53e688b8f916821baa ("tcp_cubic: fix incorrect HyStart round start detection")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      405057718a1f9074133979a9f2ff0c9fa4a19948]
[test failed on linux-next/master 5ffa57f6eecefababb8cbe327222ef171943b183]

in testcase: packetdrill
version: packetdrill-x86_64-8d63bbc-1_20250115
with following parameters:


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501261315.c6c7dbb4-lkp@intel.com



FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart.pkt (ipv4-mapped-v6)]
stdout: 
20
30
36
stderr: 
FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart.pkt (ipv6)]
stdout: 
20
30
36
stderr: 

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart.pkt (ipv4)]
stdout: 
20
30
36
stderr: 

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.pkt (ipv4)]
stdout: 
20
30
36
stderr: 

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.pkt (ipv4-mapped-v6)]
stdout: 
20
30
36
stderr: 

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k.pkt (ipv6)]
stdout: 
20
30
36
stderr: 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250126/202501261315.c6c7dbb4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


