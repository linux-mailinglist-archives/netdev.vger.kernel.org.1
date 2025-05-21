Return-Path: <netdev+bounces-192459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23AABFEF8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034144A24D6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8B134AC;
	Wed, 21 May 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaV2JKyj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76C442C;
	Wed, 21 May 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863142; cv=fail; b=m+0kVpUdMf7KIBnxqq0lRaou+i49TYV75mmpUIFgjC0NGiYpK4stzLE9R0iwdWwGhiBKfluRvVbyLqXXJjG9GI5BGUz3RvfqNHLhuRnuVFXwYCtd0FWg1fvrb82FSyi4uAsY64vx4hh0RaIN/LIF1QGzibHbJuVDK/03NS0CQgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863142; c=relaxed/simple;
	bh=FsxeXHmxXcULTvW71piWj2ews77W3ryVgPCAo6zBKwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g77JlA90st6717DC/wgnEiwcjPx5oF/6B5UsUylvH2+wHMFesNPaufLlK6hlaaihgwcjGa7oXUDKR3YoBX7kHhSMgWd4GJw8fuRhN3wmYqZW5uuQwXQSUh5q0eiGLNSMGnDBe2G0cL/uOUXc1sIa6iYL4FbIUYkaAUMY8nCSVUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaV2JKyj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747863141; x=1779399141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FsxeXHmxXcULTvW71piWj2ews77W3ryVgPCAo6zBKwI=;
  b=kaV2JKyjLJfEeWhlXPYEi6+4bF2jL5nfQSZ1KqTIQaOKnF2R3rB08qGu
   UqAnDdfALrZ60eKPiGGrw+tqASNAdEFrsJxz0Pp4wVFj5BMIFjYUeVkyN
   wENztzm+b1JfEeKwIoAHvrlA/GsDkdBHKE5RyaK4KIASqfb4gNamK3lDy
   mKFgM3//iyD8hgoZZ8tytNbzbkxXw5D/EOJmDY5aOrLigMs5OXX426UpR
   UOMGSPkIuuvHSAUiK6OF9p2TTAWiJ0UCdgWmQ8G1NKY1khQpOWrYzt4ok
   6n/bX2AUnIdVoll502uZEv336uBxhw8pN0QCaSv8/R+YDO1sHsOHMpC89
   A==;
X-CSE-ConnectionGUID: SS0oF3otTQ6cef4i31bh/A==
X-CSE-MsgGUID: Nyp4BZcaTI6S57uknVIcDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="48983019"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="48983019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:32:01 -0700
X-CSE-ConnectionGUID: pGdKageZQ/aXMAqty5KmKQ==
X-CSE-MsgGUID: k1AfXabIRr+jVAxCFzYJRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140010544"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:32:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 14:32:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 14:32:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 14:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx84PwrHd//GQDAnqFcXzUcjrgBsZMCzXd0iJ33VGSLABIgQjywDRrFdKqdZiH0EHyq3PGJv/AZku8Z1OIxuzF6CJgOmfPMeQSyASW37oJfWjOucKgNaJ4cUFPmJ2dU1DJH4rcirLDzmcMzgFbtpyiyo20nV2dYTKSVk47tld8piwdW1k6lCHdnOvY/g0XkG9+fTQaNfBVkALkosd3TtRhDiMfxcDK+fCIOScuo7GsgKPqkbbp+adRlG52aYvLRoTNGtyeoke8+DrXlNdC0GfL8LrEcM8TryDIi0N+P3kyB5mOWdiPdIycvJQr0xaloVDXK/VmLHy9pTtqR2z83j7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1Bl8Mkku6+Mg0GHwL/QZ3j6eJtvN+E+iPiEj8AlZTI=;
 b=uIClBEuk2nyCQXFYvGJrThYIkoDk3e2EHdxqEmQBUj7thnXWcEmXeT1IZi1GQGxMy3wKq8UGsLcUiVKrutGFYedv1cgtFMN2nYOj9SCpura+CtphD33cv5Ji8zfoMaEfPPunJ+TfzKDxp2jMJTx26iVg96BXVuZdhJYO/zbki3P9511E45SpXIZpcgk2pK5RV+56HHn1b+4Rpg8BnQmJilGL2A6ogHb3ebsN5erWIYp/UMidPoCSMeU/vRnN0k6QqLFdS8VExaF2SS+G1J5f/RYetuiWowjbRmDmHt5FJn+wGUdQNbJVoh0+3Q3tSmWDyRNCTg91gNNcSMv2Y1M5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 21:31:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 21:31:30 +0000
