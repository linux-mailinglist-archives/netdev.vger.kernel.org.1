Return-Path: <netdev+bounces-192837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FFAC1574
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231527A6B0F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1A22425B;
	Thu, 22 May 2025 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agGmsBH8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BF1C84D0;
	Thu, 22 May 2025 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747945375; cv=fail; b=c9ZA/3hleQvqdObyGu6/HaWLlYTQHBVDl/xnt3q6AiRmzz/S8dhDB9k0SuCIsegX8tjoXD/4roTvL0tjXrheJrapIvOaCyb4b00BBuQFdVDIzBdVsrGexG3E/MFcjhlmB98zu4bVp3EhBYSgARWVQ+L3QcJQp5qM5mKA/HDIZFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747945375; c=relaxed/simple;
	bh=9bnq90u0N4uJ7JSE0UUxhXX/AlTljLvDdfTV1bQANW4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HPPU+Yl176hWp0W6dhPGA6jFWhqG8NLKKoxBZu+wHOQI746JaEba5YJuIxUTKQWntXh7qqiNUwkKuAevwjFNpYVmLTMXXQUgah9mrP0JM1jTH0BDZNHQPIei5DhESSR/91bX8uI2A6a/q7ysoBAkEkRcBTAHDGcvBs3OskYzzhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agGmsBH8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747945374; x=1779481374;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9bnq90u0N4uJ7JSE0UUxhXX/AlTljLvDdfTV1bQANW4=;
  b=agGmsBH8pfd5UODUO1k+YSjCqb0S7XUFLoi/0wydzREr27300rMI1WIV
   aXJ20urzDXOywJcTUw7KEjasfauZFGghOQHEn5Si1YjT/xFmJ5rp/AUcO
   UnbmS6iuD9zAo7pcv0dHsm2pXCUZH2uB1QyaFW4Mo2MXoWf95zOGFbSJt
   mQsIG8spP/P8+kmk1zIzrq82kPtiIBbTXBFzbpHZKS0SdqKBid7/mE9wO
   a1LfLcucJhFYDsJy1L5pdfzRsqnDoUPQoCsUfO+m7nI6wfSqDFuY9WFO1
   afon7xagIQb6uqbNXR1T5G4R1JKaOnpLmFs79vVN16yyOI3S43cl1zfmF
   g==;
X-CSE-ConnectionGUID: ZY0410M7RgKp5Sbe5SS9HQ==
X-CSE-MsgGUID: Zw1w6KKyT8CGa/dbNtLk8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49696775"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49696775"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:22:52 -0700
X-CSE-ConnectionGUID: raZzC1zUQXy2kK8rHAbFxw==
X-CSE-MsgGUID: gKWp3DPgSYG8s7418ieSkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="140588871"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:22:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 13:22:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 13:22:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.72)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 13:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjRd3yzM0TW8G0lUxCHLKPxNmYVis7ovvuKLv8sdszcpyq0J8L26Sy50PgXOpuJC6421y6x1Mi1VoQg/pfmEfyiwSX5udFbFBchIy4ePyMlBZB5FQO3KIUxoP1e8qbLZkPqlhdx/t6UiVz1EuFZbea6FlE6GZV6V3NB7Jq5j69nRqeppDD5vpz0W3FqbyVGi7O2ZX3OBgljP//U11kqAMzr3a+Rng2JMycHvvnyYeeNquC9JlWknZ2Dywz43QuHLAnJFTANpfKa3lYyYbaVw7yH6Y49fsD3yMnTxXZUlrEoCqPVk5kDYCrinpvS9/ki42l/7+JDteR3YosbCB54psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E58rWUNiUAxeoBMLi1jiiYSVT6EDF8iUNMZMYIKRUlQ=;
 b=pOvrj8+JwfAPw25gDAgLD4ZT2SUa59b05Jyo5DCIJ95yr1jTq5KA/msgn7DVpkDzOPIWsip8m4qOceM/sjxB6IzfZfzbO28NMdaNuuhl29UiRRS6+3Ps1ydj0yt+Czi2PM5guftynSpbsk4oMcATT+i5UZ2gT0qJK+wyEBXx6aqXfrS5cSiPG4DK9gPUK0W7PStP02L95BlNZbbI7lzC+q0DHxDkUZ1+p0RyA7S2HMd385/2seri81YnwcQjJzKR1KnQmTxOtGBVSMiDvQG3oZ2yGO0ezo/hTiKUfnd1C8q9AntRXEOPG+pWm8IolZ5I9tIynbeb5ITaaMwWxAgLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 20:22:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 20:22:49 +0000
