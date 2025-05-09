Return-Path: <netdev+bounces-189178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF94AB0FEA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E96098263A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3728EA48;
	Fri,  9 May 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA91hWE9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B228DF53
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785303; cv=fail; b=sEpFT6NYyisGcERfy288TR2g6KDAAL/xQxMsIfz5550ZXADPm0D+oJ1qAKw0+/I0S/SuBSs57Gya8Clc0agO8VJQHKVEknBLwEREWeQRMjyHzGb3x5GPeRe8IKCFZ5cId6k6sMNouP1GNSUVZf3UJa3kcSHYb2cxZoIUzN2hJL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785303; c=relaxed/simple;
	bh=xFZmVc6Uu7nSeXfW6g7a9P3PFCoZ1Lxu0F45vpZBJKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKVWGbbmD5tnG8eaU88M6fGD6fAp3WmFOuTRUHK2bbnuL/OLvSHSs3egUG2K6aSJhlOd51ZkdrXhPalKRQPWy+WxlEQmDzkvTh2G7EQ+Z4m8+fsfwfkK314OgGIlBPs5BugpOHlJNK7jWCBS+9iT1JkVoFPO+esaBHbnRgegoZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA91hWE9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746785301; x=1778321301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xFZmVc6Uu7nSeXfW6g7a9P3PFCoZ1Lxu0F45vpZBJKE=;
  b=WA91hWE9wYJdZyXplyR4VhV4i6KBurmoqGjcHHxuPsR7uAMn2B/FgwwE
   VCLM0vtbzw+6+E0GlG59dlS2MBoj7yh6Ec51791ts7Gr4ZyJ/+09FKnvH
   JEBmj8di5eE8R0qDFBTGJFWoYq5GgXr+/OQhrnSadhHDNIRLJ3uvxylha
   Vng72Wi0tGTGPytd43Qg2qBEfuB0KXSPqe3giToCAZZiEC6pVJtPaBHFj
   wFx8C99rCUI+oIHlEJXazAdtNJG6fwzm33iqDwNmsaf2r9XdtwKCFy5mV
   Xy0F38IQsG0N1oe/L3XC49jZK18xbWarUm5IN99EoaGOb6KBbiSSvLqC+
   w==;
X-CSE-ConnectionGUID: c8GOdP8OTxSVFQbfhU9DGw==
X-CSE-MsgGUID: B4xsqAk/Sy2Qf9i7oZtTEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73989939"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="73989939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:08:18 -0700
X-CSE-ConnectionGUID: /cMExbSDQIGeQjrsdXFvAg==
X-CSE-MsgGUID: UEe8gUR0TKSVceFNPkQ43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="167508140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:08:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 03:08:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 03:08:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 03:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WK60RC0cycP4bap7aQycNOiXbsrC9lonFGeQ9Dz1HDrEBXSnSn3Xb6s4UxdiRxpdKS2WEbT6P0VEchad6ftboSeENJaNdcEu0TjaCxq4lkkCaXP5N20WMOAf8DZHOzM95Tq0OZdrTw4NgzzrrrOdJoRfA7ke33BDuAYgyQGCt2I3H3cfwKaAY7T83eL+phYWHval15yHmrJ7AtXnmUBbzSIiJBhejUYQ4xqIN21Kg9yO5ouc2iCnP7D4LHKKQXYU+o01fTol3dI16cQIeeKMbSCgX0xdUy/TYD/teTq6DUxYTS25rNB2pr0NGLlLayJZu8Co3Wmn1SaUkF4z57mgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEHpHBveKQbor0yb2D5KjzUfz0IRi+CuoQic1/RZWA4=;
 b=BY8J/zNsF+4LAkOISZpsB7lOwjkeTPFn7l+iEYT46MAbYRCf1dwLGjLnFIHlOGLXM35m5XnSt+Qi9NczzX7z97oXL394mMTZHVyGYMzS/RkbRxK/Bwa3TbPen2DX7yM4n5ejTXdenNQyH3A81dAYGBrBNIGm+B2/RADcOSfeCwt8LT0cvUqmudffMNSOpFwtvoiQk4fUmKQEyFhVt84bZjX83/qN735p5Z0hc/0yha7NE7M90QrNYT0i/AJn+Sf8lPnejougP+r4PSGDWFRX26n5IxisXx5Nxdbu9AgDABu3VjMEt/4fjGo8bOLtAwMG6072UYeH1p8pVL9QvTWv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 10:08:01 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8699.026; Fri, 9 May 2025
 10:08:01 +0000