Date: Wed, 21 May 2025 14:31:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 21/22] cxl: Add function for obtaining region range
Message-ID: <682e462ecbd8c_1626e100e3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-22-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8bd2f0-8746-401e-cac6-08dd98aed9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3TexT9jxYChfiDWho6YV+KZ5VP0jhe6+pSrS6aKIo7PVOfA2/jEwYCdTokbm?=
 =?us-ascii?Q?tVXuLshyfg70QYIP3E4u+Oz091dGNg2nJTd2SLVlHThNrUUjNlk3IENMW3DX?=
 =?us-ascii?Q?7Xq9OAJxUHHgYREEcfGT10vH63TAfJ/t0cttooxcIh2ns9r6AxRE6v6TiuiW?=
 =?us-ascii?Q?JNqZpwc1uuZmv1IkhddQldO0MWnrp3VVaXbnc5tCUltxJqENLd4v2f6E/IXY?=
 =?us-ascii?Q?lYHqockU5F+XSf9ZDnxJ295EfD/GQ+39zg0QRzK8Y9OTkX5Qn00E0kuvqtJR?=
 =?us-ascii?Q?5BN9+AYqXeHRpOmvNOcIMC+uO3ZsUHtNcl1NjgAYJhgAWU//B1wF4qgsW+GV?=
 =?us-ascii?Q?tJiM6zdQbngHM074Ni6kVQqzLD6A5g0El0gPQpw4FJiiNgUJjEnQ61hCloam?=
 =?us-ascii?Q?c36Qt+qsQ7jxX11S0ggCVEyZeh8Tw1RebVSmRRt392WcLVxAaMqLb+7X0ILZ?=
 =?us-ascii?Q?JLAudESXVucBafg0ucrwHOn5Kl+54qvg0gno10RoUe9YKPk8U6v+J03JutIh?=
 =?us-ascii?Q?cwocLqKDZ1zDfMQMFepaJM+IC5676F+xQlCvWIFEUc4CN2wBjSRAjtk6gDCe?=
 =?us-ascii?Q?+dIy/3Z63I1tCPxKlWd8PPMJCHGdDyg/BGCV2H50kyuUTk48r3W6SZSsVf2L?=
 =?us-ascii?Q?BEoIm5rBdnCHtNmpMI1Hx1S8/V/pz79Jj7m0yGmeWvDVRBCywXc9rFHEfkHR?=
 =?us-ascii?Q?5SvzbnfsH8rwX/kjwIL5HCUX9i1bOABoEi+B7SLTMxU7d/HGdIDfwhBX99kI?=
 =?us-ascii?Q?fjvoXahzs8NlDCKITUQZXS/LBOtSuc9a2fGYsL0ttf3dNOw5oGcszXO7wJWJ?=
 =?us-ascii?Q?2nmneP+sAVcT/giUyyELjqdccnXPpYCKPjalMVvr4OBh/R6udgqxATlS/vpq?=
 =?us-ascii?Q?FYkC5ln8o5y+g/AqhtKWVDGpOwRpzeKWFE6fPBeAPQFBhI6AkNdypS3UZ/SW?=
 =?us-ascii?Q?PpvhGeRUz9VAaHpMAWv7MtIcGs9Q87qWrvFHbqI3jmqWVQ7ILSfpIj7dgOHw?=
 =?us-ascii?Q?DI1D+fC/DfrTdiOldCEFkqW09RtsnroWHAGlBO6arHvruRgaEZFcyzr78sVN?=
 =?us-ascii?Q?OkNqfRPrbijmOo2CEsGRT3oNVW8Awc8IhbEzxbax1cXf70x+6LJLbCOcRB5t?=
 =?us-ascii?Q?jkFlLA04F/9kaemQWmmdJiISod3YL2UarZm8dhT+c0UAP00Zk/CORwYbNL8r?=
 =?us-ascii?Q?DvUm1g529wcv/EkbE76xPszF0ZhoCK/yPGd8+8vv6z/v9fwYeGJHvxCRYHjc?=
 =?us-ascii?Q?W6Td6zOelLI3km0e7VrnDeQlI+U6nXLPI0fvnC3GeT0Gkofv134VRRXe/1uT?=
 =?us-ascii?Q?sThvBWI9PFBlwgrhVyhAdWuTbEUv6hrpO5o7lQ9j9J5xVpSjzRPj7yaAKRb4?=
 =?us-ascii?Q?CtHtI9aCrw8ATTOyVG2+PPGcV7WhsmXE48HvpxXbqtJpa3CF6OgxyO76RNfv?=
 =?us-ascii?Q?XVr6RDrmFq/bMlmp6fr0cB5ZOzIMmVSw2Oyg6MZAf4jxfqqZa9pfZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1t7gOWRdNq7lVzSVSSc3jkLX4vw8ZbQHc0qYid1D5gHdzH4bpzbP1UVuynm?=
 =?us-ascii?Q?HdNIPhYjPLMMWh5IAcoGxouX9QTjMnTKUkl54omG5A9B0tv6FK2yUW4Qp7LQ?=
 =?us-ascii?Q?9QATOE2QREruPTMXXH+qmoo9Mlb3dVgmbiuQR4bt85SG7snlqMLh5nzCc+SQ?=
 =?us-ascii?Q?qkmLZ1tTSvYLwxh8ObH6Fa2gilQWl2eeaESuQ6jNeLdxXGxLwCh4AKXt4vW3?=
 =?us-ascii?Q?EPj1iWBvlpWAEtmbGJSBGbSddlnODRv2fx37wRPnF0uTFCUz1+0/RXRJV3TX?=
 =?us-ascii?Q?zAPCZecCSqWEfkhqnbIunrkmzJyo0r9JODk2QHeEH59bjNuVCxi/YkNX6O8a?=
 =?us-ascii?Q?SywvCtW+vgp3OfRLJXDtH/8mrZ5wpsqxlrpcVsFNUBdKMfaiCXZTmqTbQJtI?=
 =?us-ascii?Q?ew06yO8+jEVAWiV40baSFKPRwE/nxWQHm1vyAaOxva3xGFf9s66Y9PkMMf1D?=
 =?us-ascii?Q?n88JTdhh2Ik58CWVCUmFjMk+gs4M563R6lheKoQSSslWNYN52oHteEsw9igd?=
 =?us-ascii?Q?aEfcD6zE1+wf+nwO6PBRDkq5nfFLD1PncfW9TOAh8TN8HQLiFm1QG8HvobvV?=
 =?us-ascii?Q?tmw3zVo3mr9UmvZUsPWxP4aJPfYSHt+Y1koAuNq/WfLOEBwBJMMFd78KKvAB?=
 =?us-ascii?Q?zu2VWjpuPw0BuEivSSclESOwMx7prdEZ6w0MvhJEf7jRkKdW0f1hyiyZZB0u?=
 =?us-ascii?Q?wBiD62QUGhP2zuRntqcUJuzMiu1y13nMGCA2vawlZ0APwJlxnEpRcOvqkZvo?=
 =?us-ascii?Q?xIwGtwBgCithLoTOSaQrmWeDIjWbL9OldLRG+akO2F6JVgM8FcOBr4+aYdtx?=
 =?us-ascii?Q?p6uPwkSfPofwaP2+w1sIdVMM31kqKX1uhSEuvk+coql7cGuIbitoGgwi8qT+?=
 =?us-ascii?Q?aEhYoA9FRpTF3QEtsY7RiUaz8+laJR1mIhJbQsLNHwnfcFRLtOkV/W7RkUWy?=
 =?us-ascii?Q?N1hXWK8Z0Cx8DbrnIw559wY8iMRiB2S2MmH+C9d6VtLBYUNG7hR4wAWgk13S?=
 =?us-ascii?Q?JdIDnk0OYpB28ZWMCOUqrUP2H7oJMQ6TT+QFTwebA0tbwqFS9ptjWefATN7P?=
 =?us-ascii?Q?/4FD/666WlY4nxjJwnCvBJXxzqcnwvQxxTzZwy+JjFqx+KKZxXXNiyUAedly?=
 =?us-ascii?Q?35MR2j1+cFlvDaprYQKTo53dn9tBr+oaWr0Vh3jMlZuumB/oQhCSFT8VJnir?=
 =?us-ascii?Q?PNLTGxhPhNCMaWjxc9BrVqhxQYrugmILMko+w/ILZdrexdbIcjUaa1X+/OUT?=
 =?us-ascii?Q?JP0kKFfiRQ9S0Y17VLK/Jdx6UyHg1BWVN9/M3mCLgMycw2DStHUHBLFI43LE?=
 =?us-ascii?Q?cn10HWou57OlRZhcnY1p1vNkJueuI5oUPgWhSXezVo5//eLU0LkUAfUMkw3H?=
 =?us-ascii?Q?iU9gs0SZM5zmKrI6BWKqD1gQ0waPuikB9L/J0FqCmy3txl5+xZdlBJxebuII?=
 =?us-ascii?Q?pqMuB6yxVL2PRJzNL/zXyJaqjBPv/D6kKFNRMZbPISGWTAxK/4puK5CqWO2U?=
 =?us-ascii?Q?kdU2WZEYAZziTnqiKnbsZiThDyFc9cEEe+FKpOlf59oLp/EcKLJZTlsa48tK?=
 =?us-ascii?Q?9N2M96EFgp5SfEIwJizM9EudBuF+ndN4KWLrys78aU8mFB3gIbai0Vd21O6F?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8bd2f0-8746-401e-cac6-08dd98aed9db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:31:30.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z80yRq2fywSm56rleln/TR0nZZnBM1rL/M8hXKvJXVq2dEMwqV2tgI+YVqBtpVOD42iWcE01QbWjAcmg5GsMDgcLvpy3qW0r2HDsiTDVnIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Type2 drivers can create a CXL region but have not access to the