Date: Thu, 22 May 2025 13:22:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 06/22] sfc: make regs setup with checking and set
 media ready
Message-ID: <682f8797ac1b_3e7010017@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
 <682e1ccec6ebf_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
 <5b20031c-ed46-4470-b65c-016410adf5c0@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b20031c-ed46-4470-b65c-016410adf5c0@amd.com>
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b6eb0c-93c7-48a1-a958-08dd996e6c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nePCYx2UMIRR6kLgSiKOitSdEYUp7tSqiG7QBjCiR3wm7SauwvevZjwYvkj7?=
 =?us-ascii?Q?5kMTjsBhAaFpX1mvRj0nUsw7TKjCy2XxCNCfpZ+H+h+E/WKBpjw6C8ZBXcqy?=
 =?us-ascii?Q?/zJ/OpJyZJU8T280QMOUcYBfb2uIurRkvBXZRQIkL8ERrEMiMh7Ywaw9mKpk?=
 =?us-ascii?Q?tuL7AL4tUVGsmkCz2PrauxzpYKOKeWMw1ZQLAjCAjVHlMSEH/t0JlWiZsp7H?=
 =?us-ascii?Q?E6bHnbeiqHZCoz0TKQQsmhZgikuGbeiohKmsixDWuTtfjc0WYGcqc/wnxuN4?=
 =?us-ascii?Q?QzSNnq0dZ4d3GD/lq0GHXlY1/rBd+F+nhN+PEJTA3bN8Wm7AK0KYbit1cZu3?=
 =?us-ascii?Q?8Y0adGqxrFgSArPpzpmE/IdVi0d2Zt2w49+C0dOnbnfh15PRIe5N8lPkkEW3?=
 =?us-ascii?Q?1PKIA2s2SANgbvIfN5gD2BDM0UC+R0CfHbqkXZK9cVXaSYO2dThwZVcPP4oP?=
 =?us-ascii?Q?t/SFaHrVOZAxZMC8x3AsZW30hxtsAguL6jz+lt3uPmKNKXcOL5PFYnf06qCG?=
 =?us-ascii?Q?6ePLyWEMu8KSKA8FqGRVmNqtXSKDBATIR/JKWhJ+BkLwkgVogGMKfyo+Lx1v?=
 =?us-ascii?Q?a2xqVYN3oqduE8VnpVU8Q484PEl21LjchMSH6/n2EqnY50K8p4P9ScnL4tmI?=
 =?us-ascii?Q?EMhSriW406/qb3huDrWlxgAofdd5gz/+3cBqx/AK2YtedUwcV6hKJErhGA2t?=
 =?us-ascii?Q?w4c8xoJNilR8ALyvRRteSlxTgkGrzlHOWp+qy97qeUyjG7xNJdakXTdp73S5?=
 =?us-ascii?Q?O3bO7fLR1FsTKFziIvStZWljnNYKaI1VkHpQvKMYIieOpWbSar1SHEdrn+Ey?=
 =?us-ascii?Q?GdnBoNNPFqahJaivCjMVV23YtWudC6M133YDloatMSXlk9C341hTntqrbQrZ?=
 =?us-ascii?Q?CFv3MN6Pi2evmGaDbz0k9ZvkPCUTYpEEa9oGCu1aKb/dqFcb4pOEw82X54zj?=
 =?us-ascii?Q?wWdyzEPz4AeuiD7JFs7tLjbFy+ph8LJgP3aaI4VzMeym3BRkBMG2ROsy9S9J?=
 =?us-ascii?Q?JnIAJ/jOBAmyX8w2tHeQK3gBFfLX/GVE5Hisc6fj3AumfbGbELHxZtjdLTIM?=
 =?us-ascii?Q?znDQPl5j3NT+LWFVJiFgu6QPsBVYmZJRcI6DSdFzBDp9qzKBA8I8PujZCmoT?=
 =?us-ascii?Q?jYdISCdZBU9bJaUpuHAKMfma5qJgFBoKrxMgGMJB2AJjINKB4WlyLph2VJfx?=
 =?us-ascii?Q?yUwtYUwW98NNXraSBhtiFFSJB44NyLwPay+lNIXQOqg0pwNgiINmHWj9Pa9D?=
 =?us-ascii?Q?yU6oowCbhESxtpqHqWZIVSYj/gaSI++hPiyRf7iI23epkYTTbjKNfLvy+ozh?=
 =?us-ascii?Q?1ZhvpzW4urN9QVXAZB9r3Y+gGaftGhqo0cUoIB+TZODHUwvjSTckdLuzimFq?=
 =?us-ascii?Q?VEwBzwy2CCB2DKk/SgXrfZWWyxcFOWlhvyCFpPnYOBQ9ZUuldKCt9Fl3G/YG?=
 =?us-ascii?Q?hQ9o2pZAn9h7WNYZsdzDY/qoLlQZeo356h+FwTfGz5y3jaDohYPmYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aj7tsaQ/K9SEfbo4vE6G94WdinZoZc21yA3s2NsKTXkgSy+Wx20+ZDPgj3KA?=
 =?us-ascii?Q?lZv5eZTFbVQKveOqKkMQq/9F2lVaippoShtDguK6OseYnLyNl34w46Xzi8Tp?=
 =?us-ascii?Q?d+peYIJyamTPglYOpvPHVWH3tcX91154v+zu+qjn8YUA/A6uRwsFicF5J6Ae?=
 =?us-ascii?Q?667L9+/HOm/M37kJAWuF1xZSifcSXfsli+dDF7It3UXHK63PMtK+7lkSaEHi?=
 =?us-ascii?Q?46N4qFrS/ebp+AehuNhMgKYTyxN72kXRAG0QNkIeIRFeuSIHXn894oyQ/cBL?=
 =?us-ascii?Q?37YK8atCkTCdKFYeia8JJSl814+qMOy03kRgFBTlDl34zKgSa55pvVjDsXY5?=
 =?us-ascii?Q?tT/n1MBAo1wL8JS1BA9Es+nynx5G7F/zHc6wgO42Se4tCSPOCx2MGkljF/LO?=
 =?us-ascii?Q?mAXPFBqfV2chR/z5IQtBYfbCEWaYR4bzHwArlVvhGfoXs1FUal+EMP22JSRw?=
 =?us-ascii?Q?GWcTNj339VH3IZm3CjVwn/gZrfeQNRNjrwqx95nlV5N7oOQG0xowHSSurEpT?=
 =?us-ascii?Q?Jq769PoDI9tXx83RVdqU735POZYK31zide7QtYfv1sXp22Vh3WCgYIFn+c8b?=
 =?us-ascii?Q?/PKlW8L6qVvUZwiO9FPv0hkxGQhFp7IFRGtD+EsuDUc0pY/9pjnykCt+e5Oo?=
 =?us-ascii?Q?BE+ptMJZU5vtmw98beZgjUDcRzaY+AP5XdQ/s4lr7m1sYh7QdDSBGxFsgok9?=
 =?us-ascii?Q?+kHV+6sqWLDajQLRAzseujO+f3amvz533sSpYUefrp46s5zSmUp+7bvePfFw?=
 =?us-ascii?Q?3LTCsozeegVEC45oq+kdO4tXl8UN/gOwXhDO6+WcEbO8zBMIs79yZWSEd9+7?=
 =?us-ascii?Q?8+UXMEpO4xyWRKWEbzvq3//5Pprdk79bHC11to9rvDy0kjlCvsctb9lQpc3C?=
 =?us-ascii?Q?uuGT4bbxKSLKi6O2Adqd24KolQH6g7bJFhqKqXJOMnATFplMJoDjHgOqD3Tw?=
 =?us-ascii?Q?gA+JCngTfxoznlFYp9OIj0uYakYtNkYNmrUKaja3l/JnpvJcVIRKGBkFv+tN?=
 =?us-ascii?Q?1yp0XoUdlGW2RTLmthywF0xy1fqIlz2FNmXochjbCI3/0JHssK6DRGLPixnJ?=
 =?us-ascii?Q?NFyaLg0ClWAuDSwmNjUZ0PHXkzO2+vLqvtGmUGcwisTsXMOVjg95yc14C8IN?=
 =?us-ascii?Q?TKq0KaMeUrDjGWcVmxNSwsA1AXj9f4QC5f/a3LjGQI5ROppM7Te7dI23NktZ?=
 =?us-ascii?Q?qJgcq4IIcMLeWwNO5Ov8hrrtdG8dbzl2JhZevttnSEBlhrqn3Bf7TOt7C8ny?=
 =?us-ascii?Q?SaYD5JVAoBcXgsWeqjJ0HpENT5yOaYd5dGKjhTiadgQy7t3W2jT9/flkxvn9?=
 =?us-ascii?Q?3TAE92lV0lYp6US3T8tpVLoOHUehHrdTreVynetQT7PCJXkPWw49FEkSSAf0?=
 =?us-ascii?Q?m2+GbdmgAHKUuuN/Dfld2QYN29k8XrRDexhmIvapvCUidO7xYK5Gugeulajc?=
 =?us-ascii?Q?tDYGel8GESj/svn8xLX1X4n3+IEx6wE4321yoxefVsJTJeqszaNW2rCntS5o?=
 =?us-ascii?Q?8MVz0obs9JFlbwpmlLsgw+Gxl/2QTrsiNvEM3oNWgxSDVuPQUuhEtScqVtFQ?=
 =?us-ascii?Q?HBiUJ5CQxmKewYcLHNlCB4Qak0ySAZ4gpSW3okG0hsWbvYr8OgpACLOO3yiS?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6eb0c-93c7-48a1-a958-08dd996e6c0e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 20:22:49.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzXcU9FsfJJTniYtc1fW/OrQb3eIIik8KlXc4+kP0LIUDKt42mQY+tZFIwyM9TN7PSqlwGlLbJBrkxkcha/p+QQ1FxJHqjBuiEIez47x5t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 5/21/25 19:34, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Use cxl code for registers discovery and mapping.
