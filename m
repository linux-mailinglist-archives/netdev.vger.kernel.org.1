Return-Path: <netdev+bounces-192424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD9ABFD51
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2641B1B61C2E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173623183D;
	Wed, 21 May 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZlTweXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3B2222DD;
	Wed, 21 May 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855935; cv=fail; b=O0XKghjgewxFZRj8sK+0NVYyla3kOHbT9igVdh80IjMT+7P7eOECkpH706hme8LyKBe3w1Gmj9DBn9em55JydO6GokVsP1jlo47+6NcJWQ365ibgbrbeuJiTjk19eqO5SQ7EPOtn81JT9Es5houBtllV+vqkKl5bE4MUeOaN7ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855935; c=relaxed/simple;
	bh=16WQNCzwhhe4edtKcguUSkNQpHRXtizf8eEet6hgCfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d8mn9g6o9apXQCv7OpHJr3vp/CGFURO9xeyqr0AJEsQWq4X2RvZaCQL/wOKXevSLMUOQJ69mw3WQDkYRLzglRacSN3Gtqz29AEGS8ktIiiwHtLmIt9TCq6kqeQu95V24CiYL+NYeP8tw8aQT1wP8+EJv3JfVBFNRfN5DfTTEtGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZlTweXJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747855933; x=1779391933;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=16WQNCzwhhe4edtKcguUSkNQpHRXtizf8eEet6hgCfw=;
  b=UZlTweXJevK8eUbAJtuCnrs2wdJnAWACSF3l7yLh5pX+rGLK0Ukt2/Y9
   mCi7TwhXAZHrjKJjKVJF/HsZqD3Jdtod+2sPld9hAEWdmHF2SQZJ3iLZX
   EBK0d0XQbygnl0+tnwNWpPXVb5Ni4oHUec0urCXyg6NM7xDvN09PXFV7b
   AHgQXupGY8Y53jnm7CnwIthfN1p/nGL1vVW8E4+9miAzNFtNpcJOHBUXY
   /Ic2vcZ7wWDCNSduiMfe1Es5tr/g6JP12yKfbw/PNRFWx7ZgtOOlPtyjn
   Ha9VqKzSBnbHO6uUf0mdFtCM6U4uG0lXDGRdUgdZKVhMnCHHq8sROQLKV
   g==;
X-CSE-ConnectionGUID: Aq95xv4fRSSYc/7YSjORCw==
X-CSE-MsgGUID: KmkNFCsfT0+MAsucfoJ4wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67267492"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="67267492"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 12:32:13 -0700
X-CSE-ConnectionGUID: 24mEyDfBRWeuLUoC50VbrA==
X-CSE-MsgGUID: BAVYCyP4QN2DoswoCPE6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="141287094"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 12:32:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 12:32:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 12:32:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 12:32:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQIN+5YKCIxnezsCXDwFKd6bNMqwcwfwF7HIQ71zoAZzkorA4TZQ5SP0Qpmk5cfYWJ6FzC3G7HCW+Cv5TGZh89skWZw5X2omZ7aLDfAKS1EY5ZZAHbN4tAYqc1ivZk507ZKvRA57s/QLplq3ZNMelrn0ZPCGFafe8awqgjKHWgwYurJrORJi++ttnro7cVPKzJVDfBKrZ0/kx93RanAGrkgR9fj3hJrlqJ7+j36X124ECd+XFacRUoqCRI9zKbHTfDmUn4RENzGCRLR56FWrP+28lZL2umXoIiyn174M1gC47UaoeTCo2GJD8b/Li7CJ896HomLMy2mv7tNI8u8ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0hdAaGuU6H6CV9J8fmu7qrMUuWVcGQk3yefPuHmnRM=;
 b=nVZhBM+4aYt6HyGSIc1DgJKcAtXMRBjRICLEXjWRdYrh19IDkPBEnIoT284qxOLShPk/l6e9KiPhBd16VUNZny0mvF57PBXpnEpXyn6Rpn7zRuFheOeJdY1YRqLezEztQUwi08IDUd0imXeKEKzBWb4hOLml1XmvcBergSxi/ac8bgF6FOhfsXxUZif/JjLrefDVjOhnSJte7AHXjOtHH3VQJgHR7o2+AlStvMey3/6j3HbVqBux8siNA+TJVvvH9hu6oV4meI/ynr0/X3ydL1GnXeEppWkmVdOR9nFyPuAPQ3HIILeIock2KcLUeg4Wyn66PbvYUZg6ZTeTWsHklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 19:31:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 19:31:26 +0000
