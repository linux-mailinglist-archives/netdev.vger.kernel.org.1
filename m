Return-Path: <netdev+bounces-232768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33CC08B99
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 07:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103F040234E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9632C17A8;
	Sat, 25 Oct 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XecOMnrL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090892C15AE;
	Sat, 25 Oct 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371033; cv=fail; b=TUzvcJWdHw3MS6WSQXBrbgOCU5zNW//jQgIWPVKTjFybBjFK7cXkmkEHDvBLqW28OoNXA+XRsScz3a87x+oYumrL4CT0DtnmGmysysJqLpqfJ6A8ZEAZQxuf03n7GvfUsVjbM24IRrGZ7nyjuulaE4CRguYV0/qdq8/ZUxizGy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371033; c=relaxed/simple;
	bh=zisaosni7C++w4G/XtkjDScs4JvKVi9xPtk+7yjHNgk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ESGFqzxvwdoP0VRVL7DW9XbvTmYnCeStSwZ2NsMTiF0r+aZ4LbBzlDdA/6bhDJEj0typFXh8Hx3OatdESwdd3C9afVTuq9XjVPUnsHgpqbadhOZxsUNol1PPKxwj5Z5ZDpw2ugHcBLFTw+2k0lmKqWTqLNBzMYQK8eP9Plt52uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XecOMnrL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761371031; x=1792907031;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zisaosni7C++w4G/XtkjDScs4JvKVi9xPtk+7yjHNgk=;
  b=XecOMnrLgq2fU7P/NUc63+YLFHmSKzI2JE+KQlLgrFB/q/MGE1n5W0NU
   rVouovDmYyvcKe5wMDeRYYBNjPanleWdxfAUUaPmk3oWbR8/UniIW3+2Q
   OhENh+XNGk8bGip+rfS88XDaeZ14hrTKsc8OYLtwiqdGp+fgW15p84SbX
   nMv3zKEnA39i9FdSPPBEo/hnSjVnf4h7YNGAcf+srA5skFzSWa1vDw3yq
   OzYgmhYOfhVdh23afwCDeOwOdSAyovA0866YcYgR+CUM8/8oRnhGu5Ljc
   ypXAWA1Hyy/euJPISHAnnrDzAqrqt9lknG7eBppB+HNYvjvSW3MADgTCp
   A==;
X-CSE-ConnectionGUID: /tKy+ZGvSwmQxnfwP7+bBA==
X-CSE-MsgGUID: gK6Eqs1OSFmkpBYzQI5qqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66157320"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="66157320"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 22:43:50 -0700
X-CSE-ConnectionGUID: fa2TfYsaS6W0Em9+Zwf37A==
X-CSE-MsgGUID: FbmV2lRoSDiHh82RVqZ+Hg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 22:43:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 22:43:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 22:43:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 22:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1n2k+PsrlxcKliylj5jEVMScShqSPe9E8ZhWgfuA7NDgPizavJZouyk5g2AyBY+AvDYrSa03HssF4s5nGBsRrGPTelo1HK0zKp6/9XQFGI3PsIgdm2HxiWFFmGsqn0gXFlS49kq9+KhYmUGU21Ehr6j+tSrJuqmTV2lRjJB4i4bPerfXdyd3xPyAGn3FEp+NmgHtu5cbpV6MIdhWzRXQyUsBw76uiz64q+NvAq5dp2hK9734IJM6NexFCxCVtUtDBa2/CpbsszG9VWSYx4PzKNKw7TeRXrX5gPtTJDKtRlKGUyZyYhMC4s1kPDWxYQaxgvNb76/XYCgdjHjpYxnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdX3QNmr4PgPmr5U1mMyO8DYLKC0zKoBhgLXI3wjlGM=;
 b=HRd/3CPv6MWWogqunk32NKTqz//12gzoLbgfDUA8p7rEkO2kbaunjznK+bJRZIspk1huczWYroQBqsuR6jxCFRMPnNxCIL7NGUAJcRZBAsjcmJx2WYIFhHvnv+vs0S/b5kb4QRwi37wd7QKH6vcCc0WyEnMCnae/hYU9GP49iLzZxkVWOxaHxU3g9xY5NN+QfBRZiZG8fxIAk+SReD+z85IKb81qmqnSmdFdp6yHXG2EFG2EzTYEfdBNyjgeS0GJxjxI3mVA9KU8L2fpB/xt0TCrgFbWoas7u9OugVlcZrMP3qpC9FFxtBay23nfPyOr8v7cXjr5gyqKCioq8dlqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Sat, 25 Oct
 2025 05:43:40 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 05:43:40 +0000
