Return-Path: <netdev+bounces-294794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y6IrM2FHIGr8zwAAu9opvQ
	(envelope-from <netdev+bounces-294794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:25:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83C639256
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="Urx/oWCf";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D02A31B9864
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8230CD92;
	Wed,  3 Jun 2026 14:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920712772D;
	Wed,  3 Jun 2026 14:52:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498344; cv=fail; b=LbF9IDEdKZnqh6OpO0ikOUdEQUQ3LUTUnNQ14yJSC99lhLGaxsy0UHc3kFsqcCrrHPeP5OQl13ynnBsYFGMUywJ1niQBkqy5Z47XgV7ebKKjuad3feyFIhcHrbVeBOq6dflIiTffTAU8ioaTtD10dZ6HEAjMeWWJXodf+4yLh1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498344; c=relaxed/simple;
	bh=WTi2DSe4y0Vr/Bs+O4LiObBJzSVbLuDf8snVjRP3Fhk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGNKEJcQoat6jn03LWMgKX0IpYnbjzkXo/yX0F18nk98zBE/yvjbyXi7qeVDvcM/03o7LFq/JGwgWqWcrZC+e45E8/Gsy+kSn6Hf68EXegLPbsKBs2iinfLofnnUfLp7XIaAzVtTT6SnAUO9EFoW2kTkt5aSnMtJQCNu1/B3iMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Urx/oWCf; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780498342; x=1812034342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WTi2DSe4y0Vr/Bs+O4LiObBJzSVbLuDf8snVjRP3Fhk=;
  b=Urx/oWCfG+IsLraa9YVYcLzCO4YjBJdvZBtOb7UeC1wE4Jfp/Ira+9aI
   HFvnT57xQjExmxmk5Y2nyZeYjoiKv5nA34nkeo6Zw5KFfW5D/4XzntPFZ
   Cq5cQ8V9LdrZUzMhfwSy4s7hdOblOJDf39TiNt6/Q+BKwvMYRdJP0668G
   99uve5V6hElDbTte1r8l54dGzBT0RF0D6SEQTgm5/vnKMks7U2nYWdp46
   h45yDstw1kGxHzSV+eg6VnHdo18n6wEJZ98QgQESiysf3T9Ce6lHybNKF
   K6Wp1XvthFL0mPxtg4JHC6jyr9BHGxx+HagQmNml+tjgLnpmU44fpTQ5V
   w==;
X-CSE-ConnectionGUID: jL339XUASyCeQAr8mKqK8Q==
X-CSE-MsgGUID: Qq/kksD8SkqRlITg+T2phQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91993015"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91993015"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:52:22 -0700
X-CSE-ConnectionGUID: /osqR/tpRKKvgDmVmwYPQQ==
X-CSE-MsgGUID: w+QoN9I1TT6jw4XnZEr4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244109359"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:52:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:52:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:52:20 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KciOoLyjvjvM3XF+E6eiy1gTX3rMsYjsnpUuO4/W42VCnt4m7kHqOxOutzK3x1dsQncey6MxWS84QGgRx+m5qJErsReIUV6Zq/SQTQ1tj14uP/ufv/KGb4G7Lb2xz/11xjxH7fLNGaosXAOxbV7Inz4J/v4LvkQJD7SHkCQ0Kwg1MVF5BAzy/UY98lghFJo7SKB0PH0bjIbM9aV1lZs3WRn5/IO/LjngBFf5QSKNkFpS/Lu1vJ4/WbZo9tQipQch5cAMQ5qaJiFfXb6dma62bTJOzfM76uCDww50uagZnb+xbWWi6mIvEOoRFn4B4or8KahAua4KiIs3NlmG66Ycmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJyxx69pjwOEgkhiNKs4OFQY/zg2/sWJKbisxZd5glw=;
 b=jxT7l2R4gKna5Q35uZ+GEd7EyWchEoPZmFDJ6eSp11utK5J40vKUY9+Ck/hnvm+XI5unSOXUWD0c+sNdqAldHobBjgJ13NzM+fQ3Zdd//Bl4x17Z62Udy3eUNZ27B/dDaUHssgP6cYOfHPbRr7D8SfAF3gpg919JnDncdfZi/t85eFnGOxY3fpV9AWd8dQblSDVL7jxdkVsGfxO4HBHuOAc5mMo7U7G5E4n4MldvjKScAGEEj4X+QBUDS6l0wTjAzOfC7pqHsJHUmzdwIEzhZK98v+7+dADandkjG0up8Yfs8BPOnZePD4RF5FSgsfCHj29x8KsIrTlmj2/QLDGPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 14:52:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:52:12 +0000
Date: Wed, 3 Jun 2026 16:51:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kernelxing@tencent.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/4] selftests/xsk: Move UMEM state from
 ifobject to xsk_socket_info
