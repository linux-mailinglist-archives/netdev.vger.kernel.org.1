Return-Path: <netdev+bounces-191702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D037CABCD47
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25573AB268
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E241519A6;
	Tue, 20 May 2025 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1wozaDP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568702185AA;
	Tue, 20 May 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708608; cv=fail; b=sp73jvKpKLxmahUQ+X45fyA2RM9S3f6JQzRdpG7RdHSsa4itE+Vkxz+KfGCLz49zJBnS4RlWR2M8AGTs6N3CMiJuN06n8XIQc5YPsDvvx1jqJedHNICxghvhcJkQWWkLg+eX52rpN+a3PwpZxxkLxkVN0nGXC9EKUKotxnFq38I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708608; c=relaxed/simple;
	bh=roOhZihNm6daxEcMP9gzlPZSnvt2K0CUvfgBhixiLWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gCajH4uasPJ2Ai+F+GGjGoPV5TPYT7a9c3qv2eYjCIE6gayP4eA7YCiJ4+Tm28HgGbku84BhPB9VuyAnbBl9XvYNX3HFoZpPwFw4aPuGcvpYPB9Up/YXvU0aZUd6714ZXObdoMxjf+M92ksijkKJM04/Fl+Zz1iGJsGFWK+cr3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1wozaDP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708606; x=1779244606;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=roOhZihNm6daxEcMP9gzlPZSnvt2K0CUvfgBhixiLWY=;
  b=Q1wozaDPBxEenIqGVuonGrhQR5DGYWbD033Dix/s5Sgvxrqyr42GUKMZ
   hnxsuDFY0sw+OFo6bnSjTo0kx0YIXCxujHLbP5c1rAPhJDhM5SnBFLJXk
   RKA8eaOITkkqBS1H86J8bs5fPtmVONxSJM82Txy3dzwEiSq4M1jojbkhL
   6xlSc13/CmaCn7ITAEakJoE6rie4Vl4LoXNlYdJXREi6ZUEvxlY91OJcR
   ZWcdvXpfFLcxY/lphsXN0euMpkfsHm8Efe0JVFTUp1hg7SzqQoCTwQRXy
   1MFlehKSG8XsRuNH1pVZmgGxWGeAxv3KAu57D+4qqoJ1zuAHMyqv0QCqp
   g==;
X-CSE-ConnectionGUID: b45yX3HEQnqD7nuw2dxyRg==
X-CSE-MsgGUID: us2a+nhyQoCARSY6lZKVFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49690646"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49690646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:36:42 -0700
X-CSE-ConnectionGUID: o2bEGTFFSwqb1zMpSJlW1g==
X-CSE-MsgGUID: 48SXyxt9SB24C+kJGNIiig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139591798"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:36:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:36:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:36:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPd7EPVdM/6AZHXn+gRBYg/o2HoWuCUlN5bxtBEyQ9yEfJx1qXEqd//vudeJqJBpw35fC3JdjZcOjkt+n0Ft6i43x070Y/CLCOcBPrxFbPFjcMkngw+u4D7diZarJpvLEfd8gZhlyvmvfQSzR6wgy3yOXZv3K0M/xeJMdOJivTTI3Vdc8/kkQLj8f43SQXezxVVGwk6W7AXUp/KchXP3J5Ib6/X1XnO863yJELzBfU7CUsp6bmqH1XYcHe4GUnYH2jElePgCLGUN901PA75Dw/58pc8IFkFmdbR+1wlSNZ3MV0/+SjbPcL/qfAUrCnRQsZ/4PsRJfnu/l7PUDclyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTLtmjYwz7+oce9Cf3q7PCcFweAdXEkOU76tO8NkwTQ=;
 b=yrK8Z/vK2wOJTEBJny2HMMa4+4wYcgDXbBm11vlXJY+q/VgvrvHvtVwLYI7zbkDT+aeofIYLZgQdDxJZ0RJ0B+Xx8dYE9BP5Rz9MA5ou8Hjt1ipVhW5XkNzYC/tUF/ggyBk2Ldr2PrDUqdYOUd+TIDfvVzhd/3Zz+nVV67O2v3S2VmGvH83En9NvR32hFJZUATrowR283IUvVo/+Yob33T3Rr04N3Rjbc0EtNPo43irnlIcBqpAVJohrLsgFteg+WElEmQpLhHtXyYhlIZQF0ixAANC+e9sPaTnn703q/EvxWtRmfVfUH26dQAsET64ST8MdMAI9Co6pWpXPx4zFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:36:37 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:36:37 +0000
Date: Mon, 19 May 2025 19:36:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 19/22] cxl: Add region flag for precluding a device
 memory to be used for dax