Date: Sat, 25 Oct 2025 13:43:30 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, <netdev@vger.kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, David Yang
	<mmyangfl@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Message-ID: <aPxjgsRc9E4pGoJm@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251024033237.1336249-2-mmyangfl@gmail.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5a6e88-b455-4b40-a51e-08de13897377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbAB3JIaRR75o1yPHBIcZ12dvrxgWoMbxor2T54LdqNxJnWnGLNo95X1aJrg?=
 =?us-ascii?Q?DH2hc5908+lIRnji5CYmfuqBEonVzvd7PaVysCB5+ncF1LxP/gY+mjLvLLEY?=
 =?us-ascii?Q?10ys2SFujmIk+ngbNoesdxs5pyfwDVJDFXVr/oVpsx8fmeM8+p+VDCBd7ev+?=
 =?us-ascii?Q?CR0g9Fvd25wIM3uApTclt8Xi2Q0/DP4AFbkn7+nE0x9IIdxQCg3XGj5ngSsD?=
 =?us-ascii?Q?Ck9qV5M6CRFqZ9zRGtjRdpKO0wikza/BzSs4F+m9pXEzFhhyqdU0gTpU3le0?=
 =?us-ascii?Q?QEecTtGcf+nFFBS1sKTqlKQtLTiFrmiM2k2SOv7kgNkTsr3fQ/jKb96fRjv7?=
 =?us-ascii?Q?xnwn1/VjPC8DbH2B8n6bk9dKv1breeMs55HdofoAgHimKL+90J+0upwm5o5c?=
 =?us-ascii?Q?4bAqdviHLtdOah6WHU+dTZkDOZamO7T7GUcewEE2Mg9IdP7uncrITgoYNR4W?=
 =?us-ascii?Q?t66xo4FYk9ToLv+OT3/Nr8dLvcG0eOIySUf1xHRn8LHtT8G5fBDH/hGsNR1u?=
 =?us-ascii?Q?RJye7k/g3AZBYi6wViVC3SQoTjFCe9aUIgNbcni7sM58Jm18gF+N8XZCediG?=
 =?us-ascii?Q?/+IfcpGMIa6b6V0oARBKUgg8uk3cEK1N2lbR0gB7wxz2l6U3ZVon/mYRojS1?=
 =?us-ascii?Q?9edP2U83m0dGUELVOZ/yd71oSYijMQoEfO5eo6421WKbRNo1gIX/EF7Z1mqc?=
 =?us-ascii?Q?rD9W3M02qDe2gDD1bnMKFnQMiizp2PzBp17Ibuf8FNsWD0js8UqSc5E3RHkj?=
 =?us-ascii?Q?O+MmMXeK0ASN/dfd+1VK4YjpP8gryKPSakTmgUkmdWgblD59/LECllCmcq7R?=
 =?us-ascii?Q?CBPjqa0uFlgFMoDY8cgQoVlGTxWR1u1nC9FCF1YtGQIJlQpu2aFP0Xpwsl7h?=
 =?us-ascii?Q?Nvk2HPi+wljBl1NTO3iRsXbLgeLMIyMCqwqm6bSnCB9iI4pro0TFC+MToRQ8?=
 =?us-ascii?Q?qAcfhzViMcykfPP+OSmONIqSjFLvA9/H7Y0Fkdj3NM+gdrhYuzLy3b1QbEe7?=
 =?us-ascii?Q?cMR48sdpUucyIMMP0NMp1EWVJ4c2V3I7DiQUAGXyzBZVcdpvKkL29gRpj6bI?=
 =?us-ascii?Q?NetZWzf9ow1IEJ0tECBM4qhLFRhjeyG/It79DI8b/NYK1uvz3JJzvLyak30K?=
 =?us-ascii?Q?12tJWYoAMJfXx7Vy8WZ1F2RyNLwtvBpT4ANKiHV3tefArgo7v8wCqWPRi7/s?=
 =?us-ascii?Q?smXOQRTRa0fBuUDpBeX3r8Q+DDP/+h8o3cXHDYvo/yY42ynF4S+WvFQ5enKu?=
 =?us-ascii?Q?+xSFifGZFQH02iooMWPF541UwH2h9uFtgDJ9ozMrRmhykMeS0vbll9MpPFZx?=
 =?us-ascii?Q?ZxG1nBArJ/FlYviGVKq/W9JLRvO/7RGxijfQlgIrxSsvwaimwmzdcEy4gT7f?=
 =?us-ascii?Q?VMs1IQJkjLXejc5919mVCrTUYR25ZCaPS3aPSGuShNioypkodpVw22KV8740?=
 =?us-ascii?Q?A/TLiTLE+6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FThjDn5X6SKecvrPvBc+7qbeNmh5Lo4FGpjNSgQvAsaGRomIjMu6Qoc5jICD?=
 =?us-ascii?Q?oPz7e+a5oUW47VWKjBVvkMPyM8bqlt7kH+EVf48I8EQkSpiYGFtfqQfsD99j?=
 =?us-ascii?Q?+16PvE3JMDNTqkUXJbC8+Vu0imfNQ8LLgOm7vdLsu7OMWn608FjlBJ/kQGA6?=
 =?us-ascii?Q?FYGq+LFF5HC91uj0bLmm7A74GG6mt2UbfqJMf+rKKKmWs7tsyBn+Y7a8l7Z/?=
 =?us-ascii?Q?m/wf1UXJ3mglIfZ+j0KMg4bNTt1+iN6jHfcOmecW7D2XcOBjSHCXZ0VLMUPt?=
 =?us-ascii?Q?pOQ+kIKc8/C8RjxpFmKgnSyGXTvz6UbQt7AHZWGD1+4vbwDOobMkIWM0CVel?=
 =?us-ascii?Q?zAg0c4r9rwIzJMCFpmuEVYidV/kuozNrM4ecYapDYc/mmyfMRKLPsy8RacgJ?=
 =?us-ascii?Q?BG4RIaiawVWT1hh5U92hbIycKvYDAkit0slh7f2FMofaJmi3z+RLvIaYeuF1?=
 =?us-ascii?Q?ldsVuJwd+4KoVqCbE0mTPvejaGO3uIFPjEd6IPuY9HFueuvnlMPFauFrCHca?=
 =?us-ascii?Q?8wrCGjYUwjyXf1xcPWs39/G0STHQqsX09qXxnDO/4NqOZXHC+Rl4SBGeJEf/?=
 =?us-ascii?Q?GB4Nazo6CgGEGs4Uxq3JzEgmEUYH5IxDF0YhDT2367UOjq2Sx1lmqC/RGCPV?=
 =?us-ascii?Q?V/JhSUPHFQy81ECqYJ/XDeL0HvHMoJF5X2cmw3GWXuGKeGy15X+ljlLkWCK8?=
 =?us-ascii?Q?n724ch6vmydhnjXQheH4J/lCc56lsauGa6j0EYg4F/0E1qHKSsh3AsRveJEc?=
 =?us-ascii?Q?abJgJ9BKehTt9N9/cbpVcMbUA2UiTFwI9i2fdozjH+5VOkg0kQj48Ez+DPdE?=
 =?us-ascii?Q?/UKJTCqLf8fpcPzl1WG2T9skFVaSlOuhRGWtelsmZfbkFD89lpb4r9lFfo7m?=
 =?us-ascii?Q?3e75p/vbhFZdEUdl2ATmhVaZrG8yTmbCYLCt4bahWZeCRhfBIygV8UXya+Rm?=
 =?us-ascii?Q?mgHYVI4VZ7Gm/ylnmpsFhxy2eov3XXegicTc4Bzrp8CDr2lwfbpbIAc0xygi?=
 =?us-ascii?Q?LQ4C6sGSLfhE+stdcFEQ1IdNqKQVBVglLheuKoFS99fhE8Wch31unEkcBwSW?=
 =?us-ascii?Q?nuIIut6WAgVNYS6RNsbn5dmj9sQCm99lln74i8/GFCR6O7wk1XuwvcRdUY+P?=
 =?us-ascii?Q?m0vdrW/ylRVWDedreLwLcR4lhyQSuz2jYB6u9K7Kch0zXUQCHUySGsPDTZYZ?=
 =?us-ascii?Q?d8U73MAQPpceqRphg2DRe2t9Gzxro0bwcdP7CqKnMBQCps6q8Jl24bvzOrrV?=
 =?us-ascii?Q?Jf5I34avPN5fBV2+yqUTAGvIF//r5Ajo57l1QDwLn1oRboZdmf0+E3DYWBjk?=
 =?us-ascii?Q?0wbyh0u37CKbyE8yc4/2YpTaoQHJMj+aB7WmU8g+rU6Gw5kipG7Rn4ENbZ++?=
 =?us-ascii?Q?+UPQ1QMPsYjauhZ0yb6ksCCjxECQscEcTiC3nzzWnmT8rp8wBbK4wj//hKkQ?=
 =?us-ascii?Q?ZM4bvWa/Blrx0+5g/Re4OLcgzM/lDVMrvy94M/NRRi0jZir9x/4MF7h3bY1/?=
 =?us-ascii?Q?tHg/FtEa4G5tyTpoGE93VNnJIRIS/+arMTZh+fwY1kedx+YcJEgkDDxsXFFs?=
 =?us-ascii?Q?Rq9JUVU1l3bEb1lcdMpyPUQjHzLuzdyB+DIz7CF/6FuJk07PmLwBScHs8s1H?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a6e88-b455-4b40-a51e-08de13897377
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 05:43:40.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFsHLFbcY3o4E3NE4r9IkTdNpV40iLxLTl7Qa6oYR8o5TKSwFuNiKHFUhc0plIyyQKET4S6CsDQ4UGxr82+RbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-yt921x-Add-STP-MST-support/20251024-113613
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251024033237.1336249-2-mmyangfl%40gmail.com
patch subject: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
:::::: branch date: 22 hours ago
:::::: commit date: 22 hours ago
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251025/202510250954.SHhCZUaW-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250954.SHhCZUaW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510250954.SHhCZUaW-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/dsa/yt921x.c:2154:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2154 |         mask64 = YT921X_VLAN_CTRL_STP_ID_M;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^  ~~~
>> drivers/net/dsa/yt921x.c:2154:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2154 |         mask64 = YT921X_VLAN_CTRL_STP_ID_M;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:51: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:597:22: note: expanded from macro 'compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:585:23: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:577:9: note: expanded from macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:51: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:597:22: note: expanded from macro 'compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:585:23: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:577:9: note: expanded from macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:51: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:597:22: note: expanded from macro 'compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:585:23: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:577:9: note: expanded from macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:11: warning: shift count >= width of type [-Wshift-count-overflow]
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:51: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:37: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID_M'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:597:22: note: expanded from macro 'compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:585:23: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:577:9: note: expanded from macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/dsa/yt921x.c:2155:11: error: call to '__compiletime_assert_989' declared with 'error' attribute: FIELD_PREP: mask is zero
   drivers/net/dsa/yt921x.h:342:40: note: expanded from macro 'YT921X_VLAN_CTRL_STP_ID'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^
   include/linux/bitfield.h:67:3: note: expanded from macro '__BF_FIELD_CHECK'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:585:2: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:578:4: note: expanded from macro '__compiletime_assert'
     578 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:47:1: note: expanded from here
      47 | __compiletime_assert_989
         | ^
   6 warnings and 1 error generated.