> related struct as it is defined as private by the kernel CXL core.
> Add a function for getting the cxl region range to be used for mapping
> such memory range by a Type2 driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 06647bae210f..9b7c6b8304d6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2726,6 +2726,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +/**
> + * cxl_get_region_range - obtain range linked to a CXL region
> + *
> + * @region: a pointer to struct cxl_region
> + * @range: a pointer to a struct range to be set
> + *
> + * Returns 0 or error.
> + */
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;

Region params are only consistent under cxl_region_rwsem. Whatever is
consuming this will want to have that consistent snapshot and some
coordination with the region shutdown / de-commit flow.

This again raises the question, what do you expect to happen after the
->remove(&cxlmd->dev) event?

For Type-3 the expectation is leave all the decoders in place and
reassemble the region from past hardware settings (as if the decode
range had been established by platform firmware).

Another model could be "never trust an existing decoder and always reset
the configuration when the driver loads. That would also involve walking
the topology to reset any upstream switch decoders that were decoding
the old configuration.

The current model in these patches is "unwind nothing at cxl_mem detach
time, hope that probe_data->cxl->cxlmd is attached immediately upon
return from devm_add_cxl_memdev(), hope that it remains attached until
efx_cxl_exit() runs, and always assume a fresh "from scratch" HDM decode
configuration at efx_cxl_init() time".

I do often cringe at the complexity of the CXL subsystem, but it is all
complexity that the CXL programming model mandates. Specifically, CXL
window capacity being a dynamically assigned limited resource that needs
runtime re-configuration across multiple devices/switches, and resources
that can interleave host-bridges and endpoints. Compare that to PCIe
that mostly statically assigns MMIO resources throughout the topology,
rarely needs to reassign that, and never interleaves.

Yes, there is some self-inflicted complexity in the CXL subsystem
introduced by allowing drivers like cxl_mem and cxl_acpi to logically
detach at runtime. However given cxl_mem needs to be prepared for
physical detachment there is no simple escape from handling the "dynamic
CXL HDM decode teardown" problem.