Date: Wed, 21 May 2025 12:31:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Message-ID: <682e2a0b9b15b_1626e10088@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e80a45-762a-4615-e2d0-08dd989e13ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CDqgy98gGBh+DlWHUNED2FkGwZaPSK9LCls5XbKjsYGKAMrh2qoULcvNYGFV?=
 =?us-ascii?Q?ihWCR3oM6BzZS3Ijhmc3Ty2Nt7f6vBReGED6flqCR11riWvB6dpbcPcxpOc9?=
 =?us-ascii?Q?YbjtGN84EmOzNSroMDCub6GCpnbpbP2aW+5CwWruzqSYU8+8ECQwx1BtocYL?=
 =?us-ascii?Q?jt8mPQIqb+NGNX3aGPlO2cKZVyXw6seo0Yr3G/MrcxH49dYhStrB3gL5vcZe?=
 =?us-ascii?Q?suSDSrri/3R2kcO60SKC7FQuU7/pb0qu+IFkLDONMbVMiyD/Sy7TRMBnEWGa?=
 =?us-ascii?Q?7yM7WJZFd5Sz9v4sqHMgJwZWS9gh9aU2zzinkh/jAcLkYkrBP/cmGNbR+sRc?=
 =?us-ascii?Q?x81b6fCXLeZupbbcCcl3R+1jXcao5BTci9Z0/FzT4Ya/zeRXt4H63/5MfGfr?=
 =?us-ascii?Q?Zfljqrf5LuI0Tx3Nx0cg5F49JcYuH+xpV1hpQ4jfY3ysJOY14DpChVDg5i1E?=
 =?us-ascii?Q?7zyrOdTmTvSR2LN3qeTsIZvXF83m14B18NwMgqHSrHtuJmfLdjtdBwLZOEV+?=
 =?us-ascii?Q?wfKOuagvt7muiCPdAR+7xJflAcLRbRnWy2PuIsW2N+OQJ+mhCSSTB07KIDXm?=
 =?us-ascii?Q?7L1ovC+8Mdl9cP6+WRsdqUBIp1CblaJH7okTU8hFe3wNcGQIzePKSrvBFvHF?=
 =?us-ascii?Q?4STvVB9vl+w1o2qe2BDGPsr2IzjtC2tD4BstRl1jKqeftqOTLnIIYS8YNw1N?=
 =?us-ascii?Q?jZVFqncadqShIGIiYCUY/K3QHJI1WrxSCO8pJh+9MgOZR7u47YIz+LIvD5qV?=
 =?us-ascii?Q?nFocfM+lyNrUAu3TQC3PN0vxE6DSuur8ihb9pIhASLrgs5BtNIRQ8Rx5epKk?=
 =?us-ascii?Q?KX/knxZACj0Wtcl95Y/B5drECGHCn4kLfdX+mTzqT/WZhvJDAl2S3Br1P+G3?=
 =?us-ascii?Q?USWtCFDE94Pb/f3YNwClmPhXB43deYo8ETP5QoXFiTG8lpw6c6E79g9CL2e3?=
 =?us-ascii?Q?zuV6d3hZKQBuBYzt5vbpki1b2u4Hwvbe2Khfp3+D0I8Jo9sgEfDOwkxmllsD?=
 =?us-ascii?Q?FHV4Yb6cMHwbw/BcmquuahO6Ghfj0mlkWvsYwzuyRshbGVb7xSmE+rJFfuXx?=
 =?us-ascii?Q?f7/C6WilJVKWLa2vlvs++IHKBhl3HmWG0IJhdxpdlgRwduSLAAj8blbd3tv+?=
 =?us-ascii?Q?d7tLSa8b6ZjdzOEza6zo2CAZNxzpvJQKrnhkn2xNRUEjeyEv/e0a5gnF2tAP?=
 =?us-ascii?Q?EvE9hB0LZxxYb8fVSgSKsSkf4S85tdJ8lIh08LMC1CFkpsgZdGw8EyUO7b93?=
 =?us-ascii?Q?Pm0bd7sIDyM/sxVcxLosM/c2a21v3WY77AfM9TTgK9gDGN0vz76LjE7shrEL?=
 =?us-ascii?Q?Rjxz7BMzBy/SQ5Vej8owUX8bjOyoDrtBUhwyxrjUSAN7qrAnxoythae3TnyC?=
 =?us-ascii?Q?WIDRCo8upYYhbvhU8Bpijtj8i/4SXeuB7gTvkr4kG/vplbBId/Uyk5//dawO?=
 =?us-ascii?Q?UhBM89YJvAHxcg3+9UxhIdJYEvpf3w51YT+hn0X2BdFfW1mbR3hhfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFFqk/Lp0mZXoCR6hO9iElof4G9bx9Wya+vYqmW32cu/EK0A7sEuez+M8C1/?=
 =?us-ascii?Q?3oKQ0zE5kfTW+hHnS4VZ6UmM7P75x98Ui3yLjxn/X57M+IRCsJov9ALHJTN3?=
 =?us-ascii?Q?Tx0R3iY04+4pffJLTbFydGWbM6Lz/XDXlV8PlJeJDQsrVD99sPP+jarZVE4a?=
 =?us-ascii?Q?LIhamweAi4zObgFir3McSZikYtvK4s5mb5D6DKNiRXD1h7jF3XJAFOMkrW3I?=
 =?us-ascii?Q?ZJ+jSdrNAstXzzZwaSyaCGsLyAJ+sULfiqFbXTBHpRqIze/XKXC+nnUwGMht?=
 =?us-ascii?Q?8a0kaFwnWaz6dYYwP1bKYJyBEZ2a8eeoa99wA/HK6jfBhWMUxF21SifaOSfu?=
 =?us-ascii?Q?mzSPJowhpDgT8uN1KvH+mOrNe1DqEbNV8fO8KuNgH3r+4zeTEoxugeFxukct?=
 =?us-ascii?Q?Y6t0A2/mF/MOOV5IEqFNibph1/JHBd86ndFXXwvBO1HYGcIZrtWfh8IBICQX?=
 =?us-ascii?Q?OL6lYQf+nndzlvCXp+ImNjETR+KennX3+Cv9l1E5qewzG2yn85tny2fh6Yc6?=
 =?us-ascii?Q?DCDv6pJS81yhTRrifBOusbfvAitrKqYcEqvH/yOYgGR9SszZTQq4Zvq0da2p?=
 =?us-ascii?Q?UfneiZ5+IZzVk+FaZyIX4CJdUSHaEDgnsju+nZLABmdz38Ml9//5nKUGMrT5?=
 =?us-ascii?Q?7e91fVdmk6l07nFQBAb2MnWWA9lHx3kt3RvTECJvEx1H7R91n2ME02YqTSOp?=
 =?us-ascii?Q?++ztdzES2q1YoxqFjiNEKET/xCRo1r//nE2TZt2tQ/tu41Q4seki59jMEc0V?=
 =?us-ascii?Q?SEyHe4GfRGshWzxf/2kFNb4HdZ2Ytp+WIbmYCeGr1YCk9k1VI1Amo7STDbXC?=
 =?us-ascii?Q?SNIqZ+a8JWV97tg4EyxXLGAJO+n76VsgMapajMtNYulBxmqBagOrv4047qOB?=
 =?us-ascii?Q?hQKAixpNbEz014guybsbiAbm8HQQHJ48+bxds31GseGV0o+JEOUBnD0rVDva?=
 =?us-ascii?Q?eGt8RgimvvHfB7/EaAilyf++q0tKZFn7CoA4B+4jvTj3jRiN7L06RJMKLyYO?=
 =?us-ascii?Q?MnDPtMk5gBv+iZJ6eDYaOSJdG8alGnYQRjAr5F4g7yPR+HAFf9/fQU9PaVBO?=
 =?us-ascii?Q?/K+bL/zcMdsyXazBf9GRb9OOmtkkcl2E1F0WWaY+aqTVjpSnOOgaB4N6EIc/?=
 =?us-ascii?Q?q36Sw3mC+O89SkLL7bzlMmyFupPXvgWHuSWXqnvTnJp5nR5hnj9L43a4MPB7?=
 =?us-ascii?Q?ih87Zmfvgpt09lHQE6bvBtZY9X1PkMLFdVK080VI9WpaX7qw2M7+0CEbKmmV?=
 =?us-ascii?Q?iwOmooPTBx5rGQK7vmaopGYeN31Xkjqv9djdWokNu3dICBFwmuRvpqd2ZDJt?=
 =?us-ascii?Q?e9azobDMT98HsozaV2Yd+hk8Nd4z5w3zwOZaSA8V05RxmPv/7Yk6MrQp9vnF?=
 =?us-ascii?Q?1BGVv/pFG8kC2J9DV+MJLyzzGZIS3w0Ovm3IHPqqvaCh10d7RTV2afH9LlRT?=
 =?us-ascii?Q?1RZyqqWIxGqAUr+kGt6dsFK8Me8wYUCTCOW1OBLpHE9iKfLYXD80e4wPnhqD?=
 =?us-ascii?Q?pmE4Iev03k5CTme9EJzGsrbQU6wlVW8aT9l0Cvh0HQlKShQqXvierdc+/Lab?=
 =?us-ascii?Q?SpLvVDHTfZDMEi2AD0M3XidjoLDe8fwMkho0U0LQ01M+G67MvQcG+HouIe3X?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e80a45-762a-4615-e2d0-08dd989e13ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 19:31:26.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F6cPvN2gL91QkYgEEF24pu5zlPXhyUus11EQhuKHCInNBUBc05yJLeLSH9ExV8hLU59Rpqly5XriHBvN9loZTwAieYpNQxL3QL9F+V8fMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 166 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |  11 +++
>  3 files changed, 180 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..4affa1f22fd1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,172 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	/*
> +	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
> +	 * 32 bits, the bitmap functions can be used.
> +	 */
> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}

This seems confused because the @cxlmd argument is always an endpoint.
The dynamic state is whether that endpoint is currently connected to the
CXL HDM decode hierarchy, or not.

That state changes relative to whether @cxlmd is bound to the cxl_mem
driver. So the above check is also racy.

I think this wants to be:

	guard(device)(&cxlmd->dev);
	if (!cxlmd->endpoint)
		return -ENXIO;

> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(CXLRD_DEV(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");

I think this cxl_put_root_decoder() requirement is manageable for the
for the initial merge, but it is not something to commit to long term.
The device's HPA freespace and CXL HDM should be freed at cxl_mem detach
time, but that will require more infrastructure.

The reference does not stop the root decoder from being unregistered and
it is clearly broken to allow it to be unregistered while drivers have
pending allocations.

