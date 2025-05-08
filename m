Return-Path: <netdev+bounces-188826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01164AAF07C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C237B7049
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342280034;
	Thu,  8 May 2025 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSSWu9kh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9FE3595D;
	Thu,  8 May 2025 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666411; cv=fail; b=h0gdkJCvDiY0EVgrOkDFGa/KuwRanhGAspBuPSht4xi4ifxvrhS75UxvehXQ1Snpkv6RHshzUTarHauE2eqs4vxtTzsm6jEkVKz8xe3AXaQjQeE1NhwTjvsELoj3g9xvF+krBss334bZGe26YYRfwM6C69cyEkpxKCfbq6qMqho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666411; c=relaxed/simple;
	bh=uH2c+tLmYbXnzGlr0/CLvuRD9kLLmQpWgH4E4jW8DKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEg+NlEn6Wt44PVSKqi+MDSfd0hrjCir73pWntLDH9KNGBAO/ZziFMTVuctXA7+zzZOpY0nx/4+s8LIG0uhXofV2/Btvs+y3Vt7XRqmmOTgjYCwkxVaUesZqcE3RaLOfmSBbfW4pCtyYap7JXX0v/Fv5TqstdJYxNWv7T7Sxdo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSSWu9kh; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746666410; x=1778202410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uH2c+tLmYbXnzGlr0/CLvuRD9kLLmQpWgH4E4jW8DKQ=;
  b=QSSWu9kh/cYdramD5GaMZiauM2h04Ce2TH/8vWhQ2Wc3v5CAbCaVHv1o
   vgTWgMizNSAjVZOmmS9ETTP/5iGHhHFpyGtTTBcOQYVw5+CnNM4YmJVhR
   f28N3xXiNsJjAiCbpKwXa9j0K+VDcuepIwx6zKBE/CSo/OXVt+ZFm7y19
   qV2TLuI0RQ04XPGAQCEpXhN04+R6IYMYN4vrpdQNDPemKuVlMX97trBi/
   CF5w91PmGM1CFgK+Liy53jKcufizUgCDMLjLl/K36odvnoBwcdVe4sVZX
   +ZqjQN1+qe5yB4VrVxH/5J811HppMUKlPHnhdR1t24PmMxMyASrUckqlz
   g==;
X-CSE-ConnectionGUID: yKpXkJlsSpuPP7B391t8nw==
X-CSE-MsgGUID: zj6K0f02Qm+Q1i9iEQpDRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52240200"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52240200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:06:49 -0700
X-CSE-ConnectionGUID: 7p3Q2Nr8Ttqi8umEIc2nBw==
X-CSE-MsgGUID: R/Lg0yDCSGOSN9IrJ62CdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="167181703"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:06:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 18:06:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 18:06:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 18:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItXyoJx1G1KYk2qBGtt7jBKVGdPVH1PIUxoDHgTBrbMj9qxXGPKg4TlygNse+ozqa7D/78TON4fCW1nGwtD5BW3v2Bu95kRjJV/yQV5UWVQUpcQtZu0jnoxzSbT1h07mjseA8BEYLZxWNWfxF8pA6t+9zx0fSBlqd0nmAWkmChhsWGiY5foj9g4HmOZPXxxHyrIXlwYlZoLJqIXmO2veiS26F+dn34kjKnbPRYxo7T3cv2Fyws+M166swaoNBvvHaC2RLCbP5M0oEj1InPUfqKtKHV8dlkRhYyqAdNVqGfIcKvjcAu6LjUHVwkqTuFC48cfkKpxHNZU1zJcfOCi9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOAm6ODfsfs57ClWF04i6pJ4FRydXCOEJ1iie0nW/U4=;
 b=s+o/bfSoQ14rofU8mwK31vOhDQeish2LXP6ydi36V8ifP+gYR5+E88Xk/Bwj87c5iExtQRrLfmOecDiyberqUZIzI1H/8EnP+1dWlAIC5IZC9cumw/li3+SrzemX9TzqshsI/KNoizxY7WvgtmhvNIHg/2qu5+aqLtKGZWmmjWSKDfaNPXYdefFENcqO+8s7VWKyRv3+oRMccQMcOFo/87FUQUgvXJewG9vLhCSNMg/Bc5JA6J6bN/LJ+JxaSk9zmJJgeqI9zYIeLVSGogXR9uf7IvaxlwsbwPz1OfSLoA8+fC8w5YpvCq3QW7NQAZnoH82KKAnsmt9SlI2kwI67hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 01:06:36 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 01:06:36 +0000