Message-ID: <aCvqsW-mV9wRX4WT@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3e1798-7b95-4e92-38c6-08dd9747249f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zrbe7hx+v16OCJBNoDiFvuqMuaWSa1bsz1oO+kPtQzP9H3ShEoocs6NRkjl7?=
 =?us-ascii?Q?ETPJj6x13J1wxsoaf0W6tUf8sPc8mFNtA4yUxY29Lsa+Yt++dq5lzR+MQgYz?=
 =?us-ascii?Q?3dxu6VfDHrxEPgvyfJn5cbXd6Z6E8yQotj9AFYAu0WSCkVy40ntrHOOOJ1/0?=
 =?us-ascii?Q?B8WYhLLMWIJePrxblzdJ3oL86UruV1oLMADhkiYBocwCm1xgtXaOVsdwhntH?=
 =?us-ascii?Q?X/Aeli/BXh/z1dQ1YwJQk9FWP81I6IX4Rn2Xz49VXlxXNDrpBrm35TIoXkVF?=
 =?us-ascii?Q?W+r/mKc39fNLiko7nsKLolI3U7Aj7unVkHiYZG3zxeqnl+ZNbQEA3CibxReE?=
 =?us-ascii?Q?HGjIDnCE26oP/2nYqgESY4/KqS382Il9Mmkje+lPqng/PHuEeZm8hX2LSTVQ?=
 =?us-ascii?Q?09mx/eX1NE3Y772jsY3uIwwo8maiCEMHSEf/jC3+iFohNYzDQxGb/hxssDVW?=
 =?us-ascii?Q?ji0nG0s9ADqFRbr6wBz9VmvLmUN3vMohO34bo2T+Ay7Jy5GKZ2+Fcv0TkbJb?=
 =?us-ascii?Q?+tCORIIrp1JEnmwGr2ypPFHZKKQdrdQrZazVE/AHmjl8bD87KVDcTFSv9k6J?=
 =?us-ascii?Q?pMK+ftr02VuSm5aLn6BGLb4cac6+lfP2IWB2GuzDFyJit1Dk9M2IV933rVx6?=
 =?us-ascii?Q?p3RB3sChQ6UNIaeQFGtiCFDbZNgK60ct2urxNmY86xRyr+s4KVzWpj/fivxk?=
 =?us-ascii?Q?D58n2PzKWuaD90vyNvzf/lvrUBFF5xNOOQfQMgEBvdaXFRx1NB9oRn3WoErR?=
 =?us-ascii?Q?SLPfkSKFsFcFnKqGWph9jsRIXw2usVXVvamKBEyds9ov4wBrj3fBSUFCXEbd?=
 =?us-ascii?Q?3n6bMqdcSEkCktamfELzYOI9ZiKKmwg8iIRMkyyjetVz3Q/cWle3dhLIqI91?=
 =?us-ascii?Q?ShVvi9rd5pPq8oFIMmbBUNY2V4xk8Bq0hUbGpkxrhkNyBzw29oLU5CmdSgka?=
 =?us-ascii?Q?ubuNiZN7ZsT8irNruKOMVLtYMqAnfDIDMrRfBWM6vynHi8rs4w27L9XacmtX?=
 =?us-ascii?Q?QxcZ4Mn/jhe5Womqdwem3I9x0DhKZ3+wXlUW0F6TmZ2Jnu7XXI8aFoiVNFUp?=
 =?us-ascii?Q?gFLnReA3F4RGiUuLHDGCmFUVCdvbhvyk8CGMSItDoKcxqloBKL8tenqPVOYP?=
 =?us-ascii?Q?ROs1053WCGs6IDjxWY0U6c5gKlplJIzo7aLJLFYoVXwSKGmc8qFNsRve+bRf?=
 =?us-ascii?Q?r+Luf3Nf1ocwQmJqdslvGkuI/7r0/66RhfiicSAaA4GWsRXeeqvjBjixZZkz?=
 =?us-ascii?Q?mEVSaFrkrHpJK1CFvR+RB5kq0U9cISI/Vl8z6+CoevVbQcLWbSHfg/9U8i6d?=
 =?us-ascii?Q?7maIhTxKwqLBpEVo3L4Mfyu/gaEQAyFDJvD0obe16x+1s7kxeTTihrdYWC9v?=
 =?us-ascii?Q?TSlFJQitlJiJNww7sHyhR5/87Qv0yakcWWH3Qd5NdeHtUnsgnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vdk6izv7xaC5lQBHuW4Ewdev1W9OUYqBLp4Hrx4hajvYWyBD9MYKcG+Ymzi?=
 =?us-ascii?Q?ewlrG5buvqNrMYKW6VkGFLLu5h+fmCu/MRqqRbLRlKX5ptc/piC4CSTM7zwA?=
 =?us-ascii?Q?gtG95Tnlc+EnbLRm++tT1O0GiPYcneNPNTjQMZOdsXfQbGXak4GJI+OnN4eT?=
 =?us-ascii?Q?2B/K4qn1Q4IlaRoFL3Pk9IbCrhlIiGEf/KmnA7lokBj9pEU7+qq9yjzHXk4O?=
 =?us-ascii?Q?HRs/S1YHXs8mh1pvRQAoeO+jr9q/vYY/xeNfhjdW4hNLhnUXvHTDfzxgp3lg?=
 =?us-ascii?Q?2HLvSiMm/S1qzRKIFY95lctyW9E2dMrgzwVpCXjy1qC6OIfhR2B9WvgdL34W?=
 =?us-ascii?Q?v4IIw2YNmsbYSbWZqb1p2LN2QLqA+dAHp6wjCwmZKMhdtE2ktPogZbLc7kGW?=
 =?us-ascii?Q?WKybwBgSe5uMOtrbXUD0eUFaiVm9W+V2YZe8YukxM6VhhvCLvbnJq+29Zscj?=
 =?us-ascii?Q?CcBNMF3ea1F3m0Y7LZrI2JcYqlGWEQZpci9Z3xheMkpuuTMNwtSsmqhTFJ5h?=
 =?us-ascii?Q?nQeVdCEeV3R4ctqhY6EEFCehuN99DruDQ8uA4eclKbuSj5mRWXbFaJlNi+up?=
 =?us-ascii?Q?OIrTumNzRXs8wLcXCGMplxke/VaPMe/v4HwOGIsdVPPIE9gQYqv8JOXBKEQx?=
 =?us-ascii?Q?lsw3Zb8kl9c1ePME6MIy6yX3dzXqdgTONyklcbyXlVhVmpAImZ9M3u0+auq5?=
 =?us-ascii?Q?deemCHsFZs7kEHBm67wJVZSpA4NjYBTnqJU1uOV66UmIVQY6Ich+WySakLXW?=
 =?us-ascii?Q?5WYCsMLJwhbRFzuFl1/aqo5PDh17KVBf7ap3+/4tvsN630pi2LT+d6TymxMa?=
 =?us-ascii?Q?cBuJ4GAufIaoRjxAg5GvahXDb1HnUnA2eRGc1bad4hni21h24/uXjdiDQwo/?=
 =?us-ascii?Q?sYrSZNXt8fjZ5I7yWd/5bGXUUd5mgP4BHnwi1AMN9hEqOkevNdGvjf9p1smT?=
 =?us-ascii?Q?8mrUKUo37HkygbllsFg9nfmlqZPXzNuAdALBNzJJCN/PPTYJX0mO3g2ZGIVA?=
 =?us-ascii?Q?i7vyqQBlyMeeVihm+tNzW9YQIBpcPYRD28prU4uLx5+7Qz+BvICyM15VBH0k?=
 =?us-ascii?Q?oGYlT1qSEGqmhKfMcYTS4sUzXwoTypi8GPNjZLoeddZkgcDU544CahEGVdLb?=
 =?us-ascii?Q?DwlnNmY9ge9XdRpgD7gxBbv/JypZCdVgtNszNeEo7iXYDLpe5O9e5HdpwTDI?=
 =?us-ascii?Q?rSTl65UrdkUD3CMDdT3EEpoz3wj0hxNj8hT7I3jaMhOBuruHWrgyU+jt9Rhp?=
 =?us-ascii?Q?BMY459Lr9qt6Ty072WYQ+yX6bOf1AQFg9SuF4SalgTSkPax1sWcWxsmS8oaQ?=
 =?us-ascii?Q?bPw4QIsTF5lcv9XgyXanYGqgkDWLnc2NXRsmhWDb6yfEbJUsMIqPt0xM85aB?=
 =?us-ascii?Q?ID8amqJtCx4Ygwbl4XBOlePKIhIoF/HMJa45KxmV1G+u5SeN6Jncn/3OEQLI?=
 =?us-ascii?Q?aYSS3wGEjzSwyl5HPskOOUjhMgm73GNQR2P96UtaLPMjlxSrWfYXdpxyabfn?=
 =?us-ascii?Q?FUsoaSBoebF3A/OQ59ktUgi+LhHPM49ZwYroERFrU4stIdaEnl2Prh43yN9p?=
 =?us-ascii?Q?Rb1luZJiE0i3M2vNNmp5dXVWHknqS4Wtb2iI4ByjYq7Gr3yVM8bMK4MHu1gt?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e1798-7b95-4e92-38c6-08dd9747249f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:36:37.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fy/0QXURmoFyai4UKyPBu+qhqnPyLhzaV345tz8a8z7Kg/XN4ZtTwRLgGVgXFCjX7tcuccD3Frkv8mBJyz1q4VY+CymqD+G+PdhPEctK0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:40PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