Message-ID: <aiA/j1EWpJgAGIwV@boxer>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
 <20260603060327.298389-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603060327.298389-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: WA1PEPF00005B8A.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::63b) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db9fdec-9d6c-4094-7f3f-08dec17fb226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|56012099006|11063799006|4143699003|3023799007|22082099003|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info: t+IHrKEfpHgbO1ewgrS9hh2jftsBpXjcNvzplxY3Yx1LgoZf/8VwBt7okqwjLoMX2vAjTmrBBCgeZXS80YAOzKGe8Ghk2JVCt05ab86+oCoEuMa/22SwEXcwaJ5jGaiP4Zgt8loVtgF5Qnd+jB2VnKN4yFEdfDx6+4YbJm/rR55cmSqGzF+ohE3Jzo8Nn/agFioctQDFqhC1bgzehplGXakH9sab/wIwAP+Q2kj/L/5WyhhG2VZLYVa6hi/r+DMVo4IWwhhOoXandz9CPK7m8g2S7B7V4pE52tJH2sOEM444yKtlmFVUOyBXYplwHOm+Jib2g57a9kgHm2yiolvvI6tRHnQ/T1YjB5/S0xeSZsg5G2OaWFyRfUxcnephOq2LCcp/Z+jafSORWJRgzOz8cMVe+mC/xz1Z2O0oMRvgpABHUYWuhC/rWdkEFligfc+h5AFI7fIce+d9zVaEw/2mPYTXtLs0ub2VBohr+YUl2MuHaiq+oFWKG8vot/F+YTM3Af7sVn0UwfAXoC7GSSFUN1H3Z4Zw1D6LuLPuE4Gq1943B8y/UJmNVZmGCF+MHF3Mlp/UUHc84GiqIfSuNIPqHhf9KNPkdYuQ+GYZecCMRilpGRZu7GD5r9b7HW0ufSg3RUjMCsr8cpdUiaysV8iv7Xs5GThWQ+OLfGuCqMES10zylRJqlaIlQM7gW6kLhvHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(17002099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HPE62Zhn1V/df6syyfllchQROUyourwN9y5OiaSaFurVA3RUFmCLzEZYZq3?=
 =?us-ascii?Q?jQriEHMWfaOeGMhgaEAfeHaWaCqZHlEthf504bCiSjjQ47NaEVIAdtsRivoH?=
 =?us-ascii?Q?g6n+afAEYRTzgDleDrPHh2pkRPw0A0an4U6IuiDRfFPaayHr16FrcCVerLF3?=
 =?us-ascii?Q?lPJAe1G0iFu5EfdSXOxsip0DwBZwtpiboOcGZWJi0lB7pdotcfUNaK7y0krn?=
 =?us-ascii?Q?mokLti06zIZ13yZYDfMuoZWpFn88esDuuM/Ol768I+v7/xIEj3p5DSu38gzi?=
 =?us-ascii?Q?a6ioMICRdvo7A4w+6F8kDYd71Z4ei+ZVo225S3yyo0wgAZ6dhZKkDAI+WQEr?=
 =?us-ascii?Q?AVIHpsF9d1cgMlF9huAQv6nDUuJMuHjT5lD7rVGJMVJsBaE9vfWeZriUTuXO?=
 =?us-ascii?Q?1ZMh/h+kYHeDk+z+Z7vsrkUGXvrNNTFUbbrVvs/axU50/YQJS0kyQbHV0pUM?=
 =?us-ascii?Q?K2vq2VPkToMyR2kadTch/52I9Km31rRBri6VP2SATHiNLq0wMmiYOfCH0RmH?=
 =?us-ascii?Q?jJyoV7XuUgZCmBpRRFwoc9eJghGPQY8+lcTUawSKgB3RwSFcKhnFUCGSBqSw?=
 =?us-ascii?Q?csmhW4zczSBXz5UmZn033OqCPR8MeSDrfSgKxDnCwbQLsmd5YzBmHGLFg/qn?=
 =?us-ascii?Q?v4unj0i/WLtNpwkncZV0GklI16sxjmM1HhfzkfMbt/1ieCxNMsh+/5TEcYZo?=
 =?us-ascii?Q?0NVb2ydbV8f7VfBkbgYrZ8ioJUt3KubKEeER9remm31dtmQ91PGkIIw+6tyn?=
 =?us-ascii?Q?JMH5fxpQj54t2qY3Tb1RwtSNSlYgmPnPAiUF+GeYurRMStCkDHrI5F/Rbc1x?=
 =?us-ascii?Q?BaSl3hA2jG+Kco3x+zNy9qkIhp/YPrA47RnczLpSAblSu2HWUuhwzY8Q2jqC?=
 =?us-ascii?Q?c62CzqsVSG/PiOQC/1XXYvqgURo/FggXVuJqHeybGkykaVddTzd2Q4pjAwrv?=
 =?us-ascii?Q?fxPh61cWw4CNeXk4/ZgT0LSCkMCEgvqoiGkIJC+RRznIfWfQ63GwmcsWoXcQ?=
 =?us-ascii?Q?vFJ2V+MkexxjgEbbE+0r3Dgsw20hp5/qJ20dOQWbNP+nsM+Ocjni0YS62+BB?=
 =?us-ascii?Q?i9ezJSTwyFozPOnqPfVSRjrw0+MrYLSt2Nxbt7UAne2cVU2ViTVNSqN4iz7A?=
 =?us-ascii?Q?vOmIqxyk14Ub9WNZCvhZpmSmZqAV9C3ok/PQSEIfcH7Ydxtd9htnIcPRiMJk?=
 =?us-ascii?Q?HfeZvb1xiRvky/D2xT1zEZBcSlUcaslgdXeNS0VRGpGmMqQWkAGNt8OpDm2A?=
 =?us-ascii?Q?hOnkMnlJbhojKcTp6MHce4xq03eYx5Ac+T7q8vLCa1Ngfg6LtyK4P7p/3vHv?=
 =?us-ascii?Q?HeIen2E5LxcTfeIDUv8xY2eZYrkvkRFG4smR5KPjoNygH512+7qOkGTm7kkY?=
 =?us-ascii?Q?jxXJ/AuDUPyTNWfs3C2oM8fZ4ivAKl8Uc0vrWJ8RcDO+8+C8VracAFlLFK5h?=
 =?us-ascii?Q?ZpF/umRn/xJEe7Qgrva4gHcLhAapNWbIrzV1DpDBpIpKv6PaeOlwgXKtofAw?=
 =?us-ascii?Q?0njSSk6FXxmkVp1vgYg5EogLHPBga3FR924WPwt/rYIiYCtNeu2H/O0SXFHq?=
 =?us-ascii?Q?sdtF/muLiAYZofCn8Xl89hfy8cDXIPgCl2NfJoMNF3qvrBgg1A5jqrP6VVKp?=
 =?us-ascii?Q?Iywyb9QcTggNFm7Fn9g1JrujPxT3ywawwrIwbfNI15iSd7q+g9wHgwAqSgqP?=
 =?us-ascii?Q?NYF0PZXJ8Rw/iVIqoI4MJK3IxqJy43myjvEcosSviEeUZlb60YDKkBw8/hiE?=
 =?us-ascii?Q?WsNB7oHLyvn0/QGPhmAG0b8xR0ZAfBY=3D?=
X-Exchange-RoutingPolicyChecked: FAkGtVPBGnsFHIW2VgK/zK+OXrYrDkcmaBAZQJ1Vxne9VWECHgeulZQRBhyacGzX5/WcBsjcCluLUzKRePhXSRzq5ZDG/Qes4FBGm9G+Lz+WF6KaNWTlCvyYW9V3BLxfvW75lRqt1hBI8osTGyztJF0hkgS6T448qnaoTckwkqsvidaoi/VO+WHYYbEw5QWrXlrgqf1Bj7sibuiLP2Wo/tdcONrLpDgUBODJX6XA2mWo6lW78oJbmWs9By9BJNJMgzBAglkbhDah26Le2KsaQF9P+okgW4qqtbAixjETd8f/9fbf2utKWRyId/IrBZ+OMPY7agvFcA5V22pdowk8Fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9fdec-9d6c-4094-7f3f-08dec17fb226
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:52:12.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Qk4o7IfcfydmyefwObmtUM8sX42WrU2NbSwhvFOSZ1McN1tuWH8RNQWC/5h1uPZ1ENnHtJL/u01MgNAdXIzIURTT8CXUe1q5TR5eEdBTJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294794-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime,intel.com:email];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E83C639256