Date: Wed, 7 May 2025 18:06:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 09/22] cxl: prepare memdev creation for type2
Message-ID: <aBwDkBCw5k-6NksY@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-10-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CY8PR11MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 1881fffd-86ed-4533-bd5b-08dd8dcc9455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ijkXqu2LzDfpu+AFll7ZuXyqe66LXRmSvy3qCG+MqIqc1tnGu3tscjhi7rnx?=
 =?us-ascii?Q?bARtBxr+zOQ3xDw0CWny7rKi57MNxUOhevDFKI437DquKPW4j6dJy73jD8+p?=
 =?us-ascii?Q?XE2VNOQ/wK2SJTVlWuwaXIH032smU9oO7YHEiZFL3ZYRD8xsp0Mfj8QkeikT?=
 =?us-ascii?Q?dAJUSqIdF8KrW1H28EHfCKEU7szMe2SAgAy1cYHn5l3DxKHdSpy+t3hqSNXb?=
 =?us-ascii?Q?JMfwH9nh8iHm0DJowZ0gGMrh0Ald2FqWdwv7a8/bGhZdE5kOuL5pPgVHs9CS?=
 =?us-ascii?Q?mRDYN79bASzLp0tZMpOa8Hy0HNb6ypj8MKDEL2enXb4PidNX2Bv1LgrQu3Oc?=
 =?us-ascii?Q?SgSXch7x0AdhpUGvXIgoAY/TNuRfxRdbBZF33o5LhOTDrqyWszS/wAaDx2jN?=
 =?us-ascii?Q?eMO8Rx8g5gGsyM39c9Lopr/9Yrl9Iden9JPUrxKe0/hpWKGnWvcn+iofagBH?=
 =?us-ascii?Q?1qDQDV4E1iqWxRJqFmgC8ufoXcxehfWaKHZV1gJot7i4kDv6mPS4IYoAvSFq?=
 =?us-ascii?Q?u+Bki/YQpqz0J7CJWE+8L/6gRMpsMe9rpApmuFHqyMeBoB8YOYPHr48F+vhP?=
 =?us-ascii?Q?csDzSpKXjcADWKdXiriBcgOVUtnXRs8KZ/wJPxDr2xHD41Ga+4zTP55+vOKn?=
 =?us-ascii?Q?nvoMO00I22Sqxf3rIlGAWhuhkcKAdrxVMBU+bT8TGD2eKJXTwXvv5U7Qj1Ti?=
 =?us-ascii?Q?TYBLslOP8QbT5pXv6glFCRzUM+Xx6lH+3DO7OkUfHHZr7v7Z62GBGXdkEGj6?=
 =?us-ascii?Q?wGKV6gU79SsmK/2zI8pViZKzl2Fsgv+gx1C/qn+xsuNNbA1fGaFU9BRhlyz1?=
 =?us-ascii?Q?y0Qcw8eyzO2JNJZ3rIeWL1oHb2oUn+ZjhUrsoFAWpyCXnueMNFhOZBexFK4t?=
 =?us-ascii?Q?l0hthfIpbSfYQq7XdXmDdhzMnl4Knu10VWoR45PuTZ6IplFpRZTN/TUxmV3c?=
 =?us-ascii?Q?gVvm5AnFYjCJvoyFT7zQwz+VzbWvUv587sdaxbi6tjf+XAONRS79vqNJr+Oh?=
 =?us-ascii?Q?nwjSvFOepn34JRF6bOtIGCQ0zcO55mohu/uStH0PXwh6oaIhuMal2T57AEPp?=
 =?us-ascii?Q?rs8hdOttLgASANLg9Lt2jcf7/NCTYKrjfDnXttDmheG3v5T/kiqlRTFc68U5?=
 =?us-ascii?Q?a+GKCYgyh/BKm8XSVYfOe8oS4uIadqMv3Rd4zgvxfT2JAm/fZOZFOySDy42f?=
 =?us-ascii?Q?MD/WOevn12EG1WSNKSneld6Buzc7JrJu7eAk57mgu/mvjSAziR+0gG0Q2rOB?=
 =?us-ascii?Q?sBFImaI+mUTY1RuSxwJwrGZ9dyYf6V6bYug6VigtUyuNGmJ5SFuxtQ1nS9O5?=
 =?us-ascii?Q?+YhoviGrI3vJJv8//eLstiu46qX3rVQS2wq+y8MZvwq+nHjQHZF8g0vgYQNj?=
 =?us-ascii?Q?uqpvZUoEnO55GYLt/5duN6pm1ZGKg71QVIiGyRlmognAMDku9WWfMib6Oc8i?=
 =?us-ascii?Q?8b6QqvUuDlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4P2ge4ABmc+20emnhm/SqWybLMQCu12cl0LhWFlnAAORSlwDpjEs5nB+3+/H?=
 =?us-ascii?Q?/Tz5nEATAwT+uj3C6bO6e6u2Dcw47/66CZ67LSwT63AOgoGQmoJ4BLDe8FEX?=
 =?us-ascii?Q?wraaK4Ukf1lCyht1g/8v4r6BEZcrzuHLFFMrYJJn5PFxJO+VsiuE95S79w8w?=
 =?us-ascii?Q?c6L1etv3T2euoLTZYEtJoJ5w/9nExmwf0WnX9wKzuX5WBgQM7+Qum9tqi6qw?=
 =?us-ascii?Q?QnnZ/2jXYUuV/ftUV9O9rUpAh6LQTe8fTMCYMq/yVQjKggQSoRrZ59cbgTx/?=
 =?us-ascii?Q?z0SKJuaSJHdkFqPcMg8YNIc+GdJvsdlKtJ145KbNvgmHey3QbjjtltTOYdbF?=
 =?us-ascii?Q?b6DTQ4esbnYzTB/HC69g6Waf7vZutWc6PQDH2+SQH6IRsr/t08sfIoL86IRl?=
 =?us-ascii?Q?6szT0JU6k4YKpjcRFTkSho/p8Zj6vCmEZX/ui1SzggpXwdLcpZHP7Q9BFz4U?=
 =?us-ascii?Q?I98NkN6MS1uhrq4s5kvdOgMta0EZ+IsM7uO7HypnvmmQWkwe819lofFxqsoT?=
 =?us-ascii?Q?VdO27ggtWMk9DBI0qNbtSGkAzJDM77dVhwiH+azZVusxHiSwIVtePESJMCpt?=
 =?us-ascii?Q?voIFM30cWZTZI/H7RUa49upEYMbd38nRi0WtDOVMRHuRql5ZaV0XSoA+P8cH?=
 =?us-ascii?Q?fJPlmnS01BENEMpz3jHEkY+uuc/HEiesq92Lw+RkeKMgBp3eN2GWFzlf9OGz?=
 =?us-ascii?Q?/1kbq5nbBdEg9B2i7+sSg5ngDIWzmPgGXFTaN+wyNhFLKFnYmtNVb9sRNxYo?=
 =?us-ascii?Q?ImtkzNYbeaUd94BQ/HP7X/wuF1zzEdlemSn8uQLu8EqRyMRxgP5u7s5SoPas?=
 =?us-ascii?Q?X7d45DfdgIhSQ50B7xFuNkz+qbFACiGh/fUto3cbJ36H6dtKBiOnnxZo3aD2?=
 =?us-ascii?Q?KLVHzz4FT23iTvhjAfQ507WOENAxQZ4N8tyGnjuf9Nl9cM2ktgTsMUj5rJ7L?=
 =?us-ascii?Q?mGt6BVChlUBo2LvOXNw3m7Bo3hV6UIxDquEheDvZOFOdVt1Mw4ZRr3jMURu0?=
 =?us-ascii?Q?IXnalCQpvGKsZ6bF5VBfL9j9yJgnl/abacVUYtInz5u0GnDDjbXm5hRfgMCa?=
 =?us-ascii?Q?F8O8c6sl/2CNHv/eOb9AgeQ6ZftknNbEvwqT5iklbMEGqr2pDXuvz9VjJ6mA?=
 =?us-ascii?Q?cGwSAbiZYEEiYeJWjF7Ni9pj+Nvz4Fl9qV6BejrsArBi8CdMmui3H1SrJ+Js?=
 =?us-ascii?Q?WyK0C2HOMbT7PzkGkmf/i0vbmwwn5Lonqerv2BEOHnuzCEcA0BKGLvaA2717?=
 =?us-ascii?Q?20l9icI9IVUaS0xpg9b40hQgFtksmu9Yn/9i4ZRWUs4saYME/uEKRnW7ZAXL?=
 =?us-ascii?Q?9p2lv/g6RIYtXJHGHjfDOLZ+MK44XI54pvWhzNNiERzQ8QXMLhsSOBO+fVIt?=
 =?us-ascii?Q?L+WQnJFnv4e+W6gXLIt51Wr7YaDLPHrOftVefc5rGNEFGss4ruo27yTLDDwx?=
 =?us-ascii?Q?qMGThZro2nejr0xtxCIKn1x2RM5sosF6y9/SvydFzL3C4AyZTSVtB0jfhKm9?=
 =?us-ascii?Q?mQLqlrGdaPFc32WO8Wl/4aKRnukBlIztO8Gje2FoUibOHtQi2sZHVBt3VfSM?=
 =?us-ascii?Q?VsdthBh7/6inX38iKyMXeNWAKA8I8Oq6+lwPJOODv9rR1t43CGnelgdeG8O2?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1881fffd-86ed-4533-bd5b-08dd8dcc9455
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 01:06:35.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/H+l/P0S/mUIcEnpWc/2jDT8Ct4uTQH+iHa9AonogpZuHQvBFD9RBi8z0lG9DPHD7SVT7FQ6L8P9gdPdYBz2l6AlyVYwgZwKjWaeoIhtoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:12PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/cxlmem.h      |  2 --
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6cc732aeb9de..31af5c1ebe11 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e47f51025efd..9fdaf5cf1dd9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..7f39790d9d98 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +

The above 2 'if (!mds)' seem like indirect methods to avoid Type 2
devices. How about:

	/* Type 2, CXL_DEVTYPE_DEVMEM, excluded from poison setup */
	if (cxlds->type == CXL_DEVTYPE_CLASSMEM) {



snip