Date: Fri, 9 May 2025 12:07:50 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>
CC: <intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<aleksander.lobakin@intel.com>, <przemyslaw.kitszel@intel.com>,
	<dawid.osuchowski@linux.intel.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH iwl-net 0/3] Fix XDP loading on machines with many CPUs
Message-ID: <aB3T9gmOo37GWNKI@localhost.localdomain>
References: <20250422153659.284868-1-michal.kubiak@intel.com>
 <b36a7cb6-582b-422d-82ce-98dc8985fd0d@cloudflare.com>
 <aBsTO4_LZoNniFS5@localhost.localdomain>
 <cf46f385-0e85-4b71-baad-3b88b1d49376@cloudflare.com>
 <aBy_vW9AixQ4nREM@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBy_vW9AixQ4nREM@localhost.localdomain>
X-ClientProxiedBy: VIZP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::8) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 89161509-f67e-49da-f0d7-08dd8ee16190
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3HeP/XEY4SJ6lBejVAqNdrzC2EMe8N0BwX0cO2NcItb9015JPU50tdgrt7V9?=
 =?us-ascii?Q?6Mur6+pX7Fa9Wygdbn+2LH+7Bwz1EMjQGZoQPys6GVcp07rk2nNwKGHLrgPh?=
 =?us-ascii?Q?TeTaCt2Reyl7l7d5eirBHSuB1g9zw0TRn+CfZ0wAqDRVY9keQ6UIs/jV6A9V?=
 =?us-ascii?Q?bjenrtWcZKGckKiH7cuiRZZE6Gwcm3fPtmYwH7kOY8hC/1XjbHjQEMApZIjG?=
 =?us-ascii?Q?YI/lJ07UmaZ/zioURZ+efXFq/SMSOTD3VpRC4Yh4FKV0x//NiYyH3LoaK9KM?=
 =?us-ascii?Q?xGrOVRwIgaNdwc0QjtHjaYO9FV6EX/lsvtp/zd949N3Z9ttQQkAI1+XSX322?=
 =?us-ascii?Q?hyD9Iz2yq6sUOHQQWkd0llYBc8ZqCCDkWxDgxK478UTUVFkNuW/drdhT9npb?=
 =?us-ascii?Q?NM/hQPtaIu2M9wgb6eoIgD7IbYPAQ3350DxlOY2eNfmD/9uGXVGdS3MEbduS?=
 =?us-ascii?Q?h2jyWrLhwDz9mF9TorrCnNqbcWX3enNdVSr/mYgiCnRs2rg2dzJJL9Ov+vQh?=
 =?us-ascii?Q?OPEd2hldYw+VW2nNzEO0l5YNByzL8mC0fRSGj7xy4T8NPG0YNxORLb/H/rzj?=
 =?us-ascii?Q?3FOP3E3kbxHnjR3j2xRjVd/uxZ6w8+B0aGJVlRqHFB7zAM3oyr6LwApHtukn?=
 =?us-ascii?Q?sCC3OCEvcx7LnW1FiTSUZS5nBzC2g4zNFu+XKdf7WLPmS6wb+Z4JAgsx9G92?=
 =?us-ascii?Q?nJiBuhIFtYJWXgWdal9NKZQIvF1/+bvJV1NV6rmre7L0NAT72LannnxWsqNq?=
 =?us-ascii?Q?uwd1h8SzCfsZkaT5vzaaW6N+5T8mhAzjsoxrTp2G6lEhZUq9RE8XNmE/EV7D?=
 =?us-ascii?Q?44gBzFtATQfl7soPC1CUjl2NHcjBry8asIazw+52lvYUfHV4x56RTHdXlZdC?=
 =?us-ascii?Q?iKEgw9je68YXoIZ163q9Tx2//SyY/aKx8D0MVfr8vT91ChfO5IdH9+Z36fX4?=
 =?us-ascii?Q?+ydhJL1s7crhaOMqghusunfe5qkeVg8H6nKOeiNSpHFAkcKvTy7oi4aeQ06A?=
 =?us-ascii?Q?l+DSBxDYZ97yEgsFL95MnFQNhUhynMoRSMHsUIBB2y71SNiHxFDA/cyJTGV3?=
 =?us-ascii?Q?f5yTwe+fFiJmn/aJ9xLQv9pDyq7qqihhyUduV4p31j8HE1oP7a9Jv1ww9AoU?=
 =?us-ascii?Q?QJZUjasn8LxBMBLn0lLjjt5p4evpF8ywZuaPB1Yume7j2PKo+l1Qf1iIkY1O?=
 =?us-ascii?Q?82CMa0Mt+oFjGKxhqUbcxT7Zjt1FDPz8+FGaeKddhqiucq9dMLEAo/+CnqET?=
 =?us-ascii?Q?RiN4dDyxbmgoNZ9sh7T1Xw30gg7irveooEiPN22aXFtkw6ODIDRtXBSqAByg?=
 =?us-ascii?Q?I6qhSs7uranOMAK8b16nAVCZcqY+d8buXFC9mMlJFI5d2dF7jpLX67pQjYBs?=
 =?us-ascii?Q?uNR2MIhHaEl2pFrA8jfTMZbL/eLa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBf4CTvYquw/A7/ujFU3vO0BXQ8WduFZTe5+RPreh+1Iz51h+E6DwZ8lK+pI?=
 =?us-ascii?Q?3EqF4AhjYxfI4QyeBBWOqT25mJhVAuu6/zQMEBrXhe+CXlPNpAR1e6te1DZX?=
 =?us-ascii?Q?BM8ivjpgDVR9XLhJR03ys8oa8LFdYluuaOsXRgx1H122P4yrj1M9UTDIZaXe?=
 =?us-ascii?Q?lyeiN2JQ9xrwawI1IzIPWGjaJuW1FgOWLBIBKv6JWQc7yvoqdgAS2DKN7z4j?=
 =?us-ascii?Q?ZVFlej6eTeUsigjOMkR0l1XZiZTVXNZeGWOKmBpp3zL5MFIgMA3uBqxjCdy5?=
 =?us-ascii?Q?66ppIYOzinhKlwpaWiVD9yopvvmq9WhT1mtRnjMlUmbOj7DPz0JCliVo+L86?=
 =?us-ascii?Q?5PtrFbGzg3bIK2+S27MzYndawjYab5QljZkp6+YcmMiuV2eJDFB25R1WPgTm?=
 =?us-ascii?Q?CbbEhf4VaBbVQcnqt3eUnzUz49lGSsCJto9XUA76LyG2E2QzRRYvEhmcPNjf?=
 =?us-ascii?Q?fYMoGLoqNL4EoASzdImXp5yvKAD31KyUOLB2iItKuQAeMZUvF079wbH4aFay?=
 =?us-ascii?Q?4eGoX7Id28CvrrV9tDV/glQq6QdqXUsQs2lm/5ZT90GQzCXWGKb1ElXhKOXx?=
 =?us-ascii?Q?gKSvy9pxEnDieJljIaYlWgrH+eSssSkKEaXhPTLJvc5emRUb5yIbnMshuz59?=
 =?us-ascii?Q?QZZ+pN0AuFRpj1uxaAGVU0lq6FAHPyDecFbdDT9qJ8YXobXbNNnW1JdZHE2b?=
 =?us-ascii?Q?rlviXxJuo947RAXYzzs5X/7e8djETn16wA91E34jksH7HSxH6KUrlrY0EjBY?=
 =?us-ascii?Q?7sZhoZOnl0Xh26aHmndNBpy0/QAxTJRihjTTehLc75HdmsgcGAacCLJ6dBKf?=
 =?us-ascii?Q?fVrC2WQbMYdsRmzAAW4GSPxc7nqHh4KKTQT1vPU/SrXCSIiYk1vWA7GtkU4o?=
 =?us-ascii?Q?FFOLlhe+hWd2OQ0MKCrO/L+ADfr+IpRfkWY2w9E+F4pjZZ+N+47Io3C8HKxb?=
 =?us-ascii?Q?etAFjeME26h15KPyuUy0+peWjgoC4SEavvbEhi2dJ98G5nXMdEiUZNV04Y9g?=
 =?us-ascii?Q?1FoO6Hl8B2ZDnSapShQe9qS+qt/onJqKFB1O8hui4ihUwYaYSxxN7hz6hMkV?=
 =?us-ascii?Q?ZPcI+ZeA1I91z8xvitkOTh6hV87qkKCQGRoCheRGkNsUHIIl0MpQoaGZwTuh?=
 =?us-ascii?Q?z9V9guNUV1uds0TlWaaVi1ylgYotVd/Sd5r1NczXtqJBIhJ7kB9x0YrfVuKG?=
 =?us-ascii?Q?+nOqnLhN1V6e8qmM6yjhs8WRxbKsFgLsYdxTIIzwBPIp1Qqb4yptCDmt2AJ5?=
 =?us-ascii?Q?9Yt6Rqld21qoxRvKqDKslKeSMk4GXPDfwIx0NK/5YKfQ73CbnzuKv87st3w+?=
 =?us-ascii?Q?t3TkeIX2JWZH/tMtvsljJ5+kuFDL2w/lrHvEzMx6LRYkS5MLA6hDO/FmHOMp?=
 =?us-ascii?Q?dRTvk6GMhxm4gGswLZcb3JggOlZuUNfW50wa3j37S0TuBRJvdfapBfUv5o8/?=
 =?us-ascii?Q?2s3vgsuCrlQlo8vnZVl2b4G5jq54KJLRMqy+p2CYWPo8pmxCoJInbbcW9i7n?=
 =?us-ascii?Q?qGIcozQhzs0r4dpDYfrWDq3ztMoGZF4pfg1nOni9qMcKPg7+Lb2TpUHnyBD9?=
 =?us-ascii?Q?QEONPq54j5bQyKNTN1deeGwl5WNhhgOIIvBIHmByhxY6TU6KwpyMSERxvnO1?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89161509-f67e-49da-f0d7-08dd8ee16190
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:08:01.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAB1oC7zGTJKXfON8RZBFMbhVvW5k3zcpoxDMkyEbzQTt/Qmk6aSm9o/VhvQX7jvgyZHkoOQRYMhS+ZKoeBsKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 04:29:17PM +0200, Michal Kubiak wrote:

[...]

> > 
> > Thanks for your patience while we worked through the testing differences
> > here today. Hope this helps and let me know if you have more questions.
> > 
> > 
> > Jesse
> > 
> 
> Thanks again for reporting this bug, as it seems to have exposed a serious flaw
> in the v1 of my fix.
> As a next step, I will send the v2 of the series directly to IWL, where
> (in the patch #3) I will extend the algorithm for removing VSI nodes (to remove
> all nodes related to a given VSI). This seems to help in my local testing.
> 
> Thanks,
> Michal
>

Hi Jesse,

I have just sent the v2 of the series which seems to pass my tests.
If you have the opportunity, please verify that it also works in your
environment.

The link: https://lore.kernel.org/netdev/20250509094233.197245-1-michal.kubiak@intel.com/T/#me89fd25db3e9c9101f4030af2c7ce8662686f3a1

Thanks,
Michal

