Return-Path: <netdev+bounces-192396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05438ABFC10
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7124E2E37
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F80263F32;
	Wed, 21 May 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5M5kC1B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF81134AC;
	Wed, 21 May 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847588; cv=fail; b=kuUw6uSlSHjfbJ0pqpExUHq1EBHC1WH8X4Fw5X0CGrYtQJ0UV5L6qXOURsUiJVvcqGHr8CCOLHoGaenzjnJO6yhtEwHgTE5Oj+4cFoh4UxPBYPQn94AY5D+bOgY/gcYYTsAcS1Qk8yvIYOn2lu4ySWtsG76tSDTJOEDIqdmXRgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847588; c=relaxed/simple;
	bh=7FU7nvOLFiOqH7iizGTdwoTy9DYzcdFjjE9t9GYoi0E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxZD/DQchEnxnm+rcwB/RS4DQbVxNMbOWhzjuHvWbqhKioNb1H8dKGVrodHCUCYpEZBvtqv20lSBXH3GFy3u7TVZShfoMlTZOX4Y+SUSMHE2oE+YxO+KcxBxcG5y6ek3ek7yq7s+ds3NCjUIBRLkaNREqwj6wyB/eSvFv/C/5yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5M5kC1B; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747847587; x=1779383587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7FU7nvOLFiOqH7iizGTdwoTy9DYzcdFjjE9t9GYoi0E=;
  b=f5M5kC1BkrpDPQRyaHopx1h+jsGSSRClJt9RhQlPX72BXMa1aXLpvRZO
   t+oLxHMPJM8p+qiRK8S14MZxhSv6++eWVaIcB9ksw+pnMlzDrMeO62H50
   ou1xszNo4wNolHMfkCFJJOB+pQ0oVl19SQMvQlM04sLfdpybL/Q4A6Mzh
   V1mc/5F8SG4sBPo5PVoovAAKYqVIpoDswEdEhoUOS+3K5xIYgKJUazz6E
   FjlpmI1yVE6Uxg1vb4KOwIYSWTJi0c+U5hM1nc5ddYr4au8QyZr7h+Q+9
   JR/oV3rmHWxarGQCGP9fwzXsn82m20Q9SgVEF74L1QrBYyiyzo//8ju5K
   Q==;
X-CSE-ConnectionGUID: v+5wQncUTKaiBOQOWzFIIw==
X-CSE-MsgGUID: SetKIPkJTSOU2mjoVENsFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61184980"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="61184980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:13:06 -0700
X-CSE-ConnectionGUID: ZGu9f1k+THupSNMxQfgftw==
X-CSE-MsgGUID: uC+sqddURsmQu8tas+WtQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140708046"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 10:13:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 10:13:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 10:13:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 10:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5TIwFY0TKlWMZqkT6jvHL0eUvaFc9J12dk2tFSapGPvT6KZZH02V1C1M+YAlzrhPAfp2yzGxSnpPxBtqptO3X/aerSe/7PwGP9nvmtPiQLk980x9HsRuO1C5qcWQ2gbheg+DwbjciZbIEa2Jb5HJawvn1pQFxv/FmAX+/xl9/7FXY7xr4cbEtGJqtLALPaiX2sgK+0+uZqPLSDWnBtVNeO+byY4csuhrZyjhSvjL7b8P9z+mpThlcqjO9TLht4ofEQzkMUiKiGyuj8r1Tt2PyHTa0XicuvNhbp7eNPyCLeq6XzcBwoB7DJfphiRzy2IvcrVhx3rrtctSmETDbLGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV4lQmlilrNPGAj1FCDKLNv8T8lWiGYjrDEio/7LM74=;
 b=qY5bovw9uCg8/cBpP01NxoLgdF5DWiyl7Gk7E4lI6ue0z4qs8n8j2qy/Jny/83w7FTS+1RUjOi6oGdklWWGsiTuyK00Gma07Ess8DLRJ+slFdX8ZR/7ERfOM1zU9yliGYrVDNIzCmD1fHWbP8hMoZZFz35T7MFDpYDQz41RJFKWCRTBg3LfQwRjNpJajzaARCBYmK690Sm6v/2FMgLl3pYxwECkUy6U94fCXTAE4xLdIG/gMaYdh6MyAf5AtGmv+y+TmJJRP7bM1fnyx37q5t0BYWa4Rg8Ss7LXWRq3tQe/qn4HfEcvtJDHFJ38yDZh9Wa2sqbYC5kNDqN8TR68Lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 21 May
 2025 17:12:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 17:12:37 +0000