vim +2155 drivers/net/dsa/yt921x.c

5c1f0fbc2c12ae David Yang 2025-10-24  2139  
5c1f0fbc2c12ae David Yang 2025-10-24  2140  static int
5c1f0fbc2c12ae David Yang 2025-10-24  2141  yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
5c1f0fbc2c12ae David Yang 2025-10-24  2142  			 const struct switchdev_vlan_msti *msti)
5c1f0fbc2c12ae David Yang 2025-10-24  2143  {
5c1f0fbc2c12ae David Yang 2025-10-24  2144  	struct yt921x_priv *priv = to_yt921x_priv(ds);
5c1f0fbc2c12ae David Yang 2025-10-24  2145  	u64 mask64;
5c1f0fbc2c12ae David Yang 2025-10-24  2146  	u64 ctrl64;
5c1f0fbc2c12ae David Yang 2025-10-24  2147  	int res;
5c1f0fbc2c12ae David Yang 2025-10-24  2148  
5c1f0fbc2c12ae David Yang 2025-10-24  2149  	if (!msti->vid)
5c1f0fbc2c12ae David Yang 2025-10-24  2150  		return -EINVAL;
5c1f0fbc2c12ae David Yang 2025-10-24  2151  	if (msti->msti <= 0 || msti->msti >= YT921X_MSTI_NUM)
5c1f0fbc2c12ae David Yang 2025-10-24  2152  		return -EINVAL;
5c1f0fbc2c12ae David Yang 2025-10-24  2153  
5c1f0fbc2c12ae David Yang 2025-10-24 @2154  	mask64 = YT921X_VLAN_CTRL_STP_ID_M;
5c1f0fbc2c12ae David Yang 2025-10-24 @2155  	ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
5c1f0fbc2c12ae David Yang 2025-10-24  2156  
5c1f0fbc2c12ae David Yang 2025-10-24  2157  	mutex_lock(&priv->reg_lock);
5c1f0fbc2c12ae David Yang 2025-10-24  2158  	res = yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(msti->vid),
5c1f0fbc2c12ae David Yang 2025-10-24  2159  				       mask64, ctrl64);
5c1f0fbc2c12ae David Yang 2025-10-24  2160  	mutex_unlock(&priv->reg_lock);
5c1f0fbc2c12ae David Yang 2025-10-24  2161  
5c1f0fbc2c12ae David Yang 2025-10-24  2162  	return res;
5c1f0fbc2c12ae David Yang 2025-10-24  2163  }
5c1f0fbc2c12ae David Yang 2025-10-24  2164  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