On Wed, Jun 03, 2026 at 11:33:25AM +0530, Tushar Vyavahare wrote:
> Move UMEM ownership from ifobject to xsk_socket_info and access it
> through xsk->umem.
> 
> Allocate one shared umem_real in ifobject_create() and let all
> sockets reference it through xsk->umem, while keeping ownership in
> xsk_arr[0]. Keep the existing goto-based error path in
> ifobject_create() and free the allocation once in ifobject_delete().
> 
> Reset the existing umem_real in __test_spec_init() with memset()
> instead of reallocating it.
> 
> Preserve shared-UMEM behavior by copying RX UMEM state into a TX-local
> UMEM state in thread_common_ops_tx() and reset base_addr/next_buffer
> before TX socket configuration.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  .../selftests/bpf/prog_tests/test_xsk.c       | 133 +++++++++++-------
>  .../selftests/bpf/prog_tests/test_xsk.h       |   2 +-
>  2 files changed, 80 insertions(+), 55 deletions(-)

...

> -static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_info *umem, u64 addr, u32 len,
> -			 u32 pkt_nb, u32 bytes_written)
> +static void pkt_generate(struct xsk_socket_info *xsk, u64 addr, u32 len, u32 pkt_nb,
> +			 u32 bytes_written)
>  {
> -	void *data = xsk_umem__get_data(umem->buffer, addr);
> +	void *data = xsk_umem__get_data(xsk->umem->buffer, addr);
>  
>  	if (len < MIN_PKT_SIZE)
>  		return;
> @@ -1003,7 +1010,7 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
>  			return TEST_FAILURE;
>  
>  		if (!ret) {
> -			if (!is_umem_valid(test->ifobj_tx))
> +			if (!is_umem_valid(test->ifobj_tx->xsk))
>  				return TEST_PASS;
>  
>  			ksft_print_msg("ERROR: [%s] Poll timed out\n", __func__);
> @@ -1163,7 +1170,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  {
>  	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
>  	struct pkt_stream *pkt_stream = xsk->pkt_stream;
> -	struct xsk_umem_info *umem = ifobject->umem;
> +	struct xsk_umem_info *umem = xsk->umem;
>  	bool use_poll = ifobject->use_poll;
>  	struct pollfd fds = { };
>  	int ret;
> @@ -1222,7 +1229,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  		while (nb_frags_left--) {
>  			struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i);
>  
> -			tx_desc->addr = pkt_get_addr(pkt, ifobject->umem);
> +			tx_desc->addr = pkt_get_addr(pkt, umem);
>  			if (pkt_stream->verbatim) {
>  				tx_desc->len = pkt->len;
>  				tx_desc->options = pkt->options;
> @@ -1234,7 +1241,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
>  				tx_desc->options = 0;
>  			}
>  			if (pkt->valid)
> -				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
> +				pkt_generate(xsk, tx_desc->addr, tx_desc->len, pkt->pkt_nb,

Nit: you have the umem pointer handy, what's the point to change
pkt_generate() interface?

>  					     bytes_written);
>  			bytes_written += tx_desc->len;
>  

...

> @@ -1856,9 +1875,11 @@ static int testapp_validate_traffic(struct test_spec *test)
>  {
>  	struct ifobject *ifobj_rx = test->ifobj_rx;
>  	struct ifobject *ifobj_tx = test->ifobj_tx;
> +	struct xsk_umem_info *umem_rx = ifobj_rx->xsk->umem;
> +	struct xsk_umem_info *umem_tx = ifobj_tx->xsk->umem;
>  
> -	if ((ifobj_rx->umem->unaligned_mode && !ifobj_rx->unaligned_supp) ||
> -	    (ifobj_tx->umem->unaligned_mode && !ifobj_tx->unaligned_supp)) {
> +	if ((umem_rx->unaligned_mode && !ifobj_rx->unaligned_supp) ||
> +	    (umem_tx->unaligned_mode && !ifobj_tx->unaligned_supp)) {
>  		ksft_print_msg("No huge pages present.\n");
>  		return TEST_SKIP;
>  	}

this hunk does not add any value IMHO.