> >>
> >> Validate capabilities found based on those registers against expected
> >> capabilities.
> >>
> >> Set media ready explicitly as there is no means for doing so without
> >> a mailbox and without the related cxl register, not mandatory for type2.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> >> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> >> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> >> ---
> >>   drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> index 753d5b7d49b6..e94af8bf3a79 100644
> >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -19,10 +19,13 @@
> >>   
> >>   int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   {
> >> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> >> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
> >>   	struct efx_nic *efx = &probe_data->efx;
> >>   	struct pci_dev *pci_dev = efx->pci_dev;
> >>   	struct efx_cxl *cxl;
> >>   	u16 dvsec;
> >> +	int rc;
> >>   
> >>   	probe_data->cxl_pio_initialised = false;
> >>   
> >> @@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   	if (!cxl)
> >>   		return -ENOMEM;
> >>   
> >> +	set_bit(CXL_DEV_CAP_HDM, expected);
> >> +	set_bit(CXL_DEV_CAP_RAS, expected);
> >> +
> >> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
> >> +	if (rc) {
> >> +		pci_err(pci_dev, "CXL accel setup regs failed");
> >> +		return rc;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Checking mandatory caps are there as, at least, a subset of those
> >> +	 * found.
> >> +	 */
> >> +	if (cxl_check_caps(pci_dev, expected, found))
> >> +		return -ENXIO;
> > This all looks like an obfuscated way of writing:
> >
> >      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> >      if (!map.component_map.ras.valid || !map.component_map.hdm_decoder.valid)
> >           /* sfc cxl expectations not met */
> 
> 
> That is an unfair comment.
> 
> 
> Map is not available here 

Why is @map not available? It was made public in patch1?

> and I do not think it should.

...that is the point of contention.

> The CXL API 
> should hide all this.

A new "capabilities" contract is not hiding anything, it is layering on
a redundant mechanism.

> Adding that new accel function avoids repeating something all the
> drivers will go through:

When / if multiple drivers end up with the same policy, then look to
refactor them into a helper for that policy.

> cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> 
> Maybe cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> 
> cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map, caps);
> 
> And maybe cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component, BIT(CXL_CM_CAP_CAP_ID_RAS));

This still looks like no net improvement over the mechanisms the core
currently has. cxl_pci_accel_setup_memdev_regs() spends time explaining
how it might not work for all CXL accelerator device types, it looks
like pure maintenance burden to me. I want future accelerator driver
writers to carefully think through this problem and not look to a
cxl_pci_accel_ helper to do that for them. Outside of Type-3 there is
simply too much freedom in the CXL specification for a client driver to
expect a pre-built helper for their use case.