Date: Wed, 21 May 2025 10:12:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, <dan.j.williams@intel.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Message-ID: <682e09813a374_1626e100e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
 <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
 <172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: abb2cba2-1f47-4105-ceb6-08dd988aaf1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3MNSO7Y5sP1dK3E/qFWrblsBYaTDHOFpfnOQeCV7OV2Nk8H47IBh9Y+qm53M?=
 =?us-ascii?Q?bY7RYHdnmjQdNycn5ZS3+CJ/tR6PnX1JArYNRVf95IgydTVHt8amsUbIc3Kh?=
 =?us-ascii?Q?lUILt4Y03YJUtQ0L7PJTTqCXzhxut8hkQX3/fgPU3nz+K99qfRgF/6Asc7XA?=
 =?us-ascii?Q?SaOvueGYuhVF47dz+e6gNgkHuToq34/UQgZXm8jISWto3CUnBY5hJ19i9kxC?=
 =?us-ascii?Q?MrDd39qOU5DVJVW9zOhdfD5cqTYFCK1Nqjw099JWGdHxNg5iNn48JZ24z5Un?=
 =?us-ascii?Q?68ABdstH3jYrkmqraUquG7J1c8s4w8942NCHmeiwRMvfM6+c290es0pU4ZS6?=
 =?us-ascii?Q?1RSg/LoeDBqSRXVvtMxN1w+3AU+6Rpktjirch0I2A93WajNITSGmzOOShhev?=
 =?us-ascii?Q?2jAjJXx+uRAc8NydwAe6hav+hZse97YHRjhOHmXer9f8sD2utwXoi4ap7Ynx?=
 =?us-ascii?Q?DeiWPGU2/vTbBB+6qrQmYABCmpa5CM73utB2yia5oDlR9tzVQ+XBmXkq9g0M?=
 =?us-ascii?Q?YhsfHOgycfvkhG9wRzNgPuEJSdmdFnojGYy537Zad4HgEzyRLwdybqUYELHU?=
 =?us-ascii?Q?o7/gTMBz63QuU0s4xnC9b0St0N4OrJa99Ni0i6jwH3Zw9KHgHAAguKsC2Z+2?=
 =?us-ascii?Q?V1eXO1RdC6WjWaOfbtRv5vklWwyLE4nLA9GH/W0uewj/0mecXJSUDw3mQAvF?=
 =?us-ascii?Q?p+0tWEtBTKLpLPRnKji8RMdbOCriZHMQnE0QQ4Haf6yhB6QX/VoyBcDAXaFy?=
 =?us-ascii?Q?/iJcUXnIeaVjj4+PnJObzAwcQu0Q6XirNGaFvo1LT7UMuvm7ePoM2i8X8jiR?=
 =?us-ascii?Q?FwPL2fi47WNVEH87Akuy5D+GbtXx9c1LOM32+SfQ42OL1g/DcBGpBp7zKT8g?=
 =?us-ascii?Q?wtLIEvflYX9Jh+6G9bN+lt64emjL96mzeW4QsUuiuJEsUAorHI3f5KVjdY63?=
 =?us-ascii?Q?OA1vbevT4onk268v7Lcys/uts29XbIVpp/MNSF1Z85WlatlF+cTpM6cUODIn?=
 =?us-ascii?Q?rFFbUhKHrB9M9WJ0HZXW56rVsGYmrINqMJwE+j8JS0GB2a/OScZ1U0WtQ3se?=
 =?us-ascii?Q?5qX387ykPy9DfUgU7oVicKKDgeqPwTySKr4LfC3yq9tDouXwnpGQtH2koult?=
 =?us-ascii?Q?ggRSq9fHJnxIhmPF2Qwtt2pPlBZKwq8mvqaErScDfbx9GPGcyrXQsFFcXgZ6?=
 =?us-ascii?Q?golCUM7EbI6WtvF9ejkr5z6dpJ3UqsVvhEydEslMOrgsyPGWoh/e+WFFkM9I?=
 =?us-ascii?Q?C6vtOdwhBBzaq98QXsFYH3cMKA38yydTf+cJVmEps6ZeA7lzPc5QLxihuJ9d?=
 =?us-ascii?Q?A2o2oysZwv8XQtGhTvgsFofCxK52yvanDSU3OuGW9WnF/tDxr3E4XTcGHTXU?=
 =?us-ascii?Q?k1/UNS0++A0TJYAsEG6DycK0QLZ6yyhthOdrxZb483biKq/cBrEPv6uLNui8?=
 =?us-ascii?Q?LbqZyx2rVA4POobTpYFhafQn5ryccCawzsphs0AGXZKIYJzhFHsaAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zo/NJMMbA4wz341VCZOZvWTlQ0cZDMOU6fCu9cNNrM/JtKXKykBJOwOJvh/d?=
 =?us-ascii?Q?qyNHihWPCcC9cXMy3uQ0wSM9inOminppV7oO22aT8Wr52USpWPmFo6s2oBcS?=
 =?us-ascii?Q?V6oWsgxh1IU9CgAdgwyKlIEPLP0eq95PbPANNQlBxDwlwC6ydt3UZBGNPxGI?=
 =?us-ascii?Q?TMp5B8RgX43RPdbBsoMVF0AB9NxL/VwXKuBdxr4PzFljT45CRAdneCHRIsQp?=
 =?us-ascii?Q?M/CWcFii4wsdVLzN1Lo1yT+vV0l+QddE+o8Lj0vKSeolgDRXYivBhIv+HPY8?=
 =?us-ascii?Q?fYN/a+W3GnA3uvewI2hNm2pGoz07PXUMSwCOC2H9satAtRP7rnQ0QQRgVkb1?=
 =?us-ascii?Q?J5PNVJio2EQAPI5us5jGhDd3H/bAP5OGl4W3D8xhxeGeFjzE6WYMYlGa6jHq?=
 =?us-ascii?Q?MAbIejrMMvswwV/K4rDHOCmP7Ryd5ggjdmZY3Er8z1Aaew4bg5QF4iOeAVPF?=
 =?us-ascii?Q?LKz2dDgkihAEFDsPAQJqLLV97afXfRIGwUj5RtRWhzX9gTAbO3TMQR2jK+Oh?=
 =?us-ascii?Q?/nRgblAewj6RkGzmQerCq3VKyXpVo0MC44+k5z9qiKxTzpCVeREbC/q9n6TU?=
 =?us-ascii?Q?DfJbMjN7e8lIY7DIoEgfovDV+Ql9hIF2E5HS45M6Nq3O+INMUbu13+2EWmAj?=
 =?us-ascii?Q?c7olDQTyvlALLDPOqSTp6GYqAqw7FdOaiJ+MVggo69t0hHy0QE8NBWBw1HRh?=
 =?us-ascii?Q?vKkoNYgV4U8leV7/lP+GkVpYSGnusBZkEeyl3MVdGbonT4sOAeH56nBpoDTT?=
 =?us-ascii?Q?gwKp6xtRTDRLwIDy08VIw8H9giHdyPG3g/9BtCqOvr8GSze4RBQA4x6dbBE/?=
 =?us-ascii?Q?LjJeuf3eF2A3bBpmlUKuiD6JL7OWm40FHsgqrLANm69ZLvk8yVp+6LTM6lv1?=
 =?us-ascii?Q?1n+ZyuNKe/fN22cjLJap4PEtc3tJy0bC/JWeFBc8B51KwEyrY8qlDhUEddLi?=
 =?us-ascii?Q?Hf05ZByAguTg98ChWBr4j415+WbL4vinjoaVXkykQEuCr9naSAh5dIMGlHiF?=
 =?us-ascii?Q?tjWhhHtIRakjTrQoqYntfDDDlSuI4wad2kY7mCujE66/uHhTjkR89cM7ohl9?=
 =?us-ascii?Q?AUYrEP/aKweuI1poKTIjTnZIXzJAwrllH9wnoVB9cxWErVO0KcmMde/tLpqI?=
 =?us-ascii?Q?yZn2J4bl0CSuMydkEsZCsRldmm7e08bY8du3+EIj74zBAOFOdnhQEBHRoBTc?=
 =?us-ascii?Q?6BIKKLZYGh160HXPqzOmJAog9t1e/esA8rXL2ZacQJuKsKREs066A2GUYwqb?=
 =?us-ascii?Q?aZK9GTtxmL1WnL7uIoDxRIc+gx8sVmsxPaEXi8zZ19FmTx/rUQ1l6Txyxvw1?=
 =?us-ascii?Q?+GkVb0Ow4MORP+bqqgTicXPpafrmf8XH12U5gkbJUij4sGNIhxpzHSfFHDgo?=
 =?us-ascii?Q?GMR0Mf81VJk5Bc6CW5yw4ZtyDnG/S937BtBZqwDRkkjivK6hI4d4DJCIzpBK?=
 =?us-ascii?Q?S/jEBCKyzDkCHBXkcpJiDcI5plYJcYYtLXRZW/w3TSLfx1Ex0/1xehUMqc1T?=
 =?us-ascii?Q?e5XTEPsbZdKwRqh+WDC4G9fmGTeCCCPqhC/7zufYDjjCjFO72q1QvtLdjrrY?=
 =?us-ascii?Q?Vcwl0ozgq2sQetWvCWaAAcjpMwNNKwq8zHBjRq7pBxDkYiOb0pt6VJv7KBKE?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abb2cba2-1f47-4105-ceb6-08dd988aaf1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:12:36.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IRiGL3IvW3DwKJ4Uwu22TPpk09LqaQj/5f2PGIXBWjSeoh9niUdlggI6UK9NomjHPDYGtNxImszFGYfTFVth62ZkVz7AiolRG7+5TFkAKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> >> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> >> +{
> > So this is empty which means it leaks the cxl_dev_state_create()
> > allocation, right?
> 
> 
> Yes, because I was wrongly relying on devres ...
> 
> 
> Previous patchsets were doing the explicit release here.
> 
> 
> Your suggestion below relies on adding more awareness of cxl into 
> generic efx code, what we want to avoid using the specific efx_cxl.* files.
> 
> As I mentioned in patch 1, I think the right thing to do is to add 
> devres for cxl_dev_state_create.

...but I thought netdev is anti-devres? I am ok having a
devm_cxl_dev_state_create() alongside a "manual" cxl_dev_state_create()
if that is the case.

> Before sending v17 with this change, are you ok with the rest of the 
> patches or you want to go through them as well?

So I did start taking a look and then turned away upon finding a
memory-leak on the first 2 patches in the series. I will continue going
through it, but in general the lifetime and locking rules of the CXL
subsystem continue to be a source of trouble in new enabling. At a
minimum that indicates a need/opportunity to review the rules at a
future CXL collab meeting.

